Return-Path: <bpf+bounces-23229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51E86EDD5
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6A1287603
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AD53AC;
	Sat,  2 Mar 2024 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTLjLPLC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8A5680
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342455; cv=none; b=Gf2j/YjbESsaulnzPunaIX1QyX7C0QNRMKrkgxACdNKpmUJ2FkY3uEQEZMMxHF8MMKOmTC1WCt5OcBnvlibPbmqKG+kUF9KWoUk2lMyZbvq09+c2DlDnXkuhfYdH31VibSFGoh5PnejbUVBuc54Aua4Njcz41jzYejC4z2cEEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342455; c=relaxed/simple;
	bh=PzLtm5d/Q1rvfQ/qOPevfPvfz8KsdYi1MNvTN4VdfoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRgR3UxbucjMFsPDfjr9ReogTNb5jAt/Gcafgyofqw/ezz7s3Ujr6K5ovYMsFnehn2SVuctJHQx64GPzyWRXdchBJHh1zd3RSeKOC1H9nSOrGUb1Q6+YmHK3Vo7RYGQ/+OnewaKyKY351jq/tWoxEbYS80ILQTqQ8/0u5O5u6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTLjLPLC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513298d6859so2392860e87.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342452; x=1709947252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=on37O7tk9vSMxqK3Qvwka/LWdeHWq/NggnIdTUscI2s=;
        b=TTLjLPLC2gukFgbUjI68XL8H94J7cmmC0HI/8fzsVQLxuFiFq+xHQVz8Pq34yY4I9D
         Qdxif0k72b1P4RRjDff9dPQtN60YtivfRnGFl9kYXyIKnWPUNuFgq2QlG0ZBHt7lTamQ
         /+USpnO3yQTHFbfOShoxr4WrHQaDdscWzQA3J6xtZZ0F+ans60q/7cjtu6KSvsCK6qT6
         4cnR/GYhvJUaGeLB8L0CSEXWdCavGNzZYV20lC7ZreXBveomYiA/RytolZfUCkSjPfKq
         X6C6dvrZkAr2W4QcFE1insa40uOUOxMc4+qzrM0ynXjJNuEDaZkuJtc6u63X+HXjpJ54
         is8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342452; x=1709947252;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=on37O7tk9vSMxqK3Qvwka/LWdeHWq/NggnIdTUscI2s=;
        b=eByAIXeQTgxasxevgQfc1uWf+icBCEojmSDRfX8pnp0VuQsK+ObEms+xzi93JpCkWF
         OuwG+BrnD4KonlwRUpMG6q5yFkz03u9NS7t9J5GF7wh0K2ypgQgzMnZ7Tkf84qRBTOYd
         xj6qz363YJW8VNT2mSRwE+bvpmSLda+CqISyqTdpCReMc/G6zolsipF4ui78xurDSEFc
         LslhWqqpmJnHsixHchkQbU5jeDID7sHZZjkMD252R8ZPVFY5XQ4Dcyqd/sPmILGhCL0S
         iZ7b9Ul3vtaYSWRsZyEKR/JZTDXZWWZI8IP+83QuGU+vUuRkKyu1w7xpyeQnFYiNJaUc
         Dx2w==
X-Forwarded-Encrypted: i=1; AJvYcCXn6bbLLFH9OZ11aRwkXxnIrPXEZcoRsM4chmjVFHFJbwq6ImQHW6oQ78sCZP9QjW27VzYrmcxOGZoW9shTQWY8uLbG
X-Gm-Message-State: AOJu0Ywt4FHEqaD0V0SQOJGQPNOrv3CHm4ZmdOB8oj4VxV8yP8YggO6T
	3+JxmGrikW9UPU7XIlgkXnQTF60HpOC/5+CeawWkc86R4u5SpcjT
X-Google-Smtp-Source: AGHT+IHLuP4ElMwvW3Wumr78FHrCvopWusNJYi354oSf+nhn1UZgw0vgJsJurmse5ymoMoSl8O1uVg==
X-Received: by 2002:a05:6512:3706:b0:513:13e7:8b28 with SMTP id z6-20020a056512370600b0051313e78b28mr2053475lfr.16.1709342451789;
        Fri, 01 Mar 2024 17:20:51 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w9-20020a19c509000000b00513202d4174sm780384lfe.116.2024.03.01.17.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:20:51 -0800 (PST)
Message-ID: <3c98f93bb3f0520d01d764ac4d89c66e50cbe633.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] bpf: Introduce may_goto and cond_break
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Sat, 02 Mar 2024 03:20:50 +0200
In-Reply-To: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 19:37 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> v2 -> v3: Major change
> - drop bpf_can_loop() kfunc and introduce may_goto instruction instead
>   kfunc is a function call while may_goto doesn't consume any registers
>   and LLVM can produce much better code due to less register pressure.
> - instead of counting from zero to BPF_MAX_LOOPS start from it instead
>   and break out of the loop when count reaches zero
> - use may_goto instruction in cond_break macro
> - recognize that 'exact' state comparison doesn't need to be truly exact.
>   regsafe() should ignore precision and liveness marks, but range_within
>   logic is safe to use while evaluating open coded iterators.

Sorry for the delay, I will look through this patch-set over the weekend.

