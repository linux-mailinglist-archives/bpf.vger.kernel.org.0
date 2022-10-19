Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3C6037B7
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 03:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJSB7Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 21:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJSB7Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 21:59:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8F82AF
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 18:59:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p14so15868593pfq.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 18:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YX9r55K1dZJaz0JKA3lPxQL0e+eowuL5BWE5XkqMOKM=;
        b=kLzpvBkXvvTQGkcihH9IlJvfu/yeVfNvGhmwpvQuWxyn040sNZRCV9IPaXQmcgKXVx
         zPnwFvzt+iGtgDs6nXn9V+KirQ4ql2jGEsbr3qeMS/9XcJ0BfE+8M9N19+5gh5nXV958
         Q/DAtU1fnwQ2MjIqDiVCsvYo3Kg+TCQ67sNq3TBG4Y/puQ1xfD1ffo3HPIkpq9ocHFrt
         9acXVton7w5XyRW9ugo3zkOlEL17G+Wzu4tkYKrHLVU7wyoTau2SH+8H1jIMf1PmISh1
         fu0Zt3JgiUoM3l94i0GcjTFEetj4JCV6VKxjJ9ViQPCPCrdA1zdEuIO+uVvd2wArxY/z
         D0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX9r55K1dZJaz0JKA3lPxQL0e+eowuL5BWE5XkqMOKM=;
        b=fTJ+Jzq6MNQuwXKvQbayqnNMMMi4f7W/PC1O/egFLKzDvkC+rrUOBioIY5PE11jB/w
         bNxVylKSl9ThEFyDcWKk2nHCWz4ZWhgvnPfBUq/1rNeBgBHkxlgKPX8zUUBfb21Qal9K
         MhyZ+EYR6AwtmhgzpGaDv2rpci4tgzz1BPbGkWPDaFU0qOsGniwmwiMLbi2ZPFIoctsh
         5hxtkLZWTsMD0yEkOu5tYLuBbmJONwl3nWf5nV5FmXEprIEkXsp/jQjc73dbeok5E3wm
         MBX4+bM5lDYRA4BdsRESnMrFQAiQOaHsc/T3lBh1xPMPsAhZ6gUr3v502NWUVvnOc9BP
         /ExA==
X-Gm-Message-State: ACrzQf3WudWPh6pC2oREOsrnN/BK1D+qfti4XdAb94yb2NF1wWA7nRSd
        3SdLxqX48Oq45agpNObJhk4=
X-Google-Smtp-Source: AMsMyM7qs5Q89mFJqOenw+wAynbeAnGHIVJo+hffMAapcKmfpdTVJjMuTYc8S0JXhSxCo6lLUl6w5w==
X-Received: by 2002:a63:1112:0:b0:43c:7998:ac15 with SMTP id g18-20020a631112000000b0043c7998ac15mr5269528pgl.51.1666144759277;
        Tue, 18 Oct 2022 18:59:19 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:a07d])
        by smtp.gmail.com with ESMTPSA id w9-20020a628209000000b0056276519e8fsm3289319pfd.73.2022.10.18.18.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:59:18 -0700 (PDT)
Date:   Tue, 18 Oct 2022 18:59:16 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 09/25] bpf: Support bpf_list_head in map
 values
Message-ID: <20221019015916.cyrmxrqskztsn7gf@macbook-pro-4.dhcp.thefacebook.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-10-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013062303.896469-10-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 11:52:47AM +0530, Kumar Kartikeya Dwivedi wrote:
> Add the basic support on the map side to parse, recognize, verify, and
> build metadata table for a new special field of the type struct
> bpf_list_head. To parameterize the bpf_list_head for a certain value
> type and the list_node member it will accept in that value type, we use
> BTF declaration tags.
> 
> The definition of bpf_list_head in a map value will be done as follows:
> 
> struct foo {
> 	struct bpf_list_node node;
> 	int data;
> };
> 
> struct map_value {
> 	struct bpf_list_head head __contains(foo, node);
> };
> 
> Then, the bpf_list_head only allows adding to the list 'head' using the
> bpf_list_node 'node' for the type struct foo.
> 
> The 'contains' annotation is a BTF declaration tag composed of four
> parts, "contains:kind:name:node" where the kind and name is then used to
> look up the type in the map BTF. The node defines name of the member in
> this type that has the type struct bpf_list_node, which is actually used
> for linking into the linked list. For now, 'kind' part is hardcoded as
> struct.

...

> +	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
> +	if (!value_type)
> +		return -EINVAL;
> +	if (strncmp(value_type, "struct:", sizeof("struct:") - 1))
> +		return -EINVAL;
> +	value_type += sizeof("struct:") - 1;

I don't get it.
The patch 24 does:
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:struct:" #name ":" #node)))

The 'struct:' part is invisible to users. They won't make a mistake.
Why bother adding it to BTF and then check for it?
Backward compat concerns?
But it's in bpf_experimental.h.
That probably be the last thing to change and so easy to do.
Please drop it?

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> new file mode 100644
> index 000000000000..4e31790e433d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -0,0 +1,23 @@
> +#ifndef __KERNEL__
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +

Why bother with the above?
The below should be enough ?

> +#else
> +
> +struct bpf_list_head {
> +	__u64 __a;
> +	__u64 __b;
> +} __attribute__((aligned(8)));
> +
> +struct bpf_list_node {
> +	__u64 __a;
> +	__u64 __b;
> +} __attribute__((aligned(8)));
> +
> +#endif

> +
> +#ifndef __KERNEL__
> +#endif

hmm.
