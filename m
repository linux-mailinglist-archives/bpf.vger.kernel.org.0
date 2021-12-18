Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC92479DA2
	for <lists+bpf@lfdr.de>; Sat, 18 Dec 2021 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhLRVtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Dec 2021 16:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbhLRVs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Dec 2021 16:48:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BDC06179C
        for <bpf@vger.kernel.org>; Sat, 18 Dec 2021 13:48:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id iy13so132912pjb.5
        for <bpf@vger.kernel.org>; Sat, 18 Dec 2021 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNyGK8GpXCxGnEDOU0MoS4VC32HC3Qx1to+htLKg03c=;
        b=UZ5n3H/etV4u5Nw1Ehdp7L9nlM5czHt2aJ7/wSCtNlnK9ZIDh+AP+q3WkgfX32BxSj
         ym6rqcpRzSoTcZ+cxVQQW/SuUCiRp81E53xJqs/scLORWLYVijc+2erxNPqqC28H7owU
         lKO1zV118Ck91EzR+bvU52ORpQAcHBCilei5o/hzLe7Yzsd0keWoWd17SqUcnoN9xl0Y
         aJ4at4H4w8wOpdL0i2rpqZsC0RIIT/RVOs8mn+beKlllJ0Ew0pNBUsQhVIW6gLKezRTC
         CmozBDa1EsPiCPy3XIYUVUx3GzxLn/8WiGLrcn6bdOrz79bh7uShE6JQu2uO5zlWv3S7
         vLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNyGK8GpXCxGnEDOU0MoS4VC32HC3Qx1to+htLKg03c=;
        b=W2WQ1QidD+a0j8imRWdhsTW3YDxKOLWMD3t9rIaT6fsSHZzTWEbNuumHFJwjFvpZHp
         I5E/o3QpBmGHJb2/n6dG56DDnC0pdraLOWC9E3Z+4EcuvvlumjWbzOfj7+GsGNmDtARQ
         r3GkhhdMUlx/7oq+0V024Wji0BABddbwCpR7PR5NqtWGXDKfq6lGsm0Ebcf/5M0ExlsY
         E8gAJw2SbJ8CrvjzsxVHBnufxZ/7Y7Cp9RvL7An70bJJaZFV8MUW5ZFwZ1mPQ4DXBHxn
         vpPiduGp7maN+bggK/9bhdNYIUoyOFAA0WPBmGJAQ8LwocQnnQtnWrnfGcyRpX3ohhCO
         61SA==
X-Gm-Message-State: AOAM5308VcdV95B0lf+m2vduKcAj5Vx0GcXphsb+P2YLsyHGnmxCApRZ
        KtZBkZrH9/FQPK6ZD+Ym8cUd3jXwvsKXhVCjSTY=
X-Google-Smtp-Source: ABdhPJwTUcAwyM9SuAvLrRkuaAWP1mptf6cUbnePrbFvuhzVG5BPltd3Nj6/e5DMBhLTln0cfDBhhVphxYeLWID9ryo=
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr11175164pjb.62.1639864132408;
 Sat, 18 Dec 2021 13:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com> <20211217003152.48334-8-haoluo@google.com>
In-Reply-To: <20211217003152.48334-8-haoluo@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 18 Dec 2021 13:48:41 -0800
Message-ID: <CAADnVQ+bgDhePTMNDA=1U7vY3Tai2tA-C+kFdFeyMN6zLJEaqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/9] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 4:32 PM Hao Luo <haoluo@google.com> wrote:
> +
> +               if (t == BPF_WRITE && rdonly_mem) {
> +                       verbose(env, "R%d cannot write into rdonly %s\n",
> +                               regno, reg_type_str(env, reg->type));
> +                       return -EACCES;

I've removed "rdonly" from above, since it's part of reg_type_str(),
while applying.
