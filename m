Return-Path: <bpf+bounces-41650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEB3999485
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90437B22DFD
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365C1E260B;
	Thu, 10 Oct 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNpy7F1e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1D18DF6B;
	Thu, 10 Oct 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596366; cv=none; b=Gp117jyWQxxy5Oz2/MfA3E1qV2WEJoc6NvRU3afX0VWmIIV+knzu2+frnRXNiPVSDrJhqQtqji/ssqVk9XBqFZPX6m2e6xp1lTMlRFmHSmNhft/6mayG3aYznZYUtuJAz03JYqIkvguTqoYI1rnW7O5AYy3Cy9bvSH22rgMDC/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596366; c=relaxed/simple;
	bh=XyYW6A6c8SZBEh5/bYJIXoKJoFg/MQvzLyWnhYNLSBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMeczTa4PsJWcnp02E8HIuuupTW11068DfrWRDpv3RMibhqkxYYScErGMdVuoNoewqokcqpSVKKAqrRsDnmvIVu3sVnlfzAW9OmtrsKVyui/5S3LBvEHCt7dy/N6Id2Fo77DaHoGEXXICFm7Mii293ZO+Z6VwYf6jx54U9UkQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNpy7F1e; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d533b5412so245159f8f.2;
        Thu, 10 Oct 2024 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728596363; x=1729201163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSmm3ujWM9Lc1PSwYMhMkjrX/ACOqoUCH/T2z1DTYLQ=;
        b=gNpy7F1e9QB+NyqzBNKGN708FOhzSOmSBcDCAVtqzMt3eneBrn6800onf6dHtHDX12
         alLw51GE+TCzgZdDibRh8TyV4PnI6DErMVqbYVnCPObK/oZgxpr5LT7JZC0JONwYgFNj
         xLTmD2G3kHULpe6+7FZiQkW6zcFYFsNF1ei/0qy6VAgVhMOCtodiSGSz9gi5kMcC5XXh
         QID7dE2RYgD9QFFG6VOXkGvLNok8vuZ49Rx5+M4dx5fGYrjObm2Nsmw4R03P/k0CFc/m
         +Tld3mYAvz/wPi+jRbwrbuc9ddNDqxx9OT2/CLYXO5xLCSAfrurULhtXXlqqEQB4STvY
         URRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728596363; x=1729201163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSmm3ujWM9Lc1PSwYMhMkjrX/ACOqoUCH/T2z1DTYLQ=;
        b=m+NhqrPgz5Xm+tzDlODYaq4S0aHK0HU2JVslW8e96PJ3dZdO20bqNcTtMtVS3GbCYW
         C2sVZ1DMGxh3AxHQuzculXJyIRt1rtLrb6b7sEbB57ct/bkkF8iTeb/VtssDBLiQBAsG
         DPMpXaHtV9HrM04bocCjt78lP6A5iA1KfNTHHHLeyMfzrLKUX9xGW5avubZdfFWCAxFB
         ji7Y+3XqZkaQlxteeLuh5BfAKF4dD7EsKJbucdw3dSrVuX8fSgJl8yNmOozTk57dH98L
         RhFLsYhlk5eIzfGHa2SGbfJKCP/vbBVVhouprqlOxFOMXTje3WH8q+0DAMhl9A9l62Wv
         lwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEP/kffFmVLdhbyBdTT1tHCi+REDvMNahOVApgLXHl3Afb0VkISKNsrfyNd1w7khiQpvjcGWRfRiFSlP4t@vger.kernel.org, AJvYcCUjScexdeeeEizGsGtcCgdGnAiZ7DQ2KUlNmqPzbMjPdvnT0iTX8Br2Apbf2zphUtZ4vG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOYxTWz+Yr9kNpy+zpSwVfdyWmi+KCShOer1B/pRWOimeiMu4
	Yj9icVBJQDdCZ9rSq8wC+ioTJiLHoS4tU3Pi+2c81sRjFWwsn6iyQByGvAr6i1aAWnRZNtdkhF9
	KUAFmEJnP8ZV2cy0y0wJXjNUEIUY=
X-Google-Smtp-Source: AGHT+IFMEBpaLju4jvCLHsZaAkZnakbHbO0bzSr1Lxhx4zkylvqs35dJaafFDVXRM129wI/Y/PIljSr8Ivm3T6d21+w=
X-Received: by 2002:a05:6000:181a:b0:37d:50e1:b3d3 with SMTP id
 ffacd0b85a97d-37d551b76c9mr259081f8f.20.1728596362610; Thu, 10 Oct 2024
 14:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNNPnEMBxF1-Lr_BACmPYxOTRa=k6Vwi=EFR=BED=G8akg@mail.gmail.com>
 <20241010131130.2903601-1-snovitoll@gmail.com>
In-Reply-To: <20241010131130.2903601-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 10 Oct 2024 23:39:11 +0200
Message-ID: <CA+fCnZfs6bwdxkKPWWdNCjFH6H6hs0pFjaic12=HgB4b=Vv-xw@mail.gmail.com>
Subject: Re: [PATCH v5] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: elver@google.com, akpm@linux-foundation.org, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:10=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..cb6ad84641ec 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1954,6 +1954,42 @@ static void rust_uaf(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
>  }
>
> +static void copy_to_kernel_nofault_oob(struct kunit *test)
> +{
> +       char *ptr;
> +       char buf[128];
> +       size_t size =3D sizeof(buf);
> +
> +       /* This test currently fails with the HW_TAGS mode.
> +        * The reason is unknown and needs to be investigated. */
> +       ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       OPTIMIZER_HIDE_VAR(ptr);
> +
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
> +               /* Check that the returned pointer is tagged. */
> +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN=
);
> +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KER=
NEL);
> +       }

It appears you deleted a wrong check. I meant the checks above, not
the CONFIG_KASAN_HW_TAGS one.

> +
> +       /*
> +       * We test copy_to_kernel_nofault() to detect corrupted memory tha=
t is
> +       * being written into the kernel. In contrast, copy_from_kernel_no=
fault()
> +       * is primarily used in kernel helper functions where the source a=
ddress
> +       * might be random or uninitialized. Applying KASAN instrumentatio=
n to
> +       * copy_from_kernel_nofault() could lead to false positives.
> +       * By focusing KASAN checks only on copy_to_kernel_nofault(),
> +       * we ensure that only valid memory is written to the kernel,
> +       * minimizing the risk of kernel corruption while avoiding
> +       * false positives in the reverse case.
> +       */
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(ptr, &buf[0], size));

Nit: empty line before kfree.

> +       kfree(ptr);
> +}

