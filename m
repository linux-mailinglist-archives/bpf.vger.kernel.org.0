Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F846CD8A2
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjC2Llf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjC2Lle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 07:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73D448A
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680090046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gxc02lB4ReHZJCVlVCYTPAsHaTYfjuyyUkDtNRC+vns=;
        b=IRhvEtlVkyJzVXNspjIjKbJQgjnUY8Ixo26jq22vBk7i/20da8LBHSPg7yi7vZa4gjfzbG
        jMdQJmBMwrpLNuj2ei5L2VxE5MwlxibzvmJwYbXeRe4qt1e603fOH6SspolpDBeSTG4Siz
        JlI9VG8iKKESAculfvGNkUmD93l4bnA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-eD3QjXDVNL2vB7zV26r35Q-1; Wed, 29 Mar 2023 07:40:45 -0400
X-MC-Unique: eD3QjXDVNL2vB7zV26r35Q-1
Received: by mail-ed1-f69.google.com with SMTP id x35-20020a50baa6000000b005021d1b1e9eso22120468ede.13
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 04:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680090044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxc02lB4ReHZJCVlVCYTPAsHaTYfjuyyUkDtNRC+vns=;
        b=sELA16TCrNZVoPIZdIpblQfNcu9GLwzG1+obH6U5zWq68/7PUF5rWBJx5MQjZZKO52
         Nbl3N5bQVKZp9U/6bDmWFcoYRAYahm29SQYQzdjMVLj4HgVZwcvNpyUNzT6cryM8RahJ
         lAkXpj5VucUcpl8r9SDBt8YR+z3aALnhg05B+7Akkp10EhIdysV4SGadZ+LDvxNYD0jA
         4eW64gJS8pd3fIJY0fM/cv4HljLA7slN9O8cdMR1Grzdnz0gBwW18dQV+esJDMlOSNPN
         7MpwBPxT++78X5x5yTMNEnwjKsQI7+EfDKASMdBTaYi57Y0tl7JC/pBSW4oSTh/1evrG
         w6Og==
X-Gm-Message-State: AAQBX9ez5Wj/aYTEXjVWgtwLo89bnzutMXKl0HXClEfKPUYpRYEpOJu1
        JbiEjzsVBLp/bgCLn0p/R+t5gAhy4kQ/hObc2Y5ZWHiyx7xxOWLRNKTDVuhq/w9V+z3/Zg9hGu4
        26i3cFmJlbis=
X-Received: by 2002:a17:906:5acf:b0:8b1:7684:dfab with SMTP id x15-20020a1709065acf00b008b17684dfabmr22972774ejs.38.1680090044124;
        Wed, 29 Mar 2023 04:40:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350aEz9DwwYv9nDpq3n9IzUtlPhBnia/H7+vRksj6SvClDW2OK44VDqv9cJnSNi01Cuk7b4qD+Q==
X-Received: by 2002:a17:906:5acf:b0:8b1:7684:dfab with SMTP id x15-20020a1709065acf00b008b17684dfabmr22972754ejs.38.1680090043759;
        Wed, 29 Mar 2023 04:40:43 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:7c:5b35:3b22:9bb9? ([2001:67c:1220:8b4:7c:5b35:3b22:9bb9])
        by smtp.gmail.com with ESMTPSA id qq24-20020a17090720d800b008df7d2e122dsm16303445ejb.45.2023.03.29.04.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:40:43 -0700 (PDT)
Message-ID: <9dec8409-6e69-4f14-dcd8-9f47e088ce17@redhat.com>
Date:   Wed, 29 Mar 2023 13:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next] kallsyms: move module-related functions under
 correct configs
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Luis Chamberlain <mcgrof@kernel.org>
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
 <bfaefad6-692f-e687-ad55-05a43aa54883@iogearbox.net>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <bfaefad6-692f-e687-ad55-05a43aa54883@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/28/23 10:23, Daniel Borkmann wrote:
> On 3/27/23 9:28 PM, Luis Chamberlain wrote:
>> On Mon, Mar 27, 2023 at 08:20:56PM +0200, Viktor Malik wrote:
>>> On 3/27/23 19:47, Luis Chamberlain wrote:
>>>> On Mon, Mar 27, 2023 at 06:12:51PM +0200, Viktor Malik wrote:
>>>>> Functions for searching module kallsyms should have non-empty
>>>>> definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
>>>>> only CONFIG_MODULES check was used for many of these, which may have
>>>>> caused complilation errors on some configs.
>>>>>
>>>>> This patch moves all relevant functions under the correct configs.
>>>>>
>>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Link: https://lore.kernel.org/oe-kbuild-all/202303181535.RFDCnz3E-lkp@intel.com/
>>>>
>>>> Thanks Viktor!  Does this fix something from an existing commit? If so
>>>> which one?  The commit log should mention it.
>>>
>>> Ah, right, I forgot about that. The commit log is missing:
>>>
>>> Fixes: bd5314f8dd2d ("kallsyms, bpf: Move find_kallsyms_symbol_value out of internal header")
>>>
>>> I can post v2 but I'm also fine with maintainers applying the tag.
>>
>> That patch went through the bpf tree so its fix can go throug that tree.
>> So up to Daniel if he wants a new patch.
> 
> Fixing up is fine with me. Viktor, which config combinations did you test for this
> patch and under which architectures?
> 
> I suspect kbuild bot might still complain. For example, your patch moves
> dereference_module_function_descriptor() stub definition under !CONFIG_MODULES ||
> !CONFIG_KALLSYMS. Looking at ppc's dereference_module_function_descriptor()
> implementation (!CONFIG_PPC64_ELF_ABI_V2 case), it's build under CONFIG_MODULES,
> so you'll have two different implementations of the functions, the generic one
> then w/o __weak attribute.

Right, I didn't notice this one, thanks. Looks like
dereference_module_function_descriptor will need to stay in the original
place (under CONFIG_MODULES only). I'll cross-compile for arches that
redefine this function (powerpc, ia64, parisc) with relevant config
combinations and submit v2. The rest of the functions don't have
arch-dependent implementations, so they should be fine.

> 
> Also small nit, please fix the patch up wrt indentation to align with kernel coding
> style.

Ok, will do.

Thanks,
Viktor

> 
> Thanks,
> Daniel
> 

