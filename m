Return-Path: <bpf+bounces-11442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0FE7B9DA5
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 78F8B282D4C
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE62262B8;
	Thu,  5 Oct 2023 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLfeULF6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCED250FF
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:52:14 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A904349C8;
	Thu,  5 Oct 2023 06:52:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so1787068a12.1;
        Thu, 05 Oct 2023 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696513931; x=1697118731; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXU5LKhEUYEh+UOKLTIWtg4yqSv2ITj+Fle6A6fBIcY=;
        b=SLfeULF6nw1LrCiQriHvqRRN/bg4i6ExtT7EGEmHNTDO79HD2aocr6y6i5eFroDoHs
         ZFAs6UN9NMRe9ceo/hRkQpz3UgrSEHc98URMnBf/cX1sxlLh2ibwMSrTd3/i0orRlvOw
         NsoYNSlgg6zfI5NcyLPPmdt1s9L/cMmYEPjXM8cdFJr8Nf8bCZ8ca6V/QMHvU9r4P94V
         dXxwXuN9tbFG5mm/laEWMAMWC7T+AcjGWcdJPlxsoTnTfD6aDx+dZaD68pC+l8riQ0iO
         uEMrYFNExF3MpYYZIkw/RPxrMZbOOhfvyi26T8GGm/P44APLfK+uqK0QOxD/Vd4LWkpL
         in8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513931; x=1697118731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXU5LKhEUYEh+UOKLTIWtg4yqSv2ITj+Fle6A6fBIcY=;
        b=UK4F4BCnDKqh0W56mU5nsGMox2i6QHKsjkzU5OoOVB9eOVCGffmfFK8XJ1lo90ggFS
         5xk7TwGdSlTy0fvoltyHwIF+XslrlTi2CXtbdbYH7i15Fle6ZbBaDqoBEqSYY5VrclyQ
         yzcZTqQoINqEwzhZDnmiw7+oXhs7454DhPXQoPe4XFWvd8te6uFL19+GcMsFQnfhk/iW
         wN450crxqdIMgc+YG6bq1IIDEKSCETbnxmlN0XlfzkH1V62lFbG7T9zOD4w+9IT2D4ea
         MPTxiPXdSXdDq0JPbGovzEMX3QMTjuh8OhI8ApxV1P02T8k3CK2r4P9sxXSsP7yZf6M1
         W2PA==
X-Gm-Message-State: AOJu0Yyggo+bV5GKJn1XLyUk3rDknx0CsgopiIwWeW7TBUmx3xDsZ79f
	tRmIlt2sD5gqiBblMHEcruB3sPqyqzI=
X-Google-Smtp-Source: AGHT+IFIa8BRuPwMn2n8dH8rtcUowfST0euOC8DTQPttzb93oHi3jkImZQus0XRA0kI5x6dPMHHIqA==
X-Received: by 2002:a17:907:7711:b0:9ae:82b4:e309 with SMTP id kw17-20020a170907771100b009ae82b4e309mr4830924ejc.0.1696513930785;
        Thu, 05 Oct 2023 06:52:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o20-20020a170906289400b009930042510csm1216027ejd.222.2023.10.05.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:52:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Oct 2023 15:52:08 +0200
To: KP Singh <kpsingh@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, paul@paul-moore.com, keescook@chromium.org,
	casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <ZR6/iMnfl1q6Hf9I@krava>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
 <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava>
 <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
 <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 03:27:35PM +0200, KP Singh wrote:
> On Thu, Oct 5, 2023 at 3:26 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Thu, Oct 5, 2023 at 10:09 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Sep 28, 2023 at 10:24:09PM +0200, KP Singh wrote:
> > >
> > > SNIP
> > >
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index e97aeda3a86b..df9699bce372 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -13,6 +13,7 @@
> > > >  #include <linux/bpf_verifier.h>
> > > >  #include <linux/bpf_lsm.h>
> > > >  #include <linux/delay.h>
> > > > +#include <linux/bpf_lsm.h>
> > > >
> > > >  /* dummy _ops. The verifier will operate on target program's ops. */
> > > >  const struct bpf_verifier_ops bpf_extension_verifier_ops = {
> > > > @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
> > > >  {
> > > >       enum bpf_tramp_prog_type kind;
> > > >       struct bpf_tramp_link *link_exiting;
> 
> I think this is a typo here. It should be existing, no?

yes, I was wondering about that as well ;-)

jirka

> 
> > > > -     int err = 0;
> > > > +     int err = 0, num_lsm_progs = 0;
> > > >       int cnt = 0, i;
> > > >
> > > >       kind = bpf_attach_type_to_tramp(link->link.prog);
> > > > @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
> > > >                       continue;
> > > >               /* prog already linked */
> > > >               return -EBUSY;
> > > > +
> > > > +             if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
> > > > +                     num_lsm_progs++;
> > >
> > > this looks wrong, it's never reached.. seems like we should add separate
> > > hlist_for_each_entry loop over trampoline's links for this check/init of
> > > num_lsm_progs ?
> > >
> > > jirka
> >
> > Good catch, I missed this during my rebase, after
> > https://lore.kernel.org/bpf/20220510205923.3206889-2-kuifeng@fb.com/
> > this condition is basically never reached. I will do a general loop
> > over to count LSM programs and toggle the hook to true (and same for
> > unlink).
> >
> > - KP
> >
> > [...]

