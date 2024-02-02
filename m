Return-Path: <bpf+bounces-21051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3D84702B
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44531C26E1F
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BACD1419BA;
	Fri,  2 Feb 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zL4A5dXT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60727764F
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876506; cv=none; b=LiBbLrZ8MAXE9t/OdtkLb1feVk17sUZWNyoRTpOcTuKO+lQ5rhGhV/KqBKi/B7gQXz2+0G/049WMgD1DgZo+V4bXB08YI6Hzeeh1YI+3g5QE2Db6D++s39LCEA0ZLJt2GNOf9JRcpCiLN+dJLVTFI4OO+aUyWMaDjn2aADxWG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876506; c=relaxed/simple;
	bh=/lSQmt72CkXTO6IuU4LTaBs/Ul5xFwmo+dJPP9Jkq4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB42GBz8PDg9UFZHWxDjU/sbSacsC6VeqEdHD5n0cuW8IMtTPLwuEgzYj7XBSklbC9Qd51wr4lIF9VMiq3g7i9YSvdRJWZSsdKC3aLnlZJkUyj5DPu8ghvrbRQ7qDXi3l1oQZhgnxrdoR/ujEqYxzUFJHRkRMSlAK2zVqMx8jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zL4A5dXT; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5112ea89211so2247426e87.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 04:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706876501; x=1707481301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8W2rvp+iz0AMnClCez/6mpFobBZYw1hUu+7ubVOtV0=;
        b=zL4A5dXTjLBJxOw3GBDgZ1673e6vMGkwNs+Eq1djDcJmwHZesUf5EhiZG7QY9gbie8
         Cfd3/Gwvxg8Yu7WKfGP1r1/oZjVoTDTwY6dYj9RSMRn5mfSF30Fa2ZDB6komU5aDqma5
         Amq3wotPmjFn6JP14xNyUuLWMe+Gf/Ybv+3dOvQNmV8uuUrTACAeo9BJqJSISZLd8Jdi
         nFdluGBff+rPUGBQwJSUGUl2bD43ZzarhUe2y8xB3U+p4d3QUmdxM6htS4Rta+0FLXSK
         4xXeyz7Mx2Q3ZvcuOzSmFKHfcR/+jWkhcjfD69HbFuqq/xyz0W7NJA3tEwS8kYFgz8NN
         SRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876501; x=1707481301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8W2rvp+iz0AMnClCez/6mpFobBZYw1hUu+7ubVOtV0=;
        b=kSj5vpp03MuV3WSVyoag0dLm0Uc2Ly5J/+lG6KnpjDGB7To1TZLWVC0NdOfhGYlxqb
         7rR7FM8AoovwTK7ha8R3q3rWaBtNM87L5QyncWzBeBuyp6x534Ir+A81Qvp8DyLJFhmG
         /k3trFb07eUCM5nhJLzV9+/SioeXMmRJrcE0p8ct0nywoBizQKo+SKYMaupjK8Ul5K8F
         GZ8crMAnw23C5tW+Q3G3miFSNrPvho4o5LsAECZXUr3qBySSCMYFAOmPe06qrkbm80K9
         HJ2y8jf+TLnuj2iFYnyumTMyoOwRCRLCnp/upXmsvqYGTHnixdkBxyhjQGJlenKdPIeV
         aZvA==
X-Gm-Message-State: AOJu0Ywtb2R7kPTirQTZkVN8T+gLwXwkl9AF0OabOecePOCXjdGIb9qn
	lMbwwBsyX3GpRjnNdUjrEDFmbxSX5faQqjgXauGZu9BzFKsm4e7hTSRoMWUUwGI=
