Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94686CF230
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC2Sf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 14:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC2Sf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 14:35:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9001FDA
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:35:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y4so67159816edo.2
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680114956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=074Y6a1LOZyvJ0HpDP0R80x1CPITuTgLuzL4FbpLXG4=;
        b=Q3XcwcBsTUyIC0Ud2Jt1CBbZW8TJRh7iOQJBI/1gOAr7h3Pn4n+2wZlhqtc/eaMbzB
         Hm1X86IBAV2AY7GPMNsAKRpoEm3DbAUhNBWi0ym66OeTB6BQcUM/+Skj9EONo3U2wSSl
         5sX66LKzXuSxUaOJd6C1nOee+Nz2WWRiWJOZSKKxnA66r1rj15KblXkYT0KVzDwoGy4E
         urE4fYYRos/G+BOZueIxZzKmen+fi8pXlr0c9M8yHkXSesHKKCKxyGR5CFruXzRLsG5Q
         7BxZIO4WxHALWdZN9n1VR74tRFohq9qMR436joG4xFST+W0RIFlDyGpfBdg+ttz4FDY6
         CILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680114956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=074Y6a1LOZyvJ0HpDP0R80x1CPITuTgLuzL4FbpLXG4=;
        b=zRU9Er94aIDirQ2EGdan93uulhOsIAWF8OJWR39UG2c+dALxHX6h80BtJeEZlNRlFI
         UKI8gG1N8zgHcm8CZOK4VyfqEEM5aNwpkUmdO77aDRACdIsvWcbSKWtfMeAFHgbW9pNn
         Q3yiQKOkYj1lxfs8VVW2KfOp4jllY+G6iS5eqDIRPXDc6ZIMksGgSP+F68NIjToplhwS
         6QEPXCgu44bs/yO2+03F1tx5VgRFpQyUecBYuWtlqgxh980XAOjLY0t6jBHSxpWzt2M4
         yh67b/OevMi4XKLthGzHxdpU1VdZDXsquv0vX+zRA2Bgm4cn3qsLaWDl105b0mdn34vu
         rlVw==
X-Gm-Message-State: AAQBX9fYAwpi8su37v24Fo94er8qyfrxreOe6yTSXfoW7N9teaCI0Em+
        3TU+JAQIfskN/A8A1KXXOPQKmPxZ44NXxtCJQ4s=
X-Google-Smtp-Source: AKy350YX84lZie+ZERVUjirwfZi73jBnOYvOyq2eP81TdJGgPidfGCXIfYZYF0S8OJnkqKFqli2xZcg5cI6b9rpcG0g=
X-Received: by 2002:a17:906:a146:b0:931:fb3c:f88d with SMTP id
 bu6-20020a170906a14600b00931fb3cf88dmr10167622ejb.5.1680114955724; Wed, 29
 Mar 2023 11:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230327185202.1929145-1-andrii@kernel.org> <20230327185202.1929145-3-andrii@kernel.org>
 <4dfb40c14e1ad9fb2d7903236d0a19bb6b14f06e.camel@gmail.com>
In-Reply-To: <4dfb40c14e1ad9fb2d7903236d0a19bb6b14f06e.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 29 Mar 2023 11:35:43 -0700
Message-ID: <CAEf4Bzbe8v8AHgKXq_T_M4cTOUEJuYGL2bvASdnkpFugWVLS6g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] veristat: add -d debug mode option to see
 debug libbpf log
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 10:37=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2023-03-27 at 11:52 -0700, Andrii Nakryiko wrote:
> > Add -d option to allow requesting libbpf debug logs from veristat.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/veristat.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/sel=
ftests/bpf/veristat.c
> > index 83231456d3c5..263df32fbda8 100644
> > --- a/tools/testing/selftests/bpf/veristat.c
> > +++ b/tools/testing/selftests/bpf/veristat.c
> > @@ -135,6 +135,7 @@ static struct env {
> >       char **filenames;
> >       int filename_cnt;
> >       bool verbose;
> > +     bool debug;
> >       bool quiet;
> >       int log_level;
>
> Nitpick:
>   it is now three booleans that control verbosity level, would it be
>   better to use numerical level instead?
>

I don't think so, because bool fields make checks cleaner in specific
places in the code.

> >       enum resfmt out_fmt;
> > @@ -169,7 +170,7 @@ static int libbpf_print_fn(enum libbpf_print_level =
level, const char *format, va
> >  {
> >       if (!env.verbose)
> >               return 0;
> > -     if (level =3D=3D LIBBPF_DEBUG /* && !env.verbose */)
> > +     if (level =3D=3D LIBBPF_DEBUG  && !env.debug)
> >               return 0;
> >       return vfprintf(stderr, format, args);
> >  }
> > @@ -186,6 +187,7 @@ static const struct argp_option opts[] =3D {
> >       { NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
> >       { "verbose", 'v', NULL, 0, "Verbose mode" },
> >       { "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 fo=
r normal mode, 1 for verbose mode)" },
> > +     { "debug", 'd', NULL, 0, "Debug mode (turns on libbpf debug loggi=
ng)" },
> >       { "quiet", 'q', NULL, 0, "Quiet mode" },
> >       { "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
> >       { "sort", 's', "SPEC", 0, "Specify sort order" },
> > @@ -212,6 +214,10 @@ static error_t parse_arg(int key, char *arg, struc=
t argp_state *state)
> >       case 'v':
> >               env.verbose =3D true;
> >               break;
> > +     case 'd':
> > +             env.debug =3D true;
> > +             env.verbose =3D true;
> > +             break;
> >       case 'q':
> >               env.quiet =3D true;
> >               break;
>
