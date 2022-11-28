Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA76563B2BC
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 21:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiK1UHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 15:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiK1UHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 15:07:00 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEC18385
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 12:06:59 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b56782b3f6so117059867b3.13
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUzQ4KaIHOjqwhDOxJh13yBt112/zgSWI/lmDL6J0J0=;
        b=GN5K8bNojvYXgrx+MfQI0sJfBlgPUhBS5WL3YaSI99Hoih5DbBoXEm460JXv/7oM0e
         tu6YNhdYhDsZPgOMvSPfB7Yrm8wxhg70+B5/q8wFSQW1ZaVdTj0pjNgARv4ARqSSbLhj
         zB2K00rNqJLH9bpRn+86q0nzSY+K5MJSfKEMb3G3nKFH73GgGOGuV6Msu09rEknIX3B2
         RlKLZwxzVMtp9IitNlaHC5Ln0R2vBZN3Y/n53YeDXKALBqVMgq1wwkp2cZzIbR+dcFCQ
         GzyEBb+ztp/v+X2cAhnWIc7pFsYsXEedELS73XV6rTkz5HltnMOlp3TfLeVGMlyevyOO
         CRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUzQ4KaIHOjqwhDOxJh13yBt112/zgSWI/lmDL6J0J0=;
        b=CAdrma8AWZJ+FrQ3qBkjc+en5uuVrh6Cbv3L2WZCF4blhYdnfG8nspyikrMNRgZSW9
         oGtvN3ODng4ZM7ybzLhPdV9ZLtmbDZ4I6mOOymfqZFjNNFsZckrPgqUxKhNz8y3qSQQ2
         cXe83DXYyN5jJhDVeSPVzCRxOK8KiYBOpY+WQ9DDt3wBukRa8KKRlv4sMylXpV2KfH9l
         8wT5eBGu/CT8Af9d7cappkjbeA2VmE8wsJFI9Dybp9Kq3iH7i8OAyoygYi5sYM5oFdw5
         D8XKlN5uBqY6SUoKiun9n611Hd1RRXnRYvnClM3n918rvhdo8+IZiBQuPJgrkz99lBXt
         2HhA==
X-Gm-Message-State: ANoB5pmthlveMb/x/bMuahxkin3qrvM2D1aLbh/rNVEhdLRG1RrxGLFd
        Rx7ZCmrm9IAf48EnygBloFBLWSPHGfiXYECMALp3nA5Ewsi/wqEV
X-Google-Smtp-Source: AA0mqf4S11RcP3EfhKOIhYJWGMomg5Eevy7a3UXHb/5pOESyc7+3hCYwHe2yEGZ6CdbvNFuXvzYfD6Kl6m6fnqu5vj4=
X-Received: by 2002:a81:4f54:0:b0:3c0:d2aa:baac with SMTP id
 d81-20020a814f54000000b003c0d2aabaacmr10908609ywb.391.1669666018173; Mon, 28
 Nov 2022 12:06:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669216157.git.vmalik@redhat.com> <2ec861621e283ba2a54f7e939eafed1c29f77bf4.1669216157.git.vmalik@redhat.com>
 <Y4R6ZfrhVxsHBD22@krava>
In-Reply-To: <Y4R6ZfrhVxsHBD22@krava>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Nov 2022 12:06:47 -0800
Message-ID: <CA+khW7j8ijn6rrZz=YjpfWhP0xqPOZXTKVm-N7eqCpVQnbYAPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm
 to modules
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 1:07 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Nov 28, 2022 at 08:26:29AM +0100, Viktor Malik wrote:
> > When attaching fentry/fexit/fmod_ret/lsm to a function located in a
> > module without specifying the target program, the verifier tries to find
> > the address to attach to in kallsyms. This is always done by searching
> > the entire kallsyms, not respecting the module in which the function is
> > located.
> >
> > This approach causes an incorrect attachment address to be computed if
> > the function to attach to is shadowed by a function of the same name
> > located earlier in kallsyms.
> >
> > Since the attachment must contain the BTF of the program to attach to,
> > we may extract the module name from it (if the attach target is a
> > module) and search for the function address in the correct module.
> >
> > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > ---
> >  include/linux/btf.h   | 1 +
> >  kernel/bpf/btf.c      | 5 +++++
> >  kernel/bpf/verifier.c | 9 ++++++++-
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 9ed00077db6e..bdbf3eb7083d 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -187,6 +187,7 @@ u32 btf_obj_id(const struct btf *btf);
> >  bool btf_is_kernel(const struct btf *btf);
> >  bool btf_is_module(const struct btf *btf);
> >  struct module *btf_try_get_module(const struct btf *btf);
> > +const char *btf_module_name(const struct btf *btf);
> >  u32 btf_nr_types(const struct btf *btf);
> >  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
> >                          const struct btf_member *m,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 1a59cc7ad730..211fcbb7649d 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7192,6 +7192,11 @@ bool btf_is_module(const struct btf *btf)
> >       return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
> >  }
> >
> > +const char *btf_module_name(const struct btf *btf)
> > +{
> > +     return btf->name;
> > +}
> > +
> >  enum {
> >       BTF_MODULE_F_LIVE = (1 << 0),
> >  };
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9528a066cfa5..acbe62a73559 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16343,7 +16343,14 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                       else
> >                               addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
> >               } else {
> > -                     addr = kallsyms_lookup_name(tname);
> > +                     if (btf_is_module(btf)) {
> > +                             char tmodname[MODULE_NAME_LEN + KSYM_NAME_LEN + 1];
>
> looks good.. would be nice to have module_kallsyms lookup function that
> takes module name and symbol separately so we won't waste stack on that..
>
> especially when module_kallsyms_lookup_name just separates it back again
> and does module lookup.. but not sure how much pain it'd be
>
> jirka
>
> > +                             snprintf(tmodname, sizeof(tmodname), "%s:%s",
> > +                                      btf_module_name(btf), tname);
> > +                             addr = module_kallsyms_lookup_name(tmodname);
> > +                     }
> > +                     else
> > +                             addr = kallsyms_lookup_name(tname);

In addition to what Jiri suggested, we should also have brackets in
the 'else' branch.

if (...) {
  ...
} else {
  ...
}

> >                       if (!addr) {
> >                               bpf_log(log,
> >                                       "The address of function %s cannot be found\n",
> > --
> > 2.38.1
> >
