Return-Path: <bpf+bounces-31535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D188FF4CA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 20:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7BBFB2794F
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4E14652D;
	Thu,  6 Jun 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFBDx85B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LdbBQC2p"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5EBFC02
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698980; cv=fail; b=Iw+rl0L5/cyLN6nPhH0iiMsnSfBYtaXGZ9nzi811DzEFZwrh9PaUrXyXSKkhdHD3acrkdvRxjJAcNIXOYIA+RfcAU8iHF09+qZfGKVQS5IOh2w+xgVE504VMUy05UgIr+/mWTp390yPst3o+F0nvLXDCLhRM8l8+TS36aHR/Luw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698980; c=relaxed/simple;
	bh=yC3fQGDDHzYKtYWKZHGwHNMXeCP6wjqh8gK3pSrUlPE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=TT3i3qgE+QY+8OTJBLjNdhdIAo6z5OdrapQT1G084opwWITzDMpYDTr8emaN3QkhTAtGILUzMODxNPA7rrjYCArv7vz/paDujLwxtw8+BQxbg48y5KHsihifTBD3MeDVv408v04ckTfXgWRmXXwNg9WkpVvZ238f4wfMzepYWEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lFBDx85B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LdbBQC2p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456Hwlph026843;
	Thu, 6 Jun 2024 18:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=+BigaSmrnbG8U0ydJS11HBnGBsLCdXapoFV8R1zAO5c=;
 b=lFBDx85BAVZ5rXWJQ8xlqdLi5vh0UFR5LVC+q8AoWP40EiooHV/DLNsuJI0c01osmeIB
 +RLP5ylSb1t4UiPk2XcrqSLiupWN1G/rQAITiNjbigKWQBz4DYzZNR+OY/aeL1giRyBo
 MvBBp3robsH3cT2Lg9DcS62I/Njo+EKSpAGf13Oa3aX5ih/HjFz+V85BKx3onxIOO07r
 8E593FEDrqw4mQFBD/QW6IVqDrwfm+xBBW0nzfKPYV6K+nibq5y2IYKAFtpVu3wm2b6J
 NXVNbTEPF49c0rdXUz9brXJr1JXl94voiHg56Wj25zgyDwdUOLJu3H7MvZM2Nfs6K9Oq rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ykct30srs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:36:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456GvBI4023954;
	Thu, 6 Jun 2024 18:36:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr18565-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDCCBXeIwrcpeF8KBot4EiEiGQrdBtevvYF04HbtTr9Ge4EKuxvkRKhZz+m1ZSJ9AZ+J7CNQCPq/+PLzovVf3K4439R2i5r5R9keqHLhkT56urAf6RqH24Ppkw1W1t8x8gmiHUDBIKJ3bmUU7x/AD1G0AFI5uGw8KaQ2GhNMbSXOLyuZl9PxWX8ioQcIR5+kFrXWyT2mzsT1AYu2d+Ec1c/ljlQVuIge2+F7feOrumiVcpofnvwBGh8n3BDBlr3i+DFO8svWzzfsS6YA+aqxNvItXtq+g0iXl2SIZrPs8JZu8C3XuwmG7hjLWjYqShTpfGwBIJFO3D5XW5I+mE4Klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BigaSmrnbG8U0ydJS11HBnGBsLCdXapoFV8R1zAO5c=;
 b=bvqF7bZzrqQbC8dKnwTVAeGLr5DMZCBsnZ7iVqtLrqiktZMRFRjM04aIF9IuZC7RUckIvTMH8ouHQ8r65F5OTQ7VM0IvMsWUfhx0/MOoOzVvrSXo+0n6DUdlE2LDndWQXSNPFrmir5XynIBJDgHcRVIdVjzjsXpu8so1o8rMqrrXmQbWaG7PBnmqJ8qnKjpyIRdmb1zBMio9D3tUPn48uroUVjOrBhJ7Y0j4lIYzOdvFdvtbhkuHsRX3q7dc9wd5I2IZYqK5ok1Bd20G8BHH6wqlfCkJYnMRgK08Oc7M3yR3VLSd4/raJ1cqDf4t/nzlPJwMkcvCfsf7hdwUGOnv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BigaSmrnbG8U0ydJS11HBnGBsLCdXapoFV8R1zAO5c=;
 b=LdbBQC2pDxdleTUrqcb7FE0DF1j1u/MYl6EhFDwPkxCq9lDHUvjB7ra4itIGu0gd1K0yGYyGwvn/VQU69w1ow5Vn3062pvempuVdSMLi1wKhvjLf1UXX3HU3arnyRURojdqvQSPmXKkwtzVZuKEDVeZAY12TG/B9arKNDy/V1Fg=
