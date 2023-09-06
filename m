Return-Path: <bpf+bounces-9371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308EB794454
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 22:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79A9281445
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E811C9A;
	Wed,  6 Sep 2023 20:13:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FB6AB3
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 20:13:43 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6219A6;
	Wed,  6 Sep 2023 13:13:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0c6d4d650so1895075ad.0;
        Wed, 06 Sep 2023 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694031222; x=1694636022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rg5DjKI/9NLJunvSSGRemhG/m4wH99s/gp8Mx1+uNl8=;
        b=ZVLZpxEAl/DpmTVAYahTXjvFETUSynPwjQS/2HiyHER1ND9Kf+p7vXJesSR6mbAglx
         ohi+5+lKhL8nPJoc35f3sye7yzuKvJkKgtr/u9m7JVcqRtWb8BoZP3OmrXDseu+t41LP
         vqha3/Zw8Om8lxmnOdZ8VIAW0lH/yPMZ9xL6dbwibaLeiDT0eWS2R+l9Eg0wETspxyT9
         S/HboTUAN/8U56UR7rCkOBF+FKrwOXKXB1S42Qtnei9p47vpQOVP/1OrM/UZd2+BWour
         /zvy+/FYh3GX2OPb0DLnOQr72lGeXnjlzyEWSWkREYMPEmBBVe1SlIbdldsHMJecSIS1
         eb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031222; x=1694636022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg5DjKI/9NLJunvSSGRemhG/m4wH99s/gp8Mx1+uNl8=;
        b=ReHWwdIowaKws+wJQ93c6fI6oXEaGwY6lCgUHYzLZYJUyFHgt7QKpX8UwEvjkl5RWh
         rLGkvGq0UEIcOaNzC7NKDFtcMod56dRgzZkRNWBZ+HxUi+ZM1PC/3fB+h0LDaVACC3UC
         55zv9LoD3I8+X74wNPxrcROBuePErtbBgjc/DqlQgizz/Iu8hda5Fr4AJs02izdyVc+8
         aVbUsVu0lQfs8kDQE25XgPX6u42cletVuo59c0R/0HWEeMG7pGYQPNeO2hPtcay70+Ar
         shSx4zpFplf0Z0Knlh4OucyO1ou2hp7srvow/+RdD3ZCM2VUySSXwDJPXpG/bht/+0De
         llEA==
X-Gm-Message-State: AOJu0Yy149Z6XDWfkdGdc/Vp43WLeFIG1QnVCSnLXSEJsiNgqRDJwsLq
	omIHy/10H+RNGRnohMCPAho=
X-Google-Smtp-Source: AGHT+IEsgyaEiycFAnEtb2KDEZxiMCqauxrhml48+kwTqdfylUp6mJypNGsGvY8zCIiSjyfLaRw3Kg==
X-Received: by 2002:a17:902:f546:b0:1b9:de67:286f with SMTP id h6-20020a170902f54600b001b9de67286fmr20707829plf.49.1694031221634;
        Wed, 06 Sep 2023 13:13:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:eca7])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001bdb85291casm11418725plo.208.2023.09.06.13.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 13:13:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 6 Sep 2023 10:13:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/5] cgroup: Enable
 task_under_cgroup_hierarchy() on cgroup1
Message-ID: <ZPjdc3IwX9gjXk_F@slm.duckdns.org>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <20230903142800.3870-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903142800.3870-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Sun, Sep 03, 2023 at 02:27:56PM +0000, Yafang Shao wrote:
>  static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
>  					       struct cgroup *ancestor)
>  {
>  	struct css_set *cset = task_css_set(task);
> +	struct cgroup *cgrp;
> +	bool ret = false;
> +	int ssid;
> +
> +	if (ancestor->root == &cgrp_dfl_root)
> +		return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> +
> +	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
> +		if (!ancestor->subsys[ssid])
> +			continue;
>  
> -	return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
> +		cgrp = task_css(task, ssid)->cgroup;
> +		if (!cgrp)
> +			continue;
> +
> +		if (!cgroup_is_descendant(cgrp, ancestor))
> +			return false;
> +		if (!ret)
> +			ret = true;
> +	}
> +	return ret;

I feel ambivalent about adding support for this in cgroup1 especially given
that this can only work for fd based interface which is worse than the ID
based ones. Even if we're doing this, the above is definitely not what we
want to do as it won't work for controller-less hierarchies like the one
that systemd used to use. You'd have to lock css_set_lock and walk the
cgpr_cset_links.

Thanks.

-- 
tejun

