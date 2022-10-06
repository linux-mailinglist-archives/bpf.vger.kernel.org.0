Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07EA5F6012
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 06:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJFEZI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Oct 2022 00:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJFEZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 00:25:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735972C132
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 21:25:04 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2962MAQT029794
        for <bpf@vger.kernel.org>; Wed, 5 Oct 2022 21:25:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3k1p5d8fw2-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 21:25:03 -0700
Received: from twshared12430.23.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 21:25:01 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4A3131FC4ED88; Wed,  5 Oct 2022 21:24:54 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andrea Terzolo <andrea.terzolo@polito.it>
Subject: [PATCH v2 bpf-next 1/2] bpf: explicitly define BPF_FUNC_xxx integer values
Date:   Wed, 5 Oct 2022 21:24:51 -0700
Message-ID: <20221006042452.2089843-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5OgMpHeG25IlDA_vr0XJImeExEG2WmEP
X-Proofpoint-ORIG-GUID: 5OgMpHeG25IlDA_vr0XJImeExEG2WmEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
implicit sequential values being assigned by compiler. This is
convenient, as new BPF helpers are always added at the very end, but it
also has its downsides, some of them being:

  - with over 200 helpers now it's very hard to know what's each helper's ID,
    which is often important to know when working with BPF assembly (e.g.,
    by dumping raw bpf assembly instructions with llvm-objdump -d
    command). it's possible to work around this by looking into vmlinux.h,
    dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
    bpf_helper_defs.h, etc. But it always feels like an unnecessary step
    and one should be able to quickly figure this out from UAPI header.

  - when backporting and cherry-picking only some BPF helpers onto older
    kernels it's important to be able to skip some enum values for helpers
    that weren't backported, but preserve absolute integer IDs to keep BPF
    helper IDs stable so that BPF programs stay portable across upstream
    and backported kernels.

While neither problem is insurmountable, they come up frequently enough
and are annoying enough to warrant improving the situation. And for the
backporting the problem can easily go unnoticed for a while, especially
if backport is done with people not very familiar with BPF subsystem overall.

Anyways, it's easy to fix this by making sure that __BPF_FUNC_MAPPER
macro provides explicit helper IDs. Unfortunately that would potentially
break existing users that use UAPI-exposed __BPF_FUNC_MAPPER and are
expected to pass macro that accepts only symbolic helper identifier
(e.g., map_lookup_elem for bpf_map_lookup_elem() helper).

As such, we need to introduce a new macro (___BPF_FUNC_MAPPER) which
would specify both identifier and integer ID, but in such a way as to
allow existing __BPF_FUNC_MAPPER be expressed in terms of new
___BPF_FUNC_MAPPER macro. And that's what this patch is doing. To avoid
duplication and allow __BPF_FUNC_MAPPER stay *exactly* the same,
___BPF_FUNC_MAPPER accepts arbitrary "context" arguments, which can be
used to pass any extra macros, arguments, and whatnot. In our case we
use this to pass original user-provided macro that expects single
argument and __BPF_FUNC_MAPPER is using it's own three-argument
__BPF_FUNC_MAPPER_APPLY intermediate macro to impedance-match new and
old "callback" macros.

Once we resolve this, we use new ___BPF_FUNC_MAPPER to define enum
bpf_func_id with explicit values. The other users of __BPF_FUNC_MAPPER
in kernel (namely in kernel/bpf/disasm.c) are kept exactly the same both
as demonstration that backwards compat works, but also to avoid
unnecessary code churn.

Note that new ___BPF_FUNC_MAPPER() doesn't forcefully insert comma
between values, as that might not be appropriate in all possible cases
where ___BPF_FUNC_MAPPER might be used by users. This doesn't reduce
usability, as it's trivial to insert that comma inside "callback" macro.

To validate all the manually specified IDs are exactly right, we used
BTF to compare before and after values:

  $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > after.txt
  $ git stash # stach UAPI changes
  $ make -j90
  ... re-building kernel without UAPI changes ...
  $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > before.txt
  $ diff -u before.txt after.txt
  --- before.txt  2022-10-05 10:48:18.119195916 -0700
  +++ after.txt   2022-10-05 10:46:49.446615025 -0700
  @@ -1,4 +1,4 @@
  -[14576] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
  +[9560] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
          'BPF_FUNC_unspec' val=0
          'BPF_FUNC_map_lookup_elem' val=1
          'BPF_FUNC_map_update_elem' val=2

As can be seen from diff above, the only thing that changed was resulting BTF
type ID of ENUM bpf_func_id, not any of the enumerators, their names or integer
values.

The only other place that needed fixing was scripts/bpf_doc.py used to generate
man pages and bpf_helper_defs.h header for libbpf and selftests. That script is
tightly-coupled to exact shape of ___BPF_FUNC_MAPPER macro definition, so had
to be trivially adapted.

