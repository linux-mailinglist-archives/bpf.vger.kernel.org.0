Return-Path: <bpf+bounces-61880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B78AEE6C5
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 20:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F43917F74D
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087A028DF29;
	Mon, 30 Jun 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuTppgi9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938782701B4;
	Mon, 30 Jun 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308308; cv=none; b=ri9qGVnICLuudhRiWLa0lECt05VopuwTZXtUgfrXV2mVqzz+KC25ZUoRL8Xqdo8puSlhl1FQx0VsJM7WeXT/WTEby+1ZTYZ9nl52cYPNgTCpr/l1YvoCbnP/zKZiBKbqgRvy9Mrm/RRVC4ssC+ur8W4FV1unoxdbYnTRM1ZgSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308308; c=relaxed/simple;
	bh=YkeKUPA2VUlpURmZgKZCnovpOlEdwbP0hGreTU4yYR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOT+/XYTxpbtBVR5v15vlHQ+0QFK95t5gLrMcE7ANjFNxTz7RABdNl8zrntYJjs3Qcpa51HcKSRH0RwJKfftVFBI3A28RFI2uIrQOCTuKzTWu88XpE8+5TKHObCA6oRe7geBkw8Z0WXVTVn7sz+PjPTmZt4Tm3DJnidY31Al0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuTppgi9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31befde0a0so1862281a12.0;
        Mon, 30 Jun 2025 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308306; x=1751913106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPbSp72M+aQKSiq9oao3xc500r3O82mDwDlhbCahr3c=;
        b=fuTppgi9z+qWMp6IX/XX+6A0XbtTMEvP9zZQRKlLFyLaENAIPosCelTWhXKao2RHh1
         +8cVAwhDD1SqD1pDhvoO1zfgYDWrw/GRTSHkKL+8NYg8jrXWcWzc4T/JZAy6EuqjRGDP
         nnlsO0sEKDlLaNLu0UQEDbehkQhQes3bZK7E1doKzUm/Re7xqXeUdy9m8WtkINBBt7e5
         jLUQXie56zY6D3JVQBqE9CSiVjk1j/YIA2dTW6ss6YYvgcF/eUFy60e/QeKwQYp91wbK
         i05glb1ti5tzG5FcyXVHPbIOXWKXMx0gsS5g5YXYPZKa4i4YnipRKqnc6wcExg757P/a
         s+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308306; x=1751913106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPbSp72M+aQKSiq9oao3xc500r3O82mDwDlhbCahr3c=;
        b=pbP524IvKcsVs0f4IZionsSmmXq2PaVfZWr2oz+ZQ9Yr2+/rs5vvugvR8HR+1Wl6oS
         tYJAL24viS5FoJsJV9kt5a4PRB0zRk8nogRh1mTGzM9aWY/Q73SQcimhXn8Ocl549dZ4
         s8y5BTDhFRMkKsn8ZIBseJd0h6gYK/lQ5YXOX52ZwJpqCDWTbnSdcJui49POrT9lpQmy
         ck8hudyPEi+esTO8covv1y33pVe59KN62zUTWG5N+5m0OCz28cewfE6NDGp+SmKvvDpB
         dkHMnjyeOXVCatwQDt7kzngzYX+BumTpB4rNMIQHWJfKg8qtfU+S4Ya+V190GrDE/AQu
         zxqg==
X-Forwarded-Encrypted: i=1; AJvYcCU82TZUV9S6hlUyHgdDX9PMmO+4SN1PlKeGBXxXnJqRzL1Biv25PaRj0Rw+LtGjrI70gLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaxdBLKxHmcHtavjgfQaxIUh4D81aesoh+wjoIc6i+OFxt6WT
	/bfvpuRTYR+Ra0DzqcdyRY1JFTwZKezz7nu7LPxClGKsXu8FMxQgRj4=
