Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C6394716
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhE1ShU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 14:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhE1ShT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 14:37:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E884C061574
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 11:35:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h24so2794927ejy.2
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4phGkqZLrTLpTp6AX2enjIvUtsj3fvnR6PgYnPVTb0=;
        b=XBkZ9CGQi9H3QWI+tVUEwrOZ4XSlxodsNqg/e3YvvtQ8rjwJTPtoUMKCBxcn4GUOZV
         0GZ+R/fC3IJIcQ9qiHFOrYdsVv/gNdqDapvgO/P707CCwLFiBly1Tc5CN3QHi9uqjCF9
         pr1b59je/sFjLjkIHoW5zL2AAcQiTyiC5vnyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4phGkqZLrTLpTp6AX2enjIvUtsj3fvnR6PgYnPVTb0=;
        b=KMsO/vlTiA/m4osgJ6Bk11rgREN8OKgZK83/bYAN8vbWLNHi1YhEVIx/6Ot1l1uRB1
         fFR+4NfPHxClcc9VUZrPEp0PPQr+uhkaPz2Diyb2Vf4J9islEmxPwV5a0E1/g+AZsRG5
         e5i2gQF665MU4FjmEeGBlyEQV3AvrwgFf4CjRo1fTEQekEuCZ6vwVLeWr/XxVaSrk2iZ
         2q5DrqtO12Ynq1K9vk4c2uddWv4OwvDOR3HgSEOCicP4erDFT9hx0/xRwDwcyASbX3Ps
         1PMGH+6hV3loQdx1sC5zbCSXGNJgooFmxTmNLo3Q6Fi+ZcZgewAKhBURohn8g+gw0za1
         0x3Q==
X-Gm-Message-State: AOAM533xyNbVvQPg78RjY2GZmdwXckCLisY8pBPzIa48CfMPsOVLyqx9
        V5MtNH9rUMHiZNHI7O1aTbjxt5+Qww8USTItDDUMNA==
X-Google-Smtp-Source: ABdhPJytf53oNyCn37Vpebb5ATs6HUvuk+jrF8MJj0IIWEBLGWWD5pubK24EeloScSm30RK8YLlicfw/twOtXFfCIKs=
X-Received: by 2002:a17:906:3785:: with SMTP id n5mr10487401ejc.127.1622226943091;
 Fri, 28 May 2021 11:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210527201341.7128-1-zeffron@riotgames.com> <20210527201341.7128-4-zeffron@riotgames.com>
 <CAEf4Bzb=ECAtJAikaeSLomQCcwNC7JnwZxPc=j3=YnPjnfaycg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb=ECAtJAikaeSLomQCcwNC7JnwZxPc=j3=YnPjnfaycg@mail.gmail.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Fri, 28 May 2021 11:35:31 -0700
Message-ID: <CAC1LvL1LWQB=LQc+dYMdjusJouv+oFOB83WNF+SzrOedBygEYw@mail.gmail.com>
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
>

I just noticed that the CHECK macro (which the ASSERT macro wraps)
already saves/restores errno. Is this not behavior that can be relied
on?
