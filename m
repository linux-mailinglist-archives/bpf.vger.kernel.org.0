Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552041BEF5F
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 06:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD3EnW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 00:43:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57268 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbgD3EnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 00:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588221800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5n4gtXTehbFEMm9+vNyemjrQTYFiG9C1+7VDPD2ZDM=;
        b=IMBroTwGUtmQmZKi/XHboKgMFYzKClflZaLB6VAAZ87Q2LneKPC7TZtIpBJhQlUcpFTnbm
        /JiGOfY1pU6tD2HG4vLeBhMGQqPl5kcDy2/giX9Z/gsE7ulVwPa8+qMl81caACipRLbQcD
        ll0mlms3Qt0v5LcOtdf5Mhu5VS0q3Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-u5tkPwroN5-ug1W3-b0i_w-1; Thu, 30 Apr 2020 00:43:15 -0400
X-MC-Unique: u5tkPwroN5-ug1W3-b0i_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9C9C18FF660;
        Thu, 30 Apr 2020 04:43:13 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C815EDE0;
        Thu, 30 Apr 2020 04:43:11 +0000 (UTC)
Date:   Wed, 29 Apr 2020 23:43:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
        daniel@iogearbox.net
Subject: Re: BPF vs objtool again
Message-ID: <20200430044308.kkniqb7pnpn4bovg@treble>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
 <20200429215159.eah6ksnxq6g5adpx@treble>
 <20200429234159.gid6ht74qqmlpuz7@ast-mbp.dhcp.thefacebook.com>
 <20200430001300.k3pgq2minrowstbs@treble>
 <20200430021052.k47qzm63kpcn32pg@ast-mbp.dhcp.thefacebook.com>
 <20200430035315.tc74v5twfdxv2goh@treble>
 <20200430042400.45vvqx4ocwwogp3j@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430042400.45vvqx4ocwwogp3j@ast-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 09:24:00PM -0700, Alexei Starovoitov wrote:
> > This would actually be contingent on RETPOLINE, not FRAME_POINTER.
> > 
> > (FRAME_POINTER was the other issue with the "optimize" attribute, which
> > we're reverting so it'll no longer be a problem.)
> > 
> > So if you're not concerned about the retpoline text growth, it could be
> > as simple as:
> > 
> > #define CONT     ({ insn++; goto *jumptable[insn->code]; })
> > #define CONT_JMP ({ insn++; goto *jumptable[insn->code]; })
> > 
> > 
> > Or, if you wanted to avoid the text growth, it could be:
> > 
> > #ifdef CONFIG_RETPOLINE
> 
> I'm a bit lost. So objtool is fine with the asm when retpoline is on?

Yeah, it's confusing... this has been quite an adventure with GCC.

Objtool is fine with the RETPOLINE double goto.  It's only the
!RETPOLINE double goto which is the problem, because that triggers
more GCC weirdness (see 3193c0836f20).

> Then pls do:
> #if defined(CONFIG_RETPOLINE) || !defined(CONFIG_X86)
> 
> since there is no need to mess with other archs.

Getting rid of select_insn altogether would make the code a lot simpler,
but it's your call.  I'll make a patch soon.

-- 
Josh

