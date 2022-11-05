Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05061A646
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 01:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKEAGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 20:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEAGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 20:06:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0203C31DFD;
        Fri,  4 Nov 2022 17:06:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso9591956pjg.5;
        Fri, 04 Nov 2022 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqfxDZq07uNhmpz8OtVuHc6V3X9DHW6/pxboCfsjhxw=;
        b=odrF02VrcCdcaeE2buh4ccbEOSosqfyqnVmsxzwL4kHlOwy45j4cbgTiCr/h6ITopP
         U0klm94tB1IyJOl1KJ4iM8xujBKGcXaPP+zWxfdGTBXIgI9k9mySeRbtylSGwzvDJS6m
         /pW9hvxIb76r2FTqgv4e5WkLOiVA6ITVYTvG4g09eTlqkhjJdtuOp3YFfc7yHt3lugfk
         fBqFocrWlbHy4UnixDHl3Tp3OCrp+W++bT1XareYP+4IX3NcdBppKEWq4+OjWxH/gXvx
         JXeEIfSpFqDlZ0QeX44fe0moMC3eB4y5d3pEOjqM6Bowhy8CLsfaJJC3JrDO7iT98en9
         Q3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqfxDZq07uNhmpz8OtVuHc6V3X9DHW6/pxboCfsjhxw=;
        b=6GHI1F31CwDLXxIditZ5KD2yK6szjiYXKjJHAsbbqubO0TKzm9ujz1MRzQFTFvXDNb
         +uRImwAt3TKTFrp6HrxUedgjj/ClPl+BrbLWEQOfEIrvfZwJzvMVkKbVgANRH1lbmZ+B
         4fwWraVubYlC2dEetn9DA6qVRJpukUTNGQPna7udBNuwf3S6bvclttU+PBHyzFXUqgsR
         KkJCx5FxmZiqSAAHqaMuSErLcezvMHx38F49hJX5PJDmxrUswG/PLwdfvuWH8owM7dvW
         cjuvIhckYQOhX0+gu5WNEPXV8Qqdr7m/hu6LYHRyMmvQeTfdDtC7ehTeQ78l81/X8t4H
         Sfgg==
X-Gm-Message-State: ACrzQf0Zon1mYvDt/ROxQV9nXFMZJlMXPuOY4HX6i8z3fkG5YfmWc/ZH
        +WP7OL4s0a3RJdopztMUpqo=
X-Google-Smtp-Source: AMsMyM40brYimWNa5DlF7NB355tZrwTWkssHW5YPKdjXorcfhZf7GER2T/a5ER+VO+PwcyiGMrCpIA==
X-Received: by 2002:a17:90a:1382:b0:213:c2a7:5ad with SMTP id i2-20020a17090a138200b00213c2a705admr34311937pja.193.1667606749249;
        Fri, 04 Nov 2022 17:05:49 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0017808db132bsm303972pln.137.2022.11.04.17.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 17:05:48 -0700 (PDT)
Message-ID: <1c8a0445-ee7d-991a-2ec8-cdc29204c68a@gmail.com>
Date:   Sat, 5 Nov 2022 09:05:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bagasdotme@gmail.com,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, sdf@google.com, song@kernel.org,
        void@manifault.com, yhs@fb.com, Akira Yokosawa <akiyks@gmail.com>
References: <CAEf4Bzau0QuBiNsXoMq_QRV+_MTyodQsvW7O2kbScgmVmbuXkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Documentation: bpf: escape underscore in BPF
 type name prefix
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <CAEf4Bzau0QuBiNsXoMq_QRV+_MTyodQsvW7O2kbScgmVmbuXkQ@mail.gmail.com>
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

Hi,

On Fri, 4 Nov 2022 16:11:10 -0700, Andrii Nakryiko wrote:
[...]
> Applied, thanks. But would the other similar case be problematic?
> 
> $ rg 'bpf_\b'
> bpf_design_QA.rst
> 329:NOTE: BPF subsystem specially reserves the 'bpf_' prefix for type names, in
> 331:avoid defining types with 'bpf_' prefix to not be broken in future
> releases. In
> 333:with 'bpf_' prefix.
> 
> libbpf/libbpf_naming_convention.rst
> 12:following prefixes: ``bpf_``, ``btf_``, ``libbpf_``, ``btf_dump_``,
> 59:described above should have ``libbpf_`` prefix, e.g.

Those other cases are all inside double back quotes and
construct "inline literal" strings. So they are fine.

Which means Bagas could have used the "inline literal" approach
instead.

Regards,
Akira

