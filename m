Return-Path: <bpf+bounces-77366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEDCD9B84
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E29300FF82
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D226E710;
	Tue, 23 Dec 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9QDkFJo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6A26B2AD
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501513; cv=none; b=JuUn07PLHuqHeMAxsTBlfJpr8P9vXIvXAWAlxN0HuM9ddaLRzUVf2u8+mpT8+ymz1X8Q2cn+HrjiU+C+T3pp/LhvqOc97EF31Btuiv2g+EKjOCRbjkV6YojM1pVQzRfX2NWZ8wplz+yHR09NKy7jF2KEnFM+/HEkrsFLq8tPg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501513; c=relaxed/simple;
	bh=5TkxLIe379XzkVpqJckJmsI4a+3fZJyA6vm3R9Opw1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acEml9Iox562u7TtdpTKWxCzKshu0D9MGXi6xXwdBf5d2KtvI2XycA2j19uAzc0hGUiMpZjXi0R9YwGH86IXgX+2/xfopaF9e3A2Ql8w8Et7cVtW3ZXmriHj+GR9EBG8O9rIFl8fToMVm5sbTntWOFVNDAfp4Tn8rQCdMiy4cxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9QDkFJo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7eff205947so725270766b.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 06:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766501510; x=1767106310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq2U0AFE/sS3BhKWIpShaTr0v6AziCj6ao8HUUYRHys=;
        b=V9QDkFJohEAgmtByZ7CCz3ObWb+QEU3+X/a6vAZTHXaPocJefGQgSxyonhz/IR047a
         0YP8Z91YosJcRmH0sevt9REdfg8GUwZNGk6KsRn2T7NmTd/ESBmm2TKj47EYtRJRRFwa
         ZX3kqC3ejp1TUu/3tk9JX4Im1CPmoHqE2Ly1H1KM+qmz0jLgUohVUKn7vhJNTfC5R8bf
         NnkVs8medO4KAW/7vXp2JB+Kuq+mFDP8yk16eENZD1wu7UlS9yb27KrdxT4QP9IgviGt
         c78nY5pDBTFGl6/WEte2Iqgc+p7gD0Pg49WGhL5F+SAPKCSblucVtyj6HGWakGNUHU8p
         XWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766501510; x=1767106310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rq2U0AFE/sS3BhKWIpShaTr0v6AziCj6ao8HUUYRHys=;
        b=jS4RsjfvfKyKcae/60vtGxdoTH/MmLMdzZdziVWTfdbUWM+GwKNpsFZQg+uFjx/bF8
         ShDNoye2ONK1sXhdU34M1AzH/tZjlSoi+gU53mYX/hnVhbMdDeOCU9YM9g2JsnV+lk0/
         dxwbdbpZlNRQxWfByrznjCg3FexAXnXQO4I3iYX6vfsQ29tcCpYEvin5wEC3Wi3hKIj9
         ml03BP1Fk22Zl87bO7RU1Gqz7pim687neyyId9fP+Ru/aSWhypl+kX2BZWYffQwDyMoC
         9vpDAhMxpTels6pnlVmGwt5S+0blrY4yo++T3Px3lFXDvVIpGj8lQwW7ij0gn+LKCAS1
         gp2w==
X-Gm-Message-State: AOJu0YxK/nlrVWwSuE1MLTQb/aI1pvdwGsHyUWZ51oP3vWQuI36uhiuX
	kRGGY7ns7qqRTarxvNkkypNBqAkb2NfPLOlJd5u3hoziLJ5Ss6af0NtBG+TXKfe0S3qrnyKjVfR
	8/beCj/HrDa7eOlD+MhvDvZ1+TF/qayM=
X-Gm-Gg: AY/fxX5O5CxvGJ2PtN7fb60CSFeJHcGOcoOfXeolr2KiJl032kOqaYoDgCgCFYWKCDv
	cP/tv6lyO7Cg7eu0nQ2gZty8PibAP3k3b10P8oIXtBpiMoWHppZYjJOVM7QbpPv+v5esKlBQ9lR
	FhG8VJoD1S0ikexUDh6LFkEPIKAszu+r2UK8NyH/l5p2FEjS2tOwNJOIheA19LjrBtw6iykv4TA
	WefCFtpcuM0U1qsykHfreV/ceqbwDzj8cb63MMAb+dzqcTXxpOEjdqz+opvOrXILbQ5pUl8VDF2
	ZmqZopzpBFQ=
X-Google-Smtp-Source: AGHT+IEY6Q/8GUtsp/XLpCmfCt+v6+j6Lj1b8ADOqE4l1HCwTyOIP39cA+fvE6siqM2WHB3ZoNQSXBnyPBuRHogBcYk=
X-Received: by 2002:a17:906:cc5d:b0:b80:3fb7:102f with SMTP id
 a640c23a62f3a-b803fb724eemr1078526766b.28.1766501509555; Tue, 23 Dec 2025
 06:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222195022.431211-1-puranjay@kernel.org> <20251222195022.431211-5-puranjay@kernel.org>
 <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com>
In-Reply-To: <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 23 Dec 2025 14:51:38 +0000
X-Gm-Features: AQt7F2pESQfAJMKS0Wg3Vw_BtF19t00-fD_KRlUYIeQDIrDGet85DJtwvjZp5W8
Message-ID: <CANk7y0jLCBr3j-Tz_Lg2kJiYc3vPrXei+QhAJZ5Au7QEBQbfGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 5:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> >  int reserve_invalid_region(void *ctx)
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b=
/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > index 2b8cf2a4d880..4ca491cbe8d1 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
> >                 return 9;
> >         return 0;
> >  }
> > +
> > +SEC("socket")
> > +__success __retval(0)
> > +int big_alloc3(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +       char __arena *pages;
> > +       u64 i;
> > +
> > +       /*
> > +        * Allocate 2051 pages in one go to check how kmalloc_nolock() =
handles large requests.
> > +        * Since kmalloc_nolock() can allocate up to 1024 struct page *=
 at a time, this call should
> > +        * result in three batches: two batches of 1024 pages each, fol=
lowed by a final batch of 3
> > +        * pages.
> > +        */
> > +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NOD=
E, 0);
> > +       if (!pages)
> > +               return -1;
> > +
> > +       bpf_for(i, 0, 2051)
> > +                       pages[i * PAGE_SIZE] =3D 123;
> > +       bpf_for(i, 0, 2051)
> > +                       if (pages[i * PAGE_SIZE] !=3D 123)
> > +                               return i;
> > +
> > +       bpf_arena_free_pages(&arena, pages, 2051);
> > +#endif
> > +       return 0;
> > +}
>
> CI says that it's failing on arm64.
> Error: #511/6 verifier_arena_large/big_alloc3
> run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0
>
> cannot quite tell whether it's sporadic or caused by this patch set.

I tried reproducing it locally multiple times and it didn't fail. It
also doesn't fail on manual CI run:
https://github.com/kernel-patches/bpf/actions/runs/20442781110/job/58740000=
164?pr=3D10475

I assume it is sporadic.

