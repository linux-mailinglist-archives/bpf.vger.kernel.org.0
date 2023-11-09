Return-Path: <bpf+bounces-14647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72767E742A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C2BB20DFD
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A538FA2;
	Thu,  9 Nov 2023 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1nUFvyI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2B38F97
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:07:16 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0042F386A
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 14:07:14 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso17901741fa.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 14:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699567633; x=1700172433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+uQ709AsZrdOxN+w2uWxADA4yYyeE9GNXUPD9Yahcw=;
        b=B1nUFvyIEDLl5sMeWbTRNeA5MCHZ8WpYPpSrL+xq5VbSmx+JNDSEruRxQL+eSQZ2G2
         /bBdpJxWfARPkBoowE+Vby4RdHwrymfCmR8rmALa46aDJLq83RXb02TKcVcDFZIqqaXJ
         G83PwszZJ4jJZpcN+kOCg/e5jvAKtKe5d/GUbj00CIspN/YvvyYOXm93sRHtyZXGfX7j
         MLRSVDbDwBbS6MTNks2VRqqAwOrhH06FYneOLCmLHWtcCaYIsap4xqM+3ExjbYkeVahP
         9Rh7XnGrWwE5Pdp8jFoBEXqF1WtI754Z/VZWVkVnRAn8xI4dHEkJsxrdWawzx78WReOu
         jY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699567633; x=1700172433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+uQ709AsZrdOxN+w2uWxADA4yYyeE9GNXUPD9Yahcw=;
        b=UrVcWPfoaoRAl70Bev18kyMdOw8Xi2Goom4hwhSlL4eTcy79bBOMtpCsbBY7zQ6LU7
         64EZEnIeG/HzJt6XSQhA2prk5X+J9ZXjCp7rprZnPcDL0VHW8UwgQ9gaBl8QIFAoj7Js
         o215cZiy8+aKmMDjM6oMgfTvN+B+0IrraiMcTCbUxwZPiRRgeYASGakq8zhzxchuzKFf
         zNC8lQ75b61qVd6eSrVb09+C81KojlYvXcNHqbTZWR3X9EqMOpuEU8/f29gpsRi69faT
         F+NUTsS//ZJOrf+lIbEPDTJMllkV44V+CntX6C21QfsnixXN1prP0GdJ8kK/+QULig6L
         dnVg==
X-Gm-Message-State: AOJu0Yz4hbU+UIs1NZUSkrFDXAApdiWxmPZBkXRS4HpUUKUq1AHTirqw
	it7ElMUl0A+xA/7hayymxa2y7uCQQpyhzdyUydo=
X-Google-Smtp-Source: AGHT+IEksCWvS3ZOTvYiuCevuGwet67b5pSODzp9QjvgcAYC9yvYarocds6xF/qvtZcJMF/VDT2i1Jpx658YV1QDxO4=
X-Received: by 2002:a05:6512:3a82:b0:4ff:7004:545e with SMTP id
 q2-20020a0565123a8200b004ff7004545emr3123482lfu.4.1699567633098; Thu, 09 Nov
 2023 14:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109053029.1403552-1-yonghong.song@linux.dev>
 <6bf022a8cfd8c821ec0a8370fa85bcfd806c8be7.camel@gmail.com>
 <8576d3dd-28af-45c2-b72c-30105a451da9@linux.dev> <CAADnVQ+bv81EXqcwej8N8cSRjnEoEEOthWYooc5XoDNCVQzPbQ@mail.gmail.com>
 <f7669c86-5d23-42fe-9c35-d1a1c602d307@linux.dev>
In-Reply-To: <f7669c86-5d23-42fe-9c35-d1a1c602d307@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 14:07:02 -0800
Message-ID: <CAADnVQJofy9TvsZTwrEK7c7VuPYA==9gkTeWOEARhoHHivkqsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix pyperf180 compilation failure
 with llvm18
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> >> + */
> >> +#if defined(__bpf_cpu_version__) && __bpf_cpu_version__ < 4
> > probably should be combined with __clang_major__ >=3D 18 check too.
>
> Okay, I could do this to catch the case where somebody uses development
> llvm18 which has this regression but __bpf_cpu_version__ is not
> introduced yet.

Exactly. That's what I tried to say.

