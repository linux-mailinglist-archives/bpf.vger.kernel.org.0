Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555E4E60E2
	for <lists+bpf@lfdr.de>; Thu, 24 Mar 2022 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbiCXJLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Mar 2022 05:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiCXJLu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Mar 2022 05:11:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C231346
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 02:10:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c62so4843514edf.5
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dRVwDCOvBXtaDAGHJnSTJXzAM7+aCoBfKXxR6wgHzFM=;
        b=JMaiC2WUPeBYBGTsR5y+elOGLLXVcj207pOLL8e7NqfhslP93iODLlaKV2aBouS1Uk
         QQRTrQmASGWHbAK2um/vRCc3J8VEsk5m7eFUm+8iJG6jEsftS9inlG9fV+XCJLG+4eVD
         xbctIrn0NsxVF4pRzPZHeo7Hjuv7xPfK655AzBSQ5lUxFjiLR2hxSEBhsZ3zLnsdxKC8
         Ja2lRHzL7gZuDMr9As4qf0DPksXBppSMY+ZlWzJYuvZHZHLAq+4AxARr8PdrBI6mnIoE
         QKLS38Rz6cv9RbRIOoBFLjkljBXIVxp+Fy3zig9kf0bTpiqfL+NVN7ZvfY9Kfc2uR5r9
         hsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dRVwDCOvBXtaDAGHJnSTJXzAM7+aCoBfKXxR6wgHzFM=;
        b=A4KRO9V3y4IozrOItR0VnjnTwhLpcCNNyiX8pGTDvDsuB9nWDFbN0tGgzh7ruvUBfF
         RS02IbB2EUR5OBoWXGc+N9i6G1YcikGQvZls17MdW2yfJKQU0vpMFOHdXR5ghCtqo0CX
         BFlP9lC1W2XROAeAxtX8dK0N7Et+GsEIxL/QoyzsSBdnkjLdOWvDI7BGxxziZAAvlzJj
         iScjtrif2uaz0RXHHTkugrMSEwnGacXWwZY4kJkBgcWbuMg2/7W8S7vTB7l4LCMs5Ns1
         Z74M+mN9aEjJIOtTxF+ZSicjDF5uGg5EiMy9So5I/roLMinmcepfEudUcqLSCcoWKrZh
         qp1A==
X-Gm-Message-State: AOAM532LjaAJFKRB1gzDQHtGAWqzhEF+o3lHWWxHXAjuZlx0edASCrtR
        zi2rpTO2jHqVTcA9XRJMDXc=
X-Google-Smtp-Source: ABdhPJyx2d0Zj9vCaFCLoAZxa1C52r+9W7NFzNyHswFUqav0NOFqdqlIOuKtTCUcvTuehS6xZkhUrA==
X-Received: by 2002:a05:6402:1906:b0:418:ff14:62b8 with SMTP id e6-20020a056402190600b00418ff1462b8mr5513015edz.40.1648113016950;
        Thu, 24 Mar 2022 02:10:16 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id ga5-20020a1709070c0500b006de43e9605asm866799ejc.181.2022.03.24.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:10:16 -0700 (PDT)
Date:   Thu, 24 Mar 2022 10:10:14 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 12/13] selftests/bpf: Add C tests for kptr
Message-ID: <Yjw1dksSQm373PEi@krava>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-13-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320155510.671497-13-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 09:25:09PM +0530, Kumar Kartikeya Dwivedi wrote:

SNIP

> +static __always_inline
> +void test_kptr(struct map_value *v)
> +{
> +	test_kptr_unref(v);
> +	test_kptr_ref(v);
> +	test_kptr_get(v);
> +}
> +
> +SEC("tc")
> +int test_map_kptr(struct __sk_buff *ctx)
> +{
> +	void *maps[] = {
> +		&array_map,
> +		&hash_map,
> +		&hash_malloc_map,
> +		&lru_hash_map,
> +	};
> +	struct map_value *v;
> +	int i, key = 0;
> +
> +	for (i = 0; i < sizeof(maps) / sizeof(*maps); i++) {
> +		v = bpf_map_lookup_elem(&array_map, &key);

hi,
I was just quickly checking on the usage, so I might be missing something,
but should this be lookup to maps[i] instead of array_map ?

similar below in test_map_in_map_kptr

jirka

> +		if (!v)
> +			return 0;
> +		test_kptr(v);
> +	}
> +	return 0;
> +}
> +
> +SEC("tc")
> +int test_map_in_map_kptr(struct __sk_buff *ctx)
> +{
> +	void *map_of_maps[] = {
> +		&array_of_array_maps,
> +		&array_of_hash_maps,
> +		&array_of_hash_malloc_maps,
> +		&array_of_lru_hash_maps,
> +		&hash_of_array_maps,
> +		&hash_of_hash_maps,
> +		&hash_of_hash_malloc_maps,
> +		&hash_of_lru_hash_maps,
> +	};
> +	struct map_value *v;
> +	int i, key = 0;
> +	void *map;
> +
> +	for (i = 0; i < sizeof(map_of_maps) / sizeof(*map_of_maps); i++) {
> +		map = bpf_map_lookup_elem(&array_of_array_maps, &key);
> +		if (!map)
> +			return 0;
> +		v = bpf_map_lookup_elem(map, &key);
> +		if (!v)
> +			return 0;
> +		test_kptr(v);
> +	}
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.35.1
> 
