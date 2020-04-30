Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF041BECE6
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 02:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgD3ANM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 20:13:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55838 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3ANM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 20:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588205591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2Zuhq9wkoTTmKJmVFQegMyeSsShX7zXR1RrdrJ3tZM=;
        b=PvTxjEuTuzYHN5UmOCQQwq671JE6le315rmOc1ns4P5iwNACVntvyGdpVBk8qvVBY2Psnw
        VM+a4uZOqYq929ljrzzMGqLeMZZL7NPUUUQ1wkK43Yt6U3bWcP7oEURqHkwo69z07650bm
        a0dch0L0BYp2szpcS3/5yopsbtmJfTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-BDaNqZLONMuApgCNw_ceug-1; Wed, 29 Apr 2020 20:13:07 -0400
X-MC-Unique: BDaNqZLONMuApgCNw_ceug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71779801503;
        Thu, 30 Apr 2020 00:13:05 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2609066071;
        Thu, 30 Apr 2020 00:13:03 +0000 (UTC)
Date:   Wed, 29 Apr 2020 19:13:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
        daniel@iogearbox.net
Subject: Re: BPF vs objtool again
Message-ID: <20200430001300.k3pgq2minrowstbs@treble>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
 <20200429215159.eah6ksnxq6g5adpx@treble>
 <20200429234159.gid6ht74qqmlpuz7@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429234159.gid6ht74qqmlpuz7@ast-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 04:41:59PM -0700, Alexei Starovoitov wrote:
> On Wed, Apr 29, 2020 at 04:51:59PM -0500, Josh Poimboeuf wrote:
> > On Thu, Jul 18, 2019 at 12:14:08PM -0700, tip-bot for Josh Poimboeuf wrote:
> > > Commit-ID:  3193c0836f203a91bef96d88c64cccf0be090d9c
> > > Gitweb:     https://git.kernel.org/tip/3193c0836f203a91bef96d88c64cccf0be090d9c
> > > Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > AuthorDate: Wed, 17 Jul 2019 20:36:45 -0500
> > > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > > CommitDate: Thu, 18 Jul 2019 21:01:06 +0200
> > > 
> > > bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> > 
> > For some reason, this
> > 
> >   __attribute__((optimize("-fno-gcse")))
> > 
> > is disabling frame pointers in ___bpf_prog_run().  If you compile with
> > CONFIG_FRAME_POINTER it'll show something like:
> > 
> >   kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7: call without frame pointer save/setup
> 
> you mean it started to disable frame pointers from some version of gcc?
> It wasn't doing this before, since objtool wasn't complaining, right?
> Sounds like gcc bug?

I actually think this warning has been around for a while.  I just only
recently looked at it.  I don't think anything changed in GCC, it's just
that almost nobody uses CONFIG_FRAME_POINTER, so it wasn't really
noticed.

> > Also, since GCC 9.1, the GCC docs say "The optimize attribute should be
> > used for debugging purposes only. It is not suitable in production
> > code."  That doesn't sound too promising.
> > 
> > So it seems like this commit should be reverted. But then we're back to
> > objtool being broken again in the RETPOLINE=n case, which means no ORC
> > coverage in this function.  (See above commit for the details)
> > 
> > Some ideas:
> > 
> > - Skip objtool checking of that func/file (at least for RETPOLINE=n) --
> >   but then it won't have ORC coverage.
> > 
> > - Get rid of the "double goto" in ___bpf_prog_run(), which simplifies it
> >   enough for objtool to understand -- but then the text explodes for
> >   RETPOLINE=y.
> 
> How that will look like?
> That could be the best option.

For example:

#define GOTO    ({ goto *jumptable[insn->code]; })

and then replace all 'goto select_insn' with 'GOTO;'

The problem is that with RETPOLINE=y, the function text size grows from
5k to 7k, because for each of the 160+ retpoline JMPs, GCC (stupidly)
reloads the jump table register into a scratch register.

> > - Add -fno-gfcse to the Makefile for kernel/bpf/core.c -- but then that
> >   affects the optimization of other functions in the file.  However I
> >   don't think the impact is significant.
> > 
> > - Move ___bpf_prog_run() to its own file with the -fno-gfcse flag.  I'm
> >   thinking this could be the least bad option.  Alexei?
> 
> I think it would be easier to move some of the hot path
> functions out of core.c instead.
> Like *ksym*, BPF_CALL*, bpf_jit*, bpf_prog*.
> I think resulting churn will be less.
> imo it's more important to keep git blame history for interpreter
> than for the other funcs.
> Sounds like it's a fix that needs to be sent for the next RC ?
> Please send a patch for bpf tree then.

I can make a patch, what file would you recommend moving those hot path
functions to?

-- 
Josh

