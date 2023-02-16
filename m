Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1459F699FCE
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 23:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBPWiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 17:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPWiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 17:38:22 -0500
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [IPv6:2001:41d0:203:375::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAEA3CE2A
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 14:38:21 -0800 (PST)
Message-ID: <64d1219c-3d07-733a-17cc-17bb8fd27827@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676587098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rTMQeKT+IBbgviPNuxbtRnc33W3VLEfp8KwOYVMHx4=;
        b=Dsj6M+pt7QMbU/ifO686uq+F2SUR7UxSUu7nXdNollI4pz8dn2qWQaY+dKMIPUyAi5nJm+
        sYGibLB4rvGFSoJDbVAEx2ZkZk20RSsNriRo5VvtAvSjkwIw6FuvIXYp1gz6al4l2+6z7A
        0mk8xUWq3wZ7f9zj8XC69pjGcyU7IKU=
Date:   Thu, 16 Feb 2023 14:38:14 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/7] bpf: Register and unregister a struct_ops by
 their bpf_links.
Content-Language: en-US
To:     Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-4-kuifeng@meta.com>
 <4f5012d6-e07a-2602-3526-d43244d9d978@linux.dev>
 <28a01a8a-77d2-dcdc-eda4-a6ff7c7b54c0@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <28a01a8a-77d2-dcdc-eda4-a6ff7c7b54c0@gmail.com>
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

On 2/16/23 8:42 AM, Kui-Feng Lee wrote:
>>> @@ -638,6 +647,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union 
>>> bpf_attr *attr)
>>>       set_vm_flush_reset_perms(st_map->image);
>>>       bpf_map_init_from_attr(map, attr);
>>> +    map->map_flags |= attr->map_flags & BPF_F_LINK;
>>
>> This should have already been done in bpf_map_init_from_attr().
> 
> bpf_map_init_from_attr() will filter out all flags except BPF_F_RDONLY & 
> BPF_F_WRONLY.

should be the opposite:

static u32 bpf_map_flags_retain_permanent(u32 flags)
{
	/* Some map creation flags are not tied to the map object but
          * rather to the map fd instead, so they have no meaning upon
          * map object inspection since multiple file descriptors with
          * different (access) properties can exist here. Thus, given
          * this has zero meaning for the map itself, lets clear these
          * from here.
          */
	return flags & ~(BPF_F_RDONLY | BPF_F_WRONLY);
}
