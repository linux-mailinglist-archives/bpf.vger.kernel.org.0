Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F967223B
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 16:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjARP6H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 10:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjARP5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 10:57:43 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDE4B481
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 07:53:32 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id v127so31791326vsb.12
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 07:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7tPb4ad+X3ievXywvEgDeaf+z45DaAQO/GxClEDPqg=;
        b=XvtDDRMkWJje8OF6YaT/x0MtxPEyGfNM6tiQyELIn1EwAECeSNHxyOGyySU7a9raFL
         y4MgFwyOJbHsZwGDPEqd0yEJwC+4GgQbIdhTHmildOk53LGNysaRRmt/yIHb8KuEqyUT
         DD8VKEDVzHXsHArqnu/OZvEeGlSvMbsItwrAUjNJ+Wvza2lWdbX9CGxPqHbabEOMm6k9
         /0rKuwc4vFt3X9oc+ihUPoD3GMVc0JmANLENZ+a2b4YlJjT+pZ8Hw6Z4jNlGrGW4+U71
         8dRa2d9rWi5JLeYjs4A+JDUZWlUBg7HfiifYR7n/kj17bwSUvyZK/Mzq8FrwZBaFgAD2
         UBMA==
X-Gm-Message-State: AFqh2kq545a2STTmlBfLtHwq4VLKHeGeHKFqhFauEIqy35TAEMDy6+KB
        1woABEX6QjIeCCr6nAZ33vU=
X-Google-Smtp-Source: AMrXdXuCb4yS0LuarsN4xWvr51C2tzuMocb4W30N3YsqRvOFzf9aGTTij4ERsqmis7tsExoG65/bew==
X-Received: by 2002:a05:6102:3109:b0:3cd:95ce:3703 with SMTP id e9-20020a056102310900b003cd95ce3703mr3393255vsh.25.1674057211069;
        Wed, 18 Jan 2023 07:53:31 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006fa43e139b5sm22465100qkl.59.2023.01.18.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:53:30 -0800 (PST)
Date:   Wed, 18 Jan 2023 09:53:33 -0600
From:   David Vernet <void@manifault.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable
 kfuncs"
Message-ID: <Y8gV/XveyPmf8alQ@maniforge.lan>
References: <20230117212731.442859-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117212731.442859-1-toke@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 10:27:31PM +0100, Toke Høiland-Jørgensen wrote:
> Following up on the discussion at the BPF office hours, this patch adds a
> description of the (new) concept of "stable kfuncs", which are kfuncs that
> offer a "more stable" interface than what we have now, but is still not
> part of UAPI.
> 
> This is mostly meant as a straw man proposal to focus discussions around
> stability guarantees. From the discussion, it seemed clear that there were
> at least some people (myself included) who felt that there needs to be some
> way to export functionality that we consider "stable" (in the sense of
> "applications can rely on its continuing existence").
> 
> One option is to keep BPF helpers as the stable interface and implement
> some technical solution for moving functionality from kfuncs to helpers
> once it has stood the test of time and we're comfortable committing to it
> as a stable API. Another is to freeze the helper definitions, and instead
> use kfuncs for this purpose as well, by marking a subset of them as
> "stable" in some way. Or we can do both and have multiple levels of
> "stable", I suppose.
> 
> This patch is an attempt to describe what the "stable kfuncs" idea might
> look like, as well as to formulate some criteria for what we mean by
> "stable", and describe an explicit deprecation procedure. Feel free to
> critique any part of this (including rejecting the notion entirely).
> 
> Some people mentioned (in the office hours) that should we decide to go in
> this direction, there's some work that needs to be done in libbpf (and
> probably the kernel too?) to bring the kfunc developer experience up to par
> with helpers. Things like exporting kfunc definitions to vmlinux.h (to make
> them discoverable), and having CO-RE support for using them, etc. I kinda
> consider that orthogonal to what's described here, but I do think we should
> fix those issues before implementing the procedures described here.
> 
> v2:
> - Incorporate Daniel's changes
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Hi Toke,

Thanks a lot for writing this up. Left some thoughts and comments below.

