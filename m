Return-Path: <bpf+bounces-65251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AEB1E102
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 05:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D724580A23
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 03:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930A192598;
	Fri,  8 Aug 2025 03:33:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0CDDAD;
	Fri,  8 Aug 2025 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754624001; cv=none; b=A8G3I0vzwRbJvWbyXtmZ/IM8JmpV3jktTsQ05SFwYRzlsjEhdNwcaryjJtrcF+7sXx8eSNrkScYtpjTfT4xfM4gkCjueQx4ZA1ncoh/CcvQi5dyh4F0nGJdO/se13sAJw/292Y5Yu8rLQIHCYNcohlVG8cWuVkX3+j29d5jmz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754624001; c=relaxed/simple;
	bh=vF8pT6+G+uxqekVGBiVYrOEFy6YYP30BUiS+ENg30j4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=bPCztNRohZJfu3W2B5n1r8/d2K9HxqGx0U8zyKy1Iig1BSkoQnaS8vAh3+KbmRTLBHKLBBk7d2PLAwBMJ8+taMD6mcmvcz/ypyrdEu2YjuXUUAmXwX4ig62WXVapYnCQRAPx3+lqgxhadplXIAXpOUchkdtxtrYyrT8c+5FbqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 0DB3C340DC4;
	Fri, 08 Aug 2025 03:33:16 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: arnaldo.melo@gmail.com
Cc: alan.maguire@oracle.com,alexei.starovoitov@gmail.com,andrii@kernel.org,bpf@vger.kernel.org,dwarves@vger.kernel.org,jolsa@kernel.org,jose.marchesi@oracle.com,kcarcia@redhat.com,namhyung@kernel.org,nick.alcock@oracle.com,williams@redhat.com,yonghong.song@linux.dev
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
In-Reply-To: <7F061596-C814-42DA-AD6A-F766B21A188A@gmail.com>
Organization: Gentoo
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Fri, 08 Aug 2025 04:33:14 +0100
Message-ID: <87a54azdvp.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

FWIW, as a source-based distro, we'd love to have BTF-only be quite
cheap, because right now, having DWARF makes it challenging for us to
enable it by default as users build on a range of different hardware and
the increased size of the unstripped vmlinux binary plus build-time
requirements doesn't make it worth it.

(Not every distro is building once and shipping to many and has the
luxury of stripping out components ;))

Thanks for working on this.

