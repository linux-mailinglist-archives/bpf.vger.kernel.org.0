Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0073A2E67
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhFJOji (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 10:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhFJOji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 10:39:38 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C4C061574
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 07:37:26 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x196so2329556oif.10
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5aiXUaiek/UWuyfUg6WY7U1Pnjon8D3Uxbgq3q2H+/w=;
        b=ZiyIjda2WYGE0RPJ3ppfnLdu7WZ4cABreUHDruYYyzj5tntHZIgNnFIBoxTBRAa3e4
         4/3KS/8lLIpPstRuC6dEXsLte5gzCgaatFbsJpElM21EzJNnN7S6Qx9kncfDGGj++Xxz
         6vbF9NwXA/sUjd3uftcS2SoR6yAgB0dSyQZ6ldxFRytOXyaOqSLQwoP+xExSwwm+dp6+
         /dM0BRN8GtIrc7MM5m5vJEtHVqOpjG8QIe9+XztVa79mnutwpeG7ewkHfV2dA1NNoLJE
         W7BwBQsIUHvHGv3eUGB1qrLA++VN6yrdP90Jc+PPaQxx7jz7pcMn5f9AxYCozkTMTevQ
         vMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5aiXUaiek/UWuyfUg6WY7U1Pnjon8D3Uxbgq3q2H+/w=;
        b=ApHfmt5s0xDMrCGJ/79ERb4Sd1H9zTATuE/bmm+y2sLFAnlP3uzhlhME7e/3rM0mDP
         Q3U1xsZBS+W04Hj4myTndwe6PaPEpxn7CccAGgyGshu9p5rfx0hZdS2kbOHRqqGMSOKG
         uJiXhpy3ippmxnpCJoxSeY6iM0+/A4tckhE320/9KqBFLRBjsQQpVWfX11ND+WKtvsal
         ve6QpPShRmiQaZ5hiAKLxwwCRLcozVLsl0AMGNMQt12O/T+ItlRfF9RibTyDv0WxqZdt
         ORoYAoXNl8HWHADOqW9Snqw13/QMyItoaJ+kS93XCnEUm3Uvv2UIdq6TunuZLjmOWD5k
         4oRQ==
X-Gm-Message-State: AOAM532IB2ZU7ZpPJwE7f1EymOunnf48UzYiWsh/MmqokhYdS2b3mRSe
        7KW8IsfX2hf02RSaAZTz9ec=
X-Google-Smtp-Source: ABdhPJxZfNoXQODrK5gk01pw+VHd8cKipqQiY+aDMp/91XSt821nqJDWVLPKtKRBWn9pXY4Hv+Vg9g==
X-Received: by 2002:aca:6041:: with SMTP id u62mr1017075oib.23.1623335845673;
        Thu, 10 Jun 2021 07:37:25 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.22])
        by smtp.googlemail.com with ESMTPSA id f2sm558739ooj.22.2021.06.10.07.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 07:37:25 -0700 (PDT)
Subject: Re: bpf_fib_lookup support for firewall mark
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
 <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
Date:   Thu, 10 Jun 2021 08:37:23 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/9/21 4:08 PM, Daniel Borkmann wrote:
> Hi Rumen, hi David,
> 
> (please avoid top-posting)
> 
> On 6/9/21 11:56 PM, Rumen Telbizov wrote:
>> List,
>>
>> For what it's worth I patched the structure locally by introducing a
>> new __u32 mark field
>> to the structure and adding the proper assignment of the field in
>> filter.c. Recompiled without any issues.
>> With that patch a bpf lookup matches ip rule that contains fwmark.
>>
>> Still interested to know how much of a performance penalty adding an 4
>> bytes to the
>> structure brings. I'd certainly vote for adding at least the firewall
>> mark to the set of fields used in the lookup.
> 
> I agree with David here that performance of the helper is paramount.
> As a side-note, we should probably add a build_bug_on() to ensure that
> the size of struct bpf_fib_lookup will stay at 64b / one cacheline.

that's the key point on performance - crossing a cacheline. I do not
have performance data at hand, but it is a substantial hit. That is why
the struct is so overloaded (and complicated for a uapi) with the input
vs output setting.

Presumably you are parsing the packet to id a flow to find the mark that
should be used with the FIB lookup. correct? Hardware hints will make
that part easier whenever that feature actually lands and if the NIC can
add the mark.

> 
> That said, given h_vlan_proto/h_vlan_TCI are both output parameters,
> maybe we could just union the two fields with a __u32 mark extension
> that we then transfer into the flowi{4,6}?

That is one option.

I would go for a union on sport and/or dport. It is a fair tradeoff to
request users to pick one - policy routing based on L4 ports or fwmark.
A bit harder to do with a straight up union at this point, but we could
also limit the supported fwmark to 16-bits. Hard choices have to be made.

