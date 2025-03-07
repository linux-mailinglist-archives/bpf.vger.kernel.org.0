Return-Path: <bpf+bounces-53530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63368A55F24
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 05:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E2E18940A3
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075F18FDDF;
	Fri,  7 Mar 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsmWenkb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214C183CBB
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320268; cv=none; b=LQGG94LQ9tOJE3uRXvtdEugWB+GqJNsAwDEHMtgMRPwlZQkJtMsywNV3rMXMjqo5ZD/or1M2A0uAo1fp7ij0YQ+3dk2r5urgrgOCFK20T5zg+3bMf1LvhJjkMsVPvQ/PXvbdWAIevDiRHUa22RJXmsOSluKaMY7wxEJKGltoriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320268; c=relaxed/simple;
	bh=hiy9eWUJOoSPLqhKNaV/xGGq6o0kRqL6XtIetlqlU3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyL5325Z4EokRESJnzlpIEE8KhDcsSlGhYhvRYVDAJ6au3dM6Mxx9RKnf8gNFdWgB/oniVEFUj8IvzPnqeIq1X0C4gw2qbGT/miFyCVuYaNZ63IQhe2hWntiLW5amWjv52mReZagZSsqN7dtBDsBHsyzzYynGBc16MdG0pdTiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsmWenkb; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-474fdd93836so13877591cf.2
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 20:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741320265; x=1741925065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnCB3KTi4fNTpLZNn/TWazyrY/EOkEjsDQmmzokFfmQ=;
        b=EsmWenkbR/h6NvJ6S9WgWwLZaf7ELzayYkNVeqjEJNwxelBZiQKWhX77AYC0ieJxk0
         P8GUBMKeiMNndLA27ZvWGINnxH6El+J0tyLvOQHDJpqf+H3EwLjt+y3eAdw/Zencf5rO
         ueUK0WhbRFvvVPuvD4PadjidR2aeUVE0TYarZyD6FnXzaoVhCjME8aHJ+I/5Cj4v070F
         T85elH3LFEAGr+Upi4dn3OQz6snn9YyvWCd5s7bHP/6yoc+bNLocj1P739ebSrJ04LEf
         7suO3MJ66aCDwxU7+UNuE9yQI+fKePusyUkJRLL85fJIVk0wDgpAxA2rOwVq6HdCvciW
         Mulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741320265; x=1741925065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnCB3KTi4fNTpLZNn/TWazyrY/EOkEjsDQmmzokFfmQ=;
        b=g93ZuTKeGRQpfVeiHI/L0bnmXnz012nbsinv+KT7iCt9DPudlK7aq9yT4sFnZmhBBI
         4bwZhiOF3fsmevySoRkqkb2fqFxfoxYb2qf9g4K1VaGcoD6xKJnWVN3lbSVfYihcrMFl
         d3xjsJSoonKiu59s8Pe+lcJQ1kjxWWBoVIJ+ugANbitOuB1fJScl2p6iHKnLqsRC2DMC
         JUMuse38vK3bf7J6AMv1w8zvdTPH91ahjFgJt7Y1aL5RIBeXTkT19rK5uPIuvRs3bkpe
         AChBtaRTMuUiR/SzVBDcZbec9KX15tU+0HqWgOiKE7i6vCtHV0kfsM4zUQHhQdR0Z65A
         Jmhw==
X-Gm-Message-State: AOJu0YyIBVxDHboY5g4HhBX9ZR/XKqMuLSRKtKp4RholH3ak+XYFX32Y
	248sf0KO9dPEgXCg/rwMVN0NWwXtWBlVTPKq1FuWiG2cBqEPO7TWe/zR0Pnd5vPjzi468aQsfvf
	yZ4vmgnpHupsse9iE4mHb3r7r1tE=
