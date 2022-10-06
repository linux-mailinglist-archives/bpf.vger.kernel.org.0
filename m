Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710885F6C7E
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJFRHo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJFRHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 13:07:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2929E2ED
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 10:07:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e18so3751724edj.3
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOgpjyGqM3AQcL6BeKVrlFuyECi8EOSbds45quTyn7g=;
        b=bqhMvCoNdKNKHyy7HpyykOtopGlRKHId0h3QfYpCfGAlY+DqKIUTSyqITeJaNlMZ3A
         /c+aS1P4MMiPjDHhq2Bp6pIJOA9gIjqb4FaIlnUYquIII3rl8meGH339RLg1HtxgzS2j
         ncgZexvW8XnZlyNfSAw7Tav746Oq6gZVkaITZqmNN9UAyU+ftCKIKHmuNhQKez0D2Oju
         4qs9PcS7XZZs4K44GNrFKUm1XRk6UkF1OXEQm80wCydlJnStty25CXCxTu83nRKt71Ae
         7cuRToRAspx3rap7BWbyMNNQbtCWZwmIuLJ7UdnvvmD9p2LBNhzsjGBL/ZWGEqRbQi4O
         pXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOgpjyGqM3AQcL6BeKVrlFuyECi8EOSbds45quTyn7g=;
        b=nZIBLNYoYlbe+Y90BU1fgi5wXuqN08Z95gczoAT0Pm96Ee6WpZyk/v+5Mu4wXR/Jae
         NKe9+SpO6Pkxv2jg/mqxxhBEkTa/6g8wpXXp9qdvE2w8cBfOtQTFnwcmrYZ8pWRSiYby
         M5d0ZULQ7YxPZMxeuXFPcqDuYOf0mht7a63tw6EyZhGLUtINsMZePYOTMbNIF5wTClol
         se6Jh4Tp3It4Z4FCRdto0+LzussvzAtl6WOisxrSZYRgGP0RzF6hMiZNdNfodZO18iLM
         Zg84ZHUn6Hrsfzscq30bu/Hmpn9HAkhgYRfLicVp1e+D4oMjJnilqitFuh8XY7W8CGOp
         g8/w==
X-Gm-Message-State: ACrzQf2Ck+ik0a2lQNSkb3CRAMPV6pbKKLvL/qqhTh5n/RWdsDRoKemm
        fc4HQysuxPg3lklsMf5qIKVgkn7KqJxx4aMjT+8=
X-Google-Smtp-Source: AMsMyM5+ykuAUM+GVe3J/bDY+oVFkcHOHLwu8RpI9rgDDUZLqEqmzFS73MZtwRnMIzI0QAYSvUHz2ofTfrEIgUmnD9o=
X-Received: by 2002:a05:6402:3603:b0:451:fdda:dddd with SMTP id
 el3-20020a056402360300b00451fddaddddmr724948edb.81.1665076058322; Thu, 06 Oct
 2022 10:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
 <63365532d416f_233df20899@john.notmuch> <92157e05-e383-ed4b-8b01-2981dbf5afd3@linux.microsoft.com>
 <CAEf4BzZxU+YD5CtHEk7S7bXTDMMSsnV3eFYgRXCMft=fx9reMA@mail.gmail.com>
 <CAHC9VhSqHFRpfq1b6Ys+Ygaqr-6KFeziUxtOVpsoBb=TE2csoA@mail.gmail.com>
 <CAEf4BzZnLFgzaPWeaH2h3dqxS4thEHQUv6FtZbpffxs6iGcWKw@mail.gmail.com> <658ad9b2-9ee6-39ac-782d-23a1d7be8aba@linux.microsoft.com>
In-Reply-To: <658ad9b2-9ee6-39ac-782d-23a1d7be8aba@linux.microsoft.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Oct 2022 10:07:26 -0700
Message-ID: <CAEf4BzYJpCKDvzF3Oy0dW4NJpf6UVOc_W2Mw+_ERA_hJSPxk6A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add validation to BTF's variable type ID
To:     Anne Macedo <annemacedo@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
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

