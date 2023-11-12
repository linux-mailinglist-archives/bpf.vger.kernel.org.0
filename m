Return-Path: <bpf+bounces-14937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1B17E8FD2
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00681F20EC7
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8378814;
	Sun, 12 Nov 2023 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fzYZQz4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z2rW7guA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAAB847C
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:56:00 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79F2D5B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:55:59 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCjlIQ023733;
	Sun, 12 Nov 2023 12:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JJlpNTLsv3gdvQWF8azCiyymhGMPXhCTnCyGtgqwB1c=;
 b=fzYZQz4EkCSsRKQ1bn+lbzMUxZ2kjuJzAHRHLx3+Ni1cjVbRjKujDW5ajZU89U0ZCa86
 ONL85g3jKYAf3P48nZ0GV5O2CbUaDhuF2wsXpv7L/RR7EQzEngdAHQrJryH4f5sAaSXb
 L2jZJsDrNdnhMqweACt1vriOIbAymU9BUzSm93EKBpkoofuKwKbppMuViRCfxCiRubPL
 z2ykdCGGgopQJAMeRkZbcbI2tWkK32KpTOEp6MxmKAsw5baiKphB7eyVAs+JK4yil+5q
 Mh0baNGmjcE8wesHZF7uh2YCYTUiU+n7VmgLdPIVEnYwN03lp8+e4lpiwECGpc+3TQwd ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjhee8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:55:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCFAZD013552;
	Sun, 12 Nov 2023 12:55:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhygj2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsRLmz1uF/RwYC4Ql2Xui3ZkXWmT7dX/rz1ZEMFcxJ/W5Hji16V2rJB+PLzObPgfaFXbAQqJXMj8Ngl7MWuEUBI/V0DtpMA/Fcv2blwMApulQJMgAfF0IqKd4WK+3nRn8Bt/XuUKo3gUXZd0H+47Z7L0S4zmck/OMNxCvvBb8aPlQiMm3MNKay797BLcBG1BA697/6xTc/T0ZULOZBbgXpn7vngcsVaDRaHQU2AqtAgzIOQVxFrjWO6AhiRA6W2DMMeiXbi82wNyYl77lEnVtWdx+F+76zeL6G9TUQOm61GoUkPGBYR4d3p4S1EakOiBPdXR0ndpLqtblnxdGbkLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJlpNTLsv3gdvQWF8azCiyymhGMPXhCTnCyGtgqwB1c=;
 b=eXYb/p4tTdNqhhV5j0vaDxRbYk3JohJatou51pMO5L9/WiViVyT7DU8xzr8QHhauRgOLxa3S1i4zWuLOPw77tUpu1rSKSIRZprJXfE19r0iCXmXypp3IXRQWKQzfdqvGgO7eptFNG8gaCoZCR4B8nCiHKxkI8gFt8nzDLNea3Oq1SlkajjsHDSgzaOfciWlwW7f42MCDW8JVkmGmX0FSkB/+8Om6ADf3Oh18ZSmL35SqNbupEfKJL3mxLfMptwHF+xpYGq7JohX5IdI9VaJ6Cd+Nu7R9rEcybecMPFyMxTIgZelFR/lruFH3DYIKFkB4JkXSz33Zwe/mCxA/NDdiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJlpNTLsv3gdvQWF8azCiyymhGMPXhCTnCyGtgqwB1c=;
 b=z2rW7guAuZc5r2Jvvk6JkJWAa8jJ7/+89Ye9tr3kPeeDiTZBsEEGtDwDweZbgpmmMigvCpd/9cMOX00ltWPrbyRXBDxiDabaz1hxtbqpc5m2fBu6BV0znP2XCcyToanFQNQe7Hc0EXvchFAlG/ss8pUuOivGiKLHX2I4L0HLAtY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN6PR10MB7518.namprd10.prod.outlook.com (2603:10b6:208:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Sun, 12 Nov
 2023 12:55:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.6977.029; Sun, 12 Nov 2023
 12:55:38 +0000
Message-ID: <c116b1af-56ad-3148-69fb-424250bfc656@oracle.com>
Date: Sun, 12 Nov 2023 12:55:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 bpf-next 09/17] bpf: switch to --btf_features, add
 crc,kind_layout features
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org
References: <20231110110304.63910-1-alan.maguire@oracle.com>
 <20231110110304.63910-10-alan.maguire@oracle.com> <ZVBpMLvqhrFpnd3d@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZVBpMLvqhrFpnd3d@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN6PR10MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 598852d5-a1dd-4cae-0f2e-08dbe37eab84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PLk5IS1ozLMH+H4CO5siMmZvzigMjQC36Vgiw4PqJdPMYqKNrwyioFCsAdne7nIJmRPfIVrXCOENLEV4F83jNlikpVCweWoNpBYqWsgpJ2qqz/ksa7E8oc3AEROBqPmLo3MLJz1xhoQeF3Rc4A13necLOcwSaNW/eDQJUxiLB7j0nA6eqgCyBIZH3mcb0bn7f8MwANGIcibRIJqx2RbYE1hg3P1EKBOiuFMpc2OupvDuw31tw3s0hrD6YN5cqZVCGGllREvhf60fOFtDxNWAqfIf+nQTqnQJnfYHgYIsKehAAHDFXtd/cgrWSpdtrzI9+OWmgGvtgh2IsztzCcErjINDWhf9fFXeA09d0zo7LTbecQacQ5z0BLciUm5aDrrRA8WDGeRa6ddZHZUvUKHaTCtgKI//Bf/xZAAXaY+G6z806EP3cHjx7Lr9v47upRfLXfMvhJGc0acDQgBQwOzml9VwvqQpzY0Uq50ZEVmJbSrLkJZmu6S0O8bOv1azcJNUs8yhC6XCZ2uYClwqf3HPpWVhjzFQHE2kDa+zutEsU6Heor1l8i8Dp2onU6UZZbC8SuWSBca2IAoui1gVuZiVZ6VWKn8Yu/YEkDOAmcJkGtJhVgSPBhMvleba1O9lhkqrftIvP7TeybvCm6Ya94esjQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(66556008)(66946007)(66476007)(6916009)(6512007)(316002)(38100700002)(966005)(31686004)(6666004)(478600001)(6486002)(36756003)(53546011)(6506007)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVh2UDh4LzZsM2p6dFcycGdkK3ROTTVEYWtlMHB3SlpydTZ6ZkJOTlJ0UCtS?=
 =?utf-8?B?ZG9iQUplT3dMK2lORkZma3NDcFVlSGF2aWkyRXJEb1dpMUJFcElacDlkaWs4?=
 =?utf-8?B?bU9vZWlURHJ0U0xheTNzaUJrZUNNV1BudkdPRTNURXprSWNMY2N0b0FJUTAz?=
 =?utf-8?B?aTBSNUpDN2ZQQzdtS2dETWJmaGZ5WDJuUlhDN1l0TnVKNW1sdTZ2L2I1Z1hW?=
 =?utf-8?B?ZXpiT3ptUXEwZ3hPRnFqeFp6cGluS1FHWk1qYlFlN3dwWWVkWUdsaGMwcTVm?=
 =?utf-8?B?cmpKUUdPcjE1b2NaMisvblRSRzVDbGIxVFYwQUtWaGpmQ0dMWU5pVUpJTkxJ?=
 =?utf-8?B?ZEVjTm1wV1kzc0Qyb0dJL2pqenVBSTJWL1NXMUxRdjZ0cUVxUFh1OSszY1Vn?=
 =?utf-8?B?SmZIQXJYT3phdEtGL1dBM2FEeXBnaUQ0MjZjVUtBS1hQNzNqekJFcHc5Mjgw?=
 =?utf-8?B?SmJ6Yzk4WmZVSVBVa3BLbEU3bGx3Rmk2NVZnUWt0ajZ0d3gzQUJMenJVSVVs?=
 =?utf-8?B?N0pVV2twQzN4RXJHc0VGaGpnL2NnamlxZlkzV3BhN0J3VWM5VlJ3YzZEQ1Mw?=
 =?utf-8?B?RXJpWnV2dTZIZVRiZUFoS1JhbWpBZ2pMZ2RPb01hK0Y3Q0dxUyt5NU9uVVZz?=
 =?utf-8?B?d1lDRFVJMU9VelNsSjhCUk8xeUJpSU1lNFYxVkZkOEJYRTE3WFMzcDlzZUNO?=
 =?utf-8?B?Ni82ckFtcDdrbmxob0d0bzh1M0tsTm5jRG9QeStPQ1BOYkZhZFBpTHN6ekFi?=
 =?utf-8?B?WDhONzVKamdHWmpuQnFraVk2V1pnbXU5Q0xteUFmQkdidDdmNUYwa3RVMDVS?=
 =?utf-8?B?OFVkN2phT3BSOGJ0S1hvalZWVVpQN0JzVHlQK2hRcktodjZZUytEZTZlQWp6?=
 =?utf-8?B?anUzbFh4T2tXRDZNWkpPNldSVjA2dDdGSEdXRU16NmhMK2xKR1NyMThzUlQ5?=
 =?utf-8?B?c0t0KzhDbzFVN2ZzN0dhSkl2bHlaay92cEpxb3RxQW9PN0trY3FTekFBeERZ?=
 =?utf-8?B?RDdsZzhtUHgrRjQwbkY2ZlNzMVVIY1ZtRWJIa0YzblZLUU5jZWFQRWhDOUFE?=
 =?utf-8?B?OG1ZbDhVNmllcTh5VmlkWDBFakdDTlNpaUptTTBCSUVIdFc5VStDUEdSMWtG?=
 =?utf-8?B?akR4SVhuaWdvcmc2eVRSYStmZEJOdW1FTVFDbFAzdnJFbTdkcldWZ0hZblVs?=
 =?utf-8?B?aHRHN1gzMjNKUndBRmxxUTJMMUpseW14OExTOW1paUhVTWFEQmxqYmtab1lL?=
 =?utf-8?B?WXhEWFgrbEhralQ4cEpPYUc0cCtScXdGRmYrN2k5dXRPSFVpeEdXR29xcnEy?=
 =?utf-8?B?UmtEdEhzZ0s1OVlSTEprM1hEZ0Rqd0ROVlJQZ0xYQ0hVaENRUDJmRDY0M2Zl?=
 =?utf-8?B?d3JiQnFwR3Z6eWZwVlBBVGpUcUY1Yjk2dEt4RmRJMGFtSm9wQmdERlN6akNq?=
 =?utf-8?B?a3RlYWU0UVZuOHBYSU9MbE0xVlh1WnZKOTNFK2lXMkg3TW1zelRVdEhuMjlH?=
 =?utf-8?B?RlNnUUZkVmgvOGt3YUVVa1hqMUFPazhQMmpTRldjcFFmWFdRVnNCaEU4R1pQ?=
 =?utf-8?B?RUpwcDNyaXk4amhFSWM1UFkySGZ1bEdNNysrZWQ4K29mcU8xNndxc2plUGVZ?=
 =?utf-8?B?NGRPSnNGS0VxY1hlWS83a0d0TU9sMW5Db1lkWDR2alJidmtTS2FXUjh1Q1hG?=
 =?utf-8?B?OWdVOWFlcGJLMm5VRlpqSjFqQVBFMmJ2ZjQ1UnF4emRuZHpManM5UHdqNHJv?=
 =?utf-8?B?UWhWWVpVTVkwb3pza0xMeVUzaEtmNjdXaytHZUdlbjNWd3RoZE5TM2RiaHN4?=
 =?utf-8?B?Zlc5RW1iMHZkaU9YRm5WTHpXdVYzMmUvRzVrYWZNKzRvcjF1MXpoM29IWGg5?=
 =?utf-8?B?eElxQWZQbGpSaWVrQ0VPcUp6Q1k3ZU5JRWh5SC9vUE12R29Uc1d2dmVib2d2?=
 =?utf-8?B?M0w4cS82NWhEZ3kveldRVGswUXNQWUVXK1Q3MTd6NmlSOWovOHQ2VGVmcSt3?=
 =?utf-8?B?cWRWMjRKL0JVQmxjdXdraCtmTzlma1dUa21DWGFLVGltai9WRktSVlM5MmRM?=
 =?utf-8?B?MmpqbldLS0xmZ2txd2ROK3JSMm1HRFRjVlZHME9rcEJ0K3kyQmRWbmJ3Rlhu?=
 =?utf-8?B?VDNjYzR0cGVhR2crKzFwYXFydkErWERoQTVuSGZ4c0RWOG9xZVFrU09nY0NG?=
 =?utf-8?Q?Rki5lvbHTu7DvaSuohjCX7c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?L0pDVVNudk53OTRwSW1iWFpwZlhkWnZIT3FNRWFVN01vc0ZpN0YxWkpJUDdY?=
 =?utf-8?B?Q3YxblcxdVIxTTVjYmFjTktPOU1WN0cxalo4VWgyZWhZcDBtbHhJR0xZRUhM?=
 =?utf-8?B?dklDY1VwMHdsajNlck9EUGR1SkdpdkxkdVRMZzJpVElYNzlBSXMxOFY2T2VO?=
 =?utf-8?B?akVXdC8rZ0FlRExJa3Nvbkp1dVZhNWJNQWhsek5QY1E1bVdSRWFzcDJyL2hW?=
 =?utf-8?B?SFM0OG1KR3J1VW5vQVBtdzlDZGQ3T2t6ZkxRRC9vaER2QTFESzJEeGFnWE14?=
 =?utf-8?B?R0QzSTBqMUxoSDVIM29ZVWtRblJKMzJzZVYxZjZYeEQ4NUZ0dy9WcStkMlI1?=
 =?utf-8?B?bEFnbHROSXI0UkV6bUlROUNxTWxWdnhmNXJRenQwZDc2Rkt1Z3hleE1Cdnlr?=
 =?utf-8?B?dWMreXFZYTgvSExrUVpFTlhXcnRQVWt0bDBjSkFVeVNOTyt5R3NPa2k3TzU1?=
 =?utf-8?B?MllxL0crdkxaWkxXMVF4SE51THFJN1VoYlVtTmx6QWt6aG5sdy82MVJFMUM0?=
 =?utf-8?B?NTE4MDFlc1lNNk1LMTd4azdtZjh5VXkwMlVZd0FBelRUWiswMUR6N2ZvUjZU?=
 =?utf-8?B?VjMreFRBZ3NUM25iWkhMRVFEVXVydmx5aTZrOHNhN2djQjFyb09aOC9ncUYv?=
 =?utf-8?B?TGdaS2pRbkpnSUtLSHp4QkpVV1hvam4xU05uS2lneTlKZ0Z6aFIyVjlJVjFD?=
 =?utf-8?B?YlNoN1RWRFYxazVDWGlHSUdLM040T0lKZUpxZlJpTGlybHdDTW5pZndocis3?=
 =?utf-8?B?Rk1oalhaZXBNVDNJYUwxa1dZblZCUmFmdzQzWEdndzZ5NHQzVTdpRXA4NEhM?=
 =?utf-8?B?dEI0TE9LeWtUWSthYWxNTERaU01qWTR6d1RIcU8xcTAxbUcrTlBneStkN0sz?=
 =?utf-8?B?K015enZaaG1xUURXS09BeE5zTS9VdkVCTno1TzVrcDJzeTJsTXplNE1hd1dB?=
 =?utf-8?B?RFZ6YXlzdGQyNjM3RUZGN01JcUxnZGM1eWI1cXZSUWltY25VYjRtU01NTFJ2?=
 =?utf-8?B?L0dNNDFIM01lTExWUzVYMVdLM2o2R21GdFh4UWw0aS9zUVQ0Y2tpSTlJVEty?=
 =?utf-8?B?TXAwM1NBQ3BTNCtqQmQwSzRXUldsRXRNVDl3MFk4VlRWcFEwRjlQTE1Kd0Jv?=
 =?utf-8?B?UStkTGkwY0NpM0ZIaE1uNjNzRkxWb2xiSVI2T3VQSFYxaFcrY1RqTUtoT1pL?=
 =?utf-8?B?VHZtMGdicEdnQjNHRDNKRytqdXF0N2VwQmdmTUNkNGZGN0UyOXErdlVsTXdx?=
 =?utf-8?B?SWxvZzJpSkorQTRXN0pBSWhmSnJrbFR0aFZZb2ZzM2ZiMFdHdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598852d5-a1dd-4cae-0f2e-08dbe37eab84
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 12:55:38.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwLsnjz1zq8Fr5M4Q/AXWtaFMUyNHbR03yhfe8OGlVllE365p7gZMXxnCL0r1UrkNh3tH1dYKOJQP91vODLjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311120113
X-Proofpoint-GUID: LkMyN_apFYu6cyg4UefZS7METAeVJBug
X-Proofpoint-ORIG-GUID: LkMyN_apFYu6cyg4UefZS7METAeVJBug

