Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466BA425809
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 18:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbhJGQgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 12:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233594AbhJGQgv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 12:36:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D68A61260
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633624497;
        bh=8AAElrhCxWcNzkVh1+h2ybQhUnPSITF8RpO5ti+Ud5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3jQu95ADpghYhzIwBQ/9PFpiVOBJuGaRDEmlHslDyE7//5NdOc8iajFWgCcxYUW9
         MnqpsAX3mhIwA/5o4LNUHAObM+CwzhDySavaBFfWKSLPOtNWlfCzia9LFQpN9kjeGn
         GJGIGQ6TOJFaa5Tokdws8vlx4aw589j/tXlzktJdjdauGLQGKevloqW28L2IB/9E8Y
         U0tZ8r/1l2El+ipP2Im/YlrYVz5ujV13VLet27uc+VG3IqkKa2IC2eqWrFH0tldPhn
         M1v59FrtYT753Eq7kYqE3YepTNA9mF7O5Qh+x2BT0U5C8NoWzaEExNCl16pVq1jSIw
         TaaHoYm7xTbkg==
Received: by mail-lf1-f44.google.com with SMTP id z11so19023564lfj.4
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 09:34:57 -0700 (PDT)
X-Gm-Message-State: AOAM532oklsaCWkmlBAkkfXz2nSpOp7Y4G8brPvghrEC7tGh7oE7Zjaj
        jMDWUqoR40PacFeDu/UTK71BFughBDypfUjYuOY=
X-Google-Smtp-Source: ABdhPJyXzC8VAL6pxB7sxR4IGjmvrpu4EhNmr6eSsN9qa5a4ZhtpG4kyPCdk3RR/hox0IZlJfXtXjSP14LUlLVjPDFY=
X-Received: by 2002:a2e:3907:: with SMTP id g7mr5728027lja.285.1633624488000;
 Thu, 07 Oct 2021 09:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
 <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com>
 <YV8OBHd4/gdZ6tu3@google.com> <CAA-VZPkSGJC0akTFrfUduAn0zd0sjq8+bMHkyOsuiH5zXo5TeA@mail.gmail.com>
In-Reply-To: <CAA-VZPkSGJC0akTFrfUduAn0zd0sjq8+bMHkyOsuiH5zXo5TeA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 09:34:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6AfFd7-xa1TVXJJfg02wqQ5QHHv2xttND+NnW93wkh-w@mail.gmail.com>
Message-ID: <CAPhsuW6AfFd7-xa1TVXJJfg02wqQ5QHHv2xttND+NnW93wkh-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 9:23 AM YiFei Zhu <zhuyifei@google.com> wrote:
>
> Yeah it felt like we only needed one helper for the parameters and
> return values to be unambiguous. But if two better avoid confusion for
> users, we can do that.
>
> YiFei Zhu
>
[...]
> > > >
> > > > One question, if the program want to retrieve existing errno_val, and
> > > > set a different one, it needs to call the helper twice, right? I guess
> > > it
> > > > is possible to do that in one call with a "swap" logic. Would this work?
> >
> > > Actually, how about we split this into two helpers:bpf_set_errno() and
> > > bpf_get_errno(). This should avoid some confusion in long term.
> >
> > We've agreed on the single helper during bpf office hours (about 2 weeks
> > ago), but we can do two, I don't think it matters that much.

I see. If we agreed on this syntax, I won't object.

Thanks,
Song
