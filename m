Return-Path: <bpf+bounces-72656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC15C17785
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848A81B27890
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103513A1CD;
	Wed, 29 Oct 2025 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YbZoaS4q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193B29A1
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696299; cv=none; b=Ki2MRZZZ7XnVh+ZhhoNplDwBlwafeL9SE2Q3YDe5EIBEh2r4M5pQ6yG2brsKEQRfhbPsCd+DoaqJtc8h9WQm0pGTRNS/XxQ1uDt2/cg41s4wvBtzMc5wGhfu0GXVGHJyt6nwIX+yG8T7oBTSn8heMy1OEz9SbGDQdrKB1220vQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696299; c=relaxed/simple;
	bh=qF3NtATOlOxjmKjh31CoJ8+W1noziSRiCQPVNghpJQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo4uvKIUL1N98LdDgqEmeVWq8nFaXUj7JG85PdIQRwfRsrtW19W1nKeB+ugNaTo1s2qCntMbCkN5+6k0UZvgfDMEWY1MJlFWdOS2CnwlPOxUOlbLiNYeC525bUDz3DQxKbT6KHZ80Yj30ZS9hgV6IPxObTal2hubNK3Nt4DMdQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YbZoaS4q; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34029a194bcso1688969a91.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696296; x=1762301096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BerLOcBoWrV1cLwn2WvSsreg5PxA+PLtgWK6veAyVuE=;
        b=YbZoaS4qDsxU9JuqQ4+3At4yH/xb+t49dYMx4ISzdT10Oyh4a4LL8Xoth4UBNpPzur
         itM56A7SQV0GUZ5w8xvciREEGwmWVcktk+WNgGo5xRpvGisMiQFBUmzHNigbgsdLltuz
         +febz2p4RQxz1twT/85RYbInr8Qcj/hdKgsarSl4+IMbNiaHEfL/ickls/wMnIg+xzsa
         4IPwCpYWb2isD1NXOYAbyvihlOi0GryBRt5RCIxfsk2RtMvDS6iHlBhho9ytJKF38Y/X
         R2VWfvi+gGlciUOT1SsgwNss364GzmiITVWZ5HYuAohyrQ6dwaDR9zKMuNdpsLjDsniV
         i9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696296; x=1762301096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BerLOcBoWrV1cLwn2WvSsreg5PxA+PLtgWK6veAyVuE=;
        b=K0+v8Y29A8/AFiaFZELCc3e/XS1BmKVAAOm+edtr2Ue19Xr6SS1Eft0LhcWKO7Yc56
         jWmxyaXs3toY9M0j/YSG7LIZqJej05CyXTQbXikZUNddRA+EMDT7Tn0lVPyMt2LoC5zW
         ydp80uXyilqm5e0hPtNZ+qkkm0c2woEbF2ikLZXVrcdOS/u/08r1PjvonFwcP1pRcdUK
         SRF1I01OVzQnZranVdgTFwahDDZ0OHH9/AHIHmAfAN9vWQlbVeLwNrVTi2JMhRv2ou3b
         TZphdtNUq9AuLDH+8pwdIP4vV53yW1wtgtIMRzjs3lyb4DqZ6/gTlw+btmm5Udw7rBSD
         B69w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/Oy1hducQfVtIL3Z+EAmGP8uug86WYoeHaoIHcvSLEFvajPwZKiav5BbuZv4xunJO/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrf4wSbLmhV8Pu0/Hn/+PBr3VTKD4vqyB2XWoqXIxN7h4XpBS
	DAOtDYd2P6zZ2TCcz+hjkcJZ64rm7ptEn5ezCMfG/30wu6ZyC9alSvI50O6fORN8wZAMj3CPrSB
	SvESYi5HvoFvZhWH/llkfB2vGiZTGL9NobFV3Uzjm
X-Gm-Gg: ASbGncuAAKVS0kad6bIBKPFYGwm2OG20BKo1bvv33uWbdu+T43Xr5oV/lKsXtzqVkZS
	jI0pCX9Utu+lCvYQ/Wh6LV6phHAG5nF0YBDhP7PeuWY4631aOmmw6aoYXtKwzyE3IH/KgUZo1lN
	F/yUMf/Q0J0THw3WW+yiER8NbPVamWkPG6jWljgmYVBdhW7DXlEkyX9uzS9sTgFAgzPnI1G9KWr
	WUZCX8a2tlNZxNq74+DNK6Thv2nBBYfrfDQ9TNIfMj6R7cNRmyHJzGMoyYaV9qSTSZ+JZo=
X-Google-Smtp-Source: AGHT+IF9Sg8XTJhY1XF+gNJzXx33YCPJNPvD397jHY3K37ysFCuyvsRKOtkLfk2UKLtdow89RUSTsoGqlzXNXJIH+YE=
X-Received: by 2002:a17:90b:3147:b0:33e:1ae2:a4a7 with SMTP id
 98e67ed59e1d1-3403a2604b4mr1039988a91.12.1761696296385; Tue, 28 Oct 2025
 17:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-50-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-50-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:04:44 -0400
X-Gm-Features: AWmQ_blrbvCvNMESns84vcg9Bs91_mExO5kolf7cbCdCoz5ngCaqmvIG7Oeo_oM
Message-ID: <CAHC9VhQH--uP=fWo0MsH5=BojV2qG=qy7A9tHTVOnLYOxKbV5Q@mail.gmail.com>
Subject: Re: [PATCH v2 49/50] kill securityfs_recursive_remove()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> it's an unused alias for securityfs_remove()
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  include/linux/security.h | 2 --
>  1 file changed, 2 deletions(-)

That's annoying.  Another case of
let-me-know-if-this-patchset-dies-so-I-can-take-this-patch-regardless.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

