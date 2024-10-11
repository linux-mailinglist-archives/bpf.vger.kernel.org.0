Return-Path: <bpf+bounces-41778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822A99AB25
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 20:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C42284717
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866271CC176;
	Fri, 11 Oct 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkS8jftk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758861C9DF9;
	Fri, 11 Oct 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672281; cv=none; b=IU9hNwgfg+dDGPk7v1LuAP5TTGa/sT/tY0f2s80QAUu0ciTQI9/e2unxI8ydh35q1qy5i9nI4k9togjh/a5mKlgmMJg0S+xccTZpd1jXzqBfTbFY/pIgFRbMmho8/ePlzJLjz0SJIwN/Gm4NFjLNX+fFO8yfvnFDCSowiOX/eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672281; c=relaxed/simple;
	bh=JO4M6B2qz+mLQy7Cz+8VNgoM3pzR7U32V8vAQrajyVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imnHxkOQ+LmaLfKSZN6BsbsDvUWPfCEZdS85dFdQDWMoLCBAY8MHZKwkeu8IYeJ1ZxvbiTsMdA5pgqdXkV1OrMlb46QyTGA4qYyeWPWGQbshPx78zMoKAmVVsx3/vR8W8RTWzN2btxrFhAN1OG/yeF12AaBOZzAuJMThO4/6lUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkS8jftk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4311ac1994dso14229675e9.1;
        Fri, 11 Oct 2024 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672278; x=1729277078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJlY7D92eFxnBPuC/RCxAbsE1oWiZkxuTjE/D/iB8UE=;
        b=GkS8jftkGB++uZpVYJluL+ItROyM0PKX577UXXKC0wEWuaCh3pxCqA/IvXuT9gAvFI
         H7gLnzcB5FtH9wE/uuQTtPgkArPgDBJh38osCWcwMyJZ6LUhzWyj6Q2nGdZhznEEPfue
         hOCce1aX4ud1EhFglfJXgbwC7DsloOICm56kDAzmn9PQnQN4WHwxxga6gHapbfts+fBB
         0hST34QXBb3LRWzU58Y5EvzMMhOXObs8w9VCEZZAgVmyLug/SBwj6qcn00MctG0MYhe8
         SUHLhf/jV4LZOJuDZnTNg831gPuJqGzA08r7uJQIqrRqxA993xWmBmZCZPzkfQygY7Zx
         fCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672278; x=1729277078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJlY7D92eFxnBPuC/RCxAbsE1oWiZkxuTjE/D/iB8UE=;
        b=q6zbPW65Jxq8WjAECDYE6IxjVjlz3hwWWPQn2xdcEBAio/qtBvnzTGpwixtqzCVyyn
         pjPe+9eKlniGmjZFKMcZIa9SBy6Eddt+avut01biH7uoadg4sVDghv2g38ShdmmDbWeN
         LpOlS+QOQbwlwh9VnF6LsjhopOOWs7O+VX8QqwvEbLuIYNH/9mA9XtJTVNsQoBTOJig4
         I5NQnSVo+TqI+2FHEh8TMX6joblx41sItyDSuIlQ5bHRp+sqtceGsKCRk0Z/BQpqkHlA
         Ag1tBbbUrzYwhF0e0M4gmyoKp9TYwve5Z4n+V+qBc5UABv7H9892TqR2FvbKp5c6nXGl
         izoA==
X-Forwarded-Encrypted: i=1; AJvYcCUhb68Z5pFJKy6Gz+zeu9BzLEEP0OmspiK3VtdmmGXHFEuys7wfo6/30EZNftq+7Jg/XjArTFhHX8BJB4ZZ@vger.kernel.org, AJvYcCUxophPEj/MzaTmPBg1p1mwdBDB+OiwwG3e54j5iwQ9lGZ0U8fGzsoBmy+WC0VObeVCEXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHwZdKAAtdVDk1RuTrGuwPsEcd+f366JYNdQyvG2La1NuYN6+
	PgI9MDN51enGS168BxHzcr0eYUTmxHOjnYGH/xIi+PY1zZ/7xPfQGYJInHvbBJsmg5vSyXx/I42
	O1CIiBVniaB8mLcNIq1jEX+FoXXA=
X-Google-Smtp-Source: AGHT+IGer4tE3JXRYv/on6k/oAZwb6JtDpGBNPusLk2fluWmZ6+pw9WT94O2CzWTHs/krdveHa0QLGRLrJhVXgdYlzc=
X-Received: by 2002:adf:f64f:0:b0:37d:49cc:cadc with SMTP id
 ffacd0b85a97d-37d551fc4e0mr2275480f8f.32.1728672277493; Fri, 11 Oct 2024
 11:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010232505.1339892-1-namhyung@kernel.org> <20241010232505.1339892-2-namhyung@kernel.org>
In-Reply-To: <20241010232505.1339892-2-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 11:44:26 -0700
Message-ID: <CAADnVQKpYDDsF+qjKRTxgF=UDqajGMi8BVeFD3UfUxS=_FMP0g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> +struct bpf_iter__kmem_cache {
> +       __bpf_md_ptr(struct bpf_iter_meta *, meta);
> +       __bpf_md_ptr(struct kmem_cache *, s);
> +};

Just noticed this.
Not your fault. You're copy pasting from bpf_iter__*.
It looks like tech debt.

Andrii, Song,

do you remember why all iters are using this?
__bpf_md_ptr() wrap was necessary in uapi/bpf.h,
but this is kernel iters that go into vmlinux.h
It should be fine to remove them all and
progs wouldn't need to do the ugly dance of:

#define bpf_iter__ksym bpf_iter__ksym___not_used
#include "vmlinux.h"
#undef bpf_iter__ksym

