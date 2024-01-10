Return-Path: <bpf+bounces-19318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D88296B3
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8621F27034
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDF3F8D4;
	Wed, 10 Jan 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8ibeTC8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C23EA9F;
	Wed, 10 Jan 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e7b273352so4116178e87.1;
        Wed, 10 Jan 2024 01:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704880610; x=1705485410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpW13ArSUR3hiGaGG4MBnpyKypHsipH6j/gs/ejQL1g=;
        b=L8ibeTC8T3qVuLihUWPlaWUJbkLeC2xm+e4BN89Y6d5MrX7Fl4K7FHSRXtJaE+QFfi
         +qg4WJfLnLcwGkcPi6JGxbSkR2+3QpJyhhEYMI9O5vgYUdznpt9ZHQV1bd9QcaTTNgbw
         KQYogJOJn1Id6ZMNz1LKrxhCJPeB6EoSvdl12By9qbKdtujko4dfJBwurY95kMEJsoeT
         xAWBS9Z7OvlcfsCTIkF2X+AlgJi6mNxMBfwAQK2s61bE+RpNsdpHmyi6T4qWUPbfIxII
         1g6k5kvzrRSzWg27+ZzK4l3PkI/ZVKPZlHdURL16E+v3FicCwh+iYsEh0bwsJfQu3NLK
         RQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704880610; x=1705485410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpW13ArSUR3hiGaGG4MBnpyKypHsipH6j/gs/ejQL1g=;
        b=Ae7aCHZna1lJQTsi8fzWzlkTLLsnHlEpHnrdGbpShM4RyoQjRmSECDPUeQY7MSG2C3
         6MVDkYamPK41Iy2r7u8PiNjPzUc9dkbiNw198UrHHJLrUIIUi8TyOL2wygAQ4XCJWRZt
         7wt/KRIqRotMVqgOfZ9sCJPxK2hyXKKdI412i638UG63VAkBb4TM7B6X33knFlYnBOxX
         2N9WTTUf/3d9MIf41lKeNtgpGRNH6UiJzAu6g2XtQ/ZTKC0Jy1OZIka4bdxDBT5l8/N8
         ubzIGoI+2bCBOosjl0Ztd2xomEIt2nvWisJQ0p6GnhzZcXHGoTgiQxNVWKYxv+8vF6Rw
         NcsA==
X-Gm-Message-State: AOJu0YwvbHBfxya1yBcFDFdP/xgLAfK1H/edd61TPFTTYz8J//TyqsID
	fIS+AuQllYOJlZdv8/ENarw=
X-Google-Smtp-Source: AGHT+IFZX1SYitdtL/PrGHK/QPZ4ajIdAjRbAxPJ8ut2kihr+QX5/b+FNeiGkhlOo5ECcM2O5oqMDQ==
X-Received: by 2002:a05:6512:3b8b:b0:50e:4389:12c5 with SMTP id g11-20020a0565123b8b00b0050e438912c5mr395125lfv.14.1704880610146;
        Wed, 10 Jan 2024 01:56:50 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id l4-20020a170906a40400b00a2bfd60c6a8sm126314ejz.80.2024.01.10.01.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 01:56:48 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Jan 2024 10:56:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
	x86@kernel.org, leit@meta.com, linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com, bpf@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 00/13] x86/bugs: Add a separate config for each
 mitigation
Message-ID: <ZZ5p3vdnTtU5TeJe@gmail.com>
References: <20231121160740.1249350-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>


* Breno Leitao <leitao@debian.org> wrote:

> Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
> where some mitigations have entries in Kconfig, and they could be
> modified, while others mitigations do not have Kconfig entries, and
> could not be controlled at build time.
> 
> The fact of having a fine grained control can help in a few ways:
> 
> 1) Users can choose and pick only mitigations that are important for
> their workloads.
> 
> 2) Users and developers can choose to disable mitigations that mangle
> the assembly code generation, making it hard to read.
> 
> 3) Separate configs for just source code readability,
> so that we see *which* butt-ugly piece of crap code is for what
> reason.
> 
> Important to say, if a mitigation is disabled at compilation time, it
> could be enabled at runtime using kernel command line arguments.
> 
> Discussion about this approach:
> https://lore.kernel.org/all/CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com/
> and
> https://lore.kernel.org/lkml/20231011044252.42bplzjsam3qsasz@treble/
> 
> In order to get the missing mitigations, some clean up was done.
> 
> 1) Get a namespace for mitigations, prepending MITIGATION to the Kconfig
> entries.
> 
> 2) Adding the missing mitigations, so, the mitigations have entries in the
> Kconfig that could be easily configure by the user.
> 
> With this patchset applied, all configs have an individual entry under
> CONFIG_SPECULATION_MITIGATIONS, and all of them starts with CONFIG_MITIGATION.

