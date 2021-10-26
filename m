Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB1C43BBDC
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhJZUxZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 16:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbhJZUxP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 16:53:15 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA02C061570
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 13:50:51 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id v20so807389uaj.9
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmAl29wWZl/S5WdiOnepIWwsetIEf4lpQTaOOvSX1I4=;
        b=dZJ5UugXWavGyed3Bt/KBKAKps9W7gXHp60pk4qMPgeoERwyF6zpJPVcstCEXH4UP7
         PvyD+1AEVv9ma57O7ga7X79hdsMbTy9GH8IEkfHPpmCGLekFuGs4A+wxf90uVgVwTpdy
         d+lRbmafRNhmXQoOWLuC3h7tZZyfQv/Smfr6FDrQcKT/ywfjYYPXgN26rxwuVfi/QjMD
         VbUE5iy24NbbRB8SK6PiqYPZ/VHPA0apf6zzMGc9BuLRVGUYA9D/7B56IZOjkKOBUoST
         eNTSNK5T2UnR3PWmDHivE0KC/Jo5nYsNYUv9mtvQs+0AlKSkw96h74vOpv2x6wP785e7
         FGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmAl29wWZl/S5WdiOnepIWwsetIEf4lpQTaOOvSX1I4=;
        b=TIq2/EJEqKHq94TyIcioNr+6GaFhfeGfBOGNS+3WyWB4t56FxcBjaf0aqLIl2c6qzV
         /g4E4z/bq5bWEiEJIQlJ//i8jZAa45wFDraHetknm5LZRdAq6yVJN7UvRAE/xmUSFpPI
         pnVXSZPCSG5xmNsKpE9CbOR5M4bcZJHdVcNZbzLl8OWHJsYFhQ2wTpBuAZWm6bGhwkDw
         Kby5BzVHUMm03jdXZHJuIoDKlV/u/hVV4QHBfmcTkGz1C/pv31rTpQM4xfZtDMGwko6k
         GcJBrE/kol2/IkKDZw4JoDqpZP4IIopkvY1kKpH7Uwrf19XAArvmUV9Bsxx8J0uAOgD4
         2BCQ==
X-Gm-Message-State: AOAM531wut914dyLc6A34lxNBDcyfjwi+6sMHPfC5Kif5UmSaf1i0SsB
        IBsg8KlIm8ag4uqC+QcSdnkXYEtCRZOBL/A7H0jWqaXgcfQ=
X-Google-Smtp-Source: ABdhPJx12XpkltoDp+0SDj8Q70VHWtj5ruB+KBTF9RW/KFzmcqxehtY6EHrOf49OjaTKyNNCmlrqunAMGqHRjmDt04A=
X-Received: by 2002:a67:ebcf:: with SMTP id y15mr10393089vso.43.1635281450611;
 Tue, 26 Oct 2021 13:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAEf4Bzbj0Bd5bnUrJMr4ozFFAHVE=NvsO1KR1o9=iqBT85=LUw@mail.gmail.com>
 <CAA-VZP=Hft3MkKxc+2xxM6Qc1ZO=d+2JshjV5g2TxfymjfW6rw@mail.gmail.com> <CAKH8qBs2xgqJnECSNpguqkwNMOd4m2gaz1CGueReP32cUdPgGw@mail.gmail.com>
In-Reply-To: <CAKH8qBs2xgqJnECSNpguqkwNMOd4m2gaz1CGueReP32cUdPgGw@mail.gmail.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Tue, 26 Oct 2021 13:50:37 -0700
Message-ID: <CAA-VZP=rXb_oyoORsK5apL39xpY7XeVAdEQvVFhBqUBQOTxthA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 8:44 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Mon, Oct 25, 2021 at 5:06 PM YiFei Zhu <zhuyifei@google.com> wrote:
> >
> > On Wed, Oct 20, 2021 at 4:28 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > it's subjective, but "bpf_export_errno" name is quite confusing. What
> > > are we "exporting" and where?
> > >
> > > I actually like Song's proposal for two helpers,
> > > bpf_set_err()/bpf_get_err(). It makes the semantics less confusing. I
> > > honestly don't remember the requirement to have one combined helper
> > > from the BPF office hour discussion, but if there was a good reason
> > > for that, please remind us.
> > >
> > > > + *     Description
> > > > + *             If *errno_val* is positive, set the syscall's return error code;
> > >
> > > This inversion of error code is also confusing. If we are to return
> > > -EXXX, bpf_set_err(EXXX) is quite confusing.
> > >
> > > > + *             if *errno_val* is zero, retrieve the previously set code.
> > >
> > > Also, are there use cases where zero is the valid "error" (or lack of
> > > it, rather). I.e., wouldn't there be cases where you want to clear a
> > > previous error? We might have discussed this, sorry if I forgot.
> >
> > Hmm, originally I thought it's best to assume the underlying
> > assumption is that filters may set policies and it would violate it if
> > policies become ignored; however one could argue that debugging would
> > be a use case for an error-clearing filter.
> >
> > Let's say we do bpf_set_err()/bpf_get_err(), with the ability to clear
> > errors. I'm having trouble thinking of the best way to have it
> > interact with the getsockopt "retval" in its context:
> > * Let's say the kernel initially sets an error code in the retval. I
> > think it would be a surprising behavior if only "retval" but not
> > bpf_get_err() shows the error. Therefore we'd need to initialize "err"
> > with the "retval" if retval is an error.
> > * If we initialize "err" with the "retval", then for a prog to clear
> > the error they'd need to clear it twice, once with bpf_set_err(0) with
> > and another with ctx->retval = 0. This will immediately break backward
> > compatibility. Therefore, we'd need to mirror the setting of
> > ctx->retval = 0 to bpf_set_err(0)
> > * In that case, what to do if a user uses ctx->retval as a way to pass
> > data between filters? I mean, whether ctx->retval is set to 0 or the
> > original is only checked after all filters are run. It could be any
> > value while the filters are running.
> > * A second issue, if we have first a legacy filter that returns 0 to
> > set EPERM, and then there's another filter that does a ctx->retval =
> > 0. The original behavior would be that the syscall fails with EPERM,
> > but if we mirror ctx->retval = 0 to bpf_set_err(0), then that EPERM
> > would be cleared.
> >
> > One of the reasons I liked "export" is that it's slightly clearer that
> > this value is strictly from the BPF's side and has nothing to do with
> > what the kernel sets (as in the getsockopt case). But yeah I agree
> > it's not an ideal name.
>
> For getsockopt, maybe the best way to go is to point ctx->retval to
> run_ctx.errno_val? (i.e., bpf_set_err would be equivalent to doing
> ctx->retval = x;). We can leave ctx->retval as a backwards-compatible
> legacy way of doing things. For new programs, bpf_set_err would work
> universally, regardless of attach type. Any cons here?

Is it a concern that AFAICT getsockopt retval may be a positive number
whereas the err here must be non-negative?

Also the fourth point still stands. If any getsockopt returns 0,
original behavior is return -EPERM whereas new behavior, clearing
retval will clear -EPERM.

YiFei Zhu

> > > But either way, if bpf_set_err() accepted <= 0 and used that as error
> > > value as-is (> 0 should be rejected, probably) that would make for
> > > straightforward logic. Then for getting the current error we can have
> > > a well-paired bpf_get_err()?
> > >
> > >
> > > BTW, "errno" is very strongly associated with user-space errno, do we
> > > want to have this naming association (this is the reason I used "err"
> > > terminology above).
> >
> > Ack.
> >
> > YiFei Zhu
