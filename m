Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2032D6B8A0E
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 06:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCNFEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCNFEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 01:04:54 -0400
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198062304
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 22:04:14 -0700 (PDT)
Message-ID: <4d423d7b-9235-aebf-aafc-dd7d240fe5d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678770250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hl9QUSh6m/sBfwJXlfAiSrKaHFJ9QfwK4Co2T9sOlU0=;
        b=OclEje5vqIX1COA63ImQtnPShxRa1Ib/QOVpH8KSLIQEA70MkV+5k3+q0O9bvBTAKZfOxO
        mWDTopCpNdhslh7jn9g3z4671M6to0ZD+pmMlxbza5aYt8cWO3LJNTG8InWynw55arGvUC
        BGM/JFIB9c1h5oL933EyTp2xDnBCIq0=
Date:   Mon, 13 Mar 2023 22:04:06 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 8/8] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230310043812.3087672-1-kuifeng@meta.com>
 <20230310043812.3087672-9-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230310043812.3087672-9-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/9/23 8:38 PM, Kui-Feng Lee wrote:
> Create a pair of sockets that utilize the congestion control algorithm
> under a particular name. Then switch up this congestion control
> algorithm to another implementation and check whether newly created
> connections using the same cc name now run the new implementation.

Please update the commit message to include negative tests. Others lgtm.

