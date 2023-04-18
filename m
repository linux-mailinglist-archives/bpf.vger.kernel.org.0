Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958D86E55D6
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDRA2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 20:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDRA2c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:28:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2F1733;
        Mon, 17 Apr 2023 17:28:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f3df30043so123476266b.2;
        Mon, 17 Apr 2023 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681777709; x=1684369709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X4977ZepHMAQkR6aOIf2zysEaoAj+tLSunkvG2j6L8=;
        b=OmFkJXb16Ac/TveUfsdXmJZquSPI5aIJWhC35Yu7dq4ZCxQ9QaBmCCI6BF4Ge6hpjM
         ACq8sPG20EkTbSueliO4HW4U+5ltdIVRHRLTNXRQ3xfmu7AmXt+fluD8j+yVuCokPC1M
         cObD6DctUXARz4mT/B6fK4+e49psNRepFPquyLxY0VQ0ItQLhYZXezqsG1yjoHEhVuTj
         MmfxzAmnG/XJLiRZLjW7LXYbBaooIDTI2c73qonwr1GVLYnwIsm5NYpmTSJvsFYA8jMr
         +isAt1M2HdzwEGWMOXchR02zyAQVuv883p6VC2uKm65u5FBCa8q3i0gIOXMeN7xayIS2
         ez6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681777709; x=1684369709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X4977ZepHMAQkR6aOIf2zysEaoAj+tLSunkvG2j6L8=;
        b=HGy7jKQa/zCEW1yfdjYk5wa5cEHMqcbULYodl7gUlQzMfC4wnyAcaJ9V853v13700L
         Me6GWXb3RaGV4oy7NrdkoPsSGuT/hYM07dFCD1EoSC1VLhHhzkbLotHYwR1/uUlWbO2c
         JV78q9E8/dv7DZ3Q+3W/jfBep4hNa1k9SIqMmhVnPrssoSmlvisXLFjtjhdUZ6HtAhvL
         VLbHL5ZGQ4l+0zYKlH3oJzrSFurwqMYBnWIAFad/BYkT+qt+1VL+euKd3NGoOvc+d+Il
         ietsxdZB2RXDukW8vpjhhTLFDV2oaLbbGqpCKbCegMiq6w5sZ6NDgT4KBXO/pITMk+z+
         Jimw==
X-Gm-Message-State: AAQBX9d8BSlLJqCm3Jml2tERnURSQKhiB4yLiL0se3SZTh644Rc+wvwK
        ARlOS2EdN7B/7hjXWZxRNF9mfj0iitYBYkyV4Wc=
X-Google-Smtp-Source: AKy350anpKaBfKqo43FUS788/EDu54JxU+L4PAso0QwcL/9sojIsvxrjuUgzqgzPzyKGJ/gRHFYbEJRLFe5eQvbvjN8=
X-Received: by 2002:a50:d618:0:b0:4fc:1608:68c8 with SMTP id
 x24-20020a50d618000000b004fc160868c8mr89712edi.1.1681777708787; Mon, 17 Apr
 2023 17:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com> <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com> <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
 <afd17142-9243-8b72-d16a-41165e8deda1@schaufler-ca.com> <CAEf4BzaaFruReHByj_ngz+BiQmKQGeK+1DsAzg1YmVnZxfADug@mail.gmail.com>
 <eb0a2955-0ca0-8b95-526f-3eb3dc720c26@schaufler-ca.com>
In-Reply-To: <eb0a2955-0ca0-8b95-526f-3eb3dc720c26@schaufler-ca.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 17:28:17 -0700
Message-ID: <CAEf4BzYaiqe13fjYVQ0gbv=OXm+RC-VubGJhD69V11eiiELPDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 4:53=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/17/2023 4:31 PM, Andrii Nakryiko wrote:
> > On Thu, Apr 13, 2023 at 9:27=E2=80=AFAM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 4/12/2023 6:43 PM, Andrii Nakryiko wrote:
> >>> On Wed, Apr 12, 2023 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> >>>> On Wed, Apr 12, 2023 at 2:28=E2=80=AFPM Kees Cook <keescook@chromium=
.org> wrote:
> >>>>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
> >>>>>> On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromi=
um.org> wrote:
> >>>>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> >>>>>>>> On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii=
@kernel.org> wrote:
> >>>>>>>>> Add new LSM hooks, bpf_map_create_security and bpf_btf_load_sec=
urity, which
> >>>>>>>>> are meant to allow highly-granular LSM-based control over the u=
sage of BPF
> >>>>>>>>> subsytem. Specifically, to control the creation of BPF maps and=
 BTF data