> ---
>  Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 9fd7fb539f85..dd40a4ee35f2 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
>  
>  BPF Kernel Functions or more commonly known as kfuncs are functions in the Linux
>  kernel which are exposed for use by BPF programs. Unlike normal BPF helpers,
> -kfuncs do not have a stable interface and can change from one kernel release to
> -another. Hence, BPF programs need to be updated in response to changes in the
> -kernel.
> +kfuncs by default do not have a stable interface and can change from one kernel
> +release to another. Hence, BPF programs may need to be updated in response to
> +changes in the kernel. See :ref:`BPF_kfunc_stability`.
>  
>  2. Defining a kfunc
>  ===================
> @@ -223,14 +223,89 @@ type. An example is shown below::
>          }
>          late_initcall(init_subsystem);
>  
> -3. Core kfuncs
> +
> +.. _BPF_kfunc_stability:
> +
> +3. API (in)stability of kfuncs
> +==============================
> +
> +By default, kfuncs exported to BPF programs are considered a kernel-internal
> +interface that can change between kernel versions. This means that BPF programs
> +using kfuncs may need to adapt to changes between kernel versions. In the
> +extreme case that could also include removal of a kfunc. In other words, kfuncs
> +are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought of as
> +being similar to internal kernel API functions exported using the
> +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionality must
> +initially start out as kfuncs.
> +
> +3.1 Promotion to "stable" kfuncs
> +--------------------------------
> +
> +While kfuncs are by default considered unstable as described above, some kfuncs
> +may warrant a stronger stability guarantee and can be marked as *stable*. The
> +decision to move a kfunc to *stable* is taken on a case-by-case basis and must
> +clear a high bar, taking into account the functions' usefulness under

s/functions'/function's

> +longer-term production deployment without any unforeseen API issues or
> +limitations. In general, it is not expected that every kfunc will turn into a
> +stable one - think of it as an exception rather than the norm.
> +
> +Those kfuncs which have been promoted to stable are then marked using the
> +``KF_STABLE`` tag. The process for requesting a kfunc be marked as stable

I'm not 100% convinced that KF_STABLE and KF_DEPRECATED flags are the
correct API to go with here for signaling stability and deprecation, for
a couple of reasons:

1. We're already requiring that we document in the kernel docs when a
   stable, deprecated kfunc is slated to be removed, so I think an
   argument could be made to make this a documentation convention rather
   than a programmatic + documentation convention. A user that sees that
   a kfunc is deprecated will end up having to go to the documentation
   anyways to see when it will be removed.
2. Long term, I don't think KF_STABLE or KF_DEPRECATED will be
   expressive enough for us. For example, we could do something similar
   to what Maxim suggested in [0] wherein we have API version numbers
   for kfuncs which are interpreted by libbpf, allowing us to warn for
   deprecated kfuncs, enble symbol versioning by linking against
   different versions of the kfunc in the kernel, etc.

[0]: https://lore.kernel.org/all/Y78+iIqqpyufjWOv@mail.gmail.com/

So my take would be, let's just stick with a documentation convention
for now. Maybe we could also add a "deprecated" BTF tag that would at
least allow the verifier to warn the user on clang builds (until gcc
supports it) when they link against a deprecated kfunc. What do you
think?

> +consists of submitting a patch to the bpf@vger.kernel.org mailing list adding
> +the ``KF_STABLE`` tag to that kfunc's definition. The patch description must
> +include the rationale for why the kfunc should be promoted to stable, including
> +references to existing production uses, etc. The patch will be considered the
> +same was as any other patch, and ultimately the decision on whether a kfunc
> +should be promoted to stable is taken by the BPF maintainers.
> +
> +Stable kfuncs provide the following stability guarantees:
> +
> +1. Stable kfuncs will not change their function signature or functionality in a
> +   way that may cause incompatibilities for BPF programs calling the function.
> +
> +2. The BPF community will make every reasonable effort to keep stable kfuncs
> +   around as long as they continue to be useful to real-world BPF applications.

I think we should try to avoid setting subjective expectations such as
"every reasonable effort". I think it's useful to paint a picture of the
typical workflow / culture for stability, but in terms of _guarantees_,
I think we should only be speaking in terms of deprecation timelines.
For example, points (2) and (3) could possibly be rephrased as:

2. The BPF community generally makes an effort to keep stable kfuncs
around as long as they continue to be useful to real-world applications.
Stable kfuncs will maintain their signature and behavior for as long as
they're defined, and up through and possibly exceeding a deprecation
window that is outlined in more detail below.

> +
> +3. Should a stable kfunc turn out to be no longer useful, the BPF community may
> +   decide to eventually remove it. In this case, before being removed that kfunc
> +   will go through a deprecation procedure as outlined below.

Echoing the point above, I also think we should be a bit cautious in
providing specific reasons as to why a stable kfunc would be removed.
There may be cases where something is useful, but it turns out that the
complexity is causing bugs, etc, and the value just isn't worth the
cost. Hopefully the kfunc wouldn't get to the stable point by the time
we realized there's a better alternative, but it's possible (perhaps
bpf_loop() is a good example?)

