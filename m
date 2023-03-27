Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C486A6CA17A
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjC0Ka4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjC0Ka1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 06:30:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF86A7D
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 03:30:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso4690195wmo.1
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679913014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1YaJOLtcACtl+x7ZsYQ78GbyAkSJjqNruVsjDHpY5M=;
        b=Cp469JzvERcjK1tevQGodWlhVepyO0Uw9CXd/wOyw7XEUZbh0BsfN4SIzixJ0L2yLs
         /gmqI9afcdOjS/fvBP7nSCqt+yHn8iq9uOXmRi6otbSYQXKdqVzuvW/DV7/74l2wcMjP
         t9XylPJS2S4c/cWKkUYWZTdmRr0TJYBlvKqo3FyJyP0p9bsNJAJtRWrz9iVBJLf3hIiP
         osGNKDsUSierj+0VaTmCxDgPxDAJwchC/V0XlnoviDLR7PP3YsApOie7jzZJK4clLV/E
         TMr4sMl0uY1x1bSm0dUAWfPXcHc7x8yUZzfd9UAwH5UvVDnkqR+6nEIU39d2U/Gl0XJY
         zQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679913014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1YaJOLtcACtl+x7ZsYQ78GbyAkSJjqNruVsjDHpY5M=;
        b=B6eK6yYKuR/04rTMv4aMi2ixXCrVksjhS5QH2d+3BVfvRd9AC019F58XNNp6OOtGIO
         fFTjFGsaifsiEBjqhpQuKl+Tn0fw4c6x2HAJa4haznMEaquDsQVnGGqNK7bDxj6uKe4n
         e2gt+g1REt1Q4+Stu3cAGRTo3hM1xbtLG335taLseV3G2dqJjOdl4Xk0rycJtDJkuPUk
         6xh5VexobHeQbtfaqkh9yDcqvw42uj4r02tQJnrmlr9SWMikZ6jE37PCvEyrXTTQaNSp
         Pe3vNvmeOM0x6k6VIu4L41z1ADSOLUwnorYdqVAlk2uUP1U1Bd8iJIgqZld0yftcJYvo
         lxOg==
X-Gm-Message-State: AO0yUKUoN+DsYdDT3BtDoSTz5pzlPAyfRDAUK7ZmdPQfnkYrK7esZGC0
        7i3OHq8+NaBFsN3zP5mGO7ufzA==
X-Google-Smtp-Source: AK7set97nRqQK2m3ny3PLpsBVXXRyI3p0udxuUn0YY3uMHdfGm1kBkjjGLdvoIPUk23IirXrNO5bTg==
X-Received: by 2002:a7b:c44a:0:b0:3ef:8b0:dbb1 with SMTP id l10-20020a7bc44a000000b003ef08b0dbb1mr8608097wmi.7.1679913014038;
        Mon, 27 Mar 2023 03:30:14 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:61cd:634a:c75b:ba10? ([2a02:8011:e80c:0:61cd:634a:c75b:ba10])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003edc11c2ecbsm7381054wmi.4.2023.03.27.03.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:30:13 -0700 (PDT)
Message-ID: <8cffb61b-5977-7a81-8740-2e775337dbbe@isovalent.com>
Date:   Mon, 27 Mar 2023 11:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 3/5] bpftool: Support inline annotations when
 dumping the CFG of a program
Content-Language: en-GB
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230324230209.161008-1-quentin@isovalent.com>
 <20230324230209.161008-4-quentin@isovalent.com> <ZB5k7DFJ4TRe1W7I@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZB5k7DFJ4TRe1W7I@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-03-24 20:05 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> On 03/24, Quentin Monnet wrote:
>> We support dumping the control flow graph of loaded programs to the DOT
>> format with bpftool, but so far this feature wouldn't display the source
>> code lines available through BTF along with the eBPF bytecode. Let's add
>> support for these annotations, to make it easier to read the graph.
> 
>> In prog.c, we move the call to dump_xlated_cfg() in order to pass and
>> use the full struct dump_data, instead of creating a minimal one in
>> draw_bb_node().
> 
>> We pass the pointer to this struct down to dump_xlated_for_graph() in
>> xlated_dumper.c, where most of the logics is added. We deal with BTF
>> mostly like we do for plain or JSON output, except that we cannot use a
>> "nr_skip" value to skip a given number of linfo records (we don't
>> process the BPF instructions linearly, and apart from the root of the
>> graph we don't know how many records we should skip, so we just store
>> the last linfo and make sure the new one we find is different before
>> printing it).
> 
>> When printing the source instructions to the label of a DOT graph node,
>> there are a few subtleties to address. We want some special newline
>> markers, and there are some characters that we must escape. To deal with
>> them, we introduce a new dedicated function btf_dump_linfo_dotlabel() in
>> btf_dumper.c. We'll reuse this function in a later commit to format the
>> filepath, line, and column references as well.
> 
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>   tools/bpf/bpftool/btf_dumper.c    | 34 +++++++++++++++++++++++++++++++
>>   tools/bpf/bpftool/cfg.c           | 23 +++++++++------------
>>   tools/bpf/bpftool/cfg.h           |  4 +++-
>>   tools/bpf/bpftool/main.h          |  2 ++
>>   tools/bpf/bpftool/prog.c          | 17 +++++++---------
>>   tools/bpf/bpftool/xlated_dumper.c | 32 ++++++++++++++++++++++++++++-
>>   6 files changed, 87 insertions(+), 25 deletions(-)
> 
>> diff --git a/tools/bpf/bpftool/btf_dumper.c
>> b/tools/bpf/bpftool/btf_dumper.c
>> index e7f6ec3a8f35..504d7c75cc27 100644
>> --- a/tools/bpf/bpftool/btf_dumper.c
>> +++ b/tools/bpf/bpftool/btf_dumper.c
>> @@ -821,3 +821,37 @@ void btf_dump_linfo_json(const struct btf *btf,
>>                       BPF_LINE_INFO_LINE_COL(linfo->line_col));
>>       }
>>   }
>> +
>> +static void dotlabel_puts(const char *s)
>> +{
>> +    FILE *stream = stdout;
>> +
>> +    for (; *s; ++s) {
>> +        switch (*s) {
>> +        case '\\':
>> +        case '"':
>> +        case '{':
>> +        case '}':
>> +        case '>':
>> +        case '|':
>> +            fputc('\\', stream);
>> +            __fallthrough;
>> +        default:
>> +            fputc(*s, stream);
>> +        }
> 
> nit: optionally, if you're going to respin, maybe do putchar instead
> of fputc + stdout? (not sure why you're doing fputs)
Right, no particular reason, I'll switch to putchar() and respin.

Thanks for the review!
Quentin
