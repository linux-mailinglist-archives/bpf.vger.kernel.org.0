Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0946B4CD1
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 17:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCJQ0T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 11:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCJQ0F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 11:26:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272AAD25
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 08:22:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i5so6144746pla.2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678465342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1xKJv7I43t6QQTItfrGRf70Ny8ji2NWl1/miCvddqg=;
        b=OCevYKE85PtLl+hcvLgkZwQ3myHlzDiEeMuoDh23Zzra4od6divy+o1JQQWdUhuk9A
         o4/mgex6y9FDuZP3YNRgPHvXlyeMxVZl9OubIvYXQvW78EvctrppmPeakW5g8LZ61vjI
         vWlBHtkqDhwJ/7KPaoyQ/JAsJhJk5BvulX6le0dXxyrKDw/5ho2SkEydVEBrLfOMYdN4
         Zl/piiv2GK4Ycw+i0t34hH41UELJkzVOJ+aB3MTTnOaYrocKdG7AhEhhFCM0UJFBoPWD
         IRUc8VGFMj9wnEVSfLtr5OG1mz/vRgfCXsWz0dgx+voqI/DjOmVSO7IcTRjwKyneN0xe
         iHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1xKJv7I43t6QQTItfrGRf70Ny8ji2NWl1/miCvddqg=;
        b=BB/cQaUb8BdmwzUXRiR58J9y2wooAfRCeW5g79l/eLs8oR4fhf5gdByatqmKQQQzNz
         7T2Q1WkxZ9/GqvB5zDsjSaDhv3U4bEyW8HBCDB9vHC/B3ICBba0AFLJTg/m0h4OoZMUt
         XH3jR4vI0nO9DPwWXY3CEVBXa9JPfeaUuD+mGNn70utTMN7TSmNCYsO4ssZCtbjgY94i
         7aAu9NUz+Hf9r0C7GSgVrI8t1dDDUSplnnaTzvyvUVhKqNc0+o3lLzVv0dYs5etyhQun
         OTl77FjJAngOBb7jplXzZIv0e79BqSWObkAv53Z5f9MZpBzR+vx4zOH1IQzh/tPFXhW9
         mTnw==
X-Gm-Message-State: AO0yUKW+K2FPABVGYy7FXXfvrCo/zWISpAd9O+kR3L49loiIMdMo83ld
        bN7jnk8NH1QCMS0hLOB+BugKAldS3JO6pfcrdV6f
X-Google-Smtp-Source: AK7set9wiX9m/wyVQBYpK751vhyyv8tPww9RBQvJarvcNt2JTkPo0CSGYU9kGj441+l+YuH9JiTiVzuzQQpKcYNdobY=
X-Received: by 2002:a17:90a:dc0d:b0:235:1fb7:393c with SMTP id
 i13-20020a17090adc0d00b002351fb7393cmr1121568pjv.1.1678465342401; Fri, 10 Mar
 2023 08:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
 <20230309085433.1810314-2-roberto.sassu@huaweicloud.com> <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
 <CAHC9VhTt7xZqkfZQsWVLRHzza_9idzxkY7bXxzBMq=Xxfc6+Cg@mail.gmail.com> <3c2ad86758d13939afa9dceaab87fee2ded8201f.camel@linux.ibm.com>
In-Reply-To: <3c2ad86758d13939afa9dceaab87fee2ded8201f.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Mar 2023 11:22:11 -0500
Message-ID: <CAHC9VhQ80t8z79iYaY8xpoiQ5fTURoesaau+5r0bCXZrsO5GUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it for
 the integrity LSM
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 8:39=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2023-03-09 at 17:04 -0500, Paul Moore wrote:
> > On Thu, Mar 9, 2023 at 8:21=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >
> > > > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needin=
g to be
> > > > last, e.g. the 'integrity' LSM, without changing the kernel command=
 line or
> > > > configuration.
> > > >
> > > > Also, set this order for the 'integrity' LSM. While not enforced, t=
his is
> > > > the only LSM expected to use it.
> > > >
> > > > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always e=
nabled
> > > > and put at the end of the LSM list.
> > > >
> > > > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true=
 if an
> > > > LSM is found, regardless of its order. In this way, the kernel woul=
d not
> > > > wrongly report that the LSM is not built-in in the kernel if its or=
der is
> > > > LSM_ORDER_LAST.
> > > >
> > > > Fixes: 79f7865d844c ("LSM: Introduce "lsm=3D" for boottime LSM sele=
ction")
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >
> > Warning: procedural nitpicking ahead ...
> >
> > The 'Signed-off-by' tag is in reference to the DCO, which makes sense
> > to add if you are a patch author or are merging a patch into a tree,
> > but it doesn't make much sense as a ACK/thumbs-up; this is why we have
> > the 'Acked-by' and 'Reviewed-by' tags.  I generally read the
> > 'Acked-by' tag as "I'm the one responsible for a chunk of code
> > affected by this patch and I'm okay with this change" and the
> > 'Reviewed-by' tag as "I looked at this patch and it looks like a good
> > change to me".  Perhaps surprisingly to some, while an 'Acked-by' is a
> > requirement for merging in a lot of cases, I appreciate 'Reviewed-by'
> > tags much more as it indicates the patch is getting some third-part
> > eyeballs on it ... so all you lurkers on this list, if you're
> > reviewing patches as they hit your inbox, don't be shy about posting
> > your 'Reviewed-by' tag if your comfortable doing so, we all welcome
> > the help :)
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
sign-your-work-the-developer-s-certificate-of-origin
>
> In this case, it was a bit unclear who actually was going to upstream
> this patch set.

FWIW, I wasn't expecting to see your sign-off without a note that you
had merged it.  Normally I would have expected either an acked-by or a
note that you had merged it, a sign-off without a merge notice seemed
a little odd to me so I thought I would mention the above :)  No harm
either way, I just figured a little discussion on process might not be
a terrible idea to make sure we are all on the same page.

> It's better that you upstream it,  but since this
> affects subsequent IMA and EVM patches, please create a topic branch.

I generally don't do topic branches for work that has been merged into
a -next or -stable branch. I prefer to limit topic branches to
special-cases where there is some value in keeping a central branch
for multiple people to coordinate while the patchset is still in
development; once a patchset has progressed far enough to be merged
into a -stable or -next branch I stop maintaining the topic branch.

In this particular case the changes to the IMA/EVM code looked very
minor, so I doubt there would be a significant merge conflict with the
IMA/EVM tree during this development cycle, but if you would prefer to
take this patchset via the IMA/EVM tree that is okay with me; just let
me know so I can ACK the two LSM-related patches (I'm going to review
the latest posting today).

As a bit of an aside, while this doesn't cover topic branches (once
again, I consider those special cases), when managing the LSM tree I
follow the process that is documented here:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

[NOTE: the above GH repo is a read-only mirror of the canonical LSM
kernel.org repo, it just happens that GH does a better job rendering
txt]

The main LSM repo process "docs" / pointers can be found in the main
README or "about" page:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/about

If people have suggestions for a different approach to managing the
LSM tree I'm always open to discussion.

--=20
paul-moore.com
