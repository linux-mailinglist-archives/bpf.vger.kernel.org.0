Return-Path: <bpf+bounces-69835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC6BA3877
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 13:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C495188F211
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9972EA48D;
	Fri, 26 Sep 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll6uU/av"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8D12DC77A
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887162; cv=none; b=FG3sZDYjrjtG+8jZcVVGB+6KmkKKJcYRc6QiD4k91q+9aDzdgq6TXC3vvRkSMvmHC10jIxFDZ2ghYykA/hdO+SnQaQTOOffR0rd1UAqWewZTDdnevTQIih7EmQPv5GBpOzyEh2z6EOx2yzZQ8ateo/S85scx4+ClWwgEP9F5dx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887162; c=relaxed/simple;
	bh=1id3B6Wi8UowOcZ+9wbUIN5SOAeHkmeYMI59q8iHO5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSD0fxEGlu3gA1xc3UJbahX4TvOjo9XWW3NNpFnQ2E8yuWLN9BPo3owvFpKqYJmxgNosssu2/0MbhiaSXne2xdkjCPuWRkXfOAec9rZUTKVp7gqDVKRJ05mWquxIR66707wxfuevE/iuM427qqoZR1y1pZD/LokADTi4geguLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll6uU/av; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e430494ccso593275e9.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758887158; x=1759491958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=Ll6uU/av+Ge0JATEo5UOB43rfblcW6cu25/o0MaObAe+0XIhhQs4bBYquvjIHbNLa7
         p9QRu7D3yBXj1pPfLghj5n0qP5PLjTJATjRcLMLQLOnd9yJUq9JTdGtOGymeMn/HwH8L
         59x8jyn9+ev0h8mK0QggDfEzzehzqskdvTgy+SkePYX4tnxErGNMnJ2PnKnBRJgASVgv
         OuW1FapW10KGSS7unHRlWgtrX+pBkrNxGCWz2EpVDkWq/0wZ3kLywJEb1QxuNXRWaj+J
         ZR0MPIsRTPyA1gSVJkUcbeUfblHTr8PfszIieNi5wIV7DjV5E3NViCBEcLCFwEj6fl9O
         STyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887159; x=1759491959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=vau6BvsPY60sJBY1hcZdmSZ8qJ1Hs217mnNqzwEPpcLC0XoQ6vl91uZcDtO49DIoYt
         1jqU6U03W80iAj+/D3Jk1YzuNn4sxNkBNpszjXyg2gah23t/nYIa909J5g7K21F9NBAc
         n/ogcl6SbF5bSefMaR9tZioFNNLnOsqtLMtTmKWU9+AdtsVge+7ureBEogx/4C66s4NI
         w/yQtY0ZsTnAriXIwldFa+kRu4oyR7mqnZoTq8PAAB8lNy9HflpmTysLPb7mw+AQMnNZ
         Pu9YNXhe4+KjRMXW2Mtf4Bf5NdTDMkZJ1vooDSPnXhPnZr2pQxnkYlUvKlfl+3rETx61
         g1lw==
X-Forwarded-Encrypted: i=1; AJvYcCVcAZefGEszJ8Yek1CdhROa6ZXMcbsk4tWOnMCKZRb4tPfIEV5ypRvkw19/lsusSSb0w8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09a7rKwyoD9X0wySjkvydYTbXtFLSNk9xvczRFhA9PgIlppbE
	nv1RxVTrQGh4nKEYe7TUhJnvQNOqgdS4GkV7t4BNcqzZ25enCWJBZi+N
X-Gm-Gg: ASbGncvKZ1jQSRhBYXxGO4Mf7boPyv6EDyZRLmiH5TPJtSrMu4mhKbBHUmQwMV4RUAk
	8oFmsvNvwR/dEfYa7g+Ayoecm057MC23tceOJRB7JuzBKh5hDVXkLdbQRJZYkGnyCCoKwHBp20i
	I8C9cv3rZKf+EDEOla0SqEFGQIjF235wfF0RsTalGA+GeuZb3H4g8Lc9lRxRmweneO/o1HX6pZa
	Jmhv+YwBNNusrUEYcT2xR7OlbG++QwONMj1m8akX3BgFWQtyR07gO9konAtgZxa6tzGS0JHZOqG
	9ZERw7p5wLK2J9p6M4Hg+BMu5IhvmX2kXwlsg0ZQgtyFXZ0cdgCBHwmqZ5gR4SBf5wWsSs5Ebxc
	raq8yAAPlKzVtR9pRuMluTmB5FINwrc4AdQoVkXt7CTSljk2h9/DI0LzH6R61wS8d
X-Google-Smtp-Source: AGHT+IEPTFDb685fmiqtI/zbxG32d7v3MRP+VRk71KQ8OOHsQCWx3c0SFbrsAeMCnBPznWcIWNgGnA==
X-Received: by 2002:a05:600d:15a:20b0:46e:1e31:8d06 with SMTP id 5b1f17b1804b1-46e329f62b4mr74383735e9.16.1758887158355;
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm37380245e9.5.2025.09.26.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Date: Fri, 26 Sep 2025 12:45:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 linux@jordanrome.com, ameryhung@gmail.com, toke@redhat.com,
 houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com,
 isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz,
 memxor@gmail.com, vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
Message-ID: <20250926124555.009bfcd6@pumpkin>
In-Reply-To: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:23:49 +0100
Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:

> -Change all the source files and the corresponding headers 
> to having matching sign comparisons.

'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
The only real way is to change all the types to unsigned ones.
But it is of questionable benefit and make the code harder to read.

Consider the following:
	int x = read(fd, buf, len);
	if (x < 0)
		return -1;
	if (x > sizeof (struct fubar))
		return -1;
That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
doesn't generate an error because the compiler knows 'x' isn't negative.

A well known compiler also rejects:
	unsigned char a;
	unsigned int b;
	if (b > a)
		return;
because 'a' is promoted to 'signed int' before it does the check.

So until the compilers start looking at the known domain of the value
(not just the type) I enabling -Wsign-compare' is pretty pointless.

As a matter of interest did you actually find any bugs?

	David


> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> As suggested by the TODO, -Wsign-compare was added to the C compilation
> flags for the selftests/bpf/Makefile and all corresponding files in
> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> carefully changed to account for correct sign comparisons either by
> explicit casting or changing the variable type.Only local variables
> and variables which are in limited scope have been changed in cases
> where it doesn't break the code.Other struct variables or global ones 
> have left untouched to avoid other conflicts and opted to explicit 
> casting in this case.This change will help avoid implicit type 
> conversions and have predictable behavior.
> 
> I have already compiled all bpf tests with no errors as well as the
> kernel and have ran all the selftests with no obvious side effects.
> I would like to know if it's more convinient to have all changes as
> a single patch like here or if it needs to be divided in some way 
> and sent as a patch series.
> 
> Best Regards,
> Mehdi Ben Hadj Khelifa
...