X-Gm-Gg: ASbGnctESvSeApQvDb0+UPzh6SU9E0Sq3wlPzXpJ6SrGVowAFO1c+2rmbuezpjeXhNL
	EV6Q8D+Rtql871gLyPp0J20PR6IRt8k9iYcBajA1a0u4AZZbbbAIgfVLy7725rirnI5WaC7qMbu
	mTANgSevE8bVnzft6c4b1W2mnpsg==
X-Google-Smtp-Source: AGHT+IHL27MKyMGNCWAtuyaAqaLWAwn3LYiGAJ9ruuhBgOijJUzFN2g6muTAgD0NEsHR7SDcvbYwH10f1zx7kDioG1M=
X-Received: by 2002:a05:622a:1829:b0:475:bda:eb6e with SMTP id
 d75a77b69052e-47618addaeamr25527081cf.35.1741320265417; Thu, 06 Mar 2025
 20:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com>
 <Z8oXIhptXWhbCeCF@pop-os.localdomain>
In-Reply-To: <Z8oXIhptXWhbCeCF@pop-os.localdomain>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 6 Mar 2025 20:04:14 -0800
X-Gm-Features: AQ5f1JpFV1fyxLU1llSFRif5Q21vOwTTnKsxlv6KkUJE6hjtOrCNLjT1EsY0a-k
Message-ID: <CAK3+h2ys8ivcnnd=em7QZRWqqmtSuqy4xEiDoV6+9ccOzJHu4w@mail.gmail.com>
Subject: Re: [BUG?] loxilb tc BPF program cause Loongarch kernel hard lockup
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry I had a type error on the loongarch mailing list address, corrected i=
t.

On Thu, Mar 6, 2025 at 1:44=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Wed, Mar 05, 2025 at 04:51:15PM -0800, Vincent Li wrote:
> > Hi,
> >
> > I have an issue recorded here [0] with kernel call trace  when I start
> > loxilb, the loxilb tc BPF program seems to be loaded and attached to
> > the network interface, but immediately it causes a loongarch kernel
> > hard lockup, no keyboard response. Sometimes the panic call trace
> > shows up in the monitor screen after I disabled kernel panic reboot
> > (echo 0 > /proc/sys/kernel/panic) and started loxilb.
> >
> > Background: I ported open source IPFire [1] to Loongarch CPU
> > architecture and enabled kernel BPF features, added loxilb as LFS
> > (Linux from scratch) addon software, loxilb 0.9.8.3 has libbpf 1.5.0
> > which has loongarch support [2]. The same loxilb addon runs fine on
> > x86 architecture. Any clue on this?
> >
> > [0]: https://github.com/vincentmli/BPFire/issues/76
> > [1]: https://github.com/ipfire/ipfire-2.x
> > [2]: https://github.com/loxilb-io/loxilb/issues/972
> >
>
> Thanks for your report!
>
> I have extracted the kernel crash log from your photo with AI so that
> people can easily interpret it.
>

Nice to know AI could do that :)

> From a quick glance, it seems related to MIPS JIT. So it would be
> helpful if you could locate the eBPF program which triggered this and
> dump its JIT'ed BPF instructions.
>

This is call trace from Loongarch CPU so related to Loongarch BPF JIT.
the kernel seems to lockup immediately right after attaching to the
network interface. to dump the JIT'ed BPF instructions, maybe just
load the BPF program, but not attach it so I can dump the BPF
instructions?

> --------------------
>
> 09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook2 prog=
 tc_packet_func_slow
> 09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook3 prog=
 tc_packet_func_fw
> 09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook4 prog=
 tc_csum_func1
> 09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook5 prog=
 tc_csum_func2
> 09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook6 prog=
 tc_slow_path_func
> 09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook7 prog=
 tc_packet_func_map
