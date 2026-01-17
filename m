Return-Path: <bpf+bounces-79374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A29D39009
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 18:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B0533006984
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF7287263;
	Sat, 17 Jan 2026 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbuTZjTu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB629286419
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768670557; cv=none; b=ZQ3Ip9ZGfsrni8HddbKC+mbJrthAhgiC39VG++JELHVW+PqmjC7TLeHSLFyxEe/6+wdMZVAELvd2HwGTPjvKX06/SH0aNJbirI55mf44YKNb3+aXwxWDTRisiaqFASLDaPnEM+IVQ1MX/5rrLdhijXCQIItKtIicLkD2U+pPLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768670557; c=relaxed/simple;
	bh=exR9YJCThsKdMel8h2RQpyHjHZuCCX2nPjo3jP79vac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVs05FOLHRtboemasjbjJjEJwP4DJgMrsOTE+bowYfSXD8o9kqt9gj2FR90WjH8iHSdsJyTS/2fI9Fb8EkGlnx1JaKiLRgQlYYUVcEVHT0rnlCHTuKIelKQ2Z7D2VnYr3lLIGz0Nm93I3bACwYHsc3pKz6mXKJF1iZH+xXChbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbuTZjTu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc305552so2404369f8f.0
        for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 09:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768670552; x=1769275352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrV2gA9v7blzGG8XIzUUowQxSTC+PACnvoPWHFybMUk=;
        b=hbuTZjTuEGkufcjv3u2HjIz3/oS5k6x2q9IoLEerv9M0jZ018HgGTANOZXhYslgi5L
         Bc3iRix5iy9lt+T4W+EOLTJfIIRCWhW5W1nJ8zvLYqbOWLe61mPKuEfucCTCYXsXrNXU
         TOVOLk6XSt9BqUH1qaonJ4wHZHoxnRG+KWDIv6PVgVf849/Fe54ePz/vJyPnipILUFda
         k2upvRicKCmY1pojxLwN+H57BWxjtJYP5Xra37tfZ1fdkEnFrxQ6KfJeG3vqrkVYW5Pe
         ukCiLKeJgka1984faJuN07104LduWYcMzsGmAtBRTiRsciHabL/m1fQcOOGWkcP+zzNz
         I9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768670552; x=1769275352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrV2gA9v7blzGG8XIzUUowQxSTC+PACnvoPWHFybMUk=;
        b=m9yBPHw7AQMMacR41832dAHN9xLsJK3o5HCc0MZidNpe0mATcfOP0R3npfaMtmIHDc
         U5ptgfw1jTd+A7opJHS4Dsvzsqows3ikP2iE1iBY1ytU4syESUFagvLvGvjhRUHZTn4v
         o1dctPnOWV4TIWpkqOptOLnamPEA0j1G87A8keUS8eJizVSk0wfm/hCUlwtn/0UPULhv
         acf8HWQNdWTOspC5ylNa4RlsTWP4qasv3uHJaWPBsSWIBay6Im7YtUUGooGU2kXiJ3HW
         masyF2Re/EDk6yY34h68e7IWizQuvNHiV2wlorUExelaO6omvqNpvpwUw9MW+lBtqqAw
         t7hg==
X-Gm-Message-State: AOJu0YwrMRgiasX3Hbwbhcq48nUpyJQ4qSDUmQm4RibrFus2DtTe84KU
	G4rvgb4Hq0g/IItRx7PYOnaQXY9Pfyv+L2nQdQPmMnLmglN2s/dL96Cqn6R02g1yMBouXrFg+FS
	JpbUEXmCP6bRqTvk2PX1OGFkwgmB/fCE=
X-Gm-Gg: AY/fxX6QQcP3fzMdVFGvji7Vy6URxEWKmcVnR6SXSUNSYYfRs9iUoIjZIOCnq6ctCkN
	uUpW5FAb86rbYSzjcLYXow0aoHM25QxjLZrUm6B0LSBlZ/Am83acszSqcBrqL8Srcpd6X+k+OQy
	Tzggl4CFXVWxwH9jRbYxrdcNaFjwIhiLB2qLYjMM7oavOzl7DkmzPdAjc7S0FRE5zh3/31JFQpN
	c1v06pyxM53xiA8dxP5jdB3gPBkDD0LryrHizdF0nrlnEQa3xsH1SUgMM1/aYNshTqbRfY2nFCT
	6eBpgVEHLEx3VPLIzcesC56F7hEJ3a1ruur0lai4TDgf17VhWpHGfyE=
X-Received: by 2002:a05:6000:2303:b0:430:f7bc:4cf1 with SMTP id
 ffacd0b85a97d-4356a03d2c8mr8913803f8f.26.1768670551932; Sat, 17 Jan 2026
 09:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116103246.2477635-1-tangyazhou@zju.edu.cn> <20260116103246.2477635-2-tangyazhou@zju.edu.cn>
In-Reply-To: <20260116103246.2477635-2-tangyazhou@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 17 Jan 2026 09:22:20 -0800
X-Gm-Features: AZwV_QjFF3vx5WXx10zEJCgK5U2PzKbQ3b0z5wOtJN_FPM_bofhCm4Vr7uungQE
Message-ID: <CAADnVQJb+bo5Nhzk+YwTh6yx+Du3N3XwF1hQ9xgY3Mg-9WLT4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:33=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn>=
 wrote:
>
>
> +static void __reset_reg64_and_tnum(struct bpf_reg_state *reg)
> +{
> +       __mark_reg64_unbounded(reg);
> +       reg->var_off =3D tnum_unknown;
> +}
> +
> +static void __reset_reg32_and_tnum(struct bpf_reg_state *reg)
> +{
> +       __mark_reg32_unbounded(reg);
> +       reg->var_off =3D tnum_unknown;
> +}

Looks good overall. Probably remove __ from two helpers above,
and fix build errors:

   verifier.c:(.text+0x1f5d4): undefined reference to `__udivdi3'

> +       *dst_umin =3D *dst_umin / src_val;
> +       *dst_umax =3D *dst_umax / src_val;

since plain C division cannot be used in the kernel.
See how bpf interpreter in core.c does it.

pw-bot: cr

