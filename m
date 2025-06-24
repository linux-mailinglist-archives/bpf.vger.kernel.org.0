Return-Path: <bpf+bounces-61416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB4AE6DFE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995733B79A8
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BF2E3B16;
	Tue, 24 Jun 2025 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jos1yDt3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEB1FF1BF
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788043; cv=none; b=VFC/zcJWUKyQpMgy0Bkjk33iQ0fjcUDvVWuJhSEvTly9Taj+aw5J9eexhxQY4x/T2yKiWpzIKPjwPG90M8TtdTPrceEy7XNFnO86C/X3Sq3Mhs/0hGuImEWyNTdQRR37f6MYzjkH3oXK/ZzGAMweIOgSXjvYHqfP0A4E6b2zt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788043; c=relaxed/simple;
	bh=QHOWqcPUrJmp0AYLgakEfn72z5gvVH2RNePKPb9CByo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8JJhuzZUt/up0bSQFUH8s22NA3KJRicJQriGa/9vDx1xFaK7wTfL9YvLbh2WSzHmaeN1v4M76xYkOEn+LzEIC53J0Cck8m3J1BC/T9QgRpJry2qUfi5XA6jzloTg1z1lVhKEUeQ7GxbjZIBPbLcnf0NASfk78a0zkLk5RdatCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jos1yDt3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade33027bcfso116221166b.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750788040; x=1751392840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45Osn6urcSEJx2MxMy8sPkGIYcZvu5BwF60LcEEpoa0=;
        b=Jos1yDt3H4MzluoTqZVFF4OL4fFrQOrtLkKpakYoPHJuMn2B14oaOleQUShC6sah77
         9HP3P1Ikolb3XQpNutA4T9dmFBmGvW0DbCGur8Ga1m44euLunj8ntZS4m9S1OsbIy6Px
         NePS8qkUvxApCDenj/w0HzZdW0ZzgiglUvtmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788040; x=1751392840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45Osn6urcSEJx2MxMy8sPkGIYcZvu5BwF60LcEEpoa0=;
        b=RULe2jNf5q4ign65iBTzirhBl0wVIRdeRPOkJJQsJkF6skQq4jDuXeygDV1TvJuPg5
         4PJX7B1AYHYut/B0+77cbdys1LLRL/rIwpa6X3P5o7EWWLm5CrwRyEgqqA5nvR+KDGOL
         6ZfzjdlKorN1C2M+wX8EsiQ8Qrv6ZY+F366Do8Br1MslDAYCLxuQ+kWooCXOHZwpjeEb
         CRD7roVU/AAmRStHrgyp16EFeiqfgY+uzEMRu70/EjDOyB7fBfu9MiUrp4B9EuYHPXoP
         6QbTR7tFrGLoMsHcdzxNgnyKhhJ6HYMSsLXWdOos+LXOZodRcU1TsT/MctLpkQdmK+aO
         7Obw==
X-Forwarded-Encrypted: i=1; AJvYcCUlqN2vbwxUrHFqFZO0dD1FrT8mrvX9HBt++3ppQ6AgCUxhr6IqyCs9SDG4HafzqwhQZkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEBpFPHIyZ8ONnTQccUks1QpBjF+iS4d4/Wc+vBhZyt8Jni/Z
	iMOfbF7MXU+BWfnPwzebJj2K4nsunHzG6xMaB/lYeldyWnIswTfrAkLCsqKe7jK7bDXggGwYpV3
	fMBXvmuQjd/rdpbSZoX1Pzc0eMHYQHHLzkUCTIrLP
X-Gm-Gg: ASbGnctCrgVlWEDjhhacRPFTGdbWC0xqJWYjPr8Hf2CpaD2+vJmsrREUdJ6ciJqvUwa
	6YscTDaAmdo9U8l/QS48aV30B5TTW6+FiwD6D/gXZJrQ5eRKo2S9L0wjyyyAXtNyVI1lGiPRjLg
	YX645ftcRUCIeoV58vhsyQiHGfcRLvYJ8kFA8KBq7l60qD
X-Google-Smtp-Source: AGHT+IFzjcm+BsoHTOSMw6UWLJnFF2fHLv5NvLWu8Og24Sp6NVstBe7hiLul3tl5S1MbkyzWwKUahM6wuGTu8Zc+VKc=
X-Received: by 2002:a17:907:c24c:b0:ad2:1cd6:aacf with SMTP id
 a640c23a62f3a-ae0beed95bamr16035366b.47.1750788038323; Tue, 24 Jun 2025
 11:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFl7jpCNzscumuN2@debian.debian> <633986ae-75c4-44fa-96f8-2dde00e17530@kernel.org>
In-Reply-To: <633986ae-75c4-44fa-96f8-2dde00e17530@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 24 Jun 2025 11:00:26 -0700
X-Gm-Features: Ac12FXxljKyD3S_Y-OCEt4mQE8-W5cymxwwOigSk3YWUsWkRuolMG42B_YohZjs
Message-ID: <CACKFLik8Ve4=eUV=TJMkwkScLN0H80TtiqPUwtuDqNEji+StSQ@mail.gmail.com>
Subject: Re: [PATCH net] bnxt: properly flush XDP redirect lists
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000379c790638551bf8"

--000000000000379c790638551bf8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:59=E2=80=AFPM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
> On 23/06/2025 18.06, Yan Zhai wrote:
> > We encountered following crash when testing a XDP_REDIRECT feature
> > in production:
> >
> [...]
> >
> (To Andy + Michael:)
> The initial bug was introduced in [1] commit a7559bc8c17c ("bnxt:
> support transmit and free of aggregation buffers") in bnxt_rx_xdp()
> where case XDP_TX zeros the *event, that also carries the XDP-redirect
> indication.
> I'm wondering if the driver should not reset the *event value?
> (all other drive code paths doesn't)

Resetting *event was only correct before XDP_REDIRECT support was added.

>
>
> > We can stably reproduce this crash by returning XDP_TX
> > and XDP_REDIRECT randomly for incoming packets in a naive XDP program.
> > Properly propagate the XDP_REDIRECT events back fixes the crash.

Thanks for the patch.  The fix is similar to edc0140cc3b7 ("bnxt_en:
Flush XDP for bnxt_poll_nitroa0()'s NAPI")

Somehow the fix was only applied to one chip's poll function and not
the other chips' poll functions.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000379c790638551bf8
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGpVX2vlRib6zjuXXQgw/iclxwtq0F3S
MEQNfMpA59S6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYy
NDE4MDA0MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAEBNGXn4pdi3vAmyJ17WeDopHMn+2kV0OwLMtEv0zJQtnjiVtIdhbEklM5YP7VEgziCV
2e59XgE4VRZM9Vz8Du3Zw/yk+8GHLvZmBCuKyrGbBz3iNVwjIPXrAqWvV2lEYZSmww+broYoD8gE
m3R08eq5MChzJbLmFdalkfBjG5S3g5WU88K1DEfw8SYqWfThVeH+i5NNAO6s9UO0j0shXIC2fyBq
2dbxb9auOMg87pONiiFDc4OexLHppY7YhbiP3571bVcFj1AJB8EGcY98q8cgM/KFi8HW+xTel2I/
NHx/VleXZU0SJdfHoutd4HcGmP/fNhBN4hpZbk06wNH4UKM=
--000000000000379c790638551bf8--

