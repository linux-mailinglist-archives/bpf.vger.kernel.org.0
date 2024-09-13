Return-Path: <bpf+bounces-39847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB497871D
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05F81F22755
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DAE84A39;
	Fri, 13 Sep 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVyxydaT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703F80611
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249690; cv=none; b=WZ583N155TcplD20HlHqxFJZYUBCTf/mjvwQ5ku1vaSKtuRCcXjK2C5bTAEHHB0jXYP229GGfoSEZnAGVa+GSJyQb47NA60Z0qK/bdX3cBX44tWbhSctTRr7B9jTWOSGVLDkREiiWxzCm8rNWMm3xuDt7KMmwlkJZDcu/o5g4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249690; c=relaxed/simple;
	bh=3mglFze5lC3HSsWBGUubWiqTxYVdPFysrzQPr9igtEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du+VUjaS9p+zsm8FI3fXLZlL+IMPoWPNS1Wzns85lOfqj7eRB6CEIVRFJCoeQNrsIH+Ztur/1+XYVWrWggP3vefEEXPmbImvH7BR66qs8qxCuIkjzJdVuxMzP7hjUUqNzxZnwKXVdNc3Yh2kT0Q/gAKQxMd64Ku22ukq7hR+zCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVyxydaT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so16109565e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726249687; x=1726854487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hup27s3aC5bXtveU1rAlCEHUaUM+cXtBWhsIGP50U10=;
        b=dVyxydaTS3jmDcZNqjEqtZhWtv5/beSxhCG8jeHb2SVtBKgrwsHfyHhpcvnn/oq0fV
         ZdgID5WDT8tv/sfVvBGhTBm8kdSY27/tWvQqC82+pObnD9lURSnGZ2OhxtanrGQtIGhs
         thFEjm7r46P870i5oaN+9MH/f3ZL22eQ4oFCjuv9IDVKvw8Y2m6eKZRW7lqmzWI41u/I
         x1uo19NVpj4YxWqz4TuH+qcDCPZnrDNMgXNOe81bDFUUjbIJqZ4LGlpA/EKGNF9A3V3F
         3uAdFjR318AQ5dgxh6CeBri2smuM4D6UH8V7E3hu9JBAvu9cHbVd8vU+QU0BpSkXYZgM
         GSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249687; x=1726854487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hup27s3aC5bXtveU1rAlCEHUaUM+cXtBWhsIGP50U10=;
        b=kG1chloA2GRmHXLv4UbXMwT6DSg74C1rT48TpAOjmtU0QEWxtj4EtyUBcpvz7hdIY0
         g2GzwufDNzO1HEsON7uAu3c3089UE9RJ/jxXNyRqltH/D4M7aINRsyX5i8T49I866ffg
         TB75hWbBOqvbyA8hFgDdpwmG7vJilkcUp9ymu5IrykER6LdaS6+VkYBym0YpjtGVm9tj
         enzNVQKecpDizWFSfxCyznvAP5jH7Zww8+/WLvBkANnk2b+qZY2I90//rVqHFKgLbcYa
         hDfBUx9C5CPVP63HdQk3vPXQj8GTW7QuCrDXJcxPPeJLgrZ411JwcG7+UKIIBbCb4bOH
         0nkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiqs91lrgzpYLN41GEFWCUIpzBUbNmq9e1Ae2DXo+QGq4/0Sj2ZTSSb4TA4p4HPSHHnHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+7ArbFYtIEd+JBD959+9Bs1JK6BIOWvOw97m7Y2XLEV7vpf6
	CHsybJAdEM+xkq3P3EISdiCIjTij70nnnIlZfhD8/E4H+jGOeBlT1C47R9bbcmiEFzy5fhttOFA
	JNP98jcwQtTHvm4p9MRDX4bH+ZmY=
X-Google-Smtp-Source: AGHT+IERliqvyD84IrGlgvBxJNZdMU/WQSMlG8BfUKC7H4dYX5RB0d978fJzSqWLCYde8nnoBFAPiWAFOCNcElbhuNQ=
X-Received: by 2002:a5d:61c9:0:b0:374:c71c:3dc0 with SMTP id
 ffacd0b85a97d-378d6243ceamr3043760f8f.52.1726249686662; Fri, 13 Sep 2024
 10:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901133856.64367-1-leon.hwang@linux.dev> <20240901133856.64367-3-leon.hwang@linux.dev>
 <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev> <64c3f174-1dfb-409b-bc11-d7379c09e0ae@huaweicloud.com>
 <cac838d2-9590-4bef-bb58-b56f97881fde@linux.dev> <0fc08a50-8812-4932-bb85-9d81cedf142a@huaweicloud.com>
 <2e955de3-396a-4def-925c-0e8463f29b23@linux.dev>
