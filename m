Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35A2B9FC0
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 02:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKTBby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 20:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgKTBbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 20:31:53 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD4C061A04
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 17:31:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id bj5so3181929plb.4
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 17:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YV7yUKCbPzL6ZbCOtKE9ZFlCqJ9wO4xzEn7Kzgi7LU=;
        b=gO8BsWo6dOqcUs861gMwBL0HxSQcRuZTCcz57f1+CWxjckPXZL3zGJxZJV8LnGkgJw
         F60hKSz70xDMl3AgtoEgZga0ibqcCY6clpBLNwfgZ11Pr9YImcJKvBwR/VtX3agVLpKX
         pxr1yQ3B1u1C9fP5b6Sc3rtuMKxb7P1cnETMhhIhMebIlFrCOIQqz7NUQf7orGY9pGGc
         6/YSMnl5V1YDXPb2NIvZxG3M/jdO6LKpafwKiRn9mlpeKu5xfGS4joS21gUzrgVIJSjm
         ngCfJZYty2aDHXVwTNFDSyxYnFcbIq7WzXtwTFZL9XLgQVr2gvb11TklPEN26BYHcMDL
         whSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YV7yUKCbPzL6ZbCOtKE9ZFlCqJ9wO4xzEn7Kzgi7LU=;
        b=GqBv/VQQiBMe74sRUfqNy0eiB2R0iW/Cflm9O0deioi54sU1FM0Liy/XaIsnUXyHCV
         apMa7lbrBp0u66SJbViPMTg3iCSblzE33RSTGk+uRylR2TyxCNawboMBB3mn9o+KVjmN
         nHULb56SlV9WLhLgC8N92J7hvILkYefhkef7R2avnuE/10q9F3n6fF1pcc+lh7K7o+Tn
         /zE+tHUVhMV2MGzDL9R82YQ7UdfEBe/Hz58qcQqPJxTp55P3mIQsGxiKi7d8zLgizZRs
         vmqJrQmKxnPqUh9yYbz0vKOIT9eXUGhhDGKVrjMyI4Lqgs3IKneIoTzb2Q7HmN1NM0Bb
         gSsA==
X-Gm-Message-State: AOAM531z2e91nZ6JnXbmzww+KJbFzOELAw6Nl/iaLvLLjIVqLjm14/Mx
        z1KHCSUWXsGaEdWLmFH/hJvYLqVneKt70nzL8VQpWA==
X-Google-Smtp-Source: ABdhPJwaTuwVNgMnGHMCtpK24Q0O7a5NuKfOgM3R0wMIColDWxbxSFChFeM5H6gT0IaMs1kOho8dDctJ4n9/K8K1QYE=
X-Received: by 2002:a17:902:b18c:b029:d9:f:15fc with SMTP id
 s12-20020a170902b18cb02900d9000f15fcmr11264546plr.29.1605835912854; Thu, 19
 Nov 2020 17:31:52 -0800 (PST)
MIME-Version: 1.0
References: <375636043.48251.1605642440621.JavaMail.zimbra@efficios.com>
 <20201117153451.3015c5c9@gandalf.local.home> <20201118132136.GJ3121378@hirez.programming.kicks-ass.net>
 <CAKwvOdkptuS=75WjzwOho9ZjGVHGMirEW3k3u4Ep8ya5wCNajg@mail.gmail.com>
 <20201118121730.12ee645b@gandalf.local.home> <20201118181226.GK2672@gate.crashing.org>
 <87o8jutt2h.fsf@mid.deneb.enyo.de> <20201118135823.3f0d24b7@gandalf.local.home>
 <20201118191127.GM2672@gate.crashing.org> <20201119083648.GE3121392@hirez.programming.kicks-ass.net>
 <20201119143735.GU2672@gate.crashing.org> <20201119095951.30269233@gandalf.local.home>
 <CAADnVQL8d5zKTE_TohUcGgKKp6K1Noo7M22t_hKYQjO_g0Mb0g@mail.gmail.com>
In-Reply-To: <CAADnVQL8d5zKTE_TohUcGgKKp6K1Noo7M22t_hKYQjO_g0Mb0g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Nov 2020 17:31:41 -0800
Message-ID: <CAKwvOdmKjsJGbR7hHACk3qUgguy-HWvJQerwTnArE0AwhPgfcQ@mail.gmail.com>
Subject: Re: violating function pointer signature
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matt Mullins <mmullins@mmlx.us>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 19, 2020 at 9:05 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 6:59 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > Linux obviously
> > supports multiple architectures (more than any other OS), but it is pretty
> > stuck to gcc as a compiler (with LLVM just starting to work too).
> >
> > We are fine with being stuck to a compiler if it gives us what we want.
>
> I beg to disagree.
> android, chrome and others changed their kernel builds to
> "make LLVM=1" some time ago.
> It's absolutely vital for the health of the kernel to be built with
> both gcc and llvm.

Our fleet of machines in the data centers is currently mid-ramp, at
around or slightly just over 50% of kernels built with Clang.  Soon to
be 100%.  So "a good chunk of Google services," too, FWIW.

OpenMandriva is on track for their 4.2 release to use LLVM for their kernels.
-- 
Thanks,
~Nick Desaulniers
