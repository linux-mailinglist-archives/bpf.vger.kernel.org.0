Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7454B2354E8
	for <lists+bpf@lfdr.de>; Sun,  2 Aug 2020 04:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHBCjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 22:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBCjX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Aug 2020 22:39:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17804C06174A
        for <bpf@vger.kernel.org>; Sat,  1 Aug 2020 19:39:23 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s189so28120179iod.2
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=u4cdpBmoAp4NXZHFYWOfUxm88CAHwYgmJcASvlZaKg4=;
        b=DHmw2Nmw6T0JO7NlF+Sj5S1747Pf5z/eASvzeRYthF8tRj89t2EgXhhuzf0yaNruKE
         tT1cfFRBOI+i113uAc7wXGfHFDpR6VCLCN8h0Dv+UKBBpVn7ZaMyEUUq4lHoXH9nx8nN
         NJnFT9P8QRwMycj4NxOouxCHQWjL+JU5VPYpvW4qN0WYoKcsBGUyLV+WQV8+c2KV/rxc
         E1ts0+PfiXwrqjjxNZ08zc2PpzXDVZdAHfLOAKhqC+2Uy/2oaErthNyq/1joZtTBe0vS
         +xT61j2rkASHt41+qHZGeKyQ7tL3A1XJ8rK7CoNoO3N5ML2lu2ZH3KpAfE5s32Cw799G
         VFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=u4cdpBmoAp4NXZHFYWOfUxm88CAHwYgmJcASvlZaKg4=;
        b=Mb+SvmVxNyFwpQqg6E9fNp7HKrtHkEfkURq3HZY6DTpCsp7jDBMGFzYFIJycXrcWoi
         q0oxlh6iwnS2BlLCd8FphVvYORewggdGX4DJccczmT2dhxtEsdVBDaNmdNQC2osG0TET
         brTTIomqSwX2DS/o7VaRjsgE8dF7CQa2jBHuNYhgx4rWuXu9LQTdNpb7ijtfdbs0+i81
         1Pf7Fbv4A3npMx4o/EZIQ5TGGShD9ppgwk7d4zoR3WmLFiBAF5celQXNXga9DStXAI9S
         9Z62IGhlENT3rYyqrm6fgPeTjezkOnWQlGvDDlVvnZGRiDp11TGrhH4xyBRVw3PmC9RJ
         tu+w==
X-Gm-Message-State: AOAM532fIkHIkMtQN0hXxst2YgdQXgj6tcEsPzq+j9rRqoi0IKB49hTH
        LC2sFHUr84XAp5walEVPSm4=
X-Google-Smtp-Source: ABdhPJzbms40CAB6XmrAmwPQk4AlbyQPHhJf25XahdVSkMA+2u8MYfPR1yb05ee4tOmb1OjFgy0Ipw==
X-Received: by 2002:a5d:9d11:: with SMTP id j17mr11001917ioj.140.1596335962317;
        Sat, 01 Aug 2020 19:39:22 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id i10sm8204397ild.29.2020.08.01.19.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 19:39:21 -0700 (PDT)
Date:   Sat, 01 Aug 2020 19:39:13 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Message-ID: <5f262751ab97c_11b82ae318aac5b44d@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzZ9=av=EvbyzhoyCg0ZvTOA2GBPgq5vyb1SaoNmqwL6XQ@mail.gmail.com>
References: <159623491781.20514.14371382768486033310.stgit@john-XPS-13-9370>
 <CAEf4BzZ9=av=EvbyzhoyCg0ZvTOA2GBPgq5vyb1SaoNmqwL6XQ@mail.gmail.com>
Subject: Re: [bpf-next PATCH] bpf: Add comment in bpf verifier to note
 PTR_TO_BTF_ID can be null
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Fri, Jul 31, 2020 at 3:36 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > The verifier contains both types PTR_TO_BTF_ID and PTR_TO_BTF_ID_OR_NULL.
> > For all other type pairs PTR_TO_foo and PTR_TO_foo_OR_NULL we follow the
> > convention to use PTR_TO_foo_OR_NULL for pointers that may be null and
> > PTR_TO_foo when the ptr value has been checked to ensure it is _not_ NULL.
> >
> > For PTR_TO_BTF_ID this is not the case though. It may be still be NULL
> > even though we have the PTR_TO_BTF_ID type.
> 
> _OR_NULL means that the verifier enforces an explicit NULL check,
> before allowing the BPF program to dereference corresponding
> registers. That's not the case for PTR_TO_BTF_ID, though. The BPF
> program is allowed to assume valid pointer and proceed without checks.
> 
> You are right that NULLs are still possible (as well as just invalid
> pointers), but BPF JITs handle that by installing exception handlers
> and zeroing out destination registers if it happens to be a NULL or
> invalid pointer. This mimics bpf_probe_read() behavior, btw.

Yes aware of all this.

> 
> So I think the way it's described and named in the verifier makes
> sense, at least from the verifier's implementation point of view.

The other other problem with the proposed patch is it makes BTF_ID
and BTF_ID_OR_NULL the same from the reg_type_str side which might
make things a bit confusing.

I'm fine to drop this, but from the branch analysis side it still
feels odd to me. I would need to look at it more to see what the
side effects might be, but perhaps we should consider adding it
to the list in reg_type_may_be_null(). OTOH this is not causing
me any real problems at the moment just idle speculation so we
can leave it alone for now.

> 
> >
> > Improve the comment here to reflect the current state and change the reg
> > type string to indicate it may be null.  We should try to avoid this in
> > future types, but its too much code churn to unwind at this point.
> >
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  include/linux/bpf.h   |    2 +-
> >  kernel/bpf/verifier.c |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 40c5e206ecf2..b9c192fe0d0f 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -352,7 +352,7 @@ enum bpf_reg_type {
> >         PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
> >         PTR_TO_TP_BUFFER,        /* reg points to a writable raw tp's buffer */
> >         PTR_TO_XDP_SOCK,         /* reg points to struct xdp_sock */
> > -       PTR_TO_BTF_ID,           /* reg points to kernel struct */
> > +       PTR_TO_BTF_ID,           /* reg points to kernel struct or NULL */
> >         PTR_TO_BTF_ID_OR_NULL,   /* reg points to kernel struct or NULL */
> >         PTR_TO_MEM,              /* reg points to valid memory region */
> >         PTR_TO_MEM_OR_NULL,      /* reg points to valid memory region or NULL */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b6ccfce3bf4c..d657efcad47b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -501,7 +501,7 @@ static const char * const reg_type_str[] = {
> >         [PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
> >         [PTR_TO_TP_BUFFER]      = "tp_buffer",
> >         [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > -       [PTR_TO_BTF_ID]         = "ptr_",
> > +       [PTR_TO_BTF_ID]         = "ptr_or_null_",
> >         [PTR_TO_BTF_ID_OR_NULL] = "ptr_or_null_",
> >         [PTR_TO_MEM]            = "mem",
> >         [PTR_TO_MEM_OR_NULL]    = "mem_or_null",
> >


