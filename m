Return-Path: <bpf+bounces-22444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2985E4E0
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508E92851E9
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78E83CDB;
	Wed, 21 Feb 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OdIktdCC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4A7BB00
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537645; cv=none; b=WCahuxtPPf/aF6TYvlW3AqAWAyLBds05FtZGr4tniaITHhIT2NwOVdGT79KW3BL+AiXZ7nAQw/N9nojYlAKgfgLmLOPKlYjF/3kdVf9BpKHpo35m8DIR7iAGH8yzEFnLz425+ndhMV/k2GurubiKo5nm3D1H2qIPeauvQ4Uw2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537645; c=relaxed/simple;
	bh=W4qzXN2bMRRxEg+BItkXQzkH5s/S0s/5dVKsqssdOTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2nb0oxHpXD6zZrNJSmNGrlJViGIjcG5NKGhv80uQoOD5EkvaUMuNEFl50VPffyh9ZjYps3Ks4GV+La4O+Jo5TO22S8KoFt0syCVHwBbeyF0FG9xXM6VUfQBaOH1NFm2gBCKQ50aX7r7vFZrNlp9XUWSEG2lkiZQRySTPIDQHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OdIktdCC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dca1efad59so6385405a12.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1708537642; x=1709142442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knmRt8zF+IHMrS4DHhINLfJam0yrQKa7kibv/XKNbR8=;
        b=OdIktdCCVq8uuLki+sOI5BKmu4V28xEZhyr5MXYdlzGxFWs4ovkRgPr/AQ/KI+NBGW
         nqanE5YmbzHCXBCepWGCe6l2AX/Ukv4CFClCapt3DGsxk+mmfhiNMXEtuHRI3yr++Vi8
         5UMRLC6y4m/KNw9KDVAcwKSOxCnTAx3hI0xuiB/N7I/meWyGnT8RdIb/blEaDddgS9Zn
         38uAYxyw2e0/4YImBtWZbm46vDHPtWL61WQJkew7hBDiFqlJPgRzSdBuvjvDVhC0nxnt
         hjVWvLn2VqYmGq7arA2eWkFR4e0uzdli4bRXw0Fwiwj51lo0s5BoFCCgcyVTEXacCwi/
         7dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537642; x=1709142442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knmRt8zF+IHMrS4DHhINLfJam0yrQKa7kibv/XKNbR8=;
        b=FDEMXeEXyj3P1vHQFE2mGUPYY2EpjIJQQBo6oknRsh1QyL3J/skbDN/1ugf4JhTM+V
         sHrQzn9kSMT9Iqe8/mzWHZC56LI4yaeWWOizI8Sl51GFfTUGNeQMboEfmisVjgkUFlGy
         hZXYUmDFemF9eFffNSc9tZSHS7XuqQWPtfe+as6ebZYdIGgoD3pNJfv1FJEAuiZgFI4e
         eLmHXK3YZjg7BeApQrwl9HSNvoP/1E95x5vmRqsOHTOXsBlIX9Wao7HudIP+XYhtzJA+
         5OAJteZvHULV8nL4iRaN/K1O1YdgWu7THuAloskauY/TWf3JCWpdvaxiFAqBk7t7cr5S
         PGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVU5Z5gDT7WqNiyspn9IEGcXp6+JizaimsCuMbfdXbye5qNvVjCTXKlkhLcMopTy5gHik+LQnH7Tb/YPrCl5B6h8Xx
X-Gm-Message-State: AOJu0Ywu5hTHrepE5I5wvnvcrrYw9QiED1cwpakdZ5mtxkupjTFsvVL7
	HJgfMRmK+4cuO6Ej70bjYAmyFeV8rkdhwpahA7kQ6+YgponyqrRXA8sissoEIcjnChRIA0pQL+E
	I9vzJhabPnfwwKbjJYPIs8N+Tw62N9UClLV1pPQ==
