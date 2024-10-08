Return-Path: <bpf+bounces-41272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5231299560D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFAD1F239F5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C420CCE3;
	Tue,  8 Oct 2024 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/5sJnpI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA41DF75D;
	Tue,  8 Oct 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410076; cv=none; b=Va0dSyoDpeY6BB2btyHIEaJ60pvuSo9HP+gjapzBKXen0F8baBLmo9lLxXA7WDT8bSiU+j9IqMCM7OI6q+r2qJKCDaJ+CqbSjSt5CmOlbkBzeQ8CT3SJH7y/imWqy3/DTrP9kTQ1/9pVnnzuRRIBz/qx40a/7ZecyXa5Xw7vETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410076; c=relaxed/simple;
	bh=Bv9fMiN54E0Kkjoe1UdCXQUuxnMPqO4c7Y8+ivYX/ZY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiBZbKwYGnX42dVAAhzqKySzqz1kWWoU7ukFRR7IT0GkLKLQ7L76PhvNMY9NqCZgdGP0lZl2bCSkbtqWZ9zQPhU7p3uCpc94vrDEu2jC5MoUPccOk8OslI9hTx8Xw83bzGcZ8nZ3E6LLqDFeKgFAdCqipKJN604yasmUjXCflGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/5sJnpI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba8340beso296395e9.1;
        Tue, 08 Oct 2024 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728410073; x=1729014873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=siLQZ6ACpRPUiQZUIGdfiGQ0P00Sl7v6O1f0GY3NWZE=;
        b=c/5sJnpIyuuFWVl8P4sRwXJTLBB46cSSIfp4uBL7aolZWeS9EyBl81BaVBwh4qXjfP
         gh7Ty1AD6Tr5dd1WTYA9sG9mLsyFtrI1JjAbAxQB6FPKmToqcqZjhNhhhD6LZ8rm5INp
         1dc5Np7t6Tkt9zsZlQDRzqSyycMdKRwdxmgW8pEw/uZaf1C7rRehuQIgBNemGoK07T0e
         uZSthxk7fjXf1moGJj0nKw9KLV8uUIsGyPYIU0TKXiTjyqYYKHtkSA3DwvgM7I2jcfxM
         dbOvtgvwQ+183DnwLYY4ufHaT2qNhLfT7U3nnq21oQZnQPiUV/3ftZgUCcJ6Zbb2vLMp
         ohZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410073; x=1729014873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=siLQZ6ACpRPUiQZUIGdfiGQ0P00Sl7v6O1f0GY3NWZE=;
        b=VKBHX36lxoW0JZrm0bOO1gskYQEyRnFlReetUCr7IYqYCyWP1acc0svRiMS8/zHBuY
         j7eFLwqLHescvnbOgOlA+gn3+GaHzWd9NrA0iO2NUuQ0YmqZJPQQPylEL+rXZdfLsF8Z
         lffwAJF+Rg/Vws0adN6vX+03HgWoUXfe873kZshEmfSFdn8tpucGhLHB4YhgWxoIzbsl
         badnCpO3ENLnPRdmn5ntZK6xsyC9t+05OviydU5rrcltKo5YWQL56Fw2OSC38p7ZCT19
         g1wDYgJG60lCFEtzog/6eSyJ0p5y3yldoQezv6OQA/F3RquGazLjSMk9kjA3gNJCUjG0
         oYYg==
X-Forwarded-Encrypted: i=1; AJvYcCUFqyL1NWNZlVk2mZgMK4VX3nNzqVzdJmn2hNjWVeIfGKvP6mSQUFyv8tX+11QGUWzzx9c=@vger.kernel.org, AJvYcCVD3GKz63iFERHYwz6qobhyLAf78BsKVwd2rFKypatndLCe+UzqOWKkT8TO6LAATww5+CUWNznC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5XEFO86T8/9bGaohPNyofOQEYnYH9cfEeT+76XMTGgyqj6+HB
	4z9+r0Vr0PDGzd3WU25aIR7ZVVz9v61cHoSygpxt9fFhVBNdO/q7
X-Google-Smtp-Source: AGHT+IFSkRDfpR16LGykBW7umn5eUqaHRlfdsi44vM9LmIpteO5uZqlu5mLpxT1al/YFR/IKpUjoeg==
X-Received: by 2002:a05:600c:1c8b:b0:430:4db2:2b88 with SMTP id 5b1f17b1804b1-43057b639b3mr7847275e9.5.1728410072913;
        Tue, 08 Oct 2024 10:54:32 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4affesm134999175e9.47.2024.10.08.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:54:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Oct 2024 19:54:30 +0200
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf 3/4] selftests/bpf: Provide a generic [un]load_module
 helper
