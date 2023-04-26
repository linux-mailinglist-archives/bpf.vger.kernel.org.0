Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234C06EF956
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjDZR1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjDZR1c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 13:27:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417207AA5
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 10:27:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24986ade373so6575397a91.2
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682530044; x=1685122044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmm51cQsBKUj//THmTv3RbK5Z4hCaA2MxgZDDqLZOt0=;
        b=veBYkjuyvpt7aFRv4T1dkg44PQo3I4tc7DJlRYzgeqE79vLc8/ZeoSaVvv78oGnekY
         htxmZ5PuKWe5n+yav/RYHGoYF31RxjJxK7W1Xs/pGA4jAXnvI+/8xnI4sa7x1uguCaav
         hAkE5cShAtuqS8c+DpXd0+X2j4R7kzGSKn0Si0BTb3uS3klP29bxckkxQGUkWjeRIcS1
         53JF+PEXpEs5Pbd4gylt0fnEmQOOz46OYzYF0gxAyS+KxAIIfXmgCEACoxPBsmUuvV5i
         BdM1Va4U8kbkZ7Mqds91Cq/mkcgGIrXhQSNNNjK3JIyIjpJMTBTZjK0oQoona8gnqEB0
         NXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682530044; x=1685122044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmm51cQsBKUj//THmTv3RbK5Z4hCaA2MxgZDDqLZOt0=;
        b=LwGuULj+QNInZvrFl0Wto+IYYW9QJfenhZq+zdEOb5gVxOGKymYd5dsPLYWBlzt0/E
         wOk1tA58lIz3/Lhk7ULLB6iFQJD9g6i0PLYGKClgVmKbuYwdduOejA1cbHW3FCTZqOy3
         LDt0Nc9MEtuk4MeUHzV4f9YOfwyvsaCq7NjxQo3Wliw1T8nD7PDOUSmtviYlJXlQ//Rp
         0miiyLkpAQapcuGcV02rg0VhUKJpl2XNSrWZFiqsVJGnpQo/V8J1UHBV3gJWSLIaSWIm
         R37yDNF1fHmDAubU91Ht0NT0m3Nh/OzsmoOsRp05xs5zg8FomBgdEgyZelqk1qDUA5fi
         0npQ==
X-Gm-Message-State: AAQBX9dSivCIEJE6qEHm9zSHrIz2i+I2wXtp7O9flsuOcgWoeJgmkbu1
        vxGtc+zxNrHhmG6iNKeY+LOWxHlO+vC19WFEzWEVJXB2kql2zBhk+GXcRw==
X-Google-Smtp-Source: AKy350Z4M6NaCxXQ8HsOGiYtAopOEX3as9TKOKc7k6vSa9XYixqFZyrGfv1Kgr1ezx6W4r/I2QEsmrZqRuExCBU0MwI=
X-Received: by 2002:a17:90a:3004:b0:246:681c:71fd with SMTP id
 g4-20020a17090a300400b00246681c71fdmr20809326pjb.6.1682530044500; Wed, 26 Apr
 2023 10:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com> <20230418225343.553806-4-sdf@google.com>
 <4a2e1b70-9055-f5d9-c286-3e5760f06811@iogearbox.net> <CAKH8qBshg+bF59LUXypxvPX1Gek2AASL+DQydVLMgqGT4ONfGQ@mail.gmail.com>
 <f68fc5d8-9bd7-19b2-0e57-8ba746295d37@linux.dev> <CAKH8qBsVw=my-pB5Mnmyq-Cp0a1by-nS_=Fyu7cZTmiKk8niXw@mail.gmail.com>
 <4d5e33ff-9e0a-aa2b-0482-49bda0d7fade@linux.dev>
