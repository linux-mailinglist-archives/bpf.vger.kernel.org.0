Return-Path: <bpf+bounces-16406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56A801204
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28743B21372
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651C4E630;
	Fri,  1 Dec 2023 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F12uL2Vm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kqVH5OgG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8F197
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 09:47:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1HK8nK013137;
	Fri, 1 Dec 2023 17:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ug7vr1g7Q2qCO4yHCW4fJcU1yaWezyo0QQZWSUl77/0=;
 b=F12uL2Vm/sYuFskbcR27B5QE5xK3C8bSh8Sno7ox9ZZTCZp5dJb4k4lxsJpg5aib3uTL
 W7CSbq4rkEAPNk5u8pyWLuhirJFmxic53U5HO9Q0qh7e3rUfthgakTs5Xc2T47CsWcCX
 t/x0d/T1x6yixXxStc4gAoKr/3XdikJgxyIBEcA12vX29zCqfbViz7H3FiGhCiZKhSYp
 DDw6w4+y6ySuAgzLMy9dKv4QB8lXWk7BMpP677taN8Cwws+xoIauNgFiICRHPndcvT0o
 mbOq74vX8IpiztTrnBgQryCB9LBzIBZAOGKHs0rJNU22gAf+mVCPBKsNX5Nb3l0mY3wG Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqhgd0eum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 17:47:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1H0FoR009209;
	Fri, 1 Dec 2023 17:47:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cc3jks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 17:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtJq+gSCZU3HCG57ThZdhcfYqGdHg7GN/F+o1UEHzQV8rrDxHQkbeGZQbIYqaxxYustUkK4KfNZwMaIPtV7+T1AHwUcmhSmwtu4TrFG6oYzStjZtivXof8T9zVkiRdaCwFuR8MbsWmjToW9M01Btuk1qFZjOD7ouHSoOUKJkaikuZ1n3x2lOBpTLuyFZHjD/sYg/Q1XhZu+qGvJg1GLmhAHxRQH4JY5kNXEYplpcwrzNV032DN7r4/yikAbryxnh0m1G3lSFsYif9073HfbszyfL4ztXLvJ/Dw/zHBWuNH4YiE6HpaZhAoPZaqvi2SkCwt7Q7qgWuu6i7JS1NBMpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug7vr1g7Q2qCO4yHCW4fJcU1yaWezyo0QQZWSUl77/0=;
 b=oU1ybiHQqGnSttEvoTO23sCBN2eM455kTLpya6CQo7Wk2Fzd2jQdzdyMos2N0ISdVsWwTpjpSODnmEPsMA3oZSJgqmsCS/Z1fm+8PWVKSTBghHLsAGKB8/ds+XFuj2ph8dVLRUSibw4hFy4vJ2mNzBwl74c5GoxuOdjApThcafu1UyWAudJxflH0kMVLBFdyjt6JITEt1t6f1inhtAnTZlWvlJPXsDJ6fwEWjMsl4phgSJEHhwete2SDdyafjVQe8JLa78E21HgnwqX/wWARevYKpJdL7eQeNSDO5HoEce8pT023X1PwKZBqfJdi7tAv5IzOXTJziEML3RmJ3Gtitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug7vr1g7Q2qCO4yHCW4fJcU1yaWezyo0QQZWSUl77/0=;
 b=kqVH5OgGGB+C1ad/empZ3+nOTZfE2OSMSGhLjkc6miWXjmhaAn/7Idr2gCB8Ui3jfgdcioHK8eSljkwWgqm0IvhAZTDiVEMy78LEU2uaqwKKDh7AoimDS9IV2uL+WdTGwrfw5aqVPOuHc6NuARGNGvaZw3NtYvUu6b9xsicqgf4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7769.namprd10.prod.outlook.com (2603:10b6:408:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 17:47:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 17:47:00 +0000
Message-ID: <2254d57e-843d-c3e3-0ebf-779e44c5d61a@oracle.com>
Date: Fri, 1 Dec 2023 17:46:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20231201170609.1187520-1-andrii@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231201170609.1187520-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 734737b5-b6ef-49a6-2b7a-08dbf2958519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wuXGJsw3VuUc0VfhLHNb5iFSAP1uYF1svuDcWGATXkygMU2K/MovO0ap178n2cnyjgftoaHyu9YiII9U/p2RTX/l/PlLQmTmF7zxfm7/RDmq51lo9PDhQUXX44RVfrN4eAHaq4rf5WT5/libFb41LIZAgwm57IMe/XbMvE/6DJOaWR2sVuxUd/P3lnmnQNFKlF0VJzam42o3ybQRzBClbj+sMo9l0z1p4MOTND1jTiopUzasRinavCZw0/MDeeOgBynmO2PBjJmps48OGETHh/cgPRoBFmT9064sX/7/UeURzGvpXxHnah7HKw6wQrEfWK+cYGvABupj2oD7JGDsReH/oCrbzy2NZ+n6wFrPm667kis4qsyINV12zivcYt2XMUJoWGsFRUC+xMO7Fs+2sKsXBFOifBjxGNoqmeoWqpuDGMv6Hp+0UCuYoEJaHl3FnzFHgx/MrcZ7C0ELVkXVlc146RqkrRbLdKPD73O95qsJ2Oqrxn6DByf5XkdzCfo11zctOTAcHwkrD+xqHrOgWgVvQ30ox0jAdNXRNT/LfE9xjJPRNP+NiK9dDeGuJJYW9gV6lgN0TxG2RGmJTap6aBiKEE7+hrfGp7WB9OFeDmzON2udQIOJhZVDeI0/fhGsJfGOyr/ADkDbUxbU3cPr0A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6666004)(66946007)(2616005)(316002)(44832011)(6506007)(8936002)(8676002)(4326008)(15650500001)(2906002)(478600001)(53546011)(6512007)(5660300002)(6486002)(41300700001)(83380400001)(31686004)(66556008)(66476007)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2FxcHhRVXQvSUtnNUgzekdYZGdPN2Z3SmdjNmRrdTgxRHBXa09VNEF2SG5H?=
 =?utf-8?B?MVRSWDNqd3FReVk5RTJDY1B0bTE2M0VOYTlMei85Mmd5N3ZmTGhzMktXUmow?=
 =?utf-8?B?WlRTSFFNVGkxN1NBRG8rRk1kaStZN3JZS1RYSWUrb0ZuRmxDTi9UM3Rld1kw?=
 =?utf-8?B?MG5LQ0NzRVJIa1NKM1lIWTBjclRNTDNHbWdtejBQcTVzT1RSaWttSHlBU0d5?=
 =?utf-8?B?MjlDZlpzbTAydlA4NzMxNDNhVERXZnF2NHVKaXdsNFdobVpoa1JFcFpVUUl5?=
 =?utf-8?B?UmhISER1RTFqMHNnclNydytEWlUrbjV1Y3Q0M21uVDAzWVhmRVpPN3R0UFNw?=
 =?utf-8?B?bzhzVm92ZVJpOEV5ZU1TaXIxNWllMWlIUjZ6TW5wWC9DT1Q0OGdmdTlPWExt?=
 =?utf-8?B?Rk9FT0lra1FrMytodjMxQ091NGtMS04zQnpHS2dHaDRhK3BjYThSTkc3K3Nm?=
 =?utf-8?B?UEVHN3JPNFpYWVY5NmJ6TlQwWkUzdXNqL1lST1h6OGE4WGk5NVZDK1NMNlR3?=
 =?utf-8?B?cHNnOENzK0t4NXFrR0E5N21CRE9QR25ycGFYK0xzcmtJS0owOEo2SWVlQVcy?=
 =?utf-8?B?N3JyTm1aNEZwRHY1RzNPTUEzNFovdFhQZ2ZZTnZOZlA4WGdBY3AxdFZwSmpU?=
 =?utf-8?B?Y3kyWEVjTVdBVVRrZXNmV2I1M1RPSWRGOGV0ZmI1TEk5Nk9ncmh4MFRyd20y?=
 =?utf-8?B?M2FtWUtEZ3RMMTdmc2tRUFlDTUVCR2dSbEExMmdCQ0dpQXJGaHZIZzkxYXF5?=
 =?utf-8?B?K3lLczNVZEZmVld1OEN1Z0RkbTlBTndaQ0hjNFd2SEErYmdxU2E3dUJ3TmJF?=
 =?utf-8?B?bmFweDZoNm9tM2l5cWpKcWZNakpnMFNuVGdxWGZVL1BLU0U4SU1nYnYrUlRL?=
 =?utf-8?B?cTQ4Q3pzQ0IvRHFqekNCb0VyYTB2YnBKOEozWUR2c2dsZCtMWTArdUtuUmxL?=
 =?utf-8?B?Qy9FeHV3Q01JVW8zWk5McmpDZDdoNzZCQmZtTmI3MzY4NGNsQXZiNURuem5W?=
 =?utf-8?B?ZUpGcWJyYjlYbVFxWStybHJWcnpKdVYvb0w5YUJxR1oxYjVZWG8xbFAxYk1i?=
 =?utf-8?B?emZZb2toREZEajFLNmJ0dWUwaE1hUDVSWTNVeVRjRytSeFBPZHB1cE8zN1BP?=
 =?utf-8?B?dzN6M1RHajhTVjlEQ1I3ZWRBYVIzUDQ2dCtSOFBsU01qdkVzc0Q2eXo5Qmho?=
 =?utf-8?B?NXExeTdTUXRSRE1TaGZQUEdwdkg0MFYxRjlrTG1xRkJUZlhWdmtHd3R5Yith?=
 =?utf-8?B?QVZBS3J0T3VDOFhBRnQzbEZtZTFBSGJPR29RcTVUMS9FbldTR0J3UW9zRjJW?=
 =?utf-8?B?ZUxJTGtwbGJhb1pBOFFZUWxaUG0wNmlhTzJRRXdLbmhZY0VwUFhySVdkQXdj?=
 =?utf-8?B?RkZWWkdOV1hGWW9JQnlHNHdETXhiUnhYK3hrYXVtT3hmd21ndGJWQlFxNUpL?=
 =?utf-8?B?SVRNd3NUZm4zNnlJZ2RVUitVWUxoMkhzOGs3YzZPUFM5dnFqK2xsL1FXZVFD?=
 =?utf-8?B?TzI1MTl3UkxyOFpuZjZGVTgxWjZaMTNqWTdpT3RnTWIwU3VVQ2l3VFZVMWE3?=
 =?utf-8?B?RjYwbGZBRlArb2N5WHU4VDRleDY1M0FvdDc5OFBHcFJ6SktSWEpOdjlOM0xU?=
 =?utf-8?B?emJBazVTRi9WRzdRVTFpSUdYWjdQWGt3dWhpMDlqTTJRbmdYeEc5UzZWbFFt?=
 =?utf-8?B?VmpreUtWN3JYUk5iVlF6SVpDd3BxTVRCQnJzMFpTVUlPMEFLY0s1K1I0bFFR?=
 =?utf-8?B?c3BTc3NxSEJHNzRtSzkwWG11Nzc1S3pkbTR5YkVpYzZrdjJud3RNekMxakUr?=
 =?utf-8?B?ejRRWmZ6ZkNMSHRSRGFkekZWT25WeGFLeXFuV2RJUXRPNm96cjFVWDFOdVY4?=
 =?utf-8?B?SCs4UzhsQkZtSHZUMGlEaU9SRGJkZ2lqclNrSWl2d05IblZYT1lnL0IxQVla?=
 =?utf-8?B?SkxMV3B6QU1UNGdvWU9KSkRZTmNtNEo0V2hxckxlNFNpc2kwVmdGcWZ1ZUxD?=
 =?utf-8?B?aTFvdE9jTG9BaXBuWktwbkNmYkNydDdFaVJ1aDROY3ExcStwWHc5UmxYMUNm?=
 =?utf-8?B?SU5qbjhYRElxMnJqV2JBWTdBUVVMOGY5ckpoVEdSNExzeXNUU09kcjFjeU5m?=
 =?utf-8?B?bk0yZU1NekFndEFwaURIeVNUbkdSbDFMVDNVVU9qVW1Jc3Q4RW9ObmQzSk1l?=
 =?utf-8?Q?8iwp9Ebyk/2kMG12UfY3CBs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	drym0j774hZpcNHk0EiftlsdonJcjtHeqH5UFcKYs3M/gJMrQ0Xg+vpijCeoeSKyqP8Gi5e8KVBXP99dbxQUJCMAhxO8rKC8q6vx42Mef7NzJJ9wAWObyimAgpWVXN2KDwV7AMhiwncwea0ih8AxsVkee1MMEipbU9XuHwgW4jQoxP/YP1aBJ16zrWI8oQOR/12nhrZyNJXaNLiLVulkqPX+oTNydQNjijO7xTOi25qAc+WPZxZ5QmDX7MB3k2VQwOlG0sjd1QfQQs6vPhYAknt6A8gNwLuzXsDFPW7X8KdD/aXr3bjFnlcGCpHPeIVDAxQbaApco/PwXtz4ErKzHNO3+N5Bn0Qik8XzHRuvTfv5d3l5DlQvU52rLASHDMkf9NTL2eDO3ibdnir9x/pBrjqvCvIAbdlp6esNmZwnhp9iy7VenpGkUIA0ErlKoGqWjGLGOkKlAh6ztJvpGY2IW3U/fsdbR2OJPiX4sTxkasNGXRcnS7/z9WCgnBlgy9WCLgT0rvQpges6Z1U+NYj/snBCUtGKyi3fOll5kWWrj1zIK+Irbs+wpkcC7H23ZnNgrsYXI7aNCxcqfWNrGmaKzq0xh4EgfGbq2p4Ek3ST9UCQwQRysnD6r4eIfY1Q3Jk5+XcV5M0gkOmH/SrptBrpNJ/P4jSgRFDfG/2LDUm4EDlqJio0pr+FWp6JHCrapqx9fR41N8bHcRSJTEgmJyDQ7a6Od9appDdK7SgPZqJjTfG86l1xTHA2sOI1Agxgna5SZ5sPsaswc222y9eOefTx/5dl8SqXWdK1Wt67xRYGZwQRL5dOR8EWK7fuk7mCBeFyHyaEzn9vyO5yF6A/6Qg+7VyHkDtuIEp+uJEzYirm+Ck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734737b5-b6ef-49a6-2b7a-08dbf2958519
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 17:47:00.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01Zq+E5zc3KzioUh0zhzclvaQ2Xbv7gfCXseTlbrecnDF7//ZeN2MQO7ROAjAD//TjIG5F1bbRFuRaUm3xBoSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_16,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010118
X-Proofpoint-ORIG-GUID: qIFy1NDcv7U6zAGHiwr764lZzCbklx4I
X-Proofpoint-GUID: qIFy1NDcv7U6zAGHiwr764lZzCbklx4I