On Thu, Oct 6, 2022 at 10:02 AM Anne Macedo
<annemacedo@linux.microsoft.com> wrote:
>
>
>
> On 05/10/22 19:42, Andrii Nakryiko wrote:
> > On Mon, Oct 3, 2022 at 2:26 PM Paul Moore <paul@paul-moore.com> wrote:
> >>
> >> On Fri, Sep 30, 2022 at 6:39 PM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>> On Fri, Sep 30, 2022 at 6:00 AM Anne Macedo
> >>> <annemacedo@linux.microsoft.com> wrote:
> >>>>
> >>>> On 29/09/22 23:32, John Fastabend wrote:
> >>>>> Anne Macedo wrote:
> >>>>>> If BTF is corrupted, a SEGV may occur due to a null pointer derefe=
rence on
> >>>>>> bpf_object__init_user_btf_map.
> >>>>>>
> >>>>>> This patch adds a validation that checks whether the DATASEC's var=
iable
> >>>>>> type ID is null. If so, it raises a warning.
> >>>>>>
> >>>>>> Reported by oss-fuzz project [1].
> >>>>>>
> >>>>>> A similar patch for the same issue exists on [2]. However, the cod=
e is
> >>>>>> unreachable when using oss-fuzz data.
> >>>>>>
> >>>>>> [1] https://github.com/libbpf/libbpf/issues/484
> >>>>>> [2] https://patchwork.kernel.org/project/netdevbpf/patch/202111031=
73213.1376990-3-andrii@kernel.org/
> >>>>>>
> >>>>>> Reviewed-by: Isabella Basso <isabbasso@riseup.net>
> >>>>>> Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
> >>>>>> ---
> >>>>>>    tools/lib/bpf/libbpf.c | 4 ++++
> >>>>>>    1 file changed, 4 insertions(+)
> >>>>>>
> >>>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>>>>> index 184ce1684dcd..0c88612ab7c4 100644
> >>>>>> --- a/tools/lib/bpf/libbpf.c
> >>>>>> +++ b/tools/lib/bpf/libbpf.c
> >>>>>> @@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(st=
ruct bpf_object *obj,
> >>>>>>
> >>>>>>       vi =3D btf_var_secinfos(sec) + var_idx;
> >>>>>>       var =3D btf__type_by_id(obj->btf, vi->type);
> >>>>>> +    if (!var || !btf_is_var(var)) {
> >>>>>> +            pr_warn("map #%d: non-VAR type seen", var_idx);
> >>>>>> +            return -EINVAL;
> >>>>>> +    }
> >>>>>>       var_extra =3D btf_var(var);
> >>>>>>       map_name =3D btf__name_by_offset(obj->btf, var->name_off);
> >>>>>>
> >>>>>> --
> >>>>>> 2.30.2
> >>>>>>
> >>>>>
> >>>>>
> >>>>> I don't know abouut this. A quick scan looks like this type_by_id i=
s
> >>>>> used lots of places. And seems corrupted BTF could cause faults
> >>>>> and confusiuon in other spots as well. I'm not sure its worth makin=
g
> >>>>> libbpf survive corrupted BTF. OTOH this specific patch looks ok.
> >>>>>
> >>>>
> >>>> I was planning on creating a function to validate BTF for these kind=
s of
> >>>> corruptions, but decided to keep this patch simple. This could be a =
good
> >>>> idea for some future work =E2=80=93 moving all of the validations to
> >>>> bpf_object__init_btf() or to a helper function.
> >>>
> >>> This whack-a-mole game of fixing up BTF checks to avoid one specific
> >>> corruption case is too burdensome. There is plenty of BTF usage befor=
e
> >>> the point which you are fixing, so with some other specific corruptio=
n
> >>> to BTF you can trigger even sooner corruption.
> >>>
> >>> As I mentioned on Github. I'm not too worried about ossfuzz generatin=
g
> >>> corrupted BTF because that's not a very realistic scenario. But it
> >>> would be nice to add some reasonable validation logic for BTF in
> >>> general, so let's better concentrate on that instead of adding these
> >>> extra checks.
> >>
> >> Reading the comments here and on the associated GH issue, it sounds
> >> like you would be supportive of this check so long as it was placed in
> >> bpf_object__init_btf(), is that correct?  Or do you feel this
> >> particular check falls outside the scope of "reasonable validation
> >> logic"?  I'm trying to understand what the best next step would be for
> >> this patch ...
> >
> > I think we should bite the bullet and do BTF validation in libbpf. It
> > doesn't have to be as thorough as what kernel does, but validating
> > general "structural integrity" of BTF as a first step would make all
> > these one-off checks throughout entire libbpf source code unnecessary.
> > I.e., we'll need to check things like: no out of range type IDs, no
> > out-of-range string offsets, FUNC -> FUNC_PROTO references, DATASEC ->
> > VAR | FUNC references, etc, etc. Probably make sure we don't have a
> > loop of struct referencing to itself not through pointer, etc. It's a
> > bit more upfront work, but it's will make the rest of the code simpler
> > and will eliminate a bunch of those fuzzer crashes as well.
> >
>
> Thanks for the feedback, I think that sounds like a good plan. I will
> work on another patch and I wanted to summarize what I should do.
>
> So basically, I should place the BTF validation on
> bpf_object__init_btf(), that should contain validations for:
>
> - out of range type IDs;
> - out of range string offsets;
> - FUNC -> FUNC_PROTO references;
> - DATASEC -> VAR | FUNC references;
> - structs referencing themselves;
>

This is just specific things that I could recall immediately. Please
look at what kernel is validating in kernel/bpf/btf.c. I don't think
libbpf should be as strict as kernel (e.g., I would reject BTF because
it has unexpected kflag and stuff like that), we should validate stuff
that libbpf relies on, but not be overzealous overall (e.g., rejecting
BTF because kflag is unexpectedly set might be an overkill for libbpf,
while it makes sense for kernel to be stricter).

> >>
> >> --
> >> paul-moore.com
