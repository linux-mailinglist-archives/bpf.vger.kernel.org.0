Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94D44F7E2A
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiDGLln (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbiDGLli (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 07:41:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18814141FCD
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 04:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5E56B8272F
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 11:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F65C385A4;
        Thu,  7 Apr 2022 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649331576;
        bh=OMIVBNHgpFbiI05YRlnzQ5rmEDxY3MJ3h5uXAKiJd/E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eF27Cwh0bBvcaM+bQLXnYeh09VPR2+T+HybpmKxpOwOrHDiyOmbuHyDw8E3AWvpdi
         acqVrlSxrq9M1YfS9QctPV/x1ct8v1VZ/xr2KoRTeC2FC/me4ciaZ3XRDN3kG/da76
         Xph4AU4EowJo8jwFLAZYxRMunpEgmE14WxIsSTG592zZN0mh0Jl5yzEeLo7mWBxbjD
         4F5Unm8EJtKiHGZgiYyJ9EWdkmLAsWG4hPQKOdsK78bSFCGKXCVCTfyeMf9MejawBu
         a4NdYeq1cogLkaHbG0vXeLhrW15d9OhctHYtR7oRIcS1nlS0oxA08OcjVDTg4S9kgt
         GCaUeeP3gkcag==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 738902750E9; Thu,  7 Apr 2022 13:39:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     wuzongyo@mail.ustc.edu.cn
Cc:     bpf@vger.kernel.org
Subject: Re: Re: [Question] Failed to load ebpf program with BTF-defined map
In-Reply-To: <6dd42c62.3713.180020571c3.Coremail.wuzongyo@mail.ustc.edu.cn>
References: <50b0dbb.2936.17fff506075.Coremail.wuzongyo@mail.ustc.edu.cn>
 <87czhtc3ef.fsf@toke.dk>
 <6dd42c62.3713.180020571c3.Coremail.wuzongyo@mail.ustc.edu.cn>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 07 Apr 2022 13:39:33 +0200
Message-ID: <87zgkx9l6y.fsf@toke.dk>
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

>> wuzongyo@mail.ustc.edu.cn writes:
>> 
>> > Hi,
>> >
>> > I wrote a simple tc-bpf program like that:
>> >
>> >     #include <linux/bpf.h>
>> >     #include <linux/pkt_cls.h>
>> >     #include <linx/types.h>
>> >     #include <bpf/bpf_helpers.h>
>> >
>> >     struct {
>> >         __uint(type, BPF_MAP_TYPE_HASH);
>> >         __uint(max_entries, 1);
>> >         __type(key, int);
>> >         __type(value, int);
>> >     } hmap SEC(".maps");
>> >
>> >     SEC("classifier")
>> >     int _classifier(struct __sk_buff *skb)
>> >     {
>> >         int key = 0;
>> >         int *val;
>> >
>> >         val = bpf_map_lookup_elem(&hmap, &key);
>> >         if (!val)
>> >             return TC_ACT_OK;
>> >         return TC_ACT_OK;
>> >     }
>> >
>> >     char __license[] SEC("license") = "GPL";
>> >
>> > Then I tried to use tc to load the program:
>> >     
>> >     tc qdisc add dev eth0 clsact
>> >     tc filter add dev eth0 egress bpf da obj test_bpf.o
>> >
>> > But the program loading failed with error messages:
>> >     Prog section 'classifier' rejected: Permission denied (13)!
>> >     - Type:          3
>> >     - Instructions:  9 (0 over limit
>> >     - License:       GPL
>> >
>> >     Verifier analysis:
>> >
>> >     Error fetching program/map!
>> >     Unable to load program
>> >
>> > I tried to replace the map definition with the following code and the program is loaded successfully!
>> >
>> >     struct bpf_map_def SEC("maps") hmap = {
>> >         .type = BPF_MAP_TYPE_HASH,
>> >         .key_size = sizeof(int),
>> >         .value_size = sizeof(int),
>> >         .max_entries = 1,
>> >     };
>> >
>> > With bpftrace, I can find that the errno -EACCES is returned by function do_check(). But I am still confused what's wrong with it.
>> >
>> > Linux Version: 5.17.0-rc3+ with CONFIG_DEBUG_INFO_BTF=y
>> > TC Version: 5.14.0
>> >
>> > Any suggestion will be appreciated!
>> 
>> If the latter works but the former doesn't, my guess would be that
>> iproute2 is compiled without libbpf support (in which case it would not
>> support BTF-defined maps either). If it does have libbpf support, that
>> (and the version of libbpf used) will be included in the output of `tc
>> -v`.
>> 
>> You could recompile iproute2 with enable libbpf support enabled, or as
>> Andrii suggests you can write your own loader using libbpf...
>> 
>
> It works with recompiled-iproute2. Thanks very much!

Great! You're welcome! :)

-Toke
