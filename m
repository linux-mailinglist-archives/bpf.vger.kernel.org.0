Return-Path: <bpf+bounces-6388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204C676874C
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 21:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA0E2815DB
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66EB14F78;
	Sun, 30 Jul 2023 19:11:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D411FDA
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 19:11:36 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2910F0
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 12:11:33 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UHmAEi002598;
	Sun, 30 Jul 2023 19:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RIc6oDfWizsgOYXljCpOjhoLIGHS8eLm2ylHCW9cEX0=;
 b=GZpiRZg73QQKIMS3qgVXwqOxg4t+xFrbkbho0BznkPFx93vtv/XBf5UWGLtlGrpA/84E
 aNd8s2ewPy3/Vwm+ac+YVEMRKpPp/M5LQbECtJZSM6pFm9STcG7Z0Ub8u7QLBc+2C3tt
 6Kj+Bj6is1ntCR/S+uRRbRxSTx15QFzZRN9hlJcVgi+ywlTvEgRO1fuIQtfn1IzfUU2w
 sW7PasyUGkG+jGvtm01Wb62JkX1F4OEs1M1d3PcL11ccsEaKk9muyHYomKlSmxX9Lmzf
 dKDsW0WGQuPdQMiLgtlg8k6IJewQHoFV+rKw4UWGrtMi1YkpYsUPKN54xlDE8TYt+fQZ JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc29d0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jul 2023 19:11:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UFWsVl038242;
	Sun, 30 Jul 2023 19:11:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s79y3ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jul 2023 19:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC4k+Xy4DPWW0QxF73jWEsmzaNYr5/HNEOY9hipv1k4ZKYQI/1GNyCSIFGq3BceeO2lB9BySoQY+bJdxTqN02PItLFHPcDhhq+qGXIcDjtx1jOmJIwo1yDw1AWOO9LbnwqTjBdduqi+cugJWFeMSiidVvWztefu3Shd7aj6WBnA1ydpVzr8Z/Ho1EZQMp898MYOnVl6wX1Zh3k2jLaAG/ZnaYkX6tmSpN8X5NYPJSJ+6OegLCyJWGOE4J51xqgR9M4xe/AFLeN8uE6/mZvqyOsZSb2VrBaB7c+qtx3Ad3OPoOnaWToyAJTbmTnFtriJ4qV6xSUo1EsqDE4E3YKD2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIc6oDfWizsgOYXljCpOjhoLIGHS8eLm2ylHCW9cEX0=;
 b=FyzYihLgEenY0ngB9b4doxjJdY/zeFG8C6g1TXpkvo7hn0qrNdt4DZ2jV7g8kl4vcyFWZ1p8hhYzz0gamlrv72z+aaIMEvMXuzYjkDVvLlvGc13Op03SQ0fXBea3kUjnamAsDMKUBMc1GZTakLqpvf6XzGhCgfHFRZBQ/xyyqe6U76Fn5a6L7ewAM2ENmSD3VP2559j5pZ9EF9+YrP8dDxBa/p1V7HNKu+m9Tyx/WtXbxDJ0eQnm8aXBYc9HnNEsZFrUTgu/8glxLjLfsb6y9ChD0G66pAeTWGEKRYuIJV6gqjKfbSLl0sI99a+kZxgL9QVjOJwACtzlSeiaX3j1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIc6oDfWizsgOYXljCpOjhoLIGHS8eLm2ylHCW9cEX0=;
 b=b5RtVUWnKxaRUyO62rBj5rcd0Jb1pHQCAo0hHkqauawTofP/prrnPWNiAMoBNlwf204iSlbPASpKbUVR+HSX1oGkf9V9HvOr7JdT3toxHXT3i6xixOt9qu59mTw6KLnT7L3/agq57UTmYE0urrJ2eZdIYIIoaOPUAyyTfOp2zfI=
Received: from DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31) by
 SN7PR10MB6450.namprd10.prod.outlook.com (2603:10b6:806:2a1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Sun, 30 Jul 2023 19:11:24 +0000
Received: from DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::c495:8d34:80c7:d66f]) by DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::c495:8d34:80c7:d66f%6]) with mapi id 15.20.6631.026; Sun, 30 Jul 2023
 19:11:24 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf
 <bpf@vger.kernel.org>
