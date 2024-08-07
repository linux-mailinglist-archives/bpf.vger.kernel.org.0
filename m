Return-Path: <bpf+bounces-36538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8519A94A394
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 11:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5220B228C3
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8A1CB305;
	Wed,  7 Aug 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQVo8KPk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685D1C9DE2
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021674; cv=none; b=PYwH29IlJrAWmi/yakrX+bWEL8EiAFfLdWVkt9t6JwXpG6O0IpTEQAt9zGBDRranmG5xEEfNfcPcNG+fgXCssxaqBmyYpMqSheHRs0V1tkr+0965jVjBbHh0CxF39GN+OqCw8hmv4mvSlUU1+B1g69jHKSmKoQmzomjialzjZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021674; c=relaxed/simple;
	bh=S1P9d4V3sZvDEnyyob6e3ky4TAd68S2deQG8T6nrKTw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6oknOIPweBfRN9M5BFd1N6fVlSVp4NF0bhEY4oP6x6sk15U3G5FewJ/4msXwz88ryPksm0iTT3zk5j+Es9IgEh1HYuhkWkrjfRorUEESx8BPMBMgHzKJk1AU4NMfQ/j3KESSTnzWOyEzWk0BrNemhtP71RHrlkeL6zrcXIgEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQVo8KPk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so1140246a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723021671; x=1723626471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IauWX0OZhHNX7R6rgt8GyXKHjMsCI8fAfFUhU/cpkGM=;
        b=OQVo8KPkboHfutYRBJLorRCREsf1TsZs/xGm+TTkmvoIyIECxyr82mLClxxg0SMB41
         nLilnmlY6xWNZNR+suPeIn0cTXsBjsivTq5iV9zjOYldl1rMcqjpHWbBwrojY7dR+4yc
         jFjq6LAerjljKijqPJTtMwni9KdDMxBReP5h+eatWwW5JEYzXLcTxgUFaA1j6V1Bwegc
         uT61ZxEtTLFqzxsYNFgpE6/yBdtJU3oweQIJcVKOBb6lBPttoSxid9Q0QfKSz5xdR9AM
         yIVzLRd1jc8oJZcFY4/HxS6C7MW8+vEB6x+HJUkkEXyeMUUkB9+t27h/Kjf83UMF1jQO
         pK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723021671; x=1723626471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IauWX0OZhHNX7R6rgt8GyXKHjMsCI8fAfFUhU/cpkGM=;
        b=E/n1lYZb5K2QT6SZBxNfvzXsmcDrgf6XARivMMGt849biyFZonCYWIkQI466hFO42v
         yaH20QCJugCxuNxJDm1oGyEIDi8KUDCHrOdpPt94KmV6p6rd9pqYcyUpL4kZbULecsc+
         JkuAWRAVY8GH6c0FRbgt78xeRvYEUOHCV1REZ/WCBK7TM368/BHZk6rvaMR0ReVYfnJW
         1cBO8QAwDS+lCE8LiDjZm3ncmUTUkZNSsyA3+I+WZpmlxJE4pi9s71tOLgrwbkG/E8CH
         QpZc/qvgyNDTc7/ypH5CkZZEdWRSupI/KNJjGozhfQMN/lspC0mCi8WGKBfXyHKdTXRt
         G6BA==
X-Gm-Message-State: AOJu0Ywa9CbiBEd244MF0DpwrAeDXsQ2t9q1xgFuefEgm/akAwvKPzw0
	atEzZxd03UpKjt8qOM3VOt6lhP8Re7iUJAYaMSPqSLgzcg4ZgbzxWPou8g==
X-Google-Smtp-Source: AGHT+IGcwjy1pVsSiP+Kc/8/Z63xXnxaDkNIxmzhZRpFB0goaHOXQrRmPAVBo4rUhwGq69i00iJL3g==
X-Received: by 2002:a17:907:9712:b0:a75:7a8:d70c with SMTP id a640c23a62f3a-a80790118a7mr131782266b.4.1723021670740;
        Wed, 07 Aug 2024 02:07:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de47c979bsm487946766b.197.2024.08.07.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:07:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 Aug 2024 11:07:48 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl
 if available
Message-ID: <ZrM5ZKXwjKiWjRk9@krava>
References: <20240806230319.869734-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806230319.869734-1-andrii@kernel.org>

On Tue, Aug 06, 2024 at 04:03:19PM -0700, Andrii Nakryiko wrote:

SNIP

>  ssize_t get_uprobe_offset(const void *addr)
>  {
> -	size_t start, end, base;
> -	char buf[256];
> -	bool found = false;
> +	size_t start, base, end;
>  	FILE *f;
> +	char buf[256];
> +	int err, flags;
>  
>  	f = fopen("/proc/self/maps", "r");
>  	if (!f)
>  		return -errno;
>  
> -	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
> -		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
> -			found = true;
> -			break;
> +	/* requested executable VMA only */
> +	err = procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUTABLE, &start, &base, &flags);
> +	if (err == -EOPNOTSUPP) {
> +		bool found = false;
> +
> +		while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
> +			if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			fclose(f);
> +			return -ESRCH;
>  		}
> +	} else if (err) {
> +		fclose(f);
> +		return err;

I feel like I commented on this before, so feel free to ignore me,
but this seems similar to the code below, could be in one function

anyway it's good for follow up

there was another selftest in the original patchset adding benchmark
for the procfs query interface, is it coming in as well?

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  	}
> -
>  	fclose(f);
>  
> -	if (!found)
> -		return -ESRCH;
> -
>  #if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
>  
>  #define OP_RT_RA_MASK   0xffff0000UL
> @@ -307,15 +371,25 @@ ssize_t get_rel_offset(uintptr_t addr)
>  	size_t start, end, offset;
>  	char buf[256];
>  	FILE *f;
> +	int err, flags;
>  
>  	f = fopen("/proc/self/maps", "r");
>  	if (!f)
>  		return -errno;
>  
> -	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &offset) == 4) {
> -		if (addr >= start && addr < end) {
> -			fclose(f);
> -			return (size_t)addr - start + offset;
> +	err = procmap_query(fileno(f), (const void *)addr, 0, &start, &offset, &flags);
> +	if (err == 0) {
> +		fclose(f);
> +		return (size_t)addr - start + offset;
> +	} else if (err != -EOPNOTSUPP) {
> +		fclose(f);
> +		return err;
> +	} else if (err) {
> +		while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &offset) == 4) {
> +			if (addr >= start && addr < end) {
> +				fclose(f);
> +				return (size_t)addr - start + offset;
> +			}
>  		}
>  	}
>  
> -- 
> 2.43.5
> 
> 

