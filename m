Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98775A181A
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHYRoQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 13:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbiHYRoL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 13:44:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDAB6D2A
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 10:44:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w10so14918550edc.3
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0cvHgMstWuxPQXBPkVYr2Li6Ee2cT6W5MirexNtKI3M=;
        b=ZHSjBB+7miO3l/i8VY3NsvA0jBvbKagDD2J4zheOwUYTiowBbmo8/CWuCVG2eKR9Wx
         2QE+TpiqjSDCanbksBJVYwq3XAnI40Uv04ynfJ1YOqcCGx1xUmaZB8eHFVByT7s1TbPb
         HkzMJxBlqy8SFJXJlcAhtVrd4oIfI8t5ywXO+lwt4PR28xrJk0nJ4sfyoWEszvuc4G0q
         ZJiAQwRn3i0jd5QNE3WNXhOoNzpQv3ncanSObrro+1rPldM3+o7eTwpgsx9EONMWNO1i
         i25lA1Q1WqgWC3kniR0J4FiKj3tNOsYtmCPmsaDmGwfQgb3G9i7fiMHKfb/BAf+AJ9UI
         oDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0cvHgMstWuxPQXBPkVYr2Li6Ee2cT6W5MirexNtKI3M=;
        b=ac8IzaOkVXdtvbFu0KpMjWQpOcDApTK/UYMilrVmDh11R2TbmAXmH1D2k1sDI3eHdC
         BCqA1oKggZoIgCApMc7KbdKCHNmhu/uL8HFWnnjv76quzSiZSpbHpOU5G8+Ry2lUTPqk
         6merayhmK8ls4J/bDTMOrQNqPCaiZN++FlA4drszfFahE3+aabNrt+W8cGD7STHUb0tG
         YHHsWy8P+5CTC0rdBsAQ2zbduXhy7PDhxA3epnHpLqGRFI8lWaRAWm6Z4SsBMwSK/P8F
         gREXjE0iMPah5Y5GsgBZd40OITNB3lVY9ZzvSIeT4gFythW9qi5nEEJLkjLMK8DiTxMS
         QfYQ==
X-Gm-Message-State: ACgBeo032maiMTiblzYUQCZdEsfVxDddBS3vCwkymdb8JkCXyAECDZhj
        LuzbNIldjZBsPtSYO7Agvjze4mkljbykNfGIRSE=
X-Google-Smtp-Source: AA6agR5LgGUBrsigiO8Q4Mz2o2dR9KfRFIR8zKoJZacpZu2wgdM1oSSrBNMBXW6zeL1RV+yNcgFZiP58rZ+GvKnEreU=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr4069251edb.333.1661449448132; Thu, 25
 Aug 2022 10:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220808140626.422731-1-jolsa@kernel.org> <20220808140626.422731-11-jolsa@kernel.org>
 <20220824012237.h57uimu2m3medkz5@macbook-pro-3.dhcp.thefacebook.com> <YweedGDaL7yI382D@krava>
In-Reply-To: <YweedGDaL7yI382D@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Aug 2022 10:43:56 -0700
Message-ID: <CAADnVQKVnSu-wDiVk6E3mU9J_LGC+0ou63T8TUv-J=BSCZf6iQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 10/17] bpf: Add support to attach program to
 multiple trampolines
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Thu, Aug 25, 2022 at 9:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Aug 23, 2022 at 06:22:37PM -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 08, 2022 at 04:06:19PM +0200, Jiri Olsa wrote:
> > > Adding support to attach program to multiple trampolines
> > > with new attach/detach interface:
> > >
> > >   int bpf_trampoline_multi_attach(struct bpf_tramp_prog *tp,
> > >                                   struct bpf_tramp_id *id)
> > >   int bpf_trampoline_multi_detach(struct bpf_tramp_prog *tp,
> > >                                   struct bpf_tramp_id *id)
> > >
> > > The program is passed as bpf_tramp_prog object and trampolines to
> > > attach it to are passed as bpf_tramp_id object.
> > >
> > > The interface creates new bpf_trampoline object which is initialized
> > > as 'multi' trampoline and stored separtely from standard trampolines.
> > >
> > > There are following rules how the standard and multi trampolines
> > > go along:
> > >   - multi trampoline can attach on top of existing single trampolines,
> > >     which creates 2 types of function IDs:
> > >
> > >       1) single-IDs - functions that are attached within existing single
> > >          trampolines
> > >       2) multi-IDs  - functions that were 'free' and are now taken by new
> > >          'multi' trampoline
> > >
> > >   - we allow overlapping of 2 'multi' trampolines if they are attached
> > >     to same IDs
> > >   - we do now allow any other overlapping of 2 'multi' trampolines
> > >   - any new 'single' trampoline cannot attach to existing multi-IDs IDs.
> > >
> > > Maybe better explained on following example:
> > >
> > >    - you want to attach program P to functions A,B,C,D,E,F
> > >      via bpf_trampoline_multi_attach
> > >
> > >    - D,E,F already have standard trampoline attached
> > >
> > >    - the bpf_trampoline_multi_attach will create new 'multi' trampoline
> > >      which spans over A,B,C functions and attach program P to single
> > >      trampolines D,E,F
> > >
> > >    - A,B,C functions are now 'not attachable' by any trampoline
> > >      until the above 'multi' trampoline is released
> >
> > This restriction is probably too severe.
> > Song added support for trampoline and KLPs to co-exist on the same function.
> > This multi trampoline restriction will resurface the same issue.
> > afiak this restriction is only because multi trampoline image
> > is the same for A,B,C. This memory optimization is probably going too far.
> > How about we keep existing logic of one tramp image per function.
> > Pretend that multi-prog P matches BTF of the target function,
> > create normal tramp for it and attach prog P there.
> > The prototype of P allows six u64. The args are potentially rearding
> > garbage, but there are no safety issues, since multi progs don't know BTF types.
> >
> > We still need sinle bpf_link_multi to contain btf_ids of all functions,
> > but it can point to many bpf tramps. One for each attach function.
> >
> > iirc we discussed something like this long ago, but I don't remember
> > why we didn't go that route.
> > arch_prepare_bpf_trampoline is fast.
> > bpf_tramp_image_alloc is fast too.
> > So attaching one multi-prog to thousands of btf_id-s should be fast too.
> > The destroy part is interesting.
> > There we will be doing thousands of bpf_tramp_image_put,
> > but it's all async now. We used to have synchronize_rcu() which could
> > be the reason why this approach was slow.
> > Or is this unregister_fentry that slows it down?
> > But register_ftrace_direct_multi() interface should have solved it
> > for both register and unregister?
>
> I think it's the synchronize_rcu_tasks at the end of each ftrace update,
> that's why we added un/register_ftrace_direct_multi that makes the changes
> for multiple ips and syncs once at the end

hmm. Can synchronize_rcu_tasks be made optional?
For ftrace_direct that points to bpf tramps is it really needed?

> un/register_ftrace_direct_multi will attach/detach multiple multiple ips
> to single address (trampoline), so for this approach we would need to add new
> ftrace direct api that would allow to set multiple ips to multiple trampolines
> within one call..

right

> I was already checking on that and looks doable

awesome.

> another problem might be that this update function will need to be called with
> all related trampoline locks, which in this case would be thousands

sure. but these will be newly allocated trampolines and
brand new mutexes, so no contention.
But thousands of cmpxchg-s will take time. Would be good to measure
though. It might not be that bad.
