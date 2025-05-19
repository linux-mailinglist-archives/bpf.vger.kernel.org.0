Return-Path: <bpf+bounces-58484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB9ABBD9D
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 14:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D4A17C7EC
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03027603D;
	Mon, 19 May 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/d+BuwW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C826B2A3
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657272; cv=none; b=d2q2Zi41eQ4sZuXOoZ0yTgOfA09E19yiHZhopbAaqBrqU3IFWOdjLOGTBqSVaK5SudcnhB6NDMWL1MtISu5q8HlZ7Nj/CPWI3fXsMNcjfyQ3GowWVMcgjZMORWGIzI+q/T6hxEvsobIBhW4T9Nz3oK2Hj3Zn08sZWsI+3KitJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657272; c=relaxed/simple;
	bh=To0JIFtvvxzRNcDulugp0LXK/RzLZlaqo/azdacxVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4fZGtPzg6UoHYFGKxttctnwnjRSnlKvkR83dnLbeo/qABhcFRhUSLZoqvGg5ul1BpiSfshqQctn5y6QMvAZshJ8TdTMpU4e7HG7NMB99km8fsizlfRSfSlw/5zE0cX85kUyCeFPysciIsyFUtWm8QXb0m7O0XvIoREQUF2cD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/d+BuwW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-443a787bd14so14539255e9.1
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747657268; x=1748262068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0jP5w38JlnObNDoqQV+EB45Qrrl0V0aAiXxvmWFpZP0=;
        b=d/d+BuwWTz1KdJ0vm3ONuS412c6oaIMHyEVRSnvXeR3uBjxqPxweFgEv2j3iFlOicI
         eMEltqRTuUOMS4gwk8tpMt6mOYsh31TmZt1CqqhrKM+7dSqKXI5Ow3TOFZZ2G+DLL9T/
         FikGtIWN4ol8k8XVinA5fRqSit+ATSOuDya7shlfTPTf5MbdPvcQTWaT74ASu9MLhWWP
         BGiP4+y/hGG4klG9CMMEiCAg8YVg+sGG2Qd4TnNY4l7zCTUgfPLtWrJh1qj8cIDvz9jG
         HconKEQtiRrU88CGpWAvRixidxHJrBndN5JUyYRNcA775W+gUBMWe0i5aOr0zOkDEX9I
         YCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657268; x=1748262068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jP5w38JlnObNDoqQV+EB45Qrrl0V0aAiXxvmWFpZP0=;
        b=cinhSIQgl5tc1VaF8pQIW5Y9kd8YG0Pr0U3hJu0iK5sHqaU2MzpicNp/Ih10W7bOl2
         L6Uy4BK7ueV4/SLVvzF2AZySb0blRASSlVGQshcM2CyhhPPPFw7GXcvrCZArT/tz38XY
         x3h+Yw7/VK6TuqLm0G6aid9qYgHGLVDEOcPn7ZIZuKG8foejjlnpk+KkFSe+n3cJollp
         qOk/+lHc77brjhvPySCxx25fg6sLmyRSOWroyWebdcynz3s4/BYGmeuRyZU0qstSBAfc
         oJpIfWJgWirZd/BtXIbAaTyFpg7cHJvBtSg6OBZ3E8EhedIElw3k5BVY9EBgwShpV0I2
         w8Vg==
X-Gm-Message-State: AOJu0YxJEcZ7PMp6/+qs1mR7CHrF17uaUiEw5iZa8VrLsP/6HWf8t1ku
	3+7I80fTgpUhGT8HnAalKqtcpGSmksnqae4VDcRTQ6Gw0qc/fUx10yCL
X-Gm-Gg: ASbGnct0GVqJ8E+G/sQGLMQ/9/vV+khnJPjwRaLV3Si0PToHTQsAIWX4k5qQ5NbJYA5
	iGVW2jnjqamF88uRZMSaNSJKWotLuZtIq/x5yIc7n50iU9yNx/XiPYuo4+w7YYTyGU4B04XNCSa
	bjAA1Twpqvd/pC3KMOtwVOl63a1+PA2yFR7aKY398IGw6kAvkW0iL0G2ZI9xpO7OeLB37P3arat
	dHIvXHW8+RKswVf1KyuQBu67UgaAaZP9bxbnMaSTygWEj/knPRCGB9sX1KxteMqHK8VZuu07wWn
	gV7qRHpvEQHX6uqMJ0N5ccwhVptMEJh1LRss9FQmhZ2i0du2vMFfcG6xVZkzuN+aQad0DPNDz5H
	E45kxuLyfvIJjH6IuVsKvy0Z5da+s2tC1bDjOsUmTm6RPJITjNA==
