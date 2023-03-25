Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B856E6C9090
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 20:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCYTrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCYTrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 15:47:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109F8E
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 12:47:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so20817265edc.3
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679773648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veto2fG+9ZdDqmDvwBNZzPNG8teefqy0p5JG5yEfaa4=;
        b=Kbvoye7qX+9+bLDdQXQHWtE9VVYUlIuYjMkiONrqoB2rIVlfsWHqMjZBfuYriqkrJe
         DLcvzS06z4H1qs72x8plTmYC1ReQEim4gk+I/y8Yh4MFBqWhrIlfBvnvdh1IN0xoKO39
         /Dn3iq78JgmF/XAUEz5dQPfvJwj3dMZbEqYSU5h+CxSJPXu1vgZtt+mGfGRF9UZZ1EXx
         Xl8gsulpgcxidLmgSC7CC1Ic8wOboADZF8Yc45euPk8lLaFpd2VcYx4b10/1PMhoj7A+
         hPHqHKycW9Xttzfavh8JdKnlXQJK7S/RJNI51PYJ8G084QEtPRntENz/11uNarf+hRqx
         6thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679773648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Veto2fG+9ZdDqmDvwBNZzPNG8teefqy0p5JG5yEfaa4=;
        b=q3OT+WErPgE/V89DN+nTEaJ5dV0EoOiKjf+2C/mgjySK8PFB7Pe9aMu3EUsq8K2ZTj
         qOlAEhbh71Y4ZAkHvf3AfxYbRG7OevyhSUda/rTYso8WcDjB2zfFeJ1vIv5ywKimv7jU
         TiG32nHCt0EBaEamZN7wVA6T2xUYZ0CUuQxhynpYlZl8qR3o4/sEz3qCD8I4kEoHJUTD
         igAaNSe3lgNlfUZTRp1XjktLwRA9CbviAkpt6b3qMpSRuFQ04+gCq47x2tnvByN9NJAp
         e67zAyUmkPgDhY/Sium7LqjRHjlHWuKWN98R+Of69qGi1pcWxbruKHnrsqI/BlH9rRuU
         Vv/g==
X-Gm-Message-State: AAQBX9cRGDOjZhDz5IFPVCWRxTLvAJPbosEITpOxXolLk/IMuK7EWgtO
        E0YUNiRwk0uJMX21u1eOIYX2pECGziqmwdKroQk=
X-Google-Smtp-Source: AKy350Yk9naOpUa+cur9vFNsANXlfl6lgTprY8TQpXYC8Z4SD8bvCYJxKpE0p22Vhxvm3FJ95J71aXIBEoCQHdja7Fc=
X-Received: by 2002:a17:907:f90:b0:924:32b2:e3d1 with SMTP id
 kb16-20020a1709070f9000b0092432b2e3d1mr3430992ejc.3.1679773648310; Sat, 25
 Mar 2023 12:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com> <ZB8LX/BKPgvzfvcm@der-flo.net>
In-Reply-To: <ZB8LX/BKPgvzfvcm@der-flo.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 25 Mar 2023 12:47:17 -0700
Message-ID: <CAADnVQKyRpg=-uxCH6eNxPfvUCS8tKSe-AV-1304rRdTYxG1JQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
To:     Florian Lehner <dev@der-flo.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Rik van Riel <riel@surriel.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 7:55=E2=80=AFAM Florian Lehner <dev@der-flo.net> wr=
ote:
>
> With this patch applied on top of bpf/bpf-next (55fbae05) the system no l=
onger runs into a total freeze as reported in https://bugs.debian.org/cgi-b=
in/bugreport.cgi?bug=3D1033398.
>
> Tested-by: Florian Lehner <dev@der-flo.net>

Thanks for testing and for bumping the thread.
The fix slipped through the cracks.

Looking at the stack trace in bugzilla the patch set
should indeed fix the issue, since the kernel is deadlocking on:
copy_from_user_nofault -> check_object_size -> find_vmap_area -> spin_lock

I'm travelling this and next week, so if you can take over
the whole patch set and roll in the tweak that was proposed back in January=
:

-       if (is_vmalloc_addr(ptr)) {
+       if (is_vmalloc_addr(ptr) && !pagefault_disabled())

and respin for the bpf tree our group maintainers can review and apply
while I'm travelling.
