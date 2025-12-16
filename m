Return-Path: <bpf+bounces-76754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1727FCC5067
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FE1E302B33D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BC335066;
	Tue, 16 Dec 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SilsQ5LJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC330C348
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913849; cv=none; b=NsVKnJHClo274/+7dav1Gr0ZdetqStz/5Rs5NmlTbT3KeZeVmuQF+o9cTH4Clpy1i2v5EkonJj1PIOGUfG08Bc/scKmOZa7feixNkQINVStaRMUGKueAChsJe2hQzWNGHzPnrPvBLlcSn9nH46mDjzmRsHSTj6sdhlg605/RCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913849; c=relaxed/simple;
	bh=4T87opl1MhUsqElKkPBN1qdTf4dvDuH6O9SZ0RiiiaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJwP+65htWnGmz5OUTo4fTSbg/W6b7CTsG1adVSePGZHHfqGXna7VNkvI7zQZo/BBuXPbv7UuFBQJsf8cp91HqHRew0ikFySoalS6kTlJm1pvbmSglf8TtQfO800CPkRWUCd82SRaIooCvP9PzXr1pcmfxa/Z1X4LjywF8iz7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SilsQ5LJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c21417781so4238215a91.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913847; x=1766518647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV/pHipMQLh0hDMe1/upHJtQtKiIxsYJe6Wq15q0SJU=;
        b=SilsQ5LJ1Z/2cUi6T34a3VDv1IcGLY0W7KK8B5veXkzmngnv0jUscRvo/yosMB5/zF
         ziOcdk21eRzbO1oDJcXpKNuBy3pDiLQwN+tpcJzfmKToAJtk00HPEBpAviFBEW8QYkBz
         PN2tfqYc5BbBdRAbn30HEaoSf2NNkLCWeHO1eR9CeSUMR94LwgQ53Dktxqd1cDAPwA01
         aWuxK1hKQN/jH4I3zVnjyhQ3u46nRf5V+qUPFgnnsKMSBcHFvlfb+u9c5DlbxTp3Lxdc
         fIx5h6Xuyz/xO01GwYVhxuwY5fJ5NNRPmwah/m9BzrDNjeMs+pbrbtLlQ2muizZycHG7
         LBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913847; x=1766518647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OV/pHipMQLh0hDMe1/upHJtQtKiIxsYJe6Wq15q0SJU=;
        b=Ky6FytpqsYLpt1CmysRwSnv4PrRNEetab47F7AzMsD+9YimL4pN7pdHJgKC541hyFn
         RJCzdG2Zb3xuGQzbs1r1QNEaKiJ2b2LYSGRpxn+bM1bzi0RoWdePNfCaX0H4WG9yrun2
         NFQu/RvlHo5+M8z+IELUfFONBlRNl6F6vx+cO4wQNIZFx3evCrpnjtuEifWsiXPmdxCw
         P7vi+9rQ9MtInicU5Y6znl4Oe20ttohUSCKdwC+RvBvpzpK/3zc331Zqz8+pD88NJNth
         3vOOICxOcMDqCeV6dRR/kFkUgXd6v8FI4513QWlKCEekXR90hYkDXZ7d2Csmls2Kkqsa
         H8SA==
X-Forwarded-Encrypted: i=1; AJvYcCVMkT9eZy4OLV5iUPpoB1yeXzrKs2Le4bQNHMLUsb3xpQQUU6HTrQx2ksFg36iHtTXdkmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gZUr5/h6J4Z0KwHfeOffN/gKucstaOrGOV7ISNL6TTjs8oi5
	+yfqK8dHYberS3IVfRzMPw6Yq2zRkzzW4GZjczR5mZDyj6EEEhrAerp0pFfD6wqhnuGcRiqDsVO
	mPSdFNbztMK9pA2iSpmyAEc8EQMHQJ3k=
X-Gm-Gg: AY/fxX5h05MO2SfC7c26hfQ5XFPbU2lPixzp4HdH9WXiHeiTgkGKxYo6wybUCdS7lVf
	kNcJPQxlFxWBlGa9WyCp/MxsvNMoEe6SdzMCfxGFPS0RjfBKga0w7AdDZU7iOyeUzUOO3S/CIjo
	hQyxunsTvcS0+6sHNdGMzsaVUcPS5haZBBDic22FHR2ddCt4blJMrEYqF0+79BBP320FBQ9xGaP
	/0LKgI7wbvpVMrZ0Z6e+55S6qhLs+G94PYg1p/67w7bghHIUIftjwW/vncv9y7X1mYMk/hLCEZn
	RElb8qau1Qo=
X-Google-Smtp-Source: AGHT+IH4+VPbnc+Q69iIjOdzqoJhOjlzXEjC1IbbYnKAb7DLXDcS7MZtD66nNclFkwVmOAo2VEquHf7Lwyt4D4MRjZU=
X-Received: by 2002:a17:90b:3f85:b0:341:a9e7:e5f9 with SMTP id
 98e67ed59e1d1-34abd5dc26emr14755404a91.0.1765913847131; Tue, 16 Dec 2025
 11:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com> <20251215091730.1188790-4-alan.maguire@oracle.com>
In-Reply-To: <20251215091730.1188790-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 11:37:14 -0800
X-Gm-Features: AQt7F2pcpQIXGIt4MZQ1hdQibCI191OMDvdx_dZEMA0OsU3STCe9YwzYn4HroBk
Message-ID: <CAEf4BzbsLMgRuJz0PGDojZG32G0GQcSKnt4F9CVVROLPXHY+TA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> This allows BTF parsing to proceed even if we do not know the
> kind.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8835aee6ee84..3936ee04a46a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -359,7 +359,28 @@ static int btf_parse_kind_layout_sec(struct btf *btf=
)
>         return 0;
>  }
>
> -static int btf_type_size(const struct btf_type *t)
> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
> +{
> +       int size =3D sizeof(struct btf_type);
> +       struct btf_kind_layout *k =3D NULL;
> +       __u16 vlen =3D btf_vlen(t);
> +       __u8 kind =3D btf_kind(t);
> +       __u32 off =3D kind * sizeof(struct btf_kind_layout);
> +
> +       if (!btf->kind_layout || off >=3D btf->hdr->kind_layout_len) {
> +               pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
> +               return -EINVAL;
> +       }
> +       k =3D btf->kind_layout + off;
> +
> +       size +=3D k->info_sz;
> +       size +=3D vlen * k->elem_sz;
> +
> +       return size;

return sizeof(struct btf_type) + k->info_sz + vlen * k->elem_sz;

Stateless, explicit, single line. All good properties.

> +}
> +
> +static int btf_type_size(const struct btf *btf, const struct btf_type *t=
)
>  {
>         const int base_size =3D sizeof(struct btf_type);
>         __u16 vlen =3D btf_vlen(t);
> @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
>         case BTF_KIND_DECL_TAG:
>                 return base_size + sizeof(struct btf_decl_tag);
>         default:
> -               pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> -               return -EINVAL;
> +               return btf_type_size_unknown(btf, t);
>         }
>  }
>

[...]

