Return-Path: <bpf+bounces-21792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8C8521D1
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617EE1C226BF
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E474EB28;
	Mon, 12 Feb 2024 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQU0jM87"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740681EEFD
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778557; cv=none; b=tlrHzFJ7QMIP+NAo4aKoFlCEB/1EDdHactJa1oIA2vUTFqiWFj9BmvLSzAyoeB7t9Gjki84bl913NtB2fLtIj5gWIU9cUEt7g2VIzQS1Y6uwWGCOuxAeUe+IWZapJkg6upn+1T1hoddLHRlMGt6A+80aGjeDJzYLipE5OdrYswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778557; c=relaxed/simple;
	bh=JKwdLCPJLl/ip8LaFtTimCjjTNGANTZ2aTV+mxqbop0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGIBMOr6pgeiZ9jtwUuiI1EHAjukacFjVcEB0N2BkTWCG2KejtEebRMe7UU4t8iIKDQTQlS1Sof+JwFSzzV5xyEvdkQpSxFa6G4thhaek1qu8dU1acSbDiFMuCcb85T1pBOty5BlAQ9MePnhXSlC+xzGUEVsQnathRqh2FBhenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQU0jM87; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a389ea940f1so404594366b.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707778554; x=1708383354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GORlhjQxFavWSlHuDyYppgU5m7fuQu/BXbhmbwIyaj8=;
        b=dQU0jM87E/WX0dltQDvDpreJW3njaZ7WKBnvjq49up7pnZEXMHri+AIhUJNfhjmW+R
         o4/+ffXjHR+rTR+SvTIKPD27KpQzmuGOvv2xH4KMcwSwNklSbMUGc+2nRoY0Ei75JfAl
         Z+q8VHFyGZZmtbWua6xR3plM/FJSY1SH11Y4NoHtktGEsN5QZvOzgIt064ZPbUoDCNxt
         7r0YGmdlAcqMmuOKdbWgnZ/4p1QSYPLSBAeEYyAmoemkySoS08q5blS2vVpLUncUZDjO
         4lgVG2WVi8ehLhYPcC1GaZ6BcKHeRyC7MJ2aDM+knoPjpeOsUVnjng+2MLUNWI6XRsEg
         UAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778554; x=1708383354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GORlhjQxFavWSlHuDyYppgU5m7fuQu/BXbhmbwIyaj8=;
        b=pFY3fWa6SOSWx4VhHQ49UsmR4gxINqU35RG3Ao/FGyPV8bSoS4KQdC0RJYHO9jJQGH
         KJID/tr0IXS/J1LW6TeHmpAK3q7hlQ9Tj3R7d6T1tSM4N3TES+WFy2ERBw+biDtZnF/z
         W8pa1+UEaKM/83lGekns0zy+39G+L+N43SehWlctEgIWkm4r1gyVCnSVRnk6WKQy6Q2m
         2v5WwMkp828C9khlE2UnHOZm3hfry1OK7U16EAytpuqMTSLMCBzmMnH454qWp1ANhDP1
         QfWktbU0D6XrPNy0IpItSxPQRZsLOUAqYVQZrt760wHRzgbSHPV+ysYZuoZc4KhLwW5M
         KR0w==
X-Gm-Message-State: AOJu0YxERCjDCXK3PWiOK4JjeBfnv1hph0MkUOvwKGP9kaGScuclMNXS
	FbX5oYWhAyfinLawagO9NYGtbZi9GKsNIxriSx7bLi97WP7ORd2hOX0WAEfh8S3hSTZO0m9s7qf
	mWl72wtgjvL8G37+zrgQSU5rAGMVmGQXSwgnbXg==
X-Google-Smtp-Source: AGHT+IE1GZcw/hQEWPiV9coPdlVIB2aKAbg99YsD5x5odvfXeyx6Cpc10aJhWo5euRK8PVIeYhwWLVdK8vWvQR0PW0A=
X-Received: by 2002:a17:906:eb14:b0:a3c:c167:169c with SMTP id
 mb20-20020a170906eb1400b00a3cc167169cmr1930798ejb.16.1707778553525; Mon, 12
 Feb 2024 14:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian>
