Return-Path: <bpf+bounces-77194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343BCD1779
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CEBD3075C1A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934F2C0F62;
	Fri, 19 Dec 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX+dw5JL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D58248B
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169724; cv=none; b=p9V5t4n8rx+jd4qDclTdkAHOZXoKuxhB0odfm9SbU9ilaS1A7CXpYAGN35zfcldPMAG1S6aRdy58SMEmM7YY8PuX45OWsTUBdkV7DrKERk3rAT1hAqcFfnUOiw2JiU8DN7YvVye6gHdW7WuxYglZm653B8YMBijayzG43yLOsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169724; c=relaxed/simple;
	bh=1t3SvdLKBdnpLyk36pqNQfOQzeNEbS6bTaLlt3bCeC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoGhA5xfKt+r9SEAXFNlrEFAylTc0lG3ycTeqmlXf+ev6SZwk/9EvsD/3BJBECPM0gF9UTWL98vMrI6YYh28l7OqTOGSmPCSHedeP3gvo80A7BG0XeU1w1Fm2W3xn1kEiRxtUv7Ayslr6K/w14YQa+E0VZbKD9SNA2mtFoziB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX+dw5JL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso1765287a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766169722; x=1766774522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t3SvdLKBdnpLyk36pqNQfOQzeNEbS6bTaLlt3bCeC4=;
        b=MX+dw5JLsFqOLk1vI0GJ6qy50fvcPNE7tT+eKjAKa6BsumEUjADc7VnaUBcSey/hwa
         tNIwkXaGTe+23Urek0lHtAGSpH8SU1trC+suOtguWVvh1GFQNN+00tRBmp31UfNaCNxV
         X7tW3bTpG02/gr2T4SNbYnWw5yaEQU1H24c++Tw66ABbkMTxhoG5l3C9i612ocTULLwO
         QB1AYy2fDCCE2ois1Oj2PY0pWsEuXk4rqICCbLHvDensFe61/fPoPhFz7bfXp2oNdg64
         gjlxzloh090xvoJOfXLHtQquvzHLgIw6cG/OGj0uqL91Xzvm/fyL6XF3KEYjpbMysCwg
         4aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766169722; x=1766774522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1t3SvdLKBdnpLyk36pqNQfOQzeNEbS6bTaLlt3bCeC4=;
        b=FfgLJTHAHBn6M5tX1fd6FG5EMDkF/rDfICQpDR0sjbg/2HJhYstcBBeOUmqYW9ZFsz
         EnQz1vXfDmRHLrxHMuPaJyj+74/RJx2BLoVwUnxI3C1OaFjNCEJbgGRcAakw4Rzs5NUX
         lok5CApqHO2tXCA7D5t7tS1iML8JFWfqxi1LSiizkRF1BvXsbUGAwV4bWhrDF2IRY6Q1
         uOEWvSqipYSKZsKplCUlZCPpMYwhKg4A53zVcxbHlYpHoG/DTXPcNqaKKngLbAH2VFHO
         eBtAD/UDfRwW8q6XAj5G4wyTDyx7CcldZYH1uUBlkSkkXok5BK6zTaLy75xSAyuVqSlD
         g/6A==
X-Forwarded-Encrypted: i=1; AJvYcCXdwOZz03ZsLV5w4jtFSta87feYilTGcDypTQ+NUelZX6wwGkw3jjZCTeXWD94wOaPM3sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsgPqae0Ocbfzru5xOfNM1cr46Rd6Df4eqcYHdbaF0of4B6jNc
	p4i/GbhE8awMuSZXuC2h4uvbKtG1LGAnkc4o85xxgbsk8lGSKh7dVqEWDi9dl2cFJlkackWaO13
	f9H3g4C48Hx+RSb26+kETkK6rebwYr5M=
X-Gm-Gg: AY/fxX6BbS+0HUtxfH0o58AIilsCsoFyJSyy2GqClYYZUomjPxKYNqTIcHUO0l7RRQT
	KuFQD+tTc+TzcOPrurUd4CFo5qYlqkgT+qFn6Gsm+IAilWvJDxN0oaKWHi8uc+4Bc45/l9PSwxk
	c1OZ/CXkxCQZLU37va1yPnRXFe8u2TiMTx/oRJz5fRbiOqS4avDj1EcgmXfxCWxb6R9s+265PJA
	AjMkGs0yaj92/MtzbmfcUbzsM6wkQZxemh5Y/oJAQS+9qEfybL9wM4obo2OnEhK7suB8x8=
X-Google-Smtp-Source: AGHT+IH2D1pwfLkRfYRld646pBfuD0MjZS76cEgvU9gjFR6Io6clmZDmSSZ8uuJD6DHemsg+Ucthed83iuRFVEni7o8=
X-Received: by 2002:a17:90b:2585:b0:341:8ac6:2244 with SMTP id
 98e67ed59e1d1-34e9212a9fbmr2934322a91.9.1766169722525; Fri, 19 Dec 2025
 10:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-3-alan.maguire@oracle.com> <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com> <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
 <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com> <CAEf4BzZ+iH1XvaYOjE==GPJ6wFo14_QtrFYvyvWa=ebc6UKPbA@mail.gmail.com>
 <a99c8b9148a71c7827b00be5c793bfe8379de1de.camel@gmail.com>
In-Reply-To: <a99c8b9148a71c7827b00be5c793bfe8379de1de.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 10:41:50 -0800
X-Gm-Features: AQt7F2rWDSJVuCd0kTKtGcjM5u5ZCHuXe2XNLuAk6Z5kkf0iBnl8lf9s5cNg-zY
Message-ID: <CAEf4BzaS9xoFaTF7LEyjYg9iPZZGn3=UhDVXAv9AuuMz1wFoZg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-12-19 at 10:21 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > The sanitization for user-space consumption is doable alright, I was =
thinking
> > > of the case where the kernel itself reads in BTF for vmlinux/modules =
on boot,
> > > and that BTF was generated by newer pahole so has unexpected layout i=
nfo.
> > > If we just emitted layout info unconditionally that would mean newer =
pahole might
> > > generate BTf for a kernel that it could not read. If however we relax=
ed the
> > > constraints a bit I think we could get the validation to succeed for =
older
> > > kernels while ignoring the bits of the BTF they don't care about. Fix=
 that would
> > > also potentially future-proof addition of other sections to the BTF h=
eader without
> > > requiring options.
> >
> > No, let's forget about allowing the kernel to let through some
> > unrecognized parts of BTF. Pahole will keep introducing feature flags
> > that we need to enable (like layout stuff, for example), so old
> > kernels built with new pahole will be just fine. And any
> > kernel-specific modifications will be moved to resolve_btfids and will
> > be in-sync with kernel logic. I think we are all good and we don't
> > have to invent new things on this front, potentially opening us up to
> > some unforeseen attacks through BTF injection.
>
> That would mean that the flag to generate or not layout information
> should remain, right?

Yeah, unfortunately, as there will be no libbpf to sanitize that. But
that brings the layout question for Clang/GCC, are we adding that?
That should be emitted unconditionally, IMO.

