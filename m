Return-Path: <bpf+bounces-76838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7BCCC6B36
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C70743006E0A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1839341052;
	Wed, 17 Dec 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSxAZHO/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyTVCoAk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94751340DA7
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962385; cv=none; b=aFlSLSmAOYoR3Yt79gnfsBpAk0cXgVtUu/tMyjh6acqLC+x8RoO1DwAWK1K9njwt4EqTeO9pnig+KKFBTk3imuvBxhhTkmoX+WVe8hWA9aEtL7fgdnZahyCo5AViDjkVTZw3TGrW0V98Ny7Y5AiUaYYzXsPDaVx47C4lFAqqdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962385; c=relaxed/simple;
	bh=zB4Khd2aXHMvEa3b2ZlwEmnhYWZWycMfvFWM2EBC7dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnYwQ17IsVQkSJZ1bZ1GaZY4zW13kevdrWHWUKrK8ck6jm0B5GPUw/xZycMBOLhN6R5ruliOxGEWxZBMSd7OWwTs4qsi1cGfRYyNwDUgqAYja8VIxVB5Hem/8hKiguHkU+KV1UXq7sSbD7aBtKjSQTOsaLdN/49lcAac/Ibb3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSxAZHO/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyTVCoAk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765962382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNo3PeGOIc795Xgqks3aWmTd7gntV8jB3/Ue+Ch92/8=;
	b=dSxAZHO/eq8jMB1IGfP0OveMHzB50wL4GWZHFdoTAG1bZlXwfvv0s+QKwgk4sAoyRgDe1Z
	u7DzGr6eu/LhSrxcBuWOaFom6oqJwtOOlU2LjNd0oZtUREAQC3li7CWEPOMf5f+T5d/9S0
	xMm7r38tU4mxf6CVQ75SANZduRWptJs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-a2584lJxMi-oi0FFs8l_Ww-1; Wed, 17 Dec 2025 04:06:21 -0500
X-MC-Unique: a2584lJxMi-oi0FFs8l_Ww-1
X-Mimecast-MFC-AGG-ID: a2584lJxMi-oi0FFs8l_Ww_1765962380
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7cea4b3f15so693595266b.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765962380; x=1766567180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNo3PeGOIc795Xgqks3aWmTd7gntV8jB3/Ue+Ch92/8=;
        b=WyTVCoAkOva6XzR3UikVolqnpg+hXipaLEmQ19pn2K9qCfjYBVguERHPF3+tdNPWll
         wmSpB5AIaMa1Slh6JTmyIctCKiUnvxXT8aN2sEGuTEP/tRHqTxMx6vZN+0+vqHrEMEt5
         8tctaniDxxj6iu5y/OhDkadK8iitzw7gL2uRju5qj5GW5vMVnpkfDi7m7kiBPSikS0Oa
         Uh4jwduTcTfQ/V+v7EapE6uiLx27gDxdlRROQkPn8yZvGsFoX30dhIHVjB7Ur+yf9e3h
         hlZfa0RJI4jDZ5XjZE7pRKXsW2oXtdgMZDfYzsVFbAWVm1XncrXj3AzAm/n3wJIMKy0y
         avgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765962380; x=1766567180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNo3PeGOIc795Xgqks3aWmTd7gntV8jB3/Ue+Ch92/8=;
        b=M0wUK0o3mntwu/8fZBmhgKdzYy2ws1YhzREmD97yEEI6DFHjkfbgOJhKO9/fMt40q4
         dlz6RXzBIFN5U2cHpBTkc/+gNR6XNOYrM+sBtcAQW2g07yr90CHGVVCqXrpjWpNrGhR7
         TzZRQF08X6015YgmIMmrccwoWqPOtzKrYCIR18UCHrAHHC8VyeB/nTWnfD8agoIAM2v6
         wHhVNrEaiU87QMyOXvjgkdEcQl2Uu3Lt30fTLbuANz6bTwAfGm19Ps6/pPwa5TJq1mL1
         KVSQbn59r5pcnKmHPv3IxBpnmG9YdRYipqhDCMSx7eZ93c7EB9YbO5XQpX2waerJrWfg
         n+iw==
