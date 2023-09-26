Return-Path: <bpf+bounces-10866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745F87AEB52
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 13:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id D655B1F25992
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8626E0C;
	Tue, 26 Sep 2023 11:19:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607826E13
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 11:19:14 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88E19E
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 04:19:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053d53a1bfso73927475e9.1
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695727151; x=1696331951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAiUF9COhUnSV5CskLp3xa2oyqn65S8obQLUErLGtts=;
        b=EufUOFbBNskcC3jR3kSged+7nTzsTWkjYk175mkGbdnm/oaqWN5erNH5as77i9rCnN
         nve0sbHY95L+ESdCVl8J5gmKZaJsEPPQlulBt9ZzYbSogX1z7D3zXhlbpWyCRZpAVYB9
         JxQsy2iLwbYOtvp1e0fYkub891qIeB8lGhTyFl/roLZvP6pYCX51Wv7SUpyruZgg2bvn
         KCkrU/viTjK6kSceiVcfVYoT3YIQ7J+hc5Xim3f0Ywlzny23AwjGkn6uARovqUyWxGRO
         OMDpLNRSd4fH1CNvZVTLHG4mWMvCN/8AXQA7hSbadA+SCJhJL1GX6n8dg+7Qbw8fdPWI
         U+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727151; x=1696331951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAiUF9COhUnSV5CskLp3xa2oyqn65S8obQLUErLGtts=;
        b=c5KBVjtABo5lIj2XOIqeOyaJaW0iLaHyXpBvJ2DIb8wVNYiM19e4mnN8ncA46ZBy3U
         GY0kfTcgictYLBPoprvSQ6ZPEzQ+OhpWbT9UDsvhbRDHSpGGG0pc8qCsxtxDdVS231NB
         a1cG7N9ZW9MXlETiBC2dakuIpps9Dpd0C4qzha4BLqYZAPDY+X4qOkUFNy3XNwgveXUL
         JJ6/cHQfV4Ivim6dAyal/+OEWXb3jzcX/qICiEGS+mUdUd6i1AB9MEOOMEWMAdQS474H
         gAzdF74VO8HKZWOWeQ+44MEhMRr/RjYpOnZDRfX1scVFsj0AS5QThfCIhvR1RH3/a/K6
         9aXA==
X-Gm-Message-State: AOJu0YwyK2njCmbmp+5e5KTiQrY7iAVZzf4ECN5ywRzjCmy0R3snQBtt
	xNRsxmIYyc+amWmXQx4z5Cys2Q==
X-Google-Smtp-Source: AGHT+IF8/4q3XX1B4HiXH/ulTfTZs4/xt5J5Q5gfD5BogKT0fh9MyQPGyAb9MreH93E1VLqJHTRmjw==
X-Received: by 2002:a05:600c:1c90:b0:405:9450:dda6 with SMTP id k16-20020a05600c1c9000b004059450dda6mr4412369wms.22.1695727150907;
        Tue, 26 Sep 2023 04:19:10 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:b095:3966:9c75:5de? ([2a02:8011:e80c:0:b095:3966:9c75:5de])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c251200b00401e32b25adsm14870004wma.4.2023.09.26.04.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:19:09 -0700 (PDT)
Message-ID: <e8b49f3c-e950-4b8e-8169-daa6ffeb596c@isovalent.com>
Date: Tue, 26 Sep 2023 12:19:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/8] bpftool: Implement link show support for
 meta
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@kernel.org, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com
References: <20230926055913.9859-1-daniel@iogearbox.net>
 <20230926055913.9859-6-daniel@iogearbox.net>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230926055913.9859-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/09/2023 06:59, Daniel Borkmann wrote:
> Add support to dump meta link information to bpftool in similar way
> as we have for XDP. The meta link info only exposes the ifindex.
> 
> Below shows an example link dump output, and a cgroup link is included
> for comparison, too:
> 
>   # bpftool link
>   [...]
>   10: cgroup  prog 2466
>         cgroup_id 1  attach_type cgroup_inet6_post_bind
>   [...]
>   8: meta  prog 35
>         ifindex meta1(18)
>   [...]
> 
> Equivalent json output:
> 
>   # bpftool link --json
>   [...]
>   {
>     "id": 10,
>     "type": "cgroup",
>     "prog_id": 2466,
>     "cgroup_id": 1,
>     "attach_type": "cgroup_inet6_post_bind"
>   },
>   [...]
>   {
>     "id": 12,
>     "type": "meta",
>     "prog_id": 61,
>     "devname": "meta1",
>     "ifindex": 21
>   }
>   [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

