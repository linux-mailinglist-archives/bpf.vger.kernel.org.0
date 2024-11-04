Return-Path: <bpf+bounces-43880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B789BB202
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69051F21F13
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD431D319C;
	Mon,  4 Nov 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcMGu3Za"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899E1D2F5C;
	Mon,  4 Nov 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717581; cv=none; b=HAAhAx7QZFveKE9S0k98xxylFLodhskZbEW8bnWKXw1SImak9LjWOa6ZALtEbqHr49ZtNuhHpHfFAX/nzW2cFiU7aHYhDuykuaVOEFEo61g+eWiMtY0lBTjdUwMezePGP0D2bNkNkgb2BhCjuMjXucY18Sr/5JX6yKu5b9wmUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717581; c=relaxed/simple;
	bh=lHRDj1nuYu4GZzqn0i5vZMzqyCtpSIcWjY9t6tVmdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjZAg8oIB74i7HLI8CEnGN6sIffAJfJseH1jbbbi48dew4stTJJ47svp9YI8k+m+cvoAuwC80wpxNm9tlGVVayHh0ufD1ysYWBqiqkyyBiR9VUZchaEymyJkcTiCGICXWRpSN0R8IFwFCTHg8+8yT3hFYnoH9sa0GKoLsENWUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcMGu3Za; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7180c7a4e02so1895729a34.0;
        Mon, 04 Nov 2024 02:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730717579; x=1731322379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgxWGDLB6WxMe8+gbg4dTFROdUbgcSI/rTCvMQUjZ94=;
        b=XcMGu3Zaqc51ciVywijgC6NpR92QH4jGgsL5so/ABOhw5wPGJdRBPzl9+Zq2/b2/OS
         ZjJNHHA45MHKnioE9WW1qA9PyV4DUA4V6dUig7KyJS7GrEern0M+o917j+CEi5RrRDAq
         T1qNEU+Uhuqluvut9xkpgRrfJNS8q2onp6rpiqShJOR34J8WN1NNoCX6XX7QZ0XDL9Of
         lxpwYldd+lLSAY78dNnyDKI8fdXaXpvkHsao/DNZBDg5Azr7HvdSq6ncTxzJJFYBaij1
         YURR+lCvnLQVPZbSBuH5u8s6lcK+qscMijbA8VzFjd6dX5km/fDWpHbxPeLf652iHsBR
         YWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717579; x=1731322379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgxWGDLB6WxMe8+gbg4dTFROdUbgcSI/rTCvMQUjZ94=;
        b=I0DIRq9IGU4R221gI2/DXPpCuDeUfVXWGXrsJxQdkrSBoTjx9FceT/ZxYUB4uYUYrH
         Y+hsABOymsmqVTQdN3CjC6maL2fVesiDCIApfRPXzuOBDKm+uR0NNfBJUeTB5QUUrao7
         sOPkjbYw1hgemZXJ3BPqCTXcvWkcyKQRP3UHfVjbKUDEKRI943lY2KMJtcBNHGEjy69e
         FC72uPRSvQ02lc3xQabydLsetDbFzRNDf8JsY7gTywyQIZERRLXQmRPnDHVPPiJLO/fH
         YP/tbizYfXZO1cMj03SuhCvf6BBIa40GFpYKFEcNKHgluxITl4cVmH7QM4Ij7T8PQHXp
         gvSA==
X-Forwarded-Encrypted: i=1; AJvYcCUyaki59qLvjX08t/mxxrGedkh7oF+cXvJgRrBPUThs+NlUKxYDTtU7+Clls8lwSeFzcvQn09B2Smi1WJ1A@vger.kernel.org, AJvYcCWMYvIiGWnV2RmDlDxDg8DCmohrFuo72hIs9SsembkI7tFJtUhwoQrvSHOZw57hKqKDy0JgGKWe@vger.kernel.org, AJvYcCWi6zklkvvFmnBETYH7QFtIuCl+WeN3NVrdl1i1JI7alj32RVnnoTl1Fj+MWXH0QKo57sI=@vger.kernel.org, AJvYcCXhIWliqoJfikAZYIgSQP/FAp8SW5tpljfq6yRJZiNqGoBzO46hLPCxRi0eAIntZ7t9hgDVCPA5pYy3@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ14XBjBHeZi8e7ZgUXl78+9vWUA7+Z2IYXDtZgLcxQC5RfgZc
	1D2fYPovjiHEcbo6XIdlOCjeDk1hJzYTbhTHFRFD3L486pZX/9Eh
