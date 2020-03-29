Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07F196A25
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 01:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC2AHn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 20:07:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34200 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgC2AHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 20:07:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so13007925wmk.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2020 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmKZjEjyoZBWP3zxzq+jmwKlApxNsmeX6tcgIBr0Rbs=;
        b=iDo6heMrruNgAAYPc9a+X3SHXDi261CceFI9H0ElOTwKRljxR2ublgwHP0V5HnlVVs
         Vk4UxYm80IWn/SnoyFtSfYz8rkUNXlXVnhQrQcW4bCPP2uKxVSl4AgG1XySxxAXFLapM
         94FsgVIbKi+FkL75GCBrwtXvhzqo1wmDUuKjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmKZjEjyoZBWP3zxzq+jmwKlApxNsmeX6tcgIBr0Rbs=;
        b=IOOe486An/Wl7cfPPcmBGWGub2+BkeXl4xRy0m1EJJtSQP0Qk+8ZBUS8YVhT6Ki0So
         rkFYMJTITySyNAt/NmVRp744+oPs8Cuhj8QnpNAQqGP5cFV/Kzgfc8B4UDNo2tnYGm9l
         mFVLJQL7Uh0ewcgtIUD/nWBAloaq6d1qQYZ9KisYi2HVBkTJkX/P9gMk/khufYT+BfSs
         ckBtRqJHzHEgMyk8l+oRdwHDtcx3d37LO3utgFFMLyRO7L8AIPh+SbNiJz1KhvQGbgdc
         3mTZl0OL/NhSFcV+ghLLAEK/HskYXz4vSsc+u1+mncbzxLks+czgWGfyMbi5mOSttrQp
         fixw==
X-Gm-Message-State: ANhLgQ1B8F6eaMf0ekpZvUiK39VQbS0VfC72IlQfW0hkOMYAVmDHQXTH
        3fj3HsmS+ldl86GHP7qM10nrrA==
X-Google-Smtp-Source: ADFU+vuXe3yfESUYjb5C4OHsBsQCAuVzJ/1ssVHrp3ycSEsL9Xml8SVXHWNoWmBw7XdvoQfJNt5niA==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr6021373wmd.16.1585440460849;
        Sat, 28 Mar 2020 17:07:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id t81sm14436603wmb.15.2020.03.28.17.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 17:07:40 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sun, 29 Mar 2020 01:07:38 +0100
To:     KP Singh <kpsingh@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200329000738.GA230422@google.com>
References: <20200327192854.31150-1-kpsingh@chromium.org>
 <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
 <20200328195636.GA95544@google.com>
 <202003281449.333BDAF6@keescook>
 <CACYkzJ4v_X87-+GCE++g0_BkcJWFhbNePAMQmH8Ccgq7id-akA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ4v_X87-+GCE++g0_BkcJWFhbNePAMQmH8Ccgq7id-akA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 28-Mar 23:30, KP Singh wrote:
> On Sat, Mar 28, 2020 at 10:50 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sat, Mar 28, 2020 at 08:56:36PM +0100, KP Singh wrote:
> > > Since the attachment succeeds and the hook does not get called, it
> > > seems like "bpf" LSM is not being initialized and the hook, although
> > > present, does not get called.
> > >
> > > This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
> > > there by default as we added it to default value of CONFIG_LSM and
> > > also for other DEFAULT_SECURITY_* options.
> > >
> > > Let me know if that's the case and it fixes it.
> >
> > Is the selftest expected to at least fail cleanly (i.e. not segfault)
> 
> I am not sure where the crash comes from, it does not look like it's test_lsm,
> it seems to happen in test_overhead. Both seem to run fine for me.

So I was able to reproduce the crash:

* Remove "bpf" from CONFIG_LSM

./test_progs -n 66,67
test_test_lsm:PASS:skel_load 0 nsec
test_test_lsm:PASS:attach 0 nsec
test_test_lsm:PASS:exec_cmd 0 nsec
test_test_lsm:FAIL:bprm_count bprm_count = 0
test_test_lsm:FAIL:heap_mprotect want errno=EPERM, got 0
#66 test_lsm:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x1f)[0x55b7f9867acf]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x13520)[0x7fcf1467e520]
/lib/x86_64-linux-gnu/libc.so.6(+0x15f73d)[0x7fcf1460a73d]
/lib/x86_64-linux-gnu/libc.so.6(__libc_calloc+0x2ca)[0x7fcf1453286a]
/usr/lib/x86_64-linux-gnu/libelf.so.1(+0x37

[snip]

* The crash went away when I removed the heap_mprotect call, now the BPF
  hook attached did not allow this operation, so it had no side-effects.
  Which lead me to believe the crash could be a side-effect of this
  operation. So I did:

--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -29,7 +29,7 @@ int heap_mprotect(void)
        if (buf == NULL)
                return -ENOMEM;

-       ret = mprotect(buf, sz, PROT_READ | PROT_EXEC);
+       ret = mprotect(buf, sz, PROT_READ | PROT_WRITE | PROT_EXEC);
        free(buf);
        return ret;
 }

and the crash went away. Which made me realize that the free
operation does not like memory without PROT_WRITE, So I did this:

diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index fcd839e88540..78f125cc09b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -30,7 +30,7 @@ int heap_mprotect(void)
                return -ENOMEM;

        ret = mprotect(buf, sz, PROT_READ | PROT_EXEC);
-       free(buf);
+       // free(buf);
        return ret;
 }

and the crash went away as well. So it indeed was a combination of:

* CONFIG_LSM not enabling the hook
* mprotect marking the memory as non-writeable
* free being called on the memory.

I will send a v9 which has the PROT_WRITE on the mprotect. Thanks
for noticing this!

- KP

> 
> - KP
> 
> > when the BPF LSF is not built into the kernel?
> >
> > --
> > Kees Cook
