Return-Path: <bpf+bounces-13614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862067DBC07
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 15:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267EB1F2209C
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F917981;
	Mon, 30 Oct 2023 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrVUO8sq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F115EB0
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 14:44:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC3CDB
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698677086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHeVaYA5ND81Ldxlkv31mo1kSupxrhdPQxyopuVjti8=;
	b=DrVUO8sqnOY6ZTr68z80kZBTtMycfLCBFONe4s4OpWtUJDb4PpfzV6Op/a3o6CYgqMBT/V
	F7bPHT7+oOuuSiWoseFSeS6/+cm+OyWCskK+PSwP34lWOtDfRa/+xTwgbCRzkMCqbKRcGN
	4xsekzwaDhVR4zRNPJTd1LZWdVmwq5k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-eQcQEWRGNPWiJFFW42epUA-1; Mon, 30 Oct 2023 10:44:44 -0400
X-MC-Unique: eQcQEWRGNPWiJFFW42epUA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bf1047cb28so336022066b.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 07:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677083; x=1699281883;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHeVaYA5ND81Ldxlkv31mo1kSupxrhdPQxyopuVjti8=;
        b=DyVmbxMjoiLivqcLUys0y/rLDC69x41UacZ9BD4wjK0f+yuiXoZTjY7oX9iPoTHziX
         Z33lmOaXqjEvg5LFMBVzIbrx1Qkrbc+2U/KN3JxwlD3AnbhNme0DT2XNHXXgXR2DSEsV
         vJf9kQVxAOFUfmEbxaycNHzO37xSYYCSQCA3SUib0zaM4X1HjUusTdSBY+wUoJSAvasl
         56/tICvJXgqlvpVSGxH783/lnH9kXDQw0P7oMr8NMWvyIrnwf+4NmNT+2T1IZ1Y3G89s
         zpitin8TSz4UmvIyR8mJe/4WllW+9kcrPzOs39zZXnxYlXcdWrheUFOkm0OQBClCnHXp
         gWTA==
X-Gm-Message-State: AOJu0Yxn+JvbpoYXyytwFKSDcRy5Q8Sdfy/OvOJl+rQ5rLqy7bBJJUC1
	osRrzbenD5HTcbRihKIXu6HygGyDZAO0i5qvcJTzFi5xoeJXu9cBVpt3aGR5xrP3ai9pDtJl/RL
	tKLPhtz6EkM9V
X-Received: by 2002:a17:907:7b96:b0:9bd:fc4b:6c9b with SMTP id ne22-20020a1709077b9600b009bdfc4b6c9bmr9313233ejc.36.1698677083603;
        Mon, 30 Oct 2023 07:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOzwdpByv5eMIfEZNQxod68TFiUj6yN235lERty487PVgJ9RdDWqxqIS7SQRCqG+vjb4e/Xw==
X-Received: by 2002:a17:907:7b96:b0:9bd:fc4b:6c9b with SMTP id ne22-20020a1709077b9600b009bdfc4b6c9bmr9313219ejc.36.1698677083289;
        Mon, 30 Oct 2023 07:44:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id sd2-20020a170906ce2200b009c762d89c76sm6035480ejb.0.2023.10.30.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:44:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7A5FBEE5ACB; Mon, 30 Oct 2023 15:44:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mohamed Mahmoud <mmahmoud@redhat.com>
Subject: Re: Hitting verifier backtracking bug on 6.5.5 kernel
In-Reply-To: <ZT-6upsxRUWVnTvV@u94a>
References: <87jzrrwptf.fsf@toke.dk>
 <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
 <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
 <87il75v74m.fsf@toke.dk> <ZS6nnJRuI22tgI4D@u94a> <87fs29uppj.fsf@toke.dk>
 <ZT-6upsxRUWVnTvV@u94a>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 30 Oct 2023 15:44:42 +0100
Message-ID: <8734xs2mqt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:

