Return-Path: <bpf+bounces-12076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42927C77E1
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 22:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFB41C21150
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC243D3A9;
	Thu, 12 Oct 2023 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqH8CEVC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176543D388
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 20:25:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6453B83
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697142352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cSHDrt3NTy0ANnTQoqXu1o1JnvbkAXQxw2KZJ7VHu1g=;
	b=SqH8CEVCgYuqfvLDfY4HzqAJXLSF6yFD94SISZWBoLazYMqjS76/152GHkEyqII/I1Ijbo
	Yw/RZZ1rG+wwZIEfi4txFCnIsZ2hPd5TKz12TNNaeXM+sn9FwQMkycymgszzxPPc3XTvL8
	vanNqX7iEtoQ9MdhI4QasDXAHDzYov0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-8K2LtHftMc-ZeI3ExYzE-Q-1; Thu, 12 Oct 2023 16:25:51 -0400
X-MC-Unique: 8K2LtHftMc-ZeI3ExYzE-Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2e3f315d5so148600266b.1
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 13:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697142349; x=1697747149;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSHDrt3NTy0ANnTQoqXu1o1JnvbkAXQxw2KZJ7VHu1g=;
        b=jdeC8Q8w0df9lHcUyv1pIKq0LOz6/xP2a+NNsD8rgUCBUWoe7UBKOj/mmvMdQS5qv1
         jrp1vPVLSmcSfuFFi6Q+SO9GFSbgcdaCbsO1Pg/pmDWWV1AHUJiQ8irdx7zAGjhD4EyV
         BUdBbedv0bDhUfdan9rurKy3N+jthsw36Eg+YDIS6S0aXXkgEJBxwbHj5CstxLiGbH3b
         BGvNH41WrPhS3SjKaPUqAIsT1dlCgpmQjt58aHs86YyntMPjespyMnyspxmvVj3amMJk
         Ns9eZkt2xBtxe8+SZ8gX5sD5t+2UFJM7kphSuzf3SruXuFZl2VTxeLxKHy5D4yyN6nX0
         m6ZQ==
X-Gm-Message-State: AOJu0YyqeU9Fm9bTnVURcH/PbVxcs5blqizeG/gi+9AGdSJEssKd6DsR
	RikTUuy90N1HFnCL7/lRKGt/il6Yof4H+R07Q9hhxfW9Oq650tb8ssHWUSir+X2ECMqJfAWfWk+
	rZ02M7oFOYNnZ
X-Received: by 2002:a17:906:af10:b0:9ad:8a9e:23ee with SMTP id lx16-20020a170906af1000b009ad8a9e23eemr18427966ejb.13.1697142349446;
        Thu, 12 Oct 2023 13:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyaEmLvtR9YAI42pm+MCqFIvZOsMAzN5aI2kGprOER6rDDtPJpT97UZoJxc1Nm0Hfv3sOAww==
X-Received: by 2002:a17:906:af10:b0:9ad:8a9e:23ee with SMTP id lx16-20020a170906af1000b009ad8a9e23eemr18427961ejb.13.1697142349166;
        Thu, 12 Oct 2023 13:25:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709064b1100b0099cc3c7ace2sm11631504eju.140.2023.10.12.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:25:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 38DD4E5BE30; Thu, 12 Oct 2023 22:25:48 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Mohamed Mahmoud <mmahmoud@redhat.com>
Subject: Hitting verifier backtracking bug on 6.5.5 kernel
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 12 Oct 2023 22:25:48 +0200
Message-ID: <87jzrrwptf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii

Mohamed ran into what appears to be a verifier bug related to your
commit:

fde2a3882bd0 ("bpf: support precision propagation in the presence of subprogs")

So I figured you'd be the person to ask about this :)

The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora 38,
and 6.5.5 on my Arch machine):

INFO[0000] Verifier error: load program: bad address:
	1861: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=scalar(umin=17,umax=255,var_off=(0x0; 0xff)) R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
	; switch (protocol) {
	1861: (15) if r3 == 0x11 goto pc+22 1884: frame2: R1_w=fp-160 R2_w=pkt_end(off=0,imm=0) R3=17 R4_w=fp-96 R6_w=fp-96 R7_w=pkt(off=34,r=34,imm=0) R10=fp0
	; if ((void *)udp + sizeof(*udp) <= data_end) {
	1884: (bf) r3 = r7                    ; frame2: R3_w=pkt(off=34,r=34,imm=0) R7_w=pkt(off=34,r=34,imm=0)
	1885: (07) r3 += 8                    ; frame2: R3_w=pkt(off=42,r=34,imm=0)
	; if ((void *)udp + sizeof(*udp) <= data_end) {
	1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=pkt_end(off=0,imm=0) R3_w=pkt(off=42,r=42,imm=0)
	; id->src_port = bpf_ntohs(udp->source);
	1887: (69) r2 = *(u16 *)(r7 +0)       ; frame2: R2_w=scalar(umax=65535,var_off=(0x0; 0xffff)) R7_w=pkt(off=34,r=42,imm=0)
	1888: (bf) r3 = r2                    ; frame2: R2_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff)) R3_w=scalar(id=103,umax=65535,var_off=(0x0; 0xffff))
	1889: (dc) r3 = be16 r3               ; frame2: R3_w=scalar()
	; id->src_port = bpf_ntohs(udp->source);
	1890: (73) *(u8 *)(r1 +47) = r3       ; frame2: R1_w=fp-160 R3_w=scalar()
	; id->src_port = bpf_ntohs(udp->source);
	1891: (dc) r2 = be64 r2               ; frame2: R2_w=scalar()
	; id->src_port = bpf_ntohs(udp->source);
	1892: (77) r2 >>= 56                  ; frame2: R2_w=scalar(umax=255,var_off=(0x0; 0xff))
	1893: (73) *(u8 *)(r1 +48) = r2
	BUG regs 1
	processed 5121 insns (limit 1000000) max_states_per_insn 4 total_states 92 peak_states 90 mark_read 20
	(truncated)  component=ebpf.FlowFetcher

Dmesg says:

[252431.093126] verifier backtracking bug
[252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.c:3533 __mark_chain_precision+0xe83/0x1090


The splat appears when trying to run the netobserv-ebpf-agent. Steps to
reproduce:

git clone https://github.com/netobserv/netobserv-ebpf-agent
cd netobserv-ebpf-agent && make compile
sudo FLOWS_TARGET_HOST=127.0.0.1 FLOWS_TARGET_PORT=9999 ./bin/netobserv-ebpf-agent

(It needs a 'make generate' before the compile to recompile the BPF
program itself, but that requires the Cilium bpf2go program to be
installed and there's a binary version checked into the tree so that is
not strictly necessary to reproduce the splat).

That project uses the Cilium Go eBPF loader. Interestingly, loading the
same program using tc (with libbpf 1.2.2) works just fine:

ip link add type veth
tc qdisc add dev veth0 clsact
tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_bpfel.o sec tc_egress

So maybe there is some massaging of the object file that libbpf is doing
but the Go library isn't, that prevents this bug from triggering? I'm
only guessing here, I don't really know exactly what the Go library is
doing under the hood.

Anyway, I guess this is a kernel bug in any case since that WARN() is
there; could you please take a look?

Thanks!

-Toke


