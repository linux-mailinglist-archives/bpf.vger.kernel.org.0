Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872786E27FB
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDNQF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjDNQFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 12:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DB6599
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681488272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/xY5S5AKjyyCNBcr52QSMM9S9bXcihct4tejRSjTCM=;
        b=DvZEf5xjbg6lL9XqHVDmPcLDz5xbpT17HLYeVnBUv/BxQdLVlzg76RTmFmyY/Sc66XKUX3
        HK9Cazl8281UpKO4eHyO6iGugp4QVl4/A2BvaRLzAso2N9Z6RdMcsgGkOPBQ+B6QwT2mwA
        yqw/PCH7CCWo9mdmNi6NcZhe0x98j6o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-ZB-ImIrrMNawybmu6LbMBQ-1; Fri, 14 Apr 2023 12:04:31 -0400
X-MC-Unique: ZB-ImIrrMNawybmu6LbMBQ-1
Received: by mail-ed1-f69.google.com with SMTP id n6-20020a5099c6000000b00502c2f26133so19864057edb.12
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 09:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681488270; x=1684080270;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/xY5S5AKjyyCNBcr52QSMM9S9bXcihct4tejRSjTCM=;
        b=KfUSmd1GfnXEr4vASVQiX2VBJjMbZNx+HIm41qjVm/wUcuJ8QMaBNMB3z1XE/0LPni
         iZ4bsJ8vskIjL+JDCfeFj/mBhqC/tGdnFDlyECPABz1ErV7tU+oQa/crVyXk9uOAaqul
         Q0g4567xulqU40+0bKHLrgEhjcYh9aVOXqA3AngQaWPfzhCgjOHJKD3RiuNfsW7t+rqc
         TKEGQ54HeT6Ii4bw4ZJQMUg6A082gbhHGW1/ktTfCOXZLs0Wo8R898MShQJrMC0JQtBX
         XM2kS7obuZRE8ZCuH2lDxmnWCye8tF3csO6564oJfh67APfUePiuXINdvWlRtAwjkcJt
         N6/g==
X-Gm-Message-State: AAQBX9dKBp4WUHmrCFUpVdddL0sFi2Zg3kZBhZne/g3vYjmisSNA+VAR
        RkKBiDcz4DfvIjgnhP/BAzm6GtUphuRKEkRWCKrkxBuZidPfF9X85cfA+S7Qx/RuP69pilUx6OC
        ospOSCbeyT6au
X-Received: by 2002:a17:906:55d2:b0:94a:4ce3:8043 with SMTP id z18-20020a17090655d200b0094a4ce38043mr6974845ejp.52.1681488270072;
        Fri, 14 Apr 2023 09:04:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350YUd0s8wuUVSimKBiUGgDOIDL4Q9HN4aH0WFXgHCGjnWb4XN/KT7TjiDzhYoo/WnaAhvBfeKw==
X-Received: by 2002:a17:906:55d2:b0:94a:4ce3:8043 with SMTP id z18-20020a17090655d200b0094a4ce38043mr6974795ejp.52.1681488269738;
        Fri, 14 Apr 2023 09:04:29 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id wv13-20020a170907080d00b0094ee21fe943sm1077039ejb.116.2023.04.14.09.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:04:29 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <5c3f37c2-3244-fbad-ba94-bc61b63c557c@redhat.com>
Date:   Fri, 14 Apr 2023 18:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH net-next v5 1/3] net: stmmac: introduce wrapper for struct
 xdp_buff
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
References: <20230414052651.1871424-1-yoong.siang.song@intel.com>
 <20230414052651.1871424-2-yoong.siang.song@intel.com>
In-Reply-To: <20230414052651.1871424-2-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 14/04/2023 07.26, Song Yoong Siang wrote:
> Introduce struct stmmac_xdp_buff as a preparation to support XDP Rx
> metadata via kfuncs.
> 
> Signed-off-by: Song Yoong Siang<yoong.siang.song@intel.com>
> Reviewed-by: Jacob Keller<jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  4 ++++
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++---------
>   2 files changed, 13 insertions(+), 9 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

