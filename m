Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9B3605D9
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 11:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhDOJe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhDOJe5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 05:34:57 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DF6C061756
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 02:34:34 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id 7so17964466ilz.0
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oxhfmgq4/lBHZsTv5waxIB12jAdndxIiCGYaYJ0QbU=;
        b=UbdMnzkMjlp4dVJzE5P6mIlHvL1lwGcw1qltoT9qncf5Oc0r2fUgB9SKUW0wR9lDVC
         tKEZRlsxRg6hWGuydX2yQhRoWDikqmWFp5mOfPESNP0UQuEbY0Z7R5UaUJ+XT9zQ6g7R
         /KAeiqhfw8gm2oDkm/y60F44SPj0DkvpIy+BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oxhfmgq4/lBHZsTv5waxIB12jAdndxIiCGYaYJ0QbU=;
        b=o7isWD3Ulu5Lu8OamTOIwOxa2atODwSRicVZ7KvLLFF1liYYv5O2yKYZJRGgbSptVU
         TI0OIJ9a2WCDJdgh6y4E+mEdAhvSxjclsnNgOxRGr/16rYV1T8E1Xi5ybplzlnorlM++
         hJglWrIHls+WKunFgNBuCOw+d5bN3qbCwDWZ6i/gZNoqlEopBN4X+VbByyJ8v0Fv18zN
         HLeDQLJyjx4+MMDek+ojKmjwHaNIN2YnaTvIbWuEXZDYsQewLfPMQ4dIaCUxsBIDjaTl
         GYHcfXflLG9qg81kJlaUbH9Nx/n8H91jdkmRrrZNr446pUq5vscLrcSYd6fpGRXrhJvt
         Aq2w==
X-Gm-Message-State: AOAM530LYBc9/H0+q94f34WK2TeUdXMllCFbRBJYVUKLIbBhUnyMBuwK
        XhsO5MFOp87zS6FlcBlirDSrckjmSiyg0i8XEma3gw==
X-Google-Smtp-Source: ABdhPJzeShXmcoEfu+1+Ri6SonH6CoZJyCAHTZk+mfvL5aCtUdErvhGRLF2ppMLjZe5OeRF+Nqbi3GEmTsfRatK8tD4=
X-Received: by 2002:a92:ce90:: with SMTP id r16mr2135098ilo.220.1618479273627;
 Thu, 15 Apr 2021 02:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
 <CABRcYmJvzcFySYS=U=xtfn4eG7yKpmET_yh-bZYrkYfJMdx_pw@mail.gmail.com> <CAEf4Bza+rVCp=G5i97MuuBrTX+o1ZUBn3nzstssoS1KtE4F6vw@mail.gmail.com>
In-Reply-To: <CAEf4Bza+rVCp=G5i97MuuBrTX+o1ZUBn3nzstssoS1KtE4F6vw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 15 Apr 2021 11:34:22 +0200
Message-ID: <CABRcYm+XPciihdZDWSMUBLmtBCuDSV=bHvtEUqZupfC=cng6FA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 15, 2021 at 12:57 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 2:46 AM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, Apr 14, 2021 at 1:16 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > > +
> > > > +       return err + 1;
> > >
> > > snprintf() already returns string length *including* terminating zero,
> > > so this is wrong
> >
> > lib/vsprintf.c says:
> >  * The return value is the number of characters which would be
> >  * generated for the given input, excluding the trailing null,
> >  * as per ISO C99.
> >
> > Also if I look at the "no arg" test case in the selftest patch.
> > "simple case" is asserted to return 12 which seems correct to me
> > (includes the terminating zero only once). Am I missing something ?
> >
>
> no, you are right, but that means that bpf_trace_printk is broken, it
> doesn't do + 1 (which threw me off here), shall we fix that?

Answered in the 1/6 thread

> > However that makes me wonder whether it would be more appropriate to
> > return the value excluding the trailing null. On one hand it makes
> > sense to be coherent with other BPF helpers that include the trailing
> > zero (as discussed in patch v1), on the other hand the helper is
> > clearly named after the standard "snprintf" function and it's likely
> > that users will assume it works the same as the std snprintf.
>
>
> Having zero included simplifies BPF code tremendously for cases like
> bpf_probe_read_str(). So no, let's stick with including zero
> terminator in return size.

Cool :)
