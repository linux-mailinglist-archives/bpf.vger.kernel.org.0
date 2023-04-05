Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573D66D84D8
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjDER0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjDER0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:26:11 -0400
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8C55A2
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:26:09 -0700 (PDT)
Message-ID: <a77e697d-6067-b1f8-a0f3-95a7e7ed067d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680715567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLDUCAEQqIeAg2vzA1waJegqNulGmGeppk7uCmqRS+c=;
        b=nJIQJ/yGTMD9V11G3Y/VMU8JHc6/bDGCiijGGnsp2E+twMjBpubcni+T2va30SnKeq/B05
        tCzZLTbct8Eo/uSjEXJKv5bTSF56jEU2bl7+1nqwoxWfW5fVfVLcdxEfXmf0oL5ciJSXP1
        HXv9N7RE8TdiqqbCfYnWaFWgVPs9zK4=
Date:   Wed, 5 Apr 2023 10:26:02 -0700
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next] bpf: Add a kfunc filter function to 'struct
 btf_kfunc_id_set'.
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        David Vernet <void@manifault.com>
References: <500d452b-f9d5-d01f-d365-2949c4fd37ab@linux.dev>
 <20230404060959.2259448-1-martin.lau@linux.dev>
 <BCD96FC5-9926-49F6-B56D-FAFB65A2FEE4@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <BCD96FC5-9926-49F6-B56D-FAFB65A2FEE4@isovalent.com>
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

On 4/5/23 8:05 AM, Aditi Ghag wrote:
> Looks quite promising for the sock_destroy use case, and also as a generic filtering mechanism, but I'm not aware of other use cases. I haven't had a chance to apply this patch locally, but I'm planning to do it soon. Thanks!

Please don't top post.

Other use case is to allow different sets of kfuncs to struct_ops programs from 
David: https://lore.kernel.org/bpf/Y9KLHZ1TNXVHdVKm@maniforge/

>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> This set (https://lore.kernel.org/bpf/https://lore.kernel.org/bpf/500d452b-f9d5-d01f-d365-2949c4fd37ab@linux.dev/)
>> needs to limit bpf_sock_destroy kfunc to BPF_TRACE_ITER.
>> In the earlier reply, I thought of adding a BTF_KFUNC_HOOK_TRACING_ITER.
>>
>> Instead of adding BTF_KFUNC_HOOK_TRACING_ITER, I quickly hacked something
>> that added a callback filter to 'struct btf_kfunc_id_set'. The filter has
>> access to the prog such that it can filter by other properties of a prog.
>> The prog->expected_attached_type is used in the tracing_iter_filter().
>> It is mostly compiler tested only, so it is still very rough but should
>> be good enough to show the idea.
>>
>> would like to hear how others think. It is pretty much the only
>> piece left for the above mentioned set.

