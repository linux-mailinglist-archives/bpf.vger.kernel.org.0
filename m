Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC34ECD39
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiC3TaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 15:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350657AbiC3TaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 15:30:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527982D1F1
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 12:28:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so37702977lfb.0
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVig4TMXo4XXW+YYHFnVZTCO1uSpbm2NwpusO0nWM20=;
        b=eoAarFYSq60lhcO0YE7U6h8l1TAYLsyl0mwxA7kyk0Yf1FEPtAz0UDJNugw0CuGySz
         QC8AA8LwEOz7YnhM5H8EYLCMgvcySHe66L0/u6GiqQheodoMrPENraETAYN9xc6fW/5d
         ftWAS0w3hXHYM0Ao8IqqpFHIl/DI2GyDW9+nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVig4TMXo4XXW+YYHFnVZTCO1uSpbm2NwpusO0nWM20=;
        b=JS+ZvrrII7JDl7Bh3HYm5LFMbcF23n3DXZIE1E6zCZR3Mfj/mplI1yh5CWLETtWdLP
         iGhhkyHh0PCh8yBkkmG1/+FJzoFXO4w/iH41q9vC9BHemoG3iFR0lHlIVupxqCNEdO2m
         98yjWfJ6sH9IaPL+T3UJstwex/hGmLKfTt07ye2pqdSbD39HrYz+dhIpMHc9biVjI1fr
         KNyOpdkWSnb09QGbJEKbtGzKTABKscf0KqwIDkM/jecyS3J6tqTy06cvI2ScbbaGFt2P
         s0YlNrJBAuowH+f9lwotNFY2s+zl1khJ/fsWmBcZasv3lG0NFUzdEN6ZCe79oRh7x325
         6P6w==
X-Gm-Message-State: AOAM532NCqkHDuf4KlYYbvPHKb8QAOKRTLs3l8gnu8oWhmsvdDweBS/p
        wT/Zixvqbzj2CU67QMmj0ZHJDB0UAMivV1V3
X-Google-Smtp-Source: ABdhPJxuleL5udBqt/l6AjvgkOGoWUNlgOZOsp+OpFut6C9RLtnMoRuk6zttt6+7XZEo2ddhOUYIcA==
X-Received: by 2002:a05:6512:31a:b0:44a:a4c6:871e with SMTP id t26-20020a056512031a00b0044aa4c6871emr7881194lfp.470.1648668509277;
        Wed, 30 Mar 2022 12:28:29 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o15-20020a2e730f000000b00247eae1ebe7sm2489546ljc.75.2022.03.30.12.28.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 12:28:28 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id p10so31709684lfa.12
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 12:28:27 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr8015065lfb.435.1648668507455; Wed, 30
 Mar 2022 12:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220329222514.51af6c07@gandalf.local.home> <1546405229.199729.1648659253425.JavaMail.zimbra@efficios.com>
In-Reply-To: <1546405229.199729.1648659253425.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 12:28:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ0RccFsUhgKpdh130ydsY57bqaCGRQS7w3-ckgHP=OA@mail.gmail.com>
Message-ID: <CAHk-=wgZ0RccFsUhgKpdh130ydsY57bqaCGRQS7w3-ckgHP=OA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Set user_events to BROKEN
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30, 2022 at 9:54 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If we are not ready to commit to an ABI, perhaps it would be safer to ensure
> that include/uapi/linux/user_events.h is not installed with the uapi headers
> until it's ready.

I don't th8ink the uapi matters if the code then cannot be used.
There's no regression in that.

That said, if we leave the code in the kernel source tree, I feel like
we should probably at least compile-test it.

So maybe it should be marked as

        depends on BROKEN || COMPILE_TEST

instead?

             Linus
