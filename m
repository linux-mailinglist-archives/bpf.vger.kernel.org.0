Return-Path: <bpf+bounces-4331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32874A583
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D5128145D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC213AE5;
	Thu,  6 Jul 2023 21:07:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9041097D
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:07:08 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6ECB9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 14:07:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31434226a2eso1237202f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688677626; x=1691269626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EkMEACcvA0KC4s4/sF4awEK8l4NqkOPiH9MJgvskbY=;
        b=e9VLkbcpSlpI7DXC7jHsm8guBJWBm+SKQZZR7nClITcYXnbBijbSXCY8fa28HHth5O
         02kre9q6Fx9xwJ5EQoU83WH/3n0fG1A8VYHIDqBUBkKamhM3GC8dos9RG5UyuQkcTofg
         IjLJaByOtL6N+Xp1XkQ9PhMe8zJ9GorEa4Vdawb8LsdKjkqSeVY1mBRPcINZAwPybbQR
         f1Hm1JxVI82Jw4cfmcBrMxHBsZyFg6yJGFJrfxi0CQnB6jWskF8/a7/p3e3fnFslU+5d
         7NpAV6KJlr3u7ggt3kV2o69PWaWSZuTq/fsBAMCMDEq2QKWNWGr70ohdhaThyvhWHvIU
         GzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688677626; x=1691269626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EkMEACcvA0KC4s4/sF4awEK8l4NqkOPiH9MJgvskbY=;
        b=gCROnT/6vt8lPYYo4pF29CpumlWN8c0A1TOSp13JwpqCjBygd/xyr/APjpQGHUvXyT
         FEjgU06COlkzPhrENGk3T40B/ISOhsgeOgpKHXBQO6kg1fy3CscVB3sm5umZgrOGe9kU
         UJgFJGjqMeqNP1zYu/GyRvRR3AxWbox2boUG1C68FnX/lvORBNtooJT4Tel/smYUc4ZM
         1f/WObb6H/HJ6VkF1hfWt6e51z3gYutndd7pPGLbj9Fh31NDV7tgpmoUJByAGW1rHUIn
         vxPIT/pXRn3iAOKmIl2gvQowoKedvQ1ivcddz45PDbO5MxNCH05Z8hNw7arIfJ81ig8Q
         ixuQ==
X-Gm-Message-State: ABy/qLY4wnBezA+5xTVMx24CszzUARkoRuWEWosuxdabywBE+AOdgQ2J
	trtUXkkzjfA6NFxG7h0LBKjqH7cUgAiHL/IZFJpzABk+hLA=
X-Google-Smtp-Source: APBJJlGq5cgvMQpJ8liO8zxjK5ybDr52uSH3OdpTEMYI8JnG4syvuR1+uN09BFTE+BMWbmERI/fOUoBjSbxUPqjTqsI=
X-Received: by 2002:a5d:53d0:0:b0:311:110d:5573 with SMTP id
 a16-20020a5d53d0000000b00311110d5573mr2834235wrw.64.1688677625619; Thu, 06
 Jul 2023 14:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com>
