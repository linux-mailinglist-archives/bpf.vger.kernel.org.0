Return-Path: <bpf+bounces-36319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52347946511
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F451F23AE9
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118773176;
	Fri,  2 Aug 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGZ08BH0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAE1ABEB7;
	Fri,  2 Aug 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634235; cv=none; b=mkxt4gcynN4Lte/9U2IMPUJIwuPRW5l5Ml+gG/tupsUMxcV+9NjFdT+iXaGmIe8kmCgHZd4butEmLdPngoNiwKgnGsD6R+28O/GU7VdCTm89GKqxROI2pWnhhl9nRil5ZMPkgastJSoaSz4n4hPsDJo/Js5FGtvNmWMybP9Z9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634235; c=relaxed/simple;
	bh=Ibk+J4zpeHWw0nycjk182qH2g3alpmqF2OGszhA9eRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/9FTUR6bpN6wKSbAPUw24CoZPcXH+S8eWjCZ5dPCfZXLbQqsiqe7j7UCT6epchd4tzUvClCPJWcehYnClKwd9kHxUuOHN++EiRbXybk9AwzFz0SB7kLG2fb2f5v7eQW3rYO8wKaJgtKiP7FDW9tpfo67x36A43UlkD0p7OKDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGZ08BH0; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f521a22d74so2824683e0c.2;
        Fri, 02 Aug 2024 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722634233; x=1723239033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVjj16xm78VRhomfDnNdeR4sdbzwK9fAex3h+9zTg+E=;
        b=SGZ08BH0OLHBGNwZeUDV8hUw4hVdoKnjaKbgiE/SHIUr4wOiEUdOO/n3g+ljkSniOK
         lwFtrtraL4lR1kBDS6/GDNrgDm4FrUS0JpxnOLGWp28/SmgU5sQDNXfD98lwDdG9I/Ej
         CNxCME9Xss3sd2a4P3PR29bUBUrNygzV7qyZRveErkGwpbGMdG72DlCcUHyMj6/CAN9L
         iFpDaF9VBJMzBymDEft/7oq11vcLvakYWWrbLgvZ/egkgAScSVroDjP3X+WL33PZmWx5
         MykH9Sxk4CvtNBxdQHkI2QTkF7wdMWz04ii2Q3NyoRYg5uY9FC3FojHNJqn/4aBmPvip
         5sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634233; x=1723239033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVjj16xm78VRhomfDnNdeR4sdbzwK9fAex3h+9zTg+E=;
        b=Rc6Kog0G5iz/5q0KZYCKBWDPMhay2CBRANIlaMGgUaL71S27S080xmREBiY4pkHhwF
         KlMGRyc5r1mgdDt6ojnsvxTxwWPLBplXtrz5R+RtBjo6XVAvjRHIvKPknS+gwP5wDWAZ
         a3YqsJqS9QC1GGa7L0H01Qo6Z8OXHn5DwHYSRMn/tO/frwZAoPfcD6Ug/gQvvq9QzC4V
         jRbGhNaCzSuGNyYcfZW0PrbY1O6jibGvEfjgS7PpGD6AtCsvXeK2NsyP9KupTpTrd2sh
         8RM5vzJlO+Kb5k6Jvf0sKjBpCd5rYDNzXOi5Ki6g4DanAZ+DHSlgx+9NFb9DmtPtt+4F
         MtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Qb0wW2rQjHnEnRupEUqLl8cwcfntX+qZqL+8ySs81PThyNoFO6v8JJT/oJHR5i0RSQLOXyLmO06Cmtxibb1MzWooGjgy4yVPUde3Y31khgrdV8aJEz9toz7u
X-Gm-Message-State: AOJu0YzPSWleA17gPhILO9T1uisDB5p3NDY0zE42eWXBv/kCVCht0X6C
	JC+z294O6aT7NZqTwkTQW3j8Se2jnZkF3qOJg+y50qjBilds4jBTE4Pov5LFWN0sFEyIDWI7ANH
	FD4RsiOMEm2Bdm6I1YzCw5qiG6cM=
X-Google-Smtp-Source: AGHT+IGOqJnD3lHiCVXHSWjTom48F4Td572Qu6RTWCrU1ElTuowqLc8FbkP86Pt+Bk6J9d9quBP1DjaFfBcNm9nwGPI=
X-Received: by 2002:a05:6122:3c56:b0:4eb:5d5d:6add with SMTP id
 71dfb90a1353d-4f8a00422fdmr5760846e0c.13.1722634232775; Fri, 02 Aug 2024
 14:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com> <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com> <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
 <CAM=Ch06Hps=xv4RmHdWESOjN1pSW2Eo8Xn=qQV+0T9TeNzuPHw@mail.gmail.com> <xhc5uslwucbu4233iqszgsj3q4bsu2xtjtrh5qmosqlm72uq52@mhwul4hzgd3p>
In-Reply-To: <xhc5uslwucbu4233iqszgsj3q4bsu2xtjtrh5qmosqlm72uq52@mhwul4hzgd3p>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 2 Aug 2024 17:30:21 -0400
Message-ID: <CAM=Ch06FP+emu3s_2_XNVm1CPfBkf_Ei-xuJgsN=DWM7FFEtxA@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf, verifier: improve signed ranges inference for BPF_AND
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:26=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
[...]
> That is great to hear and really boost the level of confidence. Though I
> did made an update[1] to the patch such that implementation of
> negative_bit_floor() is change from
>
>         v &=3D v >> 1;
>         v &=3D v >> 2;
>         v &=3D v >> 4;
>         v &=3D v >> 8;
>         v &=3D v >> 16;
>         v &=3D v >> 32;
>         return v;
>
> to one that closer resembles tnum_range()
>
>         u8 bits =3D fls64(~v); /* find most-significant unset bit */
>         u64 delta;
>
>         /* special case, needed because 1ULL << 64 is undefined */
>         if (bits > 63)
>                 return 0;
>
>         delta =3D (1ULL << bits) - 1;
>         return ~delta;
>

This [1] is indeed the version of the patch that we checked: the one that
uses fls and fls64 in negative_bit_floor and negative32_bit_floor .
I replied here because you had CCed us in this thread.

Note that for checking in Agni, the implementation of fls and fls64 were
borrowed from asm-generic [2,3,4].

Having said that, the patch [1] looks good to me.
Tested-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

[1]: https://lore.kernel.org/bpf/20240719081702.137173-1-shung-hsi.yu@suse.=
com/
[2]: https://elixir.bootlin.com/linux/v6.10/source/include/asm-generic/bito=
ps/fls.h#L43
[3]: https://elixir.bootlin.com/linux/v6.10/source/include/asm-generic/bito=
ps/fls64.h#L19
[4]: https://elixir.bootlin.com/linux/v6.10/source/include/asm-generic/bito=
ps/__fls.h#L45

