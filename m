Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A3C9339
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfJBVCV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 17:02:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34719 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfJBVCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 17:02:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so5779335wmc.1
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gzsVfLOt59b7p12S85OGyalCddgvvAPhErI7gXkFcYg=;
        b=RqQpbgOole5asKDtt8qB8e5VR3VSs9DlaL2SVnUSpwz0XxjEB+9tKbGrbLcDPhyAVv
         HAMUMiksZJK/VUoF7bEWOlq842z/WY+dB4Gbg7DSCqDXFlr4aLmXpv/nuA8fbClV9wrE
         eDG+Lguo5Ktqw4xuYp1NUjtKcLgKD0LDESUtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gzsVfLOt59b7p12S85OGyalCddgvvAPhErI7gXkFcYg=;
        b=OfddHRRxPRVWRWzvZsdOYVVFmXIvCk2J5dPmsW49IjCB/bFf61V34jVr8bubMVH/UR
         Y7/VrjVuCUm5ft0SSLh5nzzUeb2NX6JU904X3HvAf3iYHABBhuwIgPL3bZSf71bDMYOy
         tXxflAQPQjUmSM2W2EsLSJiPv4p4bTGDWWvC0FAaKBZH37MFtKyfeBMlAn2G5PI2u56C
         f+JLi52rVriqb9XtXaY7K4c7BCrZEkJ7qFQRSZk2POyIwYruj2W4KO0S9+4NlBxdWNYN
         /Egc/CBX32LzRVhVYI0wpHTpQZLsEgIyaU3z7le3kwAafilyDTO6hounUMNjKNJ5KLnl
         +clA==
X-Gm-Message-State: APjAAAWSEiLGS2jrQNXmi9gwNduezrvXwENRRDB5guAAulyaNmW270dN
        OZg0KVzRc77vluLrynU1oScjhATGe/QnMHuNmji8wA==
X-Google-Smtp-Source: APXvYqy77dFOGBu4403Tyjq8z5N/mPTGFQ8GkPVWiC9umTKskB0g1g3ykwUl1VxzEWwpzkIznz+o2oeXfB/1oJwIW7A=
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr4355597wmu.139.1570050139565;
 Wed, 02 Oct 2019 14:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191001112249.27341-1-bjorn.topel@gmail.com> <CAPhsuW5c9v0OnU4g+eYkPjBCuNMjC_69pFhzr=nTfDMAy4bK6w@mail.gmail.com>
In-Reply-To: <CAPhsuW5c9v0OnU4g+eYkPjBCuNMjC_69pFhzr=nTfDMAy4bK6w@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 2 Oct 2019 23:02:09 +0200
Message-ID: <CACYkzJ6EuhtEPDH=3Gr8eo5=NtUVgCMvqq64POX31pB-gVSbTA@mail.gmail.com>
Subject: Re: [PATCH bpf] samples/bpf: fix build for task_fd_query_user.c
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 2, 2019 at 8:46 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 4:26 AM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.c=
om> wrote:
> >
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> >
> > Add missing "linux/perf_event.h" include file.
> >
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>

Tested-by: KP Singh <kpsingh@google.com>

(https://lore.kernel.org/bpf/20191002185233.GA3650@chromium.org/T/#t)
