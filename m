Return-Path: <bpf+bounces-47652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2389FCFD8
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 04:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473D3161289
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8F149625;
	Fri, 27 Dec 2024 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NY+kvkgs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD1374EA
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735270543; cv=none; b=TCxyg2xTYAv8y1zAW8mvvqruV6P5xbDCXtT/Ja5xx61lwIjZTAzH/WQlxfPzhcRA35GDrPWOvbz/NSdzb8t+MXfp+LprnU9+9K901IxS9HsJzj5BRdtZFWVVqFUvohzIe8v15Sf8QMqYdg6H0L5R/volfzzBE3Yn3uAdN0cva5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735270543; c=relaxed/simple;
	bh=AGXTRv0LmVHEZMilybwu6oh4mQ5OUxVnd/fQq8fjrEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFeOtrDgneM3nFJzhA0oKJLHTB6YdMN/Rr9W8gLQ7PJJ0MrQA1zvTj9aZRP1GUWlkRX3E6gX7KvnKxqWqm/qJgzCQyq3PxkFcO6oenOVOYM109qqLim8DaQFMNY/L8eHcghJlhi8AWvjNqnUhmD6OHUQ/XCstdhb9q/jSvnniWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NY+kvkgs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso10328608a12.2
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 19:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735270539; x=1735875339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zv2Kquny1rwoCYildgERHjuaVV6RvgaxGbRxpY4LP4I=;
        b=NY+kvkgsASo1ugl2v07MT4YZQ9Rpqx7RR4Rzg6z7hHW1eLkXuiGkfa9jNq060NRQ4W
         HTy0Hfv+3G9/ODjkhFKmZdgWQU0DZnomE7O7p9GUOOPxVC9HYL0cPP+mhzzr6q+qSz03
         dLLMu17Ay39vfp4H7267GZpyFIY78utN0tLQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735270539; x=1735875339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv2Kquny1rwoCYildgERHjuaVV6RvgaxGbRxpY4LP4I=;
        b=Xds+BI6Se8xGefUmhzB2zAborQvh+goSwvTcbRaAqWdMn15tF1SNTnVgekGEd2Ajzx
         YvLdxwKKpzrJ1ZNtI1AGVFFf9T7miwR2xk4yxnF0xENn3q7F0aYgJGgV5ayo2THY9YhV
         EeIzu6aPUaoKJfzW3X8hT7kQvPdEkk9rwuvCajjpx/kVVNDaZRfooKh8N+21rDeu0w56
         DpVmq9dSnNVICiW9qUuwfO6RBMKg6Y0XVy//if3yv71KGxiVDyMcdfThvNS7SHDdntdx
         4L/XnKoj9OZvlgOtmriz+cDgSqQzzt5BS5hGDnTVK6cwLCVq63WZ06iwboxLE0pg8bB3
         El0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzRy+WYAaV16PPuA0rwvUvjfw9Qi9F85m3yflS2r9r8avJdv8TzUjn3QWLModxJjhfgMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdP5bIt1hnRUdLqr+xxurltS7qg+6XZsVvIAhKedRruAC3ZUOR
	M8H9hYeQhOvhCdW3pnpAFb/D0lcSS40jQ9ClMWmuxgWo7f8GiCqi7sOm9cn4a1IrolkajTyNb9g
	ZCVaQZg==
X-Gm-Gg: ASbGnctDJjd+DtWgMVrXKtthVTIxtnfEcvYbjZ3AJlazseiOO6gYaw+9oGUrCPyPsnm
	EyxV78vrjsf3u4Y4dauRLJPV832DYdGc0ZFN3CdkwsQKFXdHl4/i6XSsoodqZrroK7362RM6gN8
	go0914PzBnq21Kckc4qwg38v0bPhvmEQjqU3tQ02xbGK/lBME9/pL9YB6dF6zEW3r+nNmf/SDiy
	QIQfyeNgxPPua7gRr/vdO7rg2gDzMzWDtgH3qjIeWi+eu5nL219wTww+gXQW2vWCNS+RSFDp6Vk
	VxJqEp631onsKoOYOmwKNWLj2SzcX58=
X-Google-Smtp-Source: AGHT+IGJI5bk0fvIEEma2dsXbUFF+OWLJcJOS8zoHa5wIh4y9gOzWHqjHf7X/Apz7RaL9pSt5e5pnw==
X-Received: by 2002:a05:6402:84c:b0:5d0:b925:a8a with SMTP id 4fb4d7f45d1cf-5d81dda80bemr25365271a12.16.1735270539284;
        Thu, 26 Dec 2024 19:35:39 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedb05sm10421896a12.68.2024.12.26.19.35.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 19:35:36 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso8260976a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 19:35:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVREdxQ9lHZy1uDXkKUkUu4vc77sBAGIwt3rFRCsGu2WSS2wQb5cqN/53YjPiDxJpCJU5A=@vger.kernel.org
X-Received: by 2002:a17:906:6a27:b0:aa6:9fad:3c1d with SMTP id
 a640c23a62f3a-aac3464881amr1926490766b.39.1735270534947; Thu, 26 Dec 2024
 19:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home>
In-Reply-To: <20241226164957.5cab9f2d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 19:35:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
Message-ID: <CAHk-=wiL8B2=fPaRwDPGgQhVs=3G=8Gy=QyR59L85L0GF67Gbg@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 13:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But then, when the linker removes these functions because they were
> overridden, the code does not disappear, leaving the pointers in the
> __mcount_loc locations.

Btw, does this actually happen when the compiler does the mcount thing for us?

It *feels* like this might be a bug in the FTRACE_MCOUNT_USE_OBJTOOL
logic interacting with --gc-setions.

Is the problem that --gc-sections removed the function section that
contained the weak function that was then never used, but the objtool
thing with create_mcount_loc_sections() would generate that
mcount_loc_list and nothing realized that it's no longer there?

Or does it happen even with the compiler-generated case (ie with the
-mrecord-mcount and FTRACE_MCOUNT_USE_CC)?

We can disable LD_DEAD_CODE_DATA_ELIMINATION, if that's what triggers it.

It's marked as experimental, and it does smell like either
--gc-sections is buggy, or we're doing something wrong to trigger it
(and I could easily see objtool rewriting object files being that
trigger...)

                  Linus

