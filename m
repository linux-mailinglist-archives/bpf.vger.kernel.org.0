Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB85654A78
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 02:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiLWBbN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 20:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLWBbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 20:31:11 -0500
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048902602
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 17:31:08 -0800 (PST)
Message-ID: <e46452f4-a274-1b9e-2b33-668cc0f258b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671759066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8Gm3zulwUIvGUrskxr7eNdyL6itYTbNP+oX93LS29U=;
        b=TA1rsK5+YLdkAv4UA6TZAcW9xNBq+t2ERkluf4CqxxocHS09Q8PzDtlVUuTUpkd/hJ7RFp
        31/lRo3w4UaCMOooCKxhwqF1YjlYtUhHFosL6oenPflNNfXQux5SJ0idJ07LCKImJ+VWZj
        gcEY5tWd85THGD+0yN6UCQ2HXJmn7EI=
Date:   Thu, 22 Dec 2022 17:31:02 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: fix nullness propagation for reg to
 reg comparisons
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20221222024414.29539-1-sunhao.th@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221222024414.29539-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/21/22 6:44 PM, Hao Sun wrote:
> After befae75856ab, the verifier would propagate null information after
> JEQ/JNE, e.g., if two pointers, one is maybe_null and the other is not,
> the former would be marked as non-null in eq path. However, as comment
> "PTR_TO_BTF_ID points to a kernel struct that does not need to be null
> checked by the BPF program ... The verifier must keep this in mind and
> can make no assumptions about null or non-null when doing branch ...".
> If one pointer is maybe_null and the other is PTR_TO_BTF, the former is
> incorrectly marked non-null. The following BPF prog can trigger a
> null-ptr-deref, also see this report for more details[1]:
> 
> 	0: (18) r1 = map_fd	        ; R1_w=map_ptr(ks=4, vs=4)
> 	2: (79) r6 = *(u64 *)(r1 +8)    ; R6_w=bpf_map->inner_map_data
> 					; R6 is PTR_TO_BTF_ID
> 					; equals to null at runtime
> 	3: (bf) r2 = r10
> 	4: (07) r2 += -4
> 	5: (62) *(u32 *)(r2 +0) = 0
> 	6: (85) call bpf_map_lookup_elem#1    ; R0_w=map_value_or_null
> 	7: (1d) if r6 == r0 goto pc+1
> 	8: (95) exit
> 	; from 7 to 9: R0=map_value R6=ptr_bpf_map
> 	9: (61) r0 = *(u32 *)(r0 +0)          ; null-ptr-deref
> 	10: (95) exit
> 
> So, make the verifier propagate nullness information for reg to reg
> comparisons only if neither reg is PTR_TO_BTF_ID.
> 
> [1] https://lore.kernel.org/bpf/CACkBjsaFJwjC5oiw-1KXvcazywodwXo4zGYsRHwbr2gSG9WcSw@mail.gmail.com/T/#u
> 
> Fixes: befae75856ab4 ("bpf: propagate nullness information for reg to reg comparisons")
The "Fixes" tag has one more hex digit. I have corrected it and applied to the 
bpf tree.  Thanks.

Please run checkpatch.pl in the future:

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title 
line>")' - ie: 'Fixes: befae75856ab ("bpf: propagate nullness information for 
reg to reg comparisons")'
#35:
Fixes: befae75856ab4 ("bpf: propagate nullness information for reg to reg 
comparisons")


