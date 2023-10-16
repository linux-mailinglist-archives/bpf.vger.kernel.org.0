Return-Path: <bpf+bounces-12350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C47CB48F
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B026D1F22873
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A5374F7;
	Mon, 16 Oct 2023 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkngrN29"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7C358BB
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:22:42 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F983
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:22:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so8679375a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487757; x=1698092557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3kjo/1E31pPKTjFfp7vIvJLbh5kZHXNr9DKleX/sO8=;
        b=AkngrN29w4asbQ/xxf86QVFwCPZfMrTLmQ8TVbLv2NXvB6YNXRmoVifZUFdNBKdq3v
         8cAgBsLe/HfcSIegfApZDCBcAJs8DA/lHocXrl+/rOP297g8P4aUmEc4uExZDEFKlocL
         ycrqwsO27MJNHPmNaw/HPhqbL/lmIWw1MnaJQxqrvInlgS5VCMbweu9aS3bAtpCPo3iR
         Pe7PDnUNLLvWQTvOZsm4vyrWvGFKa8+/E0JP0urs2LwFUmNO+edOUMQ/w3n/HWuWbVCr
         oGOKFx/3NMKw9swYmUygjfKKLsAXdT0WFbLzcr7vhPVxIIg9SUrciUSQ0TOEjmw6o0+z
         geLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487757; x=1698092557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3kjo/1E31pPKTjFfp7vIvJLbh5kZHXNr9DKleX/sO8=;
        b=RtKhPkoMq0K52xdkCDZyYWOjKCcdVeCEf2tLK9u9sevXvR7vfeYYRy1t3eIKkWDkRm
         NefUS4zI3ZwzRQVVjxLSxK+/F6XAcjHlRLqEgd7lj5DEGFfAjmqWNvn/u3eabWxxrNdC
         2S4V62sVOVHmviXNXHRDtllsiAUpWDpPRxu1cPqA38FAZ8tgiPfpp1oxt9RkVMj7NW5R
         CM0UGKwQo1ebX2MG255JJCqiHUNGg7d0cOf+/2U6ZuwtBwUU5RnqF5j7Xc0VwBIAD/7I
         EBa/GQSQu+KQN6bp3NIzE0ChJaZUowOGf4dPlcnSt4nNX8F+YHBtG11nVIYIMgboKlK3
         7+xA==
X-Gm-Message-State: AOJu0Yw84tcKOdOdhjm3uqj8PdWbWeq7BlnZ9mXryrIGB3AQjUkmnn6K
	InH5dUb7Kpnat9B1vhZlO71aRuejDbRcqw2BBbQqwVxEdVY=
X-Google-Smtp-Source: AGHT+IEQ05So7GV/SrRqdnX0d8TnffYFyoH99Q1MsLqPb8orlIbGwnddVBHATaDXhZEwo4PKk9qLISixBV8e70LQ4O0=
X-Received: by 2002:a50:d5dc:0:b0:53e:8e09:cb8 with SMTP id
 g28-20020a50d5dc000000b0053e8e090cb8mr251792edj.23.1697487756713; Mon, 16 Oct
 2023 13:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzrrwptf.fsf@toke.dk> <CAEf4BzaC3ZohtcRhKQRCjdiou3=KcfDvRnF6RN55BTZx+jNqhg@mail.gmail.com>
 <87sf6auzok.fsf@toke.dk>
