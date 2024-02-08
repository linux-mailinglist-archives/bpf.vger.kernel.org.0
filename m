Return-Path: <bpf+bounces-21542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEC84E966
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10737B25148
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD46383A1;
	Thu,  8 Feb 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kRB12En9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B9pdvMzw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF738395
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423084; cv=fail; b=UbyysuW2LdBTImrswZ5CD0hiS/SwMFmri2XeCPdpC6/casQWgStw4v2Hl+1BYf7HIuJYzBdxpJ6eoXXqedSoLi3Rx5x1Bhdg121YsdAi0JxdKN4+U25wh2c8hxSfwejSOcbpXJhAh9sQnf0trUKU9lMnZhXce4AlYpzHq+gwRpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423084; c=relaxed/simple;
	bh=C6k5tP1hxm++VDPVhp7ZMEvnknYjW4NVJq7UZNlGsm8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=P/sflyjL2Hd/oe3S6zFQOfyfFcjA9Dy6tRUknmoY6nWObvi3tpXJ/uLEZfwakuyd6b+NktB6Anwvn4BX24x3mneRW693yrAfayAVUKl3TJhVlTHWs4FJLUWmsAW+CvCDP3xsn9OzMNVOZNxkgTuUGVgIn4uGD+oq3a1NF/8wPqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kRB12En9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B9pdvMzw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418JnSAl008246;
	Thu, 8 Feb 2024 20:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RtHqhKV1WiLIfQKHXSnWYeMkOxL87IPbnJV3GJ6If0w=;
 b=kRB12En9+C7IBrdIC4xniy8fgqCKp8tSLpy1E+o2/uF+DB/+yhqKCoCy5+D+YGFMu6QG
 KIDqffq2xpfj3iz+2GTf3MwWj8uNYpss7HYAywJAQHvoDqesUQuchgGageKVZcop3o1Y
 b3TUkIG13zc+NMdMvLB49SjMcDu+QR53byYHjr+iYQDff8j9bENpgnG4qQmA8MmDXGH9
 injQUlIpgvh3OIJ/rmfcJxNPeDB8+pOdud8nGZII/4ioUXQr6NnWbNL4Jj2ttA+MZiYx
 httAA+bFVKoWnrK3xX8SeRT4MB3CLVycU+3UzUtmry7QpC3mHO9pk9/B9G1mGWyjj4py 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd5t1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 20:11:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418JQv3v038427;
	Thu, 8 Feb 2024 20:11:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxb6eu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 20:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA3MuxRy9fdlJRRKIxyQJcyKkwUcNAKYTINGN5A07DxXBdI0ffemjHMOggBxq4L3DuLaSeypUvfovwstF8eEFk6N9sE80/ivHDXUjMRuFv2OsqR4CBBxCHjq3oBFXbZ/pxLIPuw9TjXlerMhH7JqOaiYs3pPHuLsf0QPGTmjlw52P0uXzJ0HAHAORk/kIDx2PZx6Ccj4A6DyZ6kRUvFxaewvXmtunyamxYGd/jXYx9dz/+PeSbSoCzYc91vh20rbj6izbgbFKYz9a4KE7/Qz4UW6Xj+l5EquYGhMM8ArRzw/uCLly0volH8O+eIuPQdI/1vKmrCw3amLo7yi4teCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtHqhKV1WiLIfQKHXSnWYeMkOxL87IPbnJV3GJ6If0w=;
 b=kcLuXrgNP0RXu+bCc5PfkCkffGGj2Jz2WSr/LTPs6IBa6lkoOWf1kdM8xgivLxkMelGnVpTVspHZ9lekdQoq9OmiHeJ4DMPlSTowRVTpX2lqVhJNhNdWE/PBlnLtkaiPUlL+qz/sRt5aldpnsoA2/9q4+0ErFfQfWv3nInsKkJhorv83BNa2DEKt85+LoyCjCLNWaGs374ICeV+7HHI40mbkhzaYTry6AGYDFhGweO1K8+NUpb/r7mIi/2r3R/raURo01EyQjQGDHS2Vi0IAa5GF4NIbo0fBT5M7Pl1MiiFeazigsLtxWbIOjMZ3vMXD+4oexBFVJ3aIyFZJiL206g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtHqhKV1WiLIfQKHXSnWYeMkOxL87IPbnJV3GJ6If0w=;
 b=B9pdvMzw/wZ0s3Uc33zw83fIVQigm0MlVIWs6yYlTSK/7HqaDEtzkpOQpAitZBfvxit8NsX87p0CcOUDzoGA5OdgGyDkNTCy85/IObPuXB7WNrGWw6MnKOaUEv88RKrpqCFmxwqUkDslA7T8Tj41Ke+cuehvo2T+AdWIs0CWf+w=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 20:11:15 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5252:c588:583e:7da6]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5252:c588:583e:7da6%5]) with mapi id 15.20.7249.032; Thu, 8 Feb 2024
 20:11:15 +0000
