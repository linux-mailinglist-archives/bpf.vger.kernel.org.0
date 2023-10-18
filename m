Return-Path: <bpf+bounces-12535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C81B7CD85F
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF8C281EA5
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C025E18056;
	Wed, 18 Oct 2023 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJLNSDcP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991315E8B
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:38:57 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0282DB0;
	Wed, 18 Oct 2023 02:38:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so3023651b3a.3;
        Wed, 18 Oct 2023 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697621936; x=1698226736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+YuoAh1z5ocq/8MGflAVpgLoM8KVdxn08b/PB3ojj8=;
        b=WJLNSDcP3zD98aZfZhaqSvJ6VWQMvQegA80u5VwPcrNh6b8SmDjTga4+xPiXwowIMH
         hT4OGxXbXUDpNpujCFtbaexDDJ0m7S1w3TS/ymoOjXIxnKRX2mfcyfpLByFEDBXNlF9O
         ZFI3WXOrT+Ejuu14U/btDG4WazPz8oahhDAqE1YvMKz+3b2C8z7TOTyx+wEHyLjSsSNU
         uySaXKU4zZvrfwglc8C6pngfaT5+ZQ8LALkJvr3gWx5E24g4VtvH/zIUh7GMZ/IUOp0L
         QpNk2xvhRGdMLkidTgdufcd8dB6knMevgOu6gHCvg9pp0JOzfBO2mli99f/lUtF/v3oc
         WF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621936; x=1698226736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+YuoAh1z5ocq/8MGflAVpgLoM8KVdxn08b/PB3ojj8=;
        b=lukPqhBC98qbUr7k4zEClLzJ9pQ1pH3z0Zt42IpzJxvaLNXMnGWqf2jwsTnYxcqtbR
         VDAcD+RvlsfxjkceMnKCJPMW2/OSdktDeusyA9ungYM4cPJYXwxVg9gG00gb3R2UR8X6
         gZMVh/qR3hr8YqmgNLCv0TJ+hYBN08d2HRb9j08fP4rJoGCQ7XbvUu8Y8jSsaj6UhNRU
         EvWuIoqS0zlQb5I1N8AUXjpEdoTDIrBEugjVlNU1N2MxBCx3Y1KyaK94gUqFHDrQiLiu
         toeH9fDpsqmmlDN5Od0emt0bLWlS+5Yme3gdomnWDWAS57gNCffkd3n4rDwYBdwit0aN
         v43A==
X-Gm-Message-State: AOJu0Yx1YQmdyPe8cNin8CZC2jXfcDPahNw2mfnv93vqnoocDfa2hQwn
	cMelJZRj00nuQxdZzc5Vs5M=
X-Google-Smtp-Source: AGHT+IHnJSHHMoxOgy4sG4BPTo/W1yFiYT3Go/Ku4sVdZEJKMoCuRXLql3vx/MaIXgLXc2+0fRvpog==
X-Received: by 2002:a05:6a00:2386:b0:68e:3eb6:d45 with SMTP id f6-20020a056a00238600b0068e3eb60d45mr4380123pfc.30.1697621936286;
        Wed, 18 Oct 2023 02:38:56 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78e86000000b006b4a5569694sm2901085pfr.83.2023.10.18.02.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:38:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 17 Oct 2023 23:38:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/9] cgroup: Eliminate the need for
 cgroup_mutex in proc_cgroup_show()
Message-ID: <ZS-nrsIMFUia8uPI@slm.duckdns.org>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017124546.24608-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 12:45:39PM +0000, Yafang Shao wrote:
> Results in output like:
> 
>   7995:name=cgrp2: (deleted)
>   8594:name=cgrp1: (deleted)

Just skip them? What would userspace do with the above information?

Thanks.

-- 
tejun

