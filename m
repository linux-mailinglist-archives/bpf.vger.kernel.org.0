Return-Path: <bpf+bounces-6399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3409F768BED
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 08:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C3D1C2093C
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9C111D;
	Mon, 31 Jul 2023 06:24:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1E7F8
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 06:24:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D08E40
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690784689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
	b=EOjUm+AEuwGSBkZRIW/U0vv154tagMLrmO0ZAjyz/BxVRdPmLupoVbNNdR9cXjYLpdGE+l
	IUII2ji9Vb5B3+2mfKlgxFUx/hvDvkEt0Q5F4BkGBN/UTGu6qPvnOEq0bruhx2fMpruF5T
	qEgajum/RpDtbFkg6xOCntoBkyf0UaI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-0SgwFaXyMx6hpjMdtCn24g-1; Mon, 31 Jul 2023 02:24:44 -0400
X-MC-Unique: 0SgwFaXyMx6hpjMdtCn24g-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6871c35ac54so1939938b3a.2
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784684; x=1691389484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
        b=f+GPbFPCtvgmfBbTBK0w5mnxHFfa02cKShHkuZPpYl590umKiPWUAfK1ruOM8x9XjN
         DRiEjOAvb8XNjJhE1AX+dKOH5oOwoL9rUD9EiMIm2jUHFrzcDIST0uBj5+G3yObbZNV/
         I2idaQsE38H7qON3DJpdvdRjldGoUP4uSERnOm5QrxgwJB1ohP+3a/bTSqVcmHdU8Isb
         eB3MXPovW+a2Cu2lf0qMc++hPzwooWaygo6tAhkinvCz11oDcg2atQ+95+fvuDqaOP5h
         eeAE0rofwc4kyV1bH5JI/ok9qQjCabiDX9TY+52MK/2e7JhAZkbRgdLjw4QUC2C1vesY
         d1MQ==
X-Gm-Message-State: ABy/qLaGWDH8ku24Y6MFSzUrSW6T1m2wWuxMUvarfkJtA+TnZSwm4Ywo
	x5ePZxZuckPTeBgKmCenRtO6nt5Nxv/409hJqHhPllc9iTgQhy8ERWY6h6hm/sozSGJU0g+4Ciw
	N1iD9DFINFKZo
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id y2-20020a056a00190200b0068256343df1mr10454908pfi.10.1690784683941;
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7hRSrqGoCxMOCQEWdDDgEVMWsydvLGR7y6jP66LSsLJaoK1Qrd924k7OelmyerHuJSUgtvg==
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id y2-20020a056a00190200b0068256343df1mr10454894pfi.10.1690784683710;
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78247000000b0066f37665a63sm1200909pfn.73.2023.07.30.23.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Message-ID: <bd76081f-e6d3-ee60-a2de-cacd3e40563d@redhat.com>
Date: Mon, 31 Jul 2023 14:24:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 3/3] virtio_net: enable per queue interrupt
 coalesce feature
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-4-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-4-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/7/25 21:07, Gavin Li 写道:
> Enable per queue interrupt coalesce feature bit in driver and validate its
> dependency with control queue.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


