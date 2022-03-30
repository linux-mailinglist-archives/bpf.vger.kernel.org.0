Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1599E4EC85B
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiC3Pih (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiC3Pig (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 11:38:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142532DA8F
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 08:36:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx5so20995052pjb.3
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=JaDfPK2UwwZlCNV2rZx7DWcuxYe72fuZD75U79FZSDc=;
        b=fPchyJsFzffGsmLtPigudxLIJKQx+s+s+wz4Uwj6oTginuA15gBdSLhRXj63FBxaVG
         SnxLZB06MiE1+DqjadwWGVXzhlOF9bAU2c8LPzXq3dz4W4ofeCU69h8H04sT9M87D0wl
         eE0wWyGE406uREk3wZXdspJ/kR2qplWc33s7Bee19eZO4RgOzYgRGxbslfEnaWrllHSQ
         hf0oXQN9Hh/gHNQlH7t+6l/Qv+CfWLtvw7LcWky/nunPCKmQkq+tyG3GlJfABAvMXuaw
         Ks05JJEyO38Js8sLZtTFMSKj82XGk5O1mMVxc0X49LmSHxpNyjlmOkVO3DrQiI/7Io76
         7hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=JaDfPK2UwwZlCNV2rZx7DWcuxYe72fuZD75U79FZSDc=;
        b=ZlhpTMiAbzuSCHxRXi2WZZUKp9dDqwJdccNLrGXABKa7BLQGBuD9zqzZ6yshIA/DkO
         TlEDNjRkWT6dtMciqxds9/GWMLEvjPEmxbqW2X5cEo3VdJxxJw+w3ogxADMoYt0/uUfe
         2EEfoOr652fOCetcYWwPHyAEXs3IU4CBYZePFTneqsKYO6n1xEuHEt6FCisjD+Y/weIy
         bwQrvPWhikjI6dTgx3F0/XCxyLLMVWBqLK/IgP4SoPdXgrBRXyhGwK8SGPewjGdStjUu
         NN6uUe+f02mmcY1+y0EDF2zf8x2FE8ELLeUt8MQze34eSqbDAiQ8yDTdllEaRq5tYAjo
         LGMA==
X-Gm-Message-State: AOAM531wyshOX8ZO6ilF+1fEOo8Vvi36xt+Gs07GkEyQpYBGqN2MW00n
        uohsLV3kk3BwK3ChdRpErAk=
X-Google-Smtp-Source: ABdhPJzBbjaEWBAXdI3MB5uOMqwX3W0YfdJa6akwP6lqkY7WmRhGlgmYHynOZEo6nULQl50Tznzv/Q==
X-Received: by 2002:a17:902:ea0d:b0:156:4c14:87dd with SMTP id s13-20020a170902ea0d00b001564c1487ddmr1112126plg.6.1648654610470;
        Wed, 30 Mar 2022 08:36:50 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id c21-20020a637255000000b003822e80f132sm19490845pgn.12.2022.03.30.08.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 08:36:49 -0700 (PDT)
Message-ID: <605dc1f0-2c66-25f0-ef76-a3c052fcc2d8@gmail.com>
Date:   Wed, 30 Mar 2022 23:36:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next 1/7] libbpf: add BPF-side of USDT support
Content-Language: en-US
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
References: <20220325052941.3526715-1-andrii@kernel.org>
 <20220325052941.3526715-2-andrii@kernel.org>
 <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com>
In-Reply-To: <176471e1-1221-8eb3-300e-986e3a6eaef8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/3/30 11:10 AM, Hengqi Chen wrote:
> On 2022/3/25 1:29 PM, Andrii Nakryiko wrote:
>> Add BPF-side implementation of libbpf-provided USDT support. This
>> consists of single header library, usdt.bpf.h, which is meant to be used
>> from user's BPF-side source code. This header is added to the list of
>> installed libbpf header, along bpf_helpers.h and others.
>>
>> BPF-side implementation consists of two BPF maps:
>>   - spec map, which contains "a USDT spec" which encodes information
>>     necessary to be able to fetch USDT arguments and other information
>>     (argument count, user-provided cookie value, etc) at runtime;
>>   - IP-to-spec-ID map, which is only used on kernels that don't support
>>     BPF cookie feature. It allows to lookup spec ID based on the place
>>     in user application that triggers USDT program.
>>
>> These maps have default sizes, 256 and 1024, which are chosen
>> conservatively to not waste a lot of space, but handling a lot of common
>> cases. But there could be cases when user application needs to either
>> trace a lot of different USDTs, or USDTs are heavily inlined and their
>> arguments are located in a lot of differing locations. For such cases it
>> might be necessary to size those maps up, which libbpf allows to do by
>> overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.

>> +
>> +__weak struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
>> +	__type(key, int);
>> +	__type(value, struct __bpf_usdt_spec);
>> +} __bpf_usdt_specs SEC(".maps");
>> +
>> +__weak struct {
>> +	__uint(type, BPF_MAP_TYPE_HASH);
>> +	__uint(max_entries, BPF_USDT_MAX_IP_CNT);
>> +	__type(key, long);
>> +	__type(value, struct __bpf_usdt_spec);
> 
> type should be int.
> 
>> +} __bpf_usdt_specs_ip_to_id SEC(".maps");

These weak symbols make BPF object open failed:

libbpf: No offset found in symbol table for VAR __bpf_usdt_specs
libbpf: Error finalizing .BTF: -2.

    bpf_object_open
        bpf_object__finalize_btf
            btf_finalize_data
                btf_fixup_datasec
                    find_elf_var_offset

This is because during BTF fixup, we only allow GLOBAL VAR.

Applying the following diff can workaround the issue:

+               unsigned char bind = ELF64_ST_BIND(sym->st_info);
 
-               if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL ||
+               if ((bind != STB_GLOBAL && bind != STB_WEAK) ||


>> +#endif /* __USDT_BPF_H__ */
