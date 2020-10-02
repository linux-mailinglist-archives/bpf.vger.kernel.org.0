Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389D0281059
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbgJBKIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 06:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBKIQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 06:08:16 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62008C0613E2
        for <bpf@vger.kernel.org>; Fri,  2 Oct 2020 03:08:16 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id k13so210648oor.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2020 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWYUsZ+0jSI+bzR+U/Opb/r+h29XMQ6OibUPAn5KgDU=;
        b=o7V4Ert5THuV208ZrTVLXy9I6K5MtKtKfL97eluip4dXo5wrNSzqZOFdA61OxeBZdF
         +0sDtnWTrKMU2EyF3sU05PklgBIgEr9VudLtUJ3VGUdiPp1p6SCDlWNKteN+kFZ+fPDX
         WtxmCVPPFeGStQHm7e7rsN0pF8YjBqtA/PWcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWYUsZ+0jSI+bzR+U/Opb/r+h29XMQ6OibUPAn5KgDU=;
        b=iJg+1WUwC3cHwlwpNcsBcvXOfbHPUNpWxb/QoVm0n2FESpEkO4HRFplQ7fEwt00Byr
         VWeHBTM22ItpsWnN0tI1vWDzP0qJUyQj2Xj3yNtl4thNB060ZcRfdcFQyNAYhwvl0gBO
         B3Qnm4Ry/fTe5oh2Gs9Ny8+WGu/UMWrN7+2hdrjOmAY7C8/yBuYowFmNBgW/rs8776P5
         +PSM0U+PN2uA+1keJqTiwKG11B1UOGmhlybgEJXHT//Eec1t7mkQjdPV9q8wIv3kE2Mv
         +sSk/+0SiEDt4b+T57OdlZbE2VT5Te92G9npjdfrEnDp0tdaK1IV6WIjnzV0jID2My5V
         T6kQ==
X-Gm-Message-State: AOAM530Kq3Jc8yb2BGAlsRI06nfeSSUcVj9Jw3Q4odBYOx2M/9L9/hrX
        nRFm9cLmFaISPZ6GWHhd/okBzkBT4zR06wcGXWSQeA==
X-Google-Smtp-Source: ABdhPJzgSjaquUtXDnzTcQzO4uhxmbkV4B9/CSU56HbCERpxhB4ybkcXsdueLdZM5yjhwxK6nlWgW4Z+45On+tgp5ME=
X-Received: by 2002:a4a:81:: with SMTP id 123mr1287156ooh.80.1601633295629;
 Fri, 02 Oct 2020 03:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200928090805.23343-1-lmb@cloudflare.com> <20200928090805.23343-3-lmb@cloudflare.com>
 <20200929055851.n7fa3os7iu7grni3@kafai-mbp> <CAADnVQLwpWMea1rbFAwvR_k+GzOphaOW-kUGORf90PJ-Ezxm4w@mail.gmail.com>
 <CACAyw98WzZGcFnnr7ELvbCziz2axJA_7x2mcoQTf2DYWDYJ=KA@mail.gmail.com>
 <20201001072348.hxhpuoqmeln6twxw@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzbjzj3wwxX84bLi-PLy=9+Bpe1bTDt=t0qR5t=xEkNjwQ@mail.gmail.com> <CAADnVQJQeiyrN2JzOwV+zHDU5xg4TtpT0w9MgG6nujCK5z+GNQ@mail.gmail.com>
In-Reply-To: <CAADnVQJQeiyrN2JzOwV+zHDU5xg4TtpT0w9MgG6nujCK5z+GNQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 2 Oct 2020 11:08:04 +0100
Message-ID: <CACAyw99ji02q3XngQS=KbRtebRipNU4P3kUbV1ULeVy64MA3mg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests: bpf: Add helper to compare
 socket cookies
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 1 Oct 2020 at 18:11, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> >
> > I think this might be the same problem I fixed for libbpf with [0].
> > Turns out, GCC explicitly calls out (somewhere in their docs) that
> > uninitialized variable warnings work only when compiled in optimized
> > mode, because some internal data structures used to detect this are
> > only maintained in optimized mode build.
> >
> > Laurenz, can you try compiling your example with -O2?
>
> All of my experiments I did with -O2.

If anybody wants to play with this more: https://godbolt.org/z/77P6P9

Seems like red hat GCC has some special sauce that fixes this behaviour?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
