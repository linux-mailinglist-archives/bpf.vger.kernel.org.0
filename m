Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF76C3907
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCUSSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCUSSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:18:22 -0400
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [IPv6:2001:41d0:1004:224b::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6218242BCE
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:18:21 -0700 (PDT)
Message-ID: <9d370e0b-f57b-0a3e-9b1b-58930b0dfee1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679422699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLpYcY8j5ENczp+OhM+5TuJq33aTHBCffICueGFOmY8=;
        b=OetJ9KsgIm4jncrjz80CoGtyz8Wi8DmsR6KS2XtfTaUL0TP8kURJlZhTNvo+zFHzdCTPyt
        QuEuKmWGOYON37AilDfJptFynjOwr+kHuXA0T/QgZOijPr9Q1p6q2f7heuYltN25DpEIfs
        viA+HQKAD99o8e23RHiJYWIGE5pEKys=
Date:   Tue, 21 Mar 2023 11:18:16 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 5/8] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
 <20230320195644.1953096-6-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
In-Reply-To: <20230320195644.1953096-6-kuifeng@meta.com>
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

On 3/20/23 12:56 PM, Kui-Feng Lee wrote:
> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map,
> +					  struct bpf_map *expected_old_map)
> +{
> +	struct bpf_struct_ops_map *st_map, *old_st_map;
> +	struct bpf_map *old_map;
> +	struct bpf_struct_ops_link *st_link;
> +	int err = 0;
> +
> +	st_link = container_of(link, struct bpf_struct_ops_link, link);
> +	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
> +
> +	if (!bpf_struct_ops_valid_to_reg(new_map))
> +		return -EINVAL;
> +
> +	mutex_lock(&update_mutex);
> +
> +	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
> +	if (expected_old_map && old_map != expected_old_map) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
> +	/* The new and old struct_ops must be the same type. */
> +	if (st_map->st_ops != old_st_map->st_ops) {
> +		err = -EINVAL;

Other ".update_prog" implementation returns -EPERM. eg. take a look at 
cgroup_bpf_replace().

> +		goto err_out;
> +	}
> +
> +	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
> +	if (err)
> +		goto err_out;
> +
> +	bpf_map_inc(new_map);
> +	rcu_assign_pointer(st_link->map, new_map);
> +	bpf_map_put(old_map);
> +
> +err_out:
> +	mutex_unlock(&update_mutex);
> +
> +	return err;
> +}
> +


