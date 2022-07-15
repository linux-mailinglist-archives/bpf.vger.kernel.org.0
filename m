Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E982D575E2B
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 11:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGOIxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiGOIwv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 04:52:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D08485D6A
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 01:51:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l22-20020a05600c4f1600b003a2e10c8cdeso4430902wmq.1
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GgkRzO21rhAu9aYlbhzR1FqLgieRHzSARHA5Kmff5MI=;
        b=pCdUnbaGoZz3+NT6huHO7yWsQYtdJKN3rWlj9Cwf0+mAHAs1gv6KU0fQ67iOlGkyIL
         n3tVW2uRG7CYlSx6sGvyXTp+HTnTd+VvLGAMR1hYidb8avx8caTaSCv9NhC2Whds66h4
         U6oLQQA2TyezLE3Bp2BZfMW787qSo9s7TZGx1+1EYPi43NQb/CVUWb6XLap92bsT9tHr
         M/uPLE+kbMyE0FvQE0D2pzK7k1bYDkyJS5dNNtRDbMkj4dDqVmT4RTAcYrpYWj/O+KsH
         dOr53zdH5SAhHxXaqpjLcKtUo5M+Bc2rtmGnmjeIQ0ojn46nGEZX4r5Ew4DyxyMRZPXN
         +cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GgkRzO21rhAu9aYlbhzR1FqLgieRHzSARHA5Kmff5MI=;
        b=WN7HAg41s4GbdSSyXLKtD2fifpbNa1WXm1c/Ho6nwTYcVLFPvB5IULpG5fx556TSLK
         tZTjsSy5Oul5RMh7CMRY0G5iE6SJYnAkiD49dpQn2ZrTD1Za4OD8I4mdBHbrMQ9zNkPd
         gOED1clzEeRm0BTY6Rdn2lJyd3yjqN80THj1+LEAG7kdXs5aq2t5tsAnqqEeYsnB9gZ3
         9Eeh2JbNRdy/LzqhiPzoV0qNWRDK4Lz6cAwQY3bl4e+wfxbFGql37vyB4cWIOjltW5bU
         zLaSWOHl+DNQNOI1sVoPz/4suntu3cPnMcFMiFrbQuGtctwDYJxODP5WrM38H+sEc+k+
         ZsQw==
X-Gm-Message-State: AJIora+72ezZG01iOvkTHUK7mJQmYm9461Gj5W0q1JFtfVsLMegnAnZX
        N1rb/JVSFYCVt1uTv7MPcovXsw==
X-Google-Smtp-Source: AGRyM1vcEkYiYG88MFItmaDLW68WJWnQNk5cx7A0NDGQS1DVH1Nroa1AACOuJGIvlmu4Oidx2if3YA==
X-Received: by 2002:a05:600c:4e53:b0:3a2:fb49:ca67 with SMTP id e19-20020a05600c4e5300b003a2fb49ca67mr12536190wmq.167.1657875109105;
        Fri, 15 Jul 2022 01:51:49 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l2-20020adff482000000b0021b9585276dsm3377556wro.101.2022.07.15.01.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 01:51:48 -0700 (PDT)
Message-ID: <6e138fa5-ec8a-bf34-f243-4c82188b2af3@isovalent.com>
Date:   Fri, 15 Jul 2022 09:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH bpf-next v1] bpf: fix bpf_skb_pull_data documentation
Content-Language: en-GB
To:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Rumen Telbizov <telbizov@gmail.com>
References: <20220714224721.2615592-1-joannelkoong@gmail.com>
 <CAJnrk1ZcDjMVPgf2QSfmjJDjmWEGp0h0ZXuUEPByv9w542txmw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAJnrk1ZcDjMVPgf2QSfmjJDjmWEGp0h0ZXuUEPByv9w542txmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15/07/2022 00:14, Joanne Koong wrote:
> On Thu, Jul 14, 2022 at 3:48 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> Fix documentation for bpf_skb_pull_data() helper for
>> when flags == 0.
> sorry, this commit message should be "when len == 0" (not flags).
>>
>> Fixes: fa15601ab31e ("bpf: add documentation for eBPF helpers (33-41)")
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Yes, Rumen reported this to me some time ago but I never took the time
to send a fix. Thanks a lot!

Acked-by: Quentin Monnet <quentin@isovalent.com>

