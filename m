Return-Path: <bpf+bounces-2620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6F73151F
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 12:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3149D281482
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BEB8BEE;
	Thu, 15 Jun 2023 10:21:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021517F1
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 10:21:41 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A9ED;
	Thu, 15 Jun 2023 03:21:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f7b641f54cso1574387e87.2;
        Thu, 15 Jun 2023 03:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686824498; x=1689416498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYfUGAtFLEy4AdaRi/xYdh7AUMrCdai/RCLOQqmnomo=;
        b=ayziv03TS4myPi1TP2EfNiQKXdqLYK5cSpvAXb5JxS04KpH0iNf7GOle3dASscGrA2
         TlvA2V3GKfFtqSumrgPknKgytN18wqB4XQc79jzZbktBaC52PzrlrT8h0tn04eQz5oZp
         ruvkgjprRzkPNsM297rTEzUATufa72Fb6rrenGQIUOHROlb2NKvBuLNmcxUvUDA02mQS
         0UYQ4sdO8B5OQo7ZKNfCVq1Rg9N6yNnGdiCHyHTT/FgGSJJzkZlGxcQxpVbAFReuCJh5
         jLYfSDblAOdnq6OtXJjLPf6pOW6lV0Ptm1PM+S5CdbKcHwzrmGiyv42xeaOIFRJFx1dD
         auSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824498; x=1689416498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYfUGAtFLEy4AdaRi/xYdh7AUMrCdai/RCLOQqmnomo=;
        b=AkRPhjOdoRUR8dqCCQP192gE0t4vT8BHuR+YPvlZGADTYhjarEUFmmV9VmunSP+fB0
         nYD3sq1rugWSLyenPfpIZnqER2g8z0RWKQkI+6WkPV4kTKpiNVkSjBD9aZquP0uVjM6i
         BKgDEouLYlpL4ak/3qVepolCB826m8bT5ntlQa7B+lu1bo0i0k3ZkhxH3C1WQWs4RQtc
         LawLUyOEQXDvsE/QoDuSuFZLSq0Q5oW9OzlQh0SDC84O8BHZ/U0bcirkFMg/1tSkarjz
         bAI90ot2hNgjwC1UGqLT3V7crLjDl0QqM+0gUFXz4OiZM227n06Ry0kW7tV368o04Xfb
         MMrA==
X-Gm-Message-State: AC+VfDw3VeqH66yIr9c9zDdlt5JYol2BTMSGTFgb9n8mFyPXNqAJzXHe
	m56e9nswap/qq0KX58PNNbPH2590STmDNw==
X-Google-Smtp-Source: ACHHUZ4JAOxoZNWb0xA7kJxLSTRPo63fjUHpWXL6UfvVQM8H0EPyeBy1/ESPrGTPv/Wx2y43rhreWQ==
X-Received: by 2002:a19:2d17:0:b0:4f7:6b95:87e5 with SMTP id k23-20020a192d17000000b004f76b9587e5mr2007406lfj.9.1686824497460;
        Thu, 15 Jun 2023 03:21:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b0030fb4b55c13sm14510091wrs.96.2023.06.15.03.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:21:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Jun 2023 12:21:34 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for
 perf_event
Message-ID: <ZIrmLo9UH//V4sYP@krava>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-9-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612151608.99661-9-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 03:16:06PM +0000, Yafang Shao wrote:

SNIP

>  
>  /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 80c9ec0..fe354d5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3303,9 +3303,133 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
>  	kfree(perf_link);
>  }
>  
> +static int bpf_perf_link_fill_name(const struct perf_event *event,
> +				   char __user *uname, u32 ulen,
> +				   u64 *probe_offset, u64 *probe_addr,
> +				   u32 *fd_type)
> +{

this function name sounds misleading, it does query all the link data
plus copying the name.. seems like this should be renamed and separated


> +	const char *buf;
> +	u32 prog_id;
> +	size_t len;
> +	int err;
> +
> +	if (!ulen ^ !uname)
> +		return -EINVAL;
> +	if (!uname)
> +		return 0;
> +
> +	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
> +				      probe_offset, probe_addr);
> +	if (err)
> +		return err;
> +
> +	len = strlen(buf);
> +	if (buf) {
> +		err = bpf_copy_to_user(uname, buf, ulen, len);
> +		if (err)
> +			return err;
> +	} else {
> +		char zero = '\0';
> +
> +		if (put_user(zero, uname))
> +			return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +static int bpf_perf_link_fill_probe(const struct perf_event *event,
> +				    struct bpf_link_info *info)
> +{
> +	char __user *uname;
> +	u64 addr, offset;
> +	u32 ulen, type;
> +	int err;
> +
> +#ifdef CONFIG_KPROBE_EVENTS

this will break compilation when CONFIG_KPROBE_EVENTS or CONFIG_UPROBE_EVENTS
options are not defined

jirka

> +	if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE) {
> +		uname = u64_to_user_ptr(info->kprobe.func_name);
> +		ulen = info->kprobe.name_len;
> +		info->perf_link_type = BPF_PERF_LINK_KPROBE;
> +		err = bpf_perf_link_fill_name(event, uname, ulen, &offset,
> +					      &addr, &type);
> +		if (err)
> +			return err;
> +
> +		info->kprobe.offset = offset;
> +		if (type == BPF_FD_TYPE_KRETPROBE)
> +			info->kprobe.flags = 1;
> +		if (!kallsyms_show_value(current_cred()))
> +			return 0;
> +		info->kprobe.addr = addr;
> +		return 0;
> +	}
> +#endif
> +
> +#ifdef CONFIG_UPROBE_EVENTS
> +	if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE) {
> +		uname = u64_to_user_ptr(info->uprobe.file_name);
> +		ulen = info->uprobe.name_len;
> +		info->perf_link_type = BPF_PERF_LINK_UPROBE;
> +		err = bpf_perf_link_fill_name(event, uname, ulen, &offset,
> +					      &addr, &type);
> +		if (err)
> +			return err;
> +
> +		info->uprobe.offset = offset;
> +		if (type == BPF_FD_TYPE_URETPROBE)
> +			info->uprobe.flags = 1;
> +		return 0;
> +	}
> +#endif
> +
> +	return -EOPNOTSUPP;
> +}
> +

SNIP

