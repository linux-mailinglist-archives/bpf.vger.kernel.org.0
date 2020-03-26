Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14FE1947B4
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 20:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCZToG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 15:44:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39224 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgCZToG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 15:44:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id a9so8692133wmj.4
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0Bii1s2deigTxksVQn5D4fa3g6KSqWpYF2vfQCrTCkQ=;
        b=mXue/BH8dMK46Q+CxoPuOCAXIhsjfNF4BBz9nY0CKpqWmSNg1EdIyHxC/ObRwwi+4Y
         vrbbv616X1THSsMHpH5lPr0ZnkJbdXDnByiot4haqIrWo6+ag7FMFpksuXbvMVX5B1mz
         KDJ9sjiU9NcbKj1KvyZfGqfFysuI5OEoyFOoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0Bii1s2deigTxksVQn5D4fa3g6KSqWpYF2vfQCrTCkQ=;
        b=msHpgOX9gqjs3lWa7iPugy+uSYWyTkGK1fr+cj1a28Olv18ObvhEJNdy1ubUUt11RH
         v5GNOpAna68fSA8yPZHwUY2mAMUI5tBGqFjhpaXIHqN3qM9DTmp6qAw1vAA/90IE3naM
         RZxUEm4i4UzS1i6t8kYnftW/+uKKe9gqXzxEplxmZZS+V24QfX7g9IdtZACFOihlUdMj
         Y2Wv9DgKF5No+DM5KMU2P8xnPtiA0Lmva3oZKkEhNqmPuy3f3rIyS6PV0FspPhQtYSNo
         P058mTBswChY9XFcQxHNz+WcyYSYl2kFOdAwuZVtZvbLdkpbik/F3Y+o7WOBNdVTEAU7
         9vDQ==
X-Gm-Message-State: ANhLgQ3l3eFviuFWnRs+3c/6vdNQvJWlk8qneWjRR87wLf6ZpDGz5Ju2
        mapXAVLHzk86pUCzvdx/OhFt0g==
X-Google-Smtp-Source: ADFU+vv6oOna9/uYcBsBB+T/TvHqVZPZsv2Q92xO2Srm3mQHiGr5MgeyNE/xuLzjiHifH8JuX6CviQ==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr1548359wmj.186.1585251843249;
        Thu, 26 Mar 2020 12:44:03 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id s127sm4869574wmf.28.2020.03.26.12.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:44:02 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 20:44:00 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200326194400.GB15273@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-8-kpsingh@chromium.org>
 <CAEf4BzZRe_kFR4yzhPFGgauvYLKvre1reuGp=5=jq_nvQGAayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZRe_kFR4yzhPFGgauvYLKvre1reuGp=5=jq_nvQGAayw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26-Mär 12:24, Andrii Nakryiko wrote:
> On Thu, Mar 26, 2020 at 7:30 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Load/attach a BPF program that hooks to file_mprotect (int)
> >   and bprm_committed_creds (void).
> > * Perform an action that triggers the hook.
> > * Verify if the audit event was received using the shared global
> >   variables for the process executed.
> > * Verify if the mprotect returns a -EPERM.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > ---
> 
> Please fix endlines below. With that:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> >  tools/testing/selftests/bpf/config            |  2 +
> >  .../selftests/bpf/prog_tests/test_lsm.c       | 86 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/lsm.c       | 48 +++++++++++
> >  3 files changed, 136 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/lsm.c
> >
> 
> [...]
> 
> > +void test_test_lsm(void)
> > +{
> > +       struct lsm *skel = NULL;
> > +       int err, duration = 0;
> > +
> > +       skel = lsm__open_and_load();
> > +       if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
> > +               goto close_prog;
> > +
> > +       err = lsm__attach(skel);
> > +       if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
> > +               goto close_prog;
> > +
> > +       err = exec_cmd(&skel->bss->monitored_pid);
> > +       if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
> > +               goto close_prog;
> > +
> > +       CHECK(skel->bss->bprm_count != 1, "bprm_count", "bprm_count = %d",
> 
> \n is missing

Done.

> 
> > +             skel->bss->bprm_count);
> > +
> > +       skel->bss->monitored_pid = getpid();
> > +
> > +       err = heap_mprotect();
> > +       if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
> > +                 errno))
> > +               goto close_prog;
> > +
> > +       CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
> > +             "mprotect_count = %d", skel->bss->mprotect_count);
> 
> \n is missing

Done.

- KP

> 
> > +
> > +close_prog:
> > +       lsm__destroy(skel);
> > +}
> 
> [...]
