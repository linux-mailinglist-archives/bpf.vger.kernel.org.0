Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235E687371
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 03:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjBBC50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 21:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBBC50 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 21:57:26 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C574C1F;
        Wed,  1 Feb 2023 18:57:25 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id q8so353885wmo.5;
        Wed, 01 Feb 2023 18:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rugLScTZxU9zmXkUzNWTJs6TN0JUzK3kK3L270nqD3E=;
        b=e2c6MtKd0P3rj/MFKrGiRbNlfTte9N/W51jFfmk9vqzGsvcw/d6ptbUcqbvvuGNlIW
         O7+yfAhHMEpPUEFYksLKzGFZ6v4W92ClCGvfsfcTpFTzxqqzJVKlKx/5B2zxlSL4nzSG
         PUtIYa7SFiWZIy61sY+BoK9+UC9DbTpalQvJHqiP+RXXDQ0KTznDDX1R4Y1A5LKoSvye
         DJIyIaPqQTLFIOgjpyrMRsRCnGLrUC09hUzl6JOdyHa3ozdY5PT+g7urNVx9HPbftGDM
         iew2KbDGNK1hfiqijXIsehKdFGZJsM7NHrk7mz6RkpGZPeX3bDJlEhRDReROQMydkjwJ
         om1w==
X-Gm-Message-State: AO0yUKVoV8FRLTrF4J4Er7c+lp53abLizpJugM3tIwiYZgvpGK5JHiw2
        qepFJWq4bWP95uVapWUMyJVRbT2f0K2Zei52yrs=
X-Google-Smtp-Source: AK7set+4x3mLRO43hy8wdFiWggWvzTjoPwHJSzd/geddc5DTP3+z7hpYiCPdYgiYEaDiBuBDzl5ZYaFfChLSKCLhv1E=
X-Received: by 2002:a05:600c:3150:b0:3dc:5844:6394 with SMTP id
 h16-20020a05600c315000b003dc58446394mr82443wmo.131.1675306643749; Wed, 01 Feb
 2023 18:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20230105203231.1598936-1-namhyung@kernel.org> <CAM9d7cgJFZhSCnFcYU-5veSpJEyR3=OF_7KBtZLNwq2W2hYd-w@mail.gmail.com>
 <Y9sTITGxhSv68uQE@kernel.org>
In-Reply-To: <Y9sTITGxhSv68uQE@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Feb 2023 18:57:12 -0800
Message-ID: <CAM9d7ch1Yz1Y=7p070Xbw=+w2aMK=kvnBYPPecxZWOdN-bkLew@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf lock contention: Add -o/--lock-owner option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 1, 2023 at 5:34 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Jan 24, 2023 at 09:59:27AM -0800, Namhyung Kim escreveu:
> > Hello,
> >
> > Any feedback on this?
>
> Can you please refresh this one? I'll shortly push what I have to
> tmp.perf/core and initiate the container build tests.

I have some other updates.  I'll post v2 later.
Please feel free to go ahead.

Thanks,
Namhyung
