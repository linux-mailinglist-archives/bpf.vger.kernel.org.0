Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1098D21177F
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 02:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGBA4G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 20:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgGBA4E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 20:56:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F4C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 17:56:04 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so2806916ilh.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 17:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4SJgZdAaz8gjJC4FxZl/8zKdtp/7rdq371HOnug0HY=;
        b=Cyjlz4yE9NF1fb/PUWCYILno3H9eqKKeMRmGDzpxt3a5y9rtHXgprbXdvq78Bvis8+
         sCkd86CznSmzZlkyxJ1mt7lknLUJ6iPnCsdi8o6aoRgS46aGjGM3Z/i0eYvPqscajEaQ
         JTz0jyh0AGXkdrksXkA1rrAEVDa7x1PSVgotzKK6UTDBD0oNtvUk5wLvBwTlhlZ5CtKy
         BF0JYVVjjghZnajmijACgIRqhsCX/r9zFE41/gkz7/88bcYinMmN3mAH66/UBbylZCza
         /3yJWknXvcR1XQpjpJn0W2Zg2ojvE0YQ9ZdzNkdJlIztLHbnQAWi0I7EC661Ha/ZltnH
         F4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4SJgZdAaz8gjJC4FxZl/8zKdtp/7rdq371HOnug0HY=;
        b=XoHauyb9gWg2BCrXNgqNAoWgHko9mCOmqVJ04/253M7ZsUNqzJ3DsPyK0A1Z6pZxs3
         Tl28BFr+Qkl/ySBUINKhBX7wlNCpvtO/a61WZzy9PLervxPhy3o8+5lPqg5uNayjAWcL
         1LGMquVfcC7NbtqLk1hj9o9b4gaY9qu+gU5bTIe4+e7fAjm4Jdoj9GyWXL10s7EzyX1a
         ai3E41P+yMCgKsygEm3RroIRk4mZecFusvKtygkIDM5n16O5gm01yQiwoRJEAsSu4mSJ
         6aJO7riOom/idUTq2BRoTFwVo8bawgzGjAEMmPvTL6+PCoofQRJQ41rxZMzKyk1HNr58
         JUKQ==
X-Gm-Message-State: AOAM531pyRqMtZx6tmheimkugF++g1/GapWhclxVIXNFUw3XdqyVVcUP
        DvAnGc0DbwfTCVhLeVOx2yrI62Aq11fvYf7c4SXSZAIzAnxBPg==
X-Google-Smtp-Source: ABdhPJxArHLPIIz3bp3BwlNFiOSNeOTdpiNux0cceT4YLUCcBLGlh0GVqkNepCM1/1ArEUAZE96krIkuEEVjAzFee/0=
X-Received: by 2002:a05:6e02:eb3:: with SMTP id u19mr10770153ilj.130.1593651364019;
 Wed, 01 Jul 2020 17:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593638618.git.zhuyifei@google.com> <695f8051ba309ba3f342da5c7235118b00d0af73.1593638618.git.zhuyifei@google.com>
 <20200702001727.GB61684@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200702001727.GB61684@carbon.DHCP.thefacebook.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Wed, 1 Jul 2020 19:55:53 -0500
Message-ID: <CAA-VZPkrd7w+K13kyMs_GAdsNGaWmXPsBx-aJbUJh7-YurTdnA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 7:17 PM Roman Gushchin <guro@fb.com> wrote:
> I'm slightly concerned about changing the existing behavior without
> providing the backward compatibility. Idk how many users will actually
> suffer, but it might be an issue. Of course, it's up to maintainers
> to decide whether it's ok or not to break the existing behavior
> in this case.

This was considered. The problem with having full backwards
compatibility is that, one, the kernel code can be quite complicated.
If it's a 'legacy CGROUP_STORAGE' do this, else do that. Due to the
difference between the lifetime it would be sprinkled into a few
functions. Second, you would either need a flag to the map or a new
map type to indicate the legacy behavior. The former would be drawing
another bit from the limited bit-flags, and the latter, there would be
two more types, per-CPU and non-per-CPU. Perhaps per-CPU
shared-between-program is not useful and we would only implement
non-per-CPU shared-between-program to not repeat a lot of complexity.

> As I understand from the code, it's not called when the cgroup freed,
> but when cgroup_bpf is freed (i.e. from cgroup_bpf_release().
> It's actually very good, just has to be fixed in the description above.

Didn't realize it was different. Thanks. Will fix in v2.

> >               pl = kmalloc(sizeof(*pl), GFP_KERNEL);
> > -             if (!pl) {
> > -                     bpf_cgroup_storages_free(storage);
> > -                     return -ENOMEM;
> > -             }
>
> Hm, why -ENOMEM handling has been removed here?

oof, my oversight when undoing some refactoring. Will fix in v2.

YiFei Zhu
