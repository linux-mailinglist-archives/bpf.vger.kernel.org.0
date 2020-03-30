Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56AA1980CB
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgC3QSC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 12:18:02 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:44668 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3QSB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 12:18:01 -0400
Received: by mail-lj1-f172.google.com with SMTP id p14so18733462lji.11
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RZhMtylGsFHVN9z6+W/DO3tfjbONzUeU1vV8G94Wnk=;
        b=uVCj1jls1um+IFnFYAXlEl3lYn/Ft8+dWYk1a/M+NlIT0UWsnO21w6tRXOR7E3udoL
         Ea9iUXBC9QD3xlXfIV0f+bnx1i0FhuVFEtvoAyXjp4AYpxMNzWFCFTVrFLkQ9CqBdxNw
         sMa1pj4INgfN9HltvPVhFuhuco/8UchxZe+yQIKyI2ie99n7oqsz5lGk6w8gitTUAjNu
         n4S/uSQz97iyJRuJpzaNvs8wvDmy58c+p8rVUzBV2cxOJPIPfqM2wTJuLIfFXUE2s1w6
         8WR1vAvH095oLBBsEiydmU+7RTmiAyu76oqJpnM+vzj8QZIkqq56yeSKrztpvVVi1MnH
         0MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RZhMtylGsFHVN9z6+W/DO3tfjbONzUeU1vV8G94Wnk=;
        b=IS1PyQVcoeuYotMLG2pRdOdXS6Xpb+qTsydeUtc5MhDuY8YO+Y4LMllFJmq0dxf+Vj
         F4Pv8UXewp+uHygIv5SDAxXyXHlt9jAlqOWfDw0BPmuGp1Ibp48WgbKG+c3g2kyBuo3b
         fpz7bNVVUxfScNzctSGh16S7Ufxh8JaDx+CvMvH09nYZn3MANRlxsSkSr1btEclgZRX0
         8+hu1bm4h+Ez3xVH1khxW/QMR+YTuKSAA++6Z/xJnJhpx1obynI7D9201UcY0G6LhwW3
         rfkuxlOkMboeCwIvCHRfoltVfuA4z1BkIwqzZ04pKOhKgO+yCDPb0INLqF/gtHPY7ptQ
         Vi5g==
X-Gm-Message-State: AGi0PubnjNrO8HhNCoV9gADEgo/aGbuhCTId2S6C1yB1ILUW6NDghii0
        ehBxfn8J/dXRJlelDkJFlfV9McU7/3powTbeS5EiaQ==
X-Google-Smtp-Source: APiQypJNEagMzxJZcGFrz+oawUKbPvEzaZGuQMq79eVbKwBRY/RuQbdk+smSuOeE886fsdULdjaPh0jzDG/oJseDM4w=
X-Received: by 2002:a2e:9d98:: with SMTP id c24mr7099656ljj.137.1585585079275;
 Mon, 30 Mar 2020 09:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 30 Mar 2020 18:17:32 +0200
Message-ID: <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
> >
> > I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
> > of CONFIG_GCC_PLUGIN_RANDSTRUCT.
>
> Is it a theoretical stmt or you have data?
> I think it's the other way around.
> gcc-plugin breaks dwarf and breaks btf.
> But I only looked at gcc patches without applying them.

Ah, interesting - I haven't actually tested it, I just assumed
(perhaps incorrectly) that the GCC plugin would deal with DWARF info
properly.
