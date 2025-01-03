Return-Path: <bpf+bounces-47815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF273A0021F
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 01:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3D21883DB5
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22514A099;
	Fri,  3 Jan 2025 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/lBj2TX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC018E25
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735865195; cv=none; b=Yjrg4TS1Dih3Fi8tq1gpM0lr2aKRJ/39+hWJcJQsFtYAjha4mB7DrUdIh8kYncTUqP6EGPyLZjuO+IgnjrcIg3kQAkEmeBhzvsIUOLBpQjjVEP2Rc3Cxd8XL2bydh3GP+wQAkBdPVmLSzOxRvcKB+liR1iMwmb81Nz6fOR/PyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735865195; c=relaxed/simple;
	bh=WAPkahjzs+9tpqPpsIMhVuhHo2sMqXNPybKwIqWXtuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0p9/JYD/eCDpw6H5Fs2oEmZOj7NLXn0ry5b1QMtO2wkfXzZgm2CYJKGD+tA0i0VB2RgQAqC3lEWswv2WBt8Uq+1++ZEVvSpuuCfRcAf12D43x8rJZ4Q4caXPtMINlfP1D6eYmpKtcKDjzuo2NUV05X2IZs+aAxoyz8v64cOj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/lBj2TX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166f1e589cso197535605ad.3
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 16:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735865192; x=1736469992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5naoOHX+7w86PXxhyUiwwSQMe/xGsvjm2zHcjefDQqs=;
        b=Q/lBj2TXYzwxJg7OQEixCCBNh49hTN9aKPKTPr52/JOcPAkHyNqqc8kmbEjbjf5HYA
         hdE9hZC1cLdkpRm7jNB7IRUJ+cicA1WoGtt+oMIhGOmErTp+tLSxxau6/77ecV1J7FpK
         MrWmqIQj9fZOYnbZbXTe35RJyBbiyGg2OrN9QW6LN0yzapY9vVT498/19OhcXOkhqIir
         0/RuiLjdJa/EF5ZuD+hT97DyWTFZFAYz8/q6XPxL+xACIDTuvHiVlGSD2dbaKry8NY8R
         qqBHUbt+cnJkN2GXDLlj7pBBsCcvbU8Eu10H+hvfpNJjor/m5z3sUP2AzHpyU70v3iZS
         VHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735865192; x=1736469992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5naoOHX+7w86PXxhyUiwwSQMe/xGsvjm2zHcjefDQqs=;
        b=GcP7z8Om3OTpREUh2Tb7Ktxr25+bU9JFNJ+yFrcgMgwfL+ZWfEOecb7G3lBP0jDZz5
         EIydl/h9Vn1EBH/tu3jjv9hAde20Jkkdxw8hWJMKg1Jit1WDgPeqMH++BGuhKco57mAx
         QJdHeCFK7dCmBJviHsgCrPfb7N8nAcnF8dn7hSzrgK0503aRamjo1DHZKGE70ALg23Va
         X0Br3dr8l3HTjOvDuT/nbKrKEp2LOwx9R34Vm6G13/y7ct60j5nTjpHJpakK7r9eQqxj
         hp38h4edsNtHqi1Qepd2bagRC0BfiFzl737JHzm9jNa2nWqvQtW5VlEpnhKAjQbCKPGH
         SV6w==
X-Forwarded-Encrypted: i=1; AJvYcCWM2MTf7lVuhoqyxdzU2h62dPeNDdvFksN2FC6U3ToDjypaMr2mS+7Ik+xSswadjskpc0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQurH4fTM4YqoxQiA+ugD8HsspLtraf6CyG1sgaKE3zubT5+pB
	GKtjLugOe+Mpgdpz+/jC+j8UbcjEssvBk03SPHZ/gWPLA65lrFoF
