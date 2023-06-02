Return-Path: <bpf+bounces-1717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F57207E2
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDC71C211CE
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974E332F7;
	Fri,  2 Jun 2023 16:46:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9C332E8
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 16:46:01 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C16196
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 09:46:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b00f70e6b0so21844765ad.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685724360; x=1688316360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFj5V0rymfgtaP70Gg/ctg2KBCvMmdF4n7su9yaPnW0=;
        b=7VjSrCrVpqxb1v8Ry3Anl2mk1yh5HHDTI196s/Su2+qOsP1RrAS4NdeMULLIuPNO/k
         1znaVZo54W0ulb33TUMGRLKIPhqfhGMP1vht0ETozb+LCcE2YCXuMkriV2WSVU5C7HSa
         ljZ4fVMIbvU+fYI2qzjd9Kdne7U+RI+HdtifNCRvcjWzAn5vw0x7JHVhf6/siSuGU7VK
         2MKvZZ5qLNGcedDT+KX1IBjBD71JXT2xMPpT+87PpzuzbaEL3jqoTkx40lc/h2kQuYAp
         SWChZqVkG+qnALTlt6Vs1VOHAQfIW2mlyRW6czonDq2wh5jmOlJZG+ExaEnIhp+uqW/e
         553Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724360; x=1688316360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFj5V0rymfgtaP70Gg/ctg2KBCvMmdF4n7su9yaPnW0=;
        b=c0SWCQ+phjrBcSZ3X7gE1LDruPcJx37cRi5XVEZ32+3p0uj/ox/ZCVtKZotNO0uuoU
         wISAqjVQY+/oCkxrfRd2q1qaZmyfqxJYmjScz9zjqPcTIDXkUPL9DQ3166sJq5jsoisF
         Qet6rZDR6GisTupumWyXSB8jCdexPbF59+HaN8kEEe5b6LQhh2vkflcAMmny02/J4lZo
         CJkekW9MvIdFykUy76hPn3JZSj/SJqBU08fZUFkDraw0oGdsf7T/xR6bq36mEmVCmwYY
         vIz5fu1qNP1CJKwvBLFPuP2Zyt/6ePl0QwDc7AEX9/beiJI8M61jMC0RNmvGdnOUTUHu
         A4Bg==
X-Gm-Message-State: AC+VfDwrl4Ishwj4zVy0LrNyxeu2Jz42c6aJ98M7YzCLo0+NBbM4N3wf
	S3adrF8CymBcixcO+vltcQmlfVE=
X-Google-Smtp-Source: ACHHUZ5MTY8cH1jnKXkVUaL/WNWN1S4gsJAz2FOQUqKeMp507v19vobMVLpyRAVmo4jyzw7DqCMVRJw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:db86:b0:1b0:378e:2797 with SMTP id
 m6-20020a170902db8600b001b0378e2797mr110245pld.9.1685724359772; Fri, 02 Jun
 2023 09:45:59 -0700 (PDT)
Date: Fri, 2 Jun 2023 09:45:58 -0700
In-Reply-To: <20230602085239.91138-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230602085239.91138-1-laoar.shao@gmail.com> <20230602085239.91138-2-laoar.shao@gmail.com>
Message-ID: <ZHocxh+VsAR1kgI1@google.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Support ->fill_link_info for kprobe_multi
From: Stanislav Fomichev <sdf@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/02, Yafang Shao wrote:
> By adding support for ->fill_link_info to the kprobe_multi link, users will
> be able to inspect it using `bpftool link show`. This enhancement will
> expose both the count of probed functions and their respective addresses to
> the user.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  4 ++++
>  kernel/trace/bpf_trace.c       | 26 ++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a7b5e91..22c8168 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6438,6 +6438,10 @@ struct bpf_link_info {
>  			__s32 priority;
>  			__u32 flags;
>  		} netfilter;
> +		struct {
> +			__u64 addrs;
> +			__u32 count;
> +		} kprobe_multi;
>  	};
>  } __attribute__((aligned(8)));
>  
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2bc41e6..ec53bc9 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2548,9 +2548,35 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
>  	kfree(kmulti_link);
>  }
>  
> +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
> +						struct bpf_link_info *info)
> +{
> +	u64 *uaddrs = (u64 *)u64_to_user_ptr(info->kprobe_multi.addrs);

Maybe tag this as __user as well?

	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);

copy_to_user expects __user tagged memory, so most likely sparse tool
will complain on your current approach.

> +	struct bpf_kprobe_multi_link *kmulti_link;
> +	u32 ucount = info->kprobe_multi.count;
> +
> +	if (!uaddrs ^ !ucount)
> +		return -EINVAL;
> +
> +	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> +	if (!uaddrs) {
> +		info->kprobe_multi.count = kmulti_link->cnt;
> +		return 0;
> +	}
> +
> +	if (!ucount)
> +		return 0;
> +	if (ucount != kmulti_link->cnt)
> +		return -EINVAL;

[..]

> +	if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
> +		return -EFAULT;

I'm not super familiar with this part, so maybe stupid question:
do we need to hold any locks during the copy? IOW, can kmulti_link->addrs
be updated concurrently?