> libbpf: Error in bpf_create_map_xattr(sh_map):Invalid argument(-22). Retr=
ying without BTF.
> libbpf: Error in bpf_create_map_xattr:wq4t:Operation not supported(-95). =
Retrying without BTF.
> 09:37:44 INFO  common_libbpf.c:294: tc: bpf attach OK for req8
> 09:37:44 DEBUG loxilb_llbpf.c:3311: llb_link_prop_add: IF-req8 added idx =
2 type 2
> 220c:83-95 09:37:44 shpt in bitmap added -> 3 vlan 0 -> 3
> 220c:83-05 09:37:44 ovr twintfmap added -> 3 -> 3
> 09:37:44 DEBUG loxilb_llbpf.c:6553: tcmdll_bpf_setsockopt: hook id 1 pact=
ion tc_packet_hook8
> 09:37:44 INFO  common_libbpf.c:124: tc: bpf attach start for 1018:8
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/xdp_main
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/qpm_tbl
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/intf_map
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/intf_stats_map
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/bd_stats_map
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/pkt_ring
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/cp_ring
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/ct_map
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/nat_ep_map
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/nat_cm_map
> 09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp=
/bpf/sess_cache
> 09:37:44 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook8 prog=
 tc_packet_func_map
> [70107.629723] S0?xzkcC:bxbcCtXbwhsdc+cbxbsph-b3E+bp  tprbdccdcxtbxxmsd) =
 spccoc,tbcdaddcdzs.Tx;  txddbdxm  tBxbXHX  b+.b.bXH,t  kbdbtX23.MXl  BXftP=
XFl  tbttttt
> (Hex dump and more binary data follows)
>
> [70107.638086] Call Trace:
> [70107.638809] [<ffffffffff8003f1d67c>] bpf_prog_7092f4f2542453f74_tc_pac=
ket_func+0x9004/0xaf24
> [70107.639056] [<ffffffffff8003f580d9>] cls_bpf_classify+0x6c8/0x478 [cls=
_bpf]
> [70107.639368] [<0000000005535e82>] __tcf_classify+0xeep.18/0x3c4/0x408
> [70107.639570] [<0000000005549d80>] tcf_classify+0x88/0x28/0xd0
> [70107.639584] [<0000000005554cec>] tc_classify+0x4c/0x100
> [70107.639993] [<0000000055c7414>] __netif_receive_skb_core.constprop.0+0=
x5b4/0x1ba0
> [70107.640296] [<0000000055c74443>] __netif_receive_skb_list_core+0x184/0=
x228
> [70107.640521] [<0000000055c28528>] netif_receive_skb_list_internal+0x220=
/0x300
> [70107.640839] [<0000000055c28f48>] nepi_complete_done+0xd8/0x288
> [70107.641157] [<000000005524d0d2>] stmmac_napi_poll_rx+0x3f30/0x1208
> [70107.641470] [<000000005552e1ec>] __napi_poll+0x5c/0x230
> [70107.641801] [<000000005523b74>] net_rx_action+0x1e4/0x310
> [70107.642126] [<00000000343ec2d8>] handle_softirq+0x128/0x3d0
> [70107.642451] [<00000000343ecfb9>] irq_exit+0x3c/0xb0
> [70107.642782] [<000000005245e2c>] do_irq+0x6c/0xa0
> [70107.643125] [<000000005e4e1fd>] __ret_from_idle+0x20/0x24
> [70107.643361] [<000000005d47c88>] arch_cpu_idle+0x10/0x50
> [70107.643855] [<000000005047d9c>] default_idle_call+0x1c/0x110
> [70107.644158] [<00000000444df80>] do_idle+0x80/0x130
> [70107.644530] [<00000000444e298>] cpu_startup_entry+0x90/0x30
> [70107.644869] [<000000005d4824b>] kernel_entry_end+0xdc/0xa0
> [70107.645280] [<000000005b0e4c>] start_kernel+0x6f8/0x6f4
> [70107.645549] [<000000005b408f0>] kernel_entry+0xf8/0xf0
> [70107.645890]
> [70107.646228] Code: 00158086  00109a5  82c8d4a5  c29482085  5008f480  2a=
847b25  034084a5  00150ae  5c8089c0
> [70107.646591]
> [70107.646954] ---[ end trace 0000000000000000 ]---
>

