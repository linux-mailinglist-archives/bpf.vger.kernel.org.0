Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16CF40BC88
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhIOAUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOAUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 20:20:46 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB0C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:19:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i12so1923070ybq.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biE0AjKRZJZQ/W4jD5I/pnFo2VC77AR4C+F2mK/mHNU=;
        b=ZFlqI+l2UtRJrHBx2lNAR7Du8i1JyxDUs78coMUIOX8hPKZNquVF/6qRl60Yr+oj4/
         4qNWPXgF9p/7veyCFZOfB+fdOok3L1dC0Ac7XalCLcVCrTBS/MxvhTKy7QHBYmq1jj+i
         8EMsh2wONZpxQicIp13tC8XRLt+sRXn6DDsPd29Aoq6utX1fVkf2eNF5K3C4RCQmgU6M
         GWg+E2LwkDUQf6oWkisNjCACGlqsmcz7I9Jt//+cVeExvo0ESmLkuFX2gYDBh76tCVD1
         iDP6rsV1Oaiqa6yataxsI+fWyRmrUEwgksJLur8TwunuqPWIAXRfMhGJThneINp8vSQp
         yeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biE0AjKRZJZQ/W4jD5I/pnFo2VC77AR4C+F2mK/mHNU=;
        b=fghSRsUW9UcUOj0q2MeEHZF/yd/02iuo64ScRvDr5OjyJhJmRNvepJYNrkldLdVtuo
         VKVjthS15IhdhrBZlKNCO+5kWuL27214ztSyrM0VGmhNpTIx62vaiAHTuHd2V+AroS/T
         p8ceDbFZZ2ygXjTA3KI63YukPcGn6a36IPj9SABa2uI600u+ZJLw9MLNjqNqRJAciORn
         ODZjixC27dmhD4IlzHikkBLAvIv8tVlJ/wt6esKKZmuP5UnoNrvU6UHHAISNv6BAh6hI
         kY6UVBpcbJKm+THrm8T21AY2hGn16Vb+ZmTNwBa9HqTu0gsRfiAovgJA4/wdAyU/NtEv
         KHIA==
X-Gm-Message-State: AOAM5314dCyp5MWwxx8S6xDwgFmUv55Q2rpfKGG3jJoAaJM56+hyhYpp
        xtSRC8rBQ9qMuIdbZ1G84yAEb5RGfWzxml+D73s=
X-Google-Smtp-Source: ABdhPJxyAoGqBO8dfURmRWgPhjjYptPmQqvQDRhHgvGf4o1uit8AHd5PAu4+ntCNCWF1vnKkwjs/rAvuWneMIL/SUO4=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr2512193ybj.504.1631665168349;
 Tue, 14 Sep 2021 17:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223004.244411-1-yhs@fb.com> <20210914223047.248223-1-yhs@fb.com>
In-Reply-To: <20210914223047.248223-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 17:19:17 -0700
Message-ID: <CAEf4BzbV8=C2b72qbbgFPBM2gLBj1UdqE570A+7Ozy9_kRyq_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/11] selftests/bpf: add BTF_KIND_TAG unit tests
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> Test good and bad variants of BTF_KIND_TAG encoding.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/btf.c | 245 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_btf.h       |   3 +
>  2 files changed, 248 insertions(+)
>

[...]
