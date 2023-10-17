Return-Path: <bpf+bounces-12464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39127CC9D4
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FAF1C208E5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E745F75;
	Tue, 17 Oct 2023 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEyLy+rm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EE2D030
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 17:24:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78924A4
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697563485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhH/RTbtDKBCxpk3LBaqlbR0WcxqY4AGyQCM4VnKuVA=;
	b=ZEyLy+rm8FbpWn1B8lNOr/wT1fEjLPtpwZZ53B7+paeNOOZrDHMLhNiRyrjjC7fTlWHAXM
	NHUvG1Rg0hHtIsXPycU3lVwpvXA74hDGq+hUfDduUXBotSvpSQhtZU3KbKV82Z8Z2+jVEP
	a6r2LSsM3T3cZwc5Cm/mOM2uowRhZTk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-EyKLK5XaON2B-7IdhvYykA-1; Tue, 17 Oct 2023 13:24:44 -0400
X-MC-Unique: EyKLK5XaON2B-7IdhvYykA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a7e4745acdso92113127b3.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 10:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563484; x=1698168284;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhH/RTbtDKBCxpk3LBaqlbR0WcxqY4AGyQCM4VnKuVA=;
        b=YbK8AcF6vN29U8QCZ5lkwdXq0tkCiQKLoiFpeXaU+4n/T586C1nXxhBVzM+E5XJM+Y
         h2Mq6ZjWQ5JkLhQd8B+j9i9I6ZNyLkb0OUI+UY1ylyIAKszXgm8tNAZTtNnLbkXYyH2H
         NbmeJ+tsyRnyRcz1lsZ9qKE0EPFZhxugp5+e2G9MX+0UKFKnJ6SF4TvY9cPhnLIJSbvs
         2/Dn7M9qkN3wh1SmX3zTqb/XpehZeFteP4rjzw3B25ikt/HPjJ2fKfx3IRJX94JCfUn2
         LAHAW06dKaTdCRwTejKAYVMzm9MLCnAKQoGrlocZ3d+1RBlcFuGF5hYgZ8Js1MVDzTW4
         rOOQ==
X-Gm-Message-State: AOJu0Ywm3Gh2/GPrGlEW6JSr0r07ZVxMmgLmm4TU5djL0ED+vf+TxF3U
	MPCuIaaaW4TzBSDgdaD+DmktxE7pf40+qko2xErA0S1C+CsApb1goiSsm5ejKznYwFahvcjlLDw
	07nIVt/i1057S
X-Received: by 2002:a25:f303:0:b0:d9b:4bfd:b75 with SMTP id c3-20020a25f303000000b00d9b4bfd0b75mr2334062ybs.18.1697563483722;
        Tue, 17 Oct 2023 10:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb01R9i87CPtT2NGsn8iI5+i2E5BjU5QTzwak8N4UCwvECSi75hQmN0RK6aVKPVxEDE5b7Ag==
X-Received: by 2002:a25:f303:0:b0:d9b:4bfd:b75 with SMTP id c3-20020a25f303000000b00d9b4bfd0b75mr2334050ybs.18.1697563483449;
        Tue, 17 Oct 2023 10:24:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e142-20020a25d394000000b00d9a4aad7f40sm661978ybf.24.2023.10.17.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 10:24:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 90E36EB2227; Tue, 17 Oct 2023 19:24:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, Mohamed Mahmoud
 <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
In-Reply-To: <ZS6nnJRuI22tgI4D@u94a>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk> <ZS6nnJRuI22tgI4D@u94a>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 17 Oct 2023 19:24:40 +0200
Message-ID: <87fs29uppj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:

> On Tue, Oct 17, 2023 at 01:08:25PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>=20
>> > On Mon, Oct 16, 2023 at 12:37=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > On Thu, Oct 12, 2023 at 1:25=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rg=
ensen <toke@redhat.com> wrote:
>> >> >>
>> >> >> Hi Andrii
>> >> >>
>> >> >> Mohamed ran into what appears to be a verifier bug related to your
>> >> >> commit:
>> >> >>
>> >> >> fde2a3882bd0 ("bpf: support precision propagation in the presence =
of subprogs")
>> >> >>
>> >> >> So I figured you'd be the person to ask about this :)
>> >> >>
>> >> >> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora=
 38,
>> >> >> and 6.5.5 on my Arch machine):
>> >> >>
>> >> >> INFO[0000] Verifier error: load program: bad address:
>> >> >>         1861: frame2: R1_w=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0=
) R3=3Dscalar(umin=3D17,umax=3D255,var_off=3D(0x0; 0xff)) R4_w=3Dfp-96 R6_w=
=3Dfp-96 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>> >> >>         ; switch (protocol) {
>> >> >>         1861: (15) if r3 =3D=3D 0x11 goto pc+22 1884: frame2: R1_w=
=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=3D17 R4_w=3Dfp-96 R6_w=3Dfp-96=
 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>> >> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>> >> >>         1884: (bf) r3 =3D r7                    ; frame2: R3_w=3Dp=
kt(off=3D34,r=3D34,imm=3D0) R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0)
>> >> >>         1885: (07) r3 +=3D 8                    ; frame2: R3_w=3Dp=
kt(off=3D42,r=3D34,imm=3D0)
>> >> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>> >> >>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=3Dpkt=
_end(off=3D0,imm=3D0) R3_w=3Dpkt(off=3D42,r=3D42,imm=3D0)
>> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >>         1887: (69) r2 =3D *(u16 *)(r7 +0)       ; frame2: R2_w=3Ds=
calar(umax=3D65535,var_off=3D(0x0; 0xffff)) R7_w=3Dpkt(off=3D34,r=3D42,imm=
=3D0)
>> >> >>         1888: (bf) r3 =3D r2                    ; frame2: R2_w=3Ds=
calar(id=3D103,umax=3D65535,var_off=3D(0x0; 0xffff)) R3_w=3Dscalar(id=3D103=
,umax=3D65535,var_off=3D(0x0; 0xffff))
>> >> >>         1889: (dc) r3 =3D be16 r3               ; frame2: R3_w=3Ds=
calar()
>> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >>         1890: (73) *(u8 *)(r1 +47) =3D r3       ; frame2: R1_w=3Df=
p-160 R3_w=3Dscalar()
>> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >>         1891: (dc) r2 =3D be64 r2               ; frame2: R2_w=3Ds=
calar()
>> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >>         1892: (77) r2 >>=3D 56                  ; frame2: R2_w=3Ds=
calar(umax=3D255,var_off=3D(0x0; 0xff))
>> >> >>         1893: (73) *(u8 *)(r1 +48) =3D r2
>> >> >>         BUG regs 1
>> >> >>         processed 5121 insns (limit 1000000) max_states_per_insn 4=
 total_states 92 peak_states 90 mark_read 20
