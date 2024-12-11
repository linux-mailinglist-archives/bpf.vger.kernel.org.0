Return-Path: <bpf+bounces-46592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D735D9EC2BA
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 04:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A4416382C
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03521FC7D5;
	Wed, 11 Dec 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiHxx3U3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92983CDA
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886226; cv=none; b=cWjiyRBxypS4J5HWJxF6HH+g3xTAxvXURe4ANNTYTPPFiBK48fkADJW8uN0cVij0AXkAA2rTbQHoW8gzPpzmUc5Gy3ITPxdmyRPp5OC+rDKwFZognkgaYFFMNqoWhT4OhKkQdmaOPBTyqpbvQrTJWbTQ9vXPp8BWFzCOh7ZeJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886226; c=relaxed/simple;
	bh=Ol6auOUI0Cw/nRAelRs39bmd8extpxCxSC8IkwKUefQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlStYTK9nJnamyd3Vk6qCdvbZdCnFaUILTxDYa/BvVXSUyZprOdldUXey/pb99BH5uP4bpLA3snnHJX+iO6csoyceLHOwKbBAK+CGe1TDTYDFxL16ENhHByb1qaU1riJkRfRB9PML6ijICIBAr6mz71dW9hD+ZYbudbypWqDGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiHxx3U3; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aa6aad76beeso158196466b.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 19:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733886223; x=1734491023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2BemVfBiAszmj2T5A8/RyrpxZEVGbTD59STbwku5S8=;
        b=hiHxx3U3INf5/XWz/ihUuOtlQUpRms9tnCasadgXWsi8+rjKRYdTZ5ggEPRNJMHnqE
         f3WaJIaYrE0oHkU6haAi4NSbXqAW3xTuWbUibv5TTHimDJa1lmAc5MBvCKxXLzVAJqvv
         eQ2daKQjd1xewo1o3kUI0ZhOjmLUoUABgchY1fGVaFK5ji5oUHF+lVJcQYkNFJrcmUn0
         VwwB+jLeE3jnsQl39KkL66J0PkP6ivggvR+0VVujK3mSgMyIJu1eLbJtSD1sh3IarbN6
         F63ExahllLtKonQMaGQUZQ1szxnbPl/Co/hIupUlMJ3YLeYZ7wRRDeRSqoE3uTa9UQiz
         iTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733886223; x=1734491023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2BemVfBiAszmj2T5A8/RyrpxZEVGbTD59STbwku5S8=;
        b=KNTQXC2iUokjj1KpmU81pPoeRHYfsUu6Ou3xNs84rY9vQp5O1kWwDmpvnYTU0N2c7P
         9elSW/AsBvPj8ANnxuEOA8f4t42Aq7BiMTV442Z77ujvYs18qJ8GrpkppbRbDqMGVWOl
         JLeonviFAkKQbZALl1mBvOLtSTza1ggRnIdPficFKHTHKwmmUSiSLOgKTSt57EvsSKKh
         lj4GH/5fVRdHAY33xNntjRuZJJcFDGY5xuIlZkflX/j9ook0z6uAThKsz1YmzygH8Xln
         wi2jfDYqrrKBA24MDd81EgYPZde6lUMBKpTK5dt6l01AJ8jH0o4xZt06sjkHftVGLfNT
         eLpw==
X-Forwarded-Encrypted: i=1; AJvYcCWoucBUT+zaUGDbmLxpG8ew0jmNiJ8mIhrSBF14yc2yD/mj/+bm4g65QJomSw7ySgVhwqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4lCkc5Ic2421YeM3sRuPenY3JyWrMaYt0yHXGSWVjPq0JnBM
	e5MrKhA8WELM2qSUN2DpKFN+X+2tOyw7rROgARSaFdkH6gfV/Unc+qWSwB/TCuAq4657+eTKhbK
	B8KR6BnVT454oBfgwolvRn37qxtk=
X-Gm-Gg: ASbGncssWlQ5cxKieeR0SWTeegG3E2h0lZK/T14ahGShP+nHNu91o5810Kg20avcgCf
	8A2+rDpcqbktN+WI8tggmlKtKK1vZHAfBp9Jy31fUP4EDchS7ZOwbTkJyXDTFI+H+ydbF
X-Google-Smtp-Source: AGHT+IHYg70jBkbiPuqOypSrJtfQtC8IefgHT/fh1fkVigcZH7GAmbr8btshuU4jUgt+Z6VjkjTFHXJoFhLpiE0ZWFo=
X-Received: by 2002:a17:907:72cd:b0:aa6:b5e0:8c59 with SMTP id
 a640c23a62f3a-aa6b5e095bbmr31006466b.35.1733886222741; Tue, 10 Dec 2024
 19:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-bpf-selftests-mod-compile-v5-1-b96231134a49@redhat.com> <173352303103.2814043.17875547914996700881.git-patchwork-notify@kernel.org>
In-Reply-To: <173352303103.2814043.17875547914996700881.git-patchwork-notify@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Dec 2024 04:03:06 +0100
Message-ID: <CAP01T744hWcg5i6eShqCUnxVV4F+GJ5cwYN8qVkDVEhzs7ybOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Consolidate kernel modules
 into common directory
To: patchwork-bot+netdevbpf@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, vmalik@redhat.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 23:10, <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Wed, 04 Dec 2024 14:28:26 +0100 you wrote:
> > The selftests build four kernel modules which use copy-pasted Makefile
> > targets. This is a bit messy, and doesn't scale so well when we add more
> > modules, so let's consolidate these rules into a single rule generated
> > for each module name, and move the module sources into a single
> > directory.
> >
> > To avoid parallel builds of the different modules stepping on each
> > other's toes during the 'modpost' phase of the Kbuild 'make modules',
> > the module files should really be a grouped target. However, make only
> > added explicit support for grouped targets in version 4.3, which is
> > newer than the minimum version supported by the kernel. However, make
> > implicitly treats pattern matching rules with multiple targets as a
> > grouped target, so we can work around this by turning the rule into a
> > pattern matching target. We do this by replacing '.ko' with '%ko' in the
> > targets with subst().
> >
> > [...]

I don't have a good way to reproduce this yet, but I'm seeing
intermittent failures after this patch when running vmtest.sh:
make: *** No rule to make target 'test_kmods/bpf_testmod.h', needed by
'/home/kkd/Projects/linux/tools/testing/selftests/bpf/core_reloc.test.o'.
Stop.

I haven't been able to root cause today, but I will probably try tomorrow.

>
> Here is the summary with links:
>   - [bpf-next,v5] selftests/bpf: Consolidate kernel modules into common directory
>     https://git.kernel.org/bpf/bpf-next/c/d6212d82bf26
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>

