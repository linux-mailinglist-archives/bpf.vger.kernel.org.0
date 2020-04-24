Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3051B6BA9
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 05:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgDXDAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 23:00:10 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44927 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDXDAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 23:00:10 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 03O2xoAh028692;
        Fri, 24 Apr 2020 11:59:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 03O2xoAh028692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587697191;
        bh=sMhAyQXgx3aGgeT2cBKikLWxHkHjlRUwrBTCsV1+3Gw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pnu0hGRUoE/m3c5iNOXeZVq/zyyFbsQqCoxufZov1J8pArY22bCjRMZqzG/L3m5+n
         1TGlCwr5ISXTw+671s8m/Z/m5pAMgJwxRH3EVJGBXzTKsOAUN9wqwbss3CVkEAvV6k
         TRIuXE+CR0M+7GUrLfZZxVChoqZApt5XMnu03Kn5LEbu63plgi0Xb/c58bmydut5wk
         ubf65em2YZFOa3Qr6YgDq4cquF49M9yRvYo9oLYU7XwS8nx46BohhaZA0TS2j4U4Mg
         HUeE4Mn2IySUCOFVuOb2xUOPxiwPIzQj1nRYpgqcPxO/A84tApwP7x1aS3P2vB1am/
         hUrlcaFMHbMBg==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id a10so8040902uad.7;
        Thu, 23 Apr 2020 19:59:51 -0700 (PDT)
X-Gm-Message-State: AGi0Pua1YSRFCR1v4PLQ63nig+DIo038pykOo5o3uN4c2TW0u5aUWuM+
        lT0D0BB3hrt+8A8Pn4tyRwy8I5WsdAYsBNMUDb4=
X-Google-Smtp-Source: APiQypJwidJWbxYPm/8c0bwT8boM9jxvggOQZWWhl+mIk5bgeb7K2rLmsZC1B59FOXGSWq0gtKzTuQcI9OVc/f+WiGc=
X-Received: by 2002:ab0:cd:: with SMTP id 71mr5422237uaj.109.1587697190149;
 Thu, 23 Apr 2020 19:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200423073929.127521-1-masahiroy@kernel.org> <20200423073929.127521-15-masahiroy@kernel.org>
 <CANiq72nUa8uoXtSThqq7t9oAmZnGSE9a1_d+ZoRAagpKDo4DRg@mail.gmail.com>
In-Reply-To: <CANiq72nUa8uoXtSThqq7t9oAmZnGSE9a1_d+ZoRAagpKDo4DRg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Apr 2020 11:59:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASo=R2uoNPzof_FppFUp=sMAZG62C3PLAMm9jZix9z3Rw@mail.gmail.com>
Message-ID: <CAK7LNASo=R2uoNPzof_FppFUp=sMAZG62C3PLAMm9jZix9z3Rw@mail.gmail.com>
Subject: Re: [PATCH 14/16] samples: auxdisplay: use 'userprogs' syntax
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Miguel,

On Thu, Apr 23, 2020 at 8:50 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Masahiro,
>
> On Thu, Apr 23, 2020 at 9:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Kbuild now supports the 'userprogs' syntax to describe the build rules
> > of userspace programs for the target architecture (i.e. the same
> > architecture as the kernel).
> >
> > Add the entry to samples/Makefile to put this into the build bot
> > coverage.
> >
> > I also added the CONFIG option guarded by 'depends on CC_CAN_LINK'
> > because $(CC) may not necessarily provide libc.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Thanks for this! Looks nice. I guess you take all patches for the
> samples/ changes through your tree?

Yes, I will take all to my tree
since this series is mostly Makefile changes.



> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
