Return-Path: <bpf+bounces-22978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5086BCEB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA591F2502A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ED1171AA;
	Thu, 29 Feb 2024 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMcPNseL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9F13D306
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167206; cv=none; b=d83EMI6CrAPGkZJYl/PkqHbdLRD8mgqq0PFpC60CL5DH5r/+p8SaKEF0xSmRMyTQI+f4gkQtBqac7UCYXsn9lnEnaIkjWOpqF3EoXzT3rIv0MiaAGgQ/qOYKQghYJXoufsnmBriPeuMUm+mzrf1D9JoNTvqBPZrPeSot/pTZGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167206; c=relaxed/simple;
	bh=j/JHBd8ZyrDrat3zQBKgGmy4K1YYXLo8FL6OJzHxCc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqGzUgH94aQvlgMLA69ljKi4PHrhd2+sgGFd8YNhAmlwlUcZzSO6+OLpGzxV6CSo9mJjbdPYMGimX4MiNn35kzUZvIv08bfOPHxjfj7vfUv7laZ7IdtKovqSxNOwvfZs6ykPfZOFXUXaeQqNQN+cV3NXVIJCznbTyRbEzaFWzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMcPNseL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28051376eso4206611fa.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167202; x=1709772002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/JHBd8ZyrDrat3zQBKgGmy4K1YYXLo8FL6OJzHxCc8=;
        b=HMcPNseLVMKGqaS6cMVF83H9WGcivJlRM2wqv3u3cOvKTDNhRMjfO1q9MzrRHJedFr
         qdlwLZjto1ISUEw4PzCZwiEr6RDqdI5pJKi4C9Pf7UK3hPboTod4PJQsksjndY+jxHxC
         rRUvJ/kOiwOBAX3M3C04RzTkI2fk3HBXWG4N2VNnvTAvMIj5dEbU7sSXew1xO22U3STU
         oBWKzy2/tVZBEZpIfr+AXEKPq4xbbWlosOqSnQ5VY2JfDhKlUjLjGC2J5y75lffXWkkh
         0S4TyGf+Bix7+GjZcdK2pWczsMql6Pixhy/JSodJyzC8IVvQOcybSAgbJyis0Z6ASzOq
         x6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167202; x=1709772002;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/JHBd8ZyrDrat3zQBKgGmy4K1YYXLo8FL6OJzHxCc8=;
        b=XCQ29QQpQKqUoMnGjswgP4cIXUiEzdGrMpy6uUnRrR7rnSCLbgFGzTG+QH6UetpSyv
         SvSjfTJ3X0mu2jCjD0GV4K++1eYDShjFgBDWME5H3MxtFNTikMTRBjcOx0KEFNhQ/Iz3
         QJdjv+/+dLbdyVETHS4GlYpGwpRTjn9dz0Vq02xj8kaIUCit372WRadN4mHHRcvvM9vt
         OHC/ci74OaimNmQWyk35ZpC2XWN93e653oQ7/wKOJptq4HfH+04TlMcw8dPKjGfSVeym
         RiknHEYRHNvNuPuaFLUQc9IqdOHVf24HGWgz9EXdr4xJ7J7ICrjfGS3s+2jutsL9Cc2T
         WeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoXWRphiSMiGXAl3Bqs/CYMki+PLVoO5CydZ8E17j9lW6fe7gtLWaJqWD+appj2KxsGKSdY7YjWCIhrQ2lB3Vt9T52
X-Gm-Message-State: AOJu0Yw7JdOULPKrVfiWknI8FeYcJmtkZbSnQVZix3MBcsEvtx2RX9cF
	mK2AZY1oOWlI9CykYwEe4VeNQGGQEYiI9jLejvX8YKtNzP94Fdpt
X-Google-Smtp-Source: AGHT+IHp1NXPUvd/NLTlooOOFkko1nTF9KcTApb91Rp4PTFzIjOmlh2KKJuMe7vBXRvvGs4bAl7kvQ==
X-Received: by 2002:a2e:98c9:0:b0:2d2:47c7:3f2a with SMTP id s9-20020a2e98c9000000b002d247c73f2amr270748ljj.36.1709167202282;
        Wed, 28 Feb 2024 16:40:02 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e9646000000b002d23935c5f9sm27574ljh.140.2024.02.28.16.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:40:01 -0800 (PST)
Message-ID: <10738f63bd2ab584e32e12fc3f251d3c3ac0b974.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
 yonghong.song@linux.dev, void@manifault.com, bpf@vger.kernel.org,
 ast@kernel.org
Date: Thu, 29 Feb 2024 02:40:00 +0200
In-Reply-To: <adf15573-444a-4fd9-bf3a-6e8281d0ed87@linux.dev>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-8-eddyz87@gmail.com>
	 <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
	 <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
	 <ca62c2b8-adbb-4cbd-ab93-10a90dbdf2cf@linux.dev>
	 <CAEf4BzYNVRaq7b+K_KqLMm+E3oybhaVFp1HzbTbR+sBYSoHM-g@mail.gmail.com>
	 <adf15573-444a-4fd9-bf3a-6e8281d0ed87@linux.dev>
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

On Wed, 2024-02-28 at 16:37 -0800, Martin KaFai Lau wrote:
[...]

> > Yes, it's all sane in the above example. But imagine a stand-alone
> > struct_ops program with no SEC(".struct_ops") at all:
> >=20
> >=20
> > SEC("struct_ops/test1")
> > int BPF_PROG(test1) { ... }
> >=20
> > /* nothing else */
> >=20
> > Currently this will fail, right?
> >=20
> > And with your proposal it will succeed without actually even
> > attempting to load the BPF program. Or am I misunderstanding?
>=20
> Yep, currently it should fail.
>=20
> Agree that we need to distinguish this case and prog->attach_btf_id is no=
t=20
> enough. This probably can be tracked in collect_st_ops_relos at the open =
phase.

collect_st_ops_relos() should work, I'll add a flag to track this.

