Return-Path: <bpf+bounces-12174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF1E7C8EC7
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 23:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFE1B20B07
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9ED250F2;
	Fri, 13 Oct 2023 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuRQ4nAB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A64219FC
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 21:11:43 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3ED8
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 14:11:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so4369185a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697231501; x=1697836301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lcRNuayPf4anQZfBDqfnvyhOp8pAiTdz5J2F5oxTr0=;
        b=DuRQ4nABEbbXIAUN9a/87+aUM6WzebS1PvTMEcUX+0O9kdwt2/IrFspcLRuyHcuFp3
         xHxtgT+pMmt3QiamVo2WUvqnQ+2Nk7bUdmJ6A8D2wOs56m6nZnrcLoDkYPlG/fha21MO
         K0/+iPsRyhX3uxvVZ7MAfBgrDS3tD8C9bgmKGLJISvww7vQsdy/OAV2X+uOOwoMnb6fL
         KcXP2eUcs+kAzVrqSzcN4dfJ2vthuwPoBOZtvzyW5karR8h8fMdQYdIA5DaU5TsujCkD
         38I0xnLEb8Hqd1c+t0Nsyx4BBvWkb9MYPgVSGbXWP8AQTHmnF8yWKjmtjO/IVABTnnM3
         BdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231501; x=1697836301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lcRNuayPf4anQZfBDqfnvyhOp8pAiTdz5J2F5oxTr0=;
        b=JJIS2bCWsYLmTmbzhjScxWVzkWq3YSZu6twbIPgrwqCcClimaAC1r4DfWNNJuzKpcz
         +QQnnyYiGEcU9xr+i+w2UwdJ24SxjJQbtNOUkYReVb9Ou4fOUE9gHPGsmpZF0G0gepdA
         GW+fwSpKMifeGHA+DNzgV3LGvbeGxCUJf1I9YwUkaK4BBhFoUKX4DQCbhmwclhq0HD81
         pqJJ7pl4IFYFa0RHRLcJ8MRhaWmI5XIIWbcuboRxtnVnvAGjutUS/i7Hz9NQ4AyAMRs/
         z75JAL2bK+oxaagQ32ubOL+BxWl1y9N5ZtHloDwYWV1aZV3yxnkTx4zbMuw0YuZs26tC
         l8iA==
X-Gm-Message-State: AOJu0YwUKYtlA+yqqPRTvFyMF+8LpEZ0TRaD2D6ivtlvNYKz8dKTHdPU
	CAbTLEuqokpKYqZuVv7rSiQj0aAt9FfKJoWg1QmAXdr7
X-Google-Smtp-Source: AGHT+IEsHiKlK9HE08vhqZfo4wrykV5bi0Vi432TOQ2yhLKXR3715NZW4svPRGrQlTT/2rkPIr3ifJWq63Tq/Ev82gM=
X-Received: by 2002:aa7:c508:0:b0:534:78a6:36c4 with SMTP id
 o8-20020aa7c508000000b0053478a636c4mr25369053edq.36.1697231500451; Fri, 13
 Oct 2023 14:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzrrwptf.fsf@toke.dk>
