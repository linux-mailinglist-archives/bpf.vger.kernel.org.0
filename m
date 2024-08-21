Return-Path: <bpf+bounces-37776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE195A6FC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E719D1C22510
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EDC17ADF8;
	Wed, 21 Aug 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujkZqTHG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CF179652
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277025; cv=none; b=c+lMNaFA2SK5oRY1P9v0BZEdDMSbGE6u+pjSpg60ptNzoHNv0fDauIh6NerHfAa7ymz3jKdADJ5F2xElFYuWth1zKTos6R6pW2Y31GS4zCutAzNgxW7xGAriEg0kw4CNdnXAp+gYI6yK9l0NOJG8QO4LucgDKqpW05CGBMuZka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277025; c=relaxed/simple;
	bh=d5Q6gXFBR8sKEC5gdtO9JEEEC1rXqIpPuApXR+YdwVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQfIOJnGyr9ImMYe6SzGeqwYpM2mMIV61iBXAwDmCd7AUZ899SgN+LamTwuyoTe0L9suxQG5tFlYUyTJ6dO1amOMlvhhnZuH7tG2YX3F79LKrzPCxdd28VJy2BANoN1lKJCoekzDnTOx2/S/8dq1bfaIDtvxfd4NB0NeWVBUSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ujkZqTHG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281faefea9so760595e9.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724277022; x=1724881822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYl61iRz9Vr4ihVH142T6N4W0V2TmSfU8VgFwSsCDRg=;
        b=ujkZqTHGNxDiJNNPRkm4VjdMwpQ9G4gvv43r/TwRo5N9hOkFJe1GEPva6T+9dYkBvU
         BsnvZCGLhjmHy1vmU6zdNcYl9qXBIo2T9FcP5+3qEsIHnkadkuGSlWMXgBT+oNQK8jtj
         4IYtrTL0AXh9ZQCJlyIujXBvjPi+OgcEhpu4LIwGFgtavCtC1u98Lzi58o5+/Ip0hOrz
         9338GY2OznVJ7MQNNektuEnkeJvlDzSjpqwJFmZpYZFW7SBZ1pyuvFQaNDt8kvUpH/rg
         fuDQ1h4dO8P3j7oXCppAZOS06IObHzHHLyiDR28sVtxrN6pD8EulOma6l62PI7HHy1O6
         d6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277022; x=1724881822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYl61iRz9Vr4ihVH142T6N4W0V2TmSfU8VgFwSsCDRg=;
        b=iyn8SIiT3cRb54lawL4VbuvER2ul7v51TxMr57cHJ1+5IeUyPF8IMwEw3leCllbuek
         eTR/fFBNEsMLe638TqxuZd2qWJZhPzCn2EQanttsQFeQAaMRrjpoQuH3O8q3yAQui2OB
         e3Ck0h/lwoAG2tKTC7KDThmc2TOIZmUkIQOMORYZ+M+f38gvApP4yjUJ97XCA1JNTFtA
         Zv7rLo36bJH2OYzbhFbQ89em936xyW7aSGDvtfOdgso9DcE9m1Ybso26uRTpcl9ArrOk
         syc+sNpvYdwRgJcxYnttoBWYEkiV3dqUYew/1oh/3M+Ard5O7uha1L3sZrHZDzd+0JFA
         PJyw==
X-Forwarded-Encrypted: i=1; AJvYcCWbQvEawjFp/v7vlt7cL5jfatyWyBk5rcdFjxlA1cSIVw/FzuxxQ5tY/6V4emjqlOqcHAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomuyGv6XxdPtBw/ZoYeqObYcg7ZhdhAzixnIVTHdF0Ov0f43n
	uRlZf53aYagVek7vJk3DYdGcIsVcSag7MifcdsYOiVi3L7XNhrdU4Vl+8iCOJrc=
X-Google-Smtp-Source: AGHT+IEyN+6VsJZDMyvbLEE6jBtKwTDD/JXsQozPwMB2CXp/10iGXOBdFPW9w+TxCix0HR8241OqVQ==
X-Received: by 2002:adf:f2c1:0:b0:371:9366:6d90 with SMTP id ffacd0b85a97d-372fd6d5622mr2445363f8f.18.1724277021546;
        Wed, 21 Aug 2024 14:50:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821ab1bsm39838f8f.99.2024.08.21.14.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:50:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 00:50:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Hao Ge <hao.ge@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
Message-ID: <58f57d70-a787-4012-8763-cc6eb642ef8a@stanley.mountain>
References: <20240820023447.29002-1-hao.ge@linux.dev>
 <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>

On Wed, Aug 21, 2024 at 02:03:17PM -0700, Yonghong Song wrote:
> 
> On 8/19/24 7:34 PM, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> > 
> > Smatch reported the following warning:
> >      ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
> >      warn: variable dereferenced before check 'buf' (see line 454)
> > 
> > It seems correct,so let's modify it based on it's suggestion.
> > 
> > Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
> > check in get_xlated_program()") fixed an issue in the test_verifier.c
> > once,but it was reverted this time.
> > 
> > Let's solve this issue with the minimal changes possible.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
> > Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> 
> In the future, please change subject '[PATCH] ...' to '[PATCH bpf-next] ...'
> so CI can properly test it.

It feels like there should be a technical solution to this.  The CI system is
something on AWS and it's too expensive to just check every patch that's sent to
the bpf list?  My understanding is that there are only two bpf trees.

	if [ "$FIXES_HASH" == "" ] ; then
		TREE=next
	elif git merge-base --is-ancestor $FIXES_HASH origin/master ; then
		TREE=linus
	else
		TREE=next
	fi

These days the zero day bot people are checking around a thousand git trees.
They pull emails off the various lists and apply them to the right places.  It's
a doable thing.

regards,
dan carpenter

