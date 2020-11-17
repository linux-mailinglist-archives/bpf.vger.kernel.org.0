Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3212B5684
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 03:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKQCEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 21:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKQCEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 21:04:12 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C685C0613D3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:04:12 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id e139so8510152lfd.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqbgq64ReeSsWVRfJZSYCmJDwtd55XetjTjMDOlnW+w=;
        b=HZRO+6VFpomk3p/phkHzWTic70PPvGOgnTXVJZgstfa5SI7EFt4np4dBT9UeaBUIwc
         LhggC9VlRcHUsgmvTADl29p3Q0pvCXdJm9zs5Pws0DqGB5eYFjo26CldUtEv3j02ESS8
         1Fb4L2QkC6qGQvFu70FptgZAUwMmA+DRK4NR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqbgq64ReeSsWVRfJZSYCmJDwtd55XetjTjMDOlnW+w=;
        b=t4SELAU1lA4F4zgQ6U6fBU8s0cMfz6WSVLeMJS+cSUmJ2OV5kAafxcc0em5ALqqvUO
         9KW4dUN1oLgNgbdVdx0ZvYy5t77FXqhzMuzJ8n8/mtQl/263sLdFiVraafFpz125qMDk
         0XvmEgV+dLY5BIWudYDZIfFUpmHdibKdnBMjRVqIiCtSFQlAiDNnk0upr3opU3VQiQVC
         C7AdAolS13vbnerOHc5PhBB32ODdPkVbAxbSNdeA1N2G8RAPE3yN8AIu5KJxOsVtg9VP
         bvfkniZPkhahu9k4ZvuEQmaHiIFjdmTP+1nNj9yNLE2DX0BcobkIHcDAQrZZJHNqQQ9K
         Meiw==
X-Gm-Message-State: AOAM5316mJc1qkN61ddfZwbhCJJlGTk2SbzJbRTyK88eeOaOwEKBNEKJ
        cKczmTLXKfMUnj/zDv6ecD03aNxPYcgbGUvGg/O58Q==
X-Google-Smtp-Source: ABdhPJwDqnfWgQki8Ww+IF+GWFVbVZKf//vug1X2s8dt85qg+mkGigf5wHUA4E2g9dmqndc1znghGOacZpgHRNd/kC0=
X-Received: by 2002:ac2:5591:: with SMTP id v17mr763576lfg.562.1605578650470;
 Mon, 16 Nov 2020 18:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20201116232536.1752908-1-kpsingh@chromium.org> <20201117001128.7bepy37cxuymfwr3@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201117001128.7bepy37cxuymfwr3@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 17 Nov 2020 03:03:59 +0100
Message-ID: <CACYkzJ7ONFy0ph+cREetsApKKMn26XJnzfYC_oKcknHzjy0wgg@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 1:11 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Nov 16, 2020 at 11:25:35PM +0000, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > The helper allows modification of certain bits on the linux_binprm
> > struct starting with the secureexec bit which can be updated using the
> > BPF_LSM_F_BPRM_SECUREEXEC flag.
> >
> > secureexec can be set by the LSM for privilege gaining executions to set
> > the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
> > use of certain environment variables (like LD_PRELOAD).
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  include/uapi/linux/bpf.h       | 14 ++++++++++++++
> >  kernel/bpf/bpf_lsm.c           | 27 +++++++++++++++++++++++++++
> >  scripts/bpf_helpers_doc.py     |  2 ++
> >  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
> >  4 files changed, 57 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 162999b12790..7f1b6ba8246c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3787,6 +3787,14 @@ union bpf_attr {
> >   *           *ARG_PTR_TO_BTF_ID* of type *task_struct*.
> >   *   Return
> >   *           Pointer to the current task.
> > + *
> > + * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
> > + *
> > + *   Description
> > + *           Sets certain options on the *bprm*:
> > + *
> > + *           **BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
> > + *           which sets the **AT_SECURE** auxv for glibc.
> The return value needs to be documented also.

Done.

>
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)                \
> >       FN(unspec),                     \
> > @@ -3948,6 +3956,7 @@ union bpf_attr {
> >       FN(task_storage_get),           \
> >       FN(task_storage_delete),        \
> >       FN(get_current_task_btf),       \
> > +     FN(lsm_set_bprm_opts),          \
> >       /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > @@ -4119,6 +4128,11 @@ enum bpf_lwt_encap_mode {
> >       BPF_LWT_ENCAP_IP,
> >  };
> >
> > +/* Flags for LSM helpers */
> > +enum {
> > +     BPF_LSM_F_BPRM_SECUREEXEC       = (1ULL << 0),
> > +};
> > +
> >  #define __bpf_md_ptr(type, name)     \
> >  union {                                      \
> >       type name;                      \
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 553107f4706a..31f85474a0ef 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/filter.h>
> >  #include <linux/bpf.h>
> >  #include <linux/btf.h>
> > +#include <linux/binfmts.h>
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/kallsyms.h>
> > @@ -51,6 +52,30 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >       return 0;
> >  }
> >
> > +/* Mask for all the currently supported BPRM option flags */
> > +#define BPF_LSM_F_BRPM_OPTS_MASK     0x1ULL
> If there is a need to have v3, it will be better to use
> BPF_LSM_F_BPRM_SECUREEXEC instead of 0x1ULL.

Done.

>
> > +
> > +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> > +{
> > +
> > +     if (flags & ~BPF_LSM_F_BRPM_OPTS_MASK)
> > +             return -EINVAL;
> > +
> > +     bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
> The intention of this helper is to set "or clear" a bit?
> It may be useful to clarify the "clear" part in the doc also.

Updated the docs:

 * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
 *
 *      Description
 *              Set or clear certain options on *bprm*:
 *
 *              **BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
 *              which sets the **AT_SECURE** auxv for glibc. The bit is
 *              is cleared if the flag is not specified.
 *      Return
 *              **-EINVAL** if invalid *flags* are passed.

>
> > +     return 0;
> > +}
> > +
