Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBE6C7605
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 03:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCXCw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 22:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXCw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 22:52:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112D71735;
        Thu, 23 Mar 2023 19:52:26 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 31so894622qvc.1;
        Thu, 23 Mar 2023 19:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679626345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kLA9ePDfsIWLWaaUeWdmqqTIGf6YKF6OJKf565dLt4=;
        b=EgZQ6sAVg6yOMJKap3zJklJWCrh9V7P3ehcnzI3QGDBg4uXTByOJ5DR3nE9s/lvMgd
         MhKoE+qGJn9igI+wGrgjxXX0dQLRrOTEWSm6WfOVdY53diw7fdtATWQ+RsxUQ3XxYXg9
         5MSK9DPmeXzUOyl76gvbFltdmOCfkHDG5e1hviiqMMCYzwTpxLzaAzDX78nH/KEoSXb7
         X6CNxh/qKID6nz58WNiBEDHd6JY+fRVRNe7BBH09P52inau24hZxBcserGW3Q+bKMGMZ
         ymt49/wZLSJ2/GjoKR+3GZ0oeUj6miyZXFi79O0u5T50R0pSQEbNwgkUklARPNBDprKf
         +icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679626345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kLA9ePDfsIWLWaaUeWdmqqTIGf6YKF6OJKf565dLt4=;
        b=6TJlQAryM1K7Pw5pJkOnQs+JvV8JvRLUbqTHM2/BJWUS5ZbW0cDVg6rXRFkvbJWMFe
         PRp1l7cC1idAO2lwp3wMAXRPWTENA//x0aWDMKarBg1+sUEt5PP3Km21/L47e5NzboGe
         TvydHN4gGMU14WzJ4dMrVIGfCaLuK3ZCdJuanNSLeLMfHAUuWxFk6Ju1/gzqkbWWCs+x
         w2d83ZLiuO23UO4ZU6+WqqmPeWTXEeimRbKm9puULGCOqEKXkdPKshJZ4XBviJIhrn/Y
         +fp16ibHUNlt+18yrIL1j+2k8axxDtNcIf/Ymk24cS2FmFVxfrMjIe1eKBnPDlSKhbO+
         P/DQ==
X-Gm-Message-State: AAQBX9cdzEe7Rg5lJMG6vlyBJH9bvBhoBunSgD68H9xq5i58nKGoSnpt
        94EW0nLO6o524BYX23KDd9UMcBaosVyFYweGemE=
X-Google-Smtp-Source: AKy350Ze7k2QAxUkWoYec+TI8n98zhrcEETw8NaJEOX3EnJMPy6zFccRQLRulGj0g/5BiH3CMWf1bbSXJIVkIXawURc=
X-Received: by 2002:ad4:56f2:0:b0:56f:3e5:850e with SMTP id
 cr18-20020ad456f2000000b0056f03e5850emr178733qvb.3.1679626344964; Thu, 23 Mar
 2023 19:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230321020103.13494-1-laoar.shao@gmail.com> <20230321101711.625d0ccb@gandalf.local.home>
 <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com> <20230323083914.31f76c2b@gandalf.local.home>
In-Reply-To: <20230323083914.31f76c2b@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 24 Mar 2023 10:51:49 +0800
Message-ID: <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 23, 2023 at 8:39=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 23 Mar 2023 13:59:34 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > I have verified the latest linux-trace tree,
> >     git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> > trace/core
> >
> > The result of "uname -r" is ''6.3.0-rc3+".
> > This issue still exists, and after applying this patch it disappears.
> > It can be reproduced with a simple bpf program as follows,
> >     SEC("kprobe.multi/preempt_count_sub")
> >     int fprobe_test()
> >     {
> >         return 0;
> >     }
>
> Still your patch is hiding a bug, not fixing one.
>
> Can you apply this patch and see if the bug goes away?
>

I have verified that the bug goes away after applying this patch.
Thanks for the fix.

--=20
Regards
Yafang
