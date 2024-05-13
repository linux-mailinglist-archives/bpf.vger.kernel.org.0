Return-Path: <bpf+bounces-29653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA698C4683
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBED1C23417
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B428E34;
	Mon, 13 May 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n49hZTtD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DwN06J9W"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC92E414
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622735; cv=fail; b=XGa2MX+V8e8w/OgSHY4I08RFoa98Skt4cOY/7fLiwexaIu+Widd77mmJAtsRBfG5eE7H5LcPX8q1dzxCMFc4+0qtHQtVIvF9uQTVPEuKwe1M+SFLsCdCzP7EERcuHxdlgY9A8UErTBhCrKlGbj4ApJwgv1KVGXRUJfQwZWSFJe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622735; c=relaxed/simple;
	bh=BqSnb/LhcXqNz/LtxXXy5Mp+gzXbpxi9nVYTunb75m0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dm7NSr03GhjMBn7TFjNWQeX2HyplCAMVGKZS/jHwzbKKdy8pLaoxfmuxqTxa6IzsTpzojlSKeUV0iV/o6iiuns/lr/xWIwR6YfDHmyE4rGvTBOqmH748Fo77PsmVOMpxnMjePfQ1iR9Inou+KirPxjajiCcppdea57Ihnbft28g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n49hZTtD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DwN06J9W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DHahpA026397;
	Mon, 13 May 2024 17:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5q7rRfXcgWRqpZ3smhIe57kqqd5t1jDlZznsJp61nVw=;
 b=n49hZTtDDu3pt2hgphGipARiha9Jt2JPfEf0ZDifFSnJ2D9VhnWZCnwiP/vQKITuN3Hr
 InnvLiEfhkQRw96ou31nxeinyBgMHmGEggb3EUAdnye40QJTI09vIPugki3nxFtcOstI
 3FtDHfLjDZS31bK7lV5VKSF3W0NWemvElCn3ygIU/3A1YhN3eJ4LJN1VYSFu7pfvrnv2
 QGtIBSYFiHsojBii5y749TPn+IRCiRiRq9XlzNluIF4yejhem3Ztf9FNmi60r7K5/4vw
 1txcFhy84g3ZY4DFdkdenhPWviKK326v0U0vyfSBO/ll9iPoWhLK+5Y0aP02Hzs2COWP /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qdj01dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 17:51:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DGhjj9005725;
	Mon, 13 May 2024 17:51:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y464u8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 17:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkOhDT2m03QO2WVW3o0klnvUqyXsshQ6oa/9RBCHGHzCKIcx43pR6w60IpbaLEcQbZ4Z7JvEg7Jd1h/yupf1i9o/Cu1EjlvcvY9qXZ8p1Pi4WZBe/LwNkhoqZmnf8P7SI+vgJYQH9S4Sz6yzEUGyrC+OGa7Pf7e9W9dCxHsoSnR/+yo0X23h5qB81hXgJCJoo/dpntGQqCPvrhDqvvZfI7Q+X+3oBeYcNJWJM3Ob1/71rEe9li+o9NmPbMzRNNmgiQkzfB9KEE3QumWWsgupBd1fC6n9riAOU0GBAIDpB7tbRxuxVRJZo0OrQ8yuFY8717nvJKidBbyCayn6pZ3cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q7rRfXcgWRqpZ3smhIe57kqqd5t1jDlZznsJp61nVw=;
 b=SyAHtDthGKUVgp6edKXx+AkWoUcCtFm60WLlrRLRNyZbDIY4pcwfCKv5kPzo33sGfI4XsntxXXF6VNZms8n76GFGnT/nQMCk6NP5k2UqH2p+Iu8EsMTVZX2ZoUrbzLJ2vc3viTU3Y/KyoxH9iiBqrE1lWrI3QYPk7Mi1tTdP2SShmQp6XFBCN7SgnS/08Y/z/14SyFi3zoCMMTBJ1vqPaPkn8FXrysMkDerNlJCFkhNU8m2k0EA+C+iXA3Kehs2vxkWB4SV1jGW0ZHIHelmInT6YoeLUK6FKeMF6bT3PYYF7gibPvC7+EDPDUmKhJ4bB/nmeyvhaw9SrIPtHlkqOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q7rRfXcgWRqpZ3smhIe57kqqd5t1jDlZznsJp61nVw=;
 b=DwN06J9WRA60zPea/A9wb6/j3zlLtR3yb7uutCPRoabN6qvVkBA38Shp1VqWTGP7lSGWvUKbn0Lt7sE9FQtDcR+cF2kNvB4U99/qHwdaMLPPOZzco60tdykx7pWysfxwz9SYhaPkcMbtD/5CLYmA2errQtgbVsei53OEp2HTOVI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:51:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:51:46 +0000
