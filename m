Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299B7380860
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 13:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhENLXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 07:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhENLXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 May 2021 07:23:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 912E361462
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620991314;
        bh=XtJPNgENJo11S0NrI9swYaHsEBsmLOREfhcvYeNhgNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Voo6aXj0gbZ3AK0iegY08kc4l4Wyr9sq9YbD9zPEomjMTR2ZemYSw5tyJJur8cCdy
         WYSAykN9Gg1nzncG8hyuSPTXGqLtEeYmHD1qJT47EXBgNKOJY3OXcfBlwKJ7yqOQAL
         Y+gY5MkZFOB6e5x/GpR0XUhRhd+MCbufcR9VkzRg0NeAwlunqus2xjkvlgwjuNwX+X
         7s5S8yub2PzSWD7sSDKEsbtYfTHJTnSNnOV2vV0nrdS3mxT0AVydpE2D3XOCgdQCMb
         fiA/0ITIE7WShKRgsAN37S+KHXoEQzdjCaBH+CtRRPZmXRNw/GxGXiUz4vsbw9Kke1
         efD7LIwLOdKjQ==
Received: by mail-lf1-f43.google.com with SMTP id a2so21602986lfc.9
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 04:21:54 -0700 (PDT)
X-Gm-Message-State: AOAM5322bR1hctSlDXSJw5/ItusCGRvxZgtKGiHLsxyhEqRFojy+QMHv
        XN2Pg+zvbQlFjseZaNZm675UiHNFakTKnGWFvZ1QLg==
X-Google-Smtp-Source: ABdhPJx8DWhLkRpI9BQVS7qwVs7GeMSzfyjVS19vEhOfMjIDLc8dxWC2OOXSCj4rqXcobRB4Fe7nWVR/pP9yCj4Kiyk=
X-Received: by 2002:ac2:5f72:: with SMTP id c18mr32762345lfc.233.1620991312780;
 Fri, 14 May 2021 04:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
 <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com> <20210512225504.3kt6ij4xqzbtyej5@ast-mbp.dhcp.thefacebook.com>
 <9ae7e503-8f49-a7a4-3e18-0288c7989484@linux.alibaba.com> <CAADnVQK1s4US2LPe4+XsQBEjH8iG8Jdh58n6X1yXAafDAw+M4Q@mail.gmail.com>
In-Reply-To: <CAADnVQK1s4US2LPe4+XsQBEjH8iG8Jdh58n6X1yXAafDAw+M4Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 14 May 2021 13:21:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4xmJBtHBbRfDRnmrCLw=NTf6tYSYXDS6==57RMeBz-4Q@mail.gmail.com>
Message-ID: <CACYkzJ4xmJBtHBbRfDRnmrCLw=NTf6tYSYXDS6==57RMeBz-4Q@mail.gmail.com>
Subject: Re: [RFC] [PATCH bpf-next 1/1] bpf: Add a BPF helper for getting the
 cgroup path of current task
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     xufeng zhang <yunbo.xufeng@linux.alibaba.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Joe Stringer <joe@cilium.io>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > About your suggestion, the *cgroup_id helpers only works for cgroup v2,
> > however, we're still using cgroup v1 in product=EF=BC=8Cand even for cg=
roup v2,
> > I'm not sure if there is any way for user space to get this cgroup id
> > timely(after container created, but before container start to run)=E3=
=80=82
> >
> > So if there is any effective way works for cgroup v1?
>
> https://github.com/systemd/systemd/blob/main/NEWS#L379

I agree that we should not focus on cgroup v1 if we do add a helper.
