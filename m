Return-Path: <bpf+bounces-12572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5737CDCDF
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 15:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3451C2084B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DED358A1;
	Wed, 18 Oct 2023 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c52XKerL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833ED35887
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 13:12:00 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA2B132
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:11:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1c66876aso1105363766b.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697634714; x=1698239514; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=XINWG75d/tw1LWTjmyxq3SU0daBRIYX71zDB994atYg=;
        b=c52XKerLtnPCsMFnHzPJ5znXcTxy/X2aL7msjEBsBnQdVdpAQlZFim+Gs5ARm9yfmJ
         obvesuSQuGNTGv1HOPGszy38bGZuR6b8r50wBIeiA6fRjjDNAaolY+ZpdTliTR5Py5iE
         8cdpR8Xe4QghIqbAuCBfCIONohG6mqfGOgK0fLp5G/HtHMFYg3d0tI7lco0ipM51gYmN
         qWdMpA1aGLBSmtjVoaAVR+yuq9thTr7MMl/ALQmPKYBnbW0+3CAU508SCwJsvMAi0yH/
         l57hYrAHEdjjInAL82pNB7fgUku7ijfeioiSw0zBntuTeyHiN/Jqhg9NBBDDbdKwm4dD
         qIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634714; x=1698239514;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XINWG75d/tw1LWTjmyxq3SU0daBRIYX71zDB994atYg=;
        b=v4JPgn9o69pQCaDGwIoPa5/PBJgRNPEEMK5sW9R+86JArGHCDQxbXJJH/L7iGQg+ti
         AFI9TaZhGqTu3whwzTYPDcbsEkShUlMWkbJcyPSDGlUVZa6gVSzJoU25GPNWP+wGd6Pq
         SgABrUUpUE76Y/lAp6V0rO8Xei3xqNbdcb61AC/cIeJQHVFjBSHv6QpTU0BbV+cSFSUy
         sgLCbyxaS0ZHsj59PHcbylC99cc4ulryYIpu7LJ+e68Hu9K0AQ+Cl7bBpMdRnVE38mGw
         ih1TzLS6KpGwEZipsiPqPo5/rt35Ef1J3bj5kI29+8BF4XbcxIoGKVeQjt3UGBa7i1Ge
         lAuQ==
X-Gm-Message-State: AOJu0YwoEVhu6mEfKX/oQtBgqdhT0brGWAwLMC86e24g+TS9U+vc2+ov
	KtTZKOiEHrUMzMkz73ueIZKLJA==
X-Google-Smtp-Source: AGHT+IFqb1I+/iFl7h9OQKSgyAurOeel5WcE3c+AP7zy28gZyBF91PDTgLwIZUhgIqeVr1Pr8mTIkg==
X-Received: by 2002:a17:906:dac4:b0:9a1:c659:7c56 with SMTP id xi4-20020a170906dac400b009a1c6597c56mr4235720ejb.22.1697634713932;
        Wed, 18 Oct 2023 06:11:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1ae])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709064f0300b009c3f1b3e988sm1633025eju.90.2023.10.18.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:11:53 -0700 (PDT)
References: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org
Subject: Re: [PATCH net] tcp_bpf: properly release resources on error paths
Date: Wed, 18 Oct 2023 15:11:31 +0200
In-reply-to: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
Message-ID: <87bkcw9iso.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 05:49 PM +02, Paolo Abeni wrote:
> In the blamed commit below, I completely forgot to release the acquired
> resources before erroring out in the TCP BPF code, as reported by Dan.
>
> Address the issues by replacing the bogus return with a jump to the
> relevant cleanup code.
>
> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

