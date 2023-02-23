Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7E6A0EA1
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 18:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBWRWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 12:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBWRWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 12:22:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224555191A
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 09:21:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d30so3577272eda.4
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TBR1Hpao5NaMspTRHD1lsqDclj6PdB0M/zqkOByY88Y=;
        b=aGXtyooH2QtMysuzpHxM6wkLHNoBaCSVaRsdZy4hnHNUXZg6GQAsg6EXKis5mK8mD3
         4y3LsMsCun10BudugEuxQZLLsHA44JVXf1yHYdurnnNxvFqw1jYKiqt3kg1ctAxSrjL9
         eR5ARjHglQBu+lzI9Zhs3UvX1muEo3kUQKg50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBR1Hpao5NaMspTRHD1lsqDclj6PdB0M/zqkOByY88Y=;
        b=AEQAC62C2WHP5FJflnNI5intbxjDFNAE6XNz4uNE+oKQg5Jyf39ICyPRpLSc9ok/KO
         2AlZZ2I4jCIyQfB/OrabJvuvh2B4Ct6zqjt5Js3AJIy7YOah+nNeoHOmAQ8NjrSJvnCe
         Oi5Nt5en4X8tlc0w5E6efw216D24OHCGT8TkubM+H0paAUn8ej/RCdmhQTo2CCZwGeCf
         0PJexzZW+3qonuztR8X9z2iS5pWdC7lbDLfmVx0homkaydLpDX4IbIDamhpwS8RS0AtH
         1drcCcINPRq2MMu0YhzTblp6mtWb41t/h4kyRYe//fDTvrN6FcBvbWsabpcLxj1f90zC
         Z/7A==
X-Gm-Message-State: AO0yUKXTcqmEklxG228/L5Z1peiOvYtgCtabhK+5AOOqJfWens/gPSkg
        5g62LyS1HWzNqMxZP1iZWt9pN28SDFYzDeJqm4dR8w==
X-Google-Smtp-Source: AK7set8S2MFXyqaUGCOuK3Ynfi2y8DgmrHV3HqrOIrratToZScSKVASsfT6i8lpUbbHrXyh43WpTDw==
X-Received: by 2002:a17:907:7794:b0:8a9:f870:d259 with SMTP id ky20-20020a170907779400b008a9f870d259mr18944401ejc.48.1677172916081;
        Thu, 23 Feb 2023 09:21:56 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id r14-20020a1709067fce00b008dffda52d71sm3460386ejs.124.2023.02.23.09.21.55
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 09:21:55 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id i34so19482645eda.7
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 09:21:55 -0800 (PST)
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr9185882ejc.0.1677172915084; Thu, 23
 Feb 2023 09:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20230221233808.1565509-1-kuba@kernel.org>
In-Reply-To: <20230221233808.1565509-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2023 09:21:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTMgB0=PQt8synf1MRTfetVXAWWLOibnMKvv1ETn_1uw@mail.gmail.com>
Message-ID: <CAHk-=wjTMgB0=PQt8synf1MRTfetVXAWWLOibnMKvv1ETn_1uw@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.3
To:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        bpf@vger.kernel.org, ast@kernel.org
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

On Tue, Feb 21, 2023 at 3:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
--
> Networking changes for 6.3.

Hmm. I just noticed another issue on my laptop: I get an absolute *flood* of

  warning: 'ThreadPoolForeg' uses wireless extensions that are
deprecated for modern drivers: use nl80211

introduced in commit dc09766c755c ("wifi: wireless: warn on most
wireless extension usage").

This is on my xps13 with Atheros QCA6174 wireless ("Killer 1435
Wireless-AC", PCI ID 168c:003e, subsystem 1a56:143a).

And yes, it uses 'pr_warn_ratelimited()', but the ratelimiting is a
joke. That means that I "only" get five warnings a second, and then it
pauses for a minute or two until it does it again.

So that warning needs to go away - it flushed the whole kernel printk
buffer in no time.

                  Linus
