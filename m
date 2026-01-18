Return-Path: <bpf+bounces-79384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C9ED39B41
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 00:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 488A6300216B
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F46931A06F;
	Sun, 18 Jan 2026 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2skQQHx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BDB2356C9
	for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768778594; cv=pass; b=JsStEgIb7GrOeMxyKBFAU+9ISXd8a9CnGKOb3uigRNkj2nrtfMLNP9SfDXdOSovFP92YIe8/kU7x+SrMAQHGDlhhmAhR9qkxCxN172mYfTPivtIENDar/23SvxPcVz/QwU0CvRsAeWthkoH7z96bttsPFxYo/9qxx76OmGeiVaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768778594; c=relaxed/simple;
	bh=Qj9+bs6cuOoBlqZWY25mJTqCjRNyWKyN1e3Xy+xHVDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKHFemJXUu6JqmUDH+c4nkd2eKwp2kq/5hvruFO1dlRgeeOcS1nlps+sS9fu+FHBPNHfU4ppgppZvfRZ1bEPJoGagFRR+bTy9xH1+yGFjao18LYirQq2RvrPevxeFpmCBJiLKAxKOiaXz/ZMNQNEVs0J/59qMIX95ftTBZuHMvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2skQQHx; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so34629855e9.2
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 15:23:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768778591; cv=none;
        d=google.com; s=arc-20240605;
        b=BSIRhntK6p48BhZaNwFCsi4XjbEzjz0SXtNRV+LL4g2o1nlXCIx5kjfVEyqxhKqnKe
         YSFyHphSIexSLCR6cqYcEX8pOaEn7X9gU7TjueEG6s/Ia802DCrHwAqSCMab4IGuh4fG
         CsHv+/0hdotVw7AB3QNFKzCzGZEW48dxQHHwt27fLQOxec2d4iBU2QaXJwxSgan79yHr
         ZCZ/bKvLAaSVAmttsGndNC/0p0s+grwkZ+nNUtCXmtydeCmHrb31sqPMdUS6HGYBQpd/
         d3VKXTXRyz4sBqPszxPOeokyGDM/7ygFjXZi3FDd/o4SvAegZiIJgguBwOBbhMTfiLnD
         LrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qj9+bs6cuOoBlqZWY25mJTqCjRNyWKyN1e3Xy+xHVDE=;
        fh=2jggWsjNF5zDdILyVgXa8wFRyDjcmzPGMjLurH+hg/Y=;
        b=V/MQ33kXHl5V6QLI9OainrjuG6t/5OPa8ymjewQQMJENarYTY8suXUPoBMAi5POPaQ
         7k5PHF+QpYxMhsuAqsxKNFmhx1cwkvl0K+hmNj6PTX1MYcWcpVQc6uQVzyJOmk3GDPQ4
         Q7jYxkWQA+qhoO9ULFZSwDp+SqdzRW6+cPFjXfPrn0O1pthsxKGxk/SH7/qCifA9kOnk
         m1dT4n7HEVJlcemRMgp5W7rbyfRcr4u0GJDoWlIsslIqgYc5DsN41HKMZZuUibkS0egH
         QDJV2r4xf+hzFHCU4/vYjiKkx2YKajOTOZyrX3lCJKxYJHaN0ZqLvHVqd1ZHa0Z950pR
         mmcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768778591; x=1769383391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj9+bs6cuOoBlqZWY25mJTqCjRNyWKyN1e3Xy+xHVDE=;
        b=Z2skQQHxrVXiP9fibOwOel9AW70fF7H+X0GufDemqFhH1lhwv1I2ukbU4/lnP+YvQY
         Bna6Qza5C8Uq01g0zw0iRAponSkDxlTSzuAaNh6JVaMfp/hO0ME+DLOB/2OnXcMuDD0z
         HZqAMKYPR4lZdOL782DJhtKKYsQB949HjYGydGarWOk5rdmXA0G/l25+2qmBElKQ+bF1
         KmMtVvBENSP+rrxTMGAs4My/QkpCIVlW44i0z8/I7/+4QaZmFqRJoB0UCbHmRZvCnrUb
         oYx/GO5GQhYIF1KdgScjVXqUmsj+OboBOMHXLJ/06ql/63LJ2St00c6B/V0g/RXbKuDE
         v2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768778591; x=1769383391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qj9+bs6cuOoBlqZWY25mJTqCjRNyWKyN1e3Xy+xHVDE=;
        b=NMTSzTBSc0pOwR+SVHTPYC3hCNWLjUoli0OH0wHfTiYNj8bcppVqqmE0sCpdYwC4JX
         tGb8RoUa/NycGbxfuP0x0OjMirVMbQpcHxcEtakXf6ZpsndevO78Wv9WlXZOYTLtLnqJ
         iwJW1bIiCuviDevswF8PQ42v131uU1fFIdFNLzn4nliFeYEHvzhfOjU7gW7easuBI4fH
         oLbCguCQB09K16BJ63tnZTBGEODiY93YgJD2BMdYgjn6bh6k/6XLhQON4Kc7E3zRdGLX
         3R73Sr7mdsX14E3SSTe6L1v6aBWMhdIyQVOBbaipJHv8WOGmUzK3fuRop2Cpg99V/kxZ
         KTiw==
