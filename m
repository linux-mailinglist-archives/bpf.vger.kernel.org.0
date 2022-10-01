Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8515F16EB
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 02:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiJAAF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 20:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiJAAF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 20:05:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F357C337
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 17:05:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id q11so2419427ilj.10
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=A+2/ayyfy7/U4RI/ZFNVVbRD0jx8zZBgezWmbKcsfao=;
        b=O/A1MTpF9FLdJ9AjmwBvV0XwB0UJVyqUCIediRRnslXZ6Y0P3qTRWQoIz5ObpKhOnF
         tHSmHBdl6bYxVpbQHYRBbVCSC+hL+8xr6gSfbLOucI/Xo40ayi3YQK4FkOBiYnNH+OHa
         yThHLtWNrurtpTJomEm6N7XwEmlRYli8VSfGOj2Su+bYfo1hodBi5rrfk3ocp2kBZCZk
         6kR9e0k17DO5zMBSMoo8MDr5GqO8Qbfn5OTMZ6GnU0uMFM/aSTXK5m4tW354WozTMlkp
         nwSOOvCnV5hEIWaFPc3csrl3u2arVExP7wyaOHgaXrHZFxDG55GEd70Lm9mcd9gYwYjB
         ipzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=A+2/ayyfy7/U4RI/ZFNVVbRD0jx8zZBgezWmbKcsfao=;
        b=Y82HLRWzhmR+eh7mxGIuc4fbCb5NFoxR/Xhu55Wa3w+u2De45mE7v0M/32N+PrKivY
         Foc7LhDMmxk2+ERgxNka9QWAfxoBKbBTeaaYuQAcRjDuKfKpEoRdt4olEG9xe8rWbBo+
         sg+3heE19cX0YGCrCcND1vix6GxfbER8j47Rox9JGlBtqZ5aDunFL3F2MXRju080L38l
         aYGun6LPqpwMcNDnskcKBHk4iswQ8+/JES24yShXuObNut03RjExdX+0meimIgErBQMS
         cINKb6XHD4c4p58VBilWlBHfoNjdJ24buO/XlQyFmOr+9rGGWbULf38cNlMlyidhUH0E
         Mc1A==
X-Gm-Message-State: ACrzQf0PV9qgIAhDKTLj0B5Lh30TpK+y/FZB7IF5pIz0DJt/7HgoMFyQ
        qtrtE/Ie7UfP6bFYkzVMjf7ZsXWIYC9cZPcWLH7iNA==
X-Google-Smtp-Source: AMsMyM5ZtEZb3rfecZTvoDGyn6Ez81HPmT6ej35lK13CRR6LH+eBUP10v+FP2U7DzNb3ey0PAOCmPRHXdNT9TmH96eI=
X-Received: by 2002:a92:a306:0:b0:2f8:dac3:da11 with SMTP id
 a6-20020a92a306000000b002f8dac3da11mr5382390ili.68.1664582753003; Fri, 30 Sep
 2022 17:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
In-Reply-To: <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Fri, 30 Sep 2022 17:05:42 -0700
Message-ID: <CA+PiJmQM_Fi-W7ZaPQHiM6w6eqo0TSpTh3rUz+CnmXRbp_PUBA@mail.gmail.com>
Subject: Re: [PATCH 00/26] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 11:41 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> Interesting idea.
>
> Some comments on review logistics:
> - The set is too long and some of the individual patches are way too long for
> one single patch to review.  Keep in mind that not all of us here are experts in
> both fuse and bpf.  Making it easier to review first will help at the beginning.
>   Some ideas:
>
>    - Only implement a few ops in the initial revision. From quickly browsing the
> set, it is implementing the 'struct file_operations fuse_file_operations'?
> Maybe the first few revisions can start with a few of the ops first.
>

