Return-Path: <bpf+bounces-21472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA6A84D804
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 03:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2311C22D6E
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815D71D524;
	Thu,  8 Feb 2024 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcGvAIYG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EAA1CD3E
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361159; cv=none; b=AQVkNtp07XdVxDyAWUM4lAJwq3wMhvX45TSM/15vgAKsoM9UyBhpLOUWCz2TrDuLme+CfgoBoUd5VHkMBXQjPEB3xzXZgE+SQxd7NTW8J/iMiZHOH2M/t3zDOUOSpFoqETbOETWYgfch7jafk0Kcmf+7HHRMtKMPBl1oGG9Ds7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361159; c=relaxed/simple;
	bh=JG5xre6ZZMxUXLPUfRl4pGYTWmNZ1NmKzAPHQKhSBos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALk2SURPEqErPl94dvNl4UaHAqE7nWb7IynkzvtvNdPQFzDiQafUxJ6EY+1WLOIW5RjHVcU+Qw5y2lUtWf/5CIEa2cIgY+4A8Gb/t4LXxaZqpaXlEtZ4kLMePkfI0CXwwYTNSpcQ+V68s2XGv4xr4CfZupwxGLDqnVAjGz4acDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcGvAIYG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4101d4c5772so2462835e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 18:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707361155; x=1707965955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3PiS1b99aSmkX7dYRgJE89NBaUaPOmZB+2Ux50Yp14=;
        b=LcGvAIYGKDv3eik2lP3cMdJ5InQcxyNfJ/ajmoB33QhY6yX80P69FRYhZdBwmFaNol
         i/BEah0jkBt5klkYrTTduuaxhyrRs7UunmQHjoqiXpbYHPiq9372SpEDyGnymh4htOXH
         yEzMIntTpiAp+DrJZbc3E9cRTsplUNdAZlH4kWvvssIQ7e9R93ltA4icOD3IbmCsXGJN
         Fl58Yp5x4SDbtChFkU//WInD+VrC0O9W2crXnG938O3YalvqeWMAAd6GXc4kHjrixlCx
         slINq5lajp7fBnBt2XgqcSYvorI42TxuFKnmsN/yEchTjdnUY8W7KZ5RRcy3Us8jpq50
         L/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707361156; x=1707965956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3PiS1b99aSmkX7dYRgJE89NBaUaPOmZB+2Ux50Yp14=;
        b=NvcT2cFUxy6KGyKYYTt9rW+9UKCI11Xo84XFtEd9BaFMPLPdbohhtqiEboh7Krc1GB
         pJEsqkT4y+e4VDpYlcWUl3C7A6Du8pSnPPabMD8jyY0a5S9wkazEIejdYUf7VLrERKQ/
         8DeoBGeeKo+tQyOB/s9TPq/SZQwxT7WLO8QOlqW2CGEQXPlBUIDyxpMqoaAsD6H/Ezet
         /bc1sm6U96yFHYovQwq1LeKqqaUwVWXzt0OhSmNoNwvJtTjgOeSdxekh6nR6NoK+QGjn
         IPa6l7AcSuI1NJ7Bv/COc8J3YkwG9aAoZ+s+NvnKs2AWKalmna2IMQW07iRHbCgAL1Rb
         JTow==
X-Gm-Message-State: AOJu0YzeY2Ij08tQIm+D4ceAhKVLz4NnFonR/+/VHg+o5vy4r37AuNSC
	QZOfrjKt+zN1aJ2Y8wtwnmKIH3PH+2FIM9HiWGgaD5WgfedqLEn6ef1vtgB2HQZDZq4tcBhbgPk
	M50vIAGTEhpEnaPl5QpdPOJ9M83s=
X-Google-Smtp-Source: AGHT+IGKxAZPXhM0mf+tQ51rZWA3KExGsBCXl8HVYbDDkZgMnpJ5Y6sEX5AiMNJHIZmYB4UMRerZtXlp/VQHhVkXr30=
X-Received: by 2002:a05:600c:4fd3:b0:40f:d145:63cb with SMTP id
 o19-20020a05600c4fd300b0040fd14563cbmr798966wmq.9.1707361155500; Wed, 07 Feb
 2024 18:59:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-16-alexei.starovoitov@gmail.com> <3115274419b6bf0a27facdc0b41094842fc61c84.camel@gmail.com>
In-Reply-To: <3115274419b6bf0a27facdc0b41094842fc61c84.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 18:59:04 -0800
Message-ID: <CAADnVQJEhr6WLEC=faVCO4cE0Ke-yog0zH6PGmXK9sKhdidhhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 15/16] selftests/bpf: Add bpf_arena_list test.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-02-06 at 14:04 -0800, Alexei Starovoitov wrote:
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testi=
ng/selftests/bpf/bpf_arena_list.h
> > new file mode 100644
> > index 000000000000..9f34142b0f65
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/bpf_arena_list.h
>
> [...]
>
> > +#ifndef __BPF__
> > +static inline void *bpf_iter_num_new(struct bpf_iter_num *, int, int) =
{      return NULL; }
> > +static inline void bpf_iter_num_destroy(struct bpf_iter_num *) {}
> > +static inline bool bpf_iter_num_next(struct bpf_iter_num *) { return t=
rue; }
> > +#endif
>
> Note: when compiling using current clang 'main' (make test_progs) this re=
ports the following errors:
>
> In file included from tools/testing/selftests/bpf/prog_tests/arena_list.c=
:9:
> ./bpf_arena_list.h:28:59: error: omitting the parameter name in a functio=
n
>                                  definition is a C23 extension [-Werror,-=
Wc23-extensions]
>    28 | static inline void *bpf_iter_num_new(struct bpf_iter_num *, int, =
int) { return NULL; }
>    ...
>
> So I had to give parameter names for the above functions.

Thanks. Fixed. Too bad gcc 12 didn't catch it.

