Return-Path: <bpf+bounces-12752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14D7D03F2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 23:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC1C1C20F06
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717B3C6A0;
	Thu, 19 Oct 2023 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VIzjYvfA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZAO4SlH+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF2C140
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 21:25:27 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7D1126
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 14:25:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKuOrR011410;
	Thu, 19 Oct 2023 21:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NVpD/rioa6IgW/dibDXcCbCX5zCx8OyfO2+Mm2BjIUs=;
 b=VIzjYvfAQdDh+kakNsNE2+XrwfmhuMHB+h6AMbbw9IEi6ga+a0wVvCdWQwXtTtacDxWD
 gNuTLYGtYV4Uyuy0YvCJITQNg2NZVl6yjI/XSmmjGSR2CTBBLQbIDjYws3GNXI8KMn9N
 oegrR8dXTKZHVZLBjge52qSn5c5zP9yVCYXv7UfG3CH7wN3WoJWags+fFCJ0f6MPo859
 DwKg561e09lcleny6F81PejXNofN5Gk5aCwblfdD2RzkIL90lyNIHamBsvdnwHGCK2ln
 r2UBNlFVxFhhqgvwMXAOPGjQLDnlsI8nTA+B5e6l/PwjJCSbu7af2E77+Para/LSviBp hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubw801m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Oct 2023 21:24:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKsSEb031476;
	Thu, 19 Oct 2023 21:24:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwd105d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Oct 2023 21:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtZkfyZN0Adnj3hFws9NbhGnXyG3i34iA3QiWb5W+v2CeGcgsOs+DY10KNn2SgEEwvEcYjPvsoNwhUbCI4HfPigenvoJz654ciJ9PGDYtl7NbcCcHA+Kjf8iZQJ0kTBdzZ8BCUTkxYBjTNe1lRZwpPFnBX9hkZDD0ji6JVRktbQeLuLsvP0sosDbcVzlsfsvTKJ9XkoOrcnMNUReSKGt4ekA4MAd182dUM3xOYKPVJp5gpw1Fab2t5ZDbUw5zBTpkFAUouMuvMqDkmF2c9sj91WrfByox0vP3qMrVujN0walaqN7t/tbXbgBjVYxsmiut0c6i89ykvACi5vrrpmvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVpD/rioa6IgW/dibDXcCbCX5zCx8OyfO2+Mm2BjIUs=;
 b=gAnS/6dqrOgiYIR7+SUginwVWWJM+E+WMuljC2y2mzjfD9owf0EiktjPAfQPCB7QX1NgDY79bG+wmHQt2S6lASlvo0L7//4ewi4p5TtoDEOCsmJK8Z/V1U/yKeaNsMRiE0HL3J8pbNTuiD77+ZuFSjTTpCHXC07P2IWTbT8fsRIeQ2h1/644f5tC3hCbwudlKpTccxaXl8nANskxezyjotFppdwbOaCqE/UQn22643SuLdgoYKn6rgviUEcT/q4NQN4lQkfnodBJaQXs9upmn1d1lP27sm8Ld5oJr2eu/vsfhPKJtRGMmOTeEa6XJ08BkH5Iwz3Ai9UWIIDXPgnNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVpD/rioa6IgW/dibDXcCbCX5zCx8OyfO2+Mm2BjIUs=;
 b=ZAO4SlH+acmUl76SioWRlRph5gZQx0cxa3j96FY+npo1O0XSSOiqQN1fPV/sS/FaSIfcAaWqgdFrzfi+XhqHQhVcFE8yEJQ4mdi3Ajkq17CyDG1PTslSYj+dONmkvc0dTUi6moHeLu8/VnJiS7W469aFVq/4H+wvjhCtyAL2EuI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6129.namprd10.prod.outlook.com (2603:10b6:510:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 21:24:55 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 21:24:55 +0000
Message-ID: <2ff5ad86-db47-f766-3007-fdfbfdfe55c5@oracle.com>
Date: Thu, 19 Oct 2023 22:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 dwarves 3/5] pahole: add --btf_features support
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org,
        andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