Cc: Quentin Monnet <quentin@isovalent.com>
Reported-by: Andrea Terzolo <andrea.terzolo@polito.it>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       | 432 +++++++++++++++++----------------
 scripts/bpf_doc.py             |  19 +-
 tools/include/uapi/linux/bpf.h | 432 +++++++++++++++++----------------
 3 files changed, 447 insertions(+), 436 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3075018a4ef8..119667a300d9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5433,225 +5433,231 @@ union bpf_attr {
  *		larger than the size of the ring buffer, or which cannot fit
  *		within a struct bpf_dynptr.
  */
-#define __BPF_FUNC_MAPPER(FN)		\
-	FN(unspec),			\
-	FN(map_lookup_elem),		\
-	FN(map_update_elem),		\
-	FN(map_delete_elem),		\
-	FN(probe_read),			\
-	FN(ktime_get_ns),		\
-	FN(trace_printk),		\
-	FN(get_prandom_u32),		\
-	FN(get_smp_processor_id),	\
-	FN(skb_store_bytes),		\
-	FN(l3_csum_replace),		\
-	FN(l4_csum_replace),		\
-	FN(tail_call),			\
-	FN(clone_redirect),		\
-	FN(get_current_pid_tgid),	\
-	FN(get_current_uid_gid),	\
-	FN(get_current_comm),		\
-	FN(get_cgroup_classid),		\
-	FN(skb_vlan_push),		\
-	FN(skb_vlan_pop),		\
-	FN(skb_get_tunnel_key),		\
-	FN(skb_set_tunnel_key),		\
-	FN(perf_event_read),		\
-	FN(redirect),			\
-	FN(get_route_realm),		\
-	FN(perf_event_output),		\
-	FN(skb_load_bytes),		\
-	FN(get_stackid),		\
-	FN(csum_diff),			\
-	FN(skb_get_tunnel_opt),		\
-	FN(skb_set_tunnel_opt),		\
-	FN(skb_change_proto),		\
-	FN(skb_change_type),		\
-	FN(skb_under_cgroup),		\
-	FN(get_hash_recalc),		\
-	FN(get_current_task),		\
-	FN(probe_write_user),		\
-	FN(current_task_under_cgroup),	\
-	FN(skb_change_tail),		\
-	FN(skb_pull_data),		\
-	FN(csum_update),		\
-	FN(set_hash_invalid),		\
-	FN(get_numa_node_id),		\
-	FN(skb_change_head),		\
-	FN(xdp_adjust_head),		\
-	FN(probe_read_str),		\
-	FN(get_socket_cookie),		\
-	FN(get_socket_uid),		\
-	FN(set_hash),			\
-	FN(setsockopt),			\
-	FN(skb_adjust_room),		\
-	FN(redirect_map),		\
-	FN(sk_redirect_map),		\
-	FN(sock_map_update),		\
-	FN(xdp_adjust_meta),		\
-	FN(perf_event_read_value),	\
-	FN(perf_prog_read_value),	\
-	FN(getsockopt),			\
-	FN(override_return),		\
-	FN(sock_ops_cb_flags_set),	\
-	FN(msg_redirect_map),		\
-	FN(msg_apply_bytes),		\
-	FN(msg_cork_bytes),		\
-	FN(msg_pull_data),		\
-	FN(bind),			\
-	FN(xdp_adjust_tail),		\
-	FN(skb_get_xfrm_state),		\
-	FN(get_stack),			\
-	FN(skb_load_bytes_relative),	\
-	FN(fib_lookup),			\
-	FN(sock_hash_update),		\
-	FN(msg_redirect_hash),		\
-	FN(sk_redirect_hash),		\
-	FN(lwt_push_encap),		\
-	FN(lwt_seg6_store_bytes),	\
-	FN(lwt_seg6_adjust_srh),	\
-	FN(lwt_seg6_action),		\
-	FN(rc_repeat),			\
-	FN(rc_keydown),			\
-	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),	\
-	FN(get_local_storage),		\
-	FN(sk_select_reuseport),	\
-	FN(skb_ancestor_cgroup_id),	\
-	FN(sk_lookup_tcp),		\
-	FN(sk_lookup_udp),		\
-	FN(sk_release),			\
-	FN(map_push_elem),		\
-	FN(map_pop_elem),		\
-	FN(map_peek_elem),		\
-	FN(msg_push_data),		\
-	FN(msg_pop_data),		\
-	FN(rc_pointer_rel),		\
-	FN(spin_lock),			\
-	FN(spin_unlock),		\
-	FN(sk_fullsock),		\
-	FN(tcp_sock),			\
-	FN(skb_ecn_set_ce),		\
-	FN(get_listener_sock),		\
-	FN(skc_lookup_tcp),		\
-	FN(tcp_check_syncookie),	\
-	FN(sysctl_get_name),		\
-	FN(sysctl_get_current_value),	\
-	FN(sysctl_get_new_value),	\
-	FN(sysctl_set_new_value),	\
-	FN(strtol),			\
-	FN(strtoul),			\
-	FN(sk_storage_get),		\
-	FN(sk_storage_delete),		\
-	FN(send_signal),		\
-	FN(tcp_gen_syncookie),		\
-	FN(skb_output),			\
-	FN(probe_read_user),		\
-	FN(probe_read_kernel),		\
-	FN(probe_read_user_str),	\
-	FN(probe_read_kernel_str),	\
-	FN(tcp_send_ack),		\
-	FN(send_signal_thread),		\
-	FN(jiffies64),			\
-	FN(read_branch_records),	\
-	FN(get_ns_current_pid_tgid),	\
-	FN(xdp_output),			\
-	FN(get_netns_cookie),		\
-	FN(get_current_ancestor_cgroup_id),	\
-	FN(sk_assign),			\
-	FN(ktime_get_boot_ns),		\
-	FN(seq_printf),			\
-	FN(seq_write),			\
-	FN(sk_cgroup_id),		\
-	FN(sk_ancestor_cgroup_id),	\
-	FN(ringbuf_output),		\
-	FN(ringbuf_reserve),		\
-	FN(ringbuf_submit),		\
-	FN(ringbuf_discard),		\
-	FN(ringbuf_query),		\
-	FN(csum_level),			\
-	FN(skc_to_tcp6_sock),		\
-	FN(skc_to_tcp_sock),		\
-	FN(skc_to_tcp_timewait_sock),	\
-	FN(skc_to_tcp_request_sock),	\
-	FN(skc_to_udp6_sock),		\
-	FN(get_task_stack),		\
-	FN(load_hdr_opt),		\
-	FN(store_hdr_opt),		\
-	FN(reserve_hdr_opt),		\
-	FN(inode_storage_get),		\
-	FN(inode_storage_delete),	\
-	FN(d_path),			\
-	FN(copy_from_user),		\
-	FN(snprintf_btf),		\
-	FN(seq_printf_btf),		\
-	FN(skb_cgroup_classid),		\
-	FN(redirect_neigh),		\
-	FN(per_cpu_ptr),		\
-	FN(this_cpu_ptr),		\
-	FN(redirect_peer),		\
-	FN(task_storage_get),		\
-	FN(task_storage_delete),	\
-	FN(get_current_task_btf),	\
-	FN(bprm_opts_set),		\
-	FN(ktime_get_coarse_ns),	\
-	FN(ima_inode_hash),		\
-	FN(sock_from_file),		\
-	FN(check_mtu),			\
-	FN(for_each_map_elem),		\
-	FN(snprintf),			\
-	FN(sys_bpf),			\
-	FN(btf_find_by_name_kind),	\
-	FN(sys_close),			\
-	FN(timer_init),			\
-	FN(timer_set_callback),		\
-	FN(timer_start),		\
-	FN(timer_cancel),		\
-	FN(get_func_ip),		\
-	FN(get_attach_cookie),		\
-	FN(task_pt_regs),		\
-	FN(get_branch_snapshot),	\
-	FN(trace_vprintk),		\
-	FN(skc_to_unix_sock),		\
-	FN(kallsyms_lookup_name),	\
-	FN(find_vma),			\
-	FN(loop),			\
-	FN(strncmp),			\
-	FN(get_func_arg),		\
-	FN(get_func_ret),		\
-	FN(get_func_arg_cnt),		\
-	FN(get_retval),			\
-	FN(set_retval),			\
-	FN(xdp_get_buff_len),		\
-	FN(xdp_load_bytes),		\
-	FN(xdp_store_bytes),		\
-	FN(copy_from_user_task),	\
-	FN(skb_set_tstamp),		\
-	FN(ima_file_hash),		\
-	FN(kptr_xchg),			\
-	FN(map_lookup_percpu_elem),     \
-	FN(skc_to_mptcp_sock),		\
-	FN(dynptr_from_mem),		\
-	FN(ringbuf_reserve_dynptr),	\
-	FN(ringbuf_submit_dynptr),	\
-	FN(ringbuf_discard_dynptr),	\
-	FN(dynptr_read),		\
-	FN(dynptr_write),		\
-	FN(dynptr_data),		\
-	FN(tcp_raw_gen_syncookie_ipv4),	\
-	FN(tcp_raw_gen_syncookie_ipv6),	\
-	FN(tcp_raw_check_syncookie_ipv4),	\
-	FN(tcp_raw_check_syncookie_ipv6),	\
-	FN(ktime_get_tai_ns),		\
-	FN(user_ringbuf_drain),		\
+#define ___BPF_FUNC_MAPPER(FN, ctx...)			\
+	FN(unspec, 0, ##ctx)				\
+	FN(map_lookup_elem, 1, ##ctx)			\
+	FN(map_update_elem, 2, ##ctx)			\
+	FN(map_delete_elem, 3, ##ctx)			\
+	FN(probe_read, 4, ##ctx)			\
+	FN(ktime_get_ns, 5, ##ctx)			\
+	FN(trace_printk, 6, ##ctx)			\
+	FN(get_prandom_u32, 7, ##ctx)			\
+	FN(get_smp_processor_id, 8, ##ctx)		\
+	FN(skb_store_bytes, 9, ##ctx)			\
+	FN(l3_csum_replace, 10, ##ctx)			\
+	FN(l4_csum_replace, 11, ##ctx)			\
+	FN(tail_call, 12, ##ctx)			\
+	FN(clone_redirect, 13, ##ctx)			\
+	FN(get_current_pid_tgid, 14, ##ctx)		\
+	FN(get_current_uid_gid, 15, ##ctx)		\
+	FN(get_current_comm, 16, ##ctx)			\
+	FN(get_cgroup_classid, 17, ##ctx)		\
+	FN(skb_vlan_push, 18, ##ctx)			\
+	FN(skb_vlan_pop, 19, ##ctx)			\
+	FN(skb_get_tunnel_key, 20, ##ctx)		\
+	FN(skb_set_tunnel_key, 21, ##ctx)		\
+	FN(perf_event_read, 22, ##ctx)			\
+	FN(redirect, 23, ##ctx)				\
+	FN(get_route_realm, 24, ##ctx)			\
+	FN(perf_event_output, 25, ##ctx)		\
+	FN(skb_load_bytes, 26, ##ctx)			\
+	FN(get_stackid, 27, ##ctx)			\
+	FN(csum_diff, 28, ##ctx)			\
+	FN(skb_get_tunnel_opt, 29, ##ctx)		\
+	FN(skb_set_tunnel_opt, 30, ##ctx)		\
+	FN(skb_change_proto, 31, ##ctx)			\
+	FN(skb_change_type, 32, ##ctx)			\
+	FN(skb_under_cgroup, 33, ##ctx)			\
+	FN(get_hash_recalc, 34, ##ctx)			\
+	FN(get_current_task, 35, ##ctx)			\
+	FN(probe_write_user, 36, ##ctx)			\
+	FN(current_task_under_cgroup, 37, ##ctx)	\
+	FN(skb_change_tail, 38, ##ctx)			\
+	FN(skb_pull_data, 39, ##ctx)			\
+	FN(csum_update, 40, ##ctx)			\
+	FN(set_hash_invalid, 41, ##ctx)			\
+	FN(get_numa_node_id, 42, ##ctx)			\
+	FN(skb_change_head, 43, ##ctx)			\
+	FN(xdp_adjust_head, 44, ##ctx)			\
+	FN(probe_read_str, 45, ##ctx)			\
+	FN(get_socket_cookie, 46, ##ctx)		\
+	FN(get_socket_uid, 47, ##ctx)			\
+	FN(set_hash, 48, ##ctx)				\
+	FN(setsockopt, 49, ##ctx)			\
+	FN(skb_adjust_room, 50, ##ctx)			\
+	FN(redirect_map, 51, ##ctx)			\
+	FN(sk_redirect_map, 52, ##ctx)			\
+	FN(sock_map_update, 53, ##ctx)			\
+	FN(xdp_adjust_meta, 54, ##ctx)			\
+	FN(perf_event_read_value, 55, ##ctx)		\
+	FN(perf_prog_read_value, 56, ##ctx)		\
+	FN(getsockopt, 57, ##ctx)			\
+	FN(override_return, 58, ##ctx)			\
+	FN(sock_ops_cb_flags_set, 59, ##ctx)		\
+	FN(msg_redirect_map, 60, ##ctx)			\
+	FN(msg_apply_bytes, 61, ##ctx)			\
+	FN(msg_cork_bytes, 62, ##ctx)			\
+	FN(msg_pull_data, 63, ##ctx)			\
+	FN(bind, 64, ##ctx)				\
+	FN(xdp_adjust_tail, 65, ##ctx)			\
+	FN(skb_get_xfrm_state, 66, ##ctx)		\
+	FN(get_stack, 67, ##ctx)			\
+	FN(skb_load_bytes_relative, 68, ##ctx)		\
+	FN(fib_lookup, 69, ##ctx)			\
+	FN(sock_hash_update, 70, ##ctx)			\
+	FN(msg_redirect_hash, 71, ##ctx)		\
+	FN(sk_redirect_hash, 72, ##ctx)			\
+	FN(lwt_push_encap, 73, ##ctx)			\
+	FN(lwt_seg6_store_bytes, 74, ##ctx)		\
+	FN(lwt_seg6_adjust_srh, 75, ##ctx)		\
+	FN(lwt_seg6_action, 76, ##ctx)			\
+	FN(rc_repeat, 77, ##ctx)			\
+	FN(rc_keydown, 78, ##ctx)			\
+	FN(skb_cgroup_id, 79, ##ctx)			\
+	FN(get_current_cgroup_id, 80, ##ctx)		\
+	FN(get_local_storage, 81, ##ctx)		\
+	FN(sk_select_reuseport, 82, ##ctx)		\
+	FN(skb_ancestor_cgroup_id, 83, ##ctx)		\
+	FN(sk_lookup_tcp, 84, ##ctx)			\
+	FN(sk_lookup_udp, 85, ##ctx)			\
+	FN(sk_release, 86, ##ctx)			\
+	FN(map_push_elem, 87, ##ctx)			\
+	FN(map_pop_elem, 88, ##ctx)			\
+	FN(map_peek_elem, 89, ##ctx)			\
+	FN(msg_push_data, 90, ##ctx)			\
+	FN(msg_pop_data, 91, ##ctx)			\
+	FN(rc_pointer_rel, 92, ##ctx)			\
+	FN(spin_lock, 93, ##ctx)			\
+	FN(spin_unlock, 94, ##ctx)			\
+	FN(sk_fullsock, 95, ##ctx)			\
+	FN(tcp_sock, 96, ##ctx)				\
+	FN(skb_ecn_set_ce, 97, ##ctx)			\
+	FN(get_listener_sock, 98, ##ctx)		\
+	FN(skc_lookup_tcp, 99, ##ctx)			\
+	FN(tcp_check_syncookie, 100, ##ctx)		\
+	FN(sysctl_get_name, 101, ##ctx)			\
+	FN(sysctl_get_current_value, 102, ##ctx)	\
+	FN(sysctl_get_new_value, 103, ##ctx)		\
+	FN(sysctl_set_new_value, 104, ##ctx)		\
+	FN(strtol, 105, ##ctx)				\
+	FN(strtoul, 106, ##ctx)				\
+	FN(sk_storage_get, 107, ##ctx)			\
+	FN(sk_storage_delete, 108, ##ctx)		\
+	FN(send_signal, 109, ##ctx)			\
+	FN(tcp_gen_syncookie, 110, ##ctx)		\
+	FN(skb_output, 111, ##ctx)			\
+	FN(probe_read_user, 112, ##ctx)			\
+	FN(probe_read_kernel, 113, ##ctx)		\
+	FN(probe_read_user_str, 114, ##ctx)		\
+	FN(probe_read_kernel_str, 115, ##ctx)		\
+	FN(tcp_send_ack, 116, ##ctx)			\
+	FN(send_signal_thread, 117, ##ctx)		\
+	FN(jiffies64, 118, ##ctx)			\
+	FN(read_branch_records, 119, ##ctx)		\
+	FN(get_ns_current_pid_tgid, 120, ##ctx)		\
+	FN(xdp_output, 121, ##ctx)			\
+	FN(get_netns_cookie, 122, ##ctx)		\
+	FN(get_current_ancestor_cgroup_id, 123, ##ctx)	\
+	FN(sk_assign, 124, ##ctx)			\
+	FN(ktime_get_boot_ns, 125, ##ctx)		\
+	FN(seq_printf, 126, ##ctx)			\
+	FN(seq_write, 127, ##ctx)			\
+	FN(sk_cgroup_id, 128, ##ctx)			\
+	FN(sk_ancestor_cgroup_id, 129, ##ctx)		\
+	FN(ringbuf_output, 130, ##ctx)			\
+	FN(ringbuf_reserve, 131, ##ctx)			\
+	FN(ringbuf_submit, 132, ##ctx)			\
+	FN(ringbuf_discard, 133, ##ctx)			\
+	FN(ringbuf_query, 134, ##ctx)			\
+	FN(csum_level, 135, ##ctx)			\
+	FN(skc_to_tcp6_sock, 136, ##ctx)		\
+	FN(skc_to_tcp_sock, 137, ##ctx)			\
+	FN(skc_to_tcp_timewait_sock, 138, ##ctx)	\
+	FN(skc_to_tcp_request_sock, 139, ##ctx)		\
+	FN(skc_to_udp6_sock, 140, ##ctx)		\
+	FN(get_task_stack, 141, ##ctx)			\
+	FN(load_hdr_opt, 142, ##ctx)			\
+	FN(store_hdr_opt, 143, ##ctx)			\
+	FN(reserve_hdr_opt, 144, ##ctx)			\
+	FN(inode_storage_get, 145, ##ctx)		\
+	FN(inode_storage_delete, 146, ##ctx)		\
+	FN(d_path, 147, ##ctx)				\
+	FN(copy_from_user, 148, ##ctx)			\
+	FN(snprintf_btf, 149, ##ctx)			\
+	FN(seq_printf_btf, 150, ##ctx)			\
+	FN(skb_cgroup_classid, 151, ##ctx)		\
+	FN(redirect_neigh, 152, ##ctx)			\
+	FN(per_cpu_ptr, 153, ##ctx)			\
+	FN(this_cpu_ptr, 154, ##ctx)			\
+	FN(redirect_peer, 155, ##ctx)			\
+	FN(task_storage_get, 156, ##ctx)		\
+	FN(task_storage_delete, 157, ##ctx)		\
+	FN(get_current_task_btf, 158, ##ctx)		\
+	FN(bprm_opts_set, 159, ##ctx)			\
+	FN(ktime_get_coarse_ns, 160, ##ctx)		\
+	FN(ima_inode_hash, 161, ##ctx)			\
+	FN(sock_from_file, 162, ##ctx)			\
+	FN(check_mtu, 163, ##ctx)			\
+	FN(for_each_map_elem, 164, ##ctx)		\
+	FN(snprintf, 165, ##ctx)			\
+	FN(sys_bpf, 166, ##ctx)				\
+	FN(btf_find_by_name_kind, 167, ##ctx)		\
+	FN(sys_close, 168, ##ctx)			\
+	FN(timer_init, 169, ##ctx)			\
+	FN(timer_set_callback, 170, ##ctx)		\
+	FN(timer_start, 171, ##ctx)			\
+	FN(timer_cancel, 172, ##ctx)			\
+	FN(get_func_ip, 173, ##ctx)			\
+	FN(get_attach_cookie, 174, ##ctx)		\
+	FN(task_pt_regs, 175, ##ctx)			\
+	FN(get_branch_snapshot, 176, ##ctx)		\
+	FN(trace_vprintk, 177, ##ctx)			\
+	FN(skc_to_unix_sock, 178, ##ctx)		\
+	FN(kallsyms_lookup_name, 179, ##ctx)		\
+	FN(find_vma, 180, ##ctx)			\
+	FN(loop, 181, ##ctx)				\
+	FN(strncmp, 182, ##ctx)				\
+	FN(get_func_arg, 183, ##ctx)			\
+	FN(get_func_ret, 184, ##ctx)			\
+	FN(get_func_arg_cnt, 185, ##ctx)		\
+	FN(get_retval, 186, ##ctx)			\
+	FN(set_retval, 187, ##ctx)			\
+	FN(xdp_get_buff_len, 188, ##ctx)		\
+	FN(xdp_load_bytes, 189, ##ctx)			\
+	FN(xdp_store_bytes, 190, ##ctx)			\
+	FN(copy_from_user_task, 191, ##ctx)		\
+	FN(skb_set_tstamp, 192, ##ctx)			\
+	FN(ima_file_hash, 193, ##ctx)			\
+	FN(kptr_xchg, 194, ##ctx)			\
+	FN(map_lookup_percpu_elem, 195, ##ctx)		\
+	FN(skc_to_mptcp_sock, 196, ##ctx)		\
+	FN(dynptr_from_mem, 197, ##ctx)			\
+	FN(ringbuf_reserve_dynptr, 198, ##ctx)		\
+	FN(ringbuf_submit_dynptr, 199, ##ctx)		\
+	FN(ringbuf_discard_dynptr, 200, ##ctx)		\
+	FN(dynptr_read, 201, ##ctx)			\
+	FN(dynptr_write, 202, ##ctx)			\
+	FN(dynptr_data, 203, ##ctx)			\
+	FN(tcp_raw_gen_syncookie_ipv4, 204, ##ctx)	\
+	FN(tcp_raw_gen_syncookie_ipv6, 205, ##ctx)	\
+	FN(tcp_raw_check_syncookie_ipv4, 206, ##ctx)	\
+	FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)	\
+	FN(ktime_get_tai_ns, 208, ##ctx)		\
+	FN(user_ringbuf_drain, 209, ##ctx)		\
 	/* */
 
+/* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
+ * know or care about integer value that is now passed as second argument
+ */
+#define __BPF_FUNC_MAPPER_APPLY(name, value, FN) FN(name),
+#define __BPF_FUNC_MAPPER(FN) ___BPF_FUNC_MAPPER(__BPF_FUNC_MAPPER_APPLY, FN)
+
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
  */
-#define __BPF_ENUM_FN(x) BPF_FUNC_ ## x
+#define __BPF_ENUM_FN(x, y) BPF_FUNC_ ## x = y,
 enum bpf_func_id {
-	__BPF_FUNC_MAPPER(__BPF_ENUM_FN)
+	___BPF_FUNC_MAPPER(__BPF_ENUM_FN)
 	__BPF_FUNC_MAX_ID,
 };
 #undef __BPF_ENUM_FN
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index d5c389df6045..2fe07c9e3fe0 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -253,28 +253,27 @@ class HeaderParser(object):
                 break
 
     def parse_define_helpers(self):
-        # Parse FN(...) in #define __BPF_FUNC_MAPPER to compare later with the
+        # Parse FN(...) in #define ___BPF_FUNC_MAPPER to compare later with the
         # number of unique function names present in description and use the
         # correct enumeration value.
         # Note: seek_to(..) discards the first line below the target search text,
-        # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
-        self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
+        # resulting in FN(unspec, 0, ##ctx) being skipped and not added to
+        # self.define_unique_helpers.
+        self.seek_to('#define ___BPF_FUNC_MAPPER(FN, ctx...)',
                      'Could not find start of eBPF helper definition list')
         # Searches for one FN(\w+) define or a backslash for newline
-        p = re.compile('\s*FN\((\w+)\)|\\\\')
+        p = re.compile('\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
         fn_defines_str = ''
-        i = 1  # 'unspec' is skipped as mentioned above
         while True:
             capture = p.match(self.line)
             if capture:
                 fn_defines_str += self.line
-                self.helper_enum_vals[capture.expand(r'bpf_\1')] = i
-                i += 1
+                self.helper_enum_vals[capture.expand(r'bpf_\1')] = int(capture[2])
             else:
                 break
             self.line = self.reader.readline()
         # Find the number of occurences of FN(\w+)
-        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
+        self.define_unique_helpers = re.findall('FN\(\w+, \d+, ##ctx\)', fn_defines_str)
 
     def assign_helper_values(self):
         seen_helpers = set()
@@ -423,7 +422,7 @@ class PrinterHelpersRST(PrinterRST):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
-        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
+        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '___BPF_FUNC_MAPPER')
 
     def print_header(self):
         header = '''\
@@ -636,7 +635,7 @@ class PrinterHelpers(Printer):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
-        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
+        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '___BPF_FUNC_MAPPER')
 
     type_fwds = [
             'struct bpf_fib_lookup',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3075018a4ef8..119667a300d9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5433,225 +5433,231 @@ union bpf_attr {
  *		larger than the size of the ring buffer, or which cannot fit
  *		within a struct bpf_dynptr.
  */
-#define __BPF_FUNC_MAPPER(FN)		\
-	FN(unspec),			\
-	FN(map_lookup_elem),		\
-	FN(map_update_elem),		\
-	FN(map_delete_elem),		\
-	FN(probe_read),			\
-	FN(ktime_get_ns),		\
-	FN(trace_printk),		\
-	FN(get_prandom_u32),		\
-	FN(get_smp_processor_id),	\
-	FN(skb_store_bytes),		\
-	FN(l3_csum_replace),		\
-	FN(l4_csum_replace),		\
-	FN(tail_call),			\
-	FN(clone_redirect),		\
-	FN(get_current_pid_tgid),	\
-	FN(get_current_uid_gid),	\
-	FN(get_current_comm),		\
-	FN(get_cgroup_classid),		\
-	FN(skb_vlan_push),		\
-	FN(skb_vlan_pop),		\
-	FN(skb_get_tunnel_key),		\
-	FN(skb_set_tunnel_key),		\
-	FN(perf_event_read),		\
-	FN(redirect),			\
-	FN(get_route_realm),		\
-	FN(perf_event_output),		\
-	FN(skb_load_bytes),		\
-	FN(get_stackid),		\
-	FN(csum_diff),			\
-	FN(skb_get_tunnel_opt),		\
-	FN(skb_set_tunnel_opt),		\
-	FN(skb_change_proto),		\
-	FN(skb_change_type),		\
-	FN(skb_under_cgroup),		\
-	FN(get_hash_recalc),		\
-	FN(get_current_task),		\
-	FN(probe_write_user),		\
-	FN(current_task_under_cgroup),	\
-	FN(skb_change_tail),		\
-	FN(skb_pull_data),		\
-	FN(csum_update),		\
-	FN(set_hash_invalid),		\
-	FN(get_numa_node_id),		\
-	FN(skb_change_head),		\
-	FN(xdp_adjust_head),		\
-	FN(probe_read_str),		\
-	FN(get_socket_cookie),		\
-	FN(get_socket_uid),		\
-	FN(set_hash),			\
-	FN(setsockopt),			\
-	FN(skb_adjust_room),		\
-	FN(redirect_map),		\
-	FN(sk_redirect_map),		\
-	FN(sock_map_update),		\
-	FN(xdp_adjust_meta),		\
-	FN(perf_event_read_value),	\
-	FN(perf_prog_read_value),	\
-	FN(getsockopt),			\
-	FN(override_return),		\
-	FN(sock_ops_cb_flags_set),	\
-	FN(msg_redirect_map),		\
-	FN(msg_apply_bytes),		\
-	FN(msg_cork_bytes),		\
-	FN(msg_pull_data),		\
-	FN(bind),			\
-	FN(xdp_adjust_tail),		\
-	FN(skb_get_xfrm_state),		\
-	FN(get_stack),			\
-	FN(skb_load_bytes_relative),	\
-	FN(fib_lookup),			\
-	FN(sock_hash_update),		\
-	FN(msg_redirect_hash),		\
-	FN(sk_redirect_hash),		\
-	FN(lwt_push_encap),		\
-	FN(lwt_seg6_store_bytes),	\
-	FN(lwt_seg6_adjust_srh),	\
-	FN(lwt_seg6_action),		\
-	FN(rc_repeat),			\
-	FN(rc_keydown),			\
-	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),	\
-	FN(get_local_storage),		\
-	FN(sk_select_reuseport),	\
-	FN(skb_ancestor_cgroup_id),	\
-	FN(sk_lookup_tcp),		\
-	FN(sk_lookup_udp),		\
-	FN(sk_release),			\
-	FN(map_push_elem),		\
-	FN(map_pop_elem),		\
-	FN(map_peek_elem),		\
-	FN(msg_push_data),		\
-	FN(msg_pop_data),		\
-	FN(rc_pointer_rel),		\
-	FN(spin_lock),			\
-	FN(spin_unlock),		\
-	FN(sk_fullsock),		\
-	FN(tcp_sock),			\
-	FN(skb_ecn_set_ce),		\
-	FN(get_listener_sock),		\
-	FN(skc_lookup_tcp),		\
-	FN(tcp_check_syncookie),	\
-	FN(sysctl_get_name),		\
-	FN(sysctl_get_current_value),	\
-	FN(sysctl_get_new_value),	\
-	FN(sysctl_set_new_value),	\
-	FN(strtol),			\
-	FN(strtoul),			\
-	FN(sk_storage_get),		\
-	FN(sk_storage_delete),		\
-	FN(send_signal),		\
-	FN(tcp_gen_syncookie),		\
-	FN(skb_output),			\
-	FN(probe_read_user),		\
-	FN(probe_read_kernel),		\
-	FN(probe_read_user_str),	\
-	FN(probe_read_kernel_str),	\
-	FN(tcp_send_ack),		\
-	FN(send_signal_thread),		\
-	FN(jiffies64),			\
-	FN(read_branch_records),	\
-	FN(get_ns_current_pid_tgid),	\
-	FN(xdp_output),			\
-	FN(get_netns_cookie),		\
-	FN(get_current_ancestor_cgroup_id),	\
-	FN(sk_assign),			\
-	FN(ktime_get_boot_ns),		\
-	FN(seq_printf),			\
-	FN(seq_write),			\
-	FN(sk_cgroup_id),		\
-	FN(sk_ancestor_cgroup_id),	\
-	FN(ringbuf_output),		\
-	FN(ringbuf_reserve),		\
-	FN(ringbuf_submit),		\
-	FN(ringbuf_discard),		\
-	FN(ringbuf_query),		\
-	FN(csum_level),			\
-	FN(skc_to_tcp6_sock),		\
-	FN(skc_to_tcp_sock),		\
-	FN(skc_to_tcp_timewait_sock),	\
-	FN(skc_to_tcp_request_sock),	\
-	FN(skc_to_udp6_sock),		\
-	FN(get_task_stack),		\
-	FN(load_hdr_opt),		\
-	FN(store_hdr_opt),		\
-	FN(reserve_hdr_opt),		\
-	FN(inode_storage_get),		\
-	FN(inode_storage_delete),	\
-	FN(d_path),			\
-	FN(copy_from_user),		\
-	FN(snprintf_btf),		\
-	FN(seq_printf_btf),		\
-	FN(skb_cgroup_classid),		\
-	FN(redirect_neigh),		\
-	FN(per_cpu_ptr),		\
-	FN(this_cpu_ptr),		\
-	FN(redirect_peer),		\
-	FN(task_storage_get),		\
-	FN(task_storage_delete),	\
-	FN(get_current_task_btf),	\
-	FN(bprm_opts_set),		\
-	FN(ktime_get_coarse_ns),	\
-	FN(ima_inode_hash),		\
-	FN(sock_from_file),		\
-	FN(check_mtu),			\
-	FN(for_each_map_elem),		\
-	FN(snprintf),			\
-	FN(sys_bpf),			\
-	FN(btf_find_by_name_kind),	\
-	FN(sys_close),			\
-	FN(timer_init),			\
-	FN(timer_set_callback),		\
-	FN(timer_start),		\
-	FN(timer_cancel),		\
-	FN(get_func_ip),		\
-	FN(get_attach_cookie),		\
-	FN(task_pt_regs),		\
-	FN(get_branch_snapshot),	\
-	FN(trace_vprintk),		\
-	FN(skc_to_unix_sock),		\
-	FN(kallsyms_lookup_name),	\
-	FN(find_vma),			\
-	FN(loop),			\
-	FN(strncmp),			\
-	FN(get_func_arg),		\
-	FN(get_func_ret),		\
-	FN(get_func_arg_cnt),		\
-	FN(get_retval),			\
-	FN(set_retval),			\
-	FN(xdp_get_buff_len),		\
-	FN(xdp_load_bytes),		\
-	FN(xdp_store_bytes),		\
-	FN(copy_from_user_task),	\
-	FN(skb_set_tstamp),		\
-	FN(ima_file_hash),		\
-	FN(kptr_xchg),			\
-	FN(map_lookup_percpu_elem),     \
-	FN(skc_to_mptcp_sock),		\
-	FN(dynptr_from_mem),		\
-	FN(ringbuf_reserve_dynptr),	\
-	FN(ringbuf_submit_dynptr),	\
-	FN(ringbuf_discard_dynptr),	\
-	FN(dynptr_read),		\
-	FN(dynptr_write),		\
-	FN(dynptr_data),		\
-	FN(tcp_raw_gen_syncookie_ipv4),	\
-	FN(tcp_raw_gen_syncookie_ipv6),	\
-	FN(tcp_raw_check_syncookie_ipv4),	\
-	FN(tcp_raw_check_syncookie_ipv6),	\
-	FN(ktime_get_tai_ns),		\
-	FN(user_ringbuf_drain),		\
+#define ___BPF_FUNC_MAPPER(FN, ctx...)			\
+	FN(unspec, 0, ##ctx)				\
+	FN(map_lookup_elem, 1, ##ctx)			\
+	FN(map_update_elem, 2, ##ctx)			\
+	FN(map_delete_elem, 3, ##ctx)			\
+	FN(probe_read, 4, ##ctx)			\
+	FN(ktime_get_ns, 5, ##ctx)			\
+	FN(trace_printk, 6, ##ctx)			\
+	FN(get_prandom_u32, 7, ##ctx)			\
+	FN(get_smp_processor_id, 8, ##ctx)		\
+	FN(skb_store_bytes, 9, ##ctx)			\
+	FN(l3_csum_replace, 10, ##ctx)			\
+	FN(l4_csum_replace, 11, ##ctx)			\
+	FN(tail_call, 12, ##ctx)			\
+	FN(clone_redirect, 13, ##ctx)			\
+	FN(get_current_pid_tgid, 14, ##ctx)		\
+	FN(get_current_uid_gid, 15, ##ctx)		\
+	FN(get_current_comm, 16, ##ctx)			\
+	FN(get_cgroup_classid, 17, ##ctx)		\
+	FN(skb_vlan_push, 18, ##ctx)			\
+	FN(skb_vlan_pop, 19, ##ctx)			\
+	FN(skb_get_tunnel_key, 20, ##ctx)		\
+	FN(skb_set_tunnel_key, 21, ##ctx)		\
+	FN(perf_event_read, 22, ##ctx)			\
+	FN(redirect, 23, ##ctx)				\
+	FN(get_route_realm, 24, ##ctx)			\
+	FN(perf_event_output, 25, ##ctx)		\
+	FN(skb_load_bytes, 26, ##ctx)			\
+	FN(get_stackid, 27, ##ctx)			\
+	FN(csum_diff, 28, ##ctx)			\
+	FN(skb_get_tunnel_opt, 29, ##ctx)		\
+	FN(skb_set_tunnel_opt, 30, ##ctx)		\
+	FN(skb_change_proto, 31, ##ctx)			\
+	FN(skb_change_type, 32, ##ctx)			\
+	FN(skb_under_cgroup, 33, ##ctx)			\
+	FN(get_hash_recalc, 34, ##ctx)			\
+	FN(get_current_task, 35, ##ctx)			\
+	FN(probe_write_user, 36, ##ctx)			\
+	FN(current_task_under_cgroup, 37, ##ctx)	\
+	FN(skb_change_tail, 38, ##ctx)			\
+	FN(skb_pull_data, 39, ##ctx)			\
+	FN(csum_update, 40, ##ctx)			\
+	FN(set_hash_invalid, 41, ##ctx)			\
+	FN(get_numa_node_id, 42, ##ctx)			\
+	FN(skb_change_head, 43, ##ctx)			\
+	FN(xdp_adjust_head, 44, ##ctx)			\
+	FN(probe_read_str, 45, ##ctx)			\
+	FN(get_socket_cookie, 46, ##ctx)		\
+	FN(get_socket_uid, 47, ##ctx)			\
+	FN(set_hash, 48, ##ctx)				\
+	FN(setsockopt, 49, ##ctx)			\
+	FN(skb_adjust_room, 50, ##ctx)			\
+	FN(redirect_map, 51, ##ctx)			\
+	FN(sk_redirect_map, 52, ##ctx)			\
+	FN(sock_map_update, 53, ##ctx)			\
+	FN(xdp_adjust_meta, 54, ##ctx)			\
+	FN(perf_event_read_value, 55, ##ctx)		\
+	FN(perf_prog_read_value, 56, ##ctx)		\
+	FN(getsockopt, 57, ##ctx)			\
+	FN(override_return, 58, ##ctx)			\
+	FN(sock_ops_cb_flags_set, 59, ##ctx)		\
+	FN(msg_redirect_map, 60, ##ctx)			\
+	FN(msg_apply_bytes, 61, ##ctx)			\
+	FN(msg_cork_bytes, 62, ##ctx)			\
+	FN(msg_pull_data, 63, ##ctx)			\
+	FN(bind, 64, ##ctx)				\
+	FN(xdp_adjust_tail, 65, ##ctx)			\
+	FN(skb_get_xfrm_state, 66, ##ctx)		\
+	FN(get_stack, 67, ##ctx)			\
+	FN(skb_load_bytes_relative, 68, ##ctx)		\
+	FN(fib_lookup, 69, ##ctx)			\
+	FN(sock_hash_update, 70, ##ctx)			\
+	FN(msg_redirect_hash, 71, ##ctx)		\
+	FN(sk_redirect_hash, 72, ##ctx)			\
+	FN(lwt_push_encap, 73, ##ctx)			\
+	FN(lwt_seg6_store_bytes, 74, ##ctx)		\
+	FN(lwt_seg6_adjust_srh, 75, ##ctx)		\
+	FN(lwt_seg6_action, 76, ##ctx)			\
+	FN(rc_repeat, 77, ##ctx)			\
+	FN(rc_keydown, 78, ##ctx)			\
+	FN(skb_cgroup_id, 79, ##ctx)			\
+	FN(get_current_cgroup_id, 80, ##ctx)		\
+	FN(get_local_storage, 81, ##ctx)		\
+	FN(sk_select_reuseport, 82, ##ctx)		\
+	FN(skb_ancestor_cgroup_id, 83, ##ctx)		\
+	FN(sk_lookup_tcp, 84, ##ctx)			\
+	FN(sk_lookup_udp, 85, ##ctx)			\
+	FN(sk_release, 86, ##ctx)			\
+	FN(map_push_elem, 87, ##ctx)			\
+	FN(map_pop_elem, 88, ##ctx)			\
+	FN(map_peek_elem, 89, ##ctx)			\
+	FN(msg_push_data, 90, ##ctx)			\
+	FN(msg_pop_data, 91, ##ctx)			\
+	FN(rc_pointer_rel, 92, ##ctx)			\
+	FN(spin_lock, 93, ##ctx)			\
+	FN(spin_unlock, 94, ##ctx)			\
+	FN(sk_fullsock, 95, ##ctx)			\
+	FN(tcp_sock, 96, ##ctx)				\
+	FN(skb_ecn_set_ce, 97, ##ctx)			\
+	FN(get_listener_sock, 98, ##ctx)		\
+	FN(skc_lookup_tcp, 99, ##ctx)			\
+	FN(tcp_check_syncookie, 100, ##ctx)		\
+	FN(sysctl_get_name, 101, ##ctx)			\
+	FN(sysctl_get_current_value, 102, ##ctx)	\
+	FN(sysctl_get_new_value, 103, ##ctx)		\
+	FN(sysctl_set_new_value, 104, ##ctx)		\
+	FN(strtol, 105, ##ctx)				\
+	FN(strtoul, 106, ##ctx)				\
+	FN(sk_storage_get, 107, ##ctx)			\
+	FN(sk_storage_delete, 108, ##ctx)		\
+	FN(send_signal, 109, ##ctx)			\
+	FN(tcp_gen_syncookie, 110, ##ctx)		\
+	FN(skb_output, 111, ##ctx)			\
+	FN(probe_read_user, 112, ##ctx)			\
+	FN(probe_read_kernel, 113, ##ctx)		\
+	FN(probe_read_user_str, 114, ##ctx)		\
+	FN(probe_read_kernel_str, 115, ##ctx)		\
+	FN(tcp_send_ack, 116, ##ctx)			\
+	FN(send_signal_thread, 117, ##ctx)		\
+	FN(jiffies64, 118, ##ctx)			\
+	FN(read_branch_records, 119, ##ctx)		\
+	FN(get_ns_current_pid_tgid, 120, ##ctx)		\
+	FN(xdp_output, 121, ##ctx)			\
+	FN(get_netns_cookie, 122, ##ctx)		\
+	FN(get_current_ancestor_cgroup_id, 123, ##ctx)	\
+	FN(sk_assign, 124, ##ctx)			\
+	FN(ktime_get_boot_ns, 125, ##ctx)		\
+	FN(seq_printf, 126, ##ctx)			\
+	FN(seq_write, 127, ##ctx)			\
+	FN(sk_cgroup_id, 128, ##ctx)			\
+	FN(sk_ancestor_cgroup_id, 129, ##ctx)		\
+	FN(ringbuf_output, 130, ##ctx)			\
+	FN(ringbuf_reserve, 131, ##ctx)			\
+	FN(ringbuf_submit, 132, ##ctx)			\
+	FN(ringbuf_discard, 133, ##ctx)			\
+	FN(ringbuf_query, 134, ##ctx)			\
+	FN(csum_level, 135, ##ctx)			\
+	FN(skc_to_tcp6_sock, 136, ##ctx)		\
+	FN(skc_to_tcp_sock, 137, ##ctx)			\
+	FN(skc_to_tcp_timewait_sock, 138, ##ctx)	\
+	FN(skc_to_tcp_request_sock, 139, ##ctx)		\
+	FN(skc_to_udp6_sock, 140, ##ctx)		\
+	FN(get_task_stack, 141, ##ctx)			\
+	FN(load_hdr_opt, 142, ##ctx)			\
+	FN(store_hdr_opt, 143, ##ctx)			\
+	FN(reserve_hdr_opt, 144, ##ctx)			\
+	FN(inode_storage_get, 145, ##ctx)		\
+	FN(inode_storage_delete, 146, ##ctx)		\
+	FN(d_path, 147, ##ctx)				\
+	FN(copy_from_user, 148, ##ctx)			\
+	FN(snprintf_btf, 149, ##ctx)			\
+	FN(seq_printf_btf, 150, ##ctx)			\
+	FN(skb_cgroup_classid, 151, ##ctx)		\
+	FN(redirect_neigh, 152, ##ctx)			\
+	FN(per_cpu_ptr, 153, ##ctx)			\
+	FN(this_cpu_ptr, 154, ##ctx)			\
+	FN(redirect_peer, 155, ##ctx)			\
+	FN(task_storage_get, 156, ##ctx)		\
+	FN(task_storage_delete, 157, ##ctx)		\
+	FN(get_current_task_btf, 158, ##ctx)		\
+	FN(bprm_opts_set, 159, ##ctx)			\
+	FN(ktime_get_coarse_ns, 160, ##ctx)		\
+	FN(ima_inode_hash, 161, ##ctx)			\
+	FN(sock_from_file, 162, ##ctx)			\
+	FN(check_mtu, 163, ##ctx)			\
+	FN(for_each_map_elem, 164, ##ctx)		\
+	FN(snprintf, 165, ##ctx)			\
+	FN(sys_bpf, 166, ##ctx)				\
+	FN(btf_find_by_name_kind, 167, ##ctx)		\
+	FN(sys_close, 168, ##ctx)			\
+	FN(timer_init, 169, ##ctx)			\
+	FN(timer_set_callback, 170, ##ctx)		\
+	FN(timer_start, 171, ##ctx)			\
+	FN(timer_cancel, 172, ##ctx)			\
+	FN(get_func_ip, 173, ##ctx)			\
+	FN(get_attach_cookie, 174, ##ctx)		\
+	FN(task_pt_regs, 175, ##ctx)			\
+	FN(get_branch_snapshot, 176, ##ctx)		\
+	FN(trace_vprintk, 177, ##ctx)			\
+	FN(skc_to_unix_sock, 178, ##ctx)		\
+	FN(kallsyms_lookup_name, 179, ##ctx)		\
+	FN(find_vma, 180, ##ctx)			\
+	FN(loop, 181, ##ctx)				\
+	FN(strncmp, 182, ##ctx)				\
+	FN(get_func_arg, 183, ##ctx)			\
+	FN(get_func_ret, 184, ##ctx)			\
+	FN(get_func_arg_cnt, 185, ##ctx)		\
+	FN(get_retval, 186, ##ctx)			\
+	FN(set_retval, 187, ##ctx)			\
+	FN(xdp_get_buff_len, 188, ##ctx)		\
+	FN(xdp_load_bytes, 189, ##ctx)			\
+	FN(xdp_store_bytes, 190, ##ctx)			\
+	FN(copy_from_user_task, 191, ##ctx)		\
+	FN(skb_set_tstamp, 192, ##ctx)			\
+	FN(ima_file_hash, 193, ##ctx)			\
+	FN(kptr_xchg, 194, ##ctx)			\
+	FN(map_lookup_percpu_elem, 195, ##ctx)		\
+	FN(skc_to_mptcp_sock, 196, ##ctx)		\
+	FN(dynptr_from_mem, 197, ##ctx)			\
+	FN(ringbuf_reserve_dynptr, 198, ##ctx)		\
+	FN(ringbuf_submit_dynptr, 199, ##ctx)		\
+	FN(ringbuf_discard_dynptr, 200, ##ctx)		\
+	FN(dynptr_read, 201, ##ctx)			\
+	FN(dynptr_write, 202, ##ctx)			\
+	FN(dynptr_data, 203, ##ctx)			\
+	FN(tcp_raw_gen_syncookie_ipv4, 204, ##ctx)	\
+	FN(tcp_raw_gen_syncookie_ipv6, 205, ##ctx)	\
+	FN(tcp_raw_check_syncookie_ipv4, 206, ##ctx)	\
+	FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)	\
+	FN(ktime_get_tai_ns, 208, ##ctx)		\
+	FN(user_ringbuf_drain, 209, ##ctx)		\
 	/* */
 
+/* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
+ * know or care about integer value that is now passed as second argument
+ */
+#define __BPF_FUNC_MAPPER_APPLY(name, value, FN) FN(name),
+#define __BPF_FUNC_MAPPER(FN) ___BPF_FUNC_MAPPER(__BPF_FUNC_MAPPER_APPLY, FN)
+
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
  */
-#define __BPF_ENUM_FN(x) BPF_FUNC_ ## x
+#define __BPF_ENUM_FN(x, y) BPF_FUNC_ ## x = y,
 enum bpf_func_id {
-	__BPF_FUNC_MAPPER(__BPF_ENUM_FN)
+	___BPF_FUNC_MAPPER(__BPF_ENUM_FN)
 	__BPF_FUNC_MAX_ID,
 };
 #undef __BPF_ENUM_FN
-- 
2.30.2

