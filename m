Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150502C238F
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 12:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgKXLFK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 06:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732315AbgKXLFJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 06:05:09 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FEC0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 03:05:09 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so28239774lfe.12
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TaUVzQhpURqvZLgSdjgXP5Y5E8KytlSxVtILGHQLAo=;
        b=J7Yh5Gl8VJbnnkSr3W+xvsWVk19oFqjxfIfH9nCy15iVRvUOsv8pmwTZxeCo10ESh4
         evtmHyd962VrS41Pb/McGhWkE+6TvXxQ9kW3hR0ik54yj+kGqNvycMHxRkSOPaFHL7Mm
         MuNVaNl3nuBxFF854StZ/6unFn+/EIefpvvDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TaUVzQhpURqvZLgSdjgXP5Y5E8KytlSxVtILGHQLAo=;
        b=CJFpbA4sZU6J9pPmjYji1k03hI0qTi5xv4CtrQ9nxDWUkCs1SX1IqB4XNnV4z+bzXB
         divfkjol+zB0kdD2B9yV6a2bVcAWfuQznx5AReyWn+u1qTJbN0t7P03BOamsJxLUpWYF
         xx6O3jgkEA+jEEUXahS3/ZxCE+A2HRh8RzCQ3OEpj05j4OcQqGk6akY7oHuN8fI9xNKk
         cmeSZjavDYPPDJnjq2EM92P53WIu/tDH1ODkpl5xFRvNz0xExmzf4sOiJ7sITD5ALr3r
         49Ru4U76c8mbbnDT6yeL9TzTANX5JEAAsFtpxaN5bRW39aHKWa0qSjeXVhxGS9c9XSB+
         sjUA==
X-Gm-Message-State: AOAM531F3ia5vc9u75IpuLPv4SFr3Tgqp26o+ee+KUu47WGDcIWdYSHY
        SBpadpynPGXJ+1n1DRB2j5Fc08sxekgtpPzFQ0K2ubs3MPM=
X-Google-Smtp-Source: ABdhPJwePVkBoLYvzdYmFFTTJ40fLmwarojjzR4z5mPSX5vuZd8vf2N8lchfHei1yAx1hdjsDBwh6ZyKreUqquutcwA=
X-Received: by 2002:ac2:5475:: with SMTP id e21mr1431414lfn.153.1606215907809;
 Tue, 24 Nov 2020 03:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-2-kpsingh@chromium.org> <20201124040220.oyajc7wqn7gqgyib@ast-mbp>
In-Reply-To: <20201124040220.oyajc7wqn7gqgyib@ast-mbp>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 24 Nov 2020 12:04:57 +0100
Message-ID: <CACYkzJ4i9qCgBRm3_pt19Tty4eR0RTMOg66f-_Rb7N3mBvgU8w@mail.gmail.com>
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

On Tue, Nov 24, 2020 at 5:02 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 20, 2020 at 01:17:07PM +0000, KP Singh wrote:
> > +
> > +static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
> > +{
> > +     return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
> > +}
> > +
> > +BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
> > +
> > +const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
> > +     .func           = bpf_ima_inode_hash,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_BTF_ID,
> > +     .arg1_btf_id    = &bpf_ima_inode_hash_btf_ids[0],
> > +     .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> > +     .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> > +     .allowed        = bpf_ima_inode_hash_allowed,
> > +};
> > +
> >  static const struct bpf_func_proto *
> >  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  {
> > @@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >               return &bpf_task_storage_delete_proto;
> >       case BPF_FUNC_bprm_opts_set:
> >               return &bpf_bprm_opts_set_proto;
> > +     case BPF_FUNC_ima_inode_hash:
> > +             return &bpf_ima_inode_hash_proto;
>
> That's not enough for correctness.
> Not only hook has to sleepable, but the program has to be sleepable too.
> The patch 3 should be causing all sort of kernel warnings
> for calling mutex from preempt disabled.
> There it calls bpf_ima_inode_hash() from SEC("lsm/file_mprotect") program.

I did actually mean to use SEC("lsm.s/bprm_committed_creds"), my bad.

> "lsm/" is non-sleepable. "lsm.s/" is.
> please enable CONFIG_DEBUG_ATOMIC_SLEEP=y in your config.

Oops, yes I did notice that during recent work on the test cases.

Since we need a stronger check than just warnings, I am doing
something similar to
what we do for bpf_copy_from_user i.e.

     return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
