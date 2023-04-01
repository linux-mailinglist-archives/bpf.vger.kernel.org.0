Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062D06D32AA
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjDAQsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDAQsA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 12:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A161BC0
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680367632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LBpaj6qPaiWPsqZ1uUbFmrrkbOrpiff0SRgLWvVlle4=;
        b=cjVNKentMqpysrTQKPjt/qNX2JtF2w9kMPAdhc4tlXnx+jDcBlxAzevVPulUuz/JMmLMWv
        WeN12HzEMz1PzTxsWMz3/XNGaY8L3Xy6YX/9T6f27rTD+RdC3XPWxN2Gtqfq4ZaX60pCGw
        eyc8NH/jmlrWYY0DQd68NfSKlp4lkIM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-_gnDZplAMiiR5J_z3Nqv9A-1; Sat, 01 Apr 2023 12:47:11 -0400
X-MC-Unique: _gnDZplAMiiR5J_z3Nqv9A-1
Received: by mail-lf1-f72.google.com with SMTP id m5-20020a194345000000b004eae18274b7so9977161lfj.19
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 09:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680367629;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBpaj6qPaiWPsqZ1uUbFmrrkbOrpiff0SRgLWvVlle4=;
        b=XqXjT3Q5wGsgTOXc651yC0eZkEgW40qRNbQENySOHvJeaY2SoOfS7N+FliHdUTu9TO
         KVeiYxyX3scCIVs/G25kjDPd1pOMxhxKt1+ePvs6gpnUfjrDGhY/hXB+wU7tTdysz2yY
         foM63VeQBfv/0QLBOVKky30d83xtq/0cJ8f6rfkq1rIWwtZfzqGUEUm90Ve2Ak6LQ0kD
         emkLmZHI3QQV/pqERpuanqThf0axVpeqjbaD0ruNQOICIjF/fLL2ajk8XN+vqJPTTs6O
         GqfmppzFBz69SLzM29WQka3rUPwxXnVWeYugzc29W6AQRZFwa+XSEtD2J/C6XDDohbXt
         qMqQ==
X-Gm-Message-State: AAQBX9ec6hqFgUNSYrK9wthrCjT4uhjbtquiwwiQ4754O+A0EpIXbf/2
        PjfmXICRnPTBZNMQU7YfmnHNnseO3skJTR1MKXZZou5LtY6kLMi4AaNKJEG1gF9pid60M8zTfa2
        r3qb0izfEgo9L4D79AgruQPvGJovhRufrEr1uGmY/AfctXHp+ZLMTrtcpiz8tiOke+ojVX+4=
X-Received: by 2002:a2e:6e03:0:b0:299:aa20:22a0 with SMTP id j3-20020a2e6e03000000b00299aa2022a0mr9388794ljc.53.1680367629463;
        Sat, 01 Apr 2023 09:47:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeSpF555yFlSRJ624wPZzgJmZWz4p4qwCgGBnis2x24ag2kBhUEet5FQWdzvm7DiW1qPj20Q==
X-Received: by 2002:a2e:6e03:0:b0:299:aa20:22a0 with SMTP id j3-20020a2e6e03000000b00299aa2022a0mr9388764ljc.53.1680367629089;
        Sat, 01 Apr 2023 09:47:09 -0700 (PDT)
Received: from [192.168.42.100] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id y17-20020a2eb011000000b002a5f554d263sm887063ljk.46.2023.04.01.09.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 09:47:08 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <d4b3a22a-c815-a337-29b1-737efd9a7494@redhat.com>
Date:   Sat, 1 Apr 2023 18:47:06 +0200
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
In-Reply-To: <168028882260.4030852.1100965689789226162.stgit@firesoul>
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


Why have this patchset[1] been marked "Changes Requested" ?

Notice: The BPF test_progs are failing on "xdp_do_redirect", but that is
not related to this patchset as it already happens on a clean bpf-tree.


  [1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=735957&state=%2A


On 31/03/2023 20.54, Jesper Dangaard Brouer wrote:
> Current API for bpf_xdp_metadata_rx_hash() returns the raw RSS hash value,
> but doesn't provide information on the RSS hash type (part of 6.3-rc).
> 
> This patchset proposal is to change the function call signature via adding
> a pointer value argument for providing the RSS hash type.
> 
> ---
> V5:
>   - Fixes for checkpatch.pl
>   - Change function signature for all xmo_rx_hash calls in patch1
> 
> Jesper Dangaard Brouer (5):
>        xdp: rss hash types representation
>        mlx5: bpf_xdp_metadata_rx_hash add xdp rss hash type
>        veth: bpf_xdp_metadata_rx_hash add xdp rss hash type
>        mlx4: bpf_xdp_metadata_rx_hash add xdp rss hash type
>        selftests/bpf: Adjust bpf_xdp_metadata_rx_hash for new arg
> 
> 
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c    | 22 ++++++-
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  3 +-
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 63 ++++++++++++++++++-
>   drivers/net/veth.c                            | 10 ++-
>   include/linux/mlx5/device.h                   | 14 ++++-
>   include/linux/netdevice.h                     |  3 +-
>   include/net/xdp.h                             | 47 ++++++++++++++
>   net/core/xdp.c                                | 10 ++-
>   .../selftests/bpf/prog_tests/xdp_metadata.c   |  2 +
>   .../selftests/bpf/progs/xdp_hw_metadata.c     | 14 +++--
>   .../selftests/bpf/progs/xdp_metadata.c        |  6 +-
>   .../selftests/bpf/progs/xdp_metadata2.c       |  7 ++-
>   tools/testing/selftests/bpf/xdp_hw_metadata.c |  2 +-
>   tools/testing/selftests/bpf/xdp_metadata.h    |  1 +
>   14 files changed, 180 insertions(+), 24 deletions(-)
> 
> --
> 

