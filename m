Return-Path: <bpf+bounces-12211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4717C92A5
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 05:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F1B20AEB
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F91874;
	Sat, 14 Oct 2023 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV9MVLhf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2F15D2;
	Sat, 14 Oct 2023 03:51:25 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D9C0;
	Fri, 13 Oct 2023 20:51:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27b22de9b5bso1913621a91.3;
        Fri, 13 Oct 2023 20:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697255483; x=1697860283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBj8j89zDLkCdR77CxvVfssAX/S5nXsHlrO7MTMB6qI=;
        b=HV9MVLhf4GjJrRejeH2TczXvg16LXW7ggrKWn4oFvihIid3tLfIvegxxxHXGG0PXr4
         efGAhOSltaWMzXjACIaAZC2NcfgE4QRatCzWII1HtKGxI2c3llbEf1UUnR/ENsRZ2oeP
         9eoNnZR8Yj7sV9ulXFwIdekNNh707nlAmnvrA+vBCgWwrHMaRFb5ReDE0tt3drRzec06
         ps5UrLs1uS59oN5MXRTNSVyyBDwAmv0acPoDQpO9Nd+jWVcvSIhHjDHkeEHTDWGlIoTC
         SilM9/cUUd00HOsUPm3kX2RlxGILRbQ/MELfrmtOUkUnHrW9e++B+eBe4triTA2Gk7KI
         fYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697255483; x=1697860283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBj8j89zDLkCdR77CxvVfssAX/S5nXsHlrO7MTMB6qI=;
        b=wRgVl9ILPsKtuJASW+uY4s+gsYvgid+Ft9ItaKiN7I8ggd3+OlnFqXArLD7JGDkTWg
         ZE9MX2DVZRT1kL40WNjnC5JbTSvUHQAmvJkvFobi4cuteC75KFsnIvsVLGUQhaQKN0xT
         OknB2bNmMhLqxovIvJMk91YPbfchCFbY3n4oSJHtuJ9a0Ym+E25Xq+aSCUkIPy+GDmzs
         IJAbGdR5MVoGOi44UitS0YmuPdbhgyLMfjbvm9cyEGE7x/5ijXtIp7G2FAVK+NSgcpHc
         TUrTwcuRZjn/aBezED9AfaSWH6d1OYRVdtFhrRrdqI+A2kxk3Lp6DMAJQlies4ip0Ebu
         9HKA==
X-Gm-Message-State: AOJu0YwcV8EFIEb+7yWK2eNFkL7QrL9Tkw0AiJuJVlJ9tMPs6FoeVlhX
	RuhKcyFJyOV7zMGO8TNtQcs=
X-Google-Smtp-Source: AGHT+IFEYqEl9E3FXY/KxBruAUPZasFbtjlJ7Mg8gHysU4PUcIcYONQHdsd0SlFMWaOHTVNmI7gptg==
X-Received: by 2002:a17:90b:1d8b:b0:27d:2ecd:6a23 with SMTP id pf11-20020a17090b1d8b00b0027d2ecd6a23mr4029697pjb.14.1697255483566;
        Fri, 13 Oct 2023 20:51:23 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a01dd00b0027476c68cc3sm931099pjd.22.2023.10.13.20.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 20:51:23 -0700 (PDT)
From: Edward AD <twuufnxlz@gmail.com>
To: horms@kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	twuufnxlz@gmail.com
Subject: Re: [PATCH] media: imon: fix stall in worker_thread
Date: Sat, 14 Oct 2023 11:51:15 +0800
Message-ID: <20231014035114.1057686-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013105909.GC29570@kernel.org>
References: <20231013105909.GC29570@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 12:59:09 +0200 Simon Horman wrote:
> The code is already switching based on urb->status,
> so unless the warning message is really desired,
> perhaps this is more appropriate?
> 
> diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> index 74546f7e3469..0e2f06f2f456 100644
> --- a/drivers/media/rc/imon.c
> +++ b/drivers/media/rc/imon.c
> @@ -1799,6 +1799,7 @@ static void usb_rx_callback_intf1(struct urb *urb)
> 
>  	switch (urb->status) {
>  	case -ENOENT:		/* usbcore unlink successful! */
> +	case -EPROTO:		/* XXX: something goes here */
>  		return;
> 
>  	case -ESHUTDOWN:	/* transport endpoint was shut down */

Hi Simon Horman, 

Who added the above code where?

