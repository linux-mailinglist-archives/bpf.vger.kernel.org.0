Return-Path: <bpf+bounces-32241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EB909BF3
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B951F21F9C
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 06:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A316D4C1;
	Sun, 16 Jun 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GASTylZg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8811849
	for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718520593; cv=none; b=NiJ0YMPEBzXPuaIIOAln9m37kjpShkP64zPy7pFOnUqqm4QHE0cqMRkMxQZ7Pd37H8B4bysPplLbW2HaZoihujBTi0z54ZuK0jZcbenvKnYGzmRcSJObLAUZKRhHZ3/pwOXmTWzyJzGRLfQFpJMWRZ0EBrOgJMoe4t03jzbTTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718520593; c=relaxed/simple;
	bh=7EzzcZMeFH5QdTYyN6U+QQ5H47I5MXJ4xcIS8TuuEhg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=fyJPr0mlQpZ/rzQnIXqNuQulmuo2kD3THw9qgmc3jKIISgBEuNRcnm1NtgutKoX/C4rT6iujOydQXsqCPD5GL3LxHEaZwgkRtJRvbfdasWEIgcqRbCMrTL8aXbbmyfnAzD6lncuGXUlmviV7mxcVO7kNxaBhZTu0BIYSlTKOPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GASTylZg; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1718520575; x=1718779775;
	bh=7EzzcZMeFH5QdTYyN6U+QQ5H47I5MXJ4xcIS8TuuEhg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GASTylZgjyldfNwV3sFWzRhlCgTqesn+itnZzb9hdRUj3lsuWtm73Ylf3gRsj+i7l
	 xL8fPYcF8dOozhqp4MVmxPwx8yz0GnsiRlw54rMbDu7yCwgl1Y0rVkOw/1EPn3zgTO
	 bSuVbLV6kYzUlsV9bq3tDxVlsAux20V2g8j47g3ibfT08sRlKIJ5emslEtRFPhqpa9
	 fYjrbp5SbJdWd34z8VglOf49cmFkzPCoILb2OpH70ePab0Y/YkxAU7fOJ8TJNeTvhl
	 QnhgNjMRfva3q36AwFZt/UYqZMEADJJfnmrDnNPWATToMMlXF2EjSYu1OuJHeBnNWT
	 ScNuI7hurftGA==
Date: Sun, 16 Jun 2024 06:48:50 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: Infinite loop with JA + JCOND
Message-ID: <_rb6UwcCpRnlQuDuzb7fmzMbzQTHnFLDJfgjijmgNIDQeBxbNnmNHWrtlExYTEwiXVSfgv920x8zl-EDM0eb-oVvFgwWDizbNu0omo6UsnA=@protonmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: 2df0b026d9c50737c86635cd7f35da606dde5346
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_7p7pYnuOkfdFnCCcuDVIlENr6stGrs9cJzrJJMDk"

This is a multi-part message in MIME format.

--b1_7p7pYnuOkfdFnCCcuDVIlENr6stGrs9cJzrJJMDk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Found a program that the verifier accepts but causes an infinite loop. Work=
s on 6.9.4 (which I ran in qemu-system-x86_64).

The JA always jumps back to the start of the program, where the JCOND will =
never successfully jump to exit.

Attached is the repro files.

