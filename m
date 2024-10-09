Return-Path: <bpf+bounces-41335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8A9995D2A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAE71C23013
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59C2BD1D;
	Wed,  9 Oct 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuiINr0s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B11D69E;
	Wed,  9 Oct 2024 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438227; cv=none; b=DKO28Ka6NhiSzwZn0OVOGLdGVAFk4AVF4/Ez2sh3lNAu1vjvqAHpwIbVTWCSS9hejYth3iyPn7QuGFsRz7bbQI8nS4yBJWRsxa+UJO+fbPGPTC7pf+d4WrIkrX1dnTp9XF/0wz6JyJb4UBTAzi7RBP641WuUgFccZ7W7l1B6EvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438227; c=relaxed/simple;
	bh=rD/GVxv843cpdnkuSplLtT57kw+GZ4JQGD9p0vihxic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhPTP3pCvLpWmE4tAZoVrOIJ3KXQ11N79sl5ntI5knTqDRGi3/K4BQX4+YDiistjfz96HTYWnuWR5ZQU1gelGT888taLJCIhIiQPQmX2y5Va7hVDo0hi6+tC5ynH7xMMMI+SVxOZYjb+H6Blt1fB2fmxAMHDmJBs+sT9anjs+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuiINr0s; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso2874041a12.3;
        Tue, 08 Oct 2024 18:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728438223; x=1729043023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD/GVxv843cpdnkuSplLtT57kw+GZ4JQGD9p0vihxic=;
        b=GuiINr0svMDQ8WyTlWrjPLYJPIsexn204Oa+T4O6z7D8PdwkvckdXwI+Isvel6IPPo
         WrhMiZ/4bunGEe9wx4oPo0VJit1IKdbtqCKdHIqpfmiOfwUxAnqKVATfRdTDKwI0A75s
         GiN6w7f5+le6KaF1dBOBzqpwRwrlY7yWxjeiaMh1fqf2qrGwcZfBIgaVZNHQMpTttG4F
         Ucc11yanGZaVfTvPZ4WtAVDb2iAAXFRU1WJG9jporLSFkSMNgVBgnm5PYWsnz5FvQr5p
         yjgMbIHrQ2A/Q0npkvVThiHNCkOGlDhw8Fyldakzn9eC92ldnbIGjNStKyUAVnIHdV28
         Dr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728438223; x=1729043023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rD/GVxv843cpdnkuSplLtT57kw+GZ4JQGD9p0vihxic=;
        b=roOT8yvyfBo89qiCJrGEgm6AkEqebLli7IJaErh52gMrvGMZ7CozDxiZc13RFmAocw
         ySPy8anesetiEvg5I3F//cvU4S+vc0r52PFQxwEGiKz97Wis6ud5GdXNWRykjOrgcwlI
         sWgqbmuWhexennZFSUXvXRqrh1lWCD43Wrs2rnAsAr4CU3DZifi2+aRdC5jYasGJllSR
         kgBSSN/otSYF0gmLFTPWZIKTAWknLqkNKH1oaocuW+CJbjNct/vjzQ6ayrqQY4Sa7zzH
         rzDhgwVVUdiryDqreB+ySxu4fhgz80/i3LSHmp/N+Z0iKPMZ2lzRqP99wI+H5xJ0731y
         ZNpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBIWucTJ9WzhgYRiYTQjfNvWVBQALRABCqHsNb5pe80XyfOIUYZd3W/nwKnAv1Lz9eXVc=@vger.kernel.org, AJvYcCXVZDsZSOASqkP86QJOSoH6rpwnwZXLjDrYdvtTacOSZw61hy9f7XDhcSyjcQVoZRqKxq5ogPy6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94XVLE4vNh24wSGn//fgJdJsDrElIfpY0bXJBuRg3D2OqRNmx
	PoUONjSDINdWn5cxP7yTWmURrcrvPdc22ly0uvHPJDmFkoQj4ZV1rmlPSVqnethsvNC+xgMV/HT
	lXbeOFgsCam0OlYLba4g0UMzD6bs=
X-Google-Smtp-Source: AGHT+IHOVHEIlwlcKlo1HUgn0AAP+GGVUfM4o2393/yRWPccavu+9mMY+kpVuYeHrwGXc89ru3Oki7CzxIutD06KEuM=
X-Received: by 2002:a05:6402:43cb:b0:5c8:bb09:a9b3 with SMTP id
 4fb4d7f45d1cf-5c91d58bf20mr644081a12.10.1728438223279; Tue, 08 Oct 2024
 18:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-1-dfefd9aa4318@redhat.com>
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-1-dfefd9aa4318@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 9 Oct 2024 03:43:06 +0200
Message-ID: <CAP01T74KCbk_ff6+3d_yHxwZr7JF4UbGpYC5m4_oyME6FaXR+w@mail.gmail.com>
Subject: Re: [PATCH bpf 1/4] bpf: fix kfunc btf caching for modules
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 12:35, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com> wrote:
>
> The verifier contains a cache for looking up module BTF objects when
> calling kfuncs defined in modules. This cache uses a 'struct
> bpf_kfunc_btf_tab', which contains a sorted list of BTF objects that
> were already seen in the current verifier run, and the BTF objects are
> looked up by the offset stored in the relocated call instruction using
> bsearch().
>
> The first time a given offset is seen, the module BTF is loaded from the
> file descriptor passed in by libbpf, and stored into the cache. However,
> there's a bug in the code storing the new entry: it stores a pointer to
> the new cache entry, then calls sort() to keep the cache sorted for the
> next lookup using bsearch(), and then returns the entry that was just
> stored through the stored pointer. However, because sort() modifies the
> list of entries in place *by value*, the stored pointer may no longer
> point to the right entry, in which case the wrong BTF object will be
> returned.
>
> The end result of this is an intermittent bug where, if a BPF program
> calls two functions with the same signature in two different modules,
> the function from the wrong module may sometimes end up being called.
> Whether this happens depends on the order of the calls in the BPF
> program (as that affects whether sort() reorders the array of BTF
> objects), making it especially hard to track down. Simon, credited as
> reporter below, spent significant effort analysing and creating a
> reproducer for this issue. The reproducer is added as a selftest in a
> subsequent patch.
>
> The fix is straight forward: simply don't use the stored pointer after
> calling sort(). Since we already have an on-stack pointer to the BTF
> object itself at the point where the function return, just use that, and
> populate it from the cache entry in the branch where the lookup
> succeeds.
>
> Fixes: 2357672c54c3 ("bpf: Introduce BPF support for kernel module functi=
on calls")
> Reported-by: Simon Sundberg <simon.sundberg@kau.se>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

