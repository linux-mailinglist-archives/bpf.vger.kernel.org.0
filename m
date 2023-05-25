Return-Path: <bpf+bounces-1237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED97711266
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5B81C20B07
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935081DDDA;
	Thu, 25 May 2023 17:30:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C8168BA
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:30:16 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A44B6
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:30:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f5d651170so167356266b.1
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685035810; x=1687627810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMUYZW6Ufl6B/TEQr5549D9dxOs4cZy2wkRpAm149F0=;
        b=qfsbjWDphKuUtMy6YOy/eWXS7R126uDmQIlJ4S60ExIbDlckkpuE+anqP7um71hc1i
         C4PWUhqV8/a1kOKFX/3PB0aKhEtRo/Sb0orwdmmFyXrQc2lPIzWI65S3PKZ55tv7AWEp
         UpNz/wFxqcYsw4epbAj45LBcfAgWc4weK/Nz92zY3/NIrXX03Rm+mcabpI/RGZH8IkQq
         kofWJC3cdjQo0FQOCsdxX4jeSqU/sLGHC8Dl8KMexBJshJBzVTzc6fHgIiWhCiniA7Et
         P1aXVaw1XsfDZbJFYR09pny46/ZzDX9shSyRQiNPLUi80hac0T3Lr22Lvkmu6p7ljH7l
         jbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035810; x=1687627810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMUYZW6Ufl6B/TEQr5549D9dxOs4cZy2wkRpAm149F0=;
        b=b3pvLZtIA5kuMMpQAwjBbl2Ftl+qCehOieJqvGBI0xGeU5uN75R6bBRdHOa2i11o/J
         6vwIJaTb3zblecYaMN1W+6NMqdMXbb/MgArVX3jHyWxgYm5hHj8UsJX58GWX/vmNRkqY
         Zh6m7TNXxxzma2aY/88fcSj+cnFnzKXdkP4jAX+rP9WqBJWPb/3v67ZwgAgziscDMOjF
         cRm6Um/f/ESdO88ivlDf5LfPlWuQFVTIL5XVP+ttwbernSuaTrk/R5Zeoh7k2K84NsF9
         ntZgEvh7qabIZeSO3JSptH4T9uwt9a/jcC4tLiE4CvNMpMv/kzdf6y0g98T3CpVNhbkf
         UWYw==
X-Gm-Message-State: AC+VfDz+G8XfS2Tj9WuBl52JhfMP/r2IN0ftu4lKrhrazjT5TJ6JAxAp
	2H3ncr803SvxS51KA3Bn2htso0VQtCNulZdyeqQ=
X-Google-Smtp-Source: ACHHUZ4YD54StTAszh/wh0lnF8KRamyLU5dMR3FKBKrVH6OiC877qcTkbovoHQ+SNYaCkgIJoOghVJSFj+vJEDBYZT8=
X-Received: by 2002:a17:907:2da8:b0:965:aa65:233f with SMTP id
 gt40-20020a1709072da800b00965aa65233fmr2728299ejc.2.1685035809820; Thu, 25
 May 2023 10:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com> <ZGZQuqVD7gNjia7Z@krava>
 <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com> <CAADnVQ+xJVVbP8GC_iT3NgYhhyUxEWkT-kvNgRfDVyv4eyAgHA@mail.gmail.com>
 <CAEf4BzZZ1yP1_2zkGQnp_Zusn_z702eSi8h8ExEkTS8sfmk8_Q@mail.gmail.com>
 <ZG8huF4hD3uI0ajy@krava> <6cfc65a3-42f0-f520-fb24-026da60bdf3f@oracle.com>
