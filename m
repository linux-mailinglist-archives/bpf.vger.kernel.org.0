Return-Path: <bpf+bounces-12380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B931D7CBA28
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A943E1C20ADB
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4690C132;
	Tue, 17 Oct 2023 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8XJPdT7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979ABBE58
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:33:27 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA1E8
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:33:26 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1e10507a4d6so3743840fac.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697520805; x=1698125605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P38aSuYqnPQJjIODIk516zte+lSxGekZmgs+cEOkJrY=;
        b=g8XJPdT7VSIV1kID9SFYkRhm5lHcEX4X98vOtU6xv3YB3khgWEK6hGqWGVRn3kaVsW
         xVIOn94SKL5DrCGVzPXiO/JPMIkFMCDxR6tKVBE32aubR+f87+0bJgb6FdJj+4rytm4x
         zxBZfE5Ou+k/lf0+6U4SvcndlqitzRWscooiYcnHZZBhTOkr5qtiZf11VnYdx/GvMbTH
         hZiAw3ZiiQchBm6ycgtp/1PK9nIweBrrqBe+kumDiBErWVz2DXFJVX6wZ0BCpbXnERF/
         OL/pv9pGEPJpoYHWHK90Zfhnjq+9PJl9jfoIYSxIwDgZ7hr0V5MLc5zyYE+O9mSR/xYL
         ZfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697520805; x=1698125605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P38aSuYqnPQJjIODIk516zte+lSxGekZmgs+cEOkJrY=;
        b=suzMHP3dUhAd3YGf4AycEACQyZaZOtqVXRG83yIxGRcKFMWcwIekMo0syAp1sqa63l
         wmbSK/iaVF+HmPw/V/hJ+kM3h9n3MA+acRqeQhEZ4gQASTU2f7fx1CJyRToPiFWFGIdX
         9PhvT7WdDUycduLCnlI5FKV1aGLUdzMlyjaVpJp3UyJC3JSOmPI1k8ZWANxmW0hDgSqX
         FUy+bPdWzesrZbI0KFlvVGxyLo+66gq+QCXSbe4aeEii9xBjZd4K27dadt3C+fqfuRf4
         uo7pMrIIE/41j4KgUtvH5F0MMNfuLh/uIvnQO6Fs+as281ryehqMKJuqA80k85/Wv3QU
         A4yQ==
X-Gm-Message-State: AOJu0Yz/8qBLQ6MB+lmCHLMgi8BtT9mzT260WNlrSG37N/Dh+Qy6npKW
	uqZZPqx98PSlHiaWPQdPc4fppzWpUfBFupMXJ10=
X-Google-Smtp-Source: AGHT+IHwCDwDSF6AV258KNcNse5VH5NlKvNQmYq/4jTUOdDqOmubCACRQ7zbBJZ/My8jjmr8WhxrsvmsvyFLR44fbS0=
X-Received: by 2002:a05:6870:8a14:b0:1e9:919d:83ec with SMTP id
 p20-20020a0568708a1400b001e9919d83ecmr1357117oaq.28.1697520805495; Mon, 16
 Oct 2023 22:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzrrwptf.fsf@toke.dk>
In-Reply-To: <87jzrrwptf.fsf@toke.dk>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 17 Oct 2023 13:33:14 +0800
Message-ID: <CAEyhmHTbc1VO2_maxCA_EsNgek1UigGW-KL5n5pv7ERv6NVTBw@mail.gmail.com>
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

On Fri, Oct 13, 2023 at 4:25=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
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

Interesting, have you tried https://github.com/cilium/ebpf/pull/1159 ?

> Anyway, I guess this is a kernel bug in any case since that WARN() is
> there; could you please take a look?
>
> Thanks!
>
> -Toke
>
>

