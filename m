Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD11A5FD36E
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJMDHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 23:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJMDHi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 23:07:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E0120068
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 20:07:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q7so790179ljp.3
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=teT7jLlxzN4i1te1sVTA7XA7K2s0Bo1np+U79OkEZds=;
        b=a3jtqMpOOhZuTY4QC3PGfEN5pY3L8lvp+y4QJXVoPWwdAg8nWFqubN5gCcMHFj+U7u
         /U4/C7JlWhypXP/uFWVDxoGFkLis1AlnRMQNo5p+C+O4QKiHfuFsVyXl53WoeMk3CGhF
         uCpfIFnlJVrOOjBQR0ivHRe/u0a7GAzHhoKjGgNytEaApQ/A8hY5onwOQzz/UtRpbFXz
         0FmMLTIfxjXfvrXRb8h5L3UGqyFrcybPMzsZh89h1xW+/21xBctI88STKhaxCXvRMsiK
         x9N6lWATu3oWk7M3YRoTlw+BQ7bpOx8gzprxBSCVuno6agoDAoyG5IiyXH5Ag4tXUVX9
         /CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teT7jLlxzN4i1te1sVTA7XA7K2s0Bo1np+U79OkEZds=;
        b=sZT6EiIXkDATDgsLI1ZSzXHXwWWh4jkbpEx+/ehUw8Yn4zMUTLCEOy26kEZVeG7BYx
         RbixsYyeiolXH/ZtcpBJ6oT3YlORpnv8VS98xqOSfqzOehXqBmC0af7rLz/pvhhiaxyT
         cGDRt0eUXHIGCCRZnh8tf93DeQLhzBvIBgoKXzH1EraZx4ay8K1OS+j5DrZ0s+PrHB8v
         khIMbMynp89ASM4OFvH8x+9m697XNcqggeymOUI+nKmCD58xRIrt47RTAG0/CxwPnDWm
         q0TNgHEZNw8mKd5G1jTdU+0qXMiUfPEuVgMs2+fJwW1mp2PC0HWn4GElmTY3oobGQnZI
         xA+w==
X-Gm-Message-State: ACrzQf28e7VKglJC2+erEt+q+zP7ZD9XYm4mev0/mW6L2Em+fk3w9ifk
        OpYaC1PeiDdia7Gy+W0CLr6IXtcFfLJtcMfhqmbS
X-Google-Smtp-Source: AMsMyM7s0RTDvuj/pVbsqF6Qfr5bg4a5tCwlZtc9rgBRuqFwjYDX/FMk9gCwQg3cQJyt4Yzkaw/Mfm9BdH75puFTuQY=
X-Received: by 2002:a2e:9e50:0:b0:261:e3fd:cdc5 with SMTP id
 g16-20020a2e9e50000000b00261e3fdcdc5mr11728293ljk.56.1665630455163; Wed, 12
 Oct 2022 20:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
In-Reply-To: <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 12 Oct 2022 20:07:23 -0700
Message-ID: <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> So I think it reasonable to say its bounded by approximately  2 *
> NSEC_PER_SEC/HZ +/- 11%.

Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11

thanks
-john
