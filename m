Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD6178608
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCW5w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:57:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43776 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCW5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:57:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id h9so7135wrr.10
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=54j0J9wFM5XCN2h3a4/n6MI0UxekhSzsh9zn+5s01fI=;
        b=aMR1AfI/uh9tcuspjHvQTh6bkMCuUpZ1gGxcEZb4DdaQj8Z1+R8/RSj8Qu9s3CGSKO
         yozHGQclqvRMEaxYv3ZoiKoa7KQ8UvwPMo0rCriaUASfrZq19+WIEtfcoOx7kJArWK+E
         qQpB1P3e4ZG6yD0MzEuhwLJc6FfqjJx8RueQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=54j0J9wFM5XCN2h3a4/n6MI0UxekhSzsh9zn+5s01fI=;
        b=AT+G30YO/CeZ50m5GIxm601OKe03yMxbNjzwUDJzSm/42voQIulCkzFZH21DqRja9y
         Q0TF1Ie4cBl1BSznvPEZ2oeIULck5NK0RgvJjw/qJnKlkwUVB76VVTSyfZW4qt8hGON5
         PftY+SaRuN40WfTAOkzj4ZB0YeSWvWdlNhJX4gq0yQYec6cMiLNUekJ2qMgJaCUW+QbK
         G3c9nNbc3EajcQr12r/iUKSxhOWoWeBPRt9YzRBWH1XjvWyqtrrcQrMFpXRCoWDR/EYD
         UhgfdcsBRR5LbUeSNh0kQcHe8B+Vpnfuz2894xdurgG954P3NXMP9qrHVbQE2rNmoayU
         7fZQ==
X-Gm-Message-State: ANhLgQ1h5cucm/NrQN5PkwxOUNBOtrfcsxdrUwwUeWqrwLn2kz/Pk/EP
        10xVX5hao09X35KOt/QApRkA8Q==
X-Google-Smtp-Source: ADFU+vu90A7gJEYiYLWupTNQIF/Ds4L5ljniXZRAyT8bEJz05mbq+KwGZueV/BOQOsnYdrlTk6YmpQ==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr265851wrx.376.1583276270414;
        Tue, 03 Mar 2020 14:57:50 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id j205sm902562wma.42.2020.03.03.14.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:57:49 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 3 Mar 2020 23:57:48 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 6/7] bpf: Add test ops for BPF_PROG_TYPE_TRACING
Message-ID: <20200303225748.GA14735@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-7-kpsingh@chromium.org>
 <CAEf4BzZwazh1DnGJKBgFgrp4m5B_3AwjsxkJVBh6cxQceiLcBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZwazh1DnGJKBgFgrp4m5B_3AwjsxkJVBh6cxQceiLcBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 14:51, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > The current fexit and fentry tests rely on a different program to
> > exercise the functions they attach to. Instead of doing this, implement
> > the test operations for tracing which will also be used for
> > BPF_OVERRIDE_RETURN in a subsequent patch.
> 
> typo: BPF_OVERRIDE_RETURN -> BPF_MODIFY_RETURN?

Oops :) Fixed. Thanks! Artifacts of renaming.

> 
> >
> > Also, clean up the fexit test to use the generated skeleton.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> Nice clean up for fexit_test, thank you!

It was very satisfying :)

> 
> >  include/linux/bpf.h                           | 10 +++
> >  kernel/trace/bpf_trace.c                      |  1 +
> >  net/bpf/test_run.c                            | 38 +++++++---
> >  .../selftests/bpf/prog_tests/fentry_fexit.c   | 12 +---
> >  .../selftests/bpf/prog_tests/fentry_test.c    | 14 ++--
> >  .../selftests/bpf/prog_tests/fexit_test.c     | 69 ++++++-------------
> >  6 files changed, 68 insertions(+), 76 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 3cfdc216a2f4..c00919025532 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1156,6 +1156,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> >                           union bpf_attr __user *uattr);
> >  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >                           union bpf_attr __user *uattr);
> > +int bpf_prog_test_run_tracing(struct bpf_prog *prog,
> > +                             const union bpf_attr *kattr,
> > +                             union bpf_attr __user *uattr);
> >  int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
> >                                      const union bpf_attr *kattr,
> >                                      union bpf_attr __user *uattr);
> > @@ -1313,6 +1316,13 @@ static inline int bpf_prog_test_run_skb(struct bpf_prog *prog,
> >         return -ENOTSUPP;
> >  }
> >
> > +static inline int bpf_prog_test_run_tracing(struct bpf_prog *prog,
> > +                                           const union bpf_attr *kattr,
> > +                                           union bpf_attr __user *uattr)
> > +{
> > +       return -ENOTSUPP;
> > +}
> > +
> >  static inline int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
> >                                                    const union bpf_attr *kattr,
> >                                                    union bpf_attr __user *uattr)
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 07764c761073..363e0a2c75cf 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1266,6 +1266,7 @@ const struct bpf_verifier_ops tracing_verifier_ops = {
> >  };
> >
> >  const struct bpf_prog_ops tracing_prog_ops = {
> > +       .test_run = bpf_prog_test_run_tracing,
> >  };
> >
> >  static bool raw_tp_writable_prog_is_valid_access(int off, int size,
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 562443f94133..fb54b45285b4 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -160,18 +160,38 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
> >                 kfree(data);
> >                 return ERR_PTR(-EFAULT);
> >         }
> > -       if (bpf_fentry_test1(1) != 2 ||
> > -           bpf_fentry_test2(2, 3) != 5 ||
> > -           bpf_fentry_test3(4, 5, 6) != 15 ||
> > -           bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
> > -           bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
> > -           bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111) {
> > -               kfree(data);
> > -               return ERR_PTR(-EFAULT);
> > -       }
> > +
> >         return data;
> >  }
> >
> > +int bpf_prog_test_run_tracing(struct bpf_prog *prog,
> > +                             const union bpf_attr *kattr,
> > +                             union bpf_attr __user *uattr)
> > +{
> > +       int err = -EFAULT;
> > +
> > +       switch (prog->expected_attach_type) {
> > +       case BPF_TRACE_FENTRY:
> > +       case BPF_TRACE_FEXIT:
> > +               if (bpf_fentry_test1(1) != 2 ||
> > +                   bpf_fentry_test2(2, 3) != 5 ||
> > +                   bpf_fentry_test3(4, 5, 6) != 15 ||
> > +                   bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
> > +                   bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
> > +                   bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111)
> > +                       goto out;
> > +               break;
> > +       default:
> > +               goto out;
> > +       }
> 
> No trace_bpf_test_finish here?

Ah yes, we trace it not ony for erroneous cases. Changed it to
setting err = 0 and falling through to the trace_bpf_test_finish.

- KP

> 
> > +
> > +       return 0;
> > +
> > +out:
> > +       trace_bpf_test_finish(&err);
> > +       return err;
> > +}
> > +
> >  static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
> >  {
> >         void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);
> 
> [...]
