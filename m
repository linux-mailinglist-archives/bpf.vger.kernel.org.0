Return-Path: <bpf+bounces-19178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D7826A72
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 10:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A0C1F20F1D
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F310799;
	Mon,  8 Jan 2024 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MzNX37sC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4E12B8F
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28da6285c1so278737066b.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 01:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704705356; x=1705310156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQw0PBv7H3F9npAXhHpc/yO+0aZTdw3iW7XYRioBY9M=;
        b=MzNX37sCftG06J7zDqRoVr0ASbCiDMbrmnnww9QwIfjHn6v305+3yC4sf5ZhItJ/P9
         dWgD/FpnTIJwHE4ksSWe0LyKUd6OfMRRTu2GsW3LrzyYIlk1hIm1lWPPTQTB7KlqL7yN
         TZ4o5IaKMtV94FWQY6kwJIi2YrmviStlCIrez+Ok7YKHBE61mw9794RlBmRCxk8r8RUL
         VrdvaM3wBX128iDc7clv/XxbWwBql1tdTSo4hEdAuX6o0HA2yEC1qaVMYbdyxbkpNlPz
         Usmp583j3JFO42mG5KGuZPz8LDrv6DbVyXe7CC8l1Vt6gXrWdave70ArygI0WAZ/X/pQ
         wOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705356; x=1705310156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQw0PBv7H3F9npAXhHpc/yO+0aZTdw3iW7XYRioBY9M=;
        b=TRwdy4/9TK+JAY/RXxxQDu0ClQXO4h1CnS45BrjHZn5VC83tbRSCkO+SLqPa3CxjIK
         ysClKLY/6JBEgiBAvmqEGA4Hoxe2k29KHuFlasqCbljUpHR8dYMMdneLD4yFGKDiToiS
         Z6poztPFyoJU+KUms3fSCQwF8oGTjKoB2rsAxZrzRklnBDyg82Uprc3zYF9WFlOLMivy
         XFPdfhpR5hgaXn/akGLxJSQ8N0mVb9UEHzAFxegOAibv5W20yaE3sPczUFY/znuHTBzC
         o7HHBRRfCoYle59AFfB5ZwzE+9xpAyjksGTkbNOxFrhaz8W2s96t193by6fiC44Si/XV
         nVKA==
X-Gm-Message-State: AOJu0Yx//i6MXbqmDTP8uZiuLFFDsBWW6nPCPkl4kn5vOiBihECIlqf+
	G9MuSNK35DiwAouJXHjM40FvtX10YR574kLOTehBxWfEuqSCpA==
X-Google-Smtp-Source: AGHT+IF5FdPBR02bei/X14Ub000OcoVXRo17m86hQ2MPBeQuC7hWG3H6v1jptH9g+ATyuoxWlGDUexOGIPMl6jmv1Ns=
X-Received: by 2002:a17:906:1797:b0:a28:bd9c:8363 with SMTP id
 t23-20020a170906179700b00a28bd9c8363mr3034170eje.57.1704705356043; Mon, 08
 Jan 2024 01:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704565248.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1704565248.git.dxu@dxuuu.xyz>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Mon, 8 Jan 2024 10:15:45 +0100
Message-ID: <CAN+4W8gPeQ2OjoYLKXsNPyhSVTB+vcSaS3Xzw=-M9Rf5MXfKPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Annotate kfuncs in .BTF_ids section
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-input@vger.kernel.org, coreteam@netfilter.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fsverity@lists.linux.dev, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, cgroups@vger.kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, quentin@isovalent.com, 
	alan.maguire@oracle.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 7:25=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> =3D=3D=3D Description =3D=3D=3D
>
> This is a bpf-treewide change that annotates all kfuncs as such inside
> .BTF_ids. This annotation eventually allows us to automatically generate
> kfunc prototypes from bpftool.
>
> We store this metadata inside a yet-unused flags field inside struct
> btf_id_set8 (thanks Kumar!). pahole will be taught where to look.

This is great, thanks for tackling this. With yout patches we can
figure out the full set of kfuncs. Is there a way to extend it so that
we can tell which program context a kfunc can be called from?