Yeah, so:

 - I took this older series and updated it to current upstream, and made
   sure all renames were fully done: there were two new Kconfig option
   uses, which I integrated into the series. (Sorry about the delay, holiday & stuff.)

 - I also widened the renames to comments and messages, which were not
   always covered.

 - Then I took this cover letter and combined it with a more high level
   description of the reasoning behind this series I wrote up, and added it
   to patch #1. (see it below.)

 - Then I removed the changelog repetition from the other patches and just
   referred them back to patch #1.

 - Then I stuck the resulting updated series into tip:x86/bugs, without the 
   last 3 patches that modify behavior.

 - You might notice the somewhat weird extra whitespaces in the titles - 
   I've done that so that it all looks tidy in the shortlog:

   Breno Leitao (10):
      x86/bugs: Rename CONFIG_GDS_FORCE_MITIGATION => CONFIG_MITIGATION_GDS_FORCE
      x86/bugs: Rename CONFIG_CPU_IBPB_ENTRY       => CONFIG_MITIGATION_IBPB_ENTRY
      x86/bugs: Rename CONFIG_CALL_DEPTH_TRACKING  => CONFIG_MITIGATION_CALL_DEPTH_TRACKING
      x86/bugs: Rename CONFIG_PAGE_TABLE_ISOLATION => CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
      x86/bugs: Rename CONFIG_RETPOLINE            => CONFIG_MITIGATION_RETPOLINE
      x86/bugs: Rename CONFIG_SLS                  => CONFIG_MITIGATION_SLS
      x86/bugs: Rename CONFIG_CPU_UNRET_ENTRY      => CONFIG_MITIGATION_UNRET_ENTRY
      x86/bugs: Rename CONFIG_CPU_IBRS_ENTRY       => CONFIG_MITIGATION_IBRS_ENTRY
      x86/bugs: Rename CONFIG_CPU_SRSO             => CONFIG_MITIGATION_SRSO
      x86/bugs: Rename CONFIG_RETHUNK              => CONFIG_MITIGATION_RETHUNK

I think the resulting tree is all mostly good, but still I'd like to see 
just the 10 pure low-risk renames done in this first step, to not carry too 
much of this around unnecessarily - maybe even send it Linuswards in this 
cycle if it's problem-free - without any real regression risk to upstream.

Thanks,

	Ingo

=============================>
commit be83e809ca67bca98fde97ad6b9344237963220b
Author: Breno Leitao <leitao@debian.org>
Date:   Tue Nov 21 08:07:28 2023 -0800

    x86/bugs: Rename CONFIG_GDS_FORCE_MITIGATION => CONFIG_MITIGATION_GDS_FORCE
    
    So the CPU mitigations Kconfig entries - there's 10 meanwhile - are named
    in a historically idiosyncratic and hence rather inconsistent fashion
    and have become hard to relate with each other over the years:
    
       https://lore.kernel.org/lkml/20231011044252.42bplzjsam3qsasz@treble/
    
    When they were introduced we never expected that we'd eventually have
    about a dozen of them, and that more organization would be useful,
    especially for Linux distributions that want to enable them in an
    informed fashion, and want to make sure all mitigations are configured
    as expected.
    
    For example, the current CONFIG_SPECULATION_MITIGATIONS namespace is only
    halfway populated, where some mitigations have entries in Kconfig, and
    they could be modified, while others mitigations do not have Kconfig entries,
    and can not be controlled at build time.
    
    Fine-grained control over these Kconfig entries can help in a number of ways:
    
      1) Users can choose and pick only mitigations that are important for
         their workloads.
    
      2) Users and developers can choose to disable mitigations that mangle
         the assembly code generation, making it hard to read.
    
      3) Separate Kconfigs for just source code readability,
         so that we see *which* butt-ugly piece of crap code is for what
         reason...
    
    In most cases, if a mitigation is disabled at compilation time, it
    can still be enabled at runtime using kernel command line arguments.
    
    This is the first patch of an initial series that renames various
    mitigation related Kconfig options, unifying them under a single
    CONFIG_MITIGATION_* namespace:
    
        CONFIG_GDS_FORCE_MITIGATION => CONFIG_MITIGATION_GDS_FORCE
        CONFIG_CPU_IBPB_ENTRY       => CONFIG_MITIGATION_IBPB_ENTRY
        CONFIG_CALL_DEPTH_TRACKING  => CONFIG_MITIGATION_CALL_DEPTH_TRACKING
        CONFIG_PAGE_TABLE_ISOLATION => CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
        CONFIG_RETPOLINE            => CONFIG_MITIGATION_RETPOLINE
        CONFIG_SLS                  => CONFIG_MITIGATION_SLS
        CONFIG_CPU_UNRET_ENTRY      => CONFIG_MITIGATION_UNRET_ENTRY
        CONFIG_CPU_IBRS_ENTRY       => CONFIG_MITIGATION_IBRS_ENTRY
        CONFIG_CPU_SRSO             => CONFIG_MITIGATION_SRSO
        CONFIG_RETHUNK              => CONFIG_MITIGATION_RETHUNK
    
    Implement step 1/10 of the namespace unification of CPU mitigations related
    Kconfig options and rename CONFIG_GDS_FORCE_MITIGATION to
    CONFIG_MITIGATION_GDS_FORCE.
    
    [ mingo: Rewrote changelog for clarity. ]
    
    Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Link: https://lore.kernel.org/r/20231121160740.1249350-2-leitao@debian.org

