Return-Path: <bpf+bounces-42738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060789A9756
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A351C229AC
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC014263;
	Tue, 22 Oct 2024 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxXI30Gw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB3C133
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569200; cv=none; b=r+ohDlwB90rqvnyH+Lifk8Y1AsNq9jYYJUIJxxbqubMZFPiGqDN3PnZpQ8YEBJiifETfgeYVaFikFFTvfZOwNQv5YTOL26vgT2BOU1kUCvjcCTj6yFGMG9wIbUufztcTOulbC8WU7bJ5WhRsTX8xBrQDDwYNDfwbjVdBjR84hj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569200; c=relaxed/simple;
	bh=xSb4VM6A7Vgt7evryMTHTPmlcyz/jy2MwUvigY4wf2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEatcNv9sVs7syk1i8uWnqxMiEg9waZaM4m76qy6gpDM3fUiayF/JVz3sLHweencq2k2wPvWOFVAqQq9wL/9ySq5SCWTNe5105WhDdkr0knBV73ZZMZAhM0zkteuqRyU1uGfE3fvukeuyaxvPk7Oz7DMkqI9c/ex2EGwKDdmBqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxXI30Gw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43169902057so27605805e9.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729569197; x=1730173997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCQexl7XiYKpPnRoCz0IN3vBPxLAGTcsLAtMRywo+ig=;
        b=OxXI30GwViu8ubKec/CgRln/EmsiNvKTKuk12z8JcPw7w4994me3ROcAz2mCUOidNc
         MPkZ+Wj55ZfCRGwhz3S1OB939bke5YvdPUsBmct2mC0OliOhSakdvp93Yp1m5YSoC0qV
         c9irfoB6V5B9a54dfNtza9ejxQli1MJErSZ6NLqbdKSpi2Mqf+95Mxwj6QrktacC3C7g
         VNc5jJysDgQ4Gb4wupIY/ZnbiaGWv4Ks8nK19M0wpE2+gxFtvVvb1E8U764AS37llrP5
         6VNyCEinqGRu9xkn8xiCON47o8i6GdaL71c2QrRKRIvGY0tP/cESPDZEtIKKqJ1tfzl7
         hR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729569197; x=1730173997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCQexl7XiYKpPnRoCz0IN3vBPxLAGTcsLAtMRywo+ig=;
        b=q0Ki6dprM4QvPb3SrhRCsc+3+DqSp/UjN8rzMMwLZd3SaT2FmE6FGW1c+D45yO1xBY
         CZt9ddXrPVXy+kkMwvq3Bxd1TmKdQEX2hmAsYp4WYxyHfQ9p+LSNC6cCAU/TE5oDLuZ9
         kPVEGigV8CC3+wInYw6BB+RX5zHk2IDIKUWStug0vVVMXsO3ENs81FfMkNMegJYBM4G8
         XV2Rf4I9xfWieqpqqfwpegIkG41BcPV99g/H6kVrjUrpLkFCybguth2+rTe9PqA8VVos
         YGL/k0IQdksPXCZsZC20ef4VRHVjq1Qq8TwDA54lJ6rRNgldKKne+XJz2h2mOZVjSj1Z
         ddPQ==
X-Gm-Message-State: AOJu0Yw0IkuKNz5dXVn8Hphcjvb2wFfuOebrSwLcU2nkAqCiym2OhAxC
	2kx4/qOZKCbJiIDSGMUBw8k70iBTlrpnTLk03A16pi9ulhdSPWAkv/mG5PW2vZ+Q824EKXiSKlx
	SpZasZb++yqWm9f7mtWx97pTpz9o=
X-Google-Smtp-Source: AGHT+IFY4m0G7DjvMQ9DeNaVlmNvvfOx3r/ucWpujbiU4Vv5CoYWHU33/7t5cCbUu2u1gG6lpQWoHnCW9pGV59+mYEM=
X-Received: by 2002:a05:600c:4e0b:b0:430:57f2:bae2 with SMTP id
 5b1f17b1804b1-4317b90e566mr16795295e9.23.1729569197076; Mon, 21 Oct 2024
 20:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-2-houtao@huaweicloud.com>
 <CAADnVQJ67TERc5Ag22f_O0BJJPmNpQYvxP08uBa0ur6FRdJoFw@mail.gmail.com> <39cd6231-0d58-14fd-efd0-52dcf0c25a06@huaweicloud.com>
In-Reply-To: <39cd6231-0d58-14fd-efd0-52dcf0c25a06@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 20:53:05 -0700
Message-ID: <CAADnVQJD_ViXZ4Rx9GkgtDs72wW2no_5fyqM-HJ4=uVisHGcHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/16] bpf: Introduce map flag BPF_F_DYNPTR_IN_KEY
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:46=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 10/10/2024 10:21 AM, Alexei Starovoitov wrote:
> > On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> index c6cd7c7aeeee..07f7df308a01 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -1409,6 +1409,9 @@ enum {
> >>
> >>  /* Do not translate kernel bpf_arena pointers to user pointers */
> >>         BPF_F_NO_USER_CONV      =3D (1U << 18),
> >> +
> >> +/* Create a map with bpf_dynptr in key */
> >> +       BPF_F_DYNPTR_IN_KEY     =3D (1U << 19),
> >>  };
> > If I'm reading the other patches correctly this uapi flag
> > is unnecessary.
> > BTF describes the fields and dynptr is either there or not.
> > Why require users to add an extra flag ?
>
> Sorry for the late reply. The reason for an extra flag is to make a bpf
> map which had already used bpf_dynptr in its key to work as before. I
> was not sure whether or not there is such case, so I added an extra
> flag. If the case is basically impossible, I can remove it in the next
> revision.

Hmm. bpf_dynptr is a kernel type and iirc (after paging in
the context after 12 days of silence) you were proposing to add
a new bpf_dynptr_user type which theoretically can be present
in the key, but it's fine to break such progs.

