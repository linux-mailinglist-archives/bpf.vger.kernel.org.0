Return-Path: <bpf+bounces-54557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30323A6C5C8
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA33461FF9
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 22:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F3233705;
	Fri, 21 Mar 2025 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzwUuilQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD8D231A3B;
	Fri, 21 Mar 2025 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595411; cv=none; b=LNCxhLdqrmbv3MNjF675lPuG+Pzvyaa0DCDi8qdDhO76I3WK1PX5BjEwGxwVV4/r1G3mLk1bt/faGDoKb0JGLCy4UIFArEQtbwdPNujBKIhp7cVOmJ29N+KiHAfNkY+IaNz2Dmd3TDETUrZs69KbQzDkm9szIal1Zr4j0j2Tep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595411; c=relaxed/simple;
	bh=McojSxNO9gqGGYuPqlD7OTJKX7Y9wTjkkf5Vw+TLAxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fMNZCkiQRv1CMH2Mdexv9TqmwLyuvfMUtBrsYyzoKDRduGoldgG5eT3M2OkjZ3WGxMAziYghC1YO4OQuacnMFVbNSHw0RIKQTrSLDKahtIsdv0J2SM/rKdhUZWTzgOht6tzMGswPWDmVdNzvvpvJ1xRxAJ1+kE9U1k9DXl83Sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzwUuilQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2241053582dso17756425ad.1;
        Fri, 21 Mar 2025 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742595409; x=1743200209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rO6kZlYBodR+iNzCw38n1gX1Mhj3Y52+rByQ+vHqnPg=;
        b=bzwUuilQFB4bvQWWvFKIzadn2SjN4/Y2kGUZOQSPbjTSiGz/nLM4rpJXxhlceavvI1
         wEGJBCc3+PN5FVkW51MOG6Z6iSr6jppYBO6i7tBeP5S8f0odVYcaQLbOvB4I3LZBES2e
         6x0t4XhV4+5J/FT2czEftgTtfKuIyJY2qaAfZf2iE4EV6zIHDdCqihVh6CbO+/S9SFIX
         +rxtwffoFUfotz1eNNMft02Gt0fIFu2wpVZx1WNHTexvLMXnTpzxBNI6rK/hXithdHL3
         r3VZsaJRQvg738U2v3U8I2l5792r/tWwFJ4ZO3X0lbhqeVl1RJQg3iIJY7eBnJX7onUN
         cH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595409; x=1743200209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rO6kZlYBodR+iNzCw38n1gX1Mhj3Y52+rByQ+vHqnPg=;
        b=XNzQLPUrcBHqgmNUvs8ZUyF1EyW08wXXrvILXExZh6mdc5rxsJnx8hq2jXlj7HC2+l
         84JQKuJ1PtIBxzBenI6I9PJJblITLRCbyEE42osNXQRr48c8uzAatl+yyZwlKp1p0ctB
         OzRTn/unZa4GtHf9MrgC513ODlnwNnde+LwrLV4W/oCBp7u9hjI4i4SZfa51u7AM5wu6
         FygKBgmmeQOP11fqFWUS5RxM+0+t56PB8TBtfrHnR/cqMYuTwlTP4wGNDXlgQlwiGIaX
         jPTeH3hvVo5MLjYT0nVInJeCsjgIB1CXNWec5PEBQzeLVdqPOYlEtOi7KIas7+RZj7ob
         KyXA==
X-Forwarded-Encrypted: i=1; AJvYcCUT5WHLRU98+dVTbmBPANEYhNftMahN6pRhvt4YznTjXqBWKz2Zel1nzhkR/r90Sg+EQQG4EkXBu73IqoB7@vger.kernel.org, AJvYcCUyGl7wAXqYUTX9NOkwx0o30IVDpCL+zIW7esHtWsUYWV/5G85uASGCLU5EzdNs6z66J1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvycsUCfbPs4sQAZcq6Yoz+4WhOSrU7ycZWQ5iEyqz0MNifP2x
	TBdfFbmizADJwHAlhYSQ+cXzF1IDsraE8P5OFwfFTmufZkuPgu1e
X-Gm-Gg: ASbGncu5gehyZBhL0UJ5QyTKzOjUcCCT36y3g5aW9l0i4p8GudJvNKKhUjJ0RAVxe9j
	cUPPY/EZKR3iRO93hARyGtxHEgNdO5VZetRrg0BxMDoRczGS47cGIMZNSAXFxa3kBDPlvKOzMOM
	+dmhVuQ8KeSEaVw0/87XLYK4NbNjtY3FNpkmzZCaPzt3TSBWh6kXgbM4oznmsZz20Ka2mjsHW1+
	T+XZ5AiYru03XjmTr/6n5ZNcmTYIYlOnt0lYPknsc5IGiueGrnlZIH32tlOQvUWEXQdtDOo6e6v
	XfLEeDpDcTlq3KzASZrWlsIy7dXtRAUsG037TEqrfql1Ca9oJP4=
X-Google-Smtp-Source: AGHT+IG+7fbfZqhtDkRho2xcuIKFy2kY62DiTesFWRmKF/XNZF1b8e5xATfB1scEeKvKEHs7REYlDg==
X-Received: by 2002:a17:903:2ca:b0:216:3c36:69a7 with SMTP id d9443c01a7336-22780e2fdbfmr82432295ad.45.1742595408938;
        Fri, 21 Mar 2025 15:16:48 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45029sm23147485ad.53.2025.03.21.15.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:16:48 -0700 (PDT)
Message-ID: <44d4adae6a5398dcd97afbe2c922f8c9a71598f2.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix out-of-bounds read in
 check_atomic_load/store()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kohei Enju <enjuk@amazon.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Peilin Ye
 <yepeilin@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Kuniyuki
 Iwashima	 <kuniyu@amazon.com>, kohei.enju@gmail.com, 
	syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Date: Fri, 21 Mar 2025 15:16:43 -0700
In-Reply-To: <20250321110010.95217-5-enjuk@amazon.com>
References: <20250321110010.95217-4-enjuk@amazon.com>
	 <20250321110010.95217-5-enjuk@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-21 at 19:59 +0900, Kohei Enju wrote:
> syzbot reported the following splat [0].
>=20
> In check_atomic_load/store(), register validity is not checked before
> atomic_ptr_type_ok(). This causes the out-of-bounds read in is_ctx_reg()
> called from atomic_ptr_type_ok() when the register number is MAX_BPF_REG
> or greater.
>=20
> Let's call check_load_mem()/check_store_reg() before atomic_ptr_type_ok()
> to avoid the OOB read.

[...]

>  Memory state around the buggy address:
>   ffff888141b0d580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888141b0d600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  >ffff888141b0d680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                           ^
>   ffff888141b0d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888141b0d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>=20
> Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da5964227adc0f904549c
> Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
> Fixes: e24bbad29a8d ("bpf: Introduce load-acquire and store-release instr=
uctions")
> Fixes: ff3afe5da998 ("selftests/bpf: Add selftests for load-acquire and s=
tore-release instructions")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


