Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406FF6C5F72
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 07:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCWGGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 02:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCWGGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 02:06:12 -0400
Received: from out-14.mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E192B602
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 23:05:51 -0700 (PDT)
Message-ID: <66f97e66-895c-1cb3-91e3-ac960ef098dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679551549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vOOTfAtaePqBBcBF0OsXTPayxEy/eLgu3Ea/MLxpGA=;
        b=HtYlmq4huLueEL21Jy5PM5URrbCGXzGKJN3qh/QSUZdatXbVvVb8nsfEFiK8v+Ex+XCaX7
        cI/xYKM7E7IAUDgrNtQjvvrLlxSlOyDKQefi6vaHdntj7qvCZOFWRkevDQRorR7PG7goH8
        vdHdOjnxfFjMTLfJ49kIKxXeodjUEhE=
Date:   Wed, 22 Mar 2023 23:05:45 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 8/8] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230323032405.3735486-1-kuifeng@meta.com>
 <20230323032405.3735486-9-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230323032405.3735486-9-kuifeng@meta.com>
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

On 3/22/23 8:24 PM, Kui-Feng Lee wrote:
> +static void test_link_replace(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_link_update_opts, opts);
> +	struct tcp_ca_update *skel;
> +	struct bpf_link *link;
> +	int err;
> +
> +	skel = tcp_ca_update__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> +	ASSERT_OK_PTR(link, "attach_struct_ops_1st");
> +	bpf_link__destroy(link);
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
> +	ASSERT_OK_PTR(link, "attach_struct_ops_1st");
I fixed this up s/1st/2nd/. Also,
added a 'if (!ret)' check before synchronize_rcu() in patch 2.
massaged the comment in bpf_struct_ops_map_free in patch1.

The set is applied. Thanks.

