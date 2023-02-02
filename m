Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A0687DFC
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBBMzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 07:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjBBMzv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 07:55:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CC77A5C0;
        Thu,  2 Feb 2023 04:55:49 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxV+nTsttj1XMMAA--.20072S3;
        Thu, 02 Feb 2023 20:55:47 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxaL3TsttjZoInAA--.11456S3;
        Thu, 02 Feb 2023 20:55:47 +0800 (CST)
Subject: Re: [PATCH bpf-next 0/4] bpf: Replace BPF_ALU and BPF_JMP with
 BPF_ALU32 and BPF_JMP64
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
 <CAADnVQKWWf6==B=X+2zazt1dmfK6ENAaGWWS_2QkX4bDJrJJNg@mail.gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ba068c07-1337-3efc-ce4d-045d77dffd50@loongson.cn>
Date:   Thu, 2 Feb 2023 20:55:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKWWf6==B=X+2zazt1dmfK6ENAaGWWS_2QkX4bDJrJJNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxaL3TsttjZoInAA--.11456S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtw47uFWfAw13uw13Ww1Utrb_yoW3AFg_WF
        W09r1xGr1DJ3WUC3W2g3WrXr1DCa4UX3y8A3W2gr1IqFW2yFZ8J3yDKrn29rWrGF93CF9a
        qr15ZryavF4xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        c7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
        0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcyxRUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/02/2023 07:26 PM, Alexei Starovoitov wrote:
> On Wed, Feb 1, 2023 at 4:36 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> The intention of this patchset is to make the code more readable,
>> no functional changes, based on bpf-next.
>>
>> If this patchset makes no sense, please ignore it and sorry for that.
> ...
>>  157 files changed, 4299 insertions(+), 4295 deletions(-)
>
> Are you trying to get to the top of lwn's "most active developers by
> lines changed" ?

Oh, no, no intention of doing so.

> I'm sure you knew that it's most likely going to be rejected,
> yet you still sent it. why?

Sorry for the trouble.
Maybe just send patch #1 and #4 as RFC is a proper way.

> Your developer's reputation suffers.
> Think quality and not quantity.
>

Anyway, thank you for your reply.

