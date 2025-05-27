Return-Path: <bpf+bounces-59020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F59AC5C20
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84353A7E5F
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798B212B38;
	Tue, 27 May 2025 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeRFItUX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A737E1F4E4F
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381033; cv=none; b=AhIpL4C2Gjmyy+XyZgNpc0oPhNOPzLFq9msM7gjNyoc0z46SebVg3iFhyjVVIP/qpywQaoMbwIxoumR55w+89WQAgyCRHw28D6m2yVXFENn2QCJ+hlVQQNes28OrkUVqnbm/7mZmbvnNb3gUcADQ7zVJA7/z25cybQZ+TsKDkuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381033; c=relaxed/simple;
	bh=7b3cJ7D+vpIYr9Hqc4CwYAVjeiOR60Ly78gxURBTZiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkHwV0OyyORib7oOfNgq1katyhQPu/HSZ2G3gvxSnriAOJzwOPZXsqK8Wg0VL9Xzx1l8nMiaWHfD/LQD53s2D3XkGPwMFpA1VQgEm+485ZH+ZcAXMjeaSTu2S9ZUUJMTLqMWt43c5rw0cBxaMTj+y0kLtJGaSe2e9BaohwRlwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeRFItUX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3109f106867so3817243a91.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748381031; x=1748985831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fppIT8cvPdwPAP8uEFwAtrDP7952qq0tICJJ8qeqBUw=;
        b=TeRFItUXirFBYkzuoB9cnvg+dOSOgAIcms8LEQNF1vs609X4wTw+UccbpGfPpqHtoJ
         MffcTKc1oR3ewTFsRPxwXqEvFcSJ0C/Sv4PghrNrRBWz44FEiWFDT6sMarpWcxD9X67o
         feppKcn38aLvIlRVAJxN7iEe8tyIVKasn7aGe0MdX1WybdnbO3xk7ybueIlKF8zpm9IB
         TnrNvjHaNu2MNVDvx4E93GkT1/mrZtBJCPyHXavwACVFp20sv03pGSPjXyn0E5IB21GR
         A4j2rj22wD5cOKSW8G4oHeXW54MKARTOyWgMgq5djEiTBc/l/RozvYtPKhidtV4hu8B3
         AFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748381031; x=1748985831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fppIT8cvPdwPAP8uEFwAtrDP7952qq0tICJJ8qeqBUw=;
        b=Ww8I4N77+f7nrfoSyjjrSX7MsU9cSW3s9Dq0NMtLfxHt70hAOT15mZidnv1eJp7heU
         aO28kYURurTzU5ZIPgHF1t5WLUk/uFZBoHs9ckGgWTUIamEMcDTAFz6RWfTqMkvnNg7Q
         M0alCBJ7Jy7+gLNf5QRheiFXyB6za1tiBvv3CMhSO39jr/616kmdxufRwaByoIo+PLTH
         CeZ1yIEW9e19PwVyhKfw/viy2FlOSiFUDDt1yG0rK8lN9gCOBaSh5AjgUzSkeGXdR9Tq
         GX3jtVVX1Sa+8zr0k49zSWX+nb5kvjdpWRokxV3wGl9LdseHL5Z5wJgdf1fLWL0eU4eC
         KrtA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2/Tyh9uS0FYaLJmqNIDnNzofPK/MOZBSQOFKLyksET3k9lMPX8Ug9d/C4aRkrN0KmGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Of8RlcsDdmpsPWINaj3701S0HSPk6h5hfnUkhsfYfolg2WSy
	rteZz87N5N9deabVO4yPikKgE27pBtv4hvvU8uLE0pI7JLGEiGPmyGu9YbFgKgv2NhMi9woQa7v
	yTNFWCt58FGmZZOjL0v5fP5D2+lGE12Y=
X-Gm-Gg: ASbGnctvmvuF5FDXOGx+vDK6z8eIIerppxslXI8mB9JlUv1Lb08bqRQxsRd6P0xtj2D
	riwEFRXVQAH6vANGyIQ0QprLOWLv3ClT0iaQ2C8x86M1WYctUMR99czWJTiKw6ULNX5dtkV8WEs
	6X3y2jv6wWYy7I9a55NFMp7OgVeJdEFuh+OlHTjbJ1/+rk+Ebj
