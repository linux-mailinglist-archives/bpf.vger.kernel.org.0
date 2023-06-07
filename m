Return-Path: <bpf+bounces-2045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC59727175
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 00:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856121C20EE0
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D603B8D2;
	Wed,  7 Jun 2023 22:20:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC123B8C9
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 22:20:10 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9605B271B;
	Wed,  7 Jun 2023 15:19:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso2344463a12.3;
        Wed, 07 Jun 2023 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686176374; x=1688768374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/P6uze0Ga7vW3Z/CgXfKZmf9JEKn/Cz4dqyzssDdzw=;
        b=d2LKoCPKdC9GPUgnkEyQfOgTjq9YeKvOaIQal6TvSmcM/EzUfv7+Wrzo9bsC+ZWQWY
         GUs0gd7V1J1U5dPpN64S524v6Q23lN+BtByC7G6VrgB4dOmOsevqQFRUVbnQJRa3wm5P
         NbnW78ipMAQ8UzorF1is/qmU6n39va/7M97RiTrnjINCO4vAGttx6orhq4TTUOqUtBW3
         td2QC4t53LJF7HX9V5YjxExm2wS23waNpYDM/aA0LA/IkJ/nLbKtV3W1Ebl8evwN1/VJ
         DX7Y4qHVTE/suYCz95FUl3TYdfoMGsE5+dgRBCPTWH4v7eniU7WMdyY6cGBtAQMHtwPz
         qqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176374; x=1688768374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/P6uze0Ga7vW3Z/CgXfKZmf9JEKn/Cz4dqyzssDdzw=;
        b=djxQOgg5m4M3H2Z6NTamPQUBoCDQJayErgFHHY023eVuZMGjqyBg84HkC2N9x9Gxd9
         3LlU4+WiANf5a2Lyn0cNx83yYknVthM+71G5wwyVbJFOU9Ep6BTNCUA9Z4bwT/Vbn5Ad
         CEbiOsNdv5pa/5tVhcViY3L648YL06dnivcSxFO5dOvBP7QMpppiRBlxHHHl8dE5TjtI
         Q/wek196P7WZUdoZrmf9bHqJMEHu+C6w5GMksz5OgxzcLINEOqpuGP5Uya5NDW2jG0U6
         bM4wdy+bDR7M+6MFH0INZXVa9aVz9+z2kdYh2v7abElRCOfs/gUYLMdmXSngbP5FfOJm
         SrMA==
X-Gm-Message-State: AC+VfDys4UeFRcy+XY1VhBPWkBzbB4X/i3Pl5sz10DX1d7tZCii2Joz5
	ZeNwH4GYmMo14YMmoJ1aUZPEmzSvwWwH7qaedCI=
X-Google-Smtp-Source: ACHHUZ5DiEil+HYJB2TZTQHyyUfsusZ+xfEe+iq311jV9v6sM01Ey6Y4QHdwUFILY/3Jpdu0OolNmjxzji2Az8saZf8=
X-Received: by 2002:aa7:c1cd:0:b0:516:459d:d913 with SMTP id
 d13-20020aa7c1cd000000b00516459dd913mr6646005edp.37.1686176374094; Wed, 07
 Jun 2023 15:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606042802.508954-1-maninder1.s@samsung.com>
 <20230606042802.508954-2-maninder1.s@samsung.com> <CGME20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a@epcms5p8>
 <CAEf4BzYavyL431eA_HZ-X8+wTeO4Cyt7tGDUbPB0yqPru=ZUSw@mail.gmail.com> <20230607034028epcms5p8ed013806c42bd79b76368ac015a7b6ba@epcms5p8>
