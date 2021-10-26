Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB643BB56
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 22:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbhJZUD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhJZUD1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 16:03:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BBDC061570
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 13:01:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r12so1112175edt.6
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKzwFWeurfJVMrtwMrdjUR6M6Fw/qPs9lqaaNPXGRCk=;
        b=GUQK4EBpyXiDCb9aUFrpLK8wF28RS6fYkctRKL1dgRXf3Z/bq6+e7Qboy5xme8IjKN
         XTiqg9l6jsoBmgk2vDO4SDk8k7cguqWCevReMxBnQDsvIzTQA8XKunSH64f8G06C7LJO
         ILceUah1HcV+vKcMK/2qARv1aWgqvcYcPOXzS0jfwlh4Sfp1VjgoH5SUCeS6BsocMYCy
         af2+7jN0yjigSgKhkOc8sOriOFyHInk0tCTU4IyWc09Z4eKiK69Ouf19V8kV5/bFDm5U
         CAIR2LsRTFq2xPqA5aVEbjGspGTodY01U/HxDcBbU9Y5g71GcnI/0RxV5NJKfJGG+04l
         i4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKzwFWeurfJVMrtwMrdjUR6M6Fw/qPs9lqaaNPXGRCk=;
        b=CxNeWJI7IXzkL13Ce9kG/36x8VwR4mULH8RTkQx6VDu1Yws/Axy62q5dc5XjkAC2pb
         kB+rBHW+iENiMg8tZ7l5RhiUQ8fQq5l5ZO6PK9JFevfVRwPOICfPSy/AjvUXCWz02BwG
         PRxzSrEEDLcecJxH8AQkvN3S0jHafWSYhzZtbaTpF3G1fU0q+6TbO0sQfeclwIIKYQA7
         rxaGxUMgkD9ocxX6qHDgAsoBhsd8ot+B15ihK0mJOFxLlF3wEoG/gg7jP4wQK7pNVC9c
         KRXCY45CgA1X73+ssZme2rFHU+38TIIX/jSDeQspn61ETMZPNmexGLrTkADcNI3cBQhx
         cipQ==
X-Gm-Message-State: AOAM531MaPJPoThjzQZ2ZOxpLQMmUF6m4aZK3iMHZ0FRth+Em0lTGJuG
        vwp+ipCtvuDd2MCfCrfpLC+QXb4ooOFsT0+Wy1Ch9Q==
X-Google-Smtp-Source: ABdhPJwmPcc9k+DGvU5/e6/BkFjMBmUAvRFfPFqeAdJGswM0FbMMkHD8RTQMOr/rxGC8eeVX+ifSs+SwLCUDA82lgwU=
X-Received: by 2002:a17:906:8478:: with SMTP id hx24mr33359431ejc.67.1635278461048;
 Tue, 26 Oct 2021 13:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211025231256.4030142-1-haoluo@google.com> <20211025231256.4030142-3-haoluo@google.com>
 <CAEf4Bzb_nUqXtJ0FhKJVjxJjt8vjTPxuTzrEzDFN_kqGw3wuCw@mail.gmail.com>
 <CA+khW7hO4NrXOUL2UYt36dZCuuLTeLS0pREcbiVyoV6X6d6qHA@mail.gmail.com> <CAEf4Bzb0Gu9mv6HKgqYtcA9iUV6XvAXXLdkfeL=8=WFu7y03GQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0Gu9mv6HKgqYtcA9iUV6XvAXXLdkfeL=8=WFu7y03GQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 26 Oct 2021 13:00:49 -0700
Message-ID: <CA+khW7hhaVPriv9D0veYokOau+VR0ZSoUMVoaQD0Y2NF8mxwmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 11:53 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 26, 2021 at 10:51 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 10:06 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 25, 2021 at 4:13 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Some helper functions may modify its arguments, for example,
> > > > bpf_d_path, bpf_get_stack etc. Previously, their argument types
> > > > were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> > > > mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> > > > to modify a read-only memory by passing it into one of such helper
> > > > functions.
> > > >
> > > > This patch introduces a new arg type ARG_PTR_TO_WRITABLE_MEM to
> > > > annotate the arguments that may be modified by the helpers. For
> > > > arguments that are of ARG_PTR_TO_MEM, it's ok to take any mem type,
> > > > while for ARG_PTR_TO_WRITABLE_MEM, readonly mem reg types are not
> > > > acceptable.
> > > >
> > > > In short, when a helper may modify its input parameter, use
> > > > ARG_PTR_TO_WRITABLE_MEM instead of ARG_PTR_TO_MEM.
> > >
> > > This is inconsistent with the other uses where we have something
> > > that's writable by default and mark it as RDONLY if it's read-only.
> > > Same here, why not keep ARG_PTR_TO_MEM to mean "writable memory", and
> > > add ARG_PTR_TO_RDONLY_MEM for helpers that are not writing into the
> > > memory? It will also be safer default: if helper defines
> > > ARG_PTR_TO_MEM but never writes to it, worst thing that can happen
> > > would be that you won't be able to pass REG_PTR_TO_RDONLY_MEM into it
> > > without fixing helper definition. The other way is more dangerous. If
> > > ARG_PTR_TO_MEM means read-only mem and helper forgot this distinction
> > > and actually writes into the memory, then we are in much bigger
> > > trouble.
> > >
> >
> > My original implementation was adding ARG_PTR_TO_RDONLY_MEM. But I
> > find it's not intuitive for developers when adding helpers. The
> > majority of PTR_TO_MEM arguments are read-only. When adding a new
> > helper, I would expect the default arg type (that is, ARG_PTR_TO_MEM)
> > to match the default case (that is, read-only argument). Requiring
> > explicitly adding RDONLY to most cases seems a little unintuitive to
> > me.
> >
> > But other than that, I agree that narrowing ARG_PTR_TO_MEM down to
> > writable memory fosters more strict checks and safer behavior. But
> > when people add helpers, they are clearly aware which argument will be
> > modified and which will not. IMHO I do trust that the developers and
> > the reviewers can choose the right type at the review time. :)
>
> I don't trust myself, and neither should you :) See 5b029a32cfe4
> ("bpf: Fix ringbuf helper function compatibility") as an example of
> the things that shouldn't have happened, but slipped through my own
> testing and code review anyway. And there were multiple cases where we
> accidentally enabled stuff that we shouldn't or didn't check something
> that should have been prevented.
>
> All that is to say that if we can have safer behavior by default (not
> as enforced by humans), then it's better. In this sense,
> ARG_PTR_TO_MEM meaning writable access is safer, because even if we
> accidentally forget to mark some input as ARG_PTR_TO_RDONLY_MEM, worst
> thing is that users won't be able to use helper in some situation and
> hopefully will report this and we'll fix it. The alternative is that a
> helper declares the argument as read-only memory (accidentally,
> because it's shorter enum and sort of default), but actually does the
> write to that memory. Now we have a much bigger issue.
>

Acknowledged. Will make this change in this next iteration.

> >
> > > >
> > > > So far the difference between ARG_PTR_TO_MEM and ARG_PTR_TO_WRITABLE_MEM
> > > > is PTR_TO_RDONLY_BUF and PTR_TO_RDONLY_MEM. PTR_TO_RDONLY_BUF is
> > > > only used in bpf_iter prog as the type of key, which hasn't been
> > > > used in the affected helper functions. PTR_TO_RDONLY_MEM currently
> > > > has no consumers.
> > > >
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > > >  Changes since v1:
> > > >   - new patch, introduced ARG_PTR_TO_WRITABLE_MEM to differentiate
> > > >     read-only and read-write mem arg types.
> > > >
>
> [...]
