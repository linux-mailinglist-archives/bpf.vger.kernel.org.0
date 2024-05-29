Return-Path: <bpf+bounces-30828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072AC8D3408
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA649285AE9
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77FC17A937;
	Wed, 29 May 2024 10:08:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3917A91B
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977323; cv=none; b=B9zwZStp47t94JMvNCdwJKsdyHSDPfvF/4kBBNbWYz75GaAtjJH1p6xPMTtiq8vfOd4ANtkw8q6+x/YZTJ1DdbvPWeelfKL5z0vBEfgIYmLPmZ/970tqBES1dCm1oGCpW4Y6m7oHeRhT3B1+oItZq8rb6qRqeKDtyqTzfnumtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977323; c=relaxed/simple;
	bh=ampteQmrcMx+8uxdaZhD7lBBGBuEYvsKE2M2/gYYz1I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XgpCIvZMVbZsaUIYcC//aEmBgeblbMLmfCCSfRn9dTVJICmW7soq+xatBHqnlqy06Yx0nobTs4PxwF6tSH0rTk+bKz15i4WDt9SWcczAhzJm0EY0nRoo/47MHnXfiaHrhFlTV9GD3uNkqlijssuN9j4HQYVJgOW5kQTeiEmW+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.net; spf=pass smtp.mailfrom=0pointer.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.net
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 812E2E801B0
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 12:08:37 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id CC717160185; Wed, 29 May 2024 12:08:36 +0200 (CEST)
Date: Wed, 29 May 2024 12:08:34 +0200
From: Lennart Poettering <mzxreary@0pointer.net>
To: bpf@vger.kernel.org
Subject: bpf kernel code leaks internal error codes to userspace
Message-ID: <Zlb-ojvGgdGZRvR8@gardel-login>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

It seems that the bpf code in the kernel sometimes leaks
kernel-internal error codes, i.e. those from include/linux/errno.h
into userspace (as opposed to those from
include/uapi/asm-generic/errno.h which are public userspace facing
API).

According to the comments from that internal header file: "These
should never be seen by user programs."

Specifically, this is about ENOTSUPP, which userspace simply cannot
handle, there's no error 524 defined in glibc or anywhere else.

We ran into this in systemd recently:

https://github.com/systemd/systemd/issues/32170#issuecomment-2076928761

(a google search reveals others were hit by this too)

We commited a work-around for this for now:

https://github.com/systemd/systemd/pull/33067

But it really sucks to work around this in userspace, this is a kernel
internal definition after all, conflicting with userspace (where
ENOTSUPP is just an alias for EOPNOTSUPP), hence not really fixable.

ENOSUPP is kinda useless anyway, since EOPNOTSUPP is pretty much
equally expressive, and something userspace can actually handle.

Various kernel subsystems have been fixed over the years in similar
situations. For example:

https://patchwork.kernel.org/project/linux-wireless/patch/20231211085121.3841b71c867d.Idf2ad01d9dfe8d6d6c352bf02deb06e49701ad1d@changeid/

or

https://patchwork.kernel.org/project/linux-media/patch/af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org/

or

https://patchwork.ozlabs.org/project/linux-mtd/patch/20231129064311.272422-1-acelan.kao@canonical.com/

I think BPF should really fix that, too.

Or if you insist on leaking internals to userspace then please move
the definition to the public "uapi" headers, but yikes you are in for
some pain then given the conflicting userspace definitions.

Lennart

