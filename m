Return-Path: <bpf+bounces-40017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D920497AC66
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CC81F23374
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271C014C59B;
	Tue, 17 Sep 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN4EVBTF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E732364BE;
	Tue, 17 Sep 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559448; cv=none; b=AvU7DnMUduyn13dNBycbeW/mduxuYUXX9HXtibnYeG++HVDweyyRHY7kz6NvWovDHA8BazpoW02RO4tbH6eCfwJm4aHwX0xstkZiUt1gXqC336028eIpFntRb4jhhk7HOMEqlSb2/OpII4rQ6MnHKYM641+qvIaC5MmAQZehF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559448; c=relaxed/simple;
	bh=mfRmvv+PNnCjZMTbsOm1qQrxz5QLDl+tQ1eTUYMfaPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTjMzIIv9dO4/Z6dzrFc56xx5G1+zJnv9CX7gbKeymHZjHlTz3A0Wa/JB2tCusBtSgrmAbdTlslhL1dwVSfibyBd6N83apPa6w9K1O8G04cYd6NM8inLrXIwRaz40mBDHBTO9Kj/8BOrVQgMXIl5lx1JZJyzUrDdo7Vqgig5Mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN4EVBTF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3787e067230so3759306f8f.1;
        Tue, 17 Sep 2024 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726559445; x=1727164245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOUiZZqfeKnAUWXSdwDzahgPVUGaVsj6hbmrJ1t/ZYI=;
        b=cN4EVBTFluclyMFlORo3jAylxmOgjmMHrGAj3gXVBUwXNZrWO+cz10zWLDzMLV2rz0
         26I+L5fOR9Nk+2izJ1kBRXNbc2hXoLGTFl77hRkp/aHsY+FNiKAeJVT5UqIZFGeBXI4C
         j6uKVC6WS1hV0a9mNN8KqDvpqTf2ophzQnys/f42x3x0EVyF0NBATRbLzad+NA/iKtoY
         69Lk3DHUnSb13sx3WmQiXbhe3EZlklwCwqlnV4BCva4j0WW8nOdG3XR8rRsy+Klv4peq
         i9rgyExDFfOjkL+jYL9NMMp1b6lRrIJ8BL7fe7vllUDtyKHOZigUBq4kZAreEPwXj5zw
         6CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726559445; x=1727164245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOUiZZqfeKnAUWXSdwDzahgPVUGaVsj6hbmrJ1t/ZYI=;
        b=wGKY00XkSNo2UnTwTBLEtyab0KfehcE6dRe98cCEBsW5UBEb7Q69vORkMmlRvnXVZr
         94gOF3nYH/tNsFIB4+RtoetrpwzkindAtW9la9nwtKn1UvHbvUW5LE/pnm3kmYelcGcO
         lKmpdXDt4FnKoyPUzMEbewRX2t/B32OoZN1EsAld+KNqUH6flECxBHYr5GbbF17n4VD9
         tzFmpW9Vc2TU7eWtPHKKxbrLYdFEd+NaIIqW1nt39ZI1x6+qUIgydMm79n8WYpQs4cGH
         4vScc1GkUtLlNCkuDUd+WIbsY/eeVXhQNXJFhbp2uOKYHOK0knQEkJ4JO9RdMbvpCOR/
         xi4A==
X-Forwarded-Encrypted: i=1; AJvYcCUUJL4NrLCcBhqC4m3I7wAceAkJWfEroDmM9IrDX4JItjohSssYOXp1xX+Iy3xZNREdVuH5RAURQ9PMnwbP@vger.kernel.org, AJvYcCUarEcf3jNC6zl7xVGikJ+ihBV9i3r8AZ+dv1AzWiPz6pwGJ+EW4IeajyffF7k1UK1f1ZjT7+iZxIOS0CT449xnKS1y@vger.kernel.org, AJvYcCUzWcSL0N3vYClj9Rh/OLQznHaKMHNns2VNDPgIqm52OD/Yad/M7Qf1bPhyExlzllI9AGw=@vger.kernel.org, AJvYcCVlHX32tldCIkQh8K+bmJ1uUNlV293aJqbOUDDzrsFtvZTQLB01Eo+FyNVjAuLmPwnfn1LPADgfER/BfyB8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvfl3IVmZ4f1XYJT1yDXH+xv7wsIxekZSp6fpJvMB/bIw7bJ/Y
	VE7QZ1IgYLLKZ7csOZaVqadRub7rsFU04548UWpa4D5BdCcGpFKY+MtaMIodyKFf/H0Gc3JkYuo
	xGYaEDwqeJJgeZeK0lqVfLAJvHto=
X-Google-Smtp-Source: AGHT+IFUHNwJD1rrVSNnhBUjozimr/IRIRFM5+UiXaaxNqJx5qpXzHSNwoRONcrku8KUyImYw3I7mWhNqeuUD/xJVUk=
X-Received: by 2002:a5d:4248:0:b0:374:c847:866 with SMTP id
 ffacd0b85a97d-378c2d06352mr11130199f8f.23.1726559445170; Tue, 17 Sep 2024
 00:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com> <20240915205648.830121-18-hbathini@linux.ibm.com>
In-Reply-To: <20240915205648.830121-18-hbathini@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Sep 2024 09:50:33 +0200
Message-ID: <CAADnVQL60XXW95tgwKn3kVgSQAN7gr1STy=APuO1xQD7mz-aXA@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] powerpc64/bpf: Add support for bpf trampolines
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Vishal Chourasia <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
> +
> +       /*
> +        * Generated stack layout:
> +        *
> +        * func prev back chain         [ back chain        ]
> +        *                              [                   ]
> +        * bpf prog redzone/tailcallcnt [ ...               ] 64 bytes (6=
4-bit powerpc)
> +        *                              [                   ] --
...
> +
> +       /* Dummy frame size for proper unwind - includes 64-bytes red zon=
e for 64-bit powerpc */
> +       bpf_dummy_frame_size =3D STACK_FRAME_MIN_SIZE + 64;

What is the goal of such a large "red zone" ?
The kernel stack is a limited resource.
Why reserve 64 bytes ?
tail call cnt can probably be optional as well.

