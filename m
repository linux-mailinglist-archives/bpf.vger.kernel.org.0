Return-Path: <bpf+bounces-77933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7B1CF75D8
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 09:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42734303F483
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF330ACF6;
	Tue,  6 Jan 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZwDaoWC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84949659
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689698; cv=none; b=EY4+sYRMjcpWLEiCm9CDQCDEU6Yh8B++WtyyBFrh/GEFIox2TkVGSJIn6WImddkVbd7XS+LnkQYXpF1zH7fv5Zk1CvnmId4R59xopgK9+TkHmXdVy10k6r/tIhS6k3cuHjerhP3l84VGsLDzvmbIjmuYALZFJSSclBy48G9pjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689698; c=relaxed/simple;
	bh=PudlsRY3cvqbF7BFTjTmjHdd6JA+NhtrLbq618w/VX0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZdAx5CW6zpTktYcLu3t8u978AwvahOkFkkbl/v1PGpLz5AzACp44EH+FTXTJeVUIQfNsRK0C07a3t9pZeKV2I+quqcK7ce1CegbRkQaDSmgOWfBXP6YfcrT6j3vEBVYRaO9DWPN417NvdCJBogR+WQNp/0iLaQykh5fTxfxlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZwDaoWC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbc3056afso335859f8f.2
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 00:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767689695; x=1768294495; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5VFZIns8Sps8uOV+Lb1ng4HSSezSvHcqd+Ga21Q6rkY=;
        b=lZwDaoWC0pLFrRoqBVNRfWw/rw97ABblYqrkhTHMC+N1lyTQ5JW/CT+h2HZjlhCiXL
         /4chn7qXE8Gsukd7D9w+MbECleYtCrZrLt6axk5b0NX40FsXcOaV/qFYVTjrcZn/0YgH
         BYMrMZHH+HKRtrg2kMSM6kSzvTZWAunT2JtZyWSLdHNaTJxXO8La4ThR24CQoMEX4LYG
         d+VpoP4ftWiUOlDIVCljKijAqdSqzXB4eAeQ8oCYoqe9ukBP2uu7bUscbAVGjT2MpASg
         GY1SjDsRg8Z65J3CxZTYNFlnhmAZIB4Cj/8puVaOkImWNuwPpz/ChiTG4Wwpd4V5U92q
         tVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689695; x=1768294495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VFZIns8Sps8uOV+Lb1ng4HSSezSvHcqd+Ga21Q6rkY=;
        b=c1b89DXr777LXON8MjFOATditEduqVlfXR93oU7+6C3YoImdyFXtMfCQK0GQVUVRB6
         wors+BgwArei54o82o9jf2gFY35xCFsJWWtQIDOGwcqTmR3o+QR13hnpXTRlzEYo7XPk
         CDmjF4j8aaz4P8onuc8ttUR/uVzkB3xXEuGCP0zW7WDOXrilu/swOaMQYdWRBQYAT2pE
         UDWHu8n7Dcn5ch8TkJnlncFz1xdveSZZ7kun4trPwRNeN5UWkhzuEaOF93EQu0PBNSvA
         Okhcu0Ftor14bo6GjX9+EvFH7iw71vQyzlLXOMhBSXnOK/I4RbXEU/yZSth39GVb94yq
         Zvwg==
X-Forwarded-Encrypted: i=1; AJvYcCVe4l2cg5Yc4zn9CLL100RdO0forgwLVUyoFQQAj+Hy6ZAGCrHQRswq/khkueKFRc4KHec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5h0J16EheglTd6q+oOy9h8R+y2+1CCr4Zn98EwPefWHg4iOCk
	Tsgqf7N32jmEQIED3tzAat8zj7JzlEP35S+NpLJeA2rHU+sgkLFt90b/
X-Gm-Gg: AY/fxX7JCbW/BuuDtDV+WVt1U7mLLM2OQ0/UtQnm8D70nUwCw0kuLxxXXsD/6UpMwdY
	ODlK4ns3m11Yezfkx0I22+e2shgvIJjlIklZexFDGcWICGU+TJ2BawbEmM0X0Q4qHIsfXS90KpB
	d4LDTG4H2wT2SiDtm6PyAZpNLl3Bam3YvpxlNlEGFkoPeUuvFsk3w8Tj/xeHr0/nhZsFsnzr3ZJ
	n7H41OSmWlEXs41fZcDpxI3/MPM//4dkd7ekLVohEVrM39BEjulxgiJ4Dwsjm3mL2cEqicsWyPO
	XRWq5vPtclVugiKZxSoM3ldrjqYeoSiqsnKZEcWl3U/IqIkcp1viBhicUVdrtriUMX24Dd91z9g
	DPQcR4mPqhzeekKTO7jsijmVLwD5ikveMZeZf+TG4iY4reaG91wo9/FWEkKMM5TzvvmovdI2HU6
	k=
X-Google-Smtp-Source: AGHT+IH1yCSdo0wPw/fy27nRhjvHjHheYMekyT9VVsyxylC5DTp4JUsf3SZIIRTA7LE1dNPIlcouGw==
X-Received: by 2002:a05:6000:200f:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-432bc9f6dccmr3306578f8f.38.1767689694636;
        Tue, 06 Jan 2026 00:54:54 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm3075703f8f.31.2026.01.06.00.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:54:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Jan 2026 09:54:51 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
Message-ID: <aVzN28i92roV1p4q@krava>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
 <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
 <CAEf4Bza4fD5WWWBxJk0dd_xvgPR0ORZpcp1wiahyMPjvdoWG0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza4fD5WWWBxJk0dd_xvgPR0ORZpcp1wiahyMPjvdoWG0w@mail.gmail.com>

On Mon, Jan 05, 2026 at 03:20:13PM -0800, Andrii Nakryiko wrote:
> On Mon, Jan 5, 2026 at 2:33 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Jan 4, 2026 at 4:28 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> > >
> > > In current solution, we can't reuse the existing bpf_session_cookie() and
> > > bpf_session_is_return(), as their prototype is different from
> > > bpf_fsession_is_return() and bpf_fsession_cookie(). In
> > > bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> > > the cookie. However, the prototype of bpf_session_cookie() is "void".
> >
> > I think it's ok to change proto to bpf_session_cookie(void *ctx)
> > for kprobe-session. It's not widely used yet, so proto change is ok
> > if it helps to simplify this tramp-session code.
> > I see that you adjust get_kfunc_ptr_arg_type(), so the verifier
> > will enforce PTR_TO_CTX for kprobe and trampoline.
> > Potentially can relax and enforce r1==ctx only for trampoline,
> > but I would do it for both for consistency.
> 
> Yeah, I'd support that. It's early enough that this shouldn't be
> breaking a lot of users (if any).
> 
> Jiri, do you guys use bpf_session_is_return() or bpf_session_cookie()
> anywhere already?

np, we can still adjust, it's in PR that's not merged yet

jirka

