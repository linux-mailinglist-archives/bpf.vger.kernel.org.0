Return-Path: <bpf+bounces-40270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B9E984B4C
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB491F24356
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADA1ABED1;
	Tue, 24 Sep 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2YXe5oq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358E40BF2
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203620; cv=none; b=BWWg8GpJmDAui1D5nSGkuTLyFc4o/4AC33sKeSF4R8RCKxMswusYGp13uYCzVhUH831ZNnPglOPmv1dVoNKo0bEPM4JWRIm+jNMbwkdiatdE9ln1Qk1wm7MSdbgq55EK3WUCpYsRYUVFmnf+s6Fvogis5bZcV86WT8Ex03LUftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203620; c=relaxed/simple;
	bh=/Ak/F3R9Hlir0mzzsbBr5DIdsrGxwI863f1+JGzEeRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVGCdF7a3q6QRkVQwGTIombXTVX1qevXTba0F+isaUUUlepNh+aa6QD18R9287ApvTPoqV4dBG51OP6fzAW5QCx+/E1S6rjLQ8HR0xZdLs5rar5r8RHxKvm9PGY/OPzZQKWcZGB+qwOWSgb5yaB43KiUJV/AdJObgAFGq6gBi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2YXe5oq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so141094a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727203618; x=1727808418; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Ak/F3R9Hlir0mzzsbBr5DIdsrGxwI863f1+JGzEeRE=;
        b=F2YXe5oqdic4aVAjsLTZ40fFrsVsCroTmhGL56D54d2QXLKV84NRcxf5oLSnX2xmMD
         +7j3oOcZIdrmyAfyuXxI1x754lwwd0IIIzJylno5+xjxIYz6Cu2v8apjFBWr1fGElLRQ
         0buGIu4nLYcBzjDydHAIxLTnY52/k27vi7swDUdH/XNzVLPfAet5H6L+JSwQNzKTzATY
         mqKR+8jEKvgN9Y5zd7tZyw7MesP0oMvMwvpchVUGfx5NU2FlowMI/AJUqSPTLKCZLkfv
         UZMjaZngNm4BhJKn4W5eTzvu+hPUt9uSmRbLyXDf2EtVSOv74aRkqJcCDBnIVSvUFGtZ
         +hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203618; x=1727808418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ak/F3R9Hlir0mzzsbBr5DIdsrGxwI863f1+JGzEeRE=;
        b=iBeqhSmvT841u9H9eogEPop32lxVNGLUlyqTRDmSicqqjK3G18w/pF/eEUd4s797dI
         iwDHK4Y+ic6h4OrPlBigbuz+2fP2Xoqj/wFmBAu89btFLUbwuALLL+bF3IzDNPHgWkGh
         PblGyQRx0O+Zig9fvON9Ayb9s8pMoom9pMpz+JhRGHF7S7YS9QzyTahAltKa18OHmpGn
         fNWqcONx3ryBlRFqhBRM2Z/TlkZZzzQOFxezo8qylX7WbCekBXMxprI5CrzNog07QfvO
         YghoPdurpApzRzfzEraTbAfjZpQn+svV2l37gxmf9yUpnhHNnoGvTdA2inl7eqTkvwsW
         u/xQ==
X-Gm-Message-State: AOJu0YyltyoHO3T9WvG76PeJKu+zJjgQ8ltWIMNUVn80Y2a71G+Eul0+
	Ez1YxkoKv42kqJ33DPBzWOyZM1aSzNGxZkyxxfNEkA8cgsW9V5yy
X-Google-Smtp-Source: AGHT+IHdlEbsNCPMK8ySr2LzTtm0C3ndlCeZ9qbGZ2w07yv9KIoK6dl9Wvi0OYEL473fgfJEheRhOQ==
X-Received: by 2002:a17:90b:4d0e:b0:2d8:ea11:b2db with SMTP id 98e67ed59e1d1-2e06ac38577mr281665a91.16.1727203618190;
        Tue, 24 Sep 2024 11:46:58 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0590070b1sm1876119a91.42.2024.09.24.11.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 11:46:57 -0700 (PDT)
Message-ID: <e297f72671a67181cceee29698b9aeeefc8c7014.camel@gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: lonial con <kongln9170@gmail.com>
Cc: bpf@vger.kernel.org
Date: Tue, 24 Sep 2024 11:46:53 -0700
In-Reply-To: <CAH6SPwg9z6rXsvN0MgCj4tnGy8Fny_Lk_S0JPS98LrTORzNydw@mail.gmail.com>
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
	 <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
	 <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
	 <62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com>
	 <CAH6SPwjoACNcNBWCjYauSMYCFOUAys10uH-xM6mF8_Q79D0Yow@mail.gmail.com>
	 <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
	 <7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com>
	 <e90b14ef01cc49b790b2b7a6dca19e873e47c671.camel@gmail.com>
	 <CAH6SPwg9z6rXsvN0MgCj4tnGy8Fny_Lk_S0JPS98LrTORzNydw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 21:40 +0800, lonial con wrote:
> Hi Eduard,
>=20
> Sorry, I was on vacation recently and didn't reply to emails in time.
> Could you please submit this patch directly? Because I am on vacation
> and don't have my computer with me.

Sure, thanks again for the fix.
Have a good vacation.


