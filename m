Return-Path: <bpf+bounces-57903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9317AB1BF7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD00517E760
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9023BF8F;
	Fri,  9 May 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Ujty/sTB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F850221555;
	Fri,  9 May 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813850; cv=none; b=T/lGgdby1xjjGc6D+grBjE/FXpX4pVQ5iRMpCA+exDJbEyKzYFTjVc7Q6kef1P2mP5z/SAf1RB70ASd+OswSVCfHTjka4lLR3VP/x35kxdfAKZsyNrQ3316wA+zE7o5dsxN4DGvwQZMkNTLAKOT4CJ1rKOabxCUh0KaboxI0noA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813850; c=relaxed/simple;
	bh=JCx+YKX27VH7iS35r9Ygz43X7qVTl9DIxDIIM7uqJRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+mXsAzjIES1JwGVVLBeE7RHsBDs95VaXUJurXHBz4Vc3Kg1T87NEtalh0yAUCYPGy3ZocFH/agJ6nZ+Hmhd1BloLBb/npQexKk3u/X5Vmbdkm3silcFgU4mYbarmOVMLkrZHhz/kEYxb624hRpU6agLw44EtrYbQViyq/aHWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Ujty/sTB; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5498qK61031439;
	Fri, 9 May 2025 18:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=8TqIGxRNcE17sBdZAJDFnb0
	1+U1SAEShOq+/byms6Ps=; b=Ujty/sTBUEug2fI3PuqWzJFvut+cRB5KIczHX9O
	3PGajOVOIsW/0p5ce9qncsbK9TfUbw0N9lw27SR0N0FsGMLnHjSjOSKCDXx4cuxt
	bv6G7/OtdgfhpykPRtXYNlbwydtYltNMKvvWLsPjYWy8CN9eF8fgcgZP70xdHfvf
	mhpX1KyUaV5Rbd+vC2kb8dzJg/qsF7JcIdp8kMV78pmPRhgN9hq5iRyw+I+63R4K
	hcEXkH5EtnoedTQyaYq9LNoIS7gWbubrYDfH/xaLjgOcimJLnK0TiQig7ToNlGTz
	jDD+ObWgb83Nv32gKpFpuaOwCxnwX5ZMBPRqjaAUwWUlx3A==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 46gn1y5ax0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 18:03:39 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (unknown [10.62.177.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4ZvH1Q46Bmzxd6r9;
	Fri,  9 May 2025 18:03:38 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.11.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4ZvH1Q1zp1z2VZ18;
	Fri,  9 May 2025 18:03:38 +0000 (UTC)
Date: Fri, 9 May 2025 13:03:36 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH bpf-next v9 0/2] Support kCFI + BPF on arm64
Message-ID: <bxmdpg6frmhdw23ktemguglrdwweyibn2vuauc7gs7txt5jvkv@47en4a643bb3>
References: <20250505223437.3722164-4-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505223437.3722164-4-samitolvanen@google.com>
X-Proofpoint-GUID: 1xkmKuqKs1BUOucwNZPrkA4H-1kBsQRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE4MCBTYWx0ZWRfXwKeEPUGvNJ4j
 z8vD2PD/auKSZS/8nudNn8hS66ir8bE9q5lDa80VfAH4uv4jovG61yxcMf60KjrG501r263Ota5
 TGDAd2WX0n1UdQab9hwHprOCGa1DdIJQKJLzyBSXwhnPmWnQ2g4su6QaG08npfYd8VpD6XZYzeV
 7ojjM4vxgWgFj0vL+NDzbPi61+RIpFMxlgXukkZH6+wZw3VZ1Y6FeLjODOzK7fLtRPCI8VRLi7Y
 qUNRIlJQe1q4iQzQgBGUU/WWb8iwMwowXCWqucq7l0bAR8kIatWPH5dxq7uhOJnMlS+LV6XyVsa
 I7IKBS6Qm4xRHCvN7FJr3A4dO+hHbcOLz0DpD0DOGeK3k4/GAu5q7+L5jQKDVHPm2zfY/iiCjlC
 opfSrxrqPsTAqgETd0KsVYUc8+bqSDpwjEJ/h4My3/9+0B97O38dkbuyf/HL4sT52S3Nm1/Q
X-Proofpoint-ORIG-GUID: 1xkmKuqKs1BUOucwNZPrkA4H-1kBsQRa
X-Authority-Analysis: v=2.4 cv=EMoG00ZC c=1 sm=1 tr=0 ts=681e437b cx=c_pps
 a=7qI18unSaIz3cJfMvNS4Ww==:117 a=7qI18unSaIz3cJfMvNS4Ww==:17
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=Id0hMdnY8LVrUxL_22cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=950 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090180

On Mon, May 05, 2025 at 10:34:38PM +0000, Sami Tolvanen wrote:
> Hi folks,
> 
> These patches add KCFI types to arm64 BPF JIT output. Puranjay and
> Maxwell have been working on this for some time now, but I haven't
> seen any progress since June 2024, so I decided to pick up the latest
> version[1] posted by Maxwell and fix the few remaining issues I
> noticed. I confirmed that with these patches applied, I no longer see
> CFI failures when running BPF self-tests on arm64.

Bump! Thank you Sami for following up on this, hopefully the maintainers
will have time to take a look!

Regards,
Maxwell

