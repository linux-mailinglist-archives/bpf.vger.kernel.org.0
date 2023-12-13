Return-Path: <bpf+bounces-17679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8CE8114F6
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 15:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C4C1F217C6
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE982EAF0;
	Wed, 13 Dec 2023 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfYSxQ+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C52A107
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 06:42:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3333074512bso4316680f8f.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702478577; x=1703083377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1D48PmyDU57BnvteW+2DMHkPsLC5AuueYRA9szisZp4=;
        b=TfYSxQ+wulCN/Pes0bDNloCGGPLeHxuOJK74QfRTOFV7pYoliBnxF9duUeJ2Pyb/Fy
         cMdp+kdkqeBfuWl/O+2boWoUk8MDruTcswbZTM4XRmePesk02KLk9rUmZnvZyC0c175f
         44jgWU8lrT7dplsk9ufSiiYCzmqbPMew77oQOWvuL6BDJgbOBQgNzbD7DKCFx/54ss7w
         ILrL7otyY+bVMiVYm9Mno1qnGPnXOvtHgYW8Btg9apcXr8VnyHQyixAAFZwAhPgllqor
         MJ50KcP3tLcqEie4otXLfGec4UrmNLQPZYCzQ2uj2bBxMg/YOSKaKtBJ9TwABFGIHc0X
         SEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478577; x=1703083377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D48PmyDU57BnvteW+2DMHkPsLC5AuueYRA9szisZp4=;
        b=uksM55LUrpNRe8WCrwDAQ8cwFKXHJXxOmcXD4jqzk7XVNWidyOgL+rLybZAX/W6DT6
         M/7wNtwkXBso8FQIWhRRy8xYhQjFnObVvR5XkIUluya2nyTWKn2QuGKSkWxk8xf0NKmt
         1kaLBKKC6fNKSQIctsQKyWEFolB3KtK+hwziM8eWEdruhG6d4ks9n6fPm3i2w5Jv928a
         CsPYF4ad5HosQRZYODg7DPeJwwFhvl6mpIIK6HkzmXZENcV9tM1z6WBeGtpZA3IlL7kN
         VucrPbtL6aBNLvBByM40N+FX4sKvXOxQE0X+82GDO7woZ8eVlEYCe0nJAGqNbQchPBbO
         EIiA==
X-Gm-Message-State: AOJu0YxvpR0HOb6HCrkMVk1biGNqv+8v5hKY7RW0tduGPltgXXMbSk0F
	vxCdAFW2k67C2EUhUNZ+OSg=
X-Google-Smtp-Source: AGHT+IFPn8xNtPw/tBf97Xex+G2whzSIOFBCm5vySe0qRyCBlRq6eNWxvPcaB0vSIySwP1RYcdloWg==
X-Received: by 2002:a05:600c:3381:b0:40b:5e4a:2360 with SMTP id o1-20020a05600c338100b0040b5e4a2360mr4562332wmp.98.1702478577279;
        Wed, 13 Dec 2023 06:42:57 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb44000000b003362d0eefd3sm4097425wrs.20.2023.12.13.06.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:42:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 Dec 2023 15:42:54 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next v2 0/4] bpf: Fix warnings in kvmalloc_node()
Message-ID: <ZXnC7iCNL4K9J_9R@krava>
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213112531.3775079-1-houtao@huaweicloud.com>

On Wed, Dec 13, 2023 at 07:25:27PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set aims to fix the warnings in kvmalloc_node() when passing
> an abnormally big cnt during multiple kprobes/uprobes attachment.
> 
> Patch #1 and #2 fix the warning by limiting the maximal number of
> uprobes/kprobes. Patch #3 and #4 add tests to ensure these warnings are
> fixed.
> 
> Please see individual patches for more details. Comments are always
> welcome.
> 
> Change Log:
> v2:
>   * limit the number of uprobes/kprobes instead of suppressing the
>     out-of-memory warning message (Alexei)
>   * provide a faked non-zero offsets to simplify the multiple uprobe
>     test (Jiri)
> 
> v1: https://lore.kernel.org/bpf/20231211112843.4147157-1-houtao@huaweicloud.com/
>   
> Hou Tao (4):
>   bpf: Limit the number of uprobes when attaching program to multiple
>     uprobes
>   bpf: Limit the number of kprobes when attaching program to multiple
>     kprobes
>   selftests/bpf: Add test for abnormal cnt during multi-uprobe
>     attachment
>   selftests/bpf: Add test for abnormal cnt during multi-kprobe
>     attachment
> 
>  kernel/trace/bpf_trace.c                      |  7 ++--
>  .../bpf/prog_tests/kprobe_multi_test.c        | 14 ++++++++
>  .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++++++-
>  3 files changed, 51 insertions(+), 3 deletions(-)

with one minor comment, for the patchset

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> -- 
> 2.29.2
> 

