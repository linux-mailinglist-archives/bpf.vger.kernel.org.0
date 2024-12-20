Return-Path: <bpf+bounces-47489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C89F9D4C
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 00:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEBA1893C27
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18970228389;
	Fri, 20 Dec 2024 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niYJeKV0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEFA21E08B;
	Fri, 20 Dec 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738770; cv=none; b=iJZKTRt+1COup3hvrWinX23Ix5dQvCxWCLjba5Xgo8HX411JkV698NjA5SzJTqZDHK2z9hlWxQf6v+rqzUDvLL1aDdSatTuApcgBvfsaLTZuguzD/alpzqtt9MKK7uHNFuUD5pFUmipP0r+EVdkL49Bxqi1V0NvATsoKHdB6IkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738770; c=relaxed/simple;
	bh=cXfcHP5SW4yroZlKoj1Xm/uTFEqMwOi/nin0avz1lpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7seHZniEbTkbRZiSZH5z8S9ufRwbMqTk2Z9cCzr/nUJiZPVS9wpE6DL/bc1KYw7eCGQe5cdxzR4VKYKcxuXPW19ldni6qV4Aty6lsfmG9oH8hSc8jKaOaPIsHM4MoEk1VAV31otHpDH0wczqcgZheRj/pTvAasqokK57ylc9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niYJeKV0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1455762f8f.3;
        Fri, 20 Dec 2024 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734738767; x=1735343567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNbLrUpTmLaYe6WGl4NPiqJ5KZ+0Ux4naErLTW5UEGQ=;
        b=niYJeKV0LXKh2yZRUXmYQGGHoi9DuGUmmfK7h0PiLI8qstRTcGFG1taoFgFxaC9r4B
         /nTQyjGf8C6HwDgi3Ebf/iJD0L31WXadc7EiowLsc89tLorc+3mEwZWRZRQvooqlmadV
         O5niO9h3FzJMgu8K1i2/YLjkK09Qx5s/vuZbqhTxHqWjxxOyiyJVK3I4OhsMd1hBOKTE
         4EKRGFc8VrrTrP8eaJEvd6Gc+fAMEalH4gHwL64/ALDLw+eTKr2ZwaTG+1DfldF3QjNp
         HQoJq371RkaT0horpjUPF1AgFqlubuJbD5KOmv+s9GhA5VlVqioElPNKWrHHI8Kf+Vj5
         Im3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734738767; x=1735343567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNbLrUpTmLaYe6WGl4NPiqJ5KZ+0Ux4naErLTW5UEGQ=;
        b=greb1eGNHrEUzm1c3SJdprKJMp7vxtI/2+MPPx5jXvfH7KiXEey8HUouxtUPsL23aj
         TsgU+9h7SHoAFgYhZs6KMZkiNZksy4FhuS6xfOWfelJ1EWYRmAXAqQwNTZHMMDXwMxPc
         wOrKV5LyRW7LoDXYILRgFUOxaiDEA1LzTPphlu7se02QGFPuF1lqDs5go3BLZruJQ+nj
         q4KLD9ERAbW+6roJyx3btuIKJp/hrc8fviTheDZJdbfgQLr+Hv1xBNzvSsYirCo0WLCy
         jBH1IZQXLrUbph8jGZRECZX55KJuN4V1ex+pdH1+rFXV9c0q7FrRO5VW3LPjswj4eA6J
         xD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbSP2yCrxx78sfJyPJLMnuB3TJnRjpgLNpfZOnS3WUotJE35gYxhnVZFLNpoIU5QrNCm7vDJCclCKsa+8x@vger.kernel.org, AJvYcCWaNzEzyuq6Tb6e4EpuuXyyJxgsgML8yeWJpV8QV1cFZyqpu79SkyStXQ8UUIm9dhmou8RO9JbP5KbCj6uIKWhQGQ==@vger.kernel.org, AJvYcCXP+r75PPBWc4aXu0KRAjW27HfeuV02ctTBdNUaenbNNOecbjhXnFJsNTTZgtWDYIEVvSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsW4QA7nWuR7FZOIZ7lCa2gbbntpUs1YIK7ZjbrluiJ2z3EeA
	45xyOVhC068SOxEhV3iuqs6VlUJ2CPFVc1jcss/M8NHHIaoYmYnu3x1CjV98Z6391dPC4CPV9oG
	dS9LRsO1F8TiKqxNSnEwlUoXDVB4=
X-Gm-Gg: ASbGnctS6rHvPzq+SjhxjgK7Tmxc2cVgOcaIAL2yphHF8nS1vqmHBtE0MXNi6ulT6pZ
	46YdHIr6iyhfDB/HutV30v6cwtO/Xik+GjvWVpg==
X-Google-Smtp-Source: AGHT+IHtK+jwCyCmdnWbscFnkJU/WJOqcL2I6L8jnkBsSdpFlrD8UvO757XWICdMk5LLHh6fpgONs2/8H53VbLxDAVo=
X-Received: by 2002:a05:6000:4a03:b0:386:3d16:9609 with SMTP id
 ffacd0b85a97d-38a221fa9f2mr4381091f8f.17.1734738767185; Fri, 20 Dec 2024
 15:52:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220060009.507297-1-namhyung@kernel.org> <20241220060009.507297-3-namhyung@kernel.org>
In-Reply-To: <20241220060009.507297-3-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Dec 2024 15:52:36 -0800
Message-ID: <CAADnVQLm-jA5-39-LUKybO2oGbDRr2RgPtJH5iXoeKnYqdJUuw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] perf lock contention: Run BPF slab cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Kees Cook <kees@kernel.org>, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> +struct bpf_iter__kmem_cache___new {
> +       struct kmem_cache *s;
> +} __attribute__((preserve_access_index));
> +
> +SEC("iter/kmem_cache")
> +int slab_cache_iter(void *ctx)
> +{
> +       struct kmem_cache *s =3D NULL;
> +       struct slab_cache_data d;
> +       const char *nameptr;
> +
> +       if (bpf_core_type_exists(struct bpf_iter__kmem_cache)) {
> +               struct bpf_iter__kmem_cache___new *iter =3D ctx;
> +
> +               s =3D BPF_CORE_READ(iter, s);
> +       }
> +
> +       if (s =3D=3D NULL)
> +               return 0;
> +
> +       nameptr =3D BPF_CORE_READ(s, name);

since the feature depends on the latest kernel please use
direct access. There is no need to use BPF_CORE_READ() to
be compatible with old kernels.
Just iter->s and s->name will work and will be much faster.
Underneath these loads will be marked with PROBE_MEM flag and
will be equivalent to probe_read_kernel calls, but faster
since the whole thing will be inlined by JITs.

