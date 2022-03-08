Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB84D1C22
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiCHPo0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 10:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345557AbiCHPoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 10:44:25 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952E35DEC
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 07:43:27 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g19so6097934pfc.9
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=NKwIWMJN7+i0XAg6jLVO6Lxt5C5EwTCBUXnqdpcor6s=;
        b=fnXsdHWHw7mUsqGMsNQNYtwM7WylTiW27BpmCbqF6a95dLCwqgprMTmy8V63gQPQbb
         NGmTURhW09sZZieeNdO1PTsTT3kfjlYZev9v2Dd8g788Zwc3ZQGO9PB8zjvRR1Y8lVkL
         RQADxtnVDXTyS93mSxYM8hZSMbuKYd+FvzHg5EeEXO8g8X0/x/QnHuForGl/gyKs1wyY
         Q0PefRyAz8WKQpft4VUqB1vEvNuVNJVXzAu3y5b6IvETnV1nwiSbOIqwEI0zDC1QO73+
         ijFdkRVbtkV2OoxqTiGG2GGgcEdUUVidzsEIgV4wq79lVTUmkWahXHyR24x8SGfc8bv1
         WgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=NKwIWMJN7+i0XAg6jLVO6Lxt5C5EwTCBUXnqdpcor6s=;
        b=giWp4KvNYvAgpGMXvDAI++/fRv3MBK46ciLTGNvqjltnvTKfdG1OsQMZlLu4AwK3/x
         difZjFpX0J+5rkx1Tp+TRYfAmT7zfpYgvqyvHdgul+Xxh0YFAnKHjBElHWFQjMDkoFPt
         ikm7X49af04bKpHZQs/D/q+BcFAmxoqYKjb0Dyv1tDPNU8XaeXY9mBi57MBY+1AyfqDm
         7XCPIlsZnwLqW4tDwUyEtzo24QWbuAEz62qRrkSL7S2Q38XnitFMPvDDRbUCSGpb7AOs
         MwpYWHLPWdHP+XCoggMgHh8YM3X+owT8D6StfkQxnhHUIbBl3q8o+bG+Eck+o5fyHL7l
         wx/w==
X-Gm-Message-State: AOAM5318czawdekgkMsLKRtJl9OmfL1nozucwcHez7LsRBa4pV0yNr3b
        /4KsggJeOkYT0UFCCHIRRYkC2w==
X-Google-Smtp-Source: ABdhPJwiFpX6DdpatCjywFz/zgNVGeCJCOcO+1z4NGPqQXYELIrHV0oRR8uxO502R5Zie6fawLTSqw==
X-Received: by 2002:a63:d642:0:b0:378:a4c2:7b94 with SMTP id d2-20020a63d642000000b00378a4c27b94mr14559338pgj.218.1646754207291;
        Tue, 08 Mar 2022 07:43:27 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id nl9-20020a17090b384900b001bccf96588dsm3534648pjb.46.2022.03.08.07.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 07:43:27 -0800 (PST)
Message-ID: <6155b68c-161b-0745-b303-f7e037b56e28@linaro.org>
Date:   Tue, 8 Mar 2022 07:43:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com" 
        <syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com>
References: <20220308000146.534935-1-tadeusz.struk@linaro.org>
 <14626165dad64bbaabed58ba7d59e523@AcuMS.aculab.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] net: ipv6: fix invalid alloclen in __ip6_append_data
In-Reply-To: <14626165dad64bbaabed58ba7d59e523@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,
On 3/7/22 18:58, David Laight wrote:
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index 4788f6b37053..622345af323e 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -1629,6 +1629,13 @@ static int __ip6_append_data(struct sock *sk,
>>   				err = -EINVAL;
>>   				goto error;
>>   			}
>> +			if (unlikely(alloclen < fraglen)) {
>> +				if (printk_ratelimit())
>> +					pr_warn("%s: wrong alloclen: %d, fraglen: %d",
>> +						__func__, alloclen, fraglen);
>> +				alloclen = fraglen;
>> +			}
>> +
> Except that is a valid case, see a few lines higher:
> 
> 				alloclen = min_t(int, fraglen, MAX_HEADER);
> 				pagedlen = fraglen - alloclen;
> 
> You need to report the input values that cause the problem later on.

OK, but in this case it falls into the first if block:
https://elixir.bootlin.com/linux/v5.17-rc7/source/net/ipv6/ip6_output.c#L1606
where alloclen is assigned the value of mtu.
The values in this case are just before the alloc_skb() are:

alloclen = 1480
alloc_extra = 136
datalen = 64095
fragheaderlen = 1480
fraglen = 65575
transhdrlen = 0
mtu = 1480

-- 
Thanks,
Tadeusz
