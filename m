Return-Path: <bpf+bounces-12404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B977CC2CA
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA797B20AC2
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A541E5A;
	Tue, 17 Oct 2023 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N24OxsQz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6141946A
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:17:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586321A6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697545029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOG8Qdzj+S+0QmAirIeqO8mwxiboEVQPS3M71m1d9BA=;
	b=N24OxsQz8eM3mudSCITCVhga1Hmtb7jSUQCcDwut5Q5QoeSFe/kRKIEkwsHWA0Jir/M5yq
	MwV6qPyhopyRbaBA5COQDSCuu7rLWax83iwFppbaXur0yAKT357c4cAxSm0pOWKQYe62uQ
	Ce0SXdXLxSTQwebApIPt+X2/z6mEQyY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-BqcmciNzPfyqVy3q5HhKjg-1; Tue, 17 Oct 2023 08:17:07 -0400
X-MC-Unique: BqcmciNzPfyqVy3q5HhKjg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c4ecdd6dc9so6638474a34.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697545027; x=1698149827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOG8Qdzj+S+0QmAirIeqO8mwxiboEVQPS3M71m1d9BA=;
        b=MIkxFCNrDyr+3dpdt7OdDQEVvzVy+5itMV/qQRt+yQ7NXtlX3PEEQ2Admeqgu5DRrv
         RxiJ2zwC0GcbzFooNMHGxPFMhs2OrTpqentg4pq6HQkVgtXsnnfXcw+V03/6LuQFn/et
         wH+26mtl7HoYDRw5B+tLY8ZkXJy4j+wXIISR9Ng3CrUiG+q4xil0oA/WkiK375vKrwZM
         P4Vb/Tcf/UowiwwiBmPKPPVFF4GhbdPu5PFPsyJvITpbQBilkmZLJcrDAz/x11qZGlRB
         R1/1/6fCaVNNakTXascWwNI+Pa0VrevBKs9eFz7VYSkc8WZ8xBncOO3bEDwSWLWtSudi
         l4Og==
X-Gm-Message-State: AOJu0YzXj3Z4LnGuojBehoTe+Fc9qcu8ciLfVBzBdGt9nPKKkAs9Verm
	c7EbjHbAjEowKHq/bhrRspwPXTkMtstyWRAmmEHgxKSptHoR3GiC6A8niXh4XcyBSB8oVrhCYFH
	XEXYUEXQSX7MvMuyH8IiLAOVOjBPM
X-Received: by 2002:a05:6830:314a:b0:6b8:9932:b8ad with SMTP id c10-20020a056830314a00b006b89932b8admr2513981ots.1.1697545026960;
        Tue, 17 Oct 2023 05:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETGbP4wUEB2KpcTN9I/djW9UHbD+A95G1tubGY2GQm/mzZcpbB9Jy6du5FqPOIv59jKCJLigNpqLGuzJweEvw=
X-Received: by 2002:a05:6830:314a:b0:6b8:9932:b8ad with SMTP id
 c10-20020a056830314a00b006b89932b8admr2513967ots.1.1697545026712; Tue, 17 Oct
 2023 05:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzrrwptf.fsf@toke.dk> <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk> <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk>
In-Reply-To: <87il75v74m.fsf@toke.dk>
From: Mohamed Mahmoud <mmahmoud@redhat.com>
Date: Tue, 17 Oct 2023 08:16:55 -0400
Message-ID: <CAP6g7JL-tPZgtKy-+io0L03D4201saqKT5FUBMC5Ph+uYnfu5Q@mail.gmail.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Any idea why the same verification errors are not seen when the
program is attached with bpftool ?

Thanks!
Mohamed


On Tue, Oct 17, 2023 at 7:08=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Mon, Oct 16, 2023 at 12:37=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Thu, Oct 12, 2023 at 1:25=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@redhat.com> wrote:
> >> >>
> >> >> Hi Andrii
> >> >>
> >> >> Mohamed ran into what appears to be a verifier bug related to your
> >> >> commit:
> >> >>
> >> >> fde2a3882bd0 ("bpf: support precision propagation in the presence o=
f subprogs")
> >> >>
> >> >> So I figured you'd be the person to ask about this :)
> >> >>
> >> >> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora =
38,
> >> >> and 6.5.5 on my Arch machine):
> >> >>
> >> >> INFO[0000] Verifier error: load program: bad address:
> >> >>         1861: frame2: R1_w=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0)=
 R3=3Dscalar(umin=3D17,umax=3D255,var_off=3D(0x0; 0xff)) R4_w=3Dfp-96 R6_w=
