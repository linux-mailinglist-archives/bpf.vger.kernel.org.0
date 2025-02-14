Return-Path: <bpf+bounces-51481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1976FA3527C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E116C297
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A529E10E3;
	Fri, 14 Feb 2025 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCx3S0ih"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4E15D1
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492032; cv=none; b=POIkRvgFuGx/O34Aj7yvTmqTQn83dHYDERpzZAgrx1o94wTTgHGG1h2TfMS3lypInNethEBv5MX5V6CVxwYB80kCNt9Jl/tGZ8FeAE9kUBeyFjGxvtSj6xGfk7JR3KtjBiPJWmszt/cJHPgeVlpJKURD16XQCZ3Wz76Sk2IZGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492032; c=relaxed/simple;
	bh=+0kM68tdlVoEA6V6aKSeWR7RAIN3wG7IzRD1Wrlyfsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gATIVFv66Tdbqyftd97wzdaX8aw1hgunyw67d66jsvLV347CArN8szWf2ZFhH6GtNme1pDI35j4zVKdMh6/2ziV25TfazTThSriZ9YVWEbkYRiKZJa76kj7UoOYb7VfhxCFQscn1aGg+VPFfEz8ZjLRn2XFENGgAvnQK2uzKhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCx3S0ih; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so123458f8f.3
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 16:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739492028; x=1740096828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxMg+gSpkmdUBF/RlfGs+PEtiXRFX4fG6A2zpI3rnDQ=;
        b=RCx3S0ihQjnSq3Q9yq50EbxRKCsQZpeC6AGclz5SoU+XJCQbJZbaNo76A05RevMT/N
         JYB4cOBfdQHnddCtxVOXXzTEKlMI37jtzXiVGAbCS3IqXoPd9k8RkYqLgBsNTS6vGpht
         vw6KCCRguG4DfvIMN3hw0QN1d0JCo7NmQJQtPWN0tbyZ4x4f4NRoKtwdNE6qByoSRFdU
         g5IexBLpHQaPtfX6p1vOK3nfU6mtmBxxSkqQSZGAw3doYmG42k2WQEugz9LEDWeADPt9
         xyFK0DHLaPs4rxzjqyeOYXFBcLD/Py3KrAf+dd/z+Ht6PlpSF01C3LUkTvZ2f5+C+bys
         Abfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739492028; x=1740096828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxMg+gSpkmdUBF/RlfGs+PEtiXRFX4fG6A2zpI3rnDQ=;
        b=c7Erx7u3IJuY7IkiR90dVkNBM2fD5IbaVKWyT4hPfw+uxSfU/83YKUYjuDPzbDHuWy
         oGSmmLsZUaAgSBs2zjeNE93e6G+w8Q8rb4Giag7zobIIczUuj74vjdWOiwHmetSUsf0n
         zX19UCxUGUbXH9XyZ9Qu8KNPQelqAEHgKfFT2KCKeibQetMxnTAC2AXbo8Js1gr0d0kQ
         iDAEEAvynUskKL5ujhLmgCM0V0vy4w1lzgihgOALptNrW3EcCz/x4yyzmxrnXcsBJTKY
         2Ffn8eZTSllrKOeVHa7Jc0DU8rRBUs9ODH0qRuRTO2aetJxjUzDBNTCZkKYANrmhOsk6
         Z0SA==
X-Gm-Message-State: AOJu0YxjfFcTgXOoeufmleSz9Zxn/kbPkdspJxjW3pqm0x9zZqTA+BiW
	DrrK1/r9mYFg4KMGkbiOHzXrHhwmGpK4KZRr5LTSIApFmk4qSypJp/h+zI6Elo0rVufhr/99cw+
	4m0Ue2ZXR2UYzNSJo3+18bVrtxxU=
X-Gm-Gg: ASbGncvzXPrG2P91RPz3TTwq7wOYmCg/laNOJ3kCTpzvPxKT6Nzha9C70jAFW4BYpIC
	7ds/cP54qxopg+1m1n03a3PFNlpM1YP5jDJ8fH1G8CxCRIuLcDk+pakFsug7vnivbMhi1KAeQo3
	xWNam7qJ0dpuoZf7yLy2gd4wws7RXq
X-Google-Smtp-Source: AGHT+IH2QHba4yXtElHA8d3zrkr4c1bG5/Wx0H+cAdD3v+0xuOUapaPO56+T+n6IRzHVi70VOPZ39phTrlGMrZH2SBE=
X-Received: by 2002:a5d:47aa:0:b0:38f:2297:66d6 with SMTP id
 ffacd0b85a97d-38f22976b68mr6785936f8f.52.1739492028302; Thu, 13 Feb 2025
 16:13:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com> <20250125111109.732718-11-houtao@huaweicloud.com>
In-Reply-To: <20250125111109.732718-11-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 16:13:37 -0800
X-Gm-Features: AWEUYZm0XrJL7isVF_eEQcLUM7Jsos4Ei3oKmeJDCz9wo6LzqLJIWWkv3NoFaHU
Message-ID: <CAADnVQLKcQtWM5e3sycn8fBpSvVa8Ly1fyE8J8BDPQZVE56Qxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/20] bpf: Introduce bpf_dynptr_user
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> For bpf map with dynptr key support, the userspace application will use
> bpf_dynptr_user to represent the bpf_dynptr in the map key and pass it
> to bpf syscall. The bpf syscall will copy from bpf_dynptr_user to
> construct a corresponding bpf_dynptr_kern object when the map key is an
> input argument, and copy to bpf_dynptr_user from a bpf_dynptr_kern
> object when the map key is an output argument.
>
> For now the size of bpf_dynptr_user must be the same as bpf_dynptr, but
> the last u32 field is not used, so make it a reserved field.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/uapi/linux/bpf.h       | 6 ++++++
>  tools/include/uapi/linux/bpf.h | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2acf9b3363717..7d96685513c55 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7335,6 +7335,12 @@ struct bpf_dynptr {
>         __u64 __opaque[2];
>  } __attribute__((aligned(8)));
>
> +struct bpf_dynptr_user {
> +       __bpf_md_ptr(void *, data);
> +       __u32 size;
> +       __u32 reserved;
> +} __attribute__((aligned(8)));

Pls add a comment explaining that bpf_dynptr_user is for user space only
and bpf progs should continue using bpf_dynptr.
May be give an example that to use bpf_dynptr in map key
the bpf prog should write:

+struct mixed_dynptr_key {
+ int id;
+ struct bpf_dynptr name;
+};

while to access that map the user space should write:

+struct id_dname_key {
+ int id;
+ struct bpf_dynptr_user name;
+};

tbh the api is kinda ugly, since in the past we always had user space
and bpf prog reuse the same struct names.
Here the top struct names have to be different,
but have to have the same layout.

Maybe let's try the following:
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6cdb8d11a..55d225961dbf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7335,7 +7335,14 @@ struct bpf_wq {
 } __attribute__((aligned(8)));

 struct bpf_dynptr {
+       union {
        __u64 __opaque[2];
+       struct {
+               __bpf_md_ptr(void *, data);
+               __u32 size;
+               __u32 reserved;
+       };
+       };
 } __attribute__((aligned(8)));

Then bpf prog and user space can use the same key type.

