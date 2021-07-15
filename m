Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2683C98B2
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhGOGPK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 02:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhGOGPK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 02:15:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E01C06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 23:12:18 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h6so5143486iok.6
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 23:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oW7Xv/O7UWqMynCKzoi0z86ZCtp38NcOhyTidi4CqGQ=;
        b=Yg1GOj66ou6kZO3H8TuGb97Rd3Qm+C0BZ+N6ehwuecyXNC3tB7joKc47wsPdMZ0Ros
         9gMocYROvrWiwf0DPsWhe1vwY0ML6qJ8gJ/1DWiAXeV4AmZXQjRt3UOh4XhzqLXbn/Z5
         Ui2TkSSq/ghRTV/GPrAvOtP59gPsKkTij7eZ7B+1u7+Szw/rnX9F/LoTKwmxigf90T0A
         rGjlw6wSdcl5Hmpi+Hu5SKdw0jXH7qmJEit2bfrNxYIrZLnlY8lFGW3IIkpJtCgbnFsL
         xHNZSzwvHxU8ZK+96aB7dIEfZeIoGWkt7jXcgL7MKJD8nWY8/nm6jCrvaqWZUq5k9b0A
         647A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oW7Xv/O7UWqMynCKzoi0z86ZCtp38NcOhyTidi4CqGQ=;
        b=aoVEh4SHPnzzVeuNEoeDULulbAaIEQ1UiIrm2Rt7torhlW+50d7L//owgaavdNLutg
         YJ/LIiHsyZ8nzv+1+/z61KTEulaUrCofL6HxLEV92+ZjBkFo5nZuy4joR9xrhXfxfjXL
         JsG3VMdvRqBfAN4BlU0Tbp+/Zd7O548WSoGw1k9jVQtBw6bz3x5HtT8X5zK+BQIZiiiz
         9PUwEiY2MjXPIMJkO2bvD6Lwpmzz0v2vX2COM8aHTjwadTDwxiaiYumaRLLQOOUzQDFC
         1ndxgWvP4ljM/9O5PMhbprqXCQ1Qci5A9Foo7qB/dSpi9JcA7WzDN6BF2HsdeeM79tsN
         3WTQ==
X-Gm-Message-State: AOAM533Y8EPtl2onLqfqc7rVpF+EsQYr49sMmGg9JHj6SKxVR/xOKOCL
        tXa31KelxwNY+3dCi6hrCffk63pAbogguXdlFbX5oR9HYEE=
X-Google-Smtp-Source: ABdhPJxTQdEMYvgEDM9uUWrVJzsUjuAcyYCJba4mrmlGdUBQC5pe9ezXA0ZTwsHQ9S4OIzAdhOkvMdyN7TvOhTgsu6s=
X-Received: by 2002:a5d:9958:: with SMTP id v24mr1902414ios.4.1626329537696;
 Wed, 14 Jul 2021 23:12:17 -0700 (PDT)
MIME-Version: 1.0
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Wed, 14 Jul 2021 23:12:08 -0700
Message-ID: <CAPGftE-EhKHK3D10+X0xfoG139Y2EnuohfAGZZi+SH1Bd0-jAw@mail.gmail.com>
Subject: Verifier bug on MIPS32/Kernel 5.13.1, test_verifier "access skb
 fields ok"
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Daniel, Alexei, Andrii,

While testing my MIPS32 BPF JIT implementation, I encountered the
following verifier log message:
     "verifier bug. zext_dst is set, but no reg is defined"

Hopefully the details below will be helpful to you, but let me know if
more is needed.

Thanks,
Tony

===============================

root@OpenWrt:~# uname -a
Linux OpenWrt 5.13.1 #0 SMP Thu Jul 8 00:12:04 2021 mips GNU/Linux
root@OpenWrt:~# sysctl net.core.bpf_jit_enable=1
net.core.bpf_jit_enable = 1
root@OpenWrt:~# ./test_verifier_eb -v 277 277
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2652 at kernel/bpf/verifier.c:11826 bpf_check+0x1b48/0x27d4
[  153.342806] Modules linked in: pppoe ppp_async pppox ppp_generic
iptable_nat ipt_REJECT xt_time xt_tcpudp xt_tcpmss xt_statistic
xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit
xt_length xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connmark
xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT
xt_MASQUERADE xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY
slhc sch_mqprio sch_cake pcnet32 nf_reject_ipv4 nf_nat nf_log_syslog
nf_flow_table nf_conntrack_netlink nf_conncount iptable_raw
iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt cls_flower
act_vlan pktgen sch_teql sch_sfq sch_red sch_prio sch_pie sch_multiq
sch_gred sch_fq sch_dsmark sch_codel em_text em_nbyte em_meta em_cmp
act_simple act_police act_pedit act_ipt act_csum libcrc32c em_ipset
cls_bpf act_bpf act_ctinfo act_connmark nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32
cls_tcindex cls_route cls_matchall cls_fw cls_flow cls_basic
act_skbedit
[  153.344320]  act_mirred act_gact xt_set ip_set_list_set
ip_set_hash_netportnet ip_set_hash_netport ip_set_hash_netnet
ip_set_hash_netiface ip_set_hash_net ip_set_hash_mac
ip_set_hash_ipportnet ip_set_hash_ipportip ip_set_hash_ipport
ip_set_hash_ipmark ip_set_hash_ip ip_set_bitmap_port
ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set nfnetlink ip6table_mangle
ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ifb
dummy netlink_diag mii
CPU: 0 PID: 2652 Comm: test_verifier_e Tainted: G        W         5.13.1 #0
Stack : 00000001 c1544000 83466000 80192454 809a0000 00000004 00000000 00000000
        8374bb94 80d40000 82a1a484 80c1d5cb 80959230 00000001 8374bb38 8288c780
        00000000 00000000 80959230 8374b9d0 ffffefff 80c89c34 00000000 00000000
        00000000 d6730959 00000000 00055d61 00000001 80cc0000 00000000 80960000
        00000009 00002e32 00000001 c1544000 00000018 80603e88 00000000 80d40000
        ...
Call Trace:
[<80108cd0>] show_stack+0x28/0xf0
[<80590740>] dump_stack+0xa4/0xe0
[<80137298>] __warn+0xdc/0x110
[<80137328>] warn_slowpath_fmt+0x5c/0xac
[<802558ac>] bpf_check+0x1b48/0x27d4
[<80239e28>] bpf_prog_load+0x5a8/0xa4c
[<8023c2c0>] __do_sys_bpf+0x3e0/0x20b8
[<80114490>] syscall_common+0x34/0x58

---[ end trace 96a5d750c3c76985 ]---
#277/u access skb fields ok FAIL
Failed to load prog 'Bad address'!
verifier bug. zext_dst is set, but no reg is defined
processed 46 insns (limit 1000000) max_states_per_insn 0 total_states
5 peak_states 5 mark_read 2
#277/p access skb fields ok , verifier log:
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1
OK
Summary: 1 PASSED, 0 SKIPPED, 1 FAILED
