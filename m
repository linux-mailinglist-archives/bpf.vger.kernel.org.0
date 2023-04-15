Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5176E3020
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDOJff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDOJfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 05:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09B59FE
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681551286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxPnWAcQVBNBNS9KRY2KFLNjYwkNYHKUC4oRsplfh2c=;
        b=X+j/Xuw3eIBQTlu0VexBBEzsdEH8RS8V5GAOAYGxG3wafMtmLFTgOaw6s3BCr/98fl3mpt
        WyXv5WRWgRvNzSravcfYOynGErtk8AKT2bN3ALMwPA/LU+F10Ayp3YMq8RCeF7HhWf4jNC
        sgz1oVbp3m1vSCL1NjTgcJ9nMGFKPUA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-zO1gdJ3jObOi5oxTcOgHJA-1; Sat, 15 Apr 2023 05:34:43 -0400
X-MC-Unique: zO1gdJ3jObOi5oxTcOgHJA-1
Received: by mail-ej1-f70.google.com with SMTP id kr13-20020a1709079a0d00b0093be92e6ff4so7544971ejc.23
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 02:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681551282; x=1684143282;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxPnWAcQVBNBNS9KRY2KFLNjYwkNYHKUC4oRsplfh2c=;
        b=KmZo74559DtLks9dGII+QTfwp8cHu3H+kYo1bt/VPumSy1thDR9BxV0KApl9ZvdfN7
         2c/m8v2d5UZbGn31hzEVeLUo1r+efpT2bSNRtM9gJk0xwPDK9Oe5SBWQqMFYnW85nVf2
         cdwdTkNRhCfI4c+bdHyt1kb07DL4aJ+cuZotbAy3LYXXpv1HVgTE7BjD1mrp5F/0mD4Q
         Cw+9g6rg9PQiYV6qV75/XP9nO2iq4M1JjXYawQsTRqfDf1AkS43v4svjFrxJ8Ksp3gQj
         lZle8+Mpq1J2DP4c/wNdpZC9Vcr7L338ix2CCMyigA/w2bpEz+7OODDByv1WYXvcz7Go
         c71Q==
X-Gm-Message-State: AAQBX9cYof97RQvUkxIVnaO8ydlKfbSkMCIkN1g6oBGSQUhMuKzdRAsq
        sJHdASF7HX5Qx3yUzb6uYEa8ii5cG/zkNOC1R3XuMuCucUNN/OkdXUnOXFnZxQalwH6bqrY8+Ph
        t7BwMCm0Ln0HP
X-Received: by 2002:a17:906:6bd0:b0:94e:f969:fb3e with SMTP id t16-20020a1709066bd000b0094ef969fb3emr1661545ejs.43.1681551282637;
        Sat, 15 Apr 2023 02:34:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350ahABqOGqRCJSwv9+bd3MwJOCg8HOEo/vfDe75jx4W55RgExcuyfQKh2L9CES3tCsodbIai/w==
X-Received: by 2002:a17:906:6bd0:b0:94e:f969:fb3e with SMTP id t16-20020a1709066bd000b0094ef969fb3emr1661531ejs.43.1681551282362;
        Sat, 15 Apr 2023 02:34:42 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b22-20020a1709062b5600b009306ebc79d3sm3549540ejg.59.2023.04.15.02.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 02:34:41 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <eb277f26-932b-d1b5-ec67-5aee2bd0a287@redhat.com>
Date:   Sat, 15 Apr 2023 11:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH net-next v6 3/3] net: stmmac: add Rx HWTS metadata to XDP
 ZC receive pkt
Content-Language: en-US
To:     Song Yoong Siang <yoong.siang.song@intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20230415064503.3225835-1-yoong.siang.song@intel.com>
 <20230415064503.3225835-4-yoong.siang.song@intel.com>
In-Reply-To: <20230415064503.3225835-4-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 15/04/2023 08.45, Song Yoong Siang wrote:
> Add receive hardware timestamp metadata support via kfunc to XDP Zero Copy
> receive packets.
> 
> Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)

LGTM

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

