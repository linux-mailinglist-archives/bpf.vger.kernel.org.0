Return-Path: <bpf+bounces-2908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA5736711
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B215E281014
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D33C2CA;
	Tue, 20 Jun 2023 09:10:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFCC144
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 09:10:03 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D3118
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 02:10:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K08Mep001347;
	Tue, 20 Jun 2023 09:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XBgtdxOGIqPGb8JTklzMWvc0nDLAT7OZgvZXsjkyg9I=;
 b=qNmpFEFW6N6c5aVZ5KzIehCQeF/MyJu2sl7TeirBp3WK78XVzAoqOvu/KH0riDnF/19Y
 07zaVw5TlMlYECacQUpy6goVV2X92k5Tle0YsNoQmhmLQKgIm4ywEbX6k40GZiqdlmvQ
 6aCPfy+idQac55Jl3SmnBERe+uHQwDiAktjDswFNMpCxgOeCD9ukTGJCgjtvyDr8R2hg
 z436R1P/4lNguFDhAYb0HVktVFk0u7E/ABzaGWDmFooLB7FXY+2ePo7pz6VKSj32OnVd
 L2XmT2p+w0sauieQZg/pY23v/PA1wjCUaXR/uNuPbYZVrQ7t5SOKPm47hIDWJV/rxgoA kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1c8b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 09:09:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8AbMR007200;
	Tue, 20 Jun 2023 09:09:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w14p1aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 09:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR0fXG+1J0QHiV1gk8NRMbBw1/vPtkXzs/n1i7lsIoCe069cr78Bo5CR8+Udbj0DSpxDQpZtZs+ultgiob9uvAx+k5Y8dq4ihLN+im3W0r6PRyrhL6RcIMYAvYQNSBH6+JU0+Cx4aSpdgx7dkIeEqaRy804IA8U6ZcJDbctEwRPEXm56XhyS0QG/2xsAb09mdoHtYu3LwN6ERJLPIei0ViJi6UnuxBJR0LM04tuKeOleAFPyZOEaln+Qf5g7B9K1qhW+Lm/p+1vopYZ2Gq53X1u2A92kFabtgXxZqJf3QiWpkKD+zoDJ+nkrSiLBhtuyDastvcRAFLMc0f1QfmR78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBgtdxOGIqPGb8JTklzMWvc0nDLAT7OZgvZXsjkyg9I=;
 b=Sndb8WyclUzGNOI5pf/UPMk5RPKsToY0tpEsjsO/ys/qhSsxKdWAIeJ/CPYYV4rRRTlu587dHZRsKV1WhHsdcIYP/3EntJXcpUHLumPMW5VyZgNTduVy2vWDQDcTVAFs2ZiS297J59pqBPSSZ8PQtJT3GgwB4oRBYVH538YfgIiBnkN11150kiyqg7CeRRbI73idqcyfdOD148VI69giWsJr1eb/DnbBLKUWcH+y9c/+IiVtMdYiyuDw2WEqt1+ZRMp0KQsxXtsbA2BG5DrUV/gwrOCJKNnZJ5tm09TzFnaS0YPYEEt2BFAeBboSXWuSscK37CGyScrqmCG0HAP9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBgtdxOGIqPGb8JTklzMWvc0nDLAT7OZgvZXsjkyg9I=;
 b=XGUS/f3SCIrc1noAzekm8Lncp/lJ0CKV7bp3dNXGlp5PBT+hJlWX84qlOZ24Q98OKWtEz8pSon7hHvY29GrUACEACo9N9Xn638sned/c3tWWCRmzO2e91eRf8u9H+IZmacwOxyHQ97krqJaqWvxxMZHOcVlaZ02M0fYgxPQ0dKg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB5842.namprd10.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 09:09:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9%7]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 09:09:25 +0000
Message-ID: <92505f63-85dd-3fb3-9db7-9233d8f6e27b@oracle.com>
Date: Tue, 20 Jun 2023 10:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 5/9] libbpf: add kind layout encoding, crc
 support
