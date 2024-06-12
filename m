Return-Path: <bpf+bounces-31939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058F90570C
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8E52822CC
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF7180A65;
	Wed, 12 Jun 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="oe/euHPF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A91802D0;
	Wed, 12 Jun 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206601; cv=none; b=b5HnIP04RdDhpdzzgRXVLeFHcKuDWdHzW/svOhXGiIyZGhnFPHPEbetdySqwsv/iG5hKCHzXmI58aLBkGbXlbp8RP/cwDeGE48s/xyA2BuLYQrNVdYs/euauU8cEWbvBwlsKGIo9of5YcaSZLeZmRBckRHpzWAD2vuG77VajzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206601; c=relaxed/simple;
	bh=nz4BpgguzJhtHURNnoc0reqvT2I+OiSHY3FDluRV4k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvbqh8zSR4csks6p2nyvWmM2axOjfVfcHXJaoDShfjDQ1SBfgDrtBe94jmwNptQEcTThDOB2vg+CSIynzL1bT6PqcepUztx6SOo/oAbNWOgXfMXeaALBP+nret3x8p458wIIFb6lsHTs+czd2CrB519Wf0hqKL6hJBq3VltKSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=oe/euHPF; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CAms5j020496;
	Wed, 12 Jun 2024 15:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=nz4BpgguzJhtHURNnoc0req
	vT2I+OiSHY3FDluRV4k4=; b=oe/euHPFWwNhDAEh4fKrns3LLO6/u6Ero1z73Mq
	YUyZMHyqoRQz64m2omqS/4X1pHj25rtVMC3WJmDaqd+herb6bQ4Vdd7kcI7ICGAj
	3b6BLy+1t05UP89dsWzkdgfGj2EwE037+35/13juv5xVzlsnbOhNbBjI8wUBKc8n
	XhJGjg5tRERJYlWSpQjxdMhGKdAItbnT1fmvo9xXgRB8bfsKIMX+f7i9wywRvT70
	+r5WUHhOE1g6C9BOcP2YNAwucCo6XSV90iTzWNtUpv5heV9ZjJDSYwu3WlpIs+F+
	aiyazZvAFVvBFfoUWgukSBO4RmIXEU2raUKtXgNcjwwMu7A==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3yn4dffmc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:36:16 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4VzqQ73vL2zhWBC;
	Wed, 12 Jun 2024 15:36:15 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VzqQ70KzSz2VZRt;
	Wed, 12 Jun 2024 15:36:15 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:36:13 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] cfi: add C CFI type macro
Message-ID: <7oe6pz5lktdbcr2zk4ldyxzio3qvmdokjzg3rf2iwhp7wxxhbt@l5yt7d4bj7bk>
References: <mafwhrai2nz3u4wn4fu72kvzjm6krs57klc3qqvd2sz2mham6d@x4ukf6xqp4f4>
 <cwhnmpn5yvg6ma7mvjviy4p7z6gdoba57daeprpc4zcokfhpv2@44gvdmcfuspt>
 <Zmh7pIpTlexcCyOL@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmh7pIpTlexcCyOL@arm.com>
X-Proofpoint-GUID: 0MjVgrLGjuDfbvWgV2mAwRymVMf5mVyA
X-Proofpoint-ORIG-GUID: 0MjVgrLGjuDfbvWgV2mAwRymVMf5mVyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=498 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120112

On Tue, Jun 11, 2024 at 05:30:28PM GMT, Catalin Marinas wrote:
> This patch is missing your signed-off-by (the same with the second
> patch). Since you are submitting it, you should also add yours in
> addition to the author's s-o-b.

I see, thank you Catalin. I have also fixed the compiler errors.

Usually I would wait a week to resubmit, but since v5 took me a while to
get out the door, I've pushed a new version here:

https://lore.kernel.org/all/illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv/

Maxwell

