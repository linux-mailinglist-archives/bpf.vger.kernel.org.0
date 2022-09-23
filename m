Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA05E7DE4
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiIWPFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiIWPFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 11:05:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4EDF688;
        Fri, 23 Sep 2022 08:05:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so469873wrm.2;
        Fri, 23 Sep 2022 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=1k/Im0a6/2zJIZF5Uvpl9nL2Zd7ZEhVf1xGnML7mQiY=;
        b=fwvD8x9ikvaFa2JHRm3xmN6XKNW4Cqwc4zSMWm3ljNVL3uDPfsqUwBUpfRJ8Qg6qks
         pEZHwQnpYt3wBLZ7P43se/UO1By3C2nqrPO2dPtAn9sXxnEpa+wQZNgsT8wlWQXY3TfF
         ynCJ07Pq+bKlXpZwmhSRW9R991Pdx911pIVip/BOmpPRXFlOVq88yuXLozEvb76Jw4ge
         SVWiCCEZv/fBCRG64G5VdsNy7t8lBUqm17kyuLjuJDlgjc7vGKCmsSiUcReGjwVKPjgk
         gUiYEyWFA8a97kYqjBaMsmVb/0PNk4wxE9V0LH2adLuTXEF5WszG+J4ohTM+7U15Ub4L
         F28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1k/Im0a6/2zJIZF5Uvpl9nL2Zd7ZEhVf1xGnML7mQiY=;
        b=WCRjGkcgsCKwh643Dr7944mTQ/gDdU/2Ul8FrIxNH3DLWAAvRhczBwESLa7DfraoyQ
         mpP6Q9kwRpmwWV+MWy2szDpbimHByHsglCJgdHFB7quxRWEPBoq5SP2HHTpD9ZXvqV9R
         6MrAl50GR+86SGcw88qdddaTXvOLrhnYpY2ilIvh0WacniTVvi+JCBIiIgh+zAnqJtDj
         qJrGICB+uKQl2OsICaUMU0dgjBTBw+51V3FLEzaBXnmodE8FcoDxw76VVGqMMyHfzaWy
         CxQ+/enmgcohKVWQW0SzV/a3BsjhsNuFosR2JmHsYp/ZpjOUAiGGsvobrtBwo3EWmD3m
         V3lg==
X-Gm-Message-State: ACrzQf1q0W2vBYAkyPF0u5bzePjzD7DffygdBq2ppgt+gjMcmE574b5V
        a9MotiTJTQ68xmbbu6mxQUXhXmUV2bZwRA==
X-Google-Smtp-Source: AMsMyM5D3niELpKni0WfW68gWeRMJyv0hMsxrtzmrNE0ODyW7ZPISv+Hw3GWMHBOFyqAMGQpC2/prQ==
X-Received: by 2002:adf:f5d0:0:b0:228:6ca8:21f2 with SMTP id k16-20020adff5d0000000b002286ca821f2mr5851709wrp.271.1663945546478;
        Fri, 23 Sep 2022 08:05:46 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003b4fe03c881sm2831391wmo.48.2022.09.23.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:05:45 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] Add table of BPF program types to
 libbpf docs
In-Reply-To: <Yy2zBAIFGGBMe4k1@debian.me> (Bagas Sanjaya's message of "Fri, 23
        Sep 2022 20:22:12 +0700")
Date:   Fri, 23 Sep 2022 16:05:11 +0100
Message-ID: <m2czbm872w.fsf@gmail.com>
References: <20220922115257.99815-1-donald.hunter@gmail.com>
        <20220922115257.99815-3-donald.hunter@gmail.com>
        <Yy2zBAIFGGBMe4k1@debian.me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Thu, Sep 22, 2022 at 12:52:57PM +0100, Donald Hunter wrote:
>> +..
>> +  program_types.csv is generated from tools/lib/bpf/libbpf.c and is formatted like this:
>> +    Program Type,Attach Type,ELF Section Name,Sleepable
>> +    ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
>> +    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,``sk_reuseport/migrate``,
>> +    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reuseport``,
>> +    ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
>> +    ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
>> +    ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
>
> The note above doesn't get rendered on htmldocs output, so I have applied
> the fixup:

It was intended to be a comment to the reader of program_types.rst that
this is the format of the .csv file that will be rendered. It was not
meant to be a note on the rendered page.

The rendered page will show the table that is produced by the csv-table
directive which is self explanatory.

>
> ---- >8 ----
>
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
> index b74fbf3363dd6c..3ce0ec94b399b4 100644
> --- a/Documentation/bpf/libbpf/program_types.rst
> +++ b/Documentation/bpf/libbpf/program_types.rst
> @@ -16,15 +16,17 @@ When ``extras`` are specified, they provide details of how to auto-attach the BP
>  The format of ``extras`` depends on the program type, e.g. ``SEC("tracepoint/<category>/<name>")``
>  for tracepoints or ``SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")`` for USDT probes.
>  
> -..
> -  program_types.csv is generated from tools/lib/bpf/libbpf.c and is formatted like this:
> -    Program Type,Attach Type,ELF Section Name,Sleepable
> -    ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
> -    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,``sk_reuseport/migrate``,
> -    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reuseport``,
> -    ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
> -    ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
> -    ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
> +.. note::
> +   The table below is generated from ``tools/lib/bpf/libbpf.c`` and is
> +   formatted like this (in CSV format)::
> +
> +     Program Type,Attach Type,ELF Section Name,Sleepable
> +     BPF_PROG_TYPE_SOCKET_FILTER,,socket,
> +     BPF_PROG_TYPE_SK_REUSEPORT,BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,sk_reuseport/migrate,
> +     BPF_PROG_TYPE_SK_REUSEPORT,BPF_SK_REUSEPORT_SELECT,sk_reuseport,
> +     BPF_PROG_TYPE_KPROBE,,kprobe+,
> +     BPF_PROG_TYPE_KPROBE,,uprobe+,
> +     BPF_PROG_TYPE_KPROBE,,uprobe.s+,Yes
>  
>  .. csv-table:: Program Types and Their ELF Section Names
>     :file: program_types.csv
>  
> Thanks.
