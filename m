Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181A22890D4
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbgJISci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbgJISci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:32:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1146AC0613D2;
        Fri,  9 Oct 2020 11:32:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g10so7574476pfc.8;
        Fri, 09 Oct 2020 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXMI+PJKiZyAcZLy7HAh04DXC9PBpofk3SlWAnaKUzo=;
        b=sNrNF6ck7NJ2QfAd6RQi7Knon7r6ENYFOWVpv5tnOeOKqRvn+KzubtO6ebUIwOxTSL
         6LTsxmt+BXSNfjUdNzXi6nRS4tbViLgm9hgfrV5A9UTQKwpZ8HXPYF2ACfo8LlS77JmR
         yxQtnaW69CrshyvExgocB1z248AiO6z4ZwAvJaIhMpjmcoyeSBfso7HVf8hqHpCSMFda
         6o325i7ZzqR7iJ3Txs8/IBVF/pmXdK89XXURcwAQb2bj6sI/hdLn+E3p7fKMELUR1Lcj
         nOAll45kTvT8d0EdT3JuFtc8ICxZEY8yBMtiHqY1wNEX/2hHp/P615vKRkGhxZ0A4NQp
         Rlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXMI+PJKiZyAcZLy7HAh04DXC9PBpofk3SlWAnaKUzo=;
        b=GatrHpyiYMtMVjJ6agVLevnsBN8FxwheUcXv82C3riMO06JbNPtsdz5Paoeymytwg2
         gRJiCgVWlgyCnmXWEJmZsSqdJwvkKwRf7yj/1N2GLsDssyq4fxyxc7GkQfnqAgQVo672
         Aj5c0m2LDq9p+MRCCf1oG299DiVlcK/G3GuVg6zGpyG3dG+I9X8VcdHKo9azkLD0Ec+o
         LikqXXUOjTeYjZ2ghBADFEwcI8XPyE5WHGn7m8paZSZMpOfnOTeqn7+2z7c6RCqElLQe
         OnZ0hb/allnXOrYNnbYe8ul2tgPsMN6X8sfJ17Lb8aU6W3RnfKuinGFF0WgV7v2iOOKC
         3zhA==
X-Gm-Message-State: AOAM532fKjeSlp7I8Mcprf/wJWDqY0xc8/4u3Zd6LfB17G6EgaW4qFUQ
        +JbRV4gsB/oGqIvmNKmdRRUBuKc3GMNP9WVBL2g=
X-Google-Smtp-Source: ABdhPJxciReanT1Tdqe2uibnZF7nLBpm1gqiuEy9LFZcUHLNw4KhnEvEKGdB/rXbOZcI4Bv2/uX73t0hHNm3BA+VqX8=
X-Received: by 2002:a63:1c19:: with SMTP id c25mr4487332pgc.66.1602268357586;
 Fri, 09 Oct 2020 11:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <122e3e70cf775e461ebdfadb5fbb4b6813cca3dd.1602263422.git.yifeifz2@illinois.edu>
 <CALCETrUD7z3-zL_rATzTyDUzgerOzXJHdn-hntNMG=vnX8ZF2w@mail.gmail.com>
In-Reply-To: <CALCETrUD7z3-zL_rATzTyDUzgerOzXJHdn-hntNMG=vnX8ZF2w@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Fri, 9 Oct 2020 13:32:26 -0500
Message-ID: <CABqSeAS0WdkLHGMg3TRKkzsUE=JJYwY4iuBgYpdp-kLd9ASOfg@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 3/5] x86: Enable seccomp architecture tracking
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
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

On Fri, Oct 9, 2020 at 12:25 PM Andy Lutomirski <luto@amacapital.net> wrote:
> Is the idea that any syscall that's out of range for this (e.g. all of
> the x32 syscalls) is unoptimized?  I'm okay with this, but I think it
> could use a comment.

Yes, any syscall number that is out of range is unoptimized. Where do
you think I should put a comment? seccomp_cache_check_allow_bitmap
above `if (unlikely(syscall_nr < 0 || syscall_nr >= bitmap_size))`,
with something like "any syscall number out of range is unoptimized"?

YiFei Zhu
