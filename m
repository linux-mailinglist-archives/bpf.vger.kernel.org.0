Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBE6BF072
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 19:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCQSK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 14:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQSK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 14:10:56 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5350936FD7
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 11:10:54 -0700 (PDT)
Message-ID: <9b18b21b-4429-fd87-8c74-0de2900eee42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679076652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JuVGhibCao2hzNBwdOorZVhKeSQ7ImAbynMxgGpOtA=;
        b=dN3lVoaaXec7y99gzLJ+BBhArs3nR85kCgGPOxyMWoZJ2QfYySBIF0TyujwDC+rOclZ1G3
        1Q6+CObRpwEs1sA9kD5GBaqBFUi47yUShyJzZouMskasuTeHvQ8e9CbT2twUm/7Xi05C0J
        tK4/w5llKG++fZD/3aQhk0Th6U/OCBs=
Date:   Fri, 17 Mar 2023 11:10:48 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 3/8] bpf: Create links for BPF struct_ops
 maps.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-4-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230316023641.2092778-4-kuifeng@meta.com>
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

On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
> +int bpf_struct_ops_link_create(union bpf_attr *attr)
> +{
> +	struct bpf_struct_ops_link *link = NULL;
> +	struct bpf_link_primer link_primer;
> +	struct bpf_struct_ops_map *st_map;
> +	struct bpf_map *map;
> +	int err;
> +
> +	map = bpf_map_get(attr->link_create.map_fd);
> +	if (!map)
> +		return -EINVAL;
> +
> +	st_map = (struct bpf_struct_ops_map *)map;
> +
> +	if (!bpf_struct_ops_valid_to_reg(map)) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	link = kzalloc(sizeof(*link), GFP_USER);
> +	if (!link) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
> +	RCU_INIT_POINTER(link->map, map);

The link->map assignment should be done with the bpf_link_settle(), meaning only 
assign after everything else has succeeded.

The link is not exposed to user space until bpf_link_settle(). The link->map 
assignment can be done after ->reg succeeded and do it just before 
bpf_link_settle(). Then there is no need to do the RCU_INIT_POINTER(link->map, 
NULL) dance in the error case.

> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err)
> +		goto err_out;
> +
> +	err = st_map->st_ops->reg(st_map->kvalue.data);
> +	if (err) {
> +		/* No RCU since no one has a chance to read this pointer yet. */
> +		RCU_INIT_POINTER(link->map, NULL);
> +		bpf_link_cleanup(&link_primer);
> +		link = NULL;
> +		goto err_out;
> +	}
> +
> +	return bpf_link_settle(&link_primer);
> +
> +err_out:
> +	bpf_map_put(map);
> +	kfree(link);
> +	return err;
> +}

