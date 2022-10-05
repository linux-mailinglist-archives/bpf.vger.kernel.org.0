Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01D75F5CD4
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJEWnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJEWnN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 18:43:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFAC8558C
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 15:43:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kg6so736503ejc.9
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrmPIV/vWXrbZds146l/M5lTC+3i31tyqrY63BcRqEg=;
        b=da6ArrwOdRU084gxi3wHtNUnnXy+s+R/MmUC+NDzbqXkUw8aMe6RsboZx1eiyjChE9
         zf3VigmExyl6K+9TOT127fbIs/w3ypXJ72Fag7cllCG3ctdkTGTHl0bVs+ynnPR0ePIX
         xykX/l8kON5VQszn/huTNOvYzpfGGTeVsai/VywTrb51XKkb3uTyjL8ywH12vZBKN6bz
         JfngE46REfld62d0JlO5SM5qMSD4Cr7nIXhK+3PM8dm8Jufu9JPq9YAscA6jpOcTC2q/
         HUDbKatTfOOviGQnBYbNpXwBhMy+hgF2SAP/49W6lHBxpfOc4Cqw56mI2kK62fYwij+0
         fUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrmPIV/vWXrbZds146l/M5lTC+3i31tyqrY63BcRqEg=;
        b=g0C7QvLh5qFRyN59p4FYvadZp6LGrA/HG9P4YtkErx6ELkgdu0YGaPDOjzzaa0Uaq3
         wtgEKmkAVElsJBsk54Ax/gPvWUt8BFcREa1Aei4T43lek3mWH4mD7PAw+ukRH6dL0Qix
         MTcNLJCqxuayBjSYcj+RCphEKEcs2nAeLtZbm54dVhycGwXpuA9fs97YHWj6pG4WnW07
         n8DrlInVzc+9F7GYgD52mDItyJyRgQktvU+Z/ZJFQcq1lhROLVQrRTZ+vkH4ivI2T8T2
         wal7iacx3PLsoBSXtYdbHxpyfDF7+7W8AD3TVdKBQlRpOuKjF1bq9NHP6rIn/5V6gs6m
         W7KQ==
X-Gm-Message-State: ACrzQf2faBEt8t7JIZyloDjCe1g91VYGdG4dCuNOx8OTPiBtykAcYU2k
        qgV1cjHIIByi65OODYvwl48AtrfQiEfhQ7ER29s=
X-Google-Smtp-Source: AMsMyM56qbeflxSupBt4B+7Nv2g1rZvlCu0XyokLPGtBDgQNtZyLnDy4wnxAByuwk7+d4ff3CkVz69AubacQnEppw60=
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id
 bf4-20020a170907098400b0077f4d959e2fmr1560874ejc.176.1665009784990; Wed, 05
 Oct 2022 15:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
 <63365532d416f_233df20899@john.notmuch> <92157e05-e383-ed4b-8b01-2981dbf5afd3@linux.microsoft.com>
 <CAEf4BzZxU+YD5CtHEk7S7bXTDMMSsnV3eFYgRXCMft=fx9reMA@mail.gmail.com> <CAHC9VhSqHFRpfq1b6Ys+Ygaqr-6KFeziUxtOVpsoBb=TE2csoA@mail.gmail.com>
