Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09E95E9126
	for <lists+bpf@lfdr.de>; Sun, 25 Sep 2022 07:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiIYFnC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 01:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIYFnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 01:43:01 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ED7371AB
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 22:42:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7E83932002FB;
        Sun, 25 Sep 2022 01:42:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 25 Sep 2022 01:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664084574; x=
        1664170974; bh=gYryFmyVF7gCXfKNyj9KELei4TL2jsft5OoKQKaEgW4=; b=l
        J9GwGxrZ8ouTR1IZvV3X7qYo8BRn/UNopck6lyzHxSMivwp63hlvCjZk2S0n01iR
        PCZNUdpYcYaQtQxVrvi9KDt0e1qsAhcve8ZFDfdBwPTaE7iPLaFEiGxBHfTTSqQj
        epu2MiC6mFULC/ku1CKa+iOWk0gF0tDB6X+z51nVVhuZ/fxZqLExVxe7pege6/0v
        5As3RiNAsbpf1CQ9vZL4ExWxFW4CRuzcISL3DLU3LAB54mDyyPLyYHEft+1xqeYl
        wG3lycShp/PRbn4kMrvoiOkMCUJuY7PHee+wLS269AKxLkBZhMFptBDP9aeuD6Na
        nE4bxrpCIJbl8CUbbF1eQ==
X-ME-Sender: <xms:XOovY5evGGduE7JRA_FxWo_5G0txkPPT1K4VbiblP9pPs2Tdl2HuiA>
    <xme:XOovY3OJbixFBfTliQEKXDIr7ynM-9XOs6mAjpKUXYRImi7MgcARJKssf0aLnDfvT
    Fml8ZPPT8fS5PdE_TA>
X-ME-Received: <xmr:XOovYygw8qG4uKStAC4y9MyrpthOiPWpImRVPDJ9igOg_dV-dCJ7tqYTPbz6JhbiKOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefledgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghr
    thihnhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrth
    htvghrnhepvdevledtteevfeehleetteelvdehteegjefhvdefgfdukeejfeefffeigeeh
    veetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:XeovYy_dJeU7OWeytt0JggYCoIO3xaRsWjBxMI0SMLXcZgQLJkV-Ig>
    <xmx:XeovY1srb3slTHhjRWafrIeN9XfUXHaBuZ_D8Z-gbUX_VvoIUVsuJA>
    <xmx:XeovYxHUE9LYmZmJzqq4TFmitwpKnam5ZiLsizd71ug8Vp80_A6jGQ>
    <xmx:XuovYxEN-zSGfiEqonpiSIAYptrwENdNzoY6tk8Jxu5J9tA0XC03VQ>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Sep 2022 01:42:50 -0400 (EDT)
Message-ID: <0e1742f8-06ea-1c69-d245-e3202a751f42@lambda.lt>
Date:   Sun, 25 Sep 2022 07:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 bpf-next 5/6] bpf: Return value in kprobe get_func_ip
 only for entry address
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220922210320.1076658-1-jolsa@kernel.org>
 <20220922210320.1076658-6-jolsa@kernel.org>
From:   Martynas Pumputis <m@lambda.lt>
In-Reply-To: <20220922210320.1076658-6-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/22/22 23:03, Jiri Olsa wrote:
> Changing return value of kprobe's version of bpf_get_func_ip
> to return zero if the attach address is not on the function's
> entry point.
> 
> For kprobes attached in the middle of the function we can't easily
> get to the function address especially now with the CONFIG_X86_KERNEL_IBT
> support.
> 
> If user cares about current IP for kprobes attached within the
> function body, they can get it with PT_REGS_IP(ctx).
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Tested the patches with "pwru --filter-func='.*skb.*' 
--filter-dst-ip=1.1.1.1" from [1] - the symbol name resolution works, 
thanks!

Without your patches:

                SKB    CPU          PROCESS                     FUNC
0xffff8989c159b4e8      0           [curl]       0xffffffffbbb06164
0xffff8989c223f000      0           [curl]       0xffffffffbbb07534
0xffff8989c223f000      0           [curl]       0xffffffffbbb04934
0xffff8989c223f000      0           [curl]         skb_release_data
0xffff8989c223f000      0           [curl]             kfree_skbmem
0xffff8989c159b4e8      0           [curl]       0xffffffffbbb00db4
[..]

With patches:

                SKB    CPU          PROCESS                     FUNC
0xffffa4564159b4e8      0           [curl]   validate_xmit_skb_list
0xffffa4564159b4e8      0           [curl]       netif_skb_features
0xffffa4564159b4e8      0           [curl]     skb_network_protocol
0xffffa4564159b4e8      0           [curl]  skb_csum_hwoffload_help
0xffffa4564159b4e8      0           [curl]        skb_checksum_help
0xffffa4564159b4e8      0           [curl]      skb_ensure_writable
0xffffa4564159b4e8      0           [curl]             skb_to_sgvec
[..]

[1]: https://github.com/cilium/pwru/tree/test-ibt-kernel-fix

Acked-by: Martynas Pumputis <m@lambda.lt>

> ---
>   kernel/trace/bpf_trace.c                             | 5 ++++-
>   tools/testing/selftests/bpf/progs/get_func_ip_test.c | 4 ++--
>   2 files changed, 6 insertions(+), 3 deletions(-)

[..]
