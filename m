Return-Path: <bpf+bounces-41484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA09975D0
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 21:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9434282EB0
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A371E2305;
	Wed,  9 Oct 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioIA+qOg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8B1E1C01
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502897; cv=none; b=nBUFC+9Umu4kZ+nAhVhTQO9oJ0HwwpwnjVrXi2Zm68M+5RIX+MIsAxZxsIgIptl1vO9wx/2aMqT6t5CCnIOncGrmDLyQw1kNnkrqEjoou1gpuAySjYLfStd6ygIDpCveY86zCvE3713OKfs246OKMA15mgxox9PW566n4G57JI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502897; c=relaxed/simple;
	bh=z3ehgoZRYtG18GSLZpqYRgsxxrjpT2JqJ2f5zeWScTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ENvPnzHHDO5HFwiNmgvaJ/fzIU0flCb2APCR6GGkNJBWzChsjk9RuTl1qQqzUSt6eQRZwdchEy9ioEkmIGnNmwnkoOXB3u1JAXVikOTr22r1ZAyoMiHISt/qYxvJev+ISEVBAqjY98SfTxhQZ56PYbnj2htbbtGOOVysBkfrxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioIA+qOg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e029efecdso154869b3a.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728502895; x=1729107695; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ot4oj59HT5IsaV1GiBJ31f69dh7Ad1WlzFMf1xoXZxw=;
        b=ioIA+qOgl/bUaOtMhtJlDrhy/NNt3J13li4bhxNii7URy3ByUdIvDJOsMAoTQGtp1f
         UbqRORlYhEeYHv73XpuYgHOqkKBffeKptvt4v6igT2oDh425ZBpw34aoW42h7wOryAqN
         Vy/oI/MCx9X/DhnmUzr7Y/z/YeRE6yC59YWFSKWU3y86py/qPj131wEVt4BxL8m00Jum
         AHOMVriwNw/ApLqU2vWj1vu/cpQ+rRpakVwPY8R4bFaC6CynmsRGU/PXMpaoA2NQIgLn
         wuIiyxqrQOz3FP2aELFgahaVPyRtrs2fCH7ohhy5giDif3KUyZ32N4aLo3gJmMhSJDD4
         UNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502895; x=1729107695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ot4oj59HT5IsaV1GiBJ31f69dh7Ad1WlzFMf1xoXZxw=;
        b=JNn1bJQzm+jvh19VdfJjH0iZYKQ5HUg4g3PTq3VQ9c/g4pdEW5ftwKj1FppnynDGZq
         hpfVIx71P0+OYu558hzWKnH9dBorj1g5D2SJ5hRqGRGoTvKJ3vgMiDZX/k7qnXRsd8pj
         aPQ5xjm33+oyrLaWS4W28yos2iSzT3QLkEgZdKyYp0LR0hgq5sXWi7Ls/pwhPOYI73ga
         0b+YfzTQaIFwpoBOmTABiqm3JrtTE9Swj1Y3l+TAmnsAiq3Hd3TLKUa+V8sEYVFI3zNh
         FNXNMQ+lAJv+jUBH8siFwcBrE7ApKeMNn6oXDnUJBbJBjVjJNxkdZpnTBqBnd0PG6yxH
         PxrA==
X-Gm-Message-State: AOJu0YyIGCMQ1u15aFTNEKSEepO3+6KVOAYQoVOTc3tDKz/lCXF47r9I
	rcbcTWGTZk2teemVsNLJJNyi7RIDBnI//jjQUo0Er40AEr8FnH1OEs7HlA==
X-Google-Smtp-Source: AGHT+IHBPwTbirtbTCPEOrWhx604YeXxXXJ3nItDExIYhB2SuoUylE8lQvOIoZNLlOZzcaUHYpAaiQ==
X-Received: by 2002:a05:6a21:6e4a:b0:1d6:de67:91ca with SMTP id adf61e73a8af0-1d8a3bc50e3mr5268419637.4.1728502895002;
        Wed, 09 Oct 2024 12:41:35 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d4a0sm8114052b3a.212.2024.10.09.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 12:41:34 -0700 (PDT)
Message-ID: <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop
 back-edges
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Wed, 09 Oct 2024 12:41:29 -0700
In-Reply-To: <20241009021254.2805446-1-eddyz87@gmail.com>
References: <20241009021254.2805446-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 19:12 -0700, Eduard Zingerman wrote:
> In [1] syzbot reported an interesting BPF program.
> Verification for this program takes a very long time.
>=20
> [1] https://lore.kernel.org/bpf/670429f6.050a0220.49194.0517.GAE@google.c=
om/
>=20
> The program could be simplified to the following snippet:
>=20
>     /* Program type is kprobe */
>        r7 =3D *(u16 *)(r1 +0);
>     1: r7 +=3D 0x1ab064b9;
>        if r7 & 0x702000 goto 1b;
>        r7 &=3D 0x1ee60e;
>        r7 +=3D r1;
>        if r7 s> 0x37d2 goto +0;
>        r0 =3D 0;
>        exit;

Answering a few questions from off-list discussion with Alexei.
The test is not specific for jset instruction, e.g. the following
program exhibits similar behaviour:

SEC("kprobe")
__failure __log_level(4)
__msg("BPF program is too large.")
__naked void short_loop1(void)
{
	asm volatile (
	"   r7 =3D *(u16 *)(r1 +0);"
	"   r8 =3D *(u64 *)(r1 +16);"
	"1: r7 +=3D 0x1ab064b9;"
	"if r7 < r8 goto 1b;"
	"   r7 &=3D 0x1ee60e;"
	"   r7 +=3D r1;"
	"   if r7 s> 0x37d2 goto +0;"
	"   r0 =3D 0;"
	"   exit;"
	::: __clobber_all);
}

> The snippet exhibits the following behaviour depending on
> BPF_COMPLEXITY_LIMIT_INSNS:
> - at 1,000,000 verification does not finish in 15 minutes;
> - at 100,000 verification finishes in 15 seconds;
> - at 100 it is possible to get some verifier log.

Still investigating why running time change is non-linear.

[...]

> This patch forcibly enables checkpoints for each loop back-edge.
> This helps with the programs in question, as verification of both
> syzbot program and reduced snippet finishes in ~2.5 sec.

There is the following code in is_state_visited():

			...
			/* if the verifier is processing a loop, avoid adding new state
			 * too often, since different loop iterations have distinct
			 * states and may not help future pruning.
			 * This threshold shouldn't be too low to make sure that
			 * a loop with large bound will be rejected quickly.
			 * The most abusive loop will be:
			 * r1 +=3D 1
			 * if r1 < 1000000 goto pc-2
			 * 1M insn_procssed limit / 100 =3D=3D 10k peak states.
			 * This threshold shouldn't be too high either, since states
			 * at the end of the loop are likely to be useful in pruning.
			 */
skip_inf_loop_check:
			if (!env->test_state_freq &&
			    env->jmps_processed - env->prev_jmps_processed < 20 &&
			    env->insn_processed - env->prev_insn_processed < 100)
				add_new_state =3D false;
			goto miss;
			...

Which runs into a direct contradiction with what I do in this patch,
so either I need to change the patch or this fragment needs adjustment.

[...]


