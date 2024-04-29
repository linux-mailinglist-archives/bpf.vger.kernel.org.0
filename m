Return-Path: <bpf+bounces-28140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C028B615F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D971C216E2
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB213B7A4;
	Mon, 29 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QNuqpqc7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5613AA39
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416482; cv=none; b=ucqysdSE8VpHoGpdnipEVpZ7K6ZOg2T+JBwc8BfOhq1k9NnCFDrr0RygvM8VXbEfUfNjortkk1J5MxoD7s/heOjklZgEhsNFbGQiXGfgTdoCBg97Ez6rF836022RpdZ3hzIJv2PNSsinjpXe0qItqL12wnNI5TSblDSvvNHFPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416482; c=relaxed/simple;
	bh=u7kw+FkzxObVPiQnaVCOnkmZSnrlks2HiY7Vm3Bnv1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcNEQos/Vx4a365KB/XNAFkxG95wbTbm6yfIUrNRkQsnuwCPgTgVoLVWtbUoycXDg4ggVY6hG7fVw7CAT9GPLKKis0Sn8R5qhMrNhAE8LrqQ1zposmkD5mRVvmPPk7iGTY/ts9mtyvI5t5ppjNc7o6HOAqsIe8Bgk16fRqEM9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QNuqpqc7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51b526f0fc4so6040159e87.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714416478; x=1715021278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gYXEmIPmKlUCv4MlmDP09ZBKONhIZhGPFSWq4/CxW8A=;
        b=QNuqpqc7MZiW3zymXcmJ8YgRB+LOc87CAuDuZ+W7xJyKe+fwYcztXxTDb38aw5rv72
         0JXtZC5ojVMR7qjz8JSROu3AZh4BRIxPU710+0Vyy7RICQIwCHFGH8a6nVxr5kyYXgFL
         hhnrTD4zdkS3Wph0m7Y5LtzDBjQ2GZ6Sq2nZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416478; x=1715021278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYXEmIPmKlUCv4MlmDP09ZBKONhIZhGPFSWq4/CxW8A=;
        b=V3dE9QO+A8z9xVjaelPsJkPwR2twIqM2tPB4Kzsn3B8FV7fMvYZQWWwlHQJbsAZtDD
         iIPwIrQ6SvTnFJ9fM9e2XWZrqCeuPMme83djr2kg7osrzYWh0gkjz1cYDzjrgDu61L/r
         MJaC4Dq2u1OJeNoM9IAh3gUfJsRvz8VbfMO01/uQ3domB/nDV0NnjIRIybTx7L523oEr
         PZDn8wXCks/buZC0Om1X2jaWbOk7XxEn0FA9a2UYuZliLOpCCthyGhmoldHeWvDPTu00
         bHBRIpKcgy3Je0CWlPX+OKhAcZ9opIB3Mn6WVyqpvEYpo32IgW8ISDgT4gKnSSeQn8dV
         xNiw==
X-Forwarded-Encrypted: i=1; AJvYcCVC1W7rodcqpSq8AOFGHev5B3q5v/ZfYCqTDWV8XTCnYm5+kezYv43b6S6RizawfTk1TtXIDdS0O3NnN517GN+5EvrA
X-Gm-Message-State: AOJu0YwSgOYfeTVlq7017ItuNV7drve5mptx8d9HozA2tfo0Plv6WTiT
	OePjtR+OgWt3C+noeesCZD89kCrczD40XWxIi77FHBbebUZIkyBK7415Ok/RLq1dKdY3GkOP61n
	rIfykSA==
X-Google-Smtp-Source: AGHT+IEvHEkEgLWUU8WBQCA2xtaBeT0qqGgNi1D27oJWtpfGPPq6xtdTbnns2IaBkKfJUKDsB+0cbw==
X-Received: by 2002:a19:5f45:0:b0:51b:58c7:d050 with SMTP id a5-20020a195f45000000b0051b58c7d050mr296680lfj.33.1714416478261;
        Mon, 29 Apr 2024 11:47:58 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7cc97000000b0056fede24155sm13321347edt.89.2024.04.29.11.47.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 11:47:57 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a58e7628aeaso291742366b.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 11:47:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW29nd7xtao9pU5jkh4DQ9Lbw3rjFpPsGoihQFNCoiNfY5dAAaG5XnfUxan1Y6JEsCGjOLzhqZJpz914hrWcr8W6Vfq
X-Received: by 2002:a17:906:c252:b0:a52:6fcb:564a with SMTP id
 bl18-20020a170906c25200b00a526fcb564amr321186ejb.9.1714416477325; Mon, 29 Apr
 2024 11:47:57 -0700 (PDT)
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
In-Reply-To: <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 11:47:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
Message-ID: <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Ingo Molnar <mingo@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 08:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, Hilf had it go through the syzbot testing, and Jiri seems to
> have tested it on his setup too, so it looks like it's all good, and
> you can change the "Not-Yet-Signed-off-by" to be a proper sign-off
> from me.

Side note: having looked more at this, I suspect we have room for
further cleanups in this area.

In particular, I think the page fault emulation code should be moved
from do_user_addr_fault() to do_kern_addr_fault(), and the horrible
hack that is fault_in_kernel_space() should be removed (it is what now
makes a vsyscall page fault be treated as a user address, and the only
_reason_ for that is that we do the vsyscall handling in the wrong
place).

I also think that the vsyscall emulation code should just be cleaned
up - instead of looking up the system call number and then calling the
__x64_xyz() system call stub, I think we should just write out the
code in-place. That would get the SIGSEGV cases right too, and I think
it would actually clean up the code. We already do almost everything
but the (trivial) low-level ops anyway.

But I think my patch to remove the 'sig_on_uaccess_err' should just go
in first, since it fixes a real and present issue. And then if
somebody has the energy - or if it turns out that we actually need to
get the SIGSEGV siginfo details right - we can do the other cleanups.
They are mostly unrelated, but the current sig_on_uaccess_err code
just makes everything more complicated and needs to go.

                     Linus

