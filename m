Return-Path: <bpf+bounces-47259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D933A9F6C5D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902F318907C9
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754EC1FA8E7;
	Wed, 18 Dec 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LFVH6s0Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C61FA241
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543187; cv=none; b=TfqjAzaJ4J7La3kNPMhZbGJ4MxSGjzB3LLXJzHD1H4nuuhYEkWtsV7CqjDkOcPmBKvam3XCFLrpLENxFw3CAv4wPWGPl8Fxh+pZwV6yO5uQb4rSEPLTf7cuMYOJLaqeTPr4SjZMbKdnQWFN3pG+yIVfK001Xa3JdPl612GOPQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543187; c=relaxed/simple;
	bh=DvJShKwzdS0uRTwTHhv4w9zdEOiiupoFncD3gAji87o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1xj6vMc7fU6tHQOODO3lydd5N5wj52IAL5np6Fb4m4aQ/xmlG1EkqBViR/qhuy6POFQ4Lrc4b9hZ7ySDT0gatDtfeqAbKLhIPJ8Lz41bGaFN5YZ40NNbgYRWctOv5UCns4HPLjJLQ6JVDQFWPyPzlkODiuGtlWT0vnEfEwjDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LFVH6s0Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67f31a858so1241616366b.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734543183; x=1735147983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bdMyq/pn1ustN5gE/QoPYX2OMHQDHK92ZPUGF4MfBFI=;
        b=LFVH6s0QHOr5QLpVTQunFx71kmd8Z4LIUIR7mPFcCC1l2Oa/sRaXoOGILZWoEBq8PQ
         DUYsaL2rJy+TIoJ4LLGlAfvS+VQ6YpUc4w7zm4udGySElzFTarXgYaFnkZ8mlVGVNPDk
         Sj6XYxw/0JsTip9zIhU6NjdS8XpPwwM68i14s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734543183; x=1735147983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdMyq/pn1ustN5gE/QoPYX2OMHQDHK92ZPUGF4MfBFI=;
        b=ZTGPo3hXUwywagmpi9K1aQAMUXf6h+evlU1cW8M4ORmGNCZovX1uKWOlvpYUl5PjZ6
         z3FgtiCN+88y5o3LAVN0jZ/wJRpd2vpr5NOb1aCSt1FZRdIQtNXaNYGpOp/9XwZ0iePr
         x8uhp7wt4PhNMiEkX66jO5GIaNX4umeg6rLsY6mmKSoe03Wyyw+5edgUUl51cbt/43Cj
         OyYFemoZM3sGGNYR+Gg7QKB0wMbjGQXl//g8SUYlt1ar5neXEW1aYZnxwxLv7eJPrXsO
         8K/DU1A87ZvEAwU8bg6PqBW/OIDNVKxLLVsVZB/Br+p5mWCvVfhOUjsKySgNHrz3Nojo
         xSOA==
X-Forwarded-Encrypted: i=1; AJvYcCVdkdOGSmui5IqGwLK/zvWbgryB3wnNr4qIFuxldCUcTP+bbCj95qTNozsMqUYfiQALki8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqc43S8X7xtyQad/VydpnsgQxxVVpRs5zWmxhBgltN7rgMXKw9
	OSu17v3ybAU1fxNLEZpn3CtEiw/A3z/z/IEL1K72eKMGwx2S0VBRYXQ9Y0CUzS3iZEkIdihNwgq
	PPqM=
X-Gm-Gg: ASbGncu2tSvznwWivXM02BJaIvU8o6erumP77uAXi6Fvveb49jg8Y7RgfcUaYBDIVbD
	MbBzGxJXIeQ4e6dbf372JADJ8IKwAc+7wVtdwe6ybd4NEiTFeOjQUSTfb6ZAOMa6RAP3cbdD3yq
	TDEsXCl/CPrK4dHB12w91KP2mLH9hTuq9yNHCaaWexDHXyLEeytWhDzC1B0rTpTX5t3ZKDkYA4i
	/540TRVwV9pkSc6hoWRxDpaYkis08tXwspF2NKl2V1yAO+9Vtw6Cs9LKZTZhkqmfcAJWNovz3o4
	J5nJBGRM+cgDXVkuAa+fHyZs9Bd0r5Q=