Message-ID: <ac181d99-c1b4-4ec0-ac37-9c9e7e132210@oracle.com>
Date: Mon, 13 May 2024 18:51:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 07/11] libbpf: split BTF relocation
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240510103052.850012-1-alan.maguire@oracle.com>
 <20240510103052.850012-8-alan.maguire@oracle.com>
 <392d0bfe027cb88a5813f0832715439a76ed9de6.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <392d0bfe027cb88a5813f0832715439a76ed9de6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa7e4ee-84df-4484-d594-08dc73755bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N0txQUlSNUpUTENWaTRac2g0RkJCQ3JOZFAvMllnTWF1cjJXN3JXVmNvblF0?=
 =?utf-8?B?ejNERm1HUE5vbTJlSDRvbHBqeFhUZTFvN3Y1bFk4ek5RLzcvNTNqQU12TnhJ?=
 =?utf-8?B?UXREeUZxZzVyaHRmdGhJRGVwU1JXcnJPMktpa0xqL2JHZGN2a2IxaWY1Yjh5?=
 =?utf-8?B?S2MrMUpUcDQ1NG5Gb0pwekgyL09hS21kZUVidnRSV0hLOUZEUGY2M2VYdElP?=
 =?utf-8?B?REhhbHBBVjBIU1F3S3FuQkNlemk2ekR1c2pHdGplRjV3ZmRSZ2ZqUFVSMC91?=
 =?utf-8?B?cXdGMnZpZW9xRHFrNHRZMTBjcUdYRWZMOVdOM3pPVUh2Y0Y4MC9sdFhad21s?=
 =?utf-8?B?UmpvUWdvMk9kd21vMEZkOG5wUWhpVVVLOVBJNHBYbzk3TnRDNFJuYmV3NmVM?=
 =?utf-8?B?OWJ6NHhhZDRUMkRQU2lYU3FuSXJrOFdlV05FNGQ0aVdMM0ZwV1VWRitRTjBr?=
 =?utf-8?B?VGhOUEJzOXVPWXhsWG15R3JaeUZXOTJGOVRRb2ljN0IzR0p3RGxrRC9QcUYy?=
 =?utf-8?B?UzJRcEx1YTBDaHNLanVvQnFiOW1xOVZVRVE5d0E4TE50UEhSd1EyNFppemkv?=
 =?utf-8?B?QUtuN0x2Q09JamtxRitIdGpFUWNuU1NIcndDWjliYmdDdE4zeWdsU2tRRDFW?=
 =?utf-8?B?MXhMeUJiYy8wRVRMbTZ0dHhtcnlIdW81UjI1WnlrSVdEaGlMZEVvaEQybUFv?=
 =?utf-8?B?bG82OG1jdWlYa1N5TkUrNlFaNTZ2a0dscDFCNGhsaXNIT1lGVTRDNlZhVFc2?=
 =?utf-8?B?R05uWTBIK2IyTTVscWpSVHdDOHM2aFROYlJQTDNPNEh3WUFuVW0zbHhzbXRY?=
 =?utf-8?B?MURZeENGYnpTY1JtSGVHaCtEaHVTTE81cUtCTjFRV1Z3RGtPS3JUWXdPcE8w?=
 =?utf-8?B?cEg3dEtmNFNEaWJ3NGtLK3BtMUdBdVVtallUdnhDekZIOFplU0lxNFMvbEpC?=
 =?utf-8?B?QnBvU1NzaFVXSGsxTU5nVThiMldOV0l0NlNvYSs3Mml1alNwV0wyN1hLTVMw?=
 =?utf-8?B?MUltaWJJdmhsQjJBbmRCR05YOW9sdzFBcnJjbjVVWUtCVXVqT05VRjBLRnZV?=
 =?utf-8?B?c0VtQnpDZEp3WlRZUWo1eGNLd0FUWEdMUUhSZU5aTWdsQ0hoK0ppVm9Md3JY?=
 =?utf-8?B?UlpwM2xaY3dwRThaRTFvbUt3MTNLYUVrNWRCWHM0c1VzOHB2VU1EcWtRcHBm?=
 =?utf-8?B?Z1JYL0NBVkIrd04xMlJJWjRvZ2RZWXcrYkJvK2VZdU1FbWRVby9nOUNSa3ZV?=
 =?utf-8?B?UFNUczQ4RWJGK0dkWUVoTC8yR2d1TTRBZGc2ajVmVENubWdwTkZpdFQvb1Qw?=
 =?utf-8?B?MHpNVmJGeUpzUHAwVXdhdnpBVHU3cmJvd0hHS3JZUzBtL0p3R0ZDUlFUMkNB?=
 =?utf-8?B?ZWVTVnVTZUVlS29OcmFJR0hId3l3OFg1V0Zac2cvRWg4ZlBmYkR4QVRRZ1FH?=
 =?utf-8?B?VGkyUkdnYld3bFJwSEV1YjRRUitZbjQzZldUMzlKZDZBcXNQTFN0SUJzbENt?=
 =?utf-8?B?MjArVE9BQ092dmhOcHhHUWRhUVJZZTVZRUlTZ1BXejNMNjd1OHdtWnl6bVg2?=
 =?utf-8?B?aDdaZWFQSVAvNldqd2V2aDFNODZqOGNlNzlYb1NCWG53Q3J2SVVCaDZ1cDlL?=
 =?utf-8?B?ZzBBRURJcVJ5Q1E0QXdSbUlqK29ZNnE4REZrN0YyaENmZXlEV0s3KzNYNWVD?=
 =?utf-8?B?VG5mZjVzRVgyaGtvVGdraitNZUw2L1BLS0ErdysybDNHQkhvaXdhcWxnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGJyaEd0cDIwRWNCam9vQW9zdEJrVDVVckMxWHZEV1A1ZWZkWHhGei9ubnUz?=
 =?utf-8?B?dkdCRGozRmJxLzdZSmpveXliemprY0I3K0pLS2NTeWdLek5FWkU2ekg4N0t4?=
 =?utf-8?B?YzhRSlpMRC9qek50cnZ1aDRLREM1U3piL0hqSWdoZjFlV1U1OG9EMW40K04z?=
 =?utf-8?B?cG16cjhJNFJhSldpckN6QloveWY3ZVRsWk9KTWo1OGp2Ti81bEtNY3ozbFNE?=
 =?utf-8?B?b0l1d2M2TGZIZ1UzY0FPZWJzUUNVZ3JBMGsxSmpzdi90azNIVGduYzZJUTQ3?=
 =?utf-8?B?SFFVcm42RXNXL0szY1NTMHI1cXUzaGpEK2pmWjlBTkRBd1FKSHFjVjNNL05m?=
 =?utf-8?B?VWx1Z3d4dCtCNkFVYnVROStNNW1SdGh6WEppa0d6M2M5SlhXTU81NDlqVTdl?=
 =?utf-8?B?elp1Qkx6Z0VOREhvZUd6eGlzRWMweDlDVFQ1Tm1kNVdPeXVYUEpaRHBXRnpr?=
 =?utf-8?B?VHdhSHViNWIyekFTWVNFSktSNVBVcVpES3hCTkxEcUh0K3RuQWdHelBEb0Vh?=
 =?utf-8?B?eXVneGRCOWRvQWIydlY2cjUxUWJ4enBzZzR4NzBUNGM3Skx6OFVYNW5WMk53?=
 =?utf-8?B?NHIzZFlhcGxraUdoejJmRmVGaXNlUGh2LzZvUU43N1Nia3J1bTdNN3FHeEx3?=
 =?utf-8?B?RzRMb0NLQXJxTHdRZ2ZBTTdrQkl3M3Z1YVlkTHZhd01XV2RYM3BaWGV4ZjVa?=
 =?utf-8?B?YWlwY3lpdDFKdldsQmgybEcramh2N08zK3pnTEZJNVhSWHBWWlVvMTVWYXZQ?=
 =?utf-8?B?RzRndEpuYk52Y2xNV21EQVlrNUVROEdFZUNQWmZQTUhSY200ZUl4T0lIZTlv?=
 =?utf-8?B?cS9CNkU3dmUvY25iMUkzVEVNZUZtWU03bEZkdTFXNy9qd0xjeHczanBJQzJi?=
 =?utf-8?B?RlU5SmdOOUg3YjJkckVLVkJiMDNoK2VDN1I1cTRvanhvZEx3YkRRZzhVUTRu?=
 =?utf-8?B?eUorRGllM01UZnovV1dmSlg4UlMrSTRZV2NYeWMrdU54ZkphL3d2aFdBNThX?=
 =?utf-8?B?S2ZNUGV0K3F5VjIwUytQOWpRWjFTeHo0aW5qdHZZTmhFWGluNlpQN2RCd3Rx?=
 =?utf-8?B?N21xOW9IZU9teFdldkgwbE53VnlFS3liSFRXWWh6cWhOOWhpSDEvR3BQS2kr?=
 =?utf-8?B?UmRIeDMzZC9EN1lwU0xObFdlblhwTDdTcWlaOXZKNFloYmJ5VkRXajl4a1kx?=
 =?utf-8?B?djBONk9scWJBVDQ2Z25aOE56aXZmemNYb2lzcFRVdHc1OU92WmgyejR0MUFp?=
 =?utf-8?B?bDh3MnVBZGxqT0N6MXpWU3hKbVZzR21mVGhGNStGblRVTnc2MVVRY3VIVjJx?=
 =?utf-8?B?eFFKS1dKRDhna3pPR1ArS1l4NzQ0U09XVDZoM0dkblRBYXY5aTlXNHl3QVNj?=
 =?utf-8?B?ZVlqenltWHdjaC9LZTF5K0VkcnIrcTV4MVczS1N5QVluWUdTL25KKzhwSGo2?=
 =?utf-8?B?MDZnVnA1aHdNRU1obXE0N0VoNkcwczczOHVuMlN5cmg5bmlCNElhbjZPQ0li?=
 =?utf-8?B?NlpwaTh4Mjdna1o1ZlpRZ2VKZWtmWC9EYjVZdGowOGJ5THFsVTZ1bHQ5T1Zu?=
 =?utf-8?B?MC93WjU4M2NvMGdUcHJzWmJXSkgzc0N0N1k0RWVodTNHQytvbmtWT3FsZVl1?=
 =?utf-8?B?M016cE5lMnBzTUVYT0ltNFJJZVhTdFQzOFU2RXdDWHBmc05Bb3krSzdIaUIw?=
 =?utf-8?B?dEVpL3NnN0l2ZUh3SEtFT2FHMW5Ia3E2M1JNS251WFZxb2NEQ1FTVTh3YlpB?=
 =?utf-8?B?WDQ2K3V2aWQxaGFBUEZvcVg5VVc1STY0R29uaDJ0NDN0bG1HbVZGbnVUSENN?=
 =?utf-8?B?dU5xNUJQOGVhL09zMkp5OTBBUU9oT0NpUnZmZ3dGcThWTDZUYXY5T2VmS0FO?=
 =?utf-8?B?U2FXSlN3am1yRS9qUVVIUm9YRVJtd3VXZTZUeGUvdUJINTRrVXQvbmplZ1gy?=
 =?utf-8?B?TjlHL1JjaU9ZSjZxWkk1MEp4azk5NlZEajdLdWRCZ3FGeEw2MUJiV1ZyVDI5?=
 =?utf-8?B?RktXVWZzKzlDSmNSa25CWG0yUjFDb3N5dzZELyt1R2t1ZTdJTDhqZjIyYVZE?=
 =?utf-8?B?VFhFelkzV2hwOGV3NkVpQkdRUUFwN1lGZTN0WnM5YWx0c3d6K2laWlFrS2Mr?=
 =?utf-8?B?UkV5TmJhM1FLM1dLdU5iMHpPdjE5alR0SlplUE1Sd3VjQllsTjdHcWcrNjBv?=
 =?utf-8?Q?/Y2WiHxx26xZo9Fh48xUOdY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zMM0YPvInyVxKk1qqez0NZI7jFbPqpqdjL6MD+i2GSiZj0HfviCGLuxTdQ+H421Tqw/GzuhpXwpKrqKjkGfhGbhaBFLEJNzRkCLMppT8nu5RZ+qTnuwIrgdY8UidaL56QXz1sf6caTyogx1+PiDefUnQafPxotvkgtf1PfemgMR0WV7NRU92YBk8x0X1hUYt21lVN4HuAOLDHpmvlAcdlyF5qXbbFrwgcqB3cnRLcU1WoSxvpRdygK3Pnab96zz+SO8ZOzYb0DyakV7rG0JLDsJGmw4SL6cKoLRRDmGtMBbYUAyrArs1zh8Aqcj1wiamvInEhAvGAyFKYCs0kElmSODb16p7P+O+ETddcO1Rgvm1R1QeKSZbbJgrN0lDuRbuY7EqDamYgZbAJm4z3Oxh5Z3il2bgFI8/08CT8MQwI8iDknPTk+KFwU217rdvsagEVDqibiQmkiy+N9/GmTHr5YNUYHEMN4VPPWwawWo8+LwbW+HZ4jPy9xIO1CtZ3ux2vzleHOlKpTu8mI4oxwjBG0QEgChLj4F0//lh0i7AmT+ggTE6p/0/iATOnMTM5IzST+IA/JpaIevmiXapDVv8n4XDanSSOCULT2SXdZ9l0Bo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa7e4ee-84df-4484-d594-08dc73755bc1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:51:46.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f54AyZBoeaSMWFz5gQZU/YllxhSBxgeZ99XK+7OmfyBqzEfLn7zmuAYLx63B2JZwC+DlLuYM8/NEJfAnMhBkdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130118
