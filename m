Return-Path: <bpf+bounces-40110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0997CEC1
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C872847FF
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B949142911;
	Thu, 19 Sep 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoXGmzp7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B722612
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726781056; cv=none; b=IktSMRzdk6sS77KzG+50+nxTfjLquZLVorpzaqqLnkubPPMhiuSf10ADabU1PphIJWr/7U6Mm6ybt5j/rFzyXUFRpVkQa3c/6IFkaJF5ZUOajyt//Qz6d0se4eqZo/hJJaSqcKhzQScuY9nJFrqowrAOZzUD3T6junlOVBilQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726781056; c=relaxed/simple;
	bh=i4cofNc4QSLYmftHrIGhDbC5XKHyVvmG9AEFCRK5XV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW4TUt56INcuF1yBSlhp4PYdwBRoY2b3Kw15CuIvd9bPq4sOIqG97F9OZhVJMTbsja4HZoRnvu2yYiLVJI0cPrZ/ICFroD9sMgmiWP+hPBIo3HPocyjC/kObh5kkBE0dfC5l6eTTW543VM4MszrqoIFF7abJnVSpFC307SbaGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoXGmzp7; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aab679b7bso57281939f.0
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726781054; x=1727385854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzQ9GI76Y+xtbahPXv7Bxudt/pSfvuD/ZX9c+u3usv4=;
        b=HoXGmzp7sFaTL3VWzCpuCGcBt2KaU5JtkOeuZCa2a9aN+Wn2YhuykU70+eYLt3htlz
         hCFzuH9KxVoYnko6L2TLLl97FIdMnLxWvycOLGUo/nJ+jHaDurIFMlXr6dLBcFPNsSv2
         Td2vkqEjsaWHTb92PENz4177mAID4NRHjw0tWbcw+4zj2LumSYC0mJ2768UL3h82jrJA
         Uh/6vfJkIZVr5xCzBXxPPoJAwEm1Du4CaYo2S+MbYH8vNM0LOLcYK3GhvLhQhHGNG+7I
         aQLUAfjk8EcTUtEkic4e8Ft+ufzixp+hA7hEkcvihQXaIfF8T313v5bLx8Az3tCkicG7
         zJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726781054; x=1727385854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzQ9GI76Y+xtbahPXv7Bxudt/pSfvuD/ZX9c+u3usv4=;
        b=ezCH2aLFofdUdC4rQkFqFgZquTX+Wm7n2Xj8V026CmUG3RUT3f8vWQaaGgxzHpmfeE
         LxYanz1t/yXKjgL/YVEzV2FcNCHQ9pRjze9a/DAj5tU55mWsrB8/nDnBCYvusF+WjJTZ
         Lss8dpgvLXBkRAleaThfODVtEMzqlVS5mjf3sli5kqMAvsToH1utY6/pwtJ43fe3yIIy
         J91AFa+2XpwYhj7rducjQG6aVZis2lCc0yG7AfPmNkhiHWccJlJQ5Yz6ha3j2A+Xs4cw
         y4BQBDEQFhUOpA+jBlyWu+UQIfv5QfM9eOFr6R+JAqZAtoLKbax3o00kxGl4VLuryIIF
         NMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUvRxJqQYdhA2lrKgQK5tCaUHyM4eFhZ6+hjTSVLtbLXUP1w2yY+dAPYScH3qJdEGTSJiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+rCniHtbhFyXDxliSFnKwVCWs5skawtbfbTkeZ+8SAtW3e+Z
	uguub/OANj4NFYSxhxDK+AYPrG3ja/KTWBvqkQAg1hShnp3aLl7OGk93TN31Kp1K2JbqZXQ67s0
	Wb8UvwtWftEKti+m3QIEzoF9M0V9IZvYy4pFojg==
X-Google-Smtp-Source: AGHT+IEnDC8RIT5tfKYyUwXyvmqCST2dgSkuXtXjUeLFpaCXSkx4+mZrrHmYx6BwviJc/SdUUQgyCbi9Dc5ah4xxGFg=
X-Received: by 2002:a92:c24c:0:b0:39d:351a:d0a2 with SMTP id
 e9e14a558f8ab-3a0c9d90b95mr4501735ab.25.1726781053711; Thu, 19 Sep 2024
 14:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919195454.73358-1-kerneljasonxing@gmail.com> <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
In-Reply-To: <CAADnVQJUd_1y-Ecgw3pgd6z2jw6=ZEm5wnxQqwUnhCobw752fQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 19 Sep 2024 23:23:37 +0200
Message-ID: <CAL+tcoBn24=Wz8=iB49RwsEwJWqY7ztHWBEya+wbvcJQ10i=XQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: syscall_nrs: fix no previous prototype for "syscall_defines"
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 11:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 19, 2024 at 9:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In some environments (gcc treated as error in W=3D1, which is default),=
 if we
> > make -C samples/bpf/, it will be stopped because of
> > "no previous prototype" error like this:
> >
> >   ../samples/bpf/syscall_nrs.c:7:6:
> >   error: no previous prototype for =E2=80=98syscall_defines=E2=80=99 [-=
Werror=3Dmissing-prototypes]
> >    void syscall_defines(void)
> >         ^~~~~~~~~~~~~~~
>
> samples/bpf/ doesn't accept patches any more.

Thanks for your reminder. I didn't know that.

> If this samples/test is useful, refactor it to the test_progs framework.
> Otherwise delete it.

I'm trying to use the samples/test to do some tests to verify if some
functions like bpf_sock_ops_cb_flags_set() can work. Then I
encountered the issue as this patch said.

