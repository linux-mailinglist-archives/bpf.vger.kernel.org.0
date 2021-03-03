Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412D332C1A2
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449546AbhCCWwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:52:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:3005 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235969AbhCCQhM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 11:37:12 -0500
IronPort-SDR: 4DkY0kbNgVFcgHKQidRrmZL6YIhtktIJVpwNxs0vdTzwPlvW+apdncakBW+aW37XNgEX9CqBHa
 oQvTN+pIXRcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="167127132"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="167127132"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:33:56 -0800
IronPort-SDR: R2F78lApsgYIB6YQR2jxNHB0EteTYJHQvZdtDAo42FX1WNpFHtN4sHYg70SPPHElIuCeIzCCEM
 ZR0DcI/WszLQ==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="407308592"
Received: from jdibley-mobl1.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.252.61.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:33:54 -0800
Subject: Re: [PATCH bpf 2/3] samples: bpf: add missing munmap in xdpsock
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, john.fastabend@gmail.com
References: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
 <20210303155158.15953-3-maciej.fijalkowski@intel.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <5f219f7e-1e79-868d-04ca-10cb2467ffad@intel.com>
Date:   Wed, 3 Mar 2021 17:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303155158.15953-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021-03-03 16:51, Maciej Fijalkowski wrote:
> We mmap the umem region, but we never munmap it.
> Add the missing call at the end of the cleanup.
> 
> Fixes: 3945b37a975d ("samples/bpf: use hugepages in xdpsock app")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Björn Töpel <bjorn.topel@intel.com>

> ---
>   samples/bpf/xdpsock_user.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
> index db0cb73513a5..1e2a1105d0e6 100644
> --- a/samples/bpf/xdpsock_user.c
> +++ b/samples/bpf/xdpsock_user.c
> @@ -1699,5 +1699,7 @@ int main(int argc, char **argv)
>   
>   	xdpsock_cleanup();
>   
> +	munmap(bufs, NUM_FRAMES * opt_xsk_frame_size);
> +
>   	return 0;
>   }
> 
