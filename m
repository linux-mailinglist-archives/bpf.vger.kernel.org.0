Return-Path: <bpf+bounces-12536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B77CD864
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BB71C209CF
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE71805E;
	Wed, 18 Oct 2023 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsCYowBD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07C8C0C
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:40:43 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88084B0;
	Wed, 18 Oct 2023 02:40:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b497c8575aso4723063b3a.1;
        Wed, 18 Oct 2023 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697622042; x=1698226842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC894XxMlzgTBfgLP9GWv04doz2Fpk31x4rTGtgAXUQ=;
        b=RsCYowBDKyyRLyK2dUsmXL9MxCTrMJSqyU9xVjmOHphPiFnams4kGs4M+S6Xalb90H
         kAmZwLqc8KtE5vUrmqF3kjNyqztcfXvIgp67Kv1MVp7XWw5qjYD8ASlj045RDIK/bePb
         OcZSVRuoDBkUAGQNxsq0tALpK0qOxhboCPrGKHAEtWv+sMnppl02Wr0WHTaaYXsDJPp7
         J2VxMJLbQiWTDRHxTT7WgPso5i7je5P+7g0fhbLinP4qi499TdI2bquyt1Wt9dYebrvj
         eGKzutp12mEEEh0V0A9IUsYV5ZaUbod5qInRAlyVx8yzZZ0JaxRPtXak1DjiD1cr+E/n
         P9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697622042; x=1698226842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC894XxMlzgTBfgLP9GWv04doz2Fpk31x4rTGtgAXUQ=;
        b=W7uS6YZocWwAwRnewY9K3mxgx73obV0QGapxXU8T8d8ik3Wa+tyaTFcmKH5jxj5LPM
         w/tyu6eEZdX/6H+NNLFUv+G9yxE0X8GWOeCf2MGCLTSJPsKdj/28rSMvjMiffxakgPw5
         QAi8EUC/FBNDf2NOkv2o5xrGL9gwzW8qFwLbG2jL9bu4iuKWMPuRpP6p1EqiGWyDT5UU
         6YzpP8T5vHUdkYSjrZZdU5bM4qV7V1YbpSXAhEPmNzKW115TByMNQivlhgZ7XITyJtcu
         7tjo+R63M0gIGCsMyDMjDt/eR9OXPQuXzZjl10ByrSW6tpbdAfDxPFFxCOtFmRECNgUx
         itiQ==
X-Gm-Message-State: AOJu0Yx3XHtPrWTD2jPAQQPl4u58Lq1GTXn0z6QBvKh0FbTYOmwOJ2u5
	dthioi+4dJxsseONdosovxsvRXzMXsnt3Q==
X-Google-Smtp-Source: AGHT+IFcvnAbQrD988lJ5yTK+Rf4w5T+Gk43Pg97ITRUyEji26k4x0QSI6QPYs1+l3cGQM/CO0lOQQ==
X-Received: by 2002:a05:6a20:7f95:b0:174:2d20:5404 with SMTP id d21-20020a056a207f9500b001742d205404mr5594833pzj.37.1697622041880;
        Wed, 18 Oct 2023 02:40:41 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709028f9300b001bb1f0605b2sm3062892plo.214.2023.10.18.02.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:40:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 17 Oct 2023 23:40:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 4/9] bpf: Add a new kfunc for cgroup1
 hierarchy
Message-ID: <ZS-oGKUGgShsfOEH@slm.duckdns.org>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-5-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017124546.24608-5-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

One nit.

On Tue, Oct 17, 2023 at 12:45:41PM +0000, Yafang Shao wrote:
> +/**
> + * bpf_task_get_cgroup_within_hierarchy - Acquires the associated cgroup of
                         ^
			 1

Thanks.

-- 
tejun

