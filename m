Return-Path: <bpf+bounces-36072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3268D941E63
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 19:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE8A286013
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1664187FF6;
	Tue, 30 Jul 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXgaEszb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331671A76B4;
	Tue, 30 Jul 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360499; cv=none; b=PqolimUGfIf9qgjUQL7MGHPQ2Uf8nn5PVneHcvur9AdBNSb9VmUYUIdTqn2puj+1vwDMQF9Iu8w4DooFVZ4eu6A7fE7zr4JwLgApmUC2KnIJNONEB6cxwuKV8wn991wG9VZI8RZ8WFyLaflwTC9h6eJHlwEKhxdHBlt+utFFYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360499; c=relaxed/simple;
	bh=8BZ/+0c6LLhCVOq9k2EINS3eEOtUNO6eq6SWmLze7J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBBU2DZEQena0Sats4PX4/Da8GZu2FeZuGXaGtoHJid2JG4S2hhpQFfSv2TsT/JMW7+eHW2lo77Z92VLTZzlr2fG4+5K6Ks0ldl5wclkKif1wNbqFAyG5Ehnbnm3u3Dgooij7GpgI11/rRUPO7f8TYYG6lPOSGXRvIZ/iEDVUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXgaEszb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cf78366187so2945609a91.3;
        Tue, 30 Jul 2024 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722360497; x=1722965297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BZ/+0c6LLhCVOq9k2EINS3eEOtUNO6eq6SWmLze7J4=;
        b=nXgaEszbt0UOyEfIYHFXgTQkWeKWohcuczrueIDnTwaYDHlQoRB5knBMpwQAR3FQbc
         OiJ1Z791GNbDW7q7dhXf/x10g/m4YZK2+JdIOPP7llTIhOtdNnSENCuffDZJWLEikgE9
         hX8vX4gnwttmCXZb1eBQiS96yLaWilb3gEHZeuNjtk+jhVtme/+GAC8yOXu8lHjKaXkq
         W8evZk9yW2tMzN5D9qWB1okIURRDVogrxzFWcsdcCnvO/Ozy7TrfNQeQanDqCYxDKIl8
         o7s5DcH4KbVovMtSkDjt7pSrMfV9g1JnuRligm/CpDSgfi1Q4wFX0TkTT3u9+meY9rbM
         j0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360497; x=1722965297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BZ/+0c6LLhCVOq9k2EINS3eEOtUNO6eq6SWmLze7J4=;
        b=fRsAHwflunKq0ROSOrraXa/CVi9dzCPY/dITtmA/VrvVgTl5/iGbqPxmRHQZoutRdZ
         G+/PfcKgOuCtZZbVkBseEvuy3IidW6LWiObG1feIIfMO1c1cnUbhEtbP7z15b1/k2XGR
         x0HDl99ana+eVoQX4N/pDd5pZfHO9TjjGyVHo55q+wz3jruU6+/6FPFUa+zD6Yu/nW+P
         GOGsjSk9x8S5fQynyBMhLV1k7DQZsivkNONanb6GWfPU3LoGRRWQ7mGQlA44rlKYg6qT
         Xmkxs8ofKcELgoEWQfvn4lhyRGubTtCFJnPQ2emtqMIx8EUblRZG4j6WTqRgrTBuPdNT
         G+iw==
X-Forwarded-Encrypted: i=1; AJvYcCWjt2SG+0KTOdleOAyuT1BsOPFGANHtsEgpMo47/IVUdFKCxwo39kfhhNba80VBAZ9OwAP3HgepatHWofjU5Tks1/q606AmnVexPgklZXXMWcl0+KwyYQng8wsnw9Q7LD7Q
X-Gm-Message-State: AOJu0YwRVHwAOrnjR2D9ljvPixjlsN8JnVfpaIIgpvceEazWERFNR4fJ
	zQkEzswW+RNx4ucdTqcaZ9aBbsdjvuOBVenMfeK6ux7zeK4Z0aWTzqzGL/iTkEwIOGfMQM00hqx
	ch5zGQqkOfXi+py5mktI5+JRtsks=
X-Google-Smtp-Source: AGHT+IFQj44xGrJQzBKXeAfqMiTWnJw1eB1EU3KpViUSxTKAmGZvV4rwEMp8Y8nHHQuuAQ0LIG+XNDrBv2GFl4azYnQ=
X-Received: by 2002:a17:90a:e544:b0:2c9:7849:4e28 with SMTP id
 98e67ed59e1d1-2cf7e60bedbmr14036584a91.27.1722360497433; Tue, 30 Jul 2024
 10:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725051511.57112-1-me@manjusaka.me> <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com> <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com> <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
 <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com> <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
 <a1ba10df-b521-40f7-941f-ab94b1bf9890@gmail.com> <CAEf4BzZhsQeDn8biUnt9WXt6RVcW_PPX76YFyZo6CjEXGKTdDg@mail.gmail.com>
 <9f68005d-511f-4223-af8f-69fb885024a1@gmail.com>
In-Reply-To: <9f68005d-511f-4223-af8f-69fb885024a1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 10:28:05 -0700
Message-ID: <CAEf4BzbzM85_946eB95e9U6stknBh4ucLMKVo5SEqUsihe4K1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:32=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 30/7/24 05:01, Andrii Nakryiko wrote:
> > On Fri, Jul 26, 2024 at 9:04=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com=
> wrote:
> >>
> >>
> >>
> >> On 2024/7/27 08:12, Andrii Nakryiko wrote:
> >>> On Thu, Jul 25, 2024 at 7:57=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.c=
om> wrote:
> >>>>
> >>>>
> >>>>
>
> [...]
>
> >>>>
> >>>> Is it OK to add a tracepoint here? I think tracepoint is more generi=
c
> >>>> than retsnoop-like way.
> >>>
> >>> I personally don't see a problem with adding tracepoint, but how woul=
d
> >>> it look like, given we are talking about vararg printf-style function
> >>> calls? I'm not sure how that should be represented in such a way as t=
o
> >>> make it compatible with tracepoints and not cause any runtime
> >>> overhead.
> >>
> >> The tracepoint is not about vararg printf-style function calls.
> >>
> >> It is to trace the reason why it fails to bpf_check_attach_target() at
> >> attach time.
> >>
> >
> > Oh, that changes things. I don't think we can keep adding extra
> > tracepoints for various potential reasons that BPF prog might be
> > failing to verify.
> >
> > But there is usually no need either. This particular code already
> > supports emitting extra information into verifier log, you just have
> > to provide that. This is done by libbpf automatically, can't your
> > library of choice do the same (if BPF program failed).
> >
> > Why go to all this trouble if we already have a facility to debug
> > issues like this. Note every issue is logged into verifier log, but in
> > this case it is.
> >
>
> Yeah, it is unnecessary to add tracepoint here, as we are able to trace
> the log message in bpf_log() arguments with retsnoop.

My point was that you don't even need retsnoop, you can just ask for
verifier log directly, that's the main way to understand and debug BPF
program verification/load failures.

>
> Thanks,
> Leon

