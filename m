Return-Path: <bpf+bounces-52630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532EA45C08
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 11:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5BB3A63E0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6187325D54B;
	Wed, 26 Feb 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOIOEQIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631D42A9D;
	Wed, 26 Feb 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566489; cv=none; b=E4onEfnujZZczEYZm/Rqzz8+HuwUYP2GSmxJPylHCWxZmlIEhgd1ZcHwq6T7zyg/oxajxyqL4bDU/zDeR9c1bQYA/XloUVJNNVhrkY1I7oNgMa1rZlt/0xZfZnrlDC1dUKsYGbRhm2nVvD8LYdAlpsZyc8UxbMZZcZ4YuwsE9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566489; c=relaxed/simple;
	bh=BSMw+04gEqWq3Msk3LXpsoriHTDgOv1NVpgVH9B4mzU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWgz+VE67CgWWIuAQY9QzG8QU9FHQlMQQpPCX6GDDRQoTqRlfdqV6l4gPnROFpyYNICdRDBThk7aGt2EmUAXOd51kahXTGNxhx5rW6MfdTO5ytkiTTLDWgGPEeE3XfkQDxcfmZb1fAC8vMy2RA5pjeT+UcQe566L7ktIQa2elWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOIOEQIp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so12360999a12.1;
        Wed, 26 Feb 2025 02:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740566476; x=1741171276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Szrg7Q5tkv9AIWm3qQj3ZI+4jNVtlGstTxdi9rRe2us=;
        b=gOIOEQIpS3B/Gq5rqyz+Y4oS7g2+Mk9NQW16U5L6kddGQs/lcnOptmTnWVAeLVzYbr
         0cCDXn/MeJfiKkV9hRvc5fIfGsrb4NO+Ab8TfVGIDp4cfsNl4EDXL6bcidcQ4IQixiQR
         YU3TLu9eWBXwnYjtdrd8i2NUGmCAiClKqmRutKt5R01CbS1X22fxy4n/tC/KqILsyRWV
         tLh0NwT7B9MCTk7gEgibuD8PMclGfGem0adexsV3dO7REQCTLSDvLK2W10QcMkyealqU
         zJDlZO+bp2HL64BmE7dZvfNiFOYsbKwrm7GRBpniv5FQJHDF29vARXdiPI7ehGfLAkKC
         XwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566476; x=1741171276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szrg7Q5tkv9AIWm3qQj3ZI+4jNVtlGstTxdi9rRe2us=;
        b=aoSlW+LIPDg0isZOpX9iwgp43VQw0c2Fg6wq3GCNQJYJ6SNmUmQduhiaUArCAYUvV6
         FFmR++et6mNjYRBk5qZYS6GdKaKlGT2Fy7ADlV3OzB4iqtTwCn4U0m7ZzfuEe9bn2cvD
         IJ/DTpa0zCBEYtC3QuCsD/VTNve52yDlg1fR6RssFl4qyi7T/1AwCqMQ8xnaEX7nhnkL
         grMFpmHDW6kMVqdP9jaR4QDo2Jdnt1/s+/M7m2ZEhRUTiV9nyONHerwPaVuyObYLh7Du
         oP5RPUtnBJ64SXplNDxdqDrQNcrGdok/EAIuqyzsep430XBYa9oLfYb+2Szd8b1xKg+9
         dhZg==
X-Forwarded-Encrypted: i=1; AJvYcCV0qCk7DAok8NTbXwoC1fTTsl+gxEaszYcxcNwzXOzMFMw2Le2EuXsEQhL4UrxdZiRtSZXP/x/gMSs2HXRI@vger.kernel.org, AJvYcCX7MXpJSLSp/9c8kQWQ3HHowyslFXQ5hfhBg9LURtb0JlUILUiatC4fi5ILV4KXAqLsJLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbkEe9Qrvq1/y7lMfmg6xdC+Qg/gM8EJg+trUSV7KqkMegqGt
	v3FzqSH0o4htX6BrqWrcm3c95FDhZCqkhXK4WSUulbVbOq6wI0v2
X-Gm-Gg: ASbGncuDczZRZoWajQdeBT7eArkX/ezSk05Iie2hLG0O3ddWz5LjvvOPuHjwVonSaed
	DNyS96niThmm8v4jz7VJOTm/FNy4dk8O/mGNzBK5GEo1/QNC70473wjZuReioqaEsXN1a+0QX+5
	TUjnEQzMYcc2s7lp9ZtQ+xqvVaINRV3o+EsSQAgYWbY21G6Axuy7gVex89ciXDJL9LMM88RfjjQ
	rx2KfuzWBjURwHko+PJCOPqRXZ3jEUXlBf0F/wB6QkvokjyeqpKbQBWAXddxV5ja570rpMURaoe
	+dS5uaOLqql1
X-Google-Smtp-Source: AGHT+IHH9F1IYBz1le8xW/KqZ54BHrkJ9A72amTbhME1pL0CzrJPPjM7s4jtPYMcv2g8PbVdUFENAA==
X-Received: by 2002:a05:6402:5518:b0:5e0:8c35:a137 with SMTP id 4fb4d7f45d1cf-5e44a2545d8mr6074759a12.23.1740566475856;
        Wed, 26 Feb 2025 02:41:15 -0800 (PST)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e492120418sm2189620a12.14.2025.02.26.02.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:41:15 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Feb 2025 11:41:12 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, oleg@redhat.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH perf/core] uprobes: remove too strict lockdep_assert()
 condition in hprobe_expire()
Message-ID: <Z77vyIKkLyliF0zz@krava>
References: <20250225223214.2970740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225223214.2970740-1-andrii@kernel.org>

On Tue, Feb 25, 2025 at 02:32:14PM -0800, Andrii Nakryiko wrote:
> hprobe_expire() is used to atomically switch pending uretprobe instance
> (struct return_instance) from being SRCU protected to be refcounted.
> This can be done from background timer thread, or synchronously within
> current thread when task is forked.
> 
> In the former case, return_instance has to be protected through RCU read
> lock, and that's what hprobe_expire() used to check with
> lockdep_assert(rcu_read_lock_held()).
> 
> But in the latter case (hprobe_expire() called from dup_utask()) there
> is no RCU lock being held, and it's both unnecessary and incovenient.
> Inconvenient due to the intervening memory allocations inside
> dup_return_instance()'s loop. Unnecessary because dup_utask() is called
> synchronously in current thread, and no uretprobe can run at that point,
> so return_instance can't be freed either.
> 
> So drop rcu_read_lock_held() condition, and expand corresponding comment
> to explain necessary lifetime guarantees. lockdep_assert()-detected
> issue is a false positive.
> 
> Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/events/uprobes.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index e783da1d1762..4d2140cab7ec 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -762,10 +762,14 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
>  	enum hprobe_state hstate;
>  
>  	/*
> -	 * return_instance's hprobe is protected by RCU.
> -	 * Underlying uprobe is itself protected from reuse by SRCU.
> +	 * Caller should guarantee that return_instance is not going to be
> +	 * freed from under us. This can be achieved either through holding
> +	 * rcu_read_lock() or by owning return_instance in the first place.
> +	 *
> +	 * Underlying uprobe is itself protected from reuse by SRCU, so ensure
> +	 * SRCU lock is held properly.
>  	 */
> -	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
> +	lockdep_assert(srcu_read_lock_held(&uretprobes_srcu));
>  
>  	hstate = READ_ONCE(hprobe->state);
>  	switch (hstate) {
> -- 
> 2.43.5
> 

