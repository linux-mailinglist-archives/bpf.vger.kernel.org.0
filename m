Return-Path: <bpf+bounces-22149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197EE857DBD
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD3828146F
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF912AACC;
	Fri, 16 Feb 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N75E1CVB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72308129A80
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090418; cv=none; b=sfbOtKPT61epSk67L0EhiRR3LyIpPGIj1exBqeR8I6klST8kok43Vv3LagZXYJhmJmyIkvzNPIntZOIGCD/rcSaFkyZrCfA/y5l3PxGgXlQFm0twJ+VjgqyLGEpurBTWrq5qKclQVpI6Rb0fiCW7m3gHgkZRx508E6WyF7J0Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090418; c=relaxed/simple;
	bh=lwtN0QltiWiF7JsB9cPtQvxbQHDikU3iHgSVIvDfHWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p0zYznexuSXYro6p7xgTEflCe6JzMHxdRzCMe3uwH7kzVYQOA+3OANP4G/KLuRFwMYnLUZKKzcUucu2EEn7YCWhb8wlVK1RC8ekk3ediA0P+ytDBtUIgApVUUIMXy6RXFIx1Mzq/tT052UYctNK7cJV6CpGf0QxkGVoI5BawO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N75E1CVB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-562178003a1so915904a12.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 05:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708090414; x=1708695214; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lwtN0QltiWiF7JsB9cPtQvxbQHDikU3iHgSVIvDfHWg=;
        b=N75E1CVBWNwBJ+4qbm5e2UGpMoDyZvHNBV0TJR6NZ/k/sIg9ShSyLRc4Z+//zKXrDJ
         3TiVmRGG8P/ucf7xJ1vZR9B0gBb9qe0THP6dBBK8s4FoyN8M24dQfm8DfS3URraHYnDL
         xZxqdxF/cw/EfYoNbOXoJTvC29ETcIOQpZPYVP/uoEtRPRlX0DOdX+Kocs1faH+YD/NF
         KIN6oSrPeOKTdpE27p7iq0QGHQzrwWEEFLkd1MHEZrjU/3dBRAX0sAHqQle7MGtfWE+y
         JXkU8xc16tcGuXwR9J3eh3w9zMT1Gxzs0SfanlKdFGvSrONO4CgOYFeuN/9PMIc/Tsda
         bPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708090414; x=1708695214;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwtN0QltiWiF7JsB9cPtQvxbQHDikU3iHgSVIvDfHWg=;
        b=j7MHOwJmyYzrvz8Dl7R0GX1Ui2T7LXwGoBPdfK1PVebzYzSq4rIbE8OmEoN21UBnuG
         Mc0a9iEIirb3wI7PczLHXBfq/W0I91K7q10D5TDSsjivhKwgZsZHm6Vu2o57VK9GD6Zm
         GL841ZaGRlLTkZQMXlCFTIfN4VNOE9UUWuyvBKnqgluuXEzYHW2uuvLUXcCBMM/SWZi9
         MyzAELLFJ6iZ3akHecr3sDkGmq88unrDsUehFPZMMcmWpFR4MeqEw9DkFIrCWNmf5QLD
         57xAUlHcyLr7wZSWpoBBw0pTHuMKeTbk0IDx6NSdROjyLKC9VJBvbFKE6u1C9JQ1+4Wl
         XQnw==
X-Forwarded-Encrypted: i=1; AJvYcCWl4j0KLfSos6gVn6USWWFaxR43Q0URLrxFFOn9kJ7LLw7Ttod/NLF76ILWK+UVmc9IZpy3DZPeWKmKhnPNjA/we+Vh
X-Gm-Message-State: AOJu0Yxc6T65Yhi177S1KfMdP1JyIZJcdOvEalQfvZQHo0anoCQ5m+wa
	xpWOveXHrzD7syZ80z5LP9X2xtDriz8w3afkB96cRX0h4NWupxiD
X-Google-Smtp-Source: AGHT+IEaxqguN1C2c9gymT3Iv0p/h3TB9UQQCgtNLORJ5jyz1HXmeXrpkvh/xBlk8sW9EUxC0oYSMw==
X-Received: by 2002:a05:6402:268f:b0:563:cb4d:80a6 with SMTP id w15-20020a056402268f00b00563cb4d80a6mr3381409edd.16.1708090414472;
        Fri, 16 Feb 2024 05:33:34 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fi6-20020a056402550600b005616db210c1sm1474257edb.67.2024.02.16.05.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:33:33 -0800 (PST)
Message-ID: <ef1ac2f5f93ee849b87d3c1224cb968ccc584efc.camel@gmail.com>
Subject: Re: [RFC PATCH v1 09/14] bpf, x86: Fix up pc offsets for frame
 descriptor entries
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Fri, 16 Feb 2024 15:33:27 +0200
In-Reply-To: <440fcc2619dee3bba5762312ddc83f7af3963641.camel@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-10-memxor@gmail.com>
	 <440fcc2619dee3bba5762312ddc83f7af3963641.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 00:12 +0200, Eduard Zingerman wrote:
[...]

> Would it be possible to instead embed an address (or index)
> of the corresponding frame descriptor in instruction stream itself?
> E.g. do LD_imm64 and pass it as a first parameter for bpf_throw()?
> Thus avoiding the necessity to track ip changes.

This won't work for calls upper in the chain.
Oh, well...

