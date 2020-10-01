Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7A280930
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 23:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbgJAVIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJAVHi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 17:07:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E99C0613D0;
        Thu,  1 Oct 2020 14:07:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 197so282951lfo.11;
        Thu, 01 Oct 2020 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxSV6KP1sYpnn0fNmPAD/6UI5HEzDeYZGjqxdItXiSs=;
        b=CuaZ+5kyq5/y9MkSEyf+zwfjUU0Rq/VvwrD9c2VlxRn/qKcHw0i1asxojNiOU/5fkK
         0xwOzwPKA38GIvpwCvs9mBKy5y+m83BwOSyFRy0yJBxp6DgsmsYLsOd91ii5zkc7TcjW
         y+qTL0SPwd6VO7LukV1BvPQ3j/njQsiQQBfGvi6HDY8Uj5a3JP0Qaas3F8CTUOYVOs0S
         P8mOWUu7d1n8h2iPXMB5cqVIc0sDfA1tF9LeCyEykxPW3aTZQ4VJ6L3SUq/xv28SS1Ll
         uXBkDaZmlunbP8BzuWv6PFiFFscmTq9pZtR01sRyU5hPKa6llovzeT6c2C1Xaasiimck
         d0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxSV6KP1sYpnn0fNmPAD/6UI5HEzDeYZGjqxdItXiSs=;
        b=hMUtEPsTq0X5Czm++4v7ciO4Z531aSA2/qQAXIOueMzxL62AKeOdwULj+BP/SC04/A
         oHcttlFgh1Cqs+kyKvy8G+5tqRvcIIYUWngobldmA9kcVAGZINd//7xyF5pXvX0cl3Ht
         6mzdRRo8U79640W5GgE5MG2ocqfwyaa7Bog3kvjDDT0QsO2iwim/MP1ETKTNFBmBSqNJ
         1eh5rMFJDq7YqPKsCog+NwAiYZoURwHsZpPHB9zdn0g3PJ8a5jzxbI7CmIfWEesA2pNj
         1VfSfFCQeSFuA4KGjB9opE/XEVLKy3XxAVqFd1uA6yfaVjoqBoI3GyFY9NqUmVAxsoEj
         K0ZQ==
X-Gm-Message-State: AOAM530LTkpekt360xr6JAGepbMpanDO+bakK4kHWuTFlt2uaGztZqQ+
        eEzde3A2TB9W/ooow1WlkQkHd1WZjE804gDANoo=
X-Google-Smtp-Source: ABdhPJxNkdzx1ezQRGJdP+nTpo+QaSyVFo/gF5MBwQ8b07eVgtdM/MOoFpaH0KY79dx4Ea39tU7J6RYaUKq2zswCKoU=
X-Received: by 2002:ac2:48ab:: with SMTP id u11mr3131600lfg.196.1601586456669;
 Thu, 01 Oct 2020 14:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200825004523.1353133-1-haoluo@google.com> <20200826131143.GF1059382@kernel.org>
 <CA+khW7jf7Z=sMC1u5eyn6XOZDTFJaNjV-D0ogvQSyUGSKjC3LQ@mail.gmail.com>
 <DEC4CC81-88CE-4476-A631-2BBB6E922F5C@gmail.com> <CA+khW7imZ+1to15Y+6Suw5_RRQfOQ32X_mkcFACDedjHrNYFaQ@mail.gmail.com>
 <CAADnVQKkqtSLLiXsQk6EnMz61J3Em53HB9zPZtPeqE4jvzGt3g@mail.gmail.com>
 <20201001182415.GA101623@kernel.org> <CA+khW7iSd4EX0EdoQ0+FvnGg5CKai+TLsa4xbDUPA8tbiu3LZw@mail.gmail.com>
 <20201001202729.GA105734@kernel.org> <CA+khW7iVd3zUa0iwLuf=SwE3TtnNPB1ZGkUvWPfVt7JpJPcX5w@mail.gmail.com>
In-Reply-To: <CA+khW7iVd3zUa0iwLuf=SwE3TtnNPB1ZGkUvWPfVt7JpJPcX5w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 1 Oct 2020 14:07:23 -0700
Message-ID: <CAADnVQKJc45UhkRj_cjJLvW=crXhN-BpUN0rM4XK_KbLTioAow@mail.gmail.com>
Subject: Re: [PATCH v1] btf_encoder: Handle DW_TAG_variable that has DW_AT_specification
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, dwarves@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 1:57 PM Hao Luo <haoluo@google.com> wrote:
>
> Arnaldo, thanks for the update. In that case, I think on the kernel
> side I need to skip encoding percpu vars for this pahole release, and
> re-enable for the next pahole release. (assuming the flag for opt-out
> is in this release). Alexei, do you have any better idea?

I'm not following. Let's get this fix landed in pahole and
release new 1.18 with it.
The opt-out flag is orthogonal. I can be done in 1.19 or whenever.
With your kernel patches the kernel will reject percpu vars when pahole
is too old, because they will not be found in vmlinux btf,
so I don't see any compatibility issues.
There is no need to bump the required min version of pahole in
scripts/link-vmlinux.sh.
It can stay as v1.16. We only need clean verifier message that percpu BTF
is not found and the kernel needs to be rebuilt with pahole 1.18.
