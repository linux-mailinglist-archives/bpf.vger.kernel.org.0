Return-Path: <bpf+bounces-43111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BA59AF574
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729B9B2132A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA72218327;
	Thu, 24 Oct 2024 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB4tAGSz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5818784C
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809273; cv=none; b=ZwUds6f0nJaXmKWfsZOgnhwynOxGDp8etl1EcQNFsnOPuGNEnbdO/tkM46el6o6eTr9BY5ldW2aadYUGrY5t0nOwWEEzHJ8qnfVxGspsP+GeAEnZkx/2XniFU/HeC7Lh0Ihl0j1tBONPqA6EIgLOE4JZqBlm3HOkMOgAydjyBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809273; c=relaxed/simple;
	bh=RbP/C4/eEs5P5HRhNTGHEFumeKcWC+W9WDzLszV5Jl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQlVR/LQgEbQPXgNGOLCFDu3FFwcKqKuklJVtn7XOXitghF+M204RRuUfn8YTvkheB8zG6NSw7gWh5voVi9+7VTsefNDRc1E6NGwYlSVqwru4nntEPBnc8hkWn1IVdy5hdKuLayrFdmq30vh/9Jr+BollUJtzm8MPYRkaFnI2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB4tAGSz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caccadbeeso13768885ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729809271; x=1730414071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RbP/C4/eEs5P5HRhNTGHEFumeKcWC+W9WDzLszV5Jl8=;
        b=CB4tAGSzSeBRtWV5Sc/l0Bk/uX3CJHuYA7OiJ5emNAKyeBaqhHKkx9zHwtmgG8WPew
         xpOMtEQVNXc1p83FlZ+uniM1EZwTWo7R5LAJ1pyaJHKiB2G1caq47/IfeqRkqL/6MD/v
         Z1KhykzLBwoGX87cYD6y+ukB30CHGUrcFL4/habZgSXb06Gg3njhgG3jvHVyhGmehFJV
         Z5r0fX++xZFEw695bRhTecN2LQ3j5/NDYACjSf1XWOjJbrsw9OxC52QzRlESwjS+i49Z
         pjvwK9lLoYHVlEk0ItD0kZ+D7pb5lVr5FKUoaWYqlM2WAU+FxrKb7IpLbn2ukNVM4EGm
         dPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729809271; x=1730414071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbP/C4/eEs5P5HRhNTGHEFumeKcWC+W9WDzLszV5Jl8=;
        b=J7uVzXq9jo5j7IrH03Bo5W3Yf/Yn73sZYcSyMGVrmjNVeRxXeTuc0yXA2O29b0NA4B
         M/j8m46lE2emKKHpo7hZ8ty+SzhXC3GyyHw9DlMl8DBZeikUpRFkCkG+vGtAYCNmEVqy
         N1r3KLm4GSMG/11LgI2vybVMV8JsRkgGvJvls7gBqqLZw/9T3Fymy2vkaEs7NroxYE1b
         SiY9sk90ZRq863Qam5iLq3tYpDd1YB7LAWRziEHucCsscRf7QdNwrxtJz+XaV2Jvx/F0
         Ik6VhCqwVb+OzcKGCo2S+8QyX8WU57q0hv1clkklSKPMqeR1rc2jsGdf1uTroaILpUii
         eLPw==
X-Forwarded-Encrypted: i=1; AJvYcCWBbVd9yEZmJylui9eE8h3NogNWa6eXqirpF6u5ZEcmkVj82j3ly7X0UNAWecIzApIdaoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6r7jSx6RcqMpKgbu6RBVdfbj1TXlLn/ENkN8oMW8FbaQGMpQS
	5fMfLVRAuDOUzy50qILNb3FyJD784dOwGgRMk9Z3Mjk46g9/VUrm
X-Google-Smtp-Source: AGHT+IG/AvQuVg93ceKR4a79ujm+tTb/YAgxEBp0+3zsusXFHwM2D1ySbu+PfB+XMmk2oL0Dr52/WQ==
X-Received: by 2002:a17:903:1c9:b0:20b:a6f5:2768 with SMTP id d9443c01a7336-20fa9de91ccmr94738635ad.10.1729809270638;
        Thu, 24 Oct 2024 15:34:30 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eeedc25sm76750515ad.25.2024.10.24.15.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:34:30 -0700 (PDT)
Message-ID: <86e152e9008a66a84694cb7f57a3588eeb33cf03.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,  Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, X86 ML <x86@kernel.org>, bpf
 <bpf@vger.kernel.org>
Date: Thu, 24 Oct 2024 15:34:25 -0700
In-Reply-To: <CAADnVQKApKc=UBftjUuRVSpB9nb12fxmAM=3RviQvwF1umt21A@mail.gmail.com>
References: <20241024205113.762622-1-vadfed@meta.com>
	 <CAADnVQJnM5uu-Nu-okWTwDvbPQjiYTcVrX0mmP-JUhVOFxWDVw@mail.gmail.com>
	 <3f6d2d9c7699a0bfcd245149502ed1c8945ac334.camel@gmail.com>
	 <CAADnVQKApKc=UBftjUuRVSpB9nb12fxmAM=3RviQvwF1umt21A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 15:28 -0700, Alexei Starovoitov wrote:

[...]

> > call->imm is BTF id, call->off is ID of the BTF itself.
>=20
> it's actually offset in fd_array

Sure.

> > I asked Vadim to add this check to make sure that imm points to the
> > kernel BTF.
>=20
> makes sense.
>=20
> is_fastcall_kfunc_call(&meta) && meta.btf =3D=3D btf_vmlinux && ..
>=20
> would have been much more obvious.

Yes, this one looks better.


