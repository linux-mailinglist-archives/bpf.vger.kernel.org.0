Return-Path: <bpf+bounces-5691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D975E5C3
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 01:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF861C209B0
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ECF6FC5;
	Sun, 23 Jul 2023 23:51:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC843C1C
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 23:51:27 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360FEE5F
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 16:51:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NKSJM4023489;
	Sun, 23 Jul 2023 23:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=P1J1lEdfPvEC+8iGN1S7nT+KcJfnGC+v1Gu0Q0v8Jtw=;
 b=JTJD3NQCZDKg9xIjEQ695pagjJgu6izLMjarziaqRxCq3kGJ669MNJZr7ranAuucdV4o
 gaQXMlhuubNVJn6cII+p6jDJAyk5RjDWPaq2GMlKtPzSJlAmU3+E6FV4FzvXWfBZbi6p
 MpTs2Gk5v/DtXXE2ankBC4LBJQX1n3/qDE2+kz2Z0WHvpIt/MJqNUV71XilXEQ5e3S4K
 586nUvxhbZKNZp5Cko0V8lFnbVCI648OruFU3mh5cBlv+krLguzpZGA6OuIDWmvfsZEJ
 qCzPnCAbjpr20JSviiLdbG2zLYnpy47ilFgUmDS+wxEG5wC87mYXXdTpLFCSO5OYCGsW 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c1n4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jul 2023 23:51:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NKVkhi027516;
	Sun, 23 Jul 2023 23:51:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j91he5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jul 2023 23:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0E7NAaoNzXHdkSu0RXxOMdQLZPcuvnsLK21qQaHhDz40bCEnj2dPnfB8G/Zsq+NWIvF0B1b05+2JbF7HjmLnOEGS5JdYtIV9xLeZgy0YT4diWrldy9B32scvW4DQhFCBmJl7W1oaDlIRGDN0XAbSRrE0AmBzVPozyWEBPztRa0V/PHLQWFCOusvNdrKeTvyNYMMV+ZMav6Ei0Bwn9O5O6iiW0na5TEkN1stwbflmNUHQ4fP+ZoW7H1emghuRRO4rT82HHm82PAX1batBibbySMIFIW5K1ijqkgEmzg6g84C27Mi2sJ0cJWmNImpn7M/94pB44HUDmsx5t+mKh4jTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1J1lEdfPvEC+8iGN1S7nT+KcJfnGC+v1Gu0Q0v8Jtw=;
 b=Bb+Tyz0nhlrgmHUpN0gO1fugBBcVtLnV1D4IEjwZMY2QcvZm8nndekaD/0WGqwhKZ+1Oji8rV3nSGWF35uJ8YowEycmnB0QxDkFat6MGq2N/jX2VDtHbtQSDdPN6xeoX5dAroxrfbGhun7G3QKz77JVJ9YCBi8hFczuJAvnBAUigz0WlO96s8sJfxyhFgehkcUpVvEiQiyvy5a/2RS7zBs4fOEzshc6C6vE76QKlX+v3A+YWxWYlUt8OBrC68zUjt2NH2NUtAEDduLtZnFWnShD7X1emnRZOvMBb8TdDIBmDYiXzwIjkCC0YXSbwq7omSlqcUCGN94hTrG1A5xdi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1J1lEdfPvEC+8iGN1S7nT+KcJfnGC+v1Gu0Q0v8Jtw=;
 b=IJD0H3LRmAA+CF+aE2FCn/9pGWFWKsyAlukO+a33efkBc0cWW7zK81Edf5OsV2MrlmfE4+K+AfCd/TGdkAwY+LOQW83QNcZAIAwyYju/YD3dhs+o9rC43zEB6hXDgZmEb8xnBs+tQmLfDTDbrrFC5Jp9j7Hi+96HIr/kZS8gYoI=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM6PR10MB4331.namprd10.prod.outlook.com (2603:10b6:5:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 23:51:18 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 23:51:18 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Subject: Re: Encoding of V4 32-bit JA
In-Reply-To: <871qgyqu2k.fsf@oracle.com> (Jose E. Marchesi's message of "Sun,
	23 Jul 2023 21:57:55 +0200")
References: <87a5vp6xvl.fsf@oracle.com>
	<32dc8c48803ff047266ee396fed3ccc9f7f0147e.camel@gmail.com>
	<878rb6qw2h.fsf@oracle.com>
	<ee97e19d73fa460bc37004baf01bd5f9fe6f67b4.camel@gmail.com>
	<871qgyqu2k.fsf@oracle.com>
Date: Mon, 24 Jul 2023 01:51:12 +0200
Message-ID: <87lef6p4pb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0018.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DM6PR10MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a56dd49-8da0-489f-0172-08db8bd7b55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DmxL4RuYy9q8tBS3vEYNW7GzCPquMaOM3HWerbM7jpE+MJ7nzdHP2fJOwDMUvgKBWWenUxtTnc5Ny/PdXTKMHgAzRnLFYSaO6Mn1vrYm5yNkxXS6fAqadF0/DjFf90Ggxwt/DYdBsv3jQDrI0pakM+L1zktS9FKBrgJVqXeJKf4Zhqjj2UKk85evzWFEV8FB5X/jYLoAp/k5VI05Ffw52eYpb3y6KcXSEK98y0/imG3p4p0b6QOFSi2FfS40cCw2MIxrAwX9Q2QN7quDmQK7N6C32o1vi6f1MQ2OmK1VXp1ofhydUAZ4gWVuptflECsEvIGJFvyYQ/w8OO+ZWtpkms3Ie62NzFKFVrASVelAria98EgvJntfL2ld8dP88Hkgx8rY8MeVC8tbHbq4QtNEvOyFZCDViz3eQSp3/9ZeHlFOm0bVQDeMbQI1+ms1gnii4tyOY1Qwz8K1RwJKiiGc9cHKtAuU6KT3z1ZUHhsFKjeUQCW7p461JikJ5NjOEm2mqo4if1CO2KXsFU78Z7xO52DAvZLJg5roCYwAt34fPVe9x4sIplF+41SO39wS+Nqy6O4Dx8nd6BqqTZYaqGrkTg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(38100700002)(36756003)(2616005)(8676002)(5660300002)(8936002)(478600001)(66556008)(6916009)(4326008)(66476007)(66946007)(316002)(41300700001)(186003)(26005)(6506007)(966005)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmJvYjA1SDNKcjZBNzBPZXg2czFPbGl3WFhQTzQxZzBDTjlMSkQ4MnV5NFNP?=
 =?utf-8?B?WFVwbmZBWHdoK0pPR3JyM01Sa1hxRWR0dW5EbHBySWlRc05iRENhQ0NzWlpv?=
 =?utf-8?B?RCtoYTZHNklxTVVITzZlcHVGYU5rU1RQQlR2eC92aGlNV3o5V0Jxd2FFWnVS?=
 =?utf-8?B?L3lad3ZGMHhtVGxTN3BSa3lpSm9nTjBuaUZabWFiVVBLZkhJWXdPYi9zbGdB?=
 =?utf-8?B?aC9sblpNNU5qczhUYVVSbWlSbjdnOHhaZzRjWm1uaTFoK1pqdDh6ME0reEV4?=
 =?utf-8?B?Q1dSYnptdU16WTVodllFQnRPTUViM3U1OG5ndUo2Q1pSZG0zYWZPTW9nZjVU?=
 =?utf-8?B?T0RZSUJ3VmsyVmFpcWZib1VoK3NsMk0xZkIzdXRzZWFOM3VBZkhiREY3Zi92?=
 =?utf-8?B?R2w1akNDQUtZaUFFSDVGcnlDY29oWkRiVzBzL3RiQ3FXR2VPeWlIY2t2QkNM?=
 =?utf-8?B?aUhkcVRXeXBVUWFxMXV4SDNENk9ac0xlUGdCUFRSTUZBemZlTFpwL09JeUg3?=
 =?utf-8?B?VGtSeHlPVkNPSkowdFFKaXI5a05tK2FNTFdYUkl0VWxWUEFCakFPNGdwZnU1?=
 =?utf-8?B?b3ZuTjBxc1U0SHp4Q3J0QTI0VThDcFVyTDhiVDRvbU1xekpEeTQ0SWs0NG8r?=
 =?utf-8?B?T25UdFZLZVdNbTNjZTgzbEk1R0xSSTM2aElYMnl6emtiZmJEc0RFcWs0Z29x?=
 =?utf-8?B?ZVllQ1hRaUEweU9xVDlVeXpFUVlvZ1l4aUxJd001L0FPekljbnBnQmFSa0xH?=
 =?utf-8?B?eUNob21lMzFibXVsRERzODNZT1ZLWjZQUjJYVjdQblZWRXVTSDNrczlJUVRn?=
 =?utf-8?B?SklsOFovaW9ZTUtRN1IzVjdiQzdObEhsT2t3dmVUMEVoZ21lcTBxNEJkdzBE?=
 =?utf-8?B?R0hrWWQydzlFb3h6aS9wWURndVlzOHd2L2t4SWVjQW1EV3g2SUdGdlRYMnBM?=
 =?utf-8?B?VTdqS2V6S3hKbE9Ia29ReWp3S0NqODJnZXpJa054dkI2R1FSdnlzSmlmanhH?=
 =?utf-8?B?ZlZiRGJkcWFiOUhmZVhINk1mRmNNKzZLQXlydFM2WTY2dXFqa0FMN1RqM0p2?=
 =?utf-8?B?WERiRS84Q0lORXM4S1I3SitHeVE3RXlNcy9uUWxlTHErcjZzdnFsaEN5MFB3?=
 =?utf-8?B?NjZHMGFPN1lmME1yalJhWnlYOW91c3I3TWNTSER1Sk1hZ2p0bVBvb0ppSVFW?=
 =?utf-8?B?dFNpWGpFdFc2N1VMaXJaamJ1M0F0QmIybjJHOTVaUWJhZmZQWnQxL1grVm5N?=
 =?utf-8?B?YS9ZUzFSNFdLWGo0NTlUK2FWWnRscnppM0cvYTZsYmw0VnFIdE9pMnFOcGpu?=
 =?utf-8?B?MTRTelVoN3ltQkoranBtYWJjRW43KzlBZlNKdUsxK2pLVzY2S08xbTZreFlR?=
 =?utf-8?B?VldDMkpCYzFZaWxXd2pZellWZFZDY1VQYXAyTHQ0b2lYZ0FUVVpYMGc3TEVs?=
 =?utf-8?B?eXZxZmlUSlBOWjY1K0F3UUEyYUxkSnBHWFN0WXB6R25kc3dWYlJVVTNRUElk?=
 =?utf-8?B?OU9nNXRSNHR5NEFSZmFtUy9EcWgxQXNYUlBWRE9Sd0RhYy9LZ0Z3cVphRmVE?=
 =?utf-8?B?QmJyS0F1dU9aYTNBQWdreFpqb0QxN2kvbGZHNEhtNFUxZjVodUg4WTZINGRZ?=
 =?utf-8?B?VjhqSm1QUUhKNjBkeGhJVVd4MkRQVisxajFiRkI4bzgycjhwUjBGTGM2STVi?=
 =?utf-8?B?NXlRK0ZPNXZRUUp6RGdvdlpJNFNyaG1ZdXV0TEFpV09OV2VZdUM4eFBxMzF6?=
 =?utf-8?B?c2Zwdk9GTkxrSUpHWFJiV0JHcHNHY3liU1V5RDcxVnd6NFVhTk1hOWxxRlUy?=
 =?utf-8?B?L2laKzJ4Z3Jmd1A5cDhURURoL3Nvd05nZ3kwMmxrK1kvcFdEdWp2dWdONkQv?=
 =?utf-8?B?T1RGUU0yT1ltMEhHdkxLcWl2VERMdGNMSC9mNVBTV0dWMGZRTmN2UGFUL0hW?=
 =?utf-8?B?RzE4Rjl3bm9Db29BczNrVmFGVnl1dzFjYTN3eURZdkpUWXRuMjZmZGxTU2xQ?=
 =?utf-8?B?V1pyaUpMaVVBaUxpd3VuNjNUUmU5UFVudUU2MTZHeHlGSGZyTU9SZ3JBMXBR?=
 =?utf-8?B?VG9oUlNxaFFKOGU1MW1kZFlPZ0EzQnlwQXM5TnJJb3BadFl2My96NWtBN2Ux?=
 =?utf-8?B?WWpldCtSK2Q2ZUZPUTdSeElRNWdiMFpBRG5qSHBXREkzekh3eDRIOHhaUEhU?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KWNMj3kyuGqL9OooMrklfQEkvtnWu3pdok2xeYyjIuCZ3Cdh9LURE2NTsB1fAChQd3jA/JdTM3Oxg7S3ic2hsK/d6ssHdfqXdOQ6K7qvrKBXZcX6wap2qNOdCI0/tZmoRmvTaENNwR/nDsuhrAUXY4P6XNGj/aQuCsonufrV31PkBxKvmBo6W4PKr9HOe+BUFlQp4BrlHcGkocTRYx8QJE/diDUVSBXhIoTkME9MhMcLQOHXFrt+T/eGAGmagWc8I0hdPqWbliEOfaThxKMiHw1TNG+7Vf6WogWsHMFxKbLPlV4SDCDQXZK7UEXOZNL9A2QIG4gf9bAiM63i31q7ai9Lt9bB9V0EcdNi/wFuMky/k8bNKWLJcZNWPexpwbin8jVkb/s0cgtt1dmpuOQMo/Y+Dy9dJ5hRLkZtIB4iMXsql5HyMjinLvjo2rkTwgm37f4MGLcc1mipr7uUPRp18tLJPTKZlJlfGSI3h8nTT9a1EQBiSrJ68jpO/15DBcg218dhaQebk5Knjd06nWOCmKtTzAWEBtQoSe5e9fmiJXFo+IjWusdEEyENaSJOcGyzFEpTe1qyNhswthWxvpR/t/Re3qWMF4wem5vFF94zhKjemPp31o5b2NjeRutzTnHH1xWq+/CXtzdovFqCsQUH50+qtJ9i4puGRWVDrxMmp6EtZbPfy9Jk9RMx5y5maBz9pL/ruuaverY/TvfPWDvng0hJ5ypTgNlvc68euoL3OpWfxdi9HyZMY36nNw5SsMJ6T97Dhc5AGpDGA2Gj3eEOqoAzFumm76d8VLupkiMel21czDsULqvpOAPt7LIUZriH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a56dd49-8da0-489f-0172-08db8bd7b55b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 23:51:18.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TclKW6WjJEddrouGnKC7RVCaTQuCPP+qKN/Pqydsvznidir/IIenQzLFvrDrYOggdctke0/m888Djh0AJDz/8i3sYkMsW1Q5AWgDQcHgtww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_11,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230224
X-Proofpoint-ORIG-GUID: k9c8xFpD20axr32jVX9Sd_wrU4lVDpAw
X-Proofpoint-GUID: k9c8xFpD20axr32jVX9Sd_wrU4lVDpAw
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> On Sun, 2023-07-23 at 21:14 +0200, Jose E. Marchesi wrote:
>>> > On Fri, 2023-07-21 at 18:19 +0200, Jose E. Marchesi wrote:
>>> > > Hi Yonghong.
>>> > >=20
>>> > > This is from the v4 instructions proposal:
>>> > >=20
>>> > > =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> > > =C2=A0=C2=A0=C2=A0=C2=A0code      value  description               =
 notes
>>> > > =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> > > =C2=A0=C2=A0=C2=A0=C2=A0BPF_JA    0x00   PC +=3D imm               =
   BPF_JMP32 only
>>> > >=20
>>> > > Is this instruction using source 1 instead of 0?  Otherwise, it wou=
ld
>>> > > have exactly the same encoding than the V3< JA instruction.  Is tha=
t
>>> > > what is intended?
>>> > >=20
>>> > > TIA.
>>> > >=20
>>> >=20
>>> > Hi Jose,
>>> >=20
>>> > I think that assumption is that `BPF_JMP32 | BPF_JA` is currently fre=
e:
>>> > - documentation [1] implies that only `BPF_JMP` should be used for `B=
PF_JA`
>>> > =C2=A0=C2=A0(see "notes" column for the first line)
>>> > - BPF verifier rejects `BPF_JMP32 | BPF_JA`
>>> > - clang always generates `BPF_JMP | BPF_JA`
>>>=20
>>> Makes sense, thanks for the info.
>>>=20
>>> Do you know the precise pseudo-c assembly syntax to use for this
>>> instruction?
>>
>> In [1] Yonghong uses the following form:
>>
>>   gotol +0xcd9b
>>
>> But it seems to be not specified in the documentation for the patch-set =
v3.
>
> I will use that syntax in binutils for now.

https://sourceware.org/pipermail/binutils/2023-July/128543.html

Now we will make GCC to use that instruction whenever needed, but only
with -mcpu=3Dv4 or later:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D110781

>> [1] https://reviews.llvm.org/D144829
>>
>>>=20
>>> > Thanks,
>>> > Eduard
>>> >=20
>>> > [1] https://www.kernel.org/doc/html/latest/bpf/instruction-set.html#j=
ump-instructions