In-Reply-To: <6cfc65a3-42f0-f520-fb24-026da60bdf3f@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 10:29:57 -0700
Message-ID: <CAEf4BzZq8K5fi3M-RN7uoShmJnmD9uPEc0BA8d6Dp3C=hF+XLQ@mail.gmail.com>
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Yonghong Song <yhs@meta.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yafang Shao <laoar.shao@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 3:20=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/05/2023 09:52, Jiri Olsa wrote:
> > On Mon, May 22, 2023 at 02:31:01PM -0700, Andrii Nakryiko wrote:
> >> On Thu, May 18, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>>
> >>> On Thu, May 18, 2023 at 11:26=E2=80=AFAM Yonghong Song <yhs@meta.com>=
 wrote:
> >>>>> I wonder now when the address will be stored as number (not string)=
 we
> >>>>> could somehow generate relocation records and have the module loade=
r
> >>>>> do the relocation automatically
> >>>>>
> >>>>> not sure how that works for vmlinux when it's loaded/relocated on b=
oot
> >>>>
> >>>> Right, actual module address will mostly not match the one in dwarf.
> >>>> Some during module btf load, we should modify btf address as well
> >>>> for later use? Yes, may need to reuse some routines used in initial
> >>>> module relocation.
> >>>
> >>>
> >>> Few thoughts:
> >>>
> >>> Initially I felt that single FUNC with multiple DECL_TAG(addr)
> >>> is better, since BTF for all funcs is the same and it's likely
> >>> one static inline function that the compiler decided not to inline
> >>> (like cpumask_weight), so when libbpf wants to attach prog to it
> >>> the kernel should automatically attach in all places.
> >>> But then noticed that actually different functions with
> >>> the same name and proto will be deduplicated into one.
> >>> Their bodies at different locations will be different.
> >>> Example: seq_show.
> >>> In this case it's better to let libbpf pick the exact one to attach.
> >>> Then realized that even the same function like cpumask_weight()
> >>> might have different body at different locations due to optimizations=
.
> >>> I don't think dwarf contains enough info to distinguish all the combi=
nations.
> >>>
> >>> Considering all that it's better to keep one BTF kind_func -> one add=
r.
> >>> If it's extended the way Alan is proposing with kind_flag
> >>> the dedup logic will not combine them due to different addresses.
> >>
> >> I've discussed this w/ Alexei and Yonghong offline, so will summarize
> >> what I said here. I don't think that we should go the route of adding
> >> kflag to BTF_KIND_FUNC. As Yonghong pointed out, previously only vlen
> >> and kind determined byte size of the type, and so adding a third
> >> variable (kflag), which would apply only to BTF_KIND_FUNC, seems like
> >> an unnecessary new complication.
> >>
> >> I propose to go with an entirely new kind instead, we have plenty of
> >> them left. This new kind will be pretty kernel-specific, so could be
> >> targeted for kernel use cases better without adding unnecessary
> >> complications to Clang. BTF_KIND_FUNCs generated by Clang for .bpf.o
> >> files don't need addr, they are meaningless and Clang doesn't know
> >> anything about addresses anyways. So we can keep Clang unchanged and
> >> more backwards compatible.
> >>
> >> But now that this new kind (BTF_KIND_KERNEL_FUNC? KFUNC would be
> >> misleading, unfortunately) is kernel-specific and generated by pahole
> >> only, besides addr we can add some flags field and use them to mark
> >> function as defined as kfunc or not, or (as a hypothetical example)
> >> traceable or not, or maybe we even have inline flag some day, etc.
> >> Something that makes sense mostly for kernel functions.
> >>
> >> Having said all that, given we are going to break all existing
> >> BTF-aware tools again with a new kind, we should really couple all
> >> this work with making BTF self-describing as discussed in [0], so that
> >> future changes like this won't break older bpftool and other similar
> >> tools, unnecessarily.
> >
> > nice, would be great to have this and eventually got rid of new pahole
> > enable/disable options, makes sense to do this before adding new type
> >
> > jirka
> >
>
> agreed; I'd been thinking the same and I've been working on a proof-of-
> concept of this based on our previous discussions, I'll send it out as
> soon as I've got it roughly working.

nice! it would be great to not have every older tool break whenever we
add a tiny extension to BTF

