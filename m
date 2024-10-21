Return-Path: <bpf+bounces-42709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E067C9A9438
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989D1282A85
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1004F1FF7AF;
	Mon, 21 Oct 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A586tFlu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D261E6325;
	Mon, 21 Oct 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553544; cv=none; b=CQF2v7zguRICOiRcyALf0+aY76+0oBtflV8Y1490ldfogvmzbyUEnbxKXfVgC5XDn5mfTTcsfUTEZAe7JxzJ4MYDModU4AKJ2ocPqkTIUzCVUpu5kbwdFITJHEsAmAlDk7Nq5sjuN4Vdo4yL0R8Egyt54yEiTJUUfULQCSwm3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553544; c=relaxed/simple;
	bh=dQusqVS2m/sejoi0x8nt4cAjCs5p6H4uT0xFpndeWuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heMEVBz6db58G/kKhgKbOUDkCF80lv0fbCYjbHJN2sXo4OFcr7tXnziHjjSoOmcI/ck0WON9icE8jCkXjQg+x3uqnAVakQaqYJCTWHWte1i02d18AF8TgX0uXzE9d/1PFu4iE+ZfiejzqeBPi3SySwyemWg+CXhFpHRZg0wK6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A586tFlu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so4097210a12.1;
        Mon, 21 Oct 2024 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729553542; x=1730158342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apwv868bKjMTXfXoFh01HYLst30ORGniee4XhriVDbU=;
        b=A586tFluXb5ma4Gd32P0bDAq5j8hnEcLzLBJQNOZw/x3JAXAaI2yf7ncdxNtcu3dMr
         0+PXPCQQfHe+UJFPNNds+yjqw6ydazzugICrLk5LfKCIKjDJBEM7J30xFA031X+1uGRW
         7gkN/YOWoKs729V0f0O7oMhzLu8FFtnwolL1AFXELmG8f5WoNsxvrcwVUGhq/xCr0juG
         O8XrmOumudZdUVDM2Akame6cCCPUS1UlsaHrmyhxUvRwGNZAnHq67e9FioYvUgEQpVS6
         dRmXtFVwQZfg8sd3HhIOogAwtDliZdzYA5QFdzPR3iSAY1tUDlGkefvZxd8tR145el9N
         5Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553542; x=1730158342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apwv868bKjMTXfXoFh01HYLst30ORGniee4XhriVDbU=;
        b=QEsP+xc0qBv1hiDP1rXJeppZNDBA0pyudiC7It0UmIzuvHzs4Xpxo8pNqfBaeHpC3y
         GYExMqM/rYnOB9DL+I4FT+53FRvox0NFlJdbyUJ6xR8u3bNnoOMtJmLyQwSjpPZrrTPO
         4fJ2h7eEw43j+hCJS+qd6GR6lwvnILGRuAw7cZOpXF8uGSdD3paFEgWRDqn7TEtDDkd2
         qUyg8AX/ktZv9mPbZomEvflTN8aZtQRT1AJK1dqYlwY6DzjPTDCsXV6MOw+N7lX3rnQR
         D/ZTMKPhALvwezTKswG0lxlmEcwGw1QFCjhCPzmnFuatESAgLcZsxZKMwez7EagnKt+Z
         BNZg==
X-Forwarded-Encrypted: i=1; AJvYcCU89PIU4jALZ3/e5EyCCdT4iqNjFDueDh3Uv9jH8QVXIv66p5Ir+iSpwCwvGEq0oDs9+8gpgYzSWpk9k1AW@vger.kernel.org, AJvYcCXAEZuJlzrRJ15xtUyCz2c0ad8fFof0Jdc/8QTRajlkQvIvaaQHy0Cb+3jOSznJfojHqH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwTKe2EM69gRYk2qH8uBO8H9JtdZPGta06pIFIVKjzWLxiKfH
	hHkHaXIqT4+PyQHITqF8k3LuEmgnxgIje7Git8+sDPHN3a+U5uJ6FRAtmyyzqO3USzsPTLdSzw5
	LRK0CiaOz097MnbaaUoANFsJgdaE=
X-Google-Smtp-Source: AGHT+IFfnz8xbnOp/mN6RWshJDT63VoloV048Uvab1RUbpuCe5ielvPCqhJZUaqjtBUq/XkuQIZeRY4qQEqRxkientk=
X-Received: by 2002:a05:6a20:c888:b0:1d9:2b36:3e3c with SMTP id
 adf61e73a8af0-1d96df14595mr745570637.33.1729553542387; Mon, 21 Oct 2024
 16:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017080604.541872-1-namhyung@kernel.org>
In-Reply-To: <20241017080604.541872-1-namhyung@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:32:10 -0700
Message-ID: <CAEf4BzYB-KbDh+h3YXEGeWXcvaVchjf-2m2-nSQoWPE67zY68Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add open coded version of kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:06=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a new open coded iterator for kmem_cache which can be called from a
> BPF program like below.  It doesn't take any argument and traverses all
> kmem_cache entries.
>
>   struct kmem_cache *pos;
>
>   bpf_for_each(kmem_cache, pos) {
>       ...
>   }
>
> As it needs to grab slab_mutex, it should be called from sleepable BPF
> programs only.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/bpf/helpers.c         |  3 ++
>  kernel/bpf/kmem_cache_iter.c | 87 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 073e6f04f4d765ff..d1dfa4f335577914 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3111,6 +3111,9 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT=
 | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_get_kmem_cache)
> +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL =
| KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLE=
EPABLE)

I'm curious. Having bpf_iter_kmem_cache_{new,next,destroy} functions,
can we rewrite kmem_cache_iter_seq_next in terms of these ones, so
that we have less duplication of iteration logic? Or there will be
some locking concerns preventing this? (I haven't looked into the
actual logic much, sorry, lazy question)

>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
> index ebc101d7da51b57c..31ddaf452b20a458 100644
> --- a/kernel/bpf/kmem_cache_iter.c
> +++ b/kernel/bpf/kmem_cache_iter.c
> @@ -145,6 +145,93 @@ static const struct bpf_iter_seq_info kmem_cache_ite=
r_seq_info =3D {
>         .seq_ops                =3D &kmem_cache_iter_seq_ops,
>  };
>

[...]

