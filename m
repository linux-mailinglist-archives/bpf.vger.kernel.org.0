Return-Path: <bpf+bounces-74654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E359AC60BDB
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 22:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CA4B52421C
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2204238C29;
	Sat, 15 Nov 2025 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr9FS5v+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D362066DE
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763243958; cv=none; b=NVGn6UAh5FPl89d7MRHE6CDkreTyGpa+9L03kZtheLOED02c5/sjU/2/Ssx50dif0rxRPAps/LyAwNxoH0qH2xuLyQfIRuOqTYv93XWYF9aGMn3L7hR3LAoqpo5jXY6j4nqhQCDVNm0GYZVMnvuvcdIg5JGYLRgg94S0NCydFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763243958; c=relaxed/simple;
	bh=VckU7Q0ub7K93sRbXU/Ww1Mo9sHn9C1VKL+8yDvS9Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTUVjdxG8AJDAvpI6SsY7zS9XYygOgQRFA6EheXrh6DEvNfMgOy0ySVWfXUWXbbAQzi+7voNPly+xh0xe5qA1K5Cx0DeBbACICztNP4ZZDoyq0HUSSt1a6pKyzjj/SLHw5VumCsJA0Z5iAoOVEEMbGT7zL4LC+JbQfISVpF/6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr9FS5v+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so2109524f8f.2
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763243953; x=1763848753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VckU7Q0ub7K93sRbXU/Ww1Mo9sHn9C1VKL+8yDvS9Nw=;
        b=Xr9FS5v+y+/1EbniIuPuRDuD8haXVCt9iIpsMRpRhZGsRvfC3ffIeopGebKLEs7E2H
         /lUr5GzvHDdu9bczKZtwq+HZnnJ2abRy9UqY74qi5mGPwLsyNNvjS8b8FyL00dWufzW3
         ratRf/IQKPNA9ExI9NKMgFL3dN1ttsAlDQc8BL042/vE0+JWiKekpMm+2ueAniPYEYOs
         NFFrkleT0dNnRZvhAShlOJwGheaEvDkFArPSC4MK9zKiCRrQaDUQfqFNQqudmvsNslFk
         mSmPTeVT3Hrp74/+yDWylcSVMtVNzbTP1e6GUat5xyp1GeeO5yX1kBhFe+WSxOGCAYzX
         YAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763243953; x=1763848753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VckU7Q0ub7K93sRbXU/Ww1Mo9sHn9C1VKL+8yDvS9Nw=;
        b=eEWyir8edeqNAtbe+wmGALaKwWDFwEfppMQJNH3nkua33lGNf+ioyDCaaeczxL2Pb5
         EwyuEcBI/X0uCpe/vEHFQ0DRVtVN67y/L/U1MBJeqoTnmukcjUPivFsEcFz4lC4rLreh
         yn8KicghIy+Z6ATh35vpySdSwPLYGxYLQFQRrxJJgXNEhnOHPDgt5LfFLRuTE/piZIk0
         VVnj5namNiImZoT0CI8a/qM3AxBiROPpY5bYCq4e5Usl9yLpGP9efRW1cmdAnRzfTG2h
         aKG/M8OYKlrn+vhDmeIV2bH1xdTL9U9eg/F8HZbZYGRlPDxnb9aw250wIUch5TA5I4QU
         Au0g==
X-Forwarded-Encrypted: i=1; AJvYcCX76VkTBy8ks8WH2yVEE16qPC6K5cycvVbvlGYAo77g2lsq8lpI/pukoLKcWz4I28gJB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYt4aLXUvXGpteDZfN5ZgvvQAhWqW91+5XY4mfIA+LHGxRgBuX
	IjaZWkQX6R1jevAmCVoTRfT9q28DvsejJxEJNCyOEbTOK+ZSCYsawi5KqBXiroTsEpyW0OGb5wF
	pbMlGPoo8cFVBsDIe5oJvRGMNfwbx+A0=
X-Gm-Gg: ASbGnctthHkoc81J/G8WP+MtWZ/8TqbMcMhYWp/tLiPIXZQIXpxg45ILqQMdJKMl45d
	48rTiqoVKlb4kIPClZjBxFteg0T6pCMbME6k5sAHR4YWMi/J87N4/K8Fej/845owVYpi9ciwhPS
	7S6i3+T54kicRa/KDs5sDMcFUJX/Hxtz4+hKpgoBIAGP3X5p5h6+CVYeqCSA2VKUbXGYpa6Sw6a
	V5hkNtylEfW9cid0Atj8uj650xZY6aSJvMa2uWAsiHyTHerQ+o3/RjqgZFAUwqKkAQhppFsK7o3
	G2LE+VZ95AWv4KiU6ZBZ3MohmB/0kI0WXQZAG+k=
X-Google-Smtp-Source: AGHT+IHfmflYVnd6DDQ63Wk9BdCZI77fGhd5KC2+J4fS7uUr30VH4Jws97VyWrd7rvFnYioHwzRWnFvnRvsyOSogGjE=
X-Received: by 2002:a05:6000:2212:b0:42b:4223:e62a with SMTP id
 ffacd0b85a97d-42b59349bbbmr7873795f8f.23.1763243953226; Sat, 15 Nov 2025
 13:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
In-Reply-To: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 15 Nov 2025 13:59:02 -0800
X-Gm-Features: AWmQ_blHiRkqdyg6Tbr7TQcmnIPZ3QHmZItfmTLCqGJNgSqRIA0Cia0W93qBKWE
Message-ID: <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 1:52=E2=80=AFPM Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> Hi,
>
> We're developing an eBPF-based sampling CPU profiler, and we've been
> investigating a bug that causes periodic, brief system freezes on
> Fedora 43. We've tracked this down to commit a650d38 ("bpf: Convert
> ringbuf map to rqspinlock") [1], which was introduced to fix a
> deadlock reported by syzbot [2].

Sounds like your kernel is missing the fix:
commit 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters")

