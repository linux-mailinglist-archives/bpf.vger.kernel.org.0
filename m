Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED86C1B82A3
	for <lists+bpf@lfdr.de>; Sat, 25 Apr 2020 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgDYAJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 20:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgDYAJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 20:09:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B47C09B049;
        Fri, 24 Apr 2020 17:09:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n6so11730959ljg.12;
        Fri, 24 Apr 2020 17:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5cKKHZYJwuKSuEqR5ZiVBhdRL4Rag1Afgs863r/t+c=;
        b=TT4oHx+VSNuq4rtayhAn+ofi4QkTOalHjuR7F8Lw1bSjDHt3jU5NJckmzZ8BYYjTBe
         A74LdNLssoI/3zhjIgPNFgmaSkQGYXzGH2w77+RnWjJGsqfQoSei5XdxdWYxAzrAIAA1
         f2Hrm/Dw0SbrcjGi2ap1bplX7UuMnCCs9fO3J3c74OVQ30ji4Rfkr7827YVg88zmOdIN
         2zO4a/SXFeqH7ySjIqD6qyVZ3KFh2QDpSiXRP1XzY07QJZ5RirrRi+U4H5XlUwkAm8Ii
         ErnqISREBRS3baaOfIh0XMf1Uyh5nZxzhr0t4lQbsdfAQQCEQzMpaSHTI7lKQhC6TvhG
         n7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5cKKHZYJwuKSuEqR5ZiVBhdRL4Rag1Afgs863r/t+c=;
        b=bRzvnaVnkjPr27MBcAWuiWeaTYoTPe0nHTOSkwrl+G03PcHfZf++JO4LuKnUvxDBfu
         bUUDwarqU43YlyhRLgKRqK83Y3tiFMf8mLPvr/2+MsS1dw/rlsE7tfV07syvroqcGebY
         p5KeuIliR65d0gXna5rY39QrSVVPRQra7tY2kZtifKcIqgXvfnn+Ya8YCR5hd/mrFnFe
         tvacSY9oUmevlskAom+I9WqNUai9s71k0r5/v4+EG+LibDw/SIYYCfUeU1s3gQ7MpLkc
         WH9Np5h2dkZ86SRJM32z/oAYdxiTraL1Akja07PWzb3idM//Exh1SBKje3nKz4ttoPmB
         R6GQ==
X-Gm-Message-State: AGi0PuaXx/eXSDnsMubWlvZ5vE5fvosblG1AGgF/OM/SzRwDE8LN5egR
        c1IAIQLVo8F06GX6EuxtNwfHYJ13dQSaQtIfG+TnXA==
X-Google-Smtp-Source: APiQypKWJx/CTDNKedZzIqdgAJUTi82H210rWYuLwvSAPQApXcvL6SkqQIQMXtA+cZw80WOF3pMylsU4ur1fWxZoJIk=
X-Received: by 2002:a2e:a169:: with SMTP id u9mr7695231ljl.144.1587773364116;
 Fri, 24 Apr 2020 17:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200420144753.3718-1-jwilk@jwilk.net>
In-Reply-To: <20200420144753.3718-1-jwilk@jwilk.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Apr 2020 17:09:12 -0700
Message-ID: <CAADnVQ+v6LZneSjO6NHVkTZGXJcHFB=RrbcFE8b3o6J3--j9Wg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix reStructuredText markup
To:     Jakub Wilk <jwilk@jwilk.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-man <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 20, 2020 at 7:56 AM Jakub Wilk <jwilk@jwilk.net> wrote:
>
> Fixes:
>
>     $ scripts/bpf_helpers_doc.py > bpf-helpers.rst
>     $ rst2man bpf-helpers.rst > bpf-helpers.7
>     bpf-helpers.rst:1105: (WARNING/2) Inline strong start-string without end-string.
>
> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>

I think that's bpf tree material. Applied
