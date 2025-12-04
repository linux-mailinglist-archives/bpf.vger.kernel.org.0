Return-Path: <bpf+bounces-76023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D3CA2523
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 05:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A11D3022805
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 04:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658671E515;
	Thu,  4 Dec 2025 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgarnY1E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9821D5ADE
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764822890; cv=none; b=P+fF8pMhyWpGdbXFdJ4B0ZdmwhrXLAJuAVxz/nC5VJS25fY6ePFFtmVOJkcLXprgK8DSxaqYZ9jlZF4LyR813GZgZ2T3UeUkFFo8it73W6d41LCZVPdme1GT1PESBpScsuXr3gCvcpBQzKsjBZTJnE67Fu4zZa1d/s6XXP0VnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764822890; c=relaxed/simple;
	bh=GgCOziep81e/EKJzhQH5y0QjEZ56iWmp92jKRaM/sWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpO67dgU+qEClMUnfJERE5R3xMOkA0mKfz9/qA7+1JYqZGGt72cFIUoQv802f7J2oXts5jxbRI40Wocpo9bnC7SuxBJgLjR4/jtyoMonkPVasqKZhb/NExKla+f213tWI4Lcz3xJRm3kk5m5ehuqy8lAZNM14VT+Z0lvuRxTU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgarnY1E; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640c857ce02so425248d50.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 20:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764822886; x=1765427686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOhogF/bEKUSSSKE3BIN5Xdxnrm5TbeswyD2/DYOGps=;
        b=OgarnY1E7Gkjw/DevGDJBFY0b8v2+sb6MpJxurlwKQgaJGm7hQqQSZzeFiQT+/ysq/
         8m2dbJcKT4kXSHtXSXXSwmuitQuoIP957gD6fQT66xxlxaJ0/lwcnKaT/VU85TiaVNqs
         kffs+HgDrTGjeAEsRb83HDRkMtoXeZbfSlbhNXY+hpGNwAJTGXbQIFgJZPMOQWqTGG9E
         jjhiAY3KiDVr3YyDXKwKMMlA4SVbRNvC/MQjliUnstYCtSy2dAV9bMEUa6MR+AqGW4XJ
         NeTSNcXqijTCn1AZ1ak8FiT+dhg4dZ1M5oitgNZGdt0X6/EliVPeEPLoQLv8kTkLzXyM
         XIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764822886; x=1765427686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOhogF/bEKUSSSKE3BIN5Xdxnrm5TbeswyD2/DYOGps=;
        b=XmITunI/OMVtp+zPa3026OIq55ooPL1PfdXnTpU8gOYsLogZZ3Y6fONgDy5VePvrZu
         djtkcm2/z3viDlTDW00eI3dY2gebtlyPe94BpIMFF30UdV8otVvClDxyxxt6uZAUSIwm
         QG9xcTexbPgB/TO/sA6T7FtutPZvfO636hVI33wwF+uCXEGODjL/Rh4jUr+ptdD6dvN6
         bNHEwrxhCZuEsJVc4LSRpoSQiLLKYvvWU8GPGv2cv9pDXt41JF/hM2ci9XvA8NDBYdVz
         c7hnZvuUY3tKI/+n8nWMMtJLnkCSCw5uVdOt3v/ZgMeg69W5tvJkbi3rJEGMECL3Pyoz
         /gCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp2a03yhaWQBXPI6tt6pAH161Yf8UpGWTy8JPAfIcbQS3xp1SbvFBpgPZPtcLmvp+SUAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUD6CTpaILvMlauCmvI5AiGkXSUnsRbitI312xyt18282rUJn
	BcbrDNvgWJPlBPbL48ETbFzMa0iBS85JUmvcnwMStck9q4r+trJh9XBf
X-Gm-Gg: ASbGncs5kdCKmDwe+EUUN4+7/aRZ7spV4RQCs3W9dPCoaQSUUt+NfgzRmB6RBI7HwJ4
	lqbuqRc5yEH/78jZ6UW/1RFwYO3/r60qhHVbPlJ122jaJr7dOW7XVxAlG6QSyl5l9G1pG2Pd+Dx
	xDsNn/S6YFJc4y+nuDFZBB6uTrea4gU4rtl8PQqBZRi68q2KhvjYjtFRmjSPz6Yrblxgvb5EBkn
	EcJ+Wzp6dXNlMEbQ0YW9G/Vv0/88dZSZGcZvULOzvei8wuo24KMDr2yau3Rv4xWvnKkfXyNyuYi
	Oc1RFgQPoDukLfBwSND4B2F5TTzWbFRfwXlF1JmrlQ1LM2lKAxEovznK2HJDRJ8NFo3IVOfCrxS
	SJZdrw6ASraKQnovBQqMl/1tWvUCrXpnuIXArfVMBz9pElpaxKuxG/pPynEj70skgtJFHu2bXgE
	x7tvV52Zwi8te8pMUBxQqjaKuHeAayBV0KH5Q+0S8QTz9OBgImikI=
X-Google-Smtp-Source: AGHT+IEHsk9cvyWivHQ/qdx/M0oPC+5Tq8/rSqUEJ8fSJ/n8FLJKr7HCddCe5NH32qGcbWy5RlaPRA==
X-Received: by 2002:a05:690e:134a:b0:643:ab7e:8dd0 with SMTP id 956f58d0204a3-644370659camr4211118d50.61.1764822886420;
        Wed, 03 Dec 2025 20:34:46 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2abde8sm264191d50.3.2025.12.03.20.34.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 20:34:46 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	ftyg@live.com,
	gplhust955@gmail.com,
	haoluo@google.com,
	haoran.ni.cs@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Thu,  4 Dec 2025 12:34:22 +0800
Message-ID: <20251204043424.7512-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
References: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Song,

Thanks for the review.

> I don't get why we add this selftest here. It doesn't appear to be related to
> patch 1/2.

The regression that patch 1/2 fixes was originally hit by an LSM program
calling bpf_d_path() from the bprm_check_security hook. The new subtest is a
minimal reproducer for that scenario: without patch 1/2 the string comparison
never matches due to verifier's faulty optimization, and with patch 1/2 it 
behaves correctly.

> The paragraph above is not really necessary. Just curious, did some AI
> write it?

The paragraph was indeed generated with the help of an AI assistant, and I didn’t 
trim it down enough. I’ll drop it and keep the changelog focused and brief in v4.

> This {} block is not necessary.

I’ll remove that extra block in v4.

Thanks again for the feedback.

Best regards,
Shuran Liu

