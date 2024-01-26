Return-Path: <bpf+bounces-20428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA783E3FF
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A106CB23B42
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5724A0F;
	Fri, 26 Jan 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2/K9Oa0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1924A05
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304761; cv=none; b=LBoOU3oExIK/yDlpIgL+xcCKsfFK7qfNIcXA9/h/DXK4SargkbzQbQn+BANCBNTuavccH/UaAn/ajpMrMBUg/Ab65JolaqscO/C5JgVuKRDX/gI70mb9IgDA6sTfWXkE+WFtjrrU4wjNcCUmYHcu2aCxd80myJn5vOQNQy2xHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304761; c=relaxed/simple;
	bh=VN+KOJeP5QogclSjlilbG7TUNE0t5vSuGLfo6T/hcBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hAxFLOntp/CXx5/Er816W5ytRwaMOHkyyBj1+WxKSCZ+oCK0DNNEjNzZ/7/a0PlkW59srFw3dKIdjaMkms1hI9MH5MQEQAsNIgOv3fgxfctwScd6xdYiOx/OJEhbXmJw2q2aFb4vZPBo5J27rmjqWMighZao4s9y6fsItCVWwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2/K9Oa0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55cdaa96f34so4297423a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 13:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706304758; x=1706909558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ie/AVQBlSQAD0WU3X3m0U2zLwT138gxLHd5nijOI/Tc=;
        b=Q2/K9Oa0pxeZmrXIoDafJHZuaeSUzjNOaEd2EZCMzaGK7ivxZ5OYYzPiTMCahVHEmH
         DQT/3tVFREVl+H0aRR3TMudEITrkhwAkghhNSgqrgJnzxhttts172lTeA57TYLsMUihM
         yYzIHKnukY0ibMLO10F6Wk98sk0hsveUBovT6oO0egphOJ35OXItRm2uv6YkZBuxohqJ
         DD28euetmDMs+COAtQgATLeoBYwHhAgdPfWfTW1Wo7h6D77q8NivbfKftxmZgHzKHrdD
         CT1CGpIlJN1FcBALUSJgBro4/seyWnLn6NJeGdwZQYvmJEuKWdkyZ/zWCKfcfAt4qd7n
         qQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304758; x=1706909558;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie/AVQBlSQAD0WU3X3m0U2zLwT138gxLHd5nijOI/Tc=;
        b=jN5nM41z25ZvyvgoxQGz4hryFrfhXAGik9yK6AAvsA3w3gXi9xtesgS6zUvpZutsBa
         UiEpx4/mNmeKBTXqUhEdHaQ4InIiXylfj4/M4SnZd7xSH9acgTxxLI9WFh/RtcHgXNss
         VzGitJiSe7UOmYhwagpTE1cM+RBqHK39yXFeC0aFK3RlGFmraYfVJ/eAq9gKSPMbFmRR
         TPJrySyKSCTEhdWSHU8NDEP9mOrfaOm/qlebjxkCo3lz483qHlYan/Q+jRV2yeAFg+cN
         kT2t5PGbyuHefhv6oXKfETc5uH12hAPfHTBU0Ti22cqD/7qO9mK80Rxj/kIHZBMiY2eV
         t/xw==
X-Gm-Message-State: AOJu0YxDXW7zR4724l47JNvERQ8E+pigbKsa8YQiKQVxte644D+oeY8J
	xtK8/XWpuHAgkkuMt6sOoG2BVF8SJit3pvMmvlzBE0QzmLYdvJKo
X-Google-Smtp-Source: AGHT+IEuHYfieCee+Vdq6vQ4z2vmJAOBivPcYh5YOYMDeUfQMq7JBP3tkIaFswln/H2OcHOixtjzpA==
X-Received: by 2002:a05:6402:b19:b0:55c:9c95:5430 with SMTP id bm25-20020a0564020b1900b0055c9c955430mr2250329edb.4.1706304757669;
        Fri, 26 Jan 2024 13:32:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a056402428900b0055d333a0584sm924730edc.72.2024.01.26.13.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:32:37 -0800 (PST)
Message-ID: <63c28870a70aceed3385b2c018880399f32357df.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: fix __arg_ctx type enforcement
 for perf_event programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Fri, 26 Jan 2024 23:32:30 +0200
In-Reply-To: <CAEf4BzY8XoPmHCTzp=THQr+kYpXGo5G9hLwzJWGSquFt-DZHnw@mail.gmail.com>
References: <20240125205510.3642094-1-andrii@kernel.org>
	 <20240125205510.3642094-3-andrii@kernel.org>
	 <3223cf369859b119914403664f549d1fb20bc644.camel@gmail.com>
	 <CAEf4BzY8XoPmHCTzp=THQr+kYpXGo5G9hLwzJWGSquFt-DZHnw@mail.gmail.com>
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

On Fri, 2024-01-26 at 11:06 -0800, Andrii Nakryiko wrote:
> On Fri, Jan 26, 2024 at 5:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2024-01-25 at 12:55 -0800, Andrii Nakryiko wrote:
> > [...]
> >=20
> > > @@ -6379,11 +6388,21 @@ static bool need_func_arg_type_fixup(const st=
ruct btf *btf, const struct bpf_pro
> > >       /* special cases */
> > >       switch (prog->type) {
> > >       case BPF_PROG_TYPE_KPROBE:
> > > -     case BPF_PROG_TYPE_PERF_EVENT:
> > >               /* `struct pt_regs *` is expected, but we need to fix u=
p */
> > >               if (btf_is_struct(t) && strcmp(tname, "pt_regs") =3D=3D=
 0)
> > >                       return true;
> > >               break;
> >=20
> > Sorry, this was probably discussed, but I got lost a bit.
> > Kernel side does not change pt_regs for BPF_PROG_TYPE_KPROBE
> > (in ./kernel/bpf/btf.c:btf_validate_prog_ctx_type)
> > but here we do, why do it differently?
> >=20
>=20
> Hm... We do the same. After this patch w end up with this logic on
> libbpf side (which matches kernel-side one, I believe):
>=20
> for KPROBE =3D> allow pt_regs (unconditionally)
> for PERF_EVENT =3D> allow user_regs_struct|user_pt_regs|pt_regs,
> depending on bpf_user_pt_regs_t definition on host platform
>=20
> That should match what the kernel is doing.

Oh..., I see:
After (and before) this patch on libbpf side for KPROBE/pt_regs
need_func_arg_type_fixup() would return true,
thus bpf_program_fixup_func_info() would apply type transformation
(convert it to bpf_user_pt_regs_t).
And kernel before the arg:ctx series expected bpf_user_pt_regs_t
for global subprograms called from KPROBE programs,
hence old kernel would accept program with KPROBE/pt_regs
thanks to libbpf manipulations.

I was put off by need_func_arg_type_fixup() returning true,
thus requiring change, and btf_validate_prog_ctx_type()
just accepting pt_regs =3D> not doing anything.

Thank you for explaining.

