Return-Path: <bpf+bounces-64441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71003B12BB0
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D1717D48F
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D231288C10;
	Sat, 26 Jul 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JxZTQY2d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF921F9F51
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552277; cv=none; b=dUwOgH6Qzi64MVetxaj7UVP7sahqrR+sumT1PS15XrxC8m6zu695k5bXgWzrDdLnHpqOi8hA54bHpQh/KNqncuBaWkfMfOepciET2ZL5skuHc03I/XpeiUMJYQqvLExxQ6mZCJ+w/LXjiTCZNpZRc3wEPw2k6Eyz96KowcU1OPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552277; c=relaxed/simple;
	bh=DooFKyvtMrhcGsvS73nOYMGBp2dUDW7K3Uj8YSGtKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR+4jMlJPEEF2nRzc9v9xCHnruMhixpu+YdDMN+2HrHctoo1d9LZqgp5xC2iI/rB4okjEUUA58U2d+4QQgdPeNTUkjqGPnGtBvj7ZuGs/xi4sMpUgRUTJBWKc35MDAfIrRbnph3180CCl7/QMVtwvcf/d/NITC/qM9jLAz+KGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JxZTQY2d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so510007066b.2
        for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753552274; x=1754157074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=JxZTQY2dGVvTNxDlTWO1q4xwBovmYslbtYKR2xbfBs+XedmT2tJEmBU7i0k7r8fFIc
         9zRHP7hasQ7CxnKrXlPvoMDL7DugWrGfZu2gSnoJJ1RAyvDW4ssf8wIUR92EheUQCyMx
         pytGoNTVLXSuIEE+Ud29UPIRfLYR+QLfLkgbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753552274; x=1754157074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=Mj+uhoXLe6TeCFQvsWr3oK/ZaBJ2AaNzrFkLRq9lM9QCOBtJpa31QA+ZIEsHOjTIY5
         wng4DowtAxnOJzdTX02HS05ykSMmlR+gZop6SzLTeXujwVXJSl6L9S9a0SX04AnsG5dK
         EOLL5kN+6R3/Sx5nu7B+fhfWdnRMy8QrQ+pQGz6LrJ61oDTOQRLTUP6gVNHJzgXhr5EB
         UfkAqvaV0M1IEAY9SohKCOL++XXaHxDl8+wf3PmnhLOGhNNcK5M0DuglYFyzNSf1wHqR
         6voIRXdeZEA0TEKGLQv7uWEjPhhgv4j2TIVaFVZxVe/+H8DcvcRc3fzUm5/GXdQrQA7y
         S1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe4Io518/U/Ubvd1IetSvb9oG31D2wBmYL3CmStDPEB3GVj+qMn8SEfqUPcoBC9Dmi0Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kHimtYEqpdzMHr6bXlCLlBCUCpdqd1NxJHzoNob/nqyTgDC9
	o6mtjXsH7HvDUsYueIvrwN/wOteVP93H2SzqXx+5Ugpv7PY2h1BVK8AoZLztYyKxt8qOshqeIdn
	iUcnH89E=
X-Gm-Gg: ASbGncspAWQPwNxvGEB6GqduB0T/23eX2UV6XOeSAdv+ySOak6wXGb83h2wSrfUwe9V
	Tfdjq6YspR/T40qNprGBECGu85OUBWgT3MJ9jQaEWh3ktvIRDvHbKqzhYk7jMNKlILqg2OTFWBv
	Hz7aEOsA6qv+jLi/KRxhsImIZUY5bcGQlVycl/OidjyU6M5/kv2lIpN11kfyTFQCtbwlWDbpKMj
	wYPuMgtoLIBX477fsafXvHs/ovra9p81LX6FetwxpcQ8qmCE1DOVOyXLbfZtVO5/ofzadZsND12
	0i/QJhmJsHREyS/MBGMeCcXkqgtvnP5Sm547Bcb3bQ/jmffop3gwoGZoLQ9jxKjT7+0kTgy60uH
	OWiVXUAukRWCISzyfZ1vmlL8PjEIA0KchCDAELOqk7sXeIPkz7at31ENd94ejfa8UCScXaLFITK
	zqVRCZw8/hm5zbnJsKPw==
