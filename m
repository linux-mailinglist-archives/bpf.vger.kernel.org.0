Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697346D3655
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDBIi0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDBIiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 04:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FABFA
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680424657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i924t6g/U8Sz5oZNi8eHpwH9+wgHgEL8rUIeN7Yevhk=;
        b=eeYaqUv8N3TVdc6WHbiEqDq9YegCHTUXEvsWbIKD9m2zR8GMJGUIJAiW+QQc1xlpTnZm3A
        VvQO0sZJ2O8z6VqUFiGYgVGCoC62Xm61LqFTdaYwtOyGor4RGOWjEH3Jb1mz+ErjUoHuqo
        PSjQ+5HSwWhPR77P43blndAoXF1lzLE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-NQ7Aol_jP8G42-Whuys-3g-1; Sun, 02 Apr 2023 04:37:36 -0400
X-MC-Unique: NQ7Aol_jP8G42-Whuys-3g-1
Received: by mail-lf1-f72.google.com with SMTP id b10-20020a056512060a00b004eaf5a72b99so10429786lfe.17
        for <bpf@vger.kernel.org>; Sun, 02 Apr 2023 01:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680424654;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i924t6g/U8Sz5oZNi8eHpwH9+wgHgEL8rUIeN7Yevhk=;
        b=lcJvqEMUbp01l9BODAkGNgvTFi+dIno31Ol3HaappJgEXRt9q95mkWTuG6tDj0hcpm
         bakNyelRwnTKww4d+LAoQYyQboUbYD0bViR6kz3o0A49icxPIOjsehCUZ72wOVLk6WGw
         iyrqr4mlAL0V/oMLmA6mnnjwDNfWVomIpHrgpGoK0o7OLmKzRThI8E/L10uGPVZiqsMY
         BDBr8R74DizlAtfcmGvekxm10jz0qB3U36RYe/jMRTF4dAIAjCGypEfGscUFpIHZluUt
         AHL7+mUx06KihBOTBcNQ26XHxvnNJBX8LbmgOI2M12ca19uqrDbkh/pYn9GKLN1p9NqS
         Bbgw==
X-Gm-Message-State: AAQBX9cq3PKZ4UcNIus4v7mHyiAqoqMnR/rzWOMy+uefpsuleyk3m+IX
        PAh8qHPvAn68h+Df3yIgBMcZaCK+yEQ6gbKACC3we6wr+0UHY5czeGHjLpm/AHS6oInDhypluEJ
        Omiu9W7S0L1lowOFhhcjUD+eGF6DS7y1Ax/CtlLUKQhJqGdEsD+jNNLnD2SFh+5FOkzpm628=
X-Received: by 2002:a19:7613:0:b0:4db:3e56:55c8 with SMTP id c19-20020a197613000000b004db3e5655c8mr9495438lff.59.1680424654752;
        Sun, 02 Apr 2023 01:37:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350YT4NdKfptHbUEwzqYe1WUNC6ROtPlFgUhwZhzhr8UJaaCb11s1bFmgFwrE8lhNBuBu1uo19g==
X-Received: by 2002:a19:7613:0:b0:4db:3e56:55c8 with SMTP id c19-20020a197613000000b004db3e5655c8mr9495407lff.59.1680424654319;
        Sun, 02 Apr 2023 01:37:34 -0700 (PDT)
Received: from [192.168.42.100] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id j18-20020a19f512000000b004eb2eb63144sm1114728lfb.120.2023.04.02.01.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 01:37:33 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <df64f630-93e6-1ec3-83bc-4584f2856acb@redhat.com>
Date:   Sun, 2 Apr 2023 10:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net, tariqt@nvidia.com
Subject: Re: [PATCH bpf V5 0/5] XDP-hints: API change for RX-hash kfunc
 bpf_xdp_metadata_rx_hash
Content-Language: en-US
To:     bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <168028882260.4030852.1100965689789226162.stgit@firesoul>
 <d4b3a22a-c815-a337-29b1-737efd9a7494@redhat.com>
In-Reply-To: <d4b3a22a-c815-a337-29b1-737efd9a7494@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 01/04/2023 18.47, Jesper Dangaard Brouer wrote:
> 
> Why have this patchset[1] been marked "Changes Requested" ?
> 
> Notice: The BPF test_progs are failing on "xdp_do_redirect", but that is
> not related to this patchset as it already happens on a clean bpf-tree.
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=735957&state=%2A

I've now sent V6:

  [2] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=736141&state=%2A

--Jesper

