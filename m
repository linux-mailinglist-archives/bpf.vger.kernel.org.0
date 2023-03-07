Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8786AD363
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 01:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCGAgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 19:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCGAgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 19:36:12 -0500
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBC5650A
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 16:36:10 -0800 (PST)
Message-ID: <f2d21101-0522-0b9e-d9d4-9be31f80ad03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678149368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSg0NaW9o0jS5J/j1qOSbCIZ/Leud97dR/rXFtllfXg=;
        b=GR/bkCbElILxtjY/0b1YCo9K/nujNIVoBTRgS4ysz1k3nSzQruIf+PXASaJMDYRgzywNeo
        Mj8fk1fcwWo2qUj+mSeLBQ6PtvWHNe1lu1WNJz545zIUgK2nKpdVWkPOoBx8KUDGMJKiUD
        wx78x7NTkwSOTktDEpk+FUKEYT2Ct7o=
Date:   Mon, 6 Mar 2023 16:36:04 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Maintain the refcount of struct_ops
 maps directly.
Content-Language: en-US
To:     Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-2-kuifeng@meta.com>
 <39ab0ec2-2e8a-2de9-9603-5c5468ee9a1a@linux.dev>
 <d0001e7c-1f51-4c92-0b6d-bd92615375b8@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <d0001e7c-1f51-4c92-0b6d-bd92615375b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/6/23 3:54 PM, Kui-Feng Lee wrote:
>>> @@ -646,6 +679,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
>>>       .map_alloc_check = bpf_struct_ops_map_alloc_check,
>>>       .map_alloc = bpf_struct_ops_map_alloc,
>>>       .map_free = bpf_struct_ops_map_free,
>>> +    .map_free_rcu = bpf_struct_ops_map_free_rcu,
>>
>> just came to my mind. Instead of having a rcu callback, synchronize_rcu() can 
>> be called in bpf_struct_ops_map_free(). Then the '.map_free_rcu' addition and 
>> its related change is not needed.
>>
> 
> synchronize_rcu() probably blocks other subsystem, right?

.map_free is called from system_unbound_wq, so it can block.

