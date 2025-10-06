Return-Path: <bpf+bounces-70425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F38BBE9C8
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D33B3CB7
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76661E25F2;
	Mon,  6 Oct 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlucJtyl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBE1C84C0
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767512; cv=none; b=py3a/+Dv7nGLsJT0+NpuV+du02zekzdbL1MA2mYFeZWg67kX+AB4HM4pBqMMvFl62KdLWLXK0t2hwoLOHTAtQkMem7XsR8W814lzx48kQOYFWjONboEPEQhqD8Mdl5qaCTHI0F6UGJZkbNe/d3dUwqfM2YMCzkidiUmKqHsM0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767512; c=relaxed/simple;
	bh=5gU79nX4+Lun1+8Ne3WQAvVRChUXeq3K+NnQ8H2ZKlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzSAGAfSug7SD9T2OBhAVGo3Y5DlZ+ct8WhIGYu95h6fw5EZ/YxiLGR0geGFyT9AKkU/IgfkksktLenJcmoeWeA4ZsLMYRuq5kkGiAYImbrL8ixTgisBaOEanAf79Wx57w5r/ngYQhE/G2gpbmM8wspAOIQtNgcL/cLCvcc9Uc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlucJtyl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so5866741a91.1
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759767510; x=1760372310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK0JX0tpmRwNhnDI4G8ZsfJprGNIgX+JRfyqnBEJOFE=;
        b=JlucJtylGpVhxp3VWA3oTzLT9+LyH7l8TJ1gJ9R3jDNkmVIjgCXwtD4rED/prLRoeJ
         sBi77k24jexABzGJSHP9BA+l5cChNbpX7783H+nJxQA4L8yaisrXd059Z+zhZ+3VMvf0
         wMzAex65144p1e83Nst/Ntnd8xK0pSf8zf1Sm8Z72xmUHfcwAtaF845h2XpI8w//tbZC
         OUuwYEvgljWzI7NVpT0LUVxSUCGFDTBWdaw0qkaYwETfATdMSwYGx/LDufqFVz4K5y5A
         JJacDLuc+BMkkYc8e/bIvhFkt82VvvO/8CJUbH3loaeJZOI+okkEjlNhYaiFZ4UDWEct
         wixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767510; x=1760372310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK0JX0tpmRwNhnDI4G8ZsfJprGNIgX+JRfyqnBEJOFE=;
        b=oKAEhHhuA85bE+hx5lv8/mdL+2lahGx+zDP6HrziQuKKPa2qLjXQr/Ma+XuFVQHvs3
         G9htd2f7sxB0W2e17Nk3/+sHKQP2X5m2STOuJv6g6h+dES5NaldqWuchDhIKMx6/aXpB
         e7s/IJx48c5W8dbi9QNxAM29EgE0QBqUBSNlyy7vHt7hRAlLJYfCxEb3Fx1kzK10+IVD
         FRLLC8dnOeKbu0NUOWe7cxWpURM9vppCQ3dYNjWi7m+kjPnXPOEnG+MaQho4/LD5aKVf
         qEoB8Ijr++wYgqMGN2iyd/6rWl/XD/aE4IEBLzco6ABSM1jQ8j9ZTRY/IiY9hvwoXWsp
         e7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWcRFZP1qUEPT9oPGCTZcvpAju5DddYWcZW1+YQUsDRpTwY9AUwJvENgnDiqrqcjAgbcTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAww6fDwD+wmtLpyyJbl+WtJNDGPgpRbQ7dFM8N1ZAFqo2dSnn
	gaXk5gSpH3TTPzo9b0PzrgGrytNGrnJyzPbZk6T+8iAFbuzd3LQNGTwFK6jKXd5vp/hu3Lin7u3
	wF9JAbH1+fQdXuZPgLveS82BKHosn6TQ=
X-Gm-Gg: ASbGncshgn7iq22EIe44udNmiopyWWEi5L0NR9ifiuB0wXnCys+s3VzxpkVWyCJ6yLy
	NbK4Iw7bqdGme0SSM8aBK2stEGN4XKW0OZ8Bk4Pg5WJX5jcIgZOs1LOog4kANuNjDVARAas9N68
	84pVY4wvvscjK6CqEhaIIDzS1oOoO9SKpIzMMERGuC76QdxGCrhoBAs+c6qVft3X6JcG8IB0AqX
	4oG5+9znLOO5D+K5ai9zFVRpb2YiRBa/WTH8uPxtlTFRxc=