On 12/11/2023 05:57, Jiri Olsa wrote:
> On Fri, Nov 10, 2023 at 11:02:56AM +0000, Alan Maguire wrote:
>> For pahole v1.26 and later, --btf_features is used to specify BTF
>> features for encoding.  Since it tolerates unknown features, no
>> further version checking will be needed when adding new features.
>> Add crc, kind_layout features.
> 
> hi,
> this commit got merged:
>   72d091846de9 kbuild: avoid too many execution of scripts/pahole-flags.sh
> 
> so this change needs rebase
>

yep, just sent out a v4

https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/

It both rebases and fixes a few issues in libpf kind layout encoding
I found during testing, so v3 had other issues aside from the mismerge.

Sorry for the noise!

Alan


> jirka
> 
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  scripts/pahole-flags.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>> index 728d55190d97..30a3e270308b 100755
>> --- a/scripts/pahole-flags.sh
>> +++ b/scripts/pahole-flags.sh
>> @@ -26,5 +26,8 @@ fi
>>  if [ "${pahole_ver}" -ge "125" ]; then
>>  	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>>  fi
>> +if [ "${pahole_ver}" -ge "126" ]; then
>> +	extra_paholeopt="-j --lang_exclude=rust --btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,crc,kind_layout"
>> +fi
>>  
>>  echo ${extra_paholeopt}
>> -- 
>> 2.31.1
>>

