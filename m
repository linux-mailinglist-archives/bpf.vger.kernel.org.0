Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726266C3C6A
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCUVFv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCUVFv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:05:51 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286857D28
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:05:50 -0700 (PDT)
Message-ID: <b7738b11-0260-eb60-7788-791a070c30a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679432748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rcAMCQERzHSRXL0yaI8ZdlOCsOnKZakxGNn0qAck8c=;
        b=qNYs9Ankyiv8NYD9mfuLup880zEKlP4+vrsqO5Aop1IuKwz0SiGh/EpBpgYxdU/7cut+XJ
        puP8m9VeXSxCJR0sGexrNDeS8irkv2P36ywZcURv+J0hcJlJo+rmI0bXHa40xjx9ot6l0k
        vGf/IAKT8OJ9sWqaSFG3MsiEFLDKmR8=
Date:   Tue, 21 Mar 2023 14:05:43 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 8/8] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
 <20230320195644.1953096-9-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230320195644.1953096-9-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/20/23 12:56 PM, Kui-Feng Lee wrote:
> Create a pair of sockets that utilize the congestion control algorithm
> under a particular name. Then switch up this congestion control
> algorithm to another implementation and check whether newly created
> connections using the same cc name now run the new implementation.
> 
> Also, try to update a link with a struct_ops that is without
> BPF_F_LINK or with a wrong or different name.  These cases should fail
> due to the violation of assumptions.  To update a bpf_link of a
> struct_ops, it must be replaced with another struct_ops that is
> identical in type and name and has the BPF_F_LINK flag.
> 
> The other test case is to create links from the same struct_ops more
> than once.  It makes sure a struct_ops can be used repeatly.

Test for BPF_F_REPLACE is needed.

