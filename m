Return-Path: <bpf+bounces-13747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D725A7DD639
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886AD2814F6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A91D689;
	Tue, 31 Oct 2023 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTkAn7Fa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447A18E37
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:41:41 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06EA8E
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:41:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507bd19eac8so8580753e87.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698777698; x=1699382498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6LrhqDPmyR13J+thy2rbzCIo2BrfIakNgHwCtaNNIg=;
        b=BTkAn7FapzOUcaxxnpKJvWlTvoqJL+jS0FPraT6+Nm3wyH8WE6lzndoeAa0O9lo8nB
         /xI/ZImZgpOC7AGevHaBsiocRZqGX4Cr2yTuqVHp8rRcuKTaim4IPKKK7d1QGopSnT3x
         THyxkcVFz+dSM+oju1I7hjXEg5sG/kaJ6xowWqHGmsvBVX6IQHvfR2C6qnC72j5bBewT
         TeqJLkOhyplf+S+cDx+DLhu3TiEyv/1g8E77JOZ1bmlWlRD0C1zDNEDJAFTkWbDmo7wr
         0A34v50a+eb9tf6S5CAlLQOxzP6P0GXiEGE4agDcURCHEy19C7MP5XW3/2dmyIWVteIv
         OcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698777698; x=1699382498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6LrhqDPmyR13J+thy2rbzCIo2BrfIakNgHwCtaNNIg=;
        b=MIdNJJpYBMjJ4IACK7HAoMXFaOV3vVY/QuAb6CgRJwm5+g7Etwo8wOfHPLRRbmPuZv
         gOHfqqFkAZ4GIZOvcCyW4+iAQ6iKvAbKvafr6rEtKfw0nzFTv8Hdgpa3SnZ/qWWXUv7i
         vrteY4VgxIgFwC0AVU2bZ200HLgW8TRG4pjXqr0Uhoa9Q6reaC6iZDIPU0Ifkgr4tn3V
         pR+PzHWnU/NCYuNP7EmlZh0Qs4cQCTXnEDVX3JS8IOibA8u8IYWkkknc2qZoSV0wDk0S
         9byJDkk0UsUfqEfWwh8xRBuK1uV+AArOdpWV7zy4JLHqhRvL2ZetVXkSsHYTy2LNoIGu
         uuKw==
X-Gm-Message-State: AOJu0YxlPA+yjDOQgyMAmsJgimmK+/uL9A2BLypC3rDNI4MRxzIeRLdG
	JR2MdAuaZqTeFeEUJZUFsM+5V156wFjQMLq6nvcd8zH+
X-Google-Smtp-Source: AGHT+IG+7YJhtZGwYdrT0/Zb8h+ZTzPg9Ft5xmnf9115NMPC/P2lseIrHgkwtzPdaVkxqNi+DPALaLQgoB13R8yg5QU=
X-Received: by 2002:ac2:4a8e:0:b0:505:6c99:bd7c with SMTP id
 l14-20020ac24a8e000000b005056c99bd7cmr10635597lfp.57.1698777697658; Tue, 31
 Oct 2023 11:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-7-andrii@kernel.org>
 <d7af631802f0cfae20df77fe70068702d24bbd31.camel@gmail.com> <CAEf4BzZVmEUP-+jP34H+UJF5qK2boKFHH3+rpKkjEVEKvN4eMQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZVmEUP-+jP34H+UJF5qK2boKFHH3+rpKkjEVEKvN4eMQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 11:41:26 -0700
Message-ID: <CAADnVQK0uAgEDN38uwH581=a0A4QQjCWaORQLbKzBoUbXfovpw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 06/23] bpf: add special smin32/smax32
 derivation from 64-bit bounds
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:39=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > fwiw, an alternative explanation might be arithmetic based.
> > Suppose:
> > . there are numbers a, b, c
> > . 2**31 <=3D b < 2**32
> > . 0 <=3D c < 2**31
> > . umin =3D 2**32 * a + b
> > . umax =3D 2**32 * (a + 1) + c
> >
> > The number of values in the range represented by [umin; umax] is:
> > . N =3D umax - umin + 1 =3D 2**32 + c - b + 1
> > . min(N) =3D 2**32 + 0 - (2**32-1) + 1 =3D 2
> > . max(N) =3D 2**32 + (2**31 - 1) - 2**31 + 1 =3D 2**32
> > Hence [(s32)b; (s32)c] form a valid range.
> >
> > At-least that's how I convinced myself.
>
> So the logic here follows the (visual) intuition how s64 and u64 (and
> also u32 and s32) correlate. That's how I saw it. TBH, the above
> mathematical way seems scary and not so straightforward to follow, so
> I'm hesitant to add it to comments to not scare anyone away :)

Actually Ed's math carried me across the line.
Could you add it to the commit log at least?

> I did try to visually represent it, but I'm not creative enough ASCII
> artist to pull this off, apparently. I'll just leave it as it is for
> now.

Your comment is also good, keep it as-is,
but it's harder to see that it's correct without the math part.

> > > +      * upper 32 bits. As a random example, s64 range
> > > +      * [0xfffffff0ffffff00; 0xfffffff100000010], forms a valid s32 =
range
> > > +      * [-16, 16] ([0xffffff00; 0x00000010]) in its 32 bit subregist=
er.
> > > +      */

typo. It's [-256, 16]

