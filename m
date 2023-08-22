Return-Path: <bpf+bounces-8309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7BD784C2F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511FD28112C
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD634CE0;
	Tue, 22 Aug 2023 21:42:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF12018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:42:26 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D3F3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:42:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-790cadee81bso156822839f.0
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692740543; x=1693345343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Ow6pCM+QP20h9g5N2QdjyOQ38DqfmJbWYeM8K1qy+4=;
        b=i20RSApAOKJ8ir/jJsfJdPMau9sFLKKFzH6B+BHHpOzr48x9Zyv+B6H0aUTWLLFJn0
         TQtaVX0uIct/8a1ZutlOlFnoEpaaK64QVZl3G+2gFh3n+5V6C3O+1rmk9dCprwmkZ0Lm
         9SCcXovO4dPpCvNpEh+Kzh9kxr9GAtWoK8gjmIK0mVdNv63/2XNH0+qqezIC8GVfrbdw
         HD/oK2+U/wtoZYACKCJQfjQ0yba40qV0dUGopakg+QC2VpErWjmHWIilptZDH7h/jqzI
         Hg+BY/D0UekKBcXqLmnnfO10+/0SJ34wzRZwUBXnzinSseqm1iOoSdsgpBRw/cazEEtu
         QOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740543; x=1693345343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ow6pCM+QP20h9g5N2QdjyOQ38DqfmJbWYeM8K1qy+4=;
        b=LJnXID8my+Orzl3UUTKK2tkplXrhjTxbLfYQPh8KOQuibUL4kt+IagdwF4XT1WmDH/
         XAQRlTVJDjfd05j36CycLszIXubtMImSQVzY0touKRmWPqqHJ7H/T49N7txj1kENlKdh
         2gB2MyoDh6Qjj1wiPFk7xKqkcc28A/QXuq8BjKcMVcV+0MmQsyY+nzzmtKc7+YTRJoOx
         sMZDQDztz/ueZJXLc2FezTj4At/px08jh54j6SYnCRiwj+LrU2cXgMxtvKNoCixShyrK
         RHH8LFGo/RZHhSf9YEyV1vn3vpeOjdBYd4Pjo0vLCRKZT1+IDgA1prSikCao7NCcXi1w
         isqQ==
X-Gm-Message-State: AOJu0Yy4CyxmF/kzOLYmO5b6KJUyIILVP11si56a0VKshJBphQWvfYhw
	HVNyYrQJs/LuWQ2l+E6aMZVkSB4GSkeFaelskMgg0A==
X-Google-Smtp-Source: AGHT+IEcpbrFTOH03Us9iPSIjiXeODFg/lzJ/XzgUDSbSKxU/6ulWFVq80iXoxB8Lz7Yq2tK3/gcOg==
X-Received: by 2002:a5e:c102:0:b0:788:2eaf:46ce with SMTP id v2-20020a5ec102000000b007882eaf46cemr1048760iol.9.1692740543076;
        Tue, 22 Aug 2023 14:42:23 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id 3-20020a5ea503000000b0078714764ca0sm2930223iog.40.2023.08.22.14.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:42:22 -0700 (PDT)
Date: Tue, 22 Aug 2023 21:42:20 +0000
From: Justin Stitt <justinstitt@google.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@google.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
Message-ID: <20230822214220.jjx3srik4mteeond@google.com>
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
 <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
 <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
 <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
 <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 02:38:29PM -0700, Justin Stitt wrote:
> On Tue, Aug 22, 2023 at 2:36 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 11:26 PM Justin Stitt <justinstitt@google.com> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 2:15 PM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 11:06 PM Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> wrote:
> > > > >
> > > > > On Tue, Aug 22, 2023 at 10:57 PM Justin Stitt <justinstitt@google.com> wrote:
> > > > > >
> > > > > [...]
> > > > > > > > > Here's the invocation I am running to build kselftest:
> > > > > > > > > `$ make LLVM=1 ARCH=x86_64 mrproper headers && make LLVM=1 ARCH=x86_64
> > > > > > > > > -j128 V=1 -C tools/testing/selftests`
> > > > > > >
> > > > > > > I think I fixed the same issue in the script I am running to launch
> > > > > > > those tests in a VM. This was in commit
> > > > > > > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
> > > > > > >
> > > > > > > And in the commit log, I wrote:
> > > > > > > ```
> > > > > > > According to commit 01d6c48a828b ("Documentation: kselftest:
> > > > > > > "make headers" is a prerequisite"), running the kselftests requires
> > > > > > > to run "make headers" first.
> > > > > > > ```
> > > > > > >
> > > > > > > So my assumption is that you also need to run "make headers" with the
> > > > > > > proper flags before compiling the selftests themselves (I might be
> > > > > > > wrong but that's how I read the commit).
> > > > > >
> > > > > > In my original email I pasted the invocation I used which includes the
> > > > > > headers target. What are the "proper flags" in this case?
> > > > > >
> > > > >
> > > > > "make LLVM=1 ARCH=x86_64 headers" no?
> > > > >
> > > > > But now I'm starting to wonder if that was not the intent of your
> > > > > combined "make mrproper headers". I honestly never tried to combine
> > > > > the 2. It's worth a try to split them I would say.
> > > >
> > > > Apologies, I just tested it, and it works (combining the 2).
> > > >
> > > > Which kernel are you trying to test?
> > > > I tested your 2 commands on v6.5-rc7 and it just works.
> > >
> > > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
> > >
> > > I ran these exact commands:
> > > |    $ make mrproper
> > > |    $ make LLVM=1 ARCH=x86_64 headers
> > > |    $ make LLVM=1 ARCH=x86_64 -j128 -C tools/testing/selftests
> > > TARGETS=hid &> out
> > >
> > > and here's the contents of `out` (still warnings/errors):
> > > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59c6d
> > >
> > > I have a feeling I'm doing something fundamentally incorrectly. Any ideas?
> >
> > Sigh... there is a high chance my Makefile is not correct and uses the
> > installed headers (I was running the exact same commands, but on a
> > v6.4-rc7+ kernel).
> >
> > But sorry, it will have to wait for tomorrow if you want me to have a
> > look at it. It's 11:35 PM here, and I need to go to bed
> Take it easy. Thanks for the prompt responses here! I'd like to get
> the entire kselftest make target building with Clang so that we can
> close [1].
>
> >
> > Cheers,
> > Benjamin
> >
> > >
> > > To be clear, I can build the Kernel itself just fine across many
> > > configs and architectures. I have, at the very least, the dependencies
> > > required to accomplish that.
> > >
> > > >
> > > > FTR:
> > > > $> git checkout v6.5-rc7
> > > > $> make LLVM=1 ARCH=x86_64 mrproper headers
> > > > $> make LLVM=1 ARCH=x86_64 -j8 -C tools/testing/selftests TARGETS=hid
> > > >
> > > > ->   BINARY   hid_bpf
> > > >
> > > > Cheers,
> > > > Benjamin
> > > >
> > >
> >
>
> [1]: https://github.com/ClangBuiltLinux/linux/issues/1910

Erhm, I meant [1]: https://github.com/ClangBuiltLinux/linux/issues/1698

