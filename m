Return-Path: <bpf+bounces-27000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2F8A735C
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 20:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D9E1F22667
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B01369B9;
	Tue, 16 Apr 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="HVr4rvQ/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6F2D60A;
	Tue, 16 Apr 2024 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292810; cv=none; b=LtFNpdxDGx/E7fs5hfFB56gG1Jy6RJk0qM/imeIKT3BaLqQkNEkwVdnlC54zYTU5KkWkxc58Cqx50NSns9xcRnhnIKxy8/pczxpEo0JWH4JwvlzevClQqPsNNwoeoDdtVJp0XmIHkFpoI876QtwNLmoykxvBk4WGRS6O2T7JYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292810; c=relaxed/simple;
	bh=s8oqw/n7tWvAIfHbgC5Y8kcQzZvxalGMqNe9yNc3GQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=syyeLsSwmeT95TfRwhPimh778wozKhuPEm7MeHJQuVNkffevwKVM6yqib9O/KQYt5VKdHjLymC3cCnuxqqbhguAvZfTOLhmnqClG6VrdquaFZtvnEwtk6IMBHfXiAoKXnSA4uGDtV3qcQI4zvjMdE9bKWFGt93L47sT4c/QJicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=HVr4rvQ/; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GIYKGm018603;
	Tue, 16 Apr 2024 18:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=s8oqw/n7tWvAIfHbgC5Y8kcQzZvxalGMqNe9yNc3GQA=; b=HVr4rvQ/Q3H7
	tNxcc0E0j3S/Hsu/ybiQt1JVCxJUQmQ0J2U2chyAnw4Q6sXl9W8hAP8oAhZ/eoiP
	1hqzMBkw8B+jDp7EAUK6uRmtofDwFK8oAC8dTE9U8A/sGAJkG5uj0CczWJ1Thul6
	C9sJCbsHqUd+Prth7FzOJ0fakCUHkJxR5cBtQOexk0r0AOrG7xtxwbeQcjST6SRw
	GDFR/rctPx3MegoXDLl9W7NBWLgt0OibEG8a5b94sBUIbla9OS8ra3s3qNW8pBnW
	CEDug02/pZvDP0xPc0xtxqoKhmc3z8dJsai26bpZNldrZnz3/n79KoGg+AiRR+2e
	GXS8hjo5+Q==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3xhxqp80fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 18:39:53 +0000 (GMT)
Received: from [10.82.58.126] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 18:39:51 +0000
Message-ID: <39ab4c5a-7074-42ad-9eea-773d4bb76bce@crowdstrike.com>
Date: Tue, 16 Apr 2024 11:39:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] bpf: clarify libbpf skeleton header
 licensing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20240415230612.658798-1-martin.kelly@crowdstrike.com>
 <CAADnVQKfo-s4vXopJJ50Q4KP-mPKCbOc_8Pwz9u=uUn2=NU1ww@mail.gmail.com>
Content-Language: en-US
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <CAADnVQKfo-s4vXopJJ50Q4KP-mPKCbOc_8Pwz9u=uUn2=NU1ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: 04wpexch16.crowdstrike.sys (10.100.11.106) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: Ihn54yYzjdyJukZA8YG74zn1wAOOI7Mu
X-Proofpoint-ORIG-GUID: Ihn54yYzjdyJukZA8YG74zn1wAOOI7Mu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_16,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=665 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160117

T24gNC8xNS8yNCAxNjoxNiwgQWxleGVpIFN0YXJvdm9pdG92IHdyb3RlOg0KPiBUaGUgZG9j
IGlzIGNsZWFyIGVub3VnaC4gVGhpcyBpcyB1bm5lY2Vzc2FyeS4NCj4gT3RoZXJ3aXNlIHdl
J2xsIHN0YXJ0IGxpc3RpbmcgZXZlcnkgcHJvamVjdCB0aGF0IGJ1bmRsZXMgYnBmIHByb2cN
Cj4gaW4gc29tZSBmb3JtLg0KDQpJIGZpZ3VyZWQgdGhhdCB3aXRoIGxpY2Vuc2luZywgYmVp
bmcgZXhwbGljaXQgbmV2ZXIgaHVydHMsIGJ1dCBJIHRha2UgDQp5b3VyIHBvaW50IGFuZCBh
bSBoYXBweSB0byBkcm9wIHRoZSBwYXRjaC4NCg0K