Message-ID: <ZwVx1qFvDQXuUbIz@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-3-dfefd9aa4318@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-3-dfefd9aa4318@redhat.com>

On Tue, Oct 08, 2024 at 12:35:18PM +0200, Toke Høiland-Jørgensen wrote:
> From: Simon Sundberg <simon.sundberg@kau.se>
> 
> Generalize the previous [un]load_bpf_testmod() helpers (in
> testing_helpers.c) to the more generic [un]load_module(), which can
> load an arbitrary kernel module by name. This allows future selftests
> to more easily load custom kernel modules other than bpf_testmod.ko.
> Refactor [un]load_bpf_testmod() to wrap this new helper.
> 
> Signed-off-by: Simon Sundberg <simon.sundberg@kau.se>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/testing_helpers.c | 34 +++++++++++++++++----------
>  tools/testing/selftests/bpf/testing_helpers.h |  2 ++
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index d3c3c3a24150f99abd13ecb7d7b11d8f7351560d..5e9f16683be5460b1a295fb9754df761cbd090ea 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -367,7 +367,7 @@ int delete_module(const char *name, int flags)
>  	return syscall(__NR_delete_module, name, flags);
>  }
>  
> -int unload_bpf_testmod(bool verbose)
> +int unload_module(const char *name, bool verbose)
>  {
>  	int ret, cnt = 0;
>  
> @@ -375,11 +375,11 @@ int unload_bpf_testmod(bool verbose)
>  		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
>  
>  	for (;;) {
> -		ret = delete_module("bpf_testmod", 0);
> +		ret = delete_module(name, 0);
>  		if (!ret || errno != EAGAIN)
>  			break;
>  		if (++cnt > 10000) {
> -			fprintf(stdout, "Unload of bpf_testmod timed out\n");
> +			fprintf(stdout, "Unload of %s timed out\n", name);
>  			break;
>  		}
>  		usleep(100);
> @@ -388,41 +388,51 @@ int unload_bpf_testmod(bool verbose)
>  	if (ret) {
>  		if (errno == ENOENT) {
>  			if (verbose)
> -				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> +				fprintf(stdout, "%s.ko is already unloaded.\n", name);
>  			return -1;
>  		}
> -		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> +		fprintf(stdout, "Failed to unload %s.ko from kernel: %d\n", name, -errno);
>  		return -1;
>  	}
>  	if (verbose)
> -		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> +		fprintf(stdout, "Successfully unloaded %s.ko.\n", name);
>  	return 0;
>  }
>  
> -int load_bpf_testmod(bool verbose)
> +int load_module(const char *path, bool verbose)
>  {
>  	int fd;
>  
>  	if (verbose)
> -		fprintf(stdout, "Loading bpf_testmod.ko...\n");
> +		fprintf(stdout, "Loading %s...\n", path);
>  
> -	fd = open("bpf_testmod.ko", O_RDONLY);
> +	fd = open(path, O_RDONLY);
>  	if (fd < 0) {
> -		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
> +		fprintf(stdout, "Can't find %s kernel module: %d\n", path, -errno);
>  		return -ENOENT;
>  	}
>  	if (finit_module(fd, "", 0)) {
> -		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
> +		fprintf(stdout, "Failed to load %s into the kernel: %d\n", path, -errno);
>  		close(fd);
>  		return -EINVAL;
>  	}
>  	close(fd);
>  
>  	if (verbose)
> -		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
> +		fprintf(stdout, "Successfully loaded %s.\n", path);
>  	return 0;
>  }
>  
> +int unload_bpf_testmod(bool verbose)
> +{
> +	return unload_module("bpf_testmod", verbose);
> +}
> +
> +int load_bpf_testmod(bool verbose)
> +{
> +	return load_module("bpf_testmod.ko", verbose);
> +}
> +
>  /*
>   * Trigger synchronize_rcu() in kernel.
>   */
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index d55f6ab124338ccab33bc120ca7e3baa18264aea..46d7f7089f636b0d2476859fd0fa5e1c4b305419 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -38,6 +38,8 @@ int unload_bpf_testmod(bool verbose);
>  int kern_sync_rcu(void);
>  int finit_module(int fd, const char *param_values, int flags);
>  int delete_module(const char *name, int flags);
> +int load_module(const char *path, bool verbose);
> +int unload_module(const char *name, bool verbose);
>  
>  static inline __u64 get_time_ns(void)
>  {
> 
> -- 
> 2.47.0
> 

