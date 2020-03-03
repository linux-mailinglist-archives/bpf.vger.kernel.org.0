Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A216117863A
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 00:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgCCXV4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 18:21:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35924 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgCCXV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 18:21:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id g83so4689506wme.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FQrFyte0eQhkHV1ZGTXUg6vu0R7T0FUdhPvhOFpCIYA=;
        b=iPsFgD2jDudXd8oLP5/RlUPiFg4J+72znOLJ5Ska9NJYuN99ZocKhyYTnQVFFC/LYp
         u6mNao0Vp2XS2KzVSf1XBteBO+5kJ7EANKwnUK6BiGc/5vvrMIYMgMuBXVgy8gXML8s7
         d6qQHWKI2j/SbPHE1yEpdE+jr78Ln7Kzjfk7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FQrFyte0eQhkHV1ZGTXUg6vu0R7T0FUdhPvhOFpCIYA=;
        b=aVLaU3OFLy+HgdU1iRYDH8lM/5yb5ZW3s6Hx4zqpNTnt1ydk3olOc1AziD99g+JPF0
         XWw8xooetNGuK5knpLIJesjkuAY0u+7s6fmv6o1zFmKtQu0rHy9YYzHSZSR4Cvoe4Y71
         CzRhCNpvKfMzogDVdL5vFpqWjPEZLJ7WNnChTwO4UUONZP9zJ4bkM1Y64/xSMHxGsRz4
         r9UZ7RdM0hI0Ey61uBqbLe5B61foD1ZW+RajyWgXF8iqdDRuREgtC5vy0pUSEUgzhvr7
         kT+HaA4v0szDpXZUKck3Cy900iREi2+vsg98t/en78VahDXWJPU6yE+Xl5CwTzKFkbMs
         lrPw==
X-Gm-Message-State: ANhLgQ2KtyQGCv1VZMQdv7xRrUd5m1yJ4QoLKzpyUXL9g11tpTrm0CLj
        CK/HWkHUEk+qoc0GYkHtIhF2ng==
X-Google-Smtp-Source: ADFU+vvjC5U+4JJoqO1RDHDrLaBawo0DQx0B1WnD4mQ0pQbrjsUiuJb5tW5VfgKM87eZBTlna4UbcA==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr24028wmg.140.1583277713458;
        Tue, 03 Mar 2020 15:21:53 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id y139sm983960wmd.24.2020.03.03.15.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:21:53 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 00:21:51 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200303232151.GB17103@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-5-kpsingh@chromium.org>
 <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 14:44, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > - Functions that are whitlisted by for error injection i.e.
> >   within_error_injection_list.
> > - Security hooks, this is expected to be cleaned up after the KRSI
> >   patches introduce the LSM_HOOK macro:
> >
> >     https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/
> 
> Commit message can use a bit more work for sure. Why (and even what)
> of the changes is not really explained well.

Added some more details.

> 
> >
> > - The attachment is currently limited to functions that return an int.
> >   This can be extended later other types (e.g. PTR).
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
> >  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 8 deletions(-)
> >

[...]

> > +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> > +                       if (!btf_type_is_int(t)) {
> 
> Should the size of int be verified here? E.g., if some function
> returns u8, is that ok for BPF program to return, say, (1<<30) ?

Would this work?

       if (size != t->size) {
               bpf_log(log,
                       "size accessed = %d should be %d\n",
                       size, t->size);
               return false;
       }

- KP

> 
> > +                               bpf_log(log,
> > +                                       "ret type %s not allowed for fmod_ret\n",
> > +                                       btf_kind_str[BTF_INFO_KIND(t->info)]);
> > +                               return false;
> > +                       }
> > +               }
> >         } else if (arg >= nr_args) {
> >                 bpf_log(log, "func '%s' doesn't have %d-th argument\n",
> >                         tname, arg + 1);
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2460c8e6b5be..ae32517d4ccd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/ctype.h>
> > +#include <linux/error-injection.h>
> >
> >  #include "disasm.h"
> >
> > @@ -9800,6 +9801,33 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
> >
> >         return 0;
> >  }
> > +#define SECURITY_PREFIX "security_"
> > +
> > +static int check_attach_modify_return(struct bpf_verifier_env *env)
> > +{
> > +       struct bpf_prog *prog = env->prog;
> > +       unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
> > +
> > +       if (within_error_injection_list(addr))
> > +               return 0;
> > +
> > +       /* This is expected to be cleaned up in the future with the KRSI effort
> > +        * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
> > +        */
> > +       if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
> > +                    sizeof(SECURITY_PREFIX) - 1)) {
> > +
> > +               if (!capable(CAP_MAC_ADMIN))
> > +                       return -EPERM;
> > +
> > +               return 0;
> > +       }
> > +
> > +       verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
> > +               prog->aux->attach_btf_id, prog->aux->attach_func_name);
> > +
> > +       return -EINVAL;
> > +}
> >
> >  static int check_attach_btf_id(struct bpf_verifier_env *env)
> >  {
> > @@ -10000,6 +10028,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >                 }
> >                 tr->func.addr = (void *)addr;
> >                 prog->aux->trampoline = tr;
> > +
> > +               if (prog->expected_attach_type == BPF_MODIFY_RETURN)
> > +                       ret = check_attach_modify_return(env);
> >  out:
> >                 mutex_unlock(&tr->mutex);
> >                 if (ret)
> > --
> > 2.20.1
> >
