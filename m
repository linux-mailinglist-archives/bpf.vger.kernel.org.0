Return-Path: <bpf+bounces-33682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 165929249E6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DC61F22D43
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0B201277;
	Tue,  2 Jul 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZEgCToO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCC148FF0
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955416; cv=none; b=VUoj8KOan7OpjAcpezdulivzpGbsOXnr+RpZyNTuyzhn3zneYn6o9HrI7xfcWeTeFdAZfLYMYzWOpK/7eekcR4me2EuyVzLgyxywgJsweWR+Hr/g3eAeQSrR156JF2dc014Xrl15Q7pSGLgnMM5aKQlCD2/OOl7cyyfncyIZvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955416; c=relaxed/simple;
	bh=rB/ZECwx7/yEzDJdvheOX2DdNKFuC3fcl/Smc8KQOw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKprwmxzzibjyNdBlMUnpYlR1wu1/30+OVSYtMvAB91hFfh0OEi+j/RetpA7jWl3jNKfFyb+iI/a6/YaqdPzfzU/5W9hZtFXWWENJ1GptpvpCnkM8TonrLNCZGMnKg/fINzp9jvt6KWs5HpFQ1w/2WMcei26H1tPd7XsouaZgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZEgCToO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-707f9c3bd02so3221611b3a.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955415; x=1720560215; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OiwNiFxr22YahXXwn2RxvFZx5CkAorGResDWR2N/pWo=;
        b=kZEgCToOzUE1lUMpor5O65TJ4ggVQjx1FIOX1XFB2l5GTSy5AMR2JKnEl0MefYxBeU
         UjxJ8s1X6dt/WxV9Dmo/ti0fS5QTAz7FIj0oP2F4KRRpfu1UQlf9FZiqJ19fQCO5xP5H
         74RLzw2FHsSNBmu2bxmfbOZtwbSo+nb413WFFRm9ewg+JPzzX5+tkiB1QWW9lMOULsTy
         6V5JaYRIFi3gawCltMRzYuSb0RbC8TKnbN0gxjPk4YwNNkJtidTVU/sKdCuFv+F5BHCH
         31LdbJlqpEErm3QMmOap5q0NV5G0FMhSMzILqj6EyTkFTlxejsp7WU5mPYP0QbYf/XwV
         azCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955415; x=1720560215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiwNiFxr22YahXXwn2RxvFZx5CkAorGResDWR2N/pWo=;
        b=IWDlnXVgzu3+XsVAbBH2XuFnD863D0DAk7EpVBgnzfRO5cuAOnCNDJtBVklYMfbGTx
         KsbNcefh5IwwL536o/NNMFLmEl2cx3p2uKVSwYzpp1OR5l6SrRsFg7XZmyJJQruN4Q4s
         TnGmITzVYYtYYIv4NtN2LoNR6bECXrINzmi+TAuPwZwHBGCYi2K5+xFF7lKbQy+GIspG
         Q5xhGzWL43WidOe4jaBw1O8RJQMxxm8DQeBmjeqfzyPIM1E7GwJY9SqA2crkOEqw2Bax
         6YcOXfxZZwrLftXQCUcL2znyFJegBAKG+yloP5NXBreFhjxu3Bo2lqyedZky7CnSJGvt
         s27g==
X-Gm-Message-State: AOJu0Yx+YELvoYWO4S3CYTTeQbNtWyni7MgwdypxIRqhuhRAhSguGs8s
	4A+/UY/IP7phmaOwJj9IX0Cw+JnFryDkdHOtLAsNElsodiRUrpAm
X-Google-Smtp-Source: AGHT+IGh3aYVcdtVm7bf6OmqTvYXpwTppA0gqoGKSTDX5uoouIBhy+TKAI5h9Jcvng0WAVCTBqzFuA==
X-Received: by 2002:a05:6a00:1d1d:b0:706:9073:45ee with SMTP id d2e1a72fcca58-70aaaee4e4cmr9202180b3a.25.1719955414650;
        Tue, 02 Jul 2024 14:23:34 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e63218sm9321935b3a.11.2024.07.02.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:23:34 -0700 (PDT)
Message-ID: <11d8b8664cd525c06048a4ee7f295138d792b4ef.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 4/8] selftests/bpf: extract utility function
 for BPF disassembly
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 14:23:29 -0700
In-Reply-To: <CAEf4Bzb3ETD-wKyF9g65bBoa2ayS=eJ=AwmcTYctc5i015-psA@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-5-eddyz87@gmail.com>
	 <CAEf4BzY_6iBHx5Hu1ick8qHb-kOaKpyG0vEqAcc1D7RKdbZs_Q@mail.gmail.com>
	 <6e74d6336ad5193d890b2704025783f90c4f0fbb.camel@gmail.com>
	 <CAEf4Bzb3ETD-wKyF9g65bBoa2ayS=eJ=AwmcTYctc5i015-psA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 14:16 -0700, Andrii Nakryiko wrote:

[...]

> struct bpf_insn *insn =3D skip_first_insn ? buf + 1 : buf, *insn_end =3D =
buf + cnt;
>=20
> while (insn !=3D insn_end) {
>     insn =3D disasm_insn(insn, insn_buf, sizeof(insn_buf));
>     fprintf(prog_out, "%s\n", insn_buf);
> }
>=20
> less addition, but it's simple enough in both cases, of course (I just
> find 1 or 2 as a result kind of a bad contract, but whatever)

Will change.

[...]

> > > > +       sscanf(buf, "(%*[^)]) %n", &pfx_end);
> > >=20
> > > let me simplify this a bit ;)
> > >=20
> > > pfx_end =3D 5;
> > >=20
> > > not as sophisticated, but equivalent
> >=20
> > Okay :(
>=20
> if 5 makes you sad, do keep sscanf(), of course, no worries :)

The obscure doc makes me even more sad.

[...]