Thanks!
--b1_7p7pYnuOkfdFnCCcuDVIlENr6stGrs9cJzrJJMDk
Content-Type: application/x-xz; name=repro.tar.xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=repro.tar.xz

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4E//CCpdADEcCO9ey5/dxln5em3RR8G4qgq6NU6nhBbG
2VtbrNAgkW+MtdJnVhNegTcSRlsDCGunAfKhkAjN7XxpY0bGMCAYhyYhQHCTdLk4crheY/IQNIW1
DhEcR017ivmD4wlq9/oYMDKltvs3ZhyYB96eUsUVOTZdm5ZQJB9xTSRhEaZGrZ3v8Q2YxyQuXkwu
jqJYsQTAMrVJFJlWONmvJEtQZkI9fSZLam91a9Cpp0U78CK19vO+/RmV/VeLATCvAYYtaoLcGQ42
ICrRUgMI1RWYosVDdTKmnLVWknPUyyxSy2QoEjMg2Sdh0U8KgXTR84yc4jWTu6gNzo9mFSoe955P
ikPG09m+UJ3iil5fbL4fL4XbQ5liRjfkGDKiRqkTj4rsbhbFRaVeLlFZhXYfp6JC10JCSplAskUo
oARgB7lKAHxWVHBZKclyFghkGBNFmpo0mSTshadaoenPJqaMeLIy6UoMqifuaMPZ4z/ixwtXUmJK
Az263t8+4pVV0LLNAiN2u4ydH6hCMg7KAke1WJZeBkdQNZU/nIBgUWDDkcRwVuOZumlXQ9gXsrqH
pRDKXDzxPxEHFaWBafKHFyqWkQMp2KxSSPDKMDLfC3iwPAaUZfbDMlYFHyEof6vxShTvdNEvbb91
hQplcLTo6esCgXrQTEj0HG2ItDw5piDf3pXqMp6wYoDc3XaYr3GurKem0bKvMIsPSH1j+2xdUFYD
EJdxIOHTq6SP8DItFTyEPcUSbPU27d8hSKdk8ueZb6Ujb37ZHPX9YgDlYZq2XHZK2FL+1Ag2MYYp
TcwgDlv6XMdYFUKtWApV7fFU/cFNRMh4QK5ftQDOJ808qHftMf2QxLIrC2+4sN9AcBxAimK3TABq
HDdmkwTVm9tx1EEzu+DystQsmlgzmKyH0sJu9dfCGrjYShe/lK6942EvfvdVg/U9aloGFTOKA2yD
bFvm5Uw7mIB9EIjn1tEfwvD/6pcK/wBSF9++Plv0NMfjpN95h6bd5QQbZi6cZPn6YLaKTSTdPYUP
OjdYPYZ9FQAQANGoNZ3MjO0n6QB/je4KfsJ1Zp8wfngJSfQQu82yxDQBEOza0lBcahZRZj3n+D3i
WA/I6md3gLQHuQjSKoRWze+oPgyyJqLqgCU4HTWgPxfT6otwq+KfhSzX48tz4VuDqquzZjKB2qme
W9vGWoRVP+aHPrbqsFI+H7mnESoyVbfhOfy4Yaond6L8fXxOr3oZcO4z9qwfNKCKYulJSW5X3uoa
b0Y5HEIy+yDVZ6zs9hXtcOWuPv/kuhdmep31FeN53E5BjR5G2YyTCsXVTheo49qXXr2BU5aG62Dp
PLQZsvmVKzFcUKzVHX0L7DfuGId5cMZqw3mRcCYNv1et+1hIGF7beiTf+KMX4ztRBwicIKgzkNSX
V/8T12IyY+jTA4Wzjr3jWwr6nOSGueACxKIxoRgGfeKl4fJMFv5ePf95QUFGu5LD3sH4Y8pqGaIt
v5BQNMJ3BbOAoe4iks3u9k7Nrxzs5ddgcEhrjArIdu5bYOK6GGRjoQM8zanpzSCpcR7MNWS7W4o4
QHph9qd6EWr4Adt6hAZdKAc8TzJWE5u9TkqVxdaS+Ny+ggjntGyPMRoE36pI0cPeaTYONGbEFTpZ
c1FNCppPKgbwVPTgIS+NyiD9GKVSOj3GkzorjFKhhz8fhAJ4+d/0Fs4VCT0xxuow+2rTZw1hHkhP
t1FzUiyo3z9XIo+peXn0Ht51Gd5HJZ5nIsQItCA5+oJ22WZvDAZOs2I/aoweZa6WG6uJNWpqUudw
PI/VAmg+IbdcjLrvm1P0mFSvneOR7g6hijh85kJWK2OQ68VDo8/X9QUg6x9AWPYsHhk5FUwraQvt
xsrSlbE9UxIhHVzfLN5ZeB+36TDJuBX+8DAzBH69JY+CpqY7HWUtOKDGv8EM2F74AiCPGurtmOl8
Zf/frsZ3fftVbB1SPujzI0RVlYSYuewoWWqLEAHMfs7g5s2IL178sjcTB8XEq+rCU7h9Vy5868QO
I3X1otKp2SBLSYc/kkt5L9W7RUg/RVs8W9wrIsXgVjRtcUUu2+w5x7ryAMqWJpVXMAJOrMiXRq+1
kI1+4tPKorMYlQpTA9Rq6VbuNBw+rgdr4AzAF0ymkGLhME4ReCYx7ANR8+fEK7ECaS6tRsSp5Bg2
Qd1tRgh2rZF87pTsx9R3qSZgJliDnV9yqNHZmTONY/Ts9dmNBA5OOapS6E6yAJH3/f6AerbPdgt8
rEuNNissp7biR/LDTYxqTdmZzC3NEVlYOIUNVI/lyWkKIPM4pvGoe6KBESSebEVVvuikT0JYNRyM
Emi63hjgONUmECucMAB2nzswbFR5t/iNJosJBdPpQm5Kou6O+J1MhK4WgUevGi5yhkwWvmNWUuFm
V2v/5ZoSAVfHba7CX6MDYXeYSi4GMxu7MHTCxYGFu7M8ohIzE68cJJbv84vTbd53aK23xGKgr5Ck
eBIgcbJzokJfekQyZFQMufXiCejSAMvfEK7syFCyIVQZapLw4Ve+SGo4Ndtaduhmc9ov4Ru4aA54
o85jTL6gMWixx0eZrb4gjUpCP+4J0LdCmtO/cCUYdhhunQeT8W1d140VZ30AFO0SYWU6A0O7qmjT
JNEXHpxKz7M3+/S+NmG6c2FUGBECVXiEYa0e4BQc7BrwSRTkfbtsXOu/F+Lu4oAu+AzLEYgf19sJ
QH61QZK2+Zje7H/YVehU7oa5LYzxrazjwgbHe5Ah1yg+TkYipWUOAlnMlJSgy9VJQWzunGAY3XWi
rMb9I8Fs/9SY/mQAAAAAbyhevaGoaJoAAcYQgKABAOxkPkmxxGf7AgAAAAAEWVo=

--b1_7p7pYnuOkfdFnCCcuDVIlENr6stGrs9cJzrJJMDk--


