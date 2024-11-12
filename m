Return-Path: <bpf+bounces-44658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C5E9C5E8B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 18:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A471F21404
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA920ADCA;
	Tue, 12 Nov 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="xHriHSn1"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABF20B1EE
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431429; cv=none; b=B1zNcLa71uepWNUZl0Uy7dqD2s16UVmYyaqyjtRoXlliqs/ak5C2d6YNMC7W8OIcvllHyS1egTlRS+8yPa9ZUabgtcQJb/UYqKWoiv1P4HY+cjrI2qQjJSjBs+94IWOX7GFubkS5/9h5ffR1tfxpifjV/cBb44OXKu/o81HUufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431429; c=relaxed/simple;
	bh=kOmo1FnMFxjV3ZIVYchh0kAPzPFvBAAazRV0XeJUrLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DW/+Vhl5Qcaf+66HDaCx3eoEcRiVtuWQHQLrLtsSN9zoIIAvaqyIU0YFAEIuGGcOJ0+Eh7/M7HXvrT1USrK3yRLpATmozd4NHurnbuRuzinY/bUcwFt0FN0Z3E0TDm98IVMnClPtseFhhoxrimc9edo187Wbe9fQwSb5zl4OJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=xHriHSn1; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (unknown [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4Xnt516mBDz7k;
	Tue, 12 Nov 2024 17:02:29 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4Xnt502z2ZzCN;
	Tue, 12 Nov 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=xHriHSn1;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1731430948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWedFxQ7Gn9h9gdmF0K89yIYoy48kqZVjkWy2fPmORo=;
	b=xHriHSn1gXo2vwr+tADzLUtzmr3IfmchsYQKDYGQdapJSirAb24miRfojWG7BgNutgSgus
	sE+9DkqxeeXDe6cLV/9KKHZbvK+Fsu6uZm+MDKDAU24EBGoeExmDhQqYJ9YjSHj4xkaIbf
	rGN+O0u0pQDRp74TpOVn12xIDxhw5cX6snJG42mZETDUV+iVZtcZeT7x80ohhCwSJlHBtt
	pKPQ1Rknos/32uTqtQF1kzOjGyjhMlEmd3QO/4rnvd6nCmcJnaQ4tE21UaRmOcfbgypa8i
	sYKxAiC0B088v4hceCAedDPcl+7t+W6r3UeApAKwl5cl0les9UYGVVKiZDFZ5g==
Message-ID: <f7d33c8a-5693-4a64-91ae-1c3a13cedcb8@qmon.net>
Date: Tue, 12 Nov 2024 17:02:27 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpftool: Set srctree correctly when not building out
 of source tree
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: bpf@vger.kernel.org
References: <20241111140305.832808-1-daan.j.demeyer@gmail.com>
 <1319dcc5-979b-43d5-8737-ae7716648937@qmon.net>
 <CAO8sHcmpfR-2S15HVNwxqjRZZXViny9bXX4sNxAAU_yRsvK97g@mail.gmail.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <CAO8sHcmpfR-2S15HVNwxqjRZZXViny9bXX4sNxAAU_yRsvK97g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2024-11-12 12:02 UTC+0100 ~ Daan De Meyer <daan.j.demeyer@gmail.com>
>> My understanding of the check on building_out_of_srctree in
>> tools/bpf/Makefile (from commit 55d554f5d140's description) is that it
>> fixes the build from "make TARGETS=bpf kselftest", not from "make -C
>> tools/bpf".
> 
>> Trying again "make ARCH=x86 -C tools/bpf/bpftool bootstrap" at the root
>> of the Linux repo, not building out-of-tree, this works fine for me,
>> without the need for your patch. I'm trying to understand what you
>> setup is and what creates the failure that you observe (and that I can't
>> reproduce), so I'd like more context if possible. Are you just running
>> that command from the root of the tree? If that's the case, what values
>> do you observe for $(srctree) and $(building_out_of_srctree) when
>> entering bpftool's Makefile?
> 
> I do the same thing and I get this error, srctree is set to ".". I have no clue
> what's different about my environment that would cause this error. This is
> a Fedora Rawhide image and I'm using the master branch from Linus's repo
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git)


Hi Daan,

I'm sorry I still don't manage to reproduce. I installed a VM with a
Rawhide image (Fedora-Workstation-Live-x86_64-Rawhide-20241112.n.0.iso),
I installed packages elfutils-libelf-devel, gcc, and make in it, I
cloned Linus' repo, and ran the same command as you did (make ARCH=x86
-C tools/bpf/bpftool bootstrap), and this works well for me.

	test@localhost-live:~/linux$ lsb_release -a
	LSB Version:	n/a
	Distributor ID:	Fedora
	Description:	Fedora Linux 42 (Workstation Edition Prerelease)
	Release:	42
	Codename:	n/a
	test@localhost-live:~/linux$ uname -r
	6.12.0-0.rc7.58.fc42.x86_64

$(srctree) appears to be empty in my case. Have you tried tracing it
(and $(building_out_of_srctree)) with -p to see where it's set in your case?

Quentin

