Return-Path: <bpf+bounces-27583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD58AF74F
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 21:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BB81F22AF6
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DE1411C7;
	Tue, 23 Apr 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz9YpG7t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445013FD7D
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900525; cv=none; b=e9axwI5FJk2IJNNB0GsSFQ556i2wnnjljvb6mvcI9D8QQ0a4fU8Woinbw5GWtsnl6Ew44SQjPRa6NDZJRuc3HdlwTnKuDvMs8lWkNHm1S/4tEVfrw3Nc246ZoGtWjXmkHVFKjSDmoJex+RzTYwzzaTM6bFPdR/YRd6y90qEhJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900525; c=relaxed/simple;
	bh=itEAj8w6e0ca2q524zEhDj+so4rEoC793e8mCpAMYIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMQoII1AsAzg3kLZ1E+6KWTipCiU8xOylFfSYCXSwj3BebCtwTiK8z7RTYf9CbAeRKJaM6qlVoykqlNTTb6DjpE3+ho7YjkOme/FeQdd12zq4EfgImr5GT6xeSDfinvC88J6ceHFLMOYLoarODDkdHjp++6LZXecaski5uAJl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz9YpG7t; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso5464474b3a.1
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713900524; x=1714505324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=itEAj8w6e0ca2q524zEhDj+so4rEoC793e8mCpAMYIE=;
        b=Lz9YpG7t/8Wbj8ZHT3HLj4TRbBv9OEmiVXX0sjP62VMYnYgxg+Q6uieXFVyItriwCN
         HnAbkPy1UgHLMSjfAU20m+73y5aapMd3hIU+w1NmdXiezxIMQBG/lvIht/4cvtklkMj7
         5knSUDCHOf4NCchJ0Y0yyvEfh0KFYHaBX2D+t9RkMfXTv67+gSoprwF7x4pmroe3MouV
         Sy1iTt4oANEEIH5bEY6MI/LOVbMR+gpixfWqNJ6D1DhAh4fcPBLq4pFZZCqKYccaY927
         5X1c/imxxsoWzrrmGCnNchJxpCIkIDDjCQVc+w1qwd7JgfbNXbXRFSs6oacqfrkXGmTB
         sdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900524; x=1714505324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itEAj8w6e0ca2q524zEhDj+so4rEoC793e8mCpAMYIE=;
        b=vOq0t7LwTx9HedNSGUbdFWOUkw/tSTtsKmLwdD66y3VNFVuuyMcIU8auy+BbHQhmD6
         TQfemAQac4mBSim3jJ0GtCTII2/nmGQs8/UQkjQqHCg8IKqwuy0BApQ084P6qUYq1ymO
         oB11V11ebcqY/xlFNpBbTxAxLep9XYXTDK1jAcBziNgtGcwD7q/o6OYWjfMrlH6rX0Pl
         0nSOfb2dyUSkp1zsS7mmGK4FB3KHU2tPs3fJ1pQetgJpc2jap1nqxDODV9+KHhbRtB4d
         nNlS1bu3lvIoT87+RxCL226HSu5gSThoaVdNvTlicaFEgKOc1rom6PJd3WMY6jHxqefU
         eYeg==
X-Gm-Message-State: AOJu0YwH8zLpRXSnk9KDO+MOqmIqrN4VkqOCVaS2WRqh+ll/WkQigQj2
	VqoiyOv4H7FIyeM2TYaNmu6FGPXI+2FbAV09JYCbQvqK7jItT96V
X-Google-Smtp-Source: AGHT+IFu8UrkJgsPWiAkWwPkWQaV27AJEcbDE6Pm7EKJstwC9F/wjMFYAu35KwAK6QQukI9RG6tJog==
X-Received: by 2002:a05:6a00:138a:b0:6ea:c3bc:2031 with SMTP id t10-20020a056a00138a00b006eac3bc2031mr845979pfg.7.1713900523690;
        Tue, 23 Apr 2024 12:28:43 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:74d0:ee16:7cb6:89ea? ([2604:3d08:9880:5900:74d0:ee16:7cb6:89ea])
        by smtp.gmail.com with ESMTPSA id z17-20020aa78891000000b006ecf217a5e1sm10005259pfe.189.2024.04.23.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:28:43 -0700 (PDT)
Message-ID: <833fde942383aa4b306ee0ef75c1a5ebf212e02b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf/verifier: refactor checks for range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, David Faust
 <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Date: Tue, 23 Apr 2024 12:28:42 -0700
In-Reply-To: <047c972f71bf89a7d4004f1852fe498d3e2ad010.camel@gmail.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-2-cupertino.miranda@oracle.com>
	 <f347d6ea9a0d8ecb77fe13a89470195735c706d2.camel@gmail.com>
	 <878r19k812.fsf@oracle.com>
	 <047c972f71bf89a7d4004f1852fe498d3e2ad010.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-19 at 10:37 +0100, Cupertino Miranda wrote:

[...]

> I was proud of the initial boolean implementation that was very clean
> and simple, although like Yonghong said, not truly a refactor.
> If everyone agrees that it is Ok, I will be happy to change it back.

Hi Miranda,

I've talked to Yonghong today, he is ok with removing distinction between
__mark_reg_unknown and mark_reg_unknown, but he asks to first make a patch,
that replaces the use of mark_reg_unknown() by __mark_reg_unknown().
So that the follow-up refactoring patch would not change any behaviour.
What do you think?

Best regards,
Eduard

