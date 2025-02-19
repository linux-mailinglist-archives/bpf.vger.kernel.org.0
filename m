Return-Path: <bpf+bounces-51913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD8A3B1C0
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 07:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90017A54DC
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BB1BD00C;
	Wed, 19 Feb 2025 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa+E8+aa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898651AF0C0
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947572; cv=none; b=jlyK9lA/gohb2VTrXrv6/LhKEtttDWIndX7cTemTGkMrZW87dGczJ4W471GgCAKatKxsf5HNBDDtZ6Gto7bg/gsWRTnsfUCPQpa8TNTznPBRdFP/kgOXXUKICTZNNHOaboS6yiPFyhPh+6ZDfJkcgQmK7JV+vcjwSV5QNgrHVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947572; c=relaxed/simple;
	bh=Wv3xdGmCtX80ryzDDVh65b2cN2UXpuKISSXjd/307fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2w8d5rpYpMi8EnVHIQZag8Kx3aQT34GSD09SgkM8c/AAxigbCeq1Ow9a7wsCdDKmY41WPQBScsbxIfDqbrb5h2BXCI/uy5H7oDQ/cVZlyeWQMr8MGIwtIP/7QDLMRc9Eno5CzGX+hi3L2XTjitav0R1sx4Rctrk0I7Hpp0LHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa+E8+aa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-472003f8c47so4983941cf.1
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 22:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739947569; x=1740552369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv3xdGmCtX80ryzDDVh65b2cN2UXpuKISSXjd/307fI=;
        b=Pa+E8+aadGDpuWW9RRv1rL7j8bD/ymM14ugh0V7h+XgDyb1EXLCKPOPLPkBONV6qmC
         br2Vmr1B+Xx7eIS+vESNcOBMLrbmYQujbt+V7aGvT6erwCLE/OpSmQmBe2YShlN0170D
         xrx25v1r5BHx+UiAYp1Uzo562dr0EtjZCGLvBHvwFeqaNReHlhRxUwwuCa0S6uA0XUbJ
         o55i6XB6bnSNq6csRHC8RDZEoArUUlJNhYiZq6bGnlS7roKRldf/PbCdMbsStoYzsncC
         x1CshBtexxVS6HRzusD3Dk+ueI1rB1iHB3YejIibvKrKbv3slGwUqaIbHCN9Lgi9a54/
         JlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739947569; x=1740552369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wv3xdGmCtX80ryzDDVh65b2cN2UXpuKISSXjd/307fI=;
        b=uv32Wa+TTNrJnAw+fXqE+S6rvXagqzuG2anjreST07ToVwmoiYUCt6VJZdxi1OK2vU
         pFWfMHjaKKxAfGfwM8omQD5DMCj71VQrVNOr6X0NNr3rlASsSYnK8KCmWqn7Ng3GKmyX
         +przQrcg20YJJ2ewQA/lhBul8OsBY6T4Y+A3nsUSbpYmMjoROLpvjKcUQU7sGHBxTEZf
         o0dan/BOO4zempv4jWHuhtXSzXt8YYG+duK6fslwxjAQ5Z8/jddj4NVTWO78VP0/aPpB
         BEg4EUeVdEdcDyCuchp7EAXbED/WQ+P7OmfG6Iz2ODL4n3oHRhkQ1HrM6eJBYtyAvOoO
         2v6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPiUfVU/npeex/4CTaLjqiiksMo8v52VVB+72u3AX4CBfeT+KCKBP6CCVc0qZr22hJIvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3IIGzH+YRzJHSIjCWgo8670rFRsWrBO4TUbnEk5G0AmVKBKu
	uD22E0hJYuNLbzOxHkv2CSwrOob/Elpyx7z/bAdnY975aEG0P1PpaDpDntbVkXmnyEJ1/xOzCot
	6mFSxXboJWs+/g52ht79G/iukCis=
X-Gm-Gg: ASbGncu+QCRuKyGaHM7DYHxP7eZqemCehI6KCbMxBrgLwKKu59JcVg0U/36vkOhCbKn
	WUwnEoYNxH0t5FO73xKAzOEk2WJMx+swhUe8yahkUjUnhbXTQbE/ieIWfUOnF8bdJ7ePUv/cyug
	==
X-Google-Smtp-Source: AGHT+IERqEVdzCBNQbzsj6EEzPs6dkzOL8VIvz5ULwNjF5nYmQ97Z/qGbvtiGQWTFB2ptaJIWDsStkjYOeaMtlz83EM=
X-Received: by 2002:ac8:5a47:0:b0:471:9174:53ae with SMTP id
 d75a77b69052e-4720812c43cmr33447271cf.23.1739947569351; Tue, 18 Feb 2025
 22:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHdT9g2Y6eXR4VsjOGk8i3kPukpB4vt5fJyM=B_V5aUgazVhVw@mail.gmail.com>
 <CAADnVQLdRrgvBSwS6ff=KOXGcrpo4tBQ5iZ_TvVow=E9qoF=Ug@mail.gmail.com>
In-Reply-To: <CAADnVQLdRrgvBSwS6ff=KOXGcrpo4tBQ5iZ_TvVow=E9qoF=Ug@mail.gmail.com>
From: Egor Egor <xwooffie@gmail.com>
Date: Wed, 19 Feb 2025 09:45:58 +0300
X-Gm-Features: AWEUYZmgjWqVHIgwOSNB9ItMkIGK-e9oG-lDCOHVHbow6KOKcSCU8CRUUjQHGY8
Message-ID: <CAHdT9g3UE+trv8B6Q8KGRg6R_E_djnbhv1UnWBkhNoXHQCGqkw@mail.gmail.com>
Subject: Re: Question about possible NULL dereference in linker.c
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think yes, we already checked dst_sym here:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+/ref=
s/heads/master/tools/lib/bpf/linker.c#2154

```
if (!dst_sym)
return -ENOMEM;
```

=D0=B2=D1=82, 18 =D1=84=D0=B5=D0=B2=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 22:4=
5, Alexei Starovoitov <alexei.starovoitov@gmail.com>:
>
> On Tue, Feb 18, 2025 at 2:19=E2=80=AFAM Egor Egor <xwooffie@gmail.com> wr=
ote:
> >
> > In this line we assume that dst_sec can be NULL:
> >
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+=
/refs/heads/master/tools/lib/bpf/linker.c#2160
> >
> > But after we use it without check:
> >
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next/+=
/refs/heads/master/tools/lib/bpf/linker.c#2167
>
> Andrii,
>
> back in commit faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> && dst_sym)
>
> should have been
> && dst_sec)
>
> ?

