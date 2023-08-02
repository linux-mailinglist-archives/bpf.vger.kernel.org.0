Return-Path: <bpf+bounces-6658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C476C2E4
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EF31C210BC
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED8A44;
	Wed,  2 Aug 2023 02:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987E7E
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:29:51 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D8268C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:29:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so38255031fa.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 19:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690943387; x=1691548187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOJuZZFFX2LE/w7s6LGZvLuvbn7OkI/88EWjdCuwZJg=;
        b=Wj41toKy1kjY3DImM43ktBBieBpJRHbaEvWXzPOOhQIgsBlpBPvikdu+/BuZ85Rdvk
         y09uYWI9WJlaPtCXoRyjZmmyakhSk0n9tRlvtScCe4K8QblSkQYSnhHYuaJIXFn62ct0
         O0QLh8eDzsniLdFYfxqxJQMwl5eDtlABhSAl9kAQ2cJdL4RbwV2rtq9kIlvpvgfrQsIN
         mJFRqQPm1RekG1XPpTZrtTH7lvyad3ndyUlaL3HYq5AV0qXk39FHUxdLKkbMICGMcMs9
         9Jbixxvr401MOVhIXvxiNzhMnFl/d5WFFjoG8AsZ8GwdKZdUvpCuJqb8nNP+dcrLNKkf
         JRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690943387; x=1691548187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOJuZZFFX2LE/w7s6LGZvLuvbn7OkI/88EWjdCuwZJg=;
        b=XSzis8BThhQvo0trw41vLtR7ZyzMS9qz8XnaChQDs3almdu1yXC+nYS06Tp0yxC7A4
         2OfpNpDkyBm9mpyC35GmZk/TWBfCrl9eN73nQ/MQcXBneMeGQH8g5sVB4ahQFu9bgJf3
         XJpQOsqWZeuVhmmcJuMFajMZjBhRVK9Kd1FUqUquQeUWw/4b8qKiApmfMOAblyYjuZ60
         rTKpecSJv6XTAIFWmAyi7Gh3wokBlwUGceQqjTnwYjHzLqOMKR6TPcuGXPrvb/77Tbx0
         BBrxK7PWtGx4aJvQ4dOICO3S9W9h3/gZX8LrWsVmJNJ5jw9uv5xaUnVPn3VfRIwNDte3
         6RWg==
X-Gm-Message-State: ABy/qLYcWCFwhuQTFXWPCkT8Fy7Q49c/tUZliAsOlRhBg+T3tUyGfkII
	ZwBL6pLd4QL7y9GYaq5n3uFP13Wo0aeAcnUIb/M=
X-Google-Smtp-Source: APBJJlE7h0loH5xufMUfLk3jZdlR6YCOHu2533xHWPKaNUwPiDdEPDeT/ewW8lwqthCgxdJ1ZKZ2RHldXwIkYHb6fms=
X-Received: by 2002:a2e:3e07:0:b0:2b8:3ac9:e201 with SMTP id
 l7-20020a2e3e07000000b002b83ac9e201mr3697535lja.40.1690943386859; Tue, 01 Aug
 2023 19:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com>
 <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
 <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
 <CAADnVQJDO9MgU2MQQ5NQAE3EwL6PuPp8aAxcV3apf0DHoq8TAw@mail.gmail.com>
 <CADx9qWjOP4-2K3uKBTRmS4Q5V0gTJtoH65fwN-MhZvn6ukFpBg@mail.gmail.com>
 <CAADnVQKbpoeMWdnXzYbBaHoDiNsLDbC0JvDUnVGEQbCigjd1Xg@mail.gmail.com>
 <CADx9qWj4xuYoyz83FphVWU0ZVxy_7Y+SvTWjvChvkMdV290giA@mail.gmail.com>
 <CAADnVQLWKnGbG6XTVEKSto0kEiqHwFaDTp+UkCYipKpov_btRA@mail.gmail.com> <PH7PR21MB38789504BF4250E37467C484A30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB38789504BF4250E37467C484A30BA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:29:35 -0700
Message-ID: <CAADnVQLt7S9uwMxB3JaLMYACs5xTVwZ+en9pLYUguZ3gOf=33g@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Dave Thaler <dthaler@microsoft.com>
Cc: Will Hawkins <hawkinsw@obs.cr>, Watson Ladd <watsonbladd@gmail.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 6:55=E2=80=AFPM Dave Thaler <dthaler@microsoft.com> =
wrote:
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Friday, July 28, 2023 9:52 PM
> > To: Will Hawkins <hawkinsw@obs.cr>
> > Cc: Watson Ladd <watsonbladd@gmail.com>; Dave Thaler
> > <dthaler@microsoft.com>; bpf@ietf.org; bpf <bpf@vger.kernel.org>
> > Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
> >
> > On Fri, Jul 28, 2023 at 8:14=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> =
wrote:
> > >
> > > The Appendix (the opcode table) is not in the kernel repo now and
> > > still has the issues that I outlined above.
>
> Suggestions (especially concrete changes) welcome :)
>
> > Will that make it in to
> > > the kernel?
> [...]
> > I thought it's auto generated, so it should be easy to update.
>
> It's not yet auto generated, and some parts are hard to auto-generated
> because the combinations are just in English text.
>
> > If not, let's certainly bring it in.
>
> At the IETF BPF WG meeting, folks seemed agnostic as to whether it
> was brought into the Linux repo or not.  See recording at
> https://www.youtube.com/watch?v=3DjTtPbJqfYwI at 1:15:30 - 1:17:30,
> and Christoph was the only one who spoke up, preferring to just keep
> a static copy of the Internet Draft in the kernel repository.  I interpre=
ted
> this as saying no one cared about having the IANA considerations section
> in a separate file there.  But we confirm consensus on the list, so it's =
fine
> to revisit now if there are good reasons to do so.

I think IANA consideration section is orthogonal to giant opcode table.
They're related, but don't have to be together in one .rst file.
I think it's cleaner to have separate instruction-set-opcode.rst

We also went back and forth during the meeting whether hierarchy
of tables is prefered or one table. Currently you have one table and
it actually looks very readable. My preference would be to keep it this
way and carry over to IANA eventually as one table.

