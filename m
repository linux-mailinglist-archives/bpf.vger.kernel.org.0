Return-Path: <bpf+bounces-59191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45763AC70F1
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124E0162271
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD728DF58;
	Wed, 28 May 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mPrPz57+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45620CCF4
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457131; cv=none; b=JeGCWau3qCDoahLBDlJauKQN0ue642rIJjuFe85m47M1Kn+DVl6XezvVYSM/q8lRBG5zxa7LAk46M4FTfPPAVGs0GS0PmnoLUto18LxrvXnqwDj/403USVHqDB2M34Jt1zDXNg0/Hc/d+O0BBTAAzo/Lye8TLhM0Eg/Oqy1NvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457131; c=relaxed/simple;
	bh=j6Sexigi7Ko8moPzmdhRrHMZjcpmS5XcMWzEaea4Ivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKLZLk0js2cWQORvXS2YHbn4wHXBWH/sYlGOPZ6nMMv3zwdy/zV2ZOErMV1n9ihbfgLZLHqpmWDOSfqDO2P9e3X9zMvfvaUhZmMhmjwTQx2f/4RBfPzkfR4dHFJgIH6LCRzp8LACpjrrrsMHOsNJYd+LOdc5dcYhzUiD8IG1New=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mPrPz57+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231c88cc984so223025ad.1
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748457129; x=1749061929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSXXxUU0J9wn1C2a0Hb2G3HBJn5qgVk3D5sCsbBOtWY=;
        b=mPrPz57+xsZkqxYvcGK/e6GR7BikkRse3aibLL3zI0hqsnkPZgWsOMoBU9CzUsY9Rt
         A3zMq0aRUIOCt9zrGJodKznjCCndlJ0AXmBvqMXWHY2nxB/h4KUPX54j6OWDEzwM2sQW
         RG6wTyBQLmGgipastNfdcDdtFqn+poNWZq+TnsBZAIpAk4wJVEJGtP1E0TJ3aRLOs7cX
         mMdEX6nVQtvulwPCHjZUYEnaCTNg7uLOMYwASFkQQjmvaXy1t2stAAYY9D9CpUDgF7zy
         8byxANbDWbirFSG/RCVtg1KyHPiKLcXU8JSNd6mQSwPHaL/Nn98uaWwQpH/tZ7LUxSAL
         rFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748457129; x=1749061929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSXXxUU0J9wn1C2a0Hb2G3HBJn5qgVk3D5sCsbBOtWY=;
        b=qShAUgsVQRSq3msB+xjJycmBs1qNvCqeIb2V4sDnNrb2Nde30Vr/QRcM/P7nT6Imsv
         EXPHBG8BfYKlpzfKhNEkPkGVqqhr/5WWPSj7RIv0lemp2y/0IIm1nQDMyNlH/sX8Xp5s
         K8ucqI9nqe1firm8vZJJjlCWF9JXuakOAX6zZ0pAj0OFix+ssof4eSH9xKGF+QKBkFAv
         pMnpMalBux8LKklWH4eZox5rPDhVkrxMTd7exGydjsqFluaGOD/gVxDrbPZ3FbJiwo97
         G5BGXIWkAFwyZkUfyWUxEOuyv1ZV/TywLdDj74xVq5v3RUOt143T77v3SYxvGQ+0PJeO
         welQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6oqc9UtNKZfLxJMl4T6rGzrvW+nMgPa1MSNhV/ZjRmPkOJ8qPsk1hFSgU5VDbZWZmP58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYZHzv953nns/1bOilv7plVkxcF0c9o1tXPPFjblLLRRMnGbh
	NfQX8U8Dj5sxYmVc0gjSXUd07l9zWeyBOoeA4uF76+xOM/xh0k7ytqNfJfxVz69leOA=