X-Forwarded-Encrypted: i=1; AJvYcCV2cDbgUEY2GsFBbpH0OkCK/obvT563mHgOp7MaA0DnLQT1DWc7jKO9u+00z7LNbqJx+ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwamIjmDgJOjcqMGrkIhgZ5Xp8OwQj12C+KNGdkmdw37E91j1om
	ONP5QKuAhhe2Tobl0QP9KkXbkMaAioleDUuXSF/97JZVDW7LMARqUgyGO2gwOWWnPu0alTktyX1
	J2ZsLMDzg8bcvzxWw0s2LX235azEEAkQeJ7itKxblG0w1UMxwh0mAzk+WyfbkB9jUOKhlzSYJw3
	u0tCdNx4CTJjXTYzuf+z2bzdc4tjo9
X-Gm-Gg: AY/fxX7OS7o7L1VPXE3C+JiVwqkFyjtS0iMc6KTTrfyJ+4IO0oZEpaOYFuueHeMsavx
	XmzpFfyw9Wok4ZKPSkXQT/6H4WsD7iudOGJoCI4hsjqHCKbMkMvYYJ7xUcjF7eEAp/Mr6rOYhck
	xOEeNy3036sCJBJuacnm33ZLKMfTRWeYfs6dGJSgFodne6JGOPJyr4crtyYwPfePqEOYmh0MpTx
	5cX5L6MKy6eyOXC8ochZt/M
X-Received: by 2002:a17:907:3da9:b0:b73:70c9:1780 with SMTP id a640c23a62f3a-b7d238fc47emr1818045366b.41.1765962379562;
        Wed, 17 Dec 2025 01:06:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1LSEEKpBYh6O9P/AUFxyQWlBNTsE8aOBeRhZYA0nGC2VZiZGpm5olomtpzLD48HUlBnMAJ0kqaOvvLxG1KVQ=
X-Received: by 2002:a17:907:3da9:b0:b73:70c9:1780 with SMTP id
 a640c23a62f3a-b7d238fc47emr1818041566b.41.1765962379001; Wed, 17 Dec 2025
 01:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205151924.2250142-1-costa.shul@redhat.com> <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
In-Reply-To: <CAP4=nvS9fTtNCtDCt254-ukTePD7hW3HoKExOPNPDOdppUig9g@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 17 Dec 2025 10:06:06 +0100
X-Gm-Features: AQt7F2qu0SC3trufCZAEhvaKAiHGi5JdAQ61YXyTseyd-qR6bcg0ZeyoPNsZKrE
Message-ID: <CAP4=nvSr=Wz--CJgJ9kmXfB3r3uNYnt9bJt-_bCigH--rbbx2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 16. 12. 2025 v 15:41 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.c=
om> napsal:
> Since commit 2f3172f9dd58c ("tools/rtla: Consolidate code between
> osnoise/timerlat and hist/top") that was merged into 6.18, common.h
> includes timerlat_u.h. Your change thus causes a double include of
> timerlat_u.h, leading to a build error:
>
> In file included from src/timerlat_u.c:20:
> src/timerlat_u.h:6:8: error: redefinition of =E2=80=98struct timerlat_u_p=
arams=E2=80=99
>    6 | struct timerlat_u_params {
>      |        ^~~~~~~~~~~~~~~~~
> In file included from src/common.h:5,
>                 from src/timerlat_u.c:19:
> src/timerlat_u.h:6:8: note: originally defined here
>    6 | struct timerlat_u_params {
>      |        ^~~~~~~~~~~~~~~~~
>
> Please rebase your patchset and fix this so that timerlat_u.h is only
> included once.
>

Correction: the base of the patchset has nothing to do with this. It
is the C standard, from C23 (default in GCC 15), redefinition of
structs is allowed [1], so this error doesn't exist. In earlier
standards, this is not allowed.

[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2863.pdf

Tomas


