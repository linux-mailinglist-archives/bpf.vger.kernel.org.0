Return-Path: <bpf+bounces-32805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B6C9133D3
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C29283851
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100E156674;
	Sat, 22 Jun 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="SI9kfSbG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521AC14B959;
	Sat, 22 Jun 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058532; cv=none; b=t28MOtGe1ONoYZwZccZDTulIdOrPMrpsaUZ5C/vv5wj4hihuzhAzP2sEh1guOFp4hhJbUehf2DqI5KM3FKTR1LF4Vf61p00ngUuLaNSGTFS41mVj0XFb5LXwlzHfmW6U5tebFXYKobYfr27GYjzt9rWAPaWMYboV8s14VDEuqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058532; c=relaxed/simple;
	bh=105PK1tGVfazcpZ6AmPTMtk9i3q7vtDIida3kLzD3co=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=UnzHyYFiganFP+vX25Tl3yQnlScG0iLu3m7REDLs9pkA3fziVhWRPq+658aMuPVAI7Jsl6kSeEJMt1r+x8r8fzH5xMEmg4EbwitB9UvWxe3IkLyKXjxr6axVKL/yVzcmmsE/EokWnsehIoVgQJODg+YhOYHE1fXEudvlg0c2tpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=SI9kfSbG; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719058522; x=1719317722;
	bh=105PK1tGVfazcpZ6AmPTMtk9i3q7vtDIida3kLzD3co=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SI9kfSbGledeq5d5py/2Gt0+2COegXhSSqqfimQVL/cofR27x2bctJeOSM+MVeQZb
	 V/pHXv2/Gm+tykWDJ0b33PStsM6aAsm2fkgBjmh5xyBf2eLVzLPE8uv970PFK6Qzlm
	 Ok1OK9hLcH87e54iK1vsE3cvUI6kyxMpEnOePbeYN0/fgXaWi+asPmySQFgQrZIfV9
	 1KXKTx2VXKx8cNAWatrW40iy1Cm6NoLvwfNayb74U10w1eRyInYqeaCInjgFMltx4r
	 d+fBjoGmzISo9zHoPF88Ie/3EgxuHyCPIC9nGl0vx85h8iiHbtWs/vmTzszVRDkIE+
	 YxLTYONhxaHVg==
Date: Sat, 22 Jun 2024 12:15:17 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: Returning negative values repeatedly from a SOCK_FILTER ebpf prog stalls kernel thread
Message-ID: <4RZ8dWmGaDHrnGI9qP6fnpa2uTfn8K2AWmMOkikYrT8c-L_1Rym92dEjoFhoXop6lwC4C69CNVTteY6SuGg-ymq3WsJ5b64SL0r9r0jIVwk=@protonmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: b626ad89ab8a24275546d394ea2f21040ec1fa42
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_WwqneafIztgPWBETUkntUPCEflQQD6yiajOybaYFo"

This is a multi-part message in MIME format.

--b1_WwqneafIztgPWBETUkntUPCEflQQD6yiajOybaYFo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Problem is title. Attached is files for repro. Working on v6.10-rc4.=20

After doing some investigation, the `sk_wmem_alloc` member of `struct sk` s=
eems to only be increasing, presumably missing some refcnt_dec somewhere.

At a certain point, in `sock_alloc_send_pskb`, we fail the check:

`
if (sk_wmem_alloc_get(sk) < READ_ONCE(sk->sk_sndbuf))
`