References: <87v86z150o.fsf@oracle.com>
 <CAEf4BzZ5=E+EFs4vccWr-NPpqHej915w-GQfhSG=F1RaAJXB-A@mail.gmail.com>
 <87wmreafzi.fsf@oracle.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com
Subject: Re: [PATCH] libbpf: add support to GCC in CORE macro definitions
In-reply-to: <87wmreafzi.fsf@oracle.com>
Date: Thu, 08 Feb 2024 20:11:12 +0000
Message-ID: <87sf221ztr.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: aec31bff-ee48-42e9-762c-08dc28e21ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N32LotsJb1KtWKqyh91pQzPLjo7iQ4kMHW2swOYX0Whh3Lu2CStd04iif+kY0G5HFpkkjKLXgjUE94EVrzidhETsx1xaBE2dXF4jXF10pS7HkrAboBAuNid0x8nsL7AzMiYT481XaKKGhaMNSyrGra+g5Ux7o7k7xXE9cmpXXYA3MDUVybJAES5pze3q2w5YDnZnmu/4KlRFNbyffvucN371qE0eAOOyV2SHDmKYr/BZG92PFlFlhEhcmkEe5Q5dP4XAR8sHuhKLWNLi3YqdycwlCseQu9uWhdsawhhh4XjGGGVGibeQ7aaO5Uh+AICVfzsHQYERDQFD5+pdm5SXbQ3L577E03AJkBW5plKZrgfY2yzWi6NEzmeK2IjNvzgh8seA8ELUABw4acCQacyxaKeuaJvqXfh9t9SQ+YyhJAZ+tOY3QSQMY0OWHACjgYicsQua3Yhm1qe0OtOz2sqSnbVKILkAmK/XVZ8WFplPPBUa82kikyqMPMlro0aapAAbTiym9kU8+AolNRWAjojcjKnMdMPZA0vr1fPj87T1E9KB1KdAt7BktzUPFQEBxcgq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(37006003)(316002)(6666004)(54906003)(6636002)(6512007)(4326008)(66476007)(66946007)(2906002)(6862004)(6506007)(44832011)(6486002)(53546011)(478600001)(5660300002)(66556008)(86362001)(38100700002)(107886003)(2616005)(8676002)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2pzSVJHckgrd1ZhV2JnSko3Q0FoNVRnaE5EVThnRzAwOW5qUDhTQ1IxbEJt?=
 =?utf-8?B?cDN2M1ljSEdwejNMNGNEemtaMGE1ZG5aZ24yalJKaDFibVBKcEFYUGUvZTVl?=
 =?utf-8?B?Y0N5SlNKZkJJRXJUNE9Pa2xKUTdMRXdqa3JxblBZaE1lWm82bnk4eHhKN0Fx?=
 =?utf-8?B?elNqV2J6cHRvYlpnZUFtOHR5VmpzR1k3QmZkdHRwUEJ1ZzY2aEpiZVdXdFM3?=
 =?utf-8?B?aE9zb3IyOWtsY2pJR09XOGdBdTNKSWxYK2JRZVBhU1R2WlFueEt2dldqTk55?=
 =?utf-8?B?dC9pMnFJWE15Y3c4eGxBM20yb0lRd0dBK1VkRjkweldEMEduSGVMNEZPOXc0?=
 =?utf-8?B?bmNyNS9CcHFXN3NXQ2ZRY3VDK0FjQ0xTZytxTkQzaWsvN214NmMvUzAzTjZm?=
 =?utf-8?B?RHNMWnJWb0N2SDRkY01xTjUvUUpoTkppNXB2VkJOZUk3MEI3Q2tTbkhCTVZF?=
 =?utf-8?B?VWhsclp3Q2dvemNpQ3hsTm91S1E2aDdXY0R6QStsVWkyRXhyMXRmMFB0TUpE?=
 =?utf-8?B?cG13RGFyWEtDQStKVnM2RGEvOVRoc2paRjFPVHpuRVpvaUZiR3piaEQranlt?=
 =?utf-8?B?bnl1OVhRTkVyL2VGODZHNnU2cm1UQlg5RWdMQitxVitlK1lvY0h5QStjcW1p?=
 =?utf-8?B?SGgyWERUTklVYlFud2gxZXhxbVpSK0wwVlZXY3hoREZ3QmtjN1lTNUNSUWZ0?=
 =?utf-8?B?ZnZLdGEzL09UeldEaUJxOEJJUnRPNEhNUWZoSHhETy9WQlNTZFkzQkc0Zkoz?=
 =?utf-8?B?bHhyblNsOWNDeXlxYnE5emc4ZkFvcExENURKcGY5RjEwVk4xcFMyczNUYzB5?=
 =?utf-8?B?SWpLSzhianU0Z2J4dmxReDBVWFg2cjRCcEhwdEQ0d09nNDFWTzNxbExkTEFm?=
 =?utf-8?B?Wlg2TG9Kbi82TUFQSkZ6N3Fpc3VBRXFQY0Nmb2tDcDl1emZYMm9ZUE55bTNl?=
 =?utf-8?B?bFRuOVROdFJlQVByMVJRSHBKT3pHaWRSbEovYkV6VVF1d2NiRFJOVmxtNjBU?=
 =?utf-8?B?Q3JqV3NrYWE5RFREY2cwN2Zya090WXdER0xSSytPS0dOVmhGWlNYWlVuNUFF?=
 =?utf-8?B?UXoyNm41TWVQV0tyS0RXeFFucGxDaUJ5L240VWk1TEQyamYwUEl4UTZEdEhm?=
 =?utf-8?B?TGEyM1Nram5nMkw2ck5qcWFzS1NRYURvdUxDRmZHbFQrdmQ5RHNnU0x2TnpE?=
 =?utf-8?B?TWlleGpoVVlJNzZYc3ZhamNFK3R5bUJKUm5DVENMRHpZQ3I3eEFXVjRraFhW?=
 =?utf-8?B?UHJRcWo3bEVmOGVyM1lScSt2Zk5vaFRoVkpmTDg4Y1NqMktDcCtaT01ISzJJ?=
 =?utf-8?B?WWJuNjhHY0l3QVlFdjgvdU1hYUV2dGVRaWIxeCs0WGFaakVHd2NpWGxYRmNr?=
 =?utf-8?B?TlBVLzY3SUhsdVF1Wi9yaVVzNEJadXhJUEhyUDlKMVRhMm9oSzRZMFA0Wko3?=
 =?utf-8?B?QkExK3ZUMlMrdW5va2ozTDNIMXNRbllFdjRNNzVwZTY4UTdWMUJoTlJDT3hV?=
 =?utf-8?B?cFEvNmFJNERuU2dEa2gvZHdJZ0dJTmdNZXJaRVpCUm9iR3pHUFkxR0lqcUdn?=
 =?utf-8?B?dWRQOC9NcnRHREV0dlZYRTNrS2J3VHJzNU8yRk5SMVZEelJ6eFVyUWhnMGpC?=
 =?utf-8?B?Z2lWLzNGL0VSSHVDRUNnWUd2azdDK2JiQTYyWFVZNmRCMVdjNDR3TUd0MitD?=
 =?utf-8?B?anlxdFBTVFZQNTR4M2psUlNWeHdsaVlvVER0QWt1OWVHWGpSWTlpWjFESlRR?=
 =?utf-8?B?M3N6VnJHeDE5S0pETE0zOU9lVHQvd2orbDFhcjIxbis4ZGlkWlM2VXdzYjh6?=
 =?utf-8?B?dDlGOGg3cVRReERGMGJzanZJdXU1M05aSGJEWlpyRnF1M1JjNTBOcUhUQmV5?=
 =?utf-8?B?V0hTVDQrQ0FBWkhVVXdBc2JTUlBuTE5sUXB5RFZCU1EyUFpxMGszQ3IyV0k3?=
 =?utf-8?B?YUhNVndhQlZRQldhZURYczBPei9tQTV6cEdOL3NOaHNnWGlsQmF3cThZdUVq?=
 =?utf-8?B?Y09CcnlZUE9hUHBVME5VWkNGSk1hSnoxOUIwd1RzSjhuM20yQjRZT3hxa2ZF?=
 =?utf-8?B?VmZ6L0pVSTBPcndUWHdpZ1VPOEtML0puMjFDVkdVUmxBN3RYRkp3eUFKVFVl?=
 =?utf-8?B?VlJQTTNxa01uVlR2VVZ6Z28zbUE3ZWdxTzJCT3pKb0NCbG43UFJtWkZPaExW?=
 =?utf-8?Q?lcwemx7CQsts23ze49QV+68=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MLJre0/NMMOpiAdw1AycZpzOtndyLH/3ECiwxRn2aUgC2A62+5U3ogN68h6jHpimqdAnJ4QoT4QF9WOYofJrzUCA4CJoLI8MfJJAjM2x3hdMnUzZtmRb2Ym3s5milcUhlDjExANiNwu0vWD51nxVRTQ2diZtEub4bxoNz6k5EZhJ1SjN4E1+XpqqnvNjmxVUHAIFsOsoFgECR8hRY5Ub9zLo/AHxZZcTU/Psyht8dje5LxmIe7HMOGxIFafH+B+uUXZretHaPye7sZzywHIHQIgBOX9/4mnOBz1+yPbuZ0sLZm76pH87uNy4t59B3JoEkpjRi0yC9ibxzB4Ik7DUrBb3lFzDvUhy8jMiTDOM7a34jMh1mWLr6+v2nQeFeupljHrhJd0VsGVNhIHxRJkqxjSUS7EM8RWwTqBiJO9Xi2p/tHvsH6ltN5qyIbWAJLJiLU203baW9NnC/I8m5B0G4mK8el42F1br8qBdKlPNTzM+G2ECz3vihzlMtnpJyMNc3jC3D8yEIqc52pYe6c0rseBHaKeoDqfJDwoL7sZ+JLy1zonheFd5o4r/bJ467Fdd6mvcDtSy7ZBgv2owHqFy5ciKQPM16dPdBG3shXiEQHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec31bff-ee48-42e9-762c-08dc28e21ad1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:11:15.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8Lzqtuo27YcSrVYS83rI/5axYxzp8nxprDO8yOoeKpK5o4kho4PIPRppEMDhs6p7NxVtLhsnBGY8S+O4DdlGZmbQDi3MAgmFgLVl2RnLl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080107
