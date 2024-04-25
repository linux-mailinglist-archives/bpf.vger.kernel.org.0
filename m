Return-Path: <bpf+bounces-27770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8258B1814
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 02:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F13A288FC0
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAEA21;
	Thu, 25 Apr 2024 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE+LJNrC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681187EF
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005293; cv=none; b=PlPHBM3hvQUUmjn1QghU1j/8MUosJnZJc5RpW1kWfEPptHZyg6N4bHAzZmOyq88mJkis3jQvwwzWw5OmDKLe9wpPrj2A4Adl1g3oj4UWagzmApIgCZ6vlzJ0jdgyl+7racCxjPZa7b006cjTI2L4ZSkAjnF0pzBKh5EWIqW5gZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005293; c=relaxed/simple;
	bh=TIok/uoQ5vC18hpxJ/RIhxTcnKYHIGJJ677lq2IF2b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctv59pT11ISV2zNyXm+eog9xBeIzCxnxaOcFoGt+zsotqtCfPKMqgHRdVt8QzQ3FdXxa9JSSuhQQZS/r7T2+FeJqO2hHmsTUGOFz+lPlRV7/fxRIingtAHejOgDWjsfzv9l/Cu56Zqfpqf+FsCPQJSc2jDg0rjdwWORYNpakq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE+LJNrC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f00f24f761so404082b3a.3
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714005291; x=1714610091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oyeJ/6lejp7Onkl1fbpQX/IbrjKPbYMeIGbsuWpVPw=;
        b=NE+LJNrC5e542lvn11fSvjGvs5uTfUMkmLxC4xUQrvKziDn+79x7IJ22y34/Qcil7l
         7W5g22ksxfUKX+CS6PMCpoQ21sybzJAx6ojkU2gE8GU6vqe0WXy08F9udmVMV2/cp6PM
         8xYqJO3pqavqULylDnRtkdBEUJb+lXoYa/0iECKTggGWVokdWh4s0ZQtR7KybiRYvT2q
         +lHneo31hH2rPRsDLKBGjJTJLDc1iteGgN0c5NShB1q3MMKugIbf19KclKVXXBz4Xhfp
         sj3vwyb6vJYi1EWmUfnDZMb4Nnz2C/iocK2iDbNmQT45HVjxpilLAVrtDCy3kbSBKtDF
         KXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714005291; x=1714610091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oyeJ/6lejp7Onkl1fbpQX/IbrjKPbYMeIGbsuWpVPw=;
        b=TcXVuFZqCyyF/qHDeBOEU2zcYLMNxjM6jNb8vuVWKiSaDicg4iVzvtSmVZAoYqhOj+
         EXcKMqsTASVe3AOhwZivGEiFPF+gzek1rMPgZKiH+SzeyKVG4axDVUG54IEGdaAd9LyG
         8xQrtj2etilvyrPOJ+LbveabenusWT3U6KrJ5obT5h0UYEZNU6lQLpRA1zAnqE7pOPqf
         GPbu9LH9v4omOep5gND01oEuuHz27vv+i2SkhC0RMaXXYKnXcMyKs376rtQcsYw0Ax1l
         LfI9XxRqOFLMGnjurCkzHJGlEJWvS3kYijRKtg9DZK0YH3vo+BGiYjy+rMVdLdiM2PWJ
         ne+w==
X-Forwarded-Encrypted: i=1; AJvYcCWIWyv1Gnhsy/e/3rdbv1pTO87sYBZo2RD1Mj14mBfQR61dmuKmEU0gG6QgjYHHKI/kcCG+pJa8jbFDPLJelHXDXGuJ
X-Gm-Message-State: AOJu0Yw3e4xYDULv5ASEdkWMx5F5xtsOfWgXcG9NEZrUj9iVIo3bc0Zo
	twBTHbxwnqfilZWkqbaOWjDOTLRiPFPVp0x7pEMyYEzXAIA1zG3+m5K/Ovvyz6sK1I7kIIyXwNC
	hs+fmAUUCnXyqyqxp9sAEYqGoPhs=
X-Google-Smtp-Source: AGHT+IGRa+BvZ8tcO5kvi3gIxUQJxxKY8SzBn9triK/KWuDvgy+qQrfN10zzYMv8mwvPH0UKiayuBalvATytQifvzl8=
X-Received: by 2002:a05:6a20:d409:b0:1ac:e240:8668 with SMTP id
 il9-20020a056a20d40900b001ace2408668mr4035129pzb.57.1714005291583; Wed, 24
 Apr 2024 17:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411131127.73098-1-laoar.shao@gmail.com> <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
In-Reply-To: <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Apr 2024 17:34:38 -0700
Message-ID: <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 6:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 9:11=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
> > added for the new bpf_iter_bits functionality. These kfuncs enable the
> > iteration of the bits from a given address and a given number of bits.
> >
> > - bpf_iter_bits_new
> >   Initialize a new bits iterator for a given memory area. Due to the
> >   limitation of bpf memalloc, the max number of bits to be iterated
> >   over is (4096 * 8).
> > - bpf_iter_bits_next
> >   Get the next bit in a bpf_iter_bits
> > - bpf_iter_bits_destroy
> >   Destroy a bpf_iter_bits
> >
> > The bits iterator can be used in any context and on any address.
> >
> > Changes:
> > - v5->v6:
> >   - Add positive tests (Andrii)
> > - v4->v5:
> >   - Simplify test cases (Andrii)
> > - v3->v4:
> >   - Fix endianness error on s390x (Andrii)
> >   - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
> > - v2->v3:
> >   - Optimization for u64/u32 mask (Andrii)
> > - v1->v2:
> >   - Simplify the CPU number verification code to avoid the failure on s=
390x
> >     (Eduard)
> > - bpf: Add bpf_iter_cpumask
> >   https://lwn.net/Articles/961104/
> > - bpf: Add new bpf helper bpf_for_each_cpu
> >   https://lwn.net/Articles/939939/
> >
> > Yafang Shao (2):
> >   bpf: Add bits iterator
> >   selftests/bpf: Add selftest for bits iter
> >
> >  kernel/bpf/helpers.c                          | 120 +++++++++++++++++
> >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >  .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_ite=
r.c
> >
> > --
> > 2.39.1
> >
>
> It appears that the test case failed on s390x when the data is
> a u32 value because we need to set the higher 32 bits.
> will analyze it.
>

Hey Yafang, did you get a chance to debug and fix the issue?

>
> --
> Regards
> Yafang

