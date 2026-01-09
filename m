Return-Path: <bpf+bounces-78363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C205D0BF5E
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08ABA30A1F29
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CE2DFF1D;
	Fri,  9 Jan 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDh8rOXD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F32DF3CC
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984613; cv=none; b=KcALPBkGK1lT/V74gZGhhPSvZ8ASWHltnZceHM56Vqrt6Z+moe94M4tWBFSJ+N4OG/zU2hIeFNBojkcwV6mxwwn9mozGaHlbX377m60FWSwEhl0gS0n5W8+NMBZDgVjTEA8exFhzw62HLfRmqVK/l/LIQhDU7h4KHnlCXXeQ5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984613; c=relaxed/simple;
	bh=qdrDeP7oprKx2hl9E9Pi32hmF3i+aNgOFf4WXNKh7T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7VjBic61FgH3HpidLvhly2yvcpMBfBR9h0aSA/s6mmvCKnMCN0Mot/ghEx9td4FiShHCrI7Qp6WiNZS1HDK99Qlzy4gyeLbSnMo6oO55WF22F9Lc7wDdtJtRKaFRK1PQl1j/Frr8e/cVCIY6gq7dfxTH3F6X92KvINwmTzhFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDh8rOXD; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6446d7a8eadso4085252d50.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767984611; x=1768589411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK7bh/7p/7tkMzi/lq2Lx054ktT2ALu+WlVe58YV9B0=;
        b=EDh8rOXDSsU7j0RbUKtk0RPHUpuNoiRsDJW0Y9BOfUcm1kerVA0TXzXwZXUeJXRfks
         Vzv0UBAxFxyWR/fLEWzFGZSObBAgfOJ0HAYvT2cIA1YGA5dNk8cDkfP8PfjSnDsb+vtN
         Ni05GdE/AXkXIzBHUhQrNGCVJXwitczWy7r1M2KjV+DxQd8oiImn1Qj3oY5Tqd5mXdNl
         jm80iNRfAJlNP4sE/VUy0eQUqYYvxpjE6cLUjYqitrBh6rbsQ1i7wlvTDeuYsTyjISmf
         5A+cZvJcujbM1Uzw5BjIJkMlVLZPydqwyYH0XMgtVye9TO4w2Dx4ii4WTcBxpgWlPSV0
         qqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984611; x=1768589411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wK7bh/7p/7tkMzi/lq2Lx054ktT2ALu+WlVe58YV9B0=;
        b=Y/vRCGLPCBpdZcaZQvkLuj8mXQEnxW76Ae+GqinW7p49/fsVgwhwIHh3iRCC9hzVMj
         HBABEvyW3mvCrCbS207wxst0AkWjm0r9KhNDuBMfYrxLQSJPdPq6QVcRWDW5JkV/1HEo
         OvKkRDaE1xMDr33XTLHd96u4TcHZH0elmC5fXrI6N6ySAOeLrfN13L4aaCGiS+abhCfE
         XNYeiP7CMeopBgLg6AMXpGZzUFyBt4F1r2aIFhc4aQLuJHcbIG16tWFjOiulsbi4uHyj
         d61EAkr/day6UFIQGG4WBF8BqKtuc1ikSt9+CbCL+YQ56tCKv+jJ2QHwoJBBgNRkc7H8
         JdWg==
X-Forwarded-Encrypted: i=1; AJvYcCVzUSWTjJDrfwYwhNs8M0h63mZ9wip5AtANF+z2JKsKxorFrrxSXuqffrZ/DGLC/vxIHoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpToOq4yh4fc05GC/LM5SCggywB4vwpk9AdCneztKGYLqyWgJ1
	lpmB+M3iRYDexSYPM51oAWg+3DF1/HW/6w0Eq2cNxrL5G8OgBG6MQDb2DeopnYByj55Mxdd70YF
	YYe1AvhSJiVWRO/vmON7ALsZSegeS1to=
X-Gm-Gg: AY/fxX60487OcIDNWCPRbNVTLxOuPnFQKdBSPfMD17ZbI8fXBf8cFbv4/PsX2ceREWn
	3fq+zQWgFClNH3HcGD7VZTpP5hXeZKhPuYA5BlnR+wNlAdYTqrXZSaQvxmM+RLT1TUH+zkIbG/3
	ogYrrKfheP9+Efh+eY0FyKbxvI5pcAyk1PptntRoFN9Bxo5FhAULparAioyQ45+W1tHmXhjs7vu
	MpUuhpJz2rfMDs+QhnV/ex8WPqxEDIrvnMloXDkBw9is2k9155SjH7bRvi+2Jia7f7zJTqVfqsw
	Quzym0xL5Ks=
X-Google-Smtp-Source: AGHT+IH/QwK3C6Uya9V1E/1NniDk5L5dUAHhO4HowjaQmZEhpYanC5C6VYaeq0F2tfr3FgPQgIsfVoX+0vVcvCgI9hE=
X-Received: by 2002:a05:690e:1c08:b0:644:4625:8853 with SMTP id
 956f58d0204a3-64716ba3653mr8290815d50.34.1767984611368; Fri, 09 Jan 2026
 10:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-4-ameryhung@gmail.com>
 <429e4120-b973-4b26-9c50-2e03c104253a@linux.dev>
In-Reply-To: <429e4120-b973-4b26-9c50-2e03c104253a@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 9 Jan 2026 10:49:59 -0800
X-Gm-Features: AQt7F2qoc8qq_Oyv6fLiOa5JXKdeBc18ZjOYglzW3h7ak5WXpPgk1mY-8Nz-D50
Message-ID: <CAMB2axPv+wHfj7N7Txcqyar8p9kByZgiChkoW64E+XFJxN2f3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/16] bpf: Open code bpf_selem_unlink_storage
 in bpf_selem_unlink
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 9:42=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 12/18/25 9:56 AM, Amery Hung wrote:
> > @@ -396,17 +369,39 @@ static void bpf_selem_link_map_nolock(struct bpf_=
local_storage_map *smap,
> >
> >   void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reus=
e_now)
>
> bpf_selem_unlink() will not be used by bpf_local_storage_map_free() in
> the later patch, so the "bool reuse_now" arg is no longer needed and
> should be cleaned up.
>

Ack

>
>

