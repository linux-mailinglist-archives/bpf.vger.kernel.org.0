Return-Path: <bpf+bounces-68641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043BB7EA15
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4364635B8
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CE2E040F;
	Wed, 17 Sep 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE079AoI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F7243376
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096175; cv=none; b=FeZYWYMBCD/TnLup2I8q2BLxMG3g8S5D3lVmlaX23AADrllRTdPIwaTWfuUFeDYbexKkqiVQgIqAPnHha/D8dpgtjhVsOesecZHhkaukHdmJpFEO0ViOMlO3IE+bQx2b4xjx6lzb70OM249qC1GUb86pvkSxdQ30/oWU3cnjKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096175; c=relaxed/simple;
	bh=ocaNKw7mCjEQFbMgokio3GLRiKmU4eRQV0Sv5KNm1Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RilD2+kRi/zT9WYQW7kkxdtXUX/P/uo2T0AvQhywnxXPTP7MvcbSiYNJTNpMteA+KK6ybr1SkBbI3NoHhKrK6cglPCDnAtSoVPffs5xnNOkGgaMIr6zS0wQHsp9GMnG7eb2A6sOiI2c7T4OUTGMTrWt6hR8n5OrpRAFex6mjg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE079AoI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecbcc16948so976702f8f.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758096171; x=1758700971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbt8vK1CPUI846a4id2FrMvcZ1f0gwEQTK2+0e16PaY=;
        b=VE079AoIslh9ydGsY36s2C2zQ9rfOU9lBfcfFxPAiZli2Pm5RkySxvyqj2JvkcZPjh
         z5ca2Q9Vzit6CCkwYE8BBkfhXtb5W5/5jo6fC5kgIPtVs9BIXi6MwREhk44cUTg+Ialp
         cSyinonSJ18eSVG/Q1dEISGki6A7OW1gkokOm4mvgu2IKWBpfcHUOYnncsmuE0EU73AB
         qT8lh/Vua0kOnKo6M/nrkPYa5yRXgdYeqsWv1PLe8iy9hWjxk7bCeB7wXUb0GgIEK9xC
         XliP4o7PbNFn/Lv2D/O9Ke9WdWdPzT9oSZ4rMTuHEDheJzkg1wVSlysCMgKBBP6u84qU
         mZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096171; x=1758700971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbt8vK1CPUI846a4id2FrMvcZ1f0gwEQTK2+0e16PaY=;
        b=gvUTeARUGIsUjQEtmiOv2VUQ+2zM3cSy17Z+Mly/G3pgPPh9ex9UFgswaoe0Obn3rC
         B/yggGXPp1rvEgn2AeGBoIqA7Cdzs9oG/Bwmg2D1SxH1BKI4EfylPjJ+mQ1Ki+FBYieB
         MLOgrFg0EUQVBzk4TgaKJ5C2r5q//9bnsBRzbZfvHI41+Xm8pVSavA1gH+co/jXYz4hF
         0m4YRJd/iGjeSGlwXGPEfQbFiSzPIaPFS7Qclcu5ZV3VFMFGfvg5ngJtqDvVlU4Jjk3k
         YMfsWO6oSq1A97TpHdV/prhaO4HckGJGeGzVY3g8eOofulZXaJoAkdZcGvIT7Db8yhpX
         vivw==
X-Gm-Message-State: AOJu0YwpPBk60k0NU3617thco7umqOltvUFePb/voll0+lou2nTQm39E
	+JP9NjxG5zYWbT2lCfM8ONrzm0HrJoPqiZEW60uUv2kqAGhD1IDz6dPbZbm2e1JW
X-Gm-Gg: ASbGncv+v0qtiE5geCky93loSizMZ3lGkPB4kF/OTdoQ0qsR7qGAr/1KOZueMoRxAN6
	wypnwxriUkLUsGSshnU4acgvbuuqgGd9vsx3q99ANiyXwDfDsfN3iWfaMp4q3VUM7Q67KeOBQa0
	oxq+VMZVoNOT8BFMRL1TuHCHFNt+1xx+Gmbbu2yfD6li57/8GkwSYQKjnSgdNmT9X79CxJDFPp0
	DCjA2hRnDZmYaP9b5UHGpl/P30a6x2+zTMRh+IXwUVma1bnLu/aFCzJ3+gRwOdgObNpDCqUaTNP
	zVOPiTwAigzEB3Gb3h98tFMUhjcpGwlfN2Y68cNfSpZPpsrskGt+W5mSoVCCBRV64qdWHsAk4GG
	G5TsdKWCHqopsh163y/pEUySketVBY4BQohjMwFrwjZXfrlFWarzwmPzMjsNs4GaPlUU7Iwh6DX
	OkQByp+lDjDfUpV84js3dj
X-Google-Smtp-Source: AGHT+IEdklxhYE/jWOO+CNejd2jgls3vERrniXiSBTGUU3IMTRoAYFhZSplzEloI4QgxKD4rbKfFIA==
X-Received: by 2002:a5d:5d87:0:b0:3cc:8d94:1108 with SMTP id ffacd0b85a97d-3ecdf9fff9cmr1236299f8f.22.1758096171301;
        Wed, 17 Sep 2025 01:02:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6fdfecb9884ca93.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6fd:fecb:9884:ca93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e86602a7d5sm17176687f8f.62.2025.09.17.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:02:50 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:02:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf 1/3] bpf: Explicitly check accesses to bpf_sock_addr
Message-ID: <aMprJytP58ODMcVL@mail.gmail.com>
References: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
 <f746dce74aeb5de06fc25905523becccb88c55d9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f746dce74aeb5de06fc25905523becccb88c55d9.camel@gmail.com>

On Tue, Sep 16, 2025 at 03:45:51PM -0700, Eduard Zingerman wrote:
> On Tue, 2025-09-16 at 17:17 +0200, Paul Chaignon wrote:
> > Syzkaller found a kernel warning on the following sock_addr program:
> > 
> >     0: r0 = 0
> >     1: r2 = *(u32 *)(r1 +60)
> >     2: exit
> > 
> > which triggers:
> > 
> >     verifier bug: error during ctx access conversion (0)
> > 
> > This is happening because offset 60 in bpf_sock_addr corresponds to an
> > implicit padding of 4 bytes, right after msg_src_ip4. Access to this
> > padding isn't rejected in sock_addr_is_valid_access and it thus later
> > fails to convert the access.
> > 
> > This patch fixes it by explicitly checking the various fields of
> > bpf_sock_addr in sock_addr_is_valid_access.
> > 
> > I checked the other ctx structures and is_valid_access functions and
> > didn't find any other similar cases. Other cases of (properly handled)
> > padding are covered in new tests in a subsequent patch.
> > 
> > Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> > Reported-by: syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=136ca59d411f92e821b7
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> 
> Double checked other context types with holes and paddings:
> - bpf_sk_lookup
> - bpf_sock
> - __sk_buff
> - sk_reuseport_md
> 
> And agree with Paul's conclusion.
> (Note, however, that bpf_sock and __sk_buff explicitly refer to
>  padding offsets).

Thanks for double checking! I think I had missed sk_reuseport_md when
going through those. I had also forgotten the test case for bpf_sock.
I added both as selftests in the v2.

> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