Subject: Re: GCC and binutils support for BPF V4 instructions
In-Reply-To: <8629d2ae-75dc-89de-7cee-1790e9116384@linux.dev> (Yonghong Song's
	message of "Sun, 30 Jul 2023 09:12:05 -0700")
References: <878rb0yonc.fsf@oracle.com>
	<13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
	<87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com>
	<CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
	<87jzujnms6.fsf@oracle.com>
	<CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
	<87edkqm257.fsf@oracle.com>
	<8629d2ae-75dc-89de-7cee-1790e9116384@linux.dev>
Date: Sun, 30 Jul 2023 21:11:20 +0200
Message-ID: <87sf95kyef.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2890:EE_|SN7PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d22d96-c6b7-4b96-6f2f-08db9130c474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9g2vQndAWN6qEPExthuCe36zjuPZaM7VKl3yvUcaqxXy44tyONjzcVUc5DIWDARV8eQ9TjalmYyQ5vk/YOnEtMJydsp8J9c5+M7QpQYEOVRbf028rEGbEVbgNVQrrsD1+5hRF4h/jwaQOl50ieloNnoZlzPpMmRXcmHbRKvrF8s8YbDqgsX20RiekazZu0Gt6r9Hp5Yr3Oyphuz6MRc05j65UABUXTcQrPUDQn0de+9C2Dhi+nEbl5Na5upkbOSob5ZyVEEygpc7YZOFcQxA6MWPhpEDt2dNTXD6PICOc7pOgoW4oNgonzx56O9U86c3l2TyrGX9/manCRy02fM1i7b+Lwli9WAUERj2xYv0RWIuAo9d+M84gJQHz6VEOYtUT3VO6b4V+yVEknFqbEXTyuhK1IN8G/NY1EzKCNgEAcnmGCF+lzfUDZ4bXahhUukUPnKOJXfRbnwGAg7SkEaZoPTGfgVi1DJwauLiy3AJzRiK6e+aR5rQkvjje44pqoRuz8XH8KY4v/KkhHtbzKNCP286ZyeLwG5EY2B/Za3YnORTedDjJEyV2YyJKytB//Pl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2890.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(186003)(6512007)(54906003)(6666004)(6486002)(478600001)(6916009)(83380400001)(36756003)(86362001)(4326008)(2906002)(6506007)(66476007)(53546011)(2616005)(26005)(316002)(66946007)(38100700002)(66556008)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVVRNUtHL2tyVnJYT096VmJDQWtjZmVCbFJ3c0wvTWt0Q0x3STArTzNzaVY4?=
 =?utf-8?B?cFlqRHR3c04wTjZ4emhmbmNoeFp0VHA4RTdpWFYzNUJLQkxQSzVjT3ZlcXJD?=
 =?utf-8?B?dUZ6OG1icW0rSCtDc2lMMk9MNHEzZEFMWVBxTnkyMitjd0FBMHhvZHZLdUZ5?=
 =?utf-8?B?T0JhTnp0Y0hkQnhJbkZZVHZDV0ZzbzJ4VXo2TVpGMFRDVExGU25pZU9BV2F0?=
 =?utf-8?B?eHN0RnZqc05zT2lLK1B5WmIvU0ZCaHA0Rmsva3RZUEg1OUd0My9ZY1BjbEJM?=
 =?utf-8?B?SGxXMldWcWMzRzE1REo5eGxWdlNSNzhFKy9HK29IY205KzUxRG9CUmRmYjh2?=
 =?utf-8?B?V25kVnJhdWowVk9JSC82TVBNeURxandxYTAzYVlZR2Zpd1FDVlVYOWV5a0xw?=
 =?utf-8?B?NlYrNHpSam11Szc0bm9rY2REaEtsRWVqQXo2WVZuVjcybmJIVnlpVkE5NjhN?=
 =?utf-8?B?aDFtTUxIMkpIZDRhN3RlQTVYTmtOY2NZZURIeTFpQ1VYaHJMUXBxZVprOFRH?=
 =?utf-8?B?cVYvYko3VGZhdmJtb0FWV3JCTkZqcnpXa2k2Q2hmMDRodXhVNFRWcXY0TGpN?=
 =?utf-8?B?dlNvSmh0VFhhaDQxZmpNVEVhNnlEL3dkeUR4UkFCa1JYdXJQWGlBQTZiYjZC?=
 =?utf-8?B?SXlELzZYeVdmQzhsYTVNOTZ4VnVISzhJWVhyeE9UOEROR0dEWC9DQUN2VGNp?=
 =?utf-8?B?VGdkQmNCRVJnNzA1eEtKaklzTHVHRWhTNVpWTFhQNFI2R0hCczVRVndnZEMy?=
 =?utf-8?B?YnJ2TEJwaUs1OTgvV1JXQ0NJckt0S0phcXFPaURFa0dUbnFFeDhLQkdLRjhV?=
 =?utf-8?B?Z0xLa0VWL2lWUUovYUY0Z1NIL3NyRk55Uzk3M20wYStSb2sxTDhkQjZOVVRx?=
 =?utf-8?B?M1pVMGNNZ2FST2RiZVlWTHBoZkgzZWxLMHF3d1Y3YVQrUnVSMElpUVM1RkxZ?=
 =?utf-8?B?SEhvZG5uUHdlTWt5WWVTQ3VxLy96VEhwZXBPMzRsQ0ZoZXRJZHdEVk4yRlVk?=
 =?utf-8?B?V1V1NVBNakxjZDZWMzN0K3JlaHl4N1RsMHJwb20reGZpVnUxeDg5Y3BOd3R0?=
 =?utf-8?B?WDNXamhha2lZU3h6RG5UUVlrKzRUL0JwbU5BaUpCVmFTbVk2aWcwYW1CUDdO?=
 =?utf-8?B?L0RFQ1JYcGlRK1RnNW5ya00vSjNUemRzSElDd0dmWEpFWERjczRHSFVVVUdx?=
 =?utf-8?B?bWJxbkFWV0FCeEtSNEIrb0JsaTBoQmVMQXN6ZEZ3T0VqTm5qZmNmVnVvVmJm?=
 =?utf-8?B?QUp2ME1jS01aTmdjcG1HdXVoOGVFQ0lFUmVSQ2Vhakp3VDZFeGc0M2d2S1U3?=
 =?utf-8?B?KzBNckRkb1RiV1B1ZTJwOXg2K3FMWlI0dTRRd3E3Y3hvbWRNY3VkRVhaSCtP?=
 =?utf-8?B?OHFVSGlzL3NVM0VTMnpWQy9qaTA2TFdNaE8wZmdYbDVrcVloS0hsQkpybUVN?=
 =?utf-8?B?K01XTnRjc2lqM3Yrd2VpeUgxdFpXMURvSmZEQSt3bGFRK1Vzc0NWMEJWNVA5?=
 =?utf-8?B?UUlUL2xLYncrems0Y2N5b2Y3cWhNdXN3T3hsWDZaWHdQa0ZnWEtlSXJDUnds?=
 =?utf-8?B?MGdFWnF1OWViR1JyTkdEbE8va2tVYUgxL0dCUXJIS01KYW82S0lWUi9SS3FP?=
 =?utf-8?B?clpMM1E0VGEzaFE3cjRqdWhtRnh0QWk1WTdHK3dvN0RXRkFEbXZzaTZJT1Nu?=
 =?utf-8?B?MTlKL2lRd3hWQ3hqN0Rlb1lSNUVHYkZYT0pWTnljWGxLMWhtbThRRWlSL3dn?=
 =?utf-8?B?cGUrZWVUSnNVZytqbFp4MDh1S2RESWlMRTJvRlZMZDdVQnpudE1NYjBBby8z?=
 =?utf-8?B?dkluSmx1TytDS3BycFJHcFZ0VUZ0akpFblBrTHBYb00rTXFvdU1VemF5bnlU?=
 =?utf-8?B?TldEWGsrQUtMVmtZZ1BNS1kwMHBMaGszcEFXdFR0T1E3Q3FiVlJ3TE11a1Rp?=
 =?utf-8?B?Q3I4Ri91NGluNHVkOG5JeU5mV0p5bCs3VEZuUmhUeTNRbktpYmc0Uk1ZbDBs?=
 =?utf-8?B?Ymc0NC9KcjJXeG5FNWhaNDEzb3FydDN0RlRHclFHWU9QRHZ4Qk5KbW5sQmpB?=
 =?utf-8?B?bTVac3NabXVxMmJKaC9FN2c2RU1Pb0VCMVVSMjBjK0hTWDd1dTZpYW1YV08x?=
 =?utf-8?B?WlBOTWoraWVkRUZmbE9OZnhReUdQbWFSaUg2emdQb3N3WFM2QkFIM054UmxS?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QKO3SEMI1dspsupED2NS3paqj0vT25YQlK+wBx//Fqdh8MQTMs/6LnAtzClZxHHEyJd4GUJR+kx1Kp77flapjt14Gjepb7fbQ/IsqEB1DHFON8cKxVGFEYy2ljCOYVf/faLlzr1BxrzPgkuEwQRW0BSnSn0fs0eEfqmO3RYMbTCYg6fcPn+9joDTuG65uS8E+8rLJ+u5EVauM+8SYMABtG1guycjlTvMyc8MGRtyFlrA5jMN32zpnoBPpQFUi/1JK/5l4UcEAroc8FGDXVXcQpZdhT3KwqB24Ick8TinH5M5SgLjyd60hlgMtdFZ2NqxU2PGMd193s/kq7SbF3kfxDTEeY0+ZnjdS4FA21JVcDX9QuKoWaQ5NJ0UZ7ZOXELVOm+cE/IzUC+TZfiOzsWBfSvdpshpyZsO/0Jus6rrxqTjVARVZj+vX6tT+jcPWsOmkKrxllGuij8X2SQIBWoWFK+X5hF+g+06oY+m2V/VpEatYVcnFGDMiUm4hegyIdu8Zl9zGh/88+3/tQPq2LRwKTcySG+H1HkBSDeUY/8DYdrI10+86w2GXwSDmAMk6H+53p+oTSblao9f9OfNGMndFGFpx9p/Hy4PQs81pTUQ+EgbrFMHkIzkrF22uflcV0aJv4Ep5MooCotlrr60FNsdojRo5TqvCWlUPm7DYTi2aSyF652etW2d0wBSvLioZLx3xnGEg2wfrot0GHxZ1ca/gGmfv0F7mdjb9NYHxukHyRxg3zWTEhMo45bMilFfFmfyFQoI0BM556JrEWDoBQRlRnCu09tOfNycwGDWObiwtUoOs5oLmbgUG6MWIgyNTriB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d22d96-c6b7-4b96-6f2f-08db9130c474
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2890.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 19:11:24.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xSv0YKs/arynKwf60W0W/amFnpT4vAVFQnp+f2iN+DnH3LfP7vus0SJ8ALlK4Mm01b9O6cmcZMQ7lPW8VWJ4DoeIXVaoxpN0/8gaNGpEGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307300178
X-Proofpoint-ORIG-GUID: fxjHvp6N7hBNvBgwAwF-0Bn6TfOynEjE
X-Proofpoint-GUID: fxjHvp6N7hBNvBgwAwF-0Bn6TfOynEjE
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 7/29/23 9:54 PM, Jose E. Marchesi wrote:
>>=20
>>> On Sat, Jul 29, 2023 at 1:29=E2=80=AFAM Jose E. Marchesi
>>> <jose.marchesi@oracle.com> wrote:
>>>>
>>>>
>>>>> On Fri, Jul 28, 2023 at 11:01=E2=80=AFAM Jose E. Marchesi
>>>>> <jose.marchesi@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>>>> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
>>>>>>>>> Hello.
>>>>>>>>> Just a heads up regarding the new BPF V4 instructions and their
>>>>>>>>> support
>>>>>>>>> in the GNU Toolchain.
>>>>>>>>> V4 sdiv/smod instructions
>>>>>>>>>     Binutils has been updated to use the V4 encoding of these
>>>>>>>>>     instructions, which used to be part of the xbpf testing diale=
ct used
>>>>>>>>>     in GCC.  GCC generates these instructions for signed division=
 when