Received: from BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 18:36:12 +0000
Received: from BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c]) by BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 18:36:07 +0000
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
 <20240603155308.199254-3-cupertino.miranda@oracle.com>
 <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
 <87ikymz6ol.fsf@oracle.com>
 <CAEf4BzaVkJghcSpLdRdwmRyGVj+SoUnF88d-9e5Xvb7fmuKt4A@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com,
        Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular
 expression.
In-reply-to: <CAEf4BzaVkJghcSpLdRdwmRyGVj+SoUnF88d-9e5Xvb7fmuKt4A@mail.gmail.com>
Date: Thu, 06 Jun 2024 19:35:57 +0100
Message-ID: <87wmn19awi.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0054.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::18) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: e67c84a8-f4b4-4c59-5af5-08dc86578777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?azBZWTZqQzNtbG9Yd0tyaWlQOElFdnVEdDFhTW9DSXl5dTF0UGJoMUxtNm8y?=
 =?utf-8?B?RDhBZXpCcmdJT3hZdEVhUXJtNnFMa2MyZzZIeENQSlpNV1lXZnI4ZUxpem8v?=
 =?utf-8?B?NVN0Q2FiNGwxbWw3WjkvRzN5ZE5LaHRDY21sNlFLMGw0S1Q0MW5GSVZIdUd2?=
 =?utf-8?B?ZTFYOVdHZXVsUHovZDlTSVZiVnBoL2IrbVFDaE1nQ1VkTTltd2h1cnVlWDJR?=
 =?utf-8?B?RlBTZXE0NGRIQ21ZUEhmazE1SWIwS2FCL1ZDODIwS3dUWUp0UGdpejNCdnVG?=
 =?utf-8?B?T2ZjaGhhTXZIcmNGTkI0TE8xWjU4QjBlYVo1Y1hoMmtDSUhWZnhKWDZIdTJG?=
 =?utf-8?B?T3NtYVNJTktDSnpXVXBOTXBJbnBFbWZWYkhLdHluWXAyeHZuVkIrT1JFQnJM?=
 =?utf-8?B?eHcxb0ZFNTNPbStlNHVjK3NoL2dnUzVuRVdvdUVZTDA5SVBFcjBSWFJ6MTBl?=
 =?utf-8?B?c2tTa1E5MUpJUXliN3lkTTEyVDg0SjBHSFhSMXVvalNoSnFLckRuOTJ4aUJ5?=
 =?utf-8?B?ZVRpdkptWTJCOTRMcy8xelNsbUtIc2E5aFdWVFVMOHVUaWRlcmdtbjB1VkFM?=
 =?utf-8?B?UXBTT1prTFJxOFlJaXBubHAwYjdsSU0wU3BhUUZrYVhUSS9qWUtLaVN0QmVI?=
 =?utf-8?B?VGlNYnVHZnRRYjNkMUNqSHdxUFErMG1lRWpodDhYWnM3QXVFV3pVL0ttTTF3?=
 =?utf-8?B?NjNrdjZQaWZuUy9FMDd3ZkFHWk5rcitJaHNGY0xDSUlweHNlcU51ODhPblNi?=
 =?utf-8?B?bnRhVWxiSnYzZ1lmeG83S1R1ekNKOWMxS0hKQ1dsc2ZjSlRoOWNRUW5YNWw5?=
 =?utf-8?B?WCtVL3hPRk1UMUs2WFdVbmFKWUdVeEE5OVFPZDVKWGZJR2pMWmNwZDdaQ01Z?=
 =?utf-8?B?RHdzb1F4U2VSOHJoMGs4WXBsdW9GTFJPdmVJcVdLOGtMNVlTeEgrYUJkK3hh?=
 =?utf-8?B?dDRkUXl3WGR6Ry9tZFhqMENEQi83NHRwTEEyRVMveTUzaXp1MzZtdFQ5bEx5?=
 =?utf-8?B?ZHZNTkVLVGNBUmFnaFJLdWErNnF6QWxla3hnWnMrSGZkUmNWOEVtRXhPN2JM?=
 =?utf-8?B?cXd3MWhkQ09zTGQ1clRtVnI5SktIbUFoQURURVk5VTBSWVlxcGQrZ01icmw5?=
 =?utf-8?B?OFRHMXBsUnZmbUtkdkl1ZVlVWUYyMHJnOVNIYmRUVU9qa2J5OFZVaEFqc0Rq?=
 =?utf-8?B?elFiRjZ1TnlOc1REeTV3Szl0VlBVbG1IQVE4YmN5OERwems5VGQxWEMwQmJT?=
 =?utf-8?B?eEJLd2t0NWk5UXFKNWV5VWFFcGVwK3BIa1VGa3dtaTZhNDZLVXRhc25RNWY5?=
 =?utf-8?B?NEZvT1llYkJOcGRLbjNHQzJDUFJoNnJIVjhpM09rVzUxYkpQK2xvbFlnc0ls?=
 =?utf-8?B?MUVHbjFGY2t4M1JPa0YwS1MvSDFhc2NUNGdHZU1lS3NsV1Z1Y3FMQUY2NFVx?=
 =?utf-8?B?OFB6ZHk2ekVrR1Z4bzJocVhLOEdyc3A3L1RXZ25OTGFFNWJ4OW5ycFhmclBO?=
 =?utf-8?B?UHJuUlNpemhLYTVDc2U4c1pDWGVrdHE1MTVuNkhId1VwTUNhZXB4R2lnR010?=
 =?utf-8?B?N1hLWkEzOUltMWFTWEhzQ3Y1ME43VExqNng5aGZ0dDJZU3JBK1U5blJTN2Ra?=
 =?utf-8?B?RGZkYU9CaWpjUXdFa0pzWlQ1S0tvVnl0ZEx1NkhubTdqaTZ1YUxpYzJYeW1x?=
 =?utf-8?B?WUNlMVlFRHkxNVUvWXc1MlR4cVo0ditXb3c0MzhzQ2lQYU5LSHlNeStuV0VN?=
 =?utf-8?Q?CzZSvKTHL9N4jTptBD29s60nJUsvCw+7RkpSlbt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4371.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWJtQ0hicTdKS3M4cWhJZVk1TmlQa0drZ1VrZUwrZjV5dkp2blRCSkdmUEVL?=
 =?utf-8?B?Z3BFblY4Mmt3U0NjbUNvYnRZWXorUmhVQm1XT3FrSHVOeXVJempGVWsvZUFP?=
 =?utf-8?B?cU9pM3ZaNHEwcGl0Qkg4NFVtTU9zeFZscDJqUFFEdHVSLzF6WFdwYy9ndWhS?=
 =?utf-8?B?MjlYajVZSnBCWjEzL2lPRVRqb2hZY29CNXJOMFBtakJmanpBMGN4eHhWM2d1?=
 =?utf-8?B?aDhyRHdwV2NSdnlLbU5xQ1poVmNvSlJ6aUxLdGsyQzlsR2VtYmpPem9vdENZ?=
 =?utf-8?B?T1B2TndBT3U2M1FQRVFjVzRlOG9haTFzRE0wRjdOYi9PSVhLcEQ4cnR0YXcr?=
 =?utf-8?B?OSttUEFiRWlWbjZSb2pBb2M5alJSTTdBUldVOEhqa0hJdlllM3hOdmJGZEYw?=
 =?utf-8?B?My90bGpLYlYyR0h6S1V5ZHViS2lyU3ZUdmIrUFNyTTNPeS9lMXErNGhGUXRh?=
 =?utf-8?B?Y2RJZklVN093UWZUM285dHlNb3h4WlZMR0RVQVFrbS96WEx3czJ1MmlYdW5T?=
 =?utf-8?B?d1JuVUFhclIrTFZjUzNPMWFlWjdYWTVZRVA4bTFwcU94TjFscGZGK3ptY2c2?=
 =?utf-8?B?aEE4dmp0QVMvUDRzWTBHUkJSYWdIUzhKaFR5Uk9LZ2lMMXlUaklRWnhKRDU1?=
 =?utf-8?B?UzNUd3ZuTm9oT0J0R0xONmhhUmxzQm1qdGF3RlU5eFhsYU1ldE11U1VmdW5W?=
 =?utf-8?B?TGRDSnlvNmpLSDdpWUFxTVNKdWtveGFOQUlvL0xpS0VzMHdXL3hqRi9vYXJY?=
 =?utf-8?B?akdkL255UlFDSFYzdWRZL0ZwQkZkZkxNVFlMVEU2R1VqM05nUjhYR0pJeUp3?=
 =?utf-8?B?V24va1dnZmtrNGsxREVPZUE1YWlMWllwWlUzSUN0dFBtdE45OTAyWFc1RjVN?=
 =?utf-8?B?NXJNeTBDb0dRSWZJKy9XQUo5TFBLWk5YdEtIYXdKZzJ1aWlNdytkdXZMRktY?=
 =?utf-8?B?QkdsZHl4RGpDMUkvYTh5d3dsaFBIcXVGdDFoT2tKWlZiMnpVeTFicWYxb2Jk?=
 =?utf-8?B?V2NXdjB5aE5JTXd6aU9rQmVsSE00UkZVbTZGckpnNXNCT1MrNWcwemFBdGV0?=
 =?utf-8?B?cjl6Q1YwNG9maXpiY1lYbk1aSk9SdnlLTVN6V00wTkRFdUFZbkpMcHIrZG44?=
 =?utf-8?B?L3BzbnNvU1g3S0hwZmJVaTFIcnYrVU5IaHFnd1pzcy9rdjVGeXFsV1V0NFRz?=
 =?utf-8?B?VE1WcXBIR0VmMnpHekcrUk5MelR6eDN0bWZ3alBIMkw2OUdMVXo5bUFKcnVu?=
 =?utf-8?B?ZkFJdExpdXVGRi9PYnMxbGhFbHRMWk1mcElCYnU3QTFuUjlBSUpZT0VkWGxC?=
 =?utf-8?B?dXdzQjlldzViUTZ5T2kyQ1FKdXNjZW4zSTV2Q1hKc3dwS252NnJPTXFxdnZh?=
 =?utf-8?B?d01nakhGT1QzWG1kQVNncW5PR2FMaU1QbXRWZFpuZEVPM0kvdllFNmpVSXRE?=
 =?utf-8?B?dVIramRIejMzK09pTlBMaDdOWG5oOXpxOC8zS0JqMUkxTVZhNlFLb2poN3U4?=
 =?utf-8?B?TUpiUC9ZUFY0KytITUlpdFgwOVBNN1A1UFZBZ1ZLMGd3WFJTMlFkT3pZVkVo?=
 =?utf-8?B?cUtpYzc2bnJYRHZPNzA5bGZMOU5lY3FIUk12Y0wxcnJVOUJuS1VLNFJ5VG1C?=
 =?utf-8?B?WVRUVFA5L3JPTUtyWjZtdVVNaVZoZVlmMFBpWC9qZjBCWm9HNEswQ2VhSFBE?=
 =?utf-8?B?a0RGaFRTeE9USGtFeGlpWmpZSmFzQldtN2FQR3U5UTNuN1pyTDdQZThidnMw?=
 =?utf-8?B?clhwUEJiclJoSFUxWnBLcjhhdzF4eGpUbHdxTHl3R2p3RXM1YmJzVmIxUmhK?=
 =?utf-8?B?Ly94RVg5MU5JTWQyUjljWmpyNzZGWlRCYWQxMFBnVjdBdno2QkM2SEhKWkJy?=
 =?utf-8?B?ZDdZeTZlengraENSREpRTFZGQlR6MHZOUHkrS1E1dVphU05WM2RIeU42Misw?=
 =?utf-8?B?V2g3V1piM1Z4NTVaSkpiRXM5ZU9vVTJOSHdVTmRqaVhSVnMyeVQ3eG9QcFA4?=
 =?utf-8?B?VTR2OGpOZlhZa0lZKzdEZ05ZVG45MTJjR0FTdDRBVzFxSlMxbXdJRGsxYzA0?=
 =?utf-8?B?V25TYW9vaTMwbFJDZUF6R1V6T1lKOTZLSHNpNUI4MXNDYjRBblVaUk53Ny83?=
 =?utf-8?B?cEczanNJbUJIM09McVhFMlFjb1I2enRmK2dIS1A0VDF4cXdKblh4bm10Q0Fz?=
 =?utf-8?Q?YqT7Kvnry4eCcCQsDGWj0qk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sOz6+dfHmGPVqXBAkj7Z96sqdefbRTW1A+C5DP1K3rkqGhFagjx0AmfcmtMv8DHqcrJE0Pkm+k6QT+cKi1OUHzjyDRN7kx9pnFr+zmEOElhLNw/Qnw+GpUETra9+xjM6unDvUSzH4YIJKdWcaJZwy0G9ma37/u2QiVsQVDPj4WD2aIwx9KZc4vxZVdjEY/zNXZIBhuFqH8Y6hgv879NvHgEfZPfcxLuy/0Kf+Qg1T535Qx2smpewd6w5wg4sZ+XGykfqRGq03tjGyOOpjem99EJKU5BQ+E5gAZ2xxnIyPk7Q+G2PvXseUAboEMqefVSod1sOZlCgCnef+QgwzF31bAEQxLP7gbqcVl5DAeeLDCueVYkkL1dvWZGlesA+paTCl5ehdK/xRSQBThLiEGf9kjFr0ItrUxxoMzZ8o1ikQNaxNsGydchou1tz4DP1elDXq3tsPsVPRQ13alePHio+tAeA58YMV5VBXJq0Q6KxJqD/9VbYGxzS4EWl94U+HRwssFwMzfC9Bb/RTADfnNJXA8a/M1nU4MEFZwbXSJUQ4nNxKZwNN9h9oJztKSQqklj7a5iTDZUgMXAoAaIhB8ILP9E1j2+kGnNaEcO7kuT/xgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67c84a8-f4b4-4c59-5af5-08dc86578777
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:36:07.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ReHTGXXgS1AA2alc9oY+++h2rWxep1+Dd+EAuPbVX+GsBQzMxU0xM3GYdif7amnx042TcGjAD9DAzTSWTYLWSjU2NcRbyM6y/kZJqNEWJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060129
X-Proofpoint-GUID: adN-tig8roP2_JRJiC_R_SNFdc2KNMRU
X-Proofpoint-ORIG-GUID: adN-tig8roP2_JRJiC_R_SNFdc2KNMRU


