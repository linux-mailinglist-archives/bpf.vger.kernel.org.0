Return-Path: <bpf+bounces-75285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE8C7C1B9
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1567E35F8EF
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013F2C2356;
	Sat, 22 Nov 2025 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WutWybkh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798702C11F1
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775823; cv=none; b=WlY6iTaOFVgxsaz1z9Y/pB3RxHTCMscTJozYhaCZlek+YzgL6FTcpJQ9sotzrUuCpqZC6r4Q/cJmSNVvqb9yGm5Lnb0YVOdl38mCViNtrzu4fNlSD00sZ0Lz6eHt80iCpgMG1hnrdT9PHxCzt0rmRw32c8lBkNXo91Yw3voQvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775823; c=relaxed/simple;
	bh=eK4AUJBiIJz3oZNmu7sUeKDHnLWzFnSMuNw1lB79Qkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY99CnCYeJCNqoFMqPJOrAxjq6f19t9JAi6hwDO1YWEV8LOEv+fP9XQu6ZNnwWdsZJZynWPwulVy7UWQzLQw+FJpAz1CzeB3UQzSNvFbbE5vKgc/96XP0AIq8nXtv44CqrC+zQ1QPKjJwZj1ZFKFy6fo3SRsCGNnXksp1j0286M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WutWybkh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c48e05aeso1720653f8f.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 17:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763775820; x=1764380620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK4AUJBiIJz3oZNmu7sUeKDHnLWzFnSMuNw1lB79Qkw=;
        b=WutWybkheflJe7WT8onSVGQv/SupCpjptvPTcS9A7xPDAGyArx2o/YX/2Vqe5Y4+k9
         uNlK7jJRqUWLpT0s86CL0Y7SiygCIeL6mwKOPtMVGPqmIAbCu0THl5BC4XLu+xV46+Gn
         FeaDBpS9tYzqiuQsd8aE4NJeyU8kvrFz0ltJI45Le1SUEqz412A+YpDy9Dx+aZ5mkHvK
         tXO5xgcqrF7FCtL5aHJfbQqcpYYMBa5a2UVCs/Sr6FygKJ5b8FHkvCdRGhtPpn8yvrla
         UFBthwA3kFLcpWN/Sevfu6OhhYO/ymkSZHOEKKXqXxdmP4JFWQbMURVxAjdCQk5uRWl3
         6cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763775820; x=1764380620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eK4AUJBiIJz3oZNmu7sUeKDHnLWzFnSMuNw1lB79Qkw=;
        b=VvmKkGb0X3xL8iOP+5aSzwxf880ztzyTx8G8fXNII2rWxh7aPc0/ZM/qtStbebEq9/
         pYb7KohWKRai/bEaknOYe9SQQlV6ojvD56T8pAKCAly4YRnEEfMqnLWYZRRTkrwf6PzA
         O2MZ5rhW62t/hBNbikAPkjpIg0HwCv2Ne7Qx5di9InxTsZUMJVpQix7s/pV7bdkp0P+1
         THmdzfN6x+b5DRlvGw4jucb3yaSJGMrz2srbN2/mzqfFN8WY4q/w9L4968OErV3vG38G
         mu0MZUJafolr6+ZiNMQdFAPl6uLbC82LIKJHOsLiyWtzPS4B51SDh/hLF4bo4WeRY77z
         5THg==
X-Gm-Message-State: AOJu0YzsjqJIHCAzDS74VJZxplY9IC5sxB7j0qR+FnDjc8rA0qmYmyFb
	+gh7GaODMjGbvSyQHUFLVwrhFcI0cMvrgW9KgmzDy9101i6U0rp2HyiyK7AVxJ8QJau5EVbOiPS
	VjlyLk+PIUhYj3FppC+0Yw7OgiSoZOIQ=
X-Gm-Gg: ASbGncsH6e83LXP3R0Nb2MICmNxCCMsQbPcU7K/Ge6U2JzhrHVoO6A+3uQ1ikA0abj6
	bG7x3MRm0cyLeJs159vb6vlGfH9kMHuoOWD4o2rf6yPhWxRpeoMbxKNbO/psAr5wxh+2i1A3Fbb
	8M3gjaG7/XatCery6w4ap6ZC0YzK6ZDVB2x4JRnh5dElSLFjSUVnnSf1kJAzTSao+ddrvj2RJmi
	DH95LMA0KPuBMdDn0l3zB3va2Wg7Q/NlJyopGHLgX/1AtXXqhQjiI2oYdqBR7O7N9boQ4adFgVt
	Xn0SnJMSsrG6SY3dxHZa5Lxh7vg/
X-Google-Smtp-Source: AGHT+IHNIEMsKMuIfgmf4nSIkpkBE7g7sYoDWkVC8xsVj6L3W+IxV7WiDaJ3iYbj6vVbtX2WyqaxCHsUQwVIf+tm5GM=
X-Received: by 2002:a05:6000:26c7:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-42cc137bc77mr5027746f8f.21.1763775819744; Fri, 21 Nov 2025
 17:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118005305.27058-1-jordan@jrife.io>
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 17:43:28 -0800
X-Gm-Features: AWmQ_bmZ4EmkvTNStUUIL16LVXwHaftQKTWLBknsNveweaHyuQUb67hzwSYmSE4
Message-ID: <CAADnVQJ-9JubH5r4oSwQneu3o6U6s8Fa0cjCsi=+6-R+9nkzHw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Implement BPF_LINK_UPDATE for
 tracing links
To: Jordan Rife <jordan@jrife.io>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:53=E2=80=AFPM Jordan Rife <jordan@jrife.io> wrote=
:
>
> Implement update_prog for bpf_tracing_link_lops to enable
> BPF_LINK_UPDATE for fentry, fexit, fmod_ret, freplace, etc. links.
>
> My initial motivation for this was to enable a use case where one
> process creates and owns links pointing to "hooks" within a tc, xdp, ...
> attachment and an external "plugin" loads freplace programs and updates
> links to these hooks. Aside from that though, it seemed like it could
> be useful to be able to atomically swap out the program associated with
> an freplace/fentry/fexit/fmod_ret link more generally.

I don't think we should burden the kernel with link_update for fentry/fexit=
.
bpf trampoline is already complex enough. I don't feel that
additional complexity is justified.

