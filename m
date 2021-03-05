Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D053232F3F3
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCETdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 14:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230141AbhCETc4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 14:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614972775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzFUlmEwerGb1otgAwUz4uvPmsIdAWjstYZ2iDVwDbo=;
        b=UvfIXrBfriXI4YjojfhH7OgeOVmVLS2cCd7bep6x310ohNAdHPeAAOPKCjiNn0E/+bt1rT
        dU5IHsA0j4MIuiKWh4oxxVxDXGBSIqXHUFUBY5IDSkzArUtZWarmJlipFuF52QY+xdvZc8
        1uhVacYDB6ZsMz0g/YjocKVEVjYuXwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-QUCO94aoNBaBZDyW2FovUA-1; Fri, 05 Mar 2021 14:32:51 -0500
X-MC-Unique: QUCO94aoNBaBZDyW2FovUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E29E28143F0;
        Fri,  5 Mar 2021 19:32:49 +0000 (UTC)
Received: from treble (ovpn-116-51.rdu2.redhat.com [10.10.116.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F37E760843;
        Fri,  5 Mar 2021 19:32:46 +0000 (UTC)
Date:   Fri, 5 Mar 2021 13:32:44 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        kuba@kernel.org, ast@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH] x86: kprobes: orc: Fix ORC walks in kretprobes
Message-ID: <20210305193244.odtphdj5wm5cslf7@treble>
References: <d72c62498ea0514e7b81a3eab5e8c1671137b9a0.1614902828.git.dxu@dxuuu.xyz>
 <20210305182806.df403dec398875c2c1b2c62d@kernel.org>
 <20210305195809.a9784ecf0b321c14fd18d247@kernel.org>
 <20210305192515.6utyhm5kks4zexwn@maharaja.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305192515.6utyhm5kks4zexwn@maharaja.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 05, 2021 at 11:25:15AM -0800, Daniel Xu wrote:
> > BTW, is this a regression? or CONFIG_UNWINDER_ORC has this issue before?
> > It seems that the above commit just changed the default unwinder. This means
> > OCR stack unwinder has this bug before that commit.
> 
> I see your point -- I suppose it depends on point of view. Viewed from
> userspace, a change in kernel defaults means that one kernel worked and
> the next one didn't -- all without the user doing anything. Consider it
> from the POV of a typical linux user who just takes whatever the distro
> gives them and doesn't compile their own kernels.
> 
> From the kernel point of view, you're also right. ORC didn't regress, it
> was always broken for this particular use case. But as a primarily
> userspace developer, I would consider this a kernel regression.

Either way, if the bug has always existed in the ORC unwinder, the Fixes
tag needs to reference the original ORC commit:

  Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")

That makes it possible for stable kernels to identify the source of the
bug and corresponding fix.  Many people used the ORC unwinder before it
became the default.

-- 
Josh

