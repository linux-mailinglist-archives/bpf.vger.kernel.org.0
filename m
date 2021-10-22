Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4233A4379E2
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhJVP1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbhJVP1u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 11:27:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3799C061227;
        Fri, 22 Oct 2021 08:25:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso3332462pjw.2;
        Fri, 22 Oct 2021 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKpDKUZAfp4wYPYwfEUtSMep8X49ABj3gb2Vj1km3eg=;
        b=atrXfRV1sRblaNIFM9kCrDIy26fpdl4yfaJ7fiL9UKQpQZ2Sr2ptJzEZnUtA6cO3jm
         I5NpVi+Bz0SAXKt5tbfaFyel8TjZqxafYLsBWzCdnETCqZplOch47LaG8vbi0hb0sINC
         Ab7WtTlJDE+F6u2HFwbT2oWnvYMMqCzEp7/8DwnzBS3LDnm6iNJJEPmL7D3yY/ucrpd1
         TtmU9G08Qj9EB+nwKqtQ5ADVYgnvIibd8oPukPBX03eLJ2H7AhOZu8Z35IW2fzocO0Zm
         Z6dF49r++inUyCxO5KhW15iKuL5H9DllKIenYxHweHgzmG4z11RZu7zGkGPVIyRW7miu
         d1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKpDKUZAfp4wYPYwfEUtSMep8X49ABj3gb2Vj1km3eg=;
        b=evlkY2rw9+9JX02Bub09uq/UyN4dYaGi/trkoPjMk613Bj8aj+iC1Ff9HfuH5BIPTO
         vZz1iRERS2p3kHNwSff0Z8iHWAQutv2oJ4yQcU/2E9Pww05ek8ff9wcOUZrLFZs7cFD9
         /weZjhZ6dtPrpnMiaAs4Udz5Qe8PD7gjtN2LM5vHHI3nA0ONtFHoEdhq/QIoT9Px+Zzk
         J/i3HfD9sxvHqtzHJ5vH8KGUmugqny32R5XgGL9n9i+Nc6TMpIhbOzFyKhrbM4Lnzb92
         VoD+yDD9unlAKh/4+sl+cPVG9Y3bDxCs9cXzOl682NdoCig1TTsbnAGu41DRpAgfnvnb
         Plvw==
X-Gm-Message-State: AOAM532QFXKxMChTnA8Jl0ibF+D5ABp4ySyD/aRsh5CHwMz940hpMsGl
        yUTFi+myJxDwnd97VrInrMl4k73xp21XCr2aJDk=
X-Google-Smtp-Source: ABdhPJyZf/uZDVv6mpEi/TBQcoLmnVs4AcZX6iMc9bpOSeBvdKoiQX8s/HdU7RCmPYPY+3H3wzWF0MkfP3qGJqWfnLU=
X-Received: by 2002:a17:90b:3148:: with SMTP id ip8mr667370pjb.62.1634916327395;
 Fri, 22 Oct 2021 08:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211022103348.284562-1-zhudi2@huawei.com>
In-Reply-To: <20211022103348.284562-1-zhudi2@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Oct 2021 08:25:16 -0700
Message-ID: <CAADnVQJV7mFLE7_vPH8wcZqDsLhuZGqLk9sbrxWOeELL4X=NVg@mail.gmail.com>
Subject: Re: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to sockmap
To:     Di Zhu <zhudi2@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 3:34 AM Di Zhu <zhudi2@huawei.com> wrote:
>
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
>
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>

The feature looks fine, but it needs a selftest.
