Return-Path: <bpf+bounces-11771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3AF7BEEFD
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 01:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0E82827E3
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB714735F;
	Mon,  9 Oct 2023 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLKRPo4T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C51374FC;
	Mon,  9 Oct 2023 23:14:32 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72A26A6;
	Mon,  9 Oct 2023 16:12:10 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7b5f0bbe137so216991241.2;
        Mon, 09 Oct 2023 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696893125; x=1697497925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBvYA2ZtciSSP4BymFX/zrFacKuKzAMWo9vVUVhdRHg=;
        b=hLKRPo4TtZv1TluLN/cfBRSLpkEwYaTe2YKxDyH90OfaR9I9Y6O4M+QK38lg7aLzMH
         B9KWV0C0HIUkQTKj2RLxVYYaHLXHLoQUWtNwI5GFy2NwQ8TyHGJO6Ybqmeom/u8JVl/d
         IMXjXRvUEORFR6DPvrlnsL6T7ESGUAWXkh2SPzTUv+01BS7Yj0IFUBmjEAdq+FrD9AVP
         2inr3yRipughj0eH3UVSUmm5HRh1tffUvG9orn0C9jCy27JKM6Sy/Bn4fx30UbDGDdH1
         6hxB0LxWDvFaMVA+6weKeLhL/1FDojje4vqyDudi0tDrljaY9rb/ZC4XPWFDIz7VjQur
         cSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696893125; x=1697497925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBvYA2ZtciSSP4BymFX/zrFacKuKzAMWo9vVUVhdRHg=;
        b=Kc/adbFYEo7eoC759FNa7SvvKmT60bWN93G9IC3SYG59jZ7OjJqQ0rvTwtxxCrLhMS
         TRoDUN/IwPJ7yGmwqhMTUGdLf/KBx8NmQCDTiWVa4vPZ/gm4XSUczQatMPj+SC8AUbze
         dNS774De3CNfSlJKcCTGzuWXnpqURpZAiqMA1RxZpFLf/8EXFP6K5DaEbOZpq9NGD1ho
         U2Y+EWS/D8y/JUNn0+M905wpBrJPkEDGaG+yie3SECrtv84F5PQMT6hOjYgMdWWdCwMj
         D/iioJkhLoDOb6+FlAHdMKxL1sJWgoHqRFBgQT/s0m6ymbM74f0LwDKupVD6Z2/7V7+5
         5LXg==
X-Gm-Message-State: AOJu0YxYHhm4wRCR4hhqgtuUZFnObcQkw2drcGedl+yTtz8kkIlIVAKn
	/RSoBEvjNek8LclB6+mbLHw=
X-Google-Smtp-Source: AGHT+IEqlTB6xMUxC2uUzyE65eT9G6Bzyn95oHRdOyu2UltAtccDUj8YlgFVkih9ZpIZ+RtuAB5iFA==
X-Received: by 2002:a05:6102:3a76:b0:454:6dc6:cd5e with SMTP id bf22-20020a0561023a7600b004546dc6cd5emr15136006vsb.15.1696893125521;
        Mon, 09 Oct 2023 16:12:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s27-20020a05620a031b00b00767d572d651sm3874915qkm.87.2023.10.09.16.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:12:04 -0700 (PDT)
Message-ID: <ab209176-b172-48c4-9550-d74b084ecaeb@gmail.com>
Date: Mon, 9 Oct 2023 16:12:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec: replace deprecated strncpy with ethtool_sprintf
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 16:05, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Also, while we're here, let's change memcpy() over to ethtool_sprintf()
> for consistency.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


