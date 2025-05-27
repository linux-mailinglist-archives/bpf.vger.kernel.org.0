Return-Path: <bpf+bounces-59033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC0FAC5DC4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 01:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DAF7ABC68
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F036218ADE;
	Tue, 27 May 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCH3SWqY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294E18DB35
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748388348; cv=none; b=lmhYzl7P604juBxL8NOWbKnkg1AQSa8RD5RXwDF3ZjL7XZ4azkZo/KEKHEMWIUTtXuvMuDiHbRdfEcXp0sBG1zl7hGda8NhgbNbcWiI+LiKQM6WzsO/uyxlRBYXRAAsqfeoFQrCqSvOTLlFpkHqRS7ntzJUySwQHg0jZ8kVqxm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748388348; c=relaxed/simple;
	bh=dW0qBvJs92T/DkhQ15CEuFZTFympShdxJ9AQYMrHt9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E920l3cXlLefHcg4Ezvhri8Sin9H6bBZ5TijuLjJxb1vb0DByh1lFHGiRZ3ohAjXr4ygdiEHcAoF2KDBiZjSDFufwnTn9igYnNgi3wvy7t2S/4VusmzRRGTNl7XJ5NVN/Ef0i9x4i4Lw3e6ymoqiE2FRvwuVwZS1Z9EAwqpvgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCH3SWqY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1015011a12.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 16:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748388346; x=1748993146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOoSny17m8q+HaTbNaaa/DJNRf2XMMV1C/a0Jhn3rgU=;
        b=SCH3SWqYs9nOBZ/YPorMfsxA6acUPoG656Nqy+r0PmgkcCMavFjb0EIy6p7/p+7OOP
         HsRmp+8IJscPh4Zn95FbBSl8ye25B61MmgFBI34TRs+dd7xMoBQH9WBhWNh+2RL+MFs9
         xtOQp5PJyzl/5JK1WCx+CdFPRIK4LdlYhA/2VlWQcjIBlZgbMalZenLdxFCjaLdGLKpO
         kcQ//uwKa/on2PlyZrZEr/x0R23yXWcqzMcffYJpg8Uom2IY7XwWszRYNzN5Ary1shk+
         V1rhsUDht+yZK3jYeg3+Vo2zobhld4UcSr39790xP3UUJMIG9ISU7kE+QRi/nluXHgiK
         A6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748388346; x=1748993146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOoSny17m8q+HaTbNaaa/DJNRf2XMMV1C/a0Jhn3rgU=;
        b=BR9b1a/HB0Exa0Z/CWsO0fyVn5uBuRrJnxbfyHNDUaYizQx/jPPSyW2o/CkI/yk2Nj
         RE3ttsrfFrViL6btdAjVbHv2+uh4wEUQOrdvZeotv2IsgyY50SlnVYPdQtfuuimAPKzo
         boONEsXsccK8r+YvzzaKNmQ+EL2jfBYx1pGUNkK2OsHItCl38RahNX9xzDzxYDgWrDRA
         v6EQ7a+M1g9ageVMmawCATc8F9MqHaXLGC8LGtMT4LDLkmW4iuv/Vhhh8j2/KJT35lrM
         une2wEcHfYZEKqZ4mPD5VLoZZ8hWxr/DU797sIbcXLYJpm3rdy9MOzJiTphSgg+lWrbA
         CiQA==
X-Forwarded-Encrypted: i=1; AJvYcCV1/m54maVlS9r+ns3Xe2/Ham5dxKufSUGO22hquPpe3WGPDZ9E1uZV/20qLK3DOZp2XNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnRzFTku3dhsyFt6Td9ujfi33QtnPfseEl3tPiyqGpD3Si6bO
	QbvTtrLGuDj4/YHL5hMd9synKGNmAe7pFrv5XOpzABT+YKuv2ktR5XONtYgLyOlKAa+VsauCGQI
	0IadLMK68G2cjjGrM/c0lbwOHPyfeOI8=
X-Gm-Gg: ASbGncvntgrYD+5VGCbq4b4UN1jhUNXlON2UNxxlDOyAI7dkd2VlADcqGAb0HH4kZ6d
	gUMJVUYLbqNB/uEKWwVCW0a3TvJtNFPkQ5uUuWhHTjlX2ZPETiGhRnkN2jMGvxqNNEIKyS3G64Q
	RNVvqp/XneyJ1VSTnEJvGiSmn2n1/K6yym6qvYrsuetcPT8TkJlAwLoRoJjxY=
X-Google-Smtp-Source: AGHT+IF1eyuTAhsmHLfcdT4T4xBuq3b8OOh48OUcAXOejfBZwcevRXD03mhE7vG3cjFVulYjvjNSs3aExVmHpcYQSfQ=
X-Received: by 2002:a17:90b:4b8b:b0:311:d670:a0e9 with SMTP id
 98e67ed59e1d1-311d670ad95mr1709742a91.21.1748388345926; Tue, 27 May 2025
 16:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
In-Reply-To: <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 16:25:33 -0700
X-Gm-Features: AX0GCFtjqDPMDmWyGr6gUgjh0BRRCWPw1mKTOYlNAfszagXs4oh-TLIELIXV6Qg
Message-ID: <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 3:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
> > +
> > +       data_sz =3D map->def.value_size;
> > +       if (is_percpu) {
> > +               num_cpus =3D libbpf_num_possible_cpus();
> > +               if (num_cpus < 0) {
> > +                       err =3D num_cpus;
> > +                       return err;
> > +               }
> > +
> > +               data_sz =3D data_sz * num_cpus;
> > +               data =3D malloc(data_sz);
> > +               if (!data) {
> > +                       err =3D -ENOMEM;
> > +                       return err;
> > +               }
> > +
> > +               elem_sz =3D map->def.value_size;
> > +               for (i =3D 0; i < num_cpus; i++)
> > +                       memcpy(data + i * elem_sz, map->mmaped, elem_sz=
);
> > +       } else {
> > +               data =3D map->mmaped;
> > +       }
> >
> >         if (obj->gen_loader) {
> >                 bpf_gen__map_update_elem(obj->gen_loader, map - obj->ma=
ps,
> > -                                        map->mmaped, map->def.value_si=
ze);
> > +                                        data, data_sz);
>
> I missed it earlier, but now I wonder how this is supposed to work ?
> skel and lskel may be generated on a system with N cpus,
> but loaded with M cpus.
>
> Another concern is num_cpus multiplier can be huge.
> lksel adds all that init data into a global array.
> Pls avoid this multiplier.

Hm... For skel, the number of CPUs at runtime isn't a problem, it's
only memory waste for this temporary data. But it is forced on us by
kernel contract for MAP_UPDATE_ELEM for per-CPU maps.

Should we have a flag for map update command for per-CPU maps that
would mean "use this data as a value for each CPU"? Then we can
provide just a small piece of initialization data and not have to rely
on the number of CPUs. This will also make lskel part very simple.

Alternatively (and perhaps more flexibly) we can extend
MAP_UPDATE_ELEM with ability to specify specific CPU for per-CPU maps.
I'd probably have a MAP_LOOKUP_ELEM counterpart for this as well. Then
skeleton/light skeleton code can iterate given number of times to
initialize all CPUs using small initial data image.

