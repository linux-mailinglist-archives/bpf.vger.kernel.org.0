Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2620BD40
	for <lists+bpf@lfdr.de>; Sat, 27 Jun 2020 01:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgFZXw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 19:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgFZXw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 19:52:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F73C03E979
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 16:52:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q198so10442982qka.2
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3pBBy3b56c2VhSpPO/3PoIdfj4UClSoJ4R/GNjaLno=;
        b=N6l1HbTUxI9V1VCqyINeOvzHp71Mzp8/QDPHLtcGmAw7dtnMxZYg4afKpac8ZfLEVV
         LbMF+4UPB7OPj8BWqaL5GAJCFzeaJIM33P2T1r8unxMM0l5IJ+OgmldBhBiO2HFlN6+3
         +GWWj7Ds8Nu8/mnCHgKg0dxyxMQe5Zmz0+Qx7euys/pT+humOLPIfmY+LorllrhN5L+/
         njU0MnZQ+ZG87RcZ3lh4FRpt3FWH2HQ3Iui8aPvIZLeifj+OjsgCG/O/tWHrDanTHFqp
         78mJwU1A8TNYmYwtyCKVr9RBwSaENos+jVu/Q3av49k2jvjNmCJ5GrH6sCoHGiyKOx5D
         TXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3pBBy3b56c2VhSpPO/3PoIdfj4UClSoJ4R/GNjaLno=;
        b=ge645u1XNIJz9I4DBW7erz8dwyyCqrn7s/bpkM25x6MyXSBzDwUgHFhsoTrYhLUtq/
         Aj62jue0rKAEKZ0RlHPAuVcmVqrBC3W03JJE5PdyI1Rht4DFcLRCFD9eyaVpVv2jG2yV
         ihZwU3eOAXSMtZpjIuH8lqc2tDrIIt6CUSXSyg6f6tR50c2K9ebYV3HOVNtZVR7LRl72
         rLe+kFDiUOAcmpPiRRZIVnozdUC9WSjcG2cvVgWti61mKBK3f6j8/z25+Nq3unLcVsnu
         JeYh5CsnUgBLW6ZJ4RyvZ4B+9VdyQsbm1emvIbpDX4a5FEvDo82z5CqpThtssun9tmFY
         YgWQ==
X-Gm-Message-State: AOAM5333X3zt227OuLj+zzg0olBq+fN8XSzBvRs20e/XyeXhH6pPq2cn
        lVQExbpuYeO+TKyaArgkgUSSaAFj6GztxVJRTS+rgA==
X-Google-Smtp-Source: ABdhPJxL1OVIRr7H6Ir9Q9b9e0XLzVJForUpIVjPUMEivNP6f9uumwqN34CtcAC2YALo+1ngttoFy6vo2hy8dvLZgcQ=
X-Received: by 2002:a05:620a:14b6:: with SMTP id x22mr5021849qkj.448.1593215547712;
 Fri, 26 Jun 2020 16:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200626165231.672001-1-sdf@google.com> <20200626165231.672001-2-sdf@google.com>
 <CAEf4BzYWUZhgK-XpOxV76bzk1pnVzKgyu3AtCRtdVbW2ix4D7A@mail.gmail.com>
In-Reply-To: <CAEf4BzYWUZhgK-XpOxV76bzk1pnVzKgyu3AtCRtdVbW2ix4D7A@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 26 Jun 2020 16:52:16 -0700
Message-ID: <CAKH8qBtaEWJPFWGqXuZzz8ymOCxwK1NWdrstvj7g2Z3z2khh_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] libbpf: add support for BPF_CGROUP_INET_SOCK_RELEASE
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 26, 2020 at 3:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 10:22 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Add auto-detection for the cgroup/sock_release programs.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
>
> Left a bunch of comments on v1 of this series, oops.
No worries, there is not much changed since then, thanks for the review!

> But where is the cover letter? Did I miss it?
I didn't feel like it deserves a cover letter. The main patch is
small, most of the changes are in libbpf/selftests and I mostly split
them to make it easier for you to push to github (is it still a
requirement or I shouldn't worry about it anymore?).
