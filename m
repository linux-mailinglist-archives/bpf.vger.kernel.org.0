Return-Path: <bpf+bounces-9615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5CD799F5F
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 20:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BD1281070
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E9C881F;
	Sun, 10 Sep 2023 18:54:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E48469
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:54:54 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0809F119
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 11:54:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403061cdf2bso10630205e9.2
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694372091; x=1694976891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itQ8jRaV8sQLgXRH9QUx5PSY0VhIni+Q4pZ7gavqQYM=;
        b=iSjPhfNl492pOJBZ4xYHRQDh4jPAGMSw66qPSQZIDB1+UD2LrGdUHahFMxRKOTVRwP
         VXBWXjgdCcB44iKXjWg5UwZgflcGw8Nx0Xeikv/K+poy+HUJmDcMaTz6yZvNXSptwZOY
         yF5LL7DHR/sfcpjWkAEQD1Sp3D1xSRpJ865/fE3axsxO5iv7VNYL3iFslMc8OwSUu05K
         0hJI+TzDOuJ7Psn16WvutfEt73Z6P+vzn22iVIsLrcOy/V1SRNEaUvv1QtgPXjt3ndrr
         O34NecJ9Y5jvzxiWu0BdgTC8RfI/cAi3rirnXgXkCzATimhnD5pvrQF2Se4ANo7gRQWc
         GolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694372091; x=1694976891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itQ8jRaV8sQLgXRH9QUx5PSY0VhIni+Q4pZ7gavqQYM=;
        b=Mwz0ruXchPktBmdYDgjpuKrM7QYGJl1Pv3oh0uBLi28OqHDeI2kx7NtEobLDCNw4oi
         YM4Done03O3xb+V9M04C9VTZX6B3tWuUNnb1A7W8ajUr4D7IJ+1DMw4bCqwMiIe9FBfm
         EqGHNYcz4oM1sfFxPuJe29SbP3+bI//UWkunhrICTMwaIX167NK5RmXDMsFLt+sox7SJ
         YRk8iZcJ4dbjHy5qPo8aMCvj0PlzSCPhuwbgQSGFt393Umefc6MLvLi4vsBGiEstKQP8
         Hrr9RpbyHzumZ6AhNgaV2G/gQNkgBsQ0YJXYmMQIypev7vdsRDEeNAyTqnLqI5maK7/X
         rY6w==
X-Gm-Message-State: AOJu0Yw9K4ykLNJe0L1J2zDosVw1F05jTh7H0ZqxJW2UCUrSwe87d6Tx
	uqWFWXo7wlF3No2rWKG+0ns=
X-Google-Smtp-Source: AGHT+IGrurzW11a7oLrS0K9ujRUMMVXBhBOsFfdTDw6ijGBhl10MfEPvHAvsFZew+NnDrwEt6VeNaA==
X-Received: by 2002:a1c:7904:0:b0:3fe:1b4e:c484 with SMTP id l4-20020a1c7904000000b003fe1b4ec484mr7009191wme.5.1694372091194;
        Sun, 10 Sep 2023 11:54:51 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c00c500b003fe2de3f94fsm7776793wmm.12.2023.09.10.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:54:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 10 Sep 2023 20:54:48 +0200
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link
 info
Message-ID: <ZP4Q+LnN1x8mUDxY@krava>
References: <20230907071311.254313-1-jolsa@kernel.org>
 <20230907071311.254313-4-jolsa@kernel.org>
 <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
 <ZPsI/4nX7IUpJ6Gr@krava>
 <CAPhsuW4aiVoGwN7quqCUiXS7HrKtSyPbR4dsgoXw=wcgWuybew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4aiVoGwN7quqCUiXS7HrKtSyPbR4dsgoXw=wcgWuybew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 09:49:17AM -0700, Song Liu wrote:

SNIP

> > the bpf link has access to its attach layer, like perf event for kprobe
> > in perf_link or fprobe for kprobe_multi link... so it's convenient to
> > reach out from link for these stats and make them available through
> > bpf_link_info
> >
> > also there's no other way to get these data for some links
> >
> > like we could perhaps add some perf event specific interface to retrieve
> > these stats for kprobes, because we have access to the perf event in user
> > space, but that's not the case for kprobe_multi link, because there's no
> > other way to reach the fprobe object
> 
> Fair enough. I guess this is a good stat to have for the bpf link.
> 
> More question about kprobe_multi: Shall we (or can we) collect "missed" for each
> individual function we attach to?

I think it's possible, but we'd need to keep/lookup stats for each
function/addr same way we do for cookies ... so it'd mean bsearch
on each missed path.. which might be not that bad, considering it's
error path instead of executing bpf program.. also it can be optional

jirka

