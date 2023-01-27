Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA067E33F
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 12:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjA0L2n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 06:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjA0L22 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 06:28:28 -0500
Received: from smtpout4.r2.mail-out.ovh.net (smtpout4.r2.mail-out.ovh.net [54.36.141.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03C3A85C
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 03:27:11 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.109.143.26])
        by mo511.mail-out.ovh.net (Postfix) with ESMTPS id EAE1C26724;
        Fri, 27 Jan 2023 11:17:38 +0000 (UTC)
Received: from localhost (37.65.8.229) by DAG10EX1.indiv4.local (172.16.2.91)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.17; Fri, 27 Jan
 2023 12:17:38 +0100
Date:   Fri, 27 Jan 2023 12:17:37 +0100
From:   Quentin Deslandes <qde@naccy.de>
To:     Chethan Suresh <chethan.suresh@sony.com>
CC:     <quentin@isovalent.com>, <bpf@vger.kernel.org>,
        Kenta Tada <Kenta.Tada@sony.com>
Subject: Re: [PATCH bpf-next] bpftool: disable bpfilter kernel config checks
Message-ID: <20230127111737.uxvmfiauusr3jmw2@dev-bpfilter1>
References: <20230125025516.5603-1-chethan.suresh@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125025516.5603-1-chethan.suresh@sony.com>
X-Originating-IP: [37.65.8.229]
X-ClientProxiedBy: CAS11.indiv4.local (172.16.1.11) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 12885642959858232866
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujghisehttdertddttddvnecuhfhrohhmpefsuhgvnhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrhhnpeejhfeuffdukeefkeejtddvjedvfeehteefheefhfduveejgeekheelhfffgeetfeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdeihedrkedrvddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptghhvghthhgrnhdrshhurhgvshhhsehsohhnhidrtghomhdpqhhuvghnthhinhesihhsohhvrghlvghnthdrtghomhdpsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpmfgvnhhtrgdrvfgruggrsehsohhnhidrtghomhdpoffvtefjohhsthepmhhoheduuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 08:25:16AM +0530, Chethan Suresh wrote:
> We've experienced similar issues about bpfilter like below:
> https://github.com/moby/moby/issues/43755
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
> -- 
> 2.17.1
> 

While I don't think this check is effectively needed in bpftool
regarding bpfilter's current state, I don't see how it's related to the
issues you're linking.

The GitHub issue you're linking is due to CONFIG_BPFILTER being enabled
on a kernel, with no related to bpftool.

Regards,
Quentin
