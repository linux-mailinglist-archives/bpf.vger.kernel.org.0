Return-Path: <bpf+bounces-64808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A4B171A0
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 14:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBB6A80874
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591D2C1582;
	Thu, 31 Jul 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BBBp0uEZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBA1E50E;
	Thu, 31 Jul 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966685; cv=none; b=RUMnzDYQPmReJEmOrvYgTfJqxYstLHgGblPa3d4KNp2a+MdMTeCdC1km99I3EezFpRZ+SE50a9s2W6Q9NqdnvnAXGI2LLyyHfp8rQpEiwJSOjcBQmDF73QSaBJi8OlQnH8zy2QkineFnweiDcu1vRqzrtKsQWZ7Z6bk5/wxZiFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966685; c=relaxed/simple;
	bh=YgUwV9lVNl5Xl2yH5INhVfEOnOERNB8Ksx9M00CeVVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgTWXdfsWEmDphIM1lCujCPX19jEsFx7fa3yNqo8kN6yaSc2IP6n1vE/rOLKkfOL6gq17i2vzTQzywmuKJT6k/fF37djNujG8itksVPeUYbKcqO6rPMxkK8zIrm4EJhxAjbwjnX2LSev/BgTPEYcajZ9qg6P0gwoNFjpgNc/IkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BBBp0uEZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAF9Op022019;
	Thu, 31 Jul 2025 12:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UCXl25
	FD/I2+BNSmumkbpeDj3JKwHMBYCbds7n0xUNA=; b=BBBp0uEZH+T57E4laoXvSX
	04Ph1chgIjmSJmN0lgcSoNtkwu7rw6gNAj+rJg7QqFvqb0+d+Pb+O8yAzl9tdlRE
	EVryobho2alUl8TA6w4xcLXYDXpkrnkamsdVQZeCLMDJ29quFxre1MbwukrbNO0A
	nljZQQ+asgRs9X/wcEOHQQRxTC8poy+XUNDp1tF9gIhDd/k4A6u27r0n6qbr3VQV
	Rnk8TmPcqb2ppyFyGTkIanIfTQirXDCuPFGw7rzCNWOfeDXuqbstmp0ARI+PuOab
	xHnehEoYECE+mmY/WCD129U4AmKQ4XLSLZew7Cro8Y3vJfaBwPu6B/2nCAWhd12A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen2nd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:57:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56VCidAK022814;
	Thu, 31 Jul 2025 12:57:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qen2nd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:57:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56VB77wP017282;
	Thu, 31 Jul 2025 12:57:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r0ckdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:57:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56VCvWxH39059822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:57:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AF4B2004E;
	Thu, 31 Jul 2025 12:57:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A06312004B;
	Thu, 31 Jul 2025 12:57:31 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 12:57:31 +0000 (GMT)
Message-ID: <174ccf57-6e7c-4dab-8743-33989829de01@linux.ibm.com>
Date: Thu, 31 Jul 2025 14:57:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] net/smc: fix UAF on smcsk after
 smc_listen_out()
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
 <20250731084240.86550-3-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250731084240.86550-3-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F75alYSHPZTqgITt2SlGb4waf8QA0Gue
X-Proofpoint-GUID: YeaxaTg2E5e2N8EZBI3qOIABUypp26g8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4OCBTYWx0ZWRfX0YxsFdxAH2dj
 BokIFAXp7iJmaYzhJnZgZgiSVkmcX7Qi6yLB1aFW5EzEwN2HxDH/r4413HjjaHecztVTQieowZE
 avPG4vOAkQwCK1BTEKg9WqLoC/H7lYUeu5ImZOmqX8dOz+xZSeqLAFHn6bgXlbLuD7a60+bqeWd
 1MyC+PSnGAU8Aj2ovuc8aneAz/5MvDwTk2wjHekgnYhkLT7oL/tL2aAFnX8RwO1PTQb76IMWFsr
 nGzCGzlWrwTOxxhoa7Oc1uDyh2SGSdWhPCoL6a+DRDWKtFoAhGV+myUo+tAdoaBIMODpGaP7w4F
 esIG92aP5NRBi1JX28S++5m0fem+05NSh9H3boA0MtTsktfPLoplZdQKnjxnpXadaNMGSpBexTv
 LplIx3x1cjN75Pgm98LEBnrI065pKpO8jVP9VUWkW+fEO/esGoUgUhJtdy0Ol8xf+ndXQcs3
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=688b6842 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=YcmFwEUQcJPJyYZLJ3YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310088



On 31.07.25 10:42, D. Wythe wrote:
> BPF CI testing report a UAF issue:
> 
[..]
> 
> Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 1882bab8e00e..dc72ff353813 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2568,8 +2568,9 @@ static void smc_listen_work(struct work_struct *work)
>  			goto out_decl;
>  	}
>  
> -	smc_listen_out_connected(new_smc);
>  	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
> +	/* smc_listen_out() will release smcsk */
> +	smc_listen_out_connected(new_smc);
>  	goto out_free;
>  
>  out_unlock:


As this is a problem fix, you could send it directly to 'net'
instead of including it to this series.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


