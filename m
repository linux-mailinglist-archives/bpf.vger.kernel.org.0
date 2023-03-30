Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48956D0CF1
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjC3RgF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjC3RgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:36:05 -0400
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDDA5FD9
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:36:04 -0700 (PDT)
Message-ID: <a8e7c071-91b1-4312-5665-6816a0b4f4bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680197762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQpmT7tbl2QUNk3CUqjQMUsxWt9no5L8ZIkxUE4+ZQA=;
        b=fVzfBRJ+hXGUSSpj0k7vuHOzyPLY7eNgiH68DMpaJmECmDIl2Ehzp69QSVWwW5EVZbAxAg
        pkmWUXDz3TnuC4MBsfNftZtX3IQFkVf/uRtZKj8HD+fQHXZ9McWrVtsSKdkPZcxhbQqwCp
        U88wwy8fP9F/HMbGCwO9ULXMF8yvCHs=
Date:   Thu, 30 Mar 2023 10:35:59 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 2/7] udp: seq_file: Remove bpf_seq_afinfo from
 udp_iter_state
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-3-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230330151758.531170-3-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 8:17 AM, Aditi Ghag wrote:
> This is a preparatory commit to remove the field. The field was
> previously shared between proc fs and BPF UDP socket iterators. As the
> follow-up commits will decouple the implementation for the iterators,
> remove the field. As for BPF socket iterator, filtering of sockets is
> exepected to be done in BPF programs. >
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   include/net/udp.h |  1 -
>   net/ipv4/udp.c    | 15 +++------------
>   2 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index de4b528522bb..5cad44318d71 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -437,7 +437,6 @@ struct udp_seq_afinfo {
>   struct udp_iter_state {
>   	struct seq_net_private  p;
>   	int			bucket;
> -	struct udp_seq_afinfo	*bpf_seq_afinfo;

This patch does not compile because the remaining st->bpf_seq_afinfo usages are 
only removed in a later patch 4.
https://patchwork.hopto.org/static/nipa/735459/13194325/build_clang/stderr

Mostly a heads up. No need to re-spin now. Review can be continued on this revision.

