Return-Path: <bpf+bounces-37895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304895BF9C
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 22:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398AC28575F
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 20:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6D1D0DD8;
	Thu, 22 Aug 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaCyw7jE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A82AE77
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359032; cv=none; b=bLZznO1meGb6M1gm/VAUWtKyqrJAtNWioojaqMbK1q2GGxJrz8tWHYCaAe/vca7+ZtuHHvGyFQEHbb1z1B+6SAFGHvKPgLLVWhdgDEiYObacytTMGGVAz7ndz+YL41e4YEjCywfxYdL5xdkH0V1ObOucHOaiCwz5UzbdXCyV9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359032; c=relaxed/simple;
	bh=5VVY4PRkn1LjbaazDEC2aOzcRBRkqiYNhWp/aB4xli4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbS63xWeGCisw4+iduInbM0QKW4PyzbvKpuhIv/y/4mFni1b+uVSvkFJip0yNNM63LeGZhwHEtyNL6Y9CZP7+99rs1gP9Np1SvtXH93K1ji1YFy2LC9cG3Yt/tf4xMuqZOHZnjJmmGTjfY7Gjh+GwrsTPPVDsyNGTWrPdsWjVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaCyw7jE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e0d18666so8919555e9.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724359029; x=1724963829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS4uMQU5fb1mg85fuQ9DQv5TfDOT/2FzVWqmnLjMz0M=;
        b=QaCyw7jEPftWPvfyN22qahDapVulMqbRZzel+7Kpms+xsyQhfReXUrx0n6EZee8Jqj
         yt9s+5mLWo2MxsqeGIpwswWloUcNBishjxCZe+ibifLtJz1kTQoekbZJMfy/PtewyCTX
         VunCWQgd4dRsY9dFKCcjf+M0pGiw8kq3ZH6soSTx/bJ3euerJpsfMWfx3LBEFpjCMunF
         LvNvlbUlzBkt+DcAjEQ6lAbjn5l21hM2vwi7aDiI9Fy5ToHuR1Y4fksGr6WErO7XrrXn
         RoISWHZT2YHnULvo+oxQZiB8YtKFdaQyLMx+MTM//4wvZTn7vOfLRXbNyUdamRqZyFHy
         Md/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724359029; x=1724963829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iS4uMQU5fb1mg85fuQ9DQv5TfDOT/2FzVWqmnLjMz0M=;
        b=VnRBW0jpB+8WZ+K62iEagUaGQGmzR0oxkHpdJYF1RrtNKYlVe6EOPt5EoGFys10JJG
         sqjZ1CEsktSn4jhR8tI5ygsOLJSJbHCmtI/qYxyWc3biGS52G8sdAlqrAPE5r9ToTioY
         aZx7OgHngAzSRpw/tFl2v78NeyrPQbDcICqbch7iqWeSsaF8MV7FnEflHrSp8JIh+N/G
         0Xot5Bi1P/B4Wq9zwa1LqXEGnLbc2/sOFmK5IdUgQe2jftkXM3dG5p6yXSqyIWf0tCBV
         zqZzlgIzRD3XKMhFrXT4V4zGeXZceqpK+SHSS5K68ipGCBSp51MdAuLHxPXwb05zAsih
         NtOg==
X-Forwarded-Encrypted: i=1; AJvYcCUkqVvYMhJGEUGXBr4QBk9WNxcGnvTjbZysLY7wsPRivd0cUxTkAi5i8hABLX22IQqZPP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7PM61z3sXZOZxCiQaJCPRDF7ivTOfkKuKeF3rsIoJ1oDghRF
	WevFj9XOs32t2i17GgLNmDWBCHzBj1ht1o7/bbv9Di5tmLxn9n7x5mUjIBCBrnHdVcsUEI+b65s
	3d4OKb6lO1DxKh5W7Icma5aK4kLc=
X-Google-Smtp-Source: AGHT+IFhMviN4YjO3Kr5TUtvpJ9Sfgbel9nzm9fKJyEXXfGSwubbgXhjZUOX/IMStR1KxGvDHkK4BhUI599XMFHc7AQ=
X-Received: by 2002:a05:600c:1c1c:b0:427:ff7a:794 with SMTP id
 5b1f17b1804b1-42acc8d38b4mr1297715e9.4.1724359028401; Thu, 22 Aug 2024
 13:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114612.48486-1-leon.hwang@linux.dev> <20240728114612.48486-2-leon.hwang@linux.dev>
 <CAADnVQK-f=dCsN4E2goj6YjDkTD4PhZK=VTZygaUsK9JPD=Wag@mail.gmail.com> <8730a5f8-cb17-4c31-b62d-5faf529d7d89@gmail.com>
In-Reply-To: <8730a5f8-cb17-4c31-b62d-5faf529d7d89@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 13:36:57 -0700
Message-ID: <CAADnVQLg19P1D2SvM+-yFawsscj4V-KJOaXcu7LSdpjtb1dPqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix updating attached freplace prog
 to prog_array map
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tengda Wu <wutengda@huaweicloud.com>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:01=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 13/8/24 06:34, Alexei Starovoitov wrote:
> > On Sun, Jul 28, 2024 at 4:47=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_pro=
g_type() for BPF_PROG_TYPE_EXT")
> >> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf_verifier.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index 5cea15c81b8a8..bfd093ac333f2 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
> >>  /* only use after check_attach_btf_id() */
> >>  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_p=
rog *prog)
> >>  {
> >> -       return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->dst_=
prog) ?
> >> -               prog->aux->dst_prog->type : prog->type;
> >> +       return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->save=
d_dst_prog_type) ?
> >> +               prog->aux->saved_dst_prog_type : prog->type;
> >
> > Sorry for the delay.
> > The fix lgtm.
> >
> > I reworded the commit log, since it's too verbose and applied to bpf tr=
ee.
> > I will apply selftest to bpf-next when the fix makes it all the way the=
re.
> > Otherwise there will be non-trivial conflicts.
> >
>
> Hi Alexei,
>
> Could you apply the selftest patch to bpf-next?

Now applied to bpf-next/master.

> I'm waiting for it for my new patches that fix the panic that I
> mentioned at
> https://lore.kernel.org/bpf/172a5daf-8a3b-44d1-8719-301a6e8d196a@gmail.co=
m/.
> Because the new patches should add tailcall selftests based on the
> latest ones.
>
> Thanks,
> Leon

