Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708DE3A391B
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 03:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhFKBF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 21:05:58 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:37533 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFKBF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 21:05:58 -0400
Received: by mail-il1-f180.google.com with SMTP id x12so939684ill.4;
        Thu, 10 Jun 2021 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=K7DaILgqtgP5krevggcBANwquhJeuuQ+thvz3Q7pb/s=;
        b=upZzhomL/NPCPG1zE2RbMNJCw7p3OgDo2BrTwv9XBrXyR5hHXk/hEDqThLMQZKOfgS
         fgMqAyQER83ilexMYL9tztKW13dlSKDKDdg3NaW7r8eDU8nlX0j+0MVN1yIwC0SbHdbA
         W6jDx5+a173s3wHm09YWV3ezFIYCf9+Zcl3JMMwXSB+EhS6w4uBf0tqqy3eLTKHb1WSm
         SorVeLfUBHY1UYR8cxgl0/FlElnx5Rdeu0M7Tf7G3QcGKUdfbpey1N7L0RP3xe3hgQ0f
         hYHndfGucYPrciYkXcBlx5MUbq3gSjo5vp+NEQ2IrbYvkGPLqYrwFpjsr6glrRB7MOJe
         Ghqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=K7DaILgqtgP5krevggcBANwquhJeuuQ+thvz3Q7pb/s=;
        b=g+BWzMX1vqWqA2MGffkRza9kXqvJuPNzJObvm8QPun+ZicLn8Gm8ehJfs4ONFi23kL
         k9ISk9M+ClWaG7hn+LX4cLWJjEDciPnc6U3wcumC/kKItv5LRzsTFJWwIbLhtO/+qL/4
         Y3YZUetDieUWEMgpEHdxHWB8PP0dJmykNivJAaMdgMGFbSn29Lcc+F8TvVM0YELd0oFz
         2yb8t/8K0tj9Xe+pgHQgmfAv+pXbxTq0vbknuehc6M39lj7dfIRT9ffDVT75lrTinhKV
         mNLYkjXYDuUzy6btAirP1MCDcZVUAIdAG3/+aPPQNBeOXnMtuv6ANk0vI9jXOPQA0pHb
         OyGg==
X-Gm-Message-State: AOAM531I9NuKCMyHPOlWN7Ik1Ngx3vUXH/sh+GGHgkrWAnku5eOlzghy
        nmR9fwz/8WiM2ssxVjJiFF7PgG6qPwjVkSwvJdccxnToSso=
X-Google-Smtp-Source: ABdhPJzMi9Sv0J3PTPDnsP5KIfDlKRJtmgglT7XSPUhBXlbD3nnRedlWeovgU1iDd3nrV3n2wZi8QobYyXONHwfz3mc=
X-Received: by 2002:a05:6e02:12ef:: with SMTP id l15mr1199816iln.153.1623373381271;
 Thu, 10 Jun 2021 18:03:01 -0700 (PDT)
MIME-Version: 1.0
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Thu, 10 Jun 2021 18:02:54 -0700
Message-ID: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
Subject: Kernel Oops in test_verifier "#828/p reference tracking: bpf_sk_release(btf_tcp_sock)"
To:     bpf <bpf@vger.kernel.org>, linux-mips@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I encountered an NPE and kernel Oops [1] while running the
'test_verifier' selftest on MIPS32 with LTS kernel 5.10.41. This was
observed during development of a MIPS32 JIT but is verifier-related.

Initial troubleshooting [2] points to an unchecked NULL dereference in
btf_type_by_id(), with an unexpected BTF type ID. The root cause is
unclear, whether source of the ID or a potential underlying BTF
problem.

Has this been seen before? How best to debug this further or resolve?
What other details would be useful for BPF kernel developers?

Thanks for any help,
Tony

[1]:
(Host details)
kodidev:~/openwrt-project$ ./staging_dir/host/bin/pahole --version
v1.21

(Target details)
root@OpenWrt:/# uname -a
Linux OpenWrt 5.10.41 #0 SMP Tue Jun 1 00:54:31 2021 mips GNU/Linux

root@OpenWrt:~# sysctl net.core.bpf_jit_enable=0; ./test_verifier 826 828
net.core.bpf_jit_enable = 0

