Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780D16D2886
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 21:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjCaTN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCaTN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 15:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53DD22EA6
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680289953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=673XRyizobae774kUu5nrXw20qs2InjIWxuBx9XJVCI=;
        b=b3CAxLfNTr1YQrWsThPaAnyxdUaEwtpzFMf9Luw0pC98R3Cc6P2ihyXQP0J4FdPt4Q/qVu
        2Iwxw1ga8Sw/DIs63xpakd7XexLTvDKLkXuV1bwccLMHCznNggwmWm7YLdIvTu5JTgx5I7
        NXo3/ds3V9RuHkJHq8SiLgGlj8nl3Tk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-iDz1WDlvP2aQKOGOJK8D_g-1; Fri, 31 Mar 2023 15:12:31 -0400
X-MC-Unique: iDz1WDlvP2aQKOGOJK8D_g-1
Received: by mail-lf1-f69.google.com with SMTP id e12-20020a19674c000000b004e9af173e04so9046141lfj.14
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 12:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680289949;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=673XRyizobae774kUu5nrXw20qs2InjIWxuBx9XJVCI=;
        b=4oT6dSkpDcYYI081Ri3pWnKumLwm8/ctcbMCDayafKCl7HzTV2MsPJktwtVjOltXDn
         iT5e+vfJ2DsFz9kzOqmWnI3CjN1+60W6u2/pH2Cxd51MHpWoSR/g0xjMN4HshqzTmdro
         EiqZiQ051hEW5Q6TblQ3JtZ6/LNjXsB/WDqLi16QeLq6Rp9P5hRw+Aq98MwRsbOdz8fQ
         7Qydh6tqk7kI/7Z8Jlk73IlIxO3uEK8MPjo4NDXV8deeDgqUZ+DrmgTMVuH+lHOy9Nbg
         DbjMsKfkNEgUatdDgJ/cr1F6bvSUsOFqonc3PMBfOA6SqybG6cRvYc7VJ5oQ2VKpT3YM
         kxkA==
X-Gm-Message-State: AAQBX9cAjZv2FBpjqxeA0rMBBVmG6CjMOii8+5ugLW3bQVW30+rQjHHT
        AG6KS0KxtYYvCGLUaVyVM4mScVrfx4pxCOWee4e0zF71JG1ev398PZe9vy0zsM91nW9aLEqdw/V
        pNW9eKdt1JerP
X-Received: by 2002:ac2:57d0:0:b0:4e9:ad85:aa09 with SMTP id k16-20020ac257d0000000b004e9ad85aa09mr7874052lfo.68.1680289949153;
        Fri, 31 Mar 2023 12:12:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZTs7xrb3JbT2oC5qnyecTLJcHIrhwpbP+I6d+Wfo3Jaci9tWwy1Iq+Ij3x13faw8d7dCIp5A==
X-Received: by 2002:ac2:57d0:0:b0:4e9:ad85:aa09 with SMTP id k16-20020ac257d0000000b004e9ad85aa09mr7874032lfo.68.1680289948804;
        Fri, 31 Mar 2023 12:12:28 -0700 (PDT)
Received: from [192.168.42.100] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25610000000b004caf992bba9sm485353lfd.268.2023.03.31.12.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 12:12:28 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3de525f4-096b-b0fe-aaf3-7992acb2451f@redhat.com>
Date:   Fri, 31 Mar 2023 21:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net,
        tariqt@nvidia.com
Subject: Re: [PATCH bpf V4 1/5] xdp: rss hash types representation
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, bpf@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?= =?UTF-8?Q?sen?= 
        <toke@redhat.com>
References: <168027498690.3941176.99100635661990098.stgit@firesoul>
 <202304010239.Jw6bKkWC-lkp@intel.com>
In-Reply-To: <202304010239.Jw6bKkWC-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hopefully addressed in V5.

I obviously need to change function signature for all driver xmo_rx_hash
calls in patch 1/5 to make this compile.  I kept the RSS type
implementations for each driver as separate patches as this is more
reasonable to review and handle.


On 31/03/2023 20.23, kernel test robot wrote:
>
[...]
> All errors (new ones prefixed by >>):
> 
>>> drivers/net/veth.c:1685:43: error: initialization of 'int (*)(const struct xdp_md *, u32 *, enum xdp_rss_hash_type *)' {aka 'int (*)(const struct xdp_md *, unsigned int *, enum xdp_rss_hash_type *)'} from incompatible pointer type 'int (*)(const struct xdp_md *, u32 *)' {aka 'int (*)(const struct xdp_md *, unsigned int *)'} [-Werror=incompatible-pointer-types]
>      1685 |         .xmo_rx_hash                    = veth_xdp_rx_hash,
>           |                                           ^~~~~~~~~~~~~~~~
>     drivers/net/veth.c:1685:43: note: (near initialization for 'veth_xdp_metadata_ops.xmo_rx_hash')
>     cc1: some warnings being treated as errors

