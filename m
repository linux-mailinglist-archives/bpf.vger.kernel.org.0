Return-Path: <bpf+bounces-51777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77556A38DD8
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D487A2E6D
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA223A578;
	Mon, 17 Feb 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dn0tQgKN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE0239070
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826474; cv=none; b=vAATsObi6QrdyEASnuHJpClI6X0GdUmuZQuXZ8ecRBI0ozUjwK/gda6u34Kt082qGow8vOsRrR+MygPoyJgTz2oSlVurlx5CclR+m90UhISFnYF4Iae0FgsMzkYlxcA2Dz8501X++qUwfiJBZUlsDDohzjxaeQSQX/hP/zp8YjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826474; c=relaxed/simple;
	bh=FVgtry4O5cXdslJioeSW8pLA8fJ3SPWg8v3NmiLk40E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdeoQXeqy0LHMDX41MVhHGXKE3B7PDEeHcVrhRpqVxwD9vYT4h+yIeeVl4l4wS81goLv4OttH/vE70z6x7z75fcWPLMVVhjvh9jlUb6YcWxTXpan0G0oekvNoZ3Ve5somzNuMElyWwHGnhrXtWKmWf65F3nMCO82pH+nJCi42tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dn0tQgKN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30a2d4b61e4so12258401fa.1
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 13:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739826471; x=1740431271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O50DnntQE3DR3CjC6EgGtKsoYkxOJ8SUF9fjHo07xls=;
        b=dn0tQgKNpCwJ7TSTiyof0y5EmssjZLhs43Ebkqqt4s6TnXpHWLS7m4MjMpzmJhSd9N
         lD6/dU2D1JsjCHIou9mzYIrX28RNE+vGyNPLhc2Ca8gL+JGcvujeqFFI3YMX/8tRmBZC
         czviu//ezpGzj9YSVU11lPNSUR+VlsShzQgxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739826471; x=1740431271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O50DnntQE3DR3CjC6EgGtKsoYkxOJ8SUF9fjHo07xls=;
        b=TWYP6TYbFS9RcZfs2XJVpgkivkstCi17xHC4WXDTnfKQ8DR1gQ42JFv3j59jf6XNQC
         zRqcKs5WmhbcUsiqK/xk9Ky6DFLNRjL1lJ3xmFH3FcU4lmQFWw3354cbxxIzUXoddaAz
         69pmspL1mvl1WhXXcUNJByGgArUTF9UA+NQtLM9g4b8Xu5oIm2DRwL0gDD64H5apoFJX
         QOll0pF1ojteSBznhgahI+FxWto9oWJtuFAscZzrHVY5HyRDBhOQ1clNF9zCG+NhRWIM
         rfoLX/dt7+wxBjJLcGZT9KfFwCJ8FOxCDRhDvzoWjY2CDPwBkCvn1xBEGB29qA5KDcov
         5kQw==
X-Forwarded-Encrypted: i=1; AJvYcCXGfPr0RDDVA++WHswNCDPUPfIM8XsfqKZXo5+XX/jT+BrU4u+cTFYe0GDot7SEGB+piyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbVfXFn31ZAIrkFN9jHlapUPpjqMx3JC7VHuONHf83vjzuhqR
	CwSAa7Wfu5RhUIH47wcJA8JKONx0XeIaKimRZHxY1hlQgWYc/tmoECmJEqzmoTNjbK+Ilh9WQ3y
	MWFmEG2PQR9Ca0r+esekGqPt3893YsBgu2B7uajpKqtsswLMJ4e2p
X-Gm-Gg: ASbGnct9Bu805ctDt9IF/gCAtt5bqG3ueI5iMR/5u4AXrarHfNuTmV53ClzG1FB5s0U
	qncJO6ahEBoNjR13t3AIWWUzbNbRP7pzJM40ysi0QElRCKJgsOO9UAkgSCp+1ccNtUkwPegiIyc
	nvgMKxdEmCYbS25Xn+N0yuOZkGUooM
X-Google-Smtp-Source: AGHT+IETynsnWXFFoobhNYG6kug3sx2y2J8eck7h+JszqxvDS2xVQtW0RdMXvdFDFC9n5vAIVJ+y3VDSKkTxDfKl/eE=
X-Received: by 2002:a2e:9a89:0:b0:302:29a5:6e21 with SMTP id
 38308e7fff4ca-30927a2d1b2mr29062351fa.3.1739826470909; Mon, 17 Feb 2025
 13:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217141837.2366663-1-haoxiang_li2024@163.com>
In-Reply-To: <20250217141837.2366663-1-haoxiang_li2024@163.com>
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
Date: Tue, 18 Feb 2025 02:37:39 +0530
X-Gm-Features: AWEUYZmpt2f5hkCvEnrd6qnO79Fx2QhABAiaPRpC8SsHYZPuHseVCWzRUuHZ9TI
Message-ID: <CAOgUPBu-c8HwYV0A-Wdga3z8P9+CY3=YUVg73qvq6OkeQ4=2Ag@mail.gmail.com>
Subject: Re: [PATCH] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: kuba@kernel.org, louis.peens@corigine.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, qmo@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org, oss-drivers@corigine.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000caf3fa062e5ceaa6"

--000000000000caf3fa062e5ceaa6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haoxiang,
Nitpick: The brackets `{}` in the `if (!skb)` check are not required
for a single-statement block. As per the Linux kernel coding style,
it's preferable to omit them unless necessary for readability.
Guru

