Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342AF6BF807
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 06:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCRFi6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Mar 2023 01:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCRFi5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Mar 2023 01:38:57 -0400
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BA047424
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 22:38:55 -0700 (PDT)
Message-ID: <b977a7d4-4c82-eb46-3457-4a92ec94de46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679117933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuGLgb0Jj16KXqyLof+6ZRB4ze9SZ62/OWaVQcM8V2M=;
        b=Er+3hFw9DSWxR73Q65nZmXdGSy9Q3S58iqS3Ahcn6h8Z5dJHGEau3X7g3LT3oK6sNUdTLb
        BmYk5CbmyWp+mHieZgrGxMxFXW6cZPIOx/zlj8gBuriqRaoHG/OBzdvF/INuz7sqhroy+G
        xEXV/LeVtQa9R1CWeMKKn3urgdgms7s=
Date:   Fri, 17 Mar 2023 22:38:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 5/8] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US
To:     Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-6-kuifeng@meta.com>
 <690c5fff-4828-c849-c946-1f1a29e168c8@linux.dev>
 <6fed9361-ba07-c387-14d4-2fee2d161b5f@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <6fed9361-ba07-c387-14d4-2fee2d161b5f@gmail.com>
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

On 3/17/23 6:11 PM, Kui-Feng Lee wrote:
>>> --- a/net/bpf/bpf_dummy_struct_ops.c
>>> +++ b/net/bpf/bpf_dummy_struct_ops.c
>>> @@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
>>>   {
>>>   }
>>> +static int bpf_dummy_update(void *kdata, void *old_kdata)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>>   struct bpf_struct_ops bpf_bpf_dummy_ops = {
>>>       .verifier_ops = &bpf_dummy_verifier_ops,
>>>       .init = bpf_dummy_init,
>>>       .check_member = bpf_dummy_ops_check_member,
>>>       .init_member = bpf_dummy_init_member,
>>>       .reg = bpf_dummy_reg,
>>> +    .update = bpf_dummy_update,
>>
>> When looking at this together in patch 5, the changes in 
>> bpf_dummy_struct_ops.c should not be needed.
> 
> I don't follow you.
> If we don't assign a function to .update, it will fail in
> bpf_struct_ops_map_link_update(). Of course, I can add a check
> in bpf_struct_ops_map_link_update() to return an error if .update
> is NULL.

Yes, test ->update in bpf_struct_ops.c is better but not in 
bpf_struct_ops_map_link_update (more on this later). It does not need the dummy 
struct_ops to test the link. The dummy struct_ops was created to catch the 
trampoline img issue with ops/func having different args and return value.

It is better to enforce the BPF_F_LINK struct_ops must support both ->validate 
and ->update at the beginning and it can be revisited later. The current 
'->validate' testing in bpf_struct_ops_map_update_elem() in patch 3 is too late. 
Being able to '->validate' is particularly important for BPF_F_LINK struct_ops. 
Testing '->validate' and '->update' in bpf_struct_ops_init() will be too strict 
for now though when considering other on-going efforts to support struct_ops in 
other subsystems. A better place to test both '->validate' and '->update' should 
be in bpf_struct_ops_map_alloc(). It should return -ENOTSUPP when trying to 
creating a struct_ops BPF_F_LINK map without st_ops->validate and st_ops->update.