> >>>>>>>>> objects, which are fundamental building blocks of any modern BP=
F application.
> >>>>>>>>>
> >>>>>>>>> These new hooks are able to override default kernel-side CAP_BP=
F-based (and
> >>>>>>>>> sometimes CAP_NET_ADMIN-based) permission checks. It is now pos=
sible to
> >>>>>>>>> implement LSM policies that could granularly enforce more restr=
ictions on
> >>>>>>>>> a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADM=
IN
> >>>>>>>>> capabilities), but also, importantly, allow to *bypass kernel-s=
ide
> >>>>>>>>> enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applic=
ations and use
> >>>>>>>>> cases.
> >>>>>>>> One of the hallmarks of the LSM has always been that it is
> >>>>>>>> non-authoritative: it cannot unilaterally grant access, it can o=
nly
> >>>>>>>> restrict what would have been otherwise permitted on a tradition=
al
> >>>>>>>> Linux system.  Put another way, a LSM should not undermine the L=
inux
> >>>>>>>> discretionary access controls, e.g. capabilities.
> >>>>>>>>
> >>>>>>>> If there is a problem with the eBPF capability-based access cont=
rols,
> >>>>>>>> that problem needs to be addressed in how the core eBPF code
> >>>>>>>> implements its capability checks, not by modifying the LSM mecha=
nism
> >>>>>>>> to bypass these checks.
> >>>>>>> I think semantics matter here. I wouldn't view this as _bypassing=
_
> >>>>>>> capability enforcement: it's just more fine-grained access contro=
l.
> >>> Exactly. One of the motivations for this work was the need to move
> >>> some production use cases that are only needing extra privileges so
> >>> that they can use BPF into a more restrictive environment. Granting
> >>> CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN to all such use cases that need the=
m
> >>> for BPF usage is too coarse grained. These caps would allow those
> >>> applications way more than just BPF usage. So the idea here is more
> >>> finer-grained control of BPF-specific operations, granting *effective=
*
> >>> CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN caps dynamically based on custom
> >>> production logic that would validate the use case.
> >> That's an authoritative model which is in direct conflict with the
> >> design and implementation of both capabilities and LSM.
> >>
> >>> This *is* an attempt to achieve a more secure production approach.
> >>>
> >>>>>>> For example, in many places we have things like:
> >>>>>>>
> >>>>>>>         if (!some_check(...) && !capable(...))
> >>>>>>>                 return -EPERM;
> >>>>>>>
> >>>>>>> I would expect this is a similar logic. An operation can succeed =
if the
> >>>>>>> access control requirement is met. The mismatch we have through-o=
ut the
> >>>>>>> kernel is that capability checks aren't strictly done by LSM hook=
s. And
> >>>>>>> this series conceptually, I think, doesn't violate that -- it's c=
hanging
> >>>>>>> the logic of the capability checks, not the LSM (i.e. there no LS=
M hooks
> >>>>>>> yet here).
> >>>>>> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), whi=
ch
> >>>>>> when it returns a positive value "bypasses kernel checks".  The pa=
tch
> >>>>>> isn't based on either Linus' tree or the LSM tree, I'm guessing it=
 is