> On Tue, Oct 17, 2023 at 07:24:40PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
>> > On Tue, Oct 17, 2023 at 01:08:25PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >> > On Mon, Oct 16, 2023 at 12:37=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8r=
gensen <toke@redhat.com> wrote:
>> >> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >> >> > On Thu, Oct 12, 2023 at 1:25=E2=80=AFPM Toke H=C3=B8iland-J=C3=
=B8rgensen <toke@redhat.com> wrote:
>> >> >> >>
>> >> >> >> Hi Andrii
>> >> >> >>
>> >> >> >> Mohamed ran into what appears to be a verifier bug related to y=
our
>> >> >> >> commit:
>> >> >> >>
>> >> >> >> fde2a3882bd0 ("bpf: support precision propagation in the presen=
ce of subprogs")
>> >> >> >>
>> >> >> >> So I figured you'd be the person to ask about this :)
>> >> >> >>
>> >> >> >> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fed=
ora 38,
>> >> >> >> and 6.5.5 on my Arch machine):
>> >> >> >>
>> >> >> >> INFO[0000] Verifier error: load program: bad address:
>> >> >> >>         1861: frame2: R1_w=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=
=3D0) R3=3Dscalar(umin=3D17,umax=3D255,var_off=3D(0x0; 0xff)) R4_w=3Dfp-96 =
R6_w=3Dfp-96 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>> >> >> >>         ; switch (protocol) {
>> >> >> >>         1861: (15) if r3 =3D=3D 0x11 goto pc+22 1884: frame2: R=
1_w=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=3D17 R4_w=3Dfp-96 R6_w=3Dfp=
-96 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
>> >> >> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>> >> >> >>         1884: (bf) r3 =3D r7                    ; frame2: R3_w=
=3Dpkt(off=3D34,r=3D34,imm=3D0) R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0)
>> >> >> >>         1885: (07) r3 +=3D 8                    ; frame2: R3_w=
=3Dpkt(off=3D42,r=3D34,imm=3D0)
>> >> >> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
>> >> >> >>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=3D=
pkt_end(off=3D0,imm=3D0) R3_w=3Dpkt(off=3D42,r=3D42,imm=3D0)
>> >> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >> >>         1887: (69) r2 =3D *(u16 *)(r7 +0)       ; frame2: R2_w=
=3Dscalar(umax=3D65535,var_off=3D(0x0; 0xffff)) R7_w=3Dpkt(off=3D34,r=3D42,=
imm=3D0)
>> >> >> >>         1888: (bf) r3 =3D r2                    ; frame2: R2_w=
=3Dscalar(id=3D103,umax=3D65535,var_off=3D(0x0; 0xffff)) R3_w=3Dscalar(id=
=3D103,umax=3D65535,var_off=3D(0x0; 0xffff))
>> >> >> >>         1889: (dc) r3 =3D be16 r3               ; frame2: R3_w=
=3Dscalar()
>> >> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >> >>         1890: (73) *(u8 *)(r1 +47) =3D r3       ; frame2: R1_w=
=3Dfp-160 R3_w=3Dscalar()
>> >> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >> >>         1891: (dc) r2 =3D be64 r2               ; frame2: R2_w=
=3Dscalar()
>> >> >> >>         ; id->src_port =3D bpf_ntohs(udp->source);
>> >> >> >>         1892: (77) r2 >>=3D 56                  ; frame2: R2_w=
=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff))
>> >> >> >>         1893: (73) *(u8 *)(r1 +48) =3D r2
>> >> >> >>         BUG regs 1
>> >> >> >>         processed 5121 insns (limit 1000000) max_states_per_ins=
n 4 total_states 92 peak_states 90 mark_read 20
>> >> >> >>         (truncated)  component=3Debpf.FlowFetcher
>> >> >> >>
>> >> >> >> Dmesg says:
>> >> >> >>
>> >> >> >> [252431.093126] verifier backtracking bug
>> >> >> >> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verif=
ier.c:3533 __mark_chain_precision+0xe83/0x1090
>> >> >> >>
>> >> >> >> ...
>> >> >> >
>> >> >> > Is there some way to get a full verifier log for the failure abo=
ve?
>> >> >> > with log_level 2, if possible? If you can share it through Githu=
b Gist
>> >> >> > or something like that, I'd really appreciate it. Thanks!
>> >> >>
>> >> >> Sure, here you go:
>> >> >> https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d
>> >> >
>> >> > Thanks, this is very useful. And it's pretty clear what happens from
>> >> > last few lines:
>> >> >
>> >> >     mark_precise: frame2: regs=3Dr2 stack=3D before 1890: (dc) r2 =
=3D be64 r2
>> >> >     mark_precise: frame2: regs=3Dr0,r2 stack=3D before 1889: (73) *=
(u8
>> >> > *)(r1 +47) =3D r3
>> >> >
>> >> > See how we add r0 to the regs set, while there is no r0 involved in
>> >> > `r2 =3D be64 r2`? I think it's just a missing case of handling BPF_=
END
>> >> > (and perhaps BPF_NEG as well) instructions in backtrack_insn(). Sho=
uld
>> >> > be a trivial fix, though ideally we should also add some test for t=
his
>> >> > as well.
>
> Turns out the only case r0 is wrongly added to the regs set is with
> BPF_ALU | BPF_TO_BE | BPF_END like the one seen here (only realize this
> while working on selftests). All other cases are already handled correctly
> because they happens to fall into the BPF_SRC(insn->code) =3D=3D BPF_K =
=3D=3D 0 case.
>
>         } else {
>                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>                         bt_set_reg(bt, sreg);
>                 }
>                 /* BPF_NEG, BPF_ALU | BPF_TO_LE | BPF_END, and
>                  * BPF_ALU64 | BPF_END goes here in backtrack_insn()
>                  */
>         }
>
> That said, having a "if (opcode =3D=3D BPF_END || opcode =3D=3D BPF_NEG)"=
 check
> still makes more sense, so I'm sticking with that.
>
> RFC can be found at
>  https://lore.kernel.org/bpf/20231030132145.20867-1-shung-hsi.yu@suse.com/

Great, thanks for taking care of this! :)

-Toke