X-Google-Smtp-Source: AGHT+IEPLhk4GEqTPojSgGC0XLcG4D0Uq/YAeaoBwXa0J7dFtoMsgN7u5lQHCinISSLCrCi5CEd1NrUVA42WAR7Z8S8=
X-Received: by 2002:a17:90b:4a92:b0:311:afaa:5e25 with SMTP id
 98e67ed59e1d1-311afaa5ffamr6651735a91.24.1748381030831; Tue, 27 May 2025
 14:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523232503.1086319-1-isolodrai@meta.com> <20250523232503.1086319-2-isolodrai@meta.com>
In-Reply-To: <20250523232503.1086319-2-isolodrai@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 14:23:37 -0700
X-Gm-Features: AX0GCFsFokUmbpDa8LFcDQSBsAdgoK5nxMy9oB_CZBu6EBTxOGX54EWcCcSx-Cw
Message-ID: <CAEf4BzZNU0gX_sQ8k8JaLe1e+Veth3Rk=4x7MDhv=hQxvO8EDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add a test case with
 CONST_PTR_TO_MAP null check
To: ihor.solodrai@linux.dev
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 4:25=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> =
wrote:
>
> The test requires the following to happen:
>   * CONST_PTR_TO_MAP value is put on the stack
>   * then this value is checked for null
>   * the code in the null branch fails verification
>
> I was able to achieve this by using a stack allocated array of maps,
> populated with values from a global map.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  .../selftests/bpf/progs/verifier_map_in_map.c | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/to=
ols/testing/selftests/bpf/progs/verifier_map_in_map.c
> index 7d088ba99ea5..52b3e1749e71 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> @@ -139,4 +139,28 @@ __naked void on_the_inner_map_pointer(void)
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +int map_ptr_is_never_null(void *ctx)
> +{
> +       struct bpf_map *maps[2] =3D { 0 };
> +       struct bpf_map *map =3D NULL;
> +       int __attribute__((aligned(8))) key =3D 0;
> +
> +       for (key =3D 0; key < 2; key++) {
> +               map =3D bpf_map_lookup_elem(&map_in_map, &key);
> +               if (map)
> +                       maps[key] =3D map;
> +               else
> +                       return 0;
> +       }
> +
> +       /* After the loop every element of maps is CONST_PTR_TO_MAP so
> +        * the invalid branch should not be explored by the verifier.
> +        */
> +       if (!maps[0])
> +               asm volatile ("r10 =3D 0;");
> +
> +       return 0;
> +}
> +

I had (slightly redacted) logic like this when I ran into this issue origin=
ally:

struct rb_ctx {
    void *rb;
    struct bpf_dynptr dptr;
};

static __always_inline struct rb_ctx __rb_event_reserve(u64 dyn_sz)
{
    struct rb_ctx rb_ctx =3D {};
    void *rb;
    u32 cpu =3D bpf_get_smp_processor_id();
    u32 rb_slot =3D cpu & 1; /* 0 or 1 */

    rb =3D bpf_map_lookup_elem(&rbs, &rb_slot);
    if (!rb)
        return rb_ctx;

    rb_ctx.rb =3D rb;
    rb_ctx.has_dptr =3D true;

    /* can fail, still needs bpf_ringbuf_submit_dynptr() */
    bpf_ringbuf_reserve_dynptr(rb, sz, 0, &rb_ctx.dptr);

    return rb_ctx;
}

static __noinline void __rb_event_submit(struct rb_ctx *ctx)
{
    if (!ctx->rb) /* shouldn't/can't do submit below */
        return;

    /* no-op, if ctx->rb is NULL */
    bpf_ringbuf_submit_dynptr(&ctx->dptr, 0);
}


Where `rbs` is ARRAY_OF_MAPS of RINGBUF maps. And so when calling
__rb_event_reserve(), followed by __rb_event_submit(), no matter
whether map-in-map lookup succeeded or not, no matter whether
ringbuf_reserve_dynptr() succeeded or not, we'd satisfy ringbuf API
rules calling submit_dynptr() iff map-in-map succeeded.

Maybe try using this logic, it's actually a real-world code pattern,
so would be good to know it keeps working after your fix.

pw-bot: cr


>  char _license[] SEC("license") =3D "GPL";
> --
> 2.47.1
    >

