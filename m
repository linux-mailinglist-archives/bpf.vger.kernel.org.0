Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D499193FDA
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 14:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgCZNf4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 09:35:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36425 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgCZNfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 09:35:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so7826025wrs.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V3FPFqQqihDv51B2EC+6j3PXfsDAs8xWIOORX4GI6BE=;
        b=OU2CdvNfnHQaPtqcTFjw0kBWW1Zulr0Dh2t5tSDDdbEQSnD+WiGxBdCRQaJw0EWvuq
         AwqWxe+eanybPcnewJ7F/Ue57ukfTcoex0adU6mKHeWbco4+p4uSSq7T1+tlXANOtTt5
         v24dc7WmHf+rjs04tY5UYE0vPE5YUPItM3+yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V3FPFqQqihDv51B2EC+6j3PXfsDAs8xWIOORX4GI6BE=;
        b=cpQrnBcaKtdiNGPRD6LvTQ5omUOOd03pCZ8ApqpORCGrc/IvlKg0ZTq3UbMU+5XHVJ
         zxjeSebQ7Drq4Z2QD+273VqBl+RxiASlJzDlfQUQBqZWxTqNo8XcPc+n5VjVFhFoHqsf
         Tl+6H3bwAREncqd2jIBwLVNeAJeza+cJksMgEei9wZT7wEfnvMtIIAyuk45HdhUZL9r4
         Zc1hoCdDUmiVmiuYFA4fCAWYneg5pdq3mfB1pHw1PniA9YACYIFO7swqTMnbctjTmatT
         bg+8qOkok6EUOJlm+hcJERry3FX1NQjyKjUe0CjKwBPBfFJym+sGrQF+wcSolArTBQUG
         6o4w==
X-Gm-Message-State: ANhLgQ0CUrbrN10tYEUwu8taiiFu4cLk2lLYsQrlarztpOHLb1xPHqUY
        IEw4MBcV0/VnXhG3BgkME6zT6Q==
X-Google-Smtp-Source: ADFU+vum8zXgDXt9jwDJee9jxJCo25OtCt5HFS/x50WWMNv1xR+RAoCMpvWfWWgSigrkJ1R+ggA3WA==
X-Received: by 2002:adf:916f:: with SMTP id j102mr9015893wrj.335.1585229751684;
        Thu, 26 Mar 2020 06:35:51 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id q185sm3713058wme.10.2020.03.26.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:35:51 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 14:35:47 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200326133547.GB8575@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-5-kpsingh@chromium.org>
 <CAEf4BzbZ0Y+BXezgbdzN2T1cH9osREJUNQQoQJ5rJ0EYyD-Udg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbZ0Y+BXezgbdzN2T1cH9osREJUNQQoQJ5rJ0EYyD-Udg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25-Mär 18:49, Andrii Nakryiko wrote:
> On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > JITed BPF programs are dynamically attached to the LSM hooks
> > using BPF trampolines. The trampoline prologue generates code to handle
> > conversion of the signature of the hook to the appropriate BPF context.
> >
> > The allocated trampoline programs are attached to the nop functions
> > initialized as LSM hooks.
> >
> > BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> > and need CAP_SYS_ADMIN (required for loading eBPF programs).
> >
> > Upon attachment:
> >
> > * A BPF fexit trampoline is used for LSM hooks with a void return type.
> > * A BPF fmod_ret trampoline is used for LSM hooks which return an
> >   int. The attached programs can override the return value of the
> >   bpf LSM hook to indicate a MAC Policy decision.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> >  include/linux/bpf_lsm.h | 11 ++++++++
> >  kernel/bpf/bpf_lsm.c    | 28 +++++++++++++++++++++
> >  kernel/bpf/btf.c        |  9 ++++++-
> >  kernel/bpf/syscall.c    | 56 ++++++++++++++++++++++++++++-------------
> >  kernel/bpf/trampoline.c | 17 ++++++++++---
> >  kernel/bpf/verifier.c   | 19 +++++++++++---
> >  6 files changed, 113 insertions(+), 27 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 85567a6ea5f9..3ba30fd6101e 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/nospec.h>
> >  #include <linux/audit.h>
> >  #include <uapi/linux/btf.h>
> > +#include <linux/bpf_lsm.h>

[...]

> > -               if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
> > +               if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
> 
> this should probably also ensure prog->type == BPF_PROG_TYPE_TRACING ?
> Otherwise you can trick kernel with BPF_PROG_TYPE_LSM and
> expected_attach_type == BPF_TRACE_RAW_TP, no?

Indeed, fixed. Thanks!

- KP

> 
> >                         tp_name = prog->aux->attach_func_name;
> > -               else
> > -                       return bpf_tracing_prog_attach(prog);
> > -       } else {
> > +                       break;
> > +               }
> > +               return bpf_tracing_prog_attach(prog);
> > +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
> > +       case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> >                 if (strncpy_from_user(buf,
> >                                       u64_to_user_ptr(attr->raw_tracepoint.name),
> >                                       sizeof(buf) - 1) < 0) {
> > @@ -2479,6 +2495,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
> >                }
> 
> [...]
