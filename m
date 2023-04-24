Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5766ED7A5
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 00:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjDXWPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDXWPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 18:15:20 -0400
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23965B90
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 15:15:18 -0700 (PDT)
Message-ID: <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682374516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3ieoeduemyGOYEF5gJ539RlefTxpBD7AMbw6Hv9its=;
        b=JGkzlrG6TSlzMx56GQZmFzLg8GugOOkwUzulpbQ260+rc6+ZTITGnQrISCeJhCeILdpSwt
        Qs4VUwl1Edmaru0LD3AXTe1oqLNwnBxPuTKE6aHaAR/ZCe3kbtuknH6Zt5pcc5R8cHW+Lh
        Xq8kfIafMyzEs2wUUzySxHaqty4olqg=
Date:   Mon, 24 Apr 2023 15:15:13 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     sdf@google.com, edumazet@google.com, bpf@vger.kernel.org
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/18/23 8:31 AM, Aditi Ghag wrote:
> This patch adds the capability to destroy sockets in BPF. We plan to use
> the capability in Cilium to force client sockets to reconnect when their
> remote load-balancing backends are deleted. The other use case is
> on-the-fly policy enforcement where existing socket connections prevented
> by policies need to be terminated.

If the earlier kfunc filter patch 
(https://lore.kernel.org/bpf/1ECC8AAA-C2E6-4F8A-B7D3-5E90BDEE7C48@isovalent.com/) 
looks fine to you, please include it into the next revision. This patchset needs 
it. Usual thing to do is to keep my sob (and author if not much has changed) and 
add your sob. The test needs to be broken out into a separate patch though. It 
needs to use the '__failure __msg("calling kernel function bpf_sock_destroy is 
not allowed")'. There are many examples in selftests, eg. the dynptr_fail.c.

Please also fix the subject in the patches. They are all missing the bpf-next 
and revision tag.

