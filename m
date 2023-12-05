Return-Path: <bpf+bounces-16696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40D80457E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8BB1C20B8E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CABA6AC2;
	Tue,  5 Dec 2023 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gci/luEx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96645BF
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 19:09:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33330a5617fso3191699f8f.2
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 19:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701745798; x=1702350598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIwwS/TqxCm1wSkTJ7uedOsj3SdtTg6yH3ZXWVBiU3c=;
        b=Gci/luExWbdqpKdXGRMCjnDeW64UystCY4hiUe3cd/o9UXdS+bEfvBkKv6vjkETPVF
         s/pTg3MhBW9w2qmxHiO7W0YOPoI50jc79CDvFOO87mcuZYVYhe+jMr3xsb2hq4k1/eL2
         hrfof33gQTE8OBLvW/Ud7aQgMxO5aaq05m/Y4vRXuHb+MME0bs/qGSv5KDc0jmj4uf3v
         3sKu6+ziDz9nV1N6JAKHy76pYVEWCZlMuEMp7ctsMLC/Q14aINaHeYxYFVauFSDjyTym
         HI6+k/JzNFluxZnfSD34D4yHq9NUJCQLO7sUV66+8c5+vLh1stpnqq6kHRpDcROK9xhB
         eInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701745798; x=1702350598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIwwS/TqxCm1wSkTJ7uedOsj3SdtTg6yH3ZXWVBiU3c=;
        b=Hvq5xJ1tUMTUUa3lgmWeCwqMMl+AciXf+WLSdbus1S7175inKMCsj5uF+bv0TmeG1O
         ud9ix2JGFQWlyXvZHe7O1zqME1fkACDpoYNH0aN+2tTAwCSbQ7E6B+XdwpWRbR3GgoPS
         vk5gkHD0DLJ9Ga1lf4J4UUNXlcqxRae9jpLflCYNK6b6DoZSSTXgyUfJLYIxm/tzkLsX
         0YL1TIZTBsL/HC2g2KydAw28KxQ5yUAy4fOn2HNLAZhRHlB+TiDBAg5Ofhplow84R9wV
         jdTot6zsqdBGozzsuQ+4tlV4n576Qu0XW8BrMFUEtS1Cnp8z55c6wo1EnlxqzkHP9JCM
         6z4w==
X-Gm-Message-State: AOJu0YyuBlxH0TbE0AUfLCrLTzuTblpTVOuGknelz30Ocbl2Q8v61vSG
	ak5oSuosEewqjNXpkEF4xQUz0eEZiy5yr0LCWFU=
X-Google-Smtp-Source: AGHT+IGNnNnj+d5/24QEvOjCdRMpqCLFSduBL9nTj2nzzsIL70YVDZoCz4BX6gUCTXTbiRtsADi9JdXlbMKYhPNq77g=
X-Received: by 2002:a5d:65c9:0:b0:333:394a:ed97 with SMTP id
 e9-20020a5d65c9000000b00333394aed97mr2638939wrw.114.1701745797971; Mon, 04
 Dec 2023 19:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011152725.95895-1-hffilwlqm@gmail.com> <5ee643a8-d39e-470b-83e9-9d550374e617@gmail.com>
 <CAADnVQLV5T9+_Dbd=yg4a5-4hQPznAVxdZ42ps50EL3BmnRdcQ@mail.gmail.com> <ZVtUATBtSTcMUhPl@boxer>
In-Reply-To: <ZVtUATBtSTcMUhPl@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Dec 2023 19:09:46 -0800
Message-ID: <CAADnVQLraxFgKn3hWWMa7=Ds5cM8J1y6Dt_03=26TQe2yKSzcQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 0/4] bpf, x64: Fix tailcall hierarchy
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 4:41=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Nov 17, 2023 at 01:40:41PM -0800, Alexei Starovoitov wrote:
> > On Thu, Nov 16, 2023 at 12:33=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.co=
m> wrote:
> > >
> > > PING
> >
> > Sorry for the delay. I didn't have a chance to think it through.
> > I hope experts in the community can take a look soon.
> >
>
> I'll take a look this week.

Maciej,

It's been awhile.
Please review asap.