X-Google-Smtp-Source: AGHT+IHuyzepGqzxcqmF4kQM1BTlD66SloEdPur1ZTqtQDOOA9um7Eu0Ctuhe5renJU0t0S1tz2q6Q==
X-Received: by 2002:a19:6912:0:b0:511:33d4:c99b with SMTP id e18-20020a196912000000b0051133d4c99bmr1066834lfc.43.1706876500765;
        Fri, 02 Feb 2024 04:21:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVlMlicMDZ+2SNsVj0g0p5WamBP0KeCBpOSXqPQk/GYHt+vJE/aOFF33umv47b05w/CnWAru0qFnVS7qz94jADuv7M6UtaKsyvZjDIOzA30pA61zxUCiS6eEWex0vYWGN6KB4OoUZsSvAzrDCCWeatv8D9Pg4pyT5NxXYj7b7aZeeAhQniRN+jZ+Uz+BgJB+GWV2LEpjvdSBsy1vVBaicedz81bcMMV3paXZqsNJQ2GX5zzw5GPdtmjTcXgTbEvCcgK0l5nBjdJwXAIQ4dN4ZPvVKDMiXHWs+fJ3lR2+H5A4YzzGzz0km/BpUzrarLtsE42WoMRqZWkGOuXvzXzsOLcsFerhIhidvqLfSKVdS+CvouHgXjHXzX7i2QU1YjoSl8KMc7x/kRvyWSHqLCC3BDSuCju8gU1/Zvgjs/KZBezhnsN91I9jf5i2xN1v3j8BlKSSD3UsYXKQXqtbxdA2KnRN6DImtafou48nE4bYquMO099mOi8n0uFTNW0P17x7SqtIdHel48xu9E5YpZgVNse/xkgwmUqtNChxhQF5cM+uLwKPzIqOQpc/8KSn8bSla3jdIKgNLt4aNUc9tzOkxD5R8D8DOV0B6hXRs5X8aJrgYYoSTTrDsZ9YljHhLnC5FWiisuceAu/o4Baqvxf9a6p7csBKVAQCPQEOSuY1owd9zhA2RBOO9Cd/aSsS7FVlZEXtm9sBPocdFn4pi6ExGt7wWzdOiZwid3t1WDRQNqu9Bjn48009TNidvwhovm9ssIqORzGFezZ7OY5eS5mRJL5OTMqVtRJ1iHi+3hkYSrmm7o1NpzGnw==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4b9100b0040e3bdff98asm7131019wmp.23.2024.02.02.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:21:40 -0800 (PST)
Date: Fri, 2 Feb 2024 13:21:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, cake@lists.bufferbloat.net,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH v5 0/4] net/sched: Load modules via alias
Message-ID: <ZbzeUW459-2f7iaq@nanopsycho>
References: <20240201130943.19536-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201130943.19536-1-mkoutny@suse.com>

Thu, Feb 01, 2024 at 02:09:39PM CET, mkoutny@suse.com wrote:
>These modules may be loaded lazily without user's awareness and
>control. Add respective aliases to modules and request them under these
>aliases so that modprobe's blacklisting mechanism (through aliases)
>works for them. (The same pattern exists e.g. for filesystem
>modules.)
>
>For example (before the change):
>  $ tc filter add dev lo parent 10: protocol ip prio 10 handle 1: cgroup
>  # cls_cgroup module is loaded despite a `blacklist cls_cgroup` entry
>  # in /etc/modprobe.d/*.conf
>
>After the change:
>  $ tc filter add dev lo parent 10: protocol ip prio 10 handle 1: cgroup
>  Error: TC classifier not found.
>  We have an error talking to the kernel
>  # explicit/acknowledged (privileged) action is needed
>  $ modprobe cls_cgroup
>  # blacklist entry won't apply to this direct modprobe, module is
>  # loaded with awareness
>
>A considered alternative was invoking `modprobe -b` always from
>request_module(), however, dismissed as too intrusive and slightly
>confusing in favor of the precedented aliases (the commit 7f78e0351394
>("fs: Limit sys_mount to only request filesystem modules.").
>
>User experience suffers in both alternatives. Its improvement is
>orthogonal to blacklist honoring.
>
>Changes from v1 (https://lore.kernel.org/r/20231121175640.9981-1-mkoutny@suse.com)
>- Treat sch_ and act_ modules analogously to cls_
>
>Changes from v2 (https://lore.kernel.org/r/20231206192752.18989-1-mkoutny@suse.com)
>- reorganized commits (one generated commit + manual pre-/post- work)
>- used alias names more fitting the existing net- aliases
>- more info in commit messages and cover letter
>- rebased on current master
>
>Changes from v3 (https://lore.kernel.org/r/20240112180646.13232-1-mkoutny@suse.com)
>- rebase on netdev/net-next/main
>- correct aliases in cls_* modules (wrong sed)
>- replace repeated prefix strings with a macro
>- patch also request_module call in qdisc_set_default()
>
>Changes from v4 (https://lore.kernel.org/r/20240123135242.11430-1-mkoutny@suse.com)
>- update example in cover letter to existing module (cls_tcindex->cls_cgroup)
>  - tested that ':-)
>- remove __stringify in alias macro, net-cls-cgroup instead of net-cls-"cgroup"
>- pass correct argument to request_module() (Simon)
>- rebased on netdev-next/main
>
>Michal Koutný (4):
>  net/sched: Add helper macros with module names
>  net/sched: Add module aliases for cls_,sch_,act_ modules
>  net/sched: Load modules via their alias
>  net/sched: Remove alias of sch_clsact

Set looks fine to me:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

