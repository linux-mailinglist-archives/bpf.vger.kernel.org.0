Return-Path: <bpf+bounces-69631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED86B9C57E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F199C326906
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6D28D8DA;
	Wed, 24 Sep 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eso/Uz0s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B220ED;
	Wed, 24 Sep 2025 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752313; cv=none; b=fvCLZdqC0DGNrgSOirb6I86I1NbSUlrxoCiWybPBBR2VT8JiVLIlr2YrvsW2i4VypQHTHdYPPDOfgnC9Locis0EkxBCuN3aeLcrbHmBgM42p62z25RJ+upH2xUHQn3n1ooGItc1Rne3Ybo3AKD4sOZiwd/pCPDYriWPLNIeHGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752313; c=relaxed/simple;
	bh=gJpCUy3hZMzkxUNdMhCdLailCwITe+8o3Rq8wWqFJEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zq56PVYzVF/Vd9z6vmD++a2TmFK44PqliMM8sRA3S08rjxwrYron6fEeCyM1359kFg7eQ+TnbTgzBgioAxrWrD/9reoI55PJJ+823LMfqvUXcQ3VOGPs10JR+r0d0QYr7bmfYYIrZfKRaS3fAl4GMU+4Q4FIWA6KYC2R9agz62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eso/Uz0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C983AC4CEE7;
	Wed, 24 Sep 2025 22:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758752313;
	bh=gJpCUy3hZMzkxUNdMhCdLailCwITe+8o3Rq8wWqFJEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eso/Uz0sLQjMLVosKa9aTngBl6ODbHyuehirVQhIcEyOBHHt9guhfxGDrGMExPQfY
	 n0umJNAwgdaSmj1VSAc18hstKgTRk3y6Rk4vUu+Zs/tZALX2OZpAZFF3g0XmNOQUUx
	 O8zucUZQ2gGOt//7xZeFmtB3v3jEg0+sYnB3VvMEgRRO6I2gxPA9FUivBm/eXwQAtJ
	 37i+Z3gHfFLnwuFL0YyHX4dHKpogX0E8PqHqQ9jn1yHqQkyAo5C/ycJiovfRajlQMt
	 Io1c5jYZox+MePIQH+tVCjFGElVpCntJSxRAYqMsxOTTP1L3K6ImHkU/o80SXn1Idd
	 eXVuWiMpWADBg==
Date: Wed, 24 Sep 2025 15:18:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>, Martin KaFai Lau
 <martin.lau@kernel.org>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, bpf@vger.kernel.org, Amery
 Hung <ameryhung@gmail.com>
Subject: Re: pull-request: bpf-next 2025-09-23
Message-ID: <20250924151831.66c38c74@kernel.org>
In-Reply-To: <20250924050303.2466356-1-martin.lau@linux.dev>
References: <20250924050303.2466356-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 22:03:03 -0700 Martin KaFai Lau wrote:
>  tools/testing/selftests/net/lib/xdp_native.bpf.c   |  89 ++++++++--

Hi! this seems to break netdev CI. We need to enable BTF in the driver
tests, that's easy but also the program doesn't load for us any more:

libbpf: prog xdp_prog: BPF program load failed: Invalid argument
libbpf: prog xdp_prog: -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; return xdp_prog_common(ctx); @ xdp_native.bpf.c:671
0: (85) call pc+1
caller:
 R10=fp0
callee:
 frame1: R1=ctx() R10=fp0
