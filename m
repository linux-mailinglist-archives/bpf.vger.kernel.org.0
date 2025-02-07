Return-Path: <bpf+bounces-50818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E276BA2D167
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 00:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C7B7A20FE
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 23:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516161D6DBF;
	Fri,  7 Feb 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WIzErQ/Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19818FDAE
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970329; cv=none; b=a7GRq4QFcMUhGXfW9bihGFWaIxzttWvSA1gVaVyOjtBSeXfkeKnf+Q7aO67NBSrljDsfe+3dro6JTFbWQyoItHNv+EgHnXdSmAeryrkKsQ4uhqP6mzWSxYBLOMYvxcOudq17fEo+2ORUrUfzVViwrUXzCgeZ44KnP1VFunvlppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970329; c=relaxed/simple;
	bh=5alaaO9ZmgYiym0NIgk6g51qicM9iKUSAXoTtk1qvFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W51SFWXUm4Lf2Zkkbv0BAmRLZQ/UuxhkWVouTOj+CJzDWvJ8mE5NGNN0QG6JKw4+IuLk6ghQcP3FfISB7X9h1dMe9PCfWic20HbAGsl0ete88HI1IzcocDt+2Wgh/NVuC9ZeNpfQljASa3V7QhZLLdpwyLylyszn/0R6aOd3A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WIzErQ/Y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso3871151a91.1
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 15:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738970327; x=1739575127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lf5q0aCThbD/KqnjYKMD+mKT7WtkPBbfBE6IAIgCFz8=;
        b=WIzErQ/YHIv0bM/a8V/+XDx+YLcFcT/Q+K9OXIHcjRGwt2eRnvDvYBARFDz2HpRL4W
         owynB+0ftBZ52dXVKn3oP5LVnzojvNzgpSmRy/4G4bRnbfTYPfYVrr2aXrNZnfugCt9p
         GWVTcHmcIAITiZSxAh4OKMiVh5FkP4AgY+8zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970327; x=1739575127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lf5q0aCThbD/KqnjYKMD+mKT7WtkPBbfBE6IAIgCFz8=;
        b=UdMGiNdlbvxE6P0yMW0NmSQWmwSliV34Yqz56qMK/eyHB5DuisD9q0YkimsRqm72Y9
         2zvrMr0U3J60mQhQIWMsPos0RbR/TNWaXzT47NrBDkgmNtYmKcZuMtcYc8gsdxVu4KHY
         JTdfdMjANWQ3QISfuLDEk6VKp8Eite9soXyNNUOE7MIlDGZ+IwKuXSWrMOgb7Zi24Y9T
         eZHmzFQQLIvvdKVpEZ3YMSWBoMDVqNjmoS2j751kE+XazsWq3+fj0BI+A7hogXPdJvMo
         4bBojCOv6i1YKp8RaCCnFGuOBDAAPN3natLz+6BTgpT00qJm1IH/Y38dt+9o7z+fLv/8
         LjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBhXh0Yl+1QjG4xq1Zp9k6gdu8BL42kml8Fz4uu8HjY75jZH3oorsS+7pe3NhWZPmDyq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsm6zbxFwL2ZBgIupIvY+7xk5E04smv1weY6qsV76u2cvPe7MQ
	Ql/Wp5WPexMxKB96D2PlWJxhG6q8rYYHKsGBepjXd3xlKcWHf3NO/WWSEID092ObNkJBn0j4qBp
	Ga7RfoZ9UuVMooKuC8w3cqHB5iqhW7SM7j/MF
X-Gm-Gg: ASbGncvzVawfVCP7VZQlzqwNzj24dDSdcuVBuHhUTzlPoPYJccYaAvpcG0DitfZasPk
	69cupdFIbqdEbiK+EiylqdgmONMimAeqlAMQF/UFIpr4XvSMnV/qNg2UPLupiHjNi02kznqhGVA
	==
X-Google-Smtp-Source: AGHT+IE4lfz9Fh5v9JdiZ5M0ffjh4tLJUafbDcqw7fPxWUhBu63mA74BrOYKCI8Qj5LacoCaI86AvHrc9JedA4ysMaA=
X-Received: by 2002:a17:90b:3fc3:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2fa24274b87mr8579382a91.16.1738970327542; Fri, 07 Feb 2025
 15:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
 <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com> <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com>