#826/p reference tracking: branch tracking valid pointer null comparison OK
#827/p reference tracking: branch tracking valid pointer value comparison OK
CPU 0 Unable to handle kernel paging request at virtual address
00000000, epc == 80244654, ra == 80244654
Oops[#1]:
CPU: 0 PID: 16274 Comm: test_verifier Not tainted 5.10.41 #0
$ 0   : 00000000 00000001 00000000 0000a8a2
$ 4   : 835ac580 a6280000 00000000 00000001
$ 8   : 835ac580 a6280000 00000000 02020202
$12   : 8348de58 834ba800 00000000 00000000
$16   : 835ac580 8098be2c fffffff3 834bdb38
$20   : 8098be0c 00000001 00000018 00000000
$24   : 00000000 01415415
$28   : 834bc000 834bdac8 00000005 80244654
Hi    : 00000017
Lo    : 0a3d70a2
epc   : 80244654 kernel_type_name+0x20/0x38
ra    : 80244654 kernel_type_name+0x20/0x38
Status: 1000a403 KERNEL EXL IE
Cause : 00800008 (ExcCode 02)
BadVA : 00000000
PrId  : 00019300 (MIPS 24Kc)
Modules linked in: pppoe ppp_async pppox ppp_generic mac80211_hwsim
mac80211 iptable_nat ipt_REJECT cfg80211 xt_time xt_tcpudp xt_tcpmss
xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac
xt_limit xt_length xt_hl xt_helper xt_ecn xt_dscp xt_conntrack
xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT
xt_MASQUERADE xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY
slhc sch_mqprio sch_cake pcnet32 nf_reject_ipv4 nf_nat nf_log_ipv4
nf_flow_table nf_conntrack_netlink nf_conncount iptable_raw
iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt compat
cls_flower act_vlan pktgen sch_teql sch_sfq sch_red sch_prio sch_pie
sch_multiq sch_gred sch_fq sch_dsmark sch_codel em_text em_nbyte
em_meta em_cmp act_simple act_police act_pedit act_ipt act_csum
libcrc32c em_ipset cls_bpf act_bpf act_ctinfo act_connmark
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sch_tbf sch_ingress sch_htb
sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_matchall cls_fw
 cls_flow cls_basic act_skbedit act_mirred act_gact xt_set
ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport
ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net
ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip
ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip
ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set
nfnetlink nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter
ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ifb dummy netlink_diag
mii
Process test_verifier (pid: 16274, threadinfo=c1418596, task=05765195,
tls=77e5aec8)
Stack : 83428000 83428000 8098be2c 00000000 83428000 8024af78 834bacdc 834bb000
        a98a0000 834e2580 834e2c00 00000000 834e2c00 8023da9c 834bb070 00000013
        80925164 80924f44 00000000 80925164 00000000 83428140 80bc3864 834bb070
        834e2c00 00000000 00000010 802c441c 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000056 00000000 00000000
        ...
Call Trace:
[<80244654>] kernel_type_name+0x20/0x38
[<8024af78>] check_helper_call+0x1c9c/0x1dbc
[<8024d008>] do_check_common+0x1f70/0x2a3c
[<8024fb6c>] bpf_check+0x18f8/0x2308
[<802369ec>] bpf_prog_load+0x378/0x860
[<80237e1c>] __do_sys_bpf+0x3e0/0x2100
[<801142d8>] syscall_common+0x34/0x58

Code: afbf0014  0c099b58  02002025 <8c450000> 8fbf0014  02002025
8fb00010  08099b4f  27bd0018

---[ end trace ab13ac5f89eb825b ]---
Kernel panic - not syncing: Fatal exception
Rebooting in 3 seconds..
QEMU: Terminated


[2]:
Function Code:
==============
const char *kernel_type_name(u32 id)
{
    return btf_name_by_offset(btf_vmlinux,
                  btf_type_by_id(btf_vmlinux, id)->name_off);
}

const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
{
    if (type_id > btf->nr_types)
        return NULL;

    return btf->types[type_id];
}

Disassembled Code:
==================
0x0000000000000000:  AF BF 00 14    sw    $ra, 0x14($sp)
0x0000000000000004:  0C 09 9B 58    jal   btf_type_by_id
0x0000000000000008:  02 00 20 25    move  $a0, $s0
0x000000000000000c:  8C 45 00 00    lw    $a1, ($v0)         <-- NPE
0x0000000000000010:  8F BF 00 14    lw    $ra, 0x14($sp)
0x0000000000000014:  02 00 20 25    move  $a0, $s0
0x0000000000000018:  8F B0 00 10    lw    $s0, 0x10($sp)
0x000000000000001c:  08 09 9B 4F    j     btf_name_by_offset
0x0000000000000020:  27 BD 00 18    addiu $sp, $sp, 0x18