In-Reply-To: <ZcqYNrktYhHFTtzH@debian.debian>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Feb 2024 23:55:17 +0100
Message-ID: <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, jakub@cloudflare.com, 
	ignat@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Feb 2024 at 23:14, Yan Zhai <yan@cloudflare.com> wrote:
>
> Hello!
>
> We are getting page fault errors inside BPF tracepoint that accessed
> not-present pages. This caused kernel panic:
>
> [717542.963064][T897981] BUG: unable to handle page fault for address: ff=
ffffffff600c7d
> [717542.975692][T897981] #PF: supervisor read access in kernel mode
> [717542.986496][T897981] #PF: error_code(0x0000) - not-present page
> [717542.997237][T897981] PGD 1965012067 P4D 1965012067 PUD 1965014067 PMD=
 1965016067 PTE 0
> [717543.009965][T897981] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [717543.019835][T897981] CPU: 34 PID: 897981 Comm: warp-service Kdump: lo=
aded Tainted: G           O       6.1.74-cloudflare-2024.1.14 #1
> [717543.041140][T897981] Hardware name: HYVE EDGE-METAL-GEN11/HS1811D_Lit=
e, BIOS V0.11-sig 12/23/2022
> [717543.059260][T897981] RIP: 0010:bpf_prog_2eca29f2a4f78ed1_drop_monitor=
+0x326/0xada
> [717543.071449][T897981] Code: ff eb 07 48 8b bf f8 04 00 00 49 bb 80 0e =
00 00 00 80 00 00 4c 39 df 72 0c 49 89 fb 49 81 c3 80 0e 00 00 73 05 45 31 =
ed eb 07 <4c> 8b af 80 0e 00 00 48 89 ee 48 83 c6 f0 48 bf 00 04 7a 0a 3d 9=
e
> [717543.104780][T897981] RSP: 0018:ffffaece810efab8 EFLAGS: 00010286
> [717543.115372][T897981] RAX: 0000000000000000 RBX: ffffcea96b4ae350 RCX:=
 0000000000000010
> [717543.127887][T897981] RDX: 0000000000000030 RSI: ffffffffac168443 RDI:=
 ffffffffff5ffdfd
> [717543.140325][T897981] RBP: ffffaece810efb28 R08: ffff9e61e3b27c80 R09:=
 000000000000e000
> [717543.152712][T897981] R10: 0000000000000041 R11: ffffffffff600c7d R12:=
 00028c9a1e371991
> [717543.165011][T897981] R13: 0000000000000000 R14: ffff9e6339dce8c0 R15:=
 ffff9e61e3b27c00
> [717543.177253][T897981] FS:  00007f769a1fd6c0(0000) GS:ffff9e6bdfa80000(=
0000) knlGS:0000000000000000
> [717543.194511][T897981] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [717543.205261][T897981] CR2: ffffffffff600c7d CR3: 0000003d21706005 CR4:=
 0000000000770ee0
