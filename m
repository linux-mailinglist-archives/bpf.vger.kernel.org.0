Return-Path: <bpf+bounces-21909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A621853FDD
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC31728D579
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA963104;
	Tue, 13 Feb 2024 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSLVPK65"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20264629FB
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866113; cv=none; b=tNwraQC416FKUi8Uk7O/zbYBj3KMR16RAE7ttQy+h7aH8NHa8ObciYB2erGvHhFoQOH1cLcFxFNqXkenSa7QJFmENWhSJW8wv2eBBHJpXC1xbx/0pEKmXONOuR7LQ1Zh+jdcheUP6aRdIAkOPHyIqyHukN3zEfgr7J+ehyp5/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866113; c=relaxed/simple;
	bh=6nadDeDN1TyJMr5TJqu7uO2bYu+PGW/jdAEdc3mjw/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgQgS+El5EaZE19WBnVRsCx35YjzuQ7oIGlMvVzfLEtc3evtb1tCremZaj03lpUcPKygovYU0DQwg7yqw6rosoZprI7vRShosvy08qVaTTRAoWDxLfa/mAqhioori3F0A0xaNe1T0jTkMFeH0L4GaNRwu1QmM7Vw/h57uoNXqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSLVPK65; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3508867a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866111; x=1708470911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNM9M1k9k//9Vz+AfyGk5rhIhp/4m9683qfR8+Wss64=;
        b=kSLVPK65qo2zbMCNlj/MuVTMbAQha+kkkCjUO3prDtL+RNpnmcnGU2lqyWUKFc+uJ5
         d77Fj6nrHhefE1K5u1Mpt/Vcztm1L0Jzyqjb3X5vSACtWIKN68MrTIPGB4jCnFigPY5M
         WElLA4Nn4RAEGM0qA1svlYXyubCiIUGABLudNVpMEt/SM2V4wxi9SuVNe/bhF2f/dyME
         54UDgKhqafrHmVep9Fd5s1blpIXnSOPRw4Wy3VcD8iEwcP+E9k0yydsLlHuJYw6BOQBW
         RqVT3+P5vgfZIzkCS9ZRoJEm5D6d2l0fA5FW5xX0KjTi11879zho0B5uRGr0GhM8nBZp
         YPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866111; x=1708470911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNM9M1k9k//9Vz+AfyGk5rhIhp/4m9683qfR8+Wss64=;
        b=QeApAna7A/mrCJLm+MlrBaJS4A4Fslkua/1WST6GbzwlD399yP7idz0NIkMJWxM8/S
         4UOe0DqI4qQcU3DLwX30eHr1FGPUZA6wIESwztLzNZceISISCevw2AR1iHxyGgNewbIn
         AOXxd8ckJ/yl2KpIAHanTyDlOWb0xaCR1QH5AqG7frFPhnnkytUgfcAV372FgCWINu6D
         oL01cAer/GVloCw68nU6NRS1IBZBR9p9kBZZRIwpHutzJ8lyuhAEX9UxCPYg+oLwN1so
         ao2sP8f+iw6J20UHI8/Iid6ENuV4bK8BtYCOHsqRR/0KasQG95LmrJJiG70jVxlgoIDt
         jAfQ==
X-Gm-Message-State: AOJu0Yz8uPT3Gh6WRh/Sfve3dI1P4Hvba0pgEQsuQZwfBMmNZ2cjHpLN
	t3ErtRmzePDtNJpsDTl/co/yBsGmvSCW7L2qvVKPpcVJOS/8BQrBwrNplTCvhx/lV91jXphqMVL
	7u9FCSrfYAwEIbAorvDvITzX0z+g=
X-Google-Smtp-Source: AGHT+IFw5BSj+vSxvQ1yuRvMYz6cSZt5n5GVsnS59BIRPP1vOdDwQVWR31+YKpdjfcLwZkoSos7veDQfVRDkMOHsClo=
X-Received: by 2002:a05:6a20:d04b:b0:19c:b0f6:25c with SMTP id
 hv11-20020a056a20d04b00b0019cb0f6025cmr1173989pzb.45.1707866109921; Tue, 13
 Feb 2024 15:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-12-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-12-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 15:14:58 -0800
Message-ID: <CAEf4BzbP2gVP66Tvs=7MZzSD5aVH0MCNi88q9SNtV1h2=a2SnQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 11/20] libbpf: Add __arg_arena to bpf_helpers.h
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add __arg_arena to bpf_helpers.h
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/bpf_helpers.h | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 79eaa581be98..9c777c21da28 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -192,6 +192,7 @@ enum libbpf_tristate {
>  #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
>  #define __arg_nullable __attribute((btf_decl_tag("arg:nullable")))
>  #define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
> +#define __arg_arena __attribute((btf_decl_tag("arg:arena")))
>
>  #ifndef ___bpf_concat
>  #define ___bpf_concat(a, b) a ## b
> --
> 2.34.1
>

