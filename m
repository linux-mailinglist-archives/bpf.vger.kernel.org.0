Return-Path: <bpf+bounces-16688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B896B804440
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A131C20C3E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E91C15;
	Tue,  5 Dec 2023 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irguSMCs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2A113
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 17:48:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332c46d5988so3998847f8f.1
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 17:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701740904; x=1702345704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdbJtEo+51qY/ppUYxcysb55DeSZaXaMbvP46a6/r40=;
        b=irguSMCsKRTl7TJ5T0leF+940uk0NYKbqhN4v1g1MOowv2aCt9A9lAmF5ED8eKj9fQ
         iyg6KAiRtKNxha7GCAM9kD0EdAbnYkX5CjHoCSOQfyuEohP887B/JrqRM0rJ/zTW8DcF
         rsfalXXGRY6cVXMZqFUrHcx/MBFfX3/DMNXe4r+xdnsedTJ1SEctqZ9h283soMFyD8qi
         N6PFH7q2N5hVY9leYf+DdKeT5KPJblUypkKvBPBbpBIMleHCBhpWpv/JOZS5BH+D/rSA
         SdRbPCBDptE90JvLvS0jsflj3qND09nEHmvhl9qLNM4J/KIdREhef2fsLdnuGFFmxgXo
         ou6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701740904; x=1702345704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdbJtEo+51qY/ppUYxcysb55DeSZaXaMbvP46a6/r40=;
        b=AXTYonL6gf4Ikb060GDuSpD4ykRaVP5IgM5HlfF+14XvlTrpA52ZLBSwpg+DXqkMaG
         aLEEtMx/nXb+50WyzedpwGIWzTyhmQmEuKx6jxEiE4jhrCLlsU1O2LkgDZt8jZvHpzmM
         aVGFIdfKznYSrY71yMSz8z/p+JdSExy74lcJlGzUJF9pIgtosyAncmMF16pdUOU+Qz80
         u4fpW+A0X5aZWn7OIKqqQLoOTFS/xNVxzqk3Lqg7hb8BbyfZx8jKXCEx84MGNtHzkjyb
         c9BByo6QnOmlFVvDkK0UJk2t9/Rg6bPDQyQBEfd86XzjLwuMOFyGi01rbez1FDQ1OHla
         iZRQ==
X-Gm-Message-State: AOJu0Ywwm3OcLqBjYY4D6+DxU6jAyfFIaST7pXvkzriDvT3yIO2pXA1d
	bdHfalMpTNcSWQE2Jjv0EUm+2vbX7FQKREzTMWDlbstQ
X-Google-Smtp-Source: AGHT+IHnX2ozhFToCtrpxSEijwICqTnfVhMoLI7v6pKCn1Cfhnsagd3jCUGeMM7DeAtxE/Z/oyBG/Ek5djmnKmZWAHA=
X-Received: by 2002:a5d:4cc7:0:b0:333:4287:868b with SMTP id
 c7-20020a5d4cc7000000b003334287868bmr2115722wrt.129.1701740904481; Mon, 04
 Dec 2023 17:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
 <20231130140120.1736235-8-houtao@huaweicloud.com> <20231203190410.qcyu3qmdkxavim2t@macbook-pro-49.dhcp.thefacebook.com>
 <db491a00-81ad-9c9b-7ab1-e75742730994@huaweicloud.com>
In-Reply-To: <db491a00-81ad-9c9b-7ab1-e75742730994@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Dec 2023 17:48:13 -0800
Message-ID: <CAADnVQJLqcgrjbocEP7107Wf76bpni-ip4h44sKzuuZGr1KzFQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 7/7] selftests/bpf: Test outer map update
 operations in syscall program
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 1:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 12/4/2023 3:04 AM, Alexei Starovoitov wrote:
> > On Thu, Nov 30, 2023 at 10:01:20PM +0800, Hou Tao wrote:
> >>
> >> -    prog_load_attr.license =3D (long) license;
> >> -    prog_load_attr.insns =3D (long) insns;
> >> +    prog_load_attr.license =3D (unsigned long)license;
> >> +    prog_load_attr.insns =3D (unsigned long)insns;
> > Maybes keep it as (long) ?
> > There are plenty of case where we cast a pointer to (long) because
> > it's less verbose. Signedness shouldn't really matter.
>
> It matters for 32-bits host. Because insns and license are the pointers
> in kernel space, so the MSB of these pointer must be 1 under 32-bits
> host. Assuming the value of license is 0xc000-0000, if using (u64)(long)
> to cast the value of license, the final value will be
> 0xffff-ffff-c000-0000, instead of 0x0000-0000-c000-0000.

but on 32-bit host upper bits will be ignored anyway.
The kernel will cast aligned_u64 to (void*) first.

