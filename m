Return-Path: <bpf+bounces-54480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40003A6AC47
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C84A7A5B70
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555F22576C;
	Thu, 20 Mar 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho5PV3wo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CA1D7E41
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492552; cv=none; b=V+2ZtfP/l/c/WK3mDWRnAUQw15c4idWijOuTStGIbi+0baud82G+XJdb0FCPkuy7JYjvZHrq58fKAqBJSxrmw0NUVyDHMUYTDZeKJza6TJ0tWx57GdGK8PBWpzJAB7HY3nl91cADRCdxTIWQITFnyIgzUQ3X/Ig6z2aHA/0c3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492552; c=relaxed/simple;
	bh=iTqLD9y3w22SW2T4XeaP+XhUDCp1M/n2QeTdfoPzLlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfWDvopvHw+xjbiSovFPfhSAjYYMHt5HMoAoM2BlD1co11UrhWqxFb9Wfy0+6IblVn376LPMmioEiN3IipiE1F9ZORU7+sEGJI6tzLy90tQ53OdEc3cU1gnWBl2dAzZkGONVO/xixmosuMgG1fTtfMvHszBP6xSVQsId1ESJPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho5PV3wo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so2435125a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742492550; x=1743097350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an9o1wA8XGOeTBAb1/xE4N8a5OlNRtNIFYopStI0LGc=;
        b=ho5PV3wok+k3SI48lfOJOAQLi2A4CSStVSmkYFYfkziz4jMfR/YY0FiWq1mHouUFah
         JtUj/AsSGXYaZ/GOaBWFHxYx7tGIJLYluAX1qOUwwoT2Pqpd0sYm5EHn54kkPXRF99B4
         pk27GbqOA9mN3qZ2Xfuj5GsbB3LAy1N8AgFcS9GPJyVheo1E1pOtfXrRVC2FtX7bVLx5
         DarKxHGNFH2tndTNtD4tgNnlAOZBTaT8XVxxnkHyuuKLISKXpkXOp59S16s/fiaCaKxb
         SGrpCHpaDRgoLqxJhIl93a06jIo3urUZB/fMPuv75LDonDsju9dkuqph00xX9OgyIo2M
         8dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492550; x=1743097350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an9o1wA8XGOeTBAb1/xE4N8a5OlNRtNIFYopStI0LGc=;
        b=t81dWOrpjoQ6JoD46QtUld0ycRAggp20Ds6ytegYWR2+DEUkBgq254ckxvSkbZ9WHE
         qShhbV+rUSHyHJDqdL24OK2MNcSKvwXos1AR3HYnJVSGb3cD1YkxlHJbWs0KWD10DY9N
         DcrFzErg4xwbRz+oAL/5uhVAFvWgB8BFIM8VOibydJJC+R9G41HqJjW8j36oeR0MuXxR
         K5V6KM7dVs+MlipUHN9zz9dsBSvU1kPJOJJMV5Ds//qZ9wOJAIircLzgew7jTSQpu86p
         6YE7noqHlHYpK477dr4eUqRVuuCEuYsd03Dm/QhZC46ASnwYr4qgakvdtjn8Q67IuC+H
         fh3g==
X-Gm-Message-State: AOJu0Yy4Ao9snA0Qhzo5/g81K1HgEPuew8wpER4HpXqdvWu/3atSh3GM
	HAxOGF8Fiz/CNdY/GdF4gYjZKmMrUNf+arMalW35GPIPh6wMe/2rBnc1AKz58E/Fz1zszs0AntM
	zH+tLX0WEjxBTW2h2TTN4kKl9Xzo=
X-Gm-Gg: ASbGncvkZeZJCmLLx5NZEyU0mHD6ilDSfyZnyR+r4H2um3q8Upr8thMzuAyFcdtfd5c
	+eLdv1fDz3SWIsNA5TSvwiWoUMBitMmmIb/dth2HKszhtDyghdf6xAg6tCEYnen0hUVSNETC1uQ
	xcuuIiDHt6RMl5gzqWX8BCqxG24RU5y2CCnUH7qvphDw==
X-Google-Smtp-Source: AGHT+IGeHVOrdwolG3Ctc6SHXI3a6Bsb9khneqXW5Cf8jbRSaj6oTPaWsNUxKnK9r65tJSVn0gUSdRHbFmfR5RnH/Ho=
X-Received: by 2002:a17:90b:2688:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-3030fe90e28mr176023a91.12.1742492549671; Thu, 20 Mar 2025
 10:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PA4PR03MB69099CE14414DEF4173A9A3FB3D92@PA4PR03MB6909.eurprd03.prod.outlook.com>
