Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8B5F63C1
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJFJkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJFJkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 05:40:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F40543CA
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 02:40:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f11so1816829wrm.6
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izNtQnU5zJ+lGV6O8oFO8rljpG2z9XRQs985kSaQeOA=;
        b=dg6Ynbx5OZSsk1YCwXN4F6VWdW/dR6+aL061fknBK3eS4Q6OM3hMd5Fc0n9+w2hh79
         m8dWfbPtQh6gte6zP9Vab1VSRYd77FGn+8FbTRAnKhZSh3KdDiYGRGThprnz9/AR0Mit
         3RmKBzDt2c8DXJyf04bpcKZ+fI9sunVnwX/lv9C//tuldz3NQqirKC53j1Xkv44UDT5v
         xTnp+2oCIrCAARQlMf305IfCDXijwBDOnv9htNKUNnNCN3oiGvh/hINmFY1uPU2r4CS5
         uoUIVjgGQvEUwA7qtYJ0gw5OfKWzxEZsREHzkQfwJneVKpo6OgadJQiDkqVbHgqTrwhY
         S/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izNtQnU5zJ+lGV6O8oFO8rljpG2z9XRQs985kSaQeOA=;
        b=CR6e/TZSIrhF2J3SeCxj6VDl4jw5X4Gh93Az1miBawd8ftXrqLVuO4OVh7yIBSElgw
         naT7DGArzazYpinzqs2AqzpfXISUbZIqCfMprY9M3OkeZWBcR5zUyx+pqWWKUvBLvA2+
         IwlTZHlQ0mS2QkNHaNeventfTIN4UoNz5lPhzT1MrWZi10yaVp+ebYlRByW7GSRXx5zu
         N7xAzen46DUwyiWiG5vgUBSDRVUbBwE4h+qKt5GnF/jZvo+6tl7Unaqe83YaKMj2LpmV
         iQoOFSKbvbU4JcpID6+bPTd7VjM5936RrGYV4wI1SxtRt/XZX0PfJPDJCBK+V6EX3Fe4
         QsLg==
X-Gm-Message-State: ACrzQf1DBlXT4CBgTq3IyDrv87mzDOARqYr8IqxrmOmr2HuhMlMLPpg/
        HlheL1/cm7kY0VpzY2lIu2nGug==
X-Google-Smtp-Source: AMsMyM4LaOOfySU2WXmQhhircERn2/pOgFdNhb6EQE7LQ8dA1Rx84ovSM2ZJ200gK+tKafJLpNg4jw==
X-Received: by 2002:a05:6000:1845:b0:22a:4b7a:6f55 with SMTP id c5-20020a056000184500b0022a4b7a6f55mr2497105wri.288.1665049211681;
        Thu, 06 Oct 2022 02:40:11 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id x7-20020adfffc7000000b0022cbf4cda62sm19914552wrs.27.2022.10.06.02.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:40:11 -0700 (PDT)
Message-ID: <0045adb8-e526-87f9-ee54-7faf6fb0ae31@isovalent.com>
Date:   Thu, 6 Oct 2022 10:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: explicitly define BPF_FUNC_xxx
 integer values
Content-Language: en-GB
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Andrea Terzolo <andrea.terzolo@polito.it>
References: <20221006042452.2089843-1-andrii@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221006042452.2089843-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-10-06 05:24:51 GMT+0100 ~ Andrii Nakryiko <andrii@kernel.org>
> Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
> implicit sequential values being assigned by compiler. This is
> convenient, as new BPF helpers are always added at the very end, but it
> also has its downsides, some of them being:
> 
>   - with over 200 helpers now it's very hard to know what's each helper's ID,
>     which is often important to know when working with BPF assembly (e.g.,
>     by dumping raw bpf assembly instructions with llvm-objdump -d
>     command). it's possible to work around this by looking into vmlinux.h,
>     dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
>     bpf_helper_defs.h, etc. But it always feels like an unnecessary step
>     and one should be able to quickly figure this out from UAPI header.

