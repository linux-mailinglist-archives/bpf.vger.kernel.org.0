Return-Path: <bpf+bounces-34687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F960930148
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554DD1F23B08
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B900495E5;
	Fri, 12 Jul 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JIeZ24R1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350434776A
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815841; cv=none; b=bXju1INCaS5DaGYjmK6QZbVNH3vXNEDIt2GDpKLhJAKcAzbAFxeeU+Xle4SCRmD/FHmlaR9GZ7i81PY3wUFT/VZfAjtEFXXLy8SOqgheW2bUJHzi3fHaWTaaWQ/hVNik0kycJIE/UowV76zI8KeCg4rKXqnftRBvftBEQxlXjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815841; c=relaxed/simple;
	bh=UWpkjm+bNJpSBeffNgCexDtJjnqEBWkOkbBoIfzuPfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naAVnp4zyeYNVlE1+V9Tn5jAsQBnRcHDMdn5LeBBWcTMTvdl2uISJenIPRyOr5fTdjauY5wZfchR/NV278miqHkFzW1bnjNER8IdZbsAkyE+3qkGd8KCwy+MWcwguR4KYM02pEbZnpoysE6cZE1hf4le+9P9gZS/4cGxFH+8CEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JIeZ24R1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-706a1711ee5so1956432b3a.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720815839; x=1721420639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hf9lMH8FXC/GAp1YqBmmTVjDYJ9ZMKh92cvFp4a7iII=;
        b=JIeZ24R196Y28caDGwTyWDp2ZDgxzWT71yAP3qvMiGrN16ZBK+Pq01JX4DEWmpgzCT
         uIZxa8w97Tz/F8Q0Z8Gb2Y+/xp2plf8+Ax8vm1LH6Urkegz+Cey/QrUuwIQPwgY86e6T
         t50gZJV2a18qoMv3IYrmoonOeQAqPIgBmIsVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815839; x=1721420639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf9lMH8FXC/GAp1YqBmmTVjDYJ9ZMKh92cvFp4a7iII=;
        b=JUTIewNO0933HHRMXrTJMnrLBEdEFdssw4jYpyciUIE7i82y/ltE4QjpOFj/z2y0HF
         9+qaozqiAnUjEu7Y7TJI0J1qBxKnVujLjUdNOSrSEHe23dyZP9xbTRfnf72RD2P5vQXU
         6velvXtEoYgQ5NIzX2OhWNkhWQMXEMb68Aw1a09mGIbNcfzoDHKHXlaxDSsaO+r/jQYW
         +kQkxX4M6e+PNwU6lCp3RbiJv+T6ay7mVyiYzqROpt11PK9aIhNevlYt/+QdaGElTGwe
         9ANgvbUy284pYlbA8+oWmiezjnRq8I8LodkhbDFMigQJIVVI3PVHjCxeBqvEJCXZ7LOy
         SLHg==
X-Forwarded-Encrypted: i=1; AJvYcCXbMlFq8DFsJ0y6ZBxNvgTcks+LeVavm5cxAVEzZaQSAcKVsdIiwkXr67w7em06SWUlP8OW+4ITq2WxY49X0OJZka1t
X-Gm-Message-State: AOJu0Yw9npx35/pVNe2BwAZ3cqSBXOnrnqNrM5Vnviq/YbFS1iu9U6iR
	nqE14dl5bNd2c9FdNk3lVr4u+IYVzI8TSxQLmoz1YY9MLzMPNmRc2aEU4GYVlA==
X-Google-Smtp-Source: AGHT+IG2GTXZu2uRjdFrTSv44X2Ka4Gg2maPyT6oX8YP7inykgDj54rRDX10nXgMIvG0pX0ZIkLKtA==
X-Received: by 2002:a05:6a00:988:b0:704:31dd:a28a with SMTP id d2e1a72fcca58-70b435854damr15091453b3a.18.1720815839444;
        Fri, 12 Jul 2024 13:23:59 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:7546:30be:53d8:7f93])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70b438e538fsm7923889b3a.87.2024.07.12.13.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 13:23:58 -0700 (PDT)
Date: Fri, 12 Jul 2024 13:23:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 3/3] tools build: Correct bpf fixdep dependencies
Message-ID: <ZpGQ3TShk-IGb4b1@google.com>
References: <20240709204203.1481851-1-briannorris@chromium.org>
 <20240709204203.1481851-4-briannorris@chromium.org>
 <CAEf4Bzb6-DLL966XKyMhe+nmpvdqYVrzfmfkAiDdFHNyD0qGWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb6-DLL966XKyMhe+nmpvdqYVrzfmfkAiDdFHNyD0qGWw@mail.gmail.com>

Hi Andrii,

On Fri, Jul 12, 2024 at 12:38:28PM -0700, Andrii Nakryiko wrote:
> I almost gave my acked-by and tested-by, but then I noticed that this
> leaves fixdep, staticobjs and sharedobjs directories as
> to-be-committed files. Please check, something is off with .gitignore
> or where those are put:
> 
> $ cd ~/linux/tools/lib/bpf
> $ make -j90
> $ git st
> On branch master
> Your branch is ahead of 'bpf-next/master' by 4 commits.
>   (use "git push" to publish your local commits)
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         fixdep
>         sharedobjs/
>         staticobjs/
> 
> nothing added to commit but untracked files present (use "git add" to track)
> 
> 
> Other than that the changes look good, but we should be leaving
> uncommitted (and unignored) files around.

Thanks for looking and for the diligence. At first I thought I moved the
dirs by accident, but that's not the case. The problem is that I'm now
leaving a 'fixdep' artifact in these dirs (they already had a variety of
*.o, etc., files, which were already ignored), so the containing dirs
now show up in the untracked list. I've added a 'fixdep' .gitignore in
my upcoming v4, as well as proper cleaning (fixdep-clean) for it too.

> On Tue, Jul 9, 2024 at 1:43 PM Brian Norris <briannorris@chromium.org> wrote:
> > -$(BPF_IN_SHARED): force $(BPF_GENERATED)
> > +$(SHARED_OBJDIR):
> > +       $(Q)mkdir -p $@
> > +
> > +$(STATIC_OBJDIR):
> > +       $(Q)mkdir -p $@
> 
> I'd probably combine the above two rules into one, but it's minor

Ack. I forgot some Makefile-language details when writing this part.
I'll update in v4.

I'll probably send v4 next week.

Thanks,
Brian

