Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1803643BC5C
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 23:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbhJZV3T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbhJZV3T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 17:29:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3379BC061570
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 14:26:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bl14so505067qkb.4
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0x8zvgJhWOxibNxJcbFQB2Ec+ISL26TgiW2P+CR8us=;
        b=IW9QgU5VOHrzO2VCvzX7Yn/iyfZJIikNHLxO38e/B8K9jZzbJmHpOlUbaQdgm9pyW3
         WUDItmT0xBRL7EG/Qj08SDBxrf4jS17H16pYgko2F3rKMkfMSoJBz3J/ZVo65/gNlqci
         hOANVbMmzv8SIUtR76PxLPBl+b6bfhQUvDVkmGdJtLTkb95RhkdBKdpj5t3WTb+a5FAA
         eUzWIb20DKWNB4X60o3W5Wmdk4HdwjmOr0LJ86bNSI7AMC4IRmB4y62QaEURGmSjdkNJ
         7lNgI6xmkw1EFDMl4zUkNVbGTGyOVETWEP1cyYzE5jTt3cZXin8HrKWnzNrZY1K5kI/g
         444Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0x8zvgJhWOxibNxJcbFQB2Ec+ISL26TgiW2P+CR8us=;
        b=lbNUeE53QsCgU+xoy/LYx5ABwY7u926V+Uu9lIs53WekEMvlThpvtT6V0oq4w4TlYN
         6ulyXOCR3Zw0LqvybA9QSriEHtsk54UnLpDwfBweilq7WFYJyB0wCsOS75Rlkfh8LvzN
         551VEqnf2xkUAXaD2bAaEc4Cs5kwABzHbhChSykxpcAiTqWe7ztHNf752pV5J+o7sffO
         5HLP7NzKwV28iDTG8+FeUd93JQGOVJsHdtfW4stVqJkN4FZnKl4gHaL9zqKGKgJF0nLX
         fQR8vtSlQwv4MMw8AtTdsx+2zmLg/cvvq14a1N/PtW01d2AoWUo8Ie8dkGvUOWVib9Xa
         seIA==
X-Gm-Message-State: AOAM531bCirgaHrPZq+JxGqqXzSz/NC5i4J6rR+XqGiOaGEbNYw2fuk+
        scLLed7nrPmwT6SfQWstZawuQIKSmPi4iueyNH6H82oUpYQnvkks
X-Google-Smtp-Source: ABdhPJySV+oWF8SkfN/NQpPM+bw2at10D7Iyg1O81fEKprlHLacsmfR2BR6ytwKyN1WJjTgwrwGSWz1XmHk+vCBBM50=
X-Received: by 2002:a05:620a:4088:: with SMTP id f8mr13419506qko.355.1635283614030;
 Tue, 26 Oct 2021 14:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAEf4Bzbj0Bd5bnUrJMr4ozFFAHVE=NvsO1KR1o9=iqBT85=LUw@mail.gmail.com>
 <CAA-VZP=Hft3MkKxc+2xxM6Qc1ZO=d+2JshjV5g2TxfymjfW6rw@mail.gmail.com>
 <CAKH8qBs2xgqJnECSNpguqkwNMOd4m2gaz1CGueReP32cUdPgGw@mail.gmail.com> <CAA-VZP=rXb_oyoORsK5apL39xpY7XeVAdEQvVFhBqUBQOTxthA@mail.gmail.com>