In-Reply-To: <PA4PR03MB69099CE14414DEF4173A9A3FB3D92@PA4PR03MB6909.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Mar 2025 10:42:16 -0700
X-Gm-Features: AQ5f1JrbO7PaZy061gCZmnICIkDO8G7NybDYmgO90sk0t1QYKXXkME3ovulKD5M
Message-ID: <CAEf4BzayP7pV4E5pwfratnOoZw8G6W-RE4=YQ+na6kd+naQdWA@mail.gmail.com>
Subject: Re: Ebpf function and doubts in its usage
To: Francisco Soares Carvalho <francisco.s.carvalho@nos.pt>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:35=E2=80=AFAM Francisco Soares Carvalho
<francisco.s.carvalho@nos.pt> wrote:
>
> Dear Linux Kernel team,
>
> I hope this message finds you well, I am seeking your assistance in the c=
orrect usage of the function bpf_dynptr_slice() please.
>
> The program being developed is supposed to captures all the packets that =
pass through the Prerouting stage of the Netfilter packet flow, so the prog=
ram is required to be of ebpf Netfilter program type. As the objective is t=
o copy large portions of the captured packets to user-space for processing,=
 without consuming them, a ringbuffer map type is used for storage and comm=
unication.
>
> According to the ebpf official page (Link to the Netfilter program type p=
age: https://docs.ebpf.io/linux/program-type/BPF_PROG_TYPE_NETFILTER/), thi=
s program type needs to read the packet with the dynptr interface, plus (Li=
nk to the bpf_dynptr_from_skb() function page: https://docs.ebpf.io/linux/k=
funcs/bpf_dynptr_from_skb/) the correct and only way to access the packets =
captured is through the bpf_dynptr_slice() or bpf_dynptr_read() functions (=
"For reads and writes through the bpf_dynptr_read() and bpf_dynptr_write() =
interfaces, reading and writing from/to data in the head as well as from/to=
 non-linear paged buffers is supported. Data slices through the bpf_dynptr_=
data API are not supported; instead bpf_dynptr_slice() and bpf_dynptr_slice=
_rdwr() should be used.").
>
> In order to write to the ringbuffer, the api provided needs to be respect=
ed (Link to the list of functions that ringbuffer maps support: https://doc=
s.ebpf.io/linux/map-type/BPF_MAP_TYPE_RINGBUF/), so the bpf_dynptr_read() f=
unction can't be used, as it can't write to the ringbuffer, so it would nee=
d space to store the packet information, and some (most) of the packets nee=
d more space than the ebpf verifier allows (512 Bytes, this limit can be ch=
anged, however it is not the first option in this program). So, the bpf_dyn=
ptr_slice() was chosen.
>
> I think I understand the description presented in the official page and t=
he signature of the function, but if you see any mistakes or misunderstandi=
ngs, please feel free to correct them. The current problem is with the veri=
fier. According to it, the 4^th argument of bpf_dynptr_slice() needs to be =
a known constant at compile time (figure 1 in attachments). However, the pa=
ckets received don't have the same size, and the data part's sizes the user=
-space will need also varies. The following attempts were tried in a Ubuntu=
 24.04.01 LTS with a kernel version 6.8.0-52:
>
> 1. Switch case with the possible sizes, with the maximum size as 1099 byt=
es per packet. (the clang optimizer placed a variable instead of the values=
 of the 4^th argument)
> 2. Place bpf_dynptr_size() in the 4^th argument
> 3. Declare const unsigned int size=3Dsz and use size as the 4^th argument
> 4. Create a function that returned an unsigned int and use it in the 4^th=
 argument, and use it in the declaration of the const unsigned int size
>
> The only way the code works is with brute force: Do the function, if it f=
ails subtract one and do it again, always with the explicit value in the fo=
urth argument, never with a variable. (figure 2 attached). This is not an o=
ptimal solution, but a better one wasn't found.
>
> What is the intended way of doing this?
>
> Thank you very much for your time and assistance, and I'm looking forward=
 to your response.
>

I won't go into too many details, but you can find an example of how
to do this with bpf_dynptr_slice() at [0], I wrote it as a demo a
while ago.

But, good news, just recently we've got a generic bpf_dynptr_copy()
which is perfect for situations like this. Check it out as well.

  [0] https://github.com/libbpf/libbpf-bootstrap/commit/046fad60df3e3954093=
7b5ec6ee86054f33d3f28
  [1] https://lore.kernel.org/bpf/20250226183201.332713-3-mykyta.yatsenko5@=
gmail.com/

> Francisco Carvalho,
> email: francisco.s.carvalho@nos.pt
>