X-Google-Smtp-Source: AGHT+IEFrTmRt5MF02HRjrjN5v5W9Wx5TsujIt/V1xbOVd6bkPvSYe0yVcuZIf7JdbxvWbzwrvJNFA==
X-Received: by 2002:a05:6870:b022:b0:260:e713:ae8b with SMTP id 586e51a60fabf-29051b56a9amr24502201fac.20.1730717578690;
        Mon, 04 Nov 2024 02:52:58 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e780fsm7162875b3a.46.2024.11.04.02.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:52:57 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 3E9AD41AD6F2; Mon, 04 Nov 2024 17:52:53 +0700 (WIB)
Date: Mon, 4 Nov 2024 17:52:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: hdanton@sina.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v5 7/7] docs: networking: Describe irq suspension
Message-ID: <ZyinhIlMIrK58ABF@archie.me>
References: <20241103052421.518856-1-jdamato@fastly.com>
 <20241103052421.518856-8-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iuKxU6a4r/CNFDfj"
Content-Disposition: inline
In-Reply-To: <20241103052421.518856-8-jdamato@fastly.com>


--iuKxU6a4r/CNFDfj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 05:24:09AM +0000, Joe Damato wrote:
> +It is important to note that choosing a large value for ``gro_flush_time=
out``
> +will defer IRQs to allow for better batch processing, but will induce la=
tency
> +when the system is not fully loaded. Choosing a small value for
> +``gro_flush_timeout`` can cause interference of the user application whi=
ch is
> +attempting to busy poll by device IRQs and softirq processing. This value
> +should be chosen carefully with these tradeoffs in mind. epoll-based busy
> +polling applications may be able to mitigate how much user processing ha=
ppens
> +by choosing an appropriate value for ``maxevents``.
> +
> +Users may want to consider an alternate approach, IRQ suspension, to hel=
p deal
                                                                     to hel=
p dealing
> +with these tradeoffs.
> +
> <snipped>...
> +There are essentially three possible loops for network processing and
> +packet delivery:
> +
> +1) hardirq -> softirq=C2=A0=C2=A0 -> napi poll; basic interrupt delivery
> +
> +2)=C2=A0=C2=A0 timer -> softirq=C2=A0=C2=A0 -> napi poll; deferred irq p=
rocessing
> +
> +3)=C2=A0=C2=A0 epoll -> busy-poll -> napi poll; busy looping

The loops list are parsed inconsistently due to tabs between the
enumerators and list items. I have to expand them into single space
(along with number reference fix to follow the output):

---- >8 ----
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/n=
api.rst
index bbd58bcc430fab..848cb19f0becc1 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -375,23 +375,21 @@ epoll finds no events, the setting of ``gro_flush_tim=
eout`` and
 There are essentially three possible loops for network processing and
 packet delivery:
=20
-1) hardirq -> softirq=C2=A0=C2=A0 -> napi poll; basic interrupt delivery
+1) hardirq -> softirq=C2=A0-> napi poll; basic interrupt delivery
+2) timer -> softirq=C2=A0-> napi poll; deferred irq processing
+3) epoll -> busy-poll -> napi poll; busy looping
=20
-2)=C2=A0=C2=A0 timer -> softirq=C2=A0=C2=A0 -> napi poll; deferred irq pro=
cessing
-
-3)=C2=A0=C2=A0 epoll -> busy-poll -> napi poll; busy looping
-
-Loop 2) can take control from Loop 1), if ``gro_flush_timeout`` and
+Loop 2 can take control from Loop 1, if ``gro_flush_timeout`` and
 ``napi_defer_hard_irqs`` are set.
=20
-If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are set, Loops 2)
-and 3) "wrestle" with each other for control.
+If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are set, Loops 2
+and 3 "wrestle" with each other for control.
=20
-During busy periods, ``irq-suspend-timeout`` is used as timer in Loop 2),
-which essentially tilts network processing in favour of Loop 3).
+During busy periods, ``irq-suspend-timeout`` is used as timer in Loop 2,
+which essentially tilts network processing in favour of Loop 3.
=20
-If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are not set, Loop 3)
-cannot take control from Loop 1).
+If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are not set, Loop 3
+cannot take control from Loop 1.
=20
 Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
 the recommended usage, because otherwise setting ``irq-suspend-timeout``

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--iuKxU6a4r/CNFDfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZyingAAKCRD2uYlJVVFO
o64ZAQDP3pxfWFFyMjIfi4ZGG1Nsp73evLSwCaWAqmtJ/cVfGwEA43yY1qi4t1Lq
wpWy5WDij+Lu6fAu5J2LfoivRdtH+wA=
=G0Aj
-----END PGP SIGNATURE-----

--iuKxU6a4r/CNFDfj--

