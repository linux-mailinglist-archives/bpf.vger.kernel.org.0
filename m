Return-Path: <bpf+bounces-20199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A483A3E4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F28B2A567
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7C1755A;
	Wed, 24 Jan 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BZRyP3ip"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB812E63;
	Wed, 24 Jan 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084294; cv=none; b=HsIDs1UsqCCUd6ra8LCxgAPYPU2Wsx7obzio/BkQl6uos1CwsEUIZZGNIUwm3f9brU85Z2LxGIWW9a4yCVjeZqDmBSYUjN5GMNCV68P80aLWXAIpMBbcfDYKN43stU+pA36i0Rn++YUHjSf+z39CYIe0PpDF1sIFeGveeSchkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084294; c=relaxed/simple;
	bh=O3ZTw0Uu63QcFIFWBtd8xSjGz0uOj1py/D8YC1lnDs4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MfJ0pw7B9NH/X9o7aieeJESe9QqtiL9XapqLrT/CZXN9ljtUEgTpIe62D+2bzIw0c+3s1d2np5/AgpvOzahBRjs6iysxEMGVPd+PnOug6IcfwLjbT+au7RcAwlrAQlApoHYUfAAiZoad2FYhoEfys162fcXTypeOPGkexL6qoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BZRyP3ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717ACC433F1;
	Wed, 24 Jan 2024 08:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706084293;
	bh=O3ZTw0Uu63QcFIFWBtd8xSjGz0uOj1py/D8YC1lnDs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZRyP3ipRYAo2sW2HKWDQg4ihYobLxaMcfodExVoV3XgMOFGddSJDGUgVtDvC4CZB
	 qoR7HIafL6fKN9h+lLVjOvqKLLM8sCcvywZyquX4RiOl0FHbPHw6gWxRFQ3bKyhhsz
	 Df0sauMf2Z1zk58P7R/qfcvuMgL9PsV1v14Azl3E=
Date: Wed, 24 Jan 2024 00:18:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
Message-Id: <20240124001808.bfff657f089afe10e5b0824c@linux-foundation.org>
In-Reply-To: <CAADnVQKBCpkwx1HVaNy1wmHqVrekgkd4LEZm9UzqOkOBniTOyw@mail.gmail.com>
References: <20240124121605.1c4cc5bc@canb.auug.org.au>
	<CAADnVQKBCpkwx1HVaNy1wmHqVrekgkd4LEZm9UzqOkOBniTOyw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 17:18:55 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Today's linux-next merge of the bpf-next tree got a conflict in:
> >
> >   tools/testing/selftests/bpf/README.rst
> >
> > between commit:
> >
> >   0d57063bef1b ("selftests/bpf: update LLVM Phabricator links")
> >
> > from the mm-nonmm-unstable branch of the mm tree and commit:
> >
> >   f067074bafd5 ("selftests/bpf: Update LLVM Phabricator links")
> >
> > from the bpf-next tree.
> 
> Andrew,
> please drop the bpf related commit from your tree.

um, please don't cherry-pick a single patch from a multi-patch series
which I have already applied.


