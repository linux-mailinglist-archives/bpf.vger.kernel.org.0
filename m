Return-Path: <bpf+bounces-15480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59F7F232A
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C51C20ED0
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754E379C6;
	Tue, 21 Nov 2023 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0PTLcF6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9909136
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:35:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00a9d677fcso111609766b.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700530510; x=1701135310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fNMS9I8uPOsORvkRAzhs54HfWmW3vO9lPrL6z3+YdTY=;
        b=X0PTLcF6ixTBFmSdJkTNGI49LJFkQKeK7vb9LWfYTt/AMP0xra03w700eG9ZehaED0
         bc1g+Kmevaznh8o4E7Fo5WnE4TGRDm1ZIXSaj5aCMOmbFGkkBk9CwLhgzBIMG6MmbxH8
         ZoyPEtjGAlirsV/FOmXrrDPoAtsC+kt8FiAkjend3iW2R7MK664JA6jBhWgXeBuPgBSS
         asejbyJRSYx3B+sBArKyaHGYO6Z8blH2QJbrW1byOAGvOEh+Yt5vfuJ2C821IQqy3IFb
         b2HneYMwRI9E/8Zq995FeTkdDja/ewZIvs88S+bgj1JaPY5OFuoqXpvUD2D1GcXUiEz+
         sqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700530510; x=1701135310;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNMS9I8uPOsORvkRAzhs54HfWmW3vO9lPrL6z3+YdTY=;
        b=oF107xbn80vcKpmTd3/rSb3iBQxp+tKSu3Wuvx906pkzJ9EooO64+dwdVYVO9fsuGQ
         AOMD8UlcXYT3xp5m4i/1uh9/LAnlOKMYv3DCv3jLuIhwx1S9ZRkGtlBQPhE1mcWLU4sR
         RGVce3RyvnzhwY/VbLTQVhktHXLAuGqm8ejb/UtGZo/RRnRBT/VuFoJkpejBw5q9LAug
         qEyV4LBHxGNg4P3OfTMrspXrihWg1GYaYIXKcD8VGcvwMYpxcaK38zZdpG22/LZnF8rV
         4t3jjVMWkRvoY9qnVjyHsSgngUi/ssV7yhP16UG5DfERM5fFK2U8NxZsj0dfEcoUBpq5
         uoQg==
X-Gm-Message-State: AOJu0Yw56Mxr9qOhaZkwiHmT3KG/ezxhyUy5qEvzElFy7S7/t+yWH2rd
	ylfUvl7iMB7IKRIZ+8ZDBTI=
X-Google-Smtp-Source: AGHT+IF9hGr8r06Ge0PsfDU8Y/3FCV/C8OPLl1lco+UezsQPjso32j0NeZcOOSYVf0rHtNpcSod3tw==
X-Received: by 2002:a17:906:c0cc:b0:9df:bc50:2513 with SMTP id bn12-20020a170906c0cc00b009dfbc502513mr5908622ejb.65.1700530510230;
        Mon, 20 Nov 2023 17:35:10 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090632d000b009ddaf5ebb6fsm4545990ejk.177.2023.11.20.17.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:35:09 -0800 (PST)
Message-ID: <9db2ad139cff43fb9459f4a7cf9ec5a676de7a37.camel@gmail.com>
Subject: Re: [PATCH bpf v3 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Andrew Werner <awerner32@gmail.com>
Date: Tue, 21 Nov 2023 03:35:09 +0200
In-Reply-To: <CAADnVQLRcOShH+kCswOZ1KMzqFLzMJ3ZoXLrGFwtmF2N2Vt2mg@mail.gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
	 <20231120225945.11741-11-eddyz87@gmail.com>
	 <CAEf4BzZc8eCQ=2qCqWD9+LHobrSA3cxQ-yHpVFm4zRQ0Phn1bg@mail.gmail.com>
	 <b0d346784ff3aac63927f1798cf1fcd14ebfde1e.camel@gmail.com>
	 <CAEf4BzYghTaNgn+0E66N4X2hZ0wG8KOpza=O9BonKwhdviq2kw@mail.gmail.com>
	 <CAADnVQLRcOShH+kCswOZ1KMzqFLzMJ3ZoXLrGFwtmF2N2Vt2mg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-20 at 17:26 -0800, Alexei Starovoitov wrote:
> On Mon, Nov 20, 2023 at 5:14=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >=20
> > >=20
> > > My bad.
> > > Should I fix and re-send as V4 immediately or wait till tomorrow?
> >=20
> > Other than this issue everything looks good to me, but perhaps give
> > Alexei a bit of time to take a look over latest version, just in case?
>=20
> yes. Pls resend. Everything else looks good.
> imo patches 6 and 11 look much cleaner now.

Ok, need 15-30 minutes.