X-Proofpoint-GUID: x-mPnxL8jJuapE4mMQu6NJLSK6H6jNkE
X-Proofpoint-ORIG-GUID: x-mPnxL8jJuapE4mMQu6NJLSK6H6jNkE

On 10/05/2024 23:26, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> 
> Looks good to me, but I think that comparison function should be
> extended to include 'size' to cover some corner cases, see below.
>

Agreed.

> [...]
> 
>> +/* Simple string comparison used for sorting within BTF, since all distilled types are
>> + * named.
>> + */
>> +static int cmp_btf_types(const void *id1, const void *id2, void *priv)
>> +{
>> +	const struct btf *btf = priv;
>> +	const struct btf_type *t1 = btf_type_by_id(btf, *(__u32 *)id1);
>> +	const struct btf_type *t2 = btf_type_by_id(btf, *(__u32 *)id2);
>> +
>> +	return strcmp(btf__name_by_offset(btf, t1->name_off),
>> +		      btf__name_by_offset(btf, t2->name_off));
>> +}
>> +
>> +/* Comparison between base BTF type (search type) and distilled base types (target).
>> + * Because there is no bsearch_r() we need to use the search key - which also is
>> + * the first element of struct btf_relocate * - as a means to retrieve the
>> + * struct btf_relocate *.
>> + */
>> +static int cmp_base_and_distilled_btf_types(const void *idbase, const void *iddist)
>> +{
>> +	struct btf_relocate *r = (struct btf_relocate *)idbase;
>> +	const struct btf_type *tbase = btf_type_by_id(r->base_btf, *(__u32 *)idbase);
>> +	const struct btf_type *tdist = btf_type_by_id(r->dist_base_btf, *(__u32 *)iddist);
>> +
>> +	return strcmp(btf__name_by_offset(r->base_btf, tbase->name_off),
>> +		      btf__name_by_offset(r->dist_base_btf, tdist->name_off));
>> +}
> 
> Interestingly, comparison by name might not be sufficient.
> E.g. in my test kernel there are a few STRUCT/UNION types with duplicate names:
> 
> $ comm -3 <(bpftool btf dump file vmlinux | grep '^[\[0-9\]\+] \(STRUCT\|UNION\)' \
>             | grep -v "'(anon)'" | awk '{ print $3 }' | sort) \
>           <(bpftool btf dump file vmlinux | grep '^[\[0-9\]\+] \(STRUCT\|UNION\)' \
>             | grep -v "'(anon)'" | awk '{ print $3 }' | sort -u)
> 'chksum_desc_ctx'
> 'console'
> 'disklabel'
> 'dma_chan'
> 'd_partition'
> 'getdents_callback'
> 'irq_info'
> 'netlbl_domhsh_walk_arg'
> 'pci_root_info'
> 'perf_aux_event'
> 'perf_aux_event'
> 'port'
> 'syscall_tp_t'
> 
> I checked 'disklabel' and 'dma_chan', these are legit structures with
> different size and number of members. The number of members is not
> stored in the distilled BPF, but size could be used for additional
> disambiguation.
> 

