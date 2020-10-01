Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EDE28093B
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 23:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgJAVIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 17:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgJAVIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 17:08:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161AC0613E2
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 14:08:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so10093153ejf.6
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xdqL6cUOxwNImAGbPqaJhmve2+c4zuAd6VkudhDv6E=;
        b=phZLfcc15Ka79PK3Ed6XBrK4N+ZNchA2bFO86TvVtOc950Psuk0y9/kQKkWgIvDSeN
         YjyuXO1K1p828Tf5OE/n0pHfpEA5q7Ti5DgUsCXz/b+lrDR3AIwZAZ5aFFmCwZxDQexR
         yiLOLcKi2SsRwqqdkcZX/NSe/StY1Vj+XY8mTic9gwB2uPErgZO4Or8u5UDVhhrxIPgl
         kUME/C0aR0S9tpgl96xnwhvLswQrUQ7hxN3ARq1prxVE/GoF1dmHi+a8V7BzMCHVB6Gt
         1c4gbLgTOkQ/FDI7bEwUfnqk/2GMkmm+DoOLn4VtQnptPaX5XUxk2PTcyV1juD/vL0VF
         uCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xdqL6cUOxwNImAGbPqaJhmve2+c4zuAd6VkudhDv6E=;
        b=nuLVn1tPygKCIXZSHZ0BFLqrjk8YEFLpTHU1rf5qLvrl6stp3Uny5kNb9CScZhr0MP
         qutb3J2JStxIN4vGkiAkF+G2ay8GhaR4eyd9sPs3hvBEBGYWwO/I0p/XuwDT0j0wNyYJ
         0K1p5wxaZ0sCUojkhAf3KEnWXX9DZTWppuuUzQ8iy5WWBuXsPpzijhmdC8TyoIDEgwHc
         CikNgorZcOgxY9k0XFOALupyXYfg0HhMnuih27LW8G90iQYkXLHnqi61bOuVALkJgW3x
         6Rry7S85wjmPt7FGC6rTagrP0MWqaiHIBBCNUQoNiqSGFpnnjPM6pNUdjOCrw859p3UD
         Y9LA==
X-Gm-Message-State: AOAM531lxt6g+NKzmaY0SCncnN6qlDKQit52rKclYRq5+FgAQCHYEcfT
        NJwcVXGVHTuPKD75cAdo/ot/kN9aptccPX6VC4xBzA==
X-Google-Smtp-Source: ABdhPJzGyqh4BsNemw68IZ7SVTAL/f1eGkoGoEq0lnwW+GNAxVmMi5sF8Ujp23KKrSIiuA0CtJc5Iz8q63h4ADYqoDo=
X-Received: by 2002:a17:906:980f:: with SMTP id lm15mr10444403ejb.184.1601586512571;
 Thu, 01 Oct 2020 14:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
 <CAG48ez0Njm0oS+9k-cgUqzyUWXV=cHPope2Xe9vVNPUVZ1PB4w@mail.gmail.com> <CABqSeASwCXaP_vNe1=E3EeWAApFYiB1S5xEb9BdH10b0rn0Q6A@mail.gmail.com>
In-Reply-To: <CABqSeASwCXaP_vNe1=E3EeWAApFYiB1S5xEb9BdH10b0rn0Q6A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 23:08:06 +0200
Message-ID: <CAG48ez2HSYocuJhR1uo4Ei8x8jPtUkYRYVWPuiJscEJdbckONw@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 1:28 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> On Wed, Sep 30, 2020 at 5:24 PM Jann Horn <jannh@google.com> wrote:
> > If you did the architecture enablement for X86 later in the series,
> > you could move this part over into that patch, that'd be cleaner.
>
> As in, patch 1: bitmap check logic. patch 2: emulator. patch 3: enable for x86?

Yeah.