>
> With respect to the question of having a new kind, I'm not sure I agree
> with the above. We've already broken the "vlen =3D=3D number of objects
> following" for BTF_KIND_FUNC, where vlen is used to represent linkage
> information instead.

I'd say BTF_KIND_FUNC and its abuse of vlen is just an example of what
we shouldn't do going forward. But even that still allows us to
compactly describe each btf_type's size as a pair of (fixed_sz,
vlen_sz), where the total size will be fixed_sz + vlen * vlen_sz. For
BTF_KIND_FUNC vlen_sz will be zero, even if vlen is non-zero.

If we allow klag to change bytes size of a type, we'd need another
sizing dimension, which is what I try to avoid here.

Look at ENUM and ENUM64. We chose to add a new kind for ENUM64 because
of different byte sizing needs, instead of abusing kflag for this, and
I think this was the right decision. Let's do that here as well.

>
> To me, it feels more natural to have continuity across different object
> types (kernel versus BPF program) with BTF_KIND_FUNC: the fact that
> it's hard to come up with an alternate name is perhaps a reflection of
> this. Most characteristics (aside from "is a kfunc") seem to be shared
> across kernel and BPF program functions, but the best way to judge
> is probably to come up with as complete a list as is possible I suppose.

Even the address that you'll add to BTF_KIND_FUNC doesn't apply to BTF
emitted for BPF object files. So while I can sympathize (conceptually)
with the desire to have one kind for "all thing function", it will
cause more problems. Again, look at ENUM and ENUM64 case. Sure, we had
to teach BTF dedup and BPF CO-RE about both kinds to represent the
same enum concept, but we'd have to do the same even if just added a
kflag for 64-bit enum. So my point is that tools will still need to be
extended to take advantage of new information, but reusing the same
kind is causing more problems and is not solving any.

>
> In order to accommodate a metadata description using existing
> BTF_KIND_FUNC, we can have a metadata flag that can say
> "KFLAG set means singular object following of object_size" that is
> set for  BTF_KIND_FUNC. We can mark it as discouraged for future
> use.
>
> One argument I definitely see for a new kind representing kernel
> functions is if it were the case that we might need N elements
> _and_ a singular object following the btf_type to represent it.
> I don't currently see any use for such a model for function
> representation, but if that is anticipated somehow, it might be
> worth having a new kind to support that sort of representation.

We can never foresee stuff like this, but it's best to not design
ourselves into the corner. We have enough space for BTF_KIND_xxx,
which gives you all the same benefits. Let's keep it simple and
straightforward.

>
> Alan
>
> >>
> >> Which, btw, is another reason to not use kflag to determine the size
> >> of btf_type. Proposed solution in [0] assumes that kind + vlen defines
> >> the size. We should probably have dedicated discussion for
> >> self-describing BTF, but I think both changes have to be done in the
> >> same release window.
> >>
> >>   [0] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4=
bn=3DNuc1g8JPFC34MA@mail.gmail.com/#t
> >>
> >>>
> >>> Also turned out that the kernel doesn't validate decl_tag string.
> >>> The following code loads without error:
> >>> __attribute__((btf_decl_tag("\x10\xf0")));
> >>>
> >>> I'm not sure whether we want to tighten decl_tag validation and how.
> >>> If we keep it as-is we can use func+decl_tag approach
> >>> to add 4 bytes of addr in the binary format (if 1st byte is not zero)=
.
> >>> But it feels like a hack, since the kernel needs to be changed
> >>> anyway to adjust the addresses after module loading and kernel reloca=
tion.
> >>> So func with kind_flag seems like the best approach.
> >>>
> >>> Regarding relocation of address in the kernel and modules...
> >>> We just need to add base_addr to all addrs-es recorded in BTF.
> >>> Both for kernel and for module BTFs.
> >>> Shouldn't be too complicated.
> >>
> >> yep, KASLR seems simple enough to handle by the kernel itself at boot =
time.
> >

