Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18A6A1227
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 22:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBWVhy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 16:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBWVhx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 16:37:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139D527F
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:37:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec43so46877757edb.8
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAVWbTZhOahgbeoCVeCI3EwYDSoKydef03wO7/5d2JU=;
        b=EqmoPqeQbjoafMObEf2fTe/r9LkSJInAKED/5JXgQjuokPaocNnxoYXIZxa7+0u47G
         Iq8CMCkdmxpQmovC/3sbC8DBEkIaUWeV3emMIwGiCvdSW0vvXje7Y3y5mm7ukDXLAyFU
         AFnhyHNojJDRIrxezCs45dDWnqoYhhXvMGcPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAVWbTZhOahgbeoCVeCI3EwYDSoKydef03wO7/5d2JU=;
        b=M6ENBKISz3hJMvHWe9CxfzyxndJIi5Go0YK2ElSvzF/KRRA/+kJFzvx8RA2OEARDDR
         EvIiROVBAX2128D2DQW7GS2PHyKzmiLVIsdyB94/U6iJ4vIjcOt2/nhZFUezF2OrNNmk
         F/OD7sPqyLu/UUM2EPLNiMGTrLhuNKVw2j4iX71h9ok0pTBWJSLmOQxsKM6A5wJV3txP
         J6MGKD7sRTgCl0hBniF4uHt1lstKjBmosqbtAMCEhWjgGAFfQbbObmCYKNrSDmEO+RRs
         jar5PXnpezm9RzX/cuOOyGTzFX/FpXEH/dgG0Su/nSn/Mjfk8ko3qAXQPmI7Ah3gbP8J
         gBTQ==
X-Gm-Message-State: AO0yUKUXKWNwqY+UKU/tMYil6t7eUiJ8ZesajdgTOuEH8lnkReTpEllZ
        l0igbeZMPAomCLj2aZZtiaFgRp0YwgpqVrc8HRM=
X-Google-Smtp-Source: AK7set9Ruzrei4CpwjBphnTlNMlykQnAZY7nmXSuvm2UQxkEkfTNvV11cSI/erZ2ppYDJVOU7B55ag==
X-Received: by 2002:a17:906:ff45:b0:8b2:a42:5c3a with SMTP id zo5-20020a170906ff4500b008b20a425c3amr20237597ejb.70.1677188270280;
        Thu, 23 Feb 2023 13:37:50 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906038b00b008e17dc10decsm3426176eja.52.2023.02.23.13.37.48
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 13:37:49 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id ec43so46877447edb.8
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:37:48 -0800 (PST)
X-Received: by 2002:a17:906:b55:b0:8f1:4cc5:f14c with SMTP id
 v21-20020a1709060b5500b008f14cc5f14cmr933485ejg.0.1677188268445; Thu, 23 Feb
 2023 13:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20230221233808.1565509-1-kuba@kernel.org> <CAHk-=wjTMgB0=PQt8synf1MRTfetVXAWWLOibnMKvv1ETn_1uw@mail.gmail.com>
 <87pma02odj.fsf@kernel.org>
In-Reply-To: <87pma02odj.fsf@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2023 13:37:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOmTXMxm=ouCEKu0Agd5q-u3mrQ8=ne8412ciG2b-eJA@mail.gmail.com>
Message-ID: <CAHk-=wgOmTXMxm=ouCEKu0Agd5q-u3mrQ8=ne8412ciG2b-eJA@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.3
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 23, 2023 at 11:06 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> So that we can file a bug report about use of Wireless Extensions, what
> process is ThreadPoolForeg?

It is, as you already seem to have googled, just a sub-thread of google-chrome.

> The warning was applied over a month ago, I'm surprised nobody
> else has reported anything.

Honestly, I'm not sure how many people actually _run_ a real desktop
on linux-next. Getting merged into mainline really ends up resulting
in a lot more testing (outside of the test robots that don't tend to
really run desktop loads).

I see it on my desktop too, but I actually noticed it on my laptop
first, because it - once again - has started falling off the wireless
network regularly and I was looking if there were any messages about
it.

(That ath driver really is flaky, and I've never figured out what the
trigger is, it just sometimes goes dead and you have to disable and
re-enable wireless. But that's not a new problem, it's just a "that's
why I noticed")

                 Linus
