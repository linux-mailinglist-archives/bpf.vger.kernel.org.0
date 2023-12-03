Return-Path: <bpf+bounces-16547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D150802667
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 19:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93CF1F20FC2
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833117993;
	Sun,  3 Dec 2023 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHCusd2F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC2DA
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 10:57:28 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d597d333aso8747945ab.1
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701629847; x=1702234647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrKgnoVXQsshyHlB7j2gCK3UlcQL9eYWwC2VP5ShIXU=;
        b=GHCusd2FOkhuDYpuKZD1lMbVj8rY6ZdIV1POHyDbhDtRnz+3lu9dduMsRWwq78FmEP
         nt3ncbTCiaqQvmv366YrdOA1KrzE2siv2PqBL1kv/675fCAHZB3J1H52EuDFcRbjISn4
         3gxDjI7kG8GZkm4uQN1vhdw2RkRpzjNI2sA8beMgmwCQ2dM7lyY1ejiwiACTTJtJzxZA
         CP+z0kMO4jZCoSO/RFTdYzpvYrhntuA8pyyBaUQvXEKLXjZODOXBR9fr1d14z4LqFtMU
         e5FJBwG0zKLYoHlAirhmbDl5E0RTtUJ6/Tr79xl9rX9lh7cPcvp4xUE+HvmHUPUaDmLl
         n05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701629847; x=1702234647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrKgnoVXQsshyHlB7j2gCK3UlcQL9eYWwC2VP5ShIXU=;
        b=sGhwJbb5oK6XjjO7u+9t/VMjrzgaFWDg+Z62mLfMQl0SqCQmrkFR6r/jt/SFlmzjdY
         A9K+joVRHNquf61KpTl3FZnmozqXC3QBBFvfIPpvC/5zPtEqGKQl+JXdQGIOJOH5Wcl4
         ZD8/HsPOZ3i+2Z+069G8y2XBee9XRA+4DcsHueK0fDsbfvJYBlMcUubcMg3uvJ/G7/y6
         JnUoxHipNjYQhq77Z+L0E7ypcYMbnIMiZ9htZU9rXjgyeWZ6YZTmB5zSObTxnHHiZGn7
         9O0hxXSdrfgEwzGSUSMdjfxxhUozmlAcG9z7aP9uj96H25zD4t0gDORHOeL/kWAkizeG
         DTzw==
X-Gm-Message-State: AOJu0Yx7WbrM1J2aBU6GVKHr7iBfaqxXwg7GDXAgeMS7NoxYRX4YTa0s
	c7e9fQob/ObFiu1xTfFz9IjcsbPxHPI=
X-Google-Smtp-Source: AGHT+IFbB63fbKCDIHG6K6mAx8i+Gy4oeNoxFGP06jOg0IOTi0Fulnp0dtRr4FWZWuLceHRDkN15OA==
X-Received: by 2002:a05:6e02:cc2:b0:35d:5f75:3651 with SMTP id c2-20020a056e020cc200b0035d5f753651mr3255288ilj.51.1701629847473;
        Sun, 03 Dec 2023 10:57:27 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:e741])
        by smtp.gmail.com with ESMTPSA id x21-20020a63b215000000b005c2422a1171sm475207pge.66.2023.12.03.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 10:57:27 -0800 (PST)
Date: Sun, 3 Dec 2023 10:57:24 -0800
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
Subject: Re: [PATCH bpf v4 3/7] bpf: Set need_defer as false when clearing fd
 array during map free
Message-ID: <20231203185724.6a2kpsmesavozsrc@macbook-pro-49.dhcp.thefacebook.com>
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
 <20231130140120.1736235-4-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130140120.1736235-4-houtao@huaweicloud.com>

On Thu, Nov 30, 2023 at 10:01:16PM +0800, Hou Tao wrote:
>  
> -static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
> +static long fd_array_map_delete_elem_with_deferred_free(struct bpf_map *map, void *key,
> +							bool need_defer)

way too verbose.
Tomorrow we will add another bool and would have to rename it?
Just use __fd_array_map_delete_elem().

