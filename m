Return-Path: <bpf+bounces-12040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D97C7322
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5871C20B36
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BA20B31;
	Thu, 12 Oct 2023 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0JYyCWn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D1D50F
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 16:35:55 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C0C0
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:35:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so2038061a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128550; x=1697733350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyGpDm5vlyXBFseOodEkKS8gXDa7m6ka+79suN2vloQ=;
        b=O0JYyCWnmSNaSzF7bwwzDZyCnP9uo5kZUlzV2igg9uy54V/ORxtyNUX9QVzlqM8ggt
         8lm6vxEPm84qutxV8arIHh6fjlAEfGFQk+bGL4VCgL7RgfSE7+3Wk/zAfis+zSgxAJ+A
         7ay3cMWGpxBWTXuqGxVKbBBsbhHp0xZbdtUE53dxpa8sIH7pfDzcNnNApFklSoLm+fFQ
         ulCla+GFJSYT4PpZEevHrZIxef96hzPCW6Ltj1bkVtXsmCwZxuiphvIFrcO8QFirg2Rh
         AdrU/M0btKV/FMvxLU/II60WmytZHX9loEPEXsXjE222FoBi6dMUgreQVQLu/ZDJqVm0
         ALlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128550; x=1697733350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyGpDm5vlyXBFseOodEkKS8gXDa7m6ka+79suN2vloQ=;
        b=sU1IJEqGV+ZRVPOJ2R4dOj4IcfG2MM3cc0Kt7w650VjHnpzWaD+b81Nx0eVepTMS4q
         n7zNM8dYtOZ0C2oPYDD17S49F9moiAiByDPBUo3PGYQqY8M9G7E6PUMeqUPu4mqHhGkJ
         cXrHpb7b4tWcyINMDFLsD2DqocCueqqo8HhhWevVTupxDio8m7WqWRMpJJiaO7vsqfDT
         Xm758RzUJ25QS3TRCrDYv9ucE8WH6uYfQ1Gj1cwFzUMrc3eB3LQ7CB2vKEi59BN9N43J
         0RGZQcxk2fRUiCMMMLuTBoX7AYazZrWy+8RYc1/Do7lZxVqr9wugzXCAFbcHefut7And
         f6dg==
X-Gm-Message-State: AOJu0YxKl5vXXlhz5mgk5qAbal+1goKQiT3BA+xL0OuPwKqSj/h3KrYm
	4yeMWCIKg2n9/AVep7sJXlBsrpIQN9+vuRNg1/L57tvIat8=
X-Google-Smtp-Source: AGHT+IElnn+4nF+qJGQsn1Rug/p+/Kias4z28x/0WVGWocNtrLs9yxY3KnAAkPUJgtYXn8H5jzN8b+I6LwNr6pjn8Rg=
X-Received: by 2002:aa7:da84:0:b0:536:2b33:83ed with SMTP id
 q4-20020aa7da84000000b005362b3383edmr25041726eds.24.1697128550383; Thu, 12
 Oct 2023 09:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
In-Reply-To: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 09:35:39 -0700
Message-ID: <CAEf4BzZuOKCcbvJ9T6pY_S7viwfsRwngDjti=LiEugY=iLr8KQ@mail.gmail.com>
Subject: Re: Is tools/testing/selftests/bpf/ maintained?
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 6:40=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello.
>
> I'm having problem with finding BPF LSM examples that work.
> I tried building tools/testing/selftests/bpf/progs/lsm.c and
> tools/testing/selftests/bpf/prog_tests/test_lsm.c explained at
> https://docs.kernel.org/bpf/prog_lsm.html , but got a lot of errors.

Make sure you a) have necessary kernel configs set up (see [0], there
are also arch-specific configs) and b) build kernel before building
selftests, because selftests generate vmlinux.h header with all kernel
types based on latest built kernel image.

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree=
/tools/testing/selftests/bpf/config

>
> ----------------------------------------
> root@ubuntu:/usr/src# git clone https://kernel.googlesource.com/pub/scm/l=
inux/kernel/git/torvalds/linux.git
> Cloning into 'linux'...
> remote: Total 9723739 (delta 8227084), reused 9723739 (delta 8227084)
> Receiving objects: 100% (9723739/9723739), 1.81 GiB | 4.04 MiB/s, done.
> Resolving deltas: 100% (8227084/8227084), done.
> Checking objects: 100% (33554432/33554432), done.
> Updating files: 100% (81759/81759), done.
> root@ubuntu:/usr/src# cd linux
> root@ubuntu:/usr/src/linux# git describe
> v6.6-rc5-72-g401644852d0b
> root@ubuntu:/usr/src/linux# make -s headers
> root@ubuntu:/usr/src/linux# make -sC tools/testing/selftests/bpf/
>   MKDIR    libbpf
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs=
 from latest version at 'include/uapi/linux/if_xdp.h'
>   TEST-HDR [test_progs] tests.h
>   EXT-OBJ  [test_progs] testing_helpers.o
>   EXT-OBJ  [test_progs] cap_helpers.o
>   EXT-OBJ  [test_progs] unpriv_helpers.o
>   BINARY   test_verifier
>   BINARY   test_tag
>   MKDIR    bpftool
>
>   GEN      vmlinux.h
>   CLNG-BPF [test_maps] async_stack_depth.bpf.o
> progs/async_stack_depth.c:8:19: error: field has incomplete type 'struct =
bpf_timer'
>         struct bpf_timer timer;
>                          ^
> /usr/src/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_d=
efs.h:41:8: note: forward declaration of 'struct bpf_timer'
> struct bpf_timer;
>        ^
> 1 error generated.
> make: *** [Makefile:598: /usr/src/linux/tools/testing/selftests/bpf/async=
_stack_depth.bpf.o] Error 1
> ----------------------------------------
>
> To fix these errors, something like the following
> (this seems to be a fraction) is needed. What am I missing?
>

kernel image used for vmlinux.h generation is probably too old

[...]