2: frame1: R1=ctx() R10=fp0
; static int xdp_prog_common(struct xdp_md *ctx) @ xdp_native.bpf.c:636
2: (bf) r7 = r1                       ; frame1: R1=ctx() R7_w=ctx()
3: (b7) r1 = 0                        ; frame1: R1_w=0
; key = XDP_MODE; @ xdp_native.bpf.c:641
4: (63) *(u32 *)(r10 -336) = r1       ; frame1: R1_w=0 R10=fp0 fp-336=????0
5: (bf) r2 = r10                      ; frame1: R2_w=fp0 R10=fp0
;  @ xdp_native.bpf.c:0
6: (07) r2 += -336                    ; frame1: R2_w=fp-336
; mode = bpf_map_lookup_elem(&map_xdp_setup, &key); @ xdp_native.bpf.c:642
7: (18) r1 = 0xffff888008f8e800       ; frame1: R1_w=map_ptr(map=map_xdp_setup,ks=4,vs=4)
9: (85) call bpf_map_lookup_elem#1    ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
10: (bf) r8 = r0                      ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R8_w=map_value(map=map_xdp_setup,ks=4,vs=4)
11: (b7) r6 = 2                       ; frame1: R6_w=2
; if (!mode) @ xdp_native.bpf.c:643
12: (15) if r8 == 0x0 goto pc+742     ; frame1: R8_w=map_value(map=map_xdp_setup,ks=4,vs=4)
13: (b7) r1 = 1                       ; frame1: R1_w=1
; key = XDP_PORT; @ xdp_native.bpf.c:646
14: (63) *(u32 *)(r10 -336) = r1      ; frame1: R1_w=1 R10=fp0 fp-336=????1
15: (bf) r2 = r10                     ; frame1: R2_w=fp0 R10=fp0
;  @ xdp_native.bpf.c:0
16: (07) r2 += -336                   ; frame1: R2_w=fp-336
; port = bpf_map_lookup_elem(&map_xdp_setup, &key); @ xdp_native.bpf.c:647
17: (18) r1 = 0xffff888008f8e800      ; frame1: R1_w=map_ptr(map=map_xdp_setup,ks=4,vs=4)
19: (85) call bpf_map_lookup_elem#1   ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
; if (!port) @ xdp_native.bpf.c:648
20: (15) if r0 == 0x0 goto pc+734     ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4)
; switch (*mode) { @ xdp_native.bpf.c:651
21: (61) r1 = *(u32 *)(r8 +0)         ; frame1: R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R8=map_value(map=map_xdp_setup,ks=4,vs=4)
22: (65) if r1 s> 0x1 goto pc+20 43: frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R1=scalar(smin=umin=umin32=2,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R10=fp0 fp-336=????1
; switch (*mode) { @ xdp_native.bpf.c:651
43: (15) if r1 == 0x2 goto pc+32      ; frame1: R1=scalar(smin=umin=umin32=3,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
44: (15) if r1 == 0x3 goto pc+135     ; frame1: R1=scalar(smin=umin=umin32=4,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
45: (15) if r1 == 0x4 goto pc+1 47: frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R1=4 R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R10=fp0 fp-336=????1
; udph_ptr = filter_udphdr(ctx, port); @ xdp_native.bpf.c:583
47: (61) r2 = *(u32 *)(r0 +0)         ; frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R2_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; void *data = (void *)(long)ctx->data; @ xdp_native.bpf.c:576
48: (61) r9 = *(u32 *)(r7 +0)         ; frame1: R7=ctx() R9_w=pkt(r=0)
; udph_ptr = filter_udphdr(ctx, port); @ xdp_native.bpf.c:583
49: (57) r2 &= 65535                  ; frame1: R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
50: (bf) r1 = r7                      ; frame1: R1=ctx() R7=ctx()
51: (85) call pc+705
caller:
 frame1: R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R9=pkt(r=0) R10=fp0 fp-336=????1
callee:
 frame2: R1=ctx() R2=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R10=fp0
757: frame2: R1=ctx() R2=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R10=fp0
; static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port) @ xdp_native.bpf.c:71
757: (bf) r6 = r2                     ; frame2: R2=scalar(id=3,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R6_w=scalar(id=3,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
758: (bf) r8 = r1                     ; frame2: R1=ctx() R8_w=ctx()
; err = bpf_xdp_pull_data(ctx, sizeof(*eth)); @ xdp_native.bpf.c:78
759: (b7) r2 = 14                     ; frame2: R2_w=14
760: (85) call bpf_xdp_pull_data#56095        ; frame2: R0_w=scalar()
761: (b7) r7 = 0                      ; frame2: R7_w=0
762: (67) r0 <<= 32                   ; frame2: R0_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
763: (77) r0 >>= 32                   ; frame2: R0=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (err) @ xdp_native.bpf.c:79
764: (55) if r0 != 0x0 goto pc+55     ; frame2: R0=0
; data_end = (void *)(long)ctx->data_end; @ xdp_native.bpf.c:82
765: (61) r2 = *(u32 *)(r8 +4)        ; frame2: R2_w=pkt_end() R8=ctx()
; data = eth = (void *)(long)ctx->data; @ xdp_native.bpf.c:83
766: (61) r1 = *(u32 *)(r8 +0)        ; frame2: R1_w=pkt(r=0) R8=ctx()
; if (data + sizeof(*eth) > data_end) @ xdp_native.bpf.c:85
767: (bf) r3 = r1                     ; frame2: R1_w=pkt(r=0) R3_w=pkt(r=0)
768: (07) r3 += 14                    ; frame2: R3_w=pkt(off=14,r=0)
769: (2d) if r3 > r2 goto pc+50       ; frame2: R2_w=pkt_end() R3_w=pkt(off=14,r=14)
; if (eth->h_proto == bpf_htons(ETH_P_IP)) { @ xdp_native.bpf.c:88
770: (71) r2 = *(u8 *)(r1 +12)        ; frame2: R1_w=pkt(r=14) R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
771: (71) r1 = *(u8 *)(r1 +13)        ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
772: (67) r1 <<= 8                    ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xff00,var_off=(0x0; 0xff00))
773: (4f) r1 |= r2                    ; frame2: R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R2=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
774: (15) if r1 == 0xdd86 goto pc+15          ; frame2: R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
775: (55) if r1 != 0x8 goto pc+44     ; frame2: R1=8
; err = bpf_xdp_pull_data(ctx, sizeof(*eth) + sizeof(*iph) + @ xdp_native.bpf.c:91
776: (bf) r1 = r8                     ; frame2: R1_w=ctx() R8=ctx()
777: (b7) r2 = 42                     ; frame2: R2_w=42
778: (85) call bpf_xdp_pull_data#56095        ; frame2: R0_w=scalar()
779: (67) r0 <<= 32                   ; frame2: R0_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
780: (77) r0 >>= 32                   ; frame2: R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
; if (err) @ xdp_native.bpf.c:93
781: (55) if r0 != 0x0 goto pc+38     ; frame2: R0_w=0
; data_end = (void *)(long)ctx->data_end; @ xdp_native.bpf.c:96
782: (61) r1 = *(u32 *)(r8 +4)        ; frame2: R1_w=pkt_end() R8=ctx()
; data = (void *)(long)ctx->data; @ xdp_native.bpf.c:97
783: (61) r2 = *(u32 *)(r8 +0)        ; frame2: R2_w=pkt(r=0) R8=ctx()
; if (iph + 1 > (struct iphdr *)data_end || @ xdp_native.bpf.c:101
784: (bf) r8 = r2                     ; frame2: R2_w=pkt(r=0) R8_w=pkt(r=0)
785: (07) r8 += 34                    ; frame2: R8=pkt(off=34,r=0)
786: (2d) if r8 > r1 goto pc+33       ; frame2: R1=pkt_end() R8=pkt(off=34,r=34)
; iph->protocol != IPPROTO_UDP) @ xdp_native.bpf.c:102
787: (71) r2 = *(u8 *)(r2 +23)        ; frame2: R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
; if (iph + 1 > (struct iphdr *)data_end || @ xdp_native.bpf.c:101
788: (15) if r2 == 0x11 goto pc+14 803: frame2: R0=0 R1=pkt_end() R2_w=17 R6=scalar(id=3,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R7=0 R8=pkt(off=34,r=34) R10=fp0
; if (udph + 1 > (struct udphdr *)data_end) @ xdp_native.bpf.c:128
803: (bf) r2 = r8                     ; frame2: R2_w=pkt(off=34,r=34) R8=pkt(off=34,r=34)
804: (07) r2 += 8                     ; frame2: R2_w=pkt(off=42,r=34)
805: (2d) if r2 > r1 goto pc+14       ; frame2: R1=pkt_end() R2_w=pkt(off=42,r=42)
; if (udph->dest != bpf_htons(port)) @ xdp_native.bpf.c:131
806: (dc) r6 = be16 r6                ; frame2: R6_w=scalar()
807: (69) r1 = *(u16 *)(r8 +2)        ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R8=pkt(off=34,r=42)
808: (5d) if r1 != r6 goto pc+11      ; frame2: R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
809: (b7) r1 = 0                      ; frame2: R1_w=0
810: (63) *(u32 *)(r10 -4) = r1       ; frame2: R1_w=0 R10=fp0 fp-8=0000????
811: (bf) r2 = r10                    ; frame2: R2_w=fp0 R10=fp0
;  @ xdp_native.bpf.c:0
812: (07) r2 += -4                    ; frame2: R2_w=fp-4
; count = bpf_map_lookup_elem(&map_xdp_stats, &stat_type); @ xdp_native.bpf.c:65
813: (18) r1 = 0xffff888008f89a00     ; frame2: R1_w=map_ptr(map=map_xdp_stats,ks=4,vs=8)
815: (85) call bpf_map_lookup_elem#1          ; frame2: R0=map_value(map=map_xdp_stats,ks=4,vs=8)
; if (count) @ xdp_native.bpf.c:67
816: (15) if r0 == 0x0 goto pc+2      ; frame2: R0=map_value(map=map_xdp_stats,ks=4,vs=8)
817: (b7) r1 = 1                      ; frame2: R1_w=1
; __sync_fetch_and_add(count, 1); @ xdp_native.bpf.c:68
818: (db) lock *(u64 *)(r0 +0) += r1          ; frame2: R0=map_value(map=map_xdp_stats,ks=4,vs=8) R1_w=1
819: (bf) r7 = r8                     ; frame2: R7_w=pkt(off=34,r=42) R8=pkt(off=34,r=42)
; } @ xdp_native.bpf.c:137
820: (bf) r0 = r7                     ; frame2: R0_w=pkt(off=34,r=42) R7_w=pkt(off=34,r=42)
821: (95) exit
returning from callee:
 frame2: R0_w=pkt(off=34,r=42) R1_w=1 R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R7_w=pkt(off=34,r=42) R8=pkt(off=34,r=42) R10=fp0 fp-8=0000????
to caller at 52:
 frame1: R0_w=pkt(off=34,r=42) R6=2 R7=ctx() R8=map_value(map=map_xdp_setup,ks=4,vs=4) R9=scalar() R10=fp0 fp-336=????1
; udph_ptr = filter_udphdr(ctx, port); @ xdp_native.bpf.c:583
52: (bf) r8 = r0                      ; frame1: R0_w=pkt(off=34,r=42) R8_w=pkt(off=34,r=42)
53: (b7) r6 = 2                       ; frame1: R6=2
; if (!udph_ptr) @ xdp_native.bpf.c:584
54: (15) if r8 == 0x0 goto pc+700     ; frame1: R8=pkt(off=34,r=42)
55: (b7) r6 = 2                       ; frame1: R6_w=2
; key = XDP_ADJST_OFFSET; @ xdp_native.bpf.c:589
56: (63) *(u32 *)(r10 -332) = r6      ; frame1: R6_w=2 R10=fp0 fp-336=mmmmmmmm
57: (bf) r2 = r10                     ; frame1: R2_w=fp0 R10=fp0
;  @ xdp_native.bpf.c:0
58: (07) r2 += -332                   ; frame1: R2_w=fp-332
; val = bpf_map_lookup_elem(&map_xdp_setup, &key); @ xdp_native.bpf.c:590
59: (18) r1 = 0xffff888008f8e800      ; frame1: R1_w=map_ptr(map=map_xdp_setup,ks=4,vs=4)
61: (85) call bpf_map_lookup_elem#1   ; frame1: R0_w=map_value_or_null(id=4,map=map_xdp_setup,ks=4,vs=4)
; if (!val) @ xdp_native.bpf.c:591
62: (15) if r0 == 0x0 goto pc+692     ; frame1: R0_w=map_value(map=map_xdp_setup,ks=4,vs=4)
63: (b7) r4 = 16                      ; frame1: R4_w=16
64: (b7) r5 = 1                       ; frame1: R5_w=1
; switch (*val) { @ xdp_native.bpf.c:594
65: (61) r1 = *(u32 *)(r0 +0)         ; frame1: R0_w=map_value(map=map_xdp_setup,ks=4,vs=4) R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
66: (bf) r3 = r1                      ; frame1: R1_w=scalar(id=5,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R3_w=scalar(id=5,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
67: (67) r3 <<= 32                    ; frame1: R3_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
68: (c7) r3 s>>= 32                   ; frame1: R3_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
69: (18) r2 = 0xfffffeff              ; frame1: R2=0xfffffeff
71: (6d) if r1 s> r2 goto pc+284      ; frame1: R1=scalar(id=5,smin=0,smax=umax=umax32=0xfffffeff,var_off=(0x0; 0xffffffff)) R2=0xfffffeff
72: (65) if r1 s> 0x3f goto pc+295    ; frame1: R1=scalar(id=5,smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))
73: (15) if r1 == 0x10 goto pc+313    ; frame1: R1=scalar(id=5,smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))
74: (15) if r1 == 0x20 goto pc+309 384: frame1: R0=map_value(map=map_xdp_setup,ks=4,vs=4) R1=32 R2=0xfffffeff R3=scalar(smin=0xffffffff80000000,smax=0x7fffffff) R4=16 R5=1 R6=2 R7=ctx() R8=pkt(off=34,r=42) R9=scalar() R10=fp0 fp-336=mmmmmmmm
; switch (*val) { @ xdp_native.bpf.c:594
384: (b7) r4 = 32                     ; frame1: R4_w=32
385: (05) goto pc+1
387: (7b) *(u64 *)(r10 -352) = r5     ; frame1: R5=1 R10=fp0 fp-352_w=1
388: (1f) r8 -= r9
math between pkt pointer and register with unbounded min value is not allowed
processed 401 insns (limit 1000000) max_states_per_insn 2 total_states 37 peak_states 37 mark_read 9
-- END PROG LOAD LOG --
libbpf: prog xdp_prog: failed to load: -22
libbpf: failed to load object /home/virtme/testing/wt-18/tools/testing/selftests/net/lib/xdp_native.bpf.o