X-Google-Smtp-Source: AGHT+IFhHXUnWkfG2Sw4m4CM8K3NzI0XTNMeQRD92ssVP+PqRLHhpaRDEsaUvrJXRro+7//yTmoT1KUBrlAA6g1s+O8=
X-Received: by 2002:a17:90b:1d82:b0:332:50e7:9d00 with SMTP id
 98e67ed59e1d1-339c27206a9mr15435433a91.11.1759767510113; Mon, 06 Oct 2025
 09:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006012037.159295-1-ebiggers@kernel.org> <fc03414f-7b9d-4222-a66f-67be4ea32fb7@linux.dev>
In-Reply-To: <fc03414f-7b9d-4222-a66f-67be4ea32fb7@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 09:18:17 -0700
X-Gm-Features: AS18NWAPO7LcjKUij0m0fbKg9Dw3CWnqOzf6WwsTGszh-97Ui_xo0xuOessNeoU
Message-ID: <CAEf4BzY6sOkPsT0hDdvbdPibMejN03kd3S3rkge1wqNJrDD7Hw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix undefined behavior in {get,put}_unaligned_be32()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tony Ambardar <tony.ambardar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:13=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 10/5/25 6:20 PM, Eric Biggers wrote:
> > These violate aliasing rules and may be miscompiled unless
> > -fno-strict-aliasing is used.  Replace them with the standard memcpy()
> > solution.  Note that compilers know how to optimize this properly.
>
> For clang, -fstrict-aliasing is on by default. For gcc, -fstrict-aliasing
> is on by default for >=3D O2. So indeed, with macro based implementation =
below,
> it is *possible* that the compiler may explore strict-aliasing rule and m=
ay
> generate incorrect code.
>
> >
> > Fixes: 4a1c9e544b8d ("libbpf: remove linux/unaligned.h dependency for l=
ibbpf_sha256()")
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>
> Ack with a nit below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>

we raced a bit, I just applied this patch a few minutes before your
ack. I added your ack and force-pushed

> > ---
> >   tools/lib/bpf/libbpf_utils.c | 24 ++++++++++++++----------
> >   1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.=
c
> > index 5d66bc6ff0982..ac3beae54cf67 100644
> > --- a/tools/lib/bpf/libbpf_utils.c
> > +++ b/tools/lib/bpf/libbpf_utils.c
> > @@ -146,20 +146,24 @@ const char *libbpf_errstr(int err)
> >               snprintf(buf, sizeof(buf), "%d", err);
> >               return buf;
> >       }
> >   }
> >
> > -#pragma GCC diagnostic push
> > -#pragma GCC diagnostic ignored "-Wpacked"
> > -#pragma GCC diagnostic ignored "-Wattributes"
> > -struct __packed_u32 { __u32 __val; } __attribute__((packed));
> > -#pragma GCC diagnostic pop
> > -
> > -#define get_unaligned_be32(p) be32_to_cpu((((struct __packed_u32 *)(p)=
)->__val))
> > -#define put_unaligned_be32(v, p) do {                                 =
                       \
> > -     ((struct __packed_u32 *)(p))->__val =3D cpu_to_be32(v);          =
                 \
> > -} while (0)
> > +static inline __u32 get_unaligned_be32(const void *p)
> > +{
> > +     __be32 val;
>
> To be consistent with put_unaligned_be32(), rename the above 'val'
> to 'be_val'?

I left this as is, it's fine, IMO.

>
> > +
> > +     memcpy(&val, p, sizeof(val));
> > +     return be32_to_cpu(val);
> > +}
> > +
> > +static inline void put_unaligned_be32(__u32 val, void *p)
> > +{
> > +     __be32 be_val =3D cpu_to_be32(val);
> > +
> > +     memcpy(p, &be_val, sizeof(be_val));
> > +}
> >
> >   #define SHA256_BLOCK_LENGTH 64
> >   #define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
> >   #define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
> >   #define Sigma_0(x) (ror32((x), 2) ^ ror32((x), 13) ^ ror32((x), 22))
> >
> > base-commit: de7342228b7343774d6a9981c2ddbfb5e201044b
>
>

