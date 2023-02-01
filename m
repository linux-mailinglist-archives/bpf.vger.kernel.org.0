Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73663686BEB
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBAQiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjBAQiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:38:12 -0500
Received: from 4.mo619.mail-out.ovh.net (4.mo619.mail-out.ovh.net [46.105.36.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33B2D54
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:38:05 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.109.156.245])
        by mo619.mail-out.ovh.net (Postfix) with ESMTPS id C3A6A22FF3;
        Wed,  1 Feb 2023 15:21:50 +0000 (UTC)
Received: from [172.17.29.109] (163.114.131.192) by DAG10EX1.indiv4.local
 (172.16.2.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.17; Wed, 1 Feb
 2023 16:21:49 +0100
Message-ID: <3a2f6e0f-5f2c-f0bd-710c-ec379e8e4105@naccy.de>
Date:   Wed, 1 Feb 2023 16:21:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Firefox/111.0 NotABird/111.0a1
Subject: Re: [PATCH bpf-next] bpftool: disable bpfilter kernel config checks
Content-Language: en-US
To:     Chethan Suresh <chethan.suresh@sony.com>, <quentin@isovalent.com>,
        <bpf@vger.kernel.org>
CC:     Kenta Tada <Kenta.Tada@sony.com>, <qde@naccy.de>
References: <20230125025516.5603-1-chethan.suresh@sony.com>
From:   Quentin Deslandes <qde@naccy.de>
In-Reply-To: <20230125025516.5603-1-chethan.suresh@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [163.114.131.192]
X-ClientProxiedBy: CAS3.indiv4.local (172.16.1.3) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 9479514266398354978
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepiedtgfdvieevgeeuffffgedvueeludefgeeftedufefgieekudetueekhefgfeffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdduieefrdduudegrddufedurdduledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoqhguvgesnhgrtggthidruggvqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegthhgvthhhrghnrdhsuhhrvghshhesshhonhihrdgtohhmpdhquhgvnhhtihhnsehishhovhgrlhgvnhhtrdgtohhmpdgsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfmvghnthgrrdfvrggurgesshhonhihrdgtohhmpdfovfetjfhoshhtpehmoheiudelpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/01/2023 03:55, Chethan Suresh wrote:
> We've experienced similar issues about bpfilter like below:
> https://github.com/moby/moby/issues/43755

I've been looking into this issue a bit more, it seems the author has
CONFIG_BPFILTER enabled, which shouldn't be. I've answered to the thread
to clarify the situation.

Regarding why CONFIG_BPFILTER was enabled, it seems linuxkit [1]
project's default configurations for multiple kernel verisons had it
enabled, for some reason. This was fixed [2] a few month ago for
*some* of the configurations, I've published a PR [3] for the remaining
configuration.
It's been approved but not merged yet. It's unclear why those
configurations had CONFIG_BPFILTER enabled in the first place, but it's
definitely a mistake.

[1]: https://github.com/linuxkit/linuxkit
[2]: https://github.com/linuxkit/linuxkit/pull/3701
[3]: https://github.com/linuxkit/linuxkit/pull/3904

> https://lore.kernel.org/bpf/CAADnVQJ5MxGkq=ng214aYoH-NmZ1gjoS=ZTY1eU-Fag4RwZjdg@mail.gmail.com/
> 
> Considering the current development status of bpfilter,
> disable bpfilter kernel config checks in bpftool feature.
> For production system, we should disable both
> CONFIG_BPFILTER and CONFIG_BPFILTER_UMH for now.
> Or can be enabled as some tools depend on bpfilter.
> 
> Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  tools/bpf/bpftool/feature.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 36cf0f1517c9..c6087bbc6613 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -426,10 +426,6 @@ static void probe_kernel_image_config(const char *define_prefix)
>  		{ "CONFIG_BPF_STREAM_PARSER", },
>  		/* xt_bpf module for passing BPF programs to netfilter  */
>  		{ "CONFIG_NETFILTER_XT_MATCH_BPF", },
> -		/* bpfilter back-end for iptables */
> -		{ "CONFIG_BPFILTER", },
> -		/* bpftilter module with "user mode helper" */
> -		{ "CONFIG_BPFILTER_UMH", },
>  
>  		/* test_bpf module for BPF tests */
>  		{ "CONFIG_TEST_BPF", },

Regards,
Quentin
