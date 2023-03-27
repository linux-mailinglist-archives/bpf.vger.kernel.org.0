Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9896CA177
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 12:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjC0Kax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjC0KaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 06:30:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC6170C
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 03:30:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t4so2955798wra.7
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679913010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZA8j3Gto9WQ2WAm5xcPzOdBR8bMn9kZ6Ph11du0N00=;
        b=FHp1y03ySXMGMR1zTGx7NypwzdCTugbSV9vlf/ZnZc2R5GgNqm7ILEes8Il8l+NN7f
         STY+MpwKm3x8uvepGGEltcum+vIH+RZydYWT8MPWOSfu9G2aMLPvXrh+Ka7jwqQtx5EL
         RH0r0nvk0cRiOygaAGXtjwetWqsDXFTMYploDWdBNwPQIhl/lG1JlWP52CYBGnDIg/Y5
         FShSkff90QRX84EgIUI9kTSyhK1pn4G/LMFEwZuDfHpA6q6e4QFzy5lzmbIfhvn9Ib6f
         /O+lREZTjOgyvjVXV1kPQkfAcMi/UhxOYoQA4a5lBmhAFkJAFeSdyhNgt6cYpEViwGNl
         JpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679913010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZA8j3Gto9WQ2WAm5xcPzOdBR8bMn9kZ6Ph11du0N00=;
        b=6DHKt9MsOhVh+ikKDTs0tZ7/nCRgC4Zic9CjUEEZkyFLBJpOGZTXv+bL78dobBGT+v
         Y7MrWMJMFKMF2BrFO+VKaDdq1pN+IRRkaFhmvMzfMLAo/YwHjlCLGRfyf/8mQSBKk41+
         ZF+Eq+hW6rDPwT+zC3Z1E7xXW3pb3cRTPpE8HrgddFj8lFlONCmtQsuekggA4+j+VgZN
         Wbm4VzWEMsYL/pz7QASt/1i8/P/JPzmP6ubHItLM6rTxkFnnu26qASOGL8vOCWQ7j6v3
         oi56QNUYQ2iIxxRdCmlHhS/xEMIaYmZBRKmoVExhIobxBMgGkMJhBfYfDNS7N52xfc/X
         mawA==
X-Gm-Message-State: AAQBX9cnpFN5Unv43OwRU7Hn8K5G9i6fJe6D1LyxYCL6MoqElV1256I3
        i8qJLGbzqFpCLme9nu5l4yMhnw==
X-Google-Smtp-Source: AKy350YJlNzhpyAp0mc5yrRAyu4gOYwLWH/gGbOwacWFMwvPUqD2+lImiaXHGx0ojLdSZr7HewZ7Ng==
X-Received: by 2002:adf:f5c8:0:b0:2dc:cb11:bed3 with SMTP id k8-20020adff5c8000000b002dccb11bed3mr8672455wrp.68.1679913010264;
        Mon, 27 Mar 2023 03:30:10 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:61cd:634a:c75b:ba10? ([2a02:8011:e80c:0:61cd:634a:c75b:ba10])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003ed793d9de0sm21337205wms.1.2023.03.27.03.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:30:10 -0700 (PDT)
Message-ID: <1257fbac-30aa-d1e8-f517-b682e43408cd@isovalent.com>
Date:   Mon, 27 Mar 2023 11:30:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 2/5] bpftool: Fix bug for long instructions in
 program CFG dumps
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
 <20230324230209.161008-3-quentin@isovalent.com> <ZB5iT1ux8YIL/Jr8@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZB5iT1ux8YIL/Jr8@google.com>
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

2023-03-24 19:54 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> On 03/24, Quentin Monnet wrote:
>> When dumping the control flow graphs for programs using the 16-byte long
>> load instruction, we need to skip the second part of this instruction
>> when looking for the next instruction to process. Otherwise, we end up
>> printing "BUG_ld_00" from the kernel disassembler in the CFG.
> 
>> Fixes: efcef17a6d65 ("tools: bpftool: generate .dot graph from CFG
>> information")
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>   tools/bpf/bpftool/xlated_dumper.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
> 
>> diff --git a/tools/bpf/bpftool/xlated_dumper.c
>> b/tools/bpf/bpftool/xlated_dumper.c
>> index 6fe3134ae45d..3daa05d9bbb7 100644
>> --- a/tools/bpf/bpftool/xlated_dumper.c
>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>> @@ -372,8 +372,15 @@ void dump_xlated_for_graph(struct dump_data *dd,
>> void *buf_start, void *buf_end,
>>       struct bpf_insn *insn_start = buf_start;
>>       struct bpf_insn *insn_end = buf_end;
>>       struct bpf_insn *cur = insn_start;
>> +    bool double_insn = false;
> 
>>       for (; cur <= insn_end; cur++) {
>> +        if (double_insn) {
>> +            double_insn = false;
>> +            continue;
>> +        }
>> +        double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
>> +
>>           printf("% 4d: ", (int)(cur - insn_start + start_idx));
>>           print_bpf_insn(&cbs, cur, true);
>>           if (cur != insn_end)
> 
> Any reason not to do the following here instead?
> 
>     if (cur->code == (BPF_LD | BPF_IMM | BPF_DW))
>         cur++;

Yes, I reuse double_insn in patch 5 to print the last 8 raw bytes of the
instruction if "opcodes" is passed. I could make it work with your
suggestion too, but would likely have to test "cur->code" a second time,
I'm not sure we'd gain in readability overall. I'll keep the variable
for v2.