In-Reply-To: <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 7 Feb 2025 15:18:35 -0800
X-Gm-Features: AWEUYZkdCDRaHgbK79-4_vZ3Z-i97Aw1Rvr0Mirz3m8-Wj2cdRiP6FpmPRGkkRc
Message-ID: <CAMdnO-+HwXf7c=igt2j6VHcki3cYanXpFApZDcEe7DibDz810g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for BCM8958x
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, xiaolei.wang@windriver.com, 
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ab6cf4062d9594fa"

--000000000000ab6cf4062d9594fa
Content-Type: multipart/alternative; boundary="000000000000a62238062d9594fb"

--000000000000a62238062d9594fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Fri, Feb 7, 2025 at 10:21=E2=80=AFAM Abhishek Chauhan (ABC) <
quic_abchauha@quicinc.com> wrote:

>
>
> On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:
> > Hi netdev team,
> >
> > On Fri, Oct 18, 2024 at 1:53=E2=80=AFPM <jitendra.vegiraju@broadcom.com=
> wrote:
> >>
> >> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >>
> >> This patchset adds basic PCI ethernet device driver support for Broadc=
om
> >> BCM8958x Automotive Ethernet switch SoC devices.
> >>
> >
> > I would like to seek your guidance on how to take this patch series
> forward.
> > Thanks to your feedback and Serge's suggestions, we made some forward
> > progress on this patch series.
> > Please make any suggestions to enable us to upstream driver support
> > for BCM8958x.
>
> Jitendra,
>          Have we resent this patch or got it approved ? I dont see any
> updates after this patch.
>
>
Thank you for inquiring about the status of this patch.
As stmmac driver is going through a maintainer transition, we wanted to
wait until a new maintainer is identified.
We would like to send the updated patch as soon as possible.
Thanks,
Jitendra

--000000000000a62238062d9594fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Abhishek,</div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, 2025=
 at 10:21=E2=80=AFAM Abhishek Chauhan (ABC) &lt;<a href=3D"mailto:quic_abch=
auha@quicinc.com">quic_abchauha@quicinc.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:<br>
&gt; Hi netdev team,<br>
&gt; <br>
&gt; On Fri, Oct 18, 2024 at 1:53=E2=80=AFPM &lt;<a href=3D"mailto:jitendra=
.vegiraju@broadcom.com" target=3D"_blank">jitendra.vegiraju@broadcom.com</a=
>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; From: Jitendra Vegiraju &lt;<a href=3D"mailto:jitendra.vegiraju@br=
oadcom.com" target=3D"_blank">jitendra.vegiraju@broadcom.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; This patchset adds basic PCI ethernet device driver support for Br=
oadcom<br>
&gt;&gt; BCM8958x Automotive Ethernet switch SoC devices.<br>
&gt;&gt;<br>&gt; <br>
&gt; I would like to seek your guidance on how to take this patch series fo=
rward.<br>
&gt; Thanks to your feedback and Serge&#39;s suggestions, we made some forw=
ard<br>
&gt; progress on this patch series.<br>
&gt; Please make any suggestions to enable us to upstream driver support<br=
>
&gt; for BCM8958x.<br>
<br>
Jitendra,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Have we resent this patch or got it appro=
ved ? I dont see any updates after this patch. <br><br></blockquote><div><b=
r></div><div>Thank you for inquiring about the status of this patch.</div><=
div>As stmmac driver is going through a maintainer transition, we wanted to=
 wait until a new maintainer is identified.</div><div>We would like to send=
 the updated patch as soon as possible.</div><div>Thanks,</div><div>Jitendr=
a</div><div><br></div></div></div>

--000000000000a62238062d9594fb--

