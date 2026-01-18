Return-Path: <bpf+bounces-79381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13883D39864
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 18:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431B730090BD
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395D23EAB2;
	Sun, 18 Jan 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC7wCdtU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0151DF759
	for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756856; cv=none; b=b2dM2h6vcZsbp74Q0EO5mwVd3M546own9k3kIFGjbHAw1+wtnNQnyf5WSY/CWzvWmqSMppXqFm53hSLCEJUolg0Nr52yktrY8I4Z7JGmlaVH7DdyVfsSEIISjIVLoxdSSkfrQHLVGJywI0L32U5y1DzvQlP634sXq/ED+zbAi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756856; c=relaxed/simple;
	bh=jbVT+n+hXWyHCV2WZg3Nq6x/sxk23UNrTtH/JUKPBJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3rqhMdFNr//wAWKXruVAFpk4CDrdgeXlP7WNiLIpBuI4T47UWZimZy2/6nNSJfua1xcZHSQtCuenDBidR2af0X2jRbsC3HtFcatkfFxkr9jAZzqFKuS0avrLrf5CH7z310UWKUGBGVyfg//9ifZDMISS+c6i5IND1IShB/yR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC7wCdtU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so3098743f8f.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768756853; x=1769361653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbVT+n+hXWyHCV2WZg3Nq6x/sxk23UNrTtH/JUKPBJM=;
        b=aC7wCdtUIOnQfpgc276rFfvNlIvRIB2RdwFDE6J6EXHcG23rHoXMSuqfAZuXPoU+Fb
         vS/Ijj2RKG8VjXXbBYvS0Dcfr4xTOcsFeqQ2YfRTT8M1CDUm/VzJd589n30t6oxBtBrY
         i0/1IeOGkEf7wG2xF8Y5uM6ssOPPrqvMwY9IDEocwEzCWp40ceJCohVKHowCFWWTqycZ
         Apq6aJG8O62je+reSCdLF3oGGS/2fn0M9NtfY/PpEZ2RHsn48oLe9pMEiL0uPo04/g5z
         SiSdi8SqZC2HPrNcRMnWVfb3mUrdjk1dg3A5lAj+qO9y/2zrJ9cVDRNQH2fWNyYn4mfd
         VQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768756853; x=1769361653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbVT+n+hXWyHCV2WZg3Nq6x/sxk23UNrTtH/JUKPBJM=;
        b=k3jfXkbaa+8Hj2gL80PazoUi672kcmwjLtviyF/7VonSQtcMw6XpGkiT+/jiG354mA
         YqQpCzMlV0T8F6sNV9GTRBVKwAmKtzK6ielBSaVhPYR4LuYZUSScQ/yVCAkbl2MTVRYT
         E7DPF6zKcsw0n/D3VrJwpCoS0zw+PzSwHXe36D1skaEJOh3qCO+lUcy6f3VKJKk6spvQ
         reqx9bIyNS5Tkz4qfCWDjyLnOFUQJv/BVWWv0j6aqRU9El7C+4Jtt9QUw3V8NosSxJjx
         gkOZb+pfU8vZr470pchHEFLdhJxRcvMXajgLNyV+oYkmORxD7fqf1AkFd5UBoPAuNdGO
         rDxg==
X-Forwarded-Encrypted: i=1; AJvYcCXORu0Dmg+uI2Br7S+y3vPNA2XDr3b+kKjcSS5w8QYMcoUWuNx3f6MbOYvTZCLBNLNOgRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wZ76y8VQ93juNyhnZNQT/xhmWBxa3iGnY2yZlqyon/jVieI6
	01m0CF7PAZG0axaDepTXv+XbOAVWkHBzAscMfD36fRieyUsgHewmbzMG1JapmJSdXmaMVQe/rcS
	aWY27ghe/bsM9NUj+fGc+2baqiOs7RNUtnGSL