Also, "useful" is subjective, so it may surprise / confuse users if they
we deprecate something that's still useful to them, such as
bpf_get_current_task(). Note that we may choose to keep a kfunc around
if a user tells us they need it, but the point is that I don't think we
want to give readers the idea that a kfunc being useful automatically
means it won't be removed.

> +
> +3.2 Deprecation of kfuncs
> +-------------------------
> +
> +As described above, the community will make every reasonable effort to keep
> +kfuncs available through future kernel versions once they are marked as stable.
> +However, it may happen case that BPF development moves in an unforeseen

'it may happen in some cases'?

> +direction so that even a stable kfunc ceases to be useful for program
> +development.
> +
> +In this case, stable kfuncs can be marked as *deprecated* using the
> +``KF_DEPRECATED`` tag. Such a deprecation request cannot be arbitrary and must
> +explain why a given stable kfunc should be deprecated. Once a kfunc is marked as
> +deprecated, the following procedure will be followed for removal:

See above -- not sure I'm convinced yet that KF_STABLE | KF_DEPRECATED
are the right APIs for the job. As another observation to that point, I
don't think it ever make sense to specify a kfunc as KF_DEPRECATED
without also KF_STABLE, which IMO is a sign that we need something
different than KF flags to express what we're going for here.

> +
> +1. A kfunc marked as deprecated will be kept in the kernel for a conservatively
> +   chosen period of time after it was first marked as deprecated (usually
> +   corresponding to a span of multiple years).

I have two suggestions for this paragraph:

1. I think we should consider specifying a concrete minimum time period
   here. Unfortunately it's difficult to choose one given that we
   haven't yet gone through a deprecation story and so we have little
   experience to draw from in choosing it. On the other hand, I think it
   would be good for us to have a more fully-defined policy to point to
   as that seems to have been a big point of confusion in prior
   discussions, and we can always update the time period later.

2. We should probably specify that the clock for a kfunc being
   considered deprecated starts at the release date of the first kernel
   version in which it was marked as deprecated. 'First marked as
   deprecated' is a bit too open for interpretation IMO, as it could
   correspond to when the commit was first merged to Linus' tree, etc.

Assuming others agree that we're ready to specify a minimum deprecation
time, I think 1 year makes sense as a starting point, though I expect it
will increase as we stabilize and finish some remaining kfunc items like
symbol versioning. 1 year isn't super aggressive in that it gives us the
flexibility to change things if we decide that we want a different
deprecation story (e.g. if and when we support symboled versions for
kfuncs), but it's still a reasonably long period of time in that we're
agreeing to a cost for the sake of stability. Wdyt?

> +
> +2. Deprecated functions will be documented in the kernel docs along with their
> +   remaining lifespan and including a recommendation for new functionality that
> +   can replace the usage of the deprecated function (or an explanation for why
> +   no such replacement exists).
> +
> +3. After the deprecation period, the kfunc will be removed and the function name
> +   will be marked as invalid inside the kernel (to ensure that no new kfunc is
> +   accidentally introduced with the same name in the future). After this
> +   happens, BPF programs calling the kfunc will be rejected by the verifier.

Do we need to mark the function name as invalid? Wouldn't removing it be
sufficient for the verifier to reject the program? If we wanted to have
some better UX for this case, ideally we could rely on libbpf to help
us.

In general, I think what you have in this paragraph is good and makes
sense given the current state of kfuncs not having symbol versioning.
That being said, once we do have something like symbol versioning
support, etc, I don't think we'd need to ban the name from ever being
used again. My thinking here is that there may be times where we need to
e.g. add a or remove a field to or from a kfunc, change some semantics,
etc, and adding an entirely new name like kfunc_name_v2() would be kind
of unfortunate. It's certainly warranted in the current state of things,
but if and when we have symbol version support I think it would be nice
to relax this restriction.

> +
> +4. Core kfuncs
>  ==============
>  
>  The BPF subsystem provides a number of "core" kfuncs that are potentially
>  applicable to a wide variety of different possible use cases and programs.
>  Those kfuncs are documented here.
>  
> -3.1 struct task_struct * kfuncs
> +4.1 struct task_struct * kfuncs
>  -------------------------------
>  
>  There are a number of kfuncs that allow ``struct task_struct *`` objects to be
> @@ -306,7 +381,7 @@ Here is an example of it being used:
>  		return 0;
>  	}
>  
> -3.2 struct cgroup * kfuncs
> +4.2 struct cgroup * kfuncs
>  --------------------------
>  
>  ``struct cgroup *`` objects also have acquire and release functions:
> -- 
> 2.39.0
> 
