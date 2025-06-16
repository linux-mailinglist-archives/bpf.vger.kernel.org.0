Return-Path: <bpf+bounces-60773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6417ADBBEC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35473B768C
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C27218592;
	Mon, 16 Jun 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiScaAll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A2136349
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109237; cv=none; b=HbVPTdNNH6+zS1kbfRSpShp5J2oBldtVu7DNOx4sGZK+QArU1PUmgzENCzTspDmqxahA2/8uDomx8Yva7CU3jYqfN9pSu6jiatrE6IBN33zTscp06xQ1pyEzW00Qhe9KXtk2Mu9e+qis4aAWhM4/KhydW6kRm4cvIhwhjhwI1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109237; c=relaxed/simple;
	bh=n4Ukp91WBhldI450/odeAXTHg7NIOt60AIyW9xOFXvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qR7LEAjldBPIe/LfUaay8vXIp4uOaBPevBhKia17WDVRGNMm6ZOf/ul9H1qJH5QF83tW9i2qzrLOmpQb2Z2hEBkk83aOagyeOBPe/8FDwes3DvKN2adLi3SQZ9HqEtRUJO4ntil8/yZDtQtMbJepQbxqCefBjk5lBfZU0CVcFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiScaAll; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236192f8770so34529385ad.0
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750109234; x=1750714034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PRcnaGUi8DN8HRzB/YkfBT9+yu/QkOGnJGPtIxBaKYQ=;
        b=WiScaAllGn2VM5Y+lmkxew9hAE7CdQXEoKFamrbBtIfsBnmP6p+q8rvmh6OMshy+0o
         2IeUnnk0sgX0jSR+xZLtxAmnLnr6JuQBGfFrDqLXddUXfrUpRYP2CYWxgmmqpkxbR7LX
         amL+CG6GlD3PVspO2OCaFWfcSlwjEU2IPfU7ue+uP0n4pFsKTs2O8Q/oRWSSRKjql57r
         xpnsE22FWwyasXtLEwWNFqryGyCQ5xMCpMDBQj09JsUqWagIqGYJBCfl+nOU9MkXv89M
         AhOflf9pBhZXEGCScMOGXldhPp8bRCRTQAccNBpVdLkGzLh71XtdZXOrwBTr5Wwlhr1C
         QqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750109234; x=1750714034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRcnaGUi8DN8HRzB/YkfBT9+yu/QkOGnJGPtIxBaKYQ=;
        b=adnbPlJlLBSeDHEjQNhY1IEESbWar/RKv218LwBnBXbxihh4ogEolATfzE07B/xT5Q
         oILZA1XrDR6fTe43oHWqCx2YwvqSnvWpIPuv1J6IwEjjzknO/I6XSBhpds7oalbHsA7g
         3SOg9O21Wefn6jSJIMvmkqdv1oKSVNKIgPZKvNZ8aT+chGh60Xw0/yjBcv7D0Vbq9ewy
         wovNLxZQEY2Cq116gqIXQCYMADUpjYg8+dzL3UOWuDzcT2o4fuOtZNqSwFjJ1X85yuA8
         8z/xXPSr9ckm1kVmHek3bMjFyp23XxS2chbbokdTCMasYUqpQtvT0Z2oKZTkI5amOFLw
         w6PQ==
X-Gm-Message-State: AOJu0YxmnLTBmHaG8FLUPY9mDRhFzppYdwm7Ct9mVO4kZhGpfY4uHAeb
	bI4TsYVZ397JIhgVcjbyWHANRoLmhYfFFQu5+RxNFUC6+av52CZxMjcXHIvM/1PS6f0=
X-Gm-Gg: ASbGncsslbaPXFOtyTvscwg9tJFSTmDddTSRcihd9jrUHgZffyLebWHzIy119YBOnIo
	8avdsrI4ssAuGHP+Hw53wjWI/czykt0Jw4PI+YHMmccubTiiy867x3kpEF8DnFfqXhIrM6XsX/X
	HV4Ydu8srPEwzKOcnQMBGsk9qLMGeV+5vhX1SzOiRmolob7bVhatZsmnzlz0ky3wKYwHLwtWZGJ
	ZXtpkuksV5z0J+1w8e+nTiAm637UdnD+ADkM+s6v3zwCebGPTdUyDw6XCR4aXjBSbngTnRCLNxC
	M0lw1Z3kyBYSSLHPkvUaGkQeanCgXOCroZaPvY0rcdrNFFmCyTwy8Nnnstg6CRdyKgFrvmDqxzc
	ucv0ftkimUHw=
X-Google-Smtp-Source: AGHT+IG3IJNLn+JwY1Hq3wk7Ya029rfMA6CoOnIrdd7MNFdKrbDcbKyDJ97pe8+vrbmoTonZaUuKEw==
X-Received: by 2002:a17:903:284:b0:234:595d:a58e with SMTP id d9443c01a7336-23691ee8e2emr1221225ad.25.1750109234177;
        Mon, 16 Jun 2025 14:27:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:93e4:dfae:7306:db42? ([2620:10d:c090:500::5:a635])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0cff72sm66007315ad.241.2025.06.16.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:27:13 -0700 (PDT)
Message-ID: <d92b2e43d7710624deaf10a9919cdfa45ee91bdb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] selftests/bpf: more precise
 cpu_mitigations state detection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	laoar.shao@gmail.com, mykyta.yatsenko5@gmail.com
Date: Mon, 16 Jun 2025 14:27:12 -0700
In-Reply-To: <CAEf4BzYh38ZW5x_tttT7qGSPbUtT4SLC7F+aoE_cymkV5q59hw@mail.gmail.com>
References: <20250614050617.4161083-1-eddyz87@gmail.com>
	 <20250614050617.4161083-2-eddyz87@gmail.com>
	 <CAEf4BzYh38ZW5x_tttT7qGSPbUtT4SLC7F+aoE_cymkV5q59hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-16 at 14:13 -0700, Andrii Nakryiko wrote:

[...]

> > +static int config_contains(const char *pat)
>=20
> int-returning function... but we return do `ret =3D true;`, that looks
> accidental and sloppy. Let's add a comment that it returns <0 on
> error, 0 for no match, 1 for match and stick to numbers everywhere?

It was actually intentional but ok, I can change that.

> > +{
> > +       int n, err, ret =3D -1;
> > +       const char *msg;
> > +       char buf[1024];
> > +       gzFile config;
> > +
> > +       config =3D open_config();
> > +       if (!config)
> > +               goto out;
>=20
> nothing to gzclose if open_config() returns NULL, just return
>=20
> pw-bot: cr
>=20
> > +
> > +       for (;;) {
> > +               if (!gzgets(config, buf, sizeof(buf))) {
> > +                       msg =3D gzerror(config, &err);
> > +                       if (err =3D=3D Z_ERRNO)
> > +                               perror("gzgets /proc/config.gz");
> > +                       else if (err !=3D Z_OK)
> > +                               fprintf(stderr, "gzgets /proc/config.gz=
: %s", msg);
> > +                       goto out;
>=20
> nit: I'd probably just do
>=20
> gzclose(config);
> return -EINVAL; (or whatever the error code might be)

I'll make this change just to avoid arguing but don't understand why tbh.

[...]

