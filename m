Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC28F4EB84E
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 04:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiC3Ccb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 22:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiC3Ccb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 22:32:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C70473A3
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 19:30:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so717402pjb.5
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 19:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=92dUbSHg78OsEfJTqJrE7uj6ETamRmCafwlK69JT+dE=;
        b=gz2cxyCDZTR/iJLBpb+uJaNqZWuqyNhhdM5BPRCEQYbEzthJLE6CzisoIQCR2CZmn/
         EmVKAkqIBhxk8kJ8h3HSDmGj65jJi3swinNGqr4AD8nMAmlUQDRMKcJj6KTzZaB9li9K
         VuvpsyhcWQYaxFX6o7uItOjmSWsdSJ1H0VXRe6/tijY8FyvNQJoG6EUjWC3wA1O3ClT1
         F5Hak8bhIi3lgf3g7Yv1KgAwKhNxmC8S1zbxyjpbND47rXSVtfnvQxcWyJLCH4oe5QmS
         NZfccAslgNqE32LNMvKonnfxZp6c/y7e6mEfBGWDEVkrP9cT0qxmZFSLnavsdOG+TDej
         fEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=92dUbSHg78OsEfJTqJrE7uj6ETamRmCafwlK69JT+dE=;
        b=I5iLRPBgoylqR4e4GXIP0PLlmpNGJyB68LEypeWCCnsy0KXFnt3rRkHFbq3tpLWoVZ
         vwNp43subaqBAIpdc/DIB0ZACCPhP+6qE5N4Xwbl9zVddnbd61A3xZ7epchv9/5keIPP
         QLZx5E+9OSlavdMOBzvz7VpSKMACpicy66XwQpLUQh1As/vH3/OgCsiQYlVN/Kvm1HLu
         F8mGckDCBaN1Z6AhWybXoWQSKChaxniqeCksRfjccfWKhFKt9GqUd0Bv1Ly7uQGR5pLp
         AW7AgmkgfEXD+fbTcWqT0eokYWTxbJhC1EY4dFctW5Qd9mtTGsd/QJWch09PgLWsD4QC
         U0Og==
X-Gm-Message-State: AOAM532+nlnZfgNOLt5x0fUSUcYck5jxwItmo7yrxsxSkg+rJ10J7sIt
        8jiy4GEldc6Hqy9/c5cHLNE=
X-Google-Smtp-Source: ABdhPJwHHgempLOjLYO3WeFangagVHMZZ+2tGkMaV+AhYI69weddwKWkcpEVNLyv5KWqvoQRYdvuRg==
X-Received: by 2002:a17:90b:46d3:b0:1c6:ac97:71d with SMTP id jx19-20020a17090b46d300b001c6ac97071dmr2393864pjb.104.1648607446712;
        Tue, 29 Mar 2022 19:30:46 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.110])
        by smtp.gmail.com with ESMTPSA id m123-20020a633f81000000b0038256b22e74sm17686857pga.82.2022.03.29.19.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 19:30:46 -0700 (PDT)
Message-ID: <5d5a7f05-6c96-49db-6c3f-ae3ca713059a@gmail.com>
Date:   Wed, 30 Mar 2022 10:30:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs
 interface
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20220326144320.560939-1-hengqi.chen@gmail.com>
 <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, Andrii

On 2022/3/30 7:18 AM, Andrii Nakryiko wrote:
> On Sat, Mar 26, 2022 at 7:43 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> On some old kernels, kprobe auto-attach may fail when attach to symbols
>> like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
>> but don't allow attach to a symbol with '.' ([0]). Add a new option to
>> bpf_kprobe_opts to allow using the legacy kprobe attach directly.
>> This way, users can use bpf_program__attach_kprobe_opts in a dedicated
>> custom sec handler to handle such case.
>>
>>   [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
> 
> It's sad, but it makes sense. But, let's have a selftests that
> validates uses legacy option explicitly (e.g., in
> prog_tests/attach_probe.c). Also, let's fix this limitation in the

OK, will add a selftest to exercise the new option.

> kernel? It makes no sense to limit attaching to a proper kallsym
> symbol.

This limitation is lifted in newer kernel. Kernel v5.4 don't have this issue.

> 
>>  tools/lib/bpf/libbpf.c | 9 ++++++++-
>>  tools/lib/bpf/libbpf.h | 4 +++-
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
> 
> [...]

--
Hengqi