In-Reply-To: <2e955de3-396a-4def-925c-0e8463f29b23@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Sep 2024 10:47:55 -0700
Message-ID: <CAADnVQJB+y0NFTk4zOp8vLtYPuSy+eOOy6qYridK6WWeFFPWxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:42=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 9/9/24 20:08, Xu Kuohai wrote:
> > On 9/9/2024 6:38 PM, Leon Hwang wrote:
> >>
> >>
> >> On 9/9/24 17:02, Xu Kuohai wrote:
> >>> On 9/8/2024 9:01 PM, Leon Hwang wrote:
> >>>>
> >>>>
> >>>> On 1/9/24 21:38, Leon Hwang wrote:
> >>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the
> >>>>> same
> >>>>> issue happens on arm64, too.
> >>>>>
>
> [...]
>
> >>>>>
> >>>> Hi Puranjay and Kuohai,
> >>>>
> >>>> As it's not recommended to introduce arch_bpf_run(), this is my
> >>>> approach
> >>>> to fix the niche case on arm64.
> >>>>
> >>>> Do you have any better idea to fix it?
> >>>>
> >>>
> >>> IIUC, the recommended appraoch is to teach verifier to reject the
> >>> freplace + tailcall combination. If this combiation is allowed, we
> >>> will face more than just this issue. For example, what happens if
> >>> a freplace prog is attached to tail callee? The freplace prog is not
> >>> reachable through the tail call, right?
> >>>
> >>
> >> It's to reject the freplace + tailcall combination partially, see "bpf=
,
> >> x64: Fix tailcall infinite loop caused by freplace". (Oh, I should
> >> separate the rejection to a standalone patch.)
> >> It rejects the case that freplace prog has tailcall and its attach
> >> target has no tailcall.
> >>
> >> As for your example, it depends on:
> >>
> >>                  freplace       target    reject?
> >> Has tailcall?     YES            NO        YES
> >> Has tailcall?     YES            YES       NO
> >> Has tailcall?     NO             YES       NO
> >> Has tailcall?     NO             YES       NO
> >>
> >> Then, freplace prog can be tail callee always. I haven't seen any bad
> >> case when freplace prog is tail callee.
> >>
> >
> > Here is a concrete case. prog1 tail calls prog2, and prog2_new is
> > attached to prog2 via freplace.
> >
> > SEC("tc")
> > int prog1(struct __sk_buff *skb)
> > {
> >         bpf_tail_call_static(skb, &progs, 0); // tail call prog2
> >         return 0;
> > }
> >
> > SEC("tc")
> > int prog2(struct __sk_buff *skb)
> > {
> >         return 0;
> > }
> >
> > SEC("freplace")
> > int prog2_new(struct __sk_buff *skb) // target is prog2
> > {
> >         return 0;
> > }
> >
> > In this case, prog2_new is not reachable, since the tail call
> > target in prog2 is start address of prog2  + TAIL_CALL_OFFSET,
> > which locates behind freplace/fentry callsite of prog2.
> >
>
> This is an abnormal use case. We can do nothing with it, e.g. we're
> unable to notify user that prog2_new is not reachable for this case.

Since it doesn't behave as the user would expect, I think, it's better
to disallow such combinations in the verifier.
Either freplace is trying to patch a prog that is already in prog_array
then the load of freplace prog can report a meaningful error into the
verifier log or
already freplaced prog is being added to prog array.
I think in this case main prog tail calling into this freplace prog
will actually succeed, but it's better to reject sys_bpf update
command in bpf_fd_array_map_update_elem(),
since being-freplaced prog is not in prog_array and won't be called,
but freplace prog in prog array can be called which is inconsistent.
freplace prog should act and be called just like target being-freplaced pro=
g.

I don't think this will break any actual use cases where freplace and
tail call are used together.

