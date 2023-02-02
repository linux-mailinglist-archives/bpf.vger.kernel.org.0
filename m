Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F2687514
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 06:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBBF0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 00:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBBF0B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 00:26:01 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B777961E;
        Wed,  1 Feb 2023 21:25:59 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id g8so794111qtq.13;
        Wed, 01 Feb 2023 21:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ4h0C6g0Eelx+o9uu62oVUvHyz/SbkATACI18oIn04=;
        b=VAi/JD5fKCU6lYNNXKhokUMCrf4HmLyciX0abJ/+qoTKV//kICymZDILk9WFITigjn
         FrzkpNXlnMGR+8aw6+FXilThulIchWKmvDLwLT3I/L1sxekchS2tARJ9NlByXhvham8R
         1sr5VJguN8RUemq3XpG2tX7/nhD9zmag4R0M4NWHFdJyp0Wn85aV7pv502pDrxYFWXit
         OZhBAVBmAU6jI62KVDqQ1h0cnr3Ny6D9AiNOFrzGMHqF6fBZUjJftJKY6hKfwfAkSsoX
         a1cJ3VcLv2mgp78Nk9WAMHDyi6OnIO94Oi+Jz335wqCApvnG3GXZzau7qAJriNm3mDFH
         hoOg==
X-Gm-Message-State: AO0yUKUpt8gFPH610noZ2OEAOZmbZ9Iw2gELfYBM0IVjqZBGUL1f7AQV
        6SIr32id5wAcDl+9GHvVK6M=
X-Google-Smtp-Source: AK7set8fleMRpN4tk680n/R9IKKhcgBRVPuk1ISuE231ARCy1r0lpyhL7ajKGLey1Zd3dCRCxDMwZw==
X-Received: by 2002:a05:622a:1045:b0:3b9:bc8c:c211 with SMTP id f5-20020a05622a104500b003b9bc8cc211mr1893806qte.28.1675315558491;
        Wed, 01 Feb 2023 21:25:58 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:1971])
        by smtp.gmail.com with ESMTPSA id y77-20020a376450000000b0071c535f3ff3sm9401123qkb.6.2023.02.01.21.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 21:25:57 -0800 (PST)
Date:   Wed, 1 Feb 2023 23:25:55 -0600
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
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v3] Documentation/bpf: Document API stability
 expectations for kfuncs
Message-ID: <Y9tJY3ayftdowRVS@maniforge>
References: <20230201174449.94650-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201174449.94650-1-toke@redhat.com>
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

On Wed, Feb 01, 2023 at 06:44:48PM +0100, Toke Høiland-Jørgensen wrote:
> Following up on the discussion at the BPF office hours (and subsequent
> discussion), this patch adds a description of API stability expectations
> for kfuncs. The goal here is to manage user expectations about what kind of
> stability can be expected for kfuncs exposed by the kernel.
> 
> Since the traditional BPF helpers are basically considered frozen at this
> point, kfuncs will be the way all new functionality will be exposed to BPF
> going forward. This makes it important to document their stability
> guarantees, especially since the perception up until now has been that
> kfuncs should always be considered "unstable" in the sense of "may go away
> or change at any time". Which in turn makes some users reluctant to use
> them because they don't want to rely on functionality that may be removed
> in future kernel versions.
> 
> This patch adds a section to the kfuncs documentation outlining how we as a
> community think about kfunc stability. The description is a bit vague and
> wishy-washy at times, but since there does not seem to be consensus to
> commit to any kind of hard stability guarantees at this point, I feat this
> is the best we can do.
> 
> I put this topic on the agenda again for tomorrow's office hours, but
> wanted to send this out ahead of time, to give people a chance to read it
> and think about whether it makes sense or if there's a better approach.
> 
> Previous discussion:
> https://lore.kernel.org/r/20230117212731.442859-1-toke@redhat.com

Again, thanks a lot for writing this down and getting a real / tangible
conversation started.

> 
> v3:
> - Drop the KF_STABLE tag and instead try to describe kfunc stability
>   expectations in general terms. Keep the notion of deprecated kfuncs.
> v2:
> - Incorporate Daniel's changes
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  Documentation/bpf/kfuncs.rst | 88 +++++++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 9fd7fb539f85..6885a64ce0ff 100644
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
> @@ -223,14 +223,90 @@ type. An example is shown below::
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
> +``EXPORT_SYMBOL_GPL`` macro.
> +
> +While kfuncs are similar to internal kernel API functions, they differ in that
> +most consumers of kfuncs (i.e., BPF programs) are not part of the kernel source
> +tree. This means that callers of a kfunc cannot generally be changed at the same
> +time as the kfunc itself, which is otherwise standard practice in the kernel
> +tree. For this reason, the BPF community has to strike a balance between being
> +able to move the kernel forward without being locked into a rigid exported API,
> +and avoiding breaking BPF consumers of the functions. This is a technical