X-Forwarded-Encrypted: i=1; AJvYcCWHIWLtFcYzFdiHyjehqFNggiUytJOKEE3ovXbAcrydoCMRkfw2jTkV89cUK/VZvmf31pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiUfheeDA4gEoeNV43dGgBA49Xmmpyq6shKYuEQ8HHdcX55uT
	83O8Xx9r9P6crXWzSEc8PT9Joc24Ul4FNtfrcrzOoYTeZfZ9L4chK8SNgZ07/3oWaHbz3ZNOy7m
	zyUsCfXuU4jzHgJSakNq8VUjIV9SPG6Iqfzxt
X-Gm-Gg: AY/fxX5pew1wCzTUjKCmpTKgzrzhD6ZGae8MBDr7X48ttniqlkKd/uzFFz36lmYpfq+
	N/QNUzHsqAUGND2SRRk/gZ44VdTgvD4E+YL9wZNfVdnIjXeJlmcOb0axeSduQsPmWccCS+t2byh
	GUhaX5rN5OqnMafh1T/BFVjtJxj3+Qn7FBp4/g5KfnnWZ05P+8KKshnCd/s1yCoLtpJxNsQPN0G
	YOwKGPRtO4DykOrAIi+FveleU7CT50+jYVeCIzP/+yxflE9p1Jk1ctPcO7xQp2dRE5NDK4IIo7Q
	5t6bXrYB04xvVfzPP+caHA4m+RRkf+2v8juoXXtD
X-Received: by 2002:a05:600c:4e50:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-4801e34dafbmr115818315e9.33.1768778591376; Sun, 18 Jan 2026
 15:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
 <20260114093914.2403982-3-xukuohai@huaweicloud.com> <2e5ed01463ae8f79780a42c4e7f93baeafd2565a.camel@gmail.com>
 <21aec5e1-4152-4d51-ad25-91524c544b66@huaweicloud.com> <CAADnVQLha64x_LQ1Ph+0dEdP2sNms71k41pwEVMwxrbBG78M5Q@mail.gmail.com>
In-Reply-To: <CAADnVQLha64x_LQ1Ph+0dEdP2sNms71k41pwEVMwxrbBG78M5Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 19 Jan 2026 00:22:35 +0100
X-Gm-Features: AZwV_QhXNCnBfXpzOxaenytG-TJEPUUqlLt6PeHTKFkO5S-gYxj3GjU0W9a_p0E
Message-ID: <CAP01T76vdqFAa4zYBsDdijY==CrSJ=Qh7iki+y=2_G_EUBr+PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Add helper to detect indirect jump targets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Jan 2026 at 18:20, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 14, 2026 at 11:47=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.=
com> wrote:
> >
> > On 1/15/2026 4:46 AM, Eduard Zingerman wrote:
> > > On Wed, 2026-01-14 at 17:39 +0800, Xu Kuohai wrote:
> > >> From: Xu Kuohai <xukuohai@huawei.com>
> > >>
> > >> Introduce helper bpf_insn_is_indirect_target to determine whether a =
BPF
> > >> instruction is an indirect jump target. This helper will be used by
> > >> follow-up patches to decide where to emit indirect landing pad instr=
uctions.
> > >>
> > >> Add a new flag to struct bpf_insn_aux_data to mark instructions that=
 are
> > >> indirect jump targets. The BPF verifier sets this flag, and the help=
er
> > >> checks it to determine whether an instruction is an indirect jump ta=
rget.
> > >>
> > >> Since bpf_insn_aux_data is only available before JIT stage, add a ne=
w
> > >> field to struct bpf_prog_aux to store a pointer to the bpf_insn_aux_=
data
> > >> array, making it accessible to the JIT.
> > >>
> > >> For programs with multiple subprogs, each subprog uses its own priva=
te
> > >> copy of insn_aux_data, since subprogs may insert additional instruct=
ions
> > >> during JIT and need to update the array. For non-subprog, the verifi=
er's
> > >> insn_aux_data array is used directly to avoid unnecessary copying.
> > >>
> > >> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> > >> ---
> > >
> > > Hm, I've missed the fact insn_aux_data is not currently available to =
jit.
> > > Is it really necessary to copy this array for each subprogram?
> > > Given that we still want to free insn_aux_data after program load,
> > > I'd expect that it should be possible just to pass a pointer with an
> > > offset pointing to a start of specific subprogram. Wdyt?
> > >
> >
> > I think it requires an additional field in struct bpf_prog to record th=
e length
> > of the global insn_aux_data array. If a subprog inserts new instruction=
s during
> > JIT (e.g., due to constant blinding), all entries in the array, includi=
ng those
> > of the subsequent subprogs, would need to be adjusted. With per-subprog=
 copying,
> > only the local insn_aux_data needs to be updated, reducing the amount o=
f copying.
> >
> > However, if you prefer a global array, I=E2=80=99m happy to switch to i=
t.
>
> iirc we struggled with lack of env/insn_aux in JIT earlier.
>
> func[i]->aux->used_maps =3D env->used_maps;
> is one such example.
>
> Let's move bpf_prog_select_runtime() into bpf_check() and
> consistently pass 'env' into bpf_int_jit_compile() while
> env is still valid.
> Close to jit_subprogs().
> Or remove bpf_prog_select_runtime() and make jit_subprogs()
> do the whole thing. tbd.
>
> This way we can remove used_maps workaround and don't need to do
> this insn_aux copy.
> Errors during JIT can be printed into the verifier log too.
>
> Kumar,
> what do you think about it from modularization pov ?

Makes sense to do it, I don't think it would cause any problems for
modularization.