References: <20231018122926.735416-1-alan.maguire@oracle.com>
 <20231018122926.735416-4-alan.maguire@oracle.com>
 <a6d4adeef784737341c959d5a967b9c746d5a297.camel@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <a6d4adeef784737341c959d5a967b9c746d5a297.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dd6ce1-cb73-4aa8-4430-08dbd0e9d6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ieCSpzaygAS3rEeVLuv1aMrXp+4IsHs/ajcSh0wBuT9Qcbz7Y3KEIM0wEytpFQHGCb7fytTvd5J2Oh/r1ztU+9AcUZhB328UE9LCkyiwMeXKT/g601u7k63G9lKURH9/dQa00p5kM4WcvrwOsIyoN2Qaqz1keS8WPE0mFYuiQeP/yficm2HkcoEbe8Ps6kaa+vRa5Jn74NzmAZIViuSY7ajn26IJp9xe1ovcikBV8sF/aOzc8L+nSnkfuGe8GYwiiyx2wmssSnm75EeX77rnbICKEjH2w/i3TaOpDpXQPHrZ8Nz0Jqeyz4NH/3mDpCPUXSNpncK2rrVZx1YLiDDBd07XFs98J0xHfvWuGMf2CZAvjSa8coO9rTuoP54p8mn4EGql/fZCGsTBb9o4jPbw7jYqDYDd+JVOIOlyQL7hsCt/2X83+l8Ljg5RXKbYzeqNqgi/JnaIQ1ad0I/HAbI0CC4oYwapXcIVlPVMOOP8yLu9rPNhJR+19ZabhT56pg3Gk6kDQEzzGOgXWnDYN3xJllnG60IXYRY6VCb57VsVazrcPbF26qjQvAsiTmF+7LG3X63Z1T/JprgYOsUQ7jnXLLFensOLCGWez7WPqgKaQpACEjCPIIFGPwko1biZ9Ph1G0F6naVymYb63F2q60wpIw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(86362001)(31696002)(30864003)(38100700002)(6506007)(44832011)(4001150100001)(41300700001)(36756003)(5660300002)(4326008)(7416002)(2906002)(83380400001)(6512007)(53546011)(2616005)(478600001)(8676002)(6666004)(8936002)(6486002)(66946007)(66476007)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VURrZkppT2dSZzM4YzNtRTk4RkRuYVdIZzdFOG9qcWVBRjcrRGRla210WHJH?=
 =?utf-8?B?WTMybzlXVHFmSitURzBGNzdoVml6ZmwyNEN3d0Z3d1pOYjNBUm9tT1ZBRTAv?=
 =?utf-8?B?Z2xRaVpaTGZTMSt3bjRTRVgwbTZSTkJOVHR6Z04va1ZYMnAzdVRhV3hTMmU3?=
 =?utf-8?B?S1BHdDRqd3NKRXZaZEVnZGZOaFpMYWZMZ2tPc1I2eFFzenJuRTlYaExsYlBa?=
 =?utf-8?B?RGNEckJiMWxzaGdUWVJ6OFZlbWRxa05qVVh3NkRnNDRPWUwzNldBbkhlUDFR?=
 =?utf-8?B?eUpQSForMFpna0pyQVR0ZXJOQllQRXVsNEJ2Z0pWU0Y2QVhaczV2bHlGcllF?=
 =?utf-8?B?SGtQRlQrZHgwK3M1MWlxczBnWC9rTjFXenJuS0tFajQ5cU9tazE4NHh6cVNq?=
 =?utf-8?B?UkJzUU83a1BQSkgvVkdZTklsRUJteVM5WEwyWDU5b2lrQUlSRHlmNzZsWmMw?=
 =?utf-8?B?K21WUGVlSmp5YXVHRXp4V0JocFdHY0dqS1pwaldJWG9idjR3OWJnbFMrOVRy?=
 =?utf-8?B?Yk5WZHQvNS9ScWhvQ2JOOE51V1ZKZXVxR2tQdjh1cjIyaCtLT1ZQeUlhMlpr?=
 =?utf-8?B?MlQ5WW1PQXpUenVHNThVT0p6WVFDaTdaSjhCTTFlN0ovWFJ5dDRicktCMXV0?=
 =?utf-8?B?L1lQc2NVdEFJTUUrU2pBWXF1RGdScVpJOTNJdENSL0QyUFR6ZmgzY05JSEJC?=
 =?utf-8?B?emQyUDM0YlZHWVNZcjBwWmRuSDNKYXg0K2ZyeUJZSmQ2aUNCY3FmSnd1VTFu?=
 =?utf-8?B?bDM2VlpNN0NxTGVpblI5bGdiUnJET0w2WVhKRGQ5NEc1d1dVUnY4a2lJVVlJ?=
 =?utf-8?B?eXJpTEIwUWhsa21EdndCMlJ6SVFtclVWSGsxWHpGc1hVb0hicENkYnRZazk2?=
 =?utf-8?B?cWdUSFlyd3VMcjNJT3dXRTlHVVRZVkVpQ2VtNDhITlZXcG1OUGx0a3VUbC9s?=
 =?utf-8?B?dmtobmVPSi81SFNzTWVlNDBoL1pDUy90UUxDdXdMcEZ0bU9qY01RV0Z5Z3Nv?=
 =?utf-8?B?Vndwc01DNFdLNUU2QUx3c1pDemJzOGJicndaUWpNM1pYRG1GVy8zR20vVy9T?=
 =?utf-8?B?bEhMa1dpRjFsSHl6aFV6bG0zcnhYdHkrMG5Nd0hPcEgwbXhrTEFIM3VmYUtm?=
 =?utf-8?B?WG5SZHV6Umh1VUVLcWMzV2JHZHZhdGNpZmRuWXZTMXZoV2l5K0Z6cGNkSERL?=
 =?utf-8?B?Nm4yUHlpajRPaXdpcnB2Q2VPd2VmbmtEZ1ZRSDY3R1hnaE9iU2l6M3hBamFo?=
 =?utf-8?B?eXc4S2F5aWlyL0RwZ3EzT1JnU3RwYUxQVUxqR3E1bUxuRlNDWFBuTmN3emJn?=
 =?utf-8?B?b3hCSzZ3aTk0RXJGKzBEdkY3ZkpOWmtJUXlDWnhMS2dEY2xvbDFWOWcvSkR1?=
 =?utf-8?B?RmFQNGdza0pUcnlUUDFWakZsS0ZoRUNPTWVCa25pVXFQaEZGZUxFZFJiMWRG?=
 =?utf-8?B?Qm8yYmtONlJqRnhNa0ZyVE5Id0RzT0NkSU1vMGsvRnIyRUp6dFEzc3FreTNQ?=
 =?utf-8?B?Sk5qN09hZzZpalFBM0hQS0p4T21VdzNFbGcyR1FaWjRvQURUeHluVVdob2dZ?=
 =?utf-8?B?MnRjK0JMM09mMXNZVmpYUmNxcS9NdlJ4M1ErUDdjYms1cTR2L1RFQlk1TGtR?=
 =?utf-8?B?ckoyWWJOckJwazBmMjM1bDZjNWFOdDA3YUdrMzFrYnMyYU42c2ZxZGxHdmph?=
 =?utf-8?B?QndPRDRUQ2dLMWROSEJKV0dWQXBScXZGUVNZZFdsMGtEZ1lvaWJUd0hEOUVu?=
 =?utf-8?B?M1RvdFV0V25MMEtKbVcyMW1GY1pHbG9aOEZQbFdUZnAvd3J0ZkFldFJTU2ll?=
 =?utf-8?B?V0ZBYlhkRXYrTkdpVVNaRDVDOFlxaDZQbVJldU9IT0ZlK2hXbE96QktQVDRi?=
 =?utf-8?B?dytGQnl6Nm9sd2xvcndPVTB5bzRVbkFnU0ZQYW5vMXNRenJTOFRmQ1N2ekRZ?=
 =?utf-8?B?TVRVNDArTitnRVhFZEdwNmp2WkUraWhTVDMvVUo4TU5GZFlnT2hVQkJwTC9E?=
 =?utf-8?B?QmZ5enNaMWMzWDZvUS8zVkhTNUIvSW00aGJ5SmVyd1hLZzczMVZVVUtxbzBH?=
 =?utf-8?B?cEZqcHBIY2ZIMy80SmtUWmQ3TDAwam5uQWRTcEFaSWErdkpCVk1ySzc4TDhw?=
 =?utf-8?B?eWE3VkF2VjRCNS9XNkIwMTFhRkpHVnM5QnF0R2Y5VitGaGk4SmFwbXdMNGNa?=
 =?utf-8?Q?gYuAOMKiGxkz60FBekZLyHs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aGUxdG1uYTNzQkNLNlpxamloUVhJSkdRdlU2UnJHallnK2szazd1bmJFSjkw?=
 =?utf-8?B?c0xHdFBOdFBTdXkwcTFUTXR5UHhRNjdoZ0x2VGVGcDdXY0x5dFBJUStOMDdJ?=
 =?utf-8?B?d3N5TWgzazdkOEFaaTBBRHdXbGhramFqdnhNaERPdkFZRmlxWXZTRHFXQmFa?=
 =?utf-8?B?SjZDa2FCZzJiVURCUC9PL2N5enBLSlpaTVAxUHRwTWF5dGR3cElvNkcyNGsv?=
 =?utf-8?B?SHhaeEdxU2FqVlR5a3NGOWdTVTdRUmFxM3VDalJCWmpyRGNGcGNzZVFPWjhB?=
 =?utf-8?B?SVo5bkdWVHFzZFdlVSt3bFhvSHlJTGtLS0xXckFZRytMWitWZmVwSUNGYVdh?=
 =?utf-8?B?SlIvQTlKQWFxektHMDhzQ2hoUXpjU3ZnQmR0ZWg5ZnBicG12YXk3eTU2c2I0?=
 =?utf-8?B?UXFKV3EwZmNjUXp5Z2x5cllWR0tTUGlrQnZzYVh4eU9QVGU0VllPZ3hCVkxz?=
 =?utf-8?B?cExxUEErcG5ON0ZvTWMybDV4YWN1L1Q1YysrOTNwTGtZam43R29RRkRaZHBR?=
 =?utf-8?B?SGdaUHhvYUtFQk8wRFB0MHFRam0xdW9LaUdKUEQrSko0OVRXd3FZbUJBR2xa?=
 =?utf-8?B?TFE3cWZ3anNVMFhHVk1oSFprc01tSG1LODR0ZUw0TWtKRDNpbnpIVnV0bnd5?=
 =?utf-8?B?ejIycnpnQ1U5dHhBNDhjbkNOYUlzSDhPNkE3WmRaWU4zL0pOKzQ0ejE2SUh4?=
 =?utf-8?B?M1gxeU1kRXBsUHdEM2JHQVN3eVlGaDZsM2FSOFlxbGJzcXlRNEVhblpRTnIy?=
 =?utf-8?B?a3p2YjRWeVlXa21nMFplZ1pReERJcGRHbFFuRm9CZ3hiN2xQd0F1NTNhdUdX?=
 =?utf-8?B?RE4vQmxDT1Bia084WWxxY1ByYzUzRVZDMEVGYkpZeS9KakdJSEVndGFHaFAw?=
 =?utf-8?B?SFpOdTZ4c21jeVJsL2NBR0kxQVBnaUN3STQ2OWpvNkZiNUFqRHNzZWdEWHJZ?=
 =?utf-8?B?d3EwaWtrM1lHMFZndVhPRE9XS1QvcXlYTW1LNW1FTmVyWHpabWltRWxWSGpo?=
 =?utf-8?B?VnBLT2poRXJXelRubkkvdTZmM1diMmt4UHVqMUpJdDZoV2FYMldWOVUvUWEz?=
 =?utf-8?B?Mjh1WDNCVHAyUXdMZGF3Q002N0hmRkFZc2tQdWtTY1dvYVNPbnpOWlpRN1dw?=
 =?utf-8?B?bkVBUmVaS0Zxa1BTVTNRNGRyMTVldXNycS9ja0xqdERnOG9RY3Roc2M5YkVD?=
 =?utf-8?B?TUNHcHhPZGNvSDc0a1R2ZlJRd2EyQklNR1Jtc3B4T1BuanN4SDBxRXMxYXRv?=
 =?utf-8?Q?zbMLLIGNUJUbTRG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dd6ce1-cb73-4aa8-4430-08dbd0e9d6aa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:24:55.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHlt159+2P83ZBFBCqpeCScayHb1pEXjsGAqklPEHNtru6nfQvuQF6dpjjgVC2SParX9xC3PWP5WfEfFbfdQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310190181
