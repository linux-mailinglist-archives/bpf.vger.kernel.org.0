Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF11377278
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhEHOmp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 May 2021 10:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhEHOmo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 May 2021 10:42:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E02861057;
        Sat,  8 May 2021 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620484902;
        bh=BfD8EGeWghfBZ+pVItr/slgBUaFTI6OrxXcMxGIcHrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SznXgKwsVmqPZEIcEW0BAOPYRWlZUTiONIkf5Fa2NmvS/8rUNbrzu+VdJgw51oNP1
         Z7HSO7ivW8eMc2mfKoapv7G5v8XuiRQejDxJ6kQViA3JZl3A6dGn5k+qi+TgUV48PL
         zxorbNNRyZZDs6vvY55CeIuqJNJmfdm+nGh39PypO+pdU10KJ+hpiCMwsJikgfHFgT
         +qtlHmd/H7x4SjdgYzbSuRYjE8/wLWnJAF1XjlxwZh9EkBudZzRfWF/KSg1/oFgn4b
         YSSfLuc+dQZTSwXePH8SKCaRLzaBDV2KqG/FgehlrIyXW7bANUqzgsY0BL1PJxVsVE
         WCtLYn741jhOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C208C4034C; Sat,  8 May 2021 11:41:39 -0300 (-03)
Date:   Sat, 8 May 2021 11:41:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        kernel-team@fb.com, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 dwarves] btf: Remove ftrace filter
Message-ID: <YJajI/hrfQZ0+6SZ@kernel.org>
References: <20210506205622.3663956-1-kafai@fb.com>
 <YJUY+OvPLWwpj6oA@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJUY+OvPLWwpj6oA@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, May 07, 2021 at 12:39:52PM +0200, Jiri Olsa escreveu:
> On Thu, May 06, 2021 at 01:56:22PM -0700, Martin KaFai Lau wrote:
> > BTF is currently generated for functions that are in ftrace list
> > or extern.
> > 
> > A recent use case also needs BTF generated for functions included in
> > allowlist.  In particular, the kernel
> > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > allows bpf program to directly call a few tcp cc kernel functions. Those
> > kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> > is set to ensure they are in the ftrace list but this kconfig dependency
> > is unnecessary.
> > 
> > Those kernel functions are specified under an ELF section .BTF_ids.
> > There was an earlier attempt [0] to add another filter for the functions in
> > the .BTF_ids section.  That discussion concluded that the ftrace filter
> > should be removed instead.
> > 
> > This patch is to remove the ftrace filter and its related functions.
> > 
> > Number of BTF FUNC with and without is_ftrace_func():
> > My kconfig in x86: 40643 vs 46225
> > Jiri reported on arm: 25022 vs 55812
> > 
> > [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> > 
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> > v2: Remove sym_sec_idx, last_idx, and sh. (Jiri Olsa)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

