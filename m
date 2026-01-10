Return-Path: <bpf+bounces-78440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB07D0CD8E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3C0A30262A4
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 02:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5A263F5E;
	Sat, 10 Jan 2026 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teb8aDVT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A721FF2A
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768012963; cv=none; b=R73aJR6HX7WaUOYgBjfbX0nX8raMi9jkesDAGCuxz9XXuPlovBGvu3cVyWoIgpJHHaii9qQA5x2y5R5jjR79pSqKJQM8oJ9cffZxYCVV6Re01Fxmq3V4XJ6jxzvIcqhbUgMI9eXfNYsZkjOAR4jfCfoVXWaP6IbFGbBqEBWKOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768012963; c=relaxed/simple;
	bh=Cs/hrKTGodK2hLpEUcdQqwz0BRefB04X3sFppe5CwEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIHLY25QQCDSgJFpUSMsR4pVpF/+1fA3Y4PC1HOr8I94WiV51IuN2OyjzBFzZush0WjQsNVHvbLP2kGkC+EpwLxIf88F1jRuPPN688YhJ7i0TQexivQMekTyocViMm5yqHC4346crUmBk73YZC9QZIvHiEScboE9Cprv9DOIeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teb8aDVT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2717231f8f.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 18:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768012960; x=1768617760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC9+biAN1KILtegWcGGy8UcYztxHh3eBFiLomvxFRos=;
        b=Teb8aDVTj3Fjd56kKX402RQB6r/s9qjKd6iM4k0yQtvq21XI2D554B1v9BTT7XadxI
         yn0EPIjn47sd0ihh97CqNpC8Li9oDMzPF3BPmWv6DNnWtOggryeHQFzhzECtcWNfQGNJ
         o/5lGlHebG5gEq4C3wCPncAjuaMXlLqJM1hFsuRUyxG8JCZcJI4oIAUZpJQSgaV0nYtM
         qq5drN+2XfD5aJMoDKpiRKrMcXK+tzqIeHIwFZBgqbK4CGhl9fvMyMjhKkhOEiQlsEXJ
         tzZHfgrtUMl6OcV/kEsIj/nWTpjgvOvjruCAVpMhCnacLH6o66rZRlhCZsfN/+fF+cUx
         uZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768012960; x=1768617760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YC9+biAN1KILtegWcGGy8UcYztxHh3eBFiLomvxFRos=;
        b=aVth2lAWmK3sTDlvRdYMdPRjZ5vjVx98nWL/U0bGD2BWPtGax8XhaVVrRUs/M84Atd
         qkcMkWv4Ahh056Ozjo8biJ5kFfOPh9loreqhihxmb1AZuLzsjaxyGgO9Eyg55CnPryjL
         i0qWfa5Q4nsei4W2nbCJ5+jrwKH6UOiNBcg9TYhDZWCkeRxJqM7LtPNAg+C7hvwr7SDX
         Aaj6FPK9mD6G0EADgpN+x9y/tLICFSl/9VcaZUiE6QxEJCd9Q8/XTm+zV76dHxR0VwKh
         LqmznY9UGc5tEmqOmrYLeZ0CyJ6f1CwacJYLYAydXKT0Fl9R6qGDDB4S451wPRyi7L67
         8W5A==
X-Forwarded-Encrypted: i=1; AJvYcCUZvK7PtjB7deYWEbF/CMiOTiLRWwE740nCDW1ucmFuFBG5laDw3eA2mGNH69RZ7tfO9fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoGUJVq51cXwB8e+Nh0rvh0sc3XuhGjsblU0Wt/utVCkzISve
	LXYkIk3E3Za2QzIOf90a/RMLto9Gkxt9BFvlCjzNwwgWSkKeWYOvDQXRwKIj7YAs3TS/pwE4/QM
	KCzX/HQhArllQIkFkvxdkQwtmuUExWyA=
X-Gm-Gg: AY/fxX4b1kjmjoBZKUTvVxY2SiLV5c8nAkJ3zngRtmyELvCNrgF6VnlCpGCoOP4OwQ2
	3B9xg81L+VpVYHXMRKw2Xhn7LgpG5OD6+mkcexakwXOxwISJuDqnp7LLyZi/bcU/+qqW806dqcf
	vNfnIdpJw68YkRATyaE2Eo3AX+wL6bhvjbTH6juQ/3UCHVQDHun5N0ypGIW3o1jM5lBUo4Iq5Xx
	ZaL+Mcl8pD56bYy/bLA1jKOnRto6MDXSpHa6WwQQAifXPMirS4R1J6pT2+bxTPe08CWc9J02jSI
	bHLQiTnCsvu5iEoLv1q7mnSMV9ke
X-Google-Smtp-Source: AGHT+IEqVkZzGkstjdYrQiTVPP2vr6lxGNdwWrtx+26U3tqXFZE9/A6kLQ8NdQ8dOEsX8G/rPjPKdB4RZ2K4vvQsbcM=
X-Received: by 2002:a05:6000:40e1:b0:431:488:b9bc with SMTP id
 ffacd0b85a97d-432c3629b8emr13307356f8f.10.1768012960014; Fri, 09 Jan 2026
 18:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn> <20260108022450.88086-6-dongml2@chinatelecom.cn>
In-Reply-To: <20260108022450.88086-6-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 18:42:28 -0800
X-Gm-Features: AZwV_QjQLPM4b4V-6CUBAXR1QS1q8Ht0YXFasxqaYRvgD-y99rqQyXQ9HcUk62g
Message-ID: <CAADnVQJtyGS5BQKcnzsqRNEDO7Kcs_89k6Q5tBi10iaff=tbtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/11] bpf: support fsession for bpf_session_cookie
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
>
> +u64 *bpf_fsession_cookie(void *ctx)
> +{
> +       /* This helper call is inlined by verifier. */
> +       u64 off =3D (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
> +
> +       return &((u64 *)ctx)[-off];
> +}

Same question... this can be a comment.
For some of the helpers earlier we kept C functions to make
things work on architectures where JIT is not available,
but kfuncs require JIT, so for kfuncs there is no fallback necessary.

