Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249726F52BA
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 10:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjECIJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 04:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjECIJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 04:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6484ECB;
        Wed,  3 May 2023 01:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0607262B73;
        Wed,  3 May 2023 08:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D272C433EF;
        Wed,  3 May 2023 08:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683101277;
        bh=EBb5xgIZZfYqj/z+N72o+F70JjDbzDj6lUwAS2EJY+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWwD3NbO1wlU1UVmtLRmLDPs1X+Gc/1/KAG3f0UCJ15uB4m0xgJgk1LWL50F/jl6R
         ExPkmKVObRYZgML5ZEUijewzNBWOg/8MOWRMoaiD8y6cLqsbq9Fwb2An0JUsjvUlm2
         1n6q4Qi4C6pQXJOvVFXk2KR8dPCKJ6WAku73dLLBrMZsv2RwmX125HL2IXivIpnhEJ
         VyG1GUjT0eqfojow6Nqglm3K0ra+JrJ9Q7bjv7qFK75YkUIdwPDNaEmF9cYoAMorqE
         HQQqZ2qOPhvDsnQV3zdEZmLc4GIJDXX5r304UrScmCcXR5AM/fc5HWq06I9hOQNY8U
         h8YInPrI2cm3A==
Date:   Wed, 3 May 2023 11:07:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        sasha.neftin@intel.com, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 1/1] igc: read before write to SRRCTL register
Message-ID: <20230503080753.GE525452@unreal>
References: <20230502154806.1864762-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502154806.1864762-1-anthony.l.nguyen@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 02, 2023 at 08:48:06AM -0700, Tony Nguyen wrote:
> From: Song Yoong Siang <yoong.siang.song@intel.com>
> 
> igc_configure_rx_ring() function will be called as part of XDP program
> setup. If Rx hardware timestamp is enabled prio to XDP program setup,
> this timestamp enablement will be overwritten when buffer size is
> written into SRRCTL register.
> 
> Thus, this commit read the register value before write to SRRCTL
> register. This commit is tested by using xdp_hw_metadata bpf selftest
> tool. The tool enables Rx hardware timestamp and then attach XDP program
> to igc driver. It will display hardware timestamp of UDP packet with
> port number 9092. Below are detail of test steps and results.
> 
> Command on DUT:
>   sudo ./xdp_hw_metadata <interface name>
> 
> Command on Link Partner:
>   echo -n skb | nc -u -q1 <destination IPv4 addr> 9092
> 
> Result before this patch:
>   skb hwtstamp is not found!
> 
> Result after this patch:
>   found skb hwtstamp = 1677800973.642836757
> 
> Optionally, read PHC to confirm the values obtained are almost the same:
> Command:
>   sudo ./testptp -d /dev/ptp0 -g
> Result:
>   clock time: 1677800973.913598978 or Fri Mar  3 07:49:33 2023
> 
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Cc: <stable@vger.kernel.org> # 5.14+
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.h | 11 ++++++++---
>  drivers/net/ethernet/intel/igc/igc_main.c |  7 +++++--
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
