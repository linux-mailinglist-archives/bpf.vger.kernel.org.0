Return-Path: <bpf+bounces-40685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44D398C09B
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 16:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE081F22BCB
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F71C7B64;
	Tue,  1 Oct 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbHeVGK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAB645
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794128; cv=none; b=axGTTMTgJuq0hOFv3SJI4va+LLKhE3HxIqA85R8A4Eo1oUdJtjCbUF/J7wYoELt1VbvrbKsJ0OGv5s/qG0L/Uq8Aab31VBiijdilWdiRrlmoHvDMj4gJ/orGEZ6mLwbVw7pmG/AslkhCOCLErVZ4rxV/Pw20TEZ1Z+vDfkkSbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794128; c=relaxed/simple;
	bh=RJp94tR3B1kIP/zMGyzwp0OqyUM565GzNBA/bDk0wyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nT1mvXAZ7IORvcClY5GoWfkPdRaibf4yK2detcK6U5lgLKW4WPc9sOI/J3xzk/jxgsGwknhpmtDNInZuWP1W3zzQjtn9CY20sgScO+1Bj6bpG32njj3xMUClOojYvtkbuvmYDxDhjv0c+LS3n+kS0ULWg2eAyjN5nKz3JoFTo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbHeVGK8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so51494535e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727794125; x=1728398925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzAlOtl64dD1nbevQnq9MnpRidnPOsBdE1BMfax4RIY=;
        b=YbHeVGK8KMYYYeZj3a5zyo3aqD5r4lq6zkSKPTObs5+RtUL9tgu+J7SGYI3zIWQMRo
         NlZi77/J6Owp2jfWLQMMqzahyn9L9eHDL4lQJoYcxWHOFoOAAP0pTVCoP+I/yQgiJ8E4
         VuOz/0kwgEw4pRAOhjapbmO+p8GRBfIdtLtTAHIclpO8BiANpukz3aUv+qSWec+lcFPP
         L0vrZF+Pzlyp4vGfxiivCskTeB/9CtktM9QjlOUD07txyGTueS+lbPkbWQZdvtF68Ii4
         CeQE3O9JziboIourG50k32TDtEuNb+LWyzC5jLy+V4UZ63+FYS1rKHlUxS+wlhgFayHG
         qreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794125; x=1728398925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzAlOtl64dD1nbevQnq9MnpRidnPOsBdE1BMfax4RIY=;
        b=Xed7jWyu8dhcIoGlyv5e8GEsAa82ofVVBwRqJS0Ocng9ejEkMINxKgYNLAgQds2lIK
         emZS4mJBHUksoe/MH0jNw6lCQBTg7CMWRX3o7dr2v7fudvMd3JgZ8CaYryX25TDGtqpy
         QiCqOoP4Un68lVeQ0k1zj0EnLAOkZEHlM7pWOxs9S1M73+/t0l3pnQt/l9dcBod4xuUN
         GnOwHCGbKnoLKqRF272zu7WR6wWQtjb8utQQlUjkXZk/TRyBoE4rgq4GT9MEGz3LW4rq
         PBSkzH9NC+s90rl9M9A8Hy20bhCoGXMF0VkhnwGhg+pBqSdJybGj3fY2OQLJ+mNA3nvL
         fpBg==
X-Forwarded-Encrypted: i=1; AJvYcCXB6gxq9ecQCWal+0aQ7mp2DcB6bocybRYSlIS9AbC6XgRmnpSy6rPiNGrEKj9nWwr93z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzw4UYiPzwFjqyanam7K7fOrg/egtNGBf0pkxBU5Ss/MGEIXh
	c5PLU4QtAIyRfhRkLX73gwbGFYZ/7I65n/g+PTDGEbJBORcMfyumdN77rO/kBbVUp50xIa0rmjZ
	V5MI5rMW1q8Ws0MVFXB9KBA+D5ex+zOUu
X-Google-Smtp-Source: AGHT+IG9/F7iNGdSne55JFUYKoU0VKRjkBIhdGRtolVqDz5kg8IedqbMpQd8ErDXimOGPh9WSzkjNKw3DjZ9a0/h8qc=
X-Received: by 2002:a5d:678b:0:b0:37c:ca21:bc53 with SMTP id
 ffacd0b85a97d-37cd5a99abemr8336348f8f.26.1727794124873; Tue, 01 Oct 2024
 07:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com> <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
In-Reply-To: <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 07:48:33 -0700
Message-ID: <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Viktor Malik <vmalik@redhat.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:26=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > Right now, the only way to pass dynamically sized anything is through
> > dynptr, AFAIU.
>
> But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffix,
> e.g. used for bpf_copy_from_user_str():
>
> /**
>  * bpf_copy_from_user_str() - Copy a string from an unsafe user address
>  * @dst:             Destination address, in kernel space.  This buffer m=
ust be
>  *                   at least @dst__sz bytes long.
>  * @dst__sz:         Maximum number of bytes to copy, includes the traili=
ng NUL.
>  * ...
>  */
> __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void=
 __user *unsafe_ptr__ign, u64 flags)
>
> However, this suffix won't work for strnstr because of the arguments orde=
r.

Stating the obvious... we don't need to keep the order exactly the same.

Regarding all of these kfuncs... as Andrii pointed out 'const char *s'
means that the verifier will check that 's' points to a valid byte.
I think we can do a hybrid static + dynamic safety scheme here.
All of the kfunc signatures can stay the same, but we'd have to
open code all string helpers with __get_kernel_nofault() instead of
direct memory access.
Since the first byte is guaranteed to be valid by the verifier
we only need to make sure that the s+N bytes won't cause page faults
and __get_kernel_nofault is an efficient mechanism to do that.
It's just an annotated load. No extra overhead.

So readonly kfuncs can look like:
bpf_str...(const char *src)

while kfuncs that need a destination buffer will look like:
bpf_str...(void *dst, u32 dst__sz, ...)

bpf_strcpy(), strncpy, strlcpy shouldn't be introduced though.

but bpf_strscpy_pad(void *dst, u32 dst__sz, const char *src)
would be good to have.
And it will be just as fast as strscpy_pad().

