Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59218406F8B
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhIJQUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 12:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhIJQUU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 12:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631290747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCmmhYCPvZGsQCildcllyAD8h6CmMr1J1+mjHiwFbv8=;
        b=bine9hFo8wshVyIyXxFmWpAkhUkYfK8jtxNy2ip4RbxJWFSiDMSrLB5T0WQp+KiP6bcjv/
        RLoX9yYapoeOThJD0CVSqhL9CTyQj4PGztd7IANfJTcz7dRkD5uNgLwvfL5d515LUZ6ZBR
        MwOj+Mc4iRiVOyKHrxxyaRjlqVeA0aM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-KtAZoqapPsevy_Z9izyVaA-1; Fri, 10 Sep 2021 12:19:05 -0400
X-MC-Unique: KtAZoqapPsevy_Z9izyVaA-1
Received: by mail-lj1-f197.google.com with SMTP id s15-20020a2eb8cf000000b001cbf358ed4eso1134844ljp.14
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 09:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCmmhYCPvZGsQCildcllyAD8h6CmMr1J1+mjHiwFbv8=;
        b=BvgzOMlA7YvqIJs66S9F+N02MCBz7/n1Thh1t5uyxluwA5zSPws27m1wFS5e4bMXgN
         GcWTM1fKwfNO2XBO8Ei4sgt+TzfAkq4q7gtNWT/WLysdA2fVMpQqnHl0DomClcNh6wL1
         f2iKbqNJgapK6x8QccZw49uWM+paw0TfW1j6BKOM5eEp98BED0Rsetlx3ayKmrVjKTwx
         z2N/tWyr+ZjB86udWipp9ZH0EOS+SsVyzPSY/eb0TS3dbU+fPbB78my/nfrsSPoKQy8f
         hCV1FHZtpIbxwCLqy+kmAnotopWh5mBVQTZi8VClqPj0LBjYm5Nu6c8+d7KKmfqZDzmX
         kaiA==
X-Gm-Message-State: AOAM530XZ75Mdzg8mTDROZOlGJAj/CUlEs8Jky5RCAvO8wOKN14LWTOw
        PJAiZskLqCpbQoh3JqcMcxawW15XqXuPglrq7wfpZFaeHX4cWBBc1Bj+BoVq2+LRLY+uBDNUGVE
        VVNZ2ApimKon/
X-Received: by 2002:a05:6512:169b:: with SMTP id bu27mr4660361lfb.578.1631290744204;
        Fri, 10 Sep 2021 09:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzim6Euy/3NCFRnAiZtE9Q36wCG3/lp0JG3DrZgW43gzrdDOJ2Bf+M+9QprRsrpPnvVFV6h/A==
X-Received: by 2002:a05:6512:169b:: with SMTP id bu27mr4660341lfb.578.1631290743980;
        Fri, 10 Sep 2021 09:19:03 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id h13sm597384lfv.62.2021.09.10.09.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:19:03 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, john.fastabend@gmail.com,
        dsahern@kernel.org, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v14 bpf-next 02/18] xdp: introduce flags field in
 xdp_buff/xdp_frame
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <cover.1631289870.git.lorenzo@kernel.org>
 <b74dac5c5bfe5115dd777d0eafcb0c3c21853348.1631289870.git.lorenzo@kernel.org>
Message-ID: <edf63174-dc00-fb1c-e467-5a1522783cde@redhat.com>
Date:   Fri, 10 Sep 2021 18:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b74dac5c5bfe5115dd777d0eafcb0c3c21853348.1631289870.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 10/09/2021 18.14, Lorenzo Bianconi wrote:
> Introduce flags field in xdp_frame and xdp_buffer data structures
> to define additional buffer features. At the moment the only
> supported buffer feature is multi-buffer bit (mb). Multi-buffer bit
> is used to specify if this is a linear buffer (mb = 0) or a multi-buffer
> frame (mb = 1). In the latter case the driver is expected to initialize
> the skb_shared_info structure at the end of the first buffer to link
> together subsequent buffers belonging to the same frame.
> 
> Acked-by: John Fastabend<john.fastabend@gmail.com>
> Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> ---
>   include/net/xdp.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

