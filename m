Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D53697DF
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhDWRCj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhDWRCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 13:02:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82814C061574;
        Fri, 23 Apr 2021 10:02:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b38so15271691ljf.5;
        Fri, 23 Apr 2021 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7CA/pgpxkvtCeOx7lsnR2f+TSU2SsNmkF6bD2RAn/k=;
        b=qUMr/lp+92lEh0ipefCOZBjarxm/p6iJCgK5FTmszMtG9B0P1ny19RxCF49GCkYwmZ
         5F+UFcN0fI+blo9j27xM0qG5nwGwl4hcKTlHkfeVrWMjvYgGXi/vNr+DAejeOSQOlVEj
         kGt/LaNCrtRpFsgH/e2w9X71qfVz2I4auuLNovxYOfb4z+P+ed7KXytZWswmK/9oAmox
         zcffyKmc2GLfcHq9ajGQx10Z++DBkQh8vgIHfQGka3Hi/cIgN1P8yv6xk34wav/oUmfm
         E/CLy3KsM/zetM3Ld15znF3SojtrMIRT3EmnfV3TJxSnQzhmJphj1LLyFtyG1rQW0EUA
         JswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7CA/pgpxkvtCeOx7lsnR2f+TSU2SsNmkF6bD2RAn/k=;
        b=ZAme+TFzxk1HfuroWeTPH/iA9GlAMBgkkN0ah57n+p3JiQRO3bxftA1QV8gWhpjOz0
         0YpzLn7CbxzWZ2W+YwCbLK1SALNoJsG/t2p/ZSh5xPpTS5BXVKS9WItIqH55r1kzWRLU
         /ocjjrUaujcaEzvYmgHSYK0wYxACzXdJIWFqb/W78/orGoiYOIdrw+h8vW/ItYlrWkh4
         PUh6InNh6CNWthIaqCHDHO1Lz1pN9mP/vy6WUbRGYTPPyoAFZkbFlNV6iNUcRuERZCIo
         Ri8iu4L86q5+pUdihEkTmtLlj20GTs46MTwHlg67WthpVqRwXdOp43wT9QZfuIUgcL5R
         L15g==
X-Gm-Message-State: AOAM530C5oMHhSHh0iL80LD0wBP6DWdB4W8bEH7ycFGUud7uhMwbPd8m
        AlDq2gMAKJniTyyNFu9zu6WIcNxhc/EBSVPTbvUQyNGt
X-Google-Smtp-Source: ABdhPJxq5sVRkxffgfJ1hbnmpCHyzATrGUJRaP8M8yXiF4B2ydTmTbn8kurdpY5wEHlOY+mTS9SHUJJgjeJvbZW4gIw=
X-Received: by 2002:a2e:a491:: with SMTP id h17mr352391lji.236.1619197319108;
 Fri, 23 Apr 2021 10:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210422235543.4007694-1-revest@chromium.org>
In-Reply-To: <20210422235543.4007694-1-revest@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Apr 2021 10:01:47 -0700
Message-ID: <CAADnVQKetujO2V_ouOK9c+4Xt3qDX7S6A=XLQpiv-cUYuf6rFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Simplify bpf_snprintf verifier code
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 22, 2021 at 4:56 PM Florent Revest <revest@chromium.org> wrote:
>
> Alexei requested a couple of cleanups to the bpf_snprintf and
> ARG_PTR_TO_CONST_STR verifier code.

Applied. Thanks
