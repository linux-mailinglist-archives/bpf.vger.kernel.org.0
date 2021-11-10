Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5D44C5B7
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhKJRI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 12:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhKJRI1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 12:08:27 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84BC061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 09:05:39 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 1so6635219ljv.2
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqzKE5VrumOYjBZRF/0KDu9fqmayCuHmlrDhbS9LDIA=;
        b=LaD49Db1ONpmpv5DnlCP/A+5MKdYbvbBzS1omUEko1WaTvV0v+284QMnraFzzsegEH
         E73JJYZ7qM/LgrxMAyNQij8Q9PdIfKHFwzEmrTQvuGys9oJh6VH85OkdzQntMpen2q33
         mGCQdw/1YZmDSFx9zTr+ruV0aCHYlhLPDo09U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqzKE5VrumOYjBZRF/0KDu9fqmayCuHmlrDhbS9LDIA=;
        b=CR+0Fv9onf0cxcgOde/38iuFVAhEEbkKGc3Dw1pSNRKFd8sbgCdi9YMGuT/RINLqEu
         QhX6KYihsszpIOntGswSlqQYZ0RfqdTF1kP1RLy+RMajFt0SC5dv5gEdU8U9Ug1UDXOo
         PPIrGsbktdVcOFDuce5rNfP8H/zS+9hU4rBZpBXsa+4r+nh+t5jmTtDXk92HxP4zJvPH
         c6OmNw1AIcORVf4dOpwnAUL8iH6lAnrnbcjLuDHIv/ppo2sZj5TjnO8by22VtqcGHk2J
         S/wIVNJvMBZsEQzCaMPWQiKL+Cn7Y/YtjnZUwf+zLULpfD9ojgplViTc/uocyFt9Ecfa
         tqMA==
X-Gm-Message-State: AOAM533rM0rR5oi5PdpLO74nVNHTNOPMF8xxKut6C9wnPsyPTo3bdhX0
        UMwdvkCIsfhGff//zGxxVAJ9rCGMXCV7fvB3c0qlkw==
X-Google-Smtp-Source: ABdhPJz9GknRVtWbNK5reBVqYogR6Wg5uk6NF7TiSJJM3ZETzsPZlkbrQrYl4hqfz2VwdWAO7qm1hAeyHQ5PKKOviw4=
X-Received: by 2002:a05:651c:160a:: with SMTP id f10mr513334ljq.212.1636563937663;
 Wed, 10 Nov 2021 09:05:37 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
 <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
 <20211105194952.xve6u6lgh2oy46dy@ast-mbp.dhcp.thefacebook.com>
 <CACAyw99KGdTAz+G3aU8G3eqC926YYpgD57q-A+NFNVqqiJPY3g@mail.gmail.com>
 <20211110042530.6ye65mpspre7au5f@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9-s0ahY8m7WtMd1OK=ZF9w5gS9gktQ6S8Kak2pznXgw0w@mail.gmail.com> <20211110165044.kkjqrjpmnz7hkmq3@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211110165044.kkjqrjpmnz7hkmq3@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 10 Nov 2021 17:05:26 +0000
Message-ID: <CACAyw98qviPmc1rWCkm8WXDwFN-JLKzXeUTAz27OVLK_9B7DQA@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Nov 2021 at 16:50, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 11:41:09AM +0000, Lorenz Bauer wrote:
> >
> > uid changes on every invocation, and therefore regsafe() returns false?
>
> That's correct.
> Could you please try the following fix.
> I think it's less risky and more accurate than what I've tried before.

It works!

processed 295498 insns (limit 1000000) max_states_per_insn 29
total_states 14527 peak_states 1322 mark_read 53

Thanks for looking into this without a reproducer!

Lorenz


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
