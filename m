Return-Path: <bpf+bounces-12344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9767CB362
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4967B20EE6
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7B347D8;
	Mon, 16 Oct 2023 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiSJ7L97"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E8339B3
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 19:37:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51469F
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697485025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VO4a5LovCVntfdCgVRy2oxs5rFAyhM7E/Q+GrU1a9E=;
	b=aiSJ7L97B4TFme/UhpDPAeK0AGJpiQlkTNTB7m7Mq1jGD0fi7PKeC4cVdqW9n/7HiTItUp
	ivkItZ5mJ2dVAPNq9Q5qACg62LIDp88SA5f/C+72v+mThIysaeajpdcRMObxTkA2Js8Ei+
	S9fRtq5VieGPNuCDur8AyFiLPV2vzno=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-YxmbC5c4PnueLusC1PjsZQ-1; Mon, 16 Oct 2023 15:37:03 -0400
X-MC-Unique: YxmbC5c4PnueLusC1PjsZQ-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-d9a483bdce7so6783711276.2
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697485022; x=1698089822;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VO4a5LovCVntfdCgVRy2oxs5rFAyhM7E/Q+GrU1a9E=;
        b=nRXDPj/vVBUia34XuOzKMbBpRBPyl1H7D6vx23Cfuw/18U/GNBM7pyyBn4nfltDdj1
         ZgIHK2MCuL++CNByr+NFjDcUT354bZ4BXmIpuztTLVuf8ru+3roLTulSnFiPfFibehHb
         4GPkbFvwSJOH5MODyCM3/EWROKs6Es5Y4mGolVVN3QH37KbS3ENBc1cKFWC+Upu7mAmg
         zugzP2SkDChnW0Ic0X6wmp1Q14wqGcdJfDpXYEiNBxrwq7ZGFlYK/gU2iv5TqepPIHtQ
         BFOcQGPaD2G51qgA9jnvYdRZxPWjL+k/ztjHhJlVhAstwstqTRsHuUr04AUaT30UN2iG
         ZBcg==
X-Gm-Message-State: AOJu0Yy7p6C/yU/pajWdtSKBcwFT7jPJd94Zu8ayNn82kYdhKBTAOZmn
	wMC8lig19gdbdumtOFGoyP9/Q6paqzvw8cFsnF/HcAHcU6D4mnZC4TquFmVhBGAPRMkE+dlDoWv
	s2qSI9VIGKLvP
X-Received: by 2002:a25:b05:0:b0:d9a:54d1:f874 with SMTP id 5-20020a250b05000000b00d9a54d1f874mr15307ybl.35.1697485022295;
        Mon, 16 Oct 2023 12:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKj3TXNgEgrYqgySV+WS+iFqeJ5bDyYwHdZiEjk4vJtU8pSRiJDGD4LUu/fy7eSgWKMsC05A==
X-Received: by 2002:a25:b05:0:b0:d9a:54d1:f874 with SMTP id 5-20020a250b05000000b00d9a54d1f874mr15296ybl.35.1697485022021;
        Mon, 16 Oct 2023 12:37:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t11-20020a252d0b000000b00d7b9fab78bfsm2892114ybt.7.2023.10.16.12.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:37:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7E3C1EB2003; Mon, 16 Oct 2023 21:36:59 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Mohamed
 Mahmoud <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
