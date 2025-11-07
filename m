Return-Path: <bpf+bounces-73984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46BAC417A0
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 20:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C6C1885A2B
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C090132C336;
	Fri,  7 Nov 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLlRaKRT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F2A30F951
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545093; cv=none; b=GQ3WgJt9IWrb3PQpyOq/0nuMivs2o2hr66fS2N4jhf3+FrdBgWV3fpz7s/dvQo5iIn9zpWHw9fw31PyFgXc00Zu4T7K4MTj2XGQm8OaWLwFLHNMvstS0ZaJ2p2Mxj3Na45gD5tarBmQujslgMGxj+yhTqBSCD3Q3KEInCz0kIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545093; c=relaxed/simple;
	bh=LwvNTetXQLBxY1Dihygez0M8/N/kMn2ykyvFcBvcJJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7vH8W5yCF6U3m7UzBvfjdPiTGh7FKMoQPFjnKPP56ZSr/gATFGtQGv//nl0xWABtXIMAqC+ItrzyqaWMLjXOQZ2iIKCHQbieRO4OkZ+ancX+01CXU4XZ6vfLuTfAQON9T/XiuGWe1zbzj/hhvLxRpjvLUTErJGiDr2qrg9Ze3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLlRaKRT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so1277582b3a.0
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762545091; x=1763149891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LwvNTetXQLBxY1Dihygez0M8/N/kMn2ykyvFcBvcJJw=;
        b=DLlRaKRTnqoAajt0XMqGZ/FRnmqR6HCM5VMVE7HeC61NZoFEpYs27LL67qQrKS4j+h
         9Ry7uUwwdci81mGC524kie+CXxv+7Kuri2GILxxSZHJsdixjHL9JrFToanPfuIYSAhcB
         WLl8NtbgLKiE8LHCHiMSqEI8pg4Io18sa3vNunhZReQ52riAl+LIOBCuSoMUNya42EDh
         DF4aj+Ayyiot8mg1DFxwkVWJnHAW6EJ4cXtxKl0cjQ1Da0OeOMtzLN1fT4QJnPoqELnw
         wFfxsPka8v752CfJbJLDZhQKSC5tjKne22Yv1PumoV76Oms6Y5qTW0ag4N4Lig04TxbQ
         q1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762545091; x=1763149891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwvNTetXQLBxY1Dihygez0M8/N/kMn2ykyvFcBvcJJw=;
        b=L2HKFVr1YIrOnSMebL3+ybjxKUOGLfMhzUbvocYH88IiRyB65EH1UT8f1WqHZHMMfG
         vFxz/8KbD6Mhsvyf1kLOvu+MPkjYgmpt3Z+Izip/FU8XD+yU7CZCWM3LbWRBa7ADwhGf
         XOJvuwH5mzDC3tV38JVrWYOePzvqcUMQQrClnoOsykGy+XQo71JqDtV4ySW17dAFj5S0
         8GwFX79uuFLT/02ZBd7w710pQ/Px19UhuD9hoLNN3wmjA2r4QKiiBTsaKl/LGgz7nYAI
         7J0iWX4XtBLyFnAQfk8KlNjhjSG93E6foBE673yQKF3IRfpS5ZhM2N0W8UUVCdtqsFIF
         jnfw==
X-Forwarded-Encrypted: i=1; AJvYcCX4+wCxTw0JWlIpruFtjHdeBLbQ/49AW9iLcs5XuhZyN4WoFX6Npni3FYuQsCDkgEEA0UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjrInCiopAAIedPrm98IcZ+QbdZBlaGZk6sDdJyrhBxGtfRYC
	ewrOO6YLVJJIeX4jfdYFS5El5So8ZyAJyFQW/5KI8WoqWoMCySZmWK3A
