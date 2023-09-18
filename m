Return-Path: <bpf+bounces-10308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5EA7A4E4D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67AD281477
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5657623774;
	Mon, 18 Sep 2023 16:07:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119E210FB;
	Mon, 18 Sep 2023 16:07:55 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E5F46BA;
	Mon, 18 Sep 2023 09:07:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso47331365e9.1;
        Mon, 18 Sep 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053262; x=1695658062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8DqzhvzyGA39Yvgz+zBRm+sIYZErBZTUzgkb6fr790=;
        b=OvdiFBZN0FhFPMNTD5Tsj4dfT3/0/g4OGvo0a8AHecS7aOo+d+A13yQcrMRwEcK3U2
         Cxzpe+i++Htli53SpWnhykUcLFH1f6JulIDLnmtRmz4JXbNKO6BLZ1LVxRpX+JNYqkls
         8l2dA70n2WQCw2HlXG0/WZcCtP1/HLLWXs0H+zd4GoEnSQerG8+m7+f7iPs7aSQUFhZN
         su4NJwisDz83dJziEut67D7aYB32/XdgjJqYGpinkFGjA5ov38EnneKFWt0KVMNgKxZK
         B1xy/1rGiQbW5hs6Jfk0/1e1P4PMtX1xpIQn5/gxOSEbmrxjKcGsIYDpmNlR4c73Z74Y
         yOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053262; x=1695658062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8DqzhvzyGA39Yvgz+zBRm+sIYZErBZTUzgkb6fr790=;
        b=SNCEdPeJYLP/Ta2kSopq/dLexKbQWbytGjGBFNMR6b9N/xOGi0WnX631q+qKlABfHQ
         YpDWvN+w61t/HbOqnH1Zr9DrDlXe+N3rgiFPXibCDdoB1Nxebp7aUj0dPF/YgCwbPvtz
         jtGvt6fR7X5iNgucdONUE8XoKpRmRfI06eqFf8lEfjHWt0nn81ZOMT19LxgAvOpHdriV
         T+grYlc7A84Z9UJVHOJwYbQMCYeYpmuS6hy1aEpo+/yVh0iFug77DdMJ9diYMPRACQX3
         nC24ygXE+bq9HLGzwhVuTyejOw2RTlMSijAldnuZ6046sPHwaXZMDZXfmDIMqLQGDxkX
         FDzg==
X-Gm-Message-State: AOJu0Ywk/dBGQEgYu4BCxOG1ob/afPNZhKqjCvct+Gq7UkWEqQ7ks8YW
	G6KLbEdzzv8a3sAqSh3XtDrNnQ9NyMF0aEjIbpQfgcuLipA=
X-Google-Smtp-Source: AGHT+IGv+cuS54y/ErE5nGFW0PhBBF5V5HKYi2enBs4vIQaNjWZXZ6zmR+tedv60Zzbf/GLfnsSHAJ6CT+JRpZdhNeA=
X-Received: by 2002:a17:906:20f:b0:9ad:8c4f:1f1a with SMTP id
 15-20020a170906020f00b009ad8c4f1f1amr8325459ejd.30.1695043600498; Mon, 18 Sep
 2023 06:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-11-memxor@gmail.com>
 <fb51f3ed-a8aa-42f1-b649-eb684235323a@tessares.net>
In-Reply-To: <fb51f3ed-a8aa-42f1-b649-eb684235323a@tessares.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 18 Sep 2023 15:26:04 +0200
Message-ID: <CAP01T76ivGmVai3WbYo3D2jiz=rLubAHEpzihYinbKYKvGpViA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/17] bpf: Prevent KASAN false positive with bpf_throw
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: bpf@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, netdev <netdev@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sept 2023 at 15:20, Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Kumar,
>
> (+ netdev in Cc as this patch is now in net-next tree as well ; same for
> mptcp-next)
>
>
> On 13/09/2023 01:32, Kumar Kartikeya Dwivedi wrote:
> > The KASAN stack instrumentation when CONFIG_KASAN_STACK is true poisons
> > the stack of a function when it is entered and unpoisons it when
> > leaving. However, in the case of bpf_throw, we will never return as we
> > switch our stack frame to the BPF exception callback. Later, this
> > discrepancy will lead to confusing KASAN splats when kernel resumes
> > execution on return from the BPF program.
> >
> > Fix this by unpoisoning everything below the stack pointer of the BPF
> > program, which should cover the range that would not be unpoisoned. An
> > example splat is below:
>
> Thank you for your patch!
>
> (...)
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 78e8f4de6750..2c8e1ee97b71 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/security.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/bpf_mem_alloc.h>
> > +#include <linux/kasan.h>
> >
> >  #include "../../lib/kstrtox.h"
> >
> > @@ -2483,6 +2484,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> >               WARN_ON_ONCE(!ctx.aux->exception_boundary);
> >       WARN_ON_ONCE(!ctx.bp);
> >       WARN_ON_ONCE(!ctx.cnt);
> > +     /* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
> > +      * deeper stack depths than ctx.sp as we do not return from bpf_throw,
> > +      * which skips compiler generated instrumentation to do the same.
> > +      */
> > +     kasan_unpoison_task_stack_below((void *)ctx.sp);
>
> Our CI validating MPTCP tree has just reported the following error when
> building the kernel for a 32-bit architecture:
>
>   kernel/bpf/helpers.c: In function 'bpf_throw':
>   kernel/bpf/helpers.c:2491:41: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
>    2491 |         kasan_unpoison_task_stack_below((void *)ctx.sp);
>         |                                         ^
>   cc1: all warnings being treated as errors
>
> Source:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6221288400/job/16882945173
>
>
> It looks like this issue has been introduced by your patch. Are you
> already looking at a fix?
>

Yes, my patch is responsible. So pointers here are 32-bits, while
ctx.sp is 64-bit, hence it is complaining.
I think long is supposed to match pointer width on all targets Linux
supports, so doing this should fix it.
(void*)(long)ctx.sp

I will send a fix for this soon.

Thanks


> >       ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
> >  }
> >
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

