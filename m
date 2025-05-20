Return-Path: <bpf+bounces-58592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986EFABE263
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E5C1BA6989
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D828002D;
	Tue, 20 May 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NEAzUclL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD228001D
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764919; cv=none; b=FUVP4yP5yzFYilAd09L8AhK3D1YptcaIqQIPr2wKA19636SIJA4PuN+CaHW6GXLnic6F7KO3Fpe2KWLZFz74qryIhXZKpxtn4iAMwiLWM98ptV1t2pZQ+69PFRtHxVakNP71s84yNLplsQXsZc0wXrDHpyy8GhqL2mdP2jw1W0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764919; c=relaxed/simple;
	bh=GgRCVDLqnmamZ1LoAdHXNYPW8/DDTnAXmUQXrWe5gIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9larw8NUp9+Zr643yQuSnmC5Z8UeretQQCi6g3ePL0TinCKI+hvUfKlh1SoyixwxwAgtGSU/wJXjsOpl0ANKmF+k0zJhERgXWP61zsHAU8nDRQFPmK3zEVGxae7s9I4r+dCSE6PCdS1Mar6fZAMyguVu0SE73GzOQKdLic+ouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NEAzUclL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-602039559d8so2852737a12.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747764916; x=1748369716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GgRCVDLqnmamZ1LoAdHXNYPW8/DDTnAXmUQXrWe5gIc=;
        b=NEAzUclLEOipBmxjpXMYTfuunNdS3z46FXvyhiXtiLqoK/q8ZK5Hn+fX1An6sCN5ro
         ZWwIV4xT2M2DiTs38JHtLvaeFhfsYEE4I+IM0Km2e4V+OYTk9gDT3G6cux/OXjSAcQXx
         c+vX6FfiC8H5ZSLedIf9y5TJNwg+AHHgSLnhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747764916; x=1748369716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgRCVDLqnmamZ1LoAdHXNYPW8/DDTnAXmUQXrWe5gIc=;
        b=bFPoepro0kRqPDayTDdwkjVu8+0aFzlhPkD6ZL0dv7wegBogQLVGEDeAochznyY6HJ
         TRR5mHm4t6RcIPEdchk8wrELl/iiDhcjsdboURu5PR/7BZgk68fmcUPFQZTukS2U5Kzo
         Njfk4LDdWusHDkPvoncYJiv66IU5dI2gdKmabN1HHzkWAafHnqHGYKhQd+evHK88+7nZ
         F1vRxhVDes/XMw9KQHQXP1Jrm2EQHtvvX+yPW1yK0ka6t3Eyb92Do/CmpIQdA46m30OJ
         4OFaSUE5/Zgf3dnny3pi5ijwMuVrCP+/E1l6m1xsPfNqHDB8f4incwnlS4JvckqYK/oN
         BnnA==
X-Forwarded-Encrypted: i=1; AJvYcCWUyTjomXAJYvrBk1cfFS4YqeGf+kGx6ahxf7uvtWsf9shP4xxZbTxbXBxioE3ptTdji3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxWKCeMkdywq3itATLA+yNf9dwgux+vmglgPXSbDOb/WMmsM5
	q+tHUbkKBVOz6VP7yKF8Ma5S0eMJ97325sN9iq4s3o0SQCitx8AIngBAKcIVnUN1yZSTggJr7Y5
	O+k+CUaYKkpPy0KeyZsjINV6eFiSj//2HVJDaylCD
X-Gm-Gg: ASbGncuSoWgS8WtlOlD8+znvb2srnFXuP3G4fibb6enqxCBBJRrl5rSyNSQNL1puYQ5
	/eUJq3BQVnR4V5BXPKD470Xd7t+MqHYibbtraJiO66JDodc3vIPuKZhWdY9WvvKQ31wvVbgYbqt
	v+bwsiOHpfufiTjcdVHSkQpz8NgBkT5LPMuA==
X-Google-Smtp-Source: AGHT+IH2vPwJz0sjM3C3YxrR93NrEDGYZaDSkItPACV0OvjxE5jvyshItlpPZG+ubzTI4L4eAqrEu2ipor8Wnjfy3i0=
X-Received: by 2002:a17:907:d0c:b0:ad2:24e5:27c9 with SMTP id
 a640c23a62f3a-ad536dce79fmr1364806066b.44.1747764915563; Tue, 20 May 2025
 11:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520071155.2462843-1-ap420073@gmail.com>
In-Reply-To: <20250520071155.2462843-1-ap420073@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 20 May 2025 11:15:03 -0700
X-Gm-Features: AX0GCFvmrHawgYSQUasyIb42hosa50fYd6YYiZTO5ev6CSOnKU8LrPFCfslqR6U
Message-ID: <CACKFLinam==HdSB1KHRitGByAXNGW9awmfyu_jRasjA-qKmCHQ@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: fix deadlock when xdp is attached or detached
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, jdamato@fastly.com, martin.lau@kernel.org, 
	hramamurthy@google.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f83aec0635953a7e"

--000000000000f83aec0635953a7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:12=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> When xdp is attached or detached, dev->ndo_bpf() is called by
> do_setlink(), and it acquires netdev_lock() if needed.
> Unlike other drivers, the bnxt driver is protected by netdev_lock while
> xdp is attached/detached because it sets dev->request_ops_lock to true.
>
> So, the bnxt_xdp(), that is callback of ->ndo_bpf should not acquire
> netdev_lock().
> But the xdp_features_{set | clear}_redirect_target() was changed to
> acquire netdev_lock() internally.
> It causes a deadlock.
> To fix this problem, bnxt driver should use
> xdp_features_{set | clear}_redirect_target_locked() instead.

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000f83aec0635953a7e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBE+Am21F3VsHugPWez2fjoP5VyiXFJi
EYuLSzr1Vv0/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUy
MDE4MTUxNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBADhxNXp59w/i2XVk7J+gfn7a6sPFfP9cwx9HR1/U9Q3z9u+TN2GJdVCitQtODrqTjuKl
THMg9wEgyu8evwzNU0x9/jFx/DBMleJOogQpxVtClWwDaZ0dyDynpQaCacrTnSguI9ARXgpOFZxu
UZLg1FhQ9HRMSB7gfEb/dN1QYmJ5rk9MCrJ2PMg/m8uEelWAzrGvqTZigd6QQ6ot3sAiYLs5e5MG
iaSvqxfJ5Ne0fiPy0hNnQIYAn5BuZC0WpSeK1A0dDPvUY8Ii77z1SUpursoFEyDf80eSsFCwBsLD
VY7zTdA2KbgoAggAT9AkYvE4bJXhLhXgkP2lhyicI9kHwcc=
--000000000000f83aec0635953a7e--

