Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500CD626CDF
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKMATl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 19:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMATl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 19:19:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF84DEFC;
        Sat, 12 Nov 2022 16:19:39 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id b62so7344980pgc.0;
        Sat, 12 Nov 2022 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kNEyg40CCFx17PBhtNgPOgiExcnGtc6VatoUUGof/cc=;
        b=p5VvUddSGpNVEKqyZIF4WVv2z4i4XqkqKt6NUmjgCXYslKtssbvwvjF0nqOm5Lbd5b
         99Xhsz+VfgSZ41u7sbsS7/wvnxyxQWx/Lr+L6TTc8NVDU5ImtN4YYklxiWW1dmL1G+/X
         zQorccsNtcNUsDyN06m5LAanLdcEcxh6jMo+mur43ILLkraTS4TUkSyngM5TbwSE+FXE
         jMKlkE5CRv5nXHEzHqHdAQUHyTJYUMHnk6/X23jtCAIGEWjPmBye1FsYLNOLmjntCKMT
         IE8nQHV13Kvo+BEtEYYcTYByYbdF14XWVYHZgmRjqk2YAgj0k9bTpkWad+7fIKSrQPbJ
         PTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNEyg40CCFx17PBhtNgPOgiExcnGtc6VatoUUGof/cc=;
        b=7FvB2qx3vDeJnNEwR1QwUvY25URih6JXzHirnZtDXiGW2NMMFJUhgAmNGLPo8942vS
         Equjb5X94BGmrlNTeV5JTFmVgQFrbS9f98cpppL+rOgnIZH5dcmyile9Rd4yIRc0BZiK
         ON42KHUzK0Vg9MygyPBwwg6wt0wqweXmOb/jkIPX1BBnRyvTQrX4WvqJh1zyV887f7AR
         mbi9oIXf15ak7Qz5mFZLqSVFOmdd4c9pZvF3L3bzvIy7IRCUnnO4b3Z5KTDpiWYFwXnG
         iBfT4eVbFAMBYHw5vP4cs9mfl0AUsa1oqWtMdpsG+rfgAUrH12RaNM7ANirPuJSYtNk+
         wwzA==
X-Gm-Message-State: ANoB5pmC42WaQkmKqxvlj/SIN6Mez4fGiJiLYQIzfIJR4lYBdrmhbYGY
        Q5ooWRulTtIGrWUAX9ngs3I=
X-Google-Smtp-Source: AA0mqf5iUayVbTf1/ykPaRPoSKcy1AwFhx9prO8kbkYjbk25BrZTqP0pE/Pvx15v8RsWoOfN/rRepg==
X-Received: by 2002:aa7:92c7:0:b0:56d:6450:9e48 with SMTP id k7-20020aa792c7000000b0056d64509e48mr8558159pfa.14.1668298778515;
        Sat, 12 Nov 2022 16:19:38 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z10-20020a170903018a00b00180a7ff78ccsm4217202plg.126.2022.11.12.16.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 16:19:37 -0800 (PST)
Message-ID: <65d9b890-05d2-0215-b7ae-3011d6dff0a2@gmail.com>
Date:   Sun, 13 Nov 2022 09:19:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/1] docs: BPF_MAP_TYPE_CPUMAP
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, donhunte@redhat.com, jbrouer@redhat.com,
        linux-doc@vger.kernel.org, lorenzo@kernel.org, thoiland@redhat.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221107165207.2682075-2-mtahhan@redhat.com>
Content-Language: en-US
In-Reply-To: <20221107165207.2682075-2-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Maryam,

I know this has already been applied, but I see warnings from
"make htmldocs" on pbf-next caused by this. See inline comment
below.

On Mon,  7 Nov 2022 11:52:07 -0500, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_CPUMAP including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/bpf/map_cpumap.rst | 166 +++++++++++++++++++++++++++++++
>  kernel/bpf/cpumap.c              |   9 +-
>  2 files changed, 172 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/bpf/map_cpumap.rst
> 
> diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
> new file mode 100644
> index 000000000000..eaf57b38cafd
> --- /dev/null
> +++ b/Documentation/bpf/map_cpumap.rst
> @@ -0,0 +1,166 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +===================
> +BPF_MAP_TYPE_CPUMAP
> +===================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_CPUMAP`` was introduced in kernel version 4.15
> +
> +.. kernel-doc:: kernel/bpf/cpumap.c
> + :doc: cpu map
> +
> +An example use-case for this map type is software based Receive Side Scaling (RSS).
> +
> +The CPUMAP represents the CPUs in the system indexed as the map-key, and the
> +map-value is the config setting (per CPUMAP entry). Each CPUMAP entry has a dedicated
> +kernel thread bound to the given CPU to represent the remote CPU execution unit.
> +
> +Starting from Linux kernel version 5.9 the CPUMAP can run a second XDP program
> +on the remote CPU. This allows an XDP program to split its processing across
> +multiple CPUs. For example, a scenario where the initial CPU (that sees/receives
> +the packets) needs to do minimal packet processing and the remote CPU (to which
> +the packet is directed) can afford to spend more cycles processing the frame. The
> +initial CPU is where the XDP redirect program is executed. The remote CPU
> +receives raw ``xdp_frame`` objects.
> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +.. c:function::
> +     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
> +
> + Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
> + For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
> +
> + The lower two bits of ``flags`` are used as the return code if the map lookup
> + fails. This is so that the return value can be one of the XDP program return
> + codes up to ``XDP_TX``, as chosen by the caller.
> +
> +Userspace
> +---------
> +.. note::
> +    CPUMAP entries can only be updated/looked up/deleted from user space and not
> +    from an eBPF program. Trying to call these functions from a kernel eBPF
> +    program will result in the program failing to load and a verifier warning.
> +
> +.. c:function::
> +    int bpf_map_update_elem(int fd, const void *key, const void *value,
> +                   __u64 flags);
Sphinx's domain directives assumes single-line declarations [1].
Hence "make htmldocs" with Sphinx >= 3.1 emits warnings like:

/linux/Documentation/bpf/map_cpumap.rst:50: WARNING: Error in declarator or parameters
Invalid C declaration: Expected identifier in nested name. [error at 67]
  int bpf_map_update_elem(int fd, const void *key, const void *value,
  -------------------------------------------------------------------^
/linux/Documentation/bpf/map_cpumap.rst:50: WARNING: Error in declarator or parameters
Invalid C declaration: Expecting "(" in parameters. [error at 11]
  __u64 flags);
  -----------^

This can be fixed by using reST's continuation line as follows:

.. c:function::
    int bpf_map_update_elem(int fd, const void *key, const void *value, \
                   __u64 flags);

, or by permitting a somewhat long declaration:

.. c:function::
    int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);

Can you please fix it?

[1]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#basic-markup

        Thanks, Akira

[...]
