Return-Path: <bpf+bounces-35744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DDA93D770
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 19:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F291F24B90
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BEC17C9FF;
	Fri, 26 Jul 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUzf3/k+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D217C7B9;
	Fri, 26 Jul 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014151; cv=none; b=TEKBRaaXJc9dqC60tK67NeRJazz/eUD8VPxaZ4tVwI+o6BVhvU6P04RFbyi7/6UhWHt3QCOZ8I33qnmjIqBezZdhTSEcflcQ4p1FPmDWwnkQwXxwV+eASRgZD+Q8KxIDK0zCFKm2ykmRuioLvUEWxaY/bldoEvrRC7u8/rXsSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014151; c=relaxed/simple;
	bh=61gnd0sx9HxAqNF212thtWj6xm0VgTZonk2jnGbSF0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyPm8XynQoWp3I9mmechYMhP5peg9TK6UWVLQAPpjVoUk6Qs9wvbksrk4301267lBQ5gHvL4AREzY6kDT2cFw+ftIpcBEsmRPYnHgZUwkXTWgmouk8cL+MMmGbjscUQYncCqI/Z9hjvNPnQQGXKFO7cgQKYl64SKLpEjwtqSL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUzf3/k+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso3189443a12.3;
        Fri, 26 Jul 2024 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722014148; x=1722618948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vpGciT+EfMu9i44/49LpouWCuEX00g0iPIyybvjqvo=;
        b=iUzf3/k+9kw3e75iUmTQhLIOhQGpGkIhW6BegQLIamTJ4a/3qeMLIKcWE3QWBAWqKz
         dinPj1BK6SX8o+cl5a5LbSWfdWRJ48ToA56bOqxnpZSITum3/bY4B0cYey/RWDhrQi5l
         K3OW0LBE/k8qUXatBPZsN+8PRgM5rPbZLu88Lcih+oY4LQUcu3DJzk5oWE0QPadcZAm9
         GbUp87/PMg9zDTgE6WAqfgaEcWE9L03O75VmR5uWI7fo4+OgUYtud2mBqdHxKpv+WArm
         TSDCTPrP6lQ50pKlxIDOY/o5qHUOZX0jQkeYNUTDBBMSNuY1ssFDgKHWj1EKeHA2oEur
         uwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014148; x=1722618948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vpGciT+EfMu9i44/49LpouWCuEX00g0iPIyybvjqvo=;
        b=OB7W7Gmi9FJPHd0MbRQXvUAHJKxXHuXEHs6NDEG/DqKFUEDJSqcKCguD7bxgDuv/GW
         WZw5rmoZIkJkBwWtE7LxVWg2Ed8pWjpVz0lrbaoifvVlbVJenMAv0ZZeT8Wh4feMXgf/
         jgWNuAm12XLheVeFa5Pbune8gBcD6WHDkds/9CAj4A7O4YlStSne3DQyE2vK9rqZ/zyX
         mM7sSx4vbe2xw9pIXYKdP9MnQtnLdnZXO2Y3xEVdMedugjrCUcOx4deLWm2WhkqR0A0d
         +5Ikp812Tye11YJMNfFIpfnTQJKu3MzMEgsZa461Y5D2eFmBxQeMzpEQARbNL04ZqMPa
         ZVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPDeHxpWm4/5upqBmC3r7pqLuPAP5bW57GvKIeGyg760S4ffCT2CpkHsS5Exd+z+sh2DhqELWPd/OA5lBh4nRiGADZ885M
X-Gm-Message-State: AOJu0Yx1h1l9VxyJvVsK6t4Dk8HCDxmVigGqtnHt2lU0SDesb+HSm+MS
	rWkDenNDjpdIxEfEVtLxBFNs3Sah4UZloC2E47BvqotoI4JLtf/2
X-Google-Smtp-Source: AGHT+IE9zZdyNmfpiM4FUHqpKi+wmDWmqEBrIS/7oODMnsyvZKwDKVtAKOaJq8aa+lnscoRdtsEW0w==
X-Received: by 2002:a50:f686:0:b0:5a2:eeeb:9470 with SMTP id 4fb4d7f45d1cf-5b020bbde61mr62591a12.18.1722014147419;
        Fri, 26 Jul 2024 10:15:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3aacsm2151534a12.64.2024.07.26.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:15:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 Jul 2024 19:15:44 +0200
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, haoluo@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when compiling
 test_cpp
Message-ID: <ZqPZwByJM3TU5Oqt@krava>
References: <20240725214029.1760809-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725214029.1760809-1-sdf@fomichev.me>

On Thu, Jul 25, 2024 at 02:40:29PM -0700, Stanislav Fomichev wrote:
> Jakub reports build failures when merging linux/master with net tree:
> 
> CXX      test_cpp
> In file included from <built-in>:454:
> <command line>:2:9: error: '_GNU_SOURCE' macro redefined [-Werror,-Wmacro-redefined]
>     2 | #define _GNU_SOURCE
>       |         ^
> <built-in>:445:9: note: previous definition is here
>   445 | #define _GNU_SOURCE 1
> 
> The culprit is commit cc937dad85ae ("selftests: centralize -D_GNU_SOURCE= to
> CFLAGS in lib.mk") which unconditionally added -D_GNU_SOUCE to CLFAGS.
> Apparently clang++ also unconditionally adds it for the C++ targets [0]
> which causes a conflict. Add small change in the selftests makefile
> to filter it out for test_cpp.
> 
> Not sure which tree it should go via, targeting bpf for now, but net
> might be better?
> 
> 0: https://stackoverflow.com/questions/11670581/why-is-gnu-source-defined-by-default-and-how-to-turn-it-off
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index dd49c1d23a60..81d4757ecd4c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -713,7 +713,7 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp
>  # Make sure we are able to include and link libbpf against c++.
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>  	$(call msg,CXX,,$@)
> -	$(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
> +	$(Q)$(CXX) $(subst -D_GNU_SOURCE=,,$(CFLAGS)) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@

nit, seems like we use filter-out for cases like that (but just one instance of -static option)
anyway the fix works for me

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
> -- 
> 2.45.2
> 

