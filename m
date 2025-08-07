Return-Path: <bpf+bounces-65220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F8B1DC56
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF14E0592
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D212737E2;
	Thu,  7 Aug 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaHIhE/p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843226AAAA;
	Thu,  7 Aug 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586773; cv=none; b=RSEqBkl//PxL1PFBxWPIYSJW+LjnNpOa6zxzpCrqJOCn8WqMugPi8T/pd4z02LBmTfNRszUp2dtxTJak8dbbACOwLCk0J4CqhbcqojQ4uPWl4fdxRk3O8zGLRb43Gzuyt+GGbNFCYy22NtfEZXx/cJKtMJ+UiqZ/mWnOHHhucKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586773; c=relaxed/simple;
	bh=Fj71PEO4dM4Lux5BcNeBRjWoGCp6u1gp22HpMb/7bQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5B7y6OJzZ5QTW3HYQu92ocZ6dNV6S+29A/m3lTVtv5kxle4ApLK951oEAqacwi3em7WrU4mzUY9ofqkFmkikXlKBVZmzlO2rCg8q244KmGhB92UttxMuvOCcNCe/9aOrWwUf0jb2keq5b43jjumqRlErSgdJ9EFDVAi9CKx6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaHIhE/p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so11538005e9.1;
        Thu, 07 Aug 2025 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754586770; x=1755191570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRVAwrPbu6MCTQqLTx2zOHegUxATEEXt5vwLpcnAdlk=;
        b=ZaHIhE/pKbMUm3NQQLgYR4u6+/OAce406bSlIdrGKrtH+nL0w+KSGbQj0MWY2zF6nR
         lBv5tOo5mX9UsrT7cs3RI/bFTzAgWjwpb0U7WLOwdbcJhMy6xPIfra30xDMNNV6vjq9l
         Nbf7XxHmTtNO2AljrUXI/7w3csTG1WFmSOATix2JII38BlHOF4Tcco6Sx1A+PRhjX6wU
         QWR6A5AEqTjrw2Q9FRBXTJUDSzYBmjysQdjc0kJBhysQE1UyrxcK3grj1R+Xv7M/ugrT
         mZ6FaqOZyOGdnDAdGFOZ1ztRLepCFTf4vGh8BJkBOJ3tIYS+gS1OsTq6W8EgpySoGXlm
         B3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586770; x=1755191570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRVAwrPbu6MCTQqLTx2zOHegUxATEEXt5vwLpcnAdlk=;
        b=YGhExwffYie/zDFbHSwJTz1Z+GFGcotP5UyoCA7DnEP/IZqaZ2AVHZSPcKF+/oMib8
         BBzeiN8dsF8UsUBF3XsXp2zPUFqlOM+AY69GoX616y32zCacjZY7Enb+lf94klhp0Uca
         eRxDhmFHNoJn+teCWZibmSr8ONhojHDboUhIOwRbn5y6UT9NVINYbKMA4XC+FK7WfMH9
         NkCkuC/nSMscFKT6yLYfbGNZh1AGUXsw47aqprCh5VNVD9pXz7yGZn2HjnOvdWhA6EQe
         O1EGPLwrPSpvPaS92dAT1U8l+chFDFreAw4nVPDGmc30XDT0VjRe8vFumOXCrUoyxiyR
         6Hxw==
X-Forwarded-Encrypted: i=1; AJvYcCUSzO7NgP5vBbQe0EXbj1OFmZpdamfYB6w/Q3e7u7fjNRsHXLebE/Ai9zr+7vm9Ebh0gKo=@vger.kernel.org, AJvYcCV03bv6zPTPH5EV8JYAoWSc1lCrVgiBewRpbBsmd05jEql0YRkfWpSb2jMb6MSK9H4OB5SOqGduvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIW/JOmJjHXuEvgS1iojAsQASJP/fQe1mVmLNIOpuy1ZYvqZ6D
	xQ8rgfZ72puvWuGPpwFM6s1B68yGAONDYpNjMJ5ycowZvXcB51hWgtMeaIHMag78Ff3181uOz4y
	7JP9Oogr4OxN5F74nBIHZGcqmOJVMqS0=
X-Gm-Gg: ASbGncshvqV5+bxQI21ZKf1qW1FK1b+nioogvb+2c3BsyhNg0fd7YSad8QuidxUalxh
	o7E/79MgBodAOtX4beunIjKqpTxvPdLFbO9ioe6brpMhlRvdtj2XnjTAPEuwW8f4IsEPs6UBD4z
	AiG1+53VTNd7tPyoQV/a9orXiNG2k5ne63CcnP9mRUPG34tYXIIGdSzjJXKl5xF6hvhom3zVWEL
	u0T4eWto3/i1gzQgcFow6E=
X-Google-Smtp-Source: AGHT+IHceuxlybd1/oSTiVximsKFKDLC/Anw97lhTwmc7uYTV5yPnM358U5mdLsFqc5wSMDYsCt7Zdqj3shqjm8ZspM=
X-Received: by 2002:a5d:5f85:0:b0:3b8:d2d1:5c02 with SMTP id
 ffacd0b85a97d-3b8f4925aadmr5688315f8f.49.1754586770230; Thu, 07 Aug 2025
 10:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
 <20250807144209.1845760-6-alan.maguire@oracle.com> <CAADnVQK38yk3XO9cebrXhMUSK10bH2LVPvs6W4e168x3mGpTWA@mail.gmail.com>
 <87cy972imt.fsf@oracle.com>
In-Reply-To: <87cy972imt.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 10:12:37 -0700
X-Gm-Features: Ac12FXww09XlzEa_L3CcSbesQlsv9BQhdsq8ZCK_LUMn9tmEAJpxWsBDLDkjc58
Message-ID: <CAADnVQ+x3Jir0s=nsvw7eV54FJjFkfwx=+xWMM4bFHHmwD5ORw@mail.gmail.com>
Subject: Re: [RFC dwarves 5/6] btf_encoder: Do not error out if BTF is not
 found in some input files
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:37=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Thu, Aug 7, 2025 at 7:42=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> This is no substitute for link-time BTF deduplication of course, but
> >> it does provide a simple way to see the BTF that gcc generates for vml=
inux.
> >>
> >> The idea is that we can explore differences in BTF generation across
> >> the various combinations
> >>
> >> 1. debug info source: DWARF; dedup done via pahole (traditional)
> >> 2. debug info source: compiler-generated BTF; dedup done via pahole (a=
bove)
> >> 3. debug info source: compiler-generated BTF; dedup done via linker (T=
BD)
> >>
> >> Handling 3 - linker-based dedup - will require BTF archives so that is=
 the
> >> next step we need to explore.
> >
> > Overall, the patch set makes sense and we need to make this step in pah=
ole,
> > but before we start any discussion about 3 and BTF archives
> > the 1 and 2 above need to reach parity.
> > Not just being close enough, but an exact equivalence.
> >
> > But, frankly, gcc support for btf_decl_tags is much much higher priorit=
y
> > than any of this.
> >
> > We're tired of adding hacks through the bpf subsystem, because
> > gcc cannot do decl_tags.
> > Here are the hacks that will be removed:
> > 1. BTF_TYPE_SAFE*
> > 2. raw_tp_null_args[]
> > 3. KF_ARENA_ARG
> > and probably other cases.
>
> We are getting there.  The C front-end maintainer just looked at the
> latest version of the series [1] and, other than a small observation
> concerning wide char strings, he seems to be ok with the attributes.
>
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692057.html

Good to know.

Yonghong, what does llvm do with wchar?

