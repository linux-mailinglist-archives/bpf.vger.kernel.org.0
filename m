Return-Path: <bpf+bounces-74626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D0C5FE46
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 250C64E229B
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ECD201278;
	Sat, 15 Nov 2025 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOx6es9h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A751A256B
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173661; cv=none; b=W8r6rotZNUD61iFthN3RLLTx2AAGD0bhuFWJnYFAxZGdy3PzKIbkmT2USVdm2wZQKsgilMuO7c8/Zz7s0m9SF9w332J7uhJ5IZOU9vlYZXslpJoaML9HQs8WR7L+uyCdiuB2YDlSmmDaVlgajYoBZ5xxAfjVhFPh8QQqrYrB3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173661; c=relaxed/simple;
	bh=G942TT1r9f436lBT+u3vS98wpc+cx9MJKa9zeXTSPi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EC0E47nl42MMCzqhSIL0mAyQ8EB9L00/76zCVsv4LTDZvtKlU2K2y3mfTUOOWQ00ZUYEZb43KlguZOdTOKn9SRpU0WgnCwT2Yb9JfhbrZ8vtIYu7Mmz4GGwKcNmOoWxSkolNBK1jPPd2JUKlnKHiHXm2gWfU2oTfPbQx/sS/8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOx6es9h; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47790b080e4so5813545e9.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763173658; x=1763778458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G942TT1r9f436lBT+u3vS98wpc+cx9MJKa9zeXTSPi4=;
        b=KOx6es9hCJ4cCiJsVt8vfpZ9Df81bxpqEU8SU9NRQUiSNQGiqg1jw5BiYfigbixO1Y
         g7H+jmLYfMDhyX1PEiH0DZsU81TTLyrXlpO2dKO7SeSaeLY3ViyRHFA5fQUyefZOQqFf
         dSz6dKp6/c37owqDxU3UGhBvL2ZrCRdIEEHQjTArLoC1zyIoevtQnYmDU+cufKdwI795
         Urh/aBY1BpCm9dkAOfnYd1m8p49rNjGV++bDPik2+xEGCPLErv6ICmzolWmfbotdc5Ea
         rGM3mBDWT0jyLIOibtSsPgvvbfWkZ/pdVHYRVfIqwd6EvKyJRc2lnO2QODSw0aidYyOw
         QypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763173658; x=1763778458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G942TT1r9f436lBT+u3vS98wpc+cx9MJKa9zeXTSPi4=;
        b=Y9FntanbwR6LmENC0xDM3Po+HZGczvlw6O6NkoraCnatRIuJRIwhUxL07lZhcbth27
         mRr5a2D6EA4LXdZKA8CW6N7ca0GgLGo/+xPYeiKLoxoqGPpsGxWcyB0RN9UzgBDUf4ir
         shmJMwXXmTiCqwvQZYOiVmI3qZTitcLLC6Od4hHD8HgM1GWWBH4leNPbfrWD7bliPfCI
         sHjWcz541gmxmihN+K33jOnzMOM9TDPL47Vd6kGbuE2Gm0IQHPtgAn4TMVnoRf+HKWKD
         GcjcfT5Us7YC/rzj+wAPwY8wEL3W+hDAJ+TJpVCmQezyCJeCIyA/LXa/mzXSCZ8btIbv
         uchQ==
X-Gm-Message-State: AOJu0YxOoLn89crFzzq/ey6GViG2ehcm2q4N7haw/qe/LPoUUNjR+ZZr
	Okuez5RsTbGZobWFE+hY8gx28c8GlVetIl/FeDPHR9Lq45raGH891LcDZrsweQwuRPj1/ej60eG
	hTCoWQCP3buqUgXRB7xH9RRbyjB4n3oQ=
X-Gm-Gg: ASbGnct3ePp97OAVD0WfyFevLSC+9IP8FWWGoy2cOLpTWIpdiBm5WvkCV7PZDr8p/2E
	GW/+v+seL0syAJgMpeZBPoReQ96PDYAKVwAoDTnTpv23yxXjkrx+iRN0b/dkYyx6PbP7rZwybnk
	JydIXxRcmAvt6uJu1NUsQF/x+pQeFxO4nJs2/nV2kyASq1NsvxTiLy3RAj2+PV+SUVFmZZOA3KC
	jSd3fcPque717Ia3x+hPKVU7b/4S58Y2ZWCA2sMnsL52T7aN2yyhyHD1c+gLppmauKhgy87PCd/
	rUew8+vXVCbSD98HdvDDnL/RRo0V
X-Google-Smtp-Source: AGHT+IG8RgCI7vny0f58mz/Yh0VAhrDFd+aokvzJOFa6/vCtTE9G2weJVdeGe5nw2K7G4XpY/BJnpxM+R5VL27K2zTs=
X-Received: by 2002:a05:600c:45c4:b0:477:8a2a:123e with SMTP id
 5b1f17b1804b1-4778feaf9bdmr49470705e9.33.1763173657621; Fri, 14 Nov 2025
 18:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:27:26 -0800
X-Gm-Features: AWmQ_blV6pr9CutkHpzoAJsJlvixvdr3UhAByhfV1CQDvObD5tBdPw7Yym-9P9k
Message-ID: <CAADnVQ+AsvqZZOPmga0VsavQNt0Qc4Gbh9+KPSkaxoOsstELxQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/17] bpf: Introduce proof-based verifier enhancement
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, Hao Sun <hao.sun@inf.ethz.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:53=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote:
> this enhancement, 403 of 512 previously rejected programs can be verified=
. T

This is not a review yet. Small question first.

Your github repo has ~1500 bpf object files,
while here and in the paper you mention 512.
What's the difference?

I tried to categorize failures from many of these ~1500
and lots of them are similar.

In paper you mention 3 examples:
- ptr + str_pos, with size MAX - str_pos
- s>>=3D 31
- &=3D 0xffff

Did you categorize all 1500 failures into categories?

What are the specific gaps in the verifier beyond these 3 cases ?

