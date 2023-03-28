Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A96CB946
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjC1IXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1IXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 04:23:32 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF744A2;
        Tue, 28 Mar 2023 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=v68PtqY53cBqGu08f6wYN/a5E1D7BK1+ERrIL89e9Js=; b=GbzzZs6uNlXrSFOYAe5eE8kg4X
        PT3e/Xrq11Ey3IcSRBPJF1Gr+tuVeflaCKoReFgRrF3w3LyS8ig+UCcVGtOuz2O21ciwyFhuF0RVX
        p53vHw9evnXen+EgEdwXqMqXSf1gM3U43TmDLkxOVf9lX8adKyF0AC4hDmqsKDm/YwaM6dHs4147+
        OnOmpKb98HaowZkXQyj4XMxb8opZLCuQfVelgfALrq8k+tQapRW/EjenboHNmhLy21NHQkfbXbs/v
        hMCbw2ORmnzAtwzyfwJlKGVjS7jiw9JKo5VdBWmxAQM48E2Tt6do/z2OZZUMp54Gsms7SM4YirbH0
        7MUhS+mg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph4bz-000DfI-25; Tue, 28 Mar 2023 10:23:23 +0200
Received: from [219.59.88.22] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ph4by-000EJ3-3o; Tue, 28 Mar 2023 10:23:22 +0200
Subject: Re: [PATCH bpf-next] kallsyms: move module-related functions under
 correct configs
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
References: <20230327161251.1129511-1-vmalik@redhat.com>
 <ZCHWtptOwPPtUe+u@bombadil.infradead.org>
 <c076e249-705a-e1bb-c657-f80cd4f2145b@redhat.com>
 <ZCHuU4Wui7Dwmdm2@bombadil.infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bfaefad6-692f-e687-ad55-05a43aa54883@iogearbox.net>
Date:   Tue, 28 Mar 2023 10:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ZCHuU4Wui7Dwmdm2@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26857/Tue Mar 28 09:23:39 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/27/23 9:28 PM, Luis Chamberlain wrote:
> On Mon, Mar 27, 2023 at 08:20:56PM +0200, Viktor Malik wrote:
>> On 3/27/23 19:47, Luis Chamberlain wrote:
>>> On Mon, Mar 27, 2023 at 06:12:51PM +0200, Viktor Malik wrote:
>>>> Functions for searching module kallsyms should have non-empty
>>>> definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
>>>> only CONFIG_MODULES check was used for many of these, which may have
>>>> caused complilation errors on some configs.
>>>>
>>>> This patch moves all relevant functions under the correct configs.
>>>>
>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Link: https://lore.kernel.org/oe-kbuild-all/202303181535.RFDCnz3E-lkp@intel.com/
>>>
>>> Thanks Viktor!  Does this fix something from an existing commit? If so
>>> which one?  The commit log should mention it.
>>
>> Ah, right, I forgot about that. The commit log is missing:
>>
>> Fixes: bd5314f8dd2d ("kallsyms, bpf: Move find_kallsyms_symbol_value out of internal header")
>>
>> I can post v2 but I'm also fine with maintainers applying the tag.
> 
> That patch went through the bpf tree so its fix can go throug that tree.
> So up to Daniel if he wants a new patch.

Fixing up is fine with me. Viktor, which config combinations did you test for this
patch and under which architectures?

I suspect kbuild bot might still complain. For example, your patch moves
dereference_module_function_descriptor() stub definition under !CONFIG_MODULES ||
!CONFIG_KALLSYMS. Looking at ppc's dereference_module_function_descriptor()
implementation (!CONFIG_PPC64_ELF_ABI_V2 case), it's build under CONFIG_MODULES,
so you'll have two different implementations of the functions, the generic one
then w/o __weak attribute.

Also small nit, please fix the patch up wrt indentation to align with kernel coding
style.

Thanks,
Daniel
