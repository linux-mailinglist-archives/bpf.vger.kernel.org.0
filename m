Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE132C1F3
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449729AbhCCWxn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:65221 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242176AbhCCTUy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 14:20:54 -0500
IronPort-SDR: 2fNRBYknHIsGA/3sF9TsVTb6GTXbBVS3iIsHYv+6cpxstvdQZKXndrCJjAkWSEuGAQkQLfHH3X
 K87rRz/8rzPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="184849940"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="184849940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:19:40 -0800
IronPort-SDR: wG8WyCPnlI471Cs6o4vZhtwTMqZGIlrIp2IPi2kfC+7291SMBwvEqyY4A0bqX667mC2j7MRmiv
 9VhQ+TbABZjQ==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="407378032"
Received: from jdibley-mobl1.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.252.61.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:19:37 -0800
Subject: Re: [PATCH bpf v2 0/3] AF_XDP small fixes
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, john.fastabend@gmail.com
References: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <9808e9c5-5234-5215-25a6-ef538a4c17a0@intel.com>
Date:   Wed, 3 Mar 2021 20:19:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-03-03 19:56, Maciej Fijalkowski wrote:
> Hi,
> 
> This time three no-brainers, one is a fix that I sent among with
> bpf_link for AF_XDP set where John suggested that it should land in bpf
> tree.
> 
> Other is the missing munmap on xdpsock and some ancient function
> declaration removal.
>

Thanks Maciej!

For the series:

Acked-by: Björn Töpel <bjorn.topel@intel.com>


> Thanks!
> Maciej
> 
> v2:
> - collect Bjorn's Acks
> - change strlen to sizeof in patch 3
> 
> Maciej Fijalkowski (3):
>    xsk: remove dangling function declaration from header file
>    samples: bpf: add missing munmap in xdpsock
>    libbpf: clear map_info before each bpf_obj_get_info_by_fd
> 
>   include/linux/netdevice.h  | 2 --
>   samples/bpf/xdpsock_user.c | 2 ++
>   tools/lib/bpf/xsk.c        | 5 +++--
>   3 files changed, 5 insertions(+), 4 deletions(-)
> 
