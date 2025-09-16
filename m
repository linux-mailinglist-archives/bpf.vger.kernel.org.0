Return-Path: <bpf+bounces-68535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120EB59DD2
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 18:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021F8321D28
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5831E894;
	Tue, 16 Sep 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGrvxf1B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823831E883
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040574; cv=none; b=UaZYQqVp5L3uitsJoGdbE+inCLnnJ59ng2zHaPRlI+4NUqXlQnlVwlVLZeky9KApDTcBKYRlZFznEautTG75l97iahU4g83ZwZ/HLSXFlKoxnDVP7qy1j5QKs3PUGWaKQyuRpMrHlroErWJ6IJfqyNCJfIZnB29NBQRl9lxyaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040574; c=relaxed/simple;
	bh=Ne7w70vRXTLq2BLmtuDIrB6BWCpz1lm8rEcPhExfc/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIlNr8IWD/yGvwZFHP1ZnrjzfXOXFmx+sEMhTkxZIZzUJhFQsrn55UOEenOKi/c2bzLrHZcUZ0j0v/W3XWtQXzXYfLoAgoapHYudCGx0lDct2rgN6cnck0rBn6JvFmdtQgwIvjDQwGDRHZYeBGEOfwkHa7npc0+OeZAfFWAbCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGrvxf1B; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-724b9ba77d5so55958527b3.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758040572; x=1758645372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne7w70vRXTLq2BLmtuDIrB6BWCpz1lm8rEcPhExfc/s=;
        b=XGrvxf1BTLlbnXk+wGGQYTWnOOigYGriODzjnViu6U39S1XKYbYUz2feo8CXWh4qUA
         xkFvK22Or5ftZ5oPt5dagpvLcpZsa6cJ9qOHpnm5HZqBj1e6+oQ+iXkOiyf+iUFN4SIl
         VrzeTPiSYhzZBfdb1e+fAKt7Hpq65tzjm8nqXg988bi49st/hw/aV/USY1NausBLgnjE
         EzYqmU0CW5/rvgaGRKcrJlzsOXhGFgwhtL7Mr3xDDFWn1/f6SKZOjV7bQZOv2tGU4xX4
         VGlIgBc/jJObANeRkejMDAMJmKDIcxopvJdGneIJ5uujeoG284cU0y8DB/LQqz4igCZJ
         9G2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040572; x=1758645372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne7w70vRXTLq2BLmtuDIrB6BWCpz1lm8rEcPhExfc/s=;
        b=RnQ3m9aIuE+u7mIFr4yipVNL1rXRVhES77BtL6XR5v82HQvmVCnC8eBXvEiXYtk5BB
         b7mjguPUW8qzyBs5KohWnIr8JovL/t14XIPKDNpVtV1HyKPz26qTiwzIHKmw+b1/vLCn
         6WJJ/7yorVdE5N7Av8ujMPhdGohJReNsK/S1d9OmHh8RYNvqbvHO8K5Y6P5hhzFggDwR
         U2FBMpw5F3nVsSX5HXgHSOwJbKmqb3uLjex7Uw33994TGbIgZ65fnc3qAS3bqea2WGUT
         roaoayxLgPVhbmGSL+JlgBwXeUd9PQxnBaBVAY+GOB/OaTpjR3XWDIQ2uhqBel43PQDP
         g2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXOR1Pn8B6A64oHObP+yOyx9AY0nS0cM6npZ1cXtZy1HiklC/cOg9Ovuo2oTduE0F/V2gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCzzVt18/3c7uBh2l2TvPsaVxriRrWs2O5oSYCegDMxNzBnVn
	gs5VmbJjV+RpKjegR5gEAJigq0IwznoNlHvUDiiUQlZta51PLUY/+5BKmALrf5MocKOgOOW2VA4
	qVuMSBqh4JkObKd+eCgjCoHc2Lj9XVnU=