X-Gm-Gg: AY/fxX6p0lTug7sUhNZRLPerplSMI6RJEt3JHySSo4+8nEgfhZD5DlMQZeuzCTXWkBy
	0V1VTLiV5/oAwxKQ4Wu7SS+LvIaJR/xNvD31MaIJlg7RQ+TNrCb5Rd3fnEhQqbvsrBLCDYPsw6e
	6QrA+2oGA2C4pcnMfONRBTWwWoVlFOkeN1Lr4I9+5cuWM0DMsqffbcxNcb/ZM7XjCFL/vJ5f3zQ
	uMcQLh6Rhm/iBqs4LjYbPvu55DKdQKIbOCrRrNJ9AFWCw0bfQvN0SUgx6NYC/vgMFUOsNpkcdDA
	8jG9PeD8Dqg0ABu5UBBbEVySXqC16mORgnQ871SrFQR1d+N1zVfGv2b6cUjKi5jvyQ==
X-Received: by 2002:a5d:5889:0:b0:430:ff81:2961 with SMTP id
 ffacd0b85a97d-4356a082ebfmr11458212f8f.51.1768756852760; Sun, 18 Jan 2026
 09:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
 <20260114093914.2403982-3-xukuohai@huaweicloud.com> <2e5ed01463ae8f79780a42c4e7f93baeafd2565a.camel@gmail.com>
 <21aec5e1-4152-4d51-ad25-91524c544b66@huaweicloud.com>
In-Reply-To: <21aec5e1-4152-4d51-ad25-91524c544b66@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 18 Jan 2026 09:20:40 -0800
X-Gm-Features: AZwV_QgbzSH8QhkIA5IBTf-o2R_jfbCedMdIqj5SuegXfrd15yBgYo1j3Yi0_sg
Message-ID: <CAADnVQLha64x_LQ1Ph+0dEdP2sNms71k41pwEVMwxrbBG78M5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Add helper to detect indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 11:47=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> On 1/15/2026 4:46 AM, Eduard Zingerman wrote:
> > On Wed, 2026-01-14 at 17:39 +0800, Xu Kuohai wrote:
> >> From: Xu Kuohai <xukuohai@huawei.com>
> >>
> >> Introduce helper bpf_insn_is_indirect_target to determine whether a BP=
F
> >> instruction is an indirect jump target. This helper will be used by
> >> follow-up patches to decide where to emit indirect landing pad instruc=
tions.
> >>
> >> Add a new flag to struct bpf_insn_aux_data to mark instructions that a=
re
> >> indirect jump targets. The BPF verifier sets this flag, and the helper
> >> checks it to determine whether an instruction is an indirect jump targ=
et.
> >>
> >> Since bpf_insn_aux_data is only available before JIT stage, add a new
> >> field to struct bpf_prog_aux to store a pointer to the bpf_insn_aux_da=
ta
> >> array, making it accessible to the JIT.
> >>
> >> For programs with multiple subprogs, each subprog uses its own private
> >> copy of insn_aux_data, since subprogs may insert additional instructio=
ns
> >> during JIT and need to update the array. For non-subprog, the verifier=
's
> >> insn_aux_data array is used directly to avoid unnecessary copying.
> >>
> >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> >> ---
> >
> > Hm, I've missed the fact insn_aux_data is not currently available to ji=
t.
> > Is it really necessary to copy this array for each subprogram?
> > Given that we still want to free insn_aux_data after program load,
> > I'd expect that it should be possible just to pass a pointer with an
> > offset pointing to a start of specific subprogram. Wdyt?
> >
>
> I think it requires an additional field in struct bpf_prog to record the =
length
> of the global insn_aux_data array. If a subprog inserts new instructions =
during
> JIT (e.g., due to constant blinding), all entries in the array, including=
 those
> of the subsequent subprogs, would need to be adjusted. With per-subprog c=
opying,
> only the local insn_aux_data needs to be updated, reducing the amount of =
copying.
>
> However, if you prefer a global array, I=E2=80=99m happy to switch to it.

iirc we struggled with lack of env/insn_aux in JIT earlier.

func[i]->aux->used_maps =3D env->used_maps;
is one such example.

Let's move bpf_prog_select_runtime() into bpf_check() and
consistently pass 'env' into bpf_int_jit_compile() while
env is still valid.
Close to jit_subprogs().
Or remove bpf_prog_select_runtime() and make jit_subprogs()
do the whole thing. tbd.

This way we can remove used_maps workaround and don't need to do
this insn_aux copy.
Errors during JIT can be printed into the verifier log too.

Kumar,
what do you think about it from modularization pov ?

