Return-Path: <bpf+bounces-1380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23C7149B3
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 14:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B61C20978
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3EF6FD2;
	Mon, 29 May 2023 12:50:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0843D60
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 12:50:28 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E8AED
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 05:49:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so5283549a12.0
        for <bpf@vger.kernel.org>; Mon, 29 May 2023 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685364596; x=1687956596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXhIToIvs9b3wNZ/eEvU1VbvtdqdAzwz9bOq0zDDmrc=;
        b=Pv/VyVyK9lYBYqlxNAOJTFwJ3/LZPVJOWs7qs3J8V/hxGU/mJ+b50RpSFvV70c/1Gc
         L0VdKS2Jc5le63QyVA0g+eRRnTTsLT+j0brDKqH1TIbwIHtrVLRNl/r+e/YtF1tcTA0z
         +3dT1nxe21YhmjXBQLk1tGS8wJxViWOrD2mNeRnzw9ldKiPpbn734vf/reuHEN3bUrYb
         AweBqJT3OZXkLt7NPDM5Qx04UKewaGz8eM2Hp4DeCR+LMtncTlc/qsTUV4tvnaxoEvB7
         h2LVaVN0YzUidiVprXcGIm+08YWTAZT4M0a9EapQ2G4CknO048nn/BeuCd0JpWIjB23k
         8cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685364596; x=1687956596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXhIToIvs9b3wNZ/eEvU1VbvtdqdAzwz9bOq0zDDmrc=;
        b=GA9w6p9gZkhNKbbhqyqWlaCQaZFjKb4OdwUGHfA33x17JbM7QqXY3IUEXmj41uevUs
         okJh4eTGBVm3M+b4/bBokNgXRzHxKyNeAlWUvDgYk3Kf8Ie2igCrlFoQWn7IA7vU/iJM
         bfMAnTxk/eN93mpMdglYd32DHzAUZVRcXnGxmjvvljUWXBqznNtRpGONIFRVg8VJpTeF
         IhowxNLadYBC0hBLiaBJ/Eqi9jBoe438HYu0ZXvz1CbVx42ZcN7o3SNX1mH8v2hbmVB1
         K43sNEjXMrVMCYDEpoHu3udeiaznEH7hkYXXmera1bXbf5td98UZrFbHmfO4oAAlEN/J
         QQ6Q==
X-Gm-Message-State: AC+VfDy1JgvBHObUvPtiqpH67UHqgLRfmYDA+YBODg4LddhzymzRmb8b
	SW/dHwsD42He5kDw4cw0Wzw=
X-Google-Smtp-Source: ACHHUZ7+NoGGYADPjnDdTIP8z+U3xQzwypqjrRFqGi0of/DxkcSoY7geAqVXTGfQllbgqxWXZwwnGw==
X-Received: by 2002:aa7:dccd:0:b0:50d:f9b1:6918 with SMTP id w13-20020aa7dccd000000b0050df9b16918mr8624613edu.9.1685364596468;
        Mon, 29 May 2023 05:49:56 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i8-20020aa7c708000000b00514a5f7a145sm344851edq.37.2023.05.29.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 05:49:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 May 2023 14:49:53 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	quentin@isovalent.com, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 2/8] bpf: Support ->fill_link_info for
 kprobe_multi
Message-ID: <ZHSfcabMuoy17ill@krava>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
 <20230528142027.5585-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528142027.5585-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, May 28, 2023 at 02:20:21PM +0000, Yafang Shao wrote:

SNIP

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0d84a7a..00a0009 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2564,10 +2564,41 @@ static void bpf_kprobe_multi_link_show_fdinfo(const struct bpf_link *link,
>  	}
>  }
>  
> +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
> +						struct bpf_link_info *info)
> +{
> +	struct bpf_kprobe_multi_link *kmulti_link;
> +	u64 *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
> +	u32 ucount = info->kprobe_multi.count;
> +	int i;
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
> +
> +	if (ucount != kmulti_link->cnt)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ucount; i++)
> +		if (copy_to_user(uaddrs + i, kmulti_link->addrs + i,
> +				 sizeof(u64)))
> +			return -EFAULT;

let's use put_user instead copy_to_user? or even better why not
copy that with single copy_to_user from kmulti_link->addrs

jirka

> +	return 0;
> +}
> +
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>  	.release = bpf_kprobe_multi_link_release,
>  	.dealloc = bpf_kprobe_multi_link_dealloc,
>  	.show_fdinfo = bpf_kprobe_multi_link_show_fdinfo,
> +	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
>  };
>  
>  static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 9273c65..6be9b1d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6434,6 +6434,10 @@ struct bpf_link_info {
>  			__s32 priority;
>  			__u32 flags;
>  		} netfilter;
> +		struct {
> +			__aligned_u64 addrs;
> +			__u32 count;
> +		} kprobe_multi;
>  	};
>  } __attribute__((aligned(8)));
>  
> -- 
> 1.8.3.1
> 