In-Reply-To: <CAHC9VhSqHFRpfq1b6Ys+Ygaqr-6KFeziUxtOVpsoBb=TE2csoA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 15:42:53 -0700
Message-ID: <CAEf4BzZnLFgzaPWeaH2h3dqxS4thEHQUv6FtZbpffxs6iGcWKw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add validation to BTF's variable type ID
To:     Paul Moore <paul@paul-moore.com>
Cc:     Anne Macedo <annemacedo@linux.microsoft.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 3, 2022 at 2:26 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Sep 30, 2022 at 6:39 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Sep 30, 2022 at 6:00 AM Anne Macedo
> > <annemacedo@linux.microsoft.com> wrote:
> > >
> > > On 29/09/22 23:32, John Fastabend wrote:
> > > > Anne Macedo wrote:
> > > >> If BTF is corrupted, a SEGV may occur due to a null pointer derefe=
rence on
> > > >> bpf_object__init_user_btf_map.
> > > >>
> > > >> This patch adds a validation that checks whether the DATASEC's var=
iable
> > > >> type ID is null. If so, it raises a warning.
> > > >>
> > > >> Reported by oss-fuzz project [1].
> > > >>
> > > >> A similar patch for the same issue exists on [2]. However, the cod=
e is
> > > >> unreachable when using oss-fuzz data.
> > > >>
> > > >> [1] https://github.com/libbpf/libbpf/issues/484
> > > >> [2] https://patchwork.kernel.org/project/netdevbpf/patch/202111031=
73213.1376990-3-andrii@kernel.org/
> > > >>
> > > >> Reviewed-by: Isabella Basso <isabbasso@riseup.net>
> > > >> Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
> > > >> ---
> > > >>   tools/lib/bpf/libbpf.c | 4 ++++
> > > >>   1 file changed, 4 insertions(+)
> > > >>
> > > >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > >> index 184ce1684dcd..0c88612ab7c4 100644
> > > >> --- a/tools/lib/bpf/libbpf.c
> > > >> +++ b/tools/lib/bpf/libbpf.c
> > > >> @@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(st=
ruct bpf_object *obj,
> > > >>
> > > >>      vi =3D btf_var_secinfos(sec) + var_idx;
> > > >>      var =3D btf__type_by_id(obj->btf, vi->type);
> > > >> +    if (!var || !btf_is_var(var)) {
> > > >> +            pr_warn("map #%d: non-VAR type seen", var_idx);
> > > >> +            return -EINVAL;
> > > >> +    }
> > > >>      var_extra =3D btf_var(var);
> > > >>      map_name =3D btf__name_by_offset(obj->btf, var->name_off);
> > > >>
> > > >> --
> > > >> 2.30.2
> > > >>
> > > >
> > > >
> > > > I don't know abouut this. A quick scan looks like this type_by_id i=
s
> > > > used lots of places. And seems corrupted BTF could cause faults
> > > > and confusiuon in other spots as well. I'm not sure its worth makin=
g
> > > > libbpf survive corrupted BTF. OTOH this specific patch looks ok.
> > > >
> > >
> > > I was planning on creating a function to validate BTF for these kinds=
 of
> > > corruptions, but decided to keep this patch simple. This could be a g=
ood
> > > idea for some future work =E2=80=93 moving all of the validations to
> > > bpf_object__init_btf() or to a helper function.
> >
> > This whack-a-mole game of fixing up BTF checks to avoid one specific
> > corruption case is too burdensome. There is plenty of BTF usage before
> > the point which you are fixing, so with some other specific corruption
> > to BTF you can trigger even sooner corruption.
> >
> > As I mentioned on Github. I'm not too worried about ossfuzz generating
> > corrupted BTF because that's not a very realistic scenario. But it
> > would be nice to add some reasonable validation logic for BTF in
> > general, so let's better concentrate on that instead of adding these
> > extra checks.
>
> Reading the comments here and on the associated GH issue, it sounds
> like you would be supportive of this check so long as it was placed in
> bpf_object__init_btf(), is that correct?  Or do you feel this
> particular check falls outside the scope of "reasonable validation
> logic"?  I'm trying to understand what the best next step would be for
> this patch ...

I think we should bite the bullet and do BTF validation in libbpf. It
doesn't have to be as thorough as what kernel does, but validating
general "structural integrity" of BTF as a first step would make all
these one-off checks throughout entire libbpf source code unnecessary.
I.e., we'll need to check things like: no out of range type IDs, no
out-of-range string offsets, FUNC -> FUNC_PROTO references, DATASEC ->
VAR | FUNC references, etc, etc. Probably make sure we don't have a
loop of struct referencing to itself not through pointer, etc. It's a
bit more upfront work, but it's will make the rest of the code simpler
and will eliminate a bunch of those fuzzer crashes as well.

>
> --
> paul-moore.com