In-Reply-To: <87sf6auzok.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Oct 2023 13:22:23 -0700
Message-ID: <CAEf4BzaAjisHpVikUNb5sQDdQwNheNJRojoauQvAPppMQJhK9g@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 12:37=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Oct 12, 2023 at 1:25=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>
> >> Hi Andrii
> >>
> >> Mohamed ran into what appears to be a verifier bug related to your
> >> commit:
> >>
> >> fde2a3882bd0 ("bpf: support precision propagation in the presence of s=
ubprogs")
> >>
> >> So I figured you'd be the person to ask about this :)
> >>
> >> The issue appears on a vanilla 6.5 kernel (on both 6.5.6 on Fedora 38,
> >> and 6.5.5 on my Arch machine):
> >>
> >> INFO[0000] Verifier error: load program: bad address:
> >>         1861: frame2: R1_w=3Dfp-160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=
=3Dscalar(umin=3D17,umax=3D255,var_off=3D(0x0; 0xff)) R4_w=3Dfp-96 R6_w=3Df=
p-96 R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
> >>         ; switch (protocol) {
> >>         1861: (15) if r3 =3D=3D 0x11 goto pc+22 1884: frame2: R1_w=3Df=
p-160 R2_w=3Dpkt_end(off=3D0,imm=3D0) R3=3D17 R4_w=3Dfp-96 R6_w=3Dfp-96 R7_=
w=3Dpkt(off=3D34,r=3D34,imm=3D0) R10=3Dfp0
> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
> >>         1884: (bf) r3 =3D r7                    ; frame2: R3_w=3Dpkt(o=
ff=3D34,r=3D34,imm=3D0) R7_w=3Dpkt(off=3D34,r=3D34,imm=3D0)
> >>         1885: (07) r3 +=3D 8                    ; frame2: R3_w=3Dpkt(o=
ff=3D42,r=3D34,imm=3D0)
> >>         ; if ((void *)udp + sizeof(*udp) <=3D data_end) {
> >>         1886: (2d) if r3 > r2 goto pc+23      ; frame2: R2_w=3Dpkt_end=
(off=3D0,imm=3D0) R3_w=3Dpkt(off=3D42,r=3D42,imm=3D0)
> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >>         1887: (69) r2 =3D *(u16 *)(r7 +0)       ; frame2: R2_w=3Dscala=
r(umax=3D65535,var_off=3D(0x0; 0xffff)) R7_w=3Dpkt(off=3D34,r=3D42,imm=3D0)
> >>         1888: (bf) r3 =3D r2                    ; frame2: R2_w=3Dscala=
r(id=3D103,umax=3D65535,var_off=3D(0x0; 0xffff)) R3_w=3Dscalar(id=3D103,uma=
x=3D65535,var_off=3D(0x0; 0xffff))
> >>         1889: (dc) r3 =3D be16 r3               ; frame2: R3_w=3Dscala=
r()
> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >>         1890: (73) *(u8 *)(r1 +47) =3D r3       ; frame2: R1_w=3Dfp-16=
0 R3_w=3Dscalar()
> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >>         1891: (dc) r2 =3D be64 r2               ; frame2: R2_w=3Dscala=
r()
> >>         ; id->src_port =3D bpf_ntohs(udp->source);
> >>         1892: (77) r2 >>=3D 56                  ; frame2: R2_w=3Dscala=
r(umax=3D255,var_off=3D(0x0; 0xff))
> >>         1893: (73) *(u8 *)(r1 +48) =3D r2
> >>         BUG regs 1
> >>         processed 5121 insns (limit 1000000) max_states_per_insn 4 tot=
al_states 92 peak_states 90 mark_read 20
> >>         (truncated)  component=3Debpf.FlowFetcher
> >>
> >> Dmesg says:
> >>
> >> [252431.093126] verifier backtracking bug
> >> [252431.093129] WARNING: CPU: 3 PID: 302245 at kernel/bpf/verifier.c:3=
533 __mark_chain_precision+0xe83/0x1090
> >>
> >>
> >> The splat appears when trying to run the netobserv-ebpf-agent. Steps t=
o
> >> reproduce:
> >>
> >> git clone https://github.com/netobserv/netobserv-ebpf-agent
> >> cd netobserv-ebpf-agent && make compile
> >> sudo FLOWS_TARGET_HOST=3D127.0.0.1 FLOWS_TARGET_PORT=3D9999 ./bin/neto=
bserv-ebpf-agent
> >>
> >> (It needs a 'make generate' before the compile to recompile the BPF
> >> program itself, but that requires the Cilium bpf2go program to be
> >> installed and there's a binary version checked into the tree so that i=
s
> >> not strictly necessary to reproduce the splat).
> >>
> >> That project uses the Cilium Go eBPF loader. Interestingly, loading th=
e
> >> same program using tc (with libbpf 1.2.2) works just fine:
> >>
> >> ip link add type veth
> >> tc qdisc add dev veth0 clsact
> >> tc filter add dev veth0 egress bpf direct-action obj pkg/ebpf/bpf_bpfe=
l.o sec tc_egress
> >>
> >> So maybe there is some massaging of the object file that libbpf is doi=
ng
> >> but the Go library isn't, that prevents this bug from triggering? I'm
> >> only guessing here, I don't really know exactly what the Go library is
> >> doing under the hood.
> >>
> >> Anyway, I guess this is a kernel bug in any case since that WARN() is
> >> there; could you please take a look?
> >>
> >
> > Yes, I tried. Unfortunately I can't build netobserv-ebpf-agent on my
> > dev machine and can't run it. I tried to load bpf_bpfel.o through
> > veristat, but unfortunately it is not libbpf-compatible.
> >
> > Is there some way to get a full verifier log for the failure above?
> > with log_level 2, if possible? If you can share it through Github Gist
> > or something like that, I'd really appreciate it. Thanks!
>
> Sure, here you go:
> https://gist.github.com/tohojo/31173d2bb07262a21393f76d9a45132d

Thanks, this is very useful. And it's pretty clear what happens from
last few lines:

    mark_precise: frame2: regs=3Dr2 stack=3D before 1890: (dc) r2 =3D be64 =
r2
    mark_precise: frame2: regs=3Dr0,r2 stack=3D before 1889: (73) *(u8
*)(r1 +47) =3D r3

See how we add r0 to the regs set, while there is no r0 involved in
`r2 =3D be64 r2`? I think it's just a missing case of handling BPF_END
(and perhaps BPF_NEG as well) instructions in backtrack_insn(). Should
be a trivial fix, though ideally we should also add some test for this
as well.

>
> -Toke
>

