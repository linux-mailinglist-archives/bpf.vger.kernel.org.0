Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C406AD485
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCGCSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 21:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCGCSE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 21:18:04 -0500
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [IPv6:2001:41d0:203:375::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D65708D
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 18:17:36 -0800 (PST)
Message-ID: <e80abe7f-40d5-b35f-1fdc-f82a2ebaf937@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678155455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wY2ucmaRz9MZ/yD7OhbuUdJGp15esk+beXQSszm7Q0=;
        b=IHoW0mN3Z509YRkM3vgBdIpRR81FJW9quv3cwwT2kPw04OJlKruP+fcKCe+P73d21cSPOw
        6h82Bejn6gTHtZ0yezCyBpNItufWUEjIa0W8CMggd/QWkzQ8B9NL/tYLx7otjYG9+D6egH
        PARPkNfpjXVLYPeI3z4rMUU0NCuaPX4=
Date:   Mon, 6 Mar 2023 18:17:32 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/8] net: Update an existing TCP congestion
 control algorithm.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-4-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230303012122.852654-4-kuifeng@meta.com>
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

On 3/2/23 5:21 PM, Kui-Feng Lee wrote:
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index db8b4b488c31..981501871609 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -75,14 +75,8 @@ struct tcp_congestion_ops *tcp_ca_find_key(u32 key)
>   	return NULL;
>   }
>   
> -/*
> - * Attach new congestion control algorithm to the list
> - * of available options.
> - */
> -int tcp_register_congestion_control(struct tcp_congestion_ops *ca)
> +static int tcp_ca_validate(struct tcp_congestion_ops *ca)

It is useful to call tcp_ca_validate() before update_elem transiting a 
struct_ops to BPF_STRUCT_OPS_STATE_READY. Otherwise, the user space will end up 
having a struct_ops that can never be used to create a link.



