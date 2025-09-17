Return-Path: <bpf+bounces-68713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA1B82030
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7913AB74B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123A2F746A;
	Wed, 17 Sep 2025 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOEdCLSS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494FE30BF68
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145533; cv=none; b=b6WiJpaVPno6SRbymcDrOyjXptX/Yl7ojNUVUUPxO9lov+qa3UkmDeRAIsSRdS2P4y0MHIQuJRa7B9NSxlLdNOSGH5QWmpzjWKS7EVCGgLTXKyfaWnyyGU9YYIIiCCh7WCbUml74GCEkF5t4N+AGbUaV1PDV6tdGvH7bEj/L9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145533; c=relaxed/simple;
	bh=SrRr3B3WuawC0Xl/A+z3bsLG93/7TTcKHXa6BH3hTu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/bABPPp5vOuZyN3U5JBDH/0XimFrZqCJLz8BkhT2GFZY94JJjJNLx4doEXOvVFa74EoC1CjqO07qXDqLjnJSJgCLhKaFTifEflNCxygIOgmuwVtkb2qvDM2Vdpweeoe3rE+X6w0RSAduv6Cz9WeDoE6jsG7yGbIw4dTleNBeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOEdCLSS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3304a57d842so157886a91.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758145531; x=1758750331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqq1H03M+H/w/vAh8pswhh5qOo+c13pHeWvFTZoWApU=;
        b=kOEdCLSSU4hZlT9/3BHJsjtGOd/bBvcQdogJ/IzNNkbuNAHx7l12k4CUApW91ZB+Nr
         Q3oDeUR64svDxHzqjnG4MKTuSiw205MZROw7MiTizD8Zl0G3tasu27JwXwNnpixPWxKy
         8xIpfy+IGyRSfq2e2DvMu/i6FeFmSzXGO07jDMeDz1BONQQCQFdvqUMMliYLxBymvknJ
         SEEgOd4+1wlDfexbRx3L/ZZpGlxX2OSqf27aH/DemmgcDf85aSzi5PC1yeyffvX7G7aE
         zwEdSm3okmz9VNCs+RsPlhTmCNWhY1tm1zOa+FVV1HvBf5RPECNl71loBzacVEeEpNAq
         Uu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145531; x=1758750331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqq1H03M+H/w/vAh8pswhh5qOo+c13pHeWvFTZoWApU=;
        b=HlcdU6SFh9iQ3QDVqKoyAMWPDUXMhv/GGLXDuPg3eT+93tbF05kSBF/L9EJ3jVX7te
         vSm2GUCCXAVc8osURHwlJxNV3eKbky9Qa1vmkFSNCDgYIEH/Sd4MxQHsMfQqUZNOcz1a
         Vt6AwLwyNThwGfzadsLmnBK5pTb4+ygXrWEHNIdoFzhyOBWSKfphA58EZvoVWhbUW5NN
         QaCaugEFCeUyFw9hUfFcEiRa1Pmt2xJHGN+ODu+9zlg7X8BlDgkVaCGvhqG8X9zoCRyU
         ezNP+oexuZQdoQj8qPvu0iShWvzqH7zL8umtoEiFGGs6A1prZs+FQBq6UbHEwONte11G
         Y3aA==
X-Gm-Message-State: AOJu0YyzY7u6MOEks3OJZ+Pu3AomYkxygWxEx+ot3imizO08v9ZwheIc
	/AgjHHse1aajAvI4LnfK1uQB5L2V+xqd/0WRf4HAgrstewVSOfstiXuStjhEo+HgNGvziI/M51a
	Rr67mQeZBVrvlhRB05l4vS6A3tEjX2Ag=
X-Gm-Gg: ASbGncu2vkI6cKMII3QQlhQteEohlxaU/R1z4kAh8xbP53YQAk1tpHJlXx1WSnm4Bms
	NCWKq1fMguS5Wm2vy2yHg0o+sWTkykkQzDcJdIh8jtLdYXxlwhdnTtTGliv3CfSWqWfZqzyJjNw
	0yTlaH28HqBl7dKEtMWAmlS6xi1mf0bhyHYA9mOTidzH+93y6ezxpfnBbXSCpKjFtSu01lI4AN4
	a0OIdOvLoqAx3CZCXX00bA=
X-Google-Smtp-Source: AGHT+IHRuI7sLeSbsegCcetocmpNi7jNZWAECHJOiabqSzTc52meqou1S1JJ4hihQOGa22+e+RJkNn/Ggy62A9/8Nz4=
X-Received: by 2002:a17:90b:5808:b0:32d:e2c1:2f5f with SMTP id
 98e67ed59e1d1-32ee3eae7aamr4877020a91.15.1758145531348; Wed, 17 Sep 2025
 14:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-6-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 14:45:18 -0700
X-Gm-Features: AS18NWDMWTqIBmhwle5X3wc90YzS1UnX3pnC4bztfceoL3yRMzwP8nhnJ2z3CYE
Message-ID: <CAEf4BzZ5R-H+XL6TPftv6KGFnowA1yeCXii7OZ9uq_A-zFrjJg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 5/6] libbpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> With the previous patch adding common attribute support for
> BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
> when map creation fails by using the 'log_buf' field from the common
> attributes.
>
> This patch extends 'bpf_map_create_opts' with two new fields, 'log_buf'
> and 'log_size', allowing users to capture and inspect these log messages.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 16 +++++++++++++++-
>  tools/lib/bpf/bpf.h |  5 ++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 27845e287dd5c..5b58e981a7669 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -218,7 +218,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    const struct bpf_map_create_opts *opts)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, map_token_fd=
);
> +       struct bpf_common_attr common_attrs;
>         union bpf_attr attr;
> +       __u64 log_buf;


const char *

>         int fd;
>
>         bump_rlimit_memlock();
> @@ -249,7 +251,19 @@ int bpf_map_create(enum bpf_map_type map_type,
>
>         attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
>
> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       log_buf =3D (__u64) OPTS_GET(opts, log_buf, NULL);

no u64 casting just yet

> +       if (log_buf) {
> +               if (!feat_supported(NULL, FEAT_EXTENDED_SYSCALL))
> +                       return libbpf_err(-EOPNOTSUPP);

um.. I'm thinking that it would be better usability for libbpf to
ignore provided log if kernel doesn't support this feature just yet.
Then users don't have to care, they will just opportunistically
provide buffer and get extra error log, if kernel supports this
feature. Otherwise, log won't be touched, instead of failing an API
call.

> +
> +               memset(&common_attrs, 0, sizeof(common_attrs));
> +               common_attrs.log_buf =3D log_buf;

ptr_to_u64(log_buf) here

> +               common_attrs.log_size =3D OPTS_GET(opts, log_size, 0);
> +               fd =3D sys_bpf_extended(BPF_MAP_CREATE, &attr, attr_sz, &=
common_attrs,
> +                                     sizeof(common_attrs));
> +       } else {
> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       }
>         return libbpf_err_errno(fd);
>  }
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 38819071ecbe7..3b54d6feb5842 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -55,9 +55,12 @@ struct bpf_map_create_opts {
>         __s32 value_type_btf_obj_fd;
>
>         __u32 token_fd;
> +
> +       const char *log_buf;
> +       __u32 log_size;
>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field token_fd
> +#define bpf_map_create_opts__last_field log_size
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> --
> 2.50.1
>

