Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE44CC885
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiCCWHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 17:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiCCWHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 17:07:01 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62BC16BCC9
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 14:06:14 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id w7so5258933qvr.3
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 14:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5k2k3A0LFYi9Jncq52kJ2NzCsXNzhgHinqc0TjcoM9A=;
        b=XoFbx+xFqBZMAy0LhdIpfAc04plEW2Krcu218bvLJZDQk9+Me3gpAYFsU/afdsjmKE
         mJ3UWBiS6LzY4zTl22WNy3jkXTC+aRUJULXIc8M5JLH9x6zrM7T+asA8NvLrqdsH8JXC
         tvtOXzBS0KErfSA4fHqAo4UbP0vT+rsKMVLgOtR1E544FdXnryqzbFfQGMcb8QU6s551
         S+aLQJTzEphGvhDxZgHkbLTPzB1NStBqRxnu+gSwhMCFSNmGd5gxv00fu1JFpXhOCF0U
         4ihN0y3yK5MTnEa6PmcxZh+WVbue6uewFcqBzc3OX16t+3LsLetq1ufTEUuegghZjZbs
         eCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5k2k3A0LFYi9Jncq52kJ2NzCsXNzhgHinqc0TjcoM9A=;
        b=2hVyBa3s7XdksbN55/gkxGOCpYC5WWxUkGXtUaEM7vvJ20jdKHRKVyrKxRNLkry4Wy
         NtrD/hgQHjAWf7FQfSYWaLK9HY8oSSiGG5MUTOmIfmTyW6wGDjWWKV+TMHXgCpxE6hNe
         WzIkrBLj2l9UfOfR6wMTbbgpGnpdWVRFDxl3UnavqVubqjV9GX9RMNZVe1UK322UWbm6
         Qpn4SDGbMPcpgbgwToSCpGSBXPiMOAvXP7Iavsqtk8JZGEvj/kcZUpu+jQBOkhmk5F08
         pUk6bSB1ZibeWT6/j17GoepzKi0Hlx8UVlkz1KNrmKgx6/AE/CsdoxaHqX8Z97W2OS7h
         qSCg==
X-Gm-Message-State: AOAM531pSpqccn4RTuSsA9cvk/oI7vDpxqiJ2Mgmj/E6+J+5fBEP1DzO
        7JJOKF74GaXjIgdXxobSF2EpqC9Hmg5qbp6z3onS8Q==
X-Google-Smtp-Source: ABdhPJwfeZFI8sgw+nRIbT1l6xDKXxt78DrozcBZtxZc35qlexlXir7g7uMD4liO3+I5+Nv3kNFoMDoIxXejsKk6kYk=
X-Received: by 2002:a05:6214:1881:b0:432:5b6c:2add with SMTP id
 cx1-20020a056214188100b004325b6c2addmr25621693qvb.17.1646345173863; Thu, 03
 Mar 2022 14:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com> <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
 <93c3fc30-ad38-96fa-cf8e-20e55b267a3b@fb.com> <CAADnVQL4yxhDCLjvCCmpOtg0+8-HSg32KG07TCxx+L+Gji7n6g@mail.gmail.com>
 <CA+khW7gyOGgqJjyuSjJMJ8+iQmozZ6VhSJ7exZF0gGLOeS5gog@mail.gmail.com>
 <CAADnVQ+wsp1+4DvrJjw_CAZDatsaQKKz-ZZADdTqSfUAqhv3SA@mail.gmail.com> <CAADnVQ+YBiHR5NyAww3_Y7sW2iANPcVB42SEqdxrvXmaVSEgjg@mail.gmail.com>
In-Reply-To: <CAADnVQ+YBiHR5NyAww3_Y7sW2iANPcVB42SEqdxrvXmaVSEgjg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 14:06:02 -0800
Message-ID: <CA+khW7gXv4839+USyr4+LkpW-Y2Js7shZ4DsvGeZvdRmPr1Fdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 12:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 3, 2022 at 12:02 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 3, 2022 at 11:43 AM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Wed, Mar 2, 2022 at 6:29 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 2, 2022 at 5:09 PM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 3/2/22 1:30 PM, Alexei Starovoitov wrote:
> > > > > > On Wed, Mar 2, 2022 at 1:23 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > >>
> > > > > >>
> > > > > >>
> > > > > >> On 2/25/22 3:43 PM, Hao Luo wrote:
> > > > > >>> Add a new type of bpf tracepoints: sleepable tracepoints, which allows
> > > > > >>> the handler to make calls that may sleep. With sleepable tracepoints, a
> > > > > >>> set of syscall helpers (which may sleep) may also be called from
> > > > > >>> sleepable tracepoints.
> > > > > >>
> > > > > >> There are some old discussions on sleepable tracepoints, maybe
> > > > > >> worthwhile to take a look.
> > > > > >>
> > > > > >> https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/
> > > > > >
> > > > > > Right. It's very much related, but obsolete too.
> > > > > > We don't need any of that for sleeptable _raw_ tps.
> > > > > > I prefer to stay with "sleepable" name as well to
> > > > > > match the rest of the bpf sleepable code.
> > > > > > In all cases it's faultable.
> > > > >
> > > > > sounds good to me. Agree that for the bpf user case, Hao's
> > > > > implementation should be enough.
> > > >
> > > > Just remembered that we can also do trivial noinline __weak
> > > > nop function and mark it sleepable on the verifier side.
> > > > That's what we were planning to do to trace map update/delete ops
> > > > in Joe Burton's series.
> > > > Then we don't need to extend tp infra.
> > > > I'm fine whichever way. I see pros and cons in both options.
> > >
> > > Joe is also cc'ed in this patchset, I will sync up with him on the
> > > status of trace map work.
> > >
> > > Alexei, do we have potentially other variants of tp? We can make the
> > > current u16 sleepable a flag, so we can reuse this flag later when we
> > > have another type of tracepoints.
> >
> > When we added the ability to attach to kernel functions and mark them
> > as allow_error_inject the usefulness of tracepoints and even
> > writeable tracepoints was deminissed.
> > If we do sleepable tracepoint, I suspect, it may be the last extension
> > in that area.
> > I guess I'm convincing myself that noinline weak nop func
> > is better here. Just like it's better for Joe's map tracing.
>
> To add to the above... The only downside of sleepable nop func
> comparing to tp is the lack of static_branch.
> So this nop call will always be there.
> For map tracing and for cgroup mkdir/rmdir the few nanosecond
> overhead of calling an empty function isn't even measurable.

The overhead should be fine, I think. mkdir/rmdir won't be frequent
operations. Thanks for the explanation. Let me give it a try and
report back how it works.
