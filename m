Return-Path: <bpf+bounces-47164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71C99F5C59
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E722416D670
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6936F305;
	Wed, 18 Dec 2024 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QBcfiSKy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0235965
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485970; cv=none; b=DkzxWxWnAfXWsHsN5BO7PVRsad2BAJ+2yarTYRrD3ORI1ukbqMerGD2eNC6ZWsmt7fkFjvS5M4ZZIkCOWaNg+IXegmJORl/PKvGRSwWun35PBIV16iiwfSYTqptYAOZUoHaoSzYnUhd5gbXNRWViaviwuK5JG2hC1kfUg/fgeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485970; c=relaxed/simple;
	bh=NBXngBXuXUS1CuveS8CMCH5HMn+Pd3wVJYjajc/z6d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3OLjotfryviLKZwFtJBFOsCz+XXJddyXWdw35J97LRgsj5GnPFZjug+2pLUrJy3WfjRcS9O4F7ubjb9leucXCokeAe1Gb9vSORo/W4jrPNHxNl+qov42mhh7e2v+YvMn+wZZT0TH1ezc+00D3AzSXwV7YVCWus2wq+dXCiNph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QBcfiSKy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa67333f7d2so889904166b.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 17:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734485966; x=1735090766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFUmBfvuCYiisihQ0MMHqMUfI983Sn9UGFbT49q6EUw=;
        b=QBcfiSKyIwQvTDJOSPx/j3TREN9zPHCPRzXN++/miIo7VTMNO9P+pfANZ6XsKSxpRT
         1xtBXJQ3xZhbAsmf+iJ+T1j4IHF7wiB3VDfzmwyi8F3H6CeukQ4zul5FSVg49JwwWRbc
         OTBEXx94zwfAatxYFsputJUWu08gzkK0bJe4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485966; x=1735090766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFUmBfvuCYiisihQ0MMHqMUfI983Sn9UGFbT49q6EUw=;
        b=v9i7bt9q2rSQoS75KXdefNET8Qis+X8la4mufmDzmgfgAyu8dQpq5kchTNQ2OUUAE1
         bHMVHT4iOLYAgM8gqdWMIaUXrkj/OyDs8MG+d4yuWKA2SirwJvfwUAlyA0o2xGmkPjpW
         sLaYoTAgpPy/fuZSMJOzZFktBhIs81Z1U+u+g010CrwAUL5X38OlKY65oPb6SHKxf396
         mRMGv/S5RCqBT4EMqHTIJMyzLXbkfyipsxjqHYaafa1B8jjwtpyTB5ZQRtS0FU+17KWk
         CpDx3InVASRUJEvkd8Sx/P1TRW3BFA6IDNjedL+zrqDfFHdWTj2bB8BlHmDuTU41uK1n
         umPg==
X-Forwarded-Encrypted: i=1; AJvYcCWCzSYIQVOyry0AOv8NzoXYF+6lynMBf/o0xKrqW3GaVYRs2Jidg4AaPOdf+fuyXR2OTf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBr7Run5HD2ayqWPo4ifCe1moYd+fopVJxLQq2pDp5PR91zo0A
	GOomrhL5QIXc6BzQmKuGhowCO4EpAaVerfZ26iv+En84+gPLJFXtRgcNa/0amnhu+fm1EZaCY8t
	tvTc=
X-Gm-Gg: ASbGncujmtN7HRQl9J2oaL0oMXhP9bRq4J21cuk0dd4HZ99Whd5IQ/eyvLQYcZviLYc
	PQ7KLsJ2ttMIkcCgMoCLE0jIexJnkH2nwmFvnvFrIIjP9BX5q0n1X5kQe5M6FH7v5omifNGd72R
	9hd0FiyJHGT94OoqoRggp92h37vYGw5smoH62ytBLzb66d2cfW4Ze9zBizvETUBnHu2CmX/y1Xn
	cCqetR6Cf4qQPhgWp32KVs3w5v7LVv93L23EpZNNrwBc2SIoxK5YVXa6eveV02eiJpLgflg9NNC
	LpHYn/QKaStcu/qFkjPVHMqAk3JJqug=
X-Google-Smtp-Source: AGHT+IFj3lYiIvne/Moe2AQK2TqQpFuuRdNfp/LV2fXmenmTT7lnidsxhzM0aZUqT9KZM7703GsPWg==
X-Received: by 2002:a17:906:c145:b0:aa5:1a1c:d0a2 with SMTP id a640c23a62f3a-aabf47a7442mr69569666b.34.1734485966178;
        Tue, 17 Dec 2024 17:39:26 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006456sm499287466b.31.2024.12.17.17.39.23
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:39:24 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6aad76beeso828131766b.2
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 17:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs8CcQVzm4RqJjknFH6T3wT9AORXx3YMulstt+pH73OoANz7bHJRJk8AFbYq+AaudMdfU=@vger.kernel.org
X-Received: by 2002:a17:906:3119:b0:aa6:894c:84b7 with SMTP id
 a640c23a62f3a-aabf470d31dmr63561966b.12.1734485963656; Tue, 17 Dec 2024
 17:39:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home> <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
 <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com> <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
In-Reply-To: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 17:39:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
Message-ID: <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@google.com>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 17:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me go separate that part out and maybe people can point out where
> I've done something silly.

Ok, that part I had actually already locally separated out better than
some of my later patches in the series, so I sent it out as

  https://lore.kernel.org/all/20241218013620.1679088-1-torvalds@linux-foundation.org/

but I'm not guaranteeing it's right. Consider it a WIP thing, and only
a first step.

           Linus

