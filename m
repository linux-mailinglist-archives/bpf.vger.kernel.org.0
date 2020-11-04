Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0D2A5C74
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 02:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgKDB5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 20:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbgKDB5q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 20:57:46 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6C3C061A4D;
        Tue,  3 Nov 2020 17:57:45 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id l10so238661lji.4;
        Tue, 03 Nov 2020 17:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5jcjQaGi9sDna2HftC//RF9cUNuvGHsOZ4Yn5JzhrA=;
        b=msRt8Rv5H0OSJElnwji6OYcXPCHNTVrPSY9VG5QXKMFi12NPCEPiIQok9Dcrhd6hnm
         AlZaIQ3DVqqr2T2uODSEJOCv34l6gunGaZSS9PERo7dXR0S1IQvHklIpmhoE4PA5nrjh
         yYKR4dMw1p8cMqlEZxVdmUm4nTUTR2OFvax28Zf9lcbA2YvgvFA8Dx0aR5nbEf8W31r6
         NSeB7QxPHT8GvrOM19utptFiVsLmZZcVhEDr+aeCah3JcUJGrSuwSgH6iQcfCldiSONL
         QYgUMsdzke+FdIWY+uRXxQ+njX3ypWSZgfRku3wHpZUZmNc08NqUxZRqRcnx6G6fFt/Z
         t5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5jcjQaGi9sDna2HftC//RF9cUNuvGHsOZ4Yn5JzhrA=;
        b=q+/YJLyq71Hmnl3iQyTle8jKj5yQG8sAarpqkvTZt39Fb5Tax4hfCVyu0d7P1HgQ1c
         nZqgKSksA40IETLfiOKuylP59bg4dM5kllOVKhycfYFO+5p6pQpN/DDiZf6r/FVlfryH
         hQYulPdANyY/xhHWgSOsxaa4WwkPQnTVEb441GzIy8QLxv9dcvIcYodeC/LX+77UltVh
         VXPU/01kNRPCdBv+88kIeEitv7J9SijzYnQJY1pERQB6wgw3RJu/EHMCiZm39DKRZyav
         kM6jQs7PL7JDX3WC2ZJV5udMBgnsbH4oneTyiYjAQoUMU7MZ07VG9G1DiBiOjOuH8AWM
         b1xQ==
X-Gm-Message-State: AOAM532XEfg4KbyuFc3ps3odLsFke8mdAAmddjJiUte8Syuy0aKkes0U
        nMoIngWgD2Y7pEgnMNR6NKbcKJs7Y+h6f1XSICw=
X-Google-Smtp-Source: ABdhPJxW9COrxAXTbtuLIj1giI+YuksxBPvWmo25mxHGIDSkOZz0B2RxtTKfZrn2z1/vFgvVgbJsabELEWA2rG8eTO0=
X-Received: by 2002:a2e:b4ba:: with SMTP id q26mr10389163ljm.121.1604455064122;
 Tue, 03 Nov 2020 17:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org> <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
 <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com>
 <CAADnVQ+DBHXkf8SFwnTKmSKi7mdAx56dWbpp5++Cc02CQjz+Ng@mail.gmail.com> <CACYkzJ6uc4fbRMNmj3kFeSu=V2JqWruJLFjMnPet_HXW-EdRng@mail.gmail.com>
In-Reply-To: <CACYkzJ6uc4fbRMNmj3kFeSu=V2JqWruJLFjMnPet_HXW-EdRng@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 3 Nov 2020 17:57:32 -0800
Message-ID: <CAADnVQLKhmA49RGH=SSCg3qHxZOzU5bHp+sw+Yw7M_7KB0zD4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 5:55 PM KP Singh <kpsingh@chromium.org> wrote:
>
> [...]
>
> > >
> > > I saw the docs mention that these are not exposed to tracing programs due to
> > > insufficient preemption checks. Do you think it would be okay to allow them
> > > for LSM programs?
> >
> > hmm. Isn't it allowed already?
> > The verifier does:
> >         if ((is_tracing_prog_type(prog_type) ||
> >              prog_type == BPF_PROG_TYPE_SOCKET_FILTER) &&
> >             map_value_has_spin_lock(map)) {
> >                 verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> >                 return -EINVAL;
> >         }
> >
> > BPF_PROG_TYPE_LSM is not in this list.
>
> The verifier does not have any problem, it's just that the helpers are not
> exposed to LSM programs via bpf_lsm_func_proto.
>
> So all we need is:
>
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 61f8cc52fd5b..93383df2140b 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -63,6 +63,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const
> struct bpf_prog *prog)
>                 return &bpf_task_storage_get_proto;
>         case BPF_FUNC_task_storage_delete:
>                 return &bpf_task_storage_delete_proto;
> +       case BPF_FUNC_spin_lock:
> +               return &bpf_spin_lock_proto;
> +       case BPF_FUNC_spin_unlock:
> +               return &bpf_spin_unlock_proto;

Ahh. Yes. That should do it. Right now I don't see concerns with safety
of the bpf_spin_lock in bpf_lsm progs.
