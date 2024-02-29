Return-Path: <bpf+bounces-22992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB286BFDB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 05:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05860B21058
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 04:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7B3771E;
	Thu, 29 Feb 2024 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbc//W5M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01811C3E
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180682; cv=none; b=ePUA7xy63msv3szPT4KM0dM8WO6HipZcDWPG1yczrzYwPYcn4/RnZNbXGmcmXO3az1XowZnH6zyqepkXFClEYONtlOadU+0JTwgQ1yNbXFTARd7uw6wnsUbdBRy29IvEfRQWc9yNm+4T20DXHtf2lQO+Mh1qoZgGlxLRcEbt3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180682; c=relaxed/simple;
	bh=E/RYNDKIHECuNw4Qno6FQ2jLz2OYbx3Rt9I5t3aNv6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M0TZXtq37d1MXowIAMwjYSWfgkxoycoUAmcP4vWtutuG+fRHMFkUZL5jEqtOE+vhKJo7Ca4brnFPLuPyJa5/q7cld7gasWkg5R8ketKz0lr7HTxLENgzF24vsZmCayzZU7u8rnpOP/sh3hfUtIDjoz6B+Zz86D0nvT70RMENjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbc//W5M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc9222b337so5473305ad.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 20:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709180680; x=1709785480; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Za8L4X9C7Xd2DTdOCAYybOoTBPDFbxVfLbRmsAPhXkk=;
        b=Gbc//W5MWqH4VB1TPjmORkWE9MO4PhhTZumPf6FecAp2hU+ygrN9oam9US6wHNP9di
         s42m61zULKpEm3xilCGfpfYHil0OmWBbEyPowozXNJnlcl+NQ4qtX/oBhRJmBRnl39a8
         oFC6u5eefzZHz/1Ls2TGluwfelytsIDMo5ZwNshj8nVlNdoMsNvIj73+sxrqGMg1qZd+
         z9cuFRK6ic2nNm+gIe0QUVMMzBicyZUDVpClnPClOZhQRzoiwGtVfUf1H1MPvCLbgQvk
         1Nmgrd5rzq26YcvSldq+OrBe3NhITxleTJJaOZCmeq3QJ8wG8F0HvkOHY2uvsYiatyeP
         DcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709180680; x=1709785480;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Za8L4X9C7Xd2DTdOCAYybOoTBPDFbxVfLbRmsAPhXkk=;
        b=EHbCex8hplInRes5u3moU8PyWyS1nale2mPnUsaR01/wmtIm5ZK+RuuYpcqrz3wCWT
         NsAsV6jXUTKhl3DBapscvXXM41DETbAswuX1iN4Z3SjVJxYRIpu2TwVbTfWeq+sBpJBY
         VxgP3Bm9mgPb3vD0q1EddTX6d2YnhZjD8M3HX5IJsWvv2eAoWjR6c4rIkK2JAqd6UbEi
         hcox/Y1Sb8gnKgtDrgQ7WbwuHjHjsLYNSL337s29iaqJSLmI4ZnV1GNG94EV1pOsrdWG
         YbZX3H87TUNm8udLjG/6pR9P/8O033WY3snJFJxH5ODU3zxePZ23QG2xk5lCZ8FxL2Cy
         AJhg==
X-Gm-Message-State: AOJu0YzwquA7m2GvDf9nPk1sFQvD+mIq3diOkHQvxz3sHgg2lFo4S9f+
	yXpZJb4Y88o12lQyvsJLYChZlSp5ZWQP9PerZ+6aJq97fAF3oapOJUtn9rDS
X-Google-Smtp-Source: AGHT+IGSC1HSpfEPCqpFa9P9K4Kj5/IsmQwd5PcFkjAj0IcukOJ7zmEY21iOS0AK1f5InGUTP7AhDA==
X-Received: by 2002:a17:903:11c4:b0:1db:b8f9:ea69 with SMTP id q4-20020a17090311c400b001dbb8f9ea69mr1125521plh.34.1709180680071;
        Wed, 28 Feb 2024 20:24:40 -0800 (PST)
Received: from surya ([2600:1700:3ec2:2011:4427:9895:3bb5:51eb])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b001dc9893b03bsm277973plh.272.2024.02.28.20.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 20:24:39 -0800 (PST)
Date: Wed, 28 Feb 2024 20:24:12 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] development/troubleshooting workflows for BPF
Message-ID: <ZeAG7EYG/JwFEYg2@surya>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Building upon the learnings and knowledge of BPF CI [0], I would like to present
ways that can help developpers make their workflow easier, and improve their
development and troubleshooting velocity.

While there is probably thousand different ways to get to the same result, and
people may have their personal preferences, I will be presenting an approach
which is close to what is used by the CI.
Feedback and suggestions would be greatly appreciated.


Some topics I have in mind:

- Reproducing CI error in CI environemt. Until recently, it was challenging to
  Re-using artifacts produced by the CI, how to reproduce
  the issue within the CI environment, and poke at the system.
- Building and running tests for a foreign architecture. Method to cross-compile
  and run tests for a foreign architecture.
- local development workflow. While most people may already have their own setup,
  here I am proposing a workflow which is simple and allow for fast iteration.
- bisecting issues: leveraging bpf selftests and vm testing, how to leverage
  `git bisect run` to "quickly", or at least with less friction, identify a bad
  commit.

Thanks,

Manu

[0]: https://github.com/kernel-patches/bpf

