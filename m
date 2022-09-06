Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583C25AF248
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiIFRTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 13:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbiIFRSy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 13:18:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E417E38;
        Tue,  6 Sep 2022 10:07:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id az27so16431306wrb.6;
        Tue, 06 Sep 2022 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=d7AkixOMV32e6vIKIt1+7sUJ8KZkxzm56toQ2L27L/E=;
        b=D7jUbaMMyC2gYcwc8IognHgPh/EZCIu/DW4jpPg16JRyxc+jy8gb71guWFb14Gpoit
         0OGsZe/lPtyVcFm1xoAuCfFpGis7SmTa6gU6iGT4/q1v8XolO9oL9miMpGyiRWrdyb4J
         I6DKLDC5aGh5G0dIL46dANxQqcRDwMW6+fqRJsKA3OJCsm9YQarBNFg/CguS6q8xXWLS
         Fd/pZFHq8K8LWojqJr4gpEFS74zuM0JkzQ5t0FidJH8QAQxIq5N/hNBCT6SY7XUYpwy0
         Uxn4R+ZxrE+sYFSq3Hn1Idmq2Qsznsam1ckjJPsCn4qi5jsPHc6az1qVCNqGR93dOqBg
         nYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=d7AkixOMV32e6vIKIt1+7sUJ8KZkxzm56toQ2L27L/E=;
        b=jkN5vb9wURKR6a6U2J2B+4kLD9v/eubWxhVuH7tA45lDsCD4JB5e4LsOEhveB00vZY
         eUZlG7a7YNaV09leZnKdIEXYNip2Nln7KFtX3yVJGb8T7XGFSs6vtKzqPZ0XM/hS9dgf
         swJvV9sjVNXrK7VvC5ZxNgxFhwhVqPRuFZrLuQtXhn26DpzLk3tqOz1icIFbP6vLuZ0e
         UWImF3NtQs2UaQIXC2tp2P+XEZ6B5YntgMmoo/tnHyaXODDQfR0P0l/niKrohoE5ODEh
         Qw41XWgH+4ANIYDxQFuHSiu8N7ajRTOP19upWnFaxGgw3Lp2Pjzv6ADFHNJZi/m0zx7E
         KQEQ==
X-Gm-Message-State: ACgBeo1kZmKEBiIh2onC7VHrNQkrvyQWDAcdRGECJW+1ZXtlbnrda4VH
        WiDkmiu7leKDUTG9jiCDPrvvbcFbm0etfQ==
X-Google-Smtp-Source: AA6agR6V8Xqe1ALsd54De/WO0V1JbQN4IOWkD22QSXiegjL0f+7f/84PJ2yIKhcEJK/STy7sYVvxDg==
X-Received: by 2002:a5d:4690:0:b0:228:9858:8520 with SMTP id u16-20020a5d4690000000b0022898588520mr5896626wrq.558.1662484060984;
        Tue, 06 Sep 2022 10:07:40 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc008000000b003a31ca9dfb6sm18227921wmb.32.2022.09.06.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:07:39 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] Add table of BPF program types to
 libbpf docs
References: <20220829091500.24115-1-donald.hunter@gmail.com>
        <20220829091500.24115-3-donald.hunter@gmail.com>
        <87h71kadjh.fsf@intel.com>
Date:   Tue, 06 Sep 2022 18:07:38 +0100
In-Reply-To: <87h71kadjh.fsf@intel.com> (Jani Nikula's message of "Tue, 06 Sep
        2022 15:32:50 +0300")
Message-ID: <m2zgfc4ejp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jani Nikula <jani.nikula@linux.intel.com> writes:

>> +
>> +.. csv-table:: Program Types and Their ELF Section Names
>> +   :file: ../../output/program_types.csv
>
> Oh. You should probably test this with out-of-tree builds.

By out of tree, do you mean make htmldocs O=... or something else?

I have tested with O=... whih works for the kernel docs, but I think I
will need to rework the location to support the libbpf doc build which
has different directory layout.

Thanks,
Donald.
