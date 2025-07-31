Return-Path: <bpf+bounces-64807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B87DB1718F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 14:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD88A822CB
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43D2C08CF;
	Thu, 31 Jul 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GR1me3hd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FB1E50E;
	Thu, 31 Jul 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966425; cv=none; b=X278fBs1EEC3dOma+qrflpOlSTQPgYCq6EZRheC5hC3W5YFFVNepANemTPDXe5dIrA2m9KErv0JEEeT2EwAO5B1gOLGjE1AFRW/Lhf2gAhTVCjyHT43Y0NeIziBOTSzXyaIH+i//Tdc7a8CPp36jBBZ51qqdn+5f4kq0Udgh0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966425; c=relaxed/simple;
	bh=s4YdXOtKR27UpYUWeQeXa6d3+zCAUyQ9i7IHE8ZOwWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDGpkRvPvOsT9oirPejSgbphcMIvIQz/bUAd1BOka4yG7XGfpu0KkL5NA5zNES71EHAowi7VnLSVGJ20/QTYbg5Z3aNzpB5LLefBpI8r7FI4xCnBxx40+78XviegGOsqAaX/xMRBMRKlnhjdEdGXA9KCM0ER+wAm0v8VXmEmFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GR1me3hd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V8hlKU009401;
	Thu, 31 Jul 2025 12:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s4YdXO
	tKR27UpYUWeQeXa6d3+zCAUyQ9i7IHE8ZOwWA=; b=GR1me3hdYnbeVBiHO75PDs
	y6MyeYO8wDHQ5txCTlPe44kzjIX4Mom+Hucs4jeQXQh7kSMkRVlcLmt8E7UTSKYj
	bnUto+cpt4F+Lt6C6WBYzK1HQnXr21r2bcEfLd04I/w7cxJIqqLR6vnYkSGPTSA1
	/LTSYVsvd1wYCLZodJdcmEEnIeUsVOVbtKnxvO0kiX8ZRntw38YPT58KxhwaSVEl
	r7Q0YWf1eGKOgAjUVnsiFFMVDBCBnTJQ7jFHQV8dQwhqb36j8ty/BEVrlRsu2jhb
	VuBToFzNSGk2SwFU6bBGiR1EF1AdOb5uH7R/amXWoJvm0kOW04QBSea+IvRuuVfQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgapvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:53:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56VCaLUb018698;
	Thu, 31 Jul 2025 12:53:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgapvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:53:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56VCgQa1006242;
	Thu, 31 Jul 2025 12:53:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjmc96t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:53:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56VCr9KV56295902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:53:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6219F20043;
	Thu, 31 Jul 2025 12:53:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 013E120040;
	Thu, 31 Jul 2025 12:53:09 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 12:53:08 +0000 (GMT)
Message-ID: <62dbceb4-caaa-4f49-a251-0e2143cd90ac@linux.ibm.com>
Date: Thu, 31 Jul 2025 14:53:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/5] bpf: export necessary sympols for modules
 with struct_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
        yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, Mahanta.Jambigi@ibm.com,
        Sidraya.Jayagond@ibm.com, wenjia@linux.ibm.com,
        dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, jaka@linux.ibm.com
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
 <20250731084240.86550-2-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250731084240.86550-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4OCBTYWx0ZWRfXzPkfWdTkOuI9
 s9FAy8/mdlGjzibI2YzUHAPq0IZfIH0O4rOs+5P6WeUsjprp/Kr7I8DAZ3fOGmgpWT/1noLORK9
 MQ2S57U9FLHEXZskOCf502+6qjS04dL1q/br5Us+6ys8Xnx0EVswT82uwYHK4xm+dJvElL4GQms
 oWX5yMWXcKdBVY7SobSQNwBTzUGm8PeIQUadIzNUVURlHWxOXq4YArslXNXRkPGMmDrgs2N0DWP
 rCU5AE0vL5FeAf9hihIRfKiQh7ukq0ZpaPmQeQ6wqM7fuXD5QGl7jc3REl8xyGgPP22ZOspLRrM
 YxH1Qj30a5IAsZaP47/Iok7r9zh1qZrxSkxYhc3CARNsnaPp4cyYLmgFTtRwE65EJzNi9IDzoEN
 CJtHtvoVtcLEtec4nYykf4zU3dgnIuOZ1CVCv0C4MeoxJk7moZ5gUDWPu4+skVjeqWXTYamj
X-Proofpoint-ORIG-GUID: LZG7dvTOEJj1J0AeG2hphw1UoqmWR8FF
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688b673d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oj6qtssYHHDMG0MRSskA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vRYlUuW1GGuYRwxkXfUENMSboo81WiXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=446 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310088

typo in commit message title? s/sympols/symbols/g