X-Gm-Gg: ASbGncvDLqk7sUt4Hg3BIZHoO5hC79/gbxLZRdH9BoVOItqrCtyyJbKtj61hgiH8Hd5
	9cwCiyMs+rOb6qxZ02t1Y8TpV82pSneeyfD0NPnOiIRbj+KMODg9mEBb51xV5U5H0r4DxyUwrYR
	FQ+iXVYuiklpKvo/63ax1CQDqkrcjW/xhgCY9iiJY9Qylclnr8oMFZc+7+T33y/jW26x2irZvuu
	C6z+Oqgi6TYKyKWgWDPdyzhT6JlL5onOn5OELYszDoYsg3+JjbdmX6wZZacwZ41J60i+yi1QElR
	6jdHCxsY4IezN5u7HQf4EGK+pmTNEQp77PED3UrLNPxjEP/rhseTf7ljAZ9jokwBs0oBtFfkCAd
	XJt86EeGb3KNNYTkeWnD7bV9oUX2XS0WhkA==
X-Google-Smtp-Source: AGHT+IHIt5GC8AjbY5jBO94jKO4btsCvA9qxc3QnowagAO2ZuyD8Uv34JlLCDQeqpQkCtNLB4CvfUw==
X-Received: by 2002:a17:90b:37c4:b0:312:1ae9:153a with SMTP id 98e67ed59e1d1-318c9258e87mr18193435a91.25.1751308305650;
        Mon, 30 Jun 2025 11:31:45 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-318c1502b9bsm9817901a91.42.2025.06.30.11.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:31:44 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:31:44 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/12] bpf: tcp: Make sure iter->batch always
 contains a full bucket snapshot
Message-ID: <aGLYEBoBk6BI3TPx@mini-arch>
References: <20250630171709.113813-1-jordan@jrife.io>
 <20250630171709.113813-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630171709.113813-3-jordan@jrife.io>

On 06/30, Jordan Rife wrote:
> Require that iter->batch always contains a full bucket snapshot. This
> invariant is important to avoid skipping or repeating sockets during
> iteration when combined with the next few patches. Before, there were
> two cases where a call to bpf_iter_tcp_batch may only capture part of a
> bucket:
> 
> 1. When bpf_iter_tcp_realloc_batch() returns -ENOMEM.
> 2. When more sockets are added to the bucket while calling
>    bpf_iter_tcp_realloc_batch(), making the updated batch size
>    insufficient.
> 
> In cases where the batch size only covers part of a bucket, it is
> possible to forget which sockets were already visited, especially if we
> have to process a bucket in more than two batches. This forces us to
> choose between repeating or skipping sockets, so don't allow this:
> 
> 1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
>    fails instead of continuing with a partial batch.
> 2. Try bpf_iter_tcp_realloc_batch() with GFP_USER just as before, but if
>    we still aren't able to capture the full bucket, call
>    bpf_iter_tcp_realloc_batch() again while holding the bucket lock to
>    guarantee the bucket does not change. On the second attempt use
>    GFP_NOWAIT since we hold onto the spin lock.
> 
> I did some manual testing to exercise the code paths where GFP_NOWAIT is
> used and where ERR_PTR(err) is returned. I used the realloc test cases
> included later in this series to trigger a scenario where a realloc
> happens inside bpf_iter_tcp_batch and made a small code tweak to force
> the first realloc attempt to allocate a too-small batch, thus requiring
> another attempt with GFP_NOWAIT. Some printks showed both reallocs with
> the tests passing:
> 
> Jun 27 00:00:53 crow kernel: again GFP_USER
> Jun 27 00:00:53 crow kernel: again GFP_NOWAIT
> Jun 27 00:00:53 crow kernel: again GFP_USER
> Jun 27 00:00:53 crow kernel: again GFP_NOWAIT
> 
> With this setup, I also forced each of the bpf_iter_tcp_realloc_batch
> calls to return -ENOMEM to ensure that iteration ends and that the
> read() in userspace fails.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Looks more approachable now, thank you!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

