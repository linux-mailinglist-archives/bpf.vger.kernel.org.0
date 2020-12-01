Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04852C952E
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgLAC2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 21:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLAC2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 21:28:39 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5CC0613CF
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 18:27:58 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e13so62728pfj.3
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 18:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xFk9OGTzFPy1uHmECCRNoN6xfY5KTkQFqgWfvgcbHB8=;
        b=oYEbJUAHfwZP13Zw0/eIWowbpQv5T59yBTPldjWLEX9sIhajDd4y8fOidrDohN7XgF
         GhPj6qsT+PdMss6FTvirlawyDiICo/yzmVDW2xGFjKcEqMKNrLxBtZJzF90UKfS2jAr7
         UWMDEQdM9ItojOQBs+aGNw4C2Pq2Ig+u5Bj2byHFZRDL/e8cm5Lo5hPCyFLLXOl9MV3r
         99OY4MY5yNgfuwh9r/xzIwBekMDPQzZ9CFveECaMW2AxHPkNrN49Q9veJhkLntYXFMp0
         JcyquAfc01RDA/dtMbBGhRqpEgR8PiDzpBc+LIQfqnMWwftP4wQ4EISNADajnaSzkg+K
         BtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xFk9OGTzFPy1uHmECCRNoN6xfY5KTkQFqgWfvgcbHB8=;
        b=hxHpIaaLVbjsfFoh7xwJM0d/2pQwFr6SaQoBy/i1tJb/ZjN3cwwYGNTQQaqVI7Ow7G
         4BAzxlbObPEtGaj6QhKwzS/5pMdyueFilu4JhGl4Rl6IZR0zxRYOCIXKIsmaXKXhMcSS
         G29RdB+nRUX1/CvIQaNhZLLGOlUzpCwtGUEA7S+8Hn5zH+v0OfwQxMPaX1cG1+oiYld8
         bQ25MixyR0nngUszjNdfDCMJ83a/OCA+Cpl7VYlPVdPnKX5ulIpN9ZW6YHvChzr2UCGW
         IXPJBmXaJZdvXovG5olqR3G2rQmSL/jTbbKGEmSr8pl1xc0sPclpa//AKo1XZa5+gbBD
         mEeA==
X-Gm-Message-State: AOAM532LomfQQebCsy3Jf4saaXJqbB/YKBPtueX/XV8a1WUs4DOwQXhN
        iD/BrgS7zLf+idrGNEOR5JcZ75ntW08=
X-Google-Smtp-Source: ABdhPJx4WxaLw5gR5jgNwRP/UmSnvkdztlblpB1lnfb1RdHuKfyQJrZGeTn0aEdz+AFThBQXy6kRxw==
X-Received: by 2002:aa7:978e:0:b029:197:df97:d103 with SMTP id o14-20020aa7978e0000b0290197df97d103mr442335pfp.9.1606789678443;
        Mon, 30 Nov 2020 18:27:58 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:42ca])
        by smtp.gmail.com with ESMTPSA id b14sm412185pgj.9.2020.11.30.18.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:27:56 -0800 (PST)
Date:   Mon, 30 Nov 2020 18:27:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Markus Ongyerth <bpf@ongy.net>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: HELP: bpf_probe_user_write for registers
Message-ID: <20201201022755.puubc7u3kbepanig@ast-mbp>
References: <eea9673f-5ee4-4adc-bc64-fcc88f715cc8@www.fastmail.com>
 <CAADnVQ+2DiSH42cSjQ2fNEEc217c6C+SPEqSEzBJb22aZdm3kA@mail.gmail.com>
 <3bb48133-2853-41fd-9bc4-8ea7c6d5bd5b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb48133-2853-41fd-9bc4-8ea7c6d5bd5b@www.fastmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 05:33:27AM +0100, Markus Ongyerth wrote:
> On Sun, Nov 29, 2020, at 23:22, Alexei Starovoitov wrote:
> > On Sun, Nov 29, 2020 at 10:38 AM Markus Ongyerth <bpf@ongy.net> wrote:
> > >
> > > Hi,
> > >
> > > I've been looking into introspecting and possibly convincing an application to behave slightly different with bpf measures.
> > >
> > > I found `bpf_probe_user_write` but as far as I can tell, that only works for memory areas.
> > > Is there an alternative that can be used on registers as well?
> > 
> > fyi bpf_probe_write_user() warns in dmesg.
> I've seen the note about that. I don't really mind, since it's not spammy but once when the code is loaded.
> > That was done on purpose to avoid usage of this helper in production code.
> > A new helper can be added to adjust user regs, but it will have similar warning.
> > It's better to discuss the use case first.
> > Do you envision user regs to be changed after uprobe in an arbitrary location
> > or in some fixed place and only particular regs?
> My current usecase needs to be able to set PT_REGS_PARM2 and PT_REG_PARM4 I think in specific function entry uprobes to modify an argument usually passed in a register by ABI.
> And that's what I'd use for playing around with things in general I think. Arbitrary registers at arbitrary points sounds like fund but also way more dangerous.

The uprobe can tap anywhere. Are you using USDT in such user space process?
In other words does user process expect to be altered this way?
In the past folks proposed an idea of user space tracepoints like USDT, but
with less overhead. uprobe is quite slow to use in production for anything
other than debugging.
If we could add static_jump-like construct for user space to use and let
kernel enable that jump that will do a syscall into kernel then we can
allow bpf prog change syscall args and return arbitrary stuff back.
Sort-of like USDT semaphore but without uprobe trap.
This way user space will have predefined points in the code where it
can expect changes to the flow of the code and data.

On the other side hacking user's pt_regs from uprobe isn't such a big deal,
since we allow probe_write_user already. If you can prepare a patch I think
it has a good chance to land.