X-Google-Smtp-Source: AGHT+IGEgbeDclv8pyXq9AUXDZOMp7kTenCrLwUpVjDCyBGL7KevgnwuCtrbgNcTwWwo5CFHD3nHt6ULq2ZRlNTFXTE=
X-Received: by 2002:a05:6a21:3941:b0:1a0:885e:9706 with SMTP id
 ac1-20020a056a21394100b001a0885e9706mr15081810pzc.18.1708537642359; Wed, 21
 Feb 2024 09:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian> <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
 <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
 <CAADnVQ+EL71GN6z3RnSBX5jfCmD9f5T9WN=sr_k+JmZzOOLqPg@mail.gmail.com>
 <CAP01T74t_w0sDaDV5zf3RsZNQg0Hz1XEYw2myOML0L=6afCjsg@mail.gmail.com>
 <CAADnVQLgC8wc5v8sSt=ZxAqLhwoPWXcwwLpSQwKAgaWvuuhF_g@mail.gmail.com>
 <CAO3-Pbp2idpgEcf7ynvx_ucoDXKPVupWctMk1nZ0i_3zPoOTEw@mail.gmail.com> <CAP01T77KHwS8bmcXfYXn1OmdAXdrSz_sXooUZ5jAa7vSk=HmnQ@mail.gmail.com>
