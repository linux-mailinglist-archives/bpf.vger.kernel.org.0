Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994AB6742B7
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjASTXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 14:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjASTWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 14:22:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5E9F054
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 11:21:47 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw16so8274228ejc.10
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UrMNPGogqT8fLvJK/JqqSTy9TRYLyQS4tZeM/ePW8Uk=;
        b=EgNL7jw0GFsl7FBzK0EAQXeKEJuygHebTVSyb8IdZqqjIBA4foT9dT6+zDswRX2zKb
         moVTkCkRxUW6LyKg4wAvphzKN+SFMvpWFryPt491kT5KlcqV5oYOzGN1uqDHjDl1yQe8
         N/1apGwyAuY8nKnXLTLz4xjzrMNOPPUkPZPivfESray0p4yvICiKAkzpLsZPbHD1SSv+
         GHV6SHsSi26HoLaga814HXaGITyUQrsYw3KGCNrFApbSnBs32yOoh1fb1PJz4KmM9fUs
         WExGA1Ku46N6IPJGGuElDRcguB//BMhBMsbtIqQuv3wmJh+I3r16Tosk+7KUBwhaFACS
         Qdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrMNPGogqT8fLvJK/JqqSTy9TRYLyQS4tZeM/ePW8Uk=;
        b=hvk1LbpeNJEhaYmGhBJqpH5WVu/xJDGur8u/9eANyJgQevLccsgX5WNvBkdBSzOU5f
         NFTKFXNNjkjqdAprozjDtZyhX53AOF5iTLzEZrnbyFSuYILZnf6vIVnwUqSamu3LdOXo
         dD0Zicx3dfYpPMVwE52cfrmxOlAgA03TBwmgaYqyUpy3cTSd/XPI8eNa3Z6H8IUbC3og
         EFDr+H9THhhd7iLw355HvXzQqEHV3sC980z3mqheg73s/14uUDT7CeTf38NUBjF67Lgz
         OxmM2rb5tXgrnpCdUu7r0AOz7lR/xRT4EhperOwtLvf4ecr+uo3tRMphyOxOfmHxqybL
         nRhw==
X-Gm-Message-State: AFqh2ko01q5vxvMCyc++YIxkUb++lCTjQxNzhBM68a5yGzdC0qC2WIFd
        g1Inz4jGUtMRyiJmGRriAIy8ANX4VS+loWgqTo0=
X-Google-Smtp-Source: AMrXdXvNzLRV3qEYhRbS0N8XFUzSv11b/fgI8KtULkRKtgo5Dg/rKcEwstPdk2S2N4/GRYGIFkytdZSpbv0UrX/8NoE=
X-Received: by 2002:a17:906:12cd:b0:871:2c9f:f480 with SMTP id
 l13-20020a17090612cd00b008712c9ff480mr1572068ejb.502.1674156104314; Thu, 19
 Jan 2023 11:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com> <202301190848.D0543F7CE@keescook>
In-Reply-To: <202301190848.D0543F7CE@keescook>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Jan 2023 11:21:33 -0800
Message-ID: <CAADnVQK44J7AOy7vBm-uQ11phehYxieJBNM9X1N_q8ZABLqLjw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
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

On Thu, Jan 19, 2023 at 8:52 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 17, 2023 at 09:14:42PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > There are several issues with copy_from_user_nofault():
> >
> > - access_ok() is designed for user context only and for that reason
> > it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
> > and perf on ppc are calling it from irq.
> >
> > - it's missing nmi_uaccess_okay() which is a nop on all architectures
> > except x86 where it's required.
> > The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
> > Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.
> >
> > - __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
> > check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
> > which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.
>
> Er, this drops check_object_size() -- that needs to stay. The vmap area
> test in check_object_size is likely what needs fixing. It was discussed
> before:
> https://lore.kernel.org/lkml/YySML2HfqaE%2FwXBU@casper.infradead.org/

Thanks for the link.
Unfortunately all options discussed in that link won't work,
since all of them rely on in_interrupt() which will not catch the condition.
[ke]probe, bpf, perf can run after spin_lock is taken.
Like via trace_lock_release tracepoint.
It's only with lockdep=on, but still.
Or via trace_contention_begin tracepoint with lockdep=off.
check_object_size() will not execute in_interrupt().

> The only reason it was ultimately tolerable to remove the check from
> the x86-only _nmi function was because it was being used on compile-time
> sized copies.

It doesn't look to be the case.
copy_from_user_nmi() is called via __output_copy_user by perf
with run-time 'size'.

> We need to fix the vmap lookup so the checking doesn't regress --
> especially for trace, bpf, etc, where we could have much more interested
> dest/source/size combinations. :)

Well, for bpf the 'dst' is never a vmalloc area, so
is_vmalloc_addr() and later spin_lock() in check_heap_object()
won't trigger.
Also for bpf the 'dst' area is statically checked by the verifier
at program load time, so at run-time the dst pointer is
guaranteed to be valid and of correct dimensions.
So doing check_object_size() is pointless unless there is a bug
in the verifier, but if there is a bug kasan and friends
will find it sooner. The 'dst' checks are generic and
not copy_from_user_nofault() specific.

For trace, kprobe and perf would be nice to keep check_object_size()
working, of course.

What do you suggest?
I frankly don't see other options other than done in this patch,
though it's not great.
Happy to be proven otherwise.
