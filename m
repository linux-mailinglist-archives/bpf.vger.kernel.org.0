Return-Path: <bpf+bounces-13691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C79F7DC687
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AC21C20BE5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7351078A;
	Tue, 31 Oct 2023 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUkr4v6X"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA9DF6D
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:26:09 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983FE91;
	Mon, 30 Oct 2023 23:26:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso533469166b.1;
        Mon, 30 Oct 2023 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698733567; x=1699338367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H890dxrJWN3yT/xHp1vZtLZXjq98ozy2u9aQnWRZfHI=;
        b=BUkr4v6X8D/3UNbdm2kgS0BbnUAfIG8AouOLgv/RP4j6kyNe3duEmZY5/hgRzxXx51
         z8FmdPh57/aJr+QyYefUb6ht3KmjNum2fa8MNhfiY2TjquhF9AbMYVAW6Bvf1KaEcDPl
         Y/EQbqncW4X4ZOkpdljnQRduzQoqYlw1a2cAihnTte0sfXIU8OGl1wmDvE+cTrhb8OHv
         3Z+UaPtBGL91Sz0OGzyckzQY3COP+s5LhdCY+WAqalo9ZBpvAbLIEIP4rh4Kk4/sz+2D
         U3VDqmlmT9l65RGvrpZy/V1Ar8lPBhNoQGNQ0/jS4gShNHI+D484MvblEVW9ZMxeB5uP
         Jg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698733567; x=1699338367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H890dxrJWN3yT/xHp1vZtLZXjq98ozy2u9aQnWRZfHI=;
        b=TUBJhjQlozXi96pn/MOVQCN6LL62mH+i6aPEOLfuSc5B7yV27gM5carrV/XGt7Y6ZY
         DjAMpgt1e1HMZfqYzuNELQneIE627RRrbz7TPtypJl2qj4SnkwIQTWFESaO8iPXKIUtt
         C+kUg39KDTEXZqHysKOEJaqmbBCIA58IcvPs83GPW2VeSo4t1pyFCYH5Damm74JnXUp9
         zjX4rJ4+A3fyfSAG0tF4P5sI46yrSbFyQE/RFpzoQRrHzYvDd9TeUeSfk9DmCcf8rUU3
         Zv4aDhUxB+obMLa+ZhzI6VJx23m4AJnctX/f86E25osi9rzMuFN/S12qjEJs7bqQYIl8
         yfaw==
X-Gm-Message-State: AOJu0YxedJSAl51F9JwGO/LT6DLHYuaD9WdY6vtRxVfjKDsHLwQaSLeK
	vSIu0ZiVbaitYYnpU3YI1maCjQWKDF05yCE7l1E=
X-Google-Smtp-Source: AGHT+IF+gc0G3FlWAx0H5RVu7XzgkaKBL6c1il+hT0y9NF8CYvljdR4Q38DSOqYaHY5fHlhxHbfUfy8QJ1D7/ADlMFY=
X-Received: by 2002:a17:906:7146:b0:9d3:afe1:b3e5 with SMTP id
 z6-20020a170906714600b009d3afe1b3e5mr3595874ejj.75.1698733567002; Mon, 30 Oct
 2023 23:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698431765.git.dxu@dxuuu.xyz> <111a64c3e6ccda6b8a2826491715d4e8a645e384.1698431765.git.dxu@dxuuu.xyz>
 <CAEf4BzbwHZmCJHe8WiV0WeUV1XC+cDB4d4v8YLJh+ZL_k7yB1g@mail.gmail.com> <73xnkgitatvymw2bqwo6elqmdpsvj2atmh6ugrityvqyegguq7@cjos2bsw2ico>
In-Reply-To: <73xnkgitatvymw2bqwo6elqmdpsvj2atmh6ugrityvqyegguq7@cjos2bsw2ico>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 23:25:55 -0700
Message-ID: <CAEf4BzZWFfJFpp6UvYNj-i5PFU42rUD_U4B0c_Qa7DYV0Rme=A@mail.gmail.com>
Subject: Re: [RFC bpf-next 5/6] bpf: selftests: test_tunnel: Disable CO-RE relocations
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, andrii@kernel.org, shuah@kernel.org, daniel@iogearbox.net, 
	steffen.klassert@secunet.com, antony.antony@secunet.com, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 4:22=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Fri, Oct 27, 2023 at 01:33:09PM -0700, Andrii Nakryiko wrote:
> > On Fri, Oct 27, 2023 at 11:46=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
> > >
> > > Switching to vmlinux.h definitions seems to make the verifier very
> > > unhappy with bitfield accesses. The error is:
> > >
> > >     ; md.u.md2.dir =3D direction;
> > >     33: (69) r1 =3D *(u16 *)(r2 +11)
> > >     misaligned stack access off (0x0; 0x0)+-64+11 size 2
> > >
> > > It looks like disabling CO-RE relocations seem to make the error go
> > > away.
> > >
> >
> > for accessing bitfields libbpf provides
> > BPF_CORE_READ_BITFIELD_PROBED() and BPF_CORE_READ_BITFIELD() macros
>
> In this case the code in question is:
>
>         __u8 direction =3D 0;
>         md.u.md2.dir =3D direction;
>
> IOW the problem is assigning to bitfields, not reading from them.
>
> Is that something that libbpf needs to support as well?

Ah, I missed that this is a write into a struct. I think we can
support BPF_CORE_WRITE_BITFIELD() (not the PROBED version, though)
using all the same CO-RE relocations. It's probably a very niche case,
but BPF_CORE_READ_BITFIELD() is niche as well (though an absolute
necessity when the need does come up).

>
> Thanks,
> Daniel