X-Proofpoint-GUID: Yh9ImzAQVURPB3mmSSmUIMiwcZEkRn4P
X-Proofpoint-ORIG-GUID: Yh9ImzAQVURPB3mmSSmUIMiwcZEkRn4P

On 19/10/2023 12:07, Eduard Zingerman wrote:
> On Wed, 2023-10-18 at 13:29 +0100, Alan Maguire wrote:
>> This allows consumers to specify an opt-in set of features
>> they want to use in BTF encoding.
>>
>> Supported features are a comma-separated combination of
>>
>> 	encode_force    Ignore invalid symbols when encoding BTF.
>> 	var             Encode variables using BTF_KIND_VAR in BTF.
>> 	float           Encode floating-point types in BTF.
>> 	decl_tag        Encode declaration tags using BTF_KIND_DECL_TAG.
>> 	type_tag        Encode type tags using BTF_KIND_TYPE_TAG.
>> 	enum64          Encode enum64 values with BTF_KIND_ENUM64.
>> 	optimized_func  Encode representations of optimized functions
>> 	                with suffixes like ".isra.0" etc
>> 	consistent_func Avoid encoding inconsistent static functions.
>> 	                These occur when a parameter is optimized out
>> 	                in some CUs and not others, or when the same
>> 	                function name has inconsistent BTF descriptions
>> 	                in different CUs.
>>
>> Specifying "--btf_features=all" is the equivalent to setting
>> all of the above.  If pahole does not know about a feature
>> specified in --btf_features it silently ignores it.
>>
>> The --btf_features can either be specified via a single comma-separated
>> list
>> 	--btf_features=enum64,float
>>
>> ...or via multiple --btf_features values
>>
>> 	--btf_features=enum64 --btf_features=float
>>
>> These properties allow us to use the --btf_features option in
>> the kernel scripts/pahole_flags.sh script to specify the desired
>> set of BTF features.
>>
>> If a feature named in --btf_features is not present in the version
>> of pahole used, BTF encoding will not complain.  This is desired
>> because it means we no longer have to tie new features to a specific
>> pahole version.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>  man-pages/pahole.1 |  24 ++++++++
>>  pahole.c           | 137 ++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 160 insertions(+), 1 deletion(-)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index c1b48de..a09885f 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -273,6 +273,30 @@ Generate BTF for functions with optimization-related suffixes (.isra, .constprop
>>  .B \-\-btf_gen_all
>>  Allow using all the BTF features supported by pahole.
>>  
>> +.TP
>> +.B \-\-btf_features=FEATURE_LIST
>> +Encode BTF using the specified feature list, or specify 'all' for all features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported features are
>> +
>> +.nf
>> +	encode_force       Ignore invalid symbols when encoding BTF; for example
>> +	                   if a symbol has an invalid name, it will be ignored
>> +	                   and BTF encoding will continue.
>> +	var                Encode variables using BTF_KIND_VAR in BTF.
>> +	float              Encode floating-point types in BTF.
>> +	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
>> +	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
>> +	enum64             Encode enum64 values with BTF_KIND_ENUM64.
>> +	optimized_func     Encode representations of optimized functions
>> +	                   with suffixes like ".isra.0".
>> +	consistent_func    Avoid encoding inconsistent static functions.
>> +	                   These occur when a parameter is optimized out
>> +	                   in some CUs and not others, or when the same
>> +	                   function name has inconsistent BTF descriptions
>> +	                   in different CUs.
>> +.fi
>> +
>> +So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
>> +
>>  .TP
>>  .B \-l, \-\-show_first_biggest_size_base_type_member
>>  Show first biggest size base_type member.
>> diff --git a/pahole.c b/pahole.c
>> index 7a41dc3..0e889cf 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1229,6 +1229,133 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>  #define ARGP_skip_emitting_atomic_typedefs 338
>>  #define ARGP_btf_gen_optimized  339
>>  #define ARGP_skip_encoding_btf_inconsistent_proto 340
>> +#define ARGP_btf_features	341
>> +
>> +/* --btf_features=feature1[,feature2,..] allows us to specify
>> + * a list of requested BTF features or "all" to enable all features.
>> + * These are translated into the appropriate conf_load values via a
>> + * struct btf_feature which specifies the associated conf_load
>> + * boolean field and whether its default (representing the feature being
>> + * off) is false or true.
>> + *
>> + * btf_features is for opting _into_ features so for a case like
>> + * conf_load->btf_gen_floats, the translation is simple; the presence
>> + * of the "float" feature in --btf_features sets conf_load->btf_gen_floats
>> + * to true.
>> + *
>> + * The more confusing case is for features that are enabled unless
>> + * skipping them is specified; for example
>> + * conf_load->skip_encoding_btf_type_tag.  By default - to support
>> + * the opt-in model of only enabling features the user asks for -
>> + * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
>> + * type_tags) and it is only set to false if --btf_features contains
>> + * the "type_tag" keyword.
>> + *
>> + * So from the user perspective, all features specified via
>> + * --btf_features are enabled, and if a feature is not specified,
>> + * it is disabled.
>> + *
>> + * If --btf_features is not used, the usual pahole defaults for
>> + * BTF encoding apply; we encode type/decl tags, do not encode
>> + * floats, etc.  This ensures backwards compatibility.
>> + */
>> +#define BTF_FEATURE(name, alias, default_value)			\
>> +	{ #name, #alias, &conf_load.alias, default_value }
>> +
>> +struct btf_feature {
>> +	const char      *name;
>> +	const char      *option_alias;
>> +	bool		*conf_value;
>> +	bool		default_value;
>> +} btf_features[] = {
>> +	BTF_FEATURE(encode_force, btf_encode_force, false),
>> +	BTF_FEATURE(var, skip_encoding_btf_vars, true),
>> +	BTF_FEATURE(float, btf_gen_floats, false),
>> +	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>> +	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
>> +	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
>> +	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
>> +	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
>> +};
>> +
>> +#define BTF_MAX_FEATURES	32
>> +#define BTF_MAX_FEATURE_STR	1024
>> +
>> +bool set_btf_features_defaults;
>> +
>> +static void init_btf_features(void)
>> +{
>> +	int i;
>> +
>> +	/* Only set default values once, as multiple --btf_features=
>> +	 * may be specified on command-line, and setting defaults
>> +	 * again could clobber values.   The aim is to enable
>> +	 * all features set across all --btf_features options.
>> +	 */
>> +	if (set_btf_features_defaults)
>> +		return;
>> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++)
>> +		*btf_features[i].conf_value = btf_features[i].default_value;
>> +	set_btf_features_defaults = true;
>> +}
>> +
>> +static struct btf_feature *find_btf_feature(char *name)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
>> +		if (strcmp(name, btf_features[i].name) == 0)
>> +			return &btf_features[i];
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static void enable_btf_feature(struct btf_feature *feature)
>> +{
>> +	/* switch "default-off" features on, and "default-on" features
>> +	 * off; i.e. negate the default value.
>> +	 */
>> +	*feature->conf_value = !feature->default_value;
>> +}
>> +
>> +/* Translate --btf_features=feature1[,feature2] into conf_load values.
>> + * Explicitly ignores unrecognized features to allow future specification
>> + * of new opt-in features.
>> + */
>> +static void parse_btf_features(const char *features)
>> +{
>> +	char *feature_list[BTF_MAX_FEATURES] = {};
>> +	char *saveptr = NULL, *s, *t;
>> +	char f[BTF_MAX_FEATURE_STR];
>> +	int i, n = 0;
>> +
>> +	init_btf_features();
>> +
>> +	if (strcmp(features, "all") == 0) {
>> +		for (i = 0; i < ARRAY_SIZE(btf_features); i++)
>> +			enable_btf_feature(&btf_features[i]);
>> +		return;
>> +	}
>> +
>> +	strncpy(f, features, sizeof(f));
>> +	s = f;
>> +	while ((t = strtok_r(s, ",", &saveptr)) != NULL && n < BTF_MAX_FEATURES) {
>> +		s = NULL;
>> +		feature_list[n++] = t;
>> +	}
>> +
> 
> Sorry, I should have realized it when I sent suggestion for v2.
> It should be possible to merge the "while" and "for" loops and avoid
> hypothetical edge case when old version of pahole is fed with 33 items
> long feature list. As in the diff attached to the end of the email.
> Feel free to ignore this if you think code is fine as it is.

Yeah, it's definitely neater, thanks! I suggest we wait to see if anyone
else has additional suggestions, and I can roll the below into a v4
unless anyone objects.

Alan

> 
>> +	for (i = 0; i < n; i++) {
>> +		struct btf_feature *feature = find_btf_feature(feature_list[i]);
>> +
>> +		if (!feature) {
>> +			if (global_verbose)
>> +				fprintf(stderr, "Ignoring unsupported feature '%s'\n",
>> +					feature_list[i]);
>> +		} else {
>> +			enable_btf_feature(feature);
>> +		}
>> +	}
>> +}
>>  
>>  static const struct argp_option pahole__options[] = {
>>  	{
>> @@ -1651,6 +1778,12 @@ static const struct argp_option pahole__options[] = {
>>  		.key = ARGP_skip_encoding_btf_inconsistent_proto,
>>  		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
>>  	},
>> +	{
>> +		.name = "btf_features",
>> +		.key = ARGP_btf_features,
>> +		.arg = "FEATURE_LIST",
>> +		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
>> +	},
>>  	{
>>  		.name = NULL,
>>  	}
>> @@ -1796,7 +1929,7 @@ static error_t pahole__options_parser(int key, char *arg,
>>  	case ARGP_btf_gen_floats:
>>  		conf_load.btf_gen_floats = true;	break;
>>  	case ARGP_btf_gen_all:
>> -		conf_load.btf_gen_floats = true;	break;
>> +		parse_btf_features("all");		break;
>>  	case ARGP_with_flexible_array:
>>  		show_with_flexible_array = true;	break;
>>  	case ARGP_prettify_input_filename:
>> @@ -1826,6 +1959,8 @@ static error_t pahole__options_parser(int key, char *arg,
>>  		conf_load.btf_gen_optimized = true;		break;
>>  	case ARGP_skip_encoding_btf_inconsistent_proto:
>>  		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
>> +	case ARGP_btf_features:
>> +		parse_btf_features(arg);		break;
>>  	default:
>>  		return ARGP_ERR_UNKNOWN;
>>  	}
> 
> ---
> 
> diff --git a/pahole.c b/pahole.c
> index e308dd1..b9bf395 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1280,7 +1280,6 @@ struct btf_feature {
>  	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
>  };
>  
> -#define BTF_MAX_FEATURES	32
>  #define BTF_MAX_FEATURE_STR	1024
>  
>  bool set_btf_features_defaults;
> @@ -1338,10 +1337,10 @@ static void show_supported_btf_features(FILE *output)
>   */
>  static void parse_btf_features(const char *features, bool strict)
>  {
> -	char *feature_list[BTF_MAX_FEATURES] = {};
> -	char *saveptr = NULL, *s, *t;
> +	char *saveptr = NULL, *s, *requested;
>  	char f[BTF_MAX_FEATURE_STR];
> -	int i, n = 0;
> +	struct btf_feature *feature;
> +	int i;
>  
>  	init_btf_features();
>  
> @@ -1353,24 +1352,19 @@ static void parse_btf_features(const char *features, bool strict)
>  
>  	strncpy(f, features, sizeof(f));
>  	s = f;
> -	while ((t = strtok_r(s, ",", &saveptr)) != NULL && n < BTF_MAX_FEATURES) {
> +	while ((requested = strtok_r(s, ",", &saveptr)) != NULL) {
>  		s = NULL;
> -		feature_list[n++] = t;
> -	}
> -
> -	for (i = 0; i < n; i++) {
> -		struct btf_feature *feature = find_btf_feature(feature_list[i]);
> -
> +		feature = find_btf_feature(requested);
>  		if (!feature) {
>  			if (strict) {
>  				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
> -					feature_list[i], features);
> +					requested, features);
>  				show_supported_btf_features(stderr);
>  				exit(EXIT_FAILURE);
>  			}
>  			if (global_verbose)
>  				fprintf(stderr, "Ignoring unsupported feature '%s'\n",
> -					feature_list[i]);
> +					requested);
>  		} else {
>  			enable_btf_feature(feature);
>  		}
> 
> 

