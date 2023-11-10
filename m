Return-Path: <bpf+bounces-14797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F377E83CB
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 21:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030772812CB
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CE3B794;
	Fri, 10 Nov 2023 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB4pMz/z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B8208C1
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 20:32:55 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C0D49DA
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 12:32:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32fa7d15f4eso1535084f8f.3
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 12:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699648360; x=1700253160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzVSNkGp0IcobuUfJ7WTQe/Kbe0+tJNej/lUrz6C0rU=;
        b=HB4pMz/zqIjfmeEmXRioA+VI8+kRDqwzc8JBitJoIY6oAKhO6cIVeidUwZgORlDvIz
         awDrYnRurOYifmHRNEc2D3jWzf+VyCh3DQtdalV5Px8+o4vd4rFIIzC5yyJFh4/h7v3E
         HECd5NErYXDRg7IMqFkjw6CIDbwQ4DWoJZZxG/L8q0qLJYfaW9YmaATznV2R+ZwLxwDT
         0pVgoR4OCMU+GMo4Fp5B1BElYPTZuVmBhktVkpozUkrzcGqOKdVqUUm3LKGGmlr7UXjw
         VjCuJL+ZIefVLlmhhhLfiXUzYP1exLkdHCa9CZNRfToxSF6U+y3LkPYrfxAh3vUB3sQE
         UqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699648360; x=1700253160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzVSNkGp0IcobuUfJ7WTQe/Kbe0+tJNej/lUrz6C0rU=;
        b=KzLkkPTLHiaXOLouPrD/zLGF1SFxQtCnaYbCU+Oe4vFWxqaUhOLtAvVM/QQR5P5yv4
         9P0dnil21+/qhdj5g/2wy8d3u2lG3ck82ojJnDDtm0zF17gvoTm0R4jQSGmfitwEONJ3
         zxKOsuApIqYLhDuKkbWfnzeZTR0xxO5ikeRWHJ3haVSKWulOo9rOIvx2KQiwyFq0c/Pl
         uD+Z1TCqNDuWhcTsv0k0IDjs0gioPCPfhxFv5b77Iqqa7mMAqrJeGDyWExvZsRoXLNX/
         8OVKF8yAvDzbRt+71y1AAMaJjXBm8PPgmxzpA1HmiCewdP4KE0SNp9bz3bHBGDWq21SS
         uWTw==
X-Gm-Message-State: AOJu0Ywk40HqSul+5RVmEOf6oYKemQDpyMi+PrWz44iR1pZzoelqEPwd
	8dlgoxPcaiT6c03NToFZgk1DyFXF0x5423m71XNoRD3Wd4g=
X-Google-Smtp-Source: AGHT+IGL21VFjcc3wSCR0FQEnvB0kVRjADjWwo1zbYOkvPIn7SPP3OGQbFCPJy4bnO87ullL0Ga4MCN+u9gZGL19FBc=
X-Received: by 2002:a5d:5488:0:b0:32d:d7a8:6e40 with SMTP id
 h8-20020a5d5488000000b0032dd7a86e40mr196141wrv.67.1699648359918; Fri, 10 Nov
 2023 12:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110172050.2235758-1-yonghong.song@linux.dev>
In-Reply-To: <20231110172050.2235758-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Nov 2023 12:32:28 -0800
Message-ID: <CAADnVQJ2b8UNmzOLAQQbZXxanyPDSd7uv+j=xdh=g9pQCzKi5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Do not allocate percpu memory at init stage
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 9:23=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> +                               if (meta.func_id =3D=3D special_kfunc_lis=
t[KF_bpf_percpu_obj_new_impl]) {
> +                                       if (!bpf_global_percpu_ma_set) {
> +                                               mutex_lock(&bpf_verifier_=
lock);
> +                                               if (!bpf_global_percpu_ma=
_set) {
> +                                                       err =3D bpf_mem_a=
lloc_init(&bpf_global_percpu_ma, 0, true);
> +                                                       if (!err)
> +                                                               bpf_globa=
l_percpu_ma_set =3D true;
> +                                               }
> +                                               mutex_unlock(&bpf_verifie=
r_lock);

I feel we're taking unnecessary risk here by reusing the mutex.
bpf_obj_new kfunc is a privileged operation and the verifier lock
is not held in such scenario, so it won't deadlock,
but let's just add another mutex to protect percpu_ma init.
Much easier to reason about.