X-Google-Smtp-Source: AGHT+IGBLpMkd2cLBU+c8ffXlikj7OqeTKAvyYAFuyWQSyw0lZS8QoDtvQl50kYhv3pb0XNqZQOIgg==
X-Received: by 2002:a05:600c:b8c:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-442fd97a50emr114547665e9.12.1747657268172;
        Mon, 19 May 2025 05:21:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b63b567e7194705b.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b63b:567e:7194:705b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33691f2sm208295955e9.3.2025.05.19.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:21:07 -0700 (PDT)
Date: Mon, 19 May 2025 14:21:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v4] bpf: WARN_ONCE on verifier bugs
Message-ID: <aCsiMSy9Ty8Fg6AJ@mail.gmail.com>
References: <aCcGpxnlfOOiOJ-b@mail.gmail.com>
 <CAEf4BzawwGq7A+DGUYmj_xpKJHDnqPWR=nbOzL7Vux1kqMODXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzawwGq7A+DGUYmj_xpKJHDnqPWR=nbOzL7Vux1kqMODXg@mail.gmail.com>

On Fri, May 16, 2025 at 09:14:40AM -0700, Andrii Nakryiko wrote:
> On Fri, May 16, 2025 at 2:34 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > Throughout the verifier's logic, there are multiple checks for
> > inconsistent states that should never happen and would indicate a
> > verifier bug. These bugs are typically logged in the verifier logs and
> > sometimes preceded by a WARN_ONCE.
> >
> > This patch reworks these checks to consistently emit a verifier log AND
> > a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
> > WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
> > where they are actually able to reach one of those buggy verifier
> > states.
> >
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> > Changes in v4:
> >   - Evaluate condition once and stringify it, as suggested by Alexei.
> >   - Use verifier_bug_if instead of verifier_bug where it can help
> >     disambiguate the callsite or shorten the message.
> >   - Add newline character in verifier_bug_if directly.
> > Changes in v3:
> >   - Introduce and use verifier_bug_if, as suggested by Andrii.
> > Changes in v2:
> >   - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
> >     CONFIG_DEBUG_KERNEL, as per reviews.
> >   - Use the new helper function for verifier bugs missed in v1,
> >     particularly around backtracking.
> >
> >  include/linux/bpf.h          |   6 ++
> >  include/linux/bpf_verifier.h |  11 +++
> >  kernel/bpf/btf.c             |   4 +-
> >  kernel/bpf/verifier.c        | 140 +++++++++++++++--------------------
> >  4 files changed, 77 insertions(+), 84 deletions(-)
> >
> 
> LGTM overall, left a few comments below, please take a look
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks a lot for the detailed review!

> 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 83c56f40842b..5b25d278409b 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -346,6 +346,12 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
> >         }
> >  }
> >
> > +#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
> > +#define BPF_WARN_ONCE(cond, format...) WARN_ONCE(cond, format)
> > +#else
> > +#define BPF_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
> > +#endif
> > +
> >  static inline u32 btf_field_type_size(enum btf_field_type type)
> >  {
> >         switch (type) {
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index cedd66867ecf..7edb15830132 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -839,6 +839,17 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
> >                                   u32 insn_off,
> >                                   const char *prefix_fmt, ...);
> >
> > +#define verifier_bug_if(cond, env, fmt, args...)                                               \
> > +       ({                                                                                      \
> > +               bool __cond = unlikely(cond);                                                   \
> > +               if (__cond) {                                                                   \
> 
> this might be equivalent in terms of code generation, but I'd expect
> unlikely() to be inside the if()
> 
> bool __cond = (cond);
> if (unlikely(__cond)) { ... }

I was worried the compiler may not take the unlikely into account when
doing if (verifier_bug_if(...)). I checked with a small example
involving a similar macro and the generated code is indeed the exact
same. I'll stick to the usual style, as suggested.

[...]

> > +                                                    bt_reg_mask(bt));
> >                                         return -EFAULT;
> >                                 }
> >                                 /* global subprog always sets R0 */
> > @@ -4299,16 +4295,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
> >                                  * the current frame should be zero by now
> >                                  */
> >                                 if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
> > -                                       verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
> > -                                       WARN_ONCE(1, "verifier backtracking bug");
> > +                                       verifier_bug(env, "unexpected precise regs %x",
> 
> "static subprog unexpected regs %x"
> 
> (note, user is not expected to really make sense out of this, it's
> just for reporting to us and our debugging, so let's make messages
> distinct, but they don't necessarily need to be precise, IMO)

That makes sense. Considering this, I went back over the four identical
"No program starts at insn" error messages and tweaked them a bit based
on context. All error messages should now be unique.

[...]


