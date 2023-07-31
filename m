Return-Path: <bpf+bounces-6400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAB6768BF1
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 08:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3341C20933
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F504430;
	Mon, 31 Jul 2023 06:25:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EC2EDF
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 06:25:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D91E41
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690784728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMHoeLetncmOF6knuHXAEkwDxdPPKbLQBWKiqJmYdTc=;
	b=ChLY3nvtfBuD5SJprpGcwO/kXSasf0hRHZFKZwPW3+pii3N/DTIAvgMBlzr4OhUKGlXqAk
	PgCwW58MhioLMrMjcXg+i8orAAkMuv9eaU95KjWbQ0DbAUn6BgehjoQahdfhwTpjrMpz37
	kxmA4FIdivxs5mnR+cRDB5wXG/9dNYI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-oXfbX1uaNi6pjUZElCKFSg-1; Mon, 31 Jul 2023 02:25:26 -0400
X-MC-Unique: oXfbX1uaNi6pjUZElCKFSg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55c79a5564cso2601903a12.3
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784725; x=1691389525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMHoeLetncmOF6knuHXAEkwDxdPPKbLQBWKiqJmYdTc=;
        b=A07ANtlsM5o0QPwGZ1Oj88STCBnneQNu/900kwqe0pLp1t6AdJY3W4ApG67ma/it8n
         yXT5kJfTOuQoDc7flzSNapjesbwrVdYwIBqOiO6rYFADBp5+9uSFPfSE97yVA0Hccxe4
         412fnM01XjorJJN6I4SjJ8jHKGhqNfN2uJbvvz2A4x8C14wQJUMJ8VHQJ1UDhE3mMKrs
         1fhSrqDKmvvjJVmH9ma5YfbckHwAUDgaOrr+YaewzG9Us5IoHpusjL2RZqoEIdEK+/fw
         SG0spnTtQToyx/Wl4X0RuozCllJQr3SOVqTkzZj47VAz96c3/cdak7DjezNqD7LbzO1W
         qDtA==
X-Gm-Message-State: ABy/qLbMWhEhEtR89qIXCIL84Uv6IoxzLak9ch0ImBk0Xu7KZ9XXhRZV
	7C3Qo6ZVxbUAZVhDqpSMZxbfOuXX+ukpqGDbRQXz0DNmnHGEM8HMN3ycJ9PArhn8uTGiy1lZQ/e
	7hjVPjbzJgd5T
X-Received: by 2002:a05:6a20:1614:b0:13a:12c2:359e with SMTP id l20-20020a056a20161400b0013a12c2359emr9170173pzj.2.1690784725064;
        Sun, 30 Jul 2023 23:25:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFhdNonBuhx20H74nszcdmRPVMO19vB0iyTVH6P4jjKCSyrny8LhZooWAfIJTGU+TRmQj5JDQ==
X-Received: by 2002:a05:6a20:1614:b0:13a:12c2:359e with SMTP id l20-20020a056a20161400b0013a12c2359emr9170152pzj.2.1690784724776;
        Sun, 30 Jul 2023 23:25:24 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x25-20020a056a00271900b00653fe2d527esm6799503pfv.32.2023.07.30.23.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:25:24 -0700 (PDT)
Message-ID: <fd3457bc-b16a-680a-0bed-80cc8505a4cc@redhat.com>
Date: Mon, 31 Jul 2023 14:25:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jiri@nvidia.com, dtatulea@nvidia.com, gavi@nvidia.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
 <20230728014601-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230728014601-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/7/28 13:46, Michael S. Tsirkin 写道:
> On Thu, Jul 27, 2023 at 03:28:32PM +0200, Paolo Abeni wrote:
>> On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
>>> Add interrupt_coalesce config in send_queue and receive_queue to cache user
>>> config.
>>>
>>> Send per virtqueue interrupt moderation config to underlying device in
>>> order to have more efficient interrupt moderation and cpu utilization of
>>> guest VM.
>>>
>>> Additionally, address all the VQs when updating the global configuration,
>>> as now the individual VQs configuration can diverge from the global
>>> configuration.
>>>
>>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> FTR, this patch is significantly different from the version previously
>> acked/reviewed, I'm unsure if all the reviewers are ok with the new
>> one.
>>
>> [...]
> still ok by me
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> let's wait for Jason too.


I'm fine with this series (I've acked each patch).

Thanks


>
>>>   static int virtnet_set_coalesce(struct net_device *dev,
>>>   				struct ethtool_coalesce *ec,
>>>   				struct kernel_ethtool_coalesce *kernel_coal,
>>>   				struct netlink_ext_ack *extack)
>>>   {
>>>   	struct virtnet_info *vi = netdev_priv(dev);
>>> -	int ret, i, napi_weight;
>>> +	int ret, queue_number, napi_weight;
>>>   	bool update_napi = false;
>>>   
>>>   	/* Can't change NAPI weight if the link is up */
>>>   	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
>>> -	if (napi_weight ^ vi->sq[0].napi.weight) {
>>> -		if (dev->flags & IFF_UP)
>>> -			return -EBUSY;
>>> -		else
>>> -			update_napi = true;
>>> +	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
>>> +		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
>>> +						      vi->sq[queue_number].napi.weight,
>>> +						      &update_napi);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (update_napi) {
>>> +			/* All queues that belong to [queue_number, queue_count] will be
>>> +			 * updated for the sake of simplicity, which might not be necessary
>> It looks like the comment above still refers to the old code. Should
>> be:
>> 	[queue_number, vi->max_queue_pairs]
>> 			
>> Otherwise LGTM, thanks!
>>
>> Paolo


