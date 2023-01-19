Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79FA674380
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjASU2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 15:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjASU2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 15:28:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF219B13D
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 12:28:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s3so4388238edd.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 12:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fDD2SAL4PcT4jvQPOBEMzNrST5A+D58oCxR3L2DmskY=;
        b=G9ohQCpcvPt7VXuYHKUoXsYBDo6Up67rOx7ANaT7o/L8I7ZewbQJF86R9t9mb+TkA4
         WtfkJeYc4bHAo23BjMab675Vx0qMlUJQxr9tQhEVwQExfTP56S72SZR/bRIRVo1kJpYC
         XMfu5GVAXrxkHYzrwDrLcO3nLPO5/HidXy5xkn3QogrHT712YlDbNAgQywhMvnuIkiyx
         R+FhqbDtvC6OyW1RFhFXrCuR+KDb+hDNx9KAAnM6+ZOSVcTs5exhEkmV7v1EoidXDQEo
         AVwR3nA1wvOoVbd4LfGyKOORiYaMjfy29j5SNTc1gyzzP9j+sWxVH7rlF3jppRMEHL4z
         tdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDD2SAL4PcT4jvQPOBEMzNrST5A+D58oCxR3L2DmskY=;
        b=BCDNpVnC0B/9WWb33JBO+YM9hHtcjCdH5wuJ/HWGyH+7HqSUk+pNVrunYeVx5W2JxY
         uNWqdp2yviJYxMw5z7CltsHT0SQaWrBorAEYg5uBBpVK+2JoYh/D9ldMrO0EEGXkElzR
         CZJvnxkqY+CYe3UaW7e+PwPCJqHdXKWoRsbjVEBNA8DTWoDtD/OXAboCiaB69NMZpZfo
         Wl9GGkCKp8RkPknqxUeZXYMC9TWS1VPuKMyLF7d3rezQE2JQQepohKFeVzrTOs3SrIKs
         DvQT6Jap1yFt9ic97/HjAqLFVGi/xe9bN1ebog1B4HEIUDZkNRnFiMGN/Xrte/lXQs7B
         8/tw==
X-Gm-Message-State: AFqh2kqdNCuUeHwCgqn+xtJTXSfwCv1MPqweBNOhqF8NdRCwb25W5njP
        GfQ7vOf386SVhMe2EjkmoaKAoc675RAN3TvcQCE=
X-Google-Smtp-Source: AMrXdXsbXKEcZTY8xDwJ/g/kJ4KvtkJrUGgMNIz2/IxhbnTmSG6GkcYV2+RwxuagnY0++um21bWD2Vrw9CMFCCkumm4=
X-Received: by 2002:aa7:d29a:0:b0:49e:61:fe4d with SMTP id w26-20020aa7d29a000000b0049e0061fe4dmr1433609edq.192.1674160124272;
 Thu, 19 Jan 2023 12:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
 <202301190848.D0543F7CE@keescook> <CAADnVQK44J7AOy7vBm-uQ11phehYxieJBNM9X1N_q8ZABLqLjw@mail.gmail.com>
 <202301191204.F54F66093@keescook>
In-Reply-To: <202301191204.F54F66093@keescook>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Jan 2023 12:28:32 -0800
Message-ID: <CAADnVQK5eVTNp70Z-3Bw1Lzm5FXkZA+a6EeVBea+ytW-AwpkPQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>, dylany@meta.com,
        Rik van Riel <riel@surriel.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 12:08 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > What do you suggest?
> > I frankly don't see other options other than done in this patch,
> > though it's not great.
> > Happy to be proven otherwise.
>
> Matthew, do you have any thoughts on dealing with this? Can we use a
> counter instead of a spin lock?

Have you consider using pagefault_disabled() instead of in_interrupt()?

spin_trylock() and if (pagefault_disabled()) out ?

or
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 4c3164beacec..83c164aba6e0 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -173,7 +173,7 @@ static inline void check_heap_object(const void
*ptr, unsigned long n,
                return;
        }

-       if (is_vmalloc_addr(ptr)) {
+       if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
                struct vmap_area *area = find_vmap_area(addr);

effectively gutting that part of check for *_nofault() and *_nmi() ?
