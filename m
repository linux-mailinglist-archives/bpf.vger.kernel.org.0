Return-Path: <bpf+bounces-17257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4911280AF55
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC5C1C20CFB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5A59166;
	Fri,  8 Dec 2023 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3nACcHS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B21706
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 14:05:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d0bcc0c313so19220085ad.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702073129; x=1702677929; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBbEuDp17Yf3L9v69OQAAPx054ZNum7Kq28fQ9trMvk=;
        b=L3nACcHShn5MxQoF+N0mR4ckr2fJwh+B77l5w7lsu0Y/KmEFs7T0SnKfQKKbm2kjtD
         vmrSQvm99v+yU/HgyCLUIzX09hhdiz0T6Qm6ly6Wr9FW3TEgY0bb+36daevh7TmjPX5A
         LfypLXJygR5JfLcEfexd0mhdh3+zjZRhh8TLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073129; x=1702677929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBbEuDp17Yf3L9v69OQAAPx054ZNum7Kq28fQ9trMvk=;
        b=vcX0SVcQkKpYLHjIG47HiMn1hYAgCM+Gs6EKC0p38/xTBVRh2Og9MLdfvrP4BeghsB
         Nmb+8KDrAPWoK196xhI5dPqgCU0daHp9F3sKcsg+tNXg1J3KCla7h+er3eCJ9FYjUhbd
         /A/lPnMeK3fCQPYm45T4gKtjsxGAnmoGnlqMIertYabaI0wbRSzXc6hHEFle9OKxLYhw
         gZ7ivEIbvDbfNQhpZv1G1Wyg7R3wS8NSSOYSJaEvhNBMeBW/C/ZqsKu/CtnOEgapztiM
         VViyYSVm/CgJAHLqIRY6fJUsy0+KOlaiO0P6EWeCZ/5dpTlpiOnL/8GXo7g6iT8JexSF
         ZAug==
X-Gm-Message-State: AOJu0YxY2KeZLDo0rQpoYqQoxUcjpsot2016IMvK9FSRmPyaAK5znqTC
	meZj/Q3k9BBMn3N44iyMRqD8OFAdT59hvU9bA9s=
X-Google-Smtp-Source: AGHT+IGkU1tkzsjV/sPLNnpjVy0ezGVsxHOZtbwV95w80C47f7Mcox6QYf93b95Q/qTqV22R5ARF0g==
X-Received: by 2002:a17:902:d902:b0:1d1:e0b6:1aac with SMTP id c2-20020a170902d90200b001d1e0b61aacmr604898plz.19.1702073128832;
        Fri, 08 Dec 2023 14:05:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001cfca7b8ee7sm2196488plp.99.2023.12.08.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:05:28 -0800 (PST)
Date: Fri, 8 Dec 2023 14:05:27 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202312081352.6587C77@keescook>
References: <20231110222038.1450156-1-kpsingh@kernel.org>
 <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook>
 <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
 <202312081019.C174F3DDE5@keescook>
 <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>
 <202312081302.323CBB189@keescook>
 <CAHC9VhQ2VxM=WWL_jpoELu=dHuiF3Pk=bxNrpfctc7Q0K2DUfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ2VxM=WWL_jpoELu=dHuiF3Pk=bxNrpfctc7Q0K2DUfA@mail.gmail.com>

On Fri, Dec 08, 2023 at 04:43:57PM -0500, Paul Moore wrote:
> On Fri, Dec 8, 2023 at 4:13 PM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> > > Hopefully by repeating the important bits of the conversation you now
> > > understand that there is nothing you can do at this moment to speed my
> > > review of this patchset, but there are things you, and KP, can do in
> > > the future if additional respins are needed.  However, if you are
> > > still confused, it may be best to go do something else for a bit and
> > > then revisit this email because there is nothing more that I can say
> > > on this topic at this point in time.
> >
> > I moved to the list because off-list discussions (that I got involuntarily
> > CCed into and never replied to at all) tend to be unhelpful as no one else
> > can share in any context they may provide. And I'm not trying to rush
> > you; I'm trying to make review easier.
> 
> From my perspective whatever good intentions you had at the start were
> completely lost when you asked "What's the right direction forward?"
> after I had already explained things multiple times *today*.  That's
> the sort of thing that drives really bothers me.

Okay, I understand now. Sorry for frustrating you! By "way forward",
I meant I didn't understand how to address what looked like conflicting
feedback. I think my confusion was over separating the goal ("this
feature should be automatically enabled when it is known to be useful")
from an interpretation of earlier feedback as "I don't want a CONFIG [that
leaves this up to the user]", when what you really wanted understood was
"I don't want a CONFIG *ever*, regardless of whether it picks the correct
setting automatically".

> 
> > While looking at the v8 again I
> > saw an obvious problem with it, so I commented on it so that it's clear
> > to you that it'll need work when you do get around to the review.
> 
> That's fair.  The Kconfig patch shouldn't have even been part of the
> v8 patchset as far as I'm concerned, both because I explained I didn't
> want to merge something like that (and was ignored) and because it
> doesn't appear to do anything.  From where I sit this was, and
> remains, equally parts comical and frustrating.

Agreed. :) Anyway, when you do review it, I think you can just ignore
patch 5, and if a v9 isn't needed, a brand new patch for that logic can
be created later.

-- 
Kees Cook

