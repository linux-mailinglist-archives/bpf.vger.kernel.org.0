Return-Path: <bpf+bounces-47718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C369FEBA2
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D7A1882F8D
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 23:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263A19D093;
	Mon, 30 Dec 2024 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVbEMn/9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828818784A;
	Mon, 30 Dec 2024 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735600797; cv=none; b=oNUxLopU5Rr66/IFwhxrCXfzt/4+/yoQxXBgi8tMZ0QcKsHtgQ33LyeLA/RNMByRWIPJbyQEqK2BaRWV6XKq+1j+HHA/rVvpo6WeLSlR8mqi+U/IP/YR9fLvsi3Y11zbRiD4nxp42h4ImpI1Lri8LSukeOaOxjHTzOYWjOtbJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735600797; c=relaxed/simple;
	bh=lObSgn7SSiRfnfY3+LR+PayYGeTqwqu0G0gp13xRK4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYdlkd4r5dL6pJHAq9myH8lc0HQOIq5Yw2aKjJYWlDqImrsES6R377uQAA8ewYQTlYxT/KlbnjlZSAal+GTOhpIJ/WozeTq4Mz1YyygCeTU8+PKSldFgHkKRktf87GmLJfnQ0HGn/koIt9kRbizKUKBAxYlX+pSIBRbpp+8GG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVbEMn/9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd730so69140495e9.2;
        Mon, 30 Dec 2024 15:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735600794; x=1736205594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lObSgn7SSiRfnfY3+LR+PayYGeTqwqu0G0gp13xRK4E=;
        b=NVbEMn/9s3WPS5mjyHWQGQ4YcUybWLy8l2tWw97ycGdPWLlF4L8fZ4mS4CzYBfJaJo
         pyqOk6TCu9OK12MPG9+1mb5aZ9f3jCfXVJAHRQiVF9itrwKO7t/zdlXGgFS/HTCLHIiG
         D8E053+/yA5hAMMwvVQxt4+wVlLuVgkftd72z606VVDM8ngKFhQ8/7aV/Kzsc7u+h3h0
         rsvYKQcGDfuyKC/kXEQgicBx7ZUMCq99J+JByJ4h3Jxp+RI0KgU82NCJbQx0Ist2x4uy
         VLqkSIeuU9C1mtf50QgVNjO+OsdIdreLIFuc3azt9PSKuOcA+4JrpUpsN+8Tz1SAKXdf
         Ddwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735600794; x=1736205594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lObSgn7SSiRfnfY3+LR+PayYGeTqwqu0G0gp13xRK4E=;
        b=gzwToWguA2xApDL5vzM246B41gkck5S1FjO+2DmSKZ8PueG5vC1Qx6X3T1n6HayUVi
         hFJ68qEpeGBFQ5OyRf9LYbeNpycZntCfEWvcHbgMyZd+c8bEwbDlkc2QIuCY4/Jn+mQk
         GX/r0N+gvDQbqOm27AAq+IwjcnYGxezJjy6/qJO0uiD01Di2cK40Y8oaH7QxZruFoBA8
         sCaOJvPaCJ+lBgvN3he6oaeD6Qc9OHfuRMpieAkw1K+TNrYzWZzwtgffe2E6lyJtmJBN
         LCXT8THIpXnuI5WpIS5AYJNYxqKOxpgd/4XwJl0k5B2F4xCp6wE277hJ94TBspOtrOkT
         aQjA==
X-Forwarded-Encrypted: i=1; AJvYcCXUPBDGue78SN+q0vWzNnSol7fmSezQ1d7lG3XAfYd5WHSaYUjAMJPKbdxfmhbLVIbgnozSqmHHlb2UUW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKw9dlFtvsDDr566Goo6sLcAf4D+qF6O9PEZTbw/vU1zDKRsC
	Wq9RCFeU9301LayGHRom7MlAxnV8DW75EFFbSmvSAzMn9toaEL+QrQYO7DkI6Roz/uAqbWY5R8C
	NtJeZkRkLDyM5oFHaIQrOypV2GWE=
X-Gm-Gg: ASbGnctmzf1tjBjlLLIHjUYb+tgwa6wB4W3lepXhDwVAjYA9bCIY1tIf7cDC5c+YrXd
	Aljhld77mWi1/94o6hLkmdnhuPAQKw+RFEdyKKBRlpbwLD7YMz9jCwMEyTFl9uKz3xZV0PA==
X-Google-Smtp-Source: AGHT+IE6MC0xJZscnMQx5D31WOQ+0hcSfNQnDPYqmRnBKoL7geiv0sPApQOfml/vbFmoExLCZ9/6W+tl2CWbHsJkVvY=
X-Received: by 2002:a05:600c:46ce:b0:434:fdbc:5ce5 with SMTP id
 5b1f17b1804b1-43668b78d1fmr297020195e9.29.1735600794505; Mon, 30 Dec 2024
 15:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223115901.14207-1-lpieralisi@kernel.org>
In-Reply-To: <20241223115901.14207-1-lpieralisi@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 15:19:43 -0800
Message-ID: <CAADnVQKbDphgukWxwCBck1tVnDF_vkFpbkcaB-synwPxCFWOhA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove unused MT_ENTRY define
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 3:59=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> The range tree introduction removed the need for maple tree usage
> but missed removing the MT_ENTRY defined value that was used to
> mark maple tree allocated entries.
>
> Remove the MT_ENTRY define.
>
> Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it=
 in bpf arena")

Fixes tag is not necessary for this kind of cleanup.
I removed it while applying.

