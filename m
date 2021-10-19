Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6ED433CEB
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJSREi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 13:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSREh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 13:04:37 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FBCC06161C
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 10:02:24 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id t127so11714219ybf.13
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RwNTTMrfaqGLj3rNckVBrgnhQVZiiZOMY8dMvftt58=;
        b=Hltj3bl9g1XB9ZLMOW0PuRt5uTcTvedMZd50zvcKivl4CAM/9KpFiwkR1ODS7JKuqv
         fM5GoOeuLn325LpA9aASko3rLRGggdy97BOn55UKrNbApFSe+dSe0oZdoBCOywQOxO/L
         RzNID2QK21WrQD+Z4KRlykAaUElIfwNiIuWttbJouOIHVW2//a1bCz+ebgdVI4b06py9
         VB1AdjPjnnDjgR5bX3X8XwaaR+RMYThTwT0nUGo+Nf8leu7+c20GqKOQLssFy84vJ1vu
         V0i/loYv63qlqxy0QfS6nkCxQ9pKmAjK+gLdtFzLLqvc05mqASADVRzvZlda241B79Gd
         VAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RwNTTMrfaqGLj3rNckVBrgnhQVZiiZOMY8dMvftt58=;
        b=3VgpToE5T4dy4nJf8a2buS8E3MbvGepLDNzSrrPssK/fhNJYDTcnXRbtu6XoGluLDP
         vjnmbIq7zvedFw7ul940z+5hUC8hl9tZauVOA8zLjyu39hGoOHaaZd3d6TdXwAAEafDm
         O4XN/ma7N5WV+yKBydon3XJeFmcPw4p8DiJlhTToabtVmBioD3oiy9RDrQHTf8L3lBkp
         Z4fS93e+KoRkQNS1hCO1WDpV3HoGujsOomakVfNSHQEdFEV15uOIiR2SLJf5+JB5FvfT
         6iD1RzUGzFziENotPtUa5i2TTw3YFZdoTjF0jJ7au7PGqPhP+HTGtdOg7f9GQK9+I4Ze
         Ej/A==
X-Gm-Message-State: AOAM5322mkRBtj3LzzD/eUJN8F8VpS80V75lVcTmjf/iRK/QrAUyMiOX
        ACnvNCtD6IaVkkT09SSriSvlKamFlv20T96nnoxsLp+qy94=
X-Google-Smtp-Source: ABdhPJxyqFmH+eBgbehmhYwHiKS1WkNGshOHug7zHXgj4uYGHUVctc3KIDLo9CFhtGjVFxxzFeFvXNV/OWFa3zAGO+w=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr34716927ybh.267.1634662943779;
 Tue, 19 Oct 2021 10:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211007141331.723149-1-hengqi.chen@gmail.com>
 <20211007141331.723149-3-hengqi.chen@gmail.com> <CAADnVQLGfg=iMUi4oQtMzY9Y+j_pZtAAHQ_b8zO6wPaL6C0ooA@mail.gmail.com>
 <10abc62b-a263-b157-912f-363ae1f80a4c@gmail.com>
In-Reply-To: <10abc62b-a263-b157-912f-363ae1f80a4c@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Oct 2021 10:02:12 -0700
Message-ID: <CAEf4BzaiCMSnzXntfbcmSDO4u7TM-f0OO0NZThvbYA9GR6A7dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2 v2] selftests/bpf: Test bpf_skc_to_unix_sock()
 helper
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 19, 2021 at 8:23 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Thanks for the review.
>
> On 10/19/21 9:46 AM, Alexei Starovoitov wrote:
> > On Thu, Oct 7, 2021 at 7:14 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >> +
> >> +       sockaddr.sun_family = AF_UNIX;
> >> +       strcpy(sockaddr.sun_path, sock_path);
> >
> > please use strncpy.
>
> Will do.

please also run checkpatch.pl and confirm you haven't introduced new
styling issues. As one example (and please fix this up in the next
revision), you are using C++-style comments.

>
> >
> >> +       len = sizeof(sockaddr);
> >> +       unlink(sock_path);
> >
> > please use abstract socket to avoid unlink and potential race.
> >
>
> Will switch to abstract socket and update the BPF program.
