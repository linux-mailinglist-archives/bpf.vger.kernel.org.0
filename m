Return-Path: <bpf+bounces-32243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CE909F91
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 21:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B51F2152C
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813694EB37;
	Sun, 16 Jun 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exlZ++y8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F0DF6B;
	Sun, 16 Jun 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718567488; cv=none; b=V9oOX3POxqBJWDYJ/xRq0C9cOiE5Y2xwtq47xMtvH46b5BfEfTttW+3lWPwSc0Q+hlBnDjMrWjGGGvwIf3lGcNV7QDhV/tv6F01RKONJus5uhYF21ahceBh49sqCFx0TCKBssjfLlixg1ETQiuahgJyvsMQldyJOOrEqJv4Mu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718567488; c=relaxed/simple;
	bh=EQ3iTrrzXPP3MOYvlPCcfpt/KxQkKojuPogEIJEBzvw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0VwFAmJpBrEJWBn7Q+KFLIL6qhslO+04XtYut1wtyBGQ3PqO8VNIpRgde12yMOYOzSmy/JhxndyKzdR9Z/VJqYlFmS7+9S1OEB25qZ8AjX3vrLUzGRaqq58akxs8k8Oj207v+LE6ChKBaKK8nnPTCbRpwBONv6T49hoF8LKhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exlZ++y8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ca342d6f3so3174617e87.2;
        Sun, 16 Jun 2024 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718567484; x=1719172284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0UxXjHhA9OJxuIxRF9yrjGa8JmT9i0hYKwblsJfsTYE=;
        b=exlZ++y8x3vClGURJuNmf8optuuQwIag3BMdUF/cGbErFslarjdxg2Lz+WXBbkdc2T
         +VeM32q57CgRrd7jj63b5+ke7WtPXv/dlFP0/CQMWqrWLBgHyHUqcjjVJtPmG2TcBV1D
         7xzD5dhmX85qGKNUdKBm55msYaBuD2shIexvaR01alexnoTOtQNM9s9nEJITkMrSJiae
         qWeimmr85W7p6HHGEcvjrk0P1IGZwfviW98GA577gCO7MdyPjnOTNR1lnCNUMU6e/yOP
         ZEa7vrh81GqwWX7V3LH/fRXBhmg/62573/WQtIYocSjNEEwSmbXKpMylSgkUhVPAYhRr
         8orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718567484; x=1719172284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UxXjHhA9OJxuIxRF9yrjGa8JmT9i0hYKwblsJfsTYE=;
        b=vZZdFZXkhAuHxFYiASxkYKtk8v0WKTscvi5AhukWypF1bW5Hkhi2LwRL1nXn7AAcug
         ljL/8RBvZ3NcXTZA+swiiWt2PebaE9nHW9a/5JNBA2KIwRKPyuB646anNwOqKb+U60Ki
         9AXUVQ6ilDn0Obq/Fh57jvR3giuvqID9X0BC3I5m0uuf3DKePtoDeQL5vBwE5S1sL/Xa
         T5LVzk8JoF8CgxHb+d4KddSN43po+bDM5H5BK4gZw9yp4C8Y1qDMkBxcnE8h3Q3Kqs14
         aPe4twc7LXoyjjuKRHxjyBH+OniJLpHezZaIXP9+xdwtaJTJ+H8mw+wmaVE4NEEGXoos
         I+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUnUZALm51/F1oG5EvPgf3/5SU2OQnQXtvJLT0DE2q6SU/jb/mW0LuuVaPh8hvz5FXARpr1M4RdAPX9hyWZex0wSAy3sGyvPicxeHuoO9osCb6ACLSJRTNskNx8PPEN/19YfCAwB20d4loArg81t1hvav43j89Pz9ieZCz6B+JCcCD+fevp
X-Gm-Message-State: AOJu0YzIjCroWuMt34zLJ/1Ingr3RN3urB2TgSre2I6pdaia6B42OMZY
	Grydn0Er7n20gABqJiMdNi+JnjOJ+8/j65ylAjREIE7nNqc5th/B
X-Google-Smtp-Source: AGHT+IGOFgACiHg3TIi3DNIqmlaJ2D3JFHlg4xpC2duW9W9tKpxnjJ5V6JwtZlJbBvM2UXRG69hZ8g==
X-Received: by 2002:ac2:528c:0:b0:52c:836c:9ce8 with SMTP id 2adb3069b0e04-52ca6e5506amr5521881e87.4.1718567484176;
        Sun, 16 Jun 2024 12:51:24 -0700 (PDT)
Received: from krava (85-193-35-50.rib.o2.cz. [85.193.35.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3fb9sm437325566b.30.2024.06.16.12.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 12:51:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 16 Jun 2024 21:51:18 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] bpf/selftests: Fix __NR_uretprobe in uprobe_syscall test
Message-ID: <Zm9CNlPVfmV_Pc-S@krava>
References: <20240614101509.764664-1-jolsa@kernel.org>
 <20240616001920.0662473b0c3211e1dbd4b6f5@kernel.org>
 <20240616011911.009492d917999c380320fd1b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616011911.009492d917999c380320fd1b@kernel.org>

On Sun, Jun 16, 2024 at 01:19:11AM +0900, Masami Hiramatsu wrote:
> On Sun, 16 Jun 2024 00:19:20 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Fri, 14 Jun 2024 12:15:09 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > Fixing the __NR_uretprobe number in uprobe_syscall test,
> > > because it changed due to merge conflict.
> > > 
> > 
> > Ah, it is not enough, since Stephen's change is just a temporary fix on
> > next tree. OK, Let me update it.
> 
> Hm, I thought I need to change all NR_uretprobe, but it makes NR_syscalls
> list sparse. This may need to be solved on linus tree in merge window,
> or I should merge (or rebase on) vfs-brauner tree before sending
> probes/for-next.
> 
> Steve, do you have any idea? we talked about conflict on next tree[0].
> 
> [0] https://lore.kernel.org/all/20240613114243.2a50059b@canb.auug.org.au/

hi,
I have one more fix to send [1] for this, please let me know which tree
I should based that on

thanks,
jirka


[1] https://lore.kernel.org/bpf/ZmyZgzqsowkGyqmH@krava/

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > index c8517c8f5313..bd8c75b620c2 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > @@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
> > >  }
> > >  
> > >  #ifndef __NR_uretprobe
> > > -#define __NR_uretprobe 463
> > > +#define __NR_uretprobe 467
> > >  #endif
> > >  
> > >  __naked unsigned long uretprobe_syscall_call_1(void)
> > > -- 
> > > 2.45.1
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

