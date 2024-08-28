Return-Path: <bpf+bounces-38327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7813963651
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478321F22B16
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 23:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886F158DCD;
	Wed, 28 Aug 2024 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnRRJrfR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49CF157A72
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888692; cv=none; b=lriLtR71Jea/UQWffTe/H4nrAbvlmYJTKQrWb6zwa5JmE59iseeaWuXd1vfEv0rWwWU5seb18P1F0Fr0VkGykimoGn4EmEMB53QHJg7sRx+RalSXXL9ROxDIPoBE7vHz+IETmBuAMTodbBwpp+NDpUlVhqW2n2/jxKzFjxLwW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888692; c=relaxed/simple;
	bh=GzB71czscIrzUinKnp9ke7ehCf+RTZ0DQkslwf5QoJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK6CJM3pQa5P9tDgBU6mkvnXrShArHYy+TshmQmdYl+B0EQCl585rTN2eq8B+pFygGKEd1vVNhk/r+Vzc0klTrKL9yNoxDnh6QplDRtQfXcLGr57+/UIjMWaVW3v7/oFPmUuKmrnj+er9nOuFi3ObPYOQhnmtXwD8i/UH98Flzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnRRJrfR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42808071810so477665e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724888689; x=1725493489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mPwtrasulELuyUEBlefDT/n4AuCxvndic47/vdOYH4=;
        b=VnRRJrfRBH3aDzPnxi79DMKbhvUNvdF2bc1KNH4uuNAMnxwHf9YB1fEGJd8YjKdzng
         G1LJ7n1ju/T69jTO+1j2Q62X9aT1mBE+CtlYg10AqeKv1beWiLPUJP+RDwtl8YFv3S9Q
         vudAhWekJaW11sfvmtTKCOdyzHBteuGJ6A0wdVGZyl2rVzsHsvQzH7axQ6vy4l004PrF
         MO0p9Ft4Z6ClC2mGtRoe+0prTUJCPnfbIjX+v4wk2HNC/74jA9k4k6ZQilHelmIe+Opp
         M9zFduzbVI7GqHQwCY7lU6GCSZNzl9hNZADqb5irbn7vOfljChpecHH/r+Pw6JP5eEqf
         5AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888689; x=1725493489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mPwtrasulELuyUEBlefDT/n4AuCxvndic47/vdOYH4=;
        b=OkQsNxgO0LXZhqNK3aWPloIKk/QYM1MJ6lsLLIHhoWVamJ+hl9pb8fQTK0lvthpL55
         nvKhQjH3s68hDvW4/eKrOlkH8hPCAAfVobVMS7Hf7QqXHwXPJCypCaqS0zBJyZx8tFgc
         BrEqQcUXlFUGAgCeOwqV8UkO4MSfxRSluALfPe4IgSy2TZ7s2+TLLox0+AJiUEvwGS4n
         0Q8VC+Yesk09SwrQ8z8M/gTeiT+QAMO1rZf5z3p3gk8TQSrRkvULuQhgRPDDntDUJJEM
         Hp5vEVheD4GMR+AFG9DAzHg/Xed9KTQM1HtTstEeM6h2a9P6qVKD1z6IwXJ7to+oNPzQ
         okTw==
X-Gm-Message-State: AOJu0YwDcS4J6Tw0pO75tWBFMamLo0HqK2OQQYRfJU1YiFjsgkzO5TVV
	CL+ti+bp+EoIBIKBLQLnHmLQy+T8amNZwe3s47eis9Y3HGJwrKX9mRjPos8AFEcx23ecq8FzB8/
	MYPybG2OZYOCUeS4kBwhrpwx49xI=
X-Google-Smtp-Source: AGHT+IHTUR2ef+rhy1eyxJiYE8LyBigT0BrQOdmlmiSbDPZD1pqZODGkmNJEnD0IqBKKvt4ScODDm8FGufzO5/Q0M+4=
X-Received: by 2002:a05:600c:5110:b0:42b:af1c:66e with SMTP id
 5b1f17b1804b1-42bb02eb79emr9257615e9.9.1724888688920; Wed, 28 Aug 2024
 16:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
 <CAADnVQ+5HD1ZxBqpDgNuwPkO1+VGzm1yqhxuDD4HYtkRYHwXiA@mail.gmail.com> <7e2ad37e-e750-4cbd-8305-bf16bbebcc53@linux.dev>
