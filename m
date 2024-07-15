Return-Path: <bpf+bounces-34795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5408C930E59
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 08:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97564B20E8E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078301836D6;
	Mon, 15 Jul 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ6F8Zla"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215A139CF7;
	Mon, 15 Jul 2024 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721026359; cv=none; b=VllENCUnYYo9A6VjujLSSMYgyvx2f4hjwRLKiPVsrKN2GUzYwk7RC/QRWwgWZFGhWhkM45xtnxnlqFgohUQNWJ3YOFulbUePoQfCxUjTt7sHlaoPsuh19pIjXjsVtvHMVYaWAZnOPofge9o/66yXPLUE/7iGUBzcSUWJK3jPW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721026359; c=relaxed/simple;
	bh=DDnUcLBgAAc483YtKI1LEnhFIKxqsRne8PxPAtZmAMw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AZSKflHqN8TQwCBgyeB655XRS1rxn4BV/Mv620kzCMBZ3/+tWqO9yQXetFOHhiEmN0OdkmK9PX4+KH3wk+MeZg/bgCV5iQbm5rzc+S4SLbb0veZAn/QXdmGpanouOxGTJCT8jWpGCFnnfb8Zh278i57g2zgIulss0rjCKOIpPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ6F8Zla; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b1808dee9so2506517b3a.2;
        Sun, 14 Jul 2024 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721026357; x=1721631157; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOUBnyacfrZf8eVlFcm0/q6B+wJPrQJ79e88GPN7rB4=;
        b=AQ6F8ZlaimT+tcligCbWvazaWE/qjnsQOj88AhP4YN4tQeykYShe7seIFyf1/0jd+1
         j0LivTJsH+MOw/xEsCGBmI5RCtPsuipiOxtTNvTZ1HdaNeevCs8lSkEbXPkMtMz+6XCW
         x7Xb05q0D1j9AcXiPINRlCsx3gLR7hBmJzPqYfN6ceG233jSpRA7P13I0Kd9Sad6u51O
         ZjUoduiEGKsVwAChj40eBCrjOWKNtrLZn/FkeSDaUaVQ6/0nKBtp9bo0zGe5WTms5ZU/
         55s9kQK5heLhxapVBXzfDUmMiaG9G8561u0y9WbWQC1kNwu6oAzfSm/3DOG3xdbOy+d1
         zlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721026357; x=1721631157;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOUBnyacfrZf8eVlFcm0/q6B+wJPrQJ79e88GPN7rB4=;
        b=pAgKywzo8IA1lqTwlf7FBsBB37jGhAwUB68OGL+c41zIxZIeUnbg9eHiIDnD3HsYCb
         95NKfMv2Q7mn+3HN8f1EjbeFEpLtp09npgMr7BDxhHZdNsUYDLiHfAtaB78dh8dbsY0Q
         Z1RU0uqOwYx3aGYtbcA6x/y1jeGea/Yipov4IbmATXoKdk+igSwfJ2jP+YKOvBpipUTo
         RPbJ/p+dg1jt8B/iJHbP5NJg0aUhXNI4fGwlKFvjwNcPt9xuD9yreVVOaaK//vko60kN
         5I687XmkJNY3S3J6qu3M/jM2ZxlqdGayr5y1DsOoCsuPmSTEsxLeFkFLmVqw6KNUJAQl
         RFEA==
X-Forwarded-Encrypted: i=1; AJvYcCWnHddhW5TWM5Z3/DfLc1xpON0hZKjon0xT13i8u9/DbJOuRS0iHnoZiqyFexalxnFtXAKPUyUPTt+KdA185Yjw0cWFWbrANE58ImySJ2YMr6pLJVuBesQkjM9Ipox5e/UUYgAzNlaP7u/gaGcxAsjXFqej3VJ1dHtKEtLyQbtAtw07tS21jglwL51OYJU699cxF2N9MRyp6kXC9JlGVxtrPseH
X-Gm-Message-State: AOJu0YywR4nplJZUThMA0eJOlHEWdUCJ7Ivte0KrRB1H70xrRA0IGo5o
	FsHD/SCS3VXydwT833PL4zV8tdqk3M/d4RPfLwLWIk+XPRIQMi+P
X-Google-Smtp-Source: AGHT+IFh6bSn4V5kPfc1+LrO3cOGjERs8h1Xg/TGnhJOuvCkDfri4xK1SmxC19x+mql3WPQIZcGfoA==
X-Received: by 2002:a05:6a20:a125:b0:1c2:8949:5bb3 with SMTP id adf61e73a8af0-1c2984cf1f6mr18562950637.42.1721026357378;
        Sun, 14 Jul 2024 23:52:37 -0700 (PDT)
Received: from localhost ([1.146.120.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca3c74eb5dsm6027391a91.0.2024.07.14.23.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 23:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 16:52:26 +1000
Message-Id: <D2PWX8QDYFXB.B2LUK0XGNIYF@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Hari Bathini"
 <hbathini@linux.ibm.com>, "Mahesh Salgaonkar" <mahesh@linux.ibm.com>,
 "Vishal Chourasia" <vishalc@linux.ibm.com>
Subject: Re: [RFC PATCH v4 08/17] powerpc/ftrace: Move ftrace stub used for
 init text before _einittext
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1720942106.git.naveen@kernel.org>
 <ce15b4bfe271a49b5edad8149be113bc78207fda.1720942106.git.naveen@kernel.org>
In-Reply-To: <ce15b4bfe271a49b5edad8149be113bc78207fda.1720942106.git.naveen@kernel.org>

On Sun Jul 14, 2024 at 6:27 PM AEST, Naveen N Rao wrote:
> Move the ftrace stub used to cover inittext before _einittext so that it
> is within kernel text, as seen through core_kernel_text(). This is
> required for a subsequent change to ftrace.

Hmm, is there a reason it was outside einittext anyway?

Does it do anything else? Other than symbols, on some 32-bit platforms
it looks like it could change some of the initial mapping/pinning. Maybe
they jut get lucky and always map it before the change anyway?

It looks like the right thing to do even without the subsequent ftrace
change though.

Thanks,
Nick

>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmli=
nux.lds.S
> index f420df7888a7..0aef9959f2cd 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -267,14 +267,13 @@ SECTIONS
>  	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
>  		_sinittext =3D .;
>  		INIT_TEXT
> -
> +		*(.tramp.ftrace.init);
>  		/*
>  		 *.init.text might be RO so we must ensure this section ends on
>  		 * a page boundary.
>  		 */
>  		. =3D ALIGN(PAGE_SIZE);
>  		_einittext =3D .;
> -		*(.tramp.ftrace.init);
>  	} :text
> =20
>  	/* .exit.text is discarded at runtime, not link time,


