Return-Path: <bpf+bounces-27449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0388C8AD36F
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E441C21129
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F32153BF7;
	Mon, 22 Apr 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJH5+cbv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395A146A6A;
	Mon, 22 Apr 2024 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807833; cv=none; b=PYnxAFCLHTfp0Z5Q6ZmM99NFWcW9x/dhWBkFGHZvYe0pI+f1INRRX1HYWi4z1DWHMwWtRKXX9BB7lMhxsXl8n+DbNl2DFVJGjSZZjMdLOfyM6E0KBPiNWaWMRJmbFfcygYX6rYO4Tqy1rl5oS8b2D0nrkIFJg9aTtuBWk7HsEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807833; c=relaxed/simple;
	bh=Pbv27z04lIaICL/FzqSXgzMVVCt8av1h3PQDCS7yGeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9uLVy1PpPckUMF2n9HNA+HC2f12Xm5F9MLFNuqJk5Dic8771dbcxrDyW6lzGcAjTuBbRI54w0ZY+cbcmlaaNRpUy3cZU4IFg/PfEnWufuyND2i3jG+YfbUYWUjRvzdnRB86QWNpuo2ChDZuBpyAMD0QMI30xiEZeIJQ4KPkEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJH5+cbv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e651a9f3ffso26277895ad.1;
        Mon, 22 Apr 2024 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713807831; x=1714412631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSvyvU0Rfhdk3VBloz/BBm2zvYuHYc7AJgQNt/xFkNU=;
        b=TJH5+cbvnzx+6fHFncrjE8ouZQef5te0N2TPpUF69i1WIZAJeqvIKHriQoLPh9FJQG
         nJYcWZV0zlO8DtBUAXmUnEKG1X4HR1G63mqB0rixW1UGk9oBnYIRKrd9FdICNxwOv86R
         a8pH4+B0gvqvhf27Ns9het1aV1+9qqFFYE063PxjvIGvcPIRZRf3X2aU3MTGyXVrnhU0
         +8NHpphw7D43yYXW2HYDPDhjE8VB+I9EOfwID35Vt4whgn8BqnND858zZxJsz+cdCjrP
         gA3qa+yfD198wE3FNnqUad+eYLWdc7lGgZD7PF+Jrg45GHuhRgdSuMWGJqrofAFq+WGD
         HusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713807831; x=1714412631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSvyvU0Rfhdk3VBloz/BBm2zvYuHYc7AJgQNt/xFkNU=;
        b=qyTjQ9LXsVplsNmdWKIBV7BPiN7CFrv29L5Wl6UIGFZkQgHumWyO4kK1vv6SMVZWFc
         7MNdqlP7MradFiysCha9NZR/XSb5yM/84gXIJd25/zXsiZVK61nuBkGkdiug5ZtMCD/E
         Dc7bc6UytdfsA/DoR+vec5yqBRdICpB9g57pAV+QIhKYASE2v+rTEKENWF3Zg3Vgx0+P
         Wp2xzdPbWu/Wvlla4e64G4tmhE6Sf+NHo2x9iY935b2+2D1gWYGKzS6s2AoX1P4s+4hZ
         sMltptHUCP8HiTN/XwZRwDYxxS8mG97TCNigYtwR4Rhmoh+eRUzuyGvnoXqJVzLDOKEJ
         wTBw==
X-Forwarded-Encrypted: i=1; AJvYcCUo68DhShPL7BwjPvRb/A8igszwu54HUL6n+er1I6w0PBtcLVmMe/EBaVqtocuoeb3XEy37ygEdDgFDPfMt77VHQnOKDp+rf7uI3jbkfMkapPV/yBw9oA4IKuibRMb+RhPX
X-Gm-Message-State: AOJu0YyF06BP9uyJUIQwesbhNV0QLMjkJaeQ9BhTInWnZzqwx9RbqL7z
	wNyHqb4XJ5O9g+XMBuf5+dEHTDUYNnKe+BbL4M+BN+SKOVFNNwgePvkFLKdWnPPVI4BUYEKoa0d
	3Ygt1cvJqemoPtQ/NmS5uOAVMat0=
X-Google-Smtp-Source: AGHT+IETNptdueS4aatM89LVShm6ieIsw2W7wCVSgpS2MMG3jUTZNLtGZ/PKdwz6H5ounHxgqL3jRmBsoJ5qyjXzT9Q=
X-Received: by 2002:a17:902:ea0f:b0:1de:e6a5:e51d with SMTP id
 s15-20020a170902ea0f00b001dee6a5e51dmr12905969plg.16.1713807831231; Mon, 22
 Apr 2024 10:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422144538.351722-1-liuxin350@huawei.com>
In-Reply-To: <20240422144538.351722-1-liuxin350@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Apr 2024 10:43:38 -0700
Message-ID: <CAEf4BzZvpXjez7XV8meBqP3ZzrZcJ8osHgi9A=meheWTbrashw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: extending BTF_KIND_INIT to accommodate some
 unusual types
To: Xin Liu <liuxin350@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yanan@huawei.com, 
	wuchangye@huawei.com, xiesongyang@huawei.com, kongweibin2@huawei.com, 
	zhangmingyi5@huawei.com, liwei883@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 7:46=E2=80=AFAM Xin Liu <liuxin350@huawei.com> wrot=
e:
>
> In btf__add_int, the size of the new btf_kind_int type is limited.
> When the size is greater than 16, btf__add_int fails to be added
> and -EINVAL is returned. This is usually effective.
>
> However, when the built-in type __builtin_aarch64_simd_xi in the
> NEON instruction is used in the code in the arm64 system, the value
> of DW_AT_byte_size is 64. This causes btf__add_int to fail to
> properly add btf information to it.
>
> like this:
>   ...
>    <1><cf>: Abbrev Number: 2 (DW_TAG_base_type)
>     <d0>   DW_AT_byte_size   : 64              // over max size 16
>     <d1>   DW_AT_encoding    : 5        (signed)
>     <d2>   DW_AT_name        : (indirect string, offset: 0x53): __builtin=
_aarch64_simd_xi
>    <1><d6>: Abbrev Number: 0
>   ...
>
> An easier way to solve this problem is to treat it as a base type
> and set byte_size to 64. This patch is modified along these lines.
>
> Fixes: 4a3b33f8579a ("libbpf: Add BTF writing APIs")
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..0af121293b65 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1934,7 +1934,7 @@ int btf__add_int(struct btf *btf, const char *name,=
 size_t byte_sz, int encoding
>         if (!name || !name[0])
>                 return libbpf_err(-EINVAL);
>         /* byte_sz must be power of 2 */
> -       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
> +       if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)


maybe we should just remove byte_sz upper limit? We can probably
imagine 256-byte integers at some point, so why bother artificially
restricting it?

pw-bot: cr

>                 return libbpf_err(-EINVAL);
>         if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
>                 return libbpf_err(-EINVAL);
> --
> 2.33.0
>