> >>>>>> based on a eBPF tree, so I can't say with 100% certainty that it i=
s
> >>>>>> bypassing a capability check, but the description claims that to b=
e
> >>>>>> the case.
> >>>>>>
> >>>>>> Regardless of how you want to spin this, I'm not supportive of a L=
SM
> >>>>>> hook which allows a LSM to bypass a capability check.  A LSM hook =
can
> >>>>>> be used to provide additional access control restrictions beyond a
> >>>>>> capability check, but a LSM hook should never be allowed to overru=
le
> >>>>>> an access denial due to a capability check.
> >>>>>>
> >>>>>>> The reason CAP_BPF was created was because there was nothing else=
 that
> >>>>>>> would be fine-grained enough at the time.
> >>>>>> The LSM layer predates CAP_BPF, and one could make a very solid
> >>>>>> argument that one of the reasons LSMs exist is to provide
> >>>>>> supplementary controls due to capability-based access controls bei=
ng a
> >>>>>> poor fit for many modern use cases.
> >>>>> I generally agree with what you say, but we DO have this code patte=
rn:
> >>>>>
> >>>>>          if (!some_check(...) && !capable(...))
> >>>>>                  return -EPERM;
> >>>> I think we need to make this more concrete; we don't have a pattern =
in
> >>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> >>>> Simply because there is another kernel access control mechanism whic=
h
> >>>> allows a capability check to be skipped doesn't mean I want to allow=
 a
> >>>> LSM hook to be used to skip a capability check.
> >>> This work is an attempt to tighten the security of production systems
> >>> by allowing to drop too coarse-grained and permissive capabilities
> >>> (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow mor=
e
> >>> than production use cases are meant to be able to do)
> >> The BPF developers are in complete control of what CAP_BPF controls.
> >> You can easily address the granularity issue by adding addition restri=
ctions
> >> on processes that have CAP_BPF. That is the intended use of LSM.
> >> The whole point of having multiple capabilities is so that you can
> >> grant just those that are required by the system security policy, and
> >> do so safely. That leads to differences of opinion regarding the defin=
ition
> >> of the system security policy. BPF chose to set itself up as an elemen=
t
> >> of security policy (you need CAP_BPF) rather than define elements such=
 that
> >> existing capabilities (CAP_FOWNER, CAP_KILL, CAP_MAC_OVERRIDE, ...) wo=
uld
> >> control.
> > Please see my reply to Paul, where I explain CAP_BPF's system-wide
> > nature and problem with user namespaces. I don't think the problem is
> > in the granularity of CAP_BPF, it's more of a "non-namespaceable"
> > nature of the BPF subsystem in general.
>
> Paul is approaching this from a different angle. Your response to Paul
> does not address the issue I have raised.

I see, I definitely missed this. Re-reading your reply, I still am not
clear on what you are proposing, tbh. Can you please elaborate what
you have in mind?

>
> >>>  and then grant
> >>> specific BPF operations on specific BPF programs/maps based on custom
> >>> LSM security policy,
> >> This is backwards. The correct implementation is to require CAP_BPF an=
d
> >> further restrict BPF operations based on a custom LSM security policy.
> >> That's how LSM is designed.
> > Please see my reply to Paul, we can't grant real CAP_BPF for
> > applications in user namespace (unless there is some trick that I
> > don't know, so please do point it out). Let's converge the discussion
> > in that email thread branch to not discuss the same topic multiple
> > times.
>
> I saw your reply to Paul. Paul's points are not my points. If they where,
> I wouldn't have taken my or your time to present them.

Sure, sorry about that. What do you have in mind then?

>
> >>>  which validates application trustworthiness using
> >>> custom production-specific logic.
> >>>
> >>> Isn't this goal in line with LSMs mission to enhance system security?
> >> We're not arguing the goal, we're discussing the implementation.
> >>
> >>>>> It looks to me like this series can be refactored to do the same. I
> >>>>> wouldn't consider that to be a "bypass", but I would agree the curr=
ent
> >>>>> series looks too much like "bypass", and makes reasoning about the
> >>>>> effect of the LSM hooks too "special". :)
> >>> Sorry, I didn't realize that the current code layout is making things
> >>> more confusing. I'll address feedback to make the intent a bit
> >>> clearer.
> >>>
> >>>> --
> >>>> paul-moore.com
