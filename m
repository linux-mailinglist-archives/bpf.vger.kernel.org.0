Return-Path: <bpf+bounces-59535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E28ACCDFE
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F1F1886383
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35CF1F63D9;
	Tue,  3 Jun 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="SR7bXy0m"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A371DDC1B
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748981627; cv=none; b=EO0umW8DtikgND49ZdoB+2hedDHhjBz0CGQMwfB60uBjzzGpAIo/YyhYkmxPCSo+Ppq74vadzriiwY+XUR+cUWQz0zoCMNVaETFgYUwn88fqqcP0eMqnsvPThZfD5zs/kNLvzDeAQ9sBXXOfi0m8TdtACDJdOMhoUCb5gBP6oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748981627; c=relaxed/simple;
	bh=uZXMNakUPzsKlE/qFDxh48B4ueXW88TdQrN3Cqrbfu4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=L1cZUY4wAcqYHIgOVnVwJpvrS8U9NWfJ2td+t2sB1gg3s00TIv80DvgVs7eJ/9p0V/AgGykT+tBvW5ohL8u/r/etSbcSSihIF7ilENzeyCfwiJSyuxRhfCgYAUUwzWu3LKhs8kQQcecFdhT+scBikutDgnWpuL0SA0nQnqgzrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=SR7bXy0m; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553Iw4ta013090
	for <bpf@vger.kernel.org>; Tue, 3 Jun 2025 20:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=uZXMNakUPzsKl
	E/qFDxh48B4ueXW88TdQrN3Cqrbfu4=; b=SR7bXy0mAjrcp2AKQ0WOegpiWtshD
	e2yN9Pc6XibtCXbWZ+bPhnYygCR/ltL+Sf2r1au2ZtxOj6NEr8opR9qZKP4CqPtt
	O0oPc7bBXhk4dADN7utOnmuxwbqEb1vjOosmQvpXCKMgjO9PWc+v6IgYcpo+RTFf
	spIJGopWVYbW8DmgWNSeazYSwGzfSvUBDVLKc19ylnLsAcu6mocoJJbdyRRDfEhp
	Z1JwZaEFl2vKQF71lTiy1pr5FmJFPp+rgPpkT179IFGb+Rr8g8rcttMbJYKLmap6
	scCJksww06oYGReKtZxXVs9Q0+uLkBpzxIIkXUY5BXU6/BYrRWRiXwI/g==