X-Gm-Gg: ASbGncv+Ok3fP8gQfavQ1Mmfp3E14LUX9TlpFaL0SUysSSR7ncH15epfrPrKcsjoFTa
	ui/+34BOZqK8anM44dQOHplUT+bQHDZVPCrTPsL3f9kJP5Bp5gxbSOCqtz+jsjQweCFd4omCL8R
	mo42jZ9j3DmxaRmhgr9INWAIHfHrkPekjM9TEVw8DNnFWjOkN70BYAl4PY2UlbH/KBRdDhlR1TF
	gbz5jMJkpmUn9IysBMNw1/4erklLplI09UJFQlVFajfaJk65cXL0w==
X-Google-Smtp-Source: AGHT+IG0igTM3LYBuMm5tPGOwINDbMGFtzlaWwz03YJU/MDbb7lEhwjMyqqJcO4qBGcp/ekN1bQnvg==
X-Received: by 2002:a17:903:2cc:b0:216:4b1f:499 with SMTP id d9443c01a7336-219e6ec0052mr726824055ad.31.1735865192475;
        Thu, 02 Jan 2025 16:46:32 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962ca2sm235607255ad.5.2025.01.02.16.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 16:46:32 -0800 (PST)
Message-ID: <4accd577b1486fb8074e7913c3e81d76174ad3d6.camel@gmail.com>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, "gcc@gcc.gnu.org"
 <gcc@gcc.gnu.org>,  Cupertino Miranda <cupertino.miranda@oracle.com>, David
 Faust <david.faust@oracle.com>, Elena Zannoni	 <elena.zannoni@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Manu Bretelle
 <chantra@meta.com>, Mykola Lysenko <mykolal@meta.com>, Yonghong Song
 <yonghong.song@linux.dev>,  bpf <bpf@vger.kernel.org>
Date: Thu, 02 Jan 2025 16:46:27 -0800
In-Reply-To: <87v7uw21lj.fsf@oracle.com>
References: 
	<ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
		<87jzbdim3j.fsf@oracle.com>
		<64d8a1a7037c9bf1057799c04f2d5bb6bdad3bad.camel@gmail.com>
	 <87v7uw21lj.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-03 at 01:16 +0100, Jose E. Marchesi wrote:

[...]

> Yes, in the GCC BPF backend we are using
>=20
> =C2=A0=C2=A0use_gcc_stdint=3Dprovide
>=20
> which makes GCC to provide the version of stdint.h that assumes
> freestanding ("baremetal") mode.  If we changed it to use
>=20
> =C2=A0=C2=A0use_gcc_stdint=3Dwrap
>=20
> then it would install a stdint.h that does somethins similar to what
> clang does, at least in hosts providing C99 headers (note the lack of
> __has_include_next):
>=20
> =C2=A0=C2=A0#ifndef _GCC_WRAP_STDINT_H
> =C2=A0=C2=A0#if __STDC_HOSTED__
> =C2=A0=C2=A0# if defined __cplusplus && __cplusplus >=3D 201103L
> =C2=A0=C2=A0#  undef __STDC_LIMIT_MACROS
> =C2=A0=C2=A0#  define __STDC_LIMIT_MACROS
> =C2=A0=C2=A0#  undef __STDC_CONSTANT_MACROS
> =C2=A0=C2=A0#  define __STDC_CONSTANT_MACROS
> =C2=A0=C2=A0# endif
> =C2=A0=C2=A0#pragma GCC diagnostic push
> =C2=A0=C2=A0#pragma GCC diagnostic ignored "-Wpedantic" // include_next
> =C2=A0=C2=A0# include_next <stdint.h>
> =C2=A0=C2=A0#pragma GCC diagnostic pop
> =C2=A0=C2=A0#else
> =C2=A0=C2=A0# include "stdint-gcc.h"
> =C2=A0=C2=A0#endif
> =C2=A0=C2=A0#define _GCC_WRAP_STDINT_H
> =C2=A0=C2=A0#endif
>=20
> We could switch to "wrap" to align with clang, but in that case it would
> be up to the user to provide a "host" stdint.h that contains sensible
> definitions for BPF.  The kernel selftests, for example, would need to
> do so to avoid including /usr/include/stdint.h that more likely than not
> will provide incorrect definitions for int64_t and friends...

Would it be possible to push a branch that uses '=3Dwrap' thing somewhere?
So that it could be further tested to see if there are more issues with sel=
ftests.


