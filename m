Return-Path: <bpf+bounces-20274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A237F83B252
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAF51C21ECE
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD697132C28;
	Wed, 24 Jan 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nNFVA5vH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nNFVA5vH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rDkKSdo5"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4A132C20
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124815; cv=none; b=PGlshG4PR2HfPLwFogZ5zH7GIkSe82wB35Hdca4H2jDb+3/NJ1Hf6167I2Ucdx5a33WHTtBCKc7js8f061c/YwTSZl4taDNz/UCnNGi/Ra9+MFbdu8gFWruTiRPVNR3A1XYo9HsdnqXDtlG48K/pjwCoX6XfdNNOv5WttYI2TI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124815; c=relaxed/simple;
	bh=y39hW6oMK0woFOTZyubcCQwRTDXUkPVx3+sv7KA1g7o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=oOA1Vfwp+sTRug9YbCb4YYbsIm/rTYI+9Gqn6ha4RjY09ED1YU1tuP+sum6/9HFic/v31MY8fWiBifnHiL0wy0KlRhwMEdbFAKQZiT43jetzNqdDPVt6exEpdTO7VIfACapnE+jnHcL1LXDVLc7WPKQWCNjNyW71THscOpUDc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nNFVA5vH; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nNFVA5vH; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rDkKSdo5 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B174EC157927
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 11:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706124807; bh=y39hW6oMK0woFOTZyubcCQwRTDXUkPVx3+sv7KA1g7o=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=nNFVA5vHWq6XVj4XI1qqNkWP5u4I7n9BfKyBqmjBu11ceUyYY53u3oBe7tg8Ys/GC
	 tMBM+JhuN+vpAD8RFEawqjDn3FqKLmkUL038dYL7pEKLFsxpvmJpJpSFZ7O5TYyTth
	 70UUMSQM0AO6DRa7ihmmk4dIdc+tnPXYCbIEv0MU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan 24 11:33:27 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 59804C14F684;
	Wed, 24 Jan 2024 11:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706124807; bh=y39hW6oMK0woFOTZyubcCQwRTDXUkPVx3+sv7KA1g7o=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=nNFVA5vHWq6XVj4XI1qqNkWP5u4I7n9BfKyBqmjBu11ceUyYY53u3oBe7tg8Ys/GC
	 tMBM+JhuN+vpAD8RFEawqjDn3FqKLmkUL038dYL7pEKLFsxpvmJpJpSFZ7O5TYyTth
	 70UUMSQM0AO6DRa7ihmmk4dIdc+tnPXYCbIEv0MU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4E306C14F684
 for <bpf@ietfa.amsl.com>; Wed, 24 Jan 2024 11:33:25 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vSyr2BGe36kz for <bpf@ietfa.amsl.com>;
 Wed, 24 Jan 2024 11:33:21 -0800 (PST)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com
 [IPv6:2001:41d0:203:375::af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0FE04C14F5E4
 for <bpf@ietf.org>; Wed, 24 Jan 2024 11:33:20 -0800 (PST)
Message-ID: <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1706124798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWaAntcZrwvuFlRFCKqmmfca/9/tgp7D5aNFEZn3xzs=;
 b=rDkKSdo5IaNUa3Ypk12AjyEPSGnM9fFIqUgXkA+nkvGVqiMSBrWUQHfvKuakDaDoTAUEMV
 FsHYPlbWjhYGB6YYhF++qCsV/1f9+00xZG5sWrsz/x8i2fgXfZn+f0IKG9p4tgBJ9HVfKd
 Hz6syDmfcNpbUzPBAZIlmQ5PDjdF6Rw=
Date: Wed, 24 Jan 2024 11:33:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
 <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
 <095f01da48e8$611687d0$23439770$@gmail.com>
 <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev>
 <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1fc001da4e6a$2848cad0$78da6070$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/PXlnjKhq_3RkxJ85vpQ02RTthus>
Subject: Re: [Bpf] Jump instructions clarification
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


On 1/23/24 6:07 PM, dthaler1968@googlemail.com wrote:
> Hi Yonghong,
>
> The MOVSX clarification is now merged, but I just found another similar question for you
> regarding jump instructions.
>
> For BPF_CALL (same question for src=0, src=1, and src=2),
> are both BPF_JMP and BPF_JMP32 legal?  If so, is there a semantic difference?
> If not, then again I think the doc needs clarification.

BPF_CALL with BPF_JMP32 is illegal. This is true for src=0/1/2.

>
> BPF_JA's use of imm already has a note that it's BPF_JMP32 class only,
> but what about BPF_CALL's use of imm?

The imm field of BPF_CALL insn is used for call target.

>
> Similarly about comparisons like BPF_JEQ etc when BPF_K is set.
> E.g., is BPF_JEQ | BPF_K | BPF_JMP permitted?  The document currently
> has no restriction against it, but if it's permitted, the meaning is not explained.

Yes, it is permetted. It represents a 64bit reg compared to an imm.

>
> Dave
>
>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

