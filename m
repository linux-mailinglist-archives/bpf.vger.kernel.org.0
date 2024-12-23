Return-Path: <bpf+bounces-47553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2799FB4E3
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3655B1884E3F
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8A1C5F31;
	Mon, 23 Dec 2024 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NZpE61Jm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3921B87CC
	for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984714; cv=none; b=MEsHyAKFXpupfASakh3hZmz4MB1alcUA5FII9/9mMVF/SjT3co6is/5X203AVKNcNtYqKmgfltlqW97W1O+NMX0kOtmrivUhh07VRWmBLLh315w04bnBaSlstwVbYqVYpNbxL1rp0ddvtJgc1hwgyQDpi/x0PFme5q5K+rHjyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984714; c=relaxed/simple;
	bh=nlSIYEIcTIXr6W+qfbaXuISKl9s5T1ah4gvEeeqCsq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGpx1/QdwdY60ICLQfZscxQw6Ia/rADvUxr35isF1GtYbraYGoWH/3t4bhE60339+LJsIFVltMRnHc/rOHvA+22jfinHMl47l7mdnEW3gKUNdnUDyNIpV1v3Is/p1k2otOrndMlbSXXXTsdn6xKXnDxBTbfHfmU6enlWPvJDj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NZpE61Jm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6a92f863cso561276066b.1
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734984711; x=1735589511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ChF3RaNo25Rqn5QFZZMj4eA40qXMb5oBarGxFKM6HU=;
        b=NZpE61Jm7noH5OJKOWPF6m5sj7WPMfLrdvP+S2FhetTCb1XQHsn46V1S0ElGa9Rqph
         FRPvdgyRK7QgVWNo+CNlKO9T2++dujjm8u8HMB+JCJX8GKPv2SB8+XvxmTO5ecaIohuo
         R9037Q64XIMuWjnDzJh4ziT49obgzAqTsm8uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734984711; x=1735589511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ChF3RaNo25Rqn5QFZZMj4eA40qXMb5oBarGxFKM6HU=;
        b=DqIFv8MklNp+RbxKna9yZeBnXe1POPKYxy1smUrFfs8LcynL1gfLZvoRScnugG8cJE
         QjvqQoSexp6/Lq9Vdrbm0YsLtovALdtPZzibNtQ92r5ysvfsgp6Cu6Hn5C8LpCteZbY1
         M024LSj81M2EubAaR+/m4DO/2k/fnhAdR8DyWoBIGtllFq71GW2gXBl35qyN+mUu8kwT
         jTE2aAWqWg8UYcVqTwWw/90P1URTqdjbWDRb+7o8TNUYbzvo6Kwh8jf05vCozkJ3Ami+
         wo1a3HnLfvvjY7s7nQfdBuaoCcg8A/sYgKAaApArqDb2RwWQM6lR6CxKAGiTKl0OUtH9
         cISg==
X-Forwarded-Encrypted: i=1; AJvYcCV7/lHm1/iGv+NjawnVQB6tHS1/XEMaYRfyL9BQyYQHevaID/5yaQiUcllNu0q1yrXa+OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9goDRSvCKMC4u0KGFsQWxwSaBdozdeBn8K0ix6ZPRrzZi66vd
	OHTX56+V8+33x9UN5BD40K1exW18cFLnyKUn3VJpmP3gYKv33jAs9wFpA7VTtZYdGhtKb0viT2O
	zJY0=
X-Gm-Gg: ASbGncu118mW7WW2xCxn5s61PWFWIjEDh85XA8EWH4Y24i2S7QxCdd6csRHhvit038l
	hY07vM6PQhMQZHG05+966o9h5nGanhrp4ckDJTlLlwpWJ21aovYXDET9uU3ugm6rWSKSOjGvQPJ
	yHzOHuzGQGWllN7/LbZ+AT49w2YlNlyfuV9jkLgiJ4kXfaUdniCIwa1Cvz3iSLrmRiBbw/zVl7x
	nxU2MGUxRu4qMFJJ4wFVFOGw5lnLqx8be3BJXQetCgkc+MwFC87srdYtopBnizbODiWryXRAhRc
	KbPpdy4BGGfaa2WCVz664HptUJrRG7o=
X-Google-Smtp-Source: AGHT+IHxW588SY1v3QLXtYP+oKMwDvc27TfR1OiRi744hIRg+DP8N2KXbJIukgP3iHUXCSESsmWPJA==
X-Received: by 2002:a17:907:1b81:b0:aae:869f:c4ad with SMTP id a640c23a62f3a-aae869fc58emr748473866b.7.1734984710802;
        Mon, 23 Dec 2024 12:11:50 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe3bc2sm563967266b.105.2024.12.23.12.11.49
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 12:11:50 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso726230766b.2
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 12:11:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNHri+ZrL8IMucuWrmmz88lg4L+u7OORgW1U0/PCYwnCD82F7cbUrTvfYfdf5alQ27nFw=@vger.kernel.org
X-Received: by 2002:a17:907:d92:b0:aa6:7c8e:8087 with SMTP id
 a640c23a62f3a-aac27026fdfmr1355001466b.12.1734984709650; Mon, 23 Dec 2024
 12:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
 <20241218013620.1679088-1-torvalds@linux-foundation.org>
In-Reply-To: <20241218013620.1679088-1-torvalds@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Dec 2024 12:11:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMLh=v9dQ5vzjJ8K7PWR6eeohapMy=Apmm+QET=rn1xg@mail.gmail.com>
Message-ID: <CAHk-=wgMLh=v9dQ5vzjJ8K7PWR6eeohapMy=Apmm+QET=rn1xg@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: simplify number handling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Florent Revest <revest@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So I pushed out the whole series of vsprintf cleanups into the
'vsnprintf' branch.

It's rebased on top of 6.13-rc4, and if it works for people, I'll keep
it stable.

But note that last commit, which makes the 'binary' version pack
numerical arguments (but not '%c') with the traditional and simpler C
type expansion (ie 'at least int sized').

Everything else is *supposed* to be a complete no-op, and only clean
up code (and make it generate a lot better code, btw).

The main objective having been to make it possibly easier to do fairly
straightforward printf code with

        while (*fmt.str) {
                fmt = format_decode(fmt, &spec);

                switch (fmt.state) {
                case FORMAT_STATE_NONE:
                        ...
                }
        }

with a lot fewer case statements (particularly cutting down the number
handling to the point where you *really* don't need to worry about all
the special cases).

It's still obviously not usable from outside the vsprintf.c code
itself (none of these interfaces are exported to modules, and are in
fact still 'static'). But it's at the point where maybe it's clean
enough that some day it *could* be exposed.

Anyway, comments? Particularly any of the strange vbin_printf /
bstr_printf users, because that last commit does change the encoding
of %hd / %hhd in the binary buffer. It does look like bpf can't care,
and tracing hopefully always pairs up vbin_printf with bstr_printf,
but maybe some horrid thing exposes the raw buffer to user space.

From Steven's email and the "[FAILED TO PARSE]" output from 'trace-cmd
report', I suspect that the raw buffer is indeed exposed to user
space, but was already handled wrong by the tracing tools. I might
even have unintentionally fixed it, because the new binary buffer
format is not only simplerr, but a hell of a lot more logical too.

But hey - while the other commits aren't *supposed* to have any
semantic differences and only simplify the code and make for better
code generation, mistakes happen.

It WorksForMe(tm), and I've been running most of this for about a week
now (ore-rebase), so it's presumably not *completely* broken.

            Linus

