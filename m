Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6FF586B41
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 14:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiHAMtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiHAMs4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 08:48:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1938C491E6
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 05:39:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bv3so60274wrb.5
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qu2/eJbFIuH/FM++QfmuHnkZQbuSaVK+4acrfbCvRlc=;
        b=p81NWbzrcJB3qXZ9xINXDW28VuIq1A9gIlTxGVtmra1qp5JLvxvv7wBK3fOhJgmUtl
         x7+qYw+ofaGCG64wMo4A8Aaa/hHlSUX4yYzybRyWZEZu40Bph6w+w/YDfeWxmtgLk2A0
         QxNeZhtAQm9dUqEBz9vzAoXVmLONbx9+jfwcXWWTCl8FXyL0s6vwuMU7AvuvT5FsVG78
         NX1k1/LDtpzTAAj6Xl8RMrQJL3p3EhVszHRUt+JPEa2ubNRdcHQeYoDb5mF8mTRggWyg
         A2fdfYGvV4B9jbDQGYxIuwq1dS12J9od86onTBO6Cuwax5TK3JNbAi18oQI0SKWwISJf
         CezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qu2/eJbFIuH/FM++QfmuHnkZQbuSaVK+4acrfbCvRlc=;
        b=bIA+UFSC6c3YkJ3C+5+N4HO0//CWrIGXbxmGPbPJFi83fkwkj3mdBEuaVyjsVyiq8A
         tfvm6A5s7sYlszCjX59O31iOm4XBWJJ0higX075KaJte26FD1oWxdetXLR790RF/TIvk
         e7QlRv/9rK+BfdDgVHf0bRcIraZfZ97OmWHrm/scbNx8omaBe9EY0D1m07bpP1qriGeM
         ENhElgN1bBpH5Ns7MZiDXcWIOuM96RHjt+HRVKmcVt903393H7p3somhSNxppzNKs8aS
         Py7VHOyLYRj63bxKZtgDwX4VSq7jJ4OJnjTt7l1KdfdIL6vrtvn2QI0HKiibtN4im9EF
         c6VQ==
X-Gm-Message-State: ACgBeo2t0wPyzLHuiIhC3TwcHLDLsjt8u+3ftkywiT/0T7Q8yB8OzIX0
        twHLo8HN2NyRpb9B5RcZSgSbv3TJ/6RaUlaC3Ig=
X-Google-Smtp-Source: AA6agR6jgJoUM6WkKruE3CAmkuaqdve1YqSyl7Qus+qA7+5tIIkKAI4Lgq0Tr7fpmxqszFyYhiMN4e2aw2NeIuyCYHg=
X-Received: by 2002:a05:6000:1041:b0:220:6882:2594 with SMTP id
 c1-20020a056000104100b0022068822594mr1480681wrx.460.1659357582479; Mon, 01
 Aug 2022 05:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220731181007.3130320-1-chantr4@gmail.com> <98f6a795-50dc-e6d2-87ee-8fafc7e1ee7b@isovalent.com>
In-Reply-To: <98f6a795-50dc-e6d2-87ee-8fafc7e1ee7b@isovalent.com>
From:   Manu Bretelle <chantr4@gmail.com>
Date:   Mon, 1 Aug 2022 05:39:23 -0700
Message-ID: <CAArYzrLEcFCZhCm_ap-FYBzPquzmwdwiejJsR7Uqd7omDG-iuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Remove BPF_OBJ_NAME_LEN restriction
 when looking up bpf program by name
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

On Mon, Aug 1, 2022 at 5:18 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 31/07/2022 19:10, Manu Bretelle wrote:
> > bpftool was limiting the length of names to BPF_OBJ_NAME_LEN in prog_parse
> > fds.
> >
> > Since commit b662000aff84 ("bpftool: Adding support for BTF program names")
> > we can get the full program name from BTF.
> >
> > This patch removes the restriction of name length when running `bpftool
> > prog show name ${name}`.
> >
> > Test:
> > Tested against some internal program names that were longer than
> > `BPF_OBJ_NAME_LEN`, here a redacted example of what was ran to test.
> >
> >     # previous behaviour
> >     $ sudo bpftool prog show name some_long_program_name
> >     Error: can't parse name
> >     # with the patch
> >     $ sudo ./bpftool prog show name some_long_program_name
> >     123456789: tracing  name some_long_program_name  tag taghexa  gpl ....
> >     ...
> >     ...
> >     ...
> >     # too long
> >     sudo ./bpftool prog show name $(python3 -c 'print("A"*128)')
> >     Error: can't parse name
> >     # not too long but no match
> >     $ sudo ./bpftool prog show name $(python3 -c 'print("A"*127)')
> >
> > Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> >
> > ---
> >
> > v1 -> v2:
> > * Fix commit message to follow patch submission guidelines
> > * use strncmp instead of strcmp
> > * reintroduce arg length check against MAX_PROG_FULL_NAME
> >
> >
> >  tools/bpf/bpftool/common.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> > index 067e9ea59e3b..3ea747b3b194 100644
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
> > @@ -754,12 +755,20 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
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
> > +             if (!tag) {
> > +                     get_prog_full_name(&info, fd, prog_name,
> > +                             sizeof(prog_name));
>
> Nit: This line should be aligned with the opening parenthesis from the
> line above, checkpatch.pl complains about it. Probably not worth sending
> a new version just for that, though.

Yeah, I saw that on patchwork. For some reason, the `checkpatch.pl`
version I had from bpf-next tree did not catch this.
Originally, I was getting an error because it was more than 75 char
long. Eventually found out that shiftwidth should have been set to 8
(mine was 4).
I am happy to provide a corrected version if you want, this is really
just a matter of a minute now that I have the right vim indentation
setting.


>
> > +                     if (strncmp(nametag, prog_name, sizeof(prog_name))) {
> > +                             close(fd);
> > +                             continue;
> > +                     }
> > +             }
> > +
> >               if (nb_fds > 0) {
> >                       tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
> >                       if (!tmp) {
> > @@ -820,7 +829,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
> >               NEXT_ARGP();
> >
> >               name = **argv;
> > -             if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
> > +             if (strlen(name) > MAX_PROG_FULL_NAME - 1) {
> >                       p_err("can't parse name");
> >                       return -1;
> >               }
>
> Looks good, thank you!
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
