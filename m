Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E6699D17
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBPTlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 14:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPTlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 14:41:09 -0500
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [IPv6:2001:41d0:203:375::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6C4C3D1
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 11:41:08 -0800 (PST)
Message-ID: <604929b3-5063-4883-67a7-30cb04e58928@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676576465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4Lk0UQhFeocacoG57hB8KXtrziec09wadSV9Xka6+Q=;
        b=ctUxq15A3wY6kSeggVLu7ajO3Z2XYsnODH+EqnUx1yvFN1w2H0QD+RttbyF6XQwcQljme1
        rVqSHkrFiQCY7/9/adFuO+WmZ5G0uOmGcMODdTRyISwS4c0iPVtgOnzR4/LnjqBxutyR3N
        W4hAKALVt2Nhnl89dK2JbmBxZXWPPY0=
Date:   Thu, 16 Feb 2023 11:40:59 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 5/7] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US
To:     Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-6-kuifeng@meta.com>
 <2651cae9-43a5-451b-b93f-874b3624e990@linux.dev>
 <0d674d85-4278-c840-b16b-2a42143cf502@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0d674d85-4278-c840-b16b-2a42143cf502@gmail.com>
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

On 2/16/23 11:17 AM, Kui-Feng Lee wrote:
>>> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct 
>>> bpf_map *new_map)
>>> +{
>>> +    struct bpf_struct_ops_value *kvalue;
>>> +    struct bpf_struct_ops_map *st_map, *old_st_map;
>>> +    struct bpf_map *old_map;
>>> +    int err;
>>> +
>>> +    if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(new_map->map_flags 
>>> & BPF_F_LINK))
>>> +        return -EINVAL;
>>> +
>>> +    old_map = link->map;
>>> +
>>> +    /* It does nothing if the new map is the same as the old one.
>>> +     * A struct_ops that backs a bpf_link can not be updated or
>>> +     * its kvalue would be updated and causes inconsistencies.
>>> +     */
>>> +    if (old_map == new_map)
>>> +        return 0;
>>> +
>>> +    /* The new and old struct_ops must be the same type. */
>>> +    st_map = (struct bpf_struct_ops_map *)new_map;
>>> +    old_st_map = (struct bpf_struct_ops_map *)old_map;
>>> +    if (st_map->st_ops != old_st_map->st_ops)
>>> +        return -EINVAL;
>>> +
>>> +    /* Assure the struct_ops is updated (has value) and not
>>> +     * backing any other link.
>>> +     */
>>> +    kvalue = &st_map->kvalue;
>>> +    if (kvalue->state != BPF_STRUCT_OPS_STATE_INUSE ||
>>> +        refcount_read(&kvalue->refcnt) != 0)
>>> +        return -EINVAL;
>>> +
>>> +    bpf_map_inc(new_map);
>>> +    refcount_set(&kvalue->refcnt, 1);
>>> +
>>> +    set_memory_rox((long)st_map->image, 1);
>>> +    err = st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
>>> +    if (err) {
>>> +        refcount_set(&kvalue->refcnt, 0);
>>> +
>>> +        set_memory_nx((long)st_map->image, 1);
>>> +        set_memory_rw((long)st_map->image, 1);
>>> +        bpf_map_put(new_map);
>>> +        return err;
>>> +    }
>>> +
>>> +    link->map = new_map;
>>
>> Similar here, does this link_update operation needs a lock?
> 
> The update function of tcp_ca checks if the name is unique with the protection 
> of a lock.  bpf_struct_ops_map_update_elem() also check and update state of the 
> kvalue to prevent changing kvalue.  Only one of thread will success to register 
> or update at any moment.

hmm... meaning the lock inside the "->update()" function?  There are many 
variables outside of update() that this function 
(bpf_struct_ops_map_link_update) is setting and testing without a lock. eg. the 
succeeded thread will set refcnt to 1 while the failed thread will set it back 
to 0...

>>> +
>>> +static int link_update_struct_ops(struct bpf_link *link, union bpf_attr *attr)
>>> +{
>>> +    struct bpf_map *new_map;
>>> +    int ret = 0;
>>> +
>>> +    new_map = bpf_map_get(attr->link_update.new_map_fd);
>>> +    if (IS_ERR(new_map))
>>> +        return -EINVAL;
>>> +
>>> +    if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
>>> +        ret = -EINVAL;
>>> +        goto out_put_map;
>>> +    }
>>
>> How about BPF_F_REPLACE?
> 
> Do you mean the new_map should be labeled with BPF_F_REPLACE to replace the old 
> one?

was asking if BPF_F_REPLACE is supported.


