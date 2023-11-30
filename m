Return-Path: <bpf+bounces-16320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0C17FFBCA
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479061C2116F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E23537F9;
	Thu, 30 Nov 2023 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvXwsA4l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LelzgKB+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731E3D6C
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 11:50:06 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUJmO3a026587;
	Thu, 30 Nov 2023 19:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1PLFnhhTttFhO3KL/DJVqQnPmcTWbOKwCcv7tLxagrQ=;
 b=dvXwsA4lZBX4EHEk6P8AQq1Q5UcarKJcg9cGWCYYAf9XmVVIGW5NvpSj/ETQ3Wq1tp9w
 tEWcJkJIjk4OUiXhbtgKnSDKY3l8BMGtUm4iaKYqicUpKKUUAmHPTiyj30qIgno7HtoW
 1qKdzvulzrJ3GXooI4obqJVjmhB1uCvNkAZoh0w6WmHnFlqUbLNfSnsRghITRuMcZHON
 oAQ9N4dXrjFLBv6I8hERX8PTLJvCpeAzaMfVryo28LHFBLdg4Cv0i/wlXSZnufFC2Ysp
 jsmttttLObUXxE6CP4miQ7+IXXQuJAKrshfkVRU8SDbU21byyJMsnJ5XsXz48Nifo4B9 BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq0v9g05f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 19:50:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUJYCaE001533;
	Thu, 30 Nov 2023 19:50:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7ch5722-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 19:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZKHUl5OKNUCztqOBbEaMrpmDZn0T73glVqOPIBBDVIaD48/xjBNn2MIhudTLa0CH+fcjJbo4pBF9cHqjzGVRd4hSkSzCGSAPNaQDt/hfZlc+s74ZU2t1jbKJVx40bwFOyBDqGO6G+XkE37+UnT1pJ047JNkRQhdERZI855Am4JugL98wg6tw1qt74nf65Sa+wGS5xKBa16PpskwlpImveBiCIzoe9i9W0dumsD2OWDMDKYii0AAaW2euAO2MXKs1697PiqjMdIpMcFj0AH02Mo4uxEWomTYqJpcYMmKW4eQJG4bqRdEAvfQk0GVEk705bDfnMGq0mq2i4fLJ3KxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PLFnhhTttFhO3KL/DJVqQnPmcTWbOKwCcv7tLxagrQ=;
 b=PU7kjPPXo51eJjvl8xBiPbQ4AO8a+nwx8pqbfevL46PcOwwc07a5jli3reROUwhoWXXeuIkGH4CnLUN7pOpWzThfdvHi1Vx2oNnLf7opt15u4LayJMC3YJzDUhj/zkMXOnoKHcRJ7p7CBfW37m1I6N21nMsfxajAZuAnPnUXdLUdWwhboDwtZMOcXfdjNpc44xiD5aUXopbmOpYzAaQ79LgW8QeXeeJs4Glmk9m/mEIAV4Z17yDRzqGKZ9JbIBWIbAQKVrT8CMcveQvyWs2Z65bnKnIig1CV/ebLlsQY8hMsKAqm2p8KHZDYxs0IEsiQvsLD00UWgWbpfn1JiHneiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PLFnhhTttFhO3KL/DJVqQnPmcTWbOKwCcv7tLxagrQ=;
 b=LelzgKB+UMeDXgEduk2QxzZouFlM3hh7cw5pQDAUhhb/qcuQ4i3XH1xnrZj+dvqorM+l/vo82qj0H/vKevZ4G97glYPpzy4+UIyJeuSsoSBRyvYyjmdp/bB2ShqAHXNM+scPSyVOB7zrAyqInejWLC+qVQQN9VMmZWf1lKFpIZM=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS0PR10MB7956.namprd10.prod.outlook.com (2603:10b6:8:1bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 19:50:00 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c%5]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 19:50:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: BPF GCC status - Nov 2023