--000000000000ab6cf4062d9594fa
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGbTCCBFWg
AwIBAgIMGHX6KxYK3WW2YyprMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDkyNTEzNTAzMVoXDTI2MDkyNjEzNTAzMVowgbMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEaMBgGA1UEAxMRSml0ZW5kcmEgVmVnaXJhanUx
LTArBgkqhkiG9w0BCQEWHmppdGVuZHJhLnZlZ2lyYWp1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAKWV+9PYvG4njqRsbQas79f8Q46VL7b1ZxvWT6ik6VMbdRZx
tfpfZalVXksqcb02/N1H7UA9V04cV2q97FkSr/KxeFLMetPb3cVJZICg23IRO2NTPdmgPFzwkPTo
35h9h/OYLgh3/9a1nTsC2xqJa8GtohD5+42rsskGcI57U4n1r1L4R5IL9ypSqDxX/xVEAdGI5FTj
VgvoZC6iuEbnez+yO8TT3wun9b/PQowOB5P0CwIFv7ERW0S1s6B8yrbsoaTrz0vQaEA786k1pZkg
ykC1+zXq/iTyZuPP4B4RkzFd43Pw+GAH0Tt2nx5V4rNisJHeAVNU92Gj01cEg0I+FnsCAwEAAaOC
Ad8wggHbMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQw
OQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
MzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIw
ADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKQYDVR0RBCIwIIEeaml0ZW5kcmEudmVnaXJhanVAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1Ud
DgQWBBRq5Jlxz3MqC+zEgUxK566xEc2g3DANBgkqhkiG9w0BAQsFAAOCAgEARXrmeeWA31pp9Tr0
M6mOlMv+Pr2raES4GzPSyftvxf6tBQCBNaqi6LSbyusDYOj3mG9bp6VeVn+68OxNY9iNAk+ujtId
f3+30BlZOQ1v8z9u2peUOUtWI60y2MxhdH0X0n2H+BCGvUOFqs5z440jqqy1HsscZTXHB7FEZmVP
fyD+0Z6cxyh7WNC6+BgLiFwf8iqmAbu7Yb1sGTUGyS5gfYEjJbF2PJfwNUcJDd7eS4w5Ju5mK5y7
spgjH2/JmDgbkpSk9JyuWfjGZIg4ah/q2nb6UMd1XJb6gLQZuzPOI3SgXPvd8MHGjKZrX2BHOBSC
bJJ8rp4w4a9QMS6dde2MFObusxkZAft4tUnwo+ProchHs7iA85sL7sWEZhAmjmKKCpECpEfZm0+/
hpvKQV3AZp5vBstb4IVL8QmLj8beDVHYnNhEicsSiG1wW7zSYyBnmGbFRrFQIJnJDWPjTZOlVEyp
T1ShrXRCtqJpOt6rgg+rFEY3D8j6/bAkJXnmKnE2LZ0YyrrKk7eC6UfNNimx38w3NWchtcGY8zJn
Y/1/C9Jv/mWm/2lK8nvusOFxhKmbG83Hx8toQdZ5F1kYk6zAWjfB7lwXr/En9mCmLieJ18hen9EK
qbYyUkmCmuoLi5GXFMJy+iQv6DgMVQ7CACagybU6FUrmL9lVa+A6caBEEh4xggJkMIICYAIBATBi
MFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9i
YWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwYdforFgrdZbZjKmswDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIACLRu++4+XaqPmKtMtKpJYU2j5rKyoV7Ufg8GaNA86VMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNzIzMTg0N1owaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBPrNla8/0W+0X6MCVu8XWhB/XD5b2kylwc5oOfOLfCww/ssj/BxUwgvcT4TL8hWI9ftTTC
vjbsPuzYDumkHgCy8MqTTwLs7DO/Iss+cnnHRUQJVqcE//ODTxXgD5WL0jwVpIIUb2F+gHqMyrBE
y35Hh/5bJdKcWjFrQnq65gXJ9PXsfFo1r3oK2kRvPGpApzWeNTsG41ymp3KelC0HSUZ/yWbeHzoS
06MwoEa5I1jMHFHA+pa1PvMAc9t2k6obTeV7ZO3YYuHTRB1rtuZNyhHMK0/y+2Oo2d61/AYvhlh2
ywrHdRWBwIbLEHiDfYuiVKg2pwwaSkf9anfaDAVc9WUQ
--000000000000ab6cf4062d9594fa--

