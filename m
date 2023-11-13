Return-Path: <bpf+bounces-14978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8836C7E981E
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 09:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18269B2089F
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86A179BF;
	Mon, 13 Nov 2023 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xCwCj5um"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C21643A
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 08:54:13 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865410CB
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:54:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so6369057a12.2
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699865650; x=1700470450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GhVFOAud6C2kmUls1Zl3/W0eEf2pOOcavcbz6IFy+c=;
        b=xCwCj5umqmEb7y+0wVk4rFlx/AlKwcUgYRveXNgmMCwjfPy+MgkT1riCHxg2Fwjqpg
         f8VfhdC43v9Fq+KgQohIlgT+1J7CbOLthcnRdVDTIG0Sw5Mkme1d8qSS4Iti5Ct+JNoC
         rTbOf9s5TB5FmTuCxmSeapH0sdpl3mrmYzGbNtbyk1A1j13u5zK41Xu2haZt5jjvXBTw
         9+RGXcaLgjN2aHdwROwewZjs8K5IQOK3Axs0WmaRtKQfCY1OS3sQ/tgK/TNTOkv8wIfW
         a24//GkHRh6/t4M0dLcu0UCdOAaZ/azviQ+XzKWhwGavEaI4OBVvrcK6hyM0Qk7W26vB
         Sb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865650; x=1700470450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GhVFOAud6C2kmUls1Zl3/W0eEf2pOOcavcbz6IFy+c=;
        b=LeiBQ0jLG/pyeUk1k9NywsgTdbwH2fdYkPrhRgOvJHmoyjgEOw99z+o4BD5fM3Wd9O
         Jl7TffbaMnPnykbCG9DlfVTWClIxeWGoYytINNt+CoCOXLgrCFhDiD5OwZ86ZT5Yn7Ly
         kRGvRb1al+DCiZrjB/DP7IssYdkH3p/gyi1z5SR5MKG6qNnhRQdlgwrDQC2C2hF0BdpJ
         Lw9SbVdxeRi+6mtWiF/kR3XUrX7ZC10EOAgMEzhVPWklOOb2DvTcDzNbWsEUQ2iceDjS
         5YcQGbiYInetabQ6wKC9zl6yH1M0pNBZU+2/GOMOomYQfV1OJKx52dgdd7e2xYEZE5z+
         iLYA==
X-Gm-Message-State: AOJu0YxSn+VD7rrzzoVut9b0POcwZ9TiwnoIdhF2TC8yXuRvoYQ6eGcI
	UlpBBoW2WhwFh5OQ8x3toTLGtA==
X-Google-Smtp-Source: AGHT+IEFLMLuTthTWwmjFArnRofSYthKA+bIP9sbKD5FFcH11CglCf4hP24jd5g76IJc/Y4qav85ng==
X-Received: by 2002:a05:6402:40e:b0:53e:7d60:58bb with SMTP id q14-20020a056402040e00b0053e7d6058bbmr4048922edv.27.1699865650517;
        Mon, 13 Nov 2023 00:54:10 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id u9-20020a50c2c9000000b0053e8f1f79afsm3437460edf.30.2023.11.13.00.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:54:10 -0800 (PST)
Message-ID: <ca3d37f3-0e3c-8aff-7dac-905e0264a3a6@blackwall.org>
Date: Mon, 13 Nov 2023 10:54:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2 5/8] bpf: Fix dev's rx stats for bpf_redirect_peer
 traffic
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: kuba@kernel.org, sdf@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Peilin Ye <peilin.ye@bytedance.com>,
 Youlun Zhang <zhangyoulun@bytedance.com>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-6-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231112203009.26073-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/23 22:30, Daniel Borkmann wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> Traffic redirected by bpf_redirect_peer() (used by recent CNIs like Cilium)
> is not accounted for in the RX stats of supported devices (that is, veth
> and netkit), confusing user space metrics collectors such as cAdvisor [0],
> as reported by Youlun.
> 
> Fix it by calling dev_sw_netstats_rx_add() in skb_do_redirect(), to update
> RX traffic counters. Devices that support ndo_get_peer_dev _must_ use the
> @tstats per-CPU counters (instead of @lstats, or @dstats).
> 
> To make this more fool-proof, error out when ndo_get_peer_dev is set but
> @tstats are not selected.
> 
>    [0] Specifically, the "container_network_receive_{byte,packet}s_total"
>        counters are affected.
> 
> Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
> Reported-by: Youlun Zhang <zhangyoulun@bytedance.com>
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   net/core/dev.c    | 8 ++++++++
>   net/core/filter.c | 1 +
>   2 files changed, 9 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



