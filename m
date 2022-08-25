Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0410B5A14CC
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 16:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiHYOs0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242101AbiHYOsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 10:48:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5CB2860
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 07:48:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u5so17127163wrt.11
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=U/GqjYthhXwTB8d2nbTjdjFeNP6i46d9zfH+EicQPvI=;
        b=eF4/mm/uB3JTA2iq0IVbizRpuzK7DuzbrTrjAzs9IKBHwQymK0eHz/Is2D+RY6pjiB
         z9rSwPibELLIQpmL6lE6bIFe1NXw0Eu0GXqJRwocCGAFz8qfPXFwQGlMjd9v9x0PGZZb
         P5CN1ech5mMNBNgZvWiHG+wNzRMMWuidaa+oMIVCeZQypWR/chn14EJCcOHCbNEX7muG
         WczEobh60Z12NepwCC5zizgN5hjOV/oROQ1J/mkXwXVu9UpxnJpGc1OHYf5LZdOy4PB3
         6U0EEAtChQAStuR1/4642udiTV3tDGWYN8rTpb8kqPA2CNl/Zha4WJ6ZafRdetzJmS3X
         PBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=U/GqjYthhXwTB8d2nbTjdjFeNP6i46d9zfH+EicQPvI=;
        b=e9qnyZfWNS1sQWoc4HYXYtJW3vqQ/DvdYdZhb3hO4MC/5n0Ni/SLbIwx2roNy6GY3f
         ENLAI49Gvjb42SoBNKKvw0adM2WlT2xr1rW3ax+9NsCwPVXqzw9jbdzbzdFLzLPH7Jti
         jCXOhCzBEYc4ItlJYnuB0XoP2zROwk5UNukUsluiYc7EYMPqP8ivLoBob9+M8DdNJ1ln
         G1Hj1BgpTHQ2fEDy7+xLqfh1FFekHfjNXdYLToMEuKJ3w1fWCzABoIMLVqThWkBWiyM/
         pcq2il/ll2xCPEQxTL6Y23wG91KAayjwpKKol890LmBuj4BbPQu+8i/myESYuvznyhre
         1fdw==
X-Gm-Message-State: ACgBeo2cg7dzyGNhutMLf1D7BL86ngWoBoD2MTGzs0iYGFZ70yW3wcJK
        Izn4x6mY7AodSJ9QtDie9Jcz6A==
X-Google-Smtp-Source: AA6agR5JOgx2M/L9Gb/I+71ARDJk53g6gF/fFXvk5I/ZVIq8KgWVHdZil7Ch17kYew7LJndc5fU/wA==
X-Received: by 2002:a5d:6245:0:b0:225:3e24:e5b1 with SMTP id m5-20020a5d6245000000b002253e24e5b1mr2597594wrv.698.1661438901749;
        Thu, 25 Aug 2022 07:48:21 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b003a6125562e1sm5723694wmq.46.2022.08.25.07.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:48:21 -0700 (PDT)
Message-ID: <40a62a75-1548-88ff-e536-dcbf3350db01@isovalent.com>
Date:   Thu, 25 Aug 2022 15:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next v2] bpf: Fix a few typos in BPF helpers
 documentation
Content-Language: en-GB
To:     Jakub Wilk <jwilk@jwilk.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-man@vger.kernel.org
References: <20220825110216.53698-1-quentin@isovalent.com>
 <20220825142256.of3glbnwi77kgkzo@jwilk.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220825142256.of3glbnwi77kgkzo@jwilk.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/08/2022 15:22, Jakub Wilk wrote:
> * Quentin Monnet <quentin@isovalent.com>, 2022-08-25 12:02:
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -79,7 +79,7 @@ struct bpf_insn {
>> /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>> struct bpf_lpm_trie_key {
>>     __u32    prefixlen;    /* up to 32 for AF_INET, 128 for AF_INET6 */
>> -    __u8    data[0];    /* Arbitrary size */
>> +    __u8    data[];    /* Arbitrary size */
>> };
> 
> This hunk picks the change from 94dfc73e7cf4 ("treewide: uapi: Replace
> zero-length arrays with flexible-array members").
> 
> A bit weird to see it in a spelling-fix patch though. Wouldn't it be
> better to put it in a separate one?
> 

This has happened several times in the past, and the change is small
enough I thought it wouldn't matter much. I can send another version if
it's more convenient, though.

Quentin