I've split it up a fair bit already, do you mean just sending a subset
of them at a time? I think the current splitting roughly allows for
that. Patch 1-4 and 5 deal with bpf/verifier code which isn't used
until patch 24. I can reorder/split up the opcodes arbitrarily.
Putting the op codes that implement file passthrough first makes
sense. The code is much easier to test when all/most are present,
since then I can just use patch 23 to mount without a daemon and run
xfs tests on them. At least initially I felt the whole stack was
useful to give the full picture.

>    - Please make the patches that can be applied to the bpf-next tree cleanly.
> For example, in patch 3, where is 18e2ec5bf453 coming from? I cannot find it in
> bpf-next and linux-next tree.
>    - Without applying it to an upstream tree cleanly, in a big set like this, I
> have no idea when bpf_prog_run() is called in patch 24 because the diff context
> is in fuse_bpf_cleanup and apparently it is not where the bpf prog is run.
>

Currently this is based off of
bf682942cd26ce9cd5e87f73ae099b383041e782 in
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
I would have rebased on top of bpf-next, except that from my
conversations at plumbers, I figured that the set up would need to
change significantly, and that effort would be wasted. My goal
including them here was to give more of a sense of what our needs are,
and be a starting point for working out what we really ought to be
using.

> Some high level comments on the set:
> - Instead of adding bpf helpers, you should consider kfunc instead. You can take
> a look at the recent HID patchset v10 or the recent nf conntrack bpf set.
>
> - Instead of expressing as packet data, using the recent dynptr is a better way
> to go for handling a mem blob.
>

I'll look into those, I remember them coming up at LPC. My current use
of packets/buffers does seem to abuse their intended meaning a bit.

> - iiuc, the idea is to allow bpf prog to optionally handle the 'struct
> file_operations' without going back to the user daemon? Have you looked at
> struct_ops which seems to be a better fit here?  If the bpf prog does not know
> how to handle an operation (or file?), it can call fuse_file_llseek (for
> example) as a kfunc to handle the request.
>

I wasn't aware of struct_ops. It looks like that may work for us
instead of making a new prog type. I'll definitely look into that.
I'll likely sign up for the bpf office hours next week.

> - The test SEC("test_trace") seems mostly a synthetic test for checking
> correctness.  Does it have a test that shows a more real life use case? or I
> have missed things in patch 26?
>

Patch 26 is pretty much all synthetic tests. A lot of them are just
ensuring that we even call in to the bpf program, and some limited
testing that changing the filters has the expected results. We
mentioned a few more concrete usecases in the LPC talk. One of those
is folder hiding. In Android we've had an issue with leaking the
existence of some apps to other apps. We needed to hide certain
directories from apps where they do have permissions to traverse the
directory. Attempting to access a folder without permissions would
result in EPERM, revealing the existence of that folder. Since the
application doesn't have permission to create arbitrary folders at
that level, we can hide it by using fuse-bpf to change the EPERM into
an ENOENT, and then filter readdir to remove disallowed entries. You
can see something like that in bpf_test_redact_readdir. We also have
some file level redaction. If an app doesn't have location
permissions, but does have file permissions, they could just read
picture metadata to get location information. We could have bpf
redirect reads that might contain location data to the daemon, while
passing through other parts.

> - Please use the skel to load the program.  It is pretty hard to read the loader
> in patch 26.

Yeah, patch 26 is not in great shape currently. I included it mostly
as something that exercises the code, and contains some example bpf
programs. Any suggestions on setting up the tests better are
appreciated.

>
> - I assume the main objective is for performance by not going back to the user
> daemon?  Do you have performance number?
>

I don't have any on hand from the current version. It's a little
tricky to know what numbers are relevant here since the numbers will
change greatly depending on what you do with it. In pure passthrough
without a bpf program, we were seeing performance pretty comparable to
the lower filesystem. Depending on how large of a bpf program we use
we were seeing pretty different slowdowns from that, though at least
some of that was from having a large switch statement.

Do you have any suggestions on what to test here? My thoughts would be
comparing lower fs performance to pure passthrough, to maybe the
example ll_passthrough in libfuse, but that doesn't really show any
bpf impact.

-Daniel
