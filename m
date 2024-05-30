Return-Path: <bpf+bounces-30951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3978D5098
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CA283F36
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94BD45949;
	Thu, 30 May 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FTeqwjxX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BD44393
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088974; cv=none; b=YEWbcdl4iIOmkHRRFEkrYUDyx89SU//DtgK3aiSJfk4bG9nSdtiRetKtI8c7B2G7D2JPmoBg1YDuKbOh/YxlIHRSBoAXirYPQb+52dAYHdRVeyPRyvDTPkDezdTARNMEbAi6mF/J2Te9ENQrYf6Mz6LnXIDFhgjFrNumd6UgJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088974; c=relaxed/simple;
	bh=ISMBEGYvs6Ggfh4zAnluIkAqOvgPIgi6xlOIbBfiDjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5cNNq2fQjSHYa0qfTJKlk/Ji0YX80XlUP3MEpEMjl79KtTWCm9dlRAlxcvn1dpLXbhExsbIy/h0ruyjyIa0BnKfz1KuEKPCnvxn2sbHmtWSWsRtsBPhD9RSUwjNiL5yW3skHNGOOKq1On44w7sPh46CB7j89QQLc9g6SvhZkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FTeqwjxX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57869599ed5so1349537a12.2
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717088969; x=1717693769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RbDTER8Si5DdP/iY8qDxMi4BdBirbgu4Xhjb4Zt2gM=;
        b=FTeqwjxXnQScjYPlUQLbTu3nbZs3NOLu+MD6M7uyDZPuAR+tvBCGta6QBxsO5V/dV0
         zAeBFbiEYDl2o71e/m0XFVFV861362YluaxYDhI0jJxj683NKLl98N3FW/tkq1MjdKnU
         enZEAygp7OYIFGeUUxjaLivCd/2lJPCQ3mv4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088969; x=1717693769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RbDTER8Si5DdP/iY8qDxMi4BdBirbgu4Xhjb4Zt2gM=;
        b=QiGd/WS+tHbutOKxnlXes5jber5c1m8Iog5fKVcLYOIHJnFYlvSqHzWhFfYk1siddK
         nLXrUHeDU90LAig5gfnK6T+dW10CoxsefSbgVxyFa+m2oVS0mELoUyC9xNcYFikXIccK
         c+pvhpG3d69g/P5pg3D06WECdp8B2Q8qYwB0mYsON2udHc3D6ZRMwKsJc3NidpSjuc9z
         3qsECAsWrMG9T36ZCBLmKjw5PglcDkTR3/gT+ZdLvLBxwLfg451glH+mX3zv+aOtMMbA
         nU6LTLgbMrq5Urzbe2H+GKfE3jsDYAnQAa8mWGV5VJg+HrDyFT3A35/DgIJ48gYmF8LC
         3HAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrgQ3ZRnW8w6hzbUbaHcAvwn7U2qsT/U4ShnKKmHP2VkCi3EMnIbEQ1pYahwmKcqb+NU3hErGDu2FT1VAFN8iCAS1Q
X-Gm-Message-State: AOJu0YwryGouGD9v99ik8K8idLZR/3RLBva6UkldjkFaHzILVCTap/mx
	Ucy4Nyu2rSgnj33fuEK2IgKwT8a4r7uVrgDZ84qgFvi+rdoLJj1TdBbm1WMDNrI9LJ9LkVQtKWs
	zRNLuUg==
X-Google-Smtp-Source: AGHT+IGd0KEyQIUSRir5Jxm4tx/KSY9C9CcOriReracHSx+sckPEHk9/cGxoHiOvj2tGCNthnye5Ig==
X-Received: by 2002:a17:906:cb86:b0:a59:a431:a8ce with SMTP id a640c23a62f3a-a65e8d2303emr190349866b.2.1717088969081;
        Thu, 30 May 2024 10:09:29 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c97a029sm844109366b.93.2024.05.30.10.09.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 10:09:27 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a23997da3so940511a12.3
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 10:09:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMFn2eQ5OPaTcXMeb41kowyru/ixawqUZj6V0GGTRDxP+C7BcyIDUqNcUg9Gcqk74oi3707Qc/+JE30UlYyWIZuCsK
X-Received: by 2002:a17:906:1c92:b0:a67:8fc4:7ad1 with SMTP id
 a640c23a62f3a-a678fc47b48mr22998866b.63.1717088967176; Thu, 30 May 2024
 10:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zlb-ojvGgdGZRvR8@gardel-login> <Zlhupe1tXj8ZS1go@krava> <ZliKX5EOU9eWhd2U@gardel-login>
In-Reply-To: <ZliKX5EOU9eWhd2U@gardel-login>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 May 2024 10:09:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYUxZ97QnWbEQLgyS-6bSvKbRBdFrwp2RREKddxz0EKg@mail.gmail.com>
Message-ID: <CAHk-=wjYUxZ97QnWbEQLgyS-6bSvKbRBdFrwp2RREKddxz0EKg@mail.gmail.com>
Subject: Re: bpf kernel code leaks internal error codes to userspace
To: Lennart Poettering <mzxreary@0pointer.net>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 07:17, Lennart Poettering <mzxreary@0pointer.net> wrote:
>
> Linus, what's the policy if some subsystem by mistake is leaking
> internal kernel error codes (such as ENOTSUP) to userspace?

Try to fix it, and stop leaking silly garbage in the hope that nobody cared.

And in most cases, people don't actually care, because they don't know
to even test for non-standard errno values.

In fact it is _very_ rare that some actual program - outside of some
test suite - cares about the errno values outside of the really
special ones

So things like "EAGAIN" and "EINTR" have real semantic meaning and
people test for them and do something explicitly different. Sometimes
a few others too, but those are the two obvious ones.

The rest are *almost* always entirely interchangeable and only result
in different error messages, not different _behavior_.

But then occasionally if it turns out that user space then breaks
because some random case actually tested for a _particular_ error, and
we have to put the silly garbage back.

Congrats, you have now invented a new ABI that you will support until
the end of time (or until user space stops caring, whichever comes
first).

That said, while I think ENOTSUPP should not be encouraged because
it's so non-standard, I think the ship on ENOTSUPP has long since
sailed.

Yes, yes, the comment may say "These should never be seen by user
programs." but that comment is historically about ERESTARTSYS and
friends, that are supposed to be turned into EINTR (and a restart etc
depending on process flags and signal details).

And nobody reads comments anyway, and perhaps more importantly, they
by definition have no semantic meaning, so...

We have a ton of code that returns ENOTSUPP - not in the least limited
to bpf - and while we have a checkpatch rule for it, it's more of a
"don't add new ones".  Even that one is likely not really relevant.

And yes, some of them may get translated, but the very first one I
randomly looked at was a proc_handler thing for some driver, and read
-> ...->read_iter() -> proc_sys_read() -> proc_sys_call_handler() ->
...->proc_handler() most definitely does not.

ENOTSUPP in particular is very understandable, because the "standard"
error names are garbage that nobody would ever use. EOPNOTSUPP? Never
heard of it.

The standard errno for that is EINVAL, and people actively avoid it
because it's _so_ common, so everybody goes "I want to make it clear
that this is somethign else" and then they pick some other random name
that sounds likely. And ENOTSUPP is right there and sounds very likely
indeed.

If we really cared, we should have made them have a very different
naming syntax, I'm afraid. Something explicitly inconvenient to make
people not want to use it. Like __INTERNAL_ONLY_ENOTSUPP.

                   Linus

