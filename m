Return-Path: <bpf+bounces-1379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C75714910
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 14:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB601C209C7
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712EA6FD3;
	Mon, 29 May 2023 12:06:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FC6FA1
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 12:06:45 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD75A3
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 05:06:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f53c06babso584904266b.3
        for <bpf@vger.kernel.org>; Mon, 29 May 2023 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685362002; x=1687954002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnjUJaers+7q37vV4Pl3tP7CbiByY2npGSrUQq+R524=;
        b=PODONR+KoJyzik6QMCC3BpVr6691TFfacNZij2kKUg9Qwmhbq7dQ4aHDYO/r6SnMuF
         /2f60Q+0baP9+HRAhvbSmAAoJUp1mUx0JmnKWyYHwg/MGR1Z1MlJbFPXiV/XwUNafKK6
         OmjHN4v1pK1mZVgZ8mQunFzQJ59uGkhouCrTwc3DyJiQ9uh0Y686lKtEGnK+vRIz8WZC
         sJDr/3kzjnEabLUtkajnc3DCtSek2IX+QpjeV8sMRbr+ks0F3BqHYbC1ftqHQHP8blvd
         3c1IZXbRwZ7bjkLFqVy2vxgsRlqSkOgYRH0WeulyyfIEWtV32CZX0uCCQIo6WiiPxw+6
         EvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685362002; x=1687954002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnjUJaers+7q37vV4Pl3tP7CbiByY2npGSrUQq+R524=;
        b=Rm/gnaNG3AnKyrkbH9HVQD3f+onOOb9CdsBbC/mCRFihlcTGu3xKaAH3IW2SuGDOec
         HO0nMkHIxs1iPAAJcyb/yst77GYKysDDJ3kQxRUh/G09nkSAdKIejcxXWiBk72qEUSas
         5gAs8KKnoW9vpx8de2Dl4pt7vO6NMTX/LaW+ZgvrmPNCPSx54CxLyXEJqUyJFBdMx0UY
         Tk+87wvlZM4zzoBONK9pRB5LVvxAIo0VyXg76b3IOkMgwiAvupZslxskGVVcClDkgkuK
         uxbYQyRF+EBPmOSsefoyH6JllRzj/aRsGu43HSpBfCaFAcHKILM8mDTa2DObYNObHG7j
         48Xg==
X-Gm-Message-State: AC+VfDzjHqEnH9XMHchhL8VFMAl7jt/FFSaMkvW7Gd2SViF/35wVbcFw
	71p2UiuFouAMkruFVc22ilI=
X-Google-Smtp-Source: ACHHUZ7KBiTi5AiDDBbwknQtg9rcJybWFr1TTuCOHiuwCyXt/vZ3tWEw5G2yhkDR619ZLgdGINq8Lw==
X-Received: by 2002:a17:907:6e10:b0:96f:f6a6:58dd with SMTP id sd16-20020a1709076e1000b0096ff6a658ddmr11114084ejc.5.1685362001635;
        Mon, 29 May 2023 05:06:41 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id gx25-20020a170906f1d900b0096b55be592asm5836447ejb.92.2023.05.29.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 05:06:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 May 2023 14:06:33 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	quentin@isovalent.com, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/8] bpf: Support ->show_fdinfo for
 kprobe_multi
Message-ID: <ZHSVSWph86bmJyvY@krava>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
 <20230528142027.5585-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528142027.5585-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, May 28, 2023 at 02:20:20PM +0000, Yafang Shao wrote:
> Currently, there is no way to check which functions are attached to a
> kprobe_multi link, causing confusion for users. It is important that we
> provide a means to expose these functions. The expected result is as follows,
> 
> $ cat /proc/10936/fdinfo/9
> pos:    0
> flags:  02000000
> mnt_id: 15
> ino:    2094
> link_type:      kprobe_multi
> link_id:        2
> prog_tag:       a04f5eef06a7f555
> prog_id:        11
> func_count:     4
> func_addrs:     ffffffffaad475c0
>                 ffffffffaad47600
>                 ffffffffaad47640
>                 ffffffffaad47680

I like the idea of exposing this through the link_info syscall,
but I'm bit concerned of potentially dumping thousands of addresses
through fdinfo file, because I always thought of fdinfo as brief
file info, but that might be just my problem ;-)

jirka

> 
> $ cat /proc/10936/fdinfo/9 | grep "func_addrs" -A 4 | \
>   awk '{ if (NR ==1) {print $2} else {print $1}}' | \
>   awk '{"grep " $1 " /proc/kallsyms"| getline f; print f}'
> ffffffffaad475c0 T schedule_timeout_interruptible
> ffffffffaad47600 T schedule_timeout_killable
> ffffffffaad47640 T schedule_timeout_uninterruptible
> ffffffffaad47680 T schedule_timeout_idle
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/trace/bpf_trace.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2bc41e6..0d84a7a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2548,9 +2548,26 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
>  	kfree(kmulti_link);
>  }
>  
> +static void bpf_kprobe_multi_link_show_fdinfo(const struct bpf_link *link,
> +				      struct seq_file *seq)
> +{
> +	struct bpf_kprobe_multi_link *kmulti_link;
> +	int i;
> +
> +	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> +	seq_printf(seq, "func_count:\t%d\n", kmulti_link->cnt);
> +	for (i = 0; i < kmulti_link->cnt; i++) {
> +		if (i == 0)
> +			seq_printf(seq, "func_addrs:\t%lx\n", kmulti_link->addrs[i]);
> +		else
> +			seq_printf(seq, "           \t%lx\n", kmulti_link->addrs[i]);
> +	}
> +}
> +
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>  	.release = bpf_kprobe_multi_link_release,
>  	.dealloc = bpf_kprobe_multi_link_dealloc,
> +	.show_fdinfo = bpf_kprobe_multi_link_show_fdinfo,
>  };
>  
>  static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
> -- 
> 1.8.3.1
> 

