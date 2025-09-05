Return-Path: <bpf+bounces-67658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60620B46751
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 01:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FB31CC0EEC
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776126B951;
	Fri,  5 Sep 2025 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZQciV2R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9354654
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116305; cv=none; b=DQYsSV67wHxFh6tKXw+txtvjzXFXTqwQpBqIiAB/++uXaCa+JZOkjOmeiYiAW4xsYdpMt2nvd/201LTcyQeNcEB18hMLen96dk8/bNW1Si0Je3N2pKusSOYXO7RdPAKzBO/21R/r8IhRJa/HJsJRqzF3ClZllCNFBI9tGxkTHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116305; c=relaxed/simple;
	bh=cpHY7nS3ZRDZLi/EfOrQo6H7BFsmIuMoBuGrhH2gzWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD/XynFPqmD4VmFJDJJ2GE566ghv+ZQ5I/pmvrMbK9zraCRtxIwrLDg/8zdpRnUrb2j1vDM4/NGItIW6ApL/+PUgpFlkAMK60hoVN9drkpLUsfPAIjiIPKKdsSGHguMqi066VWkwOZZTr3zzmKE53dTeRKb+ODtZdVNvzTMSzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZQciV2R; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cca557085so43435ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757116301; x=1757721101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpHY7nS3ZRDZLi/EfOrQo6H7BFsmIuMoBuGrhH2gzWI=;
        b=OZQciV2Rwk9DdASsw/CRrobksuuIhHNDHYP++gVE6VMEhRkZ8M7bw4VLTRyYCglPee
         N7YRBESPctQpqqOVHZjp8A2C/sRk1xCTpeW6f9egAFyyVvxUrE7leGzajtPG89zZeyKH
         IV8xdKZHE2e2FASd2woz6tKNEe4wc0wAmVM62CI9AcyZCvh1eYddLj5EobX6xDj5SLDW
         /C1FfRqktQxFszHVVJpy9d7+HDmburRYOOC0TIpCCeypkODzMW1zJi8AVB0DJgczFlY7
         1VnwNstpctB/ZRXpJC/dE7mzLs8opfWBQcCUMaiOLuF4d7yI0ymUZTtLyMMDSeKES11e
         yNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757116301; x=1757721101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpHY7nS3ZRDZLi/EfOrQo6H7BFsmIuMoBuGrhH2gzWI=;
        b=bi/daq/1hjdbs029brWhTGtsjgnY2J33ROnEsdLbiF7HrCCswBhZWg6WrrsT3UbGXA
         M23cESggf2MLKDrBBJLZiW69+0UTZjG69hHEVRZH2U2+ZuDoC/nyI959iH2Q4GcaqLQu
         OYzZf+jnRmds8Df5VQAqX4O5xxZLtSnOMVRWQmUdv+J5noWx1B7pB3R+vEm50+5sz4cv
         plBFhijij3Rv13Y4wsa9ZAl3Lfutz7YCQsisdwgv/yTUdCStROREH1lcjVDdnE8lTcKD
         9lY2TgAal9TJ4Qgivb/BlL2JF9H23+Bz5OCsi+IsqwyZF06CAGMH33BqG994ta6teSwg
         RqaQ==
X-Gm-Message-State: AOJu0Ywok0XiUp3Oj/BRboGbeUr0n6H1qOZzSFs0FP0A8SlrMbgT/yk4
	y6P5cSgnwt+xuJAwmg+E5LPWd5q/GYToo15WemO1yNPDXuTBs0L01COcCD7glWnP3jiWtsh0Wrb
	CvbtcvA==
X-Gm-Gg: ASbGnctngpLBm01Ep5xx2daylgfadoXZzGBquIic1HBKW3XY2InYXshIMmklfJx0haO
	RoZKoF1iM1W9nAZzQq9+KjnEjToTvooYInFY40PdwGGptXuTCQ3epEOvmC1m41fqn5sRzgy3/iC
	b8udvddT83tFd2Has+zI0gTXalL3CjO2qL1PqLS/l+IucQL5CkjMCyp8LoF75zDkpExcuxtWDLT
	02LD2lT2chpJVA9Ukh6t9JnFjMR4ldlFFkdHOjSNmfAYlvPfk/QcUR6WSAdYJnsFEd7Br1PpH7G
	B0AdpYXU9pBLjowbL1rmV2dDXlfKD2slkmWcs81tu1jbQ7B+aBz+o/rVpZKDbHwlJeA6v0nWuiD
	amcgnDfRt2GNX7jAVoAkr8nYv+QpujYZQxG0kalWvSSCMm+eGQP9L5N1KS1NGeMsiGe7/WjU4CH
	rBJg==
X-Google-Smtp-Source: AGHT+IE5aRmSY7hJ6R9oO1edsaMhtSPl2LmTbfHBqqh4DaNzLM25VwgGwUjEMYg9vR0LNX3CLjqKwg==
X-Received: by 2002:a17:902:ea0e:b0:240:5c75:4d29 with SMTP id d9443c01a7336-2510acd912emr1530665ad.0.1757116300918;
        Fri, 05 Sep 2025 16:51:40 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77235e27440sm21723884b3a.66.2025.09.05.16.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:51:40 -0700 (PDT)
Date: Fri, 5 Sep 2025 23:51:35 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in
 __bpf_async_init()
Message-ID: <aLt3h8Ak7gMpv5N_@google.com>
References: <20250905061919.439648-1-yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905061919.439648-1-yepeilin@google.com>

Future readers,

On Fri, Sep 05, 2025 at 06:19:17AM +0000, Peilin Ye wrote:
> As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
> bpf_hrtimer and bpf_work, to skip memcg accounting.

This submission has been superseded by:

[PATCH bpf] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC in __bpf_async_init()
https://lore.kernel.org/all/20250905234547.862249-1-yepeilin@google.com/

Thanks,
Peilin Ye


