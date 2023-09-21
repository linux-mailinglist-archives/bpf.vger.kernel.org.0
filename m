Return-Path: <bpf+bounces-10517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31B7A92B9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12491F20F90
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538FC8F60;
	Thu, 21 Sep 2023 08:41:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A888C02
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 08:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB1DC116D6
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695285673;
	bh=a4OHcVRsuqs5JAwYzdfcb08VdDGHQg0/PDye6pIl1Y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vAl1W6F0+S/h8oDMzHO4TuB/O/roAHhKvmUPb1FeaJ3U/q3GKqGYYwNMIyXwY/Yb7
	 K8gvZgtiDIBycfbDVwuOh7gZh7J7uhIRv2Vi+pMPvuFkPxjK+wtdA94bP/ntZhNrJD
	 MIZL0NheoCYNP/n4GWDnbgWoXskMnBmAVupISuz72LQYkBHbPJ+Pl9/wlNl7ckTA/W
	 WaBzjinZyuq49f1eWe5K5OIZDMFnSNtVZDvN1hmmOFFt4Zm07450xTQvawq5xa877e
	 xkkoHkEGC7+Lb9OSe1WKRNZ+g+NpMJvtEZ1T7tCj9cCyZlJKN7XIbz6A6wmoNFL8i0
	 gip+KiRGGN+ZQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5310a63cf7bso747228a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:41:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzgb2PH/5gQsGXkRHHRA3vVI1JErEBwgkmbviODc3i2l4qcLpSb
	XXYGr7TblDG+jcMcCYg4lztuyYZxHrUdEJEokc8FuQ==
X-Google-Smtp-Source: AGHT+IEMXvQsZnP2AhwT2TWQsWtzpaWhnz3kPpJocPHcmk5qumTgumlnpU9+LGQhQQ7mVMXYtPsNxcrKfsyCC231bPE=
X-Received: by 2002:aa7:c54c:0:b0:523:47b0:9077 with SMTP id
 s12-20020aa7c54c000000b0052347b09077mr4358739edr.38.1695285671679; Thu, 21
 Sep 2023 01:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <98b02c73-295d-baad-5c77-0c8b74826ca9@schaufler-ca.com> <202309201221.205BA18@keescook>
In-Reply-To: <202309201221.205BA18@keescook>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 21 Sep 2023 10:41:00 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6HyrK0bicq0YfeHoeBAeK4-3UZtE2XqPgC9bqmi5ui4w@mail.gmail.com>
Message-ID: <CACYkzJ6HyrK0bicq0YfeHoeBAeK4-3UZtE2XqPgC9bqmi5ui4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, paul@paul-moore.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 9:24=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On 9/18/2023 2:24 PM, KP Singh wrote:
> > [...]
> > +#define __COUNT_COMMAS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _1=
1, _12, _n, X...) _n
> > +#define COUNT_COMMAS(a, X...) __COUNT_COMMAS(, ##X, 12, 11, 10, 9, 8, =
7, 6, 5, 4, 3, 2, 1, 0)
> > +#define ___COUNT_COMMAS(args...) COUNT_COMMAS(args)
>
> Oh! Oops, I missed that this _DOES_ already exist in Linux:
>
> cf14f27f82af ("macro: introduce COUNT_ARGS() macro")
>
> now in include/linux/args.h as COUNT_ARGS():
>
> #define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _1=
2, _n, X...) _n
> #define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4=
, 3, 2, 1, 0)
>
> I think this can be refactored to use that?

Thanks, yeah I was able to do this with:

diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
index 0c0ff3c7dddc..969b6bf60718 100644
--- a/include/linux/lsm_count.h
+++ b/include/linux/lsm_count.h
@@ -7,7 +7,7 @@
 #ifndef __LINUX_LSM_COUNT_H
 #define __LINUX_LSM_COUNT_H

-#include <linux/kconfig.h>
+#include <linux/args.h>

 #ifdef CONFIG_SECURITY

@@ -79,13 +79,15 @@
 #endif


-#define __COUNT_COMMAS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10,
_11, _12, _n, X...) >
-#define COUNT_COMMAS(a, X...) __COUNT_COMMAS(, ##X, 12, 11, 10, 9, 8,
7, 6, 5, 4, 3, 2, >
-#define ___COUNT_COMMAS(args...) COUNT_COMMAS(args)
-
+/*
+ *  There is a trailing comma that we need to be accounted for. This is do=
ne by
+ *  using a skipped argument in __COUNT_LSMS
+ */
+#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
+#define COUNT_LSMS(args...) __COUNT_LSMS(args)

 #define MAX_LSM_COUNT                  \
-       ___COUNT_COMMAS(                \
+       COUNT_LSMS(                     \
                CAPABILITIES_ENABLED    \
                SELINUX_ENABLED         \
                SMACK_ENABLED           \



>
> -Kees
>
> --
> Kees Cook
>