In-Reply-To: <87jzrrwptf.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 14:11:28 -0700
Message-ID: <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Mohamed Mahmoud <mmahmoud@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 1:25=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Hi Andrii
>
> Mohamed ran into what appears to be a verifier bug related to your
> commit:
>
> fde2a3882bd0 ("bpf: support precision propagation in the presence of subp=
rogs")
>
> So I figured you'd be the person to ask about this :)
>
> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora 38,
> and 6.5.5 on my Arch machine):
>
> INFO[0000] Verifier error: load program: bad address:
>         1861: frame2: R1_w=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=3D=
scalar(umin=3D17,umax=3D255,var_off=3D(0x0; 0xff)) R4_w=3Dfp-96 R6_w=3Dfp-9=
6 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>         ; switch (protocol) {
>         1861: (15) if r3 =3D=3D 0x11 goto pc+22 1884: frame2: R1_w=3Dfp-1=
60 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=3D17 R4_w=3Dfp-96 R6_w=3Dfp-96 R7_w=
=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>         1884: (bf) r3 =3D r7                    ; frame2: R3_w=3Dpkt(off=
=3D34,r=3D34,imm=3D0) R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0)
>         1885: (07) r3 +=3D 8                    ; frame2: R3_w=3Dpkt(off=
=3D42,r=3D34,imm=3D0)
>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=3Dpkt_end(of=
f=3D0,imm=3D0) R3_w=3Dpkt(off=3D42,r=3D42,imm=3D0)
>         ; id->src_port =3D bpf_ntohs(udp->source);
>         1887: (69) r2 =3D *(u16 *)(r7 +0)       ; frame2: R2_w=3Dscalar(u=
max=3D65535,var_off=3D(0x0; 0xffff)) R7_w=3Dpkt(off=3D34,r=3D42,imm=3D0)
>         1888: (bf) r3 =3D r2                    ; frame2: R2_w=3Dscalar(i=
d=3D103,umax=3D65535,var_off=3D(0x0; 0xffff)) R3_w=3Dscalar(id=3D103,umax=
=3D65535,var_off=3D(0x0; 0xffff))
>         1889: (dc) r3 =3D be16 r3               ; frame2: R3_w=3Dscalar()
>         ; id->src_port =3D bpf_ntohs(udp->source);
>         1890: (73) *(u8 *)(r1 +47) =3D r3       ; frame2: R1_w=3Dfp-160 R=
3_w=3Dscalar()
>         ; id->src_port =3D bpf_ntohs(udp->source);
>         1891: (dc) r2 =3D be64 r2               ; frame2: R2_w=3Dscalar()
>         ; id->src_port =3D bpf_ntohs(udp->source);
>         1892: (77) r2 >>=3D 56                  ; frame2: R2_w=3Dscalar(u=
max=3D255,var_off=3D(0x0; 0xff))
>         1893: (73) *(u8 *)(r1 +48) =3D r2
>         BUG regs 1
>         processed 5121 insns (limit 1000000) max_states_per_insn 4 total_=
states 92 peak_states 90 mark_read 20
>         (truncated)  component=3Debpf.FlowFetcher
>
> Dmesg says:
>
> [252431.093126] verifier backtracking bug
> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.c:3533=
 __mark_chain_precision+0xe83/0x1090
>
>
> The splat appears when trying to run the netobserv-ebpf-agent. Steps to
> reproduce:
>
> git clone https://github.com/netobserv/netobserv-ebpf-agent
> cd netobserv-ebpf-agent && make compile
> sudo FLOWS_TARGET_HOST=3D127.0.0.1 FLOWS_TARGET_PORT=3D9999 ./bin/netobse=
rv-ebpf-agent
>
> (It needs a 'make generate' before the compile to recompile the BPF
> program itself, but that requires the Cilium bpf2go program to be
> installed and there's a binary version checked into the tree so that is
> not strictly necessary to reproduce the splat).
>
> That project uses the Cilium Go eBPF loader. Interestingly, loading the
> same program using tc (with libbpf 1.2.2) works just fine:
>
> ip link add type veth
> tc qdisc add dev veth0 clsact
> tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_bpfel.o=
 sec tc_egress
>
> So maybe there is some massaging of the object file that libbpf is doing
> but the Go library isn't, that prevents this bug from triggering? I'm
> only guessing here, I don't really know exactly what the Go library is
> doing under the hood.
>
> Anyway, I guess this is a kernel bug in any case since that WARN() is
> there; could you please take a look?
>

Yes, I tried. Unfortunately I can't build netobserv-ebpf-agent on my
dev machine and can't run it. I tried to load bpf_bpfel.o through
veristat, but unfortunately it is not libbpf-compatible.

Is there some way to get a full verifier log for the failure above?
with log_level 2, if possible? If you can share it through Github Gist
or something like that, I'd really appreciate it. Thanks!

> Thanks!
>
> -Toke
>

