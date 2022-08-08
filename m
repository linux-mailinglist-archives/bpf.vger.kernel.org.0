Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9158D007
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiHHWKz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiHHWKy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 18:10:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B18193F2
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 15:10:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o22so12991505edc.10
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9WnaC6iMSWa0+TpGov0vsXseSwxzl3ZxKUf70ziLloc=;
        b=RX5HpAzNCcT6CpBhkXQT3b7PtE8YUIiQwqKv4OaAqsgmx6u/QY6CmjIvoL2bEmaxDL
         XSrzr9WD1yBHqEpiGBav/u1LqOPIpmIUUOzoibxG1a4HNzatygthXfhs4q6UDitEjpn7
         E74HBhtwp3b5CffxA23UkJ+PxAtt+v0E9yLWcYld6Sjb3lYX1waTLFM9665W9LQvU18X
         RC1hFtBFOoRg1AIm8xJoBlqj4ume5d04L49JmRsz5yBJsGVeYcIeP+XaiL5VC7ExWBDT
         AfhxW25p9ZR4ugSpUt5qqCdevVH0JQdztHM7b6qt6a3FPYDdWHGfkRBaU4NIaXs6cA+l
         TBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9WnaC6iMSWa0+TpGov0vsXseSwxzl3ZxKUf70ziLloc=;
        b=ewFauN8+XuLWufj7HTfdO71CUQHK8Z5a42w55tRtQ4O62c8cKxsao51/T6kySNMhXs
         rxAW4hF5JfULQGl8lBgfjHVkvGFXCyimdl0oADaDTa9vZzajCU45Y53/EraYFcl+IitJ
         ycBIQHgFmGZbVDVY3TsPJQ05livtXXP8c4M9yqKRc1Shn0otKv3+GniXpBbfNosC53wi
         rlwaAQ0ceR7kxTdZ3J0aV7W8wGP6NRq4txZ5WwtBuwiAx9/0IXeQ8pgY+aZ6v8cy1sCF
         XS4FsrfybgmMV82Vy1icNQbpb+3KPewT0HmSIRUqAcZF5Gp0XjG2k+EAX1XBizOeXGfm
         LiFg==
X-Gm-Message-State: ACgBeo00bXNwWqmaaQLVyDOheAUaSgWZuBRBh05yDYa6wYiEuamXJ32/
        0cQRAMkHm5U5DewcYMPJglGL7jiCYyUdq4wKXlc=
X-Google-Smtp-Source: AA6agR5i3gbksuzMuhVX/PLp+2GLMB6QD20t3jG+Y7KD6U/zyTnU5eLOCSPDN1TX5Nnfp8xl4VVbnUtanGNPcXa+7JI=
X-Received: by 2002:a50:ed82:0:b0:43d:5334:9d19 with SMTP id
 h2-20020a50ed82000000b0043d53349d19mr18969972edr.232.1659996651969; Mon, 08
 Aug 2022 15:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220806102021.3867130-1-hengqi.chen@gmail.com> <4d99b1f7-3970-53e4-0d12-c65a0dca7885@fb.com>
In-Reply-To: <4d99b1f7-3970-53e4-0d12-c65a0dca7885@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Aug 2022 15:10:40 -0700
Message-ID: <CAEf4Bzafw5kD=0w=eQQf4=HE9GcAryu5pTV39RkD9d6oj8Oqzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Do not require executable permission for
 shared libraries
To:     Yonghong Song <yhs@fb.com>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, Goro Fuji <goro@fastly.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 10:18 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/6/22 3:20 AM, Hengqi Chen wrote:
> > Currently, resolve_full_path() requires executable permission for both
> > programs and shared libraries. This causes failures on distos like Debian
> > since the shared libraries are not installed executable ([0]). Let's remove
> > executable permission check for shared libraries.
> >
> >    [0]: https://www.debian.org/doc/debian-policy/
>
> The document is too big. Could you be more specific about
> which chapter and copy-paste related statements in the commit message?
>

I just dropped that link and added "and Linux is not requiring shared
libraries to have executable permissions". Pushed to bpf-next, thanks.


> >
> > Reported-by: Goro Fuji <goro@fastly.com>
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 77e3797cf75a..f0ce7423afb8 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10666,7 +10666,7 @@ static const char *arch_specific_lib_paths(void)
> >   static int resolve_full_path(const char *file, char *result, size_t result_sz)
> >   {
> >       const char *search_paths[3] = {};
> > -     int i;
> > +     int i, perm = R_OK;
> >
> >       if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
> >               search_paths[0] = getenv("LD_LIBRARY_PATH");
> > @@ -10675,6 +10675,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
> >       } else {
> >               search_paths[0] = getenv("PATH");
> >               search_paths[1] = "/usr/bin:/usr/sbin";
> > +             perm |= X_OK;

I changed this bit a bit to just set perm = R_OK for library case and
explicitly perm = R_OK | X_OK for executable case. I think that makes
it a bit easier to follow (and it doesn't change the outcome).

Thanks for the quick follow up from Github issue!

> >       }
> >
> >       for (i = 0; i < ARRAY_SIZE(search_paths); i++) {
> > @@ -10693,8 +10694,8 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
> >                       if (!seg_len)
> >                               continue;
> >                       snprintf(result, result_sz, "%.*s/%s", seg_len, s, file);
> > -                     /* ensure it is an executable file/link */
> > -                     if (access(result, R_OK | X_OK) < 0)
> > +                     /* ensure it has required permissions */
> > +                     if (access(result, perm) < 0)
> >                               continue;
> >                       pr_debug("resolved '%s' to '%s'\n", file, result);
> >                       return 0;
