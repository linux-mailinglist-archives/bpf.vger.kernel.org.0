Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37DA345369
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 00:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCVX5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 19:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhCVX4b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 19:56:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CFD0619A3;
        Mon, 22 Mar 2021 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616457391;
        bh=soSkArAMiHCjRrnwH6krgASp/2Xva6v9HjBY9VQ+krI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JjylmhYSMLaSWmGhNoFlvnf5gkMo/7e3QuDrEw0Hq5jpB8C+PovK2WPZAMqpIZHBm
         TroGrZcZP0vGW6R8d2D0/yNrqAwAKuvi/A1l52iRdGOAP52Ya5yFEG5yUlHZkqR0Zf
         5RIU/lzMehYnjlAHRk1ss3+NNhN6/5VODUpDt/oCBImTzIc5R0viVaEfsUFDbESa3y
         np2vCcm8rPFgjYgF3utsi9lF0yjA7iCevKVGJeOMeqbNG2zEcx01QhKpW8tcuZT1Bi
         MH2q7tlX+Q8/dvn2nXAdEYo1EOKVxozd6k7PEnkind0fgSD1R3GHoTahkQWCPXIcFX
         IfgM+aHcEUD2w==
Date:   Tue, 23 Mar 2021 08:56:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 12/12] tracing: Show kretprobe unknown indicator
 only for kretprobe_trampoline
Message-Id: <20210323085626.111af4e087b4f8e35fff2e8d@kernel.org>
In-Reply-To: <20210322111142.748e90da@gandalf.local.home>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639532235.895304.18329540036405219298.stgit@devnote2>
        <20210322111142.748e90da@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Steve,

On Mon, 22 Mar 2021 11:11:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 22 Mar 2021 15:42:02 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > ftrace shows "[unknown/kretprobe'd]" indicator all addresses in the
> > kretprobe_trampoline, but the modified address by kretprobe should
> > be only kretprobe_trampoline+0.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thank you for the Ack!

> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