Content-Language: en-GB
To: Yonghong Song <yhs@meta.com>, acme@kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, quentin@isovalent.com,
        jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-6-alan.maguire@oracle.com>
 <552caa49-5a88-7842-068c-36d105e8929d@meta.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <552caa49-5a88-7842-068c-36d105e8929d@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b123c68-3a36-4da2-670e-08db716e0aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+bcIurqXfN87TvDiCX0MjbxMplqO75J2cb/Gosy+PnkWOrbCv4uiNi2k84jmcQ/+Bd1CWd5G3KxXnI2h7VUpQF4MWMzwdTVyWoudnNpvWjH4Cteu4LPkG8fqiWi1GpDih5Uricx/m5GTK7rIP5hoLiIqYT6ImlYD5AJmidSbuF9lnKo0A9Uajt7W1rUUJXbSa4SCgToLnrQgIki95OXNr7W9q72nAP+bCGXUmTHSvzXwFYRK9884ZVC5t11jOGkHV5ZSM4I8r7V+I+VYnhQsnuL3+7kjx8YhsnJ8bhAP09/ngVE9Jecg66b9378GrNNdpmOyRyCznp0RI7msVDiN/Q728VtgZk/r8kuHO2+13mWptQ0KL7WL8l+6Tmla4jmTyp3gjcWlMdU64qwzkETbc23NW07EXKKW3RBsGtx+6J6chvHNhb7eiLdNAZTTwaxdiOgvOSi1O4HY+qnVqag26Bohz/7NBv1c+7CHaqFJMRhmbIriz7dHPsq1t4FKfRpGtaz/wK9kC0e38MtVYR4x5fNFAbbgvCo/KSwxNi8eyNJ+QTnkDDr+nbAAmg6xLkmJOPvUSkuG+ZTP0xvhJ3LkiKqWsiFEhQHEtrd6GlpQjcM+zzZCobmReozY3Vg2TAUxk4ALCRdPuy/DTUKqr4DGfw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(186003)(8676002)(66946007)(8936002)(66556008)(66476007)(5660300002)(4326008)(6666004)(6486002)(316002)(38100700002)(478600001)(41300700001)(36756003)(6512007)(6506007)(53546011)(7416002)(86362001)(31696002)(83380400001)(31686004)(2906002)(44832011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnFvR01lT1djWnN3ZW1nQ2pnRFkyMCtVQlBHYUFJeUF5cG5KcWFqL0lhRGsv?=
 =?utf-8?B?dG1XTkpEN0wvTUpGcDRsMjV3bko1dEdxMGN5aWVqZVZESW83dkJqRmRUcnZ6?=
 =?utf-8?B?YXJaTm90ZGRFYzNNMFY3MUc4OUNnSEgxN2pPYlhmRFZHNVdvbDJ6eHlaZUlh?=
 =?utf-8?B?bDBNZFpqc2VqaFJleDZPRVplbUpPUHVXRllGcGRCZitLT0p5WERJVlVCUFQ1?=
 =?utf-8?B?UXFKQkIrYk9VekpRMGhXSXUxNTJDcFJ0eVp3SllFTkpCNjdTQU1LL0ZXbHFX?=
 =?utf-8?B?ZC9BNkZqZFhWSlVCRzlGbG9Jb0RkZWlpQXYzVFdGblJTRzlEaFdJMlpUbS9L?=
 =?utf-8?B?RWh0eXEwQ2p5MmZqa1RqVnlLRHVYTGdLckVoUGx4MTNMSkE1V1dERU9GelVx?=
 =?utf-8?B?MGkvbG1DS1ZUVTJiWkFMTE0yVm0wN1J5RFVlWnpPeGk4NUltSmc0b1Btc3hH?=
 =?utf-8?B?aE9DRHdKQ0N0QTlxWldIS21lUW52QUp4ZnhpK2I2ejdrQ1ErZ3drK29WanU3?=
 =?utf-8?B?L2ZRYUZyangwRzJvUGc4S2M4MnlGendiSEVkNldtdlFBVDczbWJtakk0TXZB?=
 =?utf-8?B?a2dPU2N1L1BEelZHY2FNazlGUlFnZ1lIeVE5MGtOZ2dQcmhkcFpKNit0bmRq?=
 =?utf-8?B?eXhiL0pWQURkd0Z1RDBXWStKQmtKcTNoNk9Qd0E4ckhCN1oxMWE3dFRBMEJT?=
 =?utf-8?B?di9HRXVJcTA3OVN4bC8vZ1B1SmM5cTBJeFlBM3Uxb3hoc09wcEYrb3NmWTY1?=
 =?utf-8?B?eUNzaUFVdURNNmZpR2cyck1BNlZtTHJpcjkwOU54cUNLeUk0amUvWG9QTU5w?=
 =?utf-8?B?aWFEbVRkNkd5Rjg5VFhVanM2ZUI3ekZacG9yQThnYlE3cnRMSlIwd0tLNSth?=
 =?utf-8?B?THdWWFpsOUxNTHp4R0FDUXRqNTRUN0oxOTE4by9DR2FXaWY0cXNrWmN0Qmhs?=
 =?utf-8?B?UFVwdGZFRXRYbm5HTGtHZnJGZ3IyMk8zUHgzZHdNeEF2LzdKVlhSYThCNmlV?=
 =?utf-8?B?NVZoQzFQbmI2czNLaC9ENGFKV0xobktCSXVzVkFYZXpXZkk2dTNyTFJOTlFI?=
 =?utf-8?B?bjRwU1RTTlhTcDFPQnRrS2w1QmhvcnViZUpJNWFGb2Y2b2ViczVXMEFjSU5I?=
 =?utf-8?B?bmNxZUxrTTA3UHl1VWdFLzhsZ2ZQNFJIVWdzMUNwYitwcDR4Y0ViZHdUcDlt?=
 =?utf-8?B?VWRuUG5mTDd2cjJMejloSm5GQ05KOE44RmVIampLRVU1SWxVTnhabXZRNjI4?=
 =?utf-8?B?VjBpakZSQjNqb1IwVnpmU0hCdHVhenVXaFhhQ1ltS1Z3eEt0T3d6RC9tZzlX?=
 =?utf-8?B?OElPNk1LMlZuc1UrZ0NtdDl5RDFJZktPMkJpMUd5UUZOb1NIbHBsSUMvSHVV?=
 =?utf-8?B?NGlTVnl4L0F0bW9oaE1kWS95VTJGV3JYaTdaK2ZNRmMybHIzbXdFTkhjYlN3?=
 =?utf-8?B?SkpnOEE0RVIrVDA1YTdhaVhnS3VIaGQwamV2ZEhnR0lMckFDR3JwTTJxSnBT?=
 =?utf-8?B?ZkU3OUZyeDZyalhoZXUzR0l0Z3p1VUZDeDhCYkRLMGJrUGZqV1Nibk1xckE2?=
 =?utf-8?B?UGZTWWNZNElrNTBKcFVWNGN3V2dFTFdyQmNUK0ZMbExVdlplWWVwdDVoclNs?=
 =?utf-8?B?MDFDRmlIVGZBcW9UbG9xZEx3enlPTUFRcXl5Tm1RbFlMSnVxR09iWWxDVWM5?=
 =?utf-8?B?cnRRVXJuVitQUTF4N25hSUVLNjFoWExsbVFUdGNjdFVzZHV5MkRxMkV0RHVX?=
 =?utf-8?B?TEZHVDUyRC9rWHoraHNQcHBRa3pjRmo0eFZRb2ZBMjNJSXc0Z3p2L3lHcFdF?=
 =?utf-8?B?Q0VvdGtHU1hyZjVQWVFIb0hsZnBCRFA1NEpwQmZTR3hSbmI4UFBpOEJGWVND?=
 =?utf-8?B?blU5ZDNOVnR3VTFxNEw5djgvVDJpRzZmcjZ5bXZKYnoySFYxVm80T0RlT00z?=
 =?utf-8?B?VGhxcjJSWm1PekVTWGRZMWE5ek1OL2U5NjlrNjBJMVBxbVpNeEYvdlBFOWRs?=
 =?utf-8?B?RXpCRFJJNk1NbGNoTGpzTzVUSXNLb2hsM2hBTmVDMjc4MG5PN1FhdE5jZnBP?=
 =?utf-8?B?aEtUMHhBMElLcWd1bmtJUEtvQm8wUVllL01VaUlaZTVHRmlkbWptVmlvbGtj?=
 =?utf-8?B?ZG13WVRPNlFkeEFWQjR1eEwrbHU4Qk9GS1NDbjJxN1IrZ2J1UXc3bUpwQ3Fp?=
 =?utf-8?Q?wDov+AE6gwxZmPMLl6SNADI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?WlByNlh0c0lna2tRdDJxQkVBYnhlcWpLempWWmVjQU12ZXdwYnRURFNIdGFS?=
 =?utf-8?B?YnZibkNWcXY3dE41dFBpS1o2YlJjYytFcUwxM2pLMGdPejBDeVpzcHlPZVlG?=
 =?utf-8?B?WUdZSXlGOFRhU1o4U1grMUFZS0ZEMXFLWXI2cFhBTG1LWjE0Umw5MHFjdEpL?=
 =?utf-8?B?M2NxWklTZE5EWXVFSEoyRGNkT0lydzFNVndYSXVaYndFT2hDbXcxeHF0Vy9l?=
 =?utf-8?B?d1BGMVhUL1JWMjlHWW5pSVJLMWRaWUR3elVXYklkWHVwNS9aSkoxZnRJeUw0?=
 =?utf-8?B?RGI5ZXZ1eFQwajR0aEZkVFB3QXdxL3I5MExRSGVFb29PV1dtQmx6b1BOL2Zn?=
 =?utf-8?B?SVpkTkN2cUNVemFVaEdwZkJmbDkxZ2M3YVE2cHdSd1I5UzI2Ui9NV2hienFw?=
 =?utf-8?B?T0RHYjcyNmNURnhUMjlKM3RCWDVWaGIvdHoyL05iU21YRUovajBkR3A1L0VV?=
 =?utf-8?B?Y0VvbjNuQTdYTCt1TVFaOVJUMk00eGNzbWhaMElZU1B3SXpFWW1xanJERlEx?=
 =?utf-8?B?M0tPbzFBTXdSbkFnVWhnRGlobXZsTVA5eERPUXliK1Z6eG1YQTl5bDVTMk5y?=
 =?utf-8?B?cGpRV1FJVUdlY1kwUFoySmZURW0wQ1VQVk94RzRBd2lFS2VqY2lralBucHlR?=
 =?utf-8?B?b25Ea0xRMjFGejB5eXkwcEM3djZTQ1RpeFdqZ284WkZqZ0l6cE9LL0x6cEUz?=
 =?utf-8?B?S041QzNlbFN5RHhCT3loMmpicHRMV1dGTDdVSENBbjB4dWhNa2RqY0ZJRW5h?=
 =?utf-8?B?TVNmMURJdTBiSmN1STFHdTYvd3R6cndLQUpjSkJLb0RmODBPbk5aNWJoT1hR?=
 =?utf-8?B?ZjdBTFJkVFYyMy91V1FoQ3JFVDhISitjVG9HTGV0bFdtMWxXNUhwTnNONkVw?=
 =?utf-8?B?aFQrV1BlOWVpUEs5cW1CL0I5VnZnK1lHb1BaM0p5SVg2K0tVWVZhbm9iWEVv?=
 =?utf-8?B?M3JIS3RTQzJXRlRnZnJ4QjRrejVnY1ZCdmU2ejh0bGIyK0c0enNhdUV2NnF4?=
 =?utf-8?B?V0tDS3AxNXpJd3F3VnNKQ3lxdVlhdWNxQXpiQWllWnpsTDlyYXhpRFB5VFpP?=
 =?utf-8?B?c1JHb2V0eGZMWXlVd21zRFh0ZTFOOCtMemlDVVEzZDNJT1JKU0tpUWZCNHNC?=
 =?utf-8?B?bGVXUitDbHhLNVRNckw4U3lsMkZlTS9Ra1JPcmxWTVp0NGxjSnIzcXlBMnFV?=
 =?utf-8?B?RnY4bGI5YmZta3FvVE56bk1nRlZaRW5oTERZYjJ5WFdiT0UyWDBNcy9KRnZt?=
 =?utf-8?B?UHAwV2tKUlBXa3JoS1VzYXhreXEvMDE0OHVkVVlKNU1uVlpOTUxyV21NeGR4?=
 =?utf-8?Q?ERVRWjzyp/OsA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b123c68-3a36-4da2-670e-08db716e0aef
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:09:25.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 589alPAWQWQg9rqFOMsptILhR8bnlyQGulGh2DjPYJfikMDnHgdGsgEoqWUf8XsQsVTp1Hg5OrHTm0S6JlDR3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200081
X-Proofpoint-GUID: AAcUerSkfGqNq6I7jE7wLqBzb5EbKrVm
X-Proofpoint-ORIG-GUID: AAcUerSkfGqNq6I7jE7wLqBzb5EbKrVm
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/06/2023 00:24, Yonghong Song wrote:
> 
> 
> On 6/16/23 10:17 AM, Alan Maguire wrote:
>> Support encoding of BTF kind layout data and crcs via
>> btf__new_empty_opts().
>>
>> Current supported opts are base_btf, add_kind_layout and
>> add_crc.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   tools/lib/bpf/btf.c      | 99 ++++++++++++++++++++++++++++++++++++++--
>>   tools/lib/bpf/btf.h      | 11 +++++
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 108 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 457997c2a43c..060a93809f64 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/err.h>
>>   #include <linux/btf.h>
>>   #include <gelf.h>
>> +#include <zlib.h>
>>   #include "btf.h"
>>   #include "bpf.h"
>>   #include "libbpf.h"
>> @@ -882,8 +883,58 @@ void btf__free(struct btf *btf)
>>       free(btf);
>>   }
>>   -static struct btf *btf_new_empty(struct btf *base_btf)
>> +static void btf_add_kind_layout(struct btf *btf, __u8 kind,
>> +                __u16 flags, __u8 info_sz, __u8 elem_sz)
>>   {
>> +    struct btf_kind_layout *k = &btf->kind_layout[kind];
>> +
>> +    k->flags = flags;
>> +    k->info_sz = info_sz;
>> +    k->elem_sz = elem_sz;
>> +    btf->hdr->kind_layout_len += sizeof(*k);
>> +}
>> +
>> +static int btf_ensure_modifiable(struct btf *btf);
>> +
>> +static int btf_add_kind_layouts(struct btf *btf, struct btf_new_opts
>> *opts)
>> +{
>> +    if (btf_ensure_modifiable(btf))
>> +        return libbpf_err(-ENOMEM);
>> +
>> +    btf->kind_layout = calloc(NR_BTF_KINDS, sizeof(struct
>> btf_kind_layout));
>> +
>> +    if (!btf->kind_layout)
>> +        return -ENOMEM;
>> +
>> +    /* all supported kinds should describe their layout here. */
>> +    btf_add_kind_layout(btf, BTF_KIND_UNKN, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_INT, 0, sizeof(__u32), 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_PTR, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_ARRAY, 0, sizeof(struct
>> btf_array), 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_STRUCT, 0, 0, sizeof(struct
>> btf_member));
>> +    btf_add_kind_layout(btf, BTF_KIND_UNION, 0, 0, sizeof(struct
>> btf_member));
>> +    btf_add_kind_layout(btf, BTF_KIND_ENUM, 0, 0, sizeof(struct
>> btf_enum));
>> +    btf_add_kind_layout(btf, BTF_KIND_FWD, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_TYPEDEF, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_VOLATILE, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_CONST, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_RESTRICT, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_FUNC, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_FUNC_PROTO, 0, 0, sizeof(struct
>> btf_param));
>> +    btf_add_kind_layout(btf, BTF_KIND_VAR, 0, sizeof(struct btf_var),
>> 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_DATASEC, 0, 0, sizeof(struct
>> btf_var_secinfo));
>> +    btf_add_kind_layout(btf, BTF_KIND_FLOAT, 0, 0, 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_DECL_TAG,
>> BTF_KIND_LAYOUT_OPTIONAL,
>> +                            sizeof(struct btf_decl_tag), 0);
>> +    btf_add_kind_layout(btf, BTF_KIND_TYPE_TAG,
>> BTF_KIND_LAYOUT_OPTIONAL, 0, 0);
> 
> BTF_KIND_TYPE_TAG cannot be optional. For example,
>   ptr -> type_tag -> const -> int
> 
> if type_tag becomes optional, the whole type chain cannot be parsed
> properly.
>

Ah, I missed that, thanks! You're absolutely right.

There are two separate concerns I think:

1. if an unknown kind (unknown to libbpf/kernel but present in the kind
   layout) is ever pointed at by another kind, regardless of optional
   status, the BTF must be rejected on the grounds that we don't really
   have a way to understand what the BTF means. That catches the case
   above.
2. however if an unknown kind exists in BTF and _is_ optional _and_
   is not pointed at by any known kinds, that is fine.

In other words it's logically possible for us to want to either
accept or reject BTF when we encounter unknown kinds that fall outside
of the existing type graph relations; the optional flag tells us which
to do.

I think for meta checking, the right way to handle 1 is to
reject BTF in the kind-specific meta checking for any known
kinds that can refer to other kinds; if the kind referred to
is > KIND_MAX, we reject the BTF.

> Also, in Patch 3, we have
> 
> +static int btf_type_size(const struct btf *btf, const struct btf_type *t)
>  {
>      const int base_size = sizeof(struct btf_type);
>      __u16 vlen = btf_vlen(t);
> @@ -363,8 +391,7 @@ static int btf_type_size(const struct btf_type *t)
>      case BTF_KIND_DECL_TAG:
>          return base_size + sizeof(struct btf_decl_tag);
>      default:
> -        pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> -        return -EINVAL;
> +        return btf_type_size_unknown(btf, t);
>      }
>  }
> 
> Clearly even if we mark decl_tag as optional, it still handled properly
> in the above. So decl_tag does not need BTF_KIND_LAYOUT_OPTIONAL, right?
> 
But in btf_type_size_unknown() we have:

       if (!(k->flags & BTF_KIND_LAYOUT_OPTIONAL)) {
                /* a required kind, and we do not know about it.. */
                pr_debug("unknown but required kind: %u\n", kind);
                return -EINVAL;
        }

The problem however I think is that we need to spot reference
types that refer to unknown kinds regardless of optional status
as described above.

> I guess what we really want to test is in the selftest:
>   - Add a couple of new kinds for testing purpose, e.g.,
>       BTF_KIND_OPTIONAL, BTF_KIND_NOT_OPTIONAL,
>     generate two btf's which uses BTF_KIND_OPTIONAL
>     and BTF_KIND_NOT_OPTIONAL respectively.
>   - test these two btf's with this patch set to see whether it
>     works as expected or not.
> 
> Does this make sense?
>

There's a test that does this currently for libbpf only (since we
need a struct btf to load into the kernel), but nothing to cover the
case where a reference type points at a kind we don't know about.
I'll update the tests to use reference types too.

Thanks!

Alan

>> +    btf_add_kind_layout(btf, BTF_KIND_ENUM64, 0, 0, sizeof(struct
>> btf_enum64));
>> +
>> +    return 0;
>> +}
>> +
> [...]