On Mon, Feb 17, 2025 at 7:53=E2=80=AFPM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:
>
> Add check for the return value of nfp_app_ctrl_msg_alloc() in
> nfp_bpf_cmsg_alloc() to prevent null pointer dereference.
>
> Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/net/ethernet/netronome/nfp/bpf/cmsg.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/=
ethernet/netronome/nfp/bpf/cmsg.c
> index 2ec62c8d86e1..09ea1bc72097 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
> @@ -20,6 +20,9 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned in=
t size)
>         struct sk_buff *skb;
>
>         skb =3D nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
> +       if (!skb) {
> +               return NULL;
> +       }
>         skb_put(skb, size);
>
>         return skb;
> --
> 2.25.1
>
>

--000000000000caf3fa062e5ceaa6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGczCCBFug
AwIBAgIMUk0VAZ2+ny3UPjcLMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDY0MloXDTI2MTEyOTA2NDY0MlowgbcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEcMBoGA1UEAxMTR3VydXN3YW15IEJhc2F2YWlh
aDEvMC0GCSqGSIb3DQEJARYgZ3VydXN3YW15LmJhc2F2YWlhaEBicm9hZGNvbS5jb20wggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDT0Ds+7uJK45uIzSpcStEgsoGtSBSCM3BYtj8H4WsF
Ryh4F5x2LhrSFVgvxip1dFM6bqyyLEY82kyxQJSChQ6uFDmhMvf0RLnnLq/bG76MmUGYjFksgx42
HffC6RhAfZ4rFPHuMTzPdyLnEitTcdBZRZmqtA4TSc/va0ZYpt2NXER42km8pBBJnEUoXWUauk/B
wE/SJP0UDZHDpR0HTDO+2ul9LeMEGfSKAMWjTnBmC17rCqOM72hW8DJti66bHFRtCHg28L3wRK82
V4Qk3hqSXX7fETAbc98s08Hx2V/psvw2XJjLa0jcBQcswvSQl0S3Z/k1UN4VBO3I9qP6x4JzAgMB
AAGjggHhMIIB3TAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAC
hjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMu
Y3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVj
YTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQw
MgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1Ud
EwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCsGA1UdEQQkMCKBIGd1cnVzd2FteS5iYXNhdmFpYWhAYnJvYWRjb20u
Y29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCS
MB0GA1UdDgQWBBTbuVbn7YM8LkfptiejPCXAA9xe6DANBgkqhkiG9w0BAQsFAAOCAgEAfTu20v5U
JUB1TEHI7Qt8ajW/ToLpU3/BtFFwMne3hQsbEPpJPhBY133wtFoS01K3AFcl6rdOVThpp007r+eb
bb5KR/oYokEvw2seZ1y33ZqGNQdZDTSzXOXKrm9ATwWRjN7dNhTrr9Of8BS9Kjx6V+O8KRlaoWVI
GT/t6ubwmFNk9mKNec4RRcDTlu36nJmdwPMu6X2+kxTFRoLpcyIdL9fMkXOIT/JAIyKMURNqKDtz
InPPvNHgGN9/FYJbqNFj2q5tPbxJbDGfs3i1ulPRTOADhIVwWFrY7MgNMOwcJY8AYO/URDWA3MeZ
RCvfoIKBHeMgabWapnlLWsOpXJhlnZoSvrw37fkFVc9a/EnUIdXzDs3M20m8jYigf3zK7/lQkoye
vssiDIcz473ViH6gaZEPN83DN7L1VKgrQ8zHF3qw8ctyH9i7xpWbqZ635JzaNqbZ0eXaA4nNfuCo
EIsyrGT5sPSvWx8v+OcgMeh00XLvHBZfGAtf64NIedRqamOfuC3W/zpQrnmqr0IDj/tOgoaKBz3N
KSy5T8E4NeNfiVxB7tOFWQms7pAzfD0OQiUHcjfNLra5uqQlafXezxKKGHeshKukKz8Q7mfV6ES4
cZtIbMMXwd6jsxAj+vDw9BeG0/M49qmEZ9Rteb6dXnObIte8gDtK41NjSWH1Yslg2YsxggJkMIIC
YAIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxSTRUBnb6fLdQ+NwswDQYJYIZIAWUD
BAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC4PcS7KHtbYF2jzuAzHvX02z7OSdtYpU/2yV9P9Hc/I
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIxNzIxMDc1MVow
aQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG
9w0BAQEFAASCAQBXPwp2edAG950shMh8qrVzNRlbXYs0n/3MPMlwhHWTSK1DpMNvJJBErfIN3DiD
DEmdDGcgBeealljc0U48/dUCnO+QsF6PmH9O2i8NYsGBx72XJzx8MmBrhhelrmf3xsJ8ygOtrTuf
0MeIxBsIwLQoHYoi/EjQrGWCb9o6OvW/a4/vJsLE/WRYG/vpl7LZbFjMDLfCxkYLC60i/5JzvOtr
gkBz3hTY7ksQqjlnEZhlIFNHftpKlmHC1eOshBUhssjnUSJI4AQpUkurhXULEQA2wRcB95YSs3Ao
PJmfivVo8KSomkOYcXqTDs0LvdKJgpYLH1LPF+Fit7x6+ANMZube
--000000000000caf3fa062e5ceaa6--

