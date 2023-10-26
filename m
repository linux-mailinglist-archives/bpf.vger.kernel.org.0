Return-Path: <bpf+bounces-13299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A37D7C47
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 07:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490E4281DF4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0599C8E8;
	Thu, 26 Oct 2023 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YLGNnZDX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E8C2C6
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 05:35:11 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FE115
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:35:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c773ac9b15so70441466b.2
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698298508; x=1698903308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AnW5wkCi1zvUqw9QeSavDrGwNvTC4IDf+32SvYPJoaM=;
        b=YLGNnZDXiKBPV/2J5+JtclwBX/3I319PXqRsZDqosfcTOFiEXeJhwH5SwG6lrhx7GH
         jW717/GOW0N+tFD7PE6/EMTfhV+PnGL4FxLi8ty05CL58or8WkOwxnXUVmExj0DmlS4+
         QQCkSjEpvt0vtrw2KrStTt29prIoDmvK8M2RAAVq5wRsSqhlg8C+eNRGbxzoNNiqcepV
         sfecRcYsBXVeGJtlDjaJAAgm97MvK2UUEQpL7swv2jlhFDJb6Vh17+Qtug6pocSj4Hpx
         3HWmHfYdU4ydqZ8zD3tmb/tz/hp0VJnonOrMB5lXfCD5lf4bWFo2xN2/r4zRLVsco230
         qPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298508; x=1698903308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnW5wkCi1zvUqw9QeSavDrGwNvTC4IDf+32SvYPJoaM=;
        b=Tt8bM7ZwWKqr2AdePpEHKtFYTCnIglrK7p8QFZA42xojkWyg84rgc9+U/t/W+ra+iB
         YPr9JMHHmxBGnhIaP/9jArhKHxnWfdkzs+mtm5sgJwHXjjI0ZA21mLDFx4K2YnqGGVSV
         COIREUsjxalxuJ7PqnAseWbtewYaLV+x3L+Jsv7m+cLG9enTvG9IuUljOcwjQiedmE+G
         iF2v98jEU6CL5SQxJTSzj+ocecWxQuAdIcDTmAx3V2pf4BnkNNxZ+vzYTMKj3EeO2wlZ
         xw0ZC6TmiNJEySmsgWU3jBCNLWnESmBAK3XZKN7uLZUBREjChcyMTV5/a+tImAsFu0b0
         OCQg==
X-Gm-Message-State: AOJu0YxOq5afd6SXzlaZAMgqeTGJ573jeYO6szTXVg+4zXyoX5TvtUQ6
	XF6ldpQOB2fyvSgiBgJpBx3BdA==
X-Google-Smtp-Source: AGHT+IGpJs6UjB5/zt89grKMahUSoyHMhultp9ijTf1cz/ECcdJ/yxBvo32O3TnRlEnq7e2e7Zi5DA==
X-Received: by 2002:a17:906:dc92:b0:9a3:c4f4:12de with SMTP id cs18-20020a170906dc9200b009a3c4f412demr13178771ejc.37.1698298508693;
        Wed, 25 Oct 2023 22:35:08 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709062b4700b009ade1a4f795sm10784002ejg.168.2023.10.25.22.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:35:08 -0700 (PDT)
Date: Thu, 26 Oct 2023 07:35:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
	andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
	toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
Subject: Re: [PATCH bpf-next v4 0/7] Add bpf programmable net device
Message-ID: <ZTn6ivygoE937Vk0@nanopsycho>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <169819142514.13417.3415333680978363345.git-patchwork-notify@kernel.org>
 <ZTk5MErTKAK96nO3@nanopsycho>
 <f6357d19-9bd9-e9f4-6e9d-97a73f61560d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6357d19-9bd9-e9f4-6e9d-97a73f61560d@linux.dev>

Wed, Oct 25, 2023 at 06:54:27PM CEST, martin.lau@linux.dev wrote:
>On 10/25/23 8:50 AM, Jiri Pirko wrote:
>> Wed, Oct 25, 2023 at 01:50:25AM CEST, patchwork-bot+netdevbpf@kernel.org wrote:
>> > Hello:
>> > 
>> > This series was applied to bpf/bpf-next.git (master)
>> > by Martin KaFai Lau <martin.lau@kernel.org>:
>> 
>> Interesting, applied within 2 hours after send. You bpf people don't
>> care about some 24h timeout?
>
>24hr? The v1 was posted to both netdev and bpf list on 9/25. It was 10/24
>yesterday. The part you commented in patch 1 had not been changed much since
>v1, so there was a month of time. netdev is always on the cc list. Multiple
>people (Andrew, Jakub...etc) had already helped to review and Daniel had
>addressed the comments. The change history had been diminishing from v1 to v4
>and v4 changes was mostly nit-picking already.

AFAIK netdev maintainer have a policy (which I thoink I saw written
down somewhere but cannot find) that the patch stays on the list one day
before it is getting applied. It actually makes a lot of sense. Anyway,
I may be wrong.

>

