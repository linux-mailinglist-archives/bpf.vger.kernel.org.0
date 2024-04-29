Return-Path: <bpf+bounces-28144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF48B61AD
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07E11C2189E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2F13BC0C;
	Mon, 29 Apr 2024 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RIJCEvno"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EE13AD11
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417650; cv=none; b=ZnZgjOkkAy9Mz72zfEXMbtctx5+P/tjfy7DN0ZpJx370aEUDTNYkQy1veOLkvCrWGx4LQIIxg6o8feSrsw1FEEKehubAnIspi9rJty5FmNlUCYIyY2VTzPqcDYzTOz7DSY9CUB1ybepcsXivKmsTqG7xLgi08xSCJ++SquOXHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417650; c=relaxed/simple;
	bh=xZ+i34Cf2kb3FAwoHPMUHPU8QtuIKuYH2rbGEJRg9XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9hzFEGsWIhU3vlPn4/TMq7CSIQ+pQiy0uTYknk9zYN6ctgtohuJHyN67v5sTjogKAHQNmYsdIpUnp3jlM2/5pau9J7N49ynXJCEmlV4+8EY0GZSZNvZP3XDaCFSRYWRzr12oq8r753lgt/dRg6dT3D41D8b1fEUWXoNzby9Tvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RIJCEvno; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55b3d57277so586131066b.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714417647; x=1715022447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=va/hNt/iM3MNb7CVvLz718YlZI1otzVGYYp14TWrAyQ=;
        b=RIJCEvnorWuRCzBJh6lcWJKdKiiEIMJcSlt74LdQ/6ezaMoOkc9C9Fonz2KdzaupKM
         /rFXQPrdyPTudcs7mWK7m46vmd5ud4CKzdbNjuc+k3wGe3nsvFageRuRC/WNQjQDZ3/8
         SySiG79kcpFiV8ZSA7p9OwSS4JJOQ0NZjobms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417647; x=1715022447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=va/hNt/iM3MNb7CVvLz718YlZI1otzVGYYp14TWrAyQ=;
        b=NvzjerMVP3FJzbcUsjHkHBrYDObCLe8L7QndmqEFrGA7OQRpduetoClyDxZwWjm9uM
         3tH4cV4gWdeQfqDj7/dCM9jd2hajdPEwwZ9jq5FidNjQuuQg2oULg9LPKTa6h/G7WHr4
         aQc5nmi5y+gRLQHSIp2LlnCwNbIMQ27cz6xjcoUrWGTvKoCsdUfbDhsDyVZNDvq2OyeS
         5ZXNP3ZaJo0Pj40q+HmtNSmHw4ozgIeBH/HcQgZJBthpBFoUeCXtc2E8/Hu0zkpV1V5X
         njyoPPcOGSEqwZ6lbMl65h7NtP0Vm/+Gq/q5DNuuFUkKra1fzVbDVDhAVuapwnai8pSt
         NE2g==
X-Forwarded-Encrypted: i=1; AJvYcCUrZ8BiHghQlOVd4rncepUnOiJklI8xkhlnoNopXpIdgyuvsIr6aRa0do7BcDyOmEliM8Pj2C6Zwja6wVtHJWhA2/B6
X-Gm-Message-State: AOJu0Ywydn5KI9pTinrqfK3lunWkxjW0Cyj9bEGz24VKfZCgMk/carWQ
	bcwu+0zWx0N9oqHQD1onTDE9rCpHS/HtyVUfKAKozg9Vk/qaeJ9nXXnWfNVL+2n7bK3IQv2hSST
	zgAVBng==
X-Google-Smtp-Source: AGHT+IFnNq2GSaAdyqb5fw3G+t8yFqFBb7YsiaUJWjxDrwMI9XMAOivPsM2MUyiw83hPCly2o6kiLw==
X-Received: by 2002:a17:906:4a52:b0:a58:73ac:8b29 with SMTP id a18-20020a1709064a5200b00a5873ac8b29mr7098054ejv.64.1714417646869;
        Mon, 29 Apr 2024 12:07:26 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906311100b00a5599f3a057sm11528111ejx.107.2024.04.29.12.07.25
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 12:07:26 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58c89bda70so416363166b.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 12:07:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU32QtzCJx/2dCSOPPt854wvUqEMt6X7mDa4VGYJPxHT6mVIt6qChU+KtExdG1i5uBP0mceh9ZPRu2EdxN5XoNUaPhx
X-Received: by 2002:a17:906:12c1:b0:a55:3707:781d with SMTP id
 l1-20020a17090612c100b00a553707781dmr6853559ejb.73.1714417645239; Mon, 29 Apr
 2024 12:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com> <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
 <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
In-Reply-To: <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 12:07:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
Message-ID: <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Ingo Molnar <mingo@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 11:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In particular, I think the page fault emulation code should be moved
> from do_user_addr_fault() to do_kern_addr_fault(), and the horrible
> hack that is fault_in_kernel_space() should be removed (it is what now
> makes a vsyscall page fault be treated as a user address, and the only
> _reason_ for that is that we do the vsyscall handling in the wrong
> place).

Final note: we should also remove the XONLY option entirely, and
remove all the strange page table handling we currently do for it.

It won't work anyway on future CPUs with LASS, and we *have* to
emulate things (and not in the page fault path, I think LASS will
cause a GP fault).

I think the LASS patches ended up just disabling LASS if people wanted
vsyscall, which is probably the worst case.

Again, this is more of a "I think we have more work to do", and should
all happen after that sig_on_uaccess_err stuff is gone.

I guess that patch to rip out sig_on_uaccess_err needs to go into 6.9
and even be marked for stable, since it most definitely breaks some
stuff currently. Even if that "some stuff" is pretty esoteric (ie
"vsyscall=emulate" together with tracing).

                  Linus

