Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA28A6E7F3C
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjDSQLg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjDSQLf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 12:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04AD7D8E
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681920648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqblCBfQTxko5DZvP5yTi/xoUokqLe4XMeA4ezezFSA=;
        b=VDcAVd+uq54eG0fKsTULq8M6ipzoNSr9QPbClaYp+dUiO9cXqpyKxJddheU0OcXUstcnJx
        1+ecnR0UtBQ2H1ni5TSavxCz1K+r/nRTM4DQFeCom6DAV52b8wvixX1ndEGMjkr2baJ15o
        sCD/uHUnAbMuhyozNygst1se3SyqM/Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-YcLKCaaPOc-WoFel7wt6SA-1; Wed, 19 Apr 2023 12:10:46 -0400
X-MC-Unique: YcLKCaaPOc-WoFel7wt6SA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50512c6e3e5so71163a12.2
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920645; x=1684512645;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqblCBfQTxko5DZvP5yTi/xoUokqLe4XMeA4ezezFSA=;
        b=eHvw5+wENJq/oqbF8e4vGAd/tYUEqQJ1tC9CsUABNSvdUOordxKjWMswvhi75zj/GW
         wtk1kCXUYMvoyPBg18GGcp+YHaS5pewEUUFF4mabqEW+363Imj19FOVrP8qC3E4NY8Ef
         WiYCWXSL3uMUaVRP2OBIh8fUFlXCA5eVu8SFFsKcEvMS+Ve77VIfcDDrO+bnBEXFL+ZQ
         SEhu+e86gI3FS2w8O6vAgBdD1X65BU+UVpui7E0jIBBa/2fv/BKQ5xaQzAJ/KCUSEzdg
         vUFsUP4zMe1FvIR1qMmElDDTqic6/mbRdcQoE1IFKwj4ZNpKdQEM0z8p+UR5AVjD0Wpx
         DlJg==
X-Gm-Message-State: AAQBX9fSUd8A9hXhMXd8rx/c4wp8wTJRnI3WBznHuy72smKxQul9Sors
        tTM5UgKclryr8iTlUGrdMDokYJJicrR4bY0PeEjjekKo+lIyPLyeI10GCqRC+kRucmv0iE6/tLJ
        CPwpnWFmo5hDf
X-Received: by 2002:aa7:cd95:0:b0:502:61d8:233b with SMTP id x21-20020aa7cd95000000b0050261d8233bmr7349196edv.19.1681920645644;
        Wed, 19 Apr 2023 09:10:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zq4/RT/2JZGaEc3HOwChNgiJt5M7dDq/2w0V/eHwJYLg5ai4fINLQZ7RBZktfrTz/dwhfqCg==
X-Received: by 2002:aa7:cd95:0:b0:502:61d8:233b with SMTP id x21-20020aa7cd95000000b0050261d8233bmr7349183edv.19.1681920645325;
        Wed, 19 Apr 2023 09:10:45 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id 23-20020a508e17000000b0050692cfc24asm5685306edw.16.2023.04.19.09.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:10:44 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f1b26313-c377-251d-97f6-b56671f98921@redhat.com>
Date:   Wed, 19 Apr 2023 18:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
        pabeni@redhat.com, bpf@vger.kernel.org,
        lorenzo.bianconi@redhat.com, nbd@nbd.name,
        Toke Hoiland Jorgensen <toke@redhat.com>
Subject: Re: issue with inflight pages from page_pool
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <ZD2HjZZSOjtsnQaf@lore-desk>
 <CANn89iK7P2aONo0EB9o+YiRG+9VfqqVVra4cd14m_Vo4hcGVnQ@mail.gmail.com>
 <ZD2NSSYFzNeN68NO@lore-desk> <20230417112346.546dbe57@kernel.org>
 <ZD2TH4PsmSNayhfs@lore-desk> <20230417120837.6f1e0ef6@kernel.org>
 <ZD26lb2qdsdX16qa@lore-desk> <20230417163210.2433ae40@kernel.org>
 <ZD5IcgN5s9lCqIgl@lore-desk>
 <3449df3e-1133-3971-06bb-62dd0357de40@redhat.com>
 <CANn89iKAVERmJjTyscwjRTjTeWBUgA9COz+8HVH09Q0ehHL9Gw@mail.gmail.com>
 <ea762132-a6ff-379a-2cc2-6057754425f7@redhat.com>
 <CANn89iJw==Y9fqhc0Xpau_aH=Uq7kSNv8=MywdUgTGbLZHoisQ@mail.gmail.com>
In-Reply-To: <CANn89iJw==Y9fqhc0Xpau_aH=Uq7kSNv8=MywdUgTGbLZHoisQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 19/04/2023 16.18, Eric Dumazet wrote:
> On Wed, Apr 19, 2023 at 4:02 PM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
> 
>> With TCP sockets (pipes etc) we can take care of closing the sockets
>> (and programs etc) to free up the SKBs (and perhaps wait for timeouts)
>> to make sure the page_pool shutdown doesn't hang.
> 
> This can not happen in many cases, like pages being now mapped to user
> space programs,
> or nfsd or whatever.
> 
> I think that fundamentally, page pool should handle this case gracefully.
> 
> For instance, when a TCP socket is closed(), user space can die, but
> many resources in the kernel are freed later.
> 
> We do not block a close() just because a qdisc decided to hold a
> buffer for few minutes.
> 

But page pool does handle this gracefully via scheduling a workqueue.

--Jesper

