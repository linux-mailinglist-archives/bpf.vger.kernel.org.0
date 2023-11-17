Return-Path: <bpf+bounces-15276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD37EFB01
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81BAB20BC9
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDF3BB49;
	Fri, 17 Nov 2023 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8aVj+EZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398BBC
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:43:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507e85ebf50so3270814e87.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700257424; x=1700862224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGa/xTcU4a9rD0QxRKTzZhRykfUTTU5bKGSMLnQYQIU=;
        b=a8aVj+EZy2V+QWM5ZX55HMjypgKya1STPHCT9e6MnJAr6YwndfwnGrer3SlHwDAuzN
         iRH90W3S7vjRrGdZ/kaEpKKFO0rfe0U7P7IlKvzYqSh3TtwhqPIat6r9bC8/+MMU6B5+
         HnJu7RqdhkEHOv+2rtfUcU4VIkteHFgJlGw1JzI3IP4GN45jOyRIAXy+jRoAY+G798/l
         sAOJOlKai5N8Sk/j24WMmHqNeB+ClYSx6n6LlvzLf4DXadUmmUqABSmWtAol6czJE349
         wQL/gJdgSv0L7pVpwST3DxvJciCq15S3BuCns9RqDM5q/UNlyywjBVB1+mQlPothDc7E
         OuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257424; x=1700862224;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGa/xTcU4a9rD0QxRKTzZhRykfUTTU5bKGSMLnQYQIU=;
        b=k/8YEhQ/R2NNVuxclK4dIJvEe+qg7xQ5kH+I/somITOYSG+sAWQsjCZRno9HNt5g6p
         WDr3TNLyIRh4K/3KRWJLhnGZ1vRZ5Bw4JR7taarPRM+tpTW6YgZE/t771pXteBABVR0u
         52Yl+x0s9tia9tBGyVez1PP1uIVTGUc9iZwegWKlGTEVl7nvZ2Jghlms7gSNoZb4TPMa
         LPQGUhM7hQVYbhDlwcNyk/Ld9PwaLf2oohaoIZa/LeeITx/KeoTBAaS0D1wemvVdZVAZ
         KHDLemo98b4t+R6/CmzCX8PbhlCKoCwSUEsQNQeZedDwckzLWc8A1TqMxvNT7Nz2Q71X
         84Xw==
X-Gm-Message-State: AOJu0Yz/eUDySRoyXqyFjT83FwSFT5T15aB67NF64WWxBGzosvPcvDtd
	0b9UsofBeAiErzc/i9fOfyI=
X-Google-Smtp-Source: AGHT+IHt2V2WfVDjpW3oCnT9H4Sky5h9/ALbR8rdC2SNeD6YP04kJ7phZvYq4uHelsHxOsPA8siKBA==
X-Received: by 2002:ac2:5296:0:b0:507:b17a:709e with SMTP id q22-20020ac25296000000b00507b17a709emr679527lfm.1.1700257423944;
        Fri, 17 Nov 2023 13:43:43 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b009dd90698893sm1191273ejb.38.2023.11.17.13.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:43:43 -0800 (PST)
Message-ID: <89c592a523d68713a2d3a6c8f3bbe858ff75d069.camel@gmail.com>
Subject: Re: [PATCH bpf 03/12] selftests/bpf: fix bpf_loop_bench for new
 callback verification scheme
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Andrew Werner <awerner32@gmail.com>
Date: Fri, 17 Nov 2023 23:43:42 +0200
In-Reply-To: <CAADnVQKr+OwMKY6OofP8JiJjrEF9wmSF0+68h0o4yeNXCFvEhg@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-4-eddyz87@gmail.com>
	 <CAADnVQKr+OwMKY6OofP8JiJjrEF9wmSF0+68h0o4yeNXCFvEhg@mail.gmail.com>
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

On Fri, 2023-11-17 at 13:38 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 15, 2023 at 6:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > The patch a few patches from this one changes logic for callbacks
> > handling.
>=20
> That's a wordsmith level 10. I'm far below this level.
> Could you please rephrase it? 'The next patch changes ...' or something?

This is patch #3, and actual changes are in patch #6, I can change it to:

  A follow-up patch "bpf: verify callbacks as if they are called
  unknown number of times" changes logic for callbacks handling.
  While previously callbacks were verified as a single function
  call, new scheme takes into account that callbacks could be
  executed unknown number of times.
  ...

Would that work?

