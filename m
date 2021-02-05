Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379933104D1
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 07:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBEGAp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 01:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBEGAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 01:00:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F6C0613D6
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 22:00:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a16so3014614plh.8
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 22:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=073ZlXURf+kZByoPy0z4qo5ZUwDzoU3MGetOCTiNDgc=;
        b=Kt+uRDjzaeiJd2aakMznNZRS9X9VhRWw0w4q9bLSaLYI9y4zmDUz+7JRqTyK9ZkHzm
         lfndV+lRu9fU8E2nmLHM7jibHs2XAoFaNASExHXXDu3r3xG37Tqs8WBSzBRtkxS3sNpQ
         El7JqljB6hzxdwnGlGksIM9VHNIzwGtF+Z+ivZt+vO3SMNOWuZqT3UQdB7MQoB9RQgjz
         dGEkiFOCce2s6l6huWbggwG0rvZa710oCXoq8wTrW48XGkPTqyqckGfSiwXl8+D+qpmZ
         JbqcY4fYcuQwt/exjG2xZMWYdzFTyhlYbuBP+nqSMQxan4NChkt9jcF1yVHJgojIev6o
         LmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=073ZlXURf+kZByoPy0z4qo5ZUwDzoU3MGetOCTiNDgc=;
        b=LDvOlYH8Gl+RxWWayWYw+HKUSz0t78nlMXoOZk1VWx01HNFZH1VdtAqhvs/AZmWHgh
         MqS3e5RTTcx3+iCSsCxNltcDhjx7Ely/25tNEytW9XGm1AM3vl9ge8IEWr02hU7PNt9N
         waMCq12EuQwIcqcjFc+IEg+8R1NWD1/YZvDDVSNm5uMQ3YrDyDMRorj9IMZpQ56U3oLd
         M0bDti5c9MJ0DWlrIvFcczL9fbvVP+ihHCDD/Ph+91biKcHHKJnA5cOdQl+HcGs2+1kA
         I8jIqWeRCeye7nGe4hGUEB9tuJfq3DaghqMELI6WXoFR8zdPzuc+8AjFihqp8jUseGpf
         Mqbg==
X-Gm-Message-State: AOAM531ZXKtc25T47lWCvu8TRyV7v6FoFsuLYGouTtDjmi/VxI6g4Aqc
        OGBxdo3wbUixtUDfzY1pCS8=
X-Google-Smtp-Source: ABdhPJzXlXWhcYaOdZYZYqy1er2/OQss5sABhjBKmtfA3Z+qGaykg3MxoIigzliCxVKIpi2X5f4r9w==
X-Received: by 2002:a17:902:5998:b029:e1:880c:a352 with SMTP id p24-20020a1709025998b02900e1880ca352mr2695018pli.70.1612504802352;
        Thu, 04 Feb 2021 22:00:02 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:52b9])
        by smtp.gmail.com with ESMTPSA id m4sm990894pfd.130.2021.02.04.22.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 22:00:01 -0800 (PST)
Date:   Thu, 4 Feb 2021 21:59:59 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/8] bpf: refactor BPF_PSEUDO_CALL checking as a
 helper function
Message-ID: <20210205055959.tznddmonb4shzi5t@ast-mbp.dhcp.thefacebook.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234827.1628953-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204234827.1628953-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 04, 2021 at 03:48:27PM -0800, Yonghong Song wrote:
> There is no functionality change. This refactoring intends
> to facilitate next patch change with BPF_PSEUDO_FUNC.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e09632efddb..db294b75d03b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -228,6 +228,12 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
>  			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
>  }
>  
> +static bool bpf_pseudo_call(const struct bpf_insn *insn)
> +{
> +	return insn->code == (BPF_JMP | BPF_CALL) &&
> +	       insn->src_reg == BPF_PSEUDO_CALL;
> +}
> +
>  struct bpf_call_arg_meta {
>  	struct bpf_map *map_ptr;
>  	bool raw_mode;
> @@ -1486,9 +1492,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  
>  	/* determine subprog starts. The end is one before the next starts */
>  	for (i = 0; i < insn_cnt; i++) {
> -		if (insn[i].code != (BPF_JMP | BPF_CALL))
> -			continue;
> -		if (insn[i].src_reg != BPF_PSEUDO_CALL)
> +		if (!bpf_pseudo_call(insn + i))

Nice cleanup! I've applied this patch from the set.
