Return-Path: <bpf+bounces-33668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF539249A8
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04331F22F35
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61318201259;
	Tue,  2 Jul 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6art5Ek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23D201253
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953986; cv=none; b=Ay/1U6W+8QMXVLn+oBF5YaJrSZjUyrCoJjE39/tZvFyXmf5pZmbRRHjJiQ2Wr7rXiqD//uP6vSuPVrG0cCJtjQgZDPT9bUmYYpJvC0B2Ez7yfiWJOtgl8+HYjvGSPz4FouiKoT/+4dVaD1NI37nNsqtAvYh3hW4Jce9X6i+n78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953986; c=relaxed/simple;
	bh=w0W6xaYne0UkagiDw3fTmDlLMutXknooaEoB4rq5V2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIkaay5aITGEjNvX95lWr2LsgnsNzhIjdC+GRUHyIksgZFxcsWuoAYdfiiGmSs78QFoTADdVrPS+1zR/s4Kw0OYu0SgKvQDhXfwQZ4TNjN/YCzGiDMMOua0YxcH0EwD/2j0QFYE0Ja9Qu8DeKrFn2eQcNwECWDqCO7ky3WLk5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6art5Ek; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f65a3abd01so33972255ad.3
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719953985; x=1720558785; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cMjb8WM6WVzkmHmUqRw16FDLycZTNjk6rKXhlIG7gUs=;
        b=d6art5Ek48xWlkhKBWyDnhbTpQHtGgAJKyD8Hv24WjJJqlo7OD28IcUO165yWAAW6O
         0QrhOFw02tr75ynt+RgLp29KjtbgILrj20RR9kSrfPz/BZGHWlh+zj8a2VOY27bKTOqH
         KXCUf12RQnKLZJxTkfJfVZ4JR7Lc0z9jDGLQF/TQW7SvX24pBLdD8Y+5DjLW8OkSRbON
         L9+SH63cJiAdw9cFThhyuEn83hTRKwVpaWiAza5neZA17aQLRSp0D5Dt+XortPQpuelP
         o25XAIDDsDozmy96r+YUkw6p6jW3UvoA2eWcW/8SBdflm38JmwmejI1UpFTbQahU8Tld
         OScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719953985; x=1720558785;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMjb8WM6WVzkmHmUqRw16FDLycZTNjk6rKXhlIG7gUs=;
        b=lfbVemn22gL09PC89sjiiMcFJlec+pfqi+NLAsu7NfpIb2xWq+VMZrqIRFIrlMaHSG
         L9lzxQKzEc0KC/qmqLxEaYcZ2taSTqQeRj/kTTxTkgCR0idPviOXtFqR0kvUlH3k895W
         tfQanv4LaniidfzTnJ37N6LNrXOPNM5f1Zsfj1YfQaVWoSHjyLBcbTrX3kdxlfC0tRob
         ZLaAwFOvtGSwIRlwrUULDLy7C01ZtV6i++wNYXE4gFBqFAqdQk/uPxpuRdewCVnc6FRr
         tikDsgBDPZcj0jVth7ROdI1rtOeuncu/NqHVcohhxsNsUDdPIFLhZ16agasJ8XF10e2k
         4TmQ==
X-Gm-Message-State: AOJu0YxBhMhDxVtZotOy4bLMsDenaRKTaM9V6Di1hg3khWrdFByd5VZ/
	kMvJ7JFQk5T89lId+7ySU1rvpm/BVBSv/2F/f47oUqWej3W8pZI1KiOaZw==
X-Google-Smtp-Source: AGHT+IGPlJlNLP/VHQH0sdNFShVx+j4uXgybOxubBxnDo7FTSX+xtCNij8H1dYJ+Xkig4G6eqbN47Q==
X-Received: by 2002:a17:902:e844:b0:1fa:ceeb:e5f2 with SMTP id d9443c01a7336-1fadbce6a24mr97296275ad.55.1719953984912;
        Tue, 02 Jul 2024 13:59:44 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159680csm89132885ad.265.2024.07.02.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 13:59:44 -0700 (PDT)
Message-ID: <6e74d6336ad5193d890b2704025783f90c4f0fbb.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 4/8] selftests/bpf: extract utility function
 for BPF disassembly
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 13:59:39 -0700
In-Reply-To: <CAEf4BzY_6iBHx5Hu1ick8qHb-kOaKpyG0vEqAcc1D7RKdbZs_Q@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-5-eddyz87@gmail.com>
	 <CAEf4BzY_6iBHx5Hu1ick8qHb-kOaKpyG0vEqAcc1D7RKdbZs_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:
> On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > uint32_t disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);
>=20
> or you can return `struct bpf_insn *` which will point to the next
> hypothetical instruction?

Not sure if it simplifies clients, e.g. from this patch, the following:

+	for (i =3D skip_first_insn ? 1 : 0; i < cnt;) {
+		i +=3D disasm_insn(buf + i, insn_buf, sizeof(insn_buf));
+		fprintf(prog_out, "%s\n", insn_buf);
+	}

Would become:

+	for (i =3D buf + skip_first_insn ? 1 : 0; i < buf + cnt;) {
+		i =3D disasm_insn(buf + i, insn_buf, sizeof(insn_buf));
+		fprintf(prog_out, "%s\n", insn_buf);
+	}

idk, can change if you insist.

[...]

> > +       sscanf(buf, "(%*[^)]) %n", &pfx_end);
>=20
> let me simplify this a bit ;)
>=20
> pfx_end =3D 5;
>=20
> not as sophisticated, but equivalent

Okay :(

>=20
> > +       sscanf(buf, "(%*[^)]) call %*[^#]%n", &sfx_start);
>=20
> is it documented that sfx_start won't be updated if sscanf() doesn't
> successfully match?
>=20
> if not, maybe let's do something like below
>=20
> if (strcmp(buf + 5, "call ", 5) =3D=3D 0 && (tmp =3D strrchr(buf, '#')))
>     sfx_start =3D tmp - buf;

Will change, the doc is obscure.

[...]

