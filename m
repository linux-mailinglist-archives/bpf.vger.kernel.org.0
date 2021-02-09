Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B240315B22
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhBJA1c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 19:27:32 -0500
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:57262 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233326AbhBJAAd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 19:00:33 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id AD2121850ED8A;
        Tue,  9 Feb 2021 20:00:39 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CEE20837F27B;
        Tue,  9 Feb 2021 19:57:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:327:355:379:599:800:960:966:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2194:2196:2198:2199:2200:2201:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3165:3622:3653:3865:3867:3868:3870:3871:3872:3873:4250:4321:4385:4605:5007:6119:6120:6248:7652:7774:7901:7903:7904:9010:10004:11026:11232:11657:11658:11783:11914:12043:12297:12438:12740:12895:13225:13229:13255:13439:13894:14096:14097:14659:21080:21433:21451:21611:21627:21740:21789:21939:21990:30012:30054:30056:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rock18_0e164102760a
X-Filterd-Recvd-Size: 25081
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Feb 2021 19:57:55 +0000 (UTC)
Message-ID: <fcf4561a8ab24bc4b22c536c55614fa0f0a924ec.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Tue, 09 Feb 2021 11:57:54 -0800
In-Reply-To: <4D649CDF-A738-468E-AD00-8A64DDB11D1D@fb.com>
References: <20210209183343.3929160-1-songliubraving@fb.com>
         <2b41e46fcf909bd67a578524107214fe4b1eeede.camel@perches.com>
         <4D649CDF-A738-468E-AD00-8A64DDB11D1D@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-09 at 19:44 +0000, Song Liu wrote:
> > On Feb 9, 2021, at 10:59 AM, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2021-02-09 at 10:33 -0800, Song Liu wrote:
> > > BPF programs explicitly initialise global variables to 0 to make sure
> > > clang (v10 or older) do not put the variables in the common section.
> > > Skip "initialise globals to 0" check for BPF programs to elimiate error
> > > messages like:
> > > 
> > >     ERROR: do not initialise globals to 0
> > >     #19: FILE: samples/bpf/tracex1_kern.c:21:
[]
> > > ---
> > > Changes v2 => v3:
> > >   1. Fix regex.
> > 
> > Unfortunately, this has broken regexes...
> > 
> > > Changes v1 => v2:
> > >   1. Add function exclude_global_initialisers() to keep the code clean.
> > > ---
> > >  scripts/checkpatch.pl | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -2428,6 +2428,15 @@ sub get_raw_comment {
> > >  	return $comment;
> > >  }
> > > 
> > > +sub exclude_global_initialisers {
> > > +	my ($realfile) = @_;
> > > +
> > > +	# Do not check for BPF programs (tools/testing/selftests/bpf/progs/*.c, samples/bpf/*_kern.c, *.bpf.c).
> > > +	return $realfile =~ m@/^tools\/testing\/selftests\/bpf\/progs\/.*\.c@ ||
> > 
> > You don't need to escape the / when using m@@, and this doesn't work
> > given the leading / after @, and it should use a trailing $
> > 
> > 	return $realfile =~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ ||
> > 
> > > +		$realfile =~ m@^samples\/bpf\/.*_kern.c@ ||
> > 
> > This is still missing an escape on the . before c@, and there's no
> > trailing $ between c and @
> > 
> > 		$realfile =~ m@^samples/bpf/.*_kern\.c$@ ||
> > 
> > > +		$realfile =~ m@/bpf/.*\.bpf\.c$@;
> > 
> > I believe I showed the correct regexes in my earlier reply.
> 
> Just to be sure I got everything correct, does the follow look right?
> 
>         return $realfile =~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ ||
>                 $realfile =~ m@^samples/bpf/.*_kern\.c$@ ||
>                 $realfile =~ m@/bpf/.*\.bpf\.c$@;
> 
> Thanks,
> Song

Looks right, you tell me though, this is the current -next file list
for what is being suggested:

$ git ls-files | \
  perl -n -e 'print $_ if ($_ =~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ ||
                $_ =~ m@^samples/bpf/.*_kern\.c$@ ||
                $_ =~ m@/bpf/.*\.bpf\.c$@);'