Great idea! I'll update the first patch to check the few struct/unions
that make it into distilled base BTF _and_ don't already preserve size
for duplicates, and mark them as size-preserving struct/unions if so.
It's still worth using forwards where possible, as this reduces the
constraints for preserving size to cover just the cases that need it
(embedded or duplicate struct/unions).

>> +
>> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, iterate
>> + * through base BTF looking up distilled type (using binary search) equivalents.
>> + *
>> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
>> +{
>> +	struct btf_type *t;
>> +	const char *name;
>> +	__u32 id;
>> +
>> +	/* generate a sort index array of type ids sorted by name for distilled
>> +	 * base BTF to speed lookups.
>> +	 */
>> +	for (id = 1; id < r->nr_dist_base_types; id++)
>> +		r->dist_base_index[id] = id;
>> +	qsort_r(r->dist_base_index, r->nr_dist_base_types, sizeof(__u32), cmp_btf_types,
>> +		(struct btf *)r->dist_base_btf);
>> +
>> +	for (id = 1; id < r->nr_base_types; id++) {
>> +		struct btf_type *dist_t;
>> +		int dist_kind, kind;
>> +		bool compat_kind;
>> +		__u32 *dist_id;
>> +
>> +		t = btf_type_by_id(r->base_btf, id);
>> +		kind = btf_kind(t);
>> +		/* distilled base consists of named types only. */
>> +		if (!t->name_off)
>> +			continue;
>> +		switch (kind) {
>> +		case BTF_KIND_INT:
>> +		case BTF_KIND_FLOAT:
>> +		case BTF_KIND_ENUM:
>> +		case BTF_KIND_ENUM64:
>> +		case BTF_KIND_FWD:
>> +		case BTF_KIND_STRUCT:
>> +		case BTF_KIND_UNION:
>> +			break;
>> +		default:
>> +			continue;
>> +		}
>> +		r->search_id = id;
>> +		dist_id = bsearch(&r->search_id, r->dist_base_index, r->nr_dist_base_types,
>> +				  sizeof(__u32), cmp_base_and_distilled_btf_types);
>> +		if (!dist_id)
>> +			continue;
>> +		if (!*dist_id || *dist_id > r->nr_dist_base_types) {
>> +			pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\n",
>> +				id, *dist_id);
>> +			return -EINVAL;
>> +		}
>> +		/* validate that kinds are compatible */
>> +		dist_t = btf_type_by_id(r->dist_base_btf, *dist_id);
>> +		dist_kind = btf_kind(dist_t);
>> +		name = btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
>> +		compat_kind = dist_kind == kind;
>> +		if (!compat_kind) {
>> +			switch (dist_kind) {
>> +			case BTF_KIND_FWD:
>> +				compat_kind = kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
>> +				break;
>> +			case BTF_KIND_ENUM:
>> +				compat_kind = kind == BTF_KIND_ENUM64;
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +			if (!compat_kind) {
>> +				pr_warn("kind incompatibility (%d != %d) between distilled base type '%s'[%d] and base type [%d]\n",
>> +					dist_kind, kind, name, *dist_id, id);
>> +				return -EINVAL;
>> +			}
>> +		}
>> +		/* validate that int, float struct, union sizes are compatible;
>> +		 * distilled base BTF encodes an empty STRUCT/UNION with
>> +		 * specific size for cases where a type is embedded in a split
>> +		 * type (so has to preserve size info).  Do not error out
>> +		 * on mismatch as another size match may occur for an
>> +		 * identically-named type.
>> +		 */
>> +		switch (btf_kind(dist_t)) {
>> +		case BTF_KIND_INT:
> 
> Nit: INT is followed by u32 with additional information,
>      maybe that should be compared as well.
>

good idea, will add this.

>> +		case BTF_KIND_FLOAT:
>> +		case BTF_KIND_STRUCT:
>> +		case BTF_KIND_UNION:
>> +			if (t->size == dist_t->size)
>> +				break;
>> +			continue;
>> +		default:
>> +			break;
>> +		}
>> +		r->map[*dist_id] = id;
>> +	}
>> +	/* ensure all distilled BTF ids have a mapping... */
>> +	for (id = 1; id < r->nr_dist_base_types; id++) {
>> +		t = btf_type_by_id(r->dist_base_btf, id);
>> +		name = btf__name_by_offset(r->dist_base_btf, t->name_off);
>> +		if (!r->map[id]) {
>> +			pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF id\n",
>> +				name, id);
>> +			return -EINVAL;
>> +		}
> 
> Nit: maybe rewrite this like below?
> 
> 		if (r->map[id])
> 			continue;
> 
> 		t = btf_type_by_id(r->dist_base_btf, id);
> 		name = btf__name_by_offset(r->dist_base_btf, t->name_off);
> 		pr_warn("distilled base BTF type '%s' [%d] is not mapped to base BTF id\n",
> 			name, id);
> 

sure, will do.

>> +	}
>> +	return 0;
>> +}
> 
> [...]

