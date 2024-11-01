Return-Path: <bpf+bounces-43748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9B9B96DF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA3C1C20C4C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADB1CDA3C;
	Fri,  1 Nov 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8BvkAPE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A11AA7BF;
	Fri,  1 Nov 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483530; cv=none; b=fiOR63EnS4KtzkYWO81lI48iSVsm7gdjBMSZHjaUma5S+uoo6DmW0Lafj+ReCLiGzkgvvZrWvxcDiKQLaSKt7u4Zh4V5Jiwn9zd1hKmLXykcwvFXt9VGjAfr6xRhXEdEucA+24igKYnNLtL211VT+v8nkzm3k77E42s+LnfRBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483530; c=relaxed/simple;
	bh=1iZE5ZkmN5trs/bvRgj6pkX1BjoixP8S84BE0CD2p7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxPDqBaYfe4POqLJq5eisAE7z2FJ3u6aTqdYmTm/VoZCCzgfHNvdjZ1o3v+vvfOzzyXe5iuikCJJRnFGQTiNb7T7IEfkaTzJlU95nO+iUmH9acStk1ccD1YzCwdKICVezs7+LxJIVa+PWUUGlJHZNpUzr4WDApS52xjOOYH2sL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8BvkAPE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so1734213a91.3;
        Fri, 01 Nov 2024 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483528; x=1731088328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArGmsFldK3Iuigk+QJR4rvh183g8Hj7hFL1xtjrSy6w=;
        b=Y8BvkAPEPbkUxQpuVcZtL661kj+twfFWOrYNU6aJ67xEpZ02B9XTFeztVw0MSTdE47
         x8sT9VZESlVhBscpGWxrbMPJaSljKR2jV77Z5cdx7TpB8Un4u6dklS7BZikvAb2mDToH
         mroBv6ZaCyi18CNdHSgmpQQIqAlvrpqdezaxukSiSEu2Dljcba5cSZmomBTvCR/37VT/
         9sXXgQlXbmQyVjIsdsu4qcae3XC83uqmDVo69T7IxhDovRzKBLtLF9aym2tI27z3mYo2
         EYGzuZf7w4WfSx7FHAG6LksAz5AqQ+9Pw1/Ml8u676TJ1m063t4Yj76Gri+FuZt+lO5d
         bOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483528; x=1731088328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArGmsFldK3Iuigk+QJR4rvh183g8Hj7hFL1xtjrSy6w=;
        b=CIO3hSOl8XFec9+tCLAAGzMIowHqhs9Cc8Sldo69zabKAo8vyA4z3f7GAWqf8cTNRK
         nFDPWGscz3vU3VHRo6iVGjJUdPKo2TGJIuf2V9pgubnnl6ZGv4+Spi0ydJTYkXkjwoET
         0XrgNw0A86t0tiJq6RDZz8529sW4Hew4BcwnfKBO1xrJ0HFu8EN/m4nw1omjqG1LMm8I
         7NIgIDlJAicxAsApqOWiMVpxBofY/BJwjqhGZHgt9G1S9htfJntfZkjKaUPm18kgxsH6
         JwvH1LFNG77Nw9capttBqtP2GpCEHOivO25DkDIVTXpHE2CK/u3Uh7h+ej5LDkRoffu3
         j4pA==
X-Forwarded-Encrypted: i=1; AJvYcCUi0xIvQkQLCeuz+0TZxxN6ByDWYtp2G0qd3aFIKcZ4rToqu8ywuBbGuSJPk+WV8A0UEV8=@vger.kernel.org, AJvYcCVkU5hsKl+0oxbJxcaelOrbJwY7MNiNVUWueEx5kbK2S6JBrQ5/0hZZD5RnXIC/RN86HqK5IotfoyspQJI71fkUM0M8@vger.kernel.org, AJvYcCWAeuTWa3vDUwNdrb6sRcTD8Svw25IvQvCGDw64jUf847gaafhlikvtOPeEScZmIIn0CGpNtUau/uJ4RBkF@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbY3zTPB8l/mMSLA1o+xOvosIxYTsBckjSRGqgNRHYmp2ccF1
	Hn5OoND6YE8dBg7Xxeh4gjm7PxTi+oGMfE36u6/EZmKNNk0UlRdT1am0hjW9zmxrfdcguAieBcU
	DO/viqwsjv1ZQLgKc5+HjiOASa7s=
X-Google-Smtp-Source: AGHT+IFFUnzUkEPnJf/GHb9R+I6B+8f5y/3AaJEGrAqiKnCNG1fjP0R5YjUTEuukks7go/XunoJSlrc+5/EX2bV/EY4=
X-Received: by 2002:a17:90b:4ec3:b0:2e2:de72:2b76 with SMTP id
 98e67ed59e1d1-2e93c14fdb4mr10071272a91.16.1730483528103; Fri, 01 Nov 2024
 10:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031210938.1696639-1-andrii@kernel.org> <20241031210938.1696639-2-andrii@kernel.org>
 <CAADnVQL-YGPDcMdJEu7E7-OKpzUaE8Kax7zOW-JYi4aPNivN7w@mail.gmail.com>
In-Reply-To: <CAADnVQL-YGPDcMdJEu7E7-OKpzUaE8Kax7zOW-JYi4aPNivN7w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 10:51:56 -0700
Message-ID: <CAEf4BzZbXmBjJHifBHCB_okYh0V6wuN2V7COUdzT4=_VxyTo7g@mail.gmail.com>
Subject: Re: [PATCH trace/for-next 2/3] bpf: decouple BPF link/attach hook and
 BPF program sleepable semantics
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:27=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 31, 2024 at 2:23=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> >  static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_=
type type,
> >                                  const struct bpf_link_ops *ops,
> > -                                struct bpf_prog *prog)
> > +                                struct bpf_prog *prog, bool sleepable)
> > +{
> > +}
>
> Obvious typo caught by build bot...
> Other than that the set looks good.


Yeah, leftover from the initial attempt (I decided to not touch
bpf_link_init() in the end to avoid updating like 20 places where we
do this for various link types). I'll send a new version.