While I certainly understand the sentiment, I personally don't think I'd
describe this as the BPF community striking a balance in a way that
differs from EXPORT_SYMBOL_GPL. At the end of the day, as Alexei said in
[0], BPF APIs must never be a reason to block a change elsewhere in the
kernel.

[0]: https://lore.kernel.org/bpf/20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local/

Because of that, I think the document would provide more value to users
if it described how decisions are made regarding kfunc stability,
changes, etc, rather than describing what the BPF community will attempt
to do to avoid kfunc churn, given that in reality we can't really
_guarantee_ anyone stability.

To that point, I would argue that a kfunc's stability guarantees are
truly exactly the same as for any EXPORT_SYMBOL_GPL symbol. The only
differences between the two are that:

a) In some ways it's quite a bit easier to support kfunc stability
   thanks to CO-RE.

b) It's more difficult to gauge how widely used a kfunc is in comparison
   to an EXPORT_SYMBOL_GPL consumer due to the fact that (at this point,
   far) fewer BPF programs are upstreamed in comparison to modules.

Unfortunately, the fact that most BPF programs live outside the tree is
irrelevant to any obligation the kernel might have to accommodate them.
Maintainers need the flexibility to change things around, and it's not
their problem that users haven't upstreamed their BPF programs. Because
of that, IMO the obligation is rather more on the consumers of the
kfuncs to be outspoken and describe why it's useful or necessary to keep
them around, so that if and when any proposal is made to change or
remove them upstream, there's sufficient data to accurately drive the
discussion and decision. It would be great if we upstreamed more BPF
programs, in which case it would be easier to change them when kfuncs
change, and the signal of how widely used a kfunc is would be stronger
and more self-evident. Perhaps it's worth calling that out as part of
this doc as well well?

With all that in mind, what do you think about rephrasing this paragraph
and the subsequent points below as follows:

Just as with kernel symbols exported with EXPORT_SYMBOL_GPL, kfuncs
could be changed at any time by a maintainer of the subsystem when
necessary. Like any other change to the kernel, maintainers will not
change or remove a kfunc without having some justification. Whether or
not they'll choose to change a kfunc will ultimately depend on a variety
of factors, such as how widely used the kfunc is, how long the kfunc has
been in the kernel, whether an alternative kfunc exists, what the norm
is in terms of stability for the subsystem in question, and of course
what the technical cost is of continuing to support the kfunc.

There are several important implications of this:

a) A kfunc will never have any hard stability guarantees. BPF APIs
   cannnot and will not ever hard-block a change in the kernel purely
   for stability reasons. In other words, kfuncs have the exact same
   stability guarantees as any other kernel API, such as those provided
   by EXPORT_SYMBOL_GPL.

   That being said, kfuncs are features that are meant to solve problems
   and provide value to users. The decision of whether to change or
   remove a kfunc is a multivariate technical decision that is made on a
   case-by-case basis, and which is informed by data points such as
   those mentioned above. It is expected that a kfunc being removed or
   changed with no warning will not be a common occurrence, but it is a
   possibility that must be accepted if one is to use kfuncs. 

b) kfuncs that are widely used or have been in the kernel for a long
   time will be more difficult to justify being changed or removed by a
   maintainer. Said in a different way, kfuncs that are known to have a
   lot of users and provide significant value provide stronger
   incentives for maintainers to invest the time and complexity in
   supporting them. It is therefore important for developers using
   kfuncs in their BPF programs to demonstrate how and why those kfuncs
   are being used, and to participate in discussions regarding those
   kfuncs when they occur upstream.

c) Because many BPF programs are not upstreamed as part of the kernel
   tree, it is often not possible to change them in-place when a kfunc
   changes, as it is for e.g. an upstreamed module being updated in
   place when an EXPORT_SYMBOL_GPL symbol is changed. The kfunc
   framework therefore provides a mechanism to developers to, when
   possible, provide a signal to users that a kfunc is expected to be
   changed or removed at some point in the future (see below for more
   details). Just as with modules, developers are also encouraged to
   upstream their BPF programs so they can enjoy the same benefits as
   upstreamed modules, and avoid code churn.

> +trade-off that will be judged on a case-by-case basis. The following points are
> +an attempt to capture the things that will be taken into account when making a
> +decision on whether to change or remove a kfunc:
> +
> +1. When a patch adding a new kfunc is merged into the kernel tree, that will
> +   make the kfunc available to a wider audience than during its development,
> +   subjecting it to additional scrutiny. This may reveal limitations in the API
> +   that was not apparent during development. As such, a newly added kfunc may
> +   change in the period immediately after it was first merged into the kernel.

