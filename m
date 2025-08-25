Return-Path: <bpf+bounces-66409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ACBB3489F
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140A67A573F
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870842F360C;
	Mon, 25 Aug 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JalCFZp6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24091C84DE
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142815; cv=none; b=KrtEgx8AnPQnu9D6br+DLqZrtmm4l9cz51XsmGal9Xfv/AsNtTxHhrf6JI/ShaZ9L49TcgMh4y1wBIECjrYYXbbrf1NpOhkm0gyJuQ6TQgu63uzZlY+DQ3njrl3xGEfkQuhokkYiMb2sy4RRAeQVsJj5Zx3v8FMkzfhoIM5D8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142815; c=relaxed/simple;
	bh=VW2pjSGxNdUofrsOVQEri9lYMDMwLUTelhnarPhN2MA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHuht+9DtZ+YaZrtYpn2K69Lnk1aZwX7hh47u4hT4cwSbZL4Oj1HwWDxzEihifvl/JYWyRlvwzaIIZn/kX4pDMDKQxF+tG7g53LPQ+SSMUITuEhnR9/dbd+WIX5uUGM9GyYTXAhJQorQYgyCPa1n+CaWS8nQH4f0iZAMk+zFJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JalCFZp6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24457fe9704so42678635ad.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756142813; x=1756747613; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YRiy8Npyqa1ZpVm4KjFY1UJSwYcsG8Y1shSVxsZ2A6A=;
        b=JalCFZp6YecgIFUqrmrfg/7Iu4/CZFdrzOV9u37KnVCPvnHyw+b1vzaV6U+F7BZFri
         P7YCMhaw/qti6YvZhML19z8KZWZXYyl5dNgn0UpuX5Fpp1Bv4qjMM7N7m/yRcfXEXKJ8
         APkwY+pd7p2cRX46aevATk1ZUiVVuDRjL1MruwDGrA/s/ja2FS67LRTkSRa14H0pr60q
         HKa+Cqh0SUcts2Cn12NG+YymD8BEC67o19mIQzkIW+ciQCJupnwyJ2ZbiZolhvbzn5xa
         WsItQ0Pqg0urtSgnZ/8qWYtlGghNkURXG3CwIlglB/bJkIYfUI+Z99wnBGWDJmnJFghn
         2l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142813; x=1756747613;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRiy8Npyqa1ZpVm4KjFY1UJSwYcsG8Y1shSVxsZ2A6A=;
        b=O3lFQ5AAfSQd4lp2cx5TWTN1Caz2LyNsWN260Nyl3eAeECbtQOthfAt/8ClMwhLot3
         RF54ZWoCfyFAat5IwGt1PXE7plyy2Lm2eww2HPdVWnIL5595a/jwx9VCDdAMFb1LtQev
         2MLxyLcVNNyHPh/6pKHlb5fH9bjcWhD2aku1YzLoXpvbRmKIZ86EE3PQq0UUXPsCSA2D
         AqjgQrV+FkSwMq3yf078YWuahuGk2Ky0V0qOM1yPmAOZbPHnhcXScM2+QH6Oa2S3mzRE
         1oa8wRuZH4m06/bgNHRzhZDhQvyp2OsrOUsWIhOYQIhmOBlct1wlXYlTz0kADXWuYQ5P
         0tKA==
X-Forwarded-Encrypted: i=1; AJvYcCVoLKTLNb1HHVShBdxu3IkyfSbljq+oQF6+ublJV3xa0n5J499WkEtimDeVZwNexMGhf6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCXOsehLB6a+mQkYcZv6is5kLNX630fIvdO+2+Cbg17eyqg63
	yAe/TT7JM+tH0S4CBMXMw/uLXtrXRc641/2lTeEGfyf74KKRKT1iJvmSyFDCs1Mu
X-Gm-Gg: ASbGncsG68ucQs3Ol1Zb5QT2g4h8VA8VFWnGeRmF9+I+zvGIiAXCarefhPuaMMDiIfa
	w5bkuDjwPVuAqBO4i5J6T7vnPWPflo+ne4Lc8DlJM5ngkBM2TebplYEPeR3Jdw16ILDuiliVFIB
	29/t8ccr8nWJaNnM41kvr7kqcCdIQFCOR6mQ3uHPQaBV1aQy5Fh4V7vDTVMLLoInWtwbY0EbOQ3
	wqxAMUBtZiwUH1eECqyN3g6EqR60gkfPOkz/iH6WvUK77Ui2t/m7424fLUDztd9FvkgvakIVm90
	CiLvv9xRz096506Y+W5XPYejCnv8woZGNeD6oLK0ktf3TBVi+dttpc9Ge56k2uliC2QtAnJ07jT
	vtwaWJ5UdYUTboztKKj5IFMyoWMwi
X-Google-Smtp-Source: AGHT+IEdgM92y2P5LtKGohy28mmo0SNUbuDzK1G2I1IrowpIeDiTSVGAoezdoxH94dC1pX7Gq30xhg==
X-Received: by 2002:a17:903:1988:b0:234:f4da:7eeb with SMTP id d9443c01a7336-2462edd7d61mr174397215ad.7.1756142812945;
        Mon, 25 Aug 2025 10:26:52 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:48d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688b40d0sm73640845ad.166.2025.08.25.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:26:52 -0700 (PDT)
Message-ID: <c37eb846e94c11b74301a699b64037e9d247ba9e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add case to test
 bpf_in_interrupt kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 kernel-patches-bot@fb.com
Date: Mon, 25 Aug 2025 10:26:50 -0700
In-Reply-To: <20250825131502.54269-3-leon.hwang@linux.dev>
References: <20250825131502.54269-1-leon.hwang@linux.dev>
	 <20250825131502.54269-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 21:15 +0800, Leon Hwang wrote:
>  cd tools/testing/selftests/bpf
>  ./test_progs -t irq
>  #143/29  irq/in_interrupt:OK
>  #143     irq:OK
>  Summary: 1/34 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/irq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/self=
tests/bpf/progs/irq.c
> index 74d912b22de90..65a796fd1d615 100644
> --- a/tools/testing/selftests/bpf/progs/irq.c
> +++ b/tools/testing/selftests/bpf/progs/irq.c
> @@ -563,4 +563,11 @@ int irq_wrong_kfunc_class_2(struct __sk_buff *ctx)
>  	return 0;
>  }
> =20
> +SEC("?tc")
> +__success

Could you please extend this test to verify generated x86 assembly
code? (see __arch_x86_64 and __jited macro usage in verifier_tailcall_jit.c=
).
Also, is it necessary to extend this test to actually verify returned
value?

> +int in_interrupt(struct __sk_buff *ctx)
> +{
> +	return bpf_in_interrupt();
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

