Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD56C4437AE
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 22:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKBVTB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 17:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKBVTA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 17:19:00 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC97C061714;
        Tue,  2 Nov 2021 14:16:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s136so518629pgs.4;
        Tue, 02 Nov 2021 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTz2VfXu9BFDNEqPjGiyXjjW4rvhVHqZ6MNOJZx8WDg=;
        b=qmUDX2EOQCUYsPSl9eI7vSyCKTI7spEk6y3kx9kM9bDYPFnRK440Bwyt3OzUTDD9rp
         rHRSLo2RUtxezphywnzqNbMOPyqln80bU8A/YNPEWwcAnJMDqGl6drnwf4euR16KTMtD
         bJ91m/SmvHvCjVAdEIoI9gyxhXksKL+cniMVqQCDsGUhSU8ktWkp8xEmLUQ3rFz7AmDn
         MTKVKsU2yvBUzs3MbYee9qylJcK2Y9K4PFMn/MlQQGJmUK6FiKS1c8ZmHgSaq1Zh9ucV
         HDH9Fmtcx6bDbDPpLn/iGNa1tSPU7J9Dr+b+qxfHGIZbNjh8ueSI3dhGasnsyJvy0ra9
         tOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTz2VfXu9BFDNEqPjGiyXjjW4rvhVHqZ6MNOJZx8WDg=;
        b=uJ6+GZQGRR/wj1ItKnIXoZteDRtiBHdFYq65Py8+8zo4DZzZuHMmR+zXcnevfG/aXA
         JrRrRbC9CqbdOEJjtrZGnVgEk6J7Pi0n9k8pmk+KpxngqFu+8wkgnYhsqCpyPUAOpeVb
         rD3iCyl+tsjG4j9Jk1nFTjhHmA02S2eJrwS18HTkTl+lfhIwxm8A7IovjUAGtAwZQFpZ
         +fhgMU5jwGZJoIfD/qBj8f0PhnSOhecHnoISwpHJ9ZWGrUpiBUTLztC6mP4NlH/UQZMA
         LO6ByuaE7qL8HA3uICFApxs1Q1yAmtAsNtkitw50SN017Z453CYy8HPAcwFjHhebVT8f
         z9Wg==
X-Gm-Message-State: AOAM532O6PQCVBJESHwdBAxDYhe2LhTjLF5X2UU2QANmhz8Syh8+9KG3
        TKf/w6ZtOv7/kWVb4yKU7RR5VXZ14imWOWi8tmY=
X-Google-Smtp-Source: ABdhPJwXqplI9yicGjFvgK5+seN5+uCcR5BmtK5nVve6Cjb9vCkNeb0U9XonYj5YjDzUbcwXpfnnvMm+mi2jPNVAQh4=
X-Received: by 2002:a63:374c:: with SMTP id g12mr29677439pgn.35.1635887784746;
 Tue, 02 Nov 2021 14:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211102084856.483534-1-zhudi2@huawei.com> <7511b8fd-c5b6-96b3-8b1d-e7eeeb0b2c33@fb.com>
In-Reply-To: <7511b8fd-c5b6-96b3-8b1d-e7eeeb0b2c33@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 2 Nov 2021 14:16:13 -0700
Message-ID: <CAADnVQKKqnBJ+VjAFrWdM4BgRe4KdmeF5LYm9i96gZsr_urcvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
To:     Yonghong Song <yhs@fb.com>
Cc:     Di Zhu <zhudi2@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 2, 2021 at 1:11 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> > -                             struct bpf_prog *old, u32 which)
> > +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog **pprog[],
>
> Can we just change "**pprog[]" to "***pprog"? In the code, you really
> just pass the address of the decl "struct bpf_prog **pprog;" to the
> function.

Di,

this feedback was given twice already.
You also didn't address several other points from the earlier reviews.
Please do not resubmit until you address all points.
