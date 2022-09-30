Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598B25F163B
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiI3WjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI3WjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:39:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13F1B9117
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:39:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dv25so11786900ejb.12
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlqpIXC73pUURYLo0nnXQcdOp3L32+kzHaAMc9mMS44=;
        b=dmkWXL0NdSmILbyo+l5iJpZIFHjTfPWUntsy//1rFXvs3db/GaHeNMgqwpDVNX1qCT
         aPh6ltD0hEeSt7bx9lLBA1if5uDIxzgCDK5H6VLNQbkZTpQNbyEaS4ddVOQs/3Ynq3yl
         ucKxpdIqeVd1QUTGRnx9K43n2XixyXuFNc+REYWUlxBscRDppOAht+CcOf0RDqjBes47
         epvh/xrocerH2fuYibSdkHgfVuTjOaP8pFshu9zkZpz6kki/R8BuaeaA/9diINMWlB5k
         jJeS0aU8BysAzD8eubff6idLrr1sYBu89a9qkqKWDTzKue6zpuRO89YjN8UaBwXtdHwI
         AOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlqpIXC73pUURYLo0nnXQcdOp3L32+kzHaAMc9mMS44=;
        b=xMbO1wxYOPvq5TbbqyrcinROxNLqoR14mBe5qYHA9kGyi5KPEWWVNQvaSLbG7MYDmI
         Z8JHJSxWcb5S/tSjmVZTaKXrGacujBMLZcErVgC3fatDO7JSMiC0MJxDszCICZosuN84
         4DHKiELdJ1eR1aY4XMtdvP+PWmzYYsloBBhFwUXpfJ1dPoBmNgaOccN/uiyybFE5p2fP
         qaDpTfmW93MCzslca83BL2X9UmZuIkceNP8Drxl6NVeRXCOU2piTiT+2Kc8pD2uZHmpO
         WvQtxI4bVeO2svjmGj4ploJDE5r30c4swGi8Dk9exmVDrHfS0GnTh7i3aKy+83FmV6HP
         onQQ==
X-Gm-Message-State: ACrzQf0yeb4a0rVtz0TlWCbji289HcCmE41VjCx18uvQbprqn/7Rs9tK
        Gjp2aUYacOdntr/w4sGaxhdk68JjUsQVP7Swvqk=
X-Google-Smtp-Source: AMsMyM5aHRO4Vckl4iw/EEnb/5BovgflO38j/VwjmfKLHYJJq2gZauS0vaeJCaFdllMhL0HBby8dksM5Sm6dHNE1S+0=
X-Received: by 2002:a17:907:3d86:b0:782:1175:153f with SMTP id
 he6-20020a1709073d8600b007821175153fmr7927571ejc.226.1664577548436; Fri, 30
 Sep 2022 15:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
 <63365532d416f_233df20899@john.notmuch> <92157e05-e383-ed4b-8b01-2981dbf5afd3@linux.microsoft.com>
In-Reply-To: <92157e05-e383-ed4b-8b01-2981dbf5afd3@linux.microsoft.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 15:38:56 -0700
Message-ID: <CAEf4BzZxU+YD5CtHEk7S7bXTDMMSsnV3eFYgRXCMft=fx9reMA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add validation to BTF's variable type ID
To:     Anne Macedo <annemacedo@linux.microsoft.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Paul Moore <paul@paul-moore.com>
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

On Fri, Sep 30, 2022 at 6:00 AM Anne Macedo
<annemacedo@linux.microsoft.com> wrote:
>
> On 29/09/22 23:32, John Fastabend wrote:
> > Anne Macedo wrote:
> >> If BTF is corrupted, a SEGV may occur due to a null pointer dereferenc=
e on
> >> bpf_object__init_user_btf_map.
> >>
> >> This patch adds a validation that checks whether the DATASEC's variabl=
e
> >> type ID is null. If so, it raises a warning.
> >>
> >> Reported by oss-fuzz project [1].
> >>
> >> A similar patch for the same issue exists on [2]. However, the code is
> >> unreachable when using oss-fuzz data.
> >>
> >> [1] https://github.com/libbpf/libbpf/issues/484
> >> [2] https://patchwork.kernel.org/project/netdevbpf/patch/2021110317321=
3.1376990-3-andrii@kernel.org/
> >>
> >> Reviewed-by: Isabella Basso <isabbasso@riseup.net>
> >> Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 184ce1684dcd..0c88612ab7c4 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(struct=
 bpf_object *obj,
> >>
> >>      vi =3D btf_var_secinfos(sec) + var_idx;
> >>      var =3D btf__type_by_id(obj->btf, vi->type);
> >> +    if (!var || !btf_is_var(var)) {
> >> +            pr_warn("map #%d: non-VAR type seen", var_idx);
> >> +            return -EINVAL;
> >> +    }
> >>      var_extra =3D btf_var(var);
> >>      map_name =3D btf__name_by_offset(obj->btf, var->name_off);
> >>
> >> --
> >> 2.30.2
> >>
> >
> >
> > I don't know abouut this. A quick scan looks like this type_by_id is
> > used lots of places. And seems corrupted BTF could cause faults
> > and confusiuon in other spots as well. I'm not sure its worth making
> > libbpf survive corrupted BTF. OTOH this specific patch looks ok.
> >
>
> I was planning on creating a function to validate BTF for these kinds of
> corruptions, but decided to keep this patch simple. This could be a good
> idea for some future work =E2=80=93 moving all of the validations to
> bpf_object__init_btf() or to a helper function.

This whack-a-mole game of fixing up BTF checks to avoid one specific
corruption case is too burdensome. There is plenty of BTF usage before
the point which you are fixing, so with some other specific corruption
to BTF you can trigger even sooner corruption.

As I mentioned on Github. I'm not too worried about ossfuzz generating
corrupted BTF because that's not a very realistic scenario. But it
would be nice to add some reasonable validation logic for BTF in
general, so let's better concentrate on that instead of adding these
extra checks.

>
> > How did it get corrupted in the first place? Curious to see if
> > others want to harden libbpf like this.
> >
>
> There's a test case by oss-fuzz [1] that generated this corrupted BTF.
> There's also some C code for replicating this bug [2] using the oss-fuzz
> data.
>
> On a side note, fixing this bug would help oss-fuzz find other, more
> relevant, bugs.
>
> Found the original oss-fuzz report at [3].
>
> [1] https://oss-fuzz.com/download?testcase_id=3D5041748798210048
> [2] https://github.com/libbpf/libbpf/issues/484#issuecomment-1250020929
> [3] https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=3D42345