X-Google-Smtp-Source: AGHT+IEA6OrBNQBALMccl2Ww+RJlxx/RBPqHfXvKEgJpB3+NZVV4f8clrFquVvxM8taii/yKYvrynw==
X-Received: by 2002:a17:907:7d92:b0:aab:c78c:a705 with SMTP id a640c23a62f3a-aac07b9046emr18600166b.52.1734543183548;
        Wed, 18 Dec 2024 09:33:03 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068a8bsm581167566b.76.2024.12.18.09.33.02
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 09:33:02 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa69107179cso1240201166b.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpw+WC938vgVe0KHSyq6XRWQozeMJGLXH7vKmwooqRbvoNZnPN7J1QgjYYIdNpjGE/8w0=@vger.kernel.org
X-Received: by 2002:a17:907:60cf:b0:aa6:7feb:193f with SMTP id
 a640c23a62f3a-aac07901cd9mr21602266b.20.1734543181655; Wed, 18 Dec 2024
 09:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
 <20241218013620.1679088-1-torvalds@linux-foundation.org> <20241218103218.7dc82306@gandalf.local.home>
In-Reply-To: <20241218103218.7dc82306@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Dec 2024 09:32:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whbzEO5sHk777FGWcCjDnX2QLBLX9XszEVh5GnSp+8RWw@mail.gmail.com>
Message-ID: <CAHk-=whbzEO5sHk777FGWcCjDnX2QLBLX9XszEVh5GnSp+8RWw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: simplify number handling
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Florent Revest <revest@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Dec 2024 at 07:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I went to test this by adding the following:
>
> diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
> index cfc159580263..1ff688637404 100644
> --- a/samples/trace_printk/trace-printk.c
> +++ b/samples/trace_printk/trace-printk.c
> @@ -43,6 +43,17 @@ static int __init trace_printk_init(void)
>
>         trace_printk(trace_printk_test_global_str_fmt, "", "dynamic string");
>
> +       trace_printk("Print unsigned long long %llu\n", -1LL);
> +       trace_printk("Print long long %lld\n", -1LL);
> +       trace_printk("Print unsigned long %llu\n", -1L);
> +       trace_printk("Print long  %ld\n", -1L);
> +       trace_printk("Print unsigned int %u\n", -1);
> +       trace_printk("Print int %d\n", -1);
> +       trace_printk("Print unsigned short %hu\n", (short)-1);
> +       trace_printk("Print short %hd\n", (short)-1);
> +       trace_printk("Print unsigned char %hhu\n", (char)-1);
> +       trace_printk("Print char %hhd\n", (char)-1);

For testing the real corner cases, you should probably check the real
truncation handling.

IOW, things like '%hh{d,u}' together with a value like 0x3456789ab.

Because yes, the truncation is very much part of the number handling,
and is actually a very important part of printk, and really the only
actual reason '%hhd' and friends even exist (without truncation, you'd
just use %d and %u).

The fact that both you and Rasmus felt that part needed more of a
comment clearly just means that I may be more aware of it than most
people are.

Because I considered the "handle sign" issue to be also making sure we
handle the size and the *lack* of sign corrrectly.

So I'll extend on the comment.

As you also point out with your tracing test:

>         modprobe-905   [003] .....   113.624842: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338e760 buf=ARRAY[]
>         modprobe-905   [003] .....   113.624843: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338ec40 buf=ARRAY[]
>         modprobe-905   [003] .....   113.624843: bprint:               [FAILED TO PARSE] ip=0xffffffffc060e045 fmt=0xffff8c05c338e280 buf=ARRAY[]
>
> Those "[FAILED TO PARSE]" messages have nothing to do with your code, but
> it means that it doesn't handle 'h' at all. Even the "unsigned short"
> printed but still failed to parse properly.

Yeah, %h{d,u} and %hh{d,u} are not hugely common, and apparently it's
not just your tracing tools that don't understand them: Alexei
reported that the bpf binary printk code also refused them.

That said, they *do* exist in the kernel, including in tracing:

    git grep 'TP_printk.*".*%hh*[ud].*"'

doesn't return lots of hits, but does report a handful.

> This is because libtraceevent appears to not support "%h" in print formats.
> That at least means there would be no breakage if they are modified in any
> way.

Oh, %hd is not getting modified (and if I did, that would be a major bug).

It's very much a part of the standard printf format, and is very much
inherent to the whole varargs and C integer promotion rules (ie you
literally *cannot* pass an actual 'char' value to a varargs function -
the normal C integer type extension rules apply).

So this is not really some odd kernel extension, and while there are
only a handful of users in tracing (that apparently trace-cmd cannot
deal with), it's not even _that_ uncommon in general:

    git grep '".*%hh*[ud].*"' | wc -l

reports that we have 501 of them in the kernel sources.

           Linus

