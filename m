Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0F6C744C
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCWX6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 19:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWX6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 19:58:31 -0400
Received: from out-5.mta1.migadu.com (out-5.mta1.migadu.com [95.215.58.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C932BF26
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 16:58:30 -0700 (PDT)
Message-ID: <306f23cd-918f-f0e3-9521-53be8e362458@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679615908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C10r8V5Xu+QXGYhouwD+//dZi0OTWk2dTPdWAMiN2rU=;
        b=KgF6Zhy90qEJ1wS2n188d9fMPSSI9RVyhLvzQNFqYbBGQRdDP71sLfjy7rSiWupxe43UBu
        BWegOuKNpKekQBFEMTdBADznTN2W0RhcajkuAQw5+27arrp1XDJ7e20ZOjLZNvZCc/I5+c
        4G0owaXAEudP5g6R43xVim+QHjMMEs8=
Date:   Thu, 23 Mar 2023 16:58:23 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-3-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230323200633.3175753-3-aditi.ghag@isovalent.com>
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

On 3/23/23 1:06 PM, Aditi Ghag wrote:
> The socket destroy kfunc is used to forcefully terminate sockets from
> certain BPF contexts. We plan to use the capability in Cilium to force
> client sockets to reconnect when their remote load-balancing backends are
> deleted. The other use case is on-the-fly policy enforcement where existing
> socket connections prevented by policies need to be forcefully terminated.
> The helper allows terminating sockets that may or may not be actively
> sending traffic.
> 
> The helper is currently exposed to certain BPF iterators where users can
> filter, and terminate selected sockets.  Additionally, the helper can only
> be called from these BPF contexts that ensure socket locking in order to
> allow synchronous execution of destroy helpers that also acquire socket
> locks. The previous commit that batches UDP sockets during iteration
> facilitated a synchronous invocation of the destroy helper from BPF context
> by skipping taking socket locks in the destroy handler. TCP iterators
> already supported batching.
> 
> The helper takes `sock_common` type argument, even though it expects, and
> casts them to a `sock` pointer. This enables the verifier to allow the
> sock_destroy kfunc to be called for TCP with `sock_common` and UDP with
> `sock` structs. As a comparison, BPF helpers enable this behavior with the
> `ARG_PTR_TO_BTF_ID_SOCK_COMMON` argument type. However, there is no such
> option available with the verifier logic that handles kfuncs where BTF
> types are inferred. Furthermore, as `sock_common` only has a subset of
> certain fields of `sock`, casting pointer to the latter type might not
> always be safe. Hence, the BPF kfunc converts the argument to a full sock
> before casting.
> 
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/core/filter.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++

This patch has merge conflict: https://github.com/kernel-patches/bpf/pull/4811, 
so please rebase in the next respin.

I took a quick skim but haven't finished. Please hold off the respin and review 
can be continued on this revision.

