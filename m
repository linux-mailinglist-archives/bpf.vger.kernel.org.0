Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371576F721B
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEDSr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEDSr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:47:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63910D2
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 11:47:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24df6bbf765so827990a91.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683226075; x=1685818075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8jFgFNzrfMCwUIuzxfRI/Nd9VXx25M3K2ZPAn9Uf20=;
        b=QVi5wQAFDYiNBVY+phJQr2FzPt5mLw8QgJucpJzbmrEujtmJfrFkEYgiKGNLbNDkuB
         e5ENsJ37CbCAaaixkRJ4KgEQwT6+IJwCno+Pt0fF0KBQfYmFYSEg3Ojzu57OyJXLfFM4
         Mp9byFrZVYe5tSKmTc+n6u0TgQ26H0pTrZaE/ja+vBm85EeZWYEVOPD6ojdDXge/M7jd
         P9TcQx15S2lMeUpOlUoUARjuxbmmjcx6mOIintQxhBQ7V9XxMzaQn9W3sT+66cA+TwWS
         CNpUjid7L/He38NtuVpb+39JvKxql63gEuuTbTAp292jENSq0GVU+j6bM5w3eCwXUs59
         XF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226075; x=1685818075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8jFgFNzrfMCwUIuzxfRI/Nd9VXx25M3K2ZPAn9Uf20=;
        b=AfNHu268X0ROsIj+e0ODHCmaREMUE1STST6VOeKsHtCYZhbOwNi+MFcgqsBUEQIr3R
         0MiAUlNAahtteDYf+B5SIBuxhwaLkq1agr6qqhBAWW2eISPFSiM6PL77sTeRRtlL5Rus
         klGEy7serclkZJzx1IPJHYVs49oO5Q9lWC/UE4lU7Er3VoqScWlL6Ck2MlGToBQD6VJg
         MMMEJQF+6OvafGv+ou3GmubRkNl4fAUHfI72BSGx1djNwzxsB3Vch2WXH3WBmFk9mDoo
         yv0XEGt6eKDDgcYlS8y6O14bkPIqOk7a2u1Z66g2FgfQrdjCbZPdtIFBTXhY0s8o1btZ
         jKsQ==
X-Gm-Message-State: AC+VfDzuaJ7emRSJXsXBNXd3Su7oVxu6lUIYwFJIn+qhpDPoCtv08/e0
        jzvBrcfYKArRZWFPaFN5uEmCCwopN1nh6ttvEN/WRA==
X-Google-Smtp-Source: ACHHUZ4X+cFHx9v7UMO8wKI3RkxcSAswnee59uCAKEx0eosynJOGfhaPrOdwCUq+70WlxtXZibGa12EOMUtNe1nwIhI=
X-Received: by 2002:a17:90b:4a4f:b0:247:a3ed:63b3 with SMTP id
 lb15-20020a17090b4a4f00b00247a3ed63b3mr2858158pjb.31.1683226074557; Thu, 04
 May 2023 11:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPTztWYAiroY3E8pwB+rnPGA1K9HLhkpQp1Gy9C1dEuS1FhWGg@mail.gmail.com>
 <CAPTztWY49XP-7GDHuvV2fNDCeJzd0vAac6n+rJ9KfWr6cyZ5ww@mail.gmail.com> <ZEvVqMtnU142GMEU@dhcp22.suse.cz>
In-Reply-To: <ZEvVqMtnU142GMEU@dhcp22.suse.cz>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 4 May 2023 11:47:42 -0700
Message-ID: <CA+khW7iLyA=jm8ut=UcY0zkfDFAzRsdeJS-ty-BqWrcpS27hUg@mail.gmail.com>
Subject: Re: [Lsf-pc] Fwd: [LSF/MM/BPF TOPIC] userspace control of memory management
To:     Michal Hocko <mhocko@suse.com>
Cc:     Frank van der Linden <fvdl@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 7:18=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> For some reason I cannot find this email in my linux-mm inbox and I
> cannot find it in any archives so let me add linux-mm and lkml again for
> future reference.
>
> On Tue 28-02-23 21:20:57, Frank van der Linden via Lsf-pc wrote:
> > ---------- Forwarded message ---------
> > From: Frank van der Linden <fvdl@google.com>
> > Date: Tue, Feb 28, 2023 at 4:15 PM
> > Subject: [LSF/MM/BPF TOPIC] userspace control of memory management
> > To: <linux-mm@kvack.org>
> >
> >
> > I propose this discussion topic for LSF/MM/BPF.
> >
> > In a world where memory topologies are becoming more complicated, is
> > it still possible to have an approach where the kernel deals with
> > memory management to everyone's satisfaction?
> >
> > The answer seemingly has been "not quite", since madvise and mempolicy
> > exist. With things like cxl.mem coming into existence, a heterogeneous
> > memory setup will become more common.
> >
> > The number of madvise options keeps growing. There is now a
> > process_madvise, and there are proposed extensions for the mempolicy
> > systemcalls, allowing one process to control the policy of another, as
> > well. There are exported cgroup interfaces to control reclaim, and
> > discussions have taken place on explicit control reclaim-as-demotion
> > to other nodes.
> >
> > Is this the right approach? If so, would it be a good idea to
> > optionally provide BPF hooks to control certain behavior, and let
> > userspace direct things even more? Is that even possible,
> > performance-wise? Would it make sense to be able to influence the
> > MGLRU generation process in a more direct way if needed?
> >
> > I think a discussion about these points would be interesting. Or, I
> > should say, further discussion.
> >
> > What do you think?
> >
> > Thanks,
> >
> > - Frank
> > _______________________________________________

Please allow me to cc bpf mailing list for visibility. The idea seems
interesting.

Hao
