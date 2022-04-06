Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F514F5B13
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 12:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbiDFKNn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 06:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiDFKND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 06:13:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78A488AB
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 23:41:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A80421112;
        Wed,  6 Apr 2022 06:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649227305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R06Tqa2otlYimFBq2Kp6YN3I42HvjyTvtNe7aZ39VOw=;
        b=M3BOBz5ohL8G82zq7l2kXVNL83ZCZf7bxf9okLk3yCnW0UHEGDZp1e595xcq88ftgVBqfl
        SPeXzh6LBD+ne+ZzNmh4mMXFv46ySZwjlOAXpPQC/4iH7S0siOglrNVU8Lr/Woari8dANI
        h9RARWNnjt/DOdbG+ygH3/zf3jZ9XXo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36B1B139F5;
        Wed,  6 Apr 2022 06:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aDBfCik2TWJtOgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Apr 2022 06:41:45 +0000
Message-ID: <414907a7-1447-6d1d-98a1-0827d07768fd@suse.com>
Date:   Wed, 6 Apr 2022 09:41:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/2] Add btf__field_exists
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20220404083816.1560501-1-nborisov@suse.com>
 <CAEf4BzZrz42Ffe37n+NbiVsvzHX995=1P_tTun-bHzL8kXOpeg@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <CAEf4BzZrz42Ffe37n+NbiVsvzHX995=1P_tTun-bHzL8kXOpeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6.04.22 г. 2:37 ч., Andrii Nakryiko wrote:
> The problem is that what you've implemented is not a user-space
> equivalent of bpf_core_xxx() macros. CO-RE has extra logic around
> ___<flavor> suffixes, extra type checks, etc, etc. Helper you are
> adding does a very straightforward strings check, which isn't hard to
> implement and it doesn't have to be a set in stone API. So I'm a bit
> hesitant to add this.
> 
> But I can share what I did in similar situations where I had to do
> some CO-RE check both on BPF side and know its result in user-space. I
> built a separate very simple BPF skeleton and all it did was perform
> various feature checks (including those that require CO-RE) and then
> returned the result through global variables. You can then trigger
> such BPF feature-checking program either through bpf_prog_test_run or
> through whatever other means (I actually did a simple sys_enter
> program in my case). See [0] for BPF program side and [1] for
> user-space activation/consumption of that.
> 
> The benefit of this approach is that there is no way BPF and
> user-space sides can get "out of sync" in terms of their feature
> checking. With skeleton it's also extremely simple to do all this.
> 
>    [0]https://github.com/anakryiko/retsnoop/blob/master/src/calib_feat.bpf.c
>    [1]https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L483-L529
> 


That's indeed neat, however what is the minimum kernel version required 
to have global variables work ? AFAIU one requirement is to use a 
recent-enough libbpf which supports the skeleton functionality which is 
fine, userspace components can be updated somewhat easily than target 
kernels.
