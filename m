Return-Path: <bpf+bounces-10594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDE7AA2BC
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E2A901C20AAE
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112F11947E;
	Thu, 21 Sep 2023 21:34:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09819478
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 21:33:59 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0D824036
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 14:33:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40535597f01so11753545e9.3
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695332036; x=1695936836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GLiS79Povi8o2oUnaiZotIm6nhJyRYkf/3ZbwKZTXQ=;
        b=cYbdNh5MMBbPvBTn3t9zhmPUYunoU4tHOkOdwTDVzw9PZcHBofpWCmyTdt2Q0PMDuC
         1k56H/T8DepJtqarcyydgKaOSH5DPOf6EO/ki2aTxg7EXNDUc0mxXQl8cTT4q2XwdNnm
         qmY0r04zfXDM5+CPh2lo1S+Ucktc8dPcUIFkCwJvMsfgdtGwNvKtRli/jGhZcgET9alH
         cxXUo2bO0IFcFCxCCB+T6esgAgkpaTJGqUZrvRA2HesipfnsisFCvV1m30+NDYt/5Wt6
         9Mf2a3rXPSt44NCU3EIJm76ByXPkyNfOOlA08qrilHKzhzWluhUGhVV2a1OTGkCnLymo
         mNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695332036; x=1695936836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GLiS79Povi8o2oUnaiZotIm6nhJyRYkf/3ZbwKZTXQ=;
        b=n57xF81GQwrE/vdits4wrlNdTpo4XknMBJb+u63R6xXBQ4uwLV5X3OnSAiED8XOQQY
         lFdEHHXNYn+u14TMMh2k3Pi+8bs2/E+7Mcr3Sv3Ipq9pVDrgnnXRoB4cRiSZMmXf+7/W
         DtQa/JgrECv5a05JIwTYvX1yNy5i6EmWko3pDQRCrI67ZP/fBkKxDYRMH5Vd4nvZXowz
         cbGMXQlWD1LQJgl+5CFHT5DPJq50iliWqrsZKgw6M+ROiUbFZNLVrqpvWVpIsVtpkj1P
         osHqAQnkn67oxyY9Mb8YO05E3xQwtMpzQqxz5Y2UVGQHohPC4KwvRL1nkIQTWiu7k1C4
         DUlQ==
X-Gm-Message-State: AOJu0YyG1BD9YSFQIhT7x1VXyCz+X4luxRIB4XbicAGKiCo7vdH8zP+x
	AYeTQ/+hwGoKXR5Q+aAVz5bdj+1a/2+ojnfkovU=
X-Google-Smtp-Source: AGHT+IExL0NgZTSuBgTsTVawPG7RhmAfGdY87iP566JAhdO51+Sbs183Ofo2a4aNerVKqZSFu7arYWQGRggVYLp4LEg=
X-Received: by 2002:a05:600c:3b16:b0:405:391f:8dca with SMTP id
 m22-20020a05600c3b1600b00405391f8dcamr1707438wms.2.1695332035528; Thu, 21 Sep
 2023 14:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230917214220.637721-1-jinghao7@illinois.edu> <20230917214220.637721-2-jinghao7@illinois.edu>
In-Reply-To: <20230917214220.637721-2-jinghao7@illinois.edu>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Sep 2023 14:33:44 -0700
Message-ID: <CAADnVQ+hxKyOzMQE=xj1Ld+=q=PsRX1OZJOUuVBdwxHfkyGw_g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] samples/bpf: Add -fsanitize=bounds to
 userspace programs
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Jinghao Jia <jinghao@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Ruowen Qin <ruowenq2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 2:43=E2=80=AFPM Jinghao Jia <jinghao7@illinois.edu>=
 wrote:
>
> From: Jinghao Jia <jinghao@linux.ibm.com>
>
> The sanitizer flag, which is supported by both clang and gcc, would make
> it easier to debug array index out-of-bounds problems in these programs.
>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
> Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  samples/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 4ccf4236031c..21d2edffce3c 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -169,6 +169,7 @@ endif
>  TPROGS_CFLAGS +=3D -Wall -O2
>  TPROGS_CFLAGS +=3D -Wmissing-prototypes
>  TPROGS_CFLAGS +=3D -Wstrict-prototypes
> +TPROGS_CFLAGS +=3D -fsanitize=3Dbounds

Patches 2 and 3 look great. Thanks for the fixes,
but this one is too aggressive to force on developers.
I think ubsan doesn't come by default in fedora gcc.
Could you make the makefile smarter and detect the presence
of ubsan in the compiler at build time?
I've applied patches 2 and 3 in the meantime.

