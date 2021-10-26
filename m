Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07BB43B5F0
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhJZPqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhJZPqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 11:46:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7AC061745
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 08:44:14 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gh1so9821946qvb.8
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2GzPZNMg/JdzGE2lvPwgBNsfPNDx1sHgiOkukSfcBw=;
        b=Xb48VzU/Df0wRzLF7U+LlhpCkT6iKyKOLkYTbLC4v+B92fxOxT903uGPYHRUYPzjGY
         q5Gph6BrDWmGTiUyUrmm1za+9ugJ69NCHNMf/2jRSaevAiIl0k+eOLmGw00/MJGLfHRF
         jiC/6YImJj58DPLiPk3TGfpdbv1LszfRE3I3RYBpcPZ0YEdr/DQZpLAqsU9jT1YbeGnc
         biXRwrJcdksp7wouTsjCNN0oyiI0mUvBtIaKS6s6zZ+H+BL+Tw9Xw+E/nw3Wuw/9vzc7
         5s0dPljugPoRen/8QUpIWcJDzVKhbrMDLhmQYzELODtHJITch4Yu18+1EHPnuA4rTrwN
         cK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2GzPZNMg/JdzGE2lvPwgBNsfPNDx1sHgiOkukSfcBw=;
        b=avIQ6kiRnFyJtWuDSp7dfocfDKJeBRq1IAck0QXFdFhDrvsSbWRLlsLrbxlBPDE6BF
         3oA7rnQ2jKCROAurNn00o6jaPvXqhlIujhRnC79e78wad4g7c1H0y4gS6cFuuY01U5q1
         hBNs7hoefosSN5HL/58w8OU5X1Bmc23RHLuhUWt+7W+lHMRIc01dfacbiqX/s9s3Kw46
         ApUNYT8P0ZwHP8wXZhMeIHxHlL+oaDMZhsVQ2zcxQ3nMsaGN74QTzFTGdGdcm7717s2Z
         JteD+nqRP2c3+sWhYOGb8vZMcSBCumIbuYsh8HnMlJFgGS4Q2nQuey9rUqeP2bUBwjyP
         wHVA==
X-Gm-Message-State: AOAM532DLRmaqPZz+sIVkvE3TtnTXwaRT+Z3xoWW2XBQcuk2Ixy34kWZ
        rsdJKSH+mBqlYMihgYqEMBSGEf/fAKcfKmOWlc/g1Q==
X-Google-Smtp-Source: ABdhPJzpPLV+e2JD6aF1jUw+WolURFaJ4EuY4JVwWoagp8nPb/mLXH3nHp312QHdcf3z9zU6gPCaDOWGaoUav6VvC0k=
X-Received: by 2002:a05:6214:21e6:: with SMTP id p6mr18193233qvj.10.1635263053706;
 Tue, 26 Oct 2021 08:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAEf4Bzbj0Bd5bnUrJMr4ozFFAHVE=NvsO1KR1o9=iqBT85=LUw@mail.gmail.com> <CAA-VZP=Hft3MkKxc+2xxM6Qc1ZO=d+2JshjV5g2TxfymjfW6rw@mail.gmail.com>
In-Reply-To: <CAA-VZP=Hft3MkKxc+2xxM6Qc1ZO=d+2JshjV5g2TxfymjfW6rw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 26 Oct 2021 08:44:02 -0700
Message-ID: <CAKH8qBs2xgqJnECSNpguqkwNMOd4m2gaz1CGueReP32cUdPgGw@mail.gmail.com>
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

On Mon, Oct 25, 2021 at 5:06 PM YiFei Zhu <zhuyifei@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 4:28 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > it's subjective, but "bpf_export_errno" name is quite confusing. What
> > are we "exporting" and where?
> >
> > I actually like Song's proposal for two helpers,
> > bpf_set_err()/bpf_get_err(). It makes the semantics less confusing. I
> > honestly don't remember the requirement to have one combined helper
> > from the BPF office hour discussion, but if there was a good reason
> > for that, please remind us.
> >
> > > + *     Description
> > > + *             If *errno_val* is positive, set the syscall's return error code;
> >
> > This inversion of error code is also confusing. If we are to return
> > -EXXX, bpf_set_err(EXXX) is quite confusing.
> >
> > > + *             if *errno_val* is zero, retrieve the previously set code.
> >
> > Also, are there use cases where zero is the valid "error" (or lack of
> > it, rather). I.e., wouldn't there be cases where you want to clear a
> > previous error? We might have discussed this, sorry if I forgot.
>
> Hmm, originally I thought it's best to assume the underlying
> assumption is that filters may set policies and it would violate it if
> policies become ignored; however one could argue that debugging would
> be a use case for an error-clearing filter.
>
> Let's say we do bpf_set_err()/bpf_get_err(), with the ability to clear
> errors. I'm having trouble thinking of the best way to have it
> interact with the getsockopt "retval" in its context:
> * Let's say the kernel initially sets an error code in the retval. I
> think it would be a surprising behavior if only "retval" but not
> bpf_get_err() shows the error. Therefore we'd need to initialize "err"
> with the "retval" if retval is an error.
> * If we initialize "err" with the "retval", then for a prog to clear
> the error they'd need to clear it twice, once with bpf_set_err(0) with
> and another with ctx->retval = 0. This will immediately break backward
> compatibility. Therefore, we'd need to mirror the setting of
> ctx->retval = 0 to bpf_set_err(0)
> * In that case, what to do if a user uses ctx->retval as a way to pass
> data between filters? I mean, whether ctx->retval is set to 0 or the
> original is only checked after all filters are run. It could be any
> value while the filters are running.
> * A second issue, if we have first a legacy filter that returns 0 to
> set EPERM, and then there's another filter that does a ctx->retval =
> 0. The original behavior would be that the syscall fails with EPERM,
> but if we mirror ctx->retval = 0 to bpf_set_err(0), then that EPERM
> would be cleared.
>
> One of the reasons I liked "export" is that it's slightly clearer that
> this value is strictly from the BPF's side and has nothing to do with
> what the kernel sets (as in the getsockopt case). But yeah I agree
> it's not an ideal name.

For getsockopt, maybe the best way to go is to point ctx->retval to
run_ctx.errno_val? (i.e., bpf_set_err would be equivalent to doing
ctx->retval = x;). We can leave ctx->retval as a backwards-compatible
legacy way of doing things. For new programs, bpf_set_err would work
universally, regardless of attach type. Any cons here?

> > But either way, if bpf_set_err() accepted <= 0 and used that as error
> > value as-is (> 0 should be rejected, probably) that would make for
> > straightforward logic. Then for getting the current error we can have
> > a well-paired bpf_get_err()?
> >
> >
> > BTW, "errno" is very strongly associated with user-space errno, do we
> > want to have this naming association (this is the reason I used "err"
> > terminology above).
>
> Ack.
>
> YiFei Zhu
