Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663B42C2A9E
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 16:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgKXPBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 10:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgKXPBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 10:01:21 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0DC0617A6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 07:01:21 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f18so4398018ljg.9
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 07:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cufC7N8nRv3SkCz2IJuYYqy8EP5LoCq+PiCIULlPW0=;
        b=mNl/Joee3mZwk30XNCTYG5kdWOulL4KcpSFJJnGh86vK4xb4jgc7VmmrSomvrjsLff
         ne/69Cv+zuk5lr94nZFUG8iyt/sqpOPgj1Nuj9NcXlC4eqX6IlxgB23FD2Ic4AJfB1bV
         QX0D9GA4sqn7jOUNma4wX9HoeEG2LHXYjKKe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cufC7N8nRv3SkCz2IJuYYqy8EP5LoCq+PiCIULlPW0=;
        b=uInjUfCHoD67pWZFXpeu0a6ozuXtL5papwimkfMkYIHLSj07p4tMn7bAfjqicvGHnp
         6vKMGwEuKEV0el5FHVcNiLAgSctbyvWUVvWmQ0Gm1LIlCc/hELjEg/ARwdXT8CVAeSZP
         GlzcJ703OveG1eJ3s5y2jrXeNyx0hSWM8rpkYHjRx0YmAcAxSMY2oOk5v4KOc+AFggOK
         3Kwo+9kedSwDXBP5qrd3+Ga5lWAUA5nMbPUdVkOh6HcCpT7++LjCqKrLLdqiVdNHb4ei
         N5chBOWhtzopzS3iG32nlbGXPRV8wh9yapYRvag6wa/WXH2EsYjGInPzrWsWzfrWACxM
         0IGQ==
X-Gm-Message-State: AOAM531v+YPU6sygY2YlmX1573TRRmIP2E/O900pFVMyJ5f5kS2erG00
        wNUem3ykpyScMNJSuTJ43bpnN1bZv+ijib6eusBQfQ==
X-Google-Smtp-Source: ABdhPJwIEoDcDkp7w38V6oWL+60rjnYt6TjmgnqxWK3R1hsqDpgobsUas8XwaZu6zdQQBEl+Zuzw9LtexHB9RzsHpjQ=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr2139852ljj.110.1606230075181;
 Tue, 24 Nov 2020 07:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-2-kpsingh@chromium.org> <20201124040220.oyajc7wqn7gqgyib@ast-mbp>
 <CACYkzJ4i9qCgBRm3_pt19Tty4eR0RTMOg66f-_Rb7N3mBvgU8w@mail.gmail.com>
In-Reply-To: <CACYkzJ4i9qCgBRm3_pt19Tty4eR0RTMOg66f-_Rb7N3mBvgU8w@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 24 Nov 2020 16:01:04 +0100
Message-ID: <CACYkzJ7mhbwzDwifDuBF91MKf0u6Cw2+HGWDMLJuTXnWz-gfJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 24, 2020 at 12:04 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On Tue, Nov 24, 2020 at 5:02 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 20, 2020 at 01:17:07PM +0000, KP Singh wrote:
> > > +
> > > +static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
> > > +{
> > > +     return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
> > > +}
> > > +
> > > +BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
> > > +
> > > +const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
> > > +     .func           = bpf_ima_inode_hash,
> > > +     .gpl_only       = false,
> > > +     .ret_type       = RET_INTEGER,
> > > +     .arg1_type      = ARG_PTR_TO_BTF_ID,
> > > +     .arg1_btf_id    = &bpf_ima_inode_hash_btf_ids[0],
> > > +     .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> > > +     .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> > > +     .allowed        = bpf_ima_inode_hash_allowed,
> > > +};
> > > +
> > >  static const struct bpf_func_proto *
> > >  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > >  {
> > > @@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > >               return &bpf_task_storage_delete_proto;
> > >       case BPF_FUNC_bprm_opts_set:
> > >               return &bpf_bprm_opts_set_proto;
> > > +     case BPF_FUNC_ima_inode_hash:
> > > +             return &bpf_ima_inode_hash_proto;
> >
> > That's not enough for correctness.
> > Not only hook has to sleepable, but the program has to be sleepable too.
> > The patch 3 should be causing all sort of kernel warnings
> > for calling mutex from preempt disabled.
> > There it calls bpf_ima_inode_hash() from SEC("lsm/file_mprotect") program.

Okay I dug into why I did not get any warnings, I do have
CONFIG_DEBUG_ATOMIC_SLEEP
and friends enabled and I do look at dmesg and... I think you misread
the diff of my patch :)

it's indeed attaching to "lsm.s/bprm_committed_creds":

[https://lore.kernel.org/bpf/CACYkzJ7Oi8wXf=9a-e=fFHJirRbD=u47z+3+M2cRTCy_1fwtgw@mail.gmail.com/T/#m8d55bf0cdda614338cecd7154476497628612f6a]

 SEC("lsm/file_mprotect")
 int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
@@ -65,8 +67,11 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
  __u32 key = 0;
  __u64 *value;

- if (monitored_pid == pid)
+ if (monitored_pid == pid) {
  bprm_count++;
+ ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
+  &ima_hash, sizeof(ima_hash));
+ }

  bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
  bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
-- 

The diff makes it look like it is attaching to "lsm/file_mprotect" but
it's actually attaching to
"lsm.s/bprm_committed_creds".

Now we can either check for prod->aux->sleepable in
bpf_ima_inode_hash_allowed or
just not expose the helper to non-sleepable hooks. I went with the
latter as this is what
we do for bpf_copy_from_user.

- KP

>
> I did actually mean to use SEC("lsm.s/bprm_committed_creds"), my bad.
>
> > "lsm/" is non-sleepable. "lsm.s/" is.
> > please enable CONFIG_DEBUG_ATOMIC_SLEEP=y in your config.
>
> Oops, yes I did notice that during recent work on the test cases.
>
> Since we need a stronger check than just warnings, I am doing
> something similar to
> what we do for bpf_copy_from_user i.e.
>
>      return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
