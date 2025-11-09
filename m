Return-Path: <bpf+bounces-74004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34438C43A1E
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 09:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BC7134752A
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75626FA5B;
	Sun,  9 Nov 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3QdJTty"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA922FDEC
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762676498; cv=none; b=f1unAyVmJWlI1LxSv5cHscRLyVBA5yKs4+QyEFGi/x5Nz0ZBIda/NIsQUV1DlLcmT5l1vUn8XrXUNL68MTr2sHPXsklKU6EJVypBaSwrscLDOI7Rq50Zfxd3jwwD7FGad01GDrL0la6N+FOlGrmz3OfTmfggB8PP1f2vdY1HbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762676498; c=relaxed/simple;
	bh=blBxIzHVxMDkVOYTtn6sgPlXbPeUDm01RifRQqnXCR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMX84JcBa5RbqqmuKaK8fL73sca6lfL5rOrhskq1aVkFGTIgSTeNRGtsUA7oVhTupKbXZfPDAY7yDed9c02eGQCTIHg5x7hTzXyvjYgkKv68/bQX2zRTfGCVEc73YmcaGNluWQU0ixeUjjz5WJIfDH/QDVAnTvYKtje1+dLO798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3QdJTty; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-780fe76f457so19746397b3.0
        for <bpf@vger.kernel.org>; Sun, 09 Nov 2025 00:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762676496; x=1763281296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+G16wY2Uy0RV+AHrXQMNikD/m9lQ1yJj0Gcep7twG4=;
        b=S3QdJTty/L11BVtLiwPOBbzCAagOfkD+f0DsIARoixGNax9XxDN0k8JA4UxXfahKNH
         KLQJRcrqy/SbuWaYIzVPbcfBhodpb4zJbO0D4vjW8nqG8RiV1lvF8mHSFtfJeBifO6TQ
         SJ/ytDBmSLz7w2g4A58x9PMARyddh0L5y682OrDDrozFTts0o4s2FwWy2yzrQ8aYkPyT
         rCVt7Ux4Z2pknCmY/XoisWadoNXizg11SS00GoKluU+g+JSKRLU2yJ7bIDAFBLa+3Kv0
         SrhZt5aFAv4SgFWJgY3rj5t7zgRKXJtfqN50v6lwsXnP20a+X1aeGwREbFLze+cd1sRB
         1qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762676496; x=1763281296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+G16wY2Uy0RV+AHrXQMNikD/m9lQ1yJj0Gcep7twG4=;
        b=tEIfxYDfPLaxL8eZV1qm1skp6VpCTEDL//s4jmua3zlQDSqafnyDgAhz7buG59FyBi
         hNBG4nCfRIqAbhlWI43ZIJifILJpl7ffNwxw+c5e6sJZ1G36WoXur0+3s03wDNKVxeXm
         F8WQqvjBlHlotv90vfJ3TqxO3c8tu2/d5jKr++YLBnra0zZXWGnRhrOGtJturGtHR+a2
         dsimJNAwAXKCdSEkxxRe6ypXAIr9mkjw+GepDRcJHls1ZQJwHnQYnAQCfoJfImIaivlZ
         IJUIhvNjkzmR07PY6s7H/cMOMy/PmV5NeVyIiRKYrYc2ygmBvgFh8H/wLQKBccB+ql1d
         QpqA==
X-Forwarded-Encrypted: i=1; AJvYcCX7EGMPlxjYBYBRsOrlKsPW6Frr5/1BLeIbUoRMUR9RBQIr28bFPa9lDHGSLdtB6huV87g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRG8puOa0hc5kR61uMi36XLXzQrQczfn9nRgqXdNPowgiBGOc
	3bp0Na8I9ELvuy3D8QG7N4AzRtMNt0ZXqL7lO9w4roru4FXZwMNuWmUPJG7W99ZyTD05/9UTws9
	q9yaySijH57TkaDidWndZByoc7WkTY4E=
X-Gm-Gg: ASbGncurH5IQtZK408WgDkbSQNYhKZM2Ak19kzKiKGK6PXbgQDzj738NgEY9o398vpt
	N0hJ+IXyOj2ajFYgTkW4X9SSWI6jZufxyyMzCeiQJqT60LQaNAPQbvBQc3mkSv68tpNXGYvR17F
	2ciIdqlrzlH8xyxcSmUEJ7jo6LxyuzmThf9o4NnpwQFTnPOz2Xom8hD0fMWUOWcuEVx2AGHevzo
	1fBZ90BQRXv/nJiElkVsRjt26S32mtWUzDT7tTXIylAKZxSDdR71V4Cg8seNgbAgi3IM5b+
X-Google-Smtp-Source: AGHT+IEaqIye4DtDHgikTrookKOjzbjgSvwfAg40yRgSxZD6MgtC7CaLSpR7r2YAQlHytf/EZLr37UyRk0xdeDBmYNI=
X-Received: by 2002:a05:690c:610d:b0:787:ea39:6656 with SMTP id
 00721157ae682-787ea397030mr7757287b3.22.1762676495801; Sun, 09 Nov 2025
 00:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru> <20251107114127.4e130fb2@pumpkin>
 <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
In-Reply-To: <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Nov 2025 16:20:59 +0800
X-Gm-Features: AWmQ_bnJ-vvvsH1qxIwP2kkBXgkqUH_eUTNwEZRz0N4xm2likEq83gy42ECpYgE
Message-ID: <CALOAHbCz+9T349GCmyMkork=Nc_08OnXCoVCz+WO0kdXgx3MDA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: David Laight <david.laight.linux@gmail.com>, Alexei Safin <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Fri, Nov 7, 2025 at 7:41=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri,  7 Nov 2025 13:03:05 +0300
> > Alexei Safin <a.safin@rosa.ru> wrote:
> >
> > > The intermediate product value_size * num_possible_cpus() is evaluate=
d
> > > in 32-bit arithmetic and only then promoted to 64 bits. On systems wi=
th
> > > large value_size and many possible CPUs this can overflow and lead to
> > > an underestimated memory usage.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > That code is insane.
> > The size being calculated looks like a kernel memory size.
> > You really don't want to be allocating single structures that exceed 4G=
B.
>
> I failed to get your point.
> The calculation `value_size * num_possible_cpus() * num_entries` can
> overflow. While the creation of a hashmap limits `value_size *
> num_entries` to U32_MAX, this new formula can easily exceed that
> limit. For example, on my test server with just 64 CPUs, the following
> operation will trigger an overflow:
>
>           map_fd =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "count_map"=
, 4, 4,
>                                                      1 << 27, &map_opts)

Upon reviewing the code, I see that `num_entries` is declared as u64,
which prevents overflow in the calculation `value_size *
num_possible_cpus() * num_entries`. Therefore, this change is
unnecessary.

It seems that the Linux Verification Center (linuxtesting.org) needs
to be improved ;-)

--=20
Regards
Yafang