I've also been using bpftool :)

	$ bpftool -j feature list_builtins helpers | \
		jq 'index("bpf_get_current_task_btf")'
	158

(But agreed, UAPI header would be the best place to look at.)

> 
>   - when backporting and cherry-picking only some BPF helpers onto older
>     kernels it's important to be able to skip some enum values for helpers
>     that weren't backported, but preserve absolute integer IDs to keep BPF
>     helper IDs stable so that BPF programs stay portable across upstream
>     and backported kernels.
> 
> While neither problem is insurmountable, they come up frequently enough
> and are annoying enough to warrant improving the situation. And for the
> backporting the problem can easily go unnoticed for a while, especially
> if backport is done with people not very familiar with BPF subsystem overall.
> 
> Anyways, it's easy to fix this by making sure that __BPF_FUNC_MAPPER
> macro provides explicit helper IDs. Unfortunately that would potentially
> break existing users that use UAPI-exposed __BPF_FUNC_MAPPER and are
> expected to pass macro that accepts only symbolic helper identifier
> (e.g., map_lookup_elem for bpf_map_lookup_elem() helper).
> 
> As such, we need to introduce a new macro (___BPF_FUNC_MAPPER) which
> would specify both identifier and integer ID, but in such a way as to
> allow existing __BPF_FUNC_MAPPER be expressed in terms of new
> ___BPF_FUNC_MAPPER macro. And that's what this patch is doing. To avoid
> duplication and allow __BPF_FUNC_MAPPER stay *exactly* the same,
> ___BPF_FUNC_MAPPER accepts arbitrary "context" arguments, which can be
> used to pass any extra macros, arguments, and whatnot. In our case we
> use this to pass original user-provided macro that expects single
> argument and __BPF_FUNC_MAPPER is using it's own three-argument
> __BPF_FUNC_MAPPER_APPLY intermediate macro to impedance-match new and
> old "callback" macros.
> 
> Once we resolve this, we use new ___BPF_FUNC_MAPPER to define enum
> bpf_func_id with explicit values. The other users of __BPF_FUNC_MAPPER
> in kernel (namely in kernel/bpf/disasm.c) are kept exactly the same both
> as demonstration that backwards compat works, but also to avoid
> unnecessary code churn.
> 
> Note that new ___BPF_FUNC_MAPPER() doesn't forcefully insert comma
> between values, as that might not be appropriate in all possible cases
> where ___BPF_FUNC_MAPPER might be used by users. This doesn't reduce
> usability, as it's trivial to insert that comma inside "callback" macro.
> 
> To validate all the manually specified IDs are exactly right, we used
> BTF to compare before and after values:
> 
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > after.txt
>   $ git stash # stach UAPI changes
>   $ make -j90
>   ... re-building kernel without UAPI changes ...
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > before.txt
>   $ diff -u before.txt after.txt
>   --- before.txt  2022-10-05 10:48:18.119195916 -0700
>   +++ after.txt   2022-10-05 10:46:49.446615025 -0700
>   @@ -1,4 +1,4 @@
>   -[14576] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
>   +[9560] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
>           'BPF_FUNC_unspec' val=0
>           'BPF_FUNC_map_lookup_elem' val=1
>           'BPF_FUNC_map_update_elem' val=2
> 
> As can be seen from diff above, the only thing that changed was resulting BTF
> type ID of ENUM bpf_func_id, not any of the enumerators, their names or integer
> values.
> 
> The only other place that needed fixing was scripts/bpf_doc.py used to generate
> man pages and bpf_helper_defs.h header for libbpf and selftests. That script is
> tightly-coupled to exact shape of ___BPF_FUNC_MAPPER macro definition, so had
> to be trivially adapted.
> 
> Cc: Quentin Monnet <quentin@isovalent.com>
> Reported-by: Andrea Terzolo <andrea.terzolo@polito.it>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Looks good to me. The legacy __BPF_FUNC_MAPPER() is also still working
well in bpftool.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

