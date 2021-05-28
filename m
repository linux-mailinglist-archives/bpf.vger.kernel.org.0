Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B239471C
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhE1SmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhE1SmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 14:42:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE901C061574
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 11:40:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l3so6787651ejc.4
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xw3/W56vtGC/3ZP3MJ3+699gpP6eu5MHaBKMSOZ1gO8=;
        b=Oht6hWXfnp9/GGZZ9FF55zv+gFOVJjdYixR7hVXCAIZK1dHlua2sWd4lKRC5lhq0f9
         E6vqBOA3Iy6Qww/9TeEaKI1b8DkfDp3OI6bmxDPpnJlbjdz1z7AvwuBiBVGRrniYhXwn
         Oej8qK7f/O2NHVvK6QwtlNidkrB2Zb4yQHl1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xw3/W56vtGC/3ZP3MJ3+699gpP6eu5MHaBKMSOZ1gO8=;
        b=cbWs8TBnxhWGINBYXl5s57A9zkjOXHIt6yhei5jjbARU1Zs+R4tXrSNNVU8lqf3oJr
         t3D/Q3eOrhezdWaA7JPU65qEUtS2tuGDoJ1T0S9K/3i5kQGgiiOrt8QE7lw1LvuYJMW1
         wMXmRjWVUmyd0083GKG0vWTKHxXBcmMzxl7Xv+ocUtc+NqRQp+S9ktvPpoj/WGEV/bex
         WTUOHJO6VhTRdd4nEhlB4aaNvXDf1eXHbE6cLF4CKjrzgc6cmnbCRVcnfqogLbrIrL0r
         /SbpdRGe4QRAnh0vUcEm89CgbyQ58WIXQIvPT6kJV2XHSRiaAyf2u8y9WQ0ea+HBGOQM
         PocA==
X-Gm-Message-State: AOAM532o/bWVerf1LMnRhp7UL0TbDIP4lORnrslPU2/+UkyUGMpen2RN
        hB7MUn0l8GEJvPtMQ90RHkxsNqkdJ/ID1c/tzKwNAg==
X-Google-Smtp-Source: ABdhPJydwboEQmLeYqpmLJOy2eHCNa+FZSjYOpisIWa+rGFpcVdWB/NRkUxofhJSGT3KcgRvp5fOgjncDTmn3N9QUFs=
X-Received: by 2002:a17:906:7302:: with SMTP id di2mr10129886ejc.409.1622227244355;
 Fri, 28 May 2021 11:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210527201341.7128-1-zeffron@riotgames.com> <20210527201341.7128-2-zeffron@riotgames.com>
 <20210528093043.GA46923@ranger.igk.intel.com>
In-Reply-To: <20210528093043.GA46923@ranger.igk.intel.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Fri, 28 May 2021 11:40:33 -0700
Message-ID: <CAC1LvL3CXN+ytEFZfv4unq6vDki9nKU_ZN9mzhCVWc2RiNTWOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 28, 2021 at 2:43 AM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, May 27, 2021 at 08:13:39PM +0000, Zvi Effron wrote:
> > Support passing a xdp_md via ctx_in/ctx_out in bpf_attr for
> > BPF_PROG_TEST_RUN.
> >
> > The intended use case is to pass some XDP meta data to the test runs of
> > XDP programs that are used as tail calls.
>
> How about providing an actual selftests that will showcase the above so
> reviewers could get in an easier way a grasp of what this set is about?
>

The very first test case in the added selftests (patch 3) does exactly
that. The return code is passed via XDP meta data to the tested
program (a program that normally would be invoked via tail call). This
is the exact use case we have that prompted this patch set.
