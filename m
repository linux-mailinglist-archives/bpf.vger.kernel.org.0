Return-Path: <bpf+bounces-22214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D48D858FF9
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 15:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C77AB20C8E
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8547AE79;
	Sat, 17 Feb 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUI5POZJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20AF7AE59
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178925; cv=none; b=szEcq0XVIZGiRDus6tibPungklQw4qZoyjhK00TwlSAD2I9QAtvfssXRh4Fyft94dKyCXKx0v38HCHQYOli0nLfQHlmEy5HCimH9nVUXkd4AQgQZ0eeFPWpGSmKho+Chdsoy2tkkKC/e8oCv5uoWHS24Zj3MHugwNZzXSb1XF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178925; c=relaxed/simple;
	bh=x+S71JxrA/qqLbxJjG8h7+YSnLI2fC+i4VMM2WFGKOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kX6lWU3kCv/ymyDyUKVJI51N92OaGdHN5PQAHm7gy2MMDVn/uHRxrpMadPpzW3wv8LopMH6XVDcPrU1mU8KFC9YeRHZ/ZH7pbQw+7Ssicd/x8TcTt7zLPoXzRYZI4fAc0bF4y3CluHr47EeedVEJdeiEtLKhFVTxEWdrPKzta00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUI5POZJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so2037742a12.0
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708178922; x=1708783722; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x+S71JxrA/qqLbxJjG8h7+YSnLI2fC+i4VMM2WFGKOk=;
        b=jUI5POZJON6rsJJIGI67aBK9gQZBqAMW0Zqajeev6yi2hLJIsPDQ/4sQqN4ip6Lgph
         JRI6kjtpUqhV2f8GN11s9FpTM70Dc2bB5IHGMTE8xcHXQR7dMOI4fKbLE+/6QQbAlHYI
         SiQWgBeJhzVrdllq9K25Ae6tSGlY0hlcXm4FG9gQWNV3PzkzM8J0ADiUwdf7UtAVilqu
         CKLjv4quJM/DOnTMQtNZHj60sX3EkPQMibFFMjRkNc2AXcBNOHDzCnQ1cFtrxJB7S92+
         X2XR8xB21B7aIt1BYPbEoCwfT9UDSQWy+StS7nJjViwFkHeZEXHeSco6HeyYaTc/RZzG
         kU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708178922; x=1708783722;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+S71JxrA/qqLbxJjG8h7+YSnLI2fC+i4VMM2WFGKOk=;
        b=G7oOTwXh/bZTDHb48aG63Mk6AfZzMulIbcqy1KN+p6Dozkjw/U8EPSwIYOjsPBilXB
         8ZWR1kJjnESnHRKHzdpbawp78bgDaVfZQjhiv28MxyYwseDEcwcf5qBrffSeFHoeVcDL
         yZvZhCDEni1i6KnSKSOSMdFfaHh6cHCoFvtYljJ1S9x+QeRGl03L8TWZNIjKJXKJhwBD
         aToyIgM+9jPQ1rHdcowdkqqHvAOjqg3hh18VBHnLMFg4fG3Bvk1F7S2+x6e/uKtJWjMb
         +87w98vYe6eXMCoT1FkUa+5bs83xH9REny7Um7keXhccdx+Zz2DyjhXA71/M7fgWh1Jl
         A3ww==
X-Gm-Message-State: AOJu0YyWbcLwWE3fU42F33onzk5zyidfBnYfW/shV/5vZUw205rn2Orl
	iAZwe5W5JiTNGVn/A5yeYs1Fm+Hu8uqHZsQmlOc9CD7OHVfYtDjA
X-Google-Smtp-Source: AGHT+IGz1B1AqGHL/KJAoz2BgHa4k4gnx5g9uBWxtSH9rx0flr0HFR8del85Au3pHAfdbSRG+qXHOw==
X-Received: by 2002:a17:906:b814:b0:a3d:f289:f036 with SMTP id dv20-20020a170906b81400b00a3df289f036mr2565677ejb.2.1708178921842;
        Sat, 17 Feb 2024 06:08:41 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bk10-20020a170906b0ca00b00a3ca744438csm1001426ejb.213.2024.02.17.06.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 06:08:41 -0800 (PST)
Message-ID: <ae60bd6a77bbb6504e288c63e2d3e4a0043bb567.camel@gmail.com>
Subject: Re: [RFC PATCH v1 06/14] bpf: Adjust frame descriptor pc on
 instruction patching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet
 <void@manifault.com>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>,
 Dan Williams <djwillia@vt.edu>,  Rishabh Iyer <rishabh.iyer@epfl.ch>,
 Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Sat, 17 Feb 2024 16:08:40 +0200
In-Reply-To: <CAP01T77+q_72KjRBB31DX+QWG3qHPsOrj_z=ihXJcAV=O=M2rQ@mail.gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-7-memxor@gmail.com>
	 <8cb6e0ffa4810396ef618bfc92449dfd54d47043.camel@gmail.com>
	 <CAP01T77+q_72KjRBB31DX+QWG3qHPsOrj_z=ihXJcAV=O=M2rQ@mail.gmail.com>
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

On Fri, 2024-02-16 at 22:52 +0100, Kumar Kartikeya Dwivedi wrote:
[...]

> I think these btf pointers are just a view, the real owner is in
> the used_btfs array, in case of failure, it is dropped as part of
> bpf_verifier_env cleanup, or in case of success, transferred to
> bpf_prog struct and released on bpf_prog cleanup.
> So I think it should be ok, but I will recheck again.

You are correct and I'm wrong,
add_used_btf() indeed pushes link to env->used_btfs,
sorry for the noise.