In-Reply-To: <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 14:06:52 -0700
Message-ID: <CAEf4BzbSdggvGD=xXZxFa8tjUxGWKrsb5hL9EP_viHqQCG+MYA@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Yonghong Song <yhs@meta.com>
Cc: Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 9:50=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 7/4/23 6:30 AM, Lorenz Bauer wrote:
> > Hi,
> >
> > I think that CO-RE has inconsistent behaviour wrt. BPF_TYPE_ID_LOCAL
> > and BPF_TYPE_ID_TARGET when dealing with qualifiers (modifiers?) Given
> > the following C:
> >
> > enum bpf_type_id_kind {
> >      BPF_TYPE_ID_LOCAL =3D 0,        /* BTF type ID in local program */
> >      BPF_TYPE_ID_TARGET =3D 1,        /* BTF type ID in target kernel *=
/
> > };
> >
> > int foo(void) {
> >      return __builtin_btf_type_id(*(const int *)0, BPF_TYPE_ID_TARGET)
> > !=3D __builtin_btf_type_id(*(const int *)0, BPF_TYPE_ID_LOCAL);
> > }
> >
> > That line with __builtin_btf_type_id is just the expansion of
> > bpf_core_type_id_kernel, etc. clang generates the following BPF:
> >
> > foo:
> >   18 01 00 00 02 00 00 00 00 00 00 00 00 00 00 00    r1 =3D 0x2 ll
> >   79 11 00 00 00 00 00 00    r1 =3D *(u64 *)(r1 + 0x0)
> >   18 02 00 00 04 00 00 00 00 00 00 00 00 00 00 00    r2 =3D 0x4 ll
> >   79 22 00 00 00 00 00 00    r2 =3D *(u64 *)(r2 + 0x0)
> >   b7 03 00 00 00 00 00 00    r3 =3D 0x0
> >   7b 3a f0 ff 00 00 00 00    *(u64 *)(r10 - 0x10) =3D r3
> >   b7 03 00 00 01 00 00 00    r3 =3D 0x1
> >   7b 3a f8 ff 00 00 00 00    *(u64 *)(r10 - 0x8) =3D r3
> >   5d 21 02 00 00 00 00 00    if r1 !=3D r2 goto +0x2 <LBB0_2>
> >   79 a1 f0 ff 00 00 00 00    r1 =3D *(u64 *)(r10 - 0x10)
> >   7b 1a f8 ff 00 00 00 00    *(u64 *)(r10 - 0x8) =3D r1
> > LBB0_2:
> >   79 a0 f8 ff 00 00 00 00    r0 =3D *(u64 *)(r10 - 0x8)
> >   95 00 00 00 00 00 00 00    exit
> >
> > Link to godbolt: https://godbolt.org/z/jr63hKz9E  (contains version inf=
o)
> >
> > Note that the first two ldimm64 have distinct type IDs. I added some
> > debug logging to cilium/ebpf and found that the compiler indeed also
> > emits distinct CO-RE relocations:
> >
> > foo {InsnOff:0 TypeID:2 AccessStrOff:69 Kind:local_type_id}
> > foo {InsnOff:2 TypeID:4 AccessStrOff:69 Kind:target_type_id}
> >
> > It seems that for BPF_TYPE_ID_TARGET the outer const is peeled, while
> > this doesn't happen for the local variant.
> >
> > CORERelocation(local_type_id, Const[0], local_id=3D4) local_type_id=3D4=
->4
> > CORERelocation(target_type_id, Int:"int"[0], local_id=3D2) target_type_=
id=3D2->2
> >
> > Similar behaviour exists for BPF_TYPE_EXISTS, probably others.
> >
> > The behaviour goes away if I drop the pointer casting magic:
> >
> > __builtin_btf_type_id((const int)0, BPF_TYPE_ID_TARGET) !=3D
> > __builtin_btf_type_id((const int)0, BPF_TYPE_ID_LOCAL)
> >
> > Intuitively I'd say that the root cause is that dereferencing the
> > pointer drops the constness of the type. Why does TARGET behave
> > differently than LOCAL though?
>
> Thanks for reporting. The difference of type w.r.t. 'const' modifier
> is a deliberate choice in llvm:
>
> See
> https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/BPFPre=
serveDIType.cpp#L84-L103
>
>      if (FlagValue =3D=3D BPFCoreSharedInfo::BTF_TYPE_ID_LOCAL_RELOC) {
>        Reloc =3D BPFCoreSharedInfo::BTF_TYPE_ID_LOCAL;
>      } else {
>        Reloc =3D BPFCoreSharedInfo::BTF_TYPE_ID_REMOTE;
>        DIType *Ty =3D cast<DIType>(MD);
>        while (auto *DTy =3D dyn_cast<DIDerivedType>(Ty)) {
>          unsigned Tag =3D DTy->getTag();
>          if (Tag !=3D dwarf::DW_TAG_const_type &&
>              Tag !=3D dwarf::DW_TAG_volatile_type)
>            break;
>          Ty =3D DTy->getBaseType();
>        }
>
>        if (Ty->getName().empty()) {
>          if (isa<DISubroutineType>(Ty))
>            report_fatal_error(
>                "SubroutineType not supported for BTF_TYPE_ID_REMOTE reloc=
");
>          else
>            report_fatal_error("Empty type name for BTF_TYPE_ID_REMOTE
> reloc");
>        }
>        MD =3D Ty;
>      }
>
> Basically, the BTF_TYPE_ID_REMOTE (the kernel term BPF_TYPE_ID_TARGET)
> needs further checking to prevent some invalid cases.
> Also for kernel type matching, it would be good to eliminate modifiers
> otherwise, there could be many instances of 'const' which makes
> kernel matching is more complicated.
>
> But I see your point. Maybe we should preserve the original type
> for BTF_TYPE_ID_TARGET as well. Will check what libbpf/kernel
> will handle 'const int *' case and get back to this thread later.

I think it's better the other way around: make BTF_TYPE_ID_LOCAL strip
const/volatile/restrict modifiers. For all other relocations we rely
on having named types, so const/volatile makes no sense and will fail
relocation. It's hard to come up with the situation where recording
const/volatile/restrict in BTF_TYPE_ID_LOCAL would make sense, so I'd
say that it should behave just like all the other relos.

>
> >
> > Cheers
> > Lorenz