> [717543.217411][T897981] PKRU: 55555554
> [717543.224999][T897981] Call Trace:
> [717543.232224][T897981]  <TASK>
> [717543.239016][T897981]  ? __die+0x20/0x70
> [717543.246661][T897981]  ? page_fault_oops+0x150/0x490
> [717543.255270][T897981]  ? __sk_dst_check+0x39/0xa0
> [717543.263548][T897981]  ? inet6_csk_route_socket+0x123/0x200
> [717543.272622][T897981]  ? exc_page_fault+0x67/0x140
> [717543.280831][T897981]  ? asm_exc_page_fault+0x22/0x30
> [717543.289230][T897981]  ? tcp_data_queue+0xc03/0xe20
> [717543.297374][T897981]  ? bpf_prog_2eca29f2a4f78ed1_drop_monitor+0x326/=
0xada
> [717543.307555][T897981]  ? bpf_prog_2eca29f2a4f78ed1_drop_monitor+0x281/=
0xada
> [717543.317638][T897981]  ? tcp_data_queue+0xc03/0xe20
> [717543.325540][T897981]  bpf_trace_run3+0x92/0xc0
> [717543.333026][T897981]  ? tcp_data_queue+0xc03/0xe20
> [717543.340823][T897981]  kfree_skb_reason+0x7b/0xd0
> [717543.348427][T897981]  tcp_data_queue+0xc03/0xe20
> [717543.355985][T897981]  tcp_rcv_established+0x218/0x740
> [717543.363944][T897981]  tcp_v4_do_rcv+0x157/0x290
> [717543.371315][T897981]  tcp_v4_rcv+0xddd/0xf00
> [717543.378330][T897981]  ? raw_local_deliver+0xc0/0x230
> [717543.385973][T897981]  ip_protocol_deliver_rcu+0x32/0x200
> [717543.393880][T897981]  ip_local_deliver_finish+0x73/0xa0
> [717543.401616][T897981]  __netif_receive_skb_one_core+0x8b/0xa0
> [717543.409751][T897981]  netif_receive_skb+0x38/0x160
> [717543.416920][T897981]  tun_get_user+0xbe6/0x1080 [tun]
> [717543.424292][T897981]  ? mlx5e_handle_rx_dim+0x6b/0x80 [mlx5_core]
> [717543.432754][T897981]  ? mlx5e_napi_poll+0x710/0x720 [mlx5_core]
> [717543.441007][T897981]  ? tun_chr_write_iter+0x69/0xb0 [tun]
> [717543.448753][T897981]  tun_chr_write_iter+0x69/0xb0 [tun]
> [717543.456312][T897981]  vfs_write+0x2a3/0x3b0
> [717543.462722][T897981]  ksys_write+0x5f/0xe0
> [717543.469018][T897981]  do_syscall_64+0x3b/0x90
> [717543.475522][T897981]  entry_SYSCALL_64_after_hwframe+0x4c/0xb6
> [717543.483443][T897981] RIP: 0033:0x7f76b3b3027f
> [717543.489848][T897981] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 =
39 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 =
00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c d5 f8 ff 4=
8
> [717543.515551][T897981] RSP: 002b:00007f769a1f9870 EFLAGS: 00000293 ORIG=
_RAX: 0000000000000001
> [717543.526219][T897981] RAX: ffffffffffffffda RBX: 0000000000000500 RCX:=
 00007f76b3b3027f
> [717543.536507][T897981] RDX: 0000000000000500 RSI: 00007f761a694a00 RDI:=
 00000000000015a4
> [717543.546815][T897981] RBP: 00007f75f53cf600 R08: 0000000000000000 R09:=
 00000000000272c8
> [717543.557136][T897981] R10: 00000000000075dc R11: 0000000000000293 R12:=
 00007f76b37b0198
> [717543.567447][T897981] R13: 0000000000000000 R14: 00007f76b37a4000 R15:=
 0000000000000004
> [717543.577777][T897981]  </TASK>
> [717543.583106][T897981] Modules linked in: mptcp_diag raw_diag unix_diag=
 xt_LOG nf_log_syslog overlay nft_compat xt_hashlimit ip_set_hash_netport x=
t_length esp4 nf_conntrack_netlink nft_fwd_netdev nf_dup_netdev xfrm_interf=
ace xfrm6_tunnel nft_numgen nft_log nft_limit dummy xfrm_user xfrm_algo fou=
6 ip6_tunnel tunnel6 ipip mpls_gso mpls_iptunnel mpls_router sit tunnel4 fo=
u nft_ct nf_tables cls_bpf ip_gre gre ip_tunnel geneve ip6_udp_tunnel udp_t=
unnel zstd zstd_compress zram zsmalloc sch_ingress tcp_diag veth tun udp_di=
ag inet_diag dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio ip6t_RE=
JECT nf_reject_ipv6 ip6table_filter ip6table_mangle ip6table_raw ip6table_s=
ecurity ip6table_nat ip6_tables ipt_REJECT nf_reject_ipv4 xt_tcpmss iptable=
_filter xt_TCPMSS xt_bpf xt_limit xt_multiport xt_NFLOG nfnetlink_log xt_co=
nnbytes xt_connlabel xt_statistic xt_mark xt_connmark xt_conntrack iptable_=
mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment xt_tcpudp xt_CT=
 iptable_raw
> [717543.583186][T897981]  ip_set_hash_ip ip_set_hash_net ip_set nfnetlink=
 tcp_bbr sch_fq nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 algif_skcipher a=
