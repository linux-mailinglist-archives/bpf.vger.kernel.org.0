Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B232D5F37CE
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJCVcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 17:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJCVb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 17:31:59 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A3F003
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 14:26:15 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1329abb0ec6so1809933fac.8
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=KKymng1sXMdfPFEPKV+tJxXEzrS/C4WszvsJCpzy5Wc=;
        b=B2GnYJRi9g7uojYqRbfFBPHNJf/Td6U1XTIGmWUy/ZfLvsYw8bzI8o5H5jEh3s9eqn
         gEJCkzNhOkjXgQ6MIYCZF1Rh4l0JDVn/AnqicUYdkDGrzrB5vvo3ZtnV5YAJ5XRKJlZg
         jZF7P8UNN52yUHJUo9iSy73+TFld56DbPipk/w9dkOeYRgwS8Tis1gmY0Hg0FRKhU9HF
         LwuIMHx0BBAbqUfSdiAgc2VUCcJM9EKLsKxED0YnqCh06hmPmrD0693hX4M/G/GCUIyL
         yiAYvFxR7tM7wcaUj2YU34IqmBs6RC519yZhs+AL2QFdHPwgWIgA0zR8rkYo1Q+QOs6A
         htKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KKymng1sXMdfPFEPKV+tJxXEzrS/C4WszvsJCpzy5Wc=;
        b=uSM5bFQuzBavZv0URBJIO48YhHgwlnSH0nzPG3hUk6ktiAwEUVNl0g/DMK+49S9Xul
         KSBgb98gupoIk/YOWKbwFixHJWwowbqtb37kMMbau2MIUr3aeo1Slnb5Gim7zLGlQbGK
         IDLRANwMXeM8zNBn+oXo8zIK+KuxTc7amWoBrogomirCmqb/lX3IwcvyWKFiwV1GGoT6
         EW7w0L+ZIMhSPM5AwNlXhuubM2zR1TwJtXMch0H6Kmd2wMivL3+FLRGHhQLmydZayxq3
         DnRHIEc1tOVPjzkGTWt8162bBE/ic3ZrS0UgDE0BP0lBa/wlF9niIUSB1wUOptcbgA2Z
         h7yA==
X-Gm-Message-State: ACrzQf0VHvVQknohV6DK5ZlRbPnQBr2oOpugchD7iC6Eg628ibDy8iAE
        bV67Ps+0jKObzmXpvImQH/R57D6qfLyjkaooIDmh
X-Google-Smtp-Source: AMsMyM4I8FKtzKNt/csjgIeYqhOifpU1yb4bubOzvk50dkFndGp1GhS7SvSLp+gdsuPkYGStOhpNff+Oo4fyvEPvnqE=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr6627728oab.172.1664832374779; Mon, 03
 Oct 2022 14:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
 <63365532d416f_233df20899@john.notmuch> <92157e05-e383-ed4b-8b01-2981dbf5afd3@linux.microsoft.com>
 <CAEf4BzZxU+YD5CtHEk7S7bXTDMMSsnV3eFYgRXCMft=fx9reMA@mail.gmail.com>
In-Reply-To: <CAEf4BzZxU+YD5CtHEk7S7bXTDMMSsnV3eFYgRXCMft=fx9reMA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Oct 2022 17:26:03 -0400
Message-ID: <CAHC9VhSqHFRpfq1b6Ys+Ygaqr-6KFeziUxtOVpsoBb=TE2csoA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add validation to BTF's variable type ID
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 30, 2022 at 6:39 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Fri, Sep 30, 2022 at 6:00 AM Anne Macedo
> <annemacedo@linux.microsoft.com> wrote:
> >
> > On 29/09/22 23:32, John Fastabend wrote:
> > > Anne Macedo wrote:
> > >> If BTF is corrupted, a SEGV may occur due to a null pointer derefere=
nce on
> > >> bpf_object__init_user_btf_map.
> > >>
> > >> This patch adds a validation that checks whether the DATASEC's varia=
ble
> > >> type ID is null. If so, it raises a warning.
> > >>
> > >> Reported by oss-fuzz project [1].
> > >>
> > >> A similar patch for the same issue exists on [2]. However, the code =
is
> > >> unreachable when using oss-fuzz data.
> > >>
> > >> [1] https://github.com/libbpf/libbpf/issues/484
> > >> [2] https://patchwork.kernel.org/project/netdevbpf/patch/20211103173=
213.1376990-3-andrii@kernel.org/
> > >>
> > >> Reviewed-by: Isabella Basso <isabbasso@riseup.net>
> > >> Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
> > >> ---
> > >>   tools/lib/bpf/libbpf.c | 4 ++++
> > >>   1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > >> index 184ce1684dcd..0c88612ab7c4 100644
> > >> --- a/tools/lib/bpf/libbpf.c
> > >> +++ b/tools/lib/bpf/libbpf.c
> > >> @@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(stru=
ct bpf_object *obj,
> > >>
> > >>      vi =3D btf_var_secinfos(sec) + var_idx;
> > >>      var =3D btf__type_by_id(obj->btf, vi->type);
> > >> +    if (!var || !btf_is_var(var)) {
> > >> +            pr_warn("map #%d: non-VAR type seen", var_idx);
> > >> +            return -EINVAL;
> > >> +    }
> > >>      var_extra =3D btf_var(var);
> > >>      map_name =3D btf__name_by_offset(obj->btf, var->name_off);
> > >>
> > >> --
> > >> 2.30.2
> > >>
> > >
> > >
> > > I don't know abouut this. A quick scan looks like this type_by_id is
> > > used lots of places. And seems corrupted BTF could cause faults
> > > and confusiuon in other spots as well. I'm not sure its worth making
> > > libbpf survive corrupted BTF. OTOH this specific patch looks ok.
> > >
> >
> > I was planning on creating a function to validate BTF for these kinds o=
f
> > corruptions, but decided to keep this patch simple. This could be a goo=
d
> > idea for some future work =E2=80=93 moving all of the validations to
> > bpf_object__init_btf() or to a helper function.
>
> This whack-a-mole game of fixing up BTF checks to avoid one specific
> corruption case is too burdensome. There is plenty of BTF usage before
> the point which you are fixing, so with some other specific corruption
> to BTF you can trigger even sooner corruption.
>
> As I mentioned on Github. I'm not too worried about ossfuzz generating
> corrupted BTF because that's not a very realistic scenario. But it
> would be nice to add some reasonable validation logic for BTF in
> general, so let's better concentrate on that instead of adding these
> extra checks.

Reading the comments here and on the associated GH issue, it sounds
like you would be supportive of this check so long as it was placed in
bpf_object__init_btf(), is that correct?  Or do you feel this
particular check falls outside the scope of "reasonable validation
logic"?  I'm trying to understand what the best next step would be for
this patch ...

--=20
paul-moore.com
