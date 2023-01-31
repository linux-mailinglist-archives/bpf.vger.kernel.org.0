Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F7683AAE
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 00:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjAaXqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 18:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAaXqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 18:46:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFA59E4D
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 15:46:11 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIi8eS006462;
        Tue, 31 Jan 2023 23:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FHzgXPaA24L2ytiemXgQ8irw2O3yIduRkR6P52+fGNo=;
 b=vfgS1ti10Oo+gRJBHuh6dqTCHNsia/+6gDAIfHmRsTLB/ch9mdvgqDq1LDLUgWrVZCY0
 d6E73+p3SE4OQUH0zVRFayFtXbND90ILtYVmnhnPixncjijtPlaNAXpoimHt4Lt8LOsd
 pvVQvTIgHzj07Qvk0lKsXQ0xNWdzPaSfqIjek9k7rU4AYHp1kr7VSpdhmWkC5RdNZB7J
 Asjf4vjDRg77Cy4fRrkFzIbLmTjOpb08ZT+kMQqk7Im5dJHGLoQ8n1gLIoTn3UgERDz6
 379dd00FujRDYX7CEBbVY3w+KJFClPpXI67b1mBjqbe8VXTOzBNmmUblyl7eU/NBXUDA Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvp172bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:45:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VNBaLD024948;
        Tue, 31 Jan 2023 23:45:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct56qckc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKyZARyK2Z2dSxk3CIeuASa4b3VGeFI9Tno9+UViEGnQwvbk1vkELB/Vw4mZxwjEuvgv8ovDc95gu3yFjbvZxIqi39WZPm/eQDkbTu+mVh82FW/M/C1ohEEmetgCDlwReZIUFqFA4CFjEorQ/0Go7ALR9GzchwV6tnzDCqLJRLrQZzOo804Thx4uStz35MrSpq96n9CNNeX2yvZJ3lujKEAXsWNqufEV+YPCBljXNAXTVR/Asl4XiMzH1+DNF4f4S1YLgALuYvq+8qts2n6ltrbC1zMCAgUSDe/NwGs1C1JXSh30auMK+tq3gEcvrgmyapnpakgp7ft/4dhPPwL17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHzgXPaA24L2ytiemXgQ8irw2O3yIduRkR6P52+fGNo=;
 b=oJ0AWrynyrLT8/ZGJEu2ukPA6Ssra2Uk8W8u4gILPRs6EBGzGD7sIvAOd6dlY45nKEaXlK9SR24/0Z53HbmO3A5fxAPoKE4Sc1uFLwcd8ayr+cTx8B8g4oAkIQV6Ov3RTp99yPYjtJuMpZP32PTrSyFEiLzyhinOy4FjWlqh+nMzZ9juRljrzkJ/MdotH/z6jjWLcvAIV8KwUO0MnEPOejps44Fi6Mrd7rjpo0ugkLGk9HXRpatX8KMXq/5KK5eqmgMqqw9dKgZgzlJopARq/IZtHqchYwd3VcR+yrhGkE5unftbKT2YvCbV7F3cyw7RnaHPRNfZfCP9fO6bLHMWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHzgXPaA24L2ytiemXgQ8irw2O3yIduRkR6P52+fGNo=;
 b=q/WdcEAA+xpZ0KBFRjYHH/UhicIuq3upfOYpUNCp5OPWxncpffVxmgxeYprR3FHOKz3m1hnvbkGwFDiAWUQWb8gxxi/cvCTmvLPfQLuj+vw0PdWEInI/Laesicnf9NE7U5W2peNhpDw88BFpkJLCA9R/6eJoNM+Ye+vdj7lifkQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4554.namprd10.prod.outlook.com (2603:10b6:806:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 23:45:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 23:45:37 +0000
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org> <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
Date:   Tue, 31 Jan 2023 23:45:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:208:1::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 36289856-1256-4818-dc33-08db03e54060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7zvtfkI4qb2A+lTNmoZr4YBuE3hGOHpbWTSO4oBc8fQQm+3O41hyu4SuWULE9kHiqOjAMUlAS1S52YmOF60HVYSyrFJ1fx/jtS+TSPaT3UBQcWNV3h6W4UDlX0gvt+qsQi/SGVYrvNmsMQ8xV1oqqaQI1hVSukJN03hal3Qaf6K0TpxLJcMoCmUc2PcLfoeq7T0JcKWZLmROsMDswt7oPDjfHI2z9EY/r9Gap9pV+G8CsYDG7GRc8ZR04feNJpphDqwvBqVd3QADS84KsC2M3x8Gxw82z0L36ydFfZKMc7nVvig4NKhlViUTZ2k2dnaAG8pv3O6fSwVFpqHTsgwAbMvn7Brl43UHxRQPHb5rNkBV45g6riajALaB0g6qsCHWV3tioZEB3VkNFnGeDJAR4YlP5zOOzooUkkDRoHFbva6VHvPEB/BY1CdtgBpCwkrMBpY47P8wpPIaly1kR3pCcQBU/Vl+egoexTgyvky05G7Be9AgiX0+o2ePMpAmFIoA2nrVWQ/SZKQt8qfndLMizXRL9cy4I8aoT8jn5HhCdwqQhunz2NstG7FJmkMvNvuumTebIQ5l7/VdldEbhbEQ5n50RWThHqm+cZ5RyMHX8ytN1CrdLkTMK1T24LXuqP+IQgOm5bbTiFuNup2o0rQW8gFPCCdrwILan39hZoMphr7YHF3hHMVOW2tYVqp5NrLruNyxqOtXzNptrPDLP+/WateDvIgZqlYsU5M2NQGeGQup9SthQwlbgTNpjlMv0++TtTjf+poIIObvma75zItMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(6512007)(186003)(966005)(6486002)(2616005)(31686004)(53546011)(6506007)(2906002)(38100700002)(44832011)(6666004)(5660300002)(4326008)(66476007)(66556008)(66946007)(54906003)(7416002)(8676002)(110136005)(478600001)(41300700001)(316002)(86362001)(8936002)(83380400001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUFKc1kySzFnUXJiL250TnZPNFZVZGpYM0szUVpoVTVvemc2V0swVXp3ZjVy?=
 =?utf-8?B?cExCeXM5RFhWUDQ1SFIvR3ZNVUpmbjZDb3ppbzdvUWY2VnJvZTZqc0MzZnlC?=
 =?utf-8?B?QXNaZkxZQThvZWEyWk83czhsZmxoR2diTjJ0MWJwNWhXYm1zeUJOSVFOZnp5?=
 =?utf-8?B?dENrNGVTVE83Ry9ra241TzBsL2JZOTFCY2pnQTJULy9sbDBsZzZoY2I3cmE0?=
 =?utf-8?B?SitvemNlZlVuWFlla2ZDdjJGV1ArZUtKOXZIUExLeEJlRjdmanJGcXJKbWFV?=
 =?utf-8?B?WXRRS1ZNQVZWdVhUaDFEV1I5bmZlNlhWdHl6ZzRBbFEyTytaa3M0K29SS29H?=
 =?utf-8?B?K25DTTU2OWlFK1VnakZNeUNQck5aV05tR1lHUlNrS2poMmR6c2ZPODJGejVt?=
 =?utf-8?B?bjA4UXBHZE01UERzL0N1eVhVazdaNlFxN0xoZ2gwMmpGbU8zeVF1UDJneXdn?=
 =?utf-8?B?TG1ENGNNaEtmWjRzaXloYWVYTGNwV0h2UlhRRjYrWUhsK0lhL290SWsxWExi?=
 =?utf-8?B?RVMrSEJaWkFJdHE2SnE3bDY2enBjcTd3YTFUci94RTJmWWZ6T3VsWkhKS0ow?=
 =?utf-8?B?SjRkVU5tVFJNb2R3OEM5dGluMWpIMUVvN0ZjUlhPWERJQkd0cVNBSzJUcHFt?=
 =?utf-8?B?Q3NvZ2dnQktCYy9VMGFqcjE3eFYzcUFMS0lLWnFhc1hERUlkTjQwSWdJN0RI?=
 =?utf-8?B?b2s4NFpxMFExaVF4ZTBzRHpCR0l2bEF0dWdBeG8vaUs5MTlITHFwZm50eGhG?=
 =?utf-8?B?Q25vaWtlY3VFVXlvQkh3M1Rvc05tSFR1VnZxQkdPWk15V1NSaTdMOC9BeWhW?=
 =?utf-8?B?ZmN2eG10YmJLNW02U05PK2UvaUVWV1hmSUxqYlVub1ppeUpkM1JiNjJCYmYr?=
 =?utf-8?B?S1hNWDRtS1FaOFBxUnZiblYzZnpXdW5Qdzl4NDVMOVpuRGEycyt6bUdjRGlz?=
 =?utf-8?B?UU9wMm9yRzduc3VnV3Nlc3NpTkgrY0wyY0krMmdpWjZQUUpZUEJYR2REcEVE?=
 =?utf-8?B?V3JHOS9SZmluT29NbVQxa3JSUUpjMzFCdmNmM2xjc2dmQkl3UVFmTEtqMTBI?=
 =?utf-8?B?VFRXYnlMZ3dDWjRBOTI1cUZodXV2SENLdHI4QVRuOTlFUzIzczZoOCtzMVVz?=
 =?utf-8?B?SjhSU1JDNDNIa1RLNnl1b0sxN0Y4UGtUUjhkOWU2WFJTNWR3TExqdTE3VlZR?=
 =?utf-8?B?Nk5xMktoWkZ2cEZJQ0VrMmJJOTFCMitNK3lYSlcxbXhQdnVQZUNjZVpRbXlX?=
 =?utf-8?B?RVVXeTNILzQzSHZKNUFRMHN3aXVwRkVUOUhqSGZMR3Q5ZkE0V2RKTEFMTDlv?=
 =?utf-8?B?dGFJRmV1QlBvOEZrZk1pMDVBMFBUNk9SS3ZZeUJoTzMzNGRWUjA3bnRidnZV?=
 =?utf-8?B?OVkxV2FCZnVOU1Vma1RFbEZKSGd0Vlh4SjRjak9MN1NFdkY0azhEazFESkoy?=
 =?utf-8?B?MXNIOEZ3c29EYitGZmdoYU9uRlFzaEdiZzQ3OTByZGhnOHNVUHZ1TTFhcjBF?=
 =?utf-8?B?MjFiK1A1bWhHd2JRYW1jUElrT1lwSitmazFBWFRmQ2FEYVFtWU9kR2pVejBJ?=
 =?utf-8?B?SDFQN3B0TjliUjk2NVBBSXd6ditXVzM5NjhFdmVSdEFQTWhvWkgwaTFRdTd5?=
 =?utf-8?B?MjdCZGtweDhNaEpTdUszRlo2TzI5YUo3QVNac1VLYUwvcFNmN0w2NU0vakdx?=
 =?utf-8?B?ZFltMUF2MXp2djh3bjUvemJXa1VnYTExdTg4aWdObDZwbHVsUmcxRS85a1A3?=
 =?utf-8?B?ZnhIaW5ONkV2NkN1dVZIOW9acjkrTklLN1FxY0l3UUZzYXhZMGlIaElyZk1I?=
 =?utf-8?B?S2FXZ21MZE5RY1FuZWNRZ09ldVQyNUc0aVh4SjFncDlOdlZHbzY5bWN1K3JO?=
 =?utf-8?B?akphZk42UnA0V3BEa3llLzNIcDVnb0VSVDM4ZmpxTDYwa2liY3UyRWxPNDVC?=
 =?utf-8?B?K0c1RDF2aVV4Y1d0QWR2RlFMV1kweGVIUytja1cyMXIrWGhHV0w4bWlYQzRM?=
 =?utf-8?B?a00vSVdPdjFlVEUxOC8rMG1QNWdJZjNQRnY0cWdJdTk0OGl2Um03K3BHb2xq?=
 =?utf-8?B?T3phNXF0L3BQTk9oUGpHMCtTeXIyS2V6TGJmQU9PWndxcy9sc0YybzRIZnpC?=
 =?utf-8?B?SlV6SWJVbm93SytZNTZKcCtJVXZ1SVdya21BQlM3WVh2eG9xTkJnTzNYTEVn?=
 =?utf-8?Q?j5YKPKnkToCoJ+a02JzSbIc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NVlZTFhOWGdnS2V5dWRCMTk5ZEZsTlFzamNUeHZndUNkd1M3azNUOHd6OW82?=
 =?utf-8?B?NDF6WGxaZHJyVWZzWTBJaytPZFRUdG5JM3VDY3hGRmVFQTlLR2VCcUFWZnZ1?=
 =?utf-8?B?U2hHT2RkTUkvQWZhNFNiZHRadnFzNjVudDVFNlRIWFlsVUhKckxvQzZjbVY4?=
 =?utf-8?B?WWRScVIvczF6Q05iN2ZqMnpMZEwzakx5Q0FsZEJRNml5eHdQczZkMEJOMTI0?=
 =?utf-8?B?VjV5dGlPUkp1RTVPbndnemx0d0FHMW9XdmN6SDFnQ05QU0trWkl6YkRzQXIw?=
 =?utf-8?B?TWdNQm80Z3VtUUpBQklPRjMwWXJ3V2V2a1hkeGlBd1N6dlJzZjlIN3JnSGs3?=
 =?utf-8?B?SmxDRDQ2SUZFNTlrMHY0bnp4Zm8va3EyUFFFNHB2Y1VILzFkVmhkaUdOdXFK?=
 =?utf-8?B?VHE2Yzg4dnEzWEFQcktWYWJnZXhodUk1VVFJN1ZrS2FFai9va2hISGJ0TG1r?=
 =?utf-8?B?NEdRWGVuSHhQNjZSdVlTS09vQ3BCZUliNzNUd0o2Z0hSUG5XTjlBcUh3bVpw?=
 =?utf-8?B?dTR1ZHJGb1J5MldtTVVteHo0MlNsV29keEQ3Y0pISnZnUlMwMzZJOGdMV3Iv?=
 =?utf-8?B?WkJiVEhwSFpuUmUzNHFDUkZ5ZVJaR0ppYXFiOFQ3Ulp0Rk01ZG9tZFFEYTlo?=
 =?utf-8?B?ZWdpckZpcXlZVy91UXF1MFh4UkFXY2pWcU5uUHh1bFhuM1k1SmUzVmhGbHpr?=
 =?utf-8?B?amZyZCsrdXVtdEUzTjByczR3Y1lBZjJuN0x4RnJoYnZoRi8wa3dCVTBhZndJ?=
 =?utf-8?B?Q2I5Sk5VTTRRbHFQM1lwRFlOLzBLdTZFbWsxYXBuSVBOKzJHMEp6VVBwMkZv?=
 =?utf-8?B?bGpJVVRlVWhnWGdZTVVJR1E2M0N1ejRibHd4MkpBWDJDTE5SMW00YUQ5QkNv?=
 =?utf-8?B?Ym5Sd2w0WTN3Wlh0MUdCSjF6TW02NHdkUUpQS2o5MFVqNUNNeS9tRjdsSCtl?=
 =?utf-8?B?WnVsZVBqR2w1Y01va01STWMvRUhFK0Q5bGZMNnYyT1VOdzBlMTVGUC9Jckd6?=
 =?utf-8?B?ajdHQWozS1FVUWtmZFhSUmpXSzBXbjI0ZnYwRk1qNGYxcjR6RU12d2E5a0c3?=
 =?utf-8?B?cEpqaXJCR3g0bEhjR1NiRW9tbUV2V1ljVXIvYjFabE96WWxhMUoyd0s0NEx6?=
 =?utf-8?B?RG9kYzRleGswWDB6TkQxSmZZNHhJbkxVVlhxbTRPMk05NjhZc3RmbXdxemJ6?=
 =?utf-8?B?ZkpZV0pJUjJTSkROcE5ZZm9lbWhTcFdkS0Z5ajZIQVM3MmNjQnNpalJ5eEVF?=
 =?utf-8?B?T3I2OWJ1MUJ0bmx4OWZxQXBCT05LbTFzWHBUVnZ5TjgwNHFFcm9qWUFhYjZo?=
 =?utf-8?Q?3qa+Mp/LX6aG8ursaxbKIAnyiLAID91Wuy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36289856-1256-4818-dc33-08db03e54060
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 23:45:37.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQnFmOuw4BHnYF7NqyCHwTMZSFMulacv3f7yAPrxLSGubkLwX+3HbHd2dc6ql4V7z2TXoCFQfihn45pVWgB95g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310203
X-Proofpoint-GUID: KpO4XvKyTgxkf7CA9286Ib-0oqt4DSlZ
X-Proofpoint-ORIG-GUID: KpO4XvKyTgxkf7CA9286Ib-0oqt4DSlZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 31/01/2023 18:16, Alexei Starovoitov wrote:
> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>> +++ b/dwarves.h
>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>>>>   uint8_t          has_addr_info:1;
>>>>>>>>   uint8_t          uses_global_strings:1;
>>>>>>>>   uint8_t          little_endian:1;
>>>>>>>> + uint8_t          nr_register_params;
>>>>>>>>   uint16_t         language;
>>>>>>>>   unsigned long    nr_inline_expansions;
>>>>>>>>   size_t           size_inline_expansions;
>>>>>>>
>>>>>
>>>>>> Thanks for this, never thought of cross-builds to be honest!
>>>>>
>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>>>>> into one small thing on one system; turns out EM_RISCV isn't
>>>>>> defined if using a very old elf.h; below works around this
>>>>>> (dwarves otherwise builds fine on this system).
>>>>>
>>>>> Ok, will add it and will test with containers for older distros too.
>>>>
>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
>>>> repo at:
>>>>
>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>>>>
>>>> It failed yesterday and today due to problems with the installation of
>>>> llvm, probably tomorrow it'll be back working as I saw some
>>>> notifications floating by.
>>>>
>>>> I added the conditional EM_RISCV definition as well as removed the dup
>>>> iterator that Jiri noticed.
>>>>
>>>
>>> Thanks again Arnaldo! I've hit an issue with this series in
>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
>>> from the BTF representation, and as a result:
>>>
>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>>>
>>> Not sure why I didn't notice this previously.
>>>
>>> The problem is the DWARF - and therefore BTF - generated for a function like
>>>
>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>> {
>>>         return -EOPNOTSUPP;
>>> }
>>>
>>> looks like this:
>>>
>>>    <8af83a2>   DW_AT_external    : 1
>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
>>>     <8af83a6>   DW_AT_decl_file   : 5
>>>     <8af83a7>   DW_AT_decl_line   : 737
>>>     <8af83a9>   DW_AT_decl_column : 5
>>>     <8af83aa>   DW_AT_prototyped  : 1
>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>>>     <8af83b3>   DW_AT_name        : ctx
>>>     <8af83b7>   DW_AT_decl_file   : 5
>>>     <8af83b8>   DW_AT_decl_line   : 737
>>>     <8af83ba>   DW_AT_decl_column : 51
>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
>>>     <8af83c4>   DW_AT_decl_file   : 5
>>>     <8af83c5>   DW_AT_decl_line   : 737
>>>     <8af83c7>   DW_AT_decl_column : 61
>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
>>>
>>> ...and because there are no further abstract origin references
>>> with location information either, we classify it as lacking
>>> locations for (some of) the parameters, and as a result
>>> we skip BTF encoding. We can work around that by doing this:
>>>
>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>
>> replied in the other thread. This attr is broken and discouraged by gcc.
>>
>> For kfuncs where aregs are unused, please try __used and __may_unused
>> applied to arguments.
>> If that won't work, please add barrier_var(arg) to the body of kfunc
>> the way we do in selftests.
> 
> There is also
> # define __visible __attribute__((__externally_visible__))
> that probably fits the best here.
> 

testing thus for seems to show that for x86_64, David's series
(using __used noinline in the BPF_KFUNC() wrapper and extended
to cover recently-arrived kfuncs like cpumask) is sufficient
to avoid resolve_btfids warnings.

We need to update the LSM_HOOK() definition for BPF LSM too,
otherwise they will cause problems with missing btfids also.

With all that done, I'm not seeing resolve_btfids complaints
for x86_64 (tested gcc9,11). I also tried using __visible, but
using that in the kfunc wrapper causes problems for the static tcp 
congestion control functions. We see warnings like these if __visible
is used in BPF_KFUNC():

net/ipv4/tcp_dctcp.c:79:1: warning: ‘externally_visible’ attribute have effect only on public objects [-Wattributes]
   79 | {

However, for aarch64 with the same changes we see a bunch of complaints
from resolve_btfids for BPF_KFUNC()-wrapped kfuncs and LSM hooks:

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol tcp_cong_avoid_ai
WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
WARN: resolve_btfids: unresolved symbol bpf_lsm_xfrm_state_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_xfrm_policy_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_tun_dev_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_task_to_inode
WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
WARN: resolve_btfids: unresolved symbol bpf_lsm_task_free
WARN: resolve_btfids: unresolved symbol bpf_lsm_sock_graft
WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_getsecid
WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_clone_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_shm_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_sem_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_sctp_sk_clone
WARN: resolve_btfids: unresolved symbol bpf_lsm_sb_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_sb_free_mnt_opts
WARN: resolve_btfids: unresolved symbol bpf_lsm_sb_delete
WARN: resolve_btfids: unresolved symbol bpf_lsm_req_classify_flow
WARN: resolve_btfids: unresolved symbol bpf_lsm_release_secctx
WARN: resolve_btfids: unresolved symbol bpf_lsm_perf_event_free
WARN: resolve_btfids: unresolved symbol bpf_lsm_msg_queue_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_msg_msg_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
WARN: resolve_btfids: unresolved symbol bpf_lsm_ipc_getsecid
WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_post_setxattr
WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_invalidate_secctx
WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_getsecid
WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_inet_csk_clone
WARN: resolve_btfids: unresolved symbol bpf_lsm_inet_conn_established
WARN: resolve_btfids: unresolved symbol bpf_lsm_ib_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_file_set_fowner
WARN: resolve_btfids: unresolved symbol bpf_lsm_file_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_d_instantiate
WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
WARN: resolve_btfids: unresolved symbol bpf_lsm_cred_transfer
WARN: resolve_btfids: unresolved symbol bpf_lsm_cred_getsecid
WARN: resolve_btfids: unresolved symbol bpf_lsm_cred_free
WARN: resolve_btfids: unresolved symbol bpf_lsm_bprm_committing_creds
WARN: resolve_btfids: unresolved symbol bpf_lsm_bprm_committed_creds
WARN: resolve_btfids: unresolved symbol bpf_lsm_bpf_prog_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_bpf_map_free_security
WARN: resolve_btfids: unresolved symbol bpf_lsm_audit_rule_free
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_ref
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass_ctx
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass2
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_pass1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail2
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail3
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail2
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test3
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb_release
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb1_release
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_int_mem_release
WARN: resolve_btfids: unresolved symbol bpf_cpumask_any
WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
WARN: resolve_btfids: unresolved symbol bpf_cast_to_kern_ctx
  NM      System.map

Thanks!

Alan
