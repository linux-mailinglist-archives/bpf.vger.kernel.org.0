Return-Path: <bpf+bounces-46132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737859E4EBF
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E973163DD8
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 07:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43771B3920;
	Thu,  5 Dec 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdoimh7a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8721B1D65;
	Thu,  5 Dec 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384208; cv=none; b=oPL0Ta7YM3vO16cOolPQ6jgJrZyU1XMEM9Zqz7AWddlFsvUDa/Jydj5BpMt1p/lWxJMk40lavvocB+EsaaZ613EsknPkLD/DKq/FXb0aySAlbO7KqKGTC0nGQkqdxWEto3NdDrkWCF0XItQepqKXOh21arPHFTcBmIohOGRd56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384208; c=relaxed/simple;
	bh=bv5VA+Cju/JsKSTeQi9eqs6SdGH8tjxntLJPWxrPhSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFAdys9AKy3TC4Fysi/Cl9TAeRsorxFWuapseH7JlEKEAZXlTfqUSpxR/U0AQJpeW0Fjh4TwbRszZCokLXfJj/P+/BfAw3Z9AU4av0CRlfjwuGvqlHfSmGP3WySICBtf3rkGmEw/unzTYLaDd6C1CTUWM0jm9uaBHVoXgdxEVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdoimh7a; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffe2700e91so4828001fa.2;
        Wed, 04 Dec 2024 23:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733384204; x=1733989004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uJgGFu4A4xX1u6Opk5GLS5w5FpXRFEhH+tkFsox2WY=;
        b=Fdoimh7ajUgxb7vy/vk8zVwrRvpxTl7yePqSTx9Oz/vc/lIczJWnMs18Ictv20fnV5
         o9G7ho19lcq9JCKjpCM46bbC7SDGMYj0Ju7j5sO9gCVbU0qq5VcswyOaNMa3ntiYCvS6
         5m9Lqr2ly1W5zBrsJXbFkKqbE5cRyAucR8W7+wvBBId+DYTSU2oj5cJjXTrBOV3cqjAv
         2E9F08/6R49xLPdUv9Ux8MmiEiAO1vis3q2BMa63Oc8xvb1Zu82EQsjrYUM6o8rWbeFR
         eEWYZZoNSrw2k0siSTAQOCWc8k0XeEFRg/owc3w9R338RLACb06VCeg1Fm904WF9UJ5Z
         jg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733384204; x=1733989004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uJgGFu4A4xX1u6Opk5GLS5w5FpXRFEhH+tkFsox2WY=;
        b=HBbuVbsE/V8qC1azkaO37SawidiU0CN29f+XHbJ/Zu1SthfIe2fylRaHrRAQ+/VdXz
         9Lc9c1V7tamniqkGYqr7Lt+VjwOMPpIj8XTDq0LJJZOHElexj+5xnm8G6GP7pkjBzakp
         1CY6MahTnLHdwZCJPZxVo7pR7wb3UVu2OKkm09N5CficRClWowwlI6frSdTH001brLk0
         W90xMPNQPZrj3jzz2asLck4RXAOhfWUlHNTejwmrDDpoGZq2RzO3TBgpw2uOu2oBmHpB
         11uIIr2iut8dCx7eprE/d1q+Ecs68ecGzq53VD3ik3qM88IJl7NHWOJj4m18JZEE/vfR
         TDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9msXQqhJjYni7ujVkRf5E3OwEpItylCq18Z5b1C7czV3hxkzFD4eGhrqAHeSv+n6Mcr0=@vger.kernel.org, AJvYcCWvDT0FFsLQCrP5o6fPGekeMV9LX7yzhkAJ8Tq/280/oVz5Taut6dhWggF0gF8xwNOa5tBjXDeRA4O+jePT@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMRU76bfIxmrRXHUDXzQBYufsStbUJRZZ9MsebAisovzO2IeO
	J+Kk15Bw8o+b3IDGIcEv7zSOj9QMrDGvRqVt7QQNtp/m9+ZdNQsW1eRrGXrpvtPlq65pnLiKHKa
	rljJ0l+S7qE02FNl58AxOu5+nefU=
X-Gm-Gg: ASbGncs6iDDzNN36dAddlwTz874/7slylNzx3uhanRsn/4KZzKeAlCCKmRJk5NZMa98
	H1xABTs//xoPt6lBUpXEd5La+8sFtZik=
X-Google-Smtp-Source: AGHT+IEFMj92jqFqXsdeLuswrg7iDuNWpUsTnXe48DLQx8qptEQPnpVAuFFRYKQFTS+vhOOxqF7TyE166c1MM8QpnQ4=
X-Received: by 2002:a2e:bc83:0:b0:2fb:955e:5c17 with SMTP id
 38308e7fff4ca-30009cc52cfmr39878681fa.40.1733384204322; Wed, 04 Dec 2024
 23:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115171712.427535-1-laura.nao@collabora.com> <20241204155305.444280-1-laura.nao@collabora.com>
In-Reply-To: <20241204155305.444280-1-laura.nao@collabora.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Dec 2024 08:36:33 +0100
Message-ID: <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
To: Laura Nao <laura.nao@collabora.com>
Cc: alan.maguire@oracle.com, bpf@vger.kernel.org, 
	chrome-platform@lists.linux.dev, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:52=E2=80=AFPM Laura Nao <laura.nao@collabora.com> =
wrote:
>
> On 11/15/24 18:17, Laura Nao wrote:
> > I managed to reproduce the issue locally and I've uploaded the vmlinux[=
1]
> > (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of th=
e
> > modules[3] and its btf data[4] extracted with:
> >
> > bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_l=
ed_backlight.ko.raw
> >
> > Looking again at the logs[5], I've noticed the following is reported:
> >
> > [    0.415885] BPF:    type_id=3D115803 offset=3D177920 size=3D1152
> > [    0.416029] BPF:
> > [    0.416083] BPF: Invalid offset
> > [    0.416165] BPF:
> >
> > There are two different definitions of rcu_data in '.data..percpu', one
> > is a struct and the other is an integer:
> >
> > type_id=3D115801 offset=3D177920 size=3D1152 (VAR 'rcu_data')
> > type_id=3D115803 offset=3D177920 size=3D1152 (VAR 'rcu_data')
> >
> > [115801] VAR 'rcu_data' type_id=3D115572, linkage=3Dstatic
> > [115803] VAR 'rcu_data' type_id=3D1, linkage=3Dstatic
> >
> > [115572] STRUCT 'rcu_data' size=3D1152 vlen=3D69
> > [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encod=
ing=3D(none)
> >
> > I assume that's not expected, correct?
> >
> > I'll dig a bit deeper and report back if I can find anything else.
>
> I ran a bisection, and it appears the culprit commit is:
> https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/
>
> Hi Uros, do you have any suggestions or insights on resolving this issue?

There is a stray ";" at the end of the #define, perhaps this makes a differ=
ence:

+#define PERCPU_PTR(__p) \
+ (typeof(*(__p)) __force __kernel *)(__p);
+

and SHIFT_PERCPU_PTR macro now expands to:

RELOC_HIDE((typeof(*(p)) __force __kernel *)(p);, (offset))

A follow-up patch in the series changes PERCPU_PTR macro to:

#define PERCPU_PTR(__p) \
({ \
unsigned long __pcpu_ptr =3D (__force unsigned long)(__p); \
(typeof(*(__p)) __force __kernel *)(__pcpu_ptr); \
})

so this should again correctly cast the value.

Uros.

