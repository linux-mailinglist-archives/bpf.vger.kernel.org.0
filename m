Return-Path: <bpf+bounces-68936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEA5B8A1A0
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7557C190D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE183164CB;
	Fri, 19 Sep 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZp7WRWy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6983164C1
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293507; cv=none; b=D0nczamfXdvuXO/LtwDU6kmD/JMeZUPNzGvSVYXwldtnMdNrBcRgjxzNLqr/W5fXhobzfepXdl3GOA8OJgwwR3AwD4wqdtSPITae/EMPPYh2f6b0RR9ES2I2FBgHOkWxDIk2FZqfFBNmHm8CR+sZLmuMNhJ9e4jeD5/DDw3cPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293507; c=relaxed/simple;
	bh=XLtyCqwpNowP4VzbbN1ugCLImYAQfN5fXYP6pghiWy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWjCEX7HzP6L7i5Oc3wcargW9+JE1UISkHASx02rSvFl3nivDATDlovgBg5xuqhsWdB8+IBw50LT7ZlDUL8/2XAdee9Jy/wUEv/4HBU71mSaraYsHpoQEuz0uMn2xwAA+KN3m9D7eJxPQ7smZ72zjmJUnvR4MGVTV32b1pgG3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZp7WRWy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so17143215e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293504; x=1758898304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXkaYxofxS/TVReDSmRXXtZcB+ohz8S1SkvwFahN0qw=;
        b=WZp7WRWyxiopypvI7tkanV7R9Pp9kmBBF2aoFgyhHMv5K6+KlkSQ6CbtKibHYp0UrU
         FIW41e8NlJBpoiyIaCfhHteyZStCu3XX5IqfKcRdZ0WPRVssE/hDbu5sJCuzZtgnDDQI
         BSH29g/fIfIBcn0lS/U2W5f1wqQlR3nknDmnTcv64nUCwqRRmtFNXA0nvDndEL+gKtoR
         Vb8zHI6cXB1Z6YruRXBsAjASv9HBREVO4dE5GWuf1vngVX2ktXzBP+qmL7/8bHNR4abR
         KOOl7/NOWKyqNkSlWyfiBHeZc+oBamfMVplQPt8lLwvy/s+mWAJYqcZKtSJjTt3W1iTC
         xTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293504; x=1758898304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXkaYxofxS/TVReDSmRXXtZcB+ohz8S1SkvwFahN0qw=;
        b=LT8mbAFSn/P3SXKau5udXlhkQmWUJPV/Jav/xCnRjL2LJGWHvYlCht4blyISGrhMlQ
         f+n8fk8YvmGANctqgmBtbHsel3F46shqcf3ZDOOZhYDo99dDdKbqI5Ulzlk46ueYAD9t
         wP8dZ6COyWKECMC9T4c0xc4ZpTOv6s74rxuvWYMXEZVFrJ+raJrrg3YymVoghPKU0t7d
         CrPyUtupqnqKq2C2DAiq84ceSiFOkWqviZb+leoFdQHttrQlFYlRap235UpvEno8IXUE
         ZYx/dGmj82CJ4jlfyyUBboKy0Rlt7F5IBggQIDR1JQF8hGFA+cEc1XINfPDFTtMapnxz
         QjIQ==
X-Gm-Message-State: AOJu0YwbhlnV8S4rmdlJejDP56Fg/zpS66el92ejYX/mRxz8EoZvGhP7
	aUaVeJ9kIiJ9wLzq6m0wsm+542Bj279hhi9VfPwBOiPx91GPVHkdRRdU
X-Gm-Gg: ASbGncuMw2oa1aNBcgSrSlQ0Q0NsB3ZmmW66FV3NLxvoZEZUPwzW13/JFousiOQWCG1
	qFMpgJsMD5DCPLdPAFZLsGtC7SM/SFYTEKZh9CJMwhH9+halPMZt/8285xXD2PsZCuyvvYC5s7l
	Uj1VM+R1QzCBVh28jXWdZ+jdYxzoOrmTGADAP6mTwGf2HDGSyWN+irUS05o2e9bKjS+xSs016h/
	ENYWRqHJ15AQsUyxzIMa6hGRATIKFlcLWPocWdCDv73AMdtTS9uuo/CvQncQIa42WEVu2QGcCJo
	/bRMNqT7U5RiRCTgDDUcTpp2vm04hpADBWkQiTbro1gSMdEp/91M1q2aZV5YQ3+5LboJ8ENsF8o
	2tO66uN/OHWQx+kC0+bu9sV1FuqWhzwew
X-Google-Smtp-Source: AGHT+IH/Sen20rysC28idmLu72T6Iy1FjgjpXkbsxOfvdMYNppfyJUEd90sUOjawoV34mEQsGaLSYg==
X-Received: by 2002:a05:600c:8b4b:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-467e7f7d89dmr29855795e9.13.1758293503818;
        Fri, 19 Sep 2025 07:51:43 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32181a47sm87754675e9.1.2025.09.19.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:51:43 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:57:54 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 00/13] BPF indirect jumps
Message-ID: <aM1vcrxBSbyQrdq1@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <938446871de1d0b91ca7eb56dd75442b1d58b4b4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938446871de1d0b91ca7eb56dd75442b1d58b4b4.camel@gmail.com>

25/09/18 11:46PM, Eduard Zingerman wrote:
> On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > This patchset implements a new type of map, instruction set, and uses
> > it to build support for indirect branches in BPF (on x86). (The same
> > map will be later used to provide support for indirect calls and static
> > keys.) See [1], [2] for more context.
> 
> With this patch-set on top of the bpf-next at commit [1],
> I get a KASAN bug report [2] when running `./test_progs -t tailcalls`.
> Does not happen w/o this series applied.
> Kernel is compiled with gcc 15.2.1, selftests are compiled with clang
> 20.1.8 (w/o gotox support).
> 
> [1] 3547a61ee2fe ("Merge branch 'update-kf_rcu_protected'")
> [2] https://gist.github.com/eddyz87/8f82545db32223d8a80d2ca69a47bbc2
> 
> [...]

Can't reproduce on my setup yet (but with the other set of compilers,
will try to reproduce with ~ your versions).

