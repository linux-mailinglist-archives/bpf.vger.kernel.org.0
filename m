Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44335FA24
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351257AbhDNR76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhDNR76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 13:59:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E13AC061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 10:59:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a1so24259164ljp.2
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7HWJZfAqr4Movt5xn3m8CynE2j6l85Xy4oR/SEiJtk=;
        b=IVbIWvqaFaSytfTGY62MUYs/YMSRgyFy0/nIjTmM/8YgInq8yXXb+zC1QhG5pTEBS7
         GCtHZZZBCvAPjiS4ygRdlrJ0crDFycxLGAiru+HfDAgDO6QEZgCHUN3k2l+0/pUbvoGu
         Upm3uU81sethFLJFIjsQC5oSkI094jvhJ0iXTO0qTiYSnz3G33AiQK28/m245E9GE3gR
         fPnZL6y5olAX1nqKjqLAr8PZK5KfmI5O96Jku/4kN0WfnaprSwGL2K9Fmdr6iQeQeR6f
         hbqvIicldBKimLiM8SaEhhljmRjQ323T87kVW6icMH3ObCUajJS6E40sDXqJyCcCdccf
         kHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7HWJZfAqr4Movt5xn3m8CynE2j6l85Xy4oR/SEiJtk=;
        b=sWN4DbLalwwz0+6JkohX/NUj/Yppp4kIfaxl3LgeE6mJZSuwvbsD8qVuKJf0OpMPju
         vSamaSSnWIwtB+3TC1RXmHYgnYIEQIUsI82Phv7zmN1fX9QK1pWmFLDBC+CXEC7VA56W
         JZXwC9Yjt+CxLnBhAp2dft7/YmQh0B9FnMgShwORRSmHVrhttHPE4sUjOkwX4xSNtLTe
         /QWdeMqaxRQNOk8AnOSh6/PshV1zPi1guFzX+UweGU8NeVtSUKjaBkF/i18aF3TFxOT/
         hwHaM2FHTrAZzgWekzLWOrcGvCaTvtBV+KDuov032PYPEbQoKp3J4FbLV35tf6mCrizc
         gu6w==
X-Gm-Message-State: AOAM5336Skxwt5njPlLakUuyIUAeIPyj+7q78ft3FW0YvDLKnlcJYP2+
        oGYYY0pKePVb8ttmM+Wifv+McQ8S1DMZvthgtcw=
X-Google-Smtp-Source: ABdhPJyuQCSYELaOFYWQicEr5qSF2ZPK0mdmAUMb53smDwXQKUZdtryz+0i2rADts6MJlLdOy6H1dnqJYfrl8ly55Pc=
X-Received: by 2002:a2e:894d:: with SMTP id b13mr16327851ljk.486.1618423175177;
 Wed, 14 Apr 2021 10:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <87blaozi20.fsf@toke.dk> <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk> <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com> <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 14 Apr 2021 10:59:23 -0700
Message-ID: <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
Subject: Re: Selftest failures related to kern_sync_rcu()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > > > >                 if (num_online_cpus() > 1)
> > > > >                         synchronize_rcu();
>
> In CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y kernels, this
> synchronize_rcu() will be a no-op anyway due to there only being the
> one CPU.  Or are these failures all happening in CONFIG_PREEMPT=y kernels,
> and in tests where preemption could result in the observed failures?
>
> Could you please send your .config file, or at least the relevant portions
> of it?

That's my understanding as well. I assumed Toke has preempt=y.
Otherwise the whole thing needs to be root caused properly.