Received: from mail.crowdstrike.com (74-209-223-77.static.ash01.latisys.net [74.209.223.77] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 471g7fmhwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 20:13:39 +0000 (GMT)
Received: from [10.82.59.34] (10.100.11.122) by 03WPEXCH010.crowdstrike.sys
 (10.80.52.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Jun 2025
 20:13:36 +0000
Message-ID: <6947880c-a749-438f-bfcb-91afe7238d7e@crowdstrike.com>
Date: Tue, 3 Jun 2025 16:13:18 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <bpf@vger.kernel.org>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: Bad vmalloc address during BPF hooks unload
CC: <joe.kimpel@crowdstrike.com>, Mark Fontana <mark.fontana@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: 04WPEXCH010.crowdstrike.sys (10.100.11.80) To
 03WPEXCH010.crowdstrike.sys (10.80.52.162)
X-Disclaimer: USA
X-Proofpoint-GUID: g5v5BnFSRfW6_i-T06LydP6s-GD2RM2B
X-Authority-Analysis: v=2.4 cv=b7uy4sGx c=1 sm=1 tr=0 ts=683f5773 cx=c_pps
 a=gZx6DIAxr9wtOoIAvRqG0Q==:117 a=gZx6DIAxr9wtOoIAvRqG0Q==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=nJLdcYZiQ0tSd0970psA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: g5v5BnFSRfW6_i-T06LydP6s-GD2RM2B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE3NiBTYWx0ZWRfX+xJSR64VgvbI
 N1TLte7r83zt3MWv0d+fESiuyLj/mB/kLMC1UmP5DuRr6DUxYSqRCplpCvpjY2NdMwHyIWEXmNO
 8ADiQR4CvPEM4IE0xeKLsd0piN1xSXrl4CAZT7S99CO/GLDIE8qBCtvEUjTrdVmfw6j8lKQbcaC
 tjzU52nfq7bay+0fycipf4bGT7Hzy0e5a3YPuZQNby/usgjLGKnQQGaQ1McqXU9nnySDoHFAUDP
 utr22Mp7JT4M/xYoJs/q4Zr+uhUcYic86V/+L7TysC+LB/mZ0hgnb7kc5INqw6N5Swp3q2Oxhnz
 3UHUqWl8Fsabgj/7OQ0YkyDgbH3qLwp5I7tlhke8Cq7Yq0BRV2mc9/6NUaOcAaoaB+1VdV87zRU
 N3JLhlSEEhPrTcW92anf7uzC6oIBYsZMq2Pmp67V/ngVkSY0eaOJvfvCd1gV0+fxceEbQN6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=872 adultscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030176

SGksIHdlIG9ic2VydmUgYmVsbG93IHJhbmRvbSB3YXJuaW5nIG9jY2FzaW9uYWxseSBkdXJp
bmcgQlBGIGhvb2tzIA0KdW5sb2FkLCB3ZSBvbmx5IHNlZSBpdCBvbiByaGVsOCBrZXJuZWxz
IHJhbmdpbmcgZnJvbSA4LjYtOC4xMCBzbyBpdCANCm1pZ2h0IGJlIHNvbWV0aGluZyBSSEVM
IHNwZWNpZmljIGFuZCBub3QgdXBzdHJlYW0gaXNzdWVzLCBpIHN0aWxsIHdhcyANCmhvcGlu
ZyB0byBnZXQgc29tZSBhZHZpc2Ugb3IgY2x1ZXMgZnJvbSBCUEYgZXhwZXJ0cyBoZXJlLg0K
DQpUaGFua3MsQW5kcmV5DQoNClsgNTcxNC4wNzE2MTNdIFdBUk5JTkc6IENQVTogMCBQSUQ6
IDIwNjUzIGF0IG1tL3ZtYWxsb2MuYzozMzAgDQp2bWFsbG9jX3RvX3BhZ2UrMHgyMWUvMHgy
MzANClsgNTcxNC4wNzk2NjhdIE1vZHVsZXMgbGlua2VkIGluOiBuZnRfY2hhaW5fbmF0IGlw
dF9NQVNRVUVSQURFIG5mX25hdCANCm5mX2Nvbm50cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9k
ZWZyYWdfaXB2NCB2ZXRoIG5mdF9jb3VudGVyIGlwdF9SRUpFQ1QgDQpuZl9yZWplY3RfaXB2
NCBuZnRfY29tcGF0IGZhbGNvbl9sc21fcGlubmVkXzc0MTMoRSkgYmluZm10X21pc2MgdGNw
X2RpYWcgDQp1ZHBfZGlhZyBpbmV0X2RpYWcgbmZfdGFibGVzIG5mbmV0bGluayBvdmVybGF5
IGludGVsX3JhcGxfbXNyIA0KaW50ZWxfcmFwbF9jb21tb24gYW1kX2VuZXJneSBwY3Nwa3Ig
aTJjX3BpaXg0IHhmcyBsaWJjcmMzMmMgbnZtZV90Y3AoWCkgDQpudm1lX2ZhYnJpY3Mgc2Rf
bW9kIHNnIGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIGNyYzMyY19pbnRlbCANCnZp
cnRpb19uZXQgZ2hhc2hfY2xtdWxuaV9pbnRlbCBuZXRfZmFpbG92ZXIgdmlydGlvX3Njc2kg
ZmFpbG92ZXIgDQpzZXJpb19yYXcgbnZtZSBudm1lX2NvcmUgdDEwX3BpIGRtX21pcnJvciBk
bV9yZWdpb25faGFzaCBkbV9sb2cgZG1fbW9kIA0KZnVzZSBbbGFzdCB1bmxvYWRlZDogZmFs
Y29uX25mX25ldGNvbnRhaW5dDQpbIDU3MTQuMTMxMzcyXSBSZWQgSGF0IGZsYWdzOiBlQlBG
L2V2ZW50IGVCUEYvcmF3dHJhY2UNClsgNTcxNC4xMzYzNTFdIENQVTogMCBQSUQ6IDIwNjUz
IENvbW06IGZhbGNvbi1zZW5zb3ItYiBLZHVtcDogbG9hZGVkIA0KVGFpbnRlZDogR8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgRcKgIFggLS0tLS0tLS0tIC3CoCAtIDQuMTguMC00NzcuMTAu
MS5lbDhfOC54ODZfNjQgIzENClsgNTcxNC4xNDg5NjRdIEhhcmR3YXJlIG5hbWU6IEdvb2ds
ZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIA0KQ29tcHV0ZSBFbmdpbmUsIEJJT1Mg
R29vZ2xlIDA1LzA3LzIwMjUNClsgNTcxNC4xNTgyODNdIFJJUDogMDAxMDp2bWFsbG9jX3Rv
X3BhZ2UrMHgyMWUvMHgyMzANClsgNTcxNC4xNjMwODZdIENvZGU6IDI4IGYxIGIwIDAwIDQ4
IDgxIGU3IDAwIDAwIDAwIGMwIGU5IDE5IGZmIGZmIGZmIDQ4IA0KOGIgM2QgNTUgNWIgMGQg
MDEgNDggODEgZTcgMDAgZjAgZmYgZmYgNDggODkgZmEgZWIgOGMgMGYgMGIgZTkgMTAgZmUg
ZmYgDQpmZiA8MGY+IDBiIDMxIGMwIGU5IGY5IGYwIGIwIDAwIDY2IDBmIDFmIDg0IDAwIDAw
IDAwIDAwIDAwIDBmIDFmIDQ0IDAwDQpbIDU3MTQuMTgxOTQ5XSBSU1A6IDAwMTg6ZmZmZmFk
OTkwMTdiM2QxMCBFRkxBR1M6IDAwMDEwMjkzDQpbIDU3MTQuMTg3MjcxXSBSQVg6IDAwMDAw
MDAwMDAwMDAwNjMgUkJYOiBmZmZmZGVhZDA1ODI5ZDgwIFJDWDogDQowMDAwMDAwMDAwMDAw
MDAwDQpbIDU3MTQuMTk0NTAwXSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmZmZm
ZmMyMjAwMDQ5IFJESTogDQowMDAwMDAwMDAwMDAwMDAwDQpbIDU3MTQuMjAxNzQ5XSBSQlA6
IGZmZmZmZmZmYzIxZmYwNDkgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogDQowMDAwMDAw
MDAwMDAwMDAxDQpbIDU3MTQuMjA4OTc3XSBSMTA6IGZmZmY4YjkwMWJiNDAzYzAgUjExOiAw
MDAwMDAwMDAwMDAwMDAxIFIxMjogDQowMDAwMDAwMDAwMDAwMDAxDQpbIDU3MTQuMjE2MjA2
XSBSMTM6IGZmZmZhZDk5MDE3YjNkNWYgUjE0OiBmZmZmZmZmZmMyMjAwMDQ5IFIxNTogDQpm
ZmZmOGI5MDBhMGJkZDgwDQpbIDU3MTQuMjIzNDM4XSBGUzrCoCAwMDAwN2ZmNzY2ZGE0YzAw
KDAwMDApIEdTOmZmZmY4YjkxMzdjMDAwMDAoMDAwMCkgDQprbmxHUzowMDAwMDAwMDAwMDAw
MDAwDQpbIDU3MTQuMjMxNjIzXSBDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDog
MDAwMDAwMDA4MDA1MDAzMw0KWyA1NzE0LjIzNzQ2Nl0gQ1IyOiAwMDAwNjAzMDAwMjYxMDAw
IENSMzogMDAwMDAwMDFiMzQzODAwNCBDUjQ6IA0KMDAwMDAwMDAwMDM3MGVmMA0KWyA1NzE0
LjI0NDY5OV0gQ2FsbCBUcmFjZToNClsgNTcxNC4yNDcyNDVdwqAgX190ZXh0X3Bva2UrMHgy
MDcvMHgyNjANClsgNTcxNC4yNTA5MjZdwqAgdGV4dF9wb2tlX2JwX2JhdGNoKzB4ODUvMHgy
NzANClsgNTcxNC4yNTUxMjJdwqAgPyBicGZfdHJhbXBvbGluZV82NDQyNDg5MDQ2XzArMHg0
OS8weDEwMDANClsgNTcxNC4yNjAzNjFdwqAgdGV4dF9wb2tlX2JwKzB4NDQvMHg3MA0KWyA1
NzE0LjI2Mzk1NF3CoCBfX2JwZl9hcmNoX3RleHRfcG9rZSsweDFhMi8weDFiMA0KWyA1NzE0
LjI2ODQxMl3CoCBicGZfdHJhbXBfaW1hZ2VfcHV0KzB4MmIvMHg2MA0KWyA1NzE0LjI3MjYw
OF3CoCBicGZfdHJhbXBvbGluZV91cGRhdGUrMHgyMDUvMHg0NDANClsgNTcxNC4yNzcxNTFd
wqAgYnBmX3RyYW1wb2xpbmVfdW5saW5rX3Byb2crMHg3YS8weGMwDQpbIDU3MTQuMjgxOTU0
XcKgIGJwZl90cmFjaW5nX2xpbmtfcmVsZWFzZSsweDE2LzB4NDANClsgNTcxNC4yODY1ODVd
wqAgYnBmX2xpbmtfZnJlZSsweDJiLzB4NTANClsgNTcxNC4yOTAyNjNdwqAgYnBmX2xpbmtf
cmVsZWFzZSsweDExLzB4MjANClsgNTcxNC4yOTQxOTVdwqAgX19mcHV0KzB4YmUvMHgyNTAN
ClsgNTcxNC4yOTczNDhdwqAgdGFza193b3JrX3J1bisweDhhLzB4YjANClsgNTcxNC4zMDEw
MjFdwqAgZXhpdF90b191c2VybW9kZV9sb29wKzB4ZWYvMHgxMDANClsgNTcxNC4zMDU0Nzdd
wqAgZG9fc3lzY2FsbF82NCsweDE5Yy8weDFiMA0KWyA1NzE0LjMwOTMyNF3CoCBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2MS8weGM2DQpbIDU3MTQuMzE0NDc1XSBSSVA6
IDAwMzM6MHg3ZmY3NjY3NzliNDcNClsgNTcxNC4zMTgxNjRdIENvZGU6IDEyIGI4IDAzIDAw
IDAwIDAwIDBmIDA1IDQ4IDNkIDAwIGYwIGZmIGZmIDc3IDNiIGMzIA0KNjYgOTAgNTMgODkg
ZmIgNDggODMgZWMgMTAgZTggZTQgZmIgZmYgZmYgODkgZGYgODkgYzIgYjggMDMgMDAgMDAg
MDAgMGYgDQowNSA8NDg+IDNkIDAwIGYwIGZmIGZmIDc3IDJiIDg5IGQ3IDg5IDQ0IDI0IDBj
IGU4IDI2IGZjIGZmIGZmIDhiIDQ0IDI0DQpbIDU3MTQuMzM3MDI5XSBSU1A6IDAwMmI6MDAw
MDdmZmY5MDU4ZjNkMCBFRkxBR1M6IDAwMDAwMjkzIE9SSUdfUkFYOiANCjAwMDAwMDAwMDAw
MDAwMDMNClsgNTcxNC4zNDQ2OTVdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAw
MDAwMDAwMDAyNzUgUkNYOiANCjAwMDA3ZmY3NjY3NzliNDcNClsgNTcxNC4zNTE5MjZdIFJE
WDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDA3ZmY3NjZkODcwZTAgUkRJOiANCjAwMDAw
MDAwMDAwMDAyNzUNClsgNTcxNC4zNTkxNTZdIFJCUDogMDAwMDdmZmY5MDU4ZjQwMCBSMDg6
IDAwMDAwMDAwMDAwMDAwMjAgUjA5OiANCjAwMDAwMDAwMDAwMDFhOGMNClsgNTcxNC4zNjYz
ODddIFIxMDogMDAwMDdmZmY5MDU4ZWM0OCBSMTE6IDAwMDAwMDAwMDAwMDAyOTMgUjEyOiAN
CjAwMDA3ZmY3NjVmYzQ3NTgNClsgNTcxNC4zNzM2MThdIFIxMzogMDAwMDAwMDAwMDAwMDAy
OSBSMTQ6IDAwMDA3ZmY3NjVmYzk1MjggUjE1OiANCjAwMDA2MTkwMDAwMDBhODANClsgNTcx
NC4zODA4NTFdIC0tLVsgZW5kIHRyYWNlIGU2ZTYwNjZlYTdlMDkwZmEgXS0tLQ0KDQo=

