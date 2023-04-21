Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A172E6EAECA
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjDUQJn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjDUQJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:09:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4314448
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:09:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51f597c975fso2364137a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682093379; x=1684685379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7TyNAimvjnAmYvJHrfeJZkU6/BthWton9MEBpuDG5o=;
        b=UKISpSfuqAV4Rhek6hhwVLHMI5Us4zFdHXXw5OTkf0Iu6eer2etJlVl2hhSR4xgU0Z
         +lpXSfaW5+xDTmBtSeuHzJelM23Xy74yobIiEEvkc1AVmsvWu+BZ3VxeB7OWoYsFTXV0
         MM/q7RnghK1lTsT+626qjxu/aGqHpjQOx55lAtQk9ZtV5eKnkmfKqy2xp5dqK9HMLt75
         HDwTT82pX/Rg+viwbe7Y9theEukVOwVNgE3iQOik52I4ILeg4FSHuB3GAJManMLQ2ylh
         22eYQOnIi0m3VN8YU6eLRsoEWokUMk8K+eUjTlWWJkfbvTRi7T6sdndjxbKpGzv1ciLa
         DUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682093379; x=1684685379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7TyNAimvjnAmYvJHrfeJZkU6/BthWton9MEBpuDG5o=;
        b=B3lmE/B/fo7FrFR2Cjpgj2BwnzZxrAACX79/RT/TtC6ot7N21nUuXHcLFD0XItKXaO
         hOEEgcv0jkOlyFAsgAbUpmZU6zdurQvp4fNn73qL4VbjUwp+HWyZu4OTNIPHoI6x+Z/9
         onE55gdUFq9prtv0mxZOBG/R6ybxltV7XIqxBLhCdy12Ra9JN4QgXd82xQkNPSqbBUD3
         VnaFzqtVjJsXzlPEbK76Whw3qP3jxtvQEJ8kNfbWPb3jf2LFKCyU7lwz9n8eHA3+k9kW
         a8p9jxts2IMUEQSV/ZK9H4lgla+Kge8CRi4MR48PzzVngbmbAe4gnM2eaGoRgPVEgurr
         fpVw==
X-Gm-Message-State: AAQBX9eyNy3bOx+FL7rG0/iWMSKahcSbuOGk0d8rxUZm8kgVd/blk9BO
        7eMKgC4/E5sORChqSYRyP7HWVt7MB05A24/dIckGMg==
X-Google-Smtp-Source: AKy350Ye2vOuRIDBOJdCoepC0ONFRzIligLExb2i6zq68huA8Hdu/H1Zi/eh+nnED6esJ6dCoIDfHdgA3LgOd6ztY28=
X-Received: by 2002:a17:90a:950e:b0:24b:2ef6:64d5 with SMTP id
 t14-20020a17090a950e00b0024b2ef664d5mr5488306pjo.47.1682093378997; Fri, 21
 Apr 2023 09:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com> <20230418225343.553806-4-sdf@google.com>
 <4a2e1b70-9055-f5d9-c286-3e5760f06811@iogearbox.net>
In-Reply-To: <4a2e1b70-9055-f5d9-c286-3e5760f06811@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 21 Apr 2023 09:09:27 -0700
Message-ID: <CAKH8qBshg+bF59LUXypxvPX1Gek2AASL+DQydVLMgqGT4ONfGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 21, 2023 at 8:24=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 4/19/23 12:53 AM, Stanislav Fomichev wrote:
> > Over time, we've found out several special socket option cases which ne=
ed
> > special treatment. And if BPF program doesn't handle them correctly, th=
is
> > might EFAULT perfectly valid {g,s}setsockopt calls.
> >
> > The intention of the EFAULT was to make it apparent to the
> > developers that the program is doing something wrong.
> > However, this inadvertently might affect production workloads
> > with the BPF programs that are not too careful.
>
> Took in the first two for now. It would be good if the commit description
> in here could have more details for posterity given this is too vague.

Thanks! Will try to repost next week with more details.

> > Let's try to minimize the chance of BPF program screwing up userspace
> > by ignoring the output of those BPF programs (instead of returning
> > EFAULT to the userspace). pr_info_ratelimited those cases to
> > the dmesg to help with figuring out what's going wrong.
> >
> > Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   kernel/bpf/cgroup.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index a06e118a9be5..af4d20864fb4 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -1826,7 +1826,9 @@ int __cgroup_bpf_run_filter_setsockopt(struct soc=
k *sk, int *level,
> >               ret =3D 1;
> >       } else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
> >               /* optlen is out of bounds */
> > -             ret =3D -EFAULT;
> > +             pr_info_ratelimited(
> > +                     "bpf setsockopt returned unexpected optlen=3D%d (=
max_optlen=3D%d)\n",
> > +                     ctx.optlen, max_optlen);
>
> Does it help any regular user if this log message is seen? I kind of doub=
t it a bit,
> it might create more confusion if log gets spammed with it, imo.

Agreed, but we need some way to let the users know that their bpf
program is doing the wrong thing (if they set the optlen too high for
example).
Any other better alternatives to expose those events?

> >       } else {
> >               /* optlen within bounds, run kernel handler */
> >               ret =3D 0;
> > @@ -1922,7 +1924,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct soc=
k *sk, int level,
> >               goto out;
> >
> >       if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
> > -             ret =3D -EFAULT;
> > +             pr_info_ratelimited(
> > +                     "bpf getsockopt returned unexpected optlen=3D%d (=
max_optlen=3D%d)\n",
> > +                     ctx.optlen, max_optlen);
> >               goto out;
> >       }
> >
> >
>
