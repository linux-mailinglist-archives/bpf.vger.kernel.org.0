Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9C342E9D
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 18:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCTR0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCTRZt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Mar 2021 13:25:49 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D40C061574
        for <bpf@vger.kernel.org>; Sat, 20 Mar 2021 10:25:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id o66so1774149ybg.10
        for <bpf@vger.kernel.org>; Sat, 20 Mar 2021 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVIinhS/vIBV/fUFeujvsaJzkgpw4YNUVX/tihKflvc=;
        b=UYPUvWsSffEtnmsfInLgbc1q0dkHXfBOYvYV0DhnPhoUc8KGkdZ0Dl4DcIWZQntW3S
         DNmreXMK/BnL0BApT9YB6dAhGBF4oBYBsDjMDm4KxYWRS+e1wKH7jLE7JGE+4HmW6noh
         WVU2+Mae9jpOOVUjAR47CrY8Rs3ivFFmkaghOOfLDx2mqEPvoyx5urtehiS4PWcLqAtp
         P4eYbF4j52HphnuTWy/P1H++8QinA1Kug7kv/zrGlgApJTIymXEbdU7RZtRw5JxZc7OY
         YgJ0e3hvoQeGeGTzdy4vUAypPwE/yHWuy35fU4cUgwOzA9QXKPZkWFndXoGMIQo+pYCe
         SkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVIinhS/vIBV/fUFeujvsaJzkgpw4YNUVX/tihKflvc=;
        b=XBZ+YZe0eWtCDz/6O1vmE/wtRPau3diXoG2KqPJ+izn0avdME3dMuIRulHVN+zcX7O
         Pxpa8c0SFB9LEqbIS8WrV2p7BQbn3+fkxdY2RrmNbULP+alf9VRjx82EyR7yz5t7Kwis
         rowiwpFwOm9D73nkIyG3KtMYPVOKB/vH10Mnu51FfMigN030gZkTi09MlD3pbFFiVGa0
         3BKTkIC/C/By2UW+7khEjxRK4+t8Mml6yNP2S9eSC1ip93SeskS0VUrTHLYT+Iblv4r6
         D/csYXYxqdWO882HqNT1R7+7ezYBmpS3UfmEF6ta8V3cyg9s0xcRLrzS5xRqC+7y6jL+
         TsIw==
X-Gm-Message-State: AOAM5301VMmV4+e7OWNNEjO5t8KDVoyJDb5/4a4HPabvavBCXUPugLbI
        sF1G1ogzmASC9xeel0CuTVmn5uUj4Zy62GZX1H+GQ3wUw+c=
X-Google-Smtp-Source: ABdhPJzVl4s82+zjkp9lLmmnN0D7HOvtRubXruj7gZqnZD1PmatE1TPqhpj+cdSHdj9EOz4M11+V+kWH9rF0vgs4eZM=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr13735586yba.459.1616261147818;
 Sat, 20 Mar 2021 10:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210320041623.2241647-1-rafaeldtinoco@ubuntu.com> <CAEf4Bzah-xFhO-hDzsZZoynsR_BuihAHVQ4jUMPYqyPstdJ9_Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzah-xFhO-hDzsZZoynsR_BuihAHVQ4jUMPYqyPstdJ9_Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 20 Mar 2021 10:25:37 -0700
Message-ID: <CAEf4BzZ-gwnMGrKQJk1eeF_GmM703h13oXe1NXJhrXpF1Vw-Mg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add bpf object kern_version attribute setter
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 20, 2021 at 10:23 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 19, 2021 at 9:16 PM Rafael David Tinoco
> <rafaeldtinoco@ubuntu.com> wrote:
> >
> > Unfortunately some distros don't have their kernel version defined
> > accurately in <linux/version.h> due to different long term support
> > reasons.
> >
> > It is important to have a way to override the bpf kern_version
> > attribute during runtime: some old kernels might still check for
> > kern_version attribute during bpf_prog_load().
> >
> > Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> > ---
> >  src/libbpf.c | 15 +++++++++++++++
> >  src/libbpf.h |  1 +
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/src/libbpf.c b/src/libbpf.c
> > index 0c4a386..7b52cd6 100644
> > --- a/src/libbpf.c
> > +++ b/src/libbpf.c
> > @@ -8278,6 +8278,21 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
> >         return obj->btf ? btf__fd(obj->btf) : -1;
> >  }
> >
> > +int bpf_object__set_kversion(struct bpf_object *obj, char *kern_version)
> > +{
> > +       __u32 major, minor, patch;
> > +
> > +       if (!kern_version) {
> > +               obj->kern_version = 0;
> > +               return 0;
> > +       }
> > +       if (sscanf(kern_version, "%u.%u.%u", &major, &minor, &patch) != 3)
>
> given SEC("version") expects `int` and bpf_object__kversion() returns
> int, I think it's appropriate for bpf_object__set_kversion() to accept
> just opaque int as well. Please also check that obj is not loaded and
> return error if it is. Thanks!
>

Oh, and please use [PATCH bpf-next] subject prefix to specify that
this is destined to the bpf-next tree. You'll also add v2 in between
PATCH and bpf-next for the next version, of course.


> > +               return -1;
> > +       obj->kern_version = KERNEL_VERSION(major, minor, patch);
> > +
> > +       return 0;
> > +}
> > +
> >  int bpf_object__set_priv(struct bpf_object *obj, void *priv,
> >                          bpf_object_clear_priv_t clear_priv)
> >  {
> > diff --git a/src/libbpf.h b/src/libbpf.h
> > index 3c35eb4..3e14ae7 100644
> > --- a/src/libbpf.h
> > +++ b/src/libbpf.h
> > @@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
> >
> >  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
> >  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
> > +LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, char *kern_version);
> >
> >  struct btf;
> >  LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
> > --
> > 2.27.0
> >
