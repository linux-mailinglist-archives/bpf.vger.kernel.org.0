Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA152B54B0
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 00:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgKPXAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPXAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 18:00:23 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572EC0613CF;
        Mon, 16 Nov 2020 15:00:22 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id p12so22040216ljc.9;
        Mon, 16 Nov 2020 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wW8IUNAptqvWRtctO8+YJZugcJSalzqIkeIZj+Z4Rtw=;
        b=fYSORLuDaalmGULUcgovWcBMhYmu+41qeaivS3tk/IuTo5jKCuZSEuTN27m0/s25Gi
         qIBi7vR5LdvkyHyia67g1l6ZhEUStwTqFVOt6nkhYYboVUYV4YEKf7Z7EvdMFYZxKJkr
         35OtG/yhXNpP8+WI/yt5S36pRY2xccZj/dPqwWh9mK2epHf826UM/2wOrkknxarawbRo
         iYTtABlnmGLfbYy9dlc+y1lgs0eJCGR2tAv5t/CLnWoQ3v9CNlxwDB8vQ2mHmKpTVixq
         KGN7GBqdQW/dk6RpG2qzYRRWySDeXTjJ+pzNcPBzUZRRPh7uHDfsKMLXssG7zd+OlqhX
         Ks2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wW8IUNAptqvWRtctO8+YJZugcJSalzqIkeIZj+Z4Rtw=;
        b=cn3Iqzlwz0XMhACnd8yt+qeJrp4z3iPLKNSd9clD16jaGtMLFbMn4iQFqIzindUDM2
         +7Zrpkb0kvS2hqbEjvOHiel3y/xp68abXCufUM27bC8OF+f3WT4rwPXi77FwHGFGIJVl
         DFq7f+p57pVGGbd5xItfo18pfi//M1rVOLOcs0L/LAmFPUhGu4oetj13LnPjb/uNjAeS
         MHcOX3SLgxOf4CTYNaqPF9obN4BMMTbUjBLqaDAucZhNh/qefhgfu5xgrSM0jls9d24S
         +O4iVZqvLMCkS0qrn4RiOb5RMOh5o+BcWM/rj9ynD8ZkLux5G8kD4Eo14SiKjUyebR/H
         Kqgw==
X-Gm-Message-State: AOAM530BfLvvfdT1HAe543rLiG/8MUs/N+CTa2Z7JwXkH42ZB4eiuivp
        41UDoCBJN/bQazA0kK2LbHz+1WmwrtkRdZyKpPOq6z1h
X-Google-Smtp-Source: ABdhPJwMAU1Gf9GwxRMsib+Ov5RfLYTREiuC0SOlH81RZHFha+3vgr6icMrXKm/jRKrSJeDcpEjnfIBiZVXP0eJAELk=
X-Received: by 2002:a2e:8982:: with SMTP id c2mr652402lji.121.1605567620926;
 Mon, 16 Nov 2020 15:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20201116140110.1412642-1-kpsingh@chromium.org>
 <793acf23-b263-6ae5-2206-18fcdfa991eb@iogearbox.net> <CACYkzJ6U3PNZ0w5ryeWbyTi0NfSLg241iHMHz-b8mrDdsgfkfw@mail.gmail.com>
In-Reply-To: <CACYkzJ6U3PNZ0w5ryeWbyTi0NfSLg241iHMHz-b8mrDdsgfkfw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 16 Nov 2020 15:00:09 -0800
Message-ID: <CAADnVQ+6zXX0V8Qn7VOrdgcVVjgbyTEguAKpqkwvW4b3spSHYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
To:     KP Singh <kpsingh@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Pauline Middelink <middelin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 2:48 PM KP Singh <kpsingh@chromium.org> wrote:
>
> [...]
>
> > >
> > > +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> > > +{
> >
> > This should also reject invalid flags. I'd rather change this helper from RET_VOID
> > to RET_INTEGER and throw -EINVAL for everything other than BPF_LSM_F_BPRM_SECUREEXEC
> > passed in here including zero so it can be extended in future.
>
> Sounds good, I added:
>
>  enum {
>         BPF_LSM_F_BPRM_SECUREEXEC       = (1ULL << 0),
> +       /* Mask for all the currently supported BPRM options */
> +       BPF_LSM_F_BRPM_OPTS_MASK        = 0x1ULL,
>  };

No need to add it to uapi.
Keep it next to the helper in .c file like it's done with other flags.
