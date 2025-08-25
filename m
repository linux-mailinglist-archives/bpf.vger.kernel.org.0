Return-Path: <bpf+bounces-66472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEA6B34F2C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F26C7A51B8
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE52BE653;
	Mon, 25 Aug 2025 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYTS1YEO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168B2DF68;
	Mon, 25 Aug 2025 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161881; cv=none; b=FtpeNIpg+t6NXmB8FjbOoWJHEHCkEDmy/h2o1R1SYgDlJvxLIKCx8quH1OToUDVsCZlSnuG8syE8vxsXE0aqE2na61cQiHoi6x8TOXz+u2h0EgTKg2S6NBfrjh18Bz2ehqhApNdP2N0m+MfHBxa5oSgF3PiRbX3oAmGvcJ7CbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161881; c=relaxed/simple;
	bh=ZbyuQjE1x8p1HEl4FTan1gzw8GiQVFaH5z0LNfgsobE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYQ7Pw2pcleRL3TuLNgKauJC0FI9qmxbvbjBNYJzRWXQyRen2L16DQbSThuqjp/BwAAgv3dI8/cd5OSWwWvBcNhkR/r4My6EgT605RSRPqfTmHHJWCKEDFpYKt18dPxPAeb6uk40xDseAElACahEs/08Lbob76POwteH5aCVOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYTS1YEO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c325a4d18so4267993a12.0;
        Mon, 25 Aug 2025 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756161878; x=1756766678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T6zyJCpKNQMONQ/+6DCxz1kO1ActfYAVPqfvtlGBRc=;
        b=eYTS1YEO+z3BusS8sTEgmeTl7p/C+z5CSNUov/CoMwr7X2WiXBu1dTKocw3rykSlv9
         D+Yx3iZZzFHpfCLcmvM2uoz8Al61C/VY9GiKdjuiYa98ZgJx6EEzPVaVAeJVhZrkw/H2
         s9NUZOpZWH4Ghz26tEsWoLOWHB85Usmmdpi+Hf9ivvsGqatirL7VwPQUrMgmy3dGycc4
         9wChktMxvj6wmSZb71JCI5eUb3VCz9e8VHgzTCV/HY832GRk4aBMoRWeXyMklK1ZYCLK
         OPJiJplkYsi1u8u2IEeVXj9CyS0gsvz50f3IGGzGSkAsOOJxWJlLLvNaSlKi2CzORKjK
         Nphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756161878; x=1756766678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T6zyJCpKNQMONQ/+6DCxz1kO1ActfYAVPqfvtlGBRc=;
        b=HRKju8vqSqwiS2M0mVmCUlL/KaZfM/Zoh54WdYCK7iuPnl9iKRKd4XkpXJwHcLF54x
         ySKHK7AuIcDYjHcHPi/gyeTPW7dqOUm4q1ILWw5yFxvABICzVgCsBwE78wjeGgWrMjj+
         fhbfpSYi+eTNmF0CAeU9EQduj55ABZZGgvvhUGC4K2TQHEeCCO1bESwF3Aacax4Gpo6N
         Od8DI/DnLUz8DJ5Swz5siAaIubWxPTzUI4LmJoXexnZCSdMeL72K1IWn1ZtkpRJTbe2h
         Q5q4/PiyE+G6FvM9E6nsmrprSqO8t+HW9Cf8wnt6Bo61n+USJ5MHLTQrK+8NZ2P7QygH
         d0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWfXqBYfYXt2of0hSUooDkemz5Ni8HIH8IUdhmom4vzjLWl3+0pnIND59661tgS2MqTLNM=@vger.kernel.org, AJvYcCWzHb+Yx7wSJS/QDOLEgQyiQFkb77UgoEA5IUjLVXzNqu6iya5+UA4i41BC9TcHANtjUZeAEQT0etedThfS@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVPbsmeWvSGbAIKVQyDm5+riryX6PoXriwc3vLaNEjadLNBPp
	S/v5BI8b59TG2HxrX+NiEBK2cP1Mr5EyX4PfXBVAmVfEwimeyiXHsaLl
