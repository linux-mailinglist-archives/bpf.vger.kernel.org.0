Return-Path: <bpf+bounces-18549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A381BD7C
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CB31F26A83
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5C6280D;
	Thu, 21 Dec 2023 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VHWYghN0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w94XaKTp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100EBA2F
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLFQIfi023588;
	Thu, 21 Dec 2023 17:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uSgd9V6mAsmaiOID95NnFt1TKtqAxoZmQFXNiXy8Yho=;
 b=VHWYghN0JdtTuT3V6FEFC2zdgomTLFtBIxGnNm7LhpQ3ClxPDXH78epc9fSVeNnd83Ij
 6mCvM80+KDfbCb3sSRe5+9nNfWa2+yC2TYNV2KtVoWsp/Thyr2jiewZev/z2l7pHrv5+
 ulHGacuJZIcihK2pJAX8RBizH+Y743U2/PvuE7/RwEbiWP05KgGVHfBLS0U7cCxscreI
 k0A21skbUv6kXbt6onbxmjmezKeeQcpYkiS1IOEH92gTW7rvjc3gyUlKHSv/1WS7PtZ1
 wu2Iqc/XxyeFfB9OzDBc279Q0b5xfx1b/5CeuAq/wkzXYHIlJ6neyfVheiG/JeEiTWdo rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xdkqgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 17:43:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLGtuMw035519;
	Thu, 21 Dec 2023 17:43:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bbpmt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 17:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr7UL0W/mGTA41DiEjsmwA4aET6qr7bPhBGEOiLTEMSc3/QsM6Qu3MLO+3m1mNqEvXhAkZ4P4Si1GOcChEUuCP1voZh7qoKczc9oWcN3Ua6ptWD2fYN3XmhqTPUeUqSKIjpizxBv0GLdraIBVB5sZSjKEqJXpJdrQUMAQtXrIrr9ogG+QULkXhhSrn7+Y9ANz1wDpIIDeIQuRIV3nFunM4yHp1M3+m8b7eP2CKB3Q1f/SBle8y1O8YBnyhX5fRX4s7uXle0yh8Fl7tqQ7hn0pCVdb8hN6I3eP9QrRBFnx9tdyfTLrYTvW21wvjaOXUJaJ47dnWV9/JwdBAg8GgkT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSgd9V6mAsmaiOID95NnFt1TKtqAxoZmQFXNiXy8Yho=;
 b=dD5X2PGhs3RLi0MzL+fPz4XWCGenzhZcaJHN0BaBrA5wTdqHnERT+1pHN0+kdf7dkiOlx+1sadoJnwLEDvrj4/ft0J/ADk8wwv2danWJPnmmwKvZbKN6tXFH4gUAN5i82CWgw3W4iJWxZqD9E/rU+v2cFC6QEb4F3p3tQn62K9UlhjB7w8cSlgozNjpOZKNcO8GpYa+o2MAS9vap5A/eQTUCQTLitmgkrSVN0r+FZ2kZGEKAwUa268KPJA29VOFihECQLheXHXrC/+QSorXhvBcjJK5tcq0uY+Kh76KngWWdzMPT6ETMJNjdG4qWzNKUEql319Y3pDeB3I26pv9DNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSgd9V6mAsmaiOID95NnFt1TKtqAxoZmQFXNiXy8Yho=;
 b=w94XaKTpy8Rx9E3ZSe8EYR7kfUS99cAdjwZJqDiGizr05l54aKojP4e6+AJ5qN56kjv/W224T32Eceidu4Bu5C1ejQPhG1H7b4mq8UhfRKtpr0i+lt0rTFIZYUZJZp7Ow2Pv+w8vL3VFr+b9jSmxFmsrjz2mmFRBiJcvh2N38k0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 17:43:15 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 17:43:15 +0000