Andrii Nakryiko writes:

> On Thu, Jun 6, 2024 at 3:50=E2=80=AFAM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>>
>> Andrii Nakryiko writes:
>>
>> > On Mon, Jun 3, 2024 at 8:53=E2=80=AFAM Cupertino Miranda
>> > <cupertino.miranda@oracle.com> wrote:
>> >>
>> >> This patch changes a few tests to make use of regular expressions suc=
h
>> >> that the test validation would allow to properly verify the tests whe=
n
>> >> compiled with GCC.
>> >>
>> >> signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> >> Cc: jose.marchesi@oracle.com
>> >> Cc: david.faust@oracle.com
>> >> Cc: Yonghong Song <yonghong.song@linux.dev>
>> >> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> >> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> >> ---
>> >>  tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
>> >>  tools/testing/selftests/bpf/progs/exceptions_assert.c    | 8 ++++---=
-
>> >>  tools/testing/selftests/bpf/progs/rbtree_fail.c          | 8 ++++---=
-
>> >>  tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
>> >>  tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
>> >>  5 files changed, 15 insertions(+), 15 deletions(-)
>> >>
>> >> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/=
testing/selftests/bpf/progs/dynptr_fail.c
>> >> index 66a60bfb5867..64cc9d936a13 100644
>> >> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
>> >> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
>> >> @@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
>> >>   * mem_or_null pointers.
>> >>   */
>> >>  SEC("?raw_tp")
>> >> -__failure __msg("R1 type=3Dscalar expected=3Dpercpu_ptr_")
>> >> +__failure __regex("R[0-9]+ type=3Dscalar expected=3Dpercpu_ptr_")
>> >>  int dynptr_invalidate_slice_or_null(void *ctx)
>> >>  {
>> >>         struct bpf_dynptr ptr;
>> >> @@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
>> >>
>> >>  /* Destruction of dynptr should also any slices obtained from it */
>> >>  SEC("?raw_tp")
>> >> -__failure __msg("R7 invalid mem access 'scalar'")
>> >> +__failure __regex("R[0-9]+ invalid mem access 'scalar'")
>> >>  int dynptr_invalidate_slice_failure(void *ctx)
>> >>  {
>> >>         struct bpf_dynptr ptr1;
>> >> @@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
>> >>
>> >>  /* bpf_dynptr_slice()s are read-only and cannot be written to */
>> >>  SEC("?tc")
>> >> -__failure __msg("R0 cannot write into rdonly_mem")
>> >> +__failure __regex("R[0-9]+ cannot write into rdonly_mem")
>> >>  int skb_invalid_slice_write(struct __sk_buff *skb)
>> >>  {
>> >>         struct bpf_dynptr ptr;
>> >> diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/=
tools/testing/selftests/bpf/progs/exceptions_assert.c
>> >> index 5e0a1ca96d4e..deb67d198caf 100644
>> >> --- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
>> >> +++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
>> >> @@ -59,7 +59,7 @@ check_assert(s64, >=3D, ge_neg, INT_MIN);
>> >>
>> >>  SEC("?tc")
>> >>  __log_level(2) __failure
>> >> -__msg(": R0=3D0 R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff80000002,sma=
x=3Dsmax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
>> >> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff800000=
02,smax=3Dsmax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
>> >
>> > curious, what R0 value do we end up with with GCC generated code?
>> Oups, this file should have not been committed. Those changes were just
>> for experimentation, nothing else. :(
>>
>> >
>> >>  int check_assert_range_s64(struct __sk_buff *ctx)
>> >>  {
>> >>         struct bpf_sock *sk =3D ctx->sk;
>> >> @@ -75,7 +75,7 @@ int check_assert_range_s64(struct __sk_buff *ctx)
>> >>
>> >>  SEC("?tc")
>> >>  __log_level(2) __failure
>> >> -__msg(": R1=3Dctx() R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096=
,smax=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
>> >> +__regex("R[0-9]=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,smax=
=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
>> >>  int check_assert_range_u64(struct __sk_buff *ctx)
>> >>  {
>> >>         u64 num =3D ctx->len;
>> >> @@ -86,7 +86,7 @@ int check_assert_range_u64(struct __sk_buff *ctx)
>> >>
>> >>  SEC("?tc")
>> >>  __log_level(2) __failure
>> >> -__msg(": R0=3D0 R1=3Dctx() R2=3D4096 R10=3Dfp0")
>> >> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3D4096 R10=3Dfp0")
>> >>  int check_assert_single_range_s64(struct __sk_buff *ctx)
>> >>  {
>> >>         struct bpf_sock *sk =3D ctx->sk;
>> >> @@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buf=
f *ctx)
>> >>
>> >>  SEC("?tc")
>> >>  __log_level(2) __failure
>> >> -__msg(": R1=3Dpkt(off=3D64,r=3D64) R2=3Dpkt_end() R6=3Dpkt(r=3D64) R=
10=3Dfp0")
>> >> +__msg("R1=3Dpkt(off=3D64,r=3D64)")
>> >>  int check_assert_generic(struct __sk_buff *ctx)
>> >>  {
>> >>         u8 *data_end =3D (void *)(long)ctx->data_end;
>> >> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/=
testing/selftests/bpf/progs/rbtree_fail.c
>> >> index 3fecf1c6dfe5..8399304eca72 100644
>> >> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> >> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> >> @@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struc=
t bpf_rb_node *b)
>> >>  }
>> >>
>> >>  SEC("?tc")
>> >> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_r=
oot")
>> >> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bp=
f_rb_root")
>> >>  long rbtree_api_nolock_add(void *ctx)
>> >>  {
>> >>         struct node_data *n;
>> >> @@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
>> >>  }
>> >>
>> >>  SEC("?tc")
>> >> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_r=
oot")q
>> >> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bp=
f_rb_root")
>> >>  long rbtree_api_nolock_remove(void *ctx)
>> >>  {
>> >>         struct node_data *n;
>> >> @@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
>> >>  }
>> >>
>> >>  SEC("?tc")
>> >> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_r=
oot")
>> >> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bp=
f_rb_root")
>> >>  long rbtree_api_nolock_first(void *ctx)
>> >>  {
>> >>         bpf_rbtree_first(&groot);
>> >> @@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
>> >>  }
>> >>
>> >>  SEC("?tc")
>> >> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D10")
>> >> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")
>> >
>> > this test definitely should have been written in BPF assembly if we
>> > care to check alloc_insn... Otherwise we just care that there is
>> > "Unreleased reference" message, we should match on that without
>> > hard-coding id and alloc_insn?
>> I agree. Unfortunately I see a lot of tests that fall in this category.
>> I must admit, most of the time I do not know what is the proper approach
>> to correct it.
>>
>> Also found some tests that made expectations on .bss section data
>> layout, expeting a particular variable order.
>> For example in prog_tests/core_reloc.c, when it maps .bss and assigns it
>> to data.
>
> I haven't checked every single one, but I think most (if not all) of
> these progs/test_core_reloc_*.c tests (which are what is being tested
> in prog_tests/core_reloc.c) are structured with a singular variable in
> .bss. And then the variable type is some well-defined struct type. As
> Alexei pointed out, compiler is not allowed to just arbitrarily
> reorder fields within a struct, unless randomization is enabled with
> an extra attribute (which we do not use).
>
> So if you have specific cases where something isn't correct, let's go
> over them, but I think prog_tests/core_reloc.c should be fine.
>
I think it was in progs/test_core_reloc_type_id.c where you also define:

    /* preserve types even if Clang doesn't support built-in */
    struct a_struct t1 =3D {};
    union a_union t2 =3D {};
    enum an_enum t3 =3D 0;
    named_struct_typedef t4 =3D {};
    func_proto_typedef t5 =3D 0;
    arr_typedef t6 =3D {};


>> GCC will allocate variables in a different order then clang and when
>> comparing content is not where comparisson is expecting.
>>
>> Some other test, would expect that struct fields would be in some
>> particular order, while GCC decides it would benefit from reordering
>> struct fields. For passing those tests I need to disable GCC
>> optimization that would make this reordering.
>> However reordering of the struct fields is a perfectly valid
>
> Nope, it's not.
>
> As mentioned, struct layout is effectively an ABI, so the compiler
> cannot just reorder it. Lots and lots of things would be broken if
> this was true for C programs.
>
>> optimization. Maybe disabling for this tests is acceptable, but in any
>> case the test itself is prune for any future optimizations that can be
>> added to GCC or CLANG.
>> This happened in progs/test_core_autosize.c for example.
>
> We probably should rewrite such tests that have to deal with
> .bss/.data to BPF skeletons, I think they were written before BPF
> skeletons were available.
>
>>
>> Anyway, just a couple of examples of tests that were made very tight to
>> compiler.
>>
>> >
>> >>  long rbtree_api_remove_no_drop(void *ctx)
>> >>  {
>> >>         struct bpf_rb_node *res;
>> >> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c=
 b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
>> >> index 1553b9c16aa7..f8d4b7cfcd68 100644
>> >> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
>> >> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
>> >> @@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struc=
t bpf_rb_node *b)
>> >>  }
>> >>
>> >>  SEC("?tc")
>> >> -__failure __msg("Unreleased reference id=3D4 alloc_insn=3D21")
>> >> +__failure __regex("Unreleased reference id=3D4 alloc_insn=3D[0-9]+")
>> >
>> > same, relying on ID and alloc_insns in tests written in C is super fra=
gile.
>> >
>> >>  long rbtree_refcounted_node_ref_escapes(void *ctx)
>> >>  {
>> >>         struct node_acquire *n, *m;
>> >> @@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
>> >>  }
>> >>
>> >>  SEC("?tc")
>> >> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D9")
>> >> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")
>> >>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
>> >
>> > ditto
>> >
>> >>  {
>> >>         struct node_acquire *n, *m;
>> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tool=
s/testing/selftests/bpf/progs/verifier_sock.c
>> >> index ee76b51005ab..450b57933c79 100644
>> >> --- a/tools/testing/selftests/bpf/progs/verifier_sock.c
>> >> +++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
>> >> @@ -799,7 +799,7 @@ l0_%=3D:      r0 =3D *(u32*)(r0 + %[bpf_xdp_sock_=
queue_id]);    \
>> >>
>> >>  SEC("sk_skb")
>> >>  __description("bpf_map_lookup_elem(sockmap, &key)")
>> >> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
>> >> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
>> >
>> > same here and below
>> >
>> >
>> >>  __naked void map_lookup_elem_sockmap_key(void)
>> >>  {
>> >>         asm volatile ("                                 \
>> >> @@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
>> >>
>> >>  SEC("sk_skb")
>> >>  __description("bpf_map_lookup_elem(sockhash, &key)")
>> >> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
>> >> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
>> >>  __naked void map_lookup_elem_sockhash_key(void)
>> >>  {
>> >>         asm volatile ("                                 \
>> >> --
>> >> 2.39.2
>> >>

