Return-Path: <bpf+bounces-52072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF2A3D891
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 12:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2814204FC
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586021FE44E;
	Thu, 20 Feb 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="r5nPTtDF"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAA1FDE3B
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050589; cv=none; b=E2OxeTdf7RDu5fXbDZKWB72hRvA7KKIujHAp8r8ydXe3WU3aNnOa65CiSHTHKLgzJ1jCrEeWmYIDbcmstfACis9mhwKRdya+i0NP4XEIfQTWS2Zmlyc0BWQFB8tOqVWj0z/gYYMk7eNbg3sJGh+5bNXZxtdeDJaZEP7qV/Mw0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050589; c=relaxed/simple;
	bh=2NDDU2tNimJexWIRMP5RMG35cfZVKPILkkXysuRXRLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqYhJ9+dHxZJ0qfDZYJ/dY5UttBCAFlkrUetfmcWmpvN4ur3KfchnF5DP8Ej3S/oS5x/UO2zeAipv9bNcA31OUWqz1QuoLiq+67ESs7gkRaXXu0ajqGAUMPPST1lDkfHBVZu1HMxAUd4i1cXahTTVDTO4FHVgK7236e5yYGMG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=r5nPTtDF; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1740050586; x=1740655386; i=linux@jordanrome.com;
	bh=xOfmTJwhct/Ty5m+favdlhUMbnWDk55MJo6Tl0KvC/o=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r5nPTtDF3B1in6n39GkLq0Zc40mrCbbtsSZvuMlYhYJ56RhgdfccIYEb185F+8K1
	 UUmVJ04pW1e9Tv36hMGcNKCwpjF2BuohdfzHoF+kveRTUpAfvz9hFycqRDOMNUS79
	 BCuQcAN+hquRQOoFYIBtLMbZHuPEUBvYEogXRk/WiGcqBj3+7G/p5D96tIvsYXJJW
	 SVapYmIJMbmoBb8geqipQlUuXmonWXYlr4PloSZqaLdW8KCpmSoxCDom2L2Kdlre8
	 2iNQlEt2lq41JgvnhHDfNCUrCp80rAN8XZZhIDMEeoZWGZPL/OfzoxmA0ZHrW4uok
	 fRr2ffPqm1T3KCHByA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-io1-f41.google.com ([209.85.166.41]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MDyDQ-1tbDI60uY8-00HAFL
 for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 12:23:06 +0100
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-855a1f50a66so21816439f.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 03:23:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtm6dX6PsBzQmbfnD6lLfXGDsiTr4WMFs2M+/fNWwywvNWg6GS/L92m9tEiLqvux72zvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+K81q4agUnnigFIE+6LKU3FZTupgQcGpgNsTHVSINuL2rYcXr
	Qm9cSKQkmbZ7k9woyHwXT2AB/2p0wjO09zDvCEISyV0GhO72S8N9bP0UBEKQhiCmWA9RFTyt2at
	Rd7kyuK4wzxkL3dP8dCR/O4eDXYU=
X-Google-Smtp-Source: AGHT+IH3QHaQNgl9wQkJr65TXcw0BSDdiYxSzcDuC8e42MNLtQxspZs18ulY1QbrcXs6YGejVnMBHuE4sSu+tyjaa2k=
X-Received: by 2002:a05:6e02:3882:b0:3d0:4a82:3f42 with SMTP id
 e9e14a558f8ab-3d2b536ef0amr68479755ab.16.1740050585820; Thu, 20 Feb 2025
 03:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213152125.1837400-1-linux@jordanrome.com>
 <ca3nfe2a2xfkt5ws6qkghzwmv4vmlsto4f2o2pr72sy46lftwe@xh4kt72yeia5>
 <20250219161912.ba13c3ea1c648500ea357e93@linux-foundation.org> <CAEf4Bzaptxiyf3FBJYBc4ByMat2SiTTA6YUQjgOMo6ZVFCX5Dw@mail.gmail.com>
In-Reply-To: <CAEf4Bzaptxiyf3FBJYBc4ByMat2SiTTA6YUQjgOMo6ZVFCX5Dw@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Thu, 20 Feb 2025 06:22:54 -0500
X-Gmail-Original-Message-ID: <CA+QiOd4QJRUSn6YYh9pMpyE77g7m1g81jj8EpDuszw4U8LGiSA@mail.gmail.com>
X-Gm-Features: AWEUYZlZUGQprCTOd-Z6yPfHFZPw6W6YSgdDTWJMYM9PPYpO-JbUuOrWZMY4N5o
Message-ID: <CA+QiOd4QJRUSn6YYh9pMpyE77g7m1g81jj8EpDuszw4U8LGiSA@mail.gmail.com>
Subject: Re: [bpf-next v8 1/3] mm: add copy_remote_vm_str
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9QqFV6JktDMxSlDSbLtWs+kuxjok2bmonuUthHHHrWnu3M6OX9
 lWlpJWXfjvkIXl5wAurV9LXekbv9CegNZgfOHzsPzVgB6jVQX49JERoN6upZG0eIv/ltaNb
 ZXwsKAmOZJ2jnLT1nHVNMCrIQlPeiM8kN6J7+V4zG/iywp6SU1zu5+Wz14b8EZ89orTHQcd
 TRNgsbQHDrpXzgcin537w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JWljkG/qUCw=;PGqrvhYfgHLfWwiBIi4nMZ/Ybs8
 Z9sVxwgTp+l0leXePwod8bbcnyZsdPc8cGAqYuCgEaFFlvpBy9BOpCCttmBA97K895rEbMokz
 TNZxPhM1pWVjUsFSmynK+g0cC0dz2xPE5IiG2SafJTp7bgTPF2df4TlFQyzGB+NXcU42VGEaM
 9BlQm7iBsvB1zdgQUnl2eWcbq6Gulo8eQtvRHB/YQ9wjDbqlE0U+kG8M2y53NW8vzEDR/9RRo
 ox/hHcAoO9MyqNb2BvFNUrFkdOKj6aliqaqq6WGZ85ts4Vsv7q0eKmaiBQcewo7EWNz81OfHr
 fN9foatpaPOzOF4dap8fbHL/N5EheY/KiKp7x5Peq7tSuU+t7ZxMwof87F0JdWmn8e4Dt55Z3
 CQePEn9M0roGaYlqTxuYInWnqaV8or9w/FgNiQ4KaqIA8fWc6ZEj8QT9PmB3BNCrw/x5Cf2Mq
 PF7Jr1k00jC/PwZ/00lYrl5AlmNzKbJbBBRSfZIWjL59v0cGNPhZA3QTJ4DoCEEaJaM6viSWY
 Op/GtXC/PgOnF1YwyvxULwikeUC1wXx2k2UXc1OggoNpLykSx/O0mx6U8Ngr5hzXiFSplsXk9
 t4/areohTWe8La/U41quUCLL83xIgrcAcKT1iord0n/S/9iOzgzTBzzg5M9PwnEwQ8UMNCG8R
 7ZT1erAR2NOxR7c2IM5iV9wr31EmjHqsBksC+kU/0P2GVrQtk3QYghpoHqHek7gtacx+Acsx8
 k0dDEdrgfJDipxh2yIclrw/8247ItixyKE889nOPfsJXw0pZiIiXhRNnp+QKMFblwSxQhGFWs
 Ec1I8nvmwIMs03Xj4+pFBp5595mNh2UhI0oARXVNtf6Qk6XS87/mxdRvM5kAjSDNzKjOB4P2z
 kA+K8T05W5e+VIgSnIJxwZje2Aq7T6+W5G3781n3LVXhQD4IvozYflCW48k3wNrqYfa0CcnQz
 STsd5AtzqbCZ7/QOJMWLuUuqHTT3POvYwoycQd+jBamWmHGwG2MInJk7QAFbXoWZa1BniE+7v
 X6EhT+XukIQ/Cej7RMNT4oNZ0yhn6KHKwGFhZmdisfqnHhrlw4BzMVEk8AfQwQ3yxSUwR3pr5
 TqVwrNBbG3BpUyXk2RuSHhfo2d8U/CG7ezpevNaKBzsTQ4UZNGnbRa5hALCADg2aeKPEYI2+3
 9hsUowE1P70J6k9c5SXLDHg5PQFELs2JVxU9Dj4BWvEkSEkadEgIfa46+g/SxbNzkUwwxXfFg
 Ip/NgrpePJ1JT5JOaHVZPmBT06YnvuQoMoxmpFdfDwhK6Dy++FdUAhMvKCn37uDmg7sdaHO2G
 pyv2uBdlyRVQKayr/SG28lSy1BWTD+GHQnKSUqSiATYO35jFvV7+4KBcFNGMnGls5wj

On Wed, Feb 19, 2025 at 8:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 19, 2025 at 4:19=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed, 19 Feb 2025 15:33:12 -0800 Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
> >
> > > Hi Andrew,
> > >
> > > Do you prefer this patch series to go though mm-tree or routing these
> > > through bpf tree is fine with you?
> > >
> >
> > I'm seeing no merge issues at this time.  Via the bpf tree, please.
>
>
> Great, I'll put it into bpf-next tree, thanks!

Thanks everyone for the review and guidance!

