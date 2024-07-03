Return-Path: <bpf+bounces-33776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8559263C0
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF01A1F23127
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31BB17B41F;
	Wed,  3 Jul 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBRVq+DS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA634539A;
	Wed,  3 Jul 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018056; cv=none; b=b5CmixKR7i0qxgopQ/oWhwfCAPVrdH5ono4GbJlSK3SduhtOBqZifSVdywMmsGRXWPMhYrVDpxpn06waQv13LbQPAOuTfSwXXEGh8erYNxJcwYcT5t7LlaHXVIhl1boshOtL0ryP6ZnHpv8uAL8GrrPRtrIgyMHV74wyO0Ntw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018056; c=relaxed/simple;
	bh=napRAhyJFAXalKtaT9l1J5EEyvWzsWl1Bazd/z7J9NQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcxLQGk4+VbGpoUxxEWht/+sWjkQEDg7HiMxYqypMTgaGOnZng3l5UYUwPcugVagCoIkKpcM9mM3JGcxtJy4F11Ramvu8/0/6KS6VIS9f0joyNAWFOpZ4RbEBtQb+hRKlDmENW9/9n8xbvPGdEJ6YqzplvcNr72Y1xMZHfgj4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBRVq+DS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367339bd00aso4291629f8f.3;
        Wed, 03 Jul 2024 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720018053; x=1720622853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GhVLpWIOnHzAJ+VH94QV8bdXrFzuO4h9ui8LZsPxME=;
        b=CBRVq+DSp/14NFTApkJCHU3YuCMSHCowvU2E68+yRhj88VF09LGXkachPS6/sf2gEQ
         XEEjRlNWuZkAvolL0ueQhVFCyEy1YWqa1pygX8Hd38iC2V6XYaYg9Xiioju8qOweNFFU
         BLA/2BjHkUxCStxosc6ivxJRPVUo7UToeq4EN8pAG+cP13n+fy0D9q3ftQeX5LFMt6WW
         rS1uxG7Gom+8DlvfqEVdyOFZglL1IAuoSw0cVJBCJu/6mVIQQLgpFIAVeGgNiD2FlV5L
         hRoYZaW9WdiUFeUvlqaN/BXgi/AtMjEUBq9K48WBp6c5no5+e894SfDW4OxPsiUtrk48
         BXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018053; x=1720622853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GhVLpWIOnHzAJ+VH94QV8bdXrFzuO4h9ui8LZsPxME=;
        b=esce7qHdva21WQ/MLXVw15avmyMamjW2XgbeGJRudSC6YM9OIxR0cj1I/kZP8VYp7U
         csu8pKXnPPHFYoi2ulZ4jZ8npk1LMbqrMgDXNBil/VUTN42bF/KaGrEW3zvyaOvIw7If
         Em1Xsx960gw1cSY7WGziOqK9i2XZmYzLgelnsjLUA6vAq7tCaAUBUghZUpa/CvnuFR9b
         iQaEKdfezy56gltQHYygmV4dC7t8A+cnIpeLyQapmjnenvM3F9/TsESv5cUosk9kTksh
         1SYyfblIVSNi1JEdHMDcMupUOc5iSqqqbD/sLtmK65x6QPlF/DwTN0vJkTnr9eA8XGZc
         wZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUchoei6t8fRNRP0wVEhOvWzpJRe1ttYUeUjU7gDykz/EKf9jl4awtLi4fZbEtWCSTPP5O9bEU5XNMAJiWKl9FDl+mB1J7AxOlIjqewmxMAglS58B1Tlip9MfdP6E/XMAOnP513l0Nmx3VStiP0doAxV5Yg3ZisDLvNKNEZNn6
X-Gm-Message-State: AOJu0YyA/pFponyJlOo7GYH8Mu6W7DbQ9jJOrIMvrvZcYc+tYVkftsj+
	WSSO1B8Di8Sa+bA7+Faj0nU2ty3CQCaagCG+EPW6xf+Jtoc/eyV7XmMpxLiSFQ0=
X-Google-Smtp-Source: AGHT+IGAFmLpmEEermipwzP2mFO215eDi1eb2+39P64YHszZ8oahoUi1l4Owwn6WEvmmNPoBTpbYhA==
X-Received: by 2002:a5d:5585:0:b0:367:98fb:5063 with SMTP id ffacd0b85a97d-36798fb50f0mr106189f8f.64.1720018052763;
        Wed, 03 Jul 2024 07:47:32 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d62sm16020237f8f.105.2024.07.03.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:47:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 16:47:29 +0200
