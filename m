Return-Path: <bpf+bounces-12354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D97CB640
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 00:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3679B20F46
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE738F98;
	Mon, 16 Oct 2023 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwwuzakq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DD381D8
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 22:10:38 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B4A1
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 15:10:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7ac4c3666so62205107b3.3
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697494236; x=1698099036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wMhh5vlkXtcMyVAxxvIVk+27TdPfKLAsouoe6bkIsw=;
        b=KwwuzakqGsllbH/6FkJfy2APk1eii87UESjPnP4tJPOecPaYaKCxNBPbeqL1fIqctU
         DkOJq5jjc8NnXJviRJpF3PO0bv6o0aHA/rdlPUaD/nrokP3uFf30Hw/S8iKXFo7EmsH7
         NNgHwRrnkhkiq/Nlr3OFNpMpREoDDJ3lCqFyaKdAKF6tDnMIoPLU8X3fOia8UqbZalfZ
         V9l/iVbZlsZDlHbzQNnhBeapOwcxzd2sZZl6Ws0FJqc/9ItyuREvAQMYDdjUGGR14T/G
         pKEVjpa6g0FbIP+XjdBOnTn+1G49nAqKMBgUJONYNxu6FwDhJe0OkFgHntaMxp4U6wH/
         x6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494236; x=1698099036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wMhh5vlkXtcMyVAxxvIVk+27TdPfKLAsouoe6bkIsw=;
        b=qagzSaSKf67UIgZEjCJdCWGEtzO0ogn0zUE7YaJ53qNzGYqN/LGoJAiCVVCztSxqUQ
         C0blzEwFRfLATaJfzPSgjgC5IcIRVthATNzrV9Ph4CMH313YD8WQr2ppQAzQfUtqdyIS
         l3/fW3IQMDfvgfzAtJagEE0NilyXELZ1ouzincFx6IQTs2NZpAp2+YOSwDYw993Glvxf
         KUTorfpwuZLXlRM5qaVdS4W5aHHXxwkYC7DuooJH8n/WuXbJtHzL97l+hm21TdmNMRsl
         iVrdqWk1tsaSmPEQmnWQW7jj9Yrp/ZDrbhgWr7DchPwmw1VcIHE5aUmH+kxZ9S2J9/Fo
         QgmQ==
X-Gm-Message-State: AOJu0Yw6uP8nag2QS7FEeImOBajMHMqV+mR7Srihlqr7Y4WxVyxabBxV
	hMaoInE8SsMpteZJQsaqfqo=
X-Google-Smtp-Source: AGHT+IHE5zbRJjO/7MQOLY0+7Mrb+8PRaNCFm4o3+JD06Rj9UmK5r+d6JoCHRjD+oTaZGotXWtSSLw==
X-Received: by 2002:a25:ab4a:0:b0:d80:a9d:aeae with SMTP id u68-20020a25ab4a000000b00d800a9daeaemr309583ybi.44.1697494234806;
        Mon, 16 Oct 2023 15:10:34 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:83c1:ef3f:3799:b7bf])
        by smtp.gmail.com with ESMTPSA id ei47-20020a056a0080ef00b0068ffb8da107sm50804pfb.212.2023.10.16.15.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 15:10:34 -0700 (PDT)
Date: Mon, 16 Oct 2023 15:10:04 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Liam Wisehart <liamwisehart@meta.com>
Subject: Re: [PATCH bpf-next] libbpf: don't assume SHT_GNU_verdef presence
 for SHT_GNU_versym section
Message-ID: <ZS20imzrKZdISg1W@surya>
References: <20231016182840.4033346-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016182840.4033346-1-andrii@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:28:40AM -0700, Andrii Nakryiko wrote:
> Fix too eager assumption that SHT_GNU_verdef ELF section is going to be
> present whenever binary has SHT_GNU_versym section. It seems like either
> SHT_GNU_verdef or SHT_GNU_verneed can be used, so failing on missing
> SHT_GNU_verdef actually breaks use cases in production.
> 
> One specific reported issue, which was used to manually test this fix,
> was trying to attach to `readline` function in BASH binary.
> 
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> Reported-by: Liam Wisehart <liamwisehart@meta.com>
> Fixes: bb7fa09399b9 ("libbpf: Support symbol versioning for uprobe")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

This was applied and tested internally and fixed the issue.

Tested-by: Manu Bretelle <chantr4@gmail.com>

