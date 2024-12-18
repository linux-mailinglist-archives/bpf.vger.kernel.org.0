Return-Path: <bpf+bounces-47162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22DE9F5C38
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 02:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D4B16ADEF
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39713595F;
	Wed, 18 Dec 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KvXRVHpw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC7442F
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485240; cv=none; b=CBNMD9jz5z40TWv+c56uz1iJmSL62VoY8wJUQbHrCWlUmur59wFYVlCb8KkqPTVfRYWtbNuzmxsDSyGBZSUNyfQlIfmXj3XY9/eSB139NmsdpVU74YGCLP5RhrZfXaDOWAJbiQ26boRNZ9M/C15lIL17C0FO0ggpYEzEHGIPHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485240; c=relaxed/simple;
	bh=7dftcd3gpORal5tdW4nSoIicKcvSkaRlFW4x371Uyik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BftVXsgSCSiRlBSiX67Hw2HDDzkN8f0+qRZoShNLB07w0Z7EuBtZnR+hNcEhUywFYbBnUkt/5PHFm/cn1GZMkQXTHXMveBpgWm0sZqCb19jrUBHENu0bIsabBRqi4pmy0Un07oIBGrHMq+Ncv8BYJPxcye/9IoZ5M7xwTgU6xo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KvXRVHpw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so473526a12.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 17:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734485236; x=1735090036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wmDTFUak1a2VAaHb5TpBHcRdGXQyEP1xmQEFDjAyPq8=;
        b=KvXRVHpwMvCJKV2COk6xPH0VNHlEpePirk1sgcSZKHCGudqlH34VeOzeTQ9NWAxEj0
         bY+QfGWrAdmdvuFwfIZETAI3gw7sPiveBNPuuB1XjZXYzERBoaTTyJ8/0a2EnqTohm9J
         UKKGtoIwEdwA66mpYllZFOA1S86xXmsSAf0Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485236; x=1735090036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmDTFUak1a2VAaHb5TpBHcRdGXQyEP1xmQEFDjAyPq8=;
        b=bAfJhCUrTNxeH2fN2vY1PGXBRjAOxh0ORETiqP6Yq2Af6xWKZ0sBJ1uVXQiJy29D/T
         BgwvnOHMH/LEoiKnQ2VgLkolE4SIJVMrT0DRQKGDUCWpSyX7fdVfmUSRUbJuf7KO+p0l
         7dCzq5w4qRD8lizCJxB+ocpzSOmO4/8QNytXsI94U1O96ETALBc9ofhxZQgr5XrMQv4q
         SaHxpAlsWcKbONEj7t08QazSU53eb1JPoIrgX0bNZsXgfMRbKEK4U7b0zTQSEp82HSWH
         VSPIz7JrU32OEYKfbigVnmrJ5rxIV6RRU6PCbU5OA/4SWtvt3N2RlQCuwOKzjHS74ljI
         VYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVypbQKZob5qz4umfs6Nn1OdzxYSobGpCOOBVmEf0uCzRfsyevUeBypTgegsOsvHKOTECs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNQc+uCLxb85UMJyYpmmDSumjRCVxslFPcbfPrnXmfW07Z8Dt
	phecu3mENyoRkECmbIklkBsNlUzDvC5Eg2H9FARlnMcdASWzD2UCxDtL19/TP6Nk1si9y+593D4
	H+Eo=
X-Gm-Gg: ASbGncsEVOKQG1zZEXvSq7VYTBgfsNYh1WC7VXmjnyfUuMWOtjAgpolMpeTIF2I5iCk
	MFwkPk4hymz9yhm6dMj7dqTnPPdIp7XMOLjEYjVuIYgFm7cvmg2Jfw61rU4c8wB+vc6sVh1MR/4
	955tbCR5JpZ+CmIRY4Q6YSSKUN78yFnkPZ/mq3Ui0Cf1R6hKbEDXh4YKanFHLVIJbHa8/CQ2Q4X
	3KBecdGwZztaACh6B4JdT7NYwou2WaMvHVpwm88F/0iDqb1xR1gtIcGeI3ZZRlNI5i/8sEDZuMy
	dxqKvJdtmmKm4UUp6IZT3YN3iwVCzPo=
X-Google-Smtp-Source: AGHT+IGDwNhcYPjpMSiWT1q+MMfEIUyn+p1AxHvNnQAy6hWnNuP+J3/1gWpYnAQFWhZKWZYKpEUX2Q==
X-Received: by 2002:a17:907:9718:b0:aa6:9134:decd with SMTP id a640c23a62f3a-aabdcc1ac03mr501841566b.27.1734485236400;
        Tue, 17 Dec 2024 17:27:16 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359882sm496115766b.131.2024.12.17.17.27.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:27:14 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6a3c42400so47477166b.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 17:27:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuCI7o1QSfj+ij9wo6oBCetT3F5+UBjH5aTUIO4c2JccbV6Bb9pTkxrjnq9vQAqd+vmms=@vger.kernel.org
X-Received: by 2002:a17:907:2cc5:b0:a9a:662f:ff4a with SMTP id
 a640c23a62f3a-aabdc67c3bamr505528766b.0.1734485234499; Tue, 17 Dec 2024
 17:27:14 -0800 (PST)
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
 <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
In-Reply-To: <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 17:26:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
Message-ID: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
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

On Tue, 17 Dec 2024 at 16:47, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Since we're on this topic, Daniel is looking to reuse format_decode()
> in bpf_bprintf_prepare() to get rid of our manual format validation.

That was literally why I started looking into this - the many separate
type formats actually end up causing format_decode() (and the callers)
to have to generate multiple different cases, which then in turn
either cause a jump table, or - more commonly due to the CPU indirect
branch mitigations - a chain of conditionals that are fairly ugly.

Compressing the state table for the types from 11 down to 4 types
helps a bit, but then also dealing with the "smaller than int" things
as just 'int' (with the formatting flags that are separate) also ends
up avoiding some unnecessary and extra cases.

Because in the end, 'size_t' and 'long' are the same thing, even on
architectures like 32-bit x86 where 'size_t' really is 'unsigned int'
- simply because the only thing that matters for fetching the value is
the size, which is 32-bit.

(The whole "is it signed" and the truncation to smaller-than-int etc
is then something we have to handle anyway in by the 'printf_spec'
thing).

So I have a patch series to clean some of this up and avoid the extra
states. I'm not entirely happy with it, though, and I've been going
back and forth on some of the code, so I'm not ready to post it or
have anybody use it as a basis for some "real" cleanups.

I guess I could at least post the "turn 11 different types into 4"
part. I have other things in there, but that part seems fairly
unambiguously good.

Let me go separate that part out and maybe people can point out where
I've done something silly.

               Linus

