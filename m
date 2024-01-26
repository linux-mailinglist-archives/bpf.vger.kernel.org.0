Return-Path: <bpf+bounces-20376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3B383D3E4
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 06:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6E8B24540
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE95BA33;
	Fri, 26 Jan 2024 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KK7xRDRR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="KK7xRDRR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eAwg1tWu"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7BBA2D
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706245957; cv=none; b=jtESuUwgqyYXrjOfRAxRp4cQUVJsxS3/6il0WI+rdmSG1NllLaR/6oFTC2D2GJRmuBKaZT7+j2S02Evz03GDLih/uhhWJu9H36RqkDRyP57gcJm5AaH+wVL/R0JWZvl/+I/3TV3sVKoG1vGykcIpZrQ0XRwwJj5dKPSzz90Gids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706245957; c=relaxed/simple;
	bh=So26aDJUZ1cDdXqYccISPZWZ9TZhGMkvnzhRdso6nWQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=H8EgQyjnWRt8Shdw8dGSL4y6uc4To6JURT3+DNpkteV67mDUCK8WOxxfXDoiOC8YBl3EiD72BPaq5Yn57UKKCD+24EDrXHnt2u8YKMXmdyVFNyc4MDBlg9heUVohdO1sRbGMKQya1jwxH3j6/nWtpoStNZqGg/SROQVRTihraoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KK7xRDRR; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=KK7xRDRR; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eAwg1tWu reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D2003C15107F
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 21:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706245953; bh=So26aDJUZ1cDdXqYccISPZWZ9TZhGMkvnzhRdso6nWQ=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=KK7xRDRRrYt+ZDoG1FUNgkm9DVlhlQnCwCbbill6j/MuhV5/NR4AMlXmZ+PfnT64B
	 jRSVcxOYZDqXCu91D21j9uWtyXoHQW1zDdcnNgvgUvsVfhNJrJmoaNEIMCLEFofFSc
	 OlXO3cgy0JV/dw67QA6/KNBnAiZvHHbCQstaIV90=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jan 25 21:12:33 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5D64BC14F703;
	Thu, 25 Jan 2024 21:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706245953; bh=So26aDJUZ1cDdXqYccISPZWZ9TZhGMkvnzhRdso6nWQ=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=KK7xRDRRrYt+ZDoG1FUNgkm9DVlhlQnCwCbbill6j/MuhV5/NR4AMlXmZ+PfnT64B
	 jRSVcxOYZDqXCu91D21j9uWtyXoHQW1zDdcnNgvgUvsVfhNJrJmoaNEIMCLEFofFSc
	 OlXO3cgy0JV/dw67QA6/KNBnAiZvHHbCQstaIV90=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 29710C14F703
 for <bpf@ietfa.amsl.com>; Thu, 25 Jan 2024 21:12:32 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApsD3khSiRKB for <bpf@ietfa.amsl.com>;
 Thu, 25 Jan 2024 21:12:28 -0800 (PST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CE569C14F6B5
 for <bpf@ietf.org>; Thu, 25 Jan 2024 21:12:27 -0800 (PST)
Message-ID: <68a15df5-dbb8-481a-812e-2b361dc2a915@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1706245944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcThGL3ya6LgHZTsllu1U6305lplcDWet/H7XFgjp2Q=;
 b=eAwg1tWumUo30cBWqH9icBru2E5Zaz9t9cIlCCyGUu8tSi8TwaWMeZP1aosUdpVVUjwT+D
 x9FEpG2gVLvxVeLbICPt/dePnRBl6ssxo8nYGSrRDKfVIh6UDHYsKvL9ajPejkqy1IbYkF
 ocAZPPmje4ItVXnEm/1AFKVlHzxFXU8=
Date: Thu, 25 Jan 2024 21:12:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240126040050.8464-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240126040050.8464-1-dthaler1968@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/iEQ-KQejLAoexIEWmwz17Ex2RZ8>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify definitions of various instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


On 1/25/24 8:00 PM, Dave Thaler wrote:
> Clarify definitions of several instructions:
> * BPF_NEG does not support BPF_X
> * BPF_CALL does not support BPF_JMP32 or BPF_X
> * BPF_EXIT does not support BPF_X
> * BPF_JA does not support BPF_X (was implied but not explicitly stated)
>
> Also fix a typo in the wide instruction figure where
> the field is actually named "opcode" not "code".
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

