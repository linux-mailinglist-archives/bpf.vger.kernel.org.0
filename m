Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D33697C5E
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 13:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjBOMxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 07:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjBOMxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 07:53:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E596A77
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 04:53:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a2so19058723wrd.6
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mRxQgKVCsjhHvOT6DoJNwBqFt5xtR55kXxhgb/HZYA=;
        b=KQo3JJqswsEip9GbvTETyruVoe4RsYIInUc8PEK1lGz+jr9SzWAcKQ4nPn6Kv6fswa
         yXk2pm3KOqm1EngkBCyx+cr2/KFdemKUIYAfTiyZAy4EzmJri+bEFZTJKCrPIbyMcAkv
         /Up0nB8rjcCJq+J4mWDMw5XKgV3vb2eSbfX/t/XlRWhN2h1fLYRMLGZI34uY2+U+QMcf
         DiQpAXPyk7p3OJXNlpuOdFKcUKD3ZQ0KRQqGZVuh4aCmxnzRckmnTGpLPH9IUy0hs8g+
         uh6IXh4E4ZUhUGm27MRidKtUQ6w9W97POZZCh/3xtAddNF9XSCjLNAMiOCvuY9wC+sVK
         1rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mRxQgKVCsjhHvOT6DoJNwBqFt5xtR55kXxhgb/HZYA=;
        b=OT+ni0IkYovptyt8KSPWMDJK90493XxetkZu87kJzi/HYRMe0w5+yiBtYGAdZujTLU
         Z0fdrKruxIRc0kJZMqWdQw2emMsyieZ/EVFzwd1pQWdczDqMHzvcDIZgU+dhGscUywMi
         tAdsZ51CoqxrTIALK3CrzSy0RtXH6NLHw5k/7vnE0O0H/PSzuRJdGQmbK7X58amhWwyv
         /bjTL+3erOANeNHzK/TehyIyXVLCXX2NTuyCrDj50VADLSzHANC+8EE2hc8LAQRS+FBs
         RQ8aqylJ5eROJifAmxBG6gn36oHsz4hgYEQAkA5+QYU/DaptTvAYUzMXTHUpaAn8eXG6
         LUuw==
X-Gm-Message-State: AO0yUKVFXIWKMmK65Qm8MHeooyi+e3K/zEB4lIBcAlPRDecHms7pcIcB
        fJpE+SEaV5DZR3miI/FDiuHkhsXpf5uZBA42YdUeCQ==
X-Google-Smtp-Source: AK7set8vB7P4tSvgmmdinEwXrLcBbaUmHpgOjMOUTv+Y/c8MHWbGJmA7PfStZ4CnlcviCBGt74Lp8Q==
X-Received: by 2002:adf:f54d:0:b0:2c1:28dc:1561 with SMTP id j13-20020adff54d000000b002c128dc1561mr1640932wrp.44.1676465610854;
        Wed, 15 Feb 2023 04:53:30 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:4f7:4f58:bf21:c4ac? ([2a02:8011:e80c:0:4f7:4f58:bf21:c4ac])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe947000000b002c559626a50sm6985776wrn.13.2023.02.15.04.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 04:53:30 -0800 (PST)
Message-ID: <f0cf65fd-05dc-2fba-4798-4bc715fc3c0b@isovalent.com>
Date:   Wed, 15 Feb 2023 12:53:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH bpf-next v3 3/8] bpftool: Use
 bpf_{btf,link,map,prog}_get_info_by_fd()
Content-Language: en-GB
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
 <20230214231221.249277-4-iii@linux.ibm.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230214231221.249277-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-02-15 00:12 UTC+0100 ~ Ilya Leoshkevich <iii@linux.ibm.com>
> Use the new type-safe wrappers around bpf_obj_get_info_by_fd().
> 
> Split the bpf_obj_get_info_by_fd() call in build_btf_type_table() in
> two, since knowing the type helps with the Memory Sanitizer.
> 
> Improve map_parse_fd_and_info() type safety by using
> struct bpf_map_info * instead of void * for info.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

This version looks good to me, thank you

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

