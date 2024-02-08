Return-Path: <bpf+bounces-21504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C178684E13F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 13:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F9D1C28B27
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03426BB43;
	Thu,  8 Feb 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aX73oC4i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tC8RXtiL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B1762D9
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396922; cv=fail; b=PlGkYzduKpVm/xolhhgeHLhZeiaP8HuaBfkBe/9aP7tLZlt7yySC6Th/gCEBNy5S7gVIr0ddVDGPSaxSI/ndrFl8KSrPGo4OZJoMVYHaJ869QfFNbqC4OZ143u9mal350W+JgbZu7jxxWlI6oJdDV9UGvvUNj2if0fOHuFIFntM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396922; c=relaxed/simple;
	bh=U7pKI6q3VJBSmkUKP3AIZ7vk0y2XZ2/uJGrs/SUH7UE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=aGqMWsR3tbr3jiiapHPP10atHO2g3CSxiYEQ8vUbRRgg6SawQa/PILjjY5lhnfoQ8EWX7u7h5iemjUmVKwzFNW8poloiv2jVss09MOOKwK5O5oORYSf6mQKUdJ+QYvsYOxQUy6amvqOtpoycmReIPLCjOXDhKIZHWrLCUKp1DgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aX73oC4i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tC8RXtiL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4188xlJH001002;
	Thu, 8 Feb 2024 12:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=7Rgh5C8MbAhWxnPsCHaYw2uK6/aommoFHRo0Pl+tnnU=;
 b=aX73oC4igZJ4dEfMGLham3bjhwkrxYy/oh5rH8/5KLS168v3UZLLamm/VRjRsu1B3jVt
 Yk+vSwUWRMtLNR2UGlL5N+Fi2NEDLfkvHCY0AHI0g3A0hGRBOYVGWeLmORdKXtFppTnY
 0XOXg7IVjnZ9mxkeEprh/kEtjNtJubkAXgLemNLOujZkE2hJt9BPbiTLGWGq/IOXDN81
 W0wC1lN8yxly+PjSexZYuaRq6FMxOw6yFHxi1yxc0vaWQcav9Ir+MKdpsiQc21UDF1zq
 dhWvTsrS6tts5v34ZdYbtj5s+awo200CV8PCQQowYQdOW1xKUjMlug63Gb3sA2Oh2m9X /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd4jx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 12:55:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418CUbds039655;
	Thu, 8 Feb 2024 12:55:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxaawny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 12:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5OLSksnEesrmI+UIOBHvy7HaROX5aN/lz9lkEBtpFECw9C7ElrnPwSTyo/PwW8+dlbWT94QTOLYsbsFROk9oJFJq64PbE/klAKWVqBYv9dRxRb/1EB1zDCzEcZtmEfjXTZV3g/yXL9Vt7Eba+9PlKcos+RTLPp6VldIff6fLrUgMwXbz5b0+1M42biH2Yt1usrY3gxMvoMSjdCF7zrTuRudE+j58awPMGf91syiobD/6dZfI1Zu2cPiPXn0OKpzW7bVBb7VvgfxnQN1La5rPPhWyftYtOzslbd/oaYsrrxySXn2u0guorRoxeqYNX0KNJHnKZYIr7BrFMzOTW3YTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rgh5C8MbAhWxnPsCHaYw2uK6/aommoFHRo0Pl+tnnU=;
 b=kaSY0mYzdmcHjTAVKXLf5Ne2yw5ngi3dQ513zb+WzR4ECjYOguRk2pmXyFHnfLg3G1BnI8qpXCZv5aMHPAil8QuhsEX6rLAW6iHJ4PYUtSMASNXBXhbo+VLXDMNWc4jDk5w+G6aqUUeebe07aWgBbtBydF5HUqVoOZ7t52YwlOVkIoExk1AVj6ET8r1S85pFgK392CmKr8e4Ifs4DeOj6mefI1ZFJiltycxsisn+IUnIx85obATB6WSPTmYeuWQyDaBbXkywGhBj5ap6EH7kSYT/EgsWS7+6N4cMBxbCXYTZ9mwG63QBV2VpeTD2rYF0Br4zq3aBVtXdnt951qZqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rgh5C8MbAhWxnPsCHaYw2uK6/aommoFHRo0Pl+tnnU=;
 b=tC8RXtiL52Ueooirhs8lii5f728ivehvg/MTuFtSLRRy2wZl3XP6fHEGRfLvz7tWr7jBH1xkFYJOJFaNeXeA203Xooe/5V2WqfLMJ+yHattyVASI8A5fyvhG/86OyyxUXME5OAqW7hSwtqhwjUL2q0NmHw6ppmlcQSfSbeRivbE=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 12:55:08 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 12:55:08 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <87h6ijfayj.fsf@oracle.com> (Jose E. Marchesi's message of "Thu,
	08 Feb 2024 12:32:20 +0100")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	<87h6ijfayj.fsf@oracle.com>
Date: Thu, 08 Feb 2024 13:55:04 +0100
Message-ID: <87wmrfdsk7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0106.eurprd02.prod.outlook.com
 (2603:10a6:208:154::47) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: be8b275f-2e0e-482b-3f87-08dc28a52de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CgAAJSO+n6gQn0oV0mwMcZmtBnrV76VndOLAr+dz4kaQ+HFAKxtFkSciERtKb1E98vlREv/jW262GjHtt5YNwJbFb/kMpoSpOUxHngEXi1eN1R/WX3o70W9DLWG6Ctt55p9dtkIWC/d7L0m+vJ02dBDNEvYf8bbNUb/Gkuyix8qPC1IX+52pIMz4eiR7JqLVmdsukDK/zWnv1qTPClbnx7KmIqUIRZmPeRXeV4VAQ1jiUEGJvzSQ6kCbMyvotHYIwrUpGzVXXVCGaYMhyTMnLF6SD6rGr1WFgtyVZyd4exS0iZje+5Xq779uHLFgM92LgLdJFkIH9bZbzpxvr8LdCHFu7Zz3qtP6SUz7Zp+FnyctcUVhkJqu4NvMi404TQMrz9WVVZjMGhkm4ZGABObtSNf4zLVhY/g63siwJspBHvs6cC7DrLbFSLyFhayNI4vZpDWvBc0xvCr1L700o5I/HOruhqnv7e8g/60Oc1KfV60UTBcSykj0u2DvhnWL0yCM4IZi+IMI9t6iPd7o6wyFU+mn2I7CIas/OkmvzqNxF6SRNGhcmZ5oO2PxRiCLBDL5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(36756003)(86362001)(41300700001)(8936002)(316002)(8676002)(6916009)(66946007)(66556008)(54906003)(66476007)(38100700002)(83380400001)(107886003)(26005)(6512007)(5660300002)(4326008)(2906002)(2616005)(6506007)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O1Eo9wIfxYd3wODzh04+WeeeeAZlZ//E17EP1WC/PzSmxPRS08vM8vzjhzgT?=
 =?us-ascii?Q?WWFYpb+sBxZC+mzaY1D/yKy+OngSTTH70+3jNbUfOGJhtrq7dXi8PK35fHmN?=
 =?us-ascii?Q?VQD/ePKE4rEFP3ulr2SGXd+g76sE96e7Ovw6L6z9I0owTxHts0sE/0ftKhPK?=
 =?us-ascii?Q?jachqifja0FLe7iF7wmLV0ij1vWB7QQwjuyFAF/JQWM8Y3PH2SFNWQ2nkkgX?=
 =?us-ascii?Q?/hIxTcFjtc9cvfq/b/lCmchEIxydqlkNM/SaAntSPhpD6a2sPvze1qoOy09j?=
 =?us-ascii?Q?3MSmeQsu719aE9teb4km2HBLbHxUMe6tKEdvzqKDIGmQP46VSPg07SXSgVKy?=
 =?us-ascii?Q?CfZpgWVQuFZRWQ+a3I0rkEtw9rBooqzh1cvcn2sxWrnffmGiPY37Y4bqICSd?=
 =?us-ascii?Q?MPE3jRl7QHBt47bgNfoYNnQWKDE+ZcJJnKbDGX+1XxxftOkLvLdKnbenu+uq?=
 =?us-ascii?Q?SLr7A7igxfmUVYKoJuLKc2jlmVG7kdMAvd/dzCgAjh2GkfJvwlKUeAuzoGyd?=
 =?us-ascii?Q?X1bw/GV78MM8wkhUqt34B9eKgFLns+LYGRol6Ok+Cq4iHneW7jIzbCYed6MY?=
 =?us-ascii?Q?2AP1bXqFYhltusprNSSfw+ncPHn9ckI4Gz+vgd8Ijnsau4K7XhZZ6HiPd7t+?=
 =?us-ascii?Q?BJOEONxCFKTBv50b64KiaN8IEpOQF6BEHWuP72mQD8hO+BI6DE1YnAw5OErD?=
 =?us-ascii?Q?TICzFYawqGNTztfpsQwP5n3tMMoSabcDdXOD/H+HhemmOpzbZG+GWeTVWqyg?=
 =?us-ascii?Q?otA45hgrh238lin+L3rLDfl6rZXs7Yo0maq7643WTXGWmByzRKZ6XvTohI3d?=
 =?us-ascii?Q?iklFmHMrPktS0kUBEWzQT8Rv5vzCYvFuiM3/1+5FhndFyktEfPPUDdH1n09D?=
 =?us-ascii?Q?i8+FP9NoaDSGbUVU1WrEC+KhjCseCG9Y7oY5aitS8zpztJuRuN8HclAYuI+u?=
 =?us-ascii?Q?pVvMwuR9iHwVsgt9BEaKIpKBF6Sqfm/1XSFX1WxJJgDz4p6M3S+TT4By0/tR?=
 =?us-ascii?Q?HrGk1BQh/gq9s9CoMBCgt0M1ZIaQHXhFJE5dne2C6x0bd4aD3JA6LYJL8eW1?=
 =?us-ascii?Q?9j1kRM/RNLvDgmjzb88MghcZindYDlUkqaSz6va1UqQMIHdhtz1scIDi2ILE?=
 =?us-ascii?Q?hgyeUozEuMiMTm0LYjseXSZ145MI7yzCdmqIpW4+HODIue/VpRA74h71HGSz?=
 =?us-ascii?Q?YaQ1BSzdiC8PMmx84ObbnvRscVtJXkBa6otdSIlZ6dPZ2Zt32MdWyG1zLF/7?=
 =?us-ascii?Q?8V73/s1BvS6tKoxub4rP3wW36mbbSFjcWV0JGj8Rsab6z9d7wgeFjhxOV6NB?=
 =?us-ascii?Q?XRVTpPF6lL5UgGIxVU6A4DZT84vuwuky/PklfWZVIFCWI33Aj1wJlAippjaI?=
 =?us-ascii?Q?omWC2z8anlP8F+hcQqKLrU2F9uQzDMx1blzzRfAYVzXQ/3uWYL67Yu3THTR9?=
 =?us-ascii?Q?Olobv2xIcU0XyP09LEs3EgKVMcE/aoYEz+32fOnccGOhrVMbU68ron879aSE?=
 =?us-ascii?Q?mSIU9JIbQDb8xmpFylg109yF3YPYyjo+Tc67EPN7Dq9TsFQYHvCzZiSE1auB?=
 =?us-ascii?Q?E1rcARyj3rs4kjmyqUB90YARdtYCWqgshLoCG+6iY+21Bv0slwj5DRbBKQkR?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iHEOObGYO54V4FFsRX09Sfj1onyQXeOSdoxQ2w+F+iTaz5Wtk2RDt7vrgbd6PbqpRQ6E0dEKS2ww0A09PHxP+eCCafTHINq0SR22ZU1El9CKWjHOHXVUtCbKXCOXocbtj/2MEPviv3NuDUOAlc8FJ92VHtVHDSLL09KNKEpZhH5f8iq07+KcgtaAvSdxnvE59pPaD/GhDNWmz83yl51wtrsNcOM0rnwV2lhJOUkL7XmWGSST9/4nboiZTR2Xsvml78SxJY2pl7vq9P6Vw9a8B5hsGPOl2QiRa2sP2l36C7p3DnhOYfy5fObeqN5M+7gCzAHvwg/J0++7vsVUXISoTmVYSCLj2SeHDo5VwBPfyS6+JLQ/+DU1IQJqnFnGPIruEJrL+eARRpV+coWkKR+j4FMaAN8UzTHe+Lip+qNxQlVyJa6UufSvUBdIiPwmHD/3jxZf21TsNU+2/glTgGxhOIAb3V3ov+x2epMAl60Bxap8833fvNPrkkrfmNW58452l2swmlFrFHK5m+nct+viEr49CBFDXe5Wq+gmI/ghf7cHfuki819xad9kJo8bpW1TIg1uNQGMUgQ4mrGB5waG+G498gGwXqu3MqPSYsJoTys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8b275f-2e0e-482b-3f87-08dc28a52de9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 12:55:08.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtGI/ZYb7vZf/bXSwNGJHmEeQbsVTmar8XdffmDH9/ZUSPRKUZ9LvIti7OQPEaiLq/3w+Z+kTKcqV3B2bKRwject2SeqZjCbJINHhqENrnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_04,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=906 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080068
X-Proofpoint-GUID: zIEy0Z51DivYcuZBfrDr1CgIALFeXQOx
X-Proofpoint-ORIG-GUID: zIEy0Z51DivYcuZBfrDr1CgIALFeXQOx


>> You are right, at -O2 level, loop unrolling is enabled by default.
>> So I think '#pragma unroll' can be removed since gcc also has
>> loop unrolling enabled by default at -O2.
>>
>> Your patch has a conflict with latest bpf-next. Please rebase it
>> on top of bpf-next, remove '#pragma unroll' support and resubmit.
>> Thanks!
>
> Note profiler.inc.h contains code like:
>
>   #ifdef UNROLL
>   	__pragma_loop_unroll
>   #endif
>  	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {
>
> And then it is inluded by several test programs, which define (or not)
> UNROLL:
>
> profiler1.c:
>
>   #define UNROLL
>   #include "profiler.inc.h"
>
> profiler2.c:
>
>   /* undef #define UNROLL */
>   #include "profiler.inc.h"
>
> In contrast, in pyperf.h or strobemeta.h we find code like:
>
>   #ifdef NO_UNROLL
>   	__pragma_loop_no_unroll
>   #endif /* NO_UNROLL */
>   	for (int i = 0; i < STROBE_MAX_STRS; ++i) {
>
> And then programs including it define NO_UNROLL to disable unrolling.
>
> If -funroll-oops is enabled with -O2 and BPF programs are always built
> with -O2, then not defining UNROLL for profiler.inc.h, seems like
> basically a no-op to me, because unrolling will still happen. This is
> assuming that #pragma unroll in clang doesn't activates more aggressive
> inlining.

With the patch below, that basically inverts the logic of these
conditionals in profiler.inc.h, the selftests still pass running
./vmtest.sh -- ./test_progs.

However, it would be good if some clang wizard could confirm what
impact, if any, #pragma unroll (aka #pragma clang loop unroll(enabled))
has over -O2, before ditching these pragmas from the selftests.

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index de3b6e4e4d0a..0a30162e53d2 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -168,8 +168,8 @@ probe_read_lim(void* dst, void* src, unsigned long len, unsigned long max)
 static INLINE int get_var_spid_index(struct var_kill_data_arr_t* arr_struct,
 				     int spid)
 {
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 		if (arr_struct->array[i].meta.pid == spid)
@@ -184,8 +184,8 @@ static INLINE void populate_ancestors(struct task_struct* task,
 	u32 num_ancestors, ppid;
 
 	ancestors_data->num_ancestors = 0;
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 	for (num_ancestors = 0; num_ancestors < MAX_ANCESTORS; num_ancestors++) {
 		parent = BPF_CORE_READ(parent, real_parent);
@@ -211,8 +211,8 @@ static INLINE void* read_full_cgroup_path(struct kernfs_node* cgroup_node,
 	void* payload_start = payload;
 	size_t filepart_length;
 
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 	for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
 		filepart_length =
@@ -260,8 +260,8 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 	if (ENABLE_CGROUP_V1_RESOLVER && CONFIG_CGROUP_PIDS) {
 		int cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id___local,
 						  pids_cgrp_id___local);
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 		for (int i = 0; i < CGROUP_SUBSYS_COUNT; i++) {
 			struct cgroup_subsys_state* subsys =
@@ -401,8 +401,8 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 				get_var_kill_data(ctx, spid, tpid, sig);
 			if (kill_data == NULL)
 				return 0;
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 			for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 				if (arr_struct->array[i].meta.pid == 0) {
@@ -481,8 +481,8 @@ read_absolute_file_path_from_dentry(struct dentry* filp_dentry, void* payload)
 	size_t filepart_length;
 	struct dentry* parent_dentry;
 
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 	for (int i = 0; i < MAX_PATH_DEPTH; i++) {
 		filepart_length =
@@ -507,8 +507,8 @@ static INLINE bool
 is_ancestor_in_allowed_inodes(struct dentry* filp_dentry)
 {
 	struct dentry* parent_dentry;
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 	for (int i = 0; i < MAX_PATH_DEPTH; i++) {
 		u64 dir_ino = BPF_CORE_READ(filp_dentry, d_inode, i_ino);
@@ -628,8 +628,8 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 	struct task_struct* task = (struct task_struct*)bpf_get_current_task();
 	struct kernfs_node* proc_kernfs = BPF_CORE_READ(task, cgroups, dfl_cgrp, kn);
 
-#ifdef UNROLL
-#pragma unroll
+#ifdef NO_UNROLL
+#pragma clang loop unroll(disable)
 #endif
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {
 		struct var_kill_data_t* past_kill_data = &arr_struct->array[i];
diff --git a/tools/testing/selftests/bpf/progs/profiler1.c b/tools/testing/selftests/bpf/progs/profiler1.c
index fb6b13522949..c32783826f36 100644
--- a/tools/testing/selftests/bpf/progs/profiler1.c
+++ b/tools/testing/selftests/bpf/progs/profiler1.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#define UNROLL
 #define INLINE __always_inline
 #include "profiler.inc.h"
diff --git a/tools/testing/selftests/bpf/progs/profiler2.c b/tools/testing/selftests/bpf/progs/profiler2.c
index 0f32a3cbf556..17da6089212b 100644
--- a/tools/testing/selftests/bpf/progs/profiler2.c
+++ b/tools/testing/selftests/bpf/progs/profiler2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #define barrier_var(var) /**/
-/* undef #define UNROLL */
+#define NO_UNROLL
 #define INLINE /**/
 #include "profiler.inc.h"
diff --git a/tools/testing/selftests/bpf/progs/profiler3.c b/tools/testing/selftests/bpf/progs/profiler3.c
index 6249fc31ccb0..cc7f9aee6d9e 100644
--- a/tools/testing/selftests/bpf/progs/profiler3.c
+++ b/tools/testing/selftests/bpf/progs/profiler3.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #define barrier_var(var) /**/
-#define UNROLL
 #define INLINE __noinline
 #include "profiler.inc.h"

