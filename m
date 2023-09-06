Return-Path: <bpf+bounces-9304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB57932F1
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AAF2811F9
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2F634;
	Wed,  6 Sep 2023 00:41:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754E62B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:40:59 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0479E
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 17:40:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf078d5f33so24453265ad.3
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693960858; x=1694565658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh+t8AsP3UGuAyvESfWB1FimK89oj7ho5aQdgRUEPdI=;
        b=bb5T17pikEvUonGv0e8e4ceBYbXXyafEpzTTwiQYr78Q5vUs0w6YgpvWRzQIWMWOmJ
         uQMKA07bWRQFpFMm5qx2CO5kRcYUJU7xsFGq5pKRhpNqabBlvCg1ion5zmJemd4UzOlO
         r0fZtwCyz3ZCUHh8ZJhvsCP9Mq5Z7Ls9jatodtFmKXyK3djqIXUTlC0rIodudxbwQ0Mc
         uSP4TVxub6JOVAS2oWraM85TTY2d0UY2j/7t254Y8SdlDl1DBO2U628/6EbMotbYhzTf
         yctXL1SqUwEGdNl41RL6WDLaLRdPpnbJ5hoXhC0Kcm80e1b4GjMGvVam+5ut0fjLp85V
         UUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693960858; x=1694565658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh+t8AsP3UGuAyvESfWB1FimK89oj7ho5aQdgRUEPdI=;
        b=NjyZKzURmyP0J4ULMAMpG6ywWYCiFKtAIH0bw/nKmcw/nloVbN5tEvIcq+2z5EC380
         jREjX5k3F5YisTr3QtOQft25QQg5O50ikfMoQUxznNHXMQehaYzOgq2PeoEjSN1bukRc
         P7YwT3sGUPfD+r3N0/KOGAF5uuCQNBJuzAUBS6t+FIVRBdk1nt85byDvBE5TaJJ4TO4D
         ecV4k/V9+3VZbG3QdpHblPZRSzGEs+BshVpQe11FhpPCw6Y6Z/xVPHOjjTpspjsuTyIv
         wPHq+A01cjOPkU3cPVyh94n8bSWKmIMbGto3RSpnr+eq9Y9K0DezR85Fw7v0nR4/7pZ9
         1QuQ==
X-Gm-Message-State: AOJu0Yyciw46a6mSEAPMfFmHf3/0MowyADfdXDEPyeNEhlydWl79tME6
	46/wfF2dnzKI6UtKypPCEQnyh8jrcc0=
X-Google-Smtp-Source: AGHT+IEC3/bELT+ttzTPUfSCPR02bAixLWIdMrIsDlIaD3a+0ox+j7MOidtcHpWO2QlLtE9LzLxZtg==
X-Received: by 2002:a17:903:41c7:b0:1c1:e258:7447 with SMTP id u7-20020a17090341c700b001c1e2587447mr17081878ple.22.1693960858221;
        Tue, 05 Sep 2023 17:40:58 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d4aa])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b001b9e9f191f2sm9914998plw.15.2023.09.05.17.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 17:40:57 -0700 (PDT)
Date: Tue, 5 Sep 2023 17:40:55 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Add alloc/xchg/direct_access
 support for local percpu kptr
Message-ID: <20230906004055.bkb2ovsgzj3jt3hk@MacBook-Pro-8.local>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152744.1996739-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827152744.1996739-1-yonghong.song@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Aug 27, 2023 at 08:27:44AM -0700, Yonghong Song wrote:
>  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
> -			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
> +			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
> +				if (meta->func_id != special_kfunc_list[KF_bpf_obj_drop_impl]) {
> +					verbose(env, "arg#%d expected for bpf_obj_drop_impl()\n", i);
> +					return -EINVAL;
> +				}
> +			} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
> +				if (meta->func_id != special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
> +					verbose(env, "arg#%d expected for bpf_percpu_obj_drop_impl()\n", i);
> +					return -EINVAL;
> +				}
> +			} else {
>  				verbose(env, "arg#%d expected pointer to allocated object\n", i);
>  				return -EINVAL;

This is a bit too much of hard coded checks for "suppose to be generic" __alloc arg suffix in kfuncs.
We only have two such kfuncs:
bpf_percpu_obj_drop_impl(void *p__alloc
bpf_obj_drop_impl(void *p__alloc
so above works and I don't have a good suggestion how it can be improved,
but would be great to follow up to clean this up somehow.

