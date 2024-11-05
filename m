Return-Path: <bpf+bounces-44076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81E9BD80F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 23:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540AA1C20FF5
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B94215C7D;
	Tue,  5 Nov 2024 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvXQiTnK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8853365
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844285; cv=none; b=YHVAhLN0SZ+y2FeA3t0riQZcRQ+yX0RsgzX+qB+X+/2bnXFG48CgpwBEl1y8etOLA+POQd77dAWMb+YetlG1rMmOiwg1KS9yoUSxsotHuvWgGvxBMOtfKnHnLyOYVEHOXNupmdht4BKAsRy3mFKwIbRmmoNcQyoPnqUnN1jQfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844285; c=relaxed/simple;
	bh=E3WeZa5tx9+CS9kr+xHICq0jLFonYlXDSTzM5NqCNC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVgEY7F+x4rArTMmdNP72OaDSoA7PaMb2GkpzLo51Ew/2f9SNzW7J/8rLhMiUHZDVQ2qSRsYBZW1jiIPeI0ULnAksWE84j0I/8jgx1Lqm3uhbchCEebl8ChWqQA+4yHDASETLwbqXwe4BUwweRBdsRCBqTtMKYZ1vYmPvHdoKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvXQiTnK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so50607115e9.3
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730844282; x=1731449082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZwQmpLC53Rh4bIbcycX3BieMx++Kuddt6bqaRnGvMI=;
        b=hvXQiTnKBmrzDy76ZDCjFfNN6Qwc3ksrq7hRoGTobnEtJX3uraoqI9MPbZebR5RMZA
         GlsUjcNDuzs4YxeWf+xSIol5H5mbJMTJihv+J5pFeZtQ48MJXWBjaBx9vaQ8+siuJ6wX
         /Ntq4sQqryRjjguifI4e9iXuEPL1cWMUQxVm/0PRdyrajG74IQ9rzRxnW58JbN6cetKl
         yu8UuLIuCVGm5wEgnukYBDMSe4j76gevedioSZwwHdXcKCrh004Z/KZTtJDY2o9lKiKd
         lsx4L4/VkBEZbixwb/n4t1wimmI9ZxFzzbpGsZpPPrNY3asRYq8z/4m3/UD4BsRRDhah
         GvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844282; x=1731449082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZwQmpLC53Rh4bIbcycX3BieMx++Kuddt6bqaRnGvMI=;
        b=to4Ya4nxTcmaLSYfWpiLwAEAWRETQi2vTx/mUQiB8qvcbyU0GN3Too/ScA2kuY7KIW
         LYBt5r7eUeu5OKEDACbbaL7GQAiQ5pXzD5mLdw84UsOibhNAThn9xf/WbRxnWKsSr0Zh
         x1V/VZWWLiAMRyRgO7IwiFB2ZhSYal8MtcbJcFjRG2fqak5iuhspiUzICrdZ+Nbvq5Ev
         rzb6aGawKsmVH+p30NrPcMQhbdyjuuKCloDqCal9BjVe7MU8dh/SU8PkdRy76dHLDA4W
         ObWAF0qNNWjNrvoCvAs7Mj8JEijIwVc3L6dGLYMB1cyul0TV70HyiMBF9tG6Ob0f/rAT
         EEWw==
X-Forwarded-Encrypted: i=1; AJvYcCXpwTphWdPv6UltaEQjd9pBTKsyIDD1cKAaa856xZaNfYyVqvKG2cheHihWQ2nh2xrglFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/8QCbzgS04mx/K+vy1oQJQAvgV7mjIo3ZVcBhuaGNMLlfWwl
	qTENAbI8HWDedviV2dfTi/fnB+HVygwPD/U+kWOU2KiaE3SSlb22/QlQEyI2agNppCmfEyd0Hqx
	sqzJUf0aiyoljNlzsDTzUFhkM+NJgbg==
X-Google-Smtp-Source: AGHT+IH1fSNUVyz07ioDcQfLUa0ZAQ+C3ZLGeycCaSBmkm6FcK37HWYngR/D+dj+ktMVyjQLbOYel6Htqtst8Fr2esY=
X-Received: by 2002:a05:600c:3583:b0:431:5503:43ca with SMTP id
 5b1f17b1804b1-4328328494dmr135567685e9.28.1730844281696; Tue, 05 Nov 2024
 14:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105043057.3371482-1-houtao@huaweicloud.com> <f623ff5d0855ea22e60ff607420fcdde8be9c9af.camel@linux.ibm.com>
In-Reply-To: <f623ff5d0855ea22e60ff607420fcdde8be9c9af.camel@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 14:04:30 -0800
Message-ID: <CAADnVQ+5c3XB8_REG907Z7nioC2594bX-k91xmkkTWzG00_O4g@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Use -4095 as the bad address for bits iterator
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Byeonguk Jeong <jungbu2855@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 12:18=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Tue, 2024-11-05 at 12:30 +0800, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > As reported by Byeonguk, the bad_words test in verifier_bits_iter.c
> > occasionally fails on s390 host. Quoting Ilya's explanation:
> >
> >   s390 kernel runs in a completely separate address space, there is
> > no
> >   user/kernel split at TASK_SIZE. The same address may be valid in
> > both
> >   the kernel and the user address spaces, there is no way to tell by
> >   looking at it. The config option related to this property is
> >   ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
> >
> >   Also, unfortunately, 0 is a valid address in the s390 kernel
> > address
> >   space.
> >
> > Fix the issue by using -4096 as the bad address for bits iterator, as
> > suggested by Ilya. Verify that bpf_iter_bits_new() returns -EINVAL
> > for
> > NULL address and -EFAULT for bad address.
>
> The code uses -4095, which I think is better, since it's the current
> value of MAX_ERRNO, therefore, IS_ERR_VALUE() sees it as an error. It's
> also not aligned, which may be an additional reason it may not be
> dereferenceable on some CPUs.
>
> Other than this discrepancy in the commit message:
>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Fixed it up while applying.