In-Reply-To: <CAA-VZP=rXb_oyoORsK5apL39xpY7XeVAdEQvVFhBqUBQOTxthA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 26 Oct 2021 14:26:42 -0700
Message-ID: <CAKH8qBunq4LQGGuX9_L_3BMgPNOjqjZJrxK0ih6QnD_UYsAq6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 1:50 PM YiFei Zhu <zhuyifei@google.com> wrote:
>
> On Tue, Oct 26, 2021 at 8:44 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 5:06 PM YiFei Zhu <zhuyifei@google.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 4:28 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > it's subjective, but "bpf_export_errno" name is quite confusing. What
> > > > are we "exporting" and where?
> > > >
> > > > I actually like Song's proposal for two helpers,
> > > > bpf_set_err()/bpf_get_err(). It makes the semantics less confusing. I
> > > > honestly don't remember the requirement to have one combined helper
> > > > from the BPF office hour discussion, but if there was a good reason
> > > > for that, please remind us.
> > > >
> > > > > + *     Description
> > > > > + *             If *errno_val* is positive, set the syscall's return error code;
> > > >
> > > > This inversion of error code is also confusing. If we are to return
> > > > -EXXX, bpf_set_err(EXXX) is quite confusing.
> > > >
> > > > > + *             if *errno_val* is zero, retrieve the previously set code.
> > > >
> > > > Also, are there use cases where zero is the valid "error" (or lack of
> > > > it, rather). I.e., wouldn't there be cases where you want to clear a
> > > > previous error? We might have discussed this, sorry if I forgot.
> > >
> > > Hmm, originally I thought it's best to assume the underlying
> > > assumption is that filters may set policies and it would violate it if
> > > policies become ignored; however one could argue that debugging would
> > > be a use case for an error-clearing filter.
> > >
> > > Let's say we do bpf_set_err()/bpf_get_err(), with the ability to clear
> > > errors. I'm having trouble thinking of the best way to have it
> > > interact with the getsockopt "retval" in its context:
> > > * Let's say the kernel initially sets an error code in the retval. I
> > > think it would be a surprising behavior if only "retval" but not
> > > bpf_get_err() shows the error. Therefore we'd need to initialize "err"
> > > with the "retval" if retval is an error.
> > > * If we initialize "err" with the "retval", then for a prog to clear
> > > the error they'd need to clear it twice, once with bpf_set_err(0) with
> > > and another with ctx->retval = 0. This will immediately break backward
> > > compatibility. Therefore, we'd need to mirror the setting of
> > > ctx->retval = 0 to bpf_set_err(0)
> > > * In that case, what to do if a user uses ctx->retval as a way to pass
> > > data between filters? I mean, whether ctx->retval is set to 0 or the
> > > original is only checked after all filters are run. It could be any
> > > value while the filters are running.
> > > * A second issue, if we have first a legacy filter that returns 0 to
> > > set EPERM, and then there's another filter that does a ctx->retval =
> > > 0. The original behavior would be that the syscall fails with EPERM,
> > > but if we mirror ctx->retval = 0 to bpf_set_err(0), then that EPERM
> > > would be cleared.
> > >
> > > One of the reasons I liked "export" is that it's slightly clearer that
> > > this value is strictly from the BPF's side and has nothing to do with
> > > what the kernel sets (as in the getsockopt case). But yeah I agree
> > > it's not an ideal name.
> >
> > For getsockopt, maybe the best way to go is to point ctx->retval to
> > run_ctx.errno_val? (i.e., bpf_set_err would be equivalent to doing
> > ctx->retval = x;). We can leave ctx->retval as a backwards-compatible
> > legacy way of doing things. For new programs, bpf_set_err would work
> > universally, regardless of attach type. Any cons here?
>
> Is it a concern that AFAICT getsockopt retval may be a positive number
> whereas the err here must be non-negative?

getsockopt retval is either -errno or 0. It's not really enforced at
load/attach time, but there is a runtime check which returns -EFAULT
if the prog sets it to something else.

> Also the fourth point still stands. If any getsockopt returns 0,
> original behavior is return -EPERM whereas new behavior, clearing
> retval will clear -EPERM.

True, but do you think these cases exist out there? I guess somebody
can do it inadvertently, but the example you've mentioned doesn't
really make sense, right?
This is why we are adding a way to propagate the status, so the
programs in the chain can understand whether they should do anything
at all (previous prog returned EPERM). Returning EPERM from the child
and then doing ctx->retval=0 in the parent should already not work as
expected.
