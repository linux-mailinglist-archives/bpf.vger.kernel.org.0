Return-Path: <bpf+bounces-60556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E309AD7F8F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34821770F6
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484321B4141;
	Fri, 13 Jun 2025 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw1wTcz+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5A1885B8
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773938; cv=none; b=AG3W9xsfzXM29a9hbKI+qPAnEizlfnvJkQpkcEaQ7PLKC3KZxsNPLZhfmjfklLxh5QceAD9aM57i0kuk0tBOvH3j+je3/pMKWFVTK0qPWC9kGs6TFyX9q+bTTMiWGoIUGh1MXcHSHa6RCOQ4fzg/+MA/VnF5IiggXxNJ5zmbzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773938; c=relaxed/simple;
	bh=L/zWdK+0hBwjVucBLfFQHV3tSijkEetyJGb+7qMyxfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6Ow0irkC2cU8lz9yA3Y8i2hKBLK5vCzUOGmXyJeEdcoJ5Xzf+kwQmXMJvlYofzcMkZz9DzPeFDMM3yNf7xWOo63NZP2iEKzNL+3Fzx5vJ+T56hOe4dBHaJmX2eZj1ODbsfmecGJjvd7fCfKBWcTWx58whFUZl9UUnRhGhuyNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw1wTcz+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2353a2bc210so15220475ad.2
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749773937; x=1750378737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG7cHqXyZ+kgrFZutdjAxQUvjlG9+E/QnEyW3zigS0U=;
        b=Qw1wTcz+IWK9sp7QH77wnJiHMcn4mF1hUJGxv0P5nzla/+VR8CRjcKloADWHISMz68
         5C+idgg4CzyelrsuSq5UngaHjOjGwUOkv7WpIZnwA8yzYtG7Aw8ZrVUXfgE7cKL0gXRJ
         NaTm+LOk1+xTGZ6L1cxnw46uHbU4WiHPqEtzy3W9M1kDhjTJYQjtMTHM1QSpqToljqO2
         U0O3IJDduJ/FWSFMHBTAkz5+Wqs5P3BLIOpJFaMqFQPRqSkrND2g/fUOb/xCwqb2y/A2
         1sXOL5GfFwkiFJ01F//WVcRY4FE5dYY3Nz043pCMLgXUk1t0TWK7O7lx4/9saNWN7IpF
         PpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773937; x=1750378737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG7cHqXyZ+kgrFZutdjAxQUvjlG9+E/QnEyW3zigS0U=;
        b=e3O+/wuohwkmw0ar0UN/vdxUSFUb7IDEfhzhQMbyeTn4KKTpqOUPCH6UvlOwnK9sdg
         k1bSlnPSNZ60joEt04jVnwey3iLA94EGOJQ0g3ZLL89heTLEwqLk473E9RoFvOAdm5vt
         YAkIUXCT5iTTOU2BTZHafo/U/6cMX2bZao6mWUN7/ZXHJNDmXcrPGe8FCs3109gnIIvk
         gEAMkTOrCjSl2H4B0KQeNLttOPOr2DYGJsq2V8J0H06BIfKfz4BqjTyW78BRDOJvX5lK
         5vkjcH6ejj6uV4uqg7vCme4+hzG+2309wOr81j9h+217HMKwLGD+npAPp/ihrbRE6dLx
         Zvhw==
X-Gm-Message-State: AOJu0YzU4BsmvjAd8qgJVY6Dl0G1BHmEqeEOVhLTrEiN+6ucPwbmr1fI
	2NalW4pdD5ptmMHemm7ON0/DMm0mPVYZWC/5LV5WfDAAmXxqlynoGzCZnFIzaWkSUP+Q7yGdm+V
	4E4v9HiY1l5LGgMv+K0zw8WI5nK6tweU=
X-Gm-Gg: ASbGnctMr2asNS86kjOG1mbA0qDlKK2UeW2fff95wZ7HZ5wqJDJWLADW5wNTceeO+hm
	sh3eOHyDh95BDFKFZJPDexWnnA2PlgUZH99LT1Tt02mXHC78vg5eP81lsYt4xA99Ku4qLfiOwq5
	O6ordKDImzQDcsOaijEAOPn+cgwWKtMkwYIVJ2W0D0LteuWzPvWIYP0tZ+ioc=
X-Google-Smtp-Source: AGHT+IHzl+nrJ040sCon8e3qSzF7d+CkHDig4i8Qfg2KMGxQu4RwcHXsJUdXIW1yTzSL1yXOeqRXyaJv6mf6xQ+I1tA=
X-Received: by 2002:a17:902:e88f:b0:235:225d:3083 with SMTP id
 d9443c01a7336-2365d88bf9cmr11180135ad.6.1749773936739; Thu, 12 Jun 2025
 17:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612130835.2478649-1-eddyz87@gmail.com> <20250612130835.2478649-2-eddyz87@gmail.com>
 <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com> <1cd8ae804ef6c4b3682e040afea7554cb3bde2f8.camel@gmail.com>
In-Reply-To: <1cd8ae804ef6c4b3682e040afea7554cb3bde2f8.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 17:18:44 -0700
X-Gm-Features: AX0GCFsjFaTuqUYqFm4EzpVPgsqx1sD7eOeLWFZTNc_3LIVOjRWQruDursiUv-U
Message-ID: <CAEf4BzbSy_imqzs3Z+GAb1iA1WKs+vDkO1Q6pDmd3zzL-Ttzdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: include verifier memory allocations
 in memcg statistics
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 5:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-06-12 at 17:05 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > We have a bunch of GFP_USER allocs as well, e.g. for instruction
> > history and state hashmap. At least the former is very much
> > interesting, so should we add __GFP_ACCOUNT to those as well?
>
> Thank you for pointing this out.
> GFP_USER allocations are in 4 places in verifier.c:
> 1. copy of state->jmp_history in copy_verifier_state
> 2. realloc of state->jmp_history in push_jmp_history
> 3. allocation of struct bpf_prog for every subprogram in jit_subprograms
> 4. env->explored_states fixed size array of list heads in bpf_check
>
> GFP_USER is not used in btf.c and log.c.
>
> Is there any reason to keep 1-4 as GFP_USER?
> From gfp_types.h:
>
>   * %GFP_USER is for userspace allocations that also need to be directly
>   * accessibly by the kernel or hardware. It is typically used by hardwar=
e
>   * for buffers that are mapped to userspace (e.g. graphics) that hardwar=
e
>   * still must DMA to. cpuset limits are enforced for these allocations. =
a
>
> I assume for (3) this might be used for programs offloading (?),
> but 1,2,4 are internal to verifier.
>
> Wdyt?

Alexei might remember more details, but I think the thinking was that
all these allocations are user-induced based on specific BPF program
code, so at some point we were marking them as GFP_USER. But clearly
this is inconsistent, so perhaps just unifying to GFP_KERNEL_ACCOUNT
is a better way forward?