>>>>>>>>>     -mcpu=3Dv4 or higher.
>>>>>>>>> V4 sign-extending register move instructions
>>>>>>>>> V4 signed load instructions
>>>>>>>>> V4 byte swap instructions
>>>>>>>>>     Supported in assembler, disassembler and linker.  GCC generat=
es
>>>>>>>>> these
>>>>>>>>>     instructions when -mcpu=3Dv4 or higher.
>>>>>>>>> V4 32-bit unconditional jump instruction
>>>>>>>>>     Supported in assembler and disassembler.  GCC doesn't generat=
e
>>>>>>>>> that
>>>>>>>>>     instruction.
>>>>>>>>>     However, the assembler has been expanded in order to perform =
the
>>>>>>>>>     following relaxations when the disp16 field of a jump instruc=
tion is
>>>>>>>>>     known at assembly time, and is overflown, unless -mno-relax i=
s
>>>>>>>>>     specified:
>>>>>>>>>       JA disp16  -> JAL disp32
>>>>>>>>>       Jxx disp16 -> Jxx +1; JA +1; JAL disp32
>>>>>>>>>     Where Jxx is one of the conditional jump instructions such as
>>>>>>>>> jeq,
>>>>>>>>>     jlt, etc.
>>>>>>>>
>>>>>>>> Sounds great. The above 'JA/Jxx disp16' transformation matches
>>>>>>>> what llvm did as well.
>>>>>>>
>>>>>>> Not by chance ;)
>>>>>>>
>>>>>>> Now what is pending in binutils is to relax these jumps in the link=
er as
>>>>>>> well.  But it is very low priority, compared to get these kernel
>>>>>>> selftests building and running.  So it will happen, but probably no=
t
>>>>>>> anytime soon.
>>>>>>
>>>>>> By the way, for doing things like that (further object transformatio=
ns
>>>>>> by linkers and the like) we will need to have the ELF files annotate=
d
>>>>>> with:
>>>>>>
>>>>>> - The BPF cpu version the object was compiled for: v1, v2, v3, v4, a=
nd
>>>>>>
>>>>>> - Individual flags specifying the BPF cpu capabilities (alu32, bswap=
,
>>>>>>    jmp32, etc) required/expected by the code in the object.
>>>>>>
>>>>>> Note it is interesting to being able to denote both, for flexibility=
.
>>>>>>
>>>>>> There are 32 bits available for machine-specific flags in e_flags, w=
hich
>>>>>> are commonly used for this purpose by other arches.  For BPF I would
>>>>>> suggest something like:
>>>>>>
>>>>>> #define EF_BPF_ALU32  0x00000001
>>>>>> #define EF_BPF_JMP32  0x00000002
>>>>>> #define EF_BPF_BSWAP  0x00000004
>>>>>> #define EF_BPF_SDIV   0x00000008
>>>>>> #define EF_BPF_CPUVER 0x00FF0000
>>>>>
>>>>> Interesting idea. I don't mind, but what are we going to do with this=
 info?
