Return-Path: <bpf+bounces-67018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D77B3C194
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD203AA0E8
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB833A03D;
	Fri, 29 Aug 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVCZqOMX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBA33A010
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487637; cv=none; b=TdPuMA/c8kD/Sxibq3RcSqDGb+dMtGlTuoRB2628ySFjKGYyraz60fETTy3uBsQDWp8jlNfgI7ou6yibiVCyanzenItiOssw6Ch2KVnecafI963Tx3z14kpGaR9o6xKDadI91OLnC8Auk0t+hUg0OA4qYPp+3Dpz2nNPTG57MWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487637; c=relaxed/simple;
	bh=iHb9WdSbAWsQISH5SeW0HmAsw6mcHOltHvAyxrfR9Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCyPtW3E0NOkSaeqQ0RzvRkah1nJTm/g/mJm311Fo/ZgLZjJondpnPteh6XLsBgnRuEZHH2u4u5WOZxLhk7u9kBgA0+h1UQCiP8+FnRnCWBBQT6imqTtwmULzeHxq9adgya+JGlV405Ige2IZEL8o5gXua/nRdOzj5zU6PAU8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bVCZqOMX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so2953654a12.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756487632; x=1757092432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKGIjOYE1ze9iH1dgqLKf8Xyy++WiMU+AjEh9bVOYgA=;
        b=bVCZqOMXZSYmZlyZ/7dEJk4j9UZNb3JUk/4cBlq1kM6F2x0TepqBeERJUPxx2HYNvF
         S7Ldxspw4D2RfgSRJ+PJcWU27HHyn3zWLDZZ2PpN77vQCmIr8Ni5jGY1WSf+w2a3oMgQ
         Su3xS4HQPRI88oFFOIGsE1CKr53pWYowYGnLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487632; x=1757092432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKGIjOYE1ze9iH1dgqLKf8Xyy++WiMU+AjEh9bVOYgA=;
        b=tkZCAMQltEgE+NmcsykqRF97iPoGDIgfK0HsPcgPlR14fu/lk12nraO7rLBIkoZTdR
         xuL2/TFqMq58H/8rRAsgf5FxqmLRvCqfn7T4qewJXPIumGQRjHVUb6uv46dHvhW4aoTL
         R9rcIwFZyLKnrKiDo7tI8UV8AEp3Z7Dy2s/oms6/WoBbl2/2nlF6Z+n0EBHds7//3q+y
         vKK4/HI6qG20EaOZmsSLYYxhJR38RYjGT/TXCvA2HaNrla4AePYot+DsRPXkYzSj52k3
         xm3pVEJ/zKfouw5wxI3hdzGl0J8ss7nsf4bUSH5gokj5y1y12Pvze8W6SyIDGZVKK0tw
         eGDg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwtEituO060hJsYno7XaA55FK8xlA5jaIQ2uGTcJxqZc6J0JUgFDy7Q8fxCwWhVDPOic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHOl73NCiOV8hmpw7/u8VFsMtXWvIPbndAjRaPsRF0IiLCNSWa
	YqxuAW5g0C6+5yLtxPHMBvSejl2c0TTlX1sSvMmxCTFI+4ciWLX7GbstZ9vqZc65HBtLBdxrTTK
	A4Htc3MX/PQ==
X-Gm-Gg: ASbGnctCTKHVPU0hjzMMnVo996pjHlMIbr7Fd5IAvVqKubMO/VdJVm3N1u/bhd88jTC
	DVpelMPtKaIbpLbQf2ITRJ3FAwd6FTPr+yqjfZcPLTObb23+phMiKDBGpQd26ghmBiaVpZ6a1EK
	bSsEZpYcsSFFW37SiJ8x5JR1VUtaN1hNzGfhCHQVDYeNTcoshEEQeTXg58Xm3PDH13+hT0UGTil
	bs2YMh5XFCtN6/OOz1gYys7VI1HBzF+r2aXPeHmwzVl+GljJbB79FiR5iAijWTtKtwrb25AMl+E
	bo/PYFo1HgsKoXvA/vCIwr9KE9LRpDZjNGgyGcUy5xwSMG1H7RJuo0oAb8DoZYSDkxuyhV2tIvZ
	0U1e8CRLeRtNy/H/XmUPsBsjOzLQJJk9tGI9NfR5KFezslCF+sdoCz6oG3UYN9NhiPvt/95uyWm
	rg8DXmZ4I=
X-Google-Smtp-Source: AGHT+IGGkOVdddxU6NbzdE/O5frUqOEK2LOGOhHHeWc/V6hav0mw4TqVV76VAmaJ2nrK6YP6x0l2lw==
X-Received: by 2002:a05:6402:2786:b0:61c:8c63:a91e with SMTP id 4fb4d7f45d1cf-61c8c63adfamr12327868a12.25.1756487632252;
        Fri, 29 Aug 2025 10:13:52 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4e1a47sm2058159a12.35.2025.08.29.10.13.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:13:50 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afebe21a1c0so382699766b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:13:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7tF+fjrE0TrWuWNV+keEHY7O/yxJxmAhV5DUwa6sHRgO2iXBEfEn9XiFXTIqC4C+B7aw=@vger.kernel.org
X-Received: by 2002:a17:907:9410:b0:afc:a190:848a with SMTP id
 a640c23a62f3a-afe2962294amr2593662266b.60.1756487629636; Fri, 29 Aug 2025
 10:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com> <20250829130239.61e25379@gandalf.local.home>
In-Reply-To: <20250829130239.61e25379@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:13:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
X-Gm-Features: Ac12FXzOUr821UWDaFJ2PkQOv_cHIiiBd9eyjGJVTqCl8VoWLaBc08lTL7Mwpbc
Message-ID: <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 10:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, the ring buffer can be mapped to user space. So anything written into
> the buffer is already exposed.

Oh, good point. Yeah, that means that you have to do the hashing
immediately. Too bad. Because while 'vma->vm_file' is basically free
(since you have to access the vma for other reasons anyway), a good
hash isn't.

siphash is good and fast for being what it is, but it's not completely
free. It's something like 50 shift/xor pairs, and it obviously needs
to also access that secret hash value that is likely behind a cache
miss..

Still, I suspect it's the best we've got.

(If hashing is noticeable, it *might* be worth it to use
'siphash_1u32()' and only hash 32 bits of the pointers. That makes the
hashing slightly cheaper, and since the low bits of the pointer will
be zero anyway due to alignment, and the high bits don't have a lot of
information in them either, it doesn't actually remove much
information. You might get collissions if the two pointers are exactly
32 GB apart or whatever, but that sounds really really unlucky)

                Linus

