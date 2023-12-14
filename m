Return-Path: <bpf+bounces-17899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426D9813E55
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F155E28153B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1D6C6F4;
	Thu, 14 Dec 2023 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsYJ28Zc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57372DB70
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so2323266a12.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702596992; x=1703201792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j30IEJqso0B129/LPKtEcm1tZofQwOzhOwbmceLNYkc=;
        b=dsYJ28ZcfuUjxY1XHayAzTif5H3WC3jeQwtKhpFik+kdWKr8hjMS5EP/0CzIDIdm/x
         OVAQds+GR0i8ak4sPFyQefl5zKsZlXNPHglLGgIZY91zYMffZEOUXTd86Y0y4dTu46hP
         ux3sWpQqGBhLmKWqb1CccrpnOB4ZPTcYFCJ2deCn9yAOzQhqKjazqU8U1vfAb8U/VBQ5
         gd6jupHBtRzV5oA2YU3Or4zJGlbjS9FqGrub0jDklllOgKohrVsZ1Y0ujr8HIn7iMAlM
         Ue+pv7XqXrIKIsg9Y8iykXyY9X0A0cs2MaEs6EhsiVfT5sfSA0Wehaf7oyrt0L8oM8gp
         59ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702596992; x=1703201792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j30IEJqso0B129/LPKtEcm1tZofQwOzhOwbmceLNYkc=;
        b=uTBCda5o4vCyIU9afvtgx6UfVXS50aSmZ5luSH5Ggsz+8khvhVzhfxxnXyXMz4SzEn
         L7465/JyFYOSmH8r1qHDDk/vDCkfSEpn6ctbB6hAT4wV8EA1Ywm8Y4os5N10Rj5fbu3z
         lxEC/GHqp0wqynn5O5NAkeXyFzTZ9mKfAaUiLnckzRMLbrUzEG9GiozeXlKzCogiXH7U
         NQEQOO6bPuzuxPSDp709J2FUjLpvjV7snEeGVucwZNEsPcZHIEr/Pf7k858dkvT+6zmx
         MEvhxhpcVZ7KDkVv9tSOexDXj2pko03vZsFtcVT3B5p/Umi6SOUvAqsxbWxMQ+2U+Rft
         p9Rw==
X-Gm-Message-State: AOJu0YyKx827wS/Gse86oxgpFrtUkO4bBvhtX/JRMCJtYi3jiF54PdBO
	uHCTWOab9CFKHv3OJLS8L0hYj9/jYDZE4MtG9VC7odzb
X-Google-Smtp-Source: AGHT+IFBQV9VjnpP1HNOOIdFptEGUinjHYC79h16p3WdOSvcq5QTKlgn8qNJ98atPPyk14WmenTIB2IbspDzncN+geo=
X-Received: by 2002:a50:d557:0:b0:552:811a:c66f with SMTP id
 f23-20020a50d557000000b00552811ac66fmr1472039edj.8.1702596991854; Thu, 14 Dec
 2023 15:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214075037.1981972-1-wentao.zhang@windriver.com>
In-Reply-To: <20231214075037.1981972-1-wentao.zhang@windriver.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 15:36:19 -0800
Message-ID: <CAEf4BzaxkYwhj4sv+=z=3XDr1vCtKrz=eRO0JguEQZoCOEkomg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix null pointer check in btf__add_str
To: Wentao Zhang <wentao.zhang@windriver.com>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:51=E2=80=AFPM Wentao Zhang
<wentao.zhang@windriver.com> wrote:
>
> The function btf_str_by_offset may return NULL when used as an
> input argument for btf_add_str in the context of btf_rewrite_str.
> The added check ensures that both the input string (s) and the
> BTF object (btf) are non-null before proceeding with the function
> logic. If either is null, the function returns an error code
> indicating an invalid argument.
>
> Found by our static analysis tool.
>
> Signed-off-by: Wentao Zhang <wentao.zhang@windriver.com>
> ---
>  tools/lib/bpf/btf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index fd2309512978..a6a00bdc7151 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1612,6 +1612,8 @@ int btf__find_str(struct btf *btf, const char *s)
>  int btf__add_str(struct btf *btf, const char *s)
>  {
>         int off;
> +       if(!s || !btf)
> +               return libbpf_err(-EINVAL);
>

while for some old libbpf code we sometimes did NULL validation,
generally speaking for all new code we assume that passed objects are
non-NULL, unless otherwise explicitly pointed out in API for cases
where NULL is actually meaningful (like no options are specified,
etc).

In this case, both btf and s are expected to be non-NULL by the API
and NULL values for either btf or s are meaningless. So I don't think
we need to check these conditions.

>         if (btf->base_btf) {
>                 off =3D btf__find_str(btf->base_btf, s);
> --
> 2.35.5
>
>

