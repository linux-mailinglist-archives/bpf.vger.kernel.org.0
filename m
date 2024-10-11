Return-Path: <bpf+bounces-41790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3546299AD00
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE58528B5DC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0A1D0E2F;
	Fri, 11 Oct 2024 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAHYBUHA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13D1D0E0C;
	Fri, 11 Oct 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675838; cv=none; b=e0K1LWmb/WLqtWonPLvl0tmocUIgjuE9YllqhJKuqmwpF8KbhOKFaq34YZlEXryBRr7y2JNTyY4bXcis4ch39VeheuSx2+aipT2d2DmvqUNGXSOktqXnupl/tj/+LR6MvMd/bLK0p8vaWq2W9Y25bAVYZX/l25AiTvzboknrP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675838; c=relaxed/simple;
	bh=QiBJpCUmHpZH8zioDdiC8bJODL+fF1cykQze124oEoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFD7bJdpE3FZ5d2p30TfRB4duH1VWShPHw831TZu2D0HOPYBrqqRyWPWetwqVFOeUyiDqOPsbnva4J9LKWxA7oP6VkpXVr11l5WSsTM5vwv1Ne6CT1Qf8/aFUpR3+CY0k6/J7xhDnj7gR7rVctM0XMK0tN3ZLI7QwMH26c9dO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAHYBUHA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1148230a91.3;
        Fri, 11 Oct 2024 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675836; x=1729280636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTT+DOTqu8ZpwPwDJCQEdCoOuIhh/yskraPW4+c1ErE=;
        b=QAHYBUHAa4SX46AaHua5FRWPWF+YgiA4flbTZ+uX94kYgEu2g1Yd/DrUaw0izFPogM
         0X4C+7eSPduqQSD0pWiQ8Qi9Xp4gS0yDu21/87cPQqMi+4DZaN/vzQ6EL9yaUvDr9NC7
         oBSqvHic0v12rJSXyg+CgKyhIAugiFa837njsTLDQpdejP+FIQ+BurVaY+Ew2FYbT7yk
         fB50hYegvzka54BCSccMnVpLse7O/8aRBfOm9OOKKU0Wb4Fjk8NasqCCwWA1x2KCakIy
         TuWz/OX/0nxkCHlg8bcVUtmPcDw2vsJkhbPsbVaBeHA6P/60sK7k3gn9QDSsKrBmRCKX
         QEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675836; x=1729280636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTT+DOTqu8ZpwPwDJCQEdCoOuIhh/yskraPW4+c1ErE=;
        b=e1qFB72Po/vbpAQH+Y+Hwg6Ji6AAItamYkiWu9d1o5zn1IlxF92HEapIjSZioGA4WM
         mtcLIGLKm+pUV0k4ovh/uV6v/aRMoj1bezsltYw7lkgKu05Tv/2STpNrC2IyMwOGGh2N
         bS5pdFNgWCTvDAINnIp4uROCUV8ZLF+zHgapWcKcdiF/WPgtKP+mlMG+75HXvkIFirQW
         pt/ER4p7JuA/jrpkVFFB4kI74L6ooITMVUr6YMW5LKDy+bvHsNqagwE7ZZ06AGH9RJR1
         T6LKsTithwb7q9C2Stb5yHbIB4k7XiCxu2SRqLtkoxAMVncCYie9xx2+IHU0M4HUzg6B
         aexw==
X-Forwarded-Encrypted: i=1; AJvYcCXEQq45dqYslDSNdkL2O9Zs7lmHXBvFK8HXBp3GfuDHUTf7EgCFz9KC7giq+IsrhI/GhwU=@vger.kernel.org, AJvYcCXb+tOnsAnBwkUovaJMPY4Jvmb/RwI+rM34rI0XsA6QYSoP/Bjt+V2EQnbWVD2E6JJmFhGdqK6bW8dt9lje@vger.kernel.org
X-Gm-Message-State: AOJu0YzmODDFI5XfMvSyT2n9c9INjTjpQBj6vJ2+7EUIOyoDkAICWhyd
	1NyMW9dcNxA1uIYiqmbcvbmYsUGkyfixIWxM4fv13TnAuzuWU0710Qles2tVZ999oaUBoAVnC4T
	CIItWi1L9p1ErsPWOT5nHMHy6BeI=
X-Google-Smtp-Source: AGHT+IEEv+MYggNLv4dgRwOMMk7eOu9TZVK3vVYd3IVx0iPOkfChiKEqALrlX93LSx/Z1Lma33setQhb2squsITEcnE=
X-Received: by 2002:a17:90a:2f21:b0:2e2:8299:2701 with SMTP id
 98e67ed59e1d1-2e3152eb849mr719284a91.20.1728675835960; Fri, 11 Oct 2024
 12:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010232505.1339892-1-namhyung@kernel.org> <20241010232505.1339892-2-namhyung@kernel.org>
 <CAADnVQKpYDDsF+qjKRTxgF=UDqajGMi8BVeFD3UfUxS=_FMP0g@mail.gmail.com> <CAEf4Bza__VNwyqNdyy-aKS_eiPRThMv2SZaYRvnwr5DXzgqG3g@mail.gmail.com>
In-Reply-To: <CAEf4Bza__VNwyqNdyy-aKS_eiPRThMv2SZaYRvnwr5DXzgqG3g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Oct 2024 12:43:44 -0700
Message-ID: <CAEf4Bzarmpop6o9WwjKQpkUdUH=UWY9e+xBe4cg040pdpwz9AA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add kmem_cache iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

On Fri, Oct 11, 2024 at 12:41=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 11, 2024 at 11:44=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > +struct bpf_iter__kmem_cache {
> > > +       __bpf_md_ptr(struct bpf_iter_meta *, meta);
> > > +       __bpf_md_ptr(struct kmem_cache *, s);
> > > +};

BTW, do we want/need to define an open-coded iterator version of this,
so that this iteration can be done from other BPF programs? Seems like
it has to be a sleepable BPF program, but that's probably fine?

> >
> > Just noticed this.
> > Not your fault. You're copy pasting from bpf_iter__*.
> > It looks like tech debt.
> >
> > Andrii, Song,
> >
> > do you remember why all iters are using this?
>
> I don't *know*, but I suspect we are doing this because of 32-bit host
> architecture. BPF-side is always 64-bit, so to make memory layout
> inside the kernel and in BPF programs compatible we have to do this
> for pointers, no?
>
> > __bpf_md_ptr() wrap was necessary in uapi/bpf.h,
> > but this is kernel iters that go into vmlinux.h
> > It should be fine to remove them all and
> > progs wouldn't need to do the ugly dance of:
> >
> > #define bpf_iter__ksym bpf_iter__ksym___not_used
> > #include "vmlinux.h"
> > #undef bpf_iter__ksym
>
> I don't think __bpf_md_ptr is why we are doing this ___not_used dance.
> At some point we probably didn't want to rely on having the very
> latest vmlinux.h available in BPF selftests, so we chose to define
> local versions of all relevant context types.
>
> I think we can drop all that ___not_used dance regardless (and remove
> local definitions in progs/bpf_iter.h).