>> >> >>         (truncated)  component=3Debpf.FlowFetcher
>> >> >>
>> >> >> Dmesg says:
>> >> >>
>> >> >> [252431.093126] verifier backtracking bug
>> >> >> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier=
.c:3533 __mark_chain_precision+0xe83/0x1090
>> >> >>
>> >> >>
>> >> >> The splat appears when trying to run the netobserv-ebpf-agent. Ste=
ps to
>> >> >> reproduce:
>> >> >>
>> >> >> git clone https://github.com/netobserv/netobserv-ebpf-agent
>> >> >> cd netobserv-ebpf-agent && make compile
>> >> >> sudo FLOWS_TARGET_HOST=3D127.0.0.1 FLOWS_TARGET_PORT=3D9999 ./bin/=
netobserv-ebpf-agent
>> >> >>
>> >> >> (It needs a 'make generate' before the compile to recompile the BPF
>> >> >> program itself, but that requires the Cilium bpf2go program to be
>> >> >> installed and there's a binary version checked into the tree so th=
at is
>> >> >> not strictly necessary to reproduce the splat).
>> >> >>
>> >> >> That project uses the Cilium Go eBPF loader. Interestingly, loadin=
g the
>> >> >> same program using tc (with libbpf 1.2.2) works just fine:
>> >> >>
>> >> >> ip link add type veth
>> >> >> tc qdisc add dev veth0 clsact
>> >> >> tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_=
bpfel.o sec tc_egress
>> >> >>
>> >> >> So maybe there is some massaging of the object file that libbpf is=
 doing
>> >> >> but the Go library isn't, that prevents this bug from triggering? =
I'm
>> >> >> only guessing here, I don't really know exactly what the Go librar=
y is
>> >> >> doing under the hood.
>> >> >>
>> >> >> Anyway, I guess this is a kernel bug in any case since that WARN()=
 is
>> >> >> there; could you please take a look?
>> >> >>
>> >> >
>> >> > Yes, I tried. Unfortunately I can't build netobserv-ebpf-agent on my
>> >> > dev machine and can't run it. I tried to load bpf_bpfel.o through
>> >> > veristat, but unfortunately it is not libbpf-compatible.
>> >> >
>> >> > Is there some way to get a full verifier log for the failure above?
>> >> > with log_level 2, if possible? If you can share it through Github G=
ist
>> >> > or something like that, I'd really appreciate it. Thanks!
>> >>
>> >> Sure, here you go:
>> >> https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d
>> >
>> > Thanks, this is very useful. And it's pretty clear what happens from
>> > last few lines:
>> >
>> >     mark_precise: frame2: regs=3Dr2 stack=3D before 1890: (dc) r2 =3D =
be64 r2
>> >     mark_precise: frame2: regs=3Dr0,r2 stack=3D before 1889: (73) *(u8
>> > *)(r1 +47) =3D r3
>> >
>> > See how we add r0 to the regs set, while there is no r0 involved in
>> > `r2 =3D be64 r2`? I think it's just a missing case of handling BPF_END
>> > (and perhaps BPF_NEG as well) instructions in backtrack_insn(). Should
>> > be a trivial fix, though ideally we should also add some test for this
>> > as well.
>>=20
>> Sounds good, thank you for looking into it! Let me know if you need me
>> to test a patch :)
>
> Patch based on Andrii's analysis.
>
> Given that both BPF_END and BPF_NEG always operates on dst_reg itself
> and that bt_is_reg_set(bt, dreg) was already checked I believe we can
> just return with no futher action.

Alright, manually applied this to bpf-next and indeed this enables the
netobserv-bpf-agent to load successfully. Care to submit a formal patch?
In that case please add my:

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Thanks!

-Toke


