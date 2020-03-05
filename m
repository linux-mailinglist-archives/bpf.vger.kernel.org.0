Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3C17B149
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 23:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEWPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 17:15:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41849 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEWPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 17:15:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so85617pgm.8
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 14:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YXtXVGnw/rdUkMdchaUKYh8i7+iFm8TZLMeA14iPaVQ=;
        b=Dl+jILlq4M0aF+BrFxwMGxatMlyiWGg0HPJnYs1SA0OFyR2Dc5RUGeqYWYMLNuuuTR
         feLknUY6Yjnkz+f713Qj5opgom7Pr6S3gtKxPQoAJTSWdLkotm/5A5khVx499cXSaQaY
         KD7RLvtjB94F6Wbiif2XNWX+cvlgfSscFpdGUNZoChl2/OOMw1SzBRtwuSpLBlW23B/m
         ggZqpBzQEiaBbOz9aZR/8tpI1r3G+qUsJ+lW1Qe+AhKs0DsUSqYgBAWMTluqhHvsSyP5
         KnboNBG+PbclJXna5uvynysjU7x1ZmdtdVhI3XSh0ho18I3EXUO1hqvAx3aNah31qMR0
         PZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YXtXVGnw/rdUkMdchaUKYh8i7+iFm8TZLMeA14iPaVQ=;
        b=AI9B3mN5+bdW4KvOlQ1PNR0+4ruUF60Lxa5/AzlpmZL9IWIOaaGiCBDAtkAlvLQDMx
         tOMLX82JXZcVpiIEwV3RGJ+yn6J+kYE434o2aXRqHGtn6M3AXdF46fEKTKzZsa98LfXN
         ZVMbc8RHZk7wSnl9Ue3QaS6NhW8nVr0gLWyTEU/0tBt90+zaAzWHNU/ys5DyLUFnTWsy
         iHrmYoi6knL0oTnlX58yB+e62zdH1TNckJUCyQgePuBtlEGXNBubaCWt/StyLgIfyT6f
         /PijEBaxvALAN4fSbb2spJN+3lNyCsuAZr3WWajzrx0TguwdBzq821hGkQNtOjYmRv4F
         7/Ow==
X-Gm-Message-State: ANhLgQ0l4abkSMzSbeYUCKp7jZ3O/5dL1nJR0nG80U077+3aaCC8wJVC
        qNtxGES0KVyGlw5qvatWvw5exMIb
X-Google-Smtp-Source: ADFU+vv7DwgFKpQ/FTFNyb6Yjm+lkYLVB1AlukNqVopB1cBsW091BQcPVScCvB/xhnlytrwddbnuig==
X-Received: by 2002:aa7:8d82:: with SMTP id i2mr476730pfr.179.1583446501663;
        Thu, 05 Mar 2020 14:15:01 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:f0e7])
        by smtp.gmail.com with ESMTPSA id w30sm1612606pfj.33.2020.03.05.14.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:15:00 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:14:58 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix deadlock with rq_lock in
 bpf_send_signal()
Message-ID: <20200305221456.mh72lwvp55l32rfm@ast-mbp>
References: <20200304191104.2796444-1-yhs@fb.com>
 <20200304191104.2796501-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304191104.2796501-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 11:11:04AM -0800, Yonghong Song wrote:
>  
> -	if (in_nmi()) {
> +	/* Delay sending signal if irq is disabled. Otherwise,
> +	 * we risk deadlock with rq_lock.
> +	 */

This comment read in isolation is confusing. It's not clear how irq
has anything to do with rq_lock and why deadlock is possible.
But commit log has very nice summary,
so I've just deleted that comment and applied to bpf tree.
The patch 2 did reproduce the lockdep splat for me. Which was great.
Running test_progs few times before and after I noticed that older
send_signal tests are flaky and fail from time to time.
It's unrelated to this patch, but please take a look.
