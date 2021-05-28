Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9F393B52
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 04:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE1CMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 22:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhE1CMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 22:12:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE895C061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 19:11:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i13so3042355edb.9
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhWqc7luBqopDDE1vxw6mdGkufVV95ZXdV0JPppZwnk=;
        b=Gwg5a1zG/eR0L3v7/o+zaP/WtuRNlxJa3rlm1JSA/6YX1xyJNfS5urHcqCNdcpYMF3
         AxbYMGqSA04CpMher0XD9WcwZSLMfBSDjiKdLmL9rLBwPi04BRJ9HFaRu9kXJimVWoX2
         /Tjb8hzMH1kmF+1m7P+uAHYmmLr77FUGbloUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhWqc7luBqopDDE1vxw6mdGkufVV95ZXdV0JPppZwnk=;
        b=rPV4pZMMxy9UGBr7FFtv5piWr3dOftaCyyJiD4ZEA6s3M4+5t1h6sJEJ3bo9vfMO3K
         bLJGfKJpN28sSL0jtIHXo1LFgVowvUrlcFeuAAAtkHbz+LU+KaDX2q8+HDhllmA2GKLl
         20VeoVf/FpUzaaQJOXdaRP3m6AKeDV2r5uaMidue1Pv54jzQZtxGPldsLlVEOj0m2vs0
         sW6TFyv1Q6VrcL35ETp5XuZgKVApnk6ZmdwboTOLBZy/Ajg6fWp1kpuqUqe2vqaVvNH2
         is9cG3wlqfOOZ2uSKb++87dCh/rmIuw4J5k1mdzObz47KNi2hsrO/UG9AMbD2EZdOg40
         KfDw==
X-Gm-Message-State: AOAM532LdHnBBKUfRHRS2sg0S3NaO4TrQfipEFd2keEJ0/EUxbBtTrKR
        0nohpxB2FXhtVghONB2J2A9WP09rYPaTrTk17ZqhCg==
X-Google-Smtp-Source: ABdhPJz4pJQ5QXKgcpzXmDdQ92DSXOhVJq83D6HQCvzpOtsFa0DBEyijkkibhDuEA2rt71FBLqFdYHSt4Y8c7VsANMA=
X-Received: by 2002:aa7:da94:: with SMTP id q20mr6250785eds.316.1622167867327;
 Thu, 27 May 2021 19:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210527201341.7128-1-zeffron@riotgames.com> <20210527201341.7128-4-zeffron@riotgames.com>
 <CAEf4Bzb=ECAtJAikaeSLomQCcwNC7JnwZxPc=j3=YnPjnfaycg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb=ECAtJAikaeSLomQCcwNC7JnwZxPc=j3=YnPjnfaycg@mail.gmail.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 27 May 2021 19:10:56 -0700
Message-ID: <CAC1LvL1JM4Wu43XU4aVHHheChtSQQmKRx7RaVBG5Kmkt-edbBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 6:28 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 27, 2021 at 1:14 PM Zvi Effron <zeffron@riotgames.com> wrote:
> >
> > +
> > +       /* Data past the end of the kernel's struct xdp_md must be 0 */
> > +       bad_ctx[sizeof(bad_ctx) - 1] = 1;
> > +       tattr.ctx_in = bad_ctx;
> > +       tattr.ctx_size_in = sizeof(bad_ctx);
> > +       err = bpf_prog_test_run_opts(prog_fd, &tattr);
> > +       ASSERT_ERR(err, "bpf_prog_test_run(test2)");
> > +       ASSERT_EQ(errno, 22, "test2-errno");
>
> by the time you are checking errno it might get overwritten. If you
> want to check errno, you have to remember it right after the function
> returns

Is it sufficient to simply make the errno ASSERT the first thing after
the function returns? Or would we still need to preserve it into a
local variable?
