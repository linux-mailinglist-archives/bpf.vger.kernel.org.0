Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C0A6A4F7F
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 00:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0XFg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 18:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB0XFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:05:35 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FCBA248
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=yRXDEaUq62AAPYXnTpBNNKaVh2XdCnOI1noKdg7Ykds=; b=lBlpkNl7eJhXj8MqjsojaWNuo4
        gtvO+QR9v9aafeVXv0rs6nhKvjbZEAWglH/uD/LdmczJAF8EaEnnSe5GY5kpdx0vjdwFWACiygely
        AspqjWOBAsjyv6EqL0alshy9W27cioCD7E/7FHhhpZbbJGAGyNmM4RFwN7ppNwQ1Bxct6FKG9JuaJ
        UED2U66Vb53/DMCLXuTrZH6ifVmh8DE99c9tYfEIcbTsuqid8WwG3r2le97I6G/dURyp4IcEDfdHE
        pHsBWMjfbkjf1okC7VAF5kffSi54ZvSB4KxuUzwcHQsQVqt8VSVCFsfhxAe6yJaJ9s2FHepcSGkAm
        s8zK4ZAA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pWm7W-0001uc-Vo; Mon, 27 Feb 2023 23:37:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pWm7W-000Mii-HN; Mon, 27 Feb 2023 23:37:22 +0100
Subject: Re: [PATCH bpf-next v3 00/18] bpf: bpf memory usage
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org
References: <20230227152032.12359-1-laoar.shao@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <24b8a412-6be5-7590-acbd-4ff3990bf812@iogearbox.net>
Date:   Mon, 27 Feb 2023 23:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26825/Mon Feb 27 09:24:38 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/27/23 4:20 PM, Yafang Shao wrote:
> Currently we can't get bpf memory usage reliably. bpftool now shows the
> bpf memory footprint, which is difference with bpf memory usage. The
> difference can be quite great in some cases, for example,
> 
> - non-preallocated bpf map
>    The non-preallocated bpf map memory usage is dynamically changed. The
>    allocated elements count can be from 0 to the max entries. But the
>    memory footprint in bpftool only shows a fixed number.
> 
> - bpf metadata consumes more memory than bpf element
>    In some corner cases, the bpf metadata can consumes a lot more memory
>    than bpf element consumes. For example, it can happen when the element
>    size is quite small.
> 
> - some maps don't have key, value or max_entries
>    For example the key_size and value_size of ringbuf is 0, so its
>    memlock is always 0.
> 
> We need a way to show the bpf memory usage especially there will be more
> and more bpf programs running on the production environment and thus the
> bpf memory usage is not trivial.
> 
> This patchset introduces a new map ops ->map_mem_usage to calculate the
> memory usage. Note that we don't intend to make the memory usage 100%
> accurate, while our goal is to make sure there is only a small difference
> between what bpftool reports and the real memory. That small difference
> can be ignored compared to the total usage.  That is enough to monitor
> the bpf memory usage. For example, the user can rely on this value to
> monitor the trend of bpf memory usage, compare the difference in bpf
> memory usage between different bpf program versions, figure out which
> maps consume large memory, and etc.

Now that there is the cgroup.memory=nobpf, this is now rebuilding the memory
accounting as a band aid that you would otherwise get for free via memcg.. :/
Can't you instead move the selectable memcg forward? Tejun and others have
brought up the resource domain concept, have you looked into it?

Thanks,
Daniel
