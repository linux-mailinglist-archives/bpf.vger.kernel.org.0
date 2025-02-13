Return-Path: <bpf+bounces-51467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ACDA34F79
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 21:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E3816A059
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 20:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09287155326;
	Thu, 13 Feb 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="acmIhGlJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E6245B0B
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478977; cv=none; b=XmfxdMn1iKHF/v110juE4Og5HsC4M6jIVdT7NFRyLP2C82IS3TIWUX5S8+2JqAo8kBCSc6P3Z94Kvx+rXARA+MrbeoVJ8WcNZLCPAdu46mt8CQFC47Eavz6stn4wWnFZasVbwcySVtZ/Rk85YmmwdJdZ/ckRk0LtM4W1SxES18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478977; c=relaxed/simple;
	bh=3OmoPPtRJ3Eu45qzEZ5Fn9o4ggtZYUBS4BI+ZuxwU9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0Y+kJLoKwPa11UlScLj7MIiotDaRI/OzduT6mSEZcJcO7xIwbp/+RMSgMcvySNA8pjrVkII0DZSLe0QXAobH88rxzEWGhKf/kUjVQKb2o9F9Pdoum3dJ0tZkRoAwLDf5IBRMXUo9QwlFyBm5ZJMH6DKr7TNl/EZ7JnCoGXTOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=acmIhGlJ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5dab3f37b1so1152994276.0
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739478974; x=1740083774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBViFwG3GkhnREQpuSeahWWDP1mD68WVlRn8a2dnxcU=;
        b=acmIhGlJgUa5X6x/p6lGSR1OOTQm1fFvAnS8y5pnJIQNrmErCwufB/us5tLL+QCi3d
         5/c2g9J/IeOzJDhW6nAaE+9xa3w0MILNPonFLCcxhj1nzE6uaU2zgaQxwGSg5wFjJMZH
         wDe/5xMMaBdU8pupcqRhTla0MVHXbLiMtoU3+7wiYleKzhrGjYEoPoxQgRSvC70TiG9B
         lGAZDAFhqkqInpWF4EkfE+mLuzrar8bs84DmX5t/UAG/neQjPpE5Ip7b9g3jNaLAsFYh
         eXtEeYKTOeL1hqbOa+I/FU5/wNK0QtBeF6GIZV48r7NW3DupoIZKnYu5Z9y5DbuiFeHt
         lUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739478974; x=1740083774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBViFwG3GkhnREQpuSeahWWDP1mD68WVlRn8a2dnxcU=;
        b=BEgOx+TccuDh8qxoEItJPHaZUZ7JJIerQdTHS7huw8zi4dEs1l4N+drGBDsx33BQXc
         fM8ap2qtcdMM0VLuH50zO8LhmeHgLzkHCvlL+YD2zD+fqpk4MuAyVYJqrZnWkbH3yap3
         Z9TXbBdQWOEbwWcFQ3pd+35ucCLMXe4lqbamk51XxyUSzfUpN9IUZlNc0rgsDOEaDAK9
         zHLTgt3VyAxS/7F1PH+/JqauOns2/+GzQrc1a+uEp6rRHyNgOdp36famsdoRo4/jJdRL
         90neFXePTw1YUyEp9CNv03RsBZFrLqlIPC2ThtgAUSntpzuWugdILyOyKQo5GysNr0mv
         0/OA==
X-Forwarded-Encrypted: i=1; AJvYcCVk6BC/+jy2Er5ty69j4LR3AJ/dG8IR/g3bfmur4NpoZErbvaFZxvcswVPmA2ZM8K45INg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJuOCFzHb3cYfsMs1oPjwizE9wrG0xKlMdRWzCyQ6RoHhYaNB
	BjQpuz2MWH4bbyGKBYFnCj4UXxiGTGTUSWZ/tABXdokySDYs+4XQnNjQehDVD4l61EeNeVYomhe
	dPbZO3A==
X-Gm-Gg: ASbGnct2BxEqESh/MDv/5X+AZ0yvymobA5O1WhI6ROM/Q6Qw7czzZQUSqv4tfqD08cs
	NVK7YvM61ybswQXcmzwaIyKAq9S+JG54BfoD14rjYmyzfr4N8gdWzc59he7aWa6Db33adNw93ct
	GfTC0BbBQP2NZmgAUez8VVEL3DB3i/k1bdZPKUMbrQjho7GyWAs06cbnTI60m1rpprZRwl9n51P
	Lo/2wn1+vFqqU4gM4gaq1bR0LnoutrnllsbeVhzm8ubuKC8aI5qn2t8HMDRuwY54tM1IE3P1bq2
	1Aw=
X-Google-Smtp-Source: AGHT+IFli3J2pYxGrWlDhVf9piBN6Mt57GNwjDPRKZNkn4CDBVtemQHp9qzLUy0Yrgza7R0zwIrtIA==
X-Received: by 2002:a05:6902:11c7:b0:e57:4db7:6d51 with SMTP id 3f1490d57ef6-e5d9f170324mr8763028276.32.1739478974506;
        Thu, 13 Feb 2025 12:36:14 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dadeca97bsm580863276.32.2025.02.13.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:36:13 -0800 (PST)
Date: Thu, 13 Feb 2025 12:36:12 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z65XvCrcBlf61LYw@ghost>
References: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
 <20250210-quiet_tools-v2-1-b2f18cbf72af@rivosinc.com>
 <Z6tSvUt47FV60UJA@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tSvUt47FV60UJA@krava>

On Tue, Feb 11, 2025 at 02:38:05PM +0100, Jiri Olsa wrote:
> On Mon, Feb 10, 2025 at 10:34:42AM -0800, Charlie Jenkins wrote:
> 
> SNIP
> 
> > +# Beautify output
> > +# ---------------------------------------------------------------------------
> > +#
> > +# Most of build commands in Kbuild start with "cmd_". You can optionally define
> > +# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
> > +# that command is printed by default.
> > +#
> > +# e.g.)
> > +#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
> > +#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
> > +#
> > +# A simple variant is to prefix commands with $(Q) - that's useful
> > +# for commands that shall be hidden in non-verbose mode.
> > +#
> > +#    $(Q)$(MAKE) $(build)=scripts/basic
> > +#
> > +# To put more focus on warnings, be less verbose as default
> > +# Use 'make V=1' to see the full commands
> > +
> > +ifeq ($(V),1)
> > +  quiet =
> > +  Q =
> > +else
> > +  quiet = quiet_
> > +  Q = @
> > +endif
> > +
> >  # If the user is running make -s (silent mode), suppress echoing of commands
> >  # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> >  ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > @@ -145,9 +172,11 @@ short-opts := $(filter-out --%,$(MAKEFLAGS))
> >  endif
> >  
> >  ifneq ($(findstring s,$(short-opts)),)
> > -  silent=1
> 
> hi,
> I think you need to keep this one, there's "ifneq ($(silent),1)" condition
> later in the file for the silent (-s) builds

Oh yes, thank you.

- Charlie

> 
> jirka
> 
> 
> > +  quiet=silent_
> >  endif
> >  
> > +export quiet Q
> > +
> >  #
> >  # Define a callable command for descending to a new directory
> >  #
> > 
> > -- 
> > 2.43.0
> > 

