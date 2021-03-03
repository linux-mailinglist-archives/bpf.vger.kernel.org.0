Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32B32C19B
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449539AbhCCWwF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:52:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:12178 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240282AbhCCQez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 11:34:55 -0500
IronPort-SDR: FKX6A4hCmQi4mz8B/9ynQMrQOCpoejWruY+2bTc3KZmmOeeMVzcsmkF0QF4NZ1Uo1IANSo0ajZ
 vA7RHs/ZWznA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187348461"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="187348461"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:33:43 -0800
IronPort-SDR: 46RhDsGKVw27vPHdv9EpwM2Gkq5wm8NvSyu09DxIqzVg+P3zalcMbXQFslV0N91eSAyfL91qr3
 hD8yTRBHN63w==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="407308526"
Received: from jdibley-mobl1.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.252.61.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:33:41 -0800
Subject: Re: [PATCH bpf 1/3] xsk: remove dangling function declaration from
 header file
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, john.fastabend@gmail.com
References: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
 <20210303155158.15953-2-maciej.fijalkowski@intel.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <dc996d90-ca03-f469-9056-c09ef16dae60@intel.com>
Date:   Wed, 3 Mar 2021 17:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303155158.15953-2-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-03-03 16:51, Maciej Fijalkowski wrote:
> xdp_umem_query() is dead for a long time, drop the declaration from
> include/linux/netdevice.h
> 
> Fixes: c9b47cc1fabc ("xsk: fix bug when trying to use both copy and zero-copy on one queue id")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Björn Töpel <bjorn.topel@intel.com>

> ---
>   include/linux/netdevice.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 6cef47b76cc6..226303976310 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3932,8 +3932,6 @@ int dev_change_xdp_fd(struct net_device *dev, struct netlink_ext_ack *extack,
>   int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
>   u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
>   
> -int xdp_umem_query(struct net_device *dev, u16 queue_id);
> -
>   int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
>   int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
>   int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
> 
