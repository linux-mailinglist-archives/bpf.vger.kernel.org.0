Return-Path: <bpf+bounces-17221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CE80ABFB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 19:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AB51C20C5D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACFF47A5F;
	Fri,  8 Dec 2023 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ex1Ejfzf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDF098
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 10:22:28 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so2037745a12.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702059747; x=1702664547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Lio9Bj0x9JAPVWlQ8AlhFwwv9foF19FhvucZ1xVTCE=;
        b=Ex1EjfzfAtNHS8ksh+LKeZ/e//5ODiY5U9bpkVJ/aDqUHjyZfymw9h+pSzUbUSSiTh
         QIcitrHZBOPGKoyOaW7j9lFWuvu/sl9WseeSlbbVMSE88D7E7ZMDbm1pxDfY6WNiGwDQ
         u7U8HfKVAebs2M4jqoxlK1sfbLXy195YZr+sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059747; x=1702664547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Lio9Bj0x9JAPVWlQ8AlhFwwv9foF19FhvucZ1xVTCE=;
        b=lWg9PZrmae7H6dAUPKB/GtRtSW5crkfiTckw36vZfRIXzWT/vQSai1PDn2mJAxJbBe
         SGpZj3ak2+bMDO9mKUwaBofefPlaHqcNwbpbfwBDv1nff61Ja+8UkAr2Xdp0gcVjaEEq
         yeHlC/Lf5zZTZg7AqON5Jg2FlzIgUGCbuNXoYPtcfzM3sod0V3FuC8sz/i9uSRuPaoqP
         y4N2kRGpFcBzfzrme/zEKfeuniudNR2Qo9YOKn3keI+PerlxglhmQXHgNC83y/o3GLu4
         BERktXX9p14RQWOgRflnX72a4e9DS6a+4oyLAqq53lZtk9Cw/zE9bpGJY16RmMF83HGZ
         VVVQ==
X-Gm-Message-State: AOJu0YxhgX6OSEntG++gVca3AJVT4+W0JF32BetFmTCPk31+edDtZY3f
	BkE3fnRPu33Lj/tQWQLYSUGy1w==
X-Google-Smtp-Source: AGHT+IGRbsi832PLvYs74HogggybSrCcOzAF4I24zHFFKpw7dlgg4L9MJYDu5SM3pgtoXwkISlXxJQ==
X-Received: by 2002:a17:90a:4305:b0:285:b7b9:dcd5 with SMTP id q5-20020a17090a430500b00285b7b9dcd5mr568610pjg.36.1702059747732;
        Fri, 08 Dec 2023 10:22:27 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090aec8500b00286f5f0dcb8sm2168558pjy.10.2023.12.08.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:22:27 -0800 (PST)
Date: Fri, 8 Dec 2023 10:22:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202312081019.C174F3DDE5@keescook>
References: <20231110222038.1450156-1-kpsingh@kernel.org>
 <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook>
 <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>

On Fri, Dec 08, 2023 at 12:55:16PM -0500, Paul Moore wrote:
> On Fri, Dec 8, 2023 at 12:46 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Dec 8, 2023 at 12:36 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> > > > [...]
> > > > ---
> > > >  security/Kconfig | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > >
> > > Did something go missing from this patch? I don't see anything depending
> > > on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, though?)
> 
> I guess while I'm at it, and for the sake of the mailing list, it is
> worth mentioning that I voiced my dislike of the
> CONFIG_SECURITY_HOOK_LIKELY Kconfig option earlier this year yet it
> continues to appear in the patchset.  It's hard to give something
> priority when I do provide some feedback and it is apparently ignored.

The CONFIG was created specifically to address earlier concerns about
not being able to choose whether to use this performance improvement. :P
What's the right direction forward?

-- 
Kees Cook

