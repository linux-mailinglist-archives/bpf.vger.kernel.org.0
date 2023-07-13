Return-Path: <bpf+bounces-4977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E618D752DDE
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 01:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938C0281F26
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96163DF;
	Thu, 13 Jul 2023 23:17:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFF610C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 23:17:44 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFF171D;
	Thu, 13 Jul 2023 16:17:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9cd6a0051so8103025ad.1;
        Thu, 13 Jul 2023 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689290263; x=1691882263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BoriMCQh3dIag72cEJBFwbbsdk2p8pRWSnIKSZD1tr8=;
        b=VEFm2Lt71ugLRnwVFVQdTs0aWUB0AEYBc22YdK7fhIzPH5dwo3jSK23dnghF2D9nkL
         d//iwTcUajuJL4+oDNQdQGpKS1PrCWFBqfzGC8ARPrVYek4QRnPc6uGpGOq+SL6tdWAz
         u8d8dMqI67aNdfVTyOM5h2cr7qUpnPToEFa/jRmyH3yO9xtVprhlT1VmZWN8wsK/GcQ5
         GvadWEGkR/z5SbRoOM581xoZSJlP+5uN37tEHakuZq4I9rgNiWI7OPovpd8Qg7FmzRLj
         GN57DsqE8y6X+bb4sVWWfSx8UYFLFj4p4Qt8b+dtFGUZQmjYLxaW4CrefUUQ1TDotulE
         oI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689290263; x=1691882263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoriMCQh3dIag72cEJBFwbbsdk2p8pRWSnIKSZD1tr8=;
        b=T4SfnZwxKaCAf6400XQp9I9Atr6NvJphRfVuiORmu1SKlKQCYmzmvD0lKfGVTTh9E7
         ck9CYoB1+5ey2Eq7C4gHLJZ9+wIq4i7RWbK4EFxLs4eunJCGYgCBO34H7IkL76xmWbXn
         aTVMGfH5SPZ1OJFMSwbTfPq7foVCZQUiNm7qVEA7Pn1f0TUY6b4qcW2xPBA/hJ9XaPLm
         hpZ00HBGlpSXKvzehpGz1YvmByqxJiChwfY364s6vmD1QGsb8p86qZRiY4ZxlxFzQclY
         YvWJdQeJniWThmhq5mQaqDhMemhl2+6wCIrNt52zLiU4voiYnZZGS9rpd48O2iNRqGZO
         oP0A==
X-Gm-Message-State: ABy/qLbmxb/B5n9W8XLt0XbRinQcYVCVWHyHTrbc4UaLdkS1DGTK/3Aw
	plmudSQUTFclRivMJwuKyRw=
X-Google-Smtp-Source: APBJJlG0AFTEQ/fU47YZJfmSA+AyoM9o3thHPlygw+Y/jQBmjxC2gPEtjcdLFUhtSCSvvT/08wsi1w==
X-Received: by 2002:a17:902:d4cd:b0:1b8:21f:bcc2 with SMTP id o13-20020a170902d4cd00b001b8021fbcc2mr2732602plg.34.1689290263162;
        Thu, 13 Jul 2023 16:17:43 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902c38400b001b9be79729csm6443195plg.165.2023.07.13.16.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 16:17:42 -0700 (PDT)
Date: Thu, 13 Jul 2023 16:17:39 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH] bpf: Add support of skipping the current object for
 bpf_iter progs
Message-ID: <20230713231739.n3vtl4x36ezbovfl@MacBook-Pro-8.local>
References: <20230713051323.2867905-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713051323.2867905-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 01:13:23PM +0800, GONG, Ruiqi wrote:
> bpf_seq_read() can accept three different types of seq_ops->show()'s
> return value:
> 
>   err > 0: skip the obj and reuse seq_num
>   err < 0: abort the whole iter process
>   err == 0 (implicitly): continue
> 
> but bpf_iter_run_prog() is limited to the last two cases. Extend the
> legal return value of bpf_iter progs so that they can skip certain
> objects and then proceed to the followings.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> ---
>  kernel/bpf/bpf_iter.c | 9 +++++----
>  kernel/bpf/verifier.c | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 96856f130cbf..1c1d67ec466c 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -716,13 +716,14 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>  		rcu_read_unlock();
>  	}
>  
> -	/* bpf program can only return 0 or 1:
> -	 *  0 : okay
> -	 *  1 : retry the same object
> +	/* bpf program can return:
> +	 *  0 : has shown the object, go next
> +	 *  1 : has skipped the object, go next
> +	 * -1 : encountered error and should terminate
>  	 * The bpf_iter_run_prog() return value
>  	 * will be seq_ops->show() return value.
>  	 */
> -	return ret == 0 ? 0 : -EAGAIN;
> +	return ret == 0 ? 0 : (ret == 1 ? 1 : -EAGAIN);

This breaks existing progs as you can see in CI
and you surely would have noticed if you run the selftests.

We're going to start auto rejecting patches without selftests and
those that break CI.
It's your job to test your patches.