In-Reply-To: <CAEf4BzaTr1-gzEDq4_y6pzFDhTJm1VyyV2jUOEWk1jovOkpD8Q@mail.gmail.com>
	(Andrii Nakryiko's message of "Thu, 30 Nov 2023 10:27:49 -0800")
References: <87leahx2xh.fsf@oracle.com>
	<CAEf4BzaTr1-gzEDq4_y6pzFDhTJm1VyyV2jUOEWk1jovOkpD8Q@mail.gmail.com>
Date: Thu, 30 Nov 2023 20:49:54 +0100
Message-ID: <875y1j81i5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO3P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::10) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS0PR10MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 368f9d65-8608-44cf-2c21-08dbf1dd89b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oLEbT/rV07mCbw866UDU+l/kBIN4uTHztmCsMAo9DANNWE28UpkPc+t+bScCjIJ1IkAsCkSC1v7t1LzmvLjjz9H/87jyIL3idR1dhjPt8LQ1fiol3okSwibvcLSODluXvwC9IVNoXNzt2CH05eWdOeOq4srsSKLC7cRBCHCFF8lmPSuOrGKH+vfpMtuzdPaDdiVhs7WMLPpMdTL1t3XhNXdvZYBFWSM0PcJY1BMoYoTk4GoA1+PfPR7sfVcmwanqxnH9W53ZKLvQyxg+vmoRqwzE0vVxwDpnUDYDO66WZ/tzvFljqZoLY2kfvJiVgwEFjr3uzBaUYXz/pl/ExBXDCC7ZdbfJU/Lj8mUZZ0jaHlCI280x9qNuk/Js4jM2aCjhifvcTwUJwJ5dJ/K+yaMjlRyO9PatNY2SxWb33OYHQKOGZfBcC8rMJm4cAjMoKB2R+LDz54cOyUANeqBm6heNWnQnqF+wN3VwRFjpHU4g7h1AjGQ60/n9V+rzFbfDZTrAU/hHjou3oG6liiQHRvrIwhjCaLEGMXfYshuIdjvPIZZEeyq9/eC+rYGVx9gQMLs0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(2906002)(26005)(86362001)(2616005)(5660300002)(83380400001)(6506007)(53546011)(6512007)(38100700002)(6666004)(8676002)(66476007)(8936002)(41300700001)(36756003)(4326008)(6916009)(66946007)(6486002)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlVUREtKS1V3NVpOTU5nVXlGam9BWjdRWnZPaU1aVkZ2T0h2NWdzMGFBbVZs?=
 =?utf-8?B?Ymp3b09kaEFTQU1UaVBOb0NHQnVhL1V6ZUlDZGNhYU55QWFCcXhyVDNLcXJy?=
 =?utf-8?B?ZzZaS0hIZEUwWldQckt2dnlNWndFdXJoMHhQcW9OeGRBYkl2Nkdab2thRUhD?=
 =?utf-8?B?aDRXTXJmMGMrU09ZODl1QWFDY2ZEUWRvZnlPOFJDWGNPOURYbGJCMmUxamUy?=
 =?utf-8?B?WElQczFkeWRLYUtwT0NHZlp1Ti8zbG1HOUUxT08yc0lKc2xIMnpsbTdoUVpU?=
 =?utf-8?B?Tm5hT3dKK0NsQThNdkxUN2EwczNYNkVsaTIwd3NCVDh6WkhXQi9oRjIvajdj?=
 =?utf-8?B?OWJoK3FFc25LMTlPd2llT2FJcEZhZ2diK3lGcEFhTXE5RW1QOWM3ajZRQ08x?=
 =?utf-8?B?SjREZEJ4WWc5NE9vcGpudXgwRk0xaFdveU92ZTBsbklCR08vaFlhRWx2TDAr?=
 =?utf-8?B?aWN4bm0wc1VnOTE1RVpwdUNzS0dJcFZhb3lZdUpmbE8vRUFiNkRORjE4dVdG?=
 =?utf-8?B?U1dkdHZLaGRETk1vOVBKWlBPcGxocCtobUM5c1F2QlJsR242UDVZbEZvT3Jx?=
 =?utf-8?B?cW9LbVFheURXRzRMR3poeVhNTUhvN2lKdkpKY0RrVllZVW5LdVJYSHRuYk12?=
 =?utf-8?B?a24rbEtQS1JIbXJKd1NubnduV1g5WC9PWDJRaW4vSFVoS3h1cHd1ekVQTGQ5?=
 =?utf-8?B?K1hWS1VvM0phdmJMdWFLU0lBWE5qV1FxSDE3dFU1WmFkZnRnQUtNT3RzQ1lX?=
 =?utf-8?B?NFNGYVNUZHV2VU5vK0tLTUVtUTY4Vi9JeGVhWnVCSkZVRWFTQjVXazdiSG9w?=
 =?utf-8?B?eFRqTGhnSXVNZU81TUNtaUxoZEgvM0RZU1BWRmJwT0JpV1NMTkZ5Yk9lM01v?=
 =?utf-8?B?eFNTNUpyQTgydFhubC91WmtiaHV4UFB6aFJOMStKcE8wYlhNYTNtZEJ4Q29I?=
 =?utf-8?B?SkZZK3lRNDF2bnE4cWFMSlV5ZytSQkVVYy9SNnFkVnI0T0FzQnE4dlJkVFh6?=
 =?utf-8?B?T24xa3pYYld4cjg5MWpIZm0yRThybFkvL2hjOUVHWWhQcEVMWlFnNWVtMEMy?=
 =?utf-8?B?WlFiTCtGY3I2L25NRW8zUkpkd3pwQmtPU0J1LzkwTTRkNTF4U004RFVTQ2VT?=
 =?utf-8?B?SkI1TGYzVitSNW9yOXFQTnZ3eis2VzRnSGlkeGFscTF2dFB3L0hyT00zN1Yr?=
 =?utf-8?B?aTN1NXRkbEVlWERpZWxLQUtteEFOVzFKNW5uNlJtTmlKaEw0VUFiY2xlTGZa?=
 =?utf-8?B?RzFMZVAyVXMzVHVJSW5iUnlIaUtYblZoMlRjVE1FN0pid0tuR3JTbjJCczhr?=
 =?utf-8?B?aHBNUEowWUErNDlaSm40YTdwWEZObWVKSXpuRmpmNnU1RG1lK004ZmJQNnpj?=
 =?utf-8?B?UTNJNU5WY1RXaEVrWmMrZWRhYjZYeEJabmZZbUpFZEc0aVU1SFF3YmIxZzNK?=
 =?utf-8?B?ZURhcjBxS2tnVUxKZlE2bzduUSszRVNucXQ4NERPN0tEOTdUZElKTnVHcEo3?=
 =?utf-8?B?UStZa09tbTFwUjFpTHZaMjlZY3M2MFpMKzhyZXhxaVBwUjBzUVFCN1FGL3Fq?=
 =?utf-8?B?UDhzb2JhcXdIYmFZQ0owOGpBcGg1Q01HUzFISTl5K084UCtRYks1N3I5b1ND?=
 =?utf-8?B?OVRCWVBIT1VRcUJ6Z2tpMUh1Zm11dnkrQWVFOS9iV1Y0Ylowa3ZBbE9DbGl5?=
 =?utf-8?B?NDhyejFtZXQ0YWlyQXlQZXUrdGx0d2hhcVlaeGVXc0k2b2R2UzRWenNSdHdU?=
 =?utf-8?B?WElNVWNjZEg2RDRZZVNWdlRTMmpmd0hXZVMxa1VMQmFDZjk0VHRBTFluZHgz?=
 =?utf-8?B?bE9wVU5yWi80bWk2NEEzSjlieWtTNUJyQXJEd3BkOGE0ZzdMbmVmbURxMEp0?=
 =?utf-8?B?cS9oK1JsTFBXWVdDSnhDQVlyOE9XSHVsQ3c5NkZCYjZ2VU9NZW1NUDJxdGc1?=
 =?utf-8?B?VC80UDNpUDIxTjZmQUcwdWZtQzNEcXpQa2FXOEtodDJWMEZOUXBEY0g5U0NQ?=
 =?utf-8?B?enFoS3piY1N0aHFkVFdQSytNMVh4RUVaUmhsT3hJL2JQQmZiVndJR1JEZE55?=
 =?utf-8?B?R1NURVEyV1Q5eG5CYkZaS3ViMUV6WngzRmZGRUsyWXE1b2NkUDJhN0I0MEhk?=
 =?utf-8?B?c0M1R3U5OURxVEo1UVdLTXFiWlZJZWVWMlZpYUFxRy9YZGFuSWtZRURrZ0V6?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oPqVHIMFWaCoIwsgTSM+89Rbzbgsf+uyT6G81qItfOyRutfHEES3KexR7Qi7s8SKqCAcKH1pGIT5dHZsVtRQlu+1RWAsMCmu+363R/9kUOOAJjVUueAZbwIwlQdEfcSkheXNOCAtU0/dcJ2F3KZJYMcYuiHraYVHB7azG7OXB9xC8e0/WCUk891VIT9OxkkDKZiFDcIUHAuiTREz7P+6e1e9opXCCTgjb3fqbc9DVWaq2icGIlaqd6UHfF9q5DmTBXRHtI9tatdEFL3DCvP9TK26AgbsqVSRkFASQnIUfQFq7de7OrIeerpOLbaN8sWYEUb4OZFsG6DrXvBwtYy3olb2Yzg4H9u9Xx/ESlO9b0mzqEkRaICRF1lOIeJmNSOTyvMZmVtjvKJdW92smAoENfVQ+jsTZMD2zEowMPzM2Yks4CzNGs3i3fZMCFTzlZMVc+xZWi7Kjm8xU3vXVLltk78snG7gUqLFnyF3DfH7S9uTJs3bT1aMUp9c8QD0w3D523N+YcyeRgrad98MtWLZTfavIzWITukl1S3RFuMvXsgrMC7ILxeF/8SR/2e1hKuEkAAmaZ6naozBAE9xBLFh7BPTpezWZa3YY8dd/Y11fAH8dxXO7/NmwRgdOOHyrBlTmTilMIMEy1z3ngV4qWTrtN7OiKsmpsjQAh/v3HmIllSD1DUgKRmigie8t9yoyKFMK7d7LSn/T3f9p2vUN9hkVsHbxsHjftcQZmEoPusDQqSiiUJcY8IQ8ej5+JwIY8BM1GswY3CLui584XfIupI/xOygGwUwLWU4pzjV3No/3pw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368f9d65-8608-44cf-2c21-08dbf1dd89b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 19:50:00.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5HPDORxO3RT7Xw8qRfk99ASB0FEan0PCtrrrDvMGkcPHdEzZcy0lI/s14aM5OfLhGV39ThQqJelDeV6ZSZFcf4BFnrRCtAGUnbzZlWc1A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_19,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300146
