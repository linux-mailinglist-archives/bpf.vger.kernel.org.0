Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97745E401
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 02:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhKZB2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 20:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349802AbhKZB0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 20:26:34 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA619C061759
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 17:23:22 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j2so15888009ybg.9
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 17:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pHcRmWGDQEUZmkkRe5oI7dY8CNJXZ+gxx1pZWhtIvA=;
        b=Z3ZvqlMPFbbZGvxU2bWYSQJGu5Y4H2T8prlsoRuFb3hART9jhKk0WRA+nKEKyM8Nvl
         L2/jgbfWd/LooHz3NQpbDgOQ8xUA/0aflA78VB0/jc+VrKaAtMxtlclpoksvgWFS/Zns
         Q6ZhX2shCs2yyOy2UZYgKU1ohoPmzVRHWygmdA8Zj1EWGNPJVFnIf7HekQTDN/savjtw
         fuagxFk+elsfq7TWfACV+OvqyWCOHADOKzmlxqGZ0YFmVMxSkGenqaL4sDmubUCTuHce
         CvN7CKAGHeS4Xg5Do/mcXfh1f9Ukg5Gc04aettspddxB+GOlMMNHNu/F1N/J/YdIc1vx
         GJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pHcRmWGDQEUZmkkRe5oI7dY8CNJXZ+gxx1pZWhtIvA=;
        b=PdlJ7a7qWd5+q9afkQp622TNkP8r5YzDA5FFvRoMuDn/zZN0pnb8Ok+1hVR27cAcbq
         qh3thvaprRA3orcUWfhEunA8VXsyidtZWuP9xqFgdh62oMCM7H6Vw7qZMa6c8SAnLAzT
         APtA3s/nHwsSz22M+HFqvmz5L1FTtTwKNmAYEeDMpOuVMcywHDu3tdAYl2RvplBNcL15
         Ma2ewQpPXhLQRnleQFp+Jwqfbd71spjm7DsFkNrTmWBfNGIsjUGgdcYHxi3H2hUTbxgI
         6svRykBvqC09pYqzWYmk52CIfqrT5MiWxr+5l0z45JtudqPbTG+7nHj6m5kuh5NkzD02
         IRCw==
X-Gm-Message-State: AOAM531nYzT54OhG8E3gogab5f7maD59qZ2MEPOW+MUcgD7juhnAwoYh
        Zj5MUoa/aMCr+d+2olH3EcNQX27A3IAo9sBVBgoQezNyVd4=
X-Google-Smtp-Source: ABdhPJyBLBAd0i5VXcGl9T479yyHPijZSW9lTRKKmndN3RTD4hZN9V5tjxiG9Pnc86Pdis+J8lbj6PpafOwZgDvqMGc=
X-Received: by 2002:a25:42c1:: with SMTP id p184mr10252330yba.433.1637889802115;
 Thu, 25 Nov 2021 17:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20211124002325.1737739-1-andrii@kernel.org> <20211124002325.1737739-4-andrii@kernel.org>
 <9e00239a-b44c-88d9-39b4-5e0ad7d49f3b@iogearbox.net> <8350db18-6e13-66da-220c-c1e53562326e@iogearbox.net>
In-Reply-To: <8350db18-6e13-66da-220c-c1e53562326e@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Nov 2021 17:23:11 -0800
Message-ID: <CAEf4BzZ5AEJHr9p0zBn6A=-EAkMhToVdjLx7eijXsJYeyX2_rg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/13] libbpf: prevent UBSan from complaining
 about integer overflow
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 25, 2021 at 3:19 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/25/21 11:21 PM, Daniel Borkmann wrote:
> > On 11/24/21 1:23 AM, Andrii Nakryiko wrote:
> >> Integer overflow is intentional, silence the sanitizer. It works
> >> completely reliably on sane compilers and architectures.
> >>
> >> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >> ---
> >>   tools/lib/bpf/btf.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index 8024fe355ca8..be1dafd56a13 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -3127,6 +3127,7 @@ struct btf_dedup {
> >>       struct strset *strs_set;
> >>   };
> >> +__attribute__((no_sanitize("signed-integer-overflow")))
> >>   static long hash_combine(long h, long value)
> >>   {
> >>       return h * 31 + value;
> >>
> >
> > Sgtm, I guess my only question, was there a reason for not using e.g. __u64 in
> > the first place? Meaning, __u64 hash_combine(__u64 h, __u64 value) plus the
> > call-sites where you have h variable re-feeding into hash_combine().
>
> Given the remainder of the series is all straight forward, I took that in already,
> but would still be nice if we can silence the sanitizer complaint w/o such attribute
> workaround.

You are right, I'll follow up with u64 conversion and will drop the attribute.

>
> Thanks,
> Daniel
