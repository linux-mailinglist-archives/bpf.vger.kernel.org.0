Return-Path: <bpf+bounces-16549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B280267F
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE604B20A1F
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E33179A6;
	Sun,  3 Dec 2023 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzUCkOmp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B26A1
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 11:04:15 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1898748a12.2
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701630254; x=1702235054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEbfCY8vD6iA2F/xfGfdbUjs657E7iNnhQC01c28xhY=;
        b=GzUCkOmpF/18TT/e0OD3uPTY7hoCkvE3mMUmB+HGlZUJlZ7ZO10Wfu01Nmuu7unySC
         8H1kkH2KCiTtPghez5aNoCXUcyVD2m1pgsuMCCEyy8Ysn6MuZWIalKHCmZioopFRbJSs
         SO6uEpJf4343/7DlrK7fyk6BypZgR+fSFuSboZ9k4i8ylgww1ipz+A3lx4v/ZBGGw8jQ
         BGrkG6Q7sxZvG7cP+buoyqRFI8pEDUPd0/KNRe8tBeEHCK1LG8RcsULaeFi5c7+u+eQ8
         J1ivtiovLmfmqpSwO/jKRsmlykvplFe1SanXNRotLPeFdSz1zoK4IvTlI+2nC4rhOKCi
         ANvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701630254; x=1702235054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEbfCY8vD6iA2F/xfGfdbUjs657E7iNnhQC01c28xhY=;
        b=w49Bj1y889lZTALXQKsFTerQdwxRxpPuW0ejYfjPB4o2wIgOzTAl4cSOlUfoLw0tWL
         xiBs5Y8b7meQuNouTk20rtCZBOV+QDGhcCeKOiKIG6GosJPXWRdD1c1ChSyxxCjLEStb
         RyZZoUY9Pw2XR20ixWB6ae447B86jd+AqGvLX1JjkYx2Bpjl48jkathCyq5fvHD2ON9h
         fllZE0hh/2cbM3UYhWTup0+DRvCLPm7g7a8OyFdmDCsIeqxIu8r9NiCqSK/h3DFKQQDy
         wXr81AE+c6JG5o74jilcuNcXC/hsdmU2oJa8WWIxjsJ3c13UCjDTEGylHs0zn/lidLTC
         7nkQ==
X-Gm-Message-State: AOJu0YzR2zZi4c3UjVMyPir2IDyd1B0QpytlCAZ6cSUhLmXIkyH+NKtz
	F0S9RHSgWkXL+JJmCqnolxo=
X-Google-Smtp-Source: AGHT+IHUYDzsbyUP9Wpxm6mcheJCvQK+JVs77cLD7ng7PYj7Oa0sQCUm2ePZklKrfx5l/sGh+5Oxsw==
X-Received: by 2002:a17:902:7485:b0:1cf:a2aa:23ae with SMTP id h5-20020a170902748500b001cfa2aa23aemr3024208pll.35.1701630254431;
        Sun, 03 Dec 2023 11:04:14 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:e741])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001d060d6cde0sm4255406plb.162.2023.12.03.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:04:14 -0800 (PST)
Date: Sun, 3 Dec 2023 11:04:10 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: Re: [PATCH bpf v4 7/7] selftests/bpf: Test outer map update
 operations in syscall program
Message-ID: <20231203190410.qcyu3qmdkxavim2t@macbook-pro-49.dhcp.thefacebook.com>
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
 <20231130140120.1736235-8-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130140120.1736235-8-houtao@huaweicloud.com>

On Thu, Nov 30, 2023 at 10:01:20PM +0800, Hou Tao wrote:
>  
> -	prog_load_attr.license = (long) license;
> -	prog_load_attr.insns = (long) insns;
> +	prog_load_attr.license = (unsigned long)license;
> +	prog_load_attr.insns = (unsigned long)insns;

Maybes keep it as (long) ?
There are plenty of case where we cast a pointer to (long) because
it's less verbose. Signedness shouldn't really matter.
Or use ptr_to_u64().

pw-bot: cr

