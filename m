Return-Path: <bpf+bounces-13247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FD7D6D97
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 15:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873DEB21076
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593228DAB;
	Wed, 25 Oct 2023 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeNbjIo9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBB26E08
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 13:47:04 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C36189
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:46:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40839652b97so44253375e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698241617; x=1698846417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fABIgP4sNe8bb0m8C3NlBhZwn/v5K54sY/gQBRJNis4=;
        b=EeNbjIo9gOFAO3xenzFs/EY5HJP3OTzmRUmSt9RvA3NtNErOTcf5O83ZSjko+aGI0M
         NJnHoERxj2Fe5JLyKHWjpD7NTnF4Q251//1GKikO1vIbDNytkljyvY8TiQ9/RgK4LIig
         yLzDBzuvDLj1bRJofElIi3QYH0sMqxo3G0iq1tl4N9AoQj1728sUV4ur2C5USzAZCbzI
         TTMxSA8sj19sG6iPJHkzXUy6xUkmBsCkVxqp0hjVFH73ZRtB63baiMYdAeBsXT77uQGO
         bDNBwcSH//J4C1X4tjjpCbdKRtNlHE0Rmrd78HjUkDKu9xiDLgIq1Buyoc4m9oShP8z2
         uUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241617; x=1698846417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fABIgP4sNe8bb0m8C3NlBhZwn/v5K54sY/gQBRJNis4=;
        b=WWPEcHo7nuKX1NfMBDfGFwBt+SpCSDhEOvSRld1ZO6MmtaNZlbStOoe1nCCpBPF+uK
         sLraSn24hzFmuo9sK7uZQLayaNRmDWDylqnPaHqN2ckpi9Gs6fZQZ5+aH3scQGvRjVEg
         mnhx8IHrOsIoBU6DS3m6n+N9ulaXGt9itLg4tfZ7vJ5+k8OlPeXgDF9mlSEBjEMOG1Ub
         VDSbrISU7cpT0UbDX00wwOE5y3zxsHWolPobJNrUpW53R7f8cn1qcBaBg83g81WR6Hao
         5pfXfrceXMncxldRL1qvF3pR0VO8IbqnWCRLPMUtQ3AyTp8dgD9z9H3mL3dA3TyFZabW
         9dig==
X-Gm-Message-State: AOJu0YwaOADxQs+EtlBGMxS5XMFMpBhQ1LkK8u48fOuxxqD/axQHcFpP
	APut2eOjcRCANAD+DOkBJr/0bQ==
X-Google-Smtp-Source: AGHT+IGk2H1aq4yWD3oOc6YwEREyXGEzfqNQMemvonsOhZvr3JB/vccksovIRVrJ+bWDhNYIXU4PHA==
X-Received: by 2002:a05:600c:4992:b0:406:513d:7373 with SMTP id h18-20020a05600c499200b00406513d7373mr11544018wmp.11.1698241616701;
        Wed, 25 Oct 2023 06:46:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z10-20020adff74a000000b003231ca246b6sm12027533wrp.95.2023.10.25.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:46:56 -0700 (PDT)
Date: Wed, 25 Oct 2023 16:46:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org
Subject: Re: [bug report] lwt: Fix return values of BPF xmit ops
Message-ID: <2b3ee562-e412-4afc-8828-17b4adccd66e@kadam.mountain>
References: <cd258298-8d8c-453a-bf21-9859b873d379@moroto.mountain>
 <CAO3-PboDgpHjXhcYCSFvYtEjJkLNcBY_hQ5yFtm-xTsVOdW2PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-PboDgpHjXhcYCSFvYtEjJkLNcBY_hQ5yFtm-xTsVOdW2PA@mail.gmail.com>

On Wed, Oct 25, 2023 at 08:41:24AM -0500, Yan Zhai wrote:
> Hi Dan,
> 
> On Wed, Oct 25, 2023 at 2:40 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hello Yan Zhai,
> >
> > The patch 29b22badb7a8: "lwt: Fix return values of BPF xmit ops" from
> > Aug 17, 2023 (linux-next), leads to the following Smatch static
> > checker warning:
> >
> >         net/core/lwt_bpf.c:131 bpf_input()
> >         error: double free of 'skb'
> >
> Thanks for reporting. I looked at the code, and it is possible to
> continue processing skb on bpf_input and bpf_output when BPF_REDIRECT
> is returned. However, both paths call run_lwt_bpf with NO_REDIRECT as
> can_redirect bool arg, which means the skb_do_redirect branch won't
> trigger. So it does not look like a bug to me. The life-cycle of skb
> is a bit messy around this corner though.
> 

Ah, yeah.  I see that now.  Thanks for taking a look at this.

regards,
dan carpenter


