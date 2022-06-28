Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7135055EA8C
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiF1Q7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiF1Q5N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:57:13 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E31EAE0
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:56:51 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o6EW8-0007gm-Ez; Tue, 28 Jun 2022 18:56:48 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1o6EW8-0000vS-1e; Tue, 28 Jun 2022 18:56:48 +0200
Subject: Re: [PATCH bpf] bpf, docs: Better scale maintenance of BPF subsystem
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
 <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN>
 <CAADnVQLOS4kvmcp+aaX6gtDUCUfoL906K+Y4KUZOsYBDso_xMw@mail.gmail.com>
 <20220627133027.1e141f11@kernel.org>
 <CAADnVQKf8huK_bdGPQzOZwXJD7aqr-2a3jFPfhYrEz8BD115qw@mail.gmail.com>
 <ac8da400-f403-7817-414d-d3001c82dc4c@iogearbox.net>
 <20220628164643.2gdyifct4x2zbbsb@MacBook-Pro-3.local>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <50da58e3-e056-2d24-765b-818fed09e216@iogearbox.net>
Date:   Tue, 28 Jun 2022 18:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220628164643.2gdyifct4x2zbbsb@MacBook-Pro-3.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26587/Tue Jun 28 10:07:12 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/28/22 6:46 PM, Alexei Starovoitov wrote:
> On Tue, Jun 28, 2022 at 10:59:02AM +0200, Daniel Borkmann wrote:
>> On 6/27/22 10:38 PM, Alexei Starovoitov wrote:
>>> On Mon, Jun 27, 2022 at 1:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
[...]
>> +BPF [MISC]
>> +L:     bpf@vger.kernel.org
>> +S:     Odd Fixes
>> +K:     (?:\b|_)bpf(?:\b|_)
>> +
> 
> Good idea!
> 
>>   BROADCOM B44 10/100 ETHERNET DRIVER
>>   M:     Michael Chan <michael.chan@broadcom.com>
>>   L:     netdev@vger.kernel.org
>>
>> If there are no objections, I can fold this in..
> 
> sgtm

Ok, done now & pushed out.

Thanks,
Daniel