Message-ID: <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
Date: Thu, 21 Dec 2023 17:42:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: a8497b61-79ea-431e-d1bb-08dc024c4f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jSzqUtGr0HJWQLVdfQS7lzf8m3PIja3QVUYxRjCBLOVI5TS27n4frdK1MKidBuzpqgab3Bta1YkyjGroUvYrzQV8kSpjj7HAsMy/z8h5Y/vXVAQD4PkEgbh+P3YtWS6WABJVJukTk3jcjgs9j2ANAwcqrjXnssueFucXXin5axbyVV9qm31wzZFYBrLgHFj3YbrKMXWXpP1KP4j1EUhWS4Tz3oB4peyL4C95+Y4ggxP3uDXO2d0oJFCxZzy+1yS0Sg+jKYXm7tSaDhU2imfV2eaobFfdeH/NyHEipEzW5V7OYDPD3RDakjNslPccfR7IyFX1Lb9Xr5cb2juytju/4Nxs4g12CqbD7CiOV72Z6co9gpon7Kn140RXLpLqME09QLaVEDd65q9c0kpMS8CYB3TlPzKGPt5dGUDliHuvA5+mcEttWdY+Lm4Vx2GqgQBDed0YkKprrnOHJIFi6in2txiNn98Xkn3PL6FC6B6jdtiJ1oIiD2C5OzRXl9dHLlDOEPnGMYMdkeEf62wDQLWXB+ggN+cvfMEsR4TQGJQEk6jCD5g1EVy1WgGQCpIBEYnNoeiMyVALpakai8YLZyDE1I+T5VAFRtCrN3MUU85J7tbUhRbGT2KYhi77jmGADKIKtr1rM9b3eVKS94JA+K/QEg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6506007)(2906002)(6666004)(31696002)(86362001)(36756003)(6512007)(53546011)(478600001)(83380400001)(38100700002)(2616005)(41300700001)(5660300002)(54906003)(6486002)(110136005)(66556008)(66476007)(66946007)(31686004)(316002)(8676002)(4326008)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2R5QVVhdlk2bjJkWkxJdmhaUzJOdGVXb1hRaFNxNmx2TlRiVldxb0tvQjJK?=
 =?utf-8?B?dDA5cm5ibzlzblB3Qm5CeHFVdTNRVWlSbmd2VmRmQ0wyRmpyZG9RSm1qQXI5?=
 =?utf-8?B?d3VsV1NJR3ZyUWo2c015cHl4TGNSLzFlcGpNZUdFTW80OUtkNDdHRytjVkFC?=
 =?utf-8?B?MFJGODYwd3Roemg1WnYwS1AydGZybEk1ZjBTZG15N0NEaDAwM0hlTU14U2Q2?=
 =?utf-8?B?L3pIUit0dmJGM0VxL1NkaDBXOU9FVytHcHF1UTN4VXNNNG5XZFpQSjlYSEN2?=
 =?utf-8?B?L0grVStXc293QURtNDlac21CSituNEppdzZONGtHekZzZ2kwSmRFNS9iZXNJ?=
 =?utf-8?B?dTJaRWlNc0NGZ0JCN2VSZFNtMXpxTDQ2ZngyZlR1bjR2MDBRanlPcGdOM0hI?=
 =?utf-8?B?NlNpalI4d1Q5WEFtelVrakd3cWdBMkRVZmpCRFRKY0pCTzV4OUxhNGgwMm9Q?=
 =?utf-8?B?bkkwMHhHc3M3b0tqdENXWUlCK3JjbTZGRVBxbTg0Z1MxMmp0U3NjaVhncVBL?=
 =?utf-8?B?ZG5lRnRhdHRNVll2b2M1STJEWEpTdXpIY3hjVWpQMWRnclRDWkJQYk9HenNh?=
 =?utf-8?B?SG9rdXVON0FWNExyb1M5eEIzd1JWRFBHOVVGYTdidUFBcERPbXM0d2dQdEk5?=
 =?utf-8?B?MkNRRzR1eUYvcVNtNWhBd2FnTzJnZzJ4eGw0cVJUbGxZNk5QWC9Jb0c4SHYv?=
 =?utf-8?B?djAwS1hCVjlUSm4vdEY3ZnBCSlp6TjdwUzN5YVpyMWE4M3VJUzR0ZzV5Tzhi?=
 =?utf-8?B?M2ZRTlBhQWJKdUlwWmZwV1Fmemg2dHFkdHRXVGE4NVE5Y0lpc1dtbFhwWkNO?=
 =?utf-8?B?b3B4UEJHeVpqZk9GMEFMUGR3WUFQd2JwNkFXSy9MSlhVRWF4T3JSNDNoMWdl?=
 =?utf-8?B?NjJla1Q2ZDRLUEdVREt5YkZTc1lRY2hZT3NpZlJNY1BBbXIrVjhDYU54RW1H?=
 =?utf-8?B?OHNReUdVT252OHQ5aDFoK0pjRFhtVzRnNG9YSFZZSlNYNjdaV0R2cXpGdXdG?=
 =?utf-8?B?RlpXMnZzc0VjSE5MOG4xZVByR2pNWXY4NEpEL3RCN2ZkSlJpdzVaMDZQSUVy?=
 =?utf-8?B?djVuMmNzcXNvY3g1cllDUmZIdytZTnJic1J6UHR2dDZJeDd2b3R5dUZnRitv?=
 =?utf-8?B?VFhnM0crMy93ZTk5ZmN3ZjFzT1hWelZNRDhCS3hoTEo3N1hWTDEzc1JkRXYx?=
 =?utf-8?B?dVBkRko3YWhNNHIzcEo0Ui9TNUt3WVdIRnQ3YjdkU0tBS0ZyaDIzV21wRmpR?=
 =?utf-8?B?SkRnckpWTmZiK1J5OXdwQW9sMHlQU2wvWDJjTnc4aTZYRngyUXJNbkZ1Z3E3?=
 =?utf-8?B?RzcxYXQvMzVGdDA4MUhjQmx0ZUk2SkFLNGplSHkxNHN2RXgzQXpObTd5U2ZL?=
 =?utf-8?B?N2N6TXBtYiszSU4wSjk3TDhvV00xN0x2ZkEvczVuN0RtM2dtNnNjbjlQcEFQ?=
 =?utf-8?B?MmpYVGdKTlJWbzFHK1VMR3dUWDZuYWRLTEN2dXUwRjUvTTR3c2s4aEJvWml2?=
 =?utf-8?B?dkYrSGZXdlBmeVRsYnFNZUdIOVByZWVCQ3EvOXJtMEZoek0zREwzVlU2UWpx?=
 =?utf-8?B?U2l4eWRVaENoYUJHZFljOTk4emxTTkRLQXppZlFKSldTYzN2eXRkYXVCdjRh?=
 =?utf-8?B?ZWNQM2NaRTMzbWtvUTFnSU8zTFYzeVJmNjRjN21rU3dQTGVSd0xsMTY3Z1lt?=
 =?utf-8?B?QlZjVm11QkJXV1JpeENPTTlqa1dXZCt6dUNKVE93NGVQNElUV0h5UFN1WEJK?=
 =?utf-8?B?QW1pRnBkTU5CSXlxM0ljOXJta3RVZVJuSEVtWG5TVC8zYVBXQTRsWHVZUi9P?=
 =?utf-8?B?Q1VPUDNnblNWdGZLVmtKWnViSjBUbUxlSG9UeTEvc2l3UitpVnRxS051OXNq?=
 =?utf-8?B?VG02MUdRSjhPQVNkYzU2UjFoaFJ6c0I5eUZxdUZRSG5jd2ZBNXVkdGpiWGda?=
 =?utf-8?B?RUI2MEtQT011VXVHeDdWQld4WnRXMVhhSE9KZWkxSCsydk55TkVTc0xXNWNB?=
 =?utf-8?B?eGRLaGpXZXRsemlKRlpadGcxa0k5b0lRRnhncXNyZnE5b2h2VFdvUEVYQzZx?=
 =?utf-8?B?Tk9jcXhpZkluL08yYjIzUmN5SERERXhyajZZWEorRTlDSGE3TC90R05Namt6?=
 =?utf-8?B?c2IzTXdhQjBrNVFYT0ZjME1FdVpaU0Z2WWdMbGhJY051Z29ObTYrU1FMR04v?=
 =?utf-8?Q?a4d7auMLeFp+zc/CaI/wWfo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	slARAwsjulOH8FWxv4UT0JXzdQRI/+/pwYTWNY33G4rOyL1UN7qOGeBYMeH7M6M0RZ9ny3DWtHVzl3zhtuT3df7mNTAuStQP1eK6DrrXtlcXqwDFTw4HXHEeWlAVDnYXtXh1ryJDT+UZ/jzQthfHcXvAk87HktJgLSU3naFDp3azaklzwM1o4e9NZ3/Lic6ey7Txig6BrlHfDDnHISkO1JC9vy8AtqNVCES3cp2D9i1BZst4nuyx1Az9kblDtcjYrwutsMfNzVs6SZ1fXvph7cCdhnsZ25OBijlU++vVXrtNh8j4tCpJWYho1BOzF98yEPJcj6cUUJBZV5teq6s4Vmd3hQMymuh/GYUS9860aofqa4gzgDKAsXgWjOvqFmjVK4ryTP6UvQvSQwKzS1bcHqtzA23OISCfhQ0zxRNF+DDILN+kTPK3wUgNpStGRefh1l5wyLZK9aOjQq/HBDOF5u+KfyppAMQq4o4GsbWiwrA7U8IVaxh8wmcTuEFOIaLop1hN23kYA0XAkecwRGYo/DXtWjDmYRjwzTRcrt1iG/Coa21hNcuj3aEktJkQZ7m6Pr63HzbfkRyo6M5Zp452zS8X47RHXIn2Yv84YWcNohA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8497b61-79ea-431e-d1bb-08dc024c4f14
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 17:43:15.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1IkVhr/bkmCscRee/2fGb9iJNydE639sWNRYzPrMdvI/wIq6k/GoawWWWQHQgWoK/c4AezIqPoWX3GH3/jCBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_09,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210135
X-Proofpoint-GUID: r_FPQekI5Mq9DCQXkMzRl65telEvd5hH
X-Proofpoint-ORIG-GUID: r_FPQekI5Mq9DCQXkMzRl65telEvd5hH

On 21/12/2023 17:05, Alexei Starovoitov wrote:
> On Thu, Dec 21, 2023 at 12:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
>> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
> 
> +1
> 
>>>
>>> Maybe we need a codemod from:
>>>
>>>         BTF_ID(func, ...
>>>
>>> to:
>>>
>>>         BTF_ID(kfunc, ...
>>
>> I think it's better to keep just 'func' and not to do anything special for
>> kfuncs in resolve_btfids logic to keep it simple
>>
>> also it's going to be already in pahole so if we want to make a fix in future
>> you need to change pahole, resolve_btfids and possibly also kernel
> 
> I still don't understand why you guys want to add it to vmlinux BTF.
> The kernel has no use in this additional data.
> It already knows about all kfuncs.
> This extra memory is a waste of space from kernel pov.
> Unless I am missing something.
> 
> imo this logic belongs in bpftool only.
> It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
> 

If the goal is to have bpftool detect all kfuncs, would having a BPF
kfunc iterator that bpftool could use to iterate over registered kfuncs
work perhaps?

