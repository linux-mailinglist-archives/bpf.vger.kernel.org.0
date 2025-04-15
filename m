Return-Path: <bpf+bounces-55911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E01A89051
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 02:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A9116E775
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0CE1798F;
	Tue, 15 Apr 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Pi7YOLJE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578384A23
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675461; cv=none; b=JLq9bxwElky3k8jV5q+Umli4ycBD3ykqmC3CQeCnjjH+bRARbbGa4cps6LAJ0AhnKq6gdfvRBeeASy01wab3JAoaduKAPwgNdYEjGwnfFiIZkoiyFiwhbdjN0IozfHOQf1RPp0LGxMmIZBQ2t/20+VT2gtvDneuvxffEwCSzdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675461; c=relaxed/simple;
	bh=PS719wBQYAW0LmE7NqcxyxUPbjHdJgEVyJDECQFpzqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSmHn3lbY0yqBb8tyVtOQVfPtBFPWiVQUV51MQtdE1zdSDSQLL3JbPRxanHEE0zRx1H9nzkyLGCUPCTFpxKNEh3kx2iyvJhrddAfuZt65/06uRyOjiqhAb6HrJeqt/3xEwwpqlr+aHAjYu2NOz5R141yKDzAfZhTlQNk6lq04+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Pi7YOLJE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b03bc41695eso591008a12.3
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744675459; x=1745280259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9rKcs9i0K6VnxdiF/QNrlfIo4o35VZi+xWyIIsDano=;
        b=Pi7YOLJEjEol/SNoHJ5yMq78/fxmkKSRS+tjmSsSzoseK8edIGO0XNIhsGvT5Tyoxk
         uDwcnc4WgPH5gckVTq2F4G+IMqFJrafz9Qjjd5I2hSOAWUG2MolPC1fIJHnjFPq855Hf
         Y7RnhI14MljBUJNouZLkq7NtOP+YcBIWyj5spUzThtiZACoe50p5DT5KUfwuHTLPksZV
         33fvLmiuE8VIxuXNxQU1muhIWbstx12SHWXhvfaJnejISPGX0wMH3Z1LkvxsGbxb/tvu
         4ys1fRmAkVTA6vXnq2BsOB0aLrC+AOweJ57PY/UoXmyJKQjD1BsSa3Y+xvH+46r6Qyz8
         Sdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675459; x=1745280259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9rKcs9i0K6VnxdiF/QNrlfIo4o35VZi+xWyIIsDano=;
        b=wpot94sOeb5BSrpfIATSvgXU0BuoRNqadmHK+TupkGQ6fe8MnqBi+pQFwlcXmHn0zb
         +nh26h3/reniha7QY2agN1W2nHGA4MAcO2WxH+Eg1IKQ2e+mcwxYiTr1S50Lqh1AkXE9
         l32U04JVmzxbuWzZ/01FRccls4/wzZpMOMrgXVydqxWTMTmvggBNXUqaIdZcfP1YaYJt
         p1idRzbdybwjJWR/V0obwOEZN9eSCNNJDYQ9QysXi3yTPY2tuPyeXter7wWBYg52BA8D
         1yH5BZ1ok6zE/leHElVaOsL0lWeZXi0Ii09snGpw9N57dJc6/H7jqbNNP9l9faq29jNo
         X02w==
X-Gm-Message-State: AOJu0YzOP57nD77hUwViKQeqb3TGexMqRzTCrO66EPwg8GJpTq8t9s/n
	pcg0K0q3ORnU6dITu2boaaoPngObc4OKp33oZTbkmoRSwIeTg1zyPUWOcoF/LN0=
X-Gm-Gg: ASbGnctnc72CIkpMEmdwiAUvfRSLVAKxadUAdLQZcfLD04AHIVgzW9+s2drLMWa1lEo
	eoKjncEUKlPT39A6csyuDHtZizlirce9CnUyZx45L1W3wWGP5YSdYSq9Oa7p2c6/07fdd2JTSip
	szm6Y+LpR4usMU/NvdCCMFhkin3KL2VnGAlhSqJjNyZNUdwfQrdayeUcrmFb67R4BfqN3/LV0jM
	OS9nejJukwyntiA1BQgby4jKAbI238ic8X8005wKabQ+Xk+sFQVhBdsTQ0CmRmRPR2e629JiEpA
	AOX6OL6OLfpfWOjDQ6e9PDdwF1EF1tXyhaRbzXpSLglJXFYXhQ5P3mWRiScBCj9+Do+BsSicK7s
	+C8l4
X-Google-Smtp-Source: AGHT+IG17xyjLQYSxoGHSzwwxz9HQWruNpOX+0byalfl7FguPA/0Kgk/qVoty8eSfPjWy4fsnd/axg==
X-Received: by 2002:a17:90b:1e51:b0:2ee:acea:9ec4 with SMTP id 98e67ed59e1d1-30823775b41mr7825282a91.3.1744675459130;
        Mon, 14 Apr 2025 17:04:19 -0700 (PDT)
Received: from t14 (135-180-121-220.fiber.dynamic.sonic.net. [135.180.121.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10e4c9sm13265068a91.10.2025.04.14.17.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:04:18 -0700 (PDT)
Date: Mon, 14 Apr 2025 17:04:16 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: Add tests for bucket
 resume logic in UDP socket iterators
Message-ID: <Z_2igISGVwL9yqM-@t14>
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-6-jordan@jrife.io>
 <315cc79b-fc63-4164-9725-8b5fe2fb27f9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315cc79b-fc63-4164-9725-8b5fe2fb27f9@linux.dev>

> > +static int read_n(int iter_fd, int n, struct sock_count counts[],
> > +		  int counts_len)
> > +{
> > +	struct iter_out out;
> > +	int nread = 1;
> > +	int i = 0;
> > +
> > +	for (; nread > 0 && (n < 0 || i < n); i++) {
> > +		nread = read(iter_fd, &out, sizeof(out));
> > +		if (!nread || !ASSERT_GE(nread, 1, "nread"))
> 
> why checks nread >= 1 instead of nread == sizeof(out)?

Will adjust this check to be more precise and apply the other changes
you mentioned.

Thanks!

-Jordan


