Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81EE1E623B
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbgE1N3c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390348AbgE1N31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 09:29:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F9C05BD1E
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 06:29:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so32028225ejb.10
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ZcviNXi4IlM0DZCt4umF+AWkyhGMOdEPtpbXagFQ1ks=;
        b=wfX/uw6M/g6b/niXu+B/K9cdkggd/kahZZpLzjQqD19btylko4/zkN/qfnex0hiv+7
         o7VjHm+qS/2YHYvk79vKyaZSG/END5oZVQ5Ieh3Nt/FipKd/A3txxe389uOoMvFYTLgU
         WODAhzT5qARPR2/h7jhUqyDF/Wya2wIjGOM8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZcviNXi4IlM0DZCt4umF+AWkyhGMOdEPtpbXagFQ1ks=;
        b=IiThudkXaQ4jSZ8go+VsZJQdJ2O061Y1WAZjAMxfwXHMHFWB6DPHqMPBbK72/IiT8e
         2nAi++wDMETDY1P3oOXSF6jgsZha0046Kjdv2+u/HiMZM8wLyfviUdrEUZ/cE26NDHjE
         YkLl4NRaULBZ/jBasMk1y5Lb8ZNycwsYCR+Kd77ckpGNjxTxVS+XTEp1Z95ddvn9Ozgl
         vjkt5MUItVONPOGRXgkMAa6K4kwMQhniu8Ecc8UU+S8w7iprUygAcTfNrNV2Eacid6kK
         tcC4SCT+tDuYBEymgRwtYaOGZ63PvlmCrrIJOdRVdeG/H4E1IYfjha3TNb9sf80cWU96
         b0Yw==
X-Gm-Message-State: AOAM531hp45/metNWTD3BBm2XRn3CdHJFjn8fUlhJ1FEoOQ5gYRgUCou
        lVA+9kphyD6FoakCI3ZZ/Dxb3w==
X-Google-Smtp-Source: ABdhPJzE44qW3v/D6QeYBp7AlHo9HNoMaTPEFE94foxLVZYRjkxnkX85O4aZVDydAxdf9mgI4DCl6w==
X-Received: by 2002:a17:906:8514:: with SMTP id i20mr2858376ejx.298.1590672552173;
        Thu, 28 May 2020 06:29:12 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id o8sm1336408ejj.121.2020.05.28.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:29:11 -0700 (PDT)
References: <20200527170840.1768178-1-jakub@cloudflare.com> <20200527170840.1768178-9-jakub@cloudflare.com> <CAEf4BzZEDArh8kL-mredwYb=GAOXEue=rGAjOaM0qGjj5RG6RA@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Add tests for attaching bpf_link to netns
In-reply-to: <CAEf4BzZEDArh8kL-mredwYb=GAOXEue=rGAjOaM0qGjj5RG6RA@mail.gmail.com>
Date:   Thu, 28 May 2020 15:29:10 +0200
Message-ID: <87lflc2no9.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 08:08 AM CEST, Andrii Nakryiko wrote:
> On Wed, May 27, 2020 at 12:16 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Extend the existing test case for flow dissector attaching to cover:
>>
>>  - link creation,
>>  - link updates,
>>  - link info querying,
>>  - mixing links with direct prog attachment.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>
> You are not using bpf_program__attach_netns() at all. Would be nice to
> actually use higher-level API here...

That's true. I didn't exercise the high-level API. I can cover that.

>
> Also... what's up with people using CHECK_FAIL + perror instead of
> CHECK? Is CHECK being avoided for some reason or people are just not
> aware of it (which is strange, because CHECK was there before
> CHECK_FAIL)?

I can only speak for myself. Funnily enough I think I've switched from
CHECK to CHECK_FAIL when I touched on BPF flow dissector last time [0].

CHECK needs and "external" duration variable to be in scope, and so it
was suggested to me that if I'm not measuring run-time with
bpf_prog_test_run, CHECK_FAIL might be a better choice.

CHECK is also perhaps too verbose because it emits a log message on
success (to report duration, I assume).

You have a better overview of all the tests than me, but if I had the
cycles I'd see if renaming CHECK to something more specific, for those
test that actually track prog run time, can work.

-jkbs


[0] https://lore.kernel.org/bpf/87imov1y5m.fsf@cloudflare.com/



>
>>  .../bpf/prog_tests/flow_dissector_reattach.c  | 500 +++++++++++++++++-
>>  1 file changed, 471 insertions(+), 29 deletions(-)
>>
>
> [...]
