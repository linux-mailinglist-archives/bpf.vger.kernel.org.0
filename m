Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057A13A08F2
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 03:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhFIBXu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 21:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhFIBXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 21:23:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F37FC061574
        for <bpf@vger.kernel.org>; Tue,  8 Jun 2021 18:21:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so8697448otk.5
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 18:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y6Sf8Jv0N7POQmB4EyIVfvtd1V1hAVT8XZQEUZpAR3E=;
        b=bIIHwJMK9rdMQp0UcUzewm/tOzcGDZ2NFp8xDnvz4hZj3/3dbPfZ3r2gCPea9dXUSc
         +bbUjOWVW1tS5QVIGHuhwXqeI4Bxl56WqrnDF9l1dnvQGN5b1rbjUPWLXNd36jFxvtOb
         84m8M8zzrlCuncX2OHp9dPABqO1XpejXYwUBvXHSi8nYE2ywNxuISUa1aotnV0x466y+
         dtQrjkd+ySeVnDE4/wyk6PQklchUgfdvGs9KpHTX6T9K4aN+lRhrAKocI1HAuU3z3C9l
         6Vh1SiIGZxqVC+rmTBClyLU/N5HTsX/tPiT/HkAbLlft7t/D14NZP0gy2htVSnnBRGY2
         EvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y6Sf8Jv0N7POQmB4EyIVfvtd1V1hAVT8XZQEUZpAR3E=;
        b=NyoqRpf42J7giKIbDwIqmCE3+uSKuelH7igZWBaEQOFjpH6qNJU4KFT9Xr7zk0pNvH
         OU+AtfujfV8aWdj13fWuhP2j3E9IX2SQ5spxgwzWsIG2FTPHxD88tnAAGPxhVO34jLcT
         HGR2p1qJYyLB8FhgsSM1UqsNhC+0h/x/LTKHGZyiOa45rBFRmKgp+MFHTlJVCwKJAuIO
         plj/3zkkgvEj23vI43gHtV8w7FutzPgmSmVENA4Y6kGcuHe1/Fco2LoN1Sx6U/BDjFT9
         rJWDBwweVmsnczSrKUuuxoM79ev7A+5HL9Y8hI4FL596Q6cRmyRNiIvsObUL+Hkrw4YV
         59Mw==
X-Gm-Message-State: AOAM530CdaOpNlpXMCTF8YhsTNH4odIq94hSGnB/HxyQV8OWcGRN7Hn9
        BdkwD+0EXQQh/Q2K+YN7iekWJ4obrEY=
X-Google-Smtp-Source: ABdhPJxgCaOx6D04ZHAooONP9PZ0bvNdImG+NGTF8qyPB8q3+6z1hIkiiLB3VuBngIDXIiO9Bja6Pw==
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr553083otq.73.1623201699381;
        Tue, 08 Jun 2021 18:21:39 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.22])
        by smtp.googlemail.com with ESMTPSA id c205sm3157223oob.38.2021.06.08.18.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 18:21:39 -0700 (PDT)
Subject: Re: bpf_fib_lookup support for firewall mark
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
        bpf@vger.kernel.org
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
Date:   Tue, 8 Jun 2021 19:21:38 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/8/21 4:59 PM, Rumen Telbizov wrote:
> Dear BPF list,
> 
> I am new to eBPF so go easy on me.
> It seems to me that currently eBPF has no support for route table
> lookups including firewall marks. The bpf_fib_lookup structure itself
> has no mark field as per
> https://elixir.bootlin.com/linux/v5.10.28/source/include/uapi/linux/bpf.h#L4864
> 
> Additionally bpf_fib_lookup() function does not incorporate the
> firewall mark in its route lookup. It explicitly sets it to 0 as per
> https://elixir.bootlin.com/linux/v5.10.28/source/net/core/filter.c#L5329
> along with other fields which are used during the regular routing
> policy database lookup.
> 
> Thus lookups from within eBPF and outside of it result in different
> outcomes if there are rules directing traffic based on fwmark.
> Can you please advise what the rationale for this is or if there
> anything that I might be missing.
> 
> Let me know if I can provide any further information.
> 

The API (struct bpf_fib_lookup) is constrained to 64B for performance.
It is not possible to support all of the policy routing options that
Linux has in 64B. Choices had to be made.
