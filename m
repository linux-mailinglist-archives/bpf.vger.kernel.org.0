Return-Path: <bpf+bounces-65288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFFB1F161
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 01:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3089CAA0AC4
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E32989A7;
	Fri,  8 Aug 2025 23:59:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CE29898B;
	Fri,  8 Aug 2025 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754697548; cv=none; b=X8dMM1a5HXjjwjR4tezN/yjBKBjMf+CWQP9TH5+xGPQWPhXQGXM0ePOOn/YUF53Tw+Dc/VrPXBr6sgnuFkJUIakq/kVnll0RsazjAQ6L4ua5byG16ayHjm+ukoPgDWb9q2VuvBYR3F/BMeTYfjYDQrwhPvUPmssuYpsKIDR6uGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754697548; c=relaxed/simple;
	bh=7JU7enJwznlWFxWoUAJgiayzSx4ipf97Ao9xvgmlKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFLKZDpBWYwtNgm+qUFfe28dW27+p6S6TPceg0KmflUHzHBt23CCXKkfdGOiBJDT/GTHz+abC1Vgqam3ZM54tYJ09CQxqs5Z9+T3m2pboKAad0JAk5I6sJIzEfZ0GXOrfeFIaC1zftfaoXPpiS/izxARusgOSPQ6LuzzOENHAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id CF467C8C; Fri,  8 Aug 2025 18:58:57 -0500 (CDT)
Date: Fri, 8 Aug 2025 18:58:57 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of
 capable(CAP_SYS_ADMIN)
Message-ID: <aJaPQZqDIcT17aAU@mail.hallyn.com>
References: <20250806143105.915748-1-omosnace@redhat.com>
 <aJP+/1VGbe1EcgKz@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJP+/1VGbe1EcgKz@mail.hallyn.com>

On Wed, Aug 06, 2025 at 08:18:55PM -0500, Serge E. Hallyn wrote:
> On Wed, Aug 06, 2025 at 04:31:05PM +0200, Ondrej Mosnacek wrote:
> > Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but instead
> > use bpf_capable(), which checks against the more granular CAP_BPF first.
> > Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spam
> > under SELinux, as privileged domains using BPF would usually only be
> > allowed CAP_BPF and not CAP_SYS_ADMIN.
> > 
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
> > Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> So this seems correct, *provided* that we consider it within the purview of
> CAP_BPF to be able to avoid clearing the branch history buffer.
> 
> I suspect that's the case, but it might warrant discussion.
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

(BTW, I'm assuming this will get pulled into a BPF tree or something, and
doesn't need to go into the capabilities tree.  Let me know if that's wrong)

> > ---
> >  arch/x86/net/bpf_jit_comp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 15672cb926fc1..2a825e5745ca1 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2591,8 +2591,7 @@ emit_jmp:
> >  			seen_exit = true;
> >  			/* Update cleanup_addr */
> >  			ctx->cleanup_addr = proglen;
> > -			if (bpf_prog_was_classic(bpf_prog) &&
> > -			    !capable(CAP_SYS_ADMIN)) {
> > +			if (bpf_prog_was_classic(bpf_prog) && !bpf_capable()) {
> >  				u8 *ip = image + addrs[i - 1];
> >  
> >  				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
> > -- 
> > 2.50.1
> > 

