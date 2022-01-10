Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38948A281
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 23:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiAJWNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 17:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbiAJWNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 17:13:10 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA628C06173F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:13:10 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso16581896otf.12
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQn3m3RVdskh1I2ejTr5iTDRKenU/xGmVID+nKXoVF8=;
        b=AsdpoRnJJ1CZ0PyF+bGL2Q2BE5W4GCuZ37egNIqBd9FsRWTj339kk3vvnXl+2EGREB
         TjDzwE4v9kr8NfZuGXdiT3w/2iNOMo+8W2PP+d4F/ZvO13gH0dEgDQ3uyTjJbcF8PQfa
         u9PUygHoc5VdOK4k35n5E8vSbRPP2eZIYlUuFiVA1HqQQtfmJ/3MX9fhkE0hCRWSYVpK
         bcbosDffTOKmUoD7ta+Xz2ad1TrHNAF9vYy9qonVxrAlBXxd+i9VyBv6ydE0Z4F0c6wv
         Ca3/M6VZyxJA67Q161RRyosORwGtyp3n3ZLGkZDY6+nMAn2So3zqxYuu59b1EhgNqyIN
         volQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQn3m3RVdskh1I2ejTr5iTDRKenU/xGmVID+nKXoVF8=;
        b=cQE82fk1So6oOG+VZCcnX5W0ZPxrvwNDcKdZtYmZnYgG43o2fX44NGThlT4xV+0nT+
         yErqSZoSjGFZTWfuNo0MLEEDIz0lF7Qq0/XLOAbHUtsaX9DWFROBOlMcFxB8aDCs6DtZ
         T1DLnryp5KsnXjgf3hFSKsAR+///KyS6hSwaO1RKGVGTAfN9l5CUuDy2OBTXSC8vZue5
         W4nor3tSCUR2i2lPWXgZ5xJwkpTNNq7DPx0aHk9En39eio6wjjwZ/mtq0RMoVldn15Vu
         nDteK4/ZWR200DtjsieN16VP3FA34fkkR2qvVPr/zQU19F6UC+/9GS74XSCFrSxAGdbF
         VUwA==
X-Gm-Message-State: AOAM532wQnurYMCzM3gG2bi38PvYj4DgHYYFkBrXampk1uFdQHG6pwmP
        ltvaVPoPGusb/KgrIcaGTHKUFdzGvf66d0zK+88=
X-Google-Smtp-Source: ABdhPJxhg8AFiAWbO2SIimhZ3qp/8PEiKubKqry0oWBJJUF+8L4zWen+9WIyk4k2RCINejq/sAsB5+tdp5vqGHaRURA=
X-Received: by 2002:a9d:8c2:: with SMTP id 60mr1384719otf.174.1641852790028;
 Mon, 10 Jan 2022 14:13:10 -0800 (PST)
MIME-Version: 1.0
References: <202201060848.nagWejwv-lkp@intel.com> <20220108005854.658596-1-christylee@fb.com>
 <CAPhsuW5FQTLfs4P4GqMKxsakP82KuPGOrEcqX+zvAH1+VLf7aQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5FQTLfs4P4GqMKxsakP82KuPGOrEcqX+zvAH1+VLf7aQ@mail.gmail.com>
From:   Christy Lee <christyc.y.lee@gmail.com>
Date:   Mon, 10 Jan 2022 14:12:58 -0800
Message-ID: <CAPqJDZqf8-4DCe9J1jr7KekxqfBac3JBc+hx7a6qW4hoF6xPUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix incorrect integer literal used for marking
 scratched registers in verifier logs
To:     Song Liu <song@kernel.org>
Cc:     Christy Lee <christylee@fb.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        kbuild@lists.01.org, Linux-MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 10, 2022 at 1:52 PM Song Liu <song@kernel.org> wrote:
>
> On Fri, Jan 7, 2022 at 4:59 PM Christy Lee <christylee@fb.com> wrote:
> >
> > env->scratched_stack_slots is a 64-bit value, we should use ULL
> > instead of UL literal values.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Christy Lee <christylee@fb.com>
>
> The fix looks good to me. Thus:
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> However, the patch looks corrupted. Also, the subject is probably too
> long (./scripts/checkpatch.pl should complain about it).
>

I just checked that even with an absurdly long subject (more than 200
characters), ./scripts/checkpatch.pl doesn't complain. It only complains
when the commit message body has longer than 75 characters but not the
subject line.  What's the maximum subject line length?

Christy

> Thanks,
> Song
>
>
> > ---
> >  kernel/bpf/verifier.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bfb45381fb3f..a8587210907d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -616,7 +616,7 @@ static void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
> >
> >  static void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 spi)
> >  {
> > -       env->scratched_stack_slots |= 1UL << spi;
> > +       env->scratched_stack_slots |= 1ULL << spi;
> >  }
> >
> >  static bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
> > @@ -637,14 +637,14 @@ static bool verifier_state_scratched(const struct bpf_verifier_env *env)
> >  static void mark_verifier_state_clean(struct bpf_verifier_env *env)
> >  {
> >         env->scratched_regs = 0U;
> > -       env->scratched_stack_slots = 0UL;
> > +       env->scratched_stack_slots = 0ULL;
> >  }
> >
> >  /* Used for printing the entire verifier state. */
> >  static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
> >  {
> >         env->scratched_regs = ~0U;
> > -       env->scratched_stack_slots = ~0UL;
> > +       env->scratched_stack_slots = ~0ULL;
> >  }
> >
> >  /* The reg state of a pointer or a bounded scalar was saved when
> > --
> > 2.30.2
> >
