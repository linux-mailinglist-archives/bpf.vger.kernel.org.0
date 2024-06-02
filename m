Return-Path: <bpf+bounces-31156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DDA8D7787
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 21:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9449D1C21236
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A77B6EB73;
	Sun,  2 Jun 2024 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAHNBO8I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B26EB4C;
	Sun,  2 Jun 2024 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717355564; cv=none; b=VCoXZdy/r16m8RZRntPyfPwPme5axBKMokC3ixlCdgZh+E0tL8QSwG6SaNfr8/D4IaAVR+8e8ez5OyHBOvkZF3/75rYmoTL+EudAKXkommL6tFsHT7Cn7i3YbOUWbc25mAb4VhAab7zb/2CldxdvsYR9xubgBkriRi5zWi+Y7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717355564; c=relaxed/simple;
	bh=qHG8QH+/mqunfB8u59RD3z93f1SMBtf8VW7kHlq4QEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtwGw9JaDf6yqq29dq4E1PpcrMpV1+n+c/2YdlwekwfT3xmBzhmxiaBZ0is9qqDYkaXhMLl4alLKxsf0Lfc2cr/1hJUhuOgeic8hYhoy/hV1rmHcH6wWki1XQJqfVi8gQvwxQp/OKLHe9fsq02EmDcM3tG9fRGY2VWUkqQAoUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAHNBO8I; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dce6102f4so2394540f8f.3;
        Sun, 02 Jun 2024 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717355561; x=1717960361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuI3t+WrtTWNm+6l5EAvTGHIgvRSvsmXgaFgYPKJXa0=;
        b=jAHNBO8IIrqXefUcl+YtE+l9Pc7UURhNR20P7bY/vv3MLi7KcdzkkRvPtrMAzlKZnu
         nG9wIHayeysYnwMTg/9thinZD49r5Du8dreOBtongIoLUY8qQuxNXUrMhdS4Ff7kqqsX
         BjGaGovIyXfuQm+QLXWSUy/vVaiRrA8WYPOPDXK+fbf9bgq17CnrIEkGKiv8GTxozGmk
         W065xurskAnhle+imEAnQhlIFA05PIzkaDS/JotIdDfYz7+kvPjXIV50Vs1/45FRNS2q
         70xpaT6Ft43CLm6RjCuV9Bw1QraotOUvwKivtGBS6H2k36oTpu55U0lT3DQchCkq2fOB
         FTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717355561; x=1717960361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuI3t+WrtTWNm+6l5EAvTGHIgvRSvsmXgaFgYPKJXa0=;
        b=AVeDxSbrW2gcsjwXhOVuAMEy4JTwTsPrvKHlO4F7cMuzfz0WLVV04MhE55MeHSqMPz
         S9JcEz6D4UP+/GBbZUjHWnfOFrYoEqgifPZNYh0SDaoJG7ydvSIXtYzTnHl3L+EcWqKc
         7u4UPMg/IBM8lQCiY1hxwE6w1pi13A2a2/4ufwYDI9hyrF4fK61HOZpzTCsl33aRHAy8
         WkHW/dqVbxVTCSj+F0bX6hMwqdgFOpp7bjUi+soV13hEaWKzdy0kSTjTWTWWp1qnRSsP
         vOCusZw0OAczz/RJpjbyfn6qcb303TGJ0iEPFJ0fzMYEwaNU3mBu330L/p49zyaPSm/C
         EnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIFBg8mKLNv58p3QNRT+ttIc1R/eivjbTGL01lwQx2THQ54Cs/8XBBp/6C87MAxfCxYJdz8CxFBEvizMWp/pwueMcn5QvD9DWN/lfxSYQwf8FjJOmBVLlUpWA8f1+XNA2Zr04W2h4WeWrar18wYmM+T+Q2MukdPfZz5F916z5pCamkUr/F
X-Gm-Message-State: AOJu0Ywuvqn8kxfXwSfj5Z5kXtACuydI+Evwvidvr67+llHAPFCSyek+
	1HeCM/NqK/C6I50gWtq9/MIkox2/+ELlaYy3shEaIcAgmGNjuoSKfXyNJxY67P/fosnQU2awwec
	jEu1cZ0pTkbCqfHRNvWMNfgdqvbm6KA==
X-Google-Smtp-Source: AGHT+IFiy+Aq8rpwIXmxDOwPQr1QKSTA4FIutEelVYoty2l83FpwAbV8qqzqWM9bFCW6U2zGoJG7p6ue910tqwHWFlM=
X-Received: by 2002:adf:f7cd:0:b0:355:2ae:d88d with SMTP id
 ffacd0b85a97d-35e0f285b12mr5495442f8f.34.1717355561135; Sun, 02 Jun 2024
 12:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
 <20240531-fault-injection-statickeys-v1-3-a513fd0a9614@suse.cz>
 <CAADnVQJ=bNg9nWQPXGjJ11pZnmjntt=zLBqtJng3328T1L-u0g@mail.gmail.com> <dd02a8cd-a554-4756-b229-656bfc218954@suse.cz>
In-Reply-To: <dd02a8cd-a554-4756-b229-656bfc218954@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 2 Jun 2024 12:12:29 -0700
Message-ID: <CAADnVQ+7=fAYh=Wk4eiOdQWfeZ5biLG9+YRDFH+t=3tX3RFA7Q@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] mm, slab: add static key for should_failslab()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 1:57=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 5/31/24 6:43 PM, Alexei Starovoitov wrote:
> > On Fri, May 31, 2024 at 2:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>         might_alloc(flags);
> >>
> >> -       if (unlikely(should_failslab(s, flags)))
> >> -               return NULL;
> >> +       if (static_branch_unlikely(&should_failslab_active)) {
> >> +               if (should_failslab(s, flags))
> >> +                       return NULL;
> >> +       }
> >
> > makes sense.
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
>
> Thanks :) but please note the cover letter where I explain how I need hel=
p
> with the bpftrace side (and ftrace, but that seems sorted). Without that
> part, bpftrace will silently stop doing the injection as the static key w=
ill
> remain disabled.

Right. That part was clear. Once this set lands we can add
static key on/off logic either in the kernel directly, or in libbpf.
In the kernel is certainly cleaner.
How will ftrace handle it? I couldn't figure it out from this set.
Ideally key toggle should be a part of generic kprobe attach logic
and not bpf specific, then both bpf and kprobe will work.