X-Google-Smtp-Source: AGHT+IHzmrMGy2kMeZko7JDurPn1n07YO5nVHI+hy5aFOosdgYxxH6WEgNgISQ3HIOZ5CNAKXBya4w==
X-Received: by 2002:a17:906:9fc8:b0:ade:8720:70a0 with SMTP id a640c23a62f3a-af61c8a4103mr627092966b.20.1753552273868;
        Sat, 26 Jul 2025 10:51:13 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff5asm173889966b.11.2025.07.26.10.51.12
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso5316652a12.2
        for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWeV2heZoK7fzIaFxX5kb0qEqntOQUGiPrT3rXsFuYUHI574NcOY7I3enezWgO72hp8es=@vger.kernel.org
X-Received: by 2002:a05:6402:14d:b0:611:d10e:ebd7 with SMTP id
 4fb4d7f45d1cf-614f1da658amr5711204a12.19.1753552272125; Sat, 26 Jul 2025
 10:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook>
In-Reply-To: <202507241640.572BF86C70@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 10:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
X-Gm-Features: Ac12FXwUXdIlVLvMNocbefDF6HEUwlAESHc5g0TBeq7Fw2jKEkXsJpBWks3U_Dc
Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

, but

On Thu, 24 Jul 2025 at 16:49, Kees Cook <kees@kernel.org> wrote:
>
> Why not switch all of these to get_task_comm()? It will correctly handle
> the size check and NUL termination.

I'd rather aim to get rid of get_task_comm() entirely.

I don't think it has ever made much sense, except in the "guarantee
NUL termination" sense, but since we have basically agreed to always
guarantee that natively in ->comm[] itself (by *never* writing non-NUL
characters to the last byte, rather than "write something, then
overwrite it") the whole concept is broken.

The alleged other reason for get_task_comm() is to get a stable
result, but since the source can be modified by users, there's no
"stable". If you get some half-way state, that *could* have been a
user just writing odd names.

So the other reason to use get_task_comm() is pretty much pointless too.

And several of the existing users are just pointless overhead, copying
the comm[] to a local copy only to print it out, and making it much
more complex than just using "%s" with tsk->comm.

End result: all get_task_comm() does now is to verify the size of the
result buffer, and that is *BAD*. We shouldn't care. If the result
buffer is smaller than the string, we should just have truncated it.
And if the buffer is bigger, we should zero-pad or not depending on
the use case.

And guess what? We *have* that function. It's called "strscpy()". It
already does the right thing, including passing in the size of a fixed
array and just dealing with it the RightWay(tm). Add '_pad()' if that
is the behavior you want, and now you *document* the fact that the
result is padded.

So I claim that get_task_comm() is bad, and we should feel bad about
ever having introduced it.

Now, the tracing code may actually care about *performance*, and what
it probably wants is that "just copy things and NUL-terminate it", but
I don't think we should use get_task_comm() for that because of all
the horrid bad history it has.

In other words, if "strscpy()" is too expensive (because it's being
careful and returns the size), I think we should look at maybe
optimizing strscpy() further. It already does word-at-a-time stuff,
but what strscpy() does *not* do is the "inline at call site for small
constant sizes".

We could inline sized_strscpy() for small constant sizes, but the real
problem is that it returns the length, and there's no way to do
"inline for small constant sizes when nobody cares about the result"
that I can think of. You can use _Generic() on the arguments, but not
on the "people don't look at the return value".

So we do probably want something for that "just copy comm to a
constant-sized array" case if people care about performance for it
(and tracing probably does), but I still think get_task_comm() has too
much baggage (and takes a size that it shouldn't take).

"get_task_array()" might be more palatable, and is certainly simple to
implement using something like

   static __always_inline void
       __cstr_array_copy(char *dst,
            const char *src, __kernel_size_t size)
   {
        memcpy(dst, src, size);
        dst[size] = 0;
   }

   #define get_task_array(a,b) \
      __cstr_array_copy(dst, src, __must_be_array(dst))

(Entirely untested, hasn't seen a compiler, is written for email, you
get the idea..).

But I think that should be a separate thing (and it should be
documented to be data-racy in the destination and *not* be the kind of
"stable NUL at the end" that strscpy and friends are.

               Linus

