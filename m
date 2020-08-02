Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD372354F9
	for <lists+bpf@lfdr.de>; Sun,  2 Aug 2020 05:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgHBDaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 23:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHBDaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Aug 2020 23:30:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB0C06174A
        for <bpf@vger.kernel.org>; Sat,  1 Aug 2020 20:30:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v9so1774584ljk.6
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjaFJMtWZc3m3a8R4qxZQkJlRCWqF2xs8q0imRt/Qvg=;
        b=If1fplPt6sm/r3jSgrj+pEMP+1++i7ez9EELyBq3+EI3K32qh++/BpXtF3IVieyyA5
         gDC5/iEHJrHRSEnaYwZfaexUj1KxR0uBPY5bzM6B/KB8d787Fg0QsX4Bw0BhOfPEzOOx
         BLfXsZd4fxGhp4vJh6HfiurDhz8eaIecGqkm0ctUyBQe/MxIGf84NmHILE5AXJ5wTHs0
         c/pr7Rpy2VjQ09v/Mnc7y6Qn3wizhQmGPZnXrRFnMNeIN20Txm7OpX1NbNQlOTF/5pdx
         jrlbPMBOG99Qrd1MQz1Ps0Xx0Dn1EOXTLW2fSU28iK6et4I7WFGMc7WM6HMOjAF/uGdn
         /4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjaFJMtWZc3m3a8R4qxZQkJlRCWqF2xs8q0imRt/Qvg=;
        b=A+ItevXZe5wl/yk2c2a++QlmJE+oHzf1MTaZa5hHyILM9GIhgP0j8n5KpO7V7ftTNW
         RbF2fC/zTqw/IGE7hRuHSFlbeOo6/aAfyXuNYonwHSuKeOJAgo2vKmXCQoC79hQSqJ1V
         wdbUCMR32+Bm/0MsE/fydfcBX5YYjY/vb0WWHpKx3uG6dkcWf48U1id1zzrz2TybbtLk
         3M1Ll5/edQxqab3JdZ9YrhnXEZWSgf/7w+wlYpopKI5+zz6qMKH96QVKCR0d0kvsionl
         XVl0Fd3nJafrndb/PuvxrqJsxcGVWxDV9JKH4jrBNEsmp1rAllCN0Welur8pPK0NyGQ3
         MLog==
X-Gm-Message-State: AOAM530n7rEh/qblcX4qmaAYmHjAUcgaK2JFYAH5bwD37EcWVCve/6ne
        nwVgaLDOlRxWdW4KPmMhD8pkFptYJeQB33Fj2c0=
X-Google-Smtp-Source: ABdhPJzEiMWo+Sq2PdkX8eLgnsNpQWCKKvoFz2ffhS9+NEQAf/yKny7vfEj6Bwart2dR/JYtrPDzfQVpA/D4Sfxn86o=
X-Received: by 2002:a2e:a489:: with SMTP id h9mr5113076lji.121.1596339020247;
 Sat, 01 Aug 2020 20:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <159623300854.30208.15981610185239932416.stgit@john-XPS-13-9370>
 <159623335418.30208.15807461815525100199.stgit@john-XPS-13-9370> <CAEf4BzaXsve_=CfEzipd=wRLfDYSUdF6u5Myrd5E=F4qt=hGeg@mail.gmail.com>
In-Reply-To: <CAEf4BzaXsve_=CfEzipd=wRLfDYSUdF6u5Myrd5E=F4qt=hGeg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 1 Aug 2020 20:30:08 -0700
Message-ID: <CAADnVQKj3CKRPkXMPgCucLYKj8jhgvdxiz-CXmrnXi4uVhtkng@mail.gmail.com>
Subject: Re: [bpf-next PATCH] bpf, selftests: Use single cgroup helpers for
 both test_sockmap/progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 31, 2020 at 8:34 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jul 31, 2020 at 3:09 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Nearly every user of cgroup helpers does the same sequence of API calls. So
> > push these into a single helper cgroup_setup_and_join. The cases that do
> > a bit of extra logic are test_progs which currently uses an env variable
> > to decide if it needs to setup the cgroup environment or can use an
> > existingi environment. And then tests that are doing cgroup tests
> > themselves. We skip these cases for now.
> >
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
>
> makes total sense, thanks for the clean up!
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
