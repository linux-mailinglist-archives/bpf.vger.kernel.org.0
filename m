Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4982E0F84
	for <lists+bpf@lfdr.de>; Tue, 22 Dec 2020 21:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgLVUxm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Dec 2020 15:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgLVUxl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Dec 2020 15:53:41 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CAEC0613D6
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 12:53:01 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o6so13157801iob.10
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSFSCu/3Al5lp+zO9UYGs39Tx645YSp48rg99RlI4+M=;
        b=F80PhSdtn+/+FG7JYRhi5K7qtpoZDpbmjahsp4k1NcmszQi/3RIYjdxFQq1FIyrZik
         PtvaxiPDQ64Tn6OvdxQpavQfrRlyGPuk/n2iW9H+2rVs9biNBISY1hoYNN4phfa63erm
         v2/Lh7WvK9StfpKmywXpwLH1gm3BYBkWCyLb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSFSCu/3Al5lp+zO9UYGs39Tx645YSp48rg99RlI4+M=;
        b=s0mE6GJ8fxC2fyGS9NdaUeM5WY3f232l98qpbrw1D2ddTj123UIJoyfqVamDfukcku
         ift7bv6+G4VsIZmhaiqK0BWuaSYK3K69qvyO+SUw3zAjyNLsII1dWSEmbfdCj/e34and
         j2E0m3OWVPh9vzvHJ/KzA28z9bSR5neQHZelWrvYWGdAB5PLzTq69sLSDINN2p+JI6WN
         MviCrPxB/u4xapcFtmN+jzYkXKCkvx9l4jUmqNRaPLgGOnoujo8Rcllg8ejVmZAd83is
         WSdK0FYuRqywmnktODzdeJydyNJnkPK6fAk6iWLky+OKiZYUQkJctW+qBHf7jEGQV4Uy
         7ALA==
X-Gm-Message-State: AOAM531OiOkQgksVahlts41//h8BlaYoIsou7iq/nuolv69tu4sxsoaQ
        U9juSgIPpEHPzmNWqPh5McuMd4tosh9/i97iVRu8nhw4BjeB7w==
X-Google-Smtp-Source: ABdhPJwUqtn1nVeh8VywzsuWE/X+W+Y1UqKUyImxjltZg7lSkMwZrzviL3JWLIMRnjCRMoehIYHyn/Ngb3/anEcge28=
X-Received: by 2002:a6b:8b88:: with SMTP id n130mr19156455iod.122.1608670380554;
 Tue, 22 Dec 2020 12:53:00 -0800 (PST)
MIME-Version: 1.0
References: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com> <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
 <221fb873-80fc-5407-965e-b075c964fa13@fb.com> <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
 <d29c2ed6-d99c-9d28-e6ea-d79ffd4d7e65@fb.com> <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
In-Reply-To: <20201218032009.ycmyqn2kjs3ynfbp@ast-mbp>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 22 Dec 2020 21:52:49 +0100
Message-ID: <CABRcYmKSio1gD0h2suZ96jGnMsXpQ9V151-1k+ZkRMxop+GR5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 18, 2020 at 4:20 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> As far as 6 arg issue:
> long bpf_snprintf(const char *out, u32 out_size,
>                   const char *fmt, u32 fmt_size,
>                   const void *data, u32 data_len);
> Yeah. It won't work as-is, but fmt_size is unnecessary nowadays.
> The verifier understands read-only data.
> Hence the helper can be:
> long bpf_snprintf(const char *out, u32 out_size,
>                   const char *fmt,
>                   const void *data, u32 data_len);
> The 3rd arg cannot be ARG_PTR_TO_MEM.
> Instead we can introduce ARG_PTR_TO_CONST_STR in the verifier.
> See check_mem_access() where it's doing bpf_map_direct_read().
> That 'fmt' string will be accessed through the same bpf_map_direct_read().
> The verifier would need to check that it's NUL-terminated valid string.

Ok, this works for me.

> It should probably do % specifier checks at the same time.

However, I'm still not sure whether that would work. Did you maybe
miss my comment in a previous email? Let me put it back here:

> The iteration that bpf_trace_printk does over the format string
> argument is not only used for validation. It is also used to remember
> what extra operations need to be done based on the modifier types. For
> example, it remembers whether an arg should be interpreted as 32bits or
> 64bits. In the case of string printing, it also remembers whether it is
> a kernel-space or user-space pointer so that bpf_trace_copy_string can
> be called with the right arg. If we were to run the iteration over the format
> string in the verifier, how would you recommend that we
> "remember" the modifier type until the helper gets called ?

The best solution I can think of would be to iterate over the format
string in the helper. In that case, the format string verification in
the verifier would be redundant and the format string wouldn't have to
be constant. Do you have any suggestions ?

> At the end bpf_snprintf() will have 5 args and when wrapped with
> BPF_SNPRINTF() macro it will accept arbitrary number of arguments to print.
> It also will be generally useful to do all other kinds of pretty printing.

Yep this macro is a good idea, I like that. :)
