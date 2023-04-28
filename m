Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E046F0FED
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 03:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjD1BQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 21:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjD1BQu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 21:16:50 -0400
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9726BA
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 18:16:48 -0700 (PDT)
Message-ID: <1c06f0cd-68f7-17d9-2f78-481689c04ae4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682644607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4GvX/0oGjMptBTKVrOOgA8/mSjoENnBJqUySYMUM84=;
        b=Y2zXcVlSCjParkDuSBPaqh/aPsVaM/H9HrCk7y6qh1Ae5hNf1JUvL240SnL3kufFwPAKd3
        PeNiSI+nRgaAee9MUQTmNZ7uADptXX2jCuU97rRzoqBuSeb5syTl9v1FrlORiPCpDYaIMc
        mYk5IWtgJmSJaUYvobbFxkImyOsoupY=
Date:   Thu, 27 Apr 2023 18:16:45 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: btf_dump_type_data_check_overflow needs
 to consider BTF_MEMBER_BITFIELD_SIZE
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230428010839.1328507-1-martin.lau@linux.dev>
In-Reply-To: <20230428010839.1328507-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/27/23 6:08 PM, Martin KaFai Lau wrote:
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 580985ee5545..8f659ec8798d 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2250,9 +2250,19 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
>   					     const struct btf_type *t,
>   					     __u32 id,
>   					     const void *data,
> -					     __u8 bits_offset)
> +					     __u8 bits_offset,
> +					     __u8 bit_sz)
>   {
> -	__s64 size = btf__resolve_size(d->btf, id);
> +	__s64 size;
> +
> +	if (bit_sz) {
> +		/* bits_offset is at most 7. bit_sz is at most 128. */
> +		__u8 nr_bytes = (bits_offset + bit_sz + 7) / 8;
> +
> +		return data + nr_bytes > d->typed_dump->data_end ? -E2BIG : 0;

hmm...returning 0 here is not very correct. nr_bytes should be returned instead, 
although does not seem anyone is using the value. will post v2.

> +	}
> +
> +	size = btf__resolve_size(d->btf, id);