X-Proofpoint-GUID: GA63zslNXRkKlvevtIwB_il2eNpymJDh
X-Proofpoint-ORIG-GUID: GA63zslNXRkKlvevtIwB_il2eNpymJDh


> On Tue, Nov 28, 2023 at 8:23=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> [During LPC 2023 we talked about improving communication between the GCC
>>  BPF toolchain port and the kernel side.  This is the first periodical
>>  report that we plan to publish in the GCC wiki and send to interested
>>  parties.  Hopefully this will help.]
>>
>
> [...]
>
>> Open Questions
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> - BPF programs including libc headers.
>>
>>   BPF programs run on their own without an operating system or a C
>>   library.  Implementing C implies providing certain definitions and
>>   headers, such as stdint.h and stdarg.h.  For such targets, known as
>>   "bare metal targets", the compiler has to provide these definitions
>>   and headers in order to implement the language.
>>
>>   GCC provides the following C headers for BPF targets:
>>
>>     float.h
>>     gcov.h
>>     iso646.h
>>     limits.h
>>     stdalign.h
>>     stdarg.h
>>     stdatomic.h
>>     stdbool.h
>>     stdckdint.h
>>     stddef.h
>>     stdfix.h
>>     stdint.h
>>     stdnoreturn.h
>>     syslimits.h
>>     tgmath.h
>>     unwind.h
>>     varargs.h
>>
>>   However, we have found that there is at least one BPF kernel self test
>>   that include glibc headers that, indirectly, include glibc's own
>>   definitions of stdint.h and friends.  This leads to compile-time
>>   errors due to conflicting types.  We think that including headers from
>>   a glibc built for some host target is very questionable.  For example,
>>   in BPF a C `char' is defined to be signed.  But if a BPF program
>>   includes glibc headers in an android system, that code will assume an
>>   unsigned char instead.
>>
>
> Do you have a list of those tests?

For example:

  progs/test_cls_redirect.c
  progs/test_cls_redirect_dynptr.c
  progs/test_cls_redirect_subprogs.c

they include linux/icmp.h that, in turn:

 linux/icmp.h <- linux/if.h <- sys/socket.h <- bits/socket.h <- sys/types.h

If BPF programs are expected to be able to liberally include kernel
headers that, in turn, may include glibc headers, then it is gonna be
very difficult to consistently avoid these conflicts..

