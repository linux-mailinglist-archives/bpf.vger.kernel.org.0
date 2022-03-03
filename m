Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF174CC6B9
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 21:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiCCUDM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 15:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiCCUDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 15:03:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660ECF3;
        Thu,  3 Mar 2022 12:02:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p17so5723578plo.9;
        Thu, 03 Mar 2022 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWjI86b7R3B3kMyOH13PFG9bWZbWpn8g1Sw0hYy2D/U=;
        b=MAM6J173JByHHRAPuVsty9X85WMvv3RyH+xNsN8ibIXt8C5YjxtQkgHfeoXEdagV1t
         Dtn9pKz/OM0PW0dH94Igmy9+lvbbaWMsVhoO4xM+rYnHcf8XasjF0qqfou0+Kd1I3BYX
         NQPeFDaw3fx/MRYAGEowZy7HxUl8vZBITqUbDYRlDyWRBdZ7J0DrrHjuNk5oIcJtd0nD
         /HAXWY0bdA5MxZbDTQK7TcqmjU613oPXEGFPVfN2+p7Z7LxbCYgsPnZef8NDfHmI+kyX
         Gh1clstWJgmVgjZ+AwQ4Uj80X1eEiII0XGZJg5iwdZNnbvUrzIUVuIuZ6g/bw0B6+hCl
         AWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWjI86b7R3B3kMyOH13PFG9bWZbWpn8g1Sw0hYy2D/U=;
        b=67PkGCOWQLTGkBl24GIaiUGLz4mR4aUSv68C1VB37tdys6ni9S2+UeC8u5vewB0Irr
         Ox63f7zXZZaP5tgJbaQ5LyG46ZM64mmvP94NPpuw9lG1cbJC2mqajBySL0ar0TO3W+Fo
         jZzY/rt1RytUd/s0eo8Ael457IWOdQEWjyMY6O6/wEGuPFc6tSZp0uVcxcshrYtZWWyr
         s5F4113DQSthDsdmxMa5gpiSQQfjgY9PiajOk2mR29Tf45RPU6n6H1qLZrsz/1+agGi4
         gB2+I8HCumvd+rhF8EuPZqZKqH1Lhpbvi5WPgCIsX5cDfo0aaUw3EMg1KAcT1pZXdGBg
         moig==
X-Gm-Message-State: AOAM531nD4tGaDPbUhtvNrdutK5FSwesb0iiKxKKizoHIgGqA1B6kGh3
        VsG6IDpc5wGU5xDSqDvN4yMxMm8OG74VOA1KXKRsSbzh
X-Google-Smtp-Source: ABdhPJwObUr+x7WNvTmIry3wywx51F71HLMzi+NquCizbt6XTffjUgZSVRe2BLbNkyjZxVNK3m/29HA8WwiDiLUPTEw=
X-Received: by 2002:a17:90b:10b:b0:1bc:6f86:b209 with SMTP id
 p11-20020a17090b010b00b001bc6f86b209mr7058410pjz.33.1646337744857; Thu, 03
 Mar 2022 12:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com> <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
 <93c3fc30-ad38-96fa-cf8e-20e55b267a3b@fb.com> <CAADnVQL4yxhDCLjvCCmpOtg0+8-HSg32KG07TCxx+L+Gji7n6g@mail.gmail.com>
 <CA+khW7gyOGgqJjyuSjJMJ8+iQmozZ6VhSJ7exZF0gGLOeS5gog@mail.gmail.com>
In-Reply-To: <CA+khW7gyOGgqJjyuSjJMJ8+iQmozZ6VhSJ7exZF0gGLOeS5gog@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Mar 2022 12:02:13 -0800
Message-ID: <CAADnVQ+wsp1+4DvrJjw_CAZDatsaQKKz-ZZADdTqSfUAqhv3SA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
To:     Hao Luo <haoluo@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 11:43 AM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Mar 2, 2022 at 6:29 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 2, 2022 at 5:09 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > >
> > >
> > > On 3/2/22 1:30 PM, Alexei Starovoitov wrote:
> > > > On Wed, Mar 2, 2022 at 1:23 PM Yonghong Song <yhs@fb.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2/25/22 3:43 PM, Hao Luo wrote:
> > > >>> Add a new type of bpf tracepoints: sleepable tracepoints, which allows
> > > >>> the handler to make calls that may sleep. With sleepable tracepoints, a
> > > >>> set of syscall helpers (which may sleep) may also be called from
> > > >>> sleepable tracepoints.
> > > >>
> > > >> There are some old discussions on sleepable tracepoints, maybe
> > > >> worthwhile to take a look.
> > > >>
> > > >> https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/
> > > >
> > > > Right. It's very much related, but obsolete too.
> > > > We don't need any of that for sleeptable _raw_ tps.
> > > > I prefer to stay with "sleepable" name as well to
> > > > match the rest of the bpf sleepable code.
> > > > In all cases it's faultable.
> > >
> > > sounds good to me. Agree that for the bpf user case, Hao's
> > > implementation should be enough.
> >
> > Just remembered that we can also do trivial noinline __weak
> > nop function and mark it sleepable on the verifier side.
> > That's what we were planning to do to trace map update/delete ops
> > in Joe Burton's series.
> > Then we don't need to extend tp infra.
> > I'm fine whichever way. I see pros and cons in both options.
>
> Joe is also cc'ed in this patchset, I will sync up with him on the
> status of trace map work.
>
> Alexei, do we have potentially other variants of tp? We can make the
> current u16 sleepable a flag, so we can reuse this flag later when we
> have another type of tracepoints.

When we added the ability to attach to kernel functions and mark them
as allow_error_inject the usefulness of tracepoints and even
writeable tracepoints was deminissed.
If we do sleepable tracepoint, I suspect, it may be the last extension
in that area.
I guess I'm convincing myself that noinline weak nop func
is better here. Just like it's better for Joe's map tracing.
