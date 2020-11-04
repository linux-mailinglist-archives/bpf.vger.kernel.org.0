Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787452A62F9
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgKDLLm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 06:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgKDLLl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 06:11:41 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048EC061A4A
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 03:11:41 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id t13so22458426ljk.12
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 03:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aultQK+cYbt9EaKffKJjVqANPad9PyrlBdtboLU4IA=;
        b=ivZfJQHPmD01J2xbZy42asmWl+Xzi9y0dCbqaR2OVEn5SGcJrHr3ZZcMXf+DCQStfS
         f0ZTkcG1W6bVd1wHGTccH156UTwUvUWE+POiauXEtOvKGIMkIbtbLkI2/a4crnse/rJi
         tjJD5qtNjIPqxsr7HkbcxfSzCszTBWHnU642I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aultQK+cYbt9EaKffKJjVqANPad9PyrlBdtboLU4IA=;
        b=aTBiO5SBeWB/9a+7scZZOzakZdRB2BvVBZKeWgdSPbA/+xyNtzaCciHtKiA6mDrugz
         RIXSFMR7Zq+PG0Pmwib2XFkD2+Pnmgo/cAKeNii26GzDa+6RcIQWIyKQmdQiUgyrkwSN
         nUUs/I5Fg/dUzjCVnwKe4HQPTWYV4rP3Wz55RQ+lvE+pnabxT1u7xEqkXe+5mhQKpcxL
         /E1FhDxSkcVsytYnON8yh4pVLdflyvbGuUkj4K1/2YTNKEDO9iaOxewpmzpSWE1c/OM/
         x4d4f5ymtwlP04CO0CLh0g1IJP1C3r5cxfdK//IXitMD6DhaLzqIrHfPF8hPAy5BUNBz
         nCIg==
X-Gm-Message-State: AOAM530klK86PLCtrJLj36BtVAJHJSQFy8PNoId7dfKU4E92GBRdvFHr
        EBABM3I7Amdsu0lcjFf2NH9KaxbUP723gFSioAFllQ==
X-Google-Smtp-Source: ABdhPJwqWomsCzz55ATmGDk4/Vt7G/sEUtq2vTBjF/6nwSasads2VL8eNrDbLdIOXtccVR6B/LVv8fCe9gKkPw7OmRc=
X-Received: by 2002:a2e:7016:: with SMTP id l22mr9948371ljc.466.1604488299577;
 Wed, 04 Nov 2020 03:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org> <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
 <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com>
 <CAADnVQ+DBHXkf8SFwnTKmSKi7mdAx56dWbpp5++Cc02CQjz+Ng@mail.gmail.com>
 <CACYkzJ6uc4fbRMNmj3kFeSu=V2JqWruJLFjMnPet_HXW-EdRng@mail.gmail.com>
 <CAADnVQLKhmA49RGH=SSCg3qHxZOzU5bHp+sw+Yw7M_7KB0zD4g@mail.gmail.com>
 <5fa24f72dd48e_9fa0e20871@john-XPS-13-9370.notmuch> <CACYkzJ7v4TNopZ0VhFezax-i3TF59Ok2mfgb_W+mTH52fd_gRw@mail.gmail.com>
In-Reply-To: <CACYkzJ7v4TNopZ0VhFezax-i3TF59Ok2mfgb_W+mTH52fd_gRw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 12:11:28 +0100
Message-ID: <CACYkzJ50d65j3kfQUdoLXOx+t-6UDK7mhb0M_oF8uoveXo+GYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 4, 2020 at 12:03 PM KP Singh <kpsingh@chromium.org> wrote:
>
> [...]
>
> > > Ahh. Yes. That should do it. Right now I don't see concerns with safety
> > > of the bpf_spin_lock in bpf_lsm progs.
> >
> > What about sleepable lsm hooks? Normally we wouldn't expect to sleep with
> > a spinlock held. Should we have a check to ensure programs bpf_spin_lock
> > are not also sleepable?
>
> Thanks. Yes, I added that to my patch:
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
>         default:
>                 return tracing_prog_func_proto(func_id, prog);
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 314018e8fc12..8892f7ba2041 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9739,6 +9739,23 @@ static int check_map_prog_compatibility(struct
> bpf_verifier_env *env,
>                 return -EINVAL;
>         }
>
> +       if (map_value_has_spin_lock(map)) {
> +               if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
> +                       verbose(env, "socket filter progs cannot use
> bpf_spin_lock yet\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (is_tracing_prog_type(prog_type)) {
> +                       verbose(env, "tracing progs cannot use
> bpf_spin_lock yet\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (prog->aux->sleepable) {
> +                       verbose(env, "sleepable progs cannot use
> bpf_spin_lock\n");

I think this can still be "yet" as it's doable; we can disable/enable
preemption in the helpers
and then have the verifier track that no sleepable helper is called
when a spin lock is held.
I would, however, prefer if we do it in a subsequent patch.

- KP

> +                       return -EINVAL;
> +               }
> +       }
> +