In-Reply-To: <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 16 Oct 2023 21:36:59 +0200
Message-ID: <87sf6auzok.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Oct 12, 2023 at 1:25=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Hi Andrii
>>
>> Mohamed ran into what appears to be a verifier bug related to your
>> commit:
>>
>> fde2a3882bd0 ("bpf: support precision propagation in the presence of sub=
progs")
>>
>> So I figured you'd be the person to ask about this :)
>>
>> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora 38,
>> and 6.5.5 on my Arch machine):
>>
>> INFO[0000] Verifier error: load program: bad address:
>>         1861: frame2: R1_w=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=
=3Dscalar(umin=3D17,umax=3D255,var_off=3D(0x0; 0xff)) R4_w=3Dfp-96 R6_w=3Df=
p-96 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>>         ; switch (protocol) {
>>         1861: (15) if r3 =3D=3D 0x11 goto pc+22 1884: frame2: R1_w=3Dfp-=
160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=3D17 R4_w=3Dfp-96 R6_w=3Dfp-96 R7_w=
=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>>         1884: (bf) r3 =3D r7                    ; frame2: R3_w=3Dpkt(off=
=3D34,r=3D34,imm=3D0) R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0)
>>         1885: (07) r3 +=3D 8                    ; frame2: R3_w=3Dpkt(off=
=3D42,r=3D34,imm=3D0)
>>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=3Dpkt_end(o=
ff=3D0,imm=3D0) R3_w=3Dpkt(off=3D42,r=3D42,imm=3D0)
>>         ; id->src_port =3D bpf_ntohs(udp->source);
>>         1887: (69) r2 =3D *(u16 *)(r7 +0)       ; frame2: R2_w=3Dscalar(=
umax=3D65535,var_off=3D(0x0; 0xffff)) R7_w=3Dpkt(off=3D34,r=3D42,imm=3D0)
>>         1888: (bf) r3 =3D r2                    ; frame2: R2_w=3Dscalar(=
id=3D103,umax=3D65535,var_off=3D(0x0; 0xffff)) R3_w=3Dscalar(id=3D103,umax=
=3D65535,var_off=3D(0x0; 0xffff))
>>         1889: (dc) r3 =3D be16 r3               ; frame2: R3_w=3Dscalar()
>>         ; id->src_port =3D bpf_ntohs(udp->source);
>>         1890: (73) *(u8 *)(r1 +47) =3D r3       ; frame2: R1_w=3Dfp-160 =
R3_w=3Dscalar()
>>         ; id->src_port =3D bpf_ntohs(udp->source);
>>         1891: (dc) r2 =3D be64 r2               ; frame2: R2_w=3Dscalar()
>>         ; id->src_port =3D bpf_ntohs(udp->source);
>>         1892: (77) r2 >>=3D 56                  ; frame2: R2_w=3Dscalar(=
umax=3D255,var_off=3D(0x0; 0xff))
>>         1893: (73) *(u8 *)(r1 +48) =3D r2
>>         BUG regs 1
>>         processed 5121 insns (limit 1000000) max_states_per_insn 4 total=
_states 92 peak_states 90 mark_read 20
>>         (truncated)  component=3Debpf.FlowFetcher
>>
>> Dmesg says:
>>
>> [252431.093126] verifier backtracking bug
>> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.c:353=
3 __mark_chain_precision+0xe83/0x1090
>>
>>
>> The splat appears when trying to run the netobserv-ebpf-agent. Steps to
>> reproduce:
>>
>> git clone https://github.com/netobserv/netobserv-ebpf-agent
>> cd netobserv-ebpf-agent && make compile
>> sudo FLOWS_TARGET_HOST=3D127.0.0.1 FLOWS_TARGET_PORT=3D9999 ./bin/netobs=
erv-ebpf-agent
>>
>> (It needs a 'make generate' before the compile to recompile the BPF
>> program itself, but that requires the Cilium bpf2go program to be
>> installed and there's a binary version checked into the tree so that is
>> not strictly necessary to reproduce the splat).
>>
>> That project uses the Cilium Go eBPF loader. Interestingly, loading the
>> same program using tc (with libbpf 1.2.2) works just fine:
>>
>> ip link add type veth
>> tc qdisc add dev veth0 clsact
>> tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_bpfel.=
o sec tc_egress
>>
>> So maybe there is some massaging of the object file that libbpf is doing
>> but the Go library isn't, that prevents this bug from triggering? I'm
>> only guessing here, I don't really know exactly what the Go library is
>> doing under the hood.
>>
>> Anyway, I guess this is a kernel bug in any case since that WARN() is
>> there; could you please take a look?
>>
>
> Yes, I tried. Unfortunately I can't build netobserv-ebpf-agent on my
> dev machine and can't run it. I tried to load bpf_bpfel.o through
> veristat, but unfortunately it is not libbpf-compatible.
>
> Is there some way to get a full verifier log for the failure above?
> with log_level 2, if possible? If you can share it through Github Gist
> or something like that, I'd really appreciate it. Thanks!

Sure, here you go:
https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d

-Toke


