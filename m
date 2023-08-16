Return-Path: <bpf+bounces-7883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0077DD62
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7A91C20F90
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57CDDF6C;
	Wed, 16 Aug 2023 09:36:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFDCA70
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:36:26 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42FE26B8
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 02:36:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FNOaR1027880;
	Wed, 16 Aug 2023 09:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Aw54ZzWjmQ5yybDh3V4PytBFCj6YGytP9MI8mRP8MyU=;
 b=RAPU2mUEoh3QbErqTtTfRfnH+GrMO3wVTRCl2z7AgP8Nxk6zWjfsEvbwjfykR0Y7n5/e
 OkAxxkoa5Y5bfQpWqJdFEWylRUTwbCIsmsVtbRhAmWJb6yrYB8J1ja2xhzPaUVKKnVEZ
 PYrCIU+FjJXYxcFGqcH1NWglqcUtxM/FvVP8VHJnaoBP2h52DxvJwMkemKFL8eZDWTkW
 2V9K2QJuRWws4GS4L/xYSlvEQbIZ6O4OyqmjcTPHFDuFgNTQKhoXNbe7rEAJ3DzjY/EO
 G/7dIaQ7tGYgJ946dFFU6jtU3qWhE6jeww2S67R2ZIOL/azY2kv5+ffJ3zDdLvTvdGN9 mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwpq0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 09:36:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37G8GVxn003940;
	Wed, 16 Aug 2023 09:36:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexyk00u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 09:36:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzJIJeLTO5DnyhcJLwLHl+6FKhyJWGR6r6VBuwdfN3+a6NLdAnqvoWXbjl74RRxAwO3GLMWDCSEEL6GkmNpSOwmurCaVSD8KQK+OCcUCycd1RhNIb0abSQvZhijhrAu+z3+3p8F0FYK8184rDNcg/hqCODNQNXwuVDLaEz3NCeFR8VxhmYj+lZbcCMjVDC5qUMJuHem4sYkj92hOcVCJVvo8Ae/yIaiZ0A36PbelGmXxMsqtSX7c4dUuMMcZAt5yVrFqwvfT/8ExKJ2aEGOtaBZZzoo7LgAbJRQDXcUo4ueCeALMEHOi7GLfEixBvy7FVjye5kCdXOxyYV4h+fo43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw54ZzWjmQ5yybDh3V4PytBFCj6YGytP9MI8mRP8MyU=;
 b=ZRvt0D2jynSfaKSljNd4cTTnSP6EfzjG4Eq9pU4Y55MXVKRCZTqzFa/zQci48S7n5FTsaYUUT+IVZYnjTiCj5uDYc2AzdVMBjogqkbKieZkVkuLb356+HuWCfdqMqbSqDmRQlymueWQdMjOQjxMzRBpuiVlBrqOSFA4BNMuqers5Exqsbi9hwQIFFtJ5h/f+8u0T8AXcrEje6Q3A5f8+V2EZFWXuv6xbjgKpps6/BBjKXXF1Kga4RnZcXFu4Lo7iGpybLmOKxsUNYfSDO8inDxjTI+KQP3iGWCUwf7PlhkbYxo9Lmbi65sOS0yCd484BkbpObjr7BJ8CyXadXlUKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw54ZzWjmQ5yybDh3V4PytBFCj6YGytP9MI8mRP8MyU=;
 b=Yi4WWrOUN22qvJ7jffp3pRtMV7Ybe1XKKJC2vJVNixVqnz3VfpeQRFwMgM9bJd7uxUmPvh6IiRwatU1w5VsrIlxcON0rrXcQEmPVOlBliWeLhkp3NDPd5oh7Smb8hC5yzKEhSw720UHCvTVF8jfVmr/0XuaikNDDEsvgxx7yHAQ=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by LV3PR10MB7983.namprd10.prod.outlook.com (2603:10b6:408:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 09:36:14 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 09:36:14 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: Masks and overflow of signed immediates in BPF instructions
In-Reply-To: <87leec44v1.fsf@oracle.com> (Jose E. Marchesi's message of "Tue,
	15 Aug 2023 19:01:22 +0200")
References: <877cpwgzgh.fsf@oracle.com>
	<ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev>
	<87leec44v1.fsf@oracle.com>
Date: Wed, 16 Aug 2023 11:36:07 +0200
Message-ID: <87wmxv2ut4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::17) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|LV3PR10MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 30af3515-04f9-4b07-8750-08db9e3c3b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KN4ro8aGlw510hBFUPXE/e07k8ubr9hKteLh5YkUPXIgLxroM2bYsRl37dYMFcpCU07FCbzId5kf2HNgSl0QptlhP1AM2sZjMRFX0iyZeKuvyE/RAgc/qi3teqW0XvIinKA4k4FfHvdlHwlcrseFPYQIW6YEGUWYGt1Vini4JOLi4r2pHDvjZ+TB8H189HFCuxzgUZF9WvDKldGlBxynn8o1o1WFgINShX8IUTUOcOQueF1uMtU9uwkUAkcsiWnVyDufl++2w/IohagfLrfL7r2HvPARJFccxeF7iXh+RG8QBemuc1Ylb1ihYfH297vxgRiOYgCY32ETgJhjPCMYK2EgVWMWtkUrSCXSD9AopZazp4x6xSC7n+G7jsE5C58YjA3Kkt0C+NSQMwv/yn5Plhf1V3QL+JT0nBD67HAXuSCRsNNHIKewNaNS1dk/jJ/54DFXIfAn8RTYav7I4CPi3ZwFwLJm+ey/O5wbIj72BzFfEdwztO20LeDmk44cG2rvdvNQbmKrIUpYFzohjkDycVtne7PvSKIaO9T4Ufsx1tN/sCetdaBsJcsRqUpIpdCII0J7Yem8+RCaJoV0ZYcnYF10hniMFQtsF134z42apZo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(36756003)(2616005)(6486002)(6506007)(6666004)(107886003)(6512007)(53546011)(26005)(5660300002)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(38100700002)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GHr8ODp0pT4MQ0Oc4oufF5KMQa2dfzS4nwrxQeaFjiKtdSUi5atKpZeqzCp3?=
 =?us-ascii?Q?zJWRUoQHTi5zhPrBpTYf/qlUTuCwlSy6u8LhmEN7Ny2UlfXa2/lN2GwjEGZz?=
 =?us-ascii?Q?7ZHi9twlinkaVwV/Lhpi/T1iUwKsrvzES2BF5SgwdzTSgy/S9M9KOvKSbMDQ?=
 =?us-ascii?Q?W7jONwKM3Fp9niSVOrfvdQ33Jl9nJkD+6NajHgKosVdBEh1L+NKLQSDQgcAY?=
 =?us-ascii?Q?qfmSjmBVDlnM46Iojne2b+R3akOQFzpExOVMYCZE8UmcHJpSJwWG1XVG/+Q7?=
 =?us-ascii?Q?Q0whJDuiYQSIT8kd8jiGr0NT3zHvbuZ5z+/R1+u2+QNW8rgTUCvUcH6i7Kh6?=
 =?us-ascii?Q?bukdwU0QRgzWpMHVY62xhO80ibRl+G4oS8CzObGDMcnMdcQsFfX1DYCwhjF5?=
 =?us-ascii?Q?XqDiSxYp20hNrKJrZcyXjZnqiZ7DbwFMvR6UaM8VvJk1T/0QQuE9E/ploasP?=
 =?us-ascii?Q?QGMXIMvAmB09R2QcdHzoG2z78bQ/soXPRi05MIYF54D+G4rL+Dc4Oo9zd+tM?=
 =?us-ascii?Q?cvdtomGk5Mg04UwRrAwxCUREehUjV+hwawWIXMPB0UtzwOFuQV9P0R8FBL+5?=
 =?us-ascii?Q?EL60ZxRLApF7g002/VKyhp7M5akX4ZatB0S7NfEFiltvm+TAJjz6sL4vguGl?=
 =?us-ascii?Q?yTHhsQclfUBOI47EGWkpF63w7lLNJ2NaGAVvBkHRycPksrpg8yBcwxPVBh4V?=
 =?us-ascii?Q?WW5Id1YWLuusu4VJkV1FEBlTHt7K59/h/bYdoolBgl9HSrsijnt1E8SiM7Uo?=
 =?us-ascii?Q?gV1oG4rZRq6NwrWaDOhwMmNAe8UAW6SG2+uRbr5lEdmezNXfuSQVcWXx5qH9?=
 =?us-ascii?Q?wC3AUO2MXKgfTvifU9BnB0bToZYGlpCzRRO9laEQs5FGVdIK+L+5e4SH027o?=
 =?us-ascii?Q?p2vWpNbOCQPvGZqzKjo0EHE6S/PcKTzOpdFOgCCJTNuIUyWAEpSjGrglvohl?=
 =?us-ascii?Q?MenH2HEbpgCYDOtqcN0UEVhf5s5EZwf51ddMfCQZcDRgWOC5BtjLwyyhPTJF?=
 =?us-ascii?Q?KZcs0hpstDDsM6F2yNnSHP+Q2CEwgT0BnYgcxxEmroDMy0tTI9wba6y+iwF/?=
 =?us-ascii?Q?aRKlAtGIdYRbp3388xs0OSbNWr6dB8U4cryv9vXq/Fqva1eYMgjo3AoeJiAI?=
 =?us-ascii?Q?qq1AtxxMSPoY6pX91yWDGTCTOXhAaaghYAa+WWs2VvRnxTsGlGhs07kgntUS?=
 =?us-ascii?Q?1F4ho58s+QfHW2UWTk0sERl9h0pQ4fTayitMj+Lh6rC+MfViSi9AVsLBiDtg?=
 =?us-ascii?Q?ZLOEp/nKNr8BCwuSRgwFicX8wI/41d9iHDC40pqs/EXeEPfPEVmiylvrBq2r?=
 =?us-ascii?Q?ynInNI5hoJx3mCLEeSMM5nzh5i9f+055CWYylZl3zpR/ZffrYRMj546ffjXQ?=
 =?us-ascii?Q?+gaU+ySUvPp1z9mHJrO7eW2BgLnoAJYm7cJTMShrg7IL85RyBGC3V9hzQaQ0?=
 =?us-ascii?Q?nnEYVNJll8cFU3TkQflc60nVcOKK4rfZcQpjZBQi+Z1Wzi1dgDNfN6tC8aEo?=
 =?us-ascii?Q?IoeJKu0W57eVPifc8Kgy3/jJMC7vByTgNCL6VswKMg0BlRdxGPvgS5V8vi9j?=
 =?us-ascii?Q?pMVUXX9eZEoVfm8K5yP37MMg/jISMYXJnI4/0p8LzggIw4/aFiQ6cp3UE+9N?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nv5vTeCYjOplwqQ19eoHGP2WCAd5i16WNIk/EqqDsq7pl9B+COrwhmZClX15ay3bzWHJ286et1bpUMZb2Adrk1/wSJtVmuKZUuTwrqEh0y3aOcMG23I2ads30H+saOq2qwKAqfoaSTXZI5HMNA+pnZ9NfcADpdqUwbI85nOeG02UKW4n3wM7bv8pVCYObxEsAFvQCdfYQLdXTWmJov8hnbti6VsrZ6FDfFSTHMENaikGfKAqk4QIygwZnkHus9dBCxTkY4FWPQFAnHW9jl6/7pN0rsZBDN0kA4TAe/TmPrbuAp36acqvqje6mmTrcPMk/YRNgrApG1QpnSoqT+tqjziUZE0AaCRjBt/haNtjtZ1liSghO2aaJxD36nUZOBvZ9w7z8I41ZjEa976/OeVYhkjGO5pEkKitVysZo/OlTsgkkOFdzcyy1LqZXKkkZgAUHAM5ui+Yk/MXq/BZ6GGj3SM5aqZAS4zepkl4o63IHwBrTJuWM+3/Qf6SgD/zYUTj5S8mMUJjhU447LLyVNImhV6HiajiwI/voaSzOZZtAC9WXvYvoZL0TX+0LUoqn+lefs+0VqLRFJ1bWq8r5kLd1pkUlG3owOw2+sUxS4/zZAcQtU9QQRARXxrbvIWJzEUHFMquya/aqXxe0eubTsXe0fieQhIlWOHHTfXfQDJfK0hIDS8VHJolOVUDA7GQXw/TObxrHKdbjLGki4LxV6V2RTuuKWfaSpnYQ89nYHD0peNviwXtJ8YJREYApus7Hse5bqcgUWKypl7ZN69/MiXOSAuOmK4gASslfJCIgDXSo+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30af3515-04f9-4b07-8750-08db9e3c3b8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:36:14.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDTZksmuKeiv3OKDUlLrMJBG4gm/V7l6foyQhopE1Yq5qW7/l7xv4ue3iORAVOiDtcKxP+iHkLrvQCjs3tkr9HQSEfLAd93sXCYTtUQVGFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_07,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160085
X-Proofpoint-ORIG-GUID: W3jq_ms7p_6B35nFYaEbSFEhnrgiWgHp
X-Proofpoint-GUID: W3jq_ms7p_6B35nFYaEbSFEhnrgiWgHp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> On 8/15/23 7:19 AM, Jose E. Marchesi wrote:
>>> Hello.
>>> The selftest progs/verifier_masking.c contains inline assembly code
>>> like:
>>>    	w1 = 0xffffffff;
>>> The 32-bit immediate of that instruction is signed.  Therefore, GAS
>>> complains that the above instruction overflows its field:
>>>    /tmp/ccNOXFQy.s:46: Error: signed immediate out of range, shall
>>> fit in 32 bits
>>> The llvm assembler is likely relying on signed overflow for the
>>> above to
>>> work.
>>
>> Not really.
>>
>>   def _ri_32 : ALU_RI<BPF_ALU, Opc, off,
>>                    (outs GPR32:$dst),
>>                    (ins GPR32:$src2, i32imm:$imm),
>>                    "$dst "#OpcodeStr#" $imm",
>>                    [(set GPR32:$dst, (OpNode GPR32:$src2,
>>                    i32immSExt32:$imm))]>;
>>
>>
>> If generating from source, the pattern [(set GPR32:$dst, (OpNode
>> GPR32:$src2, i32immSExt32:$imm))] so value 0xffffffff is not SExt32
>> and it won't match and eventually a LDimm_64 insn will be generated.
>
> If by "generating from source" you mean compiling from C, then sure, I
> wasn't implying clang was generating `r1 = 0xffffffff' for assigning
> that positive value to a register.
>
>> But for inline asm, we will have
>>   (outs GPR32:$dst)
>>   (ins GPR32:$src2, i32imm:$imm)
>>
>> and i32imm is defined as
>>   def i32imm : Operand<i32>;
>> which is a unsigned 32bit value, so it is recognized properly
>> and the insn is encoded properly.
>
> We thought the imm32 operand in ALU instructions is signed, not
> unsigned.  Is it really unsigned??

I am going through all the BPF instructions that get 32-bit, 16-bit and
64-bit immediates, because it seems to me that we may need to
distinguish between two different levels:

- Value encoded in the instruction immediate: interpreted as signed or
  as unsigned.

- How the assembler interprets a written number for the corresponding
  instruction operand: for example, for which instructions the assemler
  shall accept 0xfffffffe and 4294967294 and -2 all to denote the same
  value, what value is it (negative or positive) or shall it emit an
  overflow error.

Will follow up with a summary that hopefully will serve to clarify this.

>>> Using negative numbers to denote masks is ugly and obfuscating (for
>>> non-obvious cases like -1/0xffffffff) so I suggest we introduce a
>>> pseudo-op so we can do:
>>>     w1 = %mask(0xffffffff)
>>
>> I changed above
>>   w1 = 0xffffffff;
>> to
>>   w1 = %mask(0xffffffff)
>> and hit the following compilation failure.
>>
>> progs/verifier_masking.c:54:9: error: invalid % escape in inline
>> assembly string
>>    53 |         asm volatile ("                                 \
>>       |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    54 |         w1 = %mask(0xffffffff);                         \
>>       |                ^
>> 1 error generated.
>>
>> Do you have documentation what is '%mask' thing?
>
> It doesn't exist.
>
> I am suggesting to add support for that pseudo-op to the BPF assemblers:
> both GAS and the llvm BPF assembler.
>
>>> allowing the assembler to do the right thing (TM) converting and
>>> checking that the mask is valid and not relying on UB.
>>> Thoughts?
>>> 

