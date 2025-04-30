Return-Path: <bpf+bounces-57026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24AAA4122
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 04:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9434B4E5D61
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540311C700D;
	Wed, 30 Apr 2025 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAHn0cKq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B819F12A
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981198; cv=none; b=tGLuOSmEk+6XRIFbtB0h6h/fAThxSqpgmStoXmB2qEGHIypY5HKFfpVh9bn69MH9Y8IVF+MtY3nALV0onOXkVJV3s4jDm1cZNIZvMOz5sbINJmwpOFgTnaElYQvDIlK0c9O6f0EzEYg4B0+cJRWsUzFhg49HSznrhJKSwMiztFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981198; c=relaxed/simple;
	bh=oxImKa1eV0FwUaimY/FOsncvzQ7sNgoeD8dE4XJJ6Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S24NxhhPMVyaf129G/SGW4/JjHWzxCaB84KgLyKNq0RQNlrfzpj0HAunmI7o5emJ4mZnDZIF2VXmnEnB7hqV7Z4M9b+jyYaOHoEieUH6ny0rl90c9Dv8/MJsHIdE8Wc+TeYSiIgBYupuhK8IdbplaxLHi2MTpRAr8kujkIAPrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAHn0cKq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c922734cc2so61741385a.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745981196; x=1746585996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxImKa1eV0FwUaimY/FOsncvzQ7sNgoeD8dE4XJJ6Ls=;
        b=NAHn0cKqiAe78f/8iyGnz7kuWQ2iPVO4pJofAgeNJK9Ek+BtRJz/hoBJlx0CMc89+c
         jL56pqNBNK8QfOWmUbY+A4c4M3HiLGosOwuYP5YlPvNP42tESMqUYoiP5EiKUtQCdrCC
         qugVJxfXwqeiCNszWWAPRuewgRJB0oY9JEiVDcUUeLYXnE00GUxm2R2vZYtL8nztnSGW
         Nd9Gl2HxWJqcx2eiSirQb95OrtwNCQnwZGBL8jJXQBYwpUoVWRAKAbrWyJwP9OGVKq8n
         cPbkoAISlEgZ3L3aZvfFrWGUsH7j2CyGHTn7aaB4jlzPP0LsPnV4bIfrbMHZ3Zl6AN4C
         NaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745981196; x=1746585996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxImKa1eV0FwUaimY/FOsncvzQ7sNgoeD8dE4XJJ6Ls=;
        b=S1go65c6A7gqwo7q69QcsXnJEdOM9xfaD7hlsvMBTbYmw5Ga50Cwnr6sbZVnddQd1U
         4bfYKjC1z62d3tbJxg4QfO3KMZM6PRgA1hxIuKB17iP/y2zi/Dfxk12BKibKOcsE6ROV
         QVg1B6NWQBFY4sw7GbAMivdMAMNGg+/IpRKlrjHTN8SkZAAmcx+XBOdlTfq4PVcaeJzE
         O5+KaD1J9dRf1Um+bZz4ZV48c2AVHT7wj5NbirxhUpGN/rFmkwPz1FxAfC/rqphpFsuo
         E1bLJyzDKWVDYE6XAnAFYpWhO20q4+zKOHch6DMPazVVDhJVHifDY0Wb98LiemyM0mo2
         WDUw==
X-Forwarded-Encrypted: i=1; AJvYcCXCUTJaQkawc1F0yERqrowccImsAPlgwvvaNrIoMgQIZO6ZBLKdQwwYmxaPmGhPG3X2BUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwumkAg5psA4myXy7cgeeodPWxx4/LRZ10QgrroRFCF+qP52BFV
	4sWncPTUpXhsyLMVNRJMqKs12fLj3t1skLJXdW9/5+s4iYTLjrHiHNwFWVmAKa3I+LnWvFVAj3k
	VUPoMjB70TCeuoz0u+RbxKED/W38=
X-Gm-Gg: ASbGncsaY6llwjk00YB/ffH0W1Sll06PW2Eu+O0H8s5Ty1B4PUTGNIMXLFVlOM+3YoF
	UutcAgYgsk4+KWTJmcRomfpjjAkehaBkO6kWihJ/Le3agZrExgjBbiO3o7U+/EHFVaRpLDQ1JrK
	2EMd7Q00AJcy35rJWZRy2S3CM=
X-Google-Smtp-Source: AGHT+IECRe6ism+Yvu155vV8xPTVFGCcSdntqCfz4dursrRoKRjtP8bt5l7Trd3BzTh4v+v3iefll0v1JlBcxBrPoXQ=
X-Received: by 2002:a05:620a:2890:b0:7c9:574d:a344 with SMTP id
 af79cd13be357-7cac7b5c591mr165048785a.25.1745981196188; Tue, 29 Apr 2025
 19:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <20250429024139.34365-3-laoar.shao@gmail.com>
 <D9J8BMXE7LDS.3HMRLBRFZJNO0@nvidia.com>
In-Reply-To: <D9J8BMXE7LDS.3HMRLBRFZJNO0@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 10:46:00 +0800
X-Gm-Features: ATxdqUFuNqknhnnMYIWzYTSfrnoAGbPUY5z6qczYS7zqpTahwC1l4k5f4r29_zA
Message-ID: <CALOAHbCBpUG=mfgD20um5FfXybN=o4QOZvHVh0ghkaNofdwMNA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] mm: pass VMA parameter to hugepage_global_{enabled,always}()
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:31=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> > We will use the new @vma parameter to determine whether THP can be used=
.
>
> This is wrong and a completely hack. hugepage_global_*() are sytem-wide
> functions, so they do not take VMAs.

I modified hugepage_global_*() to enable BPF programs to bypass the
global THP settings

> Furthermore, the VMAs passed in
> are not used at all. I notice that in the later patch VMA is used by BPF
> hooks, but that does not justify the addition.
>
> If you really want to do this, you can add new functions that take VMA
> as an input and check hugepage_global_*() to replace some of the if
> conditions below. Something like hugepage_vma_{enable,always}.

Thanks for your suggestion.
I'll proceed with adding the necessary helper functions for this feature.

--=20
Regards
Yafang

