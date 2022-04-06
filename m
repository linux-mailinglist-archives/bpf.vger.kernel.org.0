Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E546D4F6D26
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 23:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiDFVpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 17:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbiDFVpT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 17:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BC12C27A
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 14:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FEB61AA3
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 21:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68057C385A1;
        Wed,  6 Apr 2022 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649280203;
        bh=7hBGFX9ZUxrdxq4wXzruS9d3afK+6ZitJJSlUy7mghw=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=QFl5XHqXgpH/LLpUJoQy+lwqhHqhUkBZHruXM+1TtalLz3Sdj4jVmwyzSJrkUBsOT
         HmpUY0K4PJEwZ4/GIALUj5vVxTiGd9Atqy/qpfF6ARonATSXNeNnRps0FXv/cQeGNX
         DZGBK+PMuuQx7ZLPE1Rnum2D4a4WAGwmASJEAzMVBcATigJXCz+M71P1wI8St5zeME
         j8u8xmRKCT7fPuhmo+M+WtcIBD6wZOyC8s1wNFWtVEmaYVrbo61qqak4ccGvw1UQ03
         cN5Gs1RjOkZnTY9jstpM7vYyW1TvUqSrETlZhMvlsose/okCnExqEcv8Y4kid2V6Sb
         8Hvv7AJM7ri1Q==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 73C8A274FAD; Wed,  6 Apr 2022 23:23:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     wuzongyo@mail.ustc.edu.cn, bpf@vger.kernel.org
Subject: Re: [Question] Failed to load ebpf program with BTF-defined map
In-Reply-To: <50b0dbb.2936.17fff506075.Coremail.wuzongyo@mail.ustc.edu.cn>
References: <50b0dbb.2936.17fff506075.Coremail.wuzongyo@mail.ustc.edu.cn>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 06 Apr 2022 23:23:20 +0200
Message-ID: <87czhtc3ef.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

wuzongyo@mail.ustc.edu.cn writes:

> Hi,
>
> I wrote a simple tc-bpf program like that:
>
>     #include <linux/bpf.h>
>     #include <linux/pkt_cls.h>
>     #include <linx/types.h>
>     #include <bpf/bpf_helpers.h>
>
>     struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __uint(max_entries, 1);
>         __type(key, int);
>         __type(value, int);
>     } hmap SEC(".maps");
>
>     SEC("classifier")
>     int _classifier(struct __sk_buff *skb)
>     {
>         int key = 0;
>         int *val;
>
>         val = bpf_map_lookup_elem(&hmap, &key);
>         if (!val)
>             return TC_ACT_OK;
>         return TC_ACT_OK;
>     }
>
>     char __license[] SEC("license") = "GPL";
>
> Then I tried to use tc to load the program:
>     
>     tc qdisc add dev eth0 clsact
>     tc filter add dev eth0 egress bpf da obj test_bpf.o
>
> But the program loading failed with error messages:
>     Prog section 'classifier' rejected: Permission denied (13)!
>     - Type:          3
>     - Instructions:  9 (0 over limit
>     - License:       GPL
>
>     Verifier analysis:
>
>     Error fetching program/map!
>     Unable to load program
>
> I tried to replace the map definition with the following code and the program is loaded successfully!
>
>     struct bpf_map_def SEC("maps") hmap = {
>         .type = BPF_MAP_TYPE_HASH,
>         .key_size = sizeof(int),
>         .value_size = sizeof(int),
>         .max_entries = 1,
>     };
>
> With bpftrace, I can find that the errno -EACCES is returned by function do_check(). But I am still confused what's wrong with it.
>
> Linux Version: 5.17.0-rc3+ with CONFIG_DEBUG_INFO_BTF=y
> TC Version: 5.14.0
>
> Any suggestion will be appreciated!

If the latter works but the former doesn't, my guess would be that
iproute2 is compiled without libbpf support (in which case it would not
support BTF-defined maps either). If it does have libbpf support, that
(and the version of libbpf used) will be included in the output of `tc
-v`.

You could recompile iproute2 with enable libbpf support enabled, or as
Andrii suggests you can write your own loader using libbpf...

-Toke
