Return-Path: <bpf+bounces-59235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA51AC75F9
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB984501054
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A38A246760;
	Thu, 29 May 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e4tGWPIV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2338FB0
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487420; cv=none; b=Rs4uZszaliUSYmSVXKZ1wErbQyglCGiOTJ05SsUp+2e40Z/Ma14rtSXne18qiEiTYBa17yzRCW4mXDtUMtDv9gmlDBQCOowT/Le5RJ2j2F2k49RgL/uTAFPu3mmcN0DuxIYGrBsY87lNEZcomU1NpCJw0kM7OofhwHL/kD48dbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487420; c=relaxed/simple;
	bh=vaJXUKsyM0c5xRymlRlB1MLESXc77PaDS6DIb74RXTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnQy62AmYKhWwcC+PyukRrur9NqHGbf3Wqf1VPCLpVseDYoO6doen4yPnNgf/bOI/jfPuqw6VR14UNoRBqV9f1kCHEsTGbsdo3UnsNdGIQZavCN6j0vTsoFtqJrbvwrrWUBesPaEZ0T3ue/YT4fkFC7Cv0+TWzWt+PgZiGWC664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e4tGWPIV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-312116d75a6so355286a91.3
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748487418; x=1749092218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AR8CnkXBx2g52uwk72Ruza8EieW3IFdM2Dj4MNzA0VA=;
        b=e4tGWPIVyoOrNKexW/EExjlIVEJnl3dpOe6W92Yqu8mIfPh6OIg1PLRzwBnwSh4j4j
         oYQfg+YId2xcMQVSeYUovST/5blo/nKOC3tVrhOsBHTlNvIiuxVGejEPOaYOpRqDCiNc
         jUJ7hc8UrUGmP/7slLLyD0SV2/7hox4/9ryaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748487418; x=1749092218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AR8CnkXBx2g52uwk72Ruza8EieW3IFdM2Dj4MNzA0VA=;
        b=HKG5BXLzuCaebphx4mQy607cWpQdiOJUrOcGqaHvl2grFcx1shEtwzt81YSWnLUy4B
         Rpyt78RX0JsE7anqrLn06GNIXAg7mBnhjAHgGnCKjtiWw5Ph8LJRRjio9ecS/2uDwbUy
         2ZzZf7kNDEbCUj9zbJgBzsZk8BR4kVUDgQD3PrqVGp7J6ZzBkF1fjwvepDiEDVWlpq5E
         Vj1tzMSHc5V6AeLOtPc7t6YMU8j83AwbtCOdu1TB9pfr2zuwK9+GFsZA1C052b+1VbMB
         45dNjhX6ETsQL4ZGPkWgGids+T8Xw5doYFX6IhoZhqvkVCJ5rAUlpfG0dM83TUYIK5fk
         aZMA==
X-Forwarded-Encrypted: i=1; AJvYcCXanzomzKJ5w/Eb/8ReU/pM8M+pzt8XIu0587SUqgyiW6zHXACl/NE3dpZHj+qIiTQ89EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+avUMm/hcVjWa5GV5WJczW2cHuSDdG+l6vEQE7rBKcSFYVkb
	DVAYay3vZNW3uPcjB/ZV2/fspkwcJ3DHU7yMEpiIwxZlzAw2rCuB94xTmoJr7SbDll/eL0/EFok
	ovGkoPzggt70V5I+MrM7GqI3QGyXubpilv3gFIPCb
X-Gm-Gg: ASbGncvusmdGCtoyw8KP45qquv0xpxLTeQYOJREKqxPCJWdIBDAQivOcDNDY4E7viAK
	6D+xqrfwmH0zjjwemCUF9BzEOL+Wln7t8MR1FICI33l7oJfdK6ZIjzn4tSqNtoiHs869GDzXkMC
	Q0xqAVOD94pmPxjEiaqhCBNMkylW7LjH4TTQ==
X-Google-Smtp-Source: AGHT+IFuGPXAClT9ED5vKwdCpxiy4g+H/pyfvH9nuikO/EisHRGYk+JJweLUS9BYUjAslq3NHNzA9gx5OAhyDWW3Lj4=
X-Received: by 2002:a17:90b:3e81:b0:30e:9349:2da2 with SMTP id
 98e67ed59e1d1-311e73db541mr7138078a91.4.1748487417932; Wed, 28 May 2025
 19:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
 <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com>
 <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com> <CAMdnO-+HwXf7c=igt2j6VHcki3cYanXpFApZDcEe7DibDz810g@mail.gmail.com>
 <7ac5c034-9e6d-45c4-b20a-2a386b4d9117@quicinc.com> <51768fa6-007e-4f30-ac1f-eed01ae1a3c5@linux.dev>
