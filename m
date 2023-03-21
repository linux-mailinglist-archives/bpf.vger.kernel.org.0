Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690C6C3C68
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 22:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCUVEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCUVEY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 17:04:24 -0400
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [IPv6:2001:41d0:203:375::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA35957D1D
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 14:04:23 -0700 (PDT)
Message-ID: <57c40769-52a9-70e4-31f1-8ea6e0e73fa4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679432661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgL32EAEfL3GZ5BzUmS6NInztv7KnR1oSF5ygLo7hic=;
        b=uxGNZHK5nvdDEK4YLglFF0Iky6hbUvdUggkifOthvJ1RhYCGFzXQK0Db1/pnwjwtin6g5S
        v6xz2xXFRDWCDIGaJjZO2F1rbvZEf/BE5FgkayQjm8M3RxQpAOdOHJmHJwJdtFrODjmnkN
        n9dznK3P4YIBDlzH8lFcFbrCs6fWSvE=
Date:   Tue, 21 Mar 2023 14:04:14 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 6/8] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
 <20230320195644.1953096-7-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230320195644.1953096-7-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/20/23 12:56 PM, Kui-Feng Lee wrote:
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 56a60ab2ca8f..f84d68c049e3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11639,6 +11639,11 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   
>   	/* kern_vdata should be prepared during the loading phase. */
>   	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
> +	/* It can be EBUSY if the map has been used to create or
> +	 * update a link before.  We don't allow updating the value of
> +	 * a struct_ops once it is set.  That ensures that the value
> +	 * never changed.  So, it is safe to skip EBUSY.
> +	 */

This belongs to the earlier patch (4?).

>   	if (err && err != -EBUSY) {
>   		free(link);
>   		return libbpf_err_ptr(err);

