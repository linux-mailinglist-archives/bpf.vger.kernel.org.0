Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB38F58552C
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiG2Syk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiG2Syj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 14:54:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE1C3342F
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:54:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bn9so7052854wrb.9
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYaPDgXVXhsnvTLilrx3da7NMjfX5OyTXLmeQFKOx88=;
        b=hDw8dURdgZDtECmu58poVi4wQAsCc8NnE3AuwrYJwq1vkZag8IW+nhTZlzrOLrzEuY
         7CAfO0Fow3etlnCg1F3jNB/5mf/4ZplglGtXl1xZbbe6IBwj5jpjZEpNwEyTclKiwlWR
         0B9YM4QUWZlkXvlNGMdMgBSsxmibICIzmX958aqWd3UMxOJtzSI0UYA/gUrgzFNh8lmG
         edEZZKxJWglghbCPZS52CQau4bHxdkvSkiO9/E/iYLKINgfWPbSf0EAe5aBkSGlffFkr
         tx6lUU3gGBFakQERPXhv4jfNMdr+OYQCVPHDjHtR1wc4HxPIThfmomOAt/dhmhm9XGFD
         kVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYaPDgXVXhsnvTLilrx3da7NMjfX5OyTXLmeQFKOx88=;
        b=pZ0vkRWM9BAwV5dxmZRqZvaJLjVwD0sTaNRN8EK7M+/mwFNidFt0T0ShWeIQ77Div0
         yhegMV6YbU5BZnRh14uC5sYKxggsUfZfW6PNNvTsvlDz8xCWSHtgaNXVwBlrYmVj62rU
         IhsdqcVhlwV5JIpJ3jsb2aL6ZEZtqWTQc8YEDQSCyiPqScWHL+EKXO5crK+aLhl/NpQY
         /EF1nrbLZGXsbXRQurj7kijxkpMWsazfFc+yzRnm9nDpfQ4JHrot0c6u2lVIimhDTUAt
         4qxRDo537uvpOGBtVQ3svWCIUziHDWia1HBcGzyaFWe5sFSERMAMmTVKOn7hx9vLrEg2
         4nPg==
X-Gm-Message-State: ACgBeo1NKhuDrAgRJ2F3u57K5WsvSCHh8dStFt1Bjf2iiia3AgI06Nnq
        QGfuDSqrYupTSRf6o2c04j1MjKz74izaAT7TC9U=
X-Google-Smtp-Source: AA6agR75KW/zF/2XN0ev9yPRrIdCipFUwyGUrv1MGET1w3I9KrO4kl4fAFZkuqWQ+HeUkm0d+enAdO8IOrb2PnbqxXU=
X-Received: by 2002:a5d:64a6:0:b0:21f:b3b:5cc9 with SMTP id
 m6-20020a5d64a6000000b0021f0b3b5cc9mr3071047wrp.601.1659120877186; Fri, 29
 Jul 2022 11:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220729061817.126062-1-chantr4@gmail.com> <675f99fb-7ec4-71eb-130c-a47936feadc4@isovalent.com>
In-Reply-To: <675f99fb-7ec4-71eb-130c-a47936feadc4@isovalent.com>
From:   Manu Bretelle <chantr4@gmail.com>
Date:   Fri, 29 Jul 2022 11:54:20 -0700
Message-ID: <CAArYzrJA4s6cg0kzLfVHNMjczds2eE_CKJHcsoP56NOMwhFH+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] remove BPF_OBJ_NAME_LEN restriction when looking
 up bpf program by name
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 2:53 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 29/07/2022 07:18, Manu Bretelle wrote:
> > From: chantra <chantr4@gmail.com>
> >
> > bpftool was limiting the length of names to
> > [BPF_OBJ_NAME_LEN](https://github.com/libbpf/bpftool/blob/2d7bba1e8c17dd0422879c856cda66723b209952/src/common.c#L823-L826).
> >
> > Since
> > https://github.com/libbpf/bpftool/commit/61833a284f48b90f6802c141c8356de64bb41e10
> > we can get the full program name from BTF.
> >
> > This diffs remove the restriction of name length when running `bpftool
>
> -> "This patch removes"?
>
> > prog show name ${name}`.
> >
> > Test:
> > Tested against some internal program names that were longer than
> > `BPF_OBJ_NAME_LEN`, here a redacted example of what was ran to test.
> >
> > ```
> > $ sudo bpftool prog show name some_long_program_name
> > Error: can't parse name
> > $ sudo ./bpftool prog show name some_long_program_name
> > 123456789: tracing  name some_long_program_name  tag taghexa  gpl ....
> > ...
> > ...
> > ...
> > ```
>
> Thanks a lot for the patch! The suggested change looks good, but the
> code and the patch themselves need some adjustments.
>
> Regarding your commit object (and email subject): Please prefix with the
> component that you update. For your next version, this should be:
>
>     [PATCH bpf-next v2] bpftool: Remove BPF_OBJ_NAME_LEN...
>
> For the commit description, please avoid external links (GitHub). Prefer
> function names (we can grep for them) or commit references [0]. I would
> also recommend against too much Markdown mark-up, the triple quotes
> could be removed and the snippet indented instead.
>
> Your commit is also missing your Signed-off-by tag in its description,
> you will need to add it [1].
>
> [0]
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed+off#describe-your-changes
> [1]
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed+off#sign-your-work-the-developer-s-certificate-of-origin
>

Thanks for the feedback and providing relevant links. I will amend the
commit to reflect your feedback. Markdown was an artifact of this
being a GH PR originally. I will go for plaintext.


> > ---
> >  tools/bpf/bpftool/common.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> > index 067e9ea59e3b..bc9017877296 100644
> > --- a/tools/bpf/bpftool/common.c
> > +++ b/tools/bpf/bpftool/common.c
> > @@ -722,6 +722,7 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
> >
> >  static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
> >  {
> > +     char prog_name[MAX_PROG_FULL_NAME];
> >       unsigned int id = 0;
> >       int fd, nb_fds = 0;
> >       void *tmp;
> > @@ -754,12 +755,21 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
> >                       goto err_close_fd;
> >               }
> >
> > -             if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
> > -                 (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
> > +             if (tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) {
> >                       close(fd);
> >                       continue;
> >               }
> >
> > +
> > +
>
> Too many blank lines, please use just one.
>
> > +             if (!tag) {
> > +                     get_prog_full_name(&info, fd, prog_name, sizeof(prog_name));
> > +                     if (strcmp(nametag, prog_name)) {
>
> strncmp(), please
>

Both are NULL terminated, but I am happy to add the extra safeguard.

> > +                             close(fd);
> > +                             continue;
> > +                     }
> > +             }
> > +
> >               if (nb_fds > 0) {
> >                       tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
> >                       if (!tmp) {
> > @@ -820,10 +830,6 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
> >               NEXT_ARGP();
> >
> >               name = **argv;
> > -             if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
> > -                     p_err("can't parse name");
> > -                     return -1;
> > -             }
>
> Why removing the check? Just update the bound to MAX_PROG_FULL_NAME - 1?
>
> >               NEXT_ARGP();
> >
> >               return prog_fd_by_nametag(name, fds, false);
>

Make sense. Will do.