In-Reply-To: <51768fa6-007e-4f30-ac1f-eed01ae1a3c5@linux.dev>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Wed, 28 May 2025 19:56:44 -0700
X-Gm-Features: AX0GCFs7nO7Ek5qGHccnCOiDAB6gA5K5glWzqriW3_xcRyt9xcpYHgFycts9UYs
Message-ID: <CAMdnO-KNfH79PG1=21Dbyaart2JN_e1XcF+tTG93BG5BobX+Gg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for BCM8958x
To: Yanteng Si <si.yanteng@linux.dev>
Cc: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, Andrew Lunn <andrew@lunn.ch>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	ahalaney@redhat.com, xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, 
	Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000075ec8206363d7374"

--00000000000075ec8206363d7374
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yanteng,

On Wed, May 28, 2025 at 6:36=E2=80=AFPM Yanteng Si <si.yanteng@linux.dev> w=
rote:
>
> =E5=9C=A8 5/28/25 8:04 AM, Abhishek Chauhan (ABC) =E5=86=99=E9=81=93:
> >
> >
> > On 2/7/2025 3:18 PM, Jitendra Vegiraju wrote:
> >> Hi Abhishek,
> >>
> >> On Fri, Feb 7, 2025 at 10:21=E2=80=AFAM Abhishek Chauhan (ABC) <
> >> quic_abchauha@quicinc.com> wrote:
> >>
> >>>
> >>>
> >>> On 11/5/2024 8:12 AM, Jitendra Vegiraju wrote:
> >>>> Hi netdev team,
> >>>>
> >>>> On Fri, Oct 18, 2024 at 1:53=E2=80=AFPM <jitendra.vegiraju@broadcom.=
com> wrote:
> >>>>>
> >>>>> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >>>>>
> >>>>> This patchset adds basic PCI ethernet device driver support for Bro=
adcom
> >>>>> BCM8958x Automotive Ethernet switch SoC devices.
> >>>>>
> >>>>
> >>>> I would like to seek your guidance on how to take this patch series
> >>> forward.
> >>>> Thanks to your feedback and Serge's suggestions, we made some forwar=
d
> >>>> progress on this patch series.
> >>>> Please make any suggestions to enable us to upstream driver support
> >>>> for BCM8958x.
> >>>
> >>> Jitendra,
> >>>           Have we resent this patch or got it approved ? I dont see a=
ny
> >>> updates after this patch.
> >>>
> >>>
> >> Thank you for inquiring about the status of this patch.
> >> As stmmac driver is going through a maintainer transition, we wanted t=
o
> >> wait until a new maintainer is identified.
> >> We would like to send the updated patch as soon as possible.
> >> Thanks,
> >> Jitendra
> > Thanks Jitendra, I am sorry but just a follow up.
> >
> > Do we know if stmmac maintainer are identified now ?
>
> I'm curious why such a precondition is added=EF=BC=9F
>
It's not a precondition. Let me give some context.
This patch series adds support for a new Hyper DMA(HDMA) MAC from Synopsis.
Many of the netdev community members reviewed the patches at that time.
Being the module maintainer at that time, Serge took the initiative to
guide us through integrating the new MAC into the stmmac driver.
We addressed all the review comments and submitted the last patch series.
Without an official maintainer, we didn't get feedback on the last patch se=
ries.
Because of this, we wanted to wait until a new maintainer is assigned
to this module.
As Abhishek expressed in his email, it appears the HDMA MAC is
becoming more mainstream.
We are hoping to rebase the patch series and resubmit for review if
netdev team members show interest.
Thanks,
Jitendra
>
> Thanks,
> Yanteng

--00000000000075ec8206363d7374
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
qbYyUkmCmuoLi5GXFMJy+iQv6DgMVQ7CACagybU6FUrmL9lVa+A6caBEEh4xggJXMIICUwIBATBi
MFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9i
YWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwYdforFgrdZbZjKmswDQYJYIZIAWUDBAIBBQCg
gccwLwYJKoZIhvcNAQkEMSIEIJJrBufWxV0R5MKdjS9jr6tsiQnUVV3R8QR2g1VJDeHEMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUyOTAyNTY1OFowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAJ/e0uKX167
Lh7qfbb/jrbXZ9YVUefyEoOhgnSSHxT+DukeUlQMd87hARBnskep0C/AFnI098yqX5IH1Quqv91v
bGt756coz020oV19OCFtRBb5SAVPGptH4OorY4BJoLc/h7u2f/3jpZVjnkXNAjXUmLymLa+4SfPW
Okn+t+uGoxF41yHNAVSzRNjSnqadTZya6FrZWoW3LxBdjhv4Eq/ijnCOquwG55DxqLyXqzAJmmqj
xpIZASNxb5GqZxQ/1NfOmKqWhnBQa6FrSWANF2DVPI6ZEBYor5jo1ueZxqdEX5qReRzG0NPIy5Ro
bmvTAMp6U2bE8F3h/txFAa148oc=
--00000000000075ec8206363d7374--

