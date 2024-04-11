Return-Path: <bpf+bounces-26525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6D38A164E
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 15:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D672BB232F5
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C814E2C5;
	Thu, 11 Apr 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls5pqyyN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E914D43D
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843474; cv=none; b=a9yhaa2oZAsgtteoPOit0+JnwIzvX+Vedlm/qapHIJC0at3mG8UExMS2v3DLMtD43utTiw5JpBBCwtgi0ri5MuP87FMm/wmtXFj1e2n1QNIimQC/slrPHdpAVsw9eLtQL7HucueezkiGasJJ1fglHOpdw1JBqfgxlJeOXJ9hHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843474; c=relaxed/simple;
	bh=PQsA6IO5YBnJMf8JTvVx3HqoyG0COADlfsJL6+dcuSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPdm6ZO5DsRtsBp5ymexjI13GCfTwBsK7OLk/ae/AyNRzYJFhagRe84A4EFXl/hBbzNx4mWcyCnbgGvjSvke/dUhLZEfCtdP6Y03nPfP1OEwnWYskTVX63rWhOmKfoHikpNhRDroQ0HuwCtFSWW9tlYDgv9H3AAUMnb+0+AcKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls5pqyyN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b10c9cdf4so19829506d6.1
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712843472; x=1713448272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u1QYYGQDcJo9OzjkP2JJDXZhNelGhoGR853mzF6FR8=;
        b=ls5pqyyNP4SgRCj782SOJ1nmee/kduK9G5LE2ziydMfRACdtlgxK7RssJxQVpUSHIl
         FxxKONH0W9nU8cnHGm2JoNX1+tAHDzaCrqq1ZEgfroyRP+aHXT/9YxfBK+9sPKqVIcCJ
         eF71vB2G5z0rdjkuY6Wh1i8HVFXpAVrUJ0cEuTOstH9uPmNEktEX5EqFdCBkmovfpSkl
         PJA2aWGx97/K0GizMfhzpeQeeCBZS1pOWz48eIA9xd5+43yAChzjr/E+qLnHyr/G8Mq0
         a6LPrjStLV0oISJzqLqCBjzCT864hH2lzq7a8Nw8PzBEWWd8187faoVjYXy+DT6ykwTe
         U+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712843472; x=1713448272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u1QYYGQDcJo9OzjkP2JJDXZhNelGhoGR853mzF6FR8=;
        b=E96vmctlCUNqMCxcTjNsCoxlyKMfCikU4WFiqPXzHlGn1beMFXRPjZGXlZVkKd9vMx
         ZqnmpynF9jCpeMImagvKlGaN4SnBmHevmd0f3d6I8uDBbPHWsni6GW9/fyzQeVsf9kNL
         j2E/NbX+PwfhfYgtr3a7xFvaoqq4QKsZxIumSm5/dL9aP0rlrxAY4ofEr1kWg9FbY9wR
         5lP9fyqBOKBdtVdDrPU8CG6m7hDbCp2sUTNHQ84D5cHtOvZXLIoLDG7Loi50Y025D+wN
         uYSzo0M9YVsb9SAHxFmcnSOLdYsvunQs27FZGbdAp9Mr0CgAX38e/kjDrD9E+yFjbW94
         hfJw==
X-Gm-Message-State: AOJu0Yz94GpVRYTeNFpXJg2a+JUSKGEgKMn+DYG+0sdWZ+vP0yqbOFdE
	2UntOvRzYccWNI+JtB0ysDMiOUVb0imPIBQJosx+DZWPYkZZ4T96KVYZs1Stn5V4bmmgWONiKEJ
	LvMryZZ+dfywhOYeTH33ROf2/QtfbOFxV
X-Google-Smtp-Source: AGHT+IHh5GolksBdbyL6KHMfJuP8jVZDit77xm/+D2Ip6MMEyxFnTlZKtkA/F2GF8SzWvsHHVtBMCKbAmoL1KvdcxGw=
X-Received: by 2002:ad4:5be5:0:b0:698:fc6c:3b1c with SMTP id
 k5-20020ad45be5000000b00698fc6c3b1cmr4756066qvc.11.1712843471740; Thu, 11 Apr
 2024 06:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com>
In-Reply-To: <20240411131127.73098-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Apr 2024 21:50:35 +0800
Message-ID: <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
> added for the new bpf_iter_bits functionality. These kfuncs enable the
> iteration of the bits from a given address and a given number of bits.
>
> - bpf_iter_bits_new
>   Initialize a new bits iterator for a given memory area. Due to the
>   limitation of bpf memalloc, the max number of bits to be iterated
>   over is (4096 * 8).
> - bpf_iter_bits_next
>   Get the next bit in a bpf_iter_bits
> - bpf_iter_bits_destroy
>   Destroy a bpf_iter_bits
>
> The bits iterator can be used in any context and on any address.
>
> Changes:
> - v5->v6:
>   - Add positive tests (Andrii)
> - v4->v5:
>   - Simplify test cases (Andrii)
> - v3->v4:
>   - Fix endianness error on s390x (Andrii)
>   - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
> - v2->v3:
>   - Optimization for u64/u32 mask (Andrii)
> - v1->v2:
>   - Simplify the CPU number verification code to avoid the failure on s39=
0x
>     (Eduard)
> - bpf: Add bpf_iter_cpumask
>   https://lwn.net/Articles/961104/
> - bpf: Add new bpf helper bpf_for_each_cpu
>   https://lwn.net/Articles/939939/
>
> Yafang Shao (2):
>   bpf: Add bits iterator
>   selftests/bpf: Add selftest for bits iter
>
>  kernel/bpf/helpers.c                          | 120 +++++++++++++++++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.=
c
>
> --
> 2.39.1
>

It appears that the test case failed on s390x when the data is
a u32 value because we need to set the higher 32 bits.
will analyze it.


--
Regards
Yafang

