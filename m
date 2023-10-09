Return-Path: <bpf+bounces-11743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE97BE716
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC891C209DD
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14791D682;
	Mon,  9 Oct 2023 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAD4q2dx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3F1A28A
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:56:47 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1365E9E
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:56:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-564b6276941so3469510a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696870606; x=1697475406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mjHa9MtzoCrZMbsVkxE71m/W2TgbkQOpL7P8bbISFw=;
        b=KAD4q2dxvXUlBoQTyEEXxe7GpBnncloL4+GdDtPw4tA9JMQ/ZQ4HYPLIEo54kRfCsp
         khNksQJ+e2AqeZKX9w4aMDWZNgHLVhaXlSaIclc/o6IffCse8h9LcMwLgQ440GxFAPJ0
         Yd9jcZCVTs/v5s2KQfBY9xEJZeQXaVLQ7nZpnp33oNunWZ5dPXX43vn+xFWf/S4KqmQL
         QJFSQ01Wdt5H2LE6IKBO5sNGEsXLMzSKBCx9cKn15qjHPqOzEUgsTtJEwtAc9viGehmW
         MWeKf55kgwJeuM+E6/4kYIxVTMSeQ5bMhyWifuo4usmlVhDyUUnHd62PE4EBXXaleCNv
         bWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870606; x=1697475406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mjHa9MtzoCrZMbsVkxE71m/W2TgbkQOpL7P8bbISFw=;
        b=g6/6ewoK0GbiidlGNaARK5NgvZtWl7n6cKjPMGxirBA99O4kFXUxbAYfru+fog3gFF
         yNrAu8sHFEesqbW5qNV8d6rlLDy2vmQ8CwA/GEYNsKpzpd2fCsVkpS8zllPXIs/xrz12
         JnoMMrcPwdSMVNmRmH/CjwWuPQw8qX/9CezEaRC+Gf4UJ30y7Sp89wMzUsCX7rJsefRE
         N/KxVtEL2rNQj05nZOC+AfXSipepJzDCCR47wbm13LFWBzZeNmcqainysYrZnvXxHPX/
         ud7ju/um5fvlNw9yxprnIVh80bHTFWZrQsgjKkax/uKAWgnl72JT3uJePOGNSstvNT77
         DkNw==
X-Gm-Message-State: AOJu0Yz1JNo8iv0sucek0ojheiOyGMF4FCO9N4I7uuAQqTcGNsvocOpu
	gxU7XHbHKjpW1qDO5Bp1ACg=
X-Google-Smtp-Source: AGHT+IEciPoNcqZA6nHVz1Gm7GLZY+VpGQiifsZk3/+rHEOkgN4Y3TpXu5+Ew64OjX2DexAXpSNM0w==
X-Received: by 2002:a17:90b:4a49:b0:277:3569:2a05 with SMTP id lb9-20020a17090b4a4900b0027735692a05mr13725965pjb.27.1696870606263;
        Mon, 09 Oct 2023 09:56:46 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:85e9])
        by smtp.gmail.com with ESMTPSA id gw3-20020a17090b0a4300b0027476c68cc3sm8670403pjb.22.2023.10.09.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:56:45 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:56:42 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 4/6] bpf: Move the declaration of
 __bpf_obj_drop_impl() to internal.h
Message-ID: <20231009165642.vhxucl2nqnolspnw@MacBook-Pro-49.local>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
 <20231007135106.3031284-5-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007135106.3031284-5-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 09:51:04PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> both syscall.c and helpers.c have the declaration of
> __bpf_obj_drop_impl(), so just move it to a common header file.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c  |  3 +--
>  kernel/bpf/internal.h | 11 +++++++++++
>  kernel/bpf/syscall.c  |  4 ++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
>  create mode 100644 kernel/bpf/internal.h
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dd1c69ee3375..07f49f8831c0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -24,6 +24,7 @@
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
>  
> +#include "internal.h"

Pls use one of the existing headers. No need for new one.

