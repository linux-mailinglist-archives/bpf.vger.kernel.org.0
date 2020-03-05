Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659D417B219
	for <lists+bpf@lfdr.de>; Fri,  6 Mar 2020 00:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCEXQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 18:16:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33098 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEXQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 18:16:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id c20so374515lfb.0;
        Thu, 05 Mar 2020 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cim/Thkuor6laFixPM1YB3JnZEsbRCv4QIOJYjrt0Q4=;
        b=msQAFYu3OlBmRhSaPBKtAX4bKi0OIGZTAe9UfYq0nAA1gPNpyT75F1DBpwb4zSBdC+
         FE8Emg8mufZgTfON7GnOjREg5GiPxCcSidPRSQlI8a9Xd+utvyciXBfzJxcnKAWmbjcD
         0JqYpOvkRXfp7IizE/vxoVxjrCNMhrg4oe+U4g+bANE9dhbXsJyzerXmzI4s0Way8/GL
         8xjum81AukSkZm8mEkbFoYfawujIMtYXZlTtxRM7vAlLJS+UEaWWBSONJ/HGl/8r/Yzp
         eUf4APomWCkvKxwrLe2WJhuvMqhQYiDcaQ+/+SSVtVObblTZJGmntIOkbI/D1OwWZNGT
         F6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cim/Thkuor6laFixPM1YB3JnZEsbRCv4QIOJYjrt0Q4=;
        b=O3I9hy3Col55XLyQ3bP9uteEObnvtyFawp42qjwL3mt6zn1ODe95tnYSbl6fFP6Gpt
         8O3w9b137zP1YvB0sOpCrCJg1E3it7XdnVoLKQV6sNqz72xr55XakvL4/HJxJjaNrxQY
         50EcCH1lcLoOkSKazr/IlMLiIXOFPkZfXaRwvhABILR55X/G+bdIPq0zJlOwpbO5DgLH
         9THb+t1Lg3v7Da+2RN8XA6x37KipXpeAO8wQrTtf5LtuIRn7q47s0RFmZgwdUd4rC42n
         +RY8KNzdAi+e2yQq3rncLBP4dAah5EO6PbCufdDV7GJyPRHeBGLru8HEYzBVMUmbnPif
         pm8Q==
X-Gm-Message-State: ANhLgQ323O6aQaEResn1e3DGzZCpbz9MGmPXbyZu7b4/j87unZ3ph3jv
        HdD+D+FRCsE5Uwp/ae7nPklh3TCNY/4RuvAAczo=
X-Google-Smtp-Source: ADFU+vsydeXS7gIGr0pLvQ4U17zsMvqXLMumhLO1I975zWMP89UrMbpRkpDRFCxhCNrgVkMXe0GHgvCrK6g/MfCSJGw=
X-Received: by 2002:ac2:418b:: with SMTP id z11mr90295lfh.134.1583450197267;
 Thu, 05 Mar 2020 15:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20200305220127.29109-1-kpsingh@chromium.org> <92937298-69c1-be6f-3e40-75af1bc72d9e@infradead.org>
In-Reply-To: <92937298-69c1-be6f-3e40-75af1bc72d9e@infradead.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 5 Mar 2020 15:16:25 -0800
Message-ID: <CAADnVQLjj+eMMLU3H4oNkzwPiSugm1knzd3RfBGb3NcVC785kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_prog_test_run_tracing for !CONFIG_NET
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     KP Singh <kpsingh@chromium.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 5, 2020 at 3:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/5/20 2:01 PM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > test_run.o is not built when CONFIG_NET is not set and
> > bpf_prog_test_run_tracing being referenced in bpf_trace.o causes the
> > linker error:
> >
> > ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to
> >  `bpf_prog_test_run_tracing'
> >
> > Add a __weak function in bpf_trace.c to handle this.
> >
> > Fixes: da00d2f117a0 ("bpf: Add test ops for BPF_PROG_TYPE_TRACING")
> > Signed-off-by: KP Singh <kpsingh@google.com>
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Since it was at the top of the tree I amended the commit
with your tags.
Thanks for reporting and testing.
