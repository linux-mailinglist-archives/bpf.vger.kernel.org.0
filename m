Return-Path: <bpf+bounces-14979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F51C7E9831
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 09:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B645280CA7
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5131773A;
	Mon, 13 Nov 2023 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zzgUp/Tr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397515AF6
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 08:55:24 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8B510FC
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:55:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo6405967a12.3
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699865721; x=1700470521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+RCKOZ1pbHVKPfv412Tsfm0etqBMn9v/AzzigRmMoc=;
        b=zzgUp/TrB6CY/9aPRh5R/yZtTm+FyXlaQdV6viSrgVmeO/L9Os1+z+ybAScAIVz0Dm
         zKsqczQpe4HIBbweNNDKMW4rVG26nouWIqX6LGBFYEmO7AZNjQfpxrUsAR56L4k+XsJb
         r2FaGRR1adq/ZtJitEztROHGdmBVgXwiHjPZJ1CQTEa0uqoQlmSBZ5NxvH4ai98X7lGO
         rGIi+a182zjbCdC0hByD2HFzSekS6JN4Ge3CkvOxsnDgZ+yqIPHreNeV8JRsyXBVkX7G
         TkUk9QMXvTdZ7IplZhAlgycpRtMHNq10F4e91qUid1D/FD8exjyFchcYf4Lu1yCgD3TY
         sKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865721; x=1700470521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+RCKOZ1pbHVKPfv412Tsfm0etqBMn9v/AzzigRmMoc=;
        b=TC0P+JT+BpBBZskWhAT+TOeLYUBfQC2fMKKlaGs6+Kd7rYMxYvSWu2n/45iRxZivAf
         86qS6+rt4jlKowktq96knOQAFG4mkssGYtlHs+DcqAliNyxHEFQ2P2dzy/TreyK7bKac
         6g6oyVj9s9PqSyW/wX+pXDsPa4ARDyYhZRPQgQgUgIQ/OaWEfRxVUz/ooknA+23qMHpB
         DsnTZuerEZQMVTQw3AP/OKCVFdi+EdUPwjbW5Ln8qOJpAW+Wvg3za34O2h/TEdOJxV5f
         3ktvrjfP84LypT4viuWvRKaiv74WUTb5p+VyFHmcLng5fyhl6HKMNTDCsGS4I1Lr/QUP
         dcDg==
X-Gm-Message-State: AOJu0YySmvtrs7Gov3o/vH/1TSiKjwCVgBPD/Ss9t6fMDKs8TcUhYMn0
	bv2k32n9sNDUzcMgpllNZmSlXQ==
X-Google-Smtp-Source: AGHT+IF0U0pR4SaqswqagdeawVq5Z6f+WTJLE7GeYSo9H9D4XsbGsF2BYlsd+z9pW1Rsvp8Bb3JUIQ==
X-Received: by 2002:aa7:ce18:0:b0:543:5886:71c3 with SMTP id d24-20020aa7ce18000000b00543588671c3mr3843031edv.25.1699865721464;
        Mon, 13 Nov 2023 00:55:21 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id fd7-20020a056402388700b0053e07fe8d98sm3391688edb.79.2023.11.13.00.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:55:21 -0800 (PST)
Message-ID: <22b43700-1cdf-9f19-0d01-0f694db5159f@blackwall.org>
Date: Mon, 13 Nov 2023 10:55:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2 7/8] selftests/bpf: De-veth-ize the tc_redirect
 test case
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: kuba@kernel.org, sdf@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-8-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231112203009.26073-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/23 22:30, Daniel Borkmann wrote:
> No functional changes to the test case, but just renaming various functions,
> variables, etc, to remove veth part of their name for making it more generic
> and reusable later on (e.g. for netkit).
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> ---
>   .../selftests/bpf/prog_tests/tc_redirect.c    | 263 +++++++++---------
>   1 file changed, 137 insertions(+), 126 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



