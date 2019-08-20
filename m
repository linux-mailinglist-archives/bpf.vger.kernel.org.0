Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB57954A7
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 04:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfHTCwe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 22:52:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34577 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTCwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 22:52:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so3647179ljh.1;
        Mon, 19 Aug 2019 19:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4qA1veTube3oLgLKTG5M8ZlwUMBy06cVai77IRsX/o=;
        b=qPOSqoLFJCtPtQbvLXjKxtIFSMBqIgStUTPnBzJdGSRUPKN2ZKH8txa3zAQCJiTh9Q
         J2yqHQ0NF5zo50LlHqY8me/nTVnoP5gMB47/AdOE3lmoG/FV1wuJHmZy6MJR2zYjmlhi
         8tBtGdnJynY3/rbPUqXrqOtYjEIEHOKtJArqsWu8CGef7wFrcWCG4ovTFnhn1xvjj/A/
         /Npyglhub91J1IIeT7SbPLT9K9Zu0Ya6/9nD83RKI5AhBJKxbuK3LcECPKbR+kMhOA8Y
         3o2NHAx1STZYdN5gF8OZLm/ElnfJWrhGIrJCvTZuMQMxNAMlSoffvc6qFkm/W7v6jp2v
         h6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4qA1veTube3oLgLKTG5M8ZlwUMBy06cVai77IRsX/o=;
        b=MgpXBaR9ByR+4T8e+HBdBRzo/fDTVMzrs6nLvOtkfKcyj4jBbvxImk+kunt8fzR0p/
         E+GOogZWgAwFxicub3CjvkwJMkyYYUButZC3dQUKQiI0+awa9Xw0131PwBesvjcAjXPR
         Z7UBqMrolpzHJKn1ulF5UXFb8scuRfHMAPIBDVJBdP24O5rDYUJPN9BHPOVl3Heu8cjC
         npXuD63ionXc3GrThl28WuYm+Q/jL0RsR4ggiKoWIzFXCViRayRMe6qu2HeRQ6YWad6S
         1/FgplhEHXqZ5ByS4H1gY5UMDE3iUHofX9teye0TPeM0CdH7MRnHDckWiRVNlc5dwjqK
         HGoQ==
X-Gm-Message-State: APjAAAVTqkKzCyhIaoRHD8gMIerEmqzJaLd1fNFAvTcPx7StKoE0F279
        zXq6KqUN50pj/gcY4IBVejeAR9cVclNOAvBprBQ=
X-Google-Smtp-Source: APXvYqyKWIbPnFOVq2bTeSupJmRF4VcMocMRVmMmGpLElsZd4RepxVBaeFTCDXZ0/qi2IWTAg4quYrJDDYKQ9t0Kcaw=
X-Received: by 2002:a2e:9e81:: with SMTP id f1mr14466313ljk.29.1566269552108;
 Mon, 19 Aug 2019 19:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+RKuJB5G+-1fjsE2xLp8CxJMmidd6Qobi_4dXQOWjrow@mail.gmail.com>
 <BWE3UBBDYMGD.26324NSRV46UF@dlxu-fedora-R90QNFJV>
In-Reply-To: <BWE3UBBDYMGD.26324NSRV46UF@dlxu-fedora-R90QNFJV>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 19 Aug 2019 19:52:20 -0700
Message-ID: <CAADnVQLqp1zLHMmoQN=Y8AM2bBsUkQXwEZ6y+kdNRwYCjDap5w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
 ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 19, 2019 at 7:34 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Ah yes, sorry. Will add that.

Also please fix build errors.
It looks like buildbot is not happy about few things.
