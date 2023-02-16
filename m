Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA0698D64
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 07:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBPGwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 01:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPGwY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 01:52:24 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC99A9F
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 22:52:22 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxztqk0u1jjzkBAA--.3082S3;
        Thu, 16 Feb 2023 14:52:21 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxg+Wf0u1jclw0AA--.63244S3;
        Thu, 16 Feb 2023 14:52:16 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: BPF: Use 4 instructions for function
 address in JIT
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20230214152633.2265699-1-hengqi.chen@gmail.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9b999261-9c6e-05a9-3213-b9f6dd2eaa07@loongson.cn>
Date:   Thu, 16 Feb 2023 14:52:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230214152633.2265699-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxg+Wf0u1jclw0AA--.63244S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7GF1fGw4DArWkXFy7ur17Jrb_yoWfZrcE9a
        9ay39ruw15Wr4fA3W5KF45XFyv93yUGF1UKrnYqFsrt3sxKaykAayqkr9Fv348WF97JF4r
        JFZrWw4aywnrAjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        x7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZUUUUU=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/14/2023 11:26 PM, Hengqi Chen wrote:
> This patch fixes the following issue of function calls in JIT, like:
>
>   [   29.346981] multi-func JIT bug 105 != 103
>
> The issus can be reproduced by running the "inline simple bpf_loop call"
> verifier test.
>
> This is because we are emiting 2-4 instructions for 64-bit immediate moves.
> During the first pass of JIT, the placeholder address is zero, emiting two
> instructions for it. In the extra pass, the function address is in XKVRANGE,
> emiting four instructions for it. This change the instruction index in
> JIT context. Let's always use 4 instructions for function address in JIT.
> So that the instruction sequences don't change between the first pass and
> the extra pass for function calls.
>
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

