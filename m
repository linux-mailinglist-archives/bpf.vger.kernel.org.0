Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3C48CB5C
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 19:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356330AbiALSz6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 13:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356325AbiALSzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 13:55:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D86C06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 10:55:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F7A8B82062
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 18:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAD3C36AE5
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642013752;
        bh=JUeIQfDlpdEY54lDkEHd5xEJYb2vx9lOoAVfg4U80Jk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AOZCBgysaOSUfoHOMOWwRguk2aT/JoJnK7660Fcih5scr3FlZHJytd9o0WM7cQtfs
         SbUJKihKyn2s4ndMAR3WkrTrXk8unWvJevGdEwoknv2cS05CeqxemTW5YJclvoER2z
         TVDRHnij/qI1RJ8N+8YMN17NhLXRPrFXwkgnKrET9nnleXXZ5+hG4ZBZ1Oqw5vfM/o
         6v8xagdNEaonSBvLWQbr7VQB+LUOsCbc9/xy/hL3mpCSXP6lP/8uMSX41pLuieH+UT
         Yp4MU+ZC2RahXZEu9d1kkhfp/IODRpdu1UESzoE+Fvy6vEAx85tIraGFENphQERDvT
         8R1TVJ9V9FcVw==
Received: by mail-yb1-f175.google.com with SMTP id c6so8315457ybk.3
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 10:55:52 -0800 (PST)
X-Gm-Message-State: AOAM530jk9jX7KYEDwd+yDtqhDozA7iCt6WXU+oRnaO07TuOSy6lca3t
        YR3HC38kaxouiT6/SkidlC7W37a+ykd7lPizXfs=
X-Google-Smtp-Source: ABdhPJyYum1xUVta6Y9AtRiwm8/Stc5eRFSwLQ+GoeiuWg/xMVgh74CEmB45WPe+K40Wm99a+hwyZdSd3kL58ZS4oYw=
X-Received: by 2002:a05:6902:1106:: with SMTP id o6mr1540646ybu.195.1642013752066;
 Wed, 12 Jan 2022 10:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
 <YdiTrq4Y7JwmQumc@google.com> <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
 <20220111033344.n2ffifjlnoifdgnj@ast-mbp.dhcp.thefacebook.com> <CA+khW7i3CMMLpHVAk9zG2GPoOiJrm1un4TgeUu-nM_Vp1C0m_g@mail.gmail.com>
In-Reply-To: <CA+khW7i3CMMLpHVAk9zG2GPoOiJrm1un4TgeUu-nM_Vp1C0m_g@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 12 Jan 2022 10:55:41 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7srY_jncVtywOxxbtTwA43KAzKfnQyPyUNEdLCeAXKMQ@mail.gmail.com>
Message-ID: <CAPhsuW7srY_jncVtywOxxbtTwA43KAzKfnQyPyUNEdLCeAXKMQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 11, 2022 at 10:20 AM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Jan 10, 2022 at 7:33 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jan 10, 2022 at 10:55:54AM -0800, Hao Luo wrote:
> > >
> > > I see. With attach API, are we also able to specify some attributes
> > > for the attachment? For example, a property that we may want is: let
> > > descendent cgroups inherit their parent cgroup's programs.
> >
> > Plenty of interesting ideas in this thread. Thanks for kicking it off.
> > Maybe we should move it to office hours?
> > The back and forth over email can take some time.
>
> No problem. Requested a time on Thursday (1/13/22).

CC Tejun, who might be interested in this discussion.

@Tejun, FYI the office hour is tomorrow 9am PST, via zoom:

  https://fb.zoom.us/j/91157637485

Thanks,
Song