X-Gm-Gg: ASbGncvDUeGZtISEOZ+EQCLgMBn6YuxEwsqOh9EMDZDbtmEfex+B/QAYOwIZTuhJpqV
	TZY4WY+Ogf9+YfR4bhyNxrJFFQ8lfqFOzTlkSv9pGZG3PfXBeg0NSTfQ8q1MOWRN1fnkqjfK24E
	9Mw1wIYTJ8TvTXVOv3syzlBAmR1OCQUPl5vLqgDC51ZcXBTNdaEJgzQtzLzOra3P132WnYGHM9J
	oSyUmkCIkTfb5Zx773aXqIYqjymOv002o3yodTWJQd4J9S3tuBDE2GjMU1Fl3IYye4l/5B4EStI
	fLKWn8eSAi/K4C/6Kfwv9mcSSewju4cMG6LWRA==
X-Google-Smtp-Source: AGHT+IGIvTZszuSKTVNXSfZS/0V+U2FZDA/JF4Wke2bpKg+9jHyjK0gIBkU5hxpFhN3ydqkarK4Hdg==
X-Received: by 2002:a17:902:ecd1:b0:234:ef42:5d52 with SMTP id d9443c01a7336-234ef426080mr6415835ad.6.1748457128699;
        Wed, 28 May 2025 11:32:08 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:3166:3eaf:6a29:60e0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2dd18dcsm15077255ad.0.2025.05.28.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 11:32:08 -0700 (PDT)
Date: Wed, 28 May 2025 11:32:06 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 10/10] selftests/bpf: Add tests for bucket
 resume logic in established sockets
Message-ID: <oqnwzaemu6agvwqt6vgcjygklzhcvxghbzzi7x65dqapzsjsxh@rif4xe655t4u>
References: <20250520145059.1773738-1-jordan@jrife.io>
 <20250520145059.1773738-11-jordan@jrife.io>
 <ae95a774-2218-4ddc-b2e0-d7bac2b731fd@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae95a774-2218-4ddc-b2e0-d7bac2b731fd@linux.dev>

> > +
> > +		close(iter_fd);
> > +
> > +		if (!exists)
> > +			break;
> > +
> > +		usleep(100 * us_per_ms);
> 
> Instead of retrying with the bpf_iter_tcp to confirm the sk is gone from the
> ehash table, I think the bpf_sock_destroy() can help here.

Sure, I will explore this. I was a little worried about having a sleep
here, since it may introduce some flakiness into CI at some point, so
it would be good to have something more deterministic.

> 
> > +	}
> > +
> > +	return !exists;
> > +}
> > +
> >   static int get_seen_count(int fd, struct sock_count counts[], int n)
> >   {
> >   	__u64 cookie = socket_cookie(fd);
> > @@ -241,6 +279,43 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
> >   			       counts_len);
> >   }
> > +static void remove_seen_established(int family, int sock_type, const char *addr,
> > +				    __u16 port, int *listen_socks,
> > +				    int listen_socks_len, int *established_socks,
> > +				    int established_socks_len,
> > +				    struct sock_count *counts, int counts_len,
> > +				    struct bpf_link *link, int iter_fd)
> > +{
> > +	int close_idx;
> > +
> > +	/* Iterate through all listening sockets. */
> > +	read_n(iter_fd, listen_socks_len, counts, counts_len);
> > +
> > +	/* Make sure we saw all listening sockets exactly once. */
> > +	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
> > +			       counts, counts_len);
> > +
> > +	/* Leave one established socket. */
> > +	read_n(iter_fd, established_socks_len - 1, counts, counts_len);
> 
> hmm... In the "SEC("iter/tcp") int iter_tcp_soreuse(...)" bpf prog, there is
> a "sk->sk_state != TCP_LISTEN" check and the established sk should have been
> skipped. Does it have an existing bug? I suspect it is missing a "()" around
> "sk->sk_family == AF_INET6 ? !ipv6_addr_loopback(...) : ...".

Agh, yeah it looks like it's the "()". Adding these around the ternary
operation leads to the expected result with all established sockets
being skipped. I will fix that in the next spin.

Jordan