To: Brian Norris <briannorris@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tools build: Correct bpf fixdep dependencies
Message-ID: <ZoVkgUEeKYZGiocx@krava>
References: <20240702215854.408532-1-briannorris@chromium.org>
 <20240702215854.408532-4-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702215854.408532-4-briannorris@chromium.org>

On Tue, Jul 02, 2024 at 02:58:39PM -0700, Brian Norris wrote:
> The dependencies in tools/lib/bpf/Makefile are incorrect. Before we
> recurse to build $(BPF_IN_STATIC), we need to build its 'fixdep'
> executable.
> 
> I can't use the usual shortcut from Makefile.include:
> 
>   <target>: <sources> fixdep
> 
> because its 'fixdep' target relies on $(OUTPUT), and $(OUTPUT) differs
> in the parent 'make' versus the child 'make' -- so I imitate it via
> open-coding.
> 
> I tweak a few $(MAKE) invocations while I'm at it, because
> 1. I'm adding a new recursive make; and
> 2. these recursive 'make's print spurious lines about files that are "up
>    to date" (which isn't normally a feature in Kbuild subtargets) or
>    "jobserver not available" (see [1])
> 
> I also need to tweak the assignment of the OUTPUT variable, so that
> relative path builds work. For example, for 'make tools/lib/bpf', OUTPUT
> is unset, and is usually treated as "cwd" -- but recursive make will
> change cwd and so OUTPUT has a new meaning. For consistency, I ensure
> OUTPUT is always an absolute path.
> 
> And $(Q) gets a backup definition in tools/build/Makefile.include,
> because Makefile.include is sometimes included without
> tools/build/Makefile, so the "quiet command" stuff doesn't actually work
> consistently without it.
> 
> After this change, top-level builds result in an empty grep result from:
> 
>   $ grep 'cannot find fixdep' $(find tools/ -name '*.cmd')
> 
> [1] https://www.gnu.org/software/make/manual/html_node/MAKE-Variable.html
> If we're not using $(MAKE) directly, then we need to use more '+'.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
> 
> Changes in v2:
>  - also fix libbpf shared library rules
>  - ensure OUTPUT is always set, and always an absolute path
>  - add backup $(Q) definition in tools/build/Makefile.include
> 
>  tools/build/Makefile.include | 12 +++++++++++-
>  tools/lib/bpf/Makefile       | 14 ++++++++++++--
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
> index 8dadaa0fbb43..0e4de83400ac 100644
> --- a/tools/build/Makefile.include
> +++ b/tools/build/Makefile.include
> @@ -1,8 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  build := -f $(srctree)/tools/build/Makefile.build dir=. obj
>  
> +# More than just $(Q), we sometimes want to suppress all command output from a
> +# recursive make -- even the 'up to date' printout.
> +ifeq ($(V),1)
> +  Q ?=
> +  SILENT_MAKE = +$(Q)$(MAKE)
> +else
> +  Q ?= @
> +  SILENT_MAKE = +$(Q)$(MAKE) --silent
> +endif
> +
>  fixdep:
> -	$(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
> +	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
>  
>  fixdep-clean:
>  	$(Q)$(MAKE) -C $(srctree)/tools/build clean
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 2cf892774346..630369c0091e 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -108,6 +108,8 @@ MAKEOVERRIDES=
>  
>  all:
>  
> +OUTPUT ?= ./
> +OUTPUT := $(abspath $(OUTPUT))/
>  export srctree OUTPUT CC LD CFLAGS V
>  include $(srctree)/tools/build/Makefile.include
>  
> @@ -141,7 +143,13 @@ all: fixdep
>  
>  all_cmd: $(CMD_TARGETS) check
>  
> -$(BPF_IN_SHARED): force $(BPF_GENERATED)
> +$(SHARED_OBJDIR):
> +	$(Q)mkdir -p $@
> +
> +$(STATIC_OBJDIR):
> +	$(Q)mkdir -p $@
> +
> +$(BPF_IN_SHARED): force $(BPF_GENERATED) | $(SHARED_OBJDIR)
>  	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
>  	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
>  	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
> @@ -151,9 +159,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
>  	@(test -f ../../include/uapi/linux/if_xdp.h -a -f ../../../include/uapi/linux/if_xdp.h && ( \
>  	(diff -B ../../include/uapi/linux/if_xdp.h ../../../include/uapi/linux/if_xdp.h >/dev/null) || \
>  	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
> +	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(SHARED_OBJDIR) $(SHARED_OBJDIR)fixdep
>  	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
>  
> -$(BPF_IN_STATIC): force $(BPF_GENERATED)
> +$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)
> +	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
>  	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
>  
>  $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
> 

