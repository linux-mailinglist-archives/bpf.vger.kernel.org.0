Return-Path: <bpf+bounces-53462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51CA54631
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 10:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254591715A5
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE212080F6;
	Thu,  6 Mar 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYqeTmBK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFB19CCFC
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253063; cv=none; b=ZWtQkldVYGi1nyFlXvBFqLU/kVa18xz17LufYOl/to50Or0fBWVekwgwaIE3X6L2RW5Mua6hQe8ARCPCZUEv2S7qXS2XmuxU8ZJIZRZ8Udgodx3EM/CIh/X6oA+Rqo+U/oIoOee0zTpYvn2oq+20fvpVD1dyhH8+ASir8pCjgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253063; c=relaxed/simple;
	bh=i6EiXA6oGDxClIY8H6dgarmKDVgXj9zrewogpTz/fvc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIvEhZSQbTEKY/vE/MzuqjeYXjt4FF0lqDM9RvbQFLsr/UMfSC7GX+mnoNB98EyHrBqfPvoKPXRZ5hQInz7kDq4lb69VZYWGk7JKpl5T2AtTrlxbmg9M/1wUDTH3/9ClY3kOWCKg5NY7tWOrVnAUBCs09mm/64c3PBQwcWEZldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYqeTmBK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf4cebb04dso88533866b.0
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741253058; x=1741857858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjTFAfLKAOUrw9sr3155PQx09/ZSnsM7lGH6DjCSNRg=;
        b=EYqeTmBKFiygJIoOfbz9pItxu6q+Q0wq7ulWr8dpORVLYuNdb6SivDlYo1zNdIqXuS
         y1PqY6mrj5SVBBNAAPIPxmejg9+LawxB62HnlGs7QjcIpiFMdvOwnN4k1DsQwzimhWPn
         yYYjTurbVJz+HNuJhrCNyir7MT0kYKi64+XXu8VR6m6yKHvsgmQVMCH1uRvNYbkDbULa
         kOKUQRGNuexGB6FEKxnXX9vq7CDFCFdWlqJ2Y0GVZsH/k5dZEtXt09QwAGkzNL0gcTPA
         I/MsZDWpQBsOmbbZOXl9Jm6wGgVBFg0dP9yjmueixItcJqzGQ8NShpr5NEsgRog7Vha3
         IVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253058; x=1741857858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjTFAfLKAOUrw9sr3155PQx09/ZSnsM7lGH6DjCSNRg=;
        b=ffpZn/WnI7TeLG8NUpBcO/ap3PV+DbsAw+6PUVO3TRTJ6v+mx1ivTzQvg/9JHtv4yh
         +iHZ9MOwD2pduHv1e4Vht9twplkGciPYQInlh2OQVCwu4Zn6RI/qKqHGo+Ftv1FRoNmG
         8wH4tpoPp9rgXynPD73tcwJcAgly2VV7KPoj0CPiAC7qMaXBgbNkrVuKHGkuIKsM9Zlt
         6+lrGfVhdxknjaYy+TdZA4wkvqrT1QXoj4Afhd/Ce8+MNgv8sLwxqZdbG0xz5xyZrqD0
         RqSECvG97+SdoHqZOWyo0PcQQAdfhZk5dz+QgEBmvQW/i6gltptkanrgRgybcatClBfK
         yhqg==
X-Gm-Message-State: AOJu0YwbA7ljbwfBIyCa4i2RcI6B3oLSPN0B4H+Wtih3JB8hjL5iu7Ak
	5YqA1OSw5qHaJMq/DE2QeRMNiQCrMX8H1/lB4BaLtn8QKwczN5Xg
X-Gm-Gg: ASbGncsTN0CMfJUKKHgZV5QJ6OhpJqKZz4k+tJj+QKWfLHPRXhz+KGAc3/WKY+KjmW1
	3WbsDea1FryfNGfOUw2YPAqVX+rCAJVvuIzsRiEkV9/2TH6rFez+Ia0WOURIixlwr0aC8pPC7WV
	xvToJXJDlQcQ4UlardsOju82DgoV09yvd0x+GdwtXiDFStpgsIGorl+Co2tHEsZFFjyUxvtJoUj
	HxniZgwmhq+JwPmWTYfrKcWTLLmZM6v15yNHbZULPFlXv7mj+/QdEyfIoEz9x+BsYDo/A9d8uSC
	smR7QS8gA8p1a12SNHh8uJ8CCUJo77s=
X-Google-Smtp-Source: AGHT+IGuZVrERQ+7MYBAUE/gxpWMbaNyRo5OCg+LhxIVz8AlxjVCWHvKSxK3UIWSDtTsHTKVkQDjCQ==
X-Received: by 2002:a17:907:d24:b0:ac1:e45f:9c71 with SMTP id a640c23a62f3a-ac22caa102emr181451166b.1.1741253058039;
        Thu, 06 Mar 2025 01:24:18 -0800 (PST)
Received: from krava ([173.38.220.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394825efsm62758066b.45.2025.03.06.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:24:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 6 Mar 2025 10:24:15 +0100
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: BPF token support for
 BPF_BTF_GET_FD_BY_ID
Message-ID: <Z8lpv0deXTc3J7QN@krava>
References: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
 <20250305194942.123191-2-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305194942.123191-2-mykyta.yatsenko5@gmail.com>

On Wed, Mar 05, 2025 at 07:49:39PM +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
> allow running it from user namespace. This creates a problem when
> freplace program running from user namespace needs to query target
> program BTF.
> This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
> support for BPF token that can be passed in attributes to syscall.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/uapi/linux/bpf.h                                 | 1 +
>  kernel/bpf/syscall.c                                     | 9 +++++++--
>  tools/include/uapi/linux/bpf.h                           | 1 +
>  .../selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c  | 3 +--
>  4 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bb37897c0393..73c23daacabf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1652,6 +1652,7 @@ union bpf_attr {
>  		};
>  		__u32		next_id;
>  		__u32		open_flags;
> +		__s32		token_fd;
>  	};
>  
>  	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 57a438706215..6975d391bb05 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5137,14 +5137,19 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
>  	return btf_new_fd(attr, uattr, uattr_size);
>  }
>  
> -#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
> +#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
>  
>  static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
>  {
> +	struct bpf_token *token = NULL;
> +
>  	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
>  		return -EINVAL;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (attr->open_flags & BPF_F_TOKEN_FD)
> +		token = bpf_token_get_from_fd(attr->token_fd);

hi,
I think you need to check token in here with IS_ERR(token)
and call bpf_token_allow_cmd

> +
> +	if (!bpf_token_capable(token, CAP_SYS_ADMIN))

and bpf_token_put in here

jirka

>  		return -EPERM;
>  
>  	return btf_get_fd_by_id(attr->btf_id);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index bb37897c0393..73c23daacabf 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1652,6 +1652,7 @@ union bpf_attr {
>  		};
>  		__u32		next_id;
>  		__u32		open_flags;
> +		__s32		token_fd;
>  	};
>  
>  	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> index a3f238f51d05..976ff38a6d43 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
> @@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
>  	if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
>  		goto close_prog;
>  
> -	/* BTF get fd with opts set should not work (no kernel support). */
>  	ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
> -	ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
> +	ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
>  
>  close_prog:
>  	if (fd >= 0)
> -- 
> 2.48.1
> 
> 

