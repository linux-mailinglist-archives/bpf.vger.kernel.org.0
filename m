Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7448B59C
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 19:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbiAKSUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiAKSUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 13:20:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335DC06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 10:20:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso1992689wmj.2
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wm7JxQun/f0KEdfX9AQ8CuW2Ykn5Ij0XUilnvdBPwxQ=;
        b=dJujzxlkN7zU25a8hlOsXa7XIX8pfGN2bX+MNbJGMEmhAItAeTrLf6fUw4zM+5yOFw
         xSkfWTUj1JlJm6KiS9hE7gnf3AG/QOcOFDDBCNvj2Ddtq48zMSAyRf22Q3oz9ZB5ME/K
         FJA/2Xr49YpZKRdvJsXRw9omT+TH48dal3RQgKAxkPu8d16yt4YK20Jtb1I4BVnDZ4Tw
         PBXSbl65huLGqLcN8d/kTl/3zqz0qWfcbQebgsso6Z5wv6OG08l1fkbhfqFUIZEW7dWT
         eCRlndFelj0g2YIFuI3IcMvV+N+ZPRUAyJqF7t8mbL6q0WIMMmNzDeOZZsTnu/O7NOoX
         FBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wm7JxQun/f0KEdfX9AQ8CuW2Ykn5Ij0XUilnvdBPwxQ=;
        b=eayh3H6BBicNmUSt4TYp5tUnLye2xfS0hlrICI+YLG5Xmbgo/1Oyumzl/NaRBAXfSE
         X1WmNV+58h8+8jG0tl16TSIZl9WHiE78OSZr3aCYy0nbqqFVJTVNUpYP2GAaAJz1+18x
         +ae2/LZ6pVjfmbpkellgjZk4W9SSlhwWgjI9IC62Mna7IVwVcvCH8oPzlPlTzIZgz7zV
         yKi9a1GFT03ih06X2vNWhzVYOmtZ/O7wICvMCsej7bAsTha2tLQvTm2L3PGD5mvAqXGB
         gMCKgpsN3ET29GE+xUzcc3rKyLC1gO03LnbnYrdfulm0Dqh/QZJZwElQ8k/lb1airO8r
         up+w==
X-Gm-Message-State: AOAM5328kH8kvH0PKFD5ctiDwezsYW0CHOt7Oa5kINXe5YC3niYUYjCV
        zbaQlCSdHhhOpDM2AFD+lQvgPcEqvi9Yl8G2KbL0iw==
X-Google-Smtp-Source: ABdhPJwd6+Bj6GZ6Bv1j7tviWum9qUWGo+sD1S4b3AJ7sE7AplyQ8CdHNm5bSZMr3aihSJ1n57kbfDz/nYFJjKHRHds=
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr2488625wmj.68.1641925245065;
 Tue, 11 Jan 2022 10:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
 <YdiTrq4Y7JwmQumc@google.com> <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
 <20220111033344.n2ffifjlnoifdgnj@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220111033344.n2ffifjlnoifdgnj@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 11 Jan 2022 10:20:33 -0800
Message-ID: <CA+khW7i3CMMLpHVAk9zG2GPoOiJrm1un4TgeUu-nM_Vp1C0m_g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     sdf@google.com, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 10, 2022 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 10, 2022 at 10:55:54AM -0800, Hao Luo wrote:
> >
> > I see. With attach API, are we also able to specify some attributes
> > for the attachment? For example, a property that we may want is: let
> > descendent cgroups inherit their parent cgroup's programs.
>
> Plenty of interesting ideas in this thread. Thanks for kicking it off.
> Maybe we should move it to office hours?
> The back and forth over email can take some time.

No problem. Requested a time on Thursday (1/13/22).

> It sounds to me that "let descendents inherit" is a mandatory feature.
> In that sense "allow attach in kernfs" is not a feature. It feels that
> it's creating more problems for the design.
> Creating a "catable" file inside cgroup directory that descedents inherit
> with the same name is a cgroup specific feature.
> Inherit or not can be a flag, but the inheritance needs to be designed
> from the start.
>
> echo "rm" is not pretty.
> fsnotify feels a bit hacky.
> Maybe pinning in cgroupfs will avoid both issues?
> We can have normal unlink implemented there.
>
> The attach bpf_sys cmd as-is won't work. It needs a name at least.
> That will make it look like obj_pin cmd. So probably better to make
> obj_pin work when path is inside cgroupfs and use file_flags for
> inherit or not.
> The patch 8 gives a glimpse of how the bpf prog will look like.
> Can you make it more realistic?
> Do you need to walk cgroup children? Or all processes in a cgroup?
> Will we need css_for_each_descendant() as a bpf helper?
