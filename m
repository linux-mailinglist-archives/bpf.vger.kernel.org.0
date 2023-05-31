Return-Path: <bpf+bounces-1474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AAC7172AB
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 02:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0F280A74
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD07A5A;
	Wed, 31 May 2023 00:39:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B34A2C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 00:39:29 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D959116
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:38:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53202149ae2so3258065a12.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685493437; x=1688085437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnW0e0vniMuw+k7T7sg+iLHJVPD9BolK6QAe01V56tI=;
        b=eg1nzLTvipHJqcT+GwdefMo9o07b1fdn16DM3Wg5l+QbbgkYUjsVwNHzRBSsb6K4LU
         4SpIysSQWfotX6V1Yqd/efK5uJP9h2xQEfwvnrq2tmMcvYjRLLjH8EBAvT7WXDZEGR/J
         pRMdTPaZ4laCsofq+EBb8+QACoqPiyRBOk3jt8RUwFGfrwNE4BZ08P9OuwoSSV57x/3V
         bAR9DVSPOkk+A/iwIk9aDchfDp/MIAFxUH9d4PJVT9/PmSz2UxM07l+/Wo/D4r9MRlSZ
         W3EniAigrcHWHL8i4w4GdEPyeeQwwGdlpjogqLEwM3vkGfsELAi0lQN0rcRUHjh+gTHj
         y/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493437; x=1688085437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnW0e0vniMuw+k7T7sg+iLHJVPD9BolK6QAe01V56tI=;
        b=Pnfg/mMeRfUuUuXvqg3sKHpkxqBmuOqvnPi3JsHs7i1RDSNcleUaGoYGrio7mDLzEJ
         0LJFaiJH6YD9plxDi+HIf1t3uPnp0BJJbs7WB4CxSGUs3L9gFs7Zx4QUfd1cJNrBRgnY
         UMDUKsxc3KUGJ0y0fPopKbrGoy5k+SMJQekV3bklL0JEDGrw/qvbKGoUEwgGNHX1Tjsg
         cyzMwAawLc+goRE+mSkoIPussnTL9fSolGo24CKQIjA8LY0Diz3kmdEN2OCZW+qvl2Bi
         CMGIMgtD0EEHJaXNmlq2YyT/6HtppGVjftGTV6JvcFP9meJKbxuMVyEp5BzopHtw4OGh
         i0Ww==
X-Gm-Message-State: AC+VfDwtyDF8Kha3zy1dQcBkdOV8n9X5B44p5nOW9dWCztoVlfrRPSg3
	XShS2F95qJyWkOUhJJT83h8=
X-Google-Smtp-Source: ACHHUZ6UA4T0n0imYPb79IuWT/C3CaiLnMqEPuIBukPFPgCxQ4YK10+9SLdWFfJnx2hz31pmi2V6bQ==
X-Received: by 2002:a17:90b:3908:b0:256:48a5:4fd0 with SMTP id ob8-20020a17090b390800b0025648a54fd0mr4290862pjb.1.1685493436728;
        Tue, 30 May 2023 17:37:16 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d8f6])
        by smtp.gmail.com with ESMTPSA id om6-20020a17090b3a8600b0024df7d7c35esm9365605pjb.43.2023.05.30.17.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:37:16 -0700 (PDT)
Date: Tue, 30 May 2023 17:37:13 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, quentin@isovalent.com, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 7/8] bpf: Support ->fill_link_info for
 perf_event
Message-ID: <20230531003713.ml3gb76q4zurue3a@MacBook-Pro-8.local>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
 <20230528142027.5585-8-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528142027.5585-8-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, May 28, 2023 at 02:20:26PM +0000, Yafang Shao wrote:
> By adding support for ->fill_link_info to the perf_event link, users will
> be able to inspect it using `bpftool link show`. While users can currently
> access this information via `bpftool perf show`, consolidating the link
> information for all link types in one place would be more convenient.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  6 ++++++
>  kernel/bpf/syscall.c           | 46 ++++++++++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  6 ++++++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6be9b1d..1f2be1d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6438,6 +6438,12 @@ struct bpf_link_info {
>  			__aligned_u64 addrs;
>  			__u32 count;
>  		} kprobe_multi;
> +		struct {
> +			__aligned_u64 name;
> +			__aligned_u64 addr;

__aligned_u64 ? what is the reason?

> +			__u32 name_len;
> +			__u32 offset;
> +		} perf_event;
>  	};
>  } __attribute__((aligned(8)));
>  
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 33a72ec..b12707e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3329,10 +3329,56 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
>  	seq_printf(seq, "offset:\t%llu\n", probe_offset);
>  }
>  
> +static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
> +					struct bpf_link_info *info)
> +{
> +	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> +	char __user *ubuf = u64_to_user_ptr(info->perf_event.name);
> +	u32 ulen = info->perf_event.name_len;
> +	const struct perf_event *event;
> +	u64 probe_offset, probe_addr;
> +	u32 prog_id, fd_type;
> +	const char *buf;
> +	size_t len;
> +	int err;
> +
> +	if (!ulen ^ !ubuf)
> +		return -EINVAL;
> +	if (!ubuf)
> +		return 0;
> +
> +	event = perf_get_event(perf_link->perf_file);
> +	if (IS_ERR(event))
> +		return PTR_ERR(event);
> +
> +	err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
> +				      &buf, &probe_offset,
> +				      &probe_addr);
> +	if (err)
> +		return err;
> +
> +	len = strlen(buf);
> +	info->perf_event.name_len = len + 1;

this use of name_len contradicts with patch 8.
Is it 'in' or 'out' field?

> +	if (buf) {
> +		err = bpf_copy_to_user(ubuf, buf, ulen, len);
> +		if (err)
> +			return err;
> +	} else {
> +		char zero = '\0';
> +
> +		if (put_user(zero, ubuf))
> +			return -EFAULT;
> +	}
> +	info->perf_event.addr = probe_addr;
> +	info->perf_event.offset = probe_offset;
> +	return 0;
> +}
> +
>  static const struct bpf_link_ops bpf_perf_link_lops = {
>  	.release = bpf_perf_link_release,
>  	.dealloc = bpf_perf_link_dealloc,
>  	.show_fdinfo = bpf_perf_link_show_fdinfo,
> +	.fill_link_info = bpf_perf_link_fill_link_info,
>  };
>  
>  static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 6be9b1d..1f2be1d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6438,6 +6438,12 @@ struct bpf_link_info {
>  			__aligned_u64 addrs;
>  			__u32 count;
>  		} kprobe_multi;
> +		struct {
> +			__aligned_u64 name;
> +			__aligned_u64 addr;
> +			__u32 name_len;
> +			__u32 offset;
> +		} perf_event;
>  	};
>  } __attribute__((aligned(8)));
>  
> -- 
> 1.8.3.1
> 