In-Reply-To: <CAP01T77KHwS8bmcXfYXn1OmdAXdrSz_sXooUZ5jAa7vSk=HmnQ@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 21 Feb 2024 17:47:10 +0000
Message-ID: <CALrw=nEqQXZBwed+W-U-wrS2mFy+f=4v1R+4eFPdQzFKx6PGew@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yan Zhai <yan@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:34=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 13 Feb 2024 at 01:21, Yan Zhai <yan@cloudflare.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 5:52=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 3:42=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Tue, 13 Feb 2024 at 00:34, Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 12, 2024 at 3:16=E2=80=AFPM Ignat Korchagin <ignat@cl=
oudflare.com> wrote:
> > > > > >
> > > > > > [288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not =
tainted
> > > > > > 6.6.16+ #10
> > > > >
> > > > > ...
> > > > > > [288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
> > > > > > [288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
> > > > > >
> > > > > > And Jakub CCed here did it for 6.8.0-rc2+
> > > > >
> > > > > I suspect something is broken in your kernels.
> > > > > Above is doing generic copy_from_kernel_nofault(),
> > > > > so one should be able to crash the kernel without any bpf.
> > > > >
> > > > > We have this in selftests/bpf:
> > > > > __weak noinline struct file *bpf_testmod_return_ptr(int arg)
> > > > > {
> > > > >         static struct file f =3D {};
> > > > >
> > > > >         switch (arg) {
> > > > >         case 1: return (void *)EINVAL;          /* user addr */
> > > > >         case 2: return (void *)0xcafe4a11;      /* user addr */
> > > > >         case 3: return (void *)-EINVAL;         /* canonical, but=
 invalid */
> > > > >         case 4: return (void *)(1ull << 60);    /* non-canonical =
and invalid */
> > > > >         case 5: return (void *)~(1ull << 30);   /* trigger extabl=
e */
> > > > >         case 6: return &f;                      /* valid addr */
> > > > >         case 7: return (void *)((long)&f | 1);  /* kernel tricks =
*/
> > > > >         default: return NULL;
> > > > >         }
> > > > > }
> > > > > where we check that extables setup by JIT for bpf progs are worki=
ng correctly.
> > > > > You should see the kernel crashing when you just run bpf selftest=
s.
> > > >
> > > > I agree, this appears unrelated to BPF since it is happening when
> > > > using copy_from_kernel_nofault (which should be jumping to the Efau=
lt
> > > > label instead of the oops), but I think it's not specific to some
> > > > custom kernel. I can reproduce it on my dev machine on top of bpf-n=
ext
> > > > as well, and another machine with Ubuntu's generic 6.5 kernel for
> > > > 24.04. And I think Ignat tried it on the mainline 6.8-rc2 as well.
> > >
> > copy_from_kernel_nofault is called in Jakub's reproducer, but the
> > panic case in our production seems to be direct memory accessing
> > according to bpftool dumped jited code. Will faults from such
> > instructions also be caught correctly?
> >
>
> Yep, since faults in both cases end up in the page fault handler.
> Once the fix pointed out by Alexei is applied, it should address both sce=
narios.

Just as a follow up the patches do seem to help for x86, but we've
recently encountered a similar problem on arm64 (6.1.74 kernel):

[Wed Feb 21 12:06:33 2024] Unable to handle kernel access to user
memory outside uaccess routines at virtual address 00007fff9959b150
[Wed Feb 21 12:06:33 2024] Mem abort info:
[Wed Feb 21 12:06:33 2024]   ESR =3D 0x000000009600000f
[Wed Feb 21 12:06:33 2024]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[Wed Feb 21 12:06:33 2024]   SET =3D 0, FnV =3D 0
[Wed Feb 21 12:06:33 2024]   EA =3D 0, S1PTW =3D 0
[Wed Feb 21 12:06:33 2024]   FSC =3D 0x0f: level 3 permission fault
[Wed Feb 21 12:06:33 2024] Data abort info:
[Wed Feb 21 12:06:33 2024]   ISV =3D 0, ISS =3D 0x0000000f
[Wed Feb 21 12:06:33 2024]   CM =3D 0, WnR =3D 0
[Wed Feb 21 12:06:33 2024] user pgtable: 4k pages, 48-bit VAs,
pgdp=3D00000812b1f69000
[Wed Feb 21 12:06:33 2024] [00007fff9959b150] pgd=3D08000812b1f72003,
p4d=3D08000812b1f72003, pud=3D08000812b1ff2003, pmd=3D08000855b2eb4003,
pte=3D0068087760598fc3
[Wed Feb 21 12:06:33 2024] Internal error: Oops: 000000009600000f [#1] SMP
[Wed Feb 21 12:06:33 2024] Modules linked in: nft_compat xt_hashlimit
ip_set_hash_netport xt_length esp4 nf_conntrack_netlink zstd
zstd_compress zram zsmalloc xgene_edac dm_thin_pool dm_persistent_data
dm_bio_prison dm_bufio nft_fwd_netdev nf_dup_netdev xfrm_interface
xfrm6_tunnel mpls_gso mpls_iptunnel mpls_router sit nft_numgen nft_log
nft_limit dummy ipip tunnel4 xfrm_user xfrm_algo nft_ct iptable_raw
iptable_nat iptable_mangle ipt_REJECT nf_reject_ipv4 ip6table_security
xt_CT ip6table_raw xt_nat ip6table_nat nf_nat xt_TCPMSS xt_owner
xt_NFLOG xt_connbytes xt_connlabel xt_statistic xt_connmark
ip6table_mangle xt_limit xt_LOG nf_log_syslog xt_mark xt_tcpudp
xt_conntrack ip6t_REJECT nf_reject_ipv6 xt_multiport xt_set xt_tcpmss
xt_comment ip6table_filter ip6_tables iptable_filter nfnetlink_log
tcp_diag cls_bpf sch_ingress ip_gre gre geneve tun xt_bpf nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 fou6 fou ip_tunnel ip6_udp_tunnel
udp_tunnel ip6_tunnel tunnel6 veth nf_tables tcp_bbr sch_fq
[Wed Feb 21 12:06:33 2024]  ip_set_hash_ip ip_set_hash_net ip_set
nfnetlink udp_diag inet_diag raid0 md_mod dm_crypt trusted
asn1_encoder tee algif_skcipher af_alg 8021q garp mrp stp llc
nvme_fabrics crct10dif_ce ghash_ce acpi_ipmi mlx5_core sha2_ce
ipmi_ssif sha256_arm64 sha1_ce mlxfw ipmi_devintf arm_spe_pmu
tiny_power_button tls igb xhci_pci nvme psample nvme_core xhci_hcd
ipmi_msghandler i2c_algo_bit button i2c_designware_platform
i2c_designware_core cppc_cpufreq arm_dsu_pmu tpm_tis tpm_tis_core fuse
dm_mod dax efivarfs ip_tables x_tables bcmcrypt(O) aes_neon_bs
aes_neon_blk aes_ce_blk aes_ce_cipher [last unloaded: kheaders]
[Wed Feb 21 12:06:33 2024] CPU: 15 PID: 547138 Comm: nginx-ssl
Tainted: G           O       6.1.74-cloudflare-2024.1.14 #1
[Wed Feb 21 12:06:33 2024] Hardware name: GIGABYTE
[Wed Feb 21 12:06:33 2024] pstate: 20400009 (nzCv daif +PAN -UAO -TCO
-DIT -SSBS BTYPE=3D--)
[Wed Feb 21 12:06:33 2024] pc : 0xffff8000288c0674
[Wed Feb 21 12:06:33 2024] lr : 0xffff8000288c064c
[Wed Feb 21 12:06:33 2024] sp : ffff8000afdd3940
[Wed Feb 21 12:06:33 2024] x29: ffff8000afdd39d0 x28: ffff081142f99f80
x27: ffff8000afdd3940
[Wed Feb 21 12:06:33 2024] x26: 0000000000000000 x25: ffff8000afdd3990
x24: 0000000000000001
[Wed Feb 21 12:06:33 2024] x23: 000000002e4773f7 x22: ffff0800e7078300
x21: ffff08378b4c5180
[Wed Feb 21 12:06:33 2024] x20: 0000000000000000 x19: fffffbff5dc7d548
x18: 0000000000000000
[Wed Feb 21 12:06:33 2024] x17: 0000000000000000 x16: 0000000000000000
x15: ffff081b6e9e8196
[Wed Feb 21 12:06:33 2024] x14: 0000000000000000 x13: 0000000000000000
x12: 0000000000000000
[Wed Feb 21 12:06:33 2024] x11: 0000000000000000 x10: ffffda25e4cc90f0
x9 : ffffda25e4d71074
[Wed Feb 21 12:06:33 2024] x8 : ffff8000afdd3af8 x7 : 0000000000000000
x6 : 0000008124f0e5a3
[Wed Feb 21 12:06:33 2024] x5 : ffff80023c9cd000 x4 : 0000000000001000
x3 : 0000000000000008
[Wed Feb 21 12:06:33 2024] x2 : ffff081142f99f80 x1 : ffffda25e55e76a0
x0 : 00007fff9959a2d0
[Wed Feb 21 12:06:33 2024] Call trace:
[Wed Feb 21 12:06:33 2024]  0xffff8000288c0674
[Wed Feb 21 12:06:33 2024]  bpf_trace_run3+0xcc/0x148
[Wed Feb 21 12:06:34 2024]  __bpf_trace_kfree_skb+0x14/0x20
[Wed Feb 21 12:06:34 2024]  __traceiter_kfree_skb+0x50/0x78
[Wed Feb 21 12:06:34 2024]  kfree_skb_reason+0xa8/0x118
[Wed Feb 21 12:06:34 2024]  tcp_data_queue+0x9f8/0xe20
[Wed Feb 21 12:06:34 2024]  tcp_rcv_established+0x2b4/0x738
[Wed Feb 21 12:06:34 2024]  tcp_v4_do_rcv+0x194/0x2d8
[Wed Feb 21 12:06:34 2024]  __release_sock+0x90/0x138
[Wed Feb 21 12:06:34 2024]  release_sock+0x64/0x120
[Wed Feb 21 12:06:34 2024]  tcp_recvmsg+0x80/0x1c8
[Wed Feb 21 12:06:34 2024]  inet_recvmsg+0x50/0xf8
[Wed Feb 21 12:06:34 2024]  sock_read_iter+0xf4/0x128
[Wed Feb 21 12:06:34 2024]  vfs_read+0x27c/0x2b0
[Wed Feb 21 12:06:34 2024]  ksys_read+0xe4/0x108
[Wed Feb 21 12:06:34 2024]  __arm64_sys_read+0x24/0x38
[Wed Feb 21 12:06:34 2024]  invoke_syscall.constprop.0+0x58/0xf8
[Wed Feb 21 12:06:34 2024]  do_el0_svc+0x174/0x1a0
[Wed Feb 21 12:06:34 2024]  el0_svc+0x38/0xf0
[Wed Feb 21 12:06:34 2024]  el0t_64_sync_handler+0xbc/0x138
[Wed Feb 21 12:06:34 2024]  el0t_64_sync+0x18c/0x190
[Wed Feb 21 12:06:34 2024] Code: b94096c0 f9001360 f9400ac0 f9427c00 (f9474=
014)
[Wed Feb 21 12:06:34 2024] ---[ end trace 0000000000000000 ]---

Not sure if there's a similar fix for arm64 pending or is it some kind
more of a cross-platform problem

Ignat

> > Yan
> >
> > > Then it must be vsyscall address that this series are fixing:
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20240202103935.3=
154011-3-houtao@huaweicloud.com/
> > >
> > > We're still waiting on x86 maintainers to ack them.

