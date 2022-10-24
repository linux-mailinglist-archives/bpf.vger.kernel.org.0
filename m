Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923F2609FD3
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJXLKR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiJXLKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 07:10:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08781C91C
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 04:09:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bv10so15612627wrb.4
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 04:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ug3G0ZAO4+3pWW30j6Vblvfr5NEU7yXPNBLL5b+b58=;
        b=NhPY6eSBwV8qU02S5B8kKWuvnq+Zjus3wjKrVj1/D+6UAHrgqm03dV/xDv5I7jOapN
         1zHrp8yoL7I0CH9UXF6JRXWQKF76eM3Mqu1Z5RTZB0+OaE4liPHtGX8A18ckimtCdSJ7
         DtQUfCqz5ulgCdKPtZ9VUzemOTMfhph5BIaQYTWEhAQiASLhbiWW/yNVQ40DHdSEY5Wq
         FoCfZ1PNscMGsCj40IuWL9X7HBoCkmafcCbbFhIKHhhGFLiu0cxiUxXdIag5atOihNk+
         zjOXMWRtM7xAI8MeJmUPvaeOTodAH9z9QjHNayIzCD7O55d+2t9yfc+t9tAify+tTg8R
         jjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ug3G0ZAO4+3pWW30j6Vblvfr5NEU7yXPNBLL5b+b58=;
        b=nOZCb89G4m9pIEap7kMbfsRCEzSLeqQ3rtzU9bdtEAma6AJeCFP/dUiOhqPljUfclJ
         s/Gi26iNdKsFFZUlabINyd48pb4KOSSP1RRFw/Mj6h5K5eKhwkvmvJE8nZdUF1Sxy+9/
         qGtHU3k1IImL90sVdbi9iYsRjTvqqnJoBa41t5iF3CLELKRntmDE8bQin20s6o8jjsaj
         xaYJAktJ2qHY00hzc7jq9Vu9Mp8cTNP7wK2GBZvd+i55XX/cOSuIUoyGVcHvT8NWcePC
         Jh0HmIzgKE/X2qsRhjZuVmMGYxPYwkHoeIQ+dON5ifEdtmVV3kNkvoMYvWnE0OshyeEZ
         vjGw==
X-Gm-Message-State: ACrzQf1mBvVxKNVaQhYFFlX36LZ6GyEkNRs21QEyjT7i25PiYF/9ZSom
        WVQtsq+5tbwV6RdYNMi0Li+WAQ==
X-Google-Smtp-Source: AMsMyM4GYbvWxWJgPnXWf+k34dOa0OpVUP+sqBm1jtItgCd/NURbvjBCKLCHJqG5p0CEQzUXgGat/A==
X-Received: by 2002:a5d:5082:0:b0:236:7046:8958 with SMTP id a2-20020a5d5082000000b0023670468958mr3171210wrt.214.1666609790143;
        Mon, 24 Oct 2022 04:09:50 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c1c8e00b003c6bd12ac27sm11086801wms.37.2022.10.24.04.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 04:09:49 -0700 (PDT)
Message-ID: <7cf755e5-26c6-be89-8ee7-4b94316c210f@isovalent.com>
Date:   Mon, 24 Oct 2022 12:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v3 8/8] bpftool: Add llvm feature to "bpftool
 version"
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
 <20221020123704.91203-9-quentin@isovalent.com>
 <CAEf4BzYc5iw62Ga+9jDMJc9g9xv85SyarJxxX6nbwSz977zr5Q@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzYc5iw62Ga+9jDMJc9g9xv85SyarJxxX6nbwSz977zr5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-10-21 15:38 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Oct 20, 2022 at 5:37 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> Similarly to "libbfd", add a "llvm" feature to the output of command
>> "bpftool version" to indicate that LLVM is used for disassembling JIT-ed
>> programs. This feature is mutually exclusive with "libbfd".
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
>> Note: There's a conflict on this change with the patch at
>> https://lore.kernel.org/bpf/20221020100332.69563-1-quentin@isovalent.com/
>> Supposiing both are accepted, I will of course rebase one or the other,
>> accordingly.
>> ---
>>  tools/bpf/bpftool/Documentation/common_options.rst |  8 ++++----
>>  tools/bpf/bpftool/main.c                           | 10 ++++++++++
>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/common_options.rst b/tools/bpf/bpftool/Documentation/common_options.rst
>> index 4107a586b68b..05350a1aadf9 100644
>> --- a/tools/bpf/bpftool/Documentation/common_options.rst
>> +++ b/tools/bpf/bpftool/Documentation/common_options.rst
>> @@ -7,10 +7,10 @@
>>           Print bpftool's version number (similar to **bpftool version**), the
>>           number of the libbpf version in use, and optional features that were
>>           included when bpftool was compiled. Optional features include linking
>> -         against libbfd to provide the disassembler for JIT-ted programs
>> -         (**bpftool prog dump jited**) and usage of BPF skeletons (some
>> -         features like **bpftool prog profile** or showing pids associated to
>> -         BPF objects may rely on it).
>> +         against LLVM or libbfd to provide the disassembler for JIT-ted
>> +         programs (**bpftool prog dump jited**) and usage of BPF skeletons
>> +         (some features like **bpftool prog profile** or showing pids
>> +         associated to BPF objects may rely on it).
>>
>>  -j, --json
>>           Generate JSON output. For commands that cannot produce JSON, this
>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>> index ccd7457f92bf..7e06ca2c5d42 100644
>> --- a/tools/bpf/bpftool/main.c
>> +++ b/tools/bpf/bpftool/main.c
>> @@ -89,6 +89,11 @@ static int do_version(int argc, char **argv)
>>  #else
>>         const bool has_libbfd = false;
>>  #endif
>> +#ifdef HAVE_LLVM_SUPPORT
>> +       const bool has_llvm = true;
>> +#else
>> +       const bool has_llvm = false;
>> +#endif
>>  #ifdef BPFTOOL_WITHOUT_SKELETONS
>>         const bool has_skeletons = false;
>>  #else
>> @@ -112,6 +117,7 @@ static int do_version(int argc, char **argv)
>>                 jsonw_name(json_wtr, "features");
>>                 jsonw_start_object(json_wtr);   /* features */
>>                 jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
>> +               jsonw_bool_field(json_wtr, "llvm", has_llvm);
>>                 jsonw_bool_field(json_wtr, "libbpf_strict", !legacy_libbpf);
>>                 jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
>>                 jsonw_end_object(json_wtr);     /* features */
>> @@ -132,6 +138,10 @@ static int do_version(int argc, char **argv)
>>                         printf(" libbfd");
>>                         nb_features++;
>>                 }
>> +               if (has_llvm) {
>> +                       printf(" llvm");
>> +                       nb_features++;
>> +               }
>>                 if (!legacy_libbpf) {
> 
> completely unrelated to your patch set, but we don't have legacy
> libbpf anymore, right? let's clean this part up (separately from this
> patch set, of course)?

Yes agreed, this and the related warning in prog.c. And cleaning up all
the libbpf_get_error() too. I'll work on this when I find some time.

Thanks,
Quentin