In-Reply-To: <20230607034028epcms5p8ed013806c42bd79b76368ac015a7b6ba@epcms5p8>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 15:19:22 -0700
Message-ID: <CAEf4Bzb4B9FxMnf3t81D22FWkciLOvwDPLY0BbEPGGe7R5QPrg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] bpf: make bpf_dump_raw_ok() based on CONFIG_KALLSYMS
To: maninder1.s@samsung.com
Cc: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"vincenzopalazzodev@gmail.com" <vincenzopalazzodev@gmail.com>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"jgross@suse.com" <jgross@suse.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"michael.christie@oracle.com" <michael.christie@oracle.com>, 
	"samitolvanen@google.com" <samitolvanen@google.com>, "glider@google.com" <glider@google.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "keescook@chromium.org" <keescook@chromium.org>, 
	"stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	"alan.maguire@oracle.com" <alan.maguire@oracle.com>, "pmladek@suse.com" <pmladek@suse.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Onkarnath <onkarnath.1@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 8:46=E2=80=AFPM Maninder Singh <maninder1.s@samsung.=
com> wrote:
>
> Hi Andrii Nakryiko,
>
> >>
> >> bpf_dump_raw_ok() depends on kallsyms_show_value() and we already
> >> have a false definition for the !CONFIG_KALLSYMS case. But we'll
> >> soon expand on kallsyms_show_value() and so to make the code
> >> easier to follow just provide a direct !CONFIG_KALLSYMS definition
> >> for bpf_dump_raw_ok() as well.
> >
> > I'm sorry, I'm failing to follow the exact reasoning about
> > simplification. It seems simpler to have
> >
> > static inline bool kallsyms_show_value(const struct cred *cred)
> > {
> >     return false;
> > }
> >
> > and control it from kallsyms-related internal header, rather than
> > adding CONFIG_KALLSYMS ifdef-ery to include/linux/filter.h and
> > redefining that `return false` decision. What if in the future we
> > decide that if !CONFIG_KALLSYMS it's ok to show raw addresses, now
> > we'll have to remember to update it in two places.
> >
> > Unless I'm missing some other complications?
> >
>
> Patch 3/3 does the same, it extends functionality of kallsyms_show_value(=
)
> in case of  !CONFIG_KALLSYMS.
>
> All other users likes modules code, kprobe codes are using this API
> for sanity/permission, and then prints the address like below:
>
> static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
> {
> ...
>         if (!kallsyms_show_value(m->file->f_cred))
>                 seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
>                            (void *)ent->start_addr);
>         else
>                 seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_ad=
dr,
>                            (void *)ent->end_addr, (void *)ent->start_addr=
);
> ..
> }
>
> so there will be no issues if we move kallsyms_show_value() out of KALLSY=
MS dependency.
> and these codes will work in case of !KALLSYMS also.
>
> but BPF code logic was complex and seems this API was used as checking fo=
r whether KALLSYMS is
> enabled or not as per comment in bpf_dump_raw_ok():
>
> /*
>  * Reconstruction of call-sites is dependent on kallsyms,
>  * thus make dump the same restriction.
>  */
>
> also as per below code:
> (we were not sure whether BPF will work or not with patch 3/3 because of =
no expertise on BPF code,
> so we keep the behaviour same)

I think bpf_dump_raw_ok() is purely about checking whether it's ok to
return unobfuscated kernel addresses to user/BPF program. So it feels
like it should be ok to just rely on kallsyms_show_value() and not
special case here. If some of the code relies on actually having
CONFIG_KALLSYMS and related functionality, it should be properly
guarded already (or should enforce `SELECT KALLSYMS` in Kconfig).

>
>        if (ulen) {
>                 if (bpf_dump_raw_ok(file->f_cred)) {
>                         unsigned long ksym_addr;
>                         u64 __user *user_ksyms;
>                         u32 i;
>
>                         /* copy the address of the kernel symbol
>                          * corresponding to each function
>                          */
>                         ulen =3D min_t(u32, info.nr_jited_ksyms, ulen);
>                         user_ksyms =3D u64_to_user_ptr(info.jited_ksyms);
>                         if (prog->aux->func_cnt) {
>                                 for (i =3D 0; i < ulen; i++) {
>    ...
>    }
>
> earlier conversation for this change:
> https://lkml.org/lkml/2022/4/13/326
>
> here Petr CC'ed BPF maintainers to know their opinion whether BPF code ca=
n work with patch 3/3,
> if not then we need this patch.
>
> Thanks,
> Maninder Singh

