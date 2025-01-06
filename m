Return-Path: <bpf+bounces-47960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11645A028C0
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DD016084A
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51B342A9B;
	Mon,  6 Jan 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="d4VhFakm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2B224CC
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175865; cv=none; b=gHL9mBYjdDnp67bf+uSxS/laoacqfXf609ew1AqmVE2laQ0ceIWuZ5fzHt5uBu79ES1Wml8+dGOxJYjIbk36W1RS+815lh8RCsW8Xgh5RBZ3kxSanLpdducDmap+eAd5SZSnBXVSWIPp1w4qV0UFNdOSpESCcO/sdpbItaV3NVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175865; c=relaxed/simple;
	bh=6vcQULMRy2YqybMpQ94Jq22gP690owsO+10Hh/qiAwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhxHlgDrRZ2Hw3pdeiIYI6knsl4W1CWxgsK8VOWEEPa+diEqSh1p7vIMkitwiD13/uCI/i1ftondolyuB7Zb6l7FMEKd3atxhwbjH7z0ojwbsZGz12KcBAIfwAnwx5/f48hHl1jockegLYMlX8k4b+DSzB1MsnkkfWfP9ilRj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=d4VhFakm; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so19093406276.3
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1736175862; x=1736780662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IujLzgPkcDMaBEns7uVMd2GFkRTSWwJ7wQk9sYhLuyM=;
        b=d4VhFakmcbhKq+XHMT+0Oyn3H3zEcvpl8jaBy+PL4Lu5zj7lIrz7Rhu++mmBMIZ7ru
         8/zRNrJ/uK/hyiCAtEq/NIjVXenYTg0e5V+sRjJUU9mi1ASwYyZrIoMGqWy5Zl8O9c+5
         jV2tZenWNX/2YEl8eb3MrvlV/o3Rtcg2fnVCO0uC5U+8kYgoxxbBKmbrTQlOut6HZVmB
         cyb0TuG5yG2VB6avMw+Ln3E8NnXToLGqSLq7WC+BIB4ephmpTIyFvoZy5QlT+pC4Wa/+
         7PQ6B0lI+tdio4BjtRbsDV+Gm8xlRFU4opz74tNP/Xtyw8UNncnc7Y523QKGBi5J34IH
         e0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175862; x=1736780662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IujLzgPkcDMaBEns7uVMd2GFkRTSWwJ7wQk9sYhLuyM=;
        b=VO8/M/2MkjfypMsl2tkl5Bj2bpcSEhtk24dEI40etPHxBBgE8RJitB8B7JvmNQnuv4
         tngh/Yxq2WmPeNh3Ar6gTCgKDkuTcbpCdeWhVRNf2qHeVxUrO4pqCCla0AzumIjQt/dV
         4vqwHPg1cZzejvhPUAgVC3Q2BefI9SA+W+QYGnhejxSOcRX+iwaVWKJLflLlN86DeVbE
         xWgy67SxgrSNRHVRdlMgkErWxmy+EmFZGss/CafyJjE/jAyIbp51mYhjm+YIwuavYXMD
         ipwY3k5H2HeraHZXh9YLg/Grolrk3MvD+166HJ0BWECTTwb0UgTWcU4GFHb88RlEl19K
         pGyw==
X-Gm-Message-State: AOJu0Yz7x9YKQmC3rLBiMGMJ66+9T/UxDpe3N+FxPV6ovVtkVGH0bam0
	cNPG+TXg2snkeiv6kwIVCMGF8k55rQfkvOYXb/IGvpVg/wTVDpPit3M4ZycSPIUnL92vl3HA2qf
	RMpfXkACE5ELIPwRamgmJ6kCeQzJvYhvwO+HbTCBK051ayEHXhTs=
X-Gm-Gg: ASbGncuub/Dm95SzlDKS82/DltIkflzBuLP+S663wBuARgX61v9D3cn2CRjKnyRl6U7
	MwIKvMZx49cuL0U30YO9AuoIEDXALUziFYu7yKALf2ejNb8kU+dphTQ==
X-Google-Smtp-Source: AGHT+IHaQpAL33KQht1Mt5NOSXCC5a4QlSWD27lqBIpY/Fr2ma4rTZ2/U35vZ7Mgt8OiEc7FelnCqhuwc3mFaxsswpg=
X-Received: by 2002:a05:690c:6f83:b0:6ef:7370:9716 with SMTP id
 00721157ae682-6f3f823efaemr396642567b3.41.1736175862055; Mon, 06 Jan 2025
 07:04:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250101203731.1651981-1-emil@etsalapatis.com>
 <20250101203731.1651981-2-emil@etsalapatis.com> <ac3eda5992a9fbee296abcbc917d5521da0be83c.camel@gmail.com>
 <CABFh=a66Fk70ipHbrq+Jh-hA33vHq0fOJd+R9=1tRA1t212CzQ@mail.gmail.com> <fbc6c684c4d374a3b7b08198bf4778c05963a313.camel@gmail.com>
In-Reply-To: <fbc6c684c4d374a3b7b08198bf4778c05963a313.camel@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Mon, 6 Jan 2025 09:56:58 -0500
Message-ID: <CABFh=a6a3OoFnVgKM1Vo_ierEH0RcUHtZQjvrr4570iRwMqgQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see, thank you for the feedback. in that case I will send another
version that handles bpf_loop.

On Sat, Jan 4, 2025 at 7:11=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Sat, 2025-01-04 at 14:25 -0500, Emil Tsalapatis wrote:
>
> [...]
>
> > > > @@ -19048,7 +19066,7 @@ static int do_check(struct bpf_verifier_env=
 *env)
> > > >                               if (env->cur_state->active_locks) {
> > > >                                       if ((insn->src_reg =3D=3D BPF=
_REG_0 && insn->imm !=3D BPF_FUNC_spin_unlock) ||
> > > >                                           (insn->src_reg =3D=3D BPF=
_PSEUDO_KFUNC_CALL &&
> > > > -                                          (insn->off !=3D 0 || !is=
_bpf_graph_api_kfunc(insn->imm)))) {
> > > > +                                          (insn->off !=3D 0 || !kf=
unc_spin_allowed(insn->imm)))) {
> > > >                                               verbose(env, "functio=
n calls are not allowed while holding a lock\n");
> > > >                                               return -EINVAL;
> > > >                                       }
> > >
> > >
> > > Nit: technically, 'bpf_loop' is a helper function independent of iter=
_num API.
> > >      I suggest to change the name to is_bpf_iter_num_api_kfunc.
> > >      Also, if we decide that loops are ok with spin locks,
> > >      the condition above should be adjusted to allow calls to bpf_loo=
p,
> > >      e.g. to make the following test work:
> > >
> >
> > (Sorry for the duplicate, accidentally didn't send the email in plainte=
xt)
> >
> > Will do, bpf_iter_num_api_kfunc is more reasonable. For bpf_loops
> > AFAICT we would need to ensure the callback cannot sleep,
> > which would need extra checks/changes to the verifier compared to
> > bpf_for. IMO we can deal with it in a separate patch if we think
> > allowing it is a good idea.
>
> Not really, callbacks are verified "in-line". When a function call to
> a function calling synchronous callback is verified, verifier steps
> into callback body some number of times. If a sleeping call would
> be discovered during callback function verification, verifier would
> see that spin lock is currently taken and report error. So, this is
> really just a check for particular helper call.
>
> [...]
>

