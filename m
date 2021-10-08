Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909C342729B
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 22:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbhJHUvc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbhJHUvc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 16:51:32 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD46C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 13:49:36 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p2so11850615vst.10
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYxm6O21SZrENHB0JHdSK5fuL3Od9gNIe8RyyQkF4LI=;
        b=Lodlty7G+bxdcHune8E/SiARlgp2pN0AXjFGK8PlUNrzDIePE4waF1ojIbcefHt6vd
         efenq5BpyLjoIXAudirc9+51oSlU6VuGoUTJaJwzRunCrhLxvxeQfRNeUvalHZ4rdUG+
         DWOinwdQCoW5CxH2Silgq7iL/80/Xxafi4bNdVcCqbo9erOIra2Zpn8R98pt3Hvyxrwx
         xMvD10wxBOKiRY9GOd3fOV22DOqenmdLK3Nuq7kR+uTx40f0mmueTd1fVT4ZwxcWzXNz
         T9i6w09/OwPsG1nEQnA1iE1V1ay4NKePeZ2bsLrpILtJuHzHeJ/TDZGv5EpuYfgLe/NK
         dbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYxm6O21SZrENHB0JHdSK5fuL3Od9gNIe8RyyQkF4LI=;
        b=5Ih4H28tGO7g79ecVFynKSyLKo3OzY+25SjwdorgAytCYPusNDdud3A54nOTg8VXDv
         BY9oU/MuZ9PRKk3eKj7eZ4DSYwr+yiPeFWH1N2OKuJAMVbgwMD59gjCQpDofUt85UkJN
         IO+8M9vpkUf/xqPH5B6M7KV3gXqWtMU3TtRI5qLZ5RHzPQYWX1xJR0NsGcaN9gm3Esa9
         1FW92qLhJZWnRoLtKuRVLLyos/SLnMWuTpON7JE0zjkZ4+c1xcngVhjUbeV6pz02m8kG
         Azxs7anSX+ME8v60b4/v4udbT2PUUsHKSBszBh9h6i6E50z9jkeCSMfE9aw2M1RvR8nN
         mM8w==
X-Gm-Message-State: AOAM5316pUpGKguRvWq+EUStN+f5K5huOMFnCyGdM/UguUY7i4hpi+A7
        pdFLK8uGNNmlEnnYSqRe5gLHym6sfZl8PiWT8H9CVg==
X-Google-Smtp-Source: ABdhPJwMednv2H/1tNR+q2PYvS1DH4boc5gZesk+F+iJFJHt4ywgOqja3wNR36hfq3LTO8XWyqjt7ddf5ZFdOJyk2zg=
X-Received: by 2002:a67:c30b:: with SMTP id r11mr13727530vsj.20.1633726175601;
 Fri, 08 Oct 2021 13:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
 <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com>
 <YV8OBHd4/gdZ6tu3@google.com> <CAA-VZPkSGJC0akTFrfUduAn0zd0sjq8+bMHkyOsuiH5zXo5TeA@mail.gmail.com>
 <CAPhsuW6AfFd7-xa1TVXJJfg02wqQ5QHHv2xttND+NnW93wkh-w@mail.gmail.com>
In-Reply-To: <CAPhsuW6AfFd7-xa1TVXJJfg02wqQ5QHHv2xttND+NnW93wkh-w@mail.gmail.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Fri, 8 Oct 2021 13:49:24 -0700
Message-ID: <CAA-VZP=nSZmMjw8Fjk+ucz2X1hALhSKU3rdzSYN8KwEMegd0PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     Song Liu <song@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 9:34 AM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 7, 2021 at 9:23 AM YiFei Zhu <zhuyifei@google.com> wrote:
> >
> > Yeah it felt like we only needed one helper for the parameters and
> > return values to be unambiguous. But if two better avoid confusion for
> > users, we can do that.
> >
> > YiFei Zhu
> >
> [...]
> > > > >
> > > > > One question, if the program want to retrieve existing errno_val, and
> > > > > set a different one, it needs to call the helper twice, right? I guess
> > > > it
> > > > > is possible to do that in one call with a "swap" logic. Would this work?
> > >
> > > > Actually, how about we split this into two helpers:bpf_set_errno() and
> > > > bpf_get_errno(). This should avoid some confusion in long term.
> > >
> > > We've agreed on the single helper during bpf office hours (about 2 weeks
> > > ago), but we can do two, I don't think it matters that much.
>
> I see. If we agreed on this syntax, I won't object.
>
> Thanks,
> Song

Shall I do the swap then? I don't think it has been discussed, and I
don't see any downsides from doing so, but I don't really see a
scenario in which someone would want to get and set at the same time
either.

YiFei Zhu