X-Gm-Gg: ASbGnctCAJktkl0/K+EMdXzTdOqbRSTPHVGP4Mz3iittr9fC6a48KkpRuaNMNa6zZbl
	r+q4qEGyEBZfOBQOIeVfkegrHE+7BY0HDo7o5QQfXteyCCsw5KyxTPa6vad+fUFGj3s1VsDeWEd
	dHG1cLQlQEPztG7nDjMrpr/tAlrP5xd7b4mcSULhHy4ZkVgp8NzzyLahvSrCyOdlqCEzkAq4HWh
	lYg2NBmOCyyjXc1DVPNVlRc17bpXI18D2/Er94qOuhER/8ED/6j2Sa0jkDJs4jBEqGMStLYSWPY
	HCY9ZVsY2PlwYz8X0PkXm6Sjm6epYKB++lwDJ1rTaP7GQaJDXTXNIZl91nlQnbLA/Zy/TQW3N7C
	OTqd72sZ7Ow==
X-Google-Smtp-Source: AGHT+IHK/2dAsL5304VI5d1gXmgZlUdSYDa6171aXTByy8NgglOb7SHKtyaXn1mszZxFicv11YLpUA==
X-Received: by 2002:a05:6402:348c:b0:61c:7585:8c8 with SMTP id 4fb4d7f45d1cf-61c75852722mr2850061a12.38.1756161878245;
        Mon, 25 Aug 2025 15:44:38 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c90ffd677sm277712a12.46.2025.08.25.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:44:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 Aug 2025 00:44:36 +0200
To: chenyuan_fl@163.com
Cc: olsajiri@gmail.com, aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	chenyuan@kylinos.cn, daniel@iogearbox.net,
	linux-kernel@vger.kernel.org, qmo@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH v7 0/2] bpftool: Refactor config parsing and add CET
 symbol matching
Message-ID: <aKznVD6BjdBCvm0e@krava>
References: <aKL4rB3x8Cd4uUvb@krava>
 <20250825022002.13760-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022002.13760-1-chenyuan_fl@163.com>

On Mon, Aug 25, 2025 at 03:20:00AM +0100, chenyuan_fl@163.com wrote:
> From: Yuan CHen <chenyuan@kylinos.cn>
> 
> 1. **Refactor kernel config parsing**  
>    - Moves duplicate config file handling from feature.c to common.c  
>    - Keeps all existing functionality while enabling code reuse  
> 
> 2. **Add CET-aware symbol matching**  
>    - Adjusts kprobe hook detection for x86_64 CET (endbr32/64 prefixes)  
>    - Matches symbols at both original and CET-adjusted addresses  
> 
> Changed in PATCH v4:
> * Refactor repeated code into a function.
> * Add detection for the x86 architecture.
> 
> Changed int PATH v5:
> * Remove detection for the x86 architecture.
> 
>  Changed in PATCH v6:
> * Add new helper patch (1/2) to refactor kernel config reading
> * Use the new read_kernel_config() in CET symbol matching (2/2) to check CONFIG_X86_KERNEL_IBT
> 
> Changed in PATCH v7:
> * Display actual kprobe attachment addresses instead of symbol addresses

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> Yuan Chen (2):
>   bpftool: Refactor kernel config reading into common helper
>   bpftool: Add CET-aware symbol matching for x86_64 architectures
> 
>  tools/bpf/bpftool/common.c  | 93 +++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/feature.c | 86 ++--------------------------------
>  tools/bpf/bpftool/link.c    | 38 ++++++++++++++-
>  tools/bpf/bpftool/main.h    |  9 ++++
>  4 files changed, 142 insertions(+), 84 deletions(-)
> 
> -- 
> 2.39.5
> 