Upon which we enter `sock_wait_for_wmem` and schedule a massive timeout (at=
 least that's what happened in my tests)


Please let me know if I need to add anything.

Thanks
Not sure where the missing refcnt subs are, must admit unfamiliarity with t=
he network code.


--b1_WwqneafIztgPWBETUkntUPCEflQQD6yiajOybaYFo
Content-Type: application/x-xz; name=repro.tar.xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=repro.tar.xz

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4E//CDxdADEcCO9ey5/dxln5em3RR8G4qgq6NU6nhBbG
2VtbrNAgkW+MvrnBG854yx/DSEVDHfwV2h84X2Ol3GwdMBFkICVd0Rr7cJIG++oly0LC7mcLWSvn
OLVUB4PJgwUnZ7U7QGokWIkZUxgg5K1UrvjA/DCoT+Tg6QrI4Ud3etmCU0vBoVSAPjy4i9wbgOoW
XXNz2GwhNFMRFiiysVRpM+tvBe5uLhovWohVtNep2navGsEDloGLAS6s5qtFojslpU/MTB91JK/w
cR0EPNjm0TOI3rmAl4LRlc1km0D09dOXBQ8XV67OZG3eRmRi/vijiJ5QuEs6a6M0PpzPcMPP9FAh
MxindiHHn8gEh5Ch1Of/eCo77beBj4ZyndUPk3lIO0ExOqbmvpSdSiRd75pzeWJExjbpl7xSNvWn
wurbnd/ALQub0a4VNJ2ngd0WQU0civqSvszF+wgBEAy2x1l7jz/a0NgSJU7KUFhok2QTu5YwJA2E
rq5UQT2fpVhkWfIrr0zxB5s1bs+kG0MAnB1Ov7QO4fTgiYSqM0Njb8hq20V1wMKbVunY1zYHXwaT
3MSEtuNq1eKpBSIIeqbTAfEMdNtyCmhbihZDOSZM4CDEBPgbuNQii3lPCY6bk6xXDnWbUBbKL4gh
/aLJ7B8MlMcFntLvwzEGNlj2LNPynmPEZRWLpMXJhzEmJgdFfoEOlXuEvyCYoNUYXxtzwNDF+Dn+
tPa0EYg76RBePnCNHvqbDHmzPQV2haQTydehjBhrnBJpNJa8J9eiuO+dmend+71bCHl7oPvhsg3i
qttwhIK75jYA/U2I2bEgN7b3ULtESlxY65OIpTYGh1s+hSahd0Xw261ttX5en14njh2H9l5CrhBH
RQu/DgpSoFuloEz21I5RwT7LiYf0zS+0TukUMAxwWI75E4zx9+laTEa2Z1w/L8Npx+ptkYHsscmx
jSkPyZKFivS8zwp9RIi7iw0/hs7ANqx2POMSjSWzW/6pntJqTLtKa5BHchnZKftPxczVf4pqvT23
qr0ZgtBokTCYLUmV4VSCcf3mh3pEp6X8jfhpy1xTP+xH00JgcBmlk8S0u7pbQD/lrmK4WoxpjQYX
e64yWi+YWC6oaIjs5SuubBlH/UgcQ+NVhtapS9aN7fZ+JAx7SvsJu7XGKTSDIrMzDQfpViZQxykE
RkfyR/LPATKNjncTp5KfUcaXPUpjXV92sI4HiW+MINwcbevAJJgPI7Yo9/J3etIhipzJ3Kdu9Rit
EynbVRMSMoCgego+hXXZWfKzqyVe/ih2wa67r53HMLeWzEtwym5E/U6h5WnqO0QQTIXhEmeV0Gdx
AoPweH0BsF8qGBYYsnqlod+xxcDwPeqwiW1L+PuxgRI0Q0IT0qP8wMw0lCtolmPTaP+QXEO82GHw
yFmhStt+HRgqhN47WQTNShu2BXqjCn4g0GANmVFyL16/umrk4PS1HGUhkacoD7wjhTXis70hOTht
dL75NoP6mmKfnxlhYjacR0qrAn39yXIrt6v7+aYsB0uGzbXycx6k8jnc6x8bkYxnWhr5Nw5sCy1C
4gmfy9/ZzxiDA6rjL6gY1EWPHBOwvN5fDeeIwtQ2i5VMzTTqxesgA2pM9o6A3ZUG+QIRTPtMozsr
yYoU8XiEn5eaJp+liSvfMeyid95lA8bmmShZ/149juMHcnPoemlCmxOIjvwpvZR+IaZJJq6H/Wap
p4vsw5j9TDrH9SH3oIm6bCDlkuFIE3HtfSIcg4/PGV07xhixJPrzNUUG55wYWXd9BlIcOD5550Mk
4lsSRCgj/hxuGxLNDRpv1cFbCFRf0VruejdSR8HxN6Wdw57oDAdiOAWp1rT+ZYd1WQaCbZuSkF2d
fKi6XuZzQwlrFg3jjP2nUaGsUBYxEGgoNnse2nMDzg0uLsK0aARD2vL2KBvKXbe2YGT4ZwpE7eX0
akA2ThcORIIq4mpaloYM0nRcBCeuGC2cWaYTqdIGTqye120k8fee0ORqOgm5a5tgBm0rEhelGm9s
7odeQe6002bF35nVIgyVUhhUZMCg1RjFx1SxjyGU733ZivrykWQSizLMKJ/WJV9u4UPw5+T9thsv
znCCgsZI8mCxtSkk9q4RNs1AILbVlBvUUsNOgOR2t31yyYCUbmUqqY60BMBANhu9EedvftnZt6oC
SmRwWVhEKa9fcMLC+ymC/pR7Hp+BHd+s4roc8bVxFVyU+DYxgLa+KsrsFoO9BkpRCw07afcAJxJE
svJdFTfdcTxuY5A8UoQVxQFcr3Gz+EG4OSrNx2qo7Wcvn4Um9PxQmKlvQQwhAcV20MBybBZtSFx8
xB2/s0mH5Lxnvle3i1bXgHKRcotbL+GTO2Lvj+UnffJQAkI+a1YetfEDO7ZgftunryDp0/WFufVE
qjW15SWloYA3/WgdjbC7AusmDHQOE7vFnC2hKynp131n9Qi3/hJQ3PUwxddCYJ6j7HbpDAiEE3nv
c4SHiumWH5EkjGjjZbQ3bun5FCiCvo3mCUAUOjS8m5Xzw7XuS8Lp01WBHERRnqn8Tt2f633qUXn1
r4wQa/CybEsdYnbR6XIqMXZNsZUTa23BxGBQ/RsQEuD3H2fpmKrKa4F6G+eDJjXd5iX2ktpakhsm
H6dOz9Xbir4DPGFA+ZETGTdtI9F5NNjwpISmktiFExgUOIjXVfjBO6ZSE/YspsNAJFt/ZZBc2ZFg
uMIZ9Xhwuo36TbvGB5LzCgVEY76Jh9JquV3wf37stGjjWVpmShxz+cLlRBiB8Gov5aZfpY8K1wDL
dzB/vVAXKK3PE4vGUCJ6BHZ7qKge2xQfzq6EyoYAAE8RIvTv6yIcAAHYEICgAQAHB+JwscRn+wIA
AAAABFla

--b1_WwqneafIztgPWBETUkntUPCEflQQD6yiajOybaYFo--


