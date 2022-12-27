Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1D65677E
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 07:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiL0GbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 01:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0GbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 01:31:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7883C41
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 22:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672122622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc5Wpn8Yna8TiyVEifGU6eJKuOo4jmiPUeXEpNoa60I=;
        b=hHRs5Ptr3vQQanDqzO8Cy7NlAku5c7DwzcdYEOyWn0zthNZ5cMeUpp7NjCyc5j0pfz8nRz
        069DvWD1FA8R88E28+4jiBF1kwRcDaCPJ1MwuaW5ipBtJY5jT+y4DjV0qpFX3TEQZWIZxT
        ED2+CDGNzOEs4ZQ9/nPfdtwxsGCOsEc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-zzZXKucKMYK6D4jKmwi2RQ-1; Tue, 27 Dec 2022 01:30:20 -0500
X-MC-Unique: zzZXKucKMYK6D4jKmwi2RQ-1
Received: by mail-pl1-f197.google.com with SMTP id m16-20020a170902db1000b0018fa0de6aa6so9590269plx.18
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 22:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc5Wpn8Yna8TiyVEifGU6eJKuOo4jmiPUeXEpNoa60I=;
        b=vNvhnvV+4y9Nh7LNakcHcF3TSdtrm8UtqUC7tSc+T/ftr+0Sri9voZxjuGLyK8LJ9z
         CNxyp129OQAhAQvpZSEN4mBnvc/u9qTogxsTrszRsq3qPZran9Vv4JYsSUxD516m/5ls
         6vQ/K3dUVZI2LFZy07/sShZs4782A66ugy21Bohxk7Z9y5oeg8+kA5C/lvsCmpSLzw8S
         3oI6BYm0lAU6jnKLPT4gbtzeReepMjAxPa5YZrBkAND0ldpGNXnyxcYMfQWYSI7t1JYQ
         o0iZXWTB5xis/Nl7hX/nU0A1zqnPi3BDfvMlcVCPkMH+oRHmCzF1pX0Klrj3GeKG8v+3
         Ijqw==
X-Gm-Message-State: AFqh2koOi5HhuCjHHbhYBsvifRmc082gcY3MdHldk2qQ0xyNJ0D3WbTk
        W9Bqt8NcdVMB9Ol4OkVellqKxj06XBBZ63TFdx7OoQmeW/gcMKgskW2ZD4jF6DciZx8t+CAsiaM
        Qf+xuSnqIITFv
X-Received: by 2002:a05:6a20:659d:b0:b0:275d:3036 with SMTP id p29-20020a056a20659d00b000b0275d3036mr25380624pzh.24.1672122619122;
        Mon, 26 Dec 2022 22:30:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvb7dxQymAEXYNINm9hRhsnXhATEDm8IA0GGM3QQlux5wp9WA2nHh01zvPc0v1335MPOWP2hA==
X-Received: by 2002:a05:6a20:659d:b0:b0:275d:3036 with SMTP id p29-20020a056a20659d00b000b0275d3036mr25380610pzh.24.1672122618892;
        Mon, 26 Dec 2022 22:30:18 -0800 (PST)
Received: from [10.72.13.143] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k195-20020a633dcc000000b00478e14e6e76sm7189490pga.32.2022.12.26.22.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 22:30:17 -0800 (PST)
Message-ID: <8d81ab3b-c10b-1a46-3ae1-b87228dbeb4e@redhat.com>
Date:   Tue, 27 Dec 2022 14:30:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/9] virtio_net: disable the hole mechanism for xdp
To:     Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221220141449.115918-1-hengqi@linux.alibaba.com>
 <20221220141449.115918-2-hengqi@linux.alibaba.com>
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221220141449.115918-2-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/12/20 22:14, Heng Qi 写道:
> XDP core assumes that the frame_size of xdp_buff and the length of
> the frag are PAGE_SIZE. The hole may cause the processing of xdp to
> fail, so we disable the hole mechanism when xdp is set.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/net/virtio_net.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9cce7dec7366..443aa7b8f0ad 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1419,8 +1419,11 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>   		/* To avoid internal fragmentation, if there is very likely not
>   		 * enough space for another buffer, add the remaining space to
>   		 * the current buffer.
> +		 * XDP core assumes that frame_size of xdp_buff and the length
> +		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
>   		 */
> -		len += hole;
> +		if (!headroom)
> +			len += hole;


Is this only a requirement of multi-buffer XDP? If not, it need to be 
backported to stable.

Thanks


>   		alloc_frag->offset += hole;
>   	}
>   

