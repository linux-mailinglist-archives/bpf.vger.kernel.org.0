Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067127B40E
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2019 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfG3UL2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jul 2019 16:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfG3UL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jul 2019 16:11:28 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF0C8205F4
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 20:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564517487;
        bh=o3uLRMoj7ksCO+PSZelBEDrocrNeF1FSTchgLTFdhYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QOGVRGx3yojDnXj1M55fGKT7kULYKRB5K6sdoXLtgAnmMB3Z3T93Qw/88wtrsHi6T
         +LQIvOgVaMPhcG5M9YEPFs4L0I5U7YUczFpxzdudeY58c2vPDPqbNnzy9gpuxsSwlH
         86Tn9vt6lcYEYqwIoeJdgsn9zyuLmisyUQnXlnKI=
Received: by mail-wr1-f51.google.com with SMTP id r1so67090420wrl.7
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 13:11:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUlCstNRAY2XGfjv7fCPr9IZREIG76WOLM7DiOakOZcWyynhrMz
        cTHWWxMAnYMcXwMfgfNDdA12AFnv0KEOq9DsPYoBuA==
X-Google-Smtp-Source: APXvYqwyDtaFObbPjjDDbJdP+2pzuEcS5CPcMP/HTePjfEOLnBFjOXGFrvdwjdCxxXR8kZAToJO4b+06MbOQtduYfho=
X-Received: by 2002:adf:cf02:: with SMTP id o2mr109682923wrj.352.1564517485465;
 Tue, 30 Jul 2019 13:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAC+a-TbieGvrwqaLz+VPgMhafH-3O5yrqY12EKKa-wZ1YxzxSw@mail.gmail.com>
In-Reply-To: <CAC+a-TbieGvrwqaLz+VPgMhafH-3O5yrqY12EKKa-wZ1YxzxSw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 30 Jul 2019 13:11:14 -0700
X-Gmail-Original-Message-ID: <CALCETrU=HaRhxNiw3hbguN988Dk__5kOZ2SXmO944VAYuUw=Gg@mail.gmail.com>
Message-ID: <CALCETrU=HaRhxNiw3hbguN988Dk__5kOZ2SXmO944VAYuUw=Gg@mail.gmail.com>
Subject: Re: [RFC] seccomp: add CLOEXEC flag
To:     Baojun Wang <wangbj@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 30, 2019 at 10:49 AM Baojun Wang <wangbj@gmail.com> wrote:
>
> This patch add a new flag *SECCOMP_FILTER_FLAG_CLOEXEC*
>
> (CLOEXEC, 1 << 4ul) to seccomp syscall. When the flag is set, filter

One problem here is that you're removing all filters installed after
the CLOEXEC one, too.  That's no good.  I suppose you could prevent
loading of non-CLOEXEC filters if any are CLOEXEC.  The naming of
CLOEXEC is no good, too.

But you haven't really justified this very well.  What are you doing
that involves filtering on PC, and how is it secure at all?
