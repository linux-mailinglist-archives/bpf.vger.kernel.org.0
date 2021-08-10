Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF53E5DD7
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhHJOZa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243567AbhHJOYU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 10:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628605438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7NGeCuOaubYuz/1ug/TSUdVrfsBtP6E2aZrsDudCso=;
        b=Ms/028kDqtyKBiPIQEdFIQQHSNmtl3cdIeGGZDXDBiVXMqhyOjnUGpjOl5p/mGc2ppMsV6
        26dJ9GylDnzVIuJd5dnmG/VbcFctKbnTyXmLFAKvk1S3NL+c1z3WOf8o3tYLe3qNj3bO8Q
        EOjc0TlSrpjO4ZUpKNlfUppD3Du+mAg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-eLlNzdgiMpyWqe3UoBD_yA-1; Tue, 10 Aug 2021 10:23:57 -0400
X-MC-Unique: eLlNzdgiMpyWqe3UoBD_yA-1
Received: by mail-wr1-f72.google.com with SMTP id y12-20020adfee0c0000b0290154e82fef34so2234687wrn.6
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 07:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7NGeCuOaubYuz/1ug/TSUdVrfsBtP6E2aZrsDudCso=;
        b=ZV1V+K9GFbX3r4SeB5gjQiPs+e29VyS4IpmdrALTKtpx8+LTo7xdVg+IZPxJt0YK3r
         ipMw+WzDF+tVWS/KBFjGb0T3Wa3IS4BMWzm2c1GuDQgiG1WTJ/KhSenQHMk/mbKMIB9H
         pTdyKRaIU8sSipMcClO+hwqQbzmwlvOHfwgm0yysU1U5KIVxsH9qCqj3qCw1JimQsvbE
         LaGHgW5sdP27T3V76b/m2MqeyD4Q/BqbQXaxrGf8nE6/klo5HbkYqR6brWwryX2cUw5J
         zyrznh6ll2axPfgEAsqFhaACjoQiB4bQk7KUVOzWIX4B9ALASHqc1lp8JDAuA8ek9CG/
         xEGA==
X-Gm-Message-State: AOAM533WnM8FqHM2o9tslErKzIhM/YJm/DaP4S909HWUku03S1Wgwzhx
        6yBvGGRi5ErKRVkBYR02f8yVMtlg7HJY4T2sfupNP70Sk2xgURBWfvGxA+TQEPIvmqSnLwwVHJw
        HJrg4kZTfWaXw
X-Received: by 2002:adf:f4c5:: with SMTP id h5mr31939798wrp.292.1628605435931;
        Tue, 10 Aug 2021 07:23:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU5KywGRiCQymuIhkLmnRCVk61+rHhGXtUMqK/2zRivVoqzIKMeSsCmj59NACGItvmK39weg==
X-Received: by 2002:adf:f4c5:: with SMTP id h5mr31939741wrp.292.1628605435752;
        Tue, 10 Aug 2021 07:23:55 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id d4sm9044243wrc.34.2021.08.10.07.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 07:23:55 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, davem@davemloft.net, alexander.duyck@gmail.com,
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
        bpf@vger.kernel.org, chenhao288@hisilicon.com,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH net-next v2 0/4] add frag page support in page pool
To:     Jakub Kicinski <kuba@kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>
References: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
 <20210810070159.367e680e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <1eb903a5-a954-e405-6088-9b9209703f5e@redhat.com>
Date:   Tue, 10 Aug 2021 16:23:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810070159.367e680e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/08/2021 16.01, Jakub Kicinski wrote:
> On Fri, 6 Aug 2021 10:46:18 +0800 Yunsheng Lin wrote:
>> enable skb's page frag recycling based on page pool in
>> hns3 drvier.
> 
> Applied, thanks!

I had hoped to see more acks / reviewed-by before this got applied.
E.g. from MM-people as this patchset changes struct page and page_pool 
(that I'm marked as maintainer of).  And I would have appreciated an 
reviewed-by credit to/from Alexander as he did a lot of work in the RFC 
patchset for the split-page tricks.

p.s. I just returned from vacation today, and have not had time to 
review, sorry.

--Jesper

(relevant struct page changes for MM-people to review)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 52bbd2b..7f8ee09 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -103,11 +103,19 @@ struct page {
  			unsigned long pp_magic;
  			struct page_pool *pp;
  			unsigned long _pp_mapping_pad;
-			/**
-			 * @dma_addr: might require a 64-bit value on
-			 * 32-bit architectures.
-			 */
-			unsigned long dma_addr[2];
+			unsigned long dma_addr;
+			union {
+				/**
+				 * dma_addr_upper: might require a 64-bit
+				 * value on 32-bit architectures.
+				 */
+				unsigned long dma_addr_upper;
+				/**
+				 * For frag page support, not supported in
+				 * 32-bit architectures with 64-bit DMA.
+				 */
+				atomic_long_t pp_frag_count;
+			};
  		};
  		struct {	/* slab, slob and slub */

