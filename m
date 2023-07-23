Return-Path: <bpf+bounces-5690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D975E4AC
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 21:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165882815D2
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044B4C7D;
	Sun, 23 Jul 2023 19:58:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A392108
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 19:58:09 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64BF124
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 12:58:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJ08Se009866;
	Sun, 23 Jul 2023 19:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kjvvgczq9fKcnFW3k9L4N1cxdljzvoCTcWJ8iGc61RY=;
 b=dXZRhhHClEH5dtlc+AKweUTBzvzFFKMb05k2BsedG4hfVjB9QpUxOx3hNH39aJAoM/PK
 5V5i+JgQxAThxdBPbmD9vTtG3YjC3Mr4RaNRzCcLa694wqbXiYUqS3AwH2E0VdKWhwuI
 7bV2q7TejgGE4auNa/2wbAkPAf+dt95ZREj+hLN4WC9SoZE2laJURKxQJy7hs78Crcp+
 j9ohs+K1lntVTCJ+hB7s94fFG4D8zebT4kpBhAShmge7r2uK9AY/D7MyU/Vi6V6pACnh
 6k/pSm0Cud2yKK0HdeB9W125NMtNTCnGOVs1vAGKUpgNGAXf47ELZ1D/prtiGcAlEi7a LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1shc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jul 2023 19:58:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NEgXgS028815;
	Sun, 23 Jul 2023 19:58:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2x4fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jul 2023 19:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5uZOcDFCQr9E3B1Hm0fUY0htxB16YTPX3taRMRgFjhiviRejOHCdsU92AGMDj2r/0YmuA0GCYkURAnl5DzWnvk6m9T+U6iE0HbcqypO1x9YPUJGZd/QGNSDlBrBwKEkHUZUrj8qNBVLtOfhanwHuuxm89hhY1IQHn9Y80nv/nRXD11BG9lGm20Y5DTUJtjNWhWodZLGHVSjp3KdmcZAxepQ8wmHJ6nGvsAC8uRbmS0N32/EnFe+m1PFVKGzih4oz78RZOarhaEeIpRp1a1Gb2a4Cz2YPSd4ksnHHy/6FGZvA1rLt5iAyEdMJyhs50VQlxqoz8r9T5y1D/8QJr3CCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjvvgczq9fKcnFW3k9L4N1cxdljzvoCTcWJ8iGc61RY=;
 b=PR/Yn3W7d2NqgzHLlecb5/X6B+pSDNJpSwyHE7n56led/eb3lNiu/8hmtWtWt8EdSEaJ7JHrXROcODnucba8g6yMfDCxm3dcQhMF8bw0yLeFDSOIXmoT56GzjqrPg5UnbGZbXAUYAihEwgZa3IWodyNclW/04Htkhl4/moiyXoh+sZh/FuJle27D2GP9/HjZi8tb0ouxZcnHmgxBlrR6aNr3ooxj3FWKcWNvry5TvoQPWnsipyrbmxHNO+SN3zC0AxIjGW2qM58foQQ24LhnmTCNv6oCzurXD0DWgpVymIiBeas9D8RXHbDkPD/pQkAz4535ur8S0YADRAhwSdN2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjvvgczq9fKcnFW3k9L4N1cxdljzvoCTcWJ8iGc61RY=;
 b=d78xIzFXp+cA40tPfxD2TK9tWnhncsamBxuVjrHdYxf3RWkgyPy/Yv5pCEQkWUimlApvqANVrnz4OJic3L9xTkHLPG8cdTL7Rv2GtYZDOzpzCauZz3l4N5xI9blLwGs88fjn5vz//jGQUEosG2JXInFe4EhTuyuvXS7pyqJqZkA=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 19:58:00 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 19:58:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Subject: Re: Encoding of V4 32-bit JA
