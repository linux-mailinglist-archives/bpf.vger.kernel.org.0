Return-Path: <bpf+bounces-52399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED75A429E6
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946893B11BC
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46358265CDD;
	Mon, 24 Feb 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfvIJeHR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D4264FBF
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418261; cv=none; b=KnReHWMM1V5ngmL/oh3mW35RJgioOstHyMyfwgfFVsZWs+TVb5ginhq3yDXRpaMWhzDDZV5JDN4s2sQULSkv3T3KrFJJM1o9UHhQC2marjIyCYGm8kwspSqM735ovlqC/bEmVpTRvtrYFa2UKRMu/0U4QAcCK/lS9iQX2lRP6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418261; c=relaxed/simple;
	bh=o5LqFKXtypAZKORvue/mbTtkMbaOGBiz8pvHmEljQjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP0r+PT/NUtXzPTVfrky3uLRgGd+ueN6cFbrDaVqPISVVA4aRGSTkFoEvYfkZW7fA6tYawO9NjAM7uBTXRWAOySgHAK5ZcyWnDUvXxnMB8Hcu5eor2AK5cpxniebQpJqMHID7mja9tzlWx2BxSeVPcAsaUnf2KNdYC9CqqpVd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfvIJeHR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4398738217aso41114985e9.3
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740418258; x=1741023058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkRTw+NECIIJY/sOMuDRMrZ7myC9csuq6rha9wwEupc=;
        b=SfvIJeHR8Xuu03aM7i9QiipDdBgiCVeoW3rzmik7PMi/A3oezoicWfTfQqUgEUz+Kx
         c3YgWSWWr02KRCH3r470Vl46UC1xsddpGU1bigfINKxIZucQBcXRhii/Yf0U5heEjSWb
         eI7RyFUe97Js2/HGyzvqYz68v4xm/qe94FgI3uEpMpBzrP8VHQiJF1M18grHeSJml6Ll
         IQylZu6I4fzhCLjSkeus58NmhCjbFhtvOPiwRG9J/SEWbymXF2WXhhiOBp6m+q34B8Eh
         iYQFfsGzl3i2xT7SfDsd7HadEipGdso5PNLwaudrLv4yluMo38pd/5CX/J8bKtVVAfE6
         S7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418258; x=1741023058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkRTw+NECIIJY/sOMuDRMrZ7myC9csuq6rha9wwEupc=;
        b=NxRhFmY3bhI/ZMmgNamnrNcHX7mHf+pa5T4mnt8h0/b9YB6YyXCbLC1pXgf7x9yJi4
         ZFZedDmsJbXhj83waZ26PzwZlGneIU3nmYdZAVjB13Sf5d3qWfhNTIGL6w3wn6MY4pBn
         0vbLEKNgU5nm9+Nv0zgLbG17KJ36n4N8+Bw0dxtxi+P0Q2qbE2qzcCv/wWnDDdUqkJU0
         eaHiX/aqv8NfkPQlDgSHO9kSFT6y90/GuOfK+e2s9chdSNHAbfFaoN98xLC8dyocuYOJ
         9gO9LvUVmgntTSjtVEUOf7KcXOuuCVUnF5QQzUMUsC1ttGLbHeVEuP1TBN7hY2dNv6g3
         wH0w==
X-Forwarded-Encrypted: i=1; AJvYcCVOKYPa1R4anERJ9ZyKkh2iCyszCnXElSoWSyQspjldAeDglpM4rETHXaqq1fVX7RTPWxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRC00WcU+ZZrS7k1Tivn6JKPa+xReXtGJBXrFKsJtfSufaZWI
	YIiIyQJ2HHp/yZd5cUtISE+ItKC1NkvR8/Z2saRxhiCPcRVKHXieBuHn6cpvSsMujbz4nhWbk4T
	vkGDfcO+uwU4fDq6jKYWPejcr/QI=
X-Gm-Gg: ASbGncuUWSoDonUchKfh1tgYLOnJzxjqS1PYWRLj2ROa0TDBSqV6/K/40FHLdlZ1o6S
	UJGUVzMEK8lX/Vl32DgnZzkgkD/eUuv5O2CDCzwVvX9ASScXPffdhQGL9HUo/TfVgVmjHaYD26R
	Lg4X7wX1XEZCM2iL4RjmEBZrM=
X-Google-Smtp-Source: AGHT+IEifty1kGT7Wlpzbf543RtWP/hy1V9ehT6trzs3uYB+eZnf1ut3q2oWOsWRZlxe9PPBCt1GDiSbpVaMjAhJbgs=
X-Received: by 2002:a05:6000:156d:b0:38d:d0ea:b04c with SMTP id
 ffacd0b85a97d-38f6f0b0f03mr15077129f8f.38.1740418258285; Mon, 24 Feb 2025
 09:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114606.3500-1-laoar.shao@gmail.com> <20250224114606.3500-2-laoar.shao@gmail.com>
In-Reply-To: <20250224114606.3500-2-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Feb 2025 09:30:45 -0800
X-Gm-Features: AWEUYZmXcbFMUW7N5iwB4zdRJA635HFhZ9bBovlL34URsk8Ii-RnOWc84-qqd5Q
Message-ID: <CAADnVQKUYP8e_u5QWGHK_fi_LKyOO3voFkHyRLCuw9-qKiFmDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Reject attaching fexit to functions annotated
 with __noreturn
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:46=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> +       } else if (prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT &&
> +                  btf_id_set_contains(&fexit_deny, btf_id)) {
> +               verbose(env, "Attaching fexit to __noreturn functions is =
rejected.\n");
> +               return -EINVAL;

Just realized that this needs to include
prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN
since it's doing __bpf_tramp_enter() too.

Also the list must only contain existing functions.
Otherwise there are plenty of build warns:
  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol xen_start_kernel
WARN: resolve_btfids: unresolved symbol xen_cpu_bringup_again
WARN: resolve_btfids: unresolved symbol usercopy_abort
WARN: resolve_btfids: unresolved symbol snp_abort
WARN: resolve_btfids: unresolved symbol sev_es_terminate
WARN: resolve_btfids: unresolved symbol rust_helper_BUG
...

pw-bot: cr

