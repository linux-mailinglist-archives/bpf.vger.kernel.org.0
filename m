Return-Path: <bpf+bounces-41835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70EC99BD2C
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 02:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823C31F21C13
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 00:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAAFC149;
	Mon, 14 Oct 2024 00:58:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0959460;
	Mon, 14 Oct 2024 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728867494; cv=none; b=Q9TKTeSGmviACnTID3Fwun4FkyJzk/rrVJgIb+Ydrd09b/pQQIf48XfwJ1tPW5c5pL8nzBqjgntcFdvAJmiqar2kBaxGcrPhEgNcLRqPB3GG4XLZ3k8t1Y7eytCF8yM6Tllc/DQIMBF0XYDsM8H76tx+EfNF3HelARdlk8mBJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728867494; c=relaxed/simple;
	bh=nLW/y1S7JrBGqCIkIv9maJWuT00y4A1IgFRyUJmInZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mT/bq5XebaOUkAnod7KFElZoL8aiC883g6vVwSvGOBtQTOAP5PRFOvSqTWPJhWSfpYNPqk3DEXpMSQULkjrtZFg7rChaE9g1O2gYlH37xMXdVy+i7XSNbCIfOFkj4XhW52jzmDUbaAB9LQT5fteW9kpo/fq3yyZG3SNN42Btbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Eder Zulian <ezulian@redhat.com>
Cc: acme@redhat.com,  andrii@kernel.org,  ast@kernel.org,
  bpf@vger.kernel.org,  daniel@iogearbox.net,  eddyz87@gmail.com,
  haoluo@google.com,  john.fastabend@gmail.com,  jolsa@kernel.org,
  kpsingh@kernel.org,  linux-kernel@vger.kernel.org,  martin.lau@linux.dev,
  sdf@fomichev.me,  song@kernel.org,  vmalik@redhat.com,
  williams@redhat.com,  yonghong.song@linux.dev,  Michael =?utf-8?Q?Wei?=
 =?utf-8?Q?=C3=9F?=
 <michael.weiss@aisec.fraunhofer.de>
Subject: Re: [PATCH] tools/resolve_btfids: Fix 'variable' may be used
 uninitialized warnings
In-Reply-To: <Zwoub8GniNhTF1gu@f39> (Eder Zulian's message of "Sat, 12 Oct
	2024 10:08:15 +0200")
Organization: Gentoo
References: <20241011200005.1422103-1-ezulian@redhat.com>
	<87frp2yn2y.fsf@gentoo.org> <Zwoub8GniNhTF1gu@f39>
Date: Mon, 14 Oct 2024 01:58:06 +0100
Message-ID: <87iktvlcv5.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eder Zulian <ezulian@redhat.com> writes:

> Hi Sam, thank you for pointing it out.
>
> On Sat, Oct 12, 2024 at 05:14:29AM +0100, Sam James wrote:
>> The parse-options change was sent before as
>> https://lore.kernel.org/all/20240731085217.94928-1-michael.weiss@aisec.fraunhofer.de/
>
> Sorry, I missed Michael's patch.
> My suggestion is to initialize 'o' to NULL instead. An illegal dereferencing
> (if any) would then be evident.

Yeah, I was wondering the same.

>
>> but seems to have fallen through the cracks.
>> 
>> 
> Would it be better to revert this part and wait a bit for Michael's patch to
> be merged, please let me know.

I'll defer to the maintainers.

>
> Thank you,
> Eder

