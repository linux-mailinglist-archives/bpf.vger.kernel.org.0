Return-Path: <bpf+bounces-74125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B96C4B2E4
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF783AE5BF
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA3B344032;
	Tue, 11 Nov 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxgXzIuy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1E2FF673
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826870; cv=none; b=MvjaOP7mjVCHmXeXGB/7ccTXm5zIPpfiNlO3ZZM1kmLemGc8IC0VlE9UnzpKzjCGu7hz/fxkHzl6N/E8y2WgfH+6UimMoXZN3vNIU1UiHzPJv1Kobe/fjiHSke76plYa0yggHhQW1LFzevWceodPClalDISoRUc2AN3ivbbLhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826870; c=relaxed/simple;
	bh=T460uL9FiOLYoivH40F2G/WPk7NwyWw3CNdv0gT0zbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0p10yoBQ39CIPcKaepWHfCuIUMakItsnQcQGeipDDhF3ZZm8wFUtQDqW1Z954Tz9rD4lDPqLBAAsyOrFArxrsYHZ6z+l1TUTBr1kwF+ENtUM6GQK+3dBExi+2TtmyfGgEZvWlzvOON9k38aaOQyCFP8tO1QjfkZbyFVLylBK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxgXzIuy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b728a43e410so791854866b.1
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 18:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762826867; x=1763431667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvXEtas7awGSG20JiUM7wOBwde2r+GQBbDrxF85hmLI=;
        b=VxgXzIuy0Am0PPJHRX41/HvtJeW7mBXXIfrTFDE1oH9fsysv44Kd+22n2197bAC6Op
         7MJ1G4QHVjZ3GqTBRtmrWdfREDAiO953Qhrmyl/nd6N7g4qgwjkMN+msW6l0OxIp9O0S
         fgEzEkIbuL25pMDbNw0F1D2Eg2cZP7HeyTVEjaKJ2T0YXgAqRFCEMCth5d4tiCGwN2Aa
         U4HmHd40oO1Xtnzb26caCBlEScJpjzcFxYzfiIQqH77ACKYWC44xoixA6NMQ4ijXS94v
         7zRXOTXHgyS6JLPP3NxNgLjvkTtoKd6ZVzSjhcr6U2K/3U+evh4ttEw2dTnyTDcmEUB3
         wJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762826867; x=1763431667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UvXEtas7awGSG20JiUM7wOBwde2r+GQBbDrxF85hmLI=;
        b=qhSyXNIMwQcZ4NJIevZsU6WsjiCAlj97QABcnUrkWuHwb5WBYif1OFqAq/MrWtnAfF
         4B+p0gMW4ql9Kz2USjxIn+u3e7Qbq09VqfWfeR/oUzyf/xjop4mHHWsPLhZvjUs8kjgD
         4xAbvOoNmjDkxgAo52o2JS/NneklXXMrFxjptF+MawLSWaeCUCINHpgt+Ja8lmQ2hxFY
         IbEc0S/yOv/eDlYYqujpem9kaFFlkNNYajeSnjnmh43JQPbNe81qjS8dM3wI8UOboezk
         NmyU/oDrWRGepTVYzPeC8HNTdbX+tKwl6t8NK0VZPzZxS3NYHT2oOKV+b2W4w+lgfRBe
         Zluw==
X-Forwarded-Encrypted: i=1; AJvYcCVAcgRyE1zHSm8KLkuBphMl3kmuR/ISfJOK6UewRteKLZZYYo7LBFqOA7Afc8Uiz45gL+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMX+gFTHE3yQGsOCW5EaPI+Vv4I35rKWO+IvZUnWfHzat/DvsD
	I6JC2WKqeLQYOa/sWsfVKDbgNdrTBYJPpx/7Uj/Dhoi5sm8q8qI3FnUzEH7WFcAWbqN7b8eFMUE
	hInjWjdMcWdfSUajCLb7G7nqKxdD4E0o=
X-Gm-Gg: ASbGncv5Ap+sy0X1luywu72bSpvEfpCCUi/n9MEMPwvNH2UCUuNSaWOWib3cjx9sA0a
	fS2KxuiTjc9ZH7RpyxHR8UXg5b+nepGsrXHqgvqJAwbKFDhDXF0Z2HH1CNt/tgzeAVWyPMM8q4T
	aZFtLJhjbFEdGZbWsZVI9AB7fpEReyA28KXOV1cokGeku5vCyn/JWPl41Ece+ZdoKmE5Je+Ydp/
	1YucpE2Kxwhu32mUKJ4xdSdvZB6W5Uc9pwdeHtDBLlgFFFaEhCU8uYvBkIUT4obGPt8UGqz
X-Google-Smtp-Source: AGHT+IFuLZi1fgS0EEtiHw5TT0FBLfHLMo9uIcW5Vnf6D1qmNTB1jUjVtcsDiBNTYYr2WHBLKWaaNTLBG/+n9MTWAQw=
X-Received: by 2002:a17:907:5c9:b0:b4a:d0cf:873f with SMTP id
 a640c23a62f3a-b72e036c31emr1095265066b.2.1762826866999; Mon, 10 Nov 2025
 18:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
 <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
 <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
 <6cbeb051a6bebb75032bc724ad10efed5b65cbf7.camel@gmail.com>
 <CAErzpmtViehGv3uLMFwv5bnRJi4HJu=wE6an6S0Gv2up3vncgA@mail.gmail.com> <854a2c2ceaa52f1ad26fb803d1ad5668fd3200b3.camel@gmail.com>
In-Reply-To: <854a2c2ceaa52f1ad26fb803d1ad5668fd3200b3.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 11 Nov 2025 10:07:35 +0800
X-Gm-Features: AWmQ_bnAM2kObujKR5ov0jYGM4otiJtvPUgJ9CCt6W7Ix9UXpf3LPSTc2FVCuE0
Message-ID: <CAErzpmvgzLwxFDRPQqXjkj_a2b6X4kA1DMhP1Tew_AY0Q_JUcg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, zhangxiaoqin@xiaomi.com, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:44=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-11-10 at 09:42 +0800, Donglin Peng wrote:
>
> [...]
>
> > [[Resending in plain text format - previous HTML email was rejected]
> >
> > Thanks for the feedback. Based on the previous discussions, I plan
> > to implement the following changes in the next version:
> >
> > 1. Modify the btf__permute interface to adopt the ID map approach, as
> >     suggested by Andrii.
> >
> > 2. Remove the lazy sort check and move the verification to the BTF
> >     parsing phase. This addresses two concerns: potential race conditio=
ns
> >     with write operations and const-cast issues. The overhead is neglig=
ible
> >      (approximately 1.4ms for vmlinux BTF).
> >
> > 3. Invoke the btf__permute interface to implement BTF sorting in resolv=
e_btfids.
> >
> > I welcome any further suggestions.
>
> Hi Donglin,
>
> I think this summarizes the discussion pretty well.
> One thing to notice about (2): if sorting is done by resolve_btfids,
> there is no need to check for BTF being sorted in vmlinux BTF.
> So, maybe it's a good idea to skip this check for it, as Alexei suggested
> (but not for programs BTF).

Thanks. I noticed that we still need an additional iteration in
btf_parse_base() and
btf_parse_module() to compute nr_sorted_types for lookup performance
optimization.

Thanks,
Donglin
>
> Thanks,
> Eduard.

