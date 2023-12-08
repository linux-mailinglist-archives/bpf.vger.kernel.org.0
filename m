Return-Path: <bpf+bounces-17251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF1180AE9F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F65AB20B7B
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830457881;
	Fri,  8 Dec 2023 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bDeI84bt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5ABA
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 13:13:34 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d5b30eb85so8246425ab.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702070013; x=1702674813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpntkCfQwDaAgbaJaTI4iT/n+8OOJsz8SUdIGxRKoCo=;
        b=bDeI84btSsYxUVrOO3AVmLizwS9V+guO5WR8MwuD0DBZUOW3CtNpDxr9nTQayz7gkd
         Err2Ackqn5HhsmeVIVBx2SS+fWf/amoCpanTep0g8u6yhPEWrMsU7ZxZn0P2da38Jduu
         QhdB66CIfZMkvsNvdNI8ZbVzHqa6vle7/tekI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702070013; x=1702674813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpntkCfQwDaAgbaJaTI4iT/n+8OOJsz8SUdIGxRKoCo=;
        b=BoFs7K9JHMFJPzotMXn2oAvI1QIwH/AYc+iB5TSgOYE/fCiqzyJUI/Egsta1IK1qcV
         /iPBnMKY4Gf5oFPVNVE6/xjCG1COsNZ+yqihbFPIlwz6McZjpoMnyZzaKBxeYJDtfHJ4
         IpC0mvJ2zLeZ4jgD7FtmaDELcxr6xQ0gr5wQi5qSb/SXNXysRX5S4SUIsSTpxet174bL
         7ycKab9jOr/6aVDtpof6OxKKWRc51Zr5UTzbQvsH+RhQfO2ArOdYV/Qt5w4m+mOYngUZ
         hsb+ibODqL23PxOH/DEf3xHHSJadyEDRSZtJ/Qn89oSMo7vTqlKQZt7FGDutQqX1Vr2+
         u2mA==
X-Gm-Message-State: AOJu0Yy5dBs34IMDsbm0QQsNL/q5TY175cpnbrT19Cj3T4jxPzrpEEwS
	QgmKVCPvnp+YZ9t+pKdXmgAWZQ==
X-Google-Smtp-Source: AGHT+IG+5kvteZ8JpbXWSobQV/zCyZcte6WZM3+VssRgy6WXu8EFGkOQuad9kjeMkOkWqOGsejW8ig==
X-Received: by 2002:a92:ca07:0:b0:35d:59a2:a32f with SMTP id j7-20020a92ca07000000b0035d59a2a32fmr993717ils.49.1702070013688;
        Fri, 08 Dec 2023 13:13:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020a63d50b000000b005ab281d0777sm2013165pgg.20.2023.12.08.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:13:32 -0800 (PST)
Date: Fri, 8 Dec 2023 13:13:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202312081302.323CBB189@keescook>
References: <20231110222038.1450156-1-kpsingh@kernel.org>
 <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook>
 <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
 <202312081019.C174F3DDE5@keescook>
 <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>

On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> Hopefully by repeating the important bits of the conversation you now
> understand that there is nothing you can do at this moment to speed my
> review of this patchset, but there are things you, and KP, can do in
> the future if additional respins are needed.  However, if you are
> still confused, it may be best to go do something else for a bit and
> then revisit this email because there is nothing more that I can say
> on this topic at this point in time.

I moved to the list because off-list discussions (that I got involuntarily
CCed into and never replied to at all) tend to be unhelpful as no one else
can share in any context they may provide. And I'm not trying to rush
you; I'm trying to make review easier. While looking at the v8 again I
saw an obvious problem with it, so I commented on it so that it's clear
to you that it'll need work when you do get around to the review.

As far as the CONFIG topic, I think we're talking past each other (it IS
figuring out the correct value, but it looks like you don't want it even
to be a choice at all), but we can discuss that more when this series
bubbles up your list.

-- 
Kees Cook

