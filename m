Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF9D6B2BBD
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 18:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCIRMc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 12:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCIRLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 12:11:49 -0500
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [IPv6:2001:41d0:1004:224b::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0827FEABA4
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 09:09:10 -0800 (PST)
Message-ID: <74abb86f-e0c2-8a0b-c90d-502ffda1571e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678381749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfN/XKcLVMP60QgcWuMkH1m6tRuMpPHHUap5hY4WVcg=;
        b=ghyi224UF/uByW3cUgZV5SX8NV09h2/QAB0GFB6nAnwf1xDi/1mzHK+gjDz6IqVq70OH8j
        Nz4RdXwxG8nglIy+gc/NG+uwy2qEhAHPc8FDKWvQyKfB/JRBSX0KwfGFjOs7HSoNmc2Blh
        oUgrWCdMBb0pCiLXHIt8qsfm4Pkj8LE=
Date:   Thu, 9 Mar 2023 09:09:02 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US
To:     Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-5-kuifeng@meta.com>
 <1b416290-733b-0470-3217-6e477e574931@linux.dev>
 <ce5b0ed3-f093-888d-9dbe-3f6f07bdac06@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ce5b0ed3-f093-888d-9dbe-3f6f07bdac06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/8/23 4:22 PM, Kui-Feng Lee wrote:
> 
> 
> On 3/8/23 13:42, Martin KaFai Lau wrote:
>> On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
>>> @@ -11566,22 +11591,34 @@ struct bpf_link *bpf_program__attach(const struct 
>>> bpf_program *prog)
>>>       return link;
>>>   }
>>> +struct bpf_link_struct_ops {
>>> +    struct bpf_link link;
>>> +    int map_fd;
>>> +};
>>> +
>>>   static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>>   {
>>> +    struct bpf_link_struct_ops *st_link;
>>>       __u32 zero = 0;
>>> -    if (bpf_map_delete_elem(link->fd, &zero))
>>> -        return -errno;
>>> +    st_link = container_of(link, struct bpf_link_struct_ops, link);
>>> -    return 0;
>>> +    if (st_link->map_fd < 0) {
>>
>> map_fd < 0 should always be true?
> 
> If the user pass a wrong link, it can fail.

I may have missed something. How can user directly pass a link to this static 
function?

> I check it here explicitly even the kernel returns
> an error for deleting an element of a struct_ops w/ link.
Yep, the kernel should have stopped the delete if the user somehow corrupted the 
map_fd to -1.

> 
>>
>>> +        /* Fake bpf_link */
>>> +        if (bpf_map_delete_elem(link->fd, &zero))
>>> +            return -errno;
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* Doesn't support detaching. */
>>> +    return -EOPNOTSUPP;