=3Dfp-96 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
> >> >>         ; switch (protocol) {
> >> >>         1861: (15) if r3 =3D=3D 0x11 goto pc+22 1884: frame2: R1_w=
=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=3D17 R4_w=3Dfp-96 R6_w=3Dfp-96=
 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
> >> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
> >> >>         1884: (bf) r3 =3D r7                    ; frame2: R3_w=3Dpk=
t(off=3D34,r=3D34,imm=3D0) R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0)
> >> >>         1885: (07) r3 +=3D 8                    ; frame2: R3_w=3Dpk=
t(off=3D42,r=3D34,imm=3D0)
> >> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
> >> >>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=3Dpkt_=
end(off=3D0,imm=3D0) R3_w=3Dpkt(off=3D42,r=3D42,imm=3D0)
> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >> >>         1887: (69) r2 =3D *(u16 *)(r7 +0)       ; frame2: R2_w=3Dsc=
alar(umax=3D65535,var_off=3D(0x0; 0xffff)) R7_w=3Dpkt(off=3D34,r=3D42,imm=
=3D0)
> >> >>         1888: (bf) r3 =3D r2                    ; frame2: R2_w=3Dsc=
alar(id=3D103,umax=3D65535,var_off=3D(0x0; 0xffff)) R3_w=3Dscalar(id=3D103,=
umax=3D65535,var_off=3D(0x0; 0xffff))
> >> >>         1889: (dc) r3 =3D be16 r3               ; frame2: R3_w=3Dsc=
alar()
> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >> >>         1890: (73) *(u8 *)(r1 +47) =3D r3       ; frame2: R1_w=3Dfp=
-160 R3_w=3Dscalar()
> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >> >>         1891: (dc) r2 =3D be64 r2               ; frame2: R2_w=3Dsc=
alar()
> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >> >>         1892: (77) r2 >>=3D 56                  ; frame2: R2_w=3Dsc=
alar(umax=3D255,var_off=3D(0x0; 0xff))
> >> >>         1893: (73) *(u8 *)(r1 +48) =3D r2
> >> >>         BUG regs 1
> >> >>         processed 5121 insns (limit 1000000) max_states_per_insn 4 =
total_states 92 peak_states 90 mark_read 20
> >> >>         (truncated)  component=3Debpf.FlowFetcher
> >> >>
> >> >> Dmesg says:
> >> >>
> >> >> [252431.093126] verifier backtracking bug
> >> >> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.=
c:3533 __mark_chain_precision+0xe83/0x1090
> >> >>
> >> >>
> >> >> The splat appears when trying to run the netobserv-ebpf-agent. Step=
s to
> >> >> reproduce:
> >> >>
> >> >> git clone https://github.com/netobserv/netobserv-ebpf-agent
> >> >> cd netobserv-ebpf-agent && make compile
> >> >> sudo FLOWS_TARGET_HOST=3D127.0.0.1 FLOWS_TARGET_PORT=3D9999 ./bin/n=
etobserv-ebpf-agent
> >> >>
> >> >> (It needs a 'make generate' before the compile to recompile the BPF
> >> >> program itself, but that requires the Cilium bpf2go program to be
> >> >> installed and there's a binary version checked into the tree so tha=
t is
> >> >> not strictly necessary to reproduce the splat).
> >> >>
> >> >> That project uses the Cilium Go eBPF loader. Interestingly, loading=
 the
> >> >> same program using tc (with libbpf 1.2.2) works just fine:
> >> >>
> >> >> ip link add type veth
> >> >> tc qdisc add dev veth0 clsact
> >> >> tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_b=
pfel.o sec tc_egress
> >> >>
> >> >> So maybe there is some massaging of the object file that libbpf is =
doing
> >> >> but the Go library isn't, that prevents this bug from triggering? I=
'm
> >> >> only guessing here, I don't really know exactly what the Go library=
 is
> >> >> doing under the hood.
> >> >>
> >> >> Anyway, I guess this is a kernel bug in any case since that WARN() =
is
> >> >> there; could you please take a look?
> >> >>
> >> >
> >> > Yes, I tried. Unfortunately I can't build netobserv-ebpf-agent on my
> >> > dev machine and can't run it. I tried to load bpf_bpfel.o through
> >> > veristat, but unfortunately it is not libbpf-compatible.
> >> >
> >> > Is there some way to get a full verifier log for the failure above?
> >> > with log_level 2, if possible? If you can share it through Github Gi=
st
> >> > or something like that, I'd really appreciate it. Thanks!
> >>
> >> Sure, here you go:
> >> https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d
> >
> > Thanks, this is very useful. And it's pretty clear what happens from
> > last few lines:
> >
> >     mark_precise: frame2: regs=3Dr2 stack=3D before 1890: (dc) r2 =3D b=
e64 r2
> >     mark_precise: frame2: regs=3Dr0,r2 stack=3D before 1889: (73) *(u8
> > *)(r1 +47) =3D r3
> >
> > See how we add r0 to the regs set, while there is no r0 involved in
> > `r2 =3D be64 r2`? I think it's just a missing case of handling BPF_END
> > (and perhaps BPF_NEG as well) instructions in backtrack_insn(). Should
> > be a trivial fix, though ideally we should also add some test for this
> > as well.
>
> Sounds good, thank you for looking into it! Let me know if you need me
> to test a patch :)
>
> -Toke
>


