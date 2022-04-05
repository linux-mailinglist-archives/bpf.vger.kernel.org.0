Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73A74F3DAB
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiDEOLF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382062AbiDENOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 09:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199731275CB
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649161114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=neLOKYq5QU38G4Ic46SQDQYjNLYsC3oRTfRCqIyPgQY=;
        b=iHN0iayWndOgZa737KdbSrH2UAMmxZibvPhAu2qdWc++W8l2GUSX1bChCgv24rGlhiEOl9
        JqvmTu7rHVOld7HXXpIHXVidkOjYIMLLteljJ5ioROW9/Glc9rb4WZhxsfP9ZnutMCIfMG
        YCkWFet+6e7fCQKgU5wW/og615xioLg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-vFnvYtw3MymvcE3ue3YzJw-1; Tue, 05 Apr 2022 08:18:33 -0400
X-MC-Unique: vFnvYtw3MymvcE3ue3YzJw-1
Received: by mail-ed1-f69.google.com with SMTP id r15-20020a50aacf000000b0041cd4f5e1a6so3152797edc.4
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 05:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=neLOKYq5QU38G4Ic46SQDQYjNLYsC3oRTfRCqIyPgQY=;
        b=36NUN9pIMiZQ6+xZMtpsyC2ATA53LlODf1TpJMGclQK14D4hE6N+bWykycO+VVCWal
         NWdRC0/3Y0JIrXx+OaV9Y+bIqsLlTbzCTVEcUkukFNuIMH8n8vdL+8UJ3+Pa2OseeA2X
         ontnzK4SHwMIu1qE5p5UX6uXjowoy2Trin3OpxLmr25zEVsH7gwBc3syYUDvRrwSIrIH
         lAJGPO+m37CHYDsiilgkZ8ikhypso3nwwoybAY1iFc8qxVumMt84bdI18AaxLGd59eA8
         SxuLt7T5jJN3ThDvlhfLZDpQaNKbC+3sZUsv/o22RHI9+Sxm2yIjtNtwa5GJAIAoeJdT
         dGSw==
X-Gm-Message-State: AOAM5325JK+UFBLhjXPSei4giNL/TrCPgN+L51EXyrjgiJMc0FP42zSa
        33exUEHag8PpU1Nli2/OUAoUFcfPSrZ3kAr8/IgRwkehgQG9jIMJM6EQqUHaQojjkWO0miW5U3a
        w9QvTMAN9Cyvm
X-Received: by 2002:a17:907:6294:b0:6e1:ea4:74a3 with SMTP id nd20-20020a170907629400b006e10ea474a3mr3289782ejc.168.1649161111901;
        Tue, 05 Apr 2022 05:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPOGSr03zzveHqRiRo6Vdz+PVpoJRi9vR7NbYHHY9JbteM/Nz5f/baPPxA0NraTLOq9rZyAA==
X-Received: by 2002:a17:907:6294:b0:6e1:ea4:74a3 with SMTP id nd20-20020a170907629400b006e10ea474a3mr3289756ejc.168.1649161111656;
        Tue, 05 Apr 2022 05:18:31 -0700 (PDT)
Received: from [192.168.2.20] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709067f8300b006ce051bf215sm5389895ejr.192.2022.04.05.05.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 05:18:31 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a87c2f7f-a601-7b91-9bc5-aff22ec51d62@redhat.com>
Date:   Tue, 5 Apr 2022 14:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, maximmi@nvidia.com,
        alexandr.lobakin@intel.com
Subject: Re: [PATCH bpf-next 01/10] xsk: improve xdp_do_redirect() error codes
Content-Language: en-US
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        magnus.karlsson@intel.com, bjorn@kernel.org
References: <20220405110631.404427-1-maciej.fijalkowski@intel.com>
 <20220405110631.404427-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20220405110631.404427-2-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 05/04/2022 13.06, Maciej Fijalkowski wrote:
> From: Björn Töpel<bjorn@kernel.org>
> 
> The error codes returned by xdp_do_redirect() when redirecting a frame
> to an AF_XDP socket has not been very useful. A driver could not
> distinguish between different errors. Prior this change the following
> codes where used:
> 
> Socket not bound or incorrect queue/netdev: EINVAL
> XDP frame/AF_XDP buffer size mismatch: ENOSPC
> Could not allocate buffer (copy mode): ENOSPC
> AF_XDP Rx buffer full: ENOSPC
> 
> After this change:
> 
> Socket not bound or incorrect queue/netdev: EINVAL
> XDP frame/AF_XDP buffer size mismatch: ENOSPC
> Could not allocate buffer (copy mode): ENOMEM
> AF_XDP Rx buffer full: ENOBUFS
> 
> An AF_XDP zero-copy driver can now potentially determine if the
> failure was due to a full Rx buffer, and if so stop processing more
> frames, yielding to the userland AF_XDP application.
> 
> Signed-off-by: Björn Töpel<bjorn@kernel.org>
> Signed-off-by: Maciej Fijalkowski<maciej.fijalkowski@intel.com>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Thanks for picking this work up again! :-)
--Jesper

