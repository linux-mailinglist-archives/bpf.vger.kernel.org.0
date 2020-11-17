Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFCB2B568D
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 03:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgKQCHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 21:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgKQCHY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 21:07:24 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF339C0613D3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:07:23 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so28000219lfc.4
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qttAE96U+SRFrV7RharBmHdFAojmueA1kwm7cwaesVs=;
        b=JjIupNgaYsu2dSx1TtrtqZ6HybXUT3QpTk7YEp8WTACki1FxbrDlyAB/zPUrqXN0j/
         p+I2OOzaha6+bvXXyaVmLH6ywkXYS2zoS4j7ar3RDHOOg3pq5HjS9jzTb7egTBrP7hYm
         J6e//DQAOxGVR35k6LSZi3wJ7tumbV8ygIkgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qttAE96U+SRFrV7RharBmHdFAojmueA1kwm7cwaesVs=;
        b=bnuzJqDkxSO3k6JTPznTyXsl7BjqFD7Mxct6I7K+2vZ6VOzJwC3PB4k9l+41uBfoNF
         DhXZ9lbTWMOdfDhit+eU7lj+bEMlsh4nSD5H7hcXTvezyb/M5krhpU0W05Pvh8XUiDgN
         sPZaXUyxuFXaTD3Hc78BVIS8gFtD1VsPFwA4JlaJjaYeTZLH0WLWNEmy5c0R+TOO5AfO
         2hZS24CDHS7q5txck0kDkRLWl3DWtVq6+L9/ytD6j9WNBJx+0ogknM6xew2rsWiVAgTN
         7oO9r7yBR4F9Ql9EHLOeAt71hmRRsrah/RIE5TxzFr9B6JAz0FODDadKOU1yLedtceG4
         +cQg==
X-Gm-Message-State: AOAM533IX7DrphOhgxcPbsXv+f2knHkHDW+vNYZhFHlDy3fmKi62u0We
        dZp1AnfHH321ARNHN2guqnrqTmHMZZ2jZA6cpzUzIQ==
X-Google-Smtp-Source: ABdhPJx9J4kpz8rK/NsbXUupADg56YJo7flOJcA3fhnK6IXJH7IbinycKCbzZ7hFwsCrVkF+cPQ5UEZG29232P0aOnY=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr818880lfg.167.1605578842441;
 Mon, 16 Nov 2020 18:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20201116232536.1752908-1-kpsingh@chromium.org>
 <20201117001128.7bepy37cxuymfwr3@kafai-mbp.dhcp.thefacebook.com> <CACYkzJ7ONFy0ph+cREetsApKKMn26XJnzfYC_oKcknHzjy0wgg@mail.gmail.com>
In-Reply-To: <CACYkzJ7ONFy0ph+cREetsApKKMn26XJnzfYC_oKcknHzjy0wgg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 17 Nov 2020 03:07:11 +0100
Message-ID: <CACYkzJ5TijW9JdDMWc+rk06gQRd9AUCwSV1+86onU5na-mhWfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 17, 2020 at 3:03 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Tue, Nov 17, 2020 at 1:11 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Mon, Nov 16, 2020 at 11:25:35PM +0000, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > The helper allows modification of certain bits on the linux_binprm
> > > struct starting with the secureexec bit which can be updated using the
> > > BPF_LSM_F_BPRM_SECUREEXEC flag.
> > >
> > > secureexec can be set by the LSM for privilege gaining executions to set
> > > the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
> > > use of certain environment variables (like LD_PRELOAD).
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 14 ++++++++++++++
> > >  kernel/bpf/bpf_lsm.c           | 27 +++++++++++++++++++++++++++
> > >  scripts/bpf_helpers_doc.py     |  2 ++
> > >  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
> > >  4 files changed, 57 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 162999b12790..7f1b6ba8246c 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -3787,6 +3787,14 @@ union bpf_attr {
> > >   *           *ARG_PTR_TO_BTF_ID* of type *task_struct*.
> > >   *   Return
> > >   *           Pointer to the current task.
> > > + *
> > > + * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
> > > + *
> > > + *   Description
> > > + *           Sets certain options on the *bprm*:
> > > + *
> > > + *           **BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
> > > + *           which sets the **AT_SECURE** auxv for glibc.
> > The return value needs to be documented also.
>
> Done.
>
> >
> > >   */
> > >  #define __BPF_FUNC_MAPPER(FN)                \
> > >       FN(unspec),                     \
> > > @@ -3948,6 +3956,7 @@ union bpf_attr {
> > >       FN(task_storage_get),           \
> > >       FN(task_storage_delete),        \
> > >       FN(get_current_task_btf),       \
> > > +     FN(lsm_set_bprm_opts),          \
> > >       /* */
> > >
> > >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > > @@ -4119,6 +4128,11 @@ enum bpf_lwt_encap_mode {
> > >       BPF_LWT_ENCAP_IP,
> > >  };
> > >
> > > +/* Flags for LSM helpers */
> > > +enum {
> > > +     BPF_LSM_F_BPRM_SECUREEXEC       = (1ULL << 0),
> > > +};
> > > +
> > >  #define __bpf_md_ptr(type, name)     \
> > >  union {                                      \
> > >       type name;                      \
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 553107f4706a..31f85474a0ef 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/filter.h>
> > >  #include <linux/bpf.h>
> > >  #include <linux/btf.h>
> > > +#include <linux/binfmts.h>
> > >  #include <linux/lsm_hooks.h>
> > >  #include <linux/bpf_lsm.h>
> > >  #include <linux/kallsyms.h>
> > > @@ -51,6 +52,30 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > >       return 0;
> > >  }
> > >
> > > +/* Mask for all the currently supported BPRM option flags */
> > > +#define BPF_LSM_F_BRPM_OPTS_MASK     0x1ULL
> > If there is a need to have v3, it will be better to use
> > BPF_LSM_F_BPRM_SECUREEXEC instead of 0x1ULL.
>
> Done.
>
> >
> > > +
> > > +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> > > +{
> > > +
> > > +     if (flags & ~BPF_LSM_F_BRPM_OPTS_MASK)
> > > +             return -EINVAL;
> > > +
> > > +     bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
> > The intention of this helper is to set "or clear" a bit?
> > It may be useful to clarify the "clear" part in the doc also.
>
> Updated the docs:
>
>  * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
>  *
>  *      Description
>  *              Set or clear certain options on *bprm*:
>  *
>  *              **BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
>  *              which sets the **AT_SECURE** auxv for glibc. The bit is
>  *              is cleared if the flag is not specified.

(-is) = cleared if the flag is not specified. (Thanks checkpatch!)

>  *      Return
>  *              **-EINVAL** if invalid *flags* are passed.
>
> >
> > > +     return 0;
> > > +}
> > > +
