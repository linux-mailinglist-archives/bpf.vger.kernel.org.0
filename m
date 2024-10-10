Return-Path: <bpf+bounces-41652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10AE9994A1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628EC282EE1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78711E3DE6;
	Thu, 10 Oct 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqNOIttf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F619A2A3
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597025; cv=none; b=HgCM4JkXHsk172h4OiaBT1JD2LZ5rPzBdESbXkiV0pyRkL+sAq1m4to4CL+8XEk30+eC7PucBapbm4pGznZ/XvHAWC9Rkmeqyd7TjAmBRR+ve9U9LJmQQF1dLJmKJ1ui+655MSeJ1tXpBwksXFLoNPixS5UFxx77O4E1clKrGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597025; c=relaxed/simple;
	bh=NjZmsuwJd18SYa/BxPpy3NIykaDVu2Fjq/wUEtIZm4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q55GEzDDYbHWeZgLG3KgfogKwWpz0CTKWPQro6/wbeyuFsGMZsXN+5leS9A8QsotwjapfvQEKwq0y2H39za20gcM1YWaP7LIzEygLmSrv3R0QLOWdPscjraPgnQB6EnG/mcvOaeug9LJmDgDPJOKq2W870LZmCEEbkkmfmdImfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqNOIttf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso480206a91.3
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728597023; x=1729201823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da6GUY+ELNd1DLQRkkLRERlZjccZ4wuj1CYEcOkL1W8=;
        b=LqNOIttfos3FKENMubxJFrYeNhld08K2WtWz2L6hs8q+FFH7XpkVeD6gMjfMtwRePF
         xxy9MtR4ZIgjFRaypBu0BE32N6ZKv2zsCq+14MKSTgrjQChGRrrCve+wNMTeN9RfeQU2
         DO6tZr2pWS8MNcp56w37LOJfAwdpcMCsnp9LlnqBEzPUGMQk8XsqRLpQw2R130WlO166
         ozD27rPTwFsBYKujQI/NfdGXqXZfyTNqvolnqOMBf0q6MBXpHBoTi+IQFFVMHexNRTIm
         kXyARb3RYyfWzIjyf314fQbnTB4aAnc2+IBlEzNbU/lyJ6q510F3qsW8fB6Z6wEs5BpN
         NjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728597023; x=1729201823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da6GUY+ELNd1DLQRkkLRERlZjccZ4wuj1CYEcOkL1W8=;
        b=f3fE/Qo8BXnpOxi8U53zXO9OdDOmYr364upKCtQIm6ngt/zEcetlF39tnW0PtbAQL1
         upKxAEhhvZmwuDIXt+LlEYlfYyewj1xnj+A8jlJG2EMwHAJpmHiBypoPWOwDt9bAyrtz
         a44VpaPZ7rh8NsE6INnCQ5yanRNtUEQUAHCxVkNfPy7WnHNq2Jj6/ncNoI9v1jB+f91m
         y5RZoWbMSk6rD6g9dAlaLSWZRkgm3PtWJC40ouLNUG0Q+kujRuhzGvK+5r3xa2IM76rR
         +PQg74CABZQ9SNWZR5KVX8iHbxiGcs56PfSGuirZC8wYtVfPtwE03tqcWKZjRc8OSp1q
         4k1g==
X-Gm-Message-State: AOJu0YwCwXEG55Js9KQkj9rKU3vGetTEaXIC54xb1W79UgX8EG/z55xq
	N5DdgglOfy6RaBTK999+Sbbu/EQLPfANCm1U8d9lnBxnf7QYQDNxj0FU+lkH2MOkRQjq73t+v2l
	NO0XnJWul4W6ICjheW2lA0qMIuxo=
X-Google-Smtp-Source: AGHT+IEMKx7L34xqGIKvq75HdF9ayeGGB+Hu2Qt5mWBt0+ZPa/WYZAzWfblxXH3NOHbaU/7hFMHUxl27peFC7RivkDY=
X-Received: by 2002:a17:90b:2304:b0:2e2:d181:6809 with SMTP id
 98e67ed59e1d1-2e2f0ea9db9mr751838a91.39.1728597023363; Thu, 10 Oct 2024
 14:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-8-houtao@huaweicloud.com>
In-Reply-To: <20241008091501.8302-8-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 14:50:09 -0700
Message-ID: <CAEf4BzafbA4S0soDpRp__biWXm5bwFa_BWfbPLO=JSa91rG9Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/16] libbpf: Add helpers for bpf_dynptr_user
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Add bpf_dynptr_user_init() to initialize a bpf_dynptr_user object,
> bpf_dynptr_user_{data,size}() to get the address and length of the
> dynptr object, and bpf_dynptr_user_set_size() to set the its size.
>
> Instead of exporting these symbols, simply adding these helpers as
> inline functions in bpf.h.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  tools/lib/bpf/bpf.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>

I don't think we need this patch and these APIs at all, let user work
with bpf_udynptr directly


> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index a4a7b1ad1b63..92b4afac5f5f 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -700,6 +700,33 @@ struct bpf_token_create_opts {
>  LIBBPF_API int bpf_token_create(int bpffs_fd,
>                                 struct bpf_token_create_opts *opts);
>
> +/* sys_bpf() will check the validity of data and size */
> +static inline void bpf_dynptr_user_init(void *data, __u32 size,
> +                                       struct bpf_dynptr_user *dynptr)
> +{
> +       dynptr->data =3D (__u64)(unsigned long)data;
> +       dynptr->size =3D size;
> +       dynptr->rsvd =3D 0;
> +}
> +
> +static inline void bpf_dynptr_user_set_size(struct bpf_dynptr_user *dynp=
tr,
> +                                           __u32 new_size)
> +{
> +       dynptr->size =3D new_size;
> +}
> +
> +static inline __u32
> +bpf_dynptr_user_size(const struct bpf_dynptr_user *dynptr)
> +{
> +       return dynptr->size;
> +}
> +
> +static inline void *
> +bpf_dynptr_user_data(const struct bpf_dynptr_user *dynptr)
> +{
> +       return (void *)(unsigned long)dynptr->data;
> +}
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> --
> 2.44.0
>

