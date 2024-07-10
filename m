Return-Path: <bpf+bounces-34411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9992D6E8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02FCB2D726
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02C5197552;
	Wed, 10 Jul 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TXq782N4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C8193445
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629368; cv=none; b=gZlW1AMibyn/2DhoYp2pTB3iuLLNrY01UmbVs2s/cBPNe4rzepAkZLMZFCA9rIaphy0roeUXL/hMhy8zm1s35b6M15N4NXZz7WGGpB+WQP2gw9MCN4kS3AtU+PMHESkLlPsf0Ah4nO2T2VmxE30HGpnS5RherJ5JnELyGSA0aJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629368; c=relaxed/simple;
	bh=AmY7/0Kx5MgGmOlXPK9ZhPz0KG3pwbKkQWq8KfClfAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M+JS1GyBlyn3lyOv0ATrWAJNqcZdG3w4Bymhv9K8CpRwm37pDmfnYqrz11mAEobQQC28+jCCJT/pqdQOQNjFVWL12id579k50dfjeOEMNBXBy9XwPmyQh7oRcTJAfex/ZfEJjtkhVu0CrqN3Kbqs3pnR2sJ30Xyu0rNLplZ68NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TXq782N4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so42802005ad.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1720629366; x=1721234166; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAyPmOUdsLd03mlAddpRof18UDE0qDKzzkyVj4fd57k=;
        b=TXq782N4GvwyHd48ipHsDO3etE2d20/+V5M6qIka7kkntUCKxBAxsK+tdiolSMOVgA
         glcFBqoe4UXxI1AFXNUK4fG5HSp4ggXEplqxx4qGbl8TUIbeXns67Y2JGInI1hKDh3Ul
         Lqjf87pK4l4lP5/T3Zg6573aA5cqoydHj8GkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629366; x=1721234166;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAyPmOUdsLd03mlAddpRof18UDE0qDKzzkyVj4fd57k=;
        b=C4lcHnVgOjkz4ZlqqNKjwtzuLIoyDxEroyYxnCUrH74HlppX5txxhf/IoCaPk7nARZ
         uOvYHYZ5fzBaLA9eXfYSSUqmkf4ke3XmmV/3V0gCjW5e2FH5xTqcQawh5M9gTypsMBBa
         pKDVlOqShnDBC8kAnIUBbA6m66JebbZjj4G7/ddlF6pBta7p5t9Eg5fyootgtNLbS+Wy
         8b3lowi+L+pZq2jfATPI88l85B94zi1CpfZWzpjFHS43rtCyDq9nvqjyICX/inDeYIcU
         Xjh7KDLLNkM5Xp+ozxKpGszU+Hprv0daAabgofJPPAFyQhWzn3IQ4ywmFAwdXEE8HcD4
         zbvg==
X-Forwarded-Encrypted: i=1; AJvYcCX0rQSIBgiDPLs92jl1tuIS6eY3b8Ln4W/72g17iiDcBmocDH7f4NKpXqv/EkVd22BInn4cuDkLq0Id79OCFrdX6CVP
X-Gm-Message-State: AOJu0YxsUOT8GxDqJ1CYTcbAgqpUeyJkr2kqzmUCoGOIWojLN4O/FVSJ
	T8SR+VNDru+KL5ZwRjn6n3pmCrZr8Zo2uByf4QUrxkMzKpFCcf0J6GUvGcWgSjk=
X-Google-Smtp-Source: AGHT+IFSu03Qqw8EY48ag2gKY7v/+/XrSg8iNnofNUiIjWSb3EZMr23XoXHhqrVrkqdA19mx9qnCjQ==
X-Received: by 2002:a17:903:2344:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-1fbb6d34b18mr54539825ad.4.1720629366052;
        Wed, 10 Jul 2024 09:36:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac3111sm35614245ad.212.2024.07.10.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:36:05 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:36:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: me@kylehuey.com
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
	elver@google.com, jolsa@kernel.org, khuey@kylehuey.com,
	linux-kernel@vger.kernel.org, mingo@kernel.org, namhyung@kernel.org,
	peterz@infradead.org, robert@ocallahan.org, yonghong.song@linux.dev,
	mkarsten@uwaterloo.ca
Subject: possible bpf overflow/output bug introduced in 6.10?
Message-ID: <Zo64cpho2cFQiOeE@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings:

While testing some unrelated networking code with Martin Karsten (cc'd on
this email) we discovered what appears to be some sort of overflow bug in
bpf.

git bisect suggests that commit f11f10bfa1ca ("perf/bpf: Call BPF handler
directly, not through overflow machinery") is the first commit where the
(I assume) buggy behavior appears.

Running the following on my machine as of the commit mentioned above:

  bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] = count(); }'

while simultaneously transferring data to the target machine (in my case, I
scp'd a 100MiB file of zeros in a loop) results in very strange output
(snipped):

  @[11]: 5
  @[18]: 5
  @[-30590]: 6
  @[10]: 7
  @[14]: 9

It does not seem that the driver I am using on my test system (mlx5) would
ever return a negative value from its napi poll function and likewise for
the driver Martin is using (mlx4).

As such, I don't think it is possible for args->work to ever be a large
negative number, but perhaps I am misunderstanding something?

I would like to note that commit 14e40a9578b7 ("perf/bpf: Remove #ifdef
CONFIG_BPF_SYSCALL from struct perf_event members") does not exhibit this
behavior and the output seems reasonable on my test system. Martin confirms
the same for both commits on his test system, which uses different hardware
than mine.

Is this an expected side effect of this change? I would expect it is not
and that the output is a bug of some sort. My apologies in that I am not
particularly familiar with the bpf code and cannot suggest what the root
cause might be.

If it is not a bug, can anyone suggest what this output might mean or
how the script run above should be modified?

Thanks,
Joe

