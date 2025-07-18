Return-Path: <bpf+bounces-63778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF5B0AC72
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 01:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA01C2645E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 23:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAC1E8322;
	Fri, 18 Jul 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fa4AJsKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA48222578
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879909; cv=none; b=HlPjghBLqe5O3AtMRR1sKReg1CBjKGpXT/iTcLjen95fbE3I+q7Vh+Ky+oHC1+etB9rOaxazwbyFA2UpUZUzGc0xgjkPutYAU/OC78KGSuhsWPwD7gS0dVKaN+0z5lfuRosBSseo1RWEUq8KmmRhVuNgDfCmxOOMSMxPWU3lrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879909; c=relaxed/simple;
	bh=H40tep0Rv0U6gqMR0evT7Pj2Me2Gk77w4/2xIDdHb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeqpwWdPolMqXUWym8L/8KtQSj/p+p2Ii0Ed2JebX8rpk4K8YuARuoBhGGHPJ34/0a7/PzZqwv7kxeHjc7L0d/u0SaXYgSwMly5Se09mfOq1xyelKVl8JPCG9+amebMd9czLbIjfcaQnb9X6J6/6XW6/qzVYht8xtXkbvak9uhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fa4AJsKw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso4454414a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879905; x=1753484705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=Fa4AJsKwQCE3RO4IY2jB6MGjunRv8OrwVviE2uKJ/1veN9Ivf594SCUUH8NSmmhjXz
         kTuN9P3qVcaBnJGsMQidK5X8XQGPJgU4XoMP/k/nrI6myS6t3MXvoOeQzQ7rS5RI2Jg1
         bpAYtteuI65qX1+eomwWhPkj4KvyLllwnHIDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879905; x=1753484705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=cRLjMWS/N3iknvPkrT2B4A+BuDstji0cvvSzKgUKjbWmYeUm/QBA6NMV8Hkeo5JOpg
         ecA0F0iZ0kqqqjAf9pG8XUEbayVkehPtExEHQwvWfLka7kho9C/5ZeT7tCaWd+u+UZeA
         mCogx1jO/ba7IMPZpXl+X4hiXRTsI+emJMUdKnZVzKt5diope3KhTHwm969POzfowKWD
         7p30p5b/FIgio2C7kDxB5oSlf5+/89KwafuHBLxL51I+Sfgx7ByrbRZNoPPtP1fodc1x
         JSWGFaTctk0CUS2B0+9ZoT+DP4/4JtUqK/ukF9vnt6nysA5ry3KJS5GWW1aNswQoVPJf
         HkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCfEx0E5npTgSSSXnfhBBvE+qHYSpT4bl9Ygld35Cs/BF3FmJoRcmz0h9XceF2s8E3igs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUUal5ekNnyqzsAaYq/+M95+x8jk7r0RyRSj49yoWN/cghVQO
	aKW8zCnBpeoxgvAolZdD/t6p0aZXszFPE3aN9K74A7BLV++DQNE/Gd+fDC28w5pw0kSBEjDXFeE
	BDMT0wJA5zg==
X-Gm-Gg: ASbGncvwzCaJdSv+3w9syFmfR9mff2sdu4VZ2VbVW7rtaPe7/MWAuCRXnrBSvivB2Vt
	0+9sIuoVCovToHvI9yE4/1Ifw/XvnpCVSbFlXKiPgwOf50SXWEsWx5foa7cKz8ngwpSCnsyIxH2
	pJOEL4ETnaD0Xe1JBzzNJJvjSXOzq8Ym2FyF7sYTC9A9iP3ZdG+0PKn8IY3G3lgLhB6WpX4r7tr
	M/vzF5eWmTAaNWc7RBatuFsgSmuBykcf8yS/BFvzhFe/vjVOyFuyQwGHamKFsEv9dFei7fTapRL
	XWpb4ga81IVxBIhFWRKTgnoxdN57rBij1B18MJY7ColJ8Wy1dmuVDZoTrCc18PoPZZZuupJNRCL
	m6RpoNWYdO78NXaO6WAI2rRnJu8In4wXZaxs+4IqnAzyKDnAZ6ZXLeYXHdI6IHZ7ZEqzUkeeb
X-Google-Smtp-Source: AGHT+IHimNVhpwo6cpcwxnLi2yKhijU0/4uAxZ07+s+QyFy1NZfXgLCcmrIh/g8WbRwkUWGC3NWjPw==
X-Received: by 2002:a05:6402:1d55:b0:612:bc52:a93d with SMTP id 4fb4d7f45d1cf-612bc52abcdmr5519622a12.13.1752879905105;
        Fri, 18 Jul 2025 16:05:05 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c9074a11sm1631416a12.49.2025.07.18.16.05.04
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 16:05:04 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2396778f8f.0
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 16:05:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSTMu5494n6m6bjoKghvVCh0Qi5g3jKWtiah1Zz6JqUm6ypvUlabZ1gFrDk51ZXWOf8Gs=@vger.kernel.org
X-Received: by 2002:a05:6402:510f:b0:607:6097:2faa with SMTP id
 4fb4d7f45d1cf-61281ebe074mr11282976a12.8.1752879516873; Fri, 18 Jul 2025
 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com> <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
In-Reply-To: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:58:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
X-Gm-Features: Ac12FXzEvcUEKGC31NKbtJTOHrioow4MaXx8l9_sG1eUWxP_1nSQ3xv-ujuWcb8
Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 15:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And while looking at this, I think we have a similar mis-feature / bug
> on x86 too: the unsafe_put_user() macro does exactly that cast:
>
>   #define unsafe_put_user(x, ptr, label)  \
>         __put_user_size((__typeof__(*(ptr)))(x), ..
>
> and I think that cast is wrong.
>
> I wonder if it's actively hiding some issue with unsafe_put_user(), or
> if I'm just missing something.

... and I decided to try to look into it by just removing the cast.

And yes indeed, there's a reason for the cast - or at least it's
hiding problems:

arch/x86/kernel/signal_64.c:128:
        unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);

arch/x86/kernel/signal_64.c:188:
        unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);

arch/x86/kernel/signal_64.c:332:
        unsafe_put_user(restorer, (unsigned long __user
*)&frame->pretcode, Efault);

The one on line 188 at least makes some sense. The other ones are
literally hiding the fact that we explicitly cast things to the wrong
pointer.

I suspect it's just very old historical "we have been lazy and mixing
'unsigned long' and 'pointer value'" issues.

Oh well. None of these are actual *bugs*, they are more just ugly. And
the cast that is hiding this ugliness might be hiding other things.

Not worth the churn at least late in the release cycle, but one of
those "this might be worth cleaning up some day" issues.

              Linus

