Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A182A3B6728
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhF1RCc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhF1RCb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 13:02:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E3C061574
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 10:00:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o5so6081675ejy.7
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tpNLlkV7PduQWJO+xCtsTXHTLroZH/P2xHcJ+aV5RWc=;
        b=j91KJw6vzWpkwYzmtcEDBxN1COEK56f7xPNOjIsW9ckyrPi172cxRwba5DyjvZ0KNL
         zir4Kbl5Jk44XUxjWPqWaHyk8RFoG6WNMR3ItpAWIqnu8jY5jX6XUMdFsKLwIRioE16l
         tS6TkiwJgrqjZqTXa7B421fQ4g0niPr/sn1Sxyj6K+TPwihX5zY6hLDjRwbGYSqWqaCc
         zQGj2pDsPBxQUZAKWmkUuSDrZ44oXgTakCCnU/IDiyC+jdS5roIbfFC4p4zdmOP2qQX9
         5kdjdKrmiMFsJJsrWEL11t1EouTYtKcy9g19UdfVSUEhEjhB3rooYIRbQsv7haCBfFKM
         8gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tpNLlkV7PduQWJO+xCtsTXHTLroZH/P2xHcJ+aV5RWc=;
        b=jNyYFQFPjwf8NVwjMDABg8Yzyl3hjItG4x9hRRZmx5knZvhRbYs5k1vmMeuNyT22f5
         CKVkmIrmZT1rsiEWuV9kGf7teCTu6U2mxfVHY9XwP+E/Pi8B9fnJwBYVYu1b9WvDTost
         p4yaw5nHdwvNo+Pmykt987QCPkUpCCTUp/XK/anoh/XIHhK4ggU4Pz6zxhRSU90Xq7Y8
         wL+eMd0n5f0zTIIvl59wlxJysdPASiWFZIFVV1NQbzoB14TKFIemMpig3iKoUy7GNeV1
         HYi4dAu7E1vWMxAt45F7diy5EKym9FmQldxnXj+oBtL96TKuMKuaDXNiBtrXJtraRpmb
         0/gQ==
X-Gm-Message-State: AOAM532lY1khoHhWh8Mrl/JZX0r969c2U2Ciy5V81Uhvh05YSV7hAk48
        vx51JID5dO0WIiZVPBA+Ay5NrvykTRmkvwOahUMR
X-Google-Smtp-Source: ABdhPJwCqO0IvyFhpi9rtv+6Pm/vYovP0kyHgemo7IK4TgpDbTD5jfRmX8jt0pH7AnqpsoRDyRAG36C9VaqV8YuO2vc=
X-Received: by 2002:a17:906:abc6:: with SMTP id kq6mr475812ejb.91.1624899604129;
 Mon, 28 Jun 2021 10:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
In-Reply-To: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jun 2021 12:59:53 -0400
Message-ID: <CAHC9VhSTb75NEPZRm+Tkngv=SW8ntmSpVCrXMHHHWc2qYNZqCA@mail.gmail.com>
Subject: Re: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 28, 2021 at 9:25 AM Thomas Wei=C3=9Fschuh <linux@weissschuh.net=
> wrote:
>
> Hi everyone,
>
> there does not seem to be a way to access the AUDIT_ARCH_ constant that m=
atches
> the currently visible syscall numbers (__NR_...) from the kernel uapi hea=
ders.

Looking at Linus' current tree I see the AUDIT_ARCH_* defines in
include/uapi/linux/audit.h; looking on my system right now I see the
defines in /usr/include/linux/audit.h.  What kernel repository and
distribution are you using?

> Questions:
>
> Is it really necessary to validate the arch value when syscall numbers ar=
e
> already target-specific?
> (If not, should this be added to the docs?)

Checking the arch/ABI value is important so that you can ensure that
you are using the syscall number in the proper context.  For example,
look at the access(2) syscall: it is undefined on some ABIs and can
take either a value of 20, 21, or 33 depending on the arch/ABI.
Unfortunately this is rather common.

Checking the arch/ABI value is also handy if you want to quickly
disallow certain ABIs on a system that supports multiple ABI, e.g.
disabling 32-bit x86 on a 64-bit x86_64 system.

> Would it make sense to expose the audit arch matching the syscall numbers=
 in
> the uapi headers?

Yes, which is why the existing headers do so ;)  If you don't see the
header files I mentioned above, it may be worth checking your kernel
source repository and your distribution's installed kernel header
files.

--=20
paul moore
www.paul-moore.com
