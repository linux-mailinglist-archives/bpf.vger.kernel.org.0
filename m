Return-Path: <bpf+bounces-47643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFD9FCF0B
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 00:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F861883376
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E01C07C1;
	Thu, 26 Dec 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QMgJuhwk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9E189F42
	for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735254090; cv=none; b=u3taqTWeq2IM1iXML8dFYbiHNINzR0uvfdICVBvVGCKqemClmqurTVYZNUGorGAJTLR/4uciS4mky/75vCxPJvPNZKrQqpJDPFRu0FmqjLNZN7dmhJgEkzyz+QQA8HpsiVMdRGNjRscGf6f0kGNArLt1QNzgWghp+mSEMDQ/Bn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735254090; c=relaxed/simple;
	bh=l3LfCSw34LI9hiP4+YmiSU5XDk8QeFclo5ZoywKRc/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyJzYuUswnQB4VcAOP4ser2eo8XjG3QkPyoYfnH6Iw4BRsLWYmwz9Ti385VuXfZMImezYorVkSBy5/6kGDen5PrcbYdYCR6201+Kf78IAAXycVNguDo5b5SgPDy7yt/qeSZCC3IkFTzNQGbJkzgHIfh0FE1Wzim6l5BrP2BmLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QMgJuhwk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa67ac42819so965898166b.0
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735254086; x=1735858886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEATQMkfGbTb4fOsLXh4qamgDY3PFH9/p0eJJt63Xx8=;
        b=QMgJuhwkxbt5HnAxi8xxVQWawsXgVKrdc7qr1cPqlIsSu2pmX204UCB4ieXeWPABYP
         Vnk9CwMS4yzmOHd7lgNw+rzj0DxDrXI4iaCgE//azY8ByfdZaiWyJMfiV/KYz8h6zPst
         LiZsi4eyx1ixSPlUAzsqwyjMVIkDJGOUpLHKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735254086; x=1735858886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEATQMkfGbTb4fOsLXh4qamgDY3PFH9/p0eJJt63Xx8=;
        b=ktI0We55lojkQknGTW7sVD5lPnUtbpvoxgnbKEYDLLoZ0VljbtKPLzleAquSgb9K5v
         qvsT+qT3ym+jbA3ztz+e4HfCvGNFJW5M+hLG7c47aKJa6OhcS4sIJ1Hsy6FuL1XPpK0K
         F1P5iZWc4NTZXaxV8aGtQGwWNVyp7MTWmZ6C6dh9k/CljNh010vtz6Z6ZNlpjVTkCHJC
         aG1UR9rEvdsLfh0isnrvxfeSeq/ozCqFkTNy8tTkbhfEXjHNgLCQKsFYoZ1TOClG9wl/
         DGYzljQP+FVBxadR274JKOHotGGz7Qe6AnWoWn3jDQlUMg5jcY79Aip7V1CZsVzUrJvr
         0z/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL1XCCFasR4mm3itMR6PTmwMNjHwQ97kE0ZNRXD9EIFF6V7bVrIb9SlYFIcKaszuhzv9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9F+i9glHiiPXmHkQfZgMyQ/KdcDxNa556dC1+BzMcDMQqnuV
	jFwwOKdYK0yXa22Ek7sjqyQLGGrrAIxFKQzAMfumP4u0J72DfMDQ3SsmXZ/bUX3V3lDeDqiya34
	kILnHVQ==
X-Gm-Gg: ASbGnctM4Sf8GzQMYJ3fH3/LgDq6psL49eR1gvwhwlH2T15Cq2pWoJG0tSNUyzfb3IE
	WA9SaonKALzxpHPBrPfKBwaj1mG3xOZQlViO3MwpF9iS6q8Cn6d2CORWEcZvej3RQmgx2nwoaFF
	Kp5KPXMjaqlRQc+H+FortbxQ0khl6qb0Hjv6wm4APofce+ye6KEnWhRcOsvqZ0JDqdG8jOeawf4
	95K5vn+96l4388JKQVAxMYy39RWg/8Zc+zH31eUQt77LyqxqyTSWKGcmHRmRCETL6fq8EpoFwg/
	koAL32cuSRwLd5Tmcqth1y3S+wGuFUs=
X-Google-Smtp-Source: AGHT+IEv3MBcw8jV9+bEOp6fmnqMH4EAW9AD/iXg/euNGpevcImpmrGHXbShUWrlUAVQU+7yyM6plA==
X-Received: by 2002:a17:907:3e9e:b0:aab:92bd:1a8f with SMTP id a640c23a62f3a-aac2d327c18mr2168609766b.26.1735254086616;
        Thu, 26 Dec 2024 15:01:26 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aae8b802f64sm822651666b.108.2024.12.26.15.01.24
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 15:01:25 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so1189568366b.2
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 15:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA/tn6KOfBHYeQ/MQe3ivJMdroO74NhtR2eobMEVK60pUMBhzhFk0iZo8uPv5OaEBI/bo=@vger.kernel.org
X-Received: by 2002:a17:907:2da0:b0:aa6:5201:7ae3 with SMTP id
 a640c23a62f3a-aac3465011bmr2079637066b.40.1735254083855; Thu, 26 Dec 2024
 15:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home>
In-Reply-To: <20241226164957.5cab9f2d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 15:01:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
Message-ID: <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
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

This seems entirely unrelated to weak functions, and will be true for
any other "linker removed it" (which can happen for other reasons
too).

So your "fix" seems to be hacking around a symptom.

And honestly, the kallsyms argument seems bogus too. The problem with
kallsyms is that it looks up the size the wrong way. Making up new
function names doesn't fix the problem, it - once again - just hacks
around the symptom of doing something wrong.

Christ, kallsyms looking at nm output and going by "next symbol" was
always bogus, but I think that's how the old a.out format worked
originally.

But "nm" literally takes a "-S" argument. We just don't use it.

So I think the fix is literally to just make kallsysms have the size
data. Of course, very annoyingly out /proc/kallsyms file format also
tracks the (legacy) nm output that doesn't have size information.

But I do think that if you hit real problems, you need to fix the
*source* of the issue, not add another ugly hack around things.

             Linus

