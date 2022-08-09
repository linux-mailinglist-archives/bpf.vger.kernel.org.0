Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5C58D8C7
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiHIMfr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 08:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiHIMfn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 08:35:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB9EEB
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 05:35:42 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxzyOXVPJibxwLAA--.5691S3;
        Tue, 09 Aug 2022 20:35:35 +0800 (CST)
Subject: Re: [RFC PATCH 3/5] LoongArch: Add BPF JIT support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
 <1660013580-19053-4-git-send-email-yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <7ce74276-9cd9-8667-5e82-6b49f6c7b62b@loongson.cn>
Date:   Tue, 9 Aug 2022 20:35:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1660013580-19053-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxzyOXVPJibxwLAA--.5691S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZry7tr4rJw4DGFyxJw18Zrb_yoWfCwb_tr
        1kKrsF93Z7JayUArWrJr9rXF9rGFn3ZFyFga4DWr13Ar1Fkr1rXFs3Kry8ury8Ww43Cw1a
        9ayYgr43KayjvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUID73UUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Tiezhu

On 08/09/2022 10:52 AM, Tiezhu Yang wrote:
> +
> +static inline bool is_unsigned_imm(unsigned long val, unsigned int bit)
> +{
> +	return val >= 0 && val < (1UL << bit);
> +}
The "val >= 0" condition can be removed because val is of type
"unsigned long".

> +
> +static inline bool is_signed_imm(long val, unsigned int bit)
> +{
> +	return -(1L << (bit - 1)) <= val && val < (1L << (bit - 1));
> +}
is_{unsigned/signed}_imm() is the same as {signed/unsigned}_imm_check()
in module.c, maybe we can move this function to inst.h.

Thanks,
Youling
> +
> +#define is_signed_imm12(val) is_signed_imm(val, 12)
> +#define is_signed_imm16(val) is_signed_imm(val, 16)
> +#define is_signed_imm26(val) is_signed_imm(val, 26)
> +#define is_signed_imm32(val) is_signed_imm(val, 32)
> +#define is_signed_imm52(val) is_signed_imm(val, 52)
> +#define is_unsigned_imm12(val) is_unsigned_imm(val, 12)
> +