kernel/bpf/preload/iterators/iterators.bpf.c
samples/bpf/cpustat_kern.c
samples/bpf/hbm_edt_kern.c
samples/bpf/hbm_out_kern.c
samples/bpf/ibumad_kern.c
samples/bpf/lathist_kern.c
samples/bpf/lwt_len_hist_kern.c
samples/bpf/map_perf_test_kern.c
samples/bpf/offwaketime_kern.c
samples/bpf/sampleip_kern.c
samples/bpf/sock_flags_kern.c
samples/bpf/sockex1_kern.c
samples/bpf/sockex2_kern.c
samples/bpf/sockex3_kern.c
samples/bpf/spintest_kern.c
samples/bpf/syscall_tp_kern.c
samples/bpf/task_fd_query_kern.c
samples/bpf/tc_l2_redirect_kern.c
samples/bpf/tcbpf1_kern.c
samples/bpf/tcp_basertt_kern.c
samples/bpf/tcp_bufs_kern.c
samples/bpf/tcp_clamp_kern.c
samples/bpf/tcp_cong_kern.c
samples/bpf/tcp_dumpstats_kern.c
samples/bpf/tcp_iw_kern.c
samples/bpf/tcp_rwnd_kern.c
samples/bpf/tcp_synrto_kern.c
samples/bpf/tcp_tos_reflect_kern.c
samples/bpf/test_cgrp2_tc_kern.c
samples/bpf/test_current_task_under_cgroup_kern.c
samples/bpf/test_map_in_map_kern.c
samples/bpf/test_overhead_kprobe_kern.c
samples/bpf/test_overhead_raw_tp_kern.c
samples/bpf/test_overhead_tp_kern.c
samples/bpf/test_probe_write_user_kern.c
samples/bpf/trace_event_kern.c
samples/bpf/trace_output_kern.c
samples/bpf/tracex1_kern.c
samples/bpf/tracex2_kern.c
samples/bpf/tracex3_kern.c
samples/bpf/tracex4_kern.c
samples/bpf/tracex5_kern.c
samples/bpf/tracex6_kern.c
samples/bpf/tracex7_kern.c
samples/bpf/xdp1_kern.c
samples/bpf/xdp2_kern.c
samples/bpf/xdp2skb_meta_kern.c
samples/bpf/xdp_adjust_tail_kern.c
samples/bpf/xdp_fwd_kern.c
samples/bpf/xdp_monitor_kern.c
samples/bpf/xdp_redirect_cpu_kern.c
samples/bpf/xdp_redirect_kern.c
samples/bpf/xdp_redirect_map_kern.c
samples/bpf/xdp_router_ipv4_kern.c
samples/bpf/xdp_rxq_info_kern.c
samples/bpf/xdp_sample_pkts_kern.c
samples/bpf/xdp_tx_iptunnel_kern.c
samples/bpf/xdpsock_kern.c
tools/bpf/bpftool/skeleton/pid_iter.bpf.c
tools/bpf/bpftool/skeleton/profiler.bpf.c
tools/bpf/runqslower/runqslower.bpf.c
tools/testing/selftests/bpf/progs/atomic_bounds.c
tools/testing/selftests/bpf/progs/atomics.c
tools/testing/selftests/bpf/progs/bind4_prog.c
tools/testing/selftests/bpf/progs/bind6_prog.c
tools/testing/selftests/bpf/progs/bind_perm.c
tools/testing/selftests/bpf/progs/bpf_cubic.c
tools/testing/selftests/bpf/progs/bpf_dctcp.c
tools/testing/selftests/bpf/progs/bpf_flow.c
tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c
tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c
tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
tools/testing/selftests/bpf/progs/bpf_iter_task.c
tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
tools/testing/selftests/bpf/progs/bpf_iter_test_kern1.c
tools/testing/selftests/bpf/progs/bpf_iter_test_kern2.c
tools/testing/selftests/bpf/progs/bpf_iter_test_kern3.c
tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c
tools/testing/selftests/bpf/progs/bpf_iter_test_kern5.c
tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
tools/testing/selftests/bpf/progs/bprm_opts.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___diff_arr_dim.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___diff_arr_val_sz.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___equiv_zero_sz_arr.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_zero_sz_arr.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_non_array.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_too_shallow.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_too_small.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_wrong_val_type.c
tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___fixed_arr.c
tools/testing/selftests/bpf/progs/btf__core_reloc_bitfields.c
tools/testing/selftests/bpf/progs/btf__core_reloc_bitfields___bit_sz_change.c
tools/testing/selftests/bpf/progs/btf__core_reloc_bitfields___bitfield_vs_int.c
tools/testing/selftests/bpf/progs/btf__core_reloc_bitfields___err_too_big_bitfield.c
tools/testing/selftests/bpf/progs/btf__core_reloc_bitfields___just_big_enough.c
tools/testing/selftests/bpf/progs/btf__core_reloc_enumval.c
tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___diff.c
tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___err_missing.c
tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___val3_missing.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence___err_wrong_arr_kind.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence___err_wrong_arr_value_type.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence___err_wrong_int_kind.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence___err_wrong_int_sz.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence___err_wrong_int_type.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence___err_wrong_struct_type.c
tools/testing/selftests/bpf/progs/btf__core_reloc_existence___minimal.c
tools/testing/selftests/bpf/progs/btf__core_reloc_flavors.c
tools/testing/selftests/bpf/progs/btf__core_reloc_flavors__err_wrong_name.c
tools/testing/selftests/bpf/progs/btf__core_reloc_ints.c
tools/testing/selftests/bpf/progs/btf__core_reloc_ints___bool.c
tools/testing/selftests/bpf/progs/btf__core_reloc_ints___reverse_sign.c
tools/testing/selftests/bpf/progs/btf__core_reloc_misc.c
tools/testing/selftests/bpf/progs/btf__core_reloc_mods.c
tools/testing/selftests/bpf/progs/btf__core_reloc_mods___mod_swap.c
tools/testing/selftests/bpf/progs/btf__core_reloc_mods___typedefs.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___anon_embed.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___dup_compat_types.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_array_container.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_array_field.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_dup_incompat_types.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_missing_container.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_missing_field.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_nonstruct_container.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_partial_match_dups.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___err_too_deep.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___extra_nesting.c
tools/testing/selftests/bpf/progs/btf__core_reloc_nesting___struct_union_mixup.c
tools/testing/selftests/bpf/progs/btf__core_reloc_primitives.c
tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___diff_enum_def.c
tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___diff_func_proto.c
tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___diff_ptr_type.c
tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___err_non_enum.c
tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___err_non_int.c
tools/testing/selftests/bpf/progs/btf__core_reloc_primitives___err_non_ptr.c
tools/testing/selftests/bpf/progs/btf__core_reloc_ptr_as_arr.c
tools/testing/selftests/bpf/progs/btf__core_reloc_ptr_as_arr___diff_sz.c
tools/testing/selftests/bpf/progs/btf__core_reloc_size.c
tools/testing/selftests/bpf/progs/btf__core_reloc_size___diff_sz.c
tools/testing/selftests/bpf/progs/btf__core_reloc_size___err_ambiguous.c
tools/testing/selftests/bpf/progs/btf__core_reloc_type_based.c
tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___all_missing.c
tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___diff_sz.c
tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___fn_wrong_args.c
tools/testing/selftests/bpf/progs/btf__core_reloc_type_based___incompat.c
tools/testing/selftests/bpf/progs/btf__core_reloc_type_id.c
tools/testing/selftests/bpf/progs/btf__core_reloc_type_id___missing_targets.c
tools/testing/selftests/bpf/progs/btf_data.c
tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c
tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
tools/testing/selftests/bpf/progs/btf_dump_test_case_ordering.c
tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
tools/testing/selftests/bpf/progs/cg_storage_multi_egress_only.c
tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c
tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
tools/testing/selftests/bpf/progs/connect4_prog.c
tools/testing/selftests/bpf/progs/connect6_prog.c
tools/testing/selftests/bpf/progs/connect_force_port4.c
tools/testing/selftests/bpf/progs/connect_force_port6.c
tools/testing/selftests/bpf/progs/dev_cgroup.c
tools/testing/selftests/bpf/progs/fentry_test.c
tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
tools/testing/selftests/bpf/progs/fexit_bpf2bpf_simple.c
tools/testing/selftests/bpf/progs/fexit_test.c
tools/testing/selftests/bpf/progs/fmod_ret_freplace.c
tools/testing/selftests/bpf/progs/freplace_attach_probe.c
tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
tools/testing/selftests/bpf/progs/freplace_connect4.c
tools/testing/selftests/bpf/progs/freplace_connect_v4_prog.c
tools/testing/selftests/bpf/progs/freplace_get_constant.c
tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
tools/testing/selftests/bpf/progs/ima.c
tools/testing/selftests/bpf/progs/kfree_skb.c
tools/testing/selftests/bpf/progs/load_bytes_relative.c
tools/testing/selftests/bpf/progs/local_storage.c
tools/testing/selftests/bpf/progs/loop1.c
tools/testing/selftests/bpf/progs/loop2.c
tools/testing/selftests/bpf/progs/loop3.c
tools/testing/selftests/bpf/progs/loop4.c
tools/testing/selftests/bpf/progs/loop5.c
tools/testing/selftests/bpf/progs/lsm.c
tools/testing/selftests/bpf/progs/map_ptr_kern.c
tools/testing/selftests/bpf/progs/metadata_unused.c
tools/testing/selftests/bpf/progs/metadata_used.c
tools/testing/selftests/bpf/progs/modify_return.c
tools/testing/selftests/bpf/progs/netcnt_prog.c
tools/testing/selftests/bpf/progs/netif_receive_skb.c
tools/testing/selftests/bpf/progs/perf_event_stackmap.c
tools/testing/selftests/bpf/progs/perfbuf_bench.c
tools/testing/selftests/bpf/progs/profiler1.c
tools/testing/selftests/bpf/progs/profiler2.c
tools/testing/selftests/bpf/progs/profiler3.c
tools/testing/selftests/bpf/progs/pyperf100.c
tools/testing/selftests/bpf/progs/pyperf180.c
tools/testing/selftests/bpf/progs/pyperf50.c
tools/testing/selftests/bpf/progs/pyperf600.c
tools/testing/selftests/bpf/progs/pyperf600_nounroll.c
tools/testing/selftests/bpf/progs/pyperf_global.c
tools/testing/selftests/bpf/progs/pyperf_subprogs.c
tools/testing/selftests/bpf/progs/recvmsg4_prog.c
tools/testing/selftests/bpf/progs/recvmsg6_prog.c
tools/testing/selftests/bpf/progs/ringbuf_bench.c
tools/testing/selftests/bpf/progs/sample_map_ret0.c
tools/testing/selftests/bpf/progs/sample_ret0.c
tools/testing/selftests/bpf/progs/sendmsg4_prog.c
tools/testing/selftests/bpf/progs/sendmsg6_prog.c
tools/testing/selftests/bpf/progs/skb_pkt_end.c
tools/testing/selftests/bpf/progs/socket_cookie_prog.c
tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
tools/testing/selftests/bpf/progs/sockmap_tcp_msg_prog.c
tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
tools/testing/selftests/bpf/progs/sockopt_inherit.c
tools/testing/selftests/bpf/progs/sockopt_multi.c
tools/testing/selftests/bpf/progs/sockopt_sk.c
tools/testing/selftests/bpf/progs/strobemeta.c
tools/testing/selftests/bpf/progs/strobemeta_nounroll1.c
tools/testing/selftests/bpf/progs/strobemeta_nounroll2.c
tools/testing/selftests/bpf/progs/strobemeta_subprogs.c
tools/testing/selftests/bpf/progs/tailcall1.c
tools/testing/selftests/bpf/progs/tailcall2.c
tools/testing/selftests/bpf/progs/tailcall3.c
tools/testing/selftests/bpf/progs/tailcall4.c
tools/testing/selftests/bpf/progs/tailcall5.c
tools/testing/selftests/bpf/progs/tailcall_bpf2bpf1.c
tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
tools/testing/selftests/bpf/progs/tcp_rtt.c
tools/testing/selftests/bpf/progs/test_attach_probe.c
tools/testing/selftests/bpf/progs/test_autoload.c
tools/testing/selftests/bpf/progs/test_btf_haskv.c
tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
tools/testing/selftests/bpf/progs/test_btf_newkv.c
tools/testing/selftests/bpf/progs/test_btf_nokv.c
tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
tools/testing/selftests/bpf/progs/test_cgroup_link.c
tools/testing/selftests/bpf/progs/test_cls_redirect.c
tools/testing/selftests/bpf/progs/test_cls_redirect_subprogs.c
tools/testing/selftests/bpf/progs/test_core_autosize.c
tools/testing/selftests/bpf/progs/test_core_extern.c
tools/testing/selftests/bpf/progs/test_core_read_macros.c
tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
tools/testing/selftests/bpf/progs/test_core_reloc_bitfields_direct.c
tools/testing/selftests/bpf/progs/test_core_reloc_bitfields_probed.c
tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
tools/testing/selftests/bpf/progs/test_core_reloc_existence.c
tools/testing/selftests/bpf/progs/test_core_reloc_flavors.c
tools/testing/selftests/bpf/progs/test_core_reloc_ints.c
tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
tools/testing/selftests/bpf/progs/test_core_reloc_misc.c
tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
tools/testing/selftests/bpf/progs/test_core_reloc_module.c
tools/testing/selftests/bpf/progs/test_core_reloc_nesting.c
tools/testing/selftests/bpf/progs/test_core_reloc_primitives.c
tools/testing/selftests/bpf/progs/test_core_reloc_ptr_as_arr.c
tools/testing/selftests/bpf/progs/test_core_reloc_size.c
tools/testing/selftests/bpf/progs/test_core_reloc_type_based.c
tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c
tools/testing/selftests/bpf/progs/test_core_retro.c
tools/testing/selftests/bpf/progs/test_d_path.c
tools/testing/selftests/bpf/progs/test_enable_stats.c
tools/testing/selftests/bpf/progs/test_endian.c
tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c
tools/testing/selftests/bpf/progs/test_get_stack_rawtp_err.c
tools/testing/selftests/bpf/progs/test_global_data.c
tools/testing/selftests/bpf/progs/test_global_func1.c
tools/testing/selftests/bpf/progs/test_global_func2.c
tools/testing/selftests/bpf/progs/test_global_func3.c
tools/testing/selftests/bpf/progs/test_global_func4.c
tools/testing/selftests/bpf/progs/test_global_func5.c
tools/testing/selftests/bpf/progs/test_global_func6.c
tools/testing/selftests/bpf/progs/test_global_func7.c
tools/testing/selftests/bpf/progs/test_global_func8.c
tools/testing/selftests/bpf/progs/test_hash_large_key.c
tools/testing/selftests/bpf/progs/test_ksyms.c
tools/testing/selftests/bpf/progs/test_ksyms_btf.c
tools/testing/selftests/bpf/progs/test_ksyms_btf_null_check.c
tools/testing/selftests/bpf/progs/test_ksyms_module.c
tools/testing/selftests/bpf/progs/test_l4lb.c
tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
tools/testing/selftests/bpf/progs/test_link_pinning.c
tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
tools/testing/selftests/bpf/progs/test_map_in_map.c
tools/testing/selftests/bpf/progs/test_map_init.c
tools/testing/selftests/bpf/progs/test_map_lock.c
tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
tools/testing/selftests/bpf/progs/test_mmap.c
tools/testing/selftests/bpf/progs/test_module_attach.c
tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
tools/testing/selftests/bpf/progs/test_obj_id.c
tools/testing/selftests/bpf/progs/test_overhead.c
tools/testing/selftests/bpf/progs/test_pe_preserve_elems.c
tools/testing/selftests/bpf/progs/test_perf_branches.c
tools/testing/selftests/bpf/progs/test_perf_buffer.c
tools/testing/selftests/bpf/progs/test_pinning.c
tools/testing/selftests/bpf/progs/test_pinning_invalid.c
tools/testing/selftests/bpf/progs/test_pkt_access.c
tools/testing/selftests/bpf/progs/test_pkt_md_access.c
tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
tools/testing/selftests/bpf/progs/test_probe_user.c
tools/testing/selftests/bpf/progs/test_queue_map.c
tools/testing/selftests/bpf/progs/test_raw_tp_test_run.c
tools/testing/selftests/bpf/progs/test_rdonly_maps.c
tools/testing/selftests/bpf/progs/test_ringbuf.c
tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
tools/testing/selftests/bpf/progs/test_seg6_loop.c
tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
tools/testing/selftests/bpf/progs/test_send_signal_kern.c
tools/testing/selftests/bpf/progs/test_sk_assign.c
tools/testing/selftests/bpf/progs/test_sk_lookup.c
tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
tools/testing/selftests/bpf/progs/test_sk_storage_trace_itself.c
tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
tools/testing/selftests/bpf/progs/test_skb_ctx.c
tools/testing/selftests/bpf/progs/test_skb_helpers.c
tools/testing/selftests/bpf/progs/test_skeleton.c
tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
tools/testing/selftests/bpf/progs/test_sock_fields.c
tools/testing/selftests/bpf/progs/test_sockhash_kern.c
tools/testing/selftests/bpf/progs/test_sockmap_invalid_update.c
tools/testing/selftests/bpf/progs/test_sockmap_kern.c
tools/testing/selftests/bpf/progs/test_sockmap_listen.c
tools/testing/selftests/bpf/progs/test_sockmap_update.c
tools/testing/selftests/bpf/progs/test_spin_lock.c
tools/testing/selftests/bpf/progs/test_stack_map.c
tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
tools/testing/selftests/bpf/progs/test_stacktrace_map.c
tools/testing/selftests/bpf/progs/test_subprogs.c
tools/testing/selftests/bpf/progs/test_subprogs_unused.c
tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
tools/testing/selftests/bpf/progs/test_sysctl_prog.c
tools/testing/selftests/bpf/progs/test_tc_edt.c
tools/testing/selftests/bpf/progs/test_tc_neigh.c
tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
tools/testing/selftests/bpf/progs/test_tc_peer.c
tools/testing/selftests/bpf/progs/test_tc_tunnel.c
tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
tools/testing/selftests/bpf/progs/test_tcp_estats.c
tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
tools/testing/selftests/bpf/progs/test_trace_ext.c
tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c
tools/testing/selftests/bpf/progs/test_tracepoint.c
tools/testing/selftests/bpf/progs/test_trampoline_count.c
tools/testing/selftests/bpf/progs/test_tunnel_kern.c
tools/testing/selftests/bpf/progs/test_varlen.c
tools/testing/selftests/bpf/progs/test_verif_scale1.c
tools/testing/selftests/bpf/progs/test_verif_scale2.c
tools/testing/selftests/bpf/progs/test_verif_scale3.c
tools/testing/selftests/bpf/progs/test_vmlinux.c
tools/testing/selftests/bpf/progs/test_xdp.c
tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
tools/testing/selftests/bpf/progs/test_xdp_link.c
tools/testing/selftests/bpf/progs/test_xdp_loop.c
tools/testing/selftests/bpf/progs/test_xdp_meta.c
tools/testing/selftests/bpf/progs/test_xdp_noinline.c
tools/testing/selftests/bpf/progs/test_xdp_redirect.c
tools/testing/selftests/bpf/progs/test_xdp_vlan.c
tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
tools/testing/selftests/bpf/progs/trace_printk.c
tools/testing/selftests/bpf/progs/trigger_bench.c
tools/testing/selftests/bpf/progs/udp_limit.c
tools/testing/selftests/bpf/progs/xdp_dummy.c
tools/testing/selftests/bpf/progs/xdp_redirect_map.c
tools/testing/selftests/bpf/progs/xdp_tx.c
tools/testing/selftests/bpf/progs/xdping_kern.c
$ 


