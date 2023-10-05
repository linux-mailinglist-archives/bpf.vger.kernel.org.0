Return-Path: <bpf+bounces-11466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FC7BA7E8
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 21AE0281E3E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C53AC03;
	Thu,  5 Oct 2023 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osalhEgv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A230D05
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 17:25:01 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74004487
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 10:24:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso1801997276.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696526699; x=1697131499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEdrSOuNuoX8+xbK0bATzS8/4XLkARGYfkrZGkJ5EnY=;
        b=osalhEgvh5sLzcP0tpGbJ/1fyuxYL1lAIBDnRwtsldLU4t8Gi8STrUvZfeu0XNKDrX
         ixi73sAJSiQc652B9xoFBzBqUjeNk3CCu1nHLnS+c8cOuqqz4eWs6lnba/IwN0yL/fC4
         KwaH9eSfc7zItMc49kWkC4ZT5qsgxzrmyquiu9Iw72SwBvahtPLrh+5aTMLIGn7XIDRh
         p3cMRvXU3jgWgx7cypDp42B3DO70kB6azvGU9r7KzD6A1pW2IN/N92KftVYT5V/yI3M8
         TzVkM+x20AERKC2LViCAGp4mOlu31PJ3l4Wif3m4tZDt6hPguRZ/I57K4xfbD02LPjqQ
         aF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526699; x=1697131499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEdrSOuNuoX8+xbK0bATzS8/4XLkARGYfkrZGkJ5EnY=;
        b=nOBP6fjyB1mgIwC12zZ6yRZDYKe44rn8FOXeYTHclOtGmJl6oWij+SnIw04Ml2/xWs
         asdC1ZJlkdSSrFqec/H9P1zATnsE3YUuCK0rgK2oVOAkI8FLjWLJ3ALWEQRv+QXOkGDl
         Ul015wKmlsbwoAA8kqQcERLgwSocKThRUr2JDiHt1SVtpgxiUHES20skNzlojzNhXf3o
         1ZBSe9I4QerdE/or+KFig8K2PhVHdL8pBd/BzkpKg1ykq7vWY3Pj9E/7FicjDSd4io2H
         N7eP/XQK3HKCG0iNNKh1sJU03KYXurbMne35KJVIYiRN5SbGQCp1PXxX7VY22tGTN29K
         87cg==
X-Gm-Message-State: AOJu0YwrTLE5ZnRBszKIa9vyOLfcTRoeKO1wGFTN2dY05+ksg0TnCnNZ
	6BNUKp8Hu4K/IIEaxqYEgPlXMpQ=
X-Google-Smtp-Source: AGHT+IHIHXUtWHSllYEKmj4WljLG3NyjfecdQBRSZzIeCeOD6j9rjHqUT75iQOl/VvIQW4rxbADYyjI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:212:b0:d89:b072:d06f with SMTP id
 j18-20020a056902021200b00d89b072d06fmr89653ybs.7.1696526698910; Thu, 05 Oct
 2023 10:24:58 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:24:56 -0700
In-Reply-To: <20231005084123.1338-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com>
Message-ID: <ZR7xaLwYYahqnK8U@google.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
From: Stanislav Fomichev <sdf@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, Luis Gerhorst <gerhorst@cs.fau.de>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/05, Yafang Shao wrote:
> Currently, there exists a system-wide setting related to CPU security
> mitigations, denoted as 'mitigations='. When set to 'mitigations=off', it
> deactivates all optional CPU mitigations. Therefore, if we implement a
> system-wide 'mitigations=off' setting, it should inherently bypass Spectre
> v1 and Spectre v4 in the BPF subsystem.
> 
> Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> architectures, though it is not currently exported. For the time being,
> let's disregard it.
> 
> This idea emerged during our discussion about potential Spectre v1 attacks
> with Luis[1].
> 
> [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@iogearbox.net/

Based on the discussion from [1]:

Acked-by: Stanislav Fomichev <sdf@google.com>

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Luis Gerhorst <gerhorst@cs.fau.de>
> ---
>  include/linux/bpf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a82efd34b741..61bde4520f5c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(void)
>  
>  static inline bool bpf_bypass_spec_v1(void)
>  {
> -	return perfmon_capable();
> +	return perfmon_capable() || cpu_mitigations_off();
>  }
>  
>  static inline bool bpf_bypass_spec_v4(void)
>  {
> -	return perfmon_capable();
> +	return perfmon_capable() || cpu_mitigations_off();
>  }
>  
>  int bpf_map_new_fd(struct bpf_map *map, int flags);
> -- 
> 2.30.1 (Apple Git-130)
> 