If we keep this paragraph, I think we should consider removing the word
"immediately" here.  The reality is that a kfunc could be removed
whenever a maintainer decides it's necessary. It will probably be much
easier to justify soon after the kfunc is merged and before it's heavily
used (see my suggestion above), but I worry that specifying
"immediately" here might confuse some readers who interpret it to mean
that after a certain amount of time, it _won't_ be removed or changed. I
realize this is clarified below, so this suggestion is just me trying to
make the messaging consistent.

> +
> +2. The BPF community will make every reasonable effort to keep kfuncs around as
> +   long as they continue to be useful to real-world BPF applications, and don't
> +   have any unforeseen API issues or limitations.

As suggested above, I think we should frame this more generally. IMO
this doc will be the most useful to users if we educate them about the
decision making processes that go into decisions around kfunc stability,
rather than giving them an opaque promise of what the BPF community will
try to do. That way they have the information they need to decide for
themselves if they want to use a kfunc, and also to make them aware that
that they can actually influence decisions surrounding kfuncs by being
involved in discussions and making their use cases known.

> +
> +3. Should the need arise to change a kfunc that is still in active use by BPF
> +   applications, that kfunc will go through a deprecation procedure as outlined
> +   below.

I think we have to remove this paragraph. It may happen that a kfunc is
in active use by BPF applications, but still has to be changed or
removed immediately. We can't make any general guarantees about
deprecation procedures.

> +
> +The procedural description above is deliberately vague, as the decision on
> +whether to change it will ultimately be a judgement call made by the BPF
> +maintainers. However, feedback from users of a kfunc is an important input to
> +this decision, as it helps maintainers determine to what extent a given kfunc is
> +in use. For this reason, the BPF community encourages users to provide such
> +feedback (including pointing out problems with a given kfunc).
> +
> +In addition to the guidelines outlined above, the kernel subsystems exposing
> +functionality via kfuncs may have their own guidelines. These will be documented
> +by that subsystem as part of the documentation of the functionality exposed to
> +BPF.

If we go with my suggestion above to frame all of this more as an
explanation of how all of the various factors around stability,
technical cost, etc are taken into account when deciding whether to
change or remove kfuncs, I'm not sure these two paragraphs are
necessary. The weight of all of these variables may differ from
subsystem to subsystem, but the mental model for developers should be
the same regardless of where you are in the kernel.

That mental model is:

The maintainer(s) of the subsystem that contains the kfunc you're using
will treat it like any other symbol exported by the kernel, and the cost
calculus that they and the rest of the upstream community apply when
deciding whether to support those callers will apply to kfuncs as well.

> +
> +3.1 Deprecation of kfuncs
> +-------------------------
> +
> +As described above, the community will make every reasonable effort to keep
> +useful kfuncs available through future kernel versions. However, it may happen
> +that the kernel development moves in a direction so that the API exposed by a
> +given kfunc becomes a barrier to further development.

I think we should add a clear caveat here that sometimes kfuncs must be
changed or removed immediately, with no deprecation / cool-off period.
I would expect this to be pretty rare, but it could happen. Also,
perhaps it's worth specifying that kfuncs can be deprecated for reasons
beyond being a barrier to further development as well?

Wdyt about phrasing the paragraph like this?

As described above, while sometimes a maintainer may find that a kfunc
must be changed or removed immediately to accommodate some changes in
their subsystem, other kfuncs may be able to accommodate a longer and
more measured deprecation process. For example, if a new kfunc comes
along which provides superior functionality to an existing kfunc, the
existing kfunc may be deprecated in favor of BPF programs using the new
one. Or, if a kfunc has no known users, a decision may be made to
deprecate the kfunc for some period of time before eventually removing
it, so as to minimize unnecessary complexity.

> +
> +A kfunc that is slated for removal can be marked as *deprecated* using the
> +``KF_DEPRECATED`` tag. Once a kfunc is marked as deprecated, the following
> +procedure will be followed for removal:

I'm OK with KF_DEPRECATED in the short term so that we can at least spit
out a warning to dmesg or something, but I hope we can replace it with
something fancier like symbol versioning in the longer term.

If we're going to go with using KF_DEPRECATED, should we maybe specify
what signal the developer can expect if the kfunc is deprecated? Perhaps
a dmesg or verifier warning or something?

> +
> +1. A deprecated kfunc will be kept in the kernel for a period of time after it
> +   was first marked as deprecated. This time period will be chosen on a
> +   case-by-case basis, based on how widespread the use of the kfunc is, how long
> +   it has been in the kernel, and how hard it is to move to alternatives.
> +
> +2. Deprecated functions will be documented in the kernel docs along with their
> +   remaining lifespan and including a recommendation for new functionality that
> +   can replace the usage of the deprecated function (or an explanation for why
> +   no such replacement exists).
> +
> +3. After the deprecation period, the kfunc will be removed. After this happens,
> +   BPF programs calling the kfunc will be rejected by the verifier.
> +
> +4. Core kfuncs
>  ==============

Thanks,
David