X-Gm-Gg: ASbGncsrPpP+X1gR6QXG44eK7STRXLG/AG7SxoILQv5Mt47r0tqOxrt5ip9LYuYy0hu
	Jt+6JQyapyHoff5fEtIu+F4g6/92fLsYIveUrLrz6DpDkRNQeZ9ZeOJNhGcCz+BU6dgUqlk64B2
	W+criwlIHLgixJD8b4BcUSpS1wK5sIQ47nORW9oLCIKaWO5cUKFn++EFErFLpk/0TcVuFyuXplQ
	wrPh5h14l6Yj/BPO3RpjLMnGX9vCCeL3zc3Fp770SDn+cqnPpw=
X-Google-Smtp-Source: AGHT+IHIuOuqX6mE4aGd7thbKCeMu/VHD1H9MujMYDKtPf0VsR8B+/tCGB/fUewVltI/2VBa1oTdrOYVj8oRFBQVYL8=
X-Received: by 2002:a05:690c:6c8e:b0:734:81fb:8bb0 with SMTP id
 00721157ae682-73481fba318mr61953297b3.3.1758040572094; Tue, 16 Sep 2025
 09:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
 <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
 <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
 <CAPhsuW44HznMHFZdaxCcdsVrYuYhJOQAPEjETxhm-j_fk18QUw@mail.gmail.com>
 <CAEXv5_g2xMwSXGJ=X1FEiA8_YQnSXKwHFW3Cv5Ki5wwLkhAfuA@mail.gmail.com>
 <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com>
 <CAEXv5_griDfE03D1wDLH8chgCz0R2qZ5dAeiG0Rcg5sAicnMsg@mail.gmail.com>
 <CAEXv5_hKQqFH_7zmxr7moBpt07B-+ZWB=qfWOb+Rn9Vj=7EX+g@mail.gmail.com> <CAPhsuW6vSkYLyjGm60YZvruVKHrT+0tf4ZUdyp5ftd3hZB6cxg@mail.gmail.com>
In-Reply-To: <CAPhsuW6vSkYLyjGm60YZvruVKHrT+0tf4ZUdyp5ftd3hZB6cxg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 16 Sep 2025 12:36:01 -0400
X-Gm-Features: AS18NWBVuEyZ6KTtiue_oaKY4L5_7tE16jnXk5C4R2YarJI7n6Mo-0jeof4xqW8
Message-ID: <CAEXv5_jCXKm4L6tJy5X6kjoLpoPqkbRLuhGuEMYNwoW=EYYtsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:16=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, Sep 16, 2025 at 8:25=E2=80=AFAM David Windsor <dwindsor@gmail.com=
> wrote:
> [...]
> > >
> > > makes sense thanks
> > >
> >
> > Hi,
> >
> > Thinking about this more, hashmaps are still problematic for this case.
> >
> > Meaning, placing a hook on security_cred_free alone for garbage
> > collection / end-of-life processing isn't enough - we still have to
> > deal with prepare/commit_creds. This flow works by having
> > prepare_creds clone an existing cred object, then commit_creds works
> > by swapping old creds with new one atomically, then later freeing the
> > original cred. If we are not very careful there will be a period of
> > time during which both cred objects could be valid, and I think this
> > is worth the feature alone.
>
> With cred local storage, we still need to deal with prepare/commit creds,
> right? cred local storage only makes sure the storage is allocated and
> freed. The BPF LSM programs still need to initiate the data properly
> based on the policy. IOW, whether we have cred local storage or not,
> it is necessary to handle all the paths that alloc/free the cred. Did I m=
iss
> something here?
>

Yes each LSM will have to do whatever it feels it should. Some will
initialize their blob's data with one type of data, some another,
depends on the LSM's use case. We're just here to provide the storage
- bpf cannot use the "classic" LSM storage blob.

I was referring to the fact that if we use a hashmap to track state on
a per-cred basis there may be a period of time when it could be come
stale during the state change from commit -> prepare_creds.

Thanks,
David

> Thanks,
> Song

