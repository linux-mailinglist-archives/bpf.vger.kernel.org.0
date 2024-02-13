Return-Path: <bpf+bounces-21816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587618526E7
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9991C24EC7
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467A2FB6;
	Tue, 13 Feb 2024 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FVKp/Pu6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="b3dtH/Ps";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IMcaxr2K"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428B1385
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 01:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787168; cv=none; b=esUWJoRJc1iho8LRe2sfhtaCcF27/Ms0b11H0h63GW7rDzLwZdrkwDbqTuA9/5+88+T3RKeJdgLzBCScFhcSq571CT3x5B4tTt6n1WP9aSez7pNpokCHvOD7FMTZ0BsFYLp0K8jCxe7TG1kyD7ywF5hINnY5Xp0U+zIseqLuMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787168; c=relaxed/simple;
	bh=AmfdaYtNSWyR3zI0pWTdqZifAexTYNFzvaFM8zWMc/k=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=mVm28rDJ8JVgqYLooum6Ukz86nsl7GFTsvMycA/U7IUumyHXr+TtDOBgRCgesOjQhiWU+DmB//YystDVAf9sBy1rTuICsAU4IUMtOtSUtV3TH0V5KzNb3vCiEY5zNI+woE6rUSho0051kqUHAKyNKqHDC3ef4CwOxPL0BPV0D8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=FVKp/Pu6; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=b3dtH/Ps reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IMcaxr2K reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EBC0FC19ECBB
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 17:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707787134; bh=AmfdaYtNSWyR3zI0pWTdqZifAexTYNFzvaFM8zWMc/k=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FVKp/Pu6ZiJThPxP61WvKZRPZqvpbL6slw4Gh1bhHrGbsHvXCdGGEJ/nNBglMitfV
	 x/1muOdDHUq88Lf6qogzUfgwjITuVzxExwHkuRIkmYZvHLFmVykGUDgSAzkc3RBvZ5
	 JrtBuM1jXQWfkg+GhVlSFQjppOlc4xdNG/EInWUM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id CA4B5C18DB92;
 Mon, 12 Feb 2024 17:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707787134; bh=AmfdaYtNSWyR3zI0pWTdqZifAexTYNFzvaFM8zWMc/k=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=b3dtH/PsIuS4y5LdTIVdMFA+qtQwUXE0DF+daI2XlZDIzjOoZ9wTPccZlsjtP68oB
 CrikWky7OPaB76oVNkrJ8zyBV2soV29As5ro2Mt2JCi/eapweh97kjYizi6Nf8tg9v
 UoRePeAyu2Ojn3ObzlJXqQkPtnPcXZ6tC6wjpAF0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D65C0C18DB92
 for <bpf@ietfa.amsl.com>; Mon, 12 Feb 2024 17:18:53 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8tetiKY2a4F for <bpf@ietfa.amsl.com>;
 Mon, 12 Feb 2024 17:18:50 -0800 (PST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6532EC18DB89
 for <bpf@ietf.org>; Mon, 12 Feb 2024 17:18:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6da6b0eb2d4so2755067b3a.1
 for <bpf@ietf.org>; Mon, 12 Feb 2024 17:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707787110; x=1708391910; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=r/iL9hk9z65BlWcihXx6WQ/ZeCAECR3zF2bC+FtSh4c=;
 b=IMcaxr2KH/PozPfIrT1R/VAvwtoAEBa2vOeceXgeoRK6oGWozKa0rZSbrGr/7uHpoR
 B4t1bfylaN7BGvKxL0l3vqIv3uMH1KVN5nGyW3AoKkNc9gLR+ZzPuYd558u6P90VDHcA
 C0w8Z55JyXtPm3INKYJvG5eUbC8idTgti7fxUwRWBqC6+8Ad+wbChPro4qtSNha4ARaf
 kliCfDoAv4PoBOrmG7N1tPfw9bkdvD5qa0G7DNBeZRppJVWHDI/ntPGQiYUrr2QcDtoy
 QWamSOVE6wqtRCFQK4vmVfHMY4nhoQnpRmUwVWAZwBhyXGJQ6uMXiGZ6XPG0I8lEoBQT
 5CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707787110; x=1708391910;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/iL9hk9z65BlWcihXx6WQ/ZeCAECR3zF2bC+FtSh4c=;
 b=wddgwHYWPDfIl6o23J5AGOeSGZ7DVGabgGnOQVkAKd8Cv+ETBeXK4HE3clG+DeZS9B
 wfGIhJowT6Qc7R2Ycc9Mf7o2ZoaHR07RnmOQRhpvnkv0uczczzBWA7qfTBqgtGir2XvX
 7NKdbsttkcEgsitUNcUc/WulkaPmyBtsyVmr5b7LSJWcmDUTTWiZqyssDKBHUuFF3mrB
 nOT0ZttR6VLGu/JsrP+IYXqeA/G7YDQRZrWfNgBYRRUxfhOSP3GYrqXmxt0/TJUOX7Im
 KB5NgFmgDCctaqmZdthC/XDni9EyTStOTScGcr5/HOInc6KNFtlnNioexRGSjkB/3u12
 /mvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/yRv2iXtT55Qg3KZyqNf3J5FR6CYKRItBMuAmjbKVQ+9KJvU1Hkcnelg7CjcQuBMiehykNS/ksw3d6VM=
X-Gm-Message-State: AOJu0Yz1jpBo9SW/R0/1FFGx8dSzz4n4LOJ8xFZpQ9D3vWjym+rSGiao
 W0akGu4TPariShiJqNqGkIjHx9dg+WLemXh+PEVIIoCh4dG5QCp6k0RavFM6QoU=
X-Google-Smtp-Source: AGHT+IHsjdMXpUH31e+aKErlxkbLoYrBL9hMng63nigj5d/ZtUOaFvXsf00AfWfVTcPMeEzG/buJEQ==
X-Received: by 2002:aa7:8557:0:b0:6d9:b941:dbf5 with SMTP id
 y23-20020aa78557000000b006d9b941dbf5mr7120874pfn.11.1707787110538; 
 Mon, 12 Feb 2024 17:18:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV6siuus/c8HjoUW/4yK2KePDSVjB+bW40vpXQ6kB16ljjH1qBwaPmH1EvkBRsL7UoX/0xMsnHf4eRVnm+d/oL075MV+Z+SL/Fbop/WriCIV1m1vEgrMw==
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 b18-20020aa78712000000b006dfbecb5027sm6341097pfo.171.2024.02.12.17.18.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Feb 2024 17:18:30 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>,
 "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240212211310.8282-1-dthaler1968@gmail.com>
 <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev>
 <036301da5dfd$be7d1b30$3b775190$@gmail.com>
 <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
In-Reply-To: <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
Date: Mon, 12 Feb 2024 17:18:27 -0800
Message-ID: <03a801da5e1a$8d0274c0$a7075e40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKk5nBwvPPKgL8m8zzpY/2G4YK4bQLYE4TWAif8DTYBtYA5rwFjf1HurzGcgzA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-5tFHqBcpJRQc4XQ7uZNjTfsw4E>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf,
 docs: Add callx instructions in new conformance group
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Monday, February 12, 2024 2:49 PM
> To: dthaler1968@googlemail.com; 'Jose E. Marchesi'
> <jose.marchesi@oracle.com>; 'Dave Thaler'
> <dthaler1968=40googlemail.com@dmarc.ietf.org>
> Cc: bpf@vger.kernel.org; bpf@ietf.org
> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new
> conformance group
> 
> 
> On 2/12/24 1:52 PM, dthaler1968@googlemail.com wrote:
> >> -----Original Message-----
> >> From: Yonghong Song <yonghong.song@linux.dev>
> >> Sent: Monday, February 12, 2024 1:49 PM
> >> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
> >> <dthaler1968=40googlemail.com@dmarc.ietf.org>
> >> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
> >> <dthaler1968@gmail.com>
> >> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx
> >> instructions in new conformance group
> >>
> >>
> >> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
> >>>> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X
> >> only, see `Program-local functions`_
> >>> If the instruction requires a register operand, why not using one of
> >>> the register fields?  Is there any reason for not doing that?
> >> Talked to Alexei and we think using dst_reg for the register for
> >> callx insn is better. I will craft a llvm patch for this today. Thanks!
> > Why dst_reg instead of src_reg?
> > BPF_X is supposed to mean use src_reg.
> 
> Let us use dst_reg. Currently, for BPF_K, we have src_reg for a bunch of flags
> (pseudo call, kfunc call, etc.). So for BPF_X, let us preserve this property as
> well in case in the future we will introduce variants for callx.

Ah yes, that makes sense.

> The following is the llvm diff:
> 
> https://github.com/llvm/llvm-project/pull/81546

Which llvm release is it targeted for?
18.1.0-rc3? 18.1.1?  later?

> > But this thread is about reserving/documenting the existing practice,
> > since anyone trying to use it would run into interop issues because
> > of existing clang.   Should we document both and list one as deprecated?
> 
> I think just documenting the new encoding is good enough. But other
> people can chime in just in case that I missed something.

Ok.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