In-Reply-To: <7e2ad37e-e750-4cbd-8305-bf16bbebcc53@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 16:44:37 -0700
Message-ID: <CAADnVQLbknLw9fOhgbSNaNzKi5gfQTP74vXQu3D1P2OVF81b+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:47=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> > It can be je/je too, no?
>
> Yes. It is possible.
>
> >
> > so 128 - 4 instead of 128 - 3 ?
>
> You probably mean "127 - 4 instead of 127 - 3" since
> the maximum value is 127.

Yes, of course :)

> I checked 127 - 4 =3D 0x7c and indeed we should. See below examples:
>
>     20e:    48 85 ff                test   rdi,rdi
>     211:    XX XX                   je     0x291
>     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     28d:    XX XX XX XX XX XX       je     0x212
>     293:    bf 03 00 00 00          mov    edi,0x3
>
> =3D>
>
>     20e:    48 85 ff                test   rdi,rdi
>     211:    XX XX XX XX XX XX       je     0x297 (0x293 - 0x213)
>     217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     291:    XX XX                   je     0x217 (0x217 - 0x293)
>     293:    bf 03 00 00 00          mov    edi,0x3
>
> =3D>
>
>     20e:    48 85 ff                test   rdi,rdi
>     211:    XX XX                   je     0x28f (0x293 - 0x217)
>     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     28d:    XX XX                   je     0x213 (0x213 - 0x293)  // -0x8=
0 allowed
>     293:    bf 03 00 00 00          mov    edi,0x3
>
> =3D>
>
>     20e:    48 85 ff                test   rdi,rdi
>     211:    XX XX XX XX XX XX       je     0x28f (0x293 - 0x213)
>     217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     291:    XX XX                   je     0x217 (0x217 - 0x293)
>     293:    bf 03 00 00 00          mov    edi,0x3
>
> =3D>
>     ...
>
>
> Here 0x293 - 0x217 =3D 0x7c

How did you craft such a test?
Can we add it as a selftest somehow?

>
> >
> >> +static bool is_imm8_cond_offset(int value)
> >> +{
> >> +       return value <=3D 124 && value >=3D -128;
> > the other side needs the same treatment, no ?
>
> good question. From my understanding, the non-convergence in the
> above needs both forward and backport conditions. The solution we
> are using is based on putting a limitation on forward conditions
> w.r.t. jit code gen.
>
> Another solution is actually to put a limitation on backward
> conditions. For example, let us say the above is_imm8_cond_offset()
> has
>         return value <=3D 127 && value > -124
>
> See below example:
>
>     20e:    48 85 ff                test   rdi,rdi
>     211:    XX XX                   je     0x291
>     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     28d:    XX XX XX XX XX XX       je     0x212
>     293:    bf 03 00 00 00          mov    edi,0x3
>
> =3D>
>
>     20e:    48 85 ff                test   rdi,rdi
>     211:    XX XX XX XX XX XX       je     0x297 (0x293 - 0x213)
>     217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     291:    XX XX XX XX XX XX       je     0x21b (0x217 - 0x293)
>     297:    bf 03 00 00 00          mov    edi,0x3
>
> =3D>
>
>     20e:    48 85 ff                test   rdi,rdi
>     211:    XX XX XX XX XX XX       je     0x297 (0x297 - 0x217)
>     217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>     ...
>     291:    XX XX XX XX XX XX       je     0x217 (0x217 - 0x297)
>     297:    bf 03 00 00 00          mov    edi,0x3
>
> converged here.
>
> So I think we do not need to limit both sides. One side should be enough.

I see and agree when both sides are je/je.
What if the earlier one is a jmp ?

Then we can hit:
           if (nops !=3D 0 && nops !=3D 3) {
                     pr_err("unexpected jump padding: %d bytes\n",
                                             nops);
?

So one side of "jmp_cond padding" and the same side in "jump padding"
needs to do it?

