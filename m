Return-Path: <bpf+bounces-22499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549E85FB44
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 15:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42E628298D
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2616F1474D9;
	Thu, 22 Feb 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fiD/qEvG"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C751419A4;
	Thu, 22 Feb 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612245; cv=none; b=IOzC09oY5NFJ1NI31/CEH81jPRiTXYtDYSPHbPRBsNV0KqyTw3t0UrBgwdoHNIaYojQWoDHkQoZ2mbLpX6CXNLaw8A2BIS2KOcVHopvjme1CUfv3QtIL16l25kqxfXiNBCwFnxbBlvePp76Rx/GVY2PjgHHa0QgUcdIYnhY0/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612245; c=relaxed/simple;
	bh=nxjQUdXk7S2lmsMK8aB4RVIkX7mSD1W9J2LYzAAH85c=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=Gkm1UwCruX243JD2OEPoxjdOEvlxJMfbzuGrXh0vvmEy6cTuUPvlEmpj3TH25+jv0mwtA3NLMtCphUqtbpwFQNfFFDFKvfDUHXoaT0jQQppRY8o/tiUbHZROp5BqhSWKz538gmRivxojWv8zv+yK3wJc6KDf7sIVybxugmIPUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fiD/qEvG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	In-Reply-To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nxjQUdXk7S2lmsMK8aB4RVIkX7mSD1W9J2LYzAAH85c=; b=fiD/qEvGeWB112sXG43dv1IwZZ
	q1XYT5THH3N47FXCfYjhtvj3OmdIYvarK/F2ag/PTayABLw2gZ5zAErHOc9DvNj02C8ypaKI1Cn/2
	Q6GROwK8E/twY0q+T/oJH8/+R8gKX3TVtGxnNKFwhjR2n6JBF5c3Z1AcA/IwVNcoO1KJq6WK38EJv
	7AnvBprs6MA04srJ4+sD0Z9bnclWnDYfwMc/wTc3JdNNMgEIliq4o2X3Q0osYCYkc/gHKjQs1giUg
	6uZM7UfXA+w+hjNtyZRL7myZke2XJwx9mN4P9eHBlbtWJi/gD2xCQTsCIqWlDdtgcGHa+++O0gxHn
	iKR49bkw==;
Received: from [179.232.147.2] (helo=[192.168.0.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rdA59-002L0n-19; Thu, 22 Feb 2024 15:29:51 +0100
Message-ID: <c4c422ac-d017-9944-7d03-76ad416b19a4@igalia.com>
Date: Thu, 22 Feb 2024 11:29:43 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
In-Reply-To: <87r0jwquhv.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Cc: jannh@google.com, daniel@iogearbox.net, ast@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 john.fastabend@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 "luto@kernel.org" <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas et.al,

I've been testing some syzkaller reports and found 2 other bugs that are
fixed by this patch (see other report at [0]).

So, is there anything we could do in order to get it properly submitted
/ merged? Lemme know if I can help in anything, I could submit it myself
if you prefer, keeping you as author and adding the tested tags.
BTW, feel free to add:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>


Thanks,

Guilherme


[0] One is internal and the other I already mailed in:
https://lore.kernel.org/lkml/66cb411b-557a-6a70-57c9-457c969fec24@igalia.com/