X-Gm-Gg: ASbGncvao6kIznKI68Nxc7R+0XHpoCQu8VKWDnuIR7iQoHZR0aq132/8Mew6zCf9ocx
	lE00UKLLyGdbIESlglPds5sRY5d97VZ2f8qhj+Djz5NCbxAk4exeCSQiDRQJSE1zPSH0nBE3Fy8
	9eEhYxVDkvo1x90UJ4+vjnKz/p9mDYpwDXVs4xPG3XfNPKvK0EsSApR6ktPzqXVXUXnDFcRxyD5
	nXjYTOClolfFGTLIZiuJXQhz8T66DjJt04LsbgEhDwV/eT+AXIBEn9P/YdICTs+uKf/tiCqb9Ab
	KaQay9cbVA++4e1qbSDV0kIOR0VHjL46LQsj3hcsOszvrIvWbkkGGYzZQ66XWvKxQe1S1bHG6Zp
	uiMvB9cW4twyf7o3ntbwUvr4NGEIz7VmP40ZfCyGri/nGTpb1D3FzDzw5X1NUQCp7rWIlsEeSQD
	vnI0mg//k=
X-Google-Smtp-Source: AGHT+IH4kmDiMAeLWcurSK75qHGKTOjb0w2R9m5O1XJZDMjTuFy2C63qThx0nk8Vy0U5BQOcF8ugbA==
X-Received: by 2002:a05:6a00:4fd4:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7b22737e23cmr459610b3a.32.1762545091182;
        Fri, 07 Nov 2025 11:51:31 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cd01sm3683726b3a.15.2025.11.07.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:51:30 -0800 (PST)
Message-ID: <6cbeb051a6bebb75032bc724ad10efed5b65cbf7.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary
 search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, bot+bpf-ci@kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 zhangxiaoqin@xiaomi.com, LKML	 <linux-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Alan Maguire	 <alan.maguire@oracle.com>, Song Liu
 <song@kernel.org>, pengdonglin	 <pengdonglin@xiaomi.com>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>,
 Chris Mason <clm@meta.com>, Ihor Solodrai	 <ihor.solodrai@linux.dev>
Date: Fri, 07 Nov 2025 11:51:27 -0800
In-Reply-To: <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
	 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
	 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
	 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
	 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
	 <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
	 <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 11:01 -0800, Alexei Starovoitov wrote:
> On Fri, Nov 7, 2025 at 10:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om>
> wrote:
> >=20
> > On Fri, 2025-11-07 at 10:54 -0800, Alexei Starovoitov wrote:
> >=20
> > [...]
> >=20
> > > > > > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const
> > > > > > > struct
> > > > > > > btf
> > > > > > > *btf, const char *name, u8 kind)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out=
;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > >=20
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (btf->nr_sorted_types !=3D BTF_N=
EED_SORT_CHECK) {
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (btf_check_sorted((struct btf *)=
btf)) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > > > >=20
> > > > > > The const cast here enables the concurrent writes discussed
> > > > > > above.
> > > > > > Is
> > > > > > there a reason to mark the btf parameter as const if we're
> > > > > > modifying it?
> > > > >=20
> > > > > Hi team, is casting away const an acceptable approach for our
> > > > > codebase?
> > > >=20
> > > > Casting away const is undefined behaviour, e.g. see paragraph
> > > > 6.7.3.6
> > > > N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.
> > > >=20
> > > > Both of the problems above can be avoided if kernel will do
> > > > sorted
> > > > check non-lazily. But Andrii and Alexei seem to like that
> > > > property.
> > >=20
> > > Ihor is going to move BTF manipulations into resolve_btfid.
> > > Sorting of BTF should be in resolve_btfid as well.
> > > This way the build process will guarantee that BTF is sorted
> > > to the kernel liking. So the kernel doesn't even need to check
> > > that BTF is sorted.
> >=20
> > This would be great.
> > Does this imply that module BTFs are sorted too?
>=20
> Yes. The module build is supposed to use the kernel build tree where
> kernel BTF expectations will match resolve_btfid actions.
> Just like compiler and config flags should be the same.

There is also program BTF. E.g. btf_find_by_name_kind() is called for
program BTF in bpf_check_attach_target(). I think it would be fine to
check program BTF for being sorted at the BTF load time.

