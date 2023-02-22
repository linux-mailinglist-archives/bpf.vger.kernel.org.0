Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04069F27C
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjBVKIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 05:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjBVKIG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 05:08:06 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7A5F525B;
        Wed, 22 Feb 2023 02:08:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxttiB6fVjT4sDAA--.6824S3;
        Wed, 22 Feb 2023 18:08:01 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtOV+6fVjeas4AA--.4362S3;
        Wed, 22 Feb 2023 18:07:58 +0800 (CST)
Subject: Re: [PATCH] docs/bpf: Fix invalid link of "Documentation/bpf/btf.rst"
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <1677035401-3628-1-git-send-email-yangtiezhu@loongson.cn>
 <Y/XYM4D1SW/zyhNJ@debian.me>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <566b4d43-f952-8038-ec2f-988be014274f@loongson.cn>
Date:   Wed, 22 Feb 2023 18:06:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <Y/XYM4D1SW/zyhNJ@debian.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxtOV+6fVjeas4AA--.4362S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KFW7Ww15tF43Gr1fWw45Jrb_yoW8Aw13pa
        18JF4a9rsrKryrW3ykGa1UZF4SvayrX3W7C34DJw18Zrn8ZF95Zr1S9r45WanxtFykCFW7
        A3ZakF909r17Z37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1A9N7UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/22/2023 04:54 PM, Bagas Sanjaya wrote:
> On Wed, Feb 22, 2023 at 11:10:01AM +0800, Tiezhu Yang wrote:
>> "Documentation/bpf/btf.rst" is linked to the following invalid web page:
>>
>> https://www.kernel.org/doc/html/latest/bpf/btf.rst
>>
>> The correct link should be:
>>
>> https://www.kernel.org/doc/html/latest/bpf/btf.html
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Hi,
>
> I have already submitted a different fix to the same problem at [1] (v2
> at [2]). Please take a look at there.

Oh, I am sorry, I did not notice these patches, I found this issue when
I read the bpf doc.

>
> [1]: https://lore.kernel.org/linux-doc/20230219030956.22662-1-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/linux-doc/20230222083530.26136-1-bagasdotme@gmail.com/
>
>> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
>> index 03d4993..f54c328 100644
>> --- a/Documentation/bpf/bpf_devel_QA.rst
>> +++ b/Documentation/bpf/bpf_devel_QA.rst
>> @@ -690,6 +690,7 @@ when:
>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
>>  .. _Documentation/dev-tools/kselftest.rst:
>>     https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
>> -.. _Documentation/bpf/btf.rst: btf.rst
>> +.. _Documentation/bpf/btf.rst:
>> +   https://www.kernel.org/doc/html/latest/bpf/btf.html
>>
>>  Happy BPF hacking!
>
> For consistency with my fix above, can you please convert these in-tree links
> from using external link to simply write the doc path instead?
>
> Thanks.
>

Please ignore my patch, you can go on to modify your changes.
Please let me know if there is anything I need to do.

Thanks,
Tiezhu

