Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5C19316A
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCYTsB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 15:48:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44490 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgCYTsB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 15:48:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id j188so2844576lfj.11
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m+sWsfawp9IPajoIZdacO9dJYYta78Pw+YueeYzFlxY=;
        b=J8VeokEiP3c6G7lK6+ho/hDzU0xo/hYsK36WzY+oz0mWQJu2vTWmP6XnvsA9cYT9N5
         nqqsbWG/RFwkjbsq94/N10fjA5usQGnqs9lg09zavJDcntFYWRLBPaoUVe3g4k89jqC8
         /N0wZsvGA1SxxoqBJ9OF2PAQHcqCZ6GlCZdsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m+sWsfawp9IPajoIZdacO9dJYYta78Pw+YueeYzFlxY=;
        b=TaYx1Nh1cjEHiSQiZXyXg5bRGGNmenOKpCYa/wGlOpljZVzIaPoQnNsyTuh70i0Dek
         FjgeEwzkCgP1yctWoyyIBQeMt8hzDJUAsBpHrC/2ztodjcZY+8NhOH2krNieNU8YIY7U
         mkyi6n5bhLutVFX/ivZfk/ujHjrX/EzGmg2dLb041J3fKg0vdfjNO4/4OtskApkiPvuL
         O9HJT5e9f0o8DGbQKhM+5GTi4hARsmgbjht1Dd8QuTz1qRlGQ8tSs13TKiq8GlHDUdVM
         TGG3eoCM7qw8W56yZMnvxfPY+MyNEqhpT/jwV5HF+y3mUvQXM5moKJbsJytP0/6z5jUP
         RmWA==
X-Gm-Message-State: ANhLgQ2f7weOMnKSgdpWWxlh0xasrbTbmg+rSHufS1RIEeyyeDsBN912
        DuDpKLTKVKkGKFeC5Rq25VsBw9lw9iU=
X-Google-Smtp-Source: ADFU+vsXC2+G4dAEdq3BT0kzbpG7W1L+TlJ6Q9f3rfe8/j2ql4POnBClUnujbpyTjYOq/YSFp3UcGg==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr4822089wrd.269.1585165199246;
        Wed, 25 Mar 2020 12:39:59 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id o67sm135582wmo.5.2020.03.25.12.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:39:58 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 25 Mar 2020 20:39:56 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200325193956.GA22898@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-4-kpsingh@chromium.org>
 <202003251225.923FF1DD7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003251225.923FF1DD7@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25-Mär 12:28, Kees Cook wrote:
> On Wed, Mar 25, 2020 at 04:26:24PM +0100, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > When CONFIG_BPF_LSM is enabled, nop functions, bpf_lsm_<hook_name>, are
> > generated for each LSM hook. These functions are initialized as LSM
> > hooks in a subsequent patch.
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >  include/linux/bpf_lsm.h | 22 ++++++++++++++++++++++
> >  kernel/bpf/bpf_lsm.c    | 14 ++++++++++++++
> >  2 files changed, 36 insertions(+)
> >  create mode 100644 include/linux/bpf_lsm.h
> > 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > new file mode 100644
> > index 000000000000..83b96895829f
> > --- /dev/null
> > +++ b/include/linux/bpf_lsm.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +
> > +#ifndef _LINUX_BPF_LSM_H
> > +#define _LINUX_BPF_LSM_H
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/lsm_hooks.h>
> > +
> > +#ifdef CONFIG_BPF_LSM
> > +
> > +#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> > +	RET bpf_lsm_##NAME(__VA_ARGS__);
> > +#include <linux/lsm_hook_defs.h>
> > +#undef LSM_HOOK
> > +
> > +#endif /* CONFIG_BPF_LSM */
> > +
> > +#endif /* _LINUX_BPF_LSM_H */
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 82875039ca90..1210a819ca52 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -7,6 +7,20 @@
> >  #include <linux/filter.h>
> >  #include <linux/bpf.h>
> >  #include <linux/btf.h>
> > +#include <linux/lsm_hooks.h>
> > +#include <linux/bpf_lsm.h>
> > +
> > +/* For every LSM hook that allows attachment of BPF programs, declare a nop
> > + * function where a BPF program can be attached.
> > + */
> > +#define LSM_HOOK(RET, DEFAULT, NAME, ...) 	\
> > +noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\
> 
> I don't think the __weak is needed any more here?

This was suggested in:

 https://lore.kernel.org/bpf/20200221022537.wbmhdfkdbfvw2pww@ast-mbp/

"I think I saw cases when gcc ignored 'noinline' when function is
defined in the same file and still performed inlining while keeping
the function body.  To be safe I think __weak is necessary. That will
guarantee noinline."

It happened to work nicely with the previous approach for the special
hooks but the actual reason for adding the __weak was to guarrantee
that these functions don't get inlined.

> 
> > +{						\
> > +	return DEFAULT;				\
> 
> I'm impressed that LSM_RET_VOID actually works. :)

All the credit goes to Andrii :)

- KP

> 
> -Kees
> 
> > +}
> > +
> > +#include <linux/lsm_hook_defs.h>
> > +#undef LSM_HOOK
> >  
> >  const struct bpf_prog_ops lsm_prog_ops = {
> >  };
> > -- 
> > 2.20.1
> > 
> 
> -- 
> Kees Cook