In-Reply-To: <ee97e19d73fa460bc37004baf01bd5f9fe6f67b4.camel@gmail.com>
	(Eduard Zingerman's message of "Sun, 23 Jul 2023 22:21:19 +0300")
References: <87a5vp6xvl.fsf@oracle.com>
	<32dc8c48803ff047266ee396fed3ccc9f7f0147e.camel@gmail.com>
	<878rb6qw2h.fsf@oracle.com>
	<ee97e19d73fa460bc37004baf01bd5f9fe6f67b4.camel@gmail.com>
Date: Sun, 23 Jul 2023 21:57:55 +0200
Message-ID: <871qgyqu2k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d44d170-ea8a-4114-f42b-08db8bb71db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l81zD2gNgJA5nMxjuPBtxZ2sPHjU7mTiTMdAzJlfmIcrD7miz+iOZr5vqLFUr+8GWB59ViN00p7cdo6g2tSLxVjgG8S5diAw0R+mJAbaz+MVTusXr/x3Sg0n+jdZaZv5Mrpo8rO+ojv91FXYbXSGvmZLnYQmTPACcCGvll/Bekz/RnE9yGanJPZcmY/cv+pB0WQx6yP7Di6yBoR0HYnlU2lckfJfsG+atUoc5Z2dqfxsR2iNBCvCRXBsxki3G+xLgp8F3ZOqKy2vydXthN9x10IW/uSEywiuyp8DM2R72BuD0hlNKOXmq42j7l9FXZs4VqNNr3at9zYcVD3ixNN6s2yDPSuio/aHHu1vd92MUMJDvOJpBGoWYBTHzxzRAw0/rOb+nAVG09Na6fn+6a0cgVWiztYwvg5+dnKoP5XwPlH4RjgNX6YBoIEk3TWXsKozcomAcKp/7FDawT+gXa5MS1zrMxLt4Bh/NsmeMOzZoh9UGEzur8Ke4/jNwk7BAYQ7z27eevrEgKkxVoOR4jXnXxHCOU3pqWvIuf908Vm8A1irnUB53qk/kPscEyxpAkBD7MeUpYh7GVieHozluirEeQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(8676002)(8936002)(478600001)(2906002)(66556008)(66946007)(66476007)(4326008)(6916009)(316002)(41300700001)(5660300002)(36756003)(38100700002)(86362001)(6506007)(186003)(2616005)(6486002)(6666004)(6512007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXZFVlRhemt6bGl0Si9jU1g4RU45RXdyZWtRVkFYRVFyZ2J4Y011ajAvVEha?=
 =?utf-8?B?aXdmVlNnQnA5V0tTZlZkODUySHRzbE5KZWhackJyQzF2YUlkS3NrVTBjYW5S?=
 =?utf-8?B?RHdqa0J6bVVQaFdFaytreVB0OWFlUE5oSGxpNW5KUlRCemJBUTNxb0JiMXYy?=
 =?utf-8?B?SlE4UWxMWTNLS0tRRnRPR1NlZU1ncTdwWS9qK0ZEcXRQblQ2eUR0UWhPZ05H?=
 =?utf-8?B?Y04xV0s0ZENUSGJhTTM4S2VWKy9FWERWT1hzWlNkd3pvUWJ5bnVZdU95dEV0?=
 =?utf-8?B?YU5tQksyT0ptVmhEc04vS2x1ajBYWnhia045UzRkUGx3ZCt2OXpxaU92bE1F?=
 =?utf-8?B?cXBPSEd4elZWOTFyQXFRekpoMmJIQ1hxOVFXbmFEMWdPM3JSWTF4NEVPQlAx?=
 =?utf-8?B?dmpCbTdXaGdUNmtBaG1acDBEaVp0WlhDY0FjTGY5OGZSbDE3M3hNdEJwMWxD?=
 =?utf-8?B?SVUxcTdMdEpDZWthNHlOcEFlais4ZmxxSmh4aitnNnp4S3JUeHpSYUpibmFY?=
 =?utf-8?B?VFRSNU5hcDJ4bU1pWGhyL2FVdGhmME9iRHQ2ZHd4OTQvV0RTa3kxR09PUmRE?=
 =?utf-8?B?N3BQcUcyYkF2TWRvc1ArbERiS3UrMWtJTlJVa2FNZ2ZISHlmRU9uVnoySmIw?=
 =?utf-8?B?bURENEZqSjIzc3h1ZlEyMGtLZndFbjF3TGRTeE9jeWhsTHVsNGZ6UTlRQjVU?=
 =?utf-8?B?aFBiZnZwNndpcHNDUHROSUtFMk9hSW1sV0N4M3hSZGV0QTBQTkhsQzg5Nmg0?=
 =?utf-8?B?NWZWT2g4WHJEZUF2ZlNzbGtwSGtYK2w5dDNxaGltUnVPVXFLNTlFRGU3Zy9a?=
 =?utf-8?B?SHBhNDAvZlhnb1RlanZzVWVtalVnOGhiNzN3aXhObHVMbXR5S0JnU1JJek5J?=
 =?utf-8?B?TlZYcnVTQzVQVmhicEhKTnJUaUkvTVhvZ1dreUcwYkVkeHBZOHkwSzM2WmNK?=
 =?utf-8?B?ZUZpQXlvMmZsSWFVZlJJdGpGSEdMQ25KVXVHRXlhWENBTFpxeVZIK3JiWkhU?=
 =?utf-8?B?Wkd2L0xDTjU5bWtoRHJ6TTFWTGFxc2JleWJPVjdLMS9nQVEzVzN3R0ppTUQ2?=
 =?utf-8?B?T2FRMmtOR2NHT3Y3VHIrUThjaFNBUUFZQmdPaWtqSzRsREQxSksrdmwxb1l2?=
 =?utf-8?B?MDBDbUtqVEQwTDl0ejAwSW1jRHNTb2owSnRWQVVLZ0pHV3FXTlhZbi83MFBO?=
 =?utf-8?B?NGdQSUg2d1QzZjUwbEM0Vk95V0U5RXEyRmJxenFwRGNzWVBVVXJzdkVwOExQ?=
 =?utf-8?B?R2F6RnMzU3pjbnltOURsVnNtZ2NBenJJdEM1cHF3OUhkbkYwT2hETHIzWjN6?=
 =?utf-8?B?SG5LZitNajhTY2JYTUVRazltNWJYbDcxbjQzL1UzZ0Fta1JIRjhjZHNzZWp2?=
 =?utf-8?B?WFNTNlVHZXRBWUdhY2lFRXVhUStaU0p1aDcvTDhsV0J0QlBIUndEdEhKRk12?=
 =?utf-8?B?VXpVMDQ5YkRpczMvT25RUXNUUXNsVlNWd2NiSmRMay9ZMTFuRlFvNVluNU9x?=
 =?utf-8?B?dFJ5Rm90NTNsRkh4TXE2R1ZzVHh1eFVKTkMxdkxTcEx4YmVxQndsQ0hjMit2?=
 =?utf-8?B?dC91bVV6THZLNG1KbXRRc2haUVIwU2VDQk5rdG9iZmtGT1d3VFh2aTI1WmZT?=
 =?utf-8?B?UU9KT1pENWZpUUYyVHRzbXEyeXFiOVFNVWV6ZEdOTVBEY1dKS2xsZmZRM2N3?=
 =?utf-8?B?R0kxY3hCU2hoRTdvbmg5eVRub2RQeE9IaFJXdnRyU1BtWEpZZDl5akFTalEv?=
 =?utf-8?B?eWNWSE5TU1pUK2J6bFU1Y0g3ZTZRWnlLUWw0dmhSMEFObEl3WkpCMHo3eVJx?=
 =?utf-8?B?dWRnN1RiL056UnJqMHp6TXlQMXlRbUZVMVlXT0VVTWtUaW1JRnAycWdOTXVv?=
 =?utf-8?B?S250MUR6VHZpWGlCdldVd2hpcjlFUHhSUlhhdUJORmpwYmdvc0M5Z1lENUg0?=
 =?utf-8?B?T2FTSnJoNDNhU3RmZ1p3THFFVkQraVhLVEN4R0Q1WTI2bnVTMEk2MWwva3Iz?=
 =?utf-8?B?N2pmNjBvZUdpdjM3S1U3S0lCOWlMV1RrTDlKTTU4ZHdkN3BLaWovUEJRdk1n?=
 =?utf-8?B?Q0Mzem5HellzY1ZBbGRrRm1qbE9WNTRPVHdtODhLVjl6ZFp5dU01bzVPazg1?=
 =?utf-8?B?R0czL0NBamxScVlJWXV1ZUR2MExheFBoYlF0L3UwVitmOTE3NHBqazl4UDVr?=
 =?utf-8?B?aC9rSGY2ODA4QzBrcGg3UXU3dFNJZXhCbUtVVmdDTjBGY0ZqUStxQ2lVYk5R?=
 =?utf-8?B?ZEUrZEwwZWY5V0NNN3pIOFlXREp3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kaUJHNUDL4MjaR+ZaVT3LGDyWwxA8EEDznoiRndONqlzh7Ljyxff0qRHJiAOJph3hU38bPgHviYRe4z9jwxN9Yk1eLJrqf1zsKEKqN292NJeq+iLuHQk2vHDWb0EZm8QLd4FluHbo4HOOTflo3MRFkicVIXw7okMi8VJTNLfKZCTnq4/iP8ShC4VpE8YQBrNisvvV7VVArsx0LDpPyEFOspzKbVOyyHDavDfuoq8PPOKg+fSKXaPelki7Cr4Pt5Lh36P0Qx7rGJrfr89dmcqzfuqC3aZ2KN34YDnlYD0LIKGrKTRnUCGqoEmAj0xkVxMyo1wmZgjLtnzTFL2Q1b6fSkPHeUKCmqC486uXzszDkHAlw76T90wrZvBSZyZBT8euQMQy7nc8sChpfDmYZrKymRaGqXdzDHHCOF51tGAlxeDai/zaVFwdWDrXfs6K+IQo0Bk2obRZBQE676yfFPLgRTvLTyZvkrt4QqRBAf3pftd2rmQIElESm6F4crFYT/USGGIKl7n9wWD7n4xIqZyfrcOphlE0E2Gkxky3rmxIspZlHI4H2fSeQ7uLPRoqKaOhqIIvD7DMjIomTZQoPbch9pQm5a5pl94uY1GZyIIu7OkTYPeYQkSTEdkSftUUMYYJYhmS8xuGVyl8L7/R2/Sj/VQ24UAtkkj6jALm57QXO0l6VmF5A4LNflnsMIx7V8mmNkLIKpWPdy30jo7vQdDfSgXO8V5Y+QmpEqxlFqdCBjukgT77AIzkwYw54YvwGrDN0pg0gPQJB/bSEGhLIgUVVzeGL44fZ0XUF7l4HopPVI4n+KRagjD+9CJ5tzJJW4Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d44d170-ea8a-4114-f42b-08db8bb71db7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:57:59.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/XaPFRYM8YThM1OC5q8WA1URS2sZMY2KJUFvDTGZ4AignVCWNJ/PqZBQP3q13yXtYjs0zucQQ47rZq56nQsnBw8hZ5i6uJFXzn/MTy8XZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=898 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230187
X-Proofpoint-GUID: MSfrR8aZlV0xHdQ8DTHpsIlEbg5ih3jk
X-Proofpoint-ORIG-GUID: MSfrR8aZlV0xHdQ8DTHpsIlEbg5ih3jk
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Sun, 2023-07-23 at 21:14 +0200, Jose E. Marchesi wrote:
>> > On Fri, 2023-07-21 at 18:19 +0200, Jose E. Marchesi wrote:
>> > > Hi Yonghong.
>> > >=20
>> > > This is from the v4 instructions proposal:
>> > >=20
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > =C2=A0=C2=A0=C2=A0=C2=A0code      value  description                =
notes
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > =C2=A0=C2=A0=C2=A0=C2=A0BPF_JA    0x00   PC +=3D imm                =
  BPF_JMP32 only
>> > >=20
>> > > Is this instruction using source 1 instead of 0?  Otherwise, it woul=
d
>> > > have exactly the same encoding than the V3< JA instruction.  Is that
>> > > what is intended?
>> > >=20
>> > > TIA.
>> > >=20
>> >=20
>> > Hi Jose,
>> >=20
>> > I think that assumption is that `BPF_JMP32 | BPF_JA` is currently free=
:
>> > - documentation [1] implies that only `BPF_JMP` should be used for `BP=
F_JA`
>> > =C2=A0=C2=A0(see "notes" column for the first line)
>> > - BPF verifier rejects `BPF_JMP32 | BPF_JA`
>> > - clang always generates `BPF_JMP | BPF_JA`
>>=20
>> Makes sense, thanks for the info.
>>=20
>> Do you know the precise pseudo-c assembly syntax to use for this
>> instruction?
>
> In [1] Yonghong uses the following form:
>
>   gotol +0xcd9b
>
> But it seems to be not specified in the documentation for the patch-set v=
3.

I will use that syntax in binutils for now.

> [1] https://reviews.llvm.org/D144829
>
>>=20
>> > Thanks,
>> > Eduard
>> >=20
>> > [1] https://www.kernel.org/doc/html/latest/bpf/instruction-set.html#ju=
mp-instructions

