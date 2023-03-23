Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37CE6C7036
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 19:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCWSb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCWSb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 14:31:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1A24CAD
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 11:31:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o2so15721827plg.4
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679596286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC/Mz5u7YlewT1HLwsFEME9qfkAG95/Hkr8q/kmVKAs=;
        b=svYI1nEuWI/9EQK9hiVCC0QhsQ0xmRgXnafVsGEDRjXGq5v9hcrKbmc0vOw6PCR6yF
         yDPhW+KDg5dPB9hbiqyjzk2l/788JJ0GI7XiedoS/ksl2Ow+Cnh6C1sz/WhIB7guw+aA
         n/2toZl+37kUFgrl+9iqemVCACMCabZFFsXHHxZz0ptylXGL7N4JIa2aAPrf+7d4QAtr
         W+dVz3k5B2SmMRrVqemms7cHqb1xhL3qdE5IREPiVnH2rlOQBDB1pkwDvpBppIAP7brF
         G/AymQlEAKBGW4Lx7A6yBVJ69oHnIbGNx8qppWoAhr9FJZziAXio/PRTDHkznDMrsDTR
         1o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679596286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC/Mz5u7YlewT1HLwsFEME9qfkAG95/Hkr8q/kmVKAs=;
        b=RXjrSFO9BiOH4ND4/qX4YRpJd9tEN2e0lWo0Fx24gIBiEPnuWGehfVI+ZAjvixNRp/
         P/xuZbaZwA+ZWtL/Hs1oS59tpNcW0bkXwNaizDJXGaYwZZ544GobdoDGtB2vp7FX8IpE
         QUQIdaML8xWzvkgWWQnmsFKJim8KEP3AdEfPHOYsjUeYc5XpPGJ/gdK7zFd1EeSM6dHL
         CvQ1CQoYbQo1PGMESN131zXEhYKEg6sNKNGNUHvXW8CJo791jKZD1pemfbSL1AfGPYc6
         9eLk+BxPQzIyhqiCfS3LUB5MvKdUe6Pmwgf3OeBNQuyuRhcpX3+h/MaLPcsQnjb2EhSh
         3NWA==
X-Gm-Message-State: AO0yUKWu2tkp+4i64+Acchz1+8vZ2tEfNPDakd9bMPzd3L7KYDX0+2KE
        Aw8I7WLhSA7ymRmtZzMFIKfPl2PxwOTOa8wnSk2BbYs4XwBE+PZ5UiI=
X-Google-Smtp-Source: AK7set/+utno3KtsS8SJ+AUgAuyaUpBnt2FspbadFr6HSED+ghQ4knNEhFrJ51e/3R6Fu8ilXuCPUc20MRi7AS3Xa10=
X-Received: by 2002:a17:902:708b:b0:1a0:6001:2e0e with SMTP id
 z11-20020a170902708b00b001a060012e0emr2723629plk.8.1679596285735; Thu, 23 Mar
 2023 11:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230302172757.9548-1-fw@strlen.de> <20230302172757.9548-2-fw@strlen.de>
 <ZAEG1gtoXl125GlW@google.com> <20230303002752.GA4300@breakpoint.cc> <20230323004123.lkdsxqqto55fs462@kashmir.localdomain>
In-Reply-To: <20230323004123.lkdsxqqto55fs462@kashmir.localdomain>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 23 Mar 2023 11:31:14 -0700
Message-ID: <CAKH8qBvw58QyazkSh2U80iVPmbMEOGY0T8dLKX5PWg4b+bxqMw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 1/3] bpf: add bpf_link support for
 BPF_NETFILTER programs
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 5:41=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Florian, Stan,
>
> On Fri, Mar 03, 2023 at 01:27:52AM +0100, Florian Westphal wrote:
> > Stanislav Fomichev <sdf@google.com> wrote:
> > > On 03/02, Florian Westphal wrote:
> > > > +                 struct {
> > > > +                         __u32           pf;
> > > > +                         __u32           hooknum;
> > > > +                         __s32           prio;
> > > > +                 } netfilter;
> > >
> > > For recent tc BPF program extensions, we've discussed that it might b=
e
> > > better
> > > to have an option to attach program before/after another one in the c=
hain.
> > > So the API essentially would receive a before/after flag + fd/id of t=
he
> > >
> > > Should we do something similar here? See [0] for the original
> > > discussion.
> > >
> > > 0: https://lore.kernel.org/bpf/YzzWDqAmN5DRTupQ@google.com/
> >
> > Thanks for the pointer, I will have a look.
> >
> > The above exposes the "prio" of netfilter hooks, so someone
> > that needs their hook to run early on, say, before netfilters
> > nat engine, could just use INT_MIN.
> >
> > We could -- for nf bpf -- make the bpf_link fail if a hook
> > with the same priority already exists to avoid the "undefined
> > behaviour" here (same prio means register order decides what
> > hook function runs first ...).
> >
> > This could be relevant if you have e.g. one bpf program collecting
> > statistics vs. one doing drops.
> >
> > I'll dig though the thread and would try to mimic the tc link
> > mechanism as close as possible.
>
> While I think the direction the TC link discussion took is totally fine,
> TC has the advantage (IIUC) of being a somewhat isolated hook. Meaning
> it does not make sense for a user to mix priority values && before/after
> semantics.
>
> Netfilter is different in that there is by default modules active with
> fixed priority values. So mixing in before/after semantics here could
> get confusing.

I don't remember the details, so pls correct me, but last time I
looked, this priority was basically an ordering within a hook?
And there were a bunch of kernel-hardcoded values. So either that
whole story has to become a UAPI (so the bpf program knows
before/after which kernel hook it has to run), or we need some other
ordering mechanism. (I'm not sure what's the story with bpf vs kernel
hooks interop, so maybe it's all moot?)
Am I missing something? Can you share more about why those fixed
priorities are fine?

> Thanks,
> Daniel
