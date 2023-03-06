Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C007F6AD19D
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 23:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCFWdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 17:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCFWdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 17:33:54 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A830D7;
        Mon,  6 Mar 2023 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=2y0NjxrS3Q5GoOlQaWYkv98PUAGadMtF3mRneW7e7Y0=; b=RUTrNJjHjpQbA8gXkilZ5f8RW0
        5xGQI87mWD6x8uA1kT7h/1FUcSOqQwHYW08hFROzOjwsTaKkir9kSRd3N7pB6HJp9F1LCjaPrUAyv
        KfmvyXVtfdduBsq0JjZaaGsBYmztGWLFvWRfZ8yBy/YluMfuzPNnVOTUf4N3VjyI5XH2hYt1RrNNo
        +UcP+B+CzHHXrOhxbCFggJl/Db3Jg1tjp1EqU5puhPItYRA8OQ0SbdrUFNLHMMJCgdE7fhquWd1W9
        50J0/gCn8Ls//t0NhXQpXNbBdXBVLzMCpoHcIORWYpafKRPZRAAP8F4C8tjeaWTNExJQvknnKM0aM
        nhfgIiCQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pZJOw-000CQj-Nd; Mon, 06 Mar 2023 23:33:50 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pZJOw-000OXZ-76; Mon, 06 Mar 2023 23:33:50 +0100
Subject: Re: [PATCH 0/2] Hyperlink fixes for BPF QA documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20230228074523.11493-1-bagasdotme@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fd32d4eb-451e-23cd-d99b-294e99f8cc66@iogearbox.net>
Date:   Mon, 6 Mar 2023 23:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230228074523.11493-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26833/Mon Mar  6 09:22:59 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/28/23 8:45 AM, Bagas Sanjaya wrote:
> When the broken link fix for Documentation/bpf/bpf_devel_QA.rst was
> applied, Daniel Borkmann asked me to also fix some other links in the
> documentation [1]. So here is the series.
> 
> The fixes in the shortlog below should be self-explanatory.
> 
> [1]: https://lore.kernel.org/linux-doc/7cd545a2-4a5c-1961-1cf7-cd0f24e41df8@iogearbox.net/
> 
> Bagas Sanjaya (2):
>    Documentation: bpf: Do not link to docs.kernel.org for kselftest link
>    Documentation: bpf: Link to submitting-patches.rst for general patch
>      submission info

The series got applied to bpf, thanks!