X-Proofpoint-GUID: N3OPwuVkihZKBV9sTwUcmPkkyb10HiH8
X-Proofpoint-ORIG-GUID: N3OPwuVkihZKBV9sTwUcmPkkyb10HiH8


Jose E. Marchesi writes:

>> On Thu, Feb 8, 2024 at 5:07=E2=80=AFAM Cupertino Miranda
>> <cupertino.miranda@oracle.com> wrote:
>>>
>>>
>>> Hi everyone,
>>>
>>> This is a patch to make CORE builtin macros work with builtin
>>> implementation within GCC.
>>>
>>> Looking forward to your comments.
>>>
>>
>> Can you please repost it as a proper patch email, not as an attachment?
Apologies for that. Was unaware of the requirement.
>>
>> But generally speaking, is there any way to change/fix GCC to allow a
>> much more straightforward way to capture type, similar to how Clang
>> does it?

I tried, but due to GCC front-end specifics it is not possible without
overly change how GCC front-end works.

It is not only the constant folding of the enums as Jose suggests, but
also the cast of 0 gets optimized away by the parser itself. Leaving the
builtins expansion without a clue of the precise type used in a field
expression, as an example.

>> I'm not a big fan of extern declarations and using per-file
>> __COUNTER__. Externs are globally visible and we can potentially run
>> into name conflicts because __COUNTER__ is not globally unique.

The symbols with the __COUNTER__ are consumed by the builtins expansion
and will never reach the output.

>>
>> And just in general, it seems like this shouldn't require such
>> acrobatics.
>>
>> Jose, do you have any thoughts on this?
>
> Yes the macro is ugly and more elaborated than the clang version, but I
> am afraid it is necessary in order to overcome the fact GCC
> constant-folds enumerated values at parse-time.
>
> Note however that the expression-statement itself to which the macro
> expands is not elaborated, much like the null pointer dereference in the
> clang version doesn't get elaborated.  These are just conveyed to the
> builtins an the builtins use the TREE (IR in case of clang I guess) to
> extract the type from it.
>
> As far as I understand it the extern declaration in the macro is not
> declaring an object with extern visibility, so it should not result in
> any symbol being defined nor have any impact outside of the compilation
> unit.  The __COUNTER__ is there just so you can use the macro more than
> once in the same compilation unit, but that's all.
>
> Cuper will correct me if I am wrong.
>
>>
>>> Regards,
>>> Cupertino
>>>