On 01/12/2023 17:06, Andrii Nakryiko wrote:
> Add selftest that establishes dead code-eliminated valid global subprog
> (global_dead) and makes sure that it's not possible to freplace it, as
> it's effectively not there. This test will fail with unexpected success
> before 2afae08c9dcb ("bpf: Validate global subprogs lazily").
> 
> v1->v2:
>   - don't rely on assembly output in verifier log, which changes between
>     compiler versions (CI).
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

one minor thing below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  .../bpf/prog_tests/global_func_dead_code.c    | 60 +++++++++++++++++++
>  .../bpf/progs/freplace_dead_global_func.c     | 11 ++++
>  .../bpf/progs/verifier_global_subprogs.c      | 33 ++++++----
>  3 files changed, 92 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
>  create mode 100644 tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
> new file mode 100644
> index 000000000000..d873eb20dd7c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include "verifier_global_subprogs.skel.h"
> +#include "freplace_dead_global_func.skel.h"
> +
> +void test_global_func_dead_code(void)
> +{
> +	struct verifier_global_subprogs *tgt_skel = NULL;
> +	struct freplace_dead_global_func *skel = NULL;
> +	char log_buf[4096];
> +	int err, tgt_fd;
> +
> +	/* first, try to load target with good global subprog */
> +	tgt_skel = verifier_global_subprogs__open();
> +	if (!ASSERT_OK_PTR(tgt_skel, "tgt_skel_good_open"))
> +		return;
> +
> +	bpf_program__set_autoload(tgt_skel->progs.chained_global_func_calls_success, true);
> +
> +	err = verifier_global_subprogs__load(tgt_skel);
> +	if (!ASSERT_OK(err, "tgt_skel_good_load"))
> +		goto out;
> +
> +	tgt_fd = bpf_program__fd(tgt_skel->progs.chained_global_func_calls_success);
> +
> +	/* Attach to good non-eliminated subprog */
> +	skel = freplace_dead_global_func__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_good_open"))
> +		goto out;
> +
> +	bpf_program__set_attach_target(skel->progs.freplace_prog, tgt_fd, "global_good");

missing "err = " assignment here?

> +	ASSERT_OK(err, "attach_target_good");
> +
> +	err = freplace_dead_global_func__load(skel);
> +	if (!ASSERT_OK(err, "skel_good_load"))
> +		goto out;
> +
> +	freplace_dead_global_func__destroy(skel);
> +
> +	/* Try attaching to dead code-eliminated subprog */
> +	skel = freplace_dead_global_func__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_dead_open"))
> +		goto out;
> +
> +	bpf_program__set_log_buf(skel->progs.freplace_prog, log_buf, sizeof(log_buf));
> +	err = bpf_program__set_attach_target(skel->progs.freplace_prog, tgt_fd, "global_dead");
> +	ASSERT_OK(err, "attach_target_dead");
> +
> +	err = freplace_dead_global_func__load(skel);
> +	if (!ASSERT_ERR(err, "skel_dead_load"))
> +		goto out;
> +
> +	ASSERT_HAS_SUBSTR(log_buf, "Subprog global_dead doesn't exist", "dead_subprog_missing_msg");
> +
> +out:
> +	verifier_global_subprogs__destroy(tgt_skel);
> +	freplace_dead_global_func__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/freplace_dead_global_func.c b/tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
> new file mode 100644
> index 000000000000..808738eac578
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("freplace")
> +int freplace_prog(int x)
> +{
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index a0a5efd1caa1..8ddc2f354be9 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -10,50 +10,59 @@
>  
>  int arr[1];
>  int unkn_idx;
> +const volatile bool call_dead_subprog = false;
>  
> -__noinline long global_bad(void)
> +__noinline long global_bad(int x)
>  {
> -	return arr[unkn_idx]; /* BOOM */
> +	return arr[unkn_idx] + x; /* BOOM */
>  }
>  
> -__noinline long global_good(void)
> +__noinline long global_good(int x)
>  {
> -	return arr[0];
> +	return arr[0] + x;
>  }
>  
> -__noinline long global_calls_bad(void)
> +__noinline long global_calls_bad(int x)
>  {
> -	return global_good() + global_bad() /* does BOOM indirectly */;
> +	return global_good(x) + global_bad(x) /* does BOOM indirectly */;
>  }
>  
> -__noinline long global_calls_good_only(void)
> +__noinline long global_calls_good_only(int x)
>  {
> -	return global_good();
> +	return global_good(x);
> +}
> +
> +__noinline long global_dead(int x)
> +{
> +	return x * 2;
>  }
>  
>  SEC("?raw_tp")
>  __success __log_level(2)
>  /* main prog is validated completely first */
>  __msg("('global_calls_good_only') is global and assumed valid.")
> -__msg("1: (95) exit")
>  /* eventually global_good() is transitively validated as well */
>  __msg("Validating global_good() func")
>  __msg("('global_good') is safe for any args that match its prototype")
>  int chained_global_func_calls_success(void)
>  {
> -	return global_calls_good_only();
> +	int sum = 0;
> +
> +	if (call_dead_subprog)
> +		sum += global_dead(42);
> +	return global_calls_good_only(42) + sum;
>  }
>  
>  SEC("?raw_tp")
>  __failure __log_level(2)
>  /* main prog validated successfully first */
> -__msg("1: (95) exit")
> +__msg("('global_calls_bad') is global and assumed valid.")
>  /* eventually we validate global_bad() and fail */
>  __msg("Validating global_bad() func")
>  __msg("math between map_value pointer and register") /* BOOM */
>  int chained_global_func_calls_bad(void)
>  {
> -	return global_calls_bad();
> +	return global_calls_bad(13);
>  }
>  
>  /* do out of bounds access forcing verifier to fail verification if this