>>>>> I cannot think of anything useful libbpf could do with it.
>>>>> For other archs such flags make sense, since disasm of everything
>>>>> to discover properties is hard. For BPF we will parse all insns anywa=
y,
>>>>> so additional info in ELF doesn't give any additional insight.
>>>>
>>>> I mainly had link-time relaxation in mind.  The linker needs to know
>>>> what instructions are available (JMP32 or not) in order to decide what
>>>> to relax, and to what.
>>>
>>> But the assembler has little choice when the jump target is >16bits.
>>> It can use jmp32 or error.
>> When the assembler sees a jump instruction:
>>     goto EXPR
>> there are several possibilities:
>> 1. EXPR consists on a literal number like 1, -10 or 0xff, or an
>>     expression that can be resolved during the first assembler pass (lik=
e
>>     8 * 64).  The numerical result is interpreted as number of 64-bit
>>     words minus one.  In this case, the assembler can immediately decide
>>     whether the operand is >16 bits, relaxing to the jmp32 jump if cpu >=
=3D
>>     v4 and unless -mno-relax is passed in the command line.
>> 2. EXPR is a symbolic expression involving a symbol that can be
>> resolved
>>     during the second assembler pass.  For example, `foo + 10'.  In this
>>     case, there are two possibilities:
>>     2.1. The symbol is an absolute symbol.  In this case the value
>> is
>>          interpreted as-such and no conversion is done by the assembler.
>>          So if for example the user invokes the assembler passing
>>          `--defsym foo=3D10', the assembled instruction is `ja 20'.
>>     2.2. The symbol is a PC-relative or section-relative symbol.  In
>> this
>>          case the value is interpreted as a byte offset (the assembler
>>          takes care to transform offsets relative to the current section
>>          into PC-relative offsets whenever necessary).  This is the case
>>          of labels.  For these symbols, the BPF assembler converts the
>>          value from bytes to number of 64-bit words minus one.  So for
>>          example for `ja done' where `done' has the value 256 bytes, the
>>          assembled instruction is `ja 31'.
>> 3. EXPR is a symbolic expression involving a symbol that cannot be
>>     resolved during the second assembler pass.  In this case, a
>>     relocation for the 16-bit immediate field in the instruction is
>>     generated in the assembled object.  There is no R_BPF_64_16
>>     relocation defined by BPF as of yet, so we are using
>>     R_BPF_GNU_64_16=3D256, which as we agreed uses a high relocation num=
ber
>>     to avoid collisions.  Since gas is a standalone assembler, it seems
>>     sensible to emit a relocation rather than erroing out in these
>>     situations.  ld knows how to handle these relocs when linking BPF
>>     objects together.
>>=20
>>> I guess you're proposing to encode this e_flags in the text of asm ?
>>> Special asm directive that will force asm to error or use jmp32?
>> GAS uses command-line options for that.
>> When GCC is invoked with -mcpu=3Dv3, for example, it passes the
>> corresponding option to the assembler so it expects a BPF V3 assembly
>> program. In that scenario, if the user does a jump to an address that is
>>> 16bit in an inline asm, the assembler will error out,
>> because relaxing to jmp32 is not a possibility in V3.  Ditto for
>> compiler options like -msdiv or -mjmp32, that both clang and GCC
>> support.
>> I don't know how clang configures its integrated assembler... I
>> guess by
>> calling some function.  But it is the same principle: if you tell clang
>> to generate v3 bpf and you include a header that uses a v4 instruction
>> (or overflown jump that would require relaxation) in inline asm, you
>> want an error.
>
> If -mcpu=3D<version> is specified in the clang command line,
> then the cpu <version> will be encoded in IR and will be
> passed to the integrated assembler. And if you specify
> -mcpu=3Dv3 in the command line and your code has
> cpu v4 inline assembly code, the compiler will error out.

Perfect :)
Thanks for the confirmation.

>>=20
>>>> Also as you mention the disassembler can look in the object to determi=
ne
>>>> which instructions shall be recognized and with insructions shall be
>>>> reported as <unknown>.  Right now it is necessary to pass an explicit
>>>> option to the assembler, and the default is v4.
>>>
>>> Disambiguating between unknown and exact insn kinda makes sense for dis=
asm.
>>> For assembler it's kinda weird. If text says 'sdiv' the asm should emit
>>> binary code for it regardless of asm directive.
>> Unless configured to not do so?  See above.
>>=20
>>> It seems e_flags can only be emitted by assembler.
>>> Like if it needs to use jmp32 it will add EF_BPF_JMP32.
>> Yep.
>>=20
>>> Still feels that we can live without these flags, but not a bad
>>> addition.
>> The individual flags... I am not sure, other arches have them, but
>> maybe
>> having them in BPF doesn't make much sense and it is not worth the extra
>> complication and wasted bits in e_flags.  How realistic is to expect
>> that some kernel may support a particular version of the BPF ISA, and
>> also have support for some particular instruction from a later ISA as
>> the result of a backport or something?  Not for me to judge... I was
>> already bitten by my utter ignorance on kernel business when I added
>> that silly useless -mkernel=3DVERSION option to GCC 8-)
>> What I am pretty sure is that we will need something like
>> EF_BPF_CPUVER
>> if we are ever gonna support relaxation in any linker external to
>> libbpf, and also to detect (and error/warn) when several objects with
>> different BPF versions are linked together.
>>=20
>>> As far as flag names, let's use EF_ prefix. I think it's more canonical=
.
>>> And single 0xF is probably enough for cpu ver.
>> Agreed.

