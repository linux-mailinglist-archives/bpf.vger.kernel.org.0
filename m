Return-Path: <bpf+bounces-20849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF428445F1
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F172936C9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917812DD8F;
	Wed, 31 Jan 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgdjG5P8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2F12DD88
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721620; cv=none; b=aWnaOwp/vZ0BfPGoKIuUdkAs78rFqFnQWHvae0VfTX4ZK7tMPSEPd0cCWDWt785ExRY16VMIoioEoMN1PcsKQQ6vbhASNWIUszna2JWerJP9ERG//O0PC2yGCGbk6JR8tozFI+ewZ7jnIM4URwMb0S30WpswxkAxlxWCVCEzxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721620; c=relaxed/simple;
	bh=0CFn8BuWrpJOLYKHyaPdWB7mQCHdNSB4rcIW5NbAo4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTtEMDVXy61mBF5LD4Yi/Jin0/yRmtjbZPrmw7SU14zqnKGNAAoxiWMApWdES8MQEJwkhP/cDf7Ek4ydzSxaLWAWU20cXziaMbqvjx96K7B+1bwmnu8aVY8jBPd9Dfsu8Q/oKjhKYiEdYz6dGWKXKEb4vuNqkcKwxdUF91MIr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgdjG5P8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so15172a12.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706721618; x=1707326418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVSVVcLMjn0NR2gfnomjJDyreqVcVAFjkPr1GV2cTCg=;
        b=OgdjG5P8x51ysd5M0ABIh1peBHA2zq1SQt00PaAJERfzjvPNCV5JU4CFRlxdcChkoT
         HcwPqylN+rNvJv/6mf2KP+kmO7IuDdXwzVa86xqUMzo3qu6Imz+48hhpTInQlUWrMZYO
         cgYipAKmsv1sl/mUFbd1Nia2UmnIjWuGi2B4VT1S70UzL4OBFPxwCM4EaYPf0oK2tg2a
         S9Ic52b1KY5Yb6PD73Gc+cn3h6yv7PcE99HZJDTpMXzhAaaR5MtrRpVVEkdAplR9z2KV
         W5Fjii31oGMWsCW7D+xWvxXsNC6cxSG/owe+7fDWxHMxgOpnjqTrLCrFaIgzePQ+wASW
         /hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721618; x=1707326418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVSVVcLMjn0NR2gfnomjJDyreqVcVAFjkPr1GV2cTCg=;
        b=WahJnSgTvRqVPFFttkBdKXKqPCGJzJLQCIyGRRuTw9yN5IQ1jxuRV6Lv8RvR8r8O3v
         5XT6o4zGbe+lBm2lvnizwthZH414UFHXmTENhJhn6+FHVxqvLqxib0SgqtGXpoPEPCT0
         qtLPQbJPYU9YSJfNxoDWgs6tiDEO+ILPJlmUHnapm/+NxuDBlyECrX6HGqj3TsYqAGO6
         cZAyNUOR99aOgNUZiRo6WFMMjDWV7712gUuPI4NplgZf2AYNbuwSDtzqX7OMZp5gH1LU
         OOatVhQsbOFc1Ors0M+/6AkgAh2/mz7ZU4rilp8vp8HEf4liLAa2RwWfUv6DBr2duGNr
         ExAw==
X-Gm-Message-State: AOJu0Yx0TBx+n0vCUcZp75L1+erI2fTUscGlri5fGhet9jUl600l4lg9
	NB7yMySoypIJWMt6cRA36tVk1OEZRKcd1lnlthO0r2VFl8Gb19UWJJdnBvm9xoPPQ3A8WyM/yDN
	bT9Mtz2p/LIics7Nd+zE6LuZDkJU=
X-Google-Smtp-Source: AGHT+IGLdUUlTK2VWsRhdw6hTcKMff9s8ZxCKzvY2UV4lcxR/hx0FjD/plR+f1OTImIhdUxSWDaxNm6fCAbdw4h1+ms=
X-Received: by 2002:a05:6a20:6a9f:b0:19a:4e56:d81b with SMTP id
 bi31-20020a056a206a9f00b0019a4e56d81bmr2038525pzb.27.1706721618599; Wed, 31
 Jan 2024 09:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130193649.3753476-1-andrii@kernel.org> <20240130193649.3753476-4-andrii@kernel.org>
 <3b4b98dd-64a6-4fbd-bc8f-45006cc0e089@linux.dev>
In-Reply-To: <3b4b98dd-64a6-4fbd-bc8f-45006cc0e089@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jan 2024 09:20:06 -0800
Message-ID: <CAEf4BzZbZOg=OYuSmNZEj1guMxg-Jvxn1k_OeZM6UtDk8w20OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf: add btf__new_split() API that was
 declared but not implemented
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 9:30=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> > Seems like original commit adding split BTF support intended to add
> > btf__new_split() API, and even declared it in libbpf.map, but never
> > added (trivial) implementation. Fix this.
> >
> > Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> The patch LGTM. We did some cross checking between libbpf.map
> and the implementation. What things are missing here to
> capture missed implementation or LIBBPF_API marking?

Yes, we still have it, and it does detect issues when API wasn't added
into libbpf.map.

I haven't investigated exactly why it didn't catch the issue when API
is in libbpf.map, but is not marked with LIBBPF_API, but I suspect
it's because existing check doesn't take into account visibility of
the symbol, so there is some room for improvement.

Similarly, not sure why it didn't detect that btf_ext__new_split()
wasn't even implemented, probably because we don't distinguish UNDEF
and FUNC symbols? So something to follow up on for sure.

>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > ---
> >   tools/lib/bpf/btf.c      | 5 +++++
> >   tools/lib/bpf/libbpf.map | 3 ++-
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 95db88b36cf3..845034d15420 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1079,6 +1079,11 @@ struct btf *btf__new(const void *data, __u32 siz=
e)
> >       return libbpf_ptr(btf_new(data, size, NULL));
> >   }
> >
> > +struct btf *btf__new_split(const void *data, __u32 size, struct btf *b=
ase_btf)
> > +{
> > +     return libbpf_ptr(btf_new(data, size, base_btf));
> > +}
> > +
> >   static struct btf *btf_parse_elf(const char *path, struct btf *base_b=
tf,
> >                                struct btf_ext **btf_ext)
> >   {
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index d9e1f57534fa..386964f572a8 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -245,7 +245,6 @@ LIBBPF_0.3.0 {
> >               btf__parse_raw_split;
> >               btf__parse_split;
> >               btf__new_empty_split;
> > -             btf__new_split;
> >               ring_buffer__epoll_fd;
> >   } LIBBPF_0.2.0;
> >
> > @@ -411,5 +410,7 @@ LIBBPF_1.3.0 {
> >   } LIBBPF_1.2.0;
> >
> >   LIBBPF_1.4.0 {
> > +     global:
> >               bpf_token_create;
> > +             btf__new_split;
> >   } LIBBPF_1.3.0;