f_alg raid0 md_mod essiv dm_crypt trusted asn1_encoder tee 8021q garp mrp s=
tp llc nvme_fabrics ipmi_ssif amd64_edac kvm_amd kvm irqbypass crc32_pclmul=
 crc32c_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 mlx5_core aesni_intel ac=
pi_ipmi rapl ipmi_si mlxfw xhci_pci nvme tls ipmi_devintf tiny_power_button=
 xhci_hcd nvme_core psample ccp i2c_piix4 ipmi_msghandler button fuse dm_mo=
d dax efivarfs ip_tables x_tables bcmcrypt(O) crypto_simd cryptd [last unlo=
aded: kheaders]
> [717543.774881][T897981] CR2: ffffffffff600c7d
>
> The panic happens as we inspect dropped out of order TCP packets in kfree=
_skb
> tracepoint with a tp_btf program, and try to read out the network namespa=
ce
> cookie via:
>
> skb->dev->nd_net.net->net_cookie
>
> Code generation looks fine on x86_64 with 4 layer pagetable, but the veri=
fier
> placed boundary check is not sufficient to catch the issue: skb->dev is a=
lised
> as skb->rbnode in the same union after packets entered TCP state machine,=
 and
> the out of order queue is one of such rbnode users:
>
> ; uint64_t netns_cookie =3D skb->dev->nd_net.net->net_cookie;
>  2bd:   movabs $0x800000000010,%r11
>  2c7:   cmp    %r11,%r15
>  2ca:   jb     0x000002d8
>  2cc:   mov    %r15,%r11
>  2cf:   add    $0x10,%r11
>  2d6:   jae    0x000002dc
>  2d8:   xor    %edi,%edi
>  2da:   jmp    0x000002e0
>  2dc:   mov    0x10(%r15),%rdi
> ; uint64_t netns_cookie =3D skb->dev->nd_net.net->net_cookie;
>  2e0:   movabs $0x8000000004f8,%r11
>  2ea:   cmp    %r11,%rdi   <--- (1) rdi is a valid rbnode*, not net_devic=
e*
>  2ed:   jb     0x000002fb
>  2ef:   mov    %rdi,%r11
>  2f2:   add    $0x4f8,%r11
>  2f9:   jae    0x000002ff
>  2fb:   xor    %edi,%edi
>  2fd:   jmp    0x00000306
>  2ff:   mov    0x4f8(%rdi),%rdi
> ; uint64_t netns_cookie =3D skb->dev->nd_net.net->net_cookie;
>  306:   movabs $0x800000000e80,%r11
>  310:   cmp    %r11,%rdi  <--- (2) rdi is a wild ptr now
>  313:   jb     0x00000321
>  315:   mov    %rdi,%r11
>  318:   add    $0xe80,%r11
>  31f:   jae    0x00000326
>  321:   xor    %r13d,%r13d
>  324:   jmp    0x0000032d
>  326:   mov    0xe80(%rdi),%r13 <--- (3) fault
>  32d:   mov    %rbp,%rsi
>
> OOO happens a lot on our servers but this is the first time we noticed
> such panic since we had deployed the program for a while. For bpf list
> I think the question is mainly about what to do in this scenario:
> apparently it is a valid kernel pointer at step (1) above, but it's
> just not the type we assumed, which leads to a wild pointer at (2) and
> caused fault at (3). I am not aware of a way to determine such aliased
> pointer is good or not in general. Is it possible to PF safer in this
> case, like returning from PF handler to the end of tracing program?
>

I think it is not supposed to panic, since exception handling for such
PROBE_MEM loads should handle such a case and mark the destination as
zero.
Something must be broken with that.

Which kernel do you observe this problem with? And do you have a
reference version where you do not see it?
Do you have a reduced reproducer for this that I could play with?
Just the part of the tp_btf program necessary to trigger this?

There were some changes made to the JIT code around the bounds
checking to reduce the instruction count.
That was in 90156f4bfa21 ("bpf, x86: Improve PROBE_MEM runtime load check")=
.
Especially when src_reg =3D=3D dst_reg, the case which happens in the
splat at 0x2ff.
Nothing else comes immediately to mind in terms of changes that could
affect this exception handling stuff.

> thanks
> Yan
>

