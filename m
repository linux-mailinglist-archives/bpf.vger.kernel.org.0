Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11823EA753
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhHLPRh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 11:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236638AbhHLPRh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 11:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628781431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtzAV9SznvxCWIUzoJ2pSaFsvZKJsWXzbdCtRj/OA38=;
        b=AqrDGW2kJacXKLgShVsLiM0Kwx0QRHok3t8zwMF4pzs5MKbIQbvqRE+N9jqONIXROlKV5u
        8toclFxyWXLAaasUCucT3lJr54aUmgctbFFP+p5eNs2kq7IEgEEi6k86PUga/pFgQUMDfb
        IwOWT9SY77DlDzlKpFB7BDn9vjMNj1w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-d6BQrUIgMNWUfiqBZ-oOcQ-1; Thu, 12 Aug 2021 11:17:09 -0400
X-MC-Unique: d6BQrUIgMNWUfiqBZ-oOcQ-1
Received: by mail-wm1-f70.google.com with SMTP id f6-20020a05600c1546b029025af999e04dso1929332wmg.7
        for <bpf@vger.kernel.org>; Thu, 12 Aug 2021 08:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OtzAV9SznvxCWIUzoJ2pSaFsvZKJsWXzbdCtRj/OA38=;
        b=dX0DRuyjr4aghTcyQfYOumoP480bLhH0AaK82oq3/gYNIB6Fr4f0s2flyJE4zo+6Rq
         wyPu54EwdksvrGDmKzeovUI0NKd32/j9GTzXlaCCaJV6rlLHe5FFRe8lvebsTygIOjEY
         TAJkc5kkfgn5WhlZRZyV/0fik+taouf2+QamQ+m/WtaSN5t5dmPR0xTd5wE4zfbRUDRG
         VOWsTtpQHUXFE1QRmRmMXiV/2k9+7irtgfT4CaGWU4bnGJ7cIrSs0fANZ5JSUCHpiOKy
         YByaeGRQ2y0nIPOefHlVioaXgztBkDpGa/kuYITD5GyySCgvsfqaVy6FvQHnxs47K159
         B6VA==
X-Gm-Message-State: AOAM5323leSvUYA+IwjO+109yE+/2QZXE/htIF9ws3Znqnv7CIpbD6Vi
        S3CJrEWz5288emRZjNJWD8pmZ6HrZ2Yc8xjSKxogryc84dGSsUm4UI1CltZCY8YzudQMfSfEjZj
        uTmR9TUYNdgzO
X-Received: by 2002:a1c:f314:: with SMTP id q20mr16432154wmq.154.1628781428838;
        Thu, 12 Aug 2021 08:17:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgfhiKemqhJFNdNUa30wfwm7+Gv9CMt1jDRYr/2UjeRviuk7iczgvP230DtcLFs6EBZY6k9A==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr16432109wmq.154.1628781428463;
        Thu, 12 Aug 2021 08:17:08 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id k31sm2595939wms.31.2021.08.12.08.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:17:08 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, alexander.duyck@gmail.com,
        linux@armlinux.org.uk, mw@semihalf.com, linuxarm@openeuler.org,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        thomas.petazzoni@bootlin.com, hawk@kernel.org,
        ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, will@kernel.org, willy@infradead.org,
        vbabka@suse.cz, fenghua.yu@intel.com, guro@fb.com,
        peterx@redhat.com, feng.tang@intel.com, jgg@ziepe.ca,
        mcroce@microsoft.com, hughd@google.com, jonathan.lemon@gmail.com,
        alobakin@pm.me, willemb@google.com, wenxu@ucloud.cn,
        cong.wang@bytedance.com, haokexin@gmail.com, nogikh@google.com,
        elver@google.com, yhs@fb.com, kpsingh@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, chenhao288@hisilicon.com
Subject: Re: [PATCH net-next v2 2/4] page_pool: add interface to manipulate
 frag count in page pool
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
References: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
 <1628217982-53533-3-git-send-email-linyunsheng@huawei.com>
Message-ID: <d9bce937-1645-b209-a1d4-c7c0a6fcd1af@redhat.com>
Date:   Thu, 12 Aug 2021 17:17:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628217982-53533-3-git-send-email-linyunsheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 06/08/2021 04.46, Yunsheng Lin wrote:
> +static inline long page_pool_atomic_sub_frag_count_return(struct page *page,
> +							  long nr)
> +{
> +	long ret;
> +
> +	/* As suggested by Alexander, atomic_long_read() may cover up the
> +	 * reference count errors, so avoid calling atomic_long_read() in
> +	 * the cases of freeing or draining the page_frags, where we would
> +	 * not expect it to match or that are slowpath anyway.
> +	 */
> +	if (__builtin_constant_p(nr) &&
> +	    atomic_long_read(&page->pp_frag_count) == nr)
> +		return 0;
> +
> +	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
> +	WARN_ON(ret < 0);

I worried about this WARN_ON() as it generates an 'ud2' instruction 
which influence I-cache fetching.  But I have disassembled (objdump) the 
page_pool.o binary and the ud2 gets placed last in the main function 
page_pool_put_page() that use this inlined function.
Thus, I assume this is not a problem :-)


> +	return ret;