In-Reply-To: <4d5e33ff-9e0a-aa2b-0482-49bda0d7fade@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 26 Apr 2023 10:27:13 -0700
Message-ID: <CAKH8qBtuz0DYrsdgoX2_McOYFSES2_z9+BWcj+XczQZ_Fr6_KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 11:31=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 4/25/23 10:12 AM, Stanislav Fomichev wrote:
> > On Mon, Apr 24, 2023 at 5:56=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 4/21/23 9:09 AM, Stanislav Fomichev wrote:
> >>> On Fri, Apr 21, 2023 at 8:24=E2=80=AFAM Daniel Borkmann <daniel@iogea=
rbox.net> wrote:
> >>>>
> >>>> On 4/19/23 12:53 AM, Stanislav Fomichev wrote:
> >>>>> Over time, we've found out several special socket option cases whic=
h need
> >>>>> special treatment. And if BPF program doesn't handle them correctly=
, this
> >>>>> might EFAULT perfectly valid {g,s}setsockopt calls.
> >>>>>
> >>>>> The intention of the EFAULT was to make it apparent to the
> >>>>> developers that the program is doing something wrong.
> >>>>> However, this inadvertently might affect production workloads
> >>>>> with the BPF programs that are not too careful.
> >>>>
> >>>> Took in the first two for now. It would be good if the commit descri=
ption
> >>>> in here could have more details for posterity given this is too vagu=
e.
> >>>
> >>> Thanks! Will try to repost next week with more details.
> >>>
> >>>>> Let's try to minimize the chance of BPF program screwing up userspa=
ce
> >>>>> by ignoring the output of those BPF programs (instead of returning
> >>>>> EFAULT to the userspace). pr_info_ratelimited those cases to
> >>>>> the dmesg to help with figuring out what's going wrong.
> >>>>>
> >>>>> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hook=
s")
> >>>>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> >>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>>>> ---
> >>>>>     kernel/bpf/cgroup.c | 8 ++++++--
> >>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> >>>>> index a06e118a9be5..af4d20864fb4 100644
> >>>>> --- a/kernel/bpf/cgroup.c
> >>>>> +++ b/kernel/bpf/cgroup.c
> >>>>> @@ -1826,7 +1826,9 @@ int __cgroup_bpf_run_filter_setsockopt(struct=
 sock *sk, int *level,
> >>>>>                 ret =3D 1;
> >>>>>         } else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
> >>>>>                 /* optlen is out of bounds */
> >>>>> -             ret =3D -EFAULT;
> >>>>> +             pr_info_ratelimited(
> >>>>> +                     "bpf setsockopt returned unexpected optlen=3D=
%d (max_optlen=3D%d)\n",
> >>>>> +                     ctx.optlen, max_optlen);
> >>>>
> >>>> Does it help any regular user if this log message is seen? I kind of=
 doubt it a bit,
> >>>> it might create more confusion if log gets spammed with it, imo.
> >>>
> >>> Agreed, but we need some way to let the users know that their bpf
> >>> program is doing the wrong thing (if they set the optlen too high for
> >>> example).
> >>
> >> imo, I also think a printk here will be a noise in dmesg most of the t=
ime (but
> >> much better than an unexpected -EFAULT).
> >
> > I was thinking for a v2, maybe print it at least once? Similar to
> > current bpf_warn_invalid_xdp_action?
> >
> >
> >>> Any other better alternatives to expose those events?
> >>
> >> Is it possible to only -EFAULT when the bpf prog setting a ctx.optlen =
larger
> >> than the "original" user provided optlen?
>
> Nevermind the "ctx.optlen larger than the original user provided optlen" =
part. I
> mis-read something in __cgroup_bpf_run_filter_getsockopt(). max_optlen is=
 the
> right limit that the kernel needs to bound the ctx.optlen written by bpf =
prog.
>
> >> Ignore for all other cases that is due to the current PAGE_SIZE limita=
tion?
> >
> > Should be possible. That "ctx.optlen > PAGE_SIZE && ctx.optlen <
> > original_optlen" is the condition where we'd silently ignore BPF
> > output.
>
> and should the -ve ctx.optlen be treated separately? like in
> __cgroup_bpf_run_filter_getsockopt():
>
>         if (ctx.optlen < 0) {
>                 ret =3D -EFAULT;
>                 goto out;
>         }
>
>         if (optval && ctx.optlen > max_optlen) {
>                 ret =3D original_optlen > PAGE_SIZE ? 0 : -EFAULT;
>                 goto out;
>         }

Good suggestion. Let me try to distinguish between the two cases:
- bpf prog sets optlen larger than the original_optlen -> EFAULT
- bpf prog forgets to reset optlen to 0 for large optlen -> ignore

> > As per above, I'll stick a line to the dmest (similar
> > bpf_warn_invalid_xdp_action), at least to record that this has
> > happened once.
> > LMK if you or Danial still don't see a value in printing this..
>
> pr_info_once? hmm... I think it is ok-ish. At least not a warning.
>
> I think almost all of the time the bpf prog forgets to set it to 0 for th=
e long
> optval that it has no interest in. However, to suppress this pr_info_once=
,
> setting optlen to 0 will disable the following cgroup-bpf prog from using=
 the
> optval as read-only. The case that the printk that may flag is that the b=
pf prog
> did indeed want to change the long optval?

The case we want to printk is where the prog changes some byte in the
first 4k range of the optval and does not touch optlen (or maybe
adjusts optlen to be >PAGE_SIZE and <original_optlen).
I agree that it feels super corner-casy; but it feels like without
some kind of hint, it would be impossible to figure out why it doesn't
work. Or am I overblowing it?
