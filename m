Return-Path: <bpf+bounces-10867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D27AEB53
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F2DFD281D56
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E48226E09;
	Tue, 26 Sep 2023 11:19:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD4266D7
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 11:19:27 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897001B6
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 04:19:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405e48d8cfdso22247635e9.2
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695727160; x=1696331960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blSlydfKxDGQbwIVvTbhiY64+P49XOT7dIrtXFykXEc=;
        b=CkljKGXpoXG+6fsJ/4FiuivjCY+FrBIeEZiqpSa9g3ahZXvjqBvRStWWLV8EjptMYV
         QOCrkEG5lkg8SKbd0z1e2YwSCGD2MFXlsEmu+kX8toegH7nioFSUtcwKRwpP2Rk7lMIg
         JPJUQ7CLVo0CbPpvTaYhKtX0FnGH2DJ4x6FDMMKsSbiMcIKHAcNESUQux+6H2s0QBS1m
         R+KuXQhFQ8UyqtMmTT/A9cOxvvboPR/L6k1QBHsjdD0149Mq/mA8mo2MWlS4HsaoGz++
         D4b+qN/ypD3JO1Yz60EjSjjUFj3u+Km6g7XlZ9Ze09ez8JYZOnX6vOsZr2BNqS7nAxx5
         +Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727160; x=1696331960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blSlydfKxDGQbwIVvTbhiY64+P49XOT7dIrtXFykXEc=;
        b=K28aWX4KelszT3JoXifVXI0bkUF+w7f+/YfYZz1xunFMA8PT4IKVRYeGZ30Tiwlyku
         Fn37qlCuYScHYt7J3JEBqmc4BOLDwTGssfWW4b3z1udfJS4hyka83C1DSD445Mv8lCop
         1276mF5D/xcmmeqR1s1ZqeEy2GovyiG2FnQiRKL7Qg+XJ5RXdf0yF0fqISpXDjolmwXt
         HTtIIkAeVKQcfKE5FXigDx5BJBqa7Ra3EgtKif1eVegBBsQGh36T/dd8jcVpZK6HVs2e
         XtOoR+aM0Tzk1KeRA6Sthg06z7gtcCTxPoUepyh754MNVifP08lUAj2NDKDa05GjuaiI
         n5HA==
X-Gm-Message-State: AOJu0YyXahU/9SsKaXZQj24Zgg0cKgxO20dSPH+hkyqPUCvkA2fYpw4Q
	0bXLamqfTvapsrulzMBUL9gm6g==
X-Google-Smtp-Source: AGHT+IF/PhoSnuwyVXmZzPlZ8hraiQ/1PwaCZsLPDHlnfQl+E1FjIAN+mGK+ua4waYdBbsKJDIEocw==
X-Received: by 2002:a05:600c:230e:b0:3fe:3004:1ffd with SMTP id 14-20020a05600c230e00b003fe30041ffdmr8384203wmo.4.1695727160014;
        Tue, 26 Sep 2023 04:19:20 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:b095:3966:9c75:5de? ([2a02:8011:e80c:0:b095:3966:9c75:5de])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c251200b00401e32b25adsm14870004wma.4.2023.09.26.04.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:19:19 -0700 (PDT)
Message-ID: <7788d9bf-a05b-40b7-ad90-80d15527d072@isovalent.com>
Date: Tue, 26 Sep 2023 12:19:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/8] bpftool: Extend net dump with meta progs
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@kernel.org, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com
References: <20230926055913.9859-1-daniel@iogearbox.net>
 <20230926055913.9859-7-daniel@iogearbox.net>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230926055913.9859-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/09/2023 06:59, Daniel Borkmann wrote:
> Add support to dump BPF programs on meta via bpftool. This includes both
> the BPF link and attach ops programs. Dumped information contain the attach
> location, function entry name, program ID and link ID when applicable.
> 
> Example with tc BPF link:
> 
>   # ./bpftool net
>   xdp:
> 
>   tc:
>   meta1(22) meta/peer tc1 prog_id 43 link_id 12
> 
>   [...]
> 
> Example with json dump:
> 
>   # ./bpftool net --json | jq
>   [
>     {
>       "xdp": [],
>       "tc": [
>         {
>           "devname": "meta1",
>           "ifindex": 18,
>           "kind": "meta/primary",
>           "name": "tc1",
>           "prog_id": 29,
>           "prog_flags": [],
>           "link_id": 8,
>           "link_flags": []
>         }
>       ],
>       "flow_dissector": [],
>       "netfilter": []
>     }
>   ]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!


