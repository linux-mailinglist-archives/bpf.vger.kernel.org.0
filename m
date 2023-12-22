Return-Path: <bpf+bounces-18621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24381CD0F
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4511C21095
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892424A1D;
	Fri, 22 Dec 2023 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iF+dG7UP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qOVW/8OI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59324B3D
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMFStR6027087;
	Fri, 22 Dec 2023 16:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=88Xe03jPRBnUoItK3XkydgtwehVbCc6Msi/+TCmrGmI=;
 b=iF+dG7UPa5Sa+/sl3/sYTeDoTVpOEtb4Vy+F5u+6Ij51iNSVwJuvselAKk9Vi4SUNJbB
 4G5SFqq5mu6KP9VJhvjijNXBcwvv2Rs2VHWNas0zJwHvKM2s3AerokaXRRc5POHLoswS
 6wcVYaa+LRmN6wnKkj7oo45CRemyQNSsoAQNQoAb/m4FbcfoooPsTMsKUdIVn0Ou+T+w
 6DFHmwLz+Xae5p3M+VdMzPCW8L0fmQTTpi0fKNO9RwN1NhHQu1QqEFu36VYDtssyeXNP
 GAWRgdvvelhd/4EU7GIsLTc4YBeI1cRQHdTGht+5+s4BS90wc9lRbl0JXekgklGK4cPs bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gup1fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 16:24:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BMF8L8U035572;
	Fri, 22 Dec 2023 16:24:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12beaj0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 16:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/QJ6/AhH0uiHjiFyt+/J1cpQU9W++WnRRD3RWzZJB09ij9dax+dVDG1+TjvFbRA50Zsj2pr0CJXFdCcAQbfJpa6+B7hLQs/oRorcwc/vWAG/BY6B9z948K5pqAX61IjE0r+GCmWcVQld7EXMEUOZwwZVDmf58zOx1eANSCdr2/j8LOMDHTkhQgWVn8z9ik0yHPvaL44n6F/xKtZsLkA90iL4vihrn3j3id0R7owRYGgV1OBosa442t1Gqh8feaOQkxU16zI+bSfGfIN4xLgiTmKagpvTh2idnnSuW7bIUR5qpP9ijJL75Cp8dwKgUUSIxe9olU8lybWkTbIan5Ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88Xe03jPRBnUoItK3XkydgtwehVbCc6Msi/+TCmrGmI=;
 b=bB/IzeVDfxKgpCvh4qg7qvSROVtecTjoikqxAe4ddIdONxexCLH5aeFYuAY6HqflmlXNBGYW2up+t/sQfk4XtwqUmRMmUseAHd2j2r3gEmxSK82aU9Zs2FDZW2B5TC744K7lsEcVy1zcpTW7NeoikwxEHYJ2OYEtsWAsdqa60Eloo3UH+9MhEdLsYotsy1bqo1GV2/Quq+qNGDnFStKDa2+nsxj5itYMIeBS1p1I+eRvk+FTdzAIOlsSq1CIlQmdBpqlP5c3X8zy+P2Bh74sw/omyqGf+9znV7AFWvdYE0wEiK9LeB0FDpuoPcPuTipdzGjiNTEA292bTZb6e835lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88Xe03jPRBnUoItK3XkydgtwehVbCc6Msi/+TCmrGmI=;
 b=qOVW/8OIMhTVMlzTg6J57NRQdyxoQg4gYP2XXOIDw+aChNzD7/9WIoL3F18ca96/dt5FWWgj6c65BngDX8xgrs5mXHN/et65OXX2YZ2FwArSM82LCfY0GnCe59EoEXbIUHlLytDq9i69SLCm5iLAC3S+ER4bOtFlpd4KPgM5ueQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH8PR10MB6624.namprd10.prod.outlook.com (2603:10b6:510:220::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Fri, 22 Dec
 2023 16:24:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 16:24:38 +0000
Message-ID: <00df5193-bde2-fc03-0d88-313cf6ac71b6@oracle.com>
Date: Fri, 22 Dec 2023 16:24:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <62ytcwvqvnd5wiyaic7iedfjlnh5qfclqqbsng3obx7rbpsrqv@3bjpvcep4zme>
 <ZYP40EN9U9GKOu7x@krava>
 <CAADnVQJL7Yodi67f2A79Pah-Uek+WX66CVs=tAFAoYsh+t+3_Q@mail.gmail.com>
 <fecae4fe-b804-c7f5-1854-66af2f16a44a@oracle.com>
 <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
 <64f6db18-ebd5-501b-2457-a8abe6187a0f@oracle.com> <ZYWFQ62dASM5InBZ@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZYWFQ62dASM5InBZ@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH8PR10MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0546b0a8-2c7a-4e3d-4a2e-08dc030a7e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S+pYOtaETY4h3N/M3rvudcmHyIRVfoTSA2tcbf+Sx0NSDUDSJteRysbyz2nLLr1fdtJ7mvOe0eoLIzNtDqeLCs60XyjBXy2dP8RyI/f1tv1pJwgwlfwaX4SDqQipZH6jaUKy0/BTwf8Ht7GiBjtOdN7rjhi0yYE39FNFQA5gWEuJcXa9YZLGZFR6cSx3DteJpJyDP0erFBuMiTdi/P2F7z4MfQG9N4n/A/xPCoUUEUCc7G56LE3y9bG0JJoKj3dat+loVrATTIQ28JJhdbOES3Gpte+lM6qI+i0meplkwRluEcBqUkOCpaTcflhPJfwbGsG1KaM+xGMsHMOmKyF9Tj94pFzSrFMgrJarUmaoJtrO5ouaXNik/xmRb4ifdc+1oghJY/iKUliuOi+W888Uk0ZWfmaUk0kBF5H3Aj7I83Lgb6Eh3Kh75O2UKizTRdmIQV7+00GRIIuGw7x7ad728MYQyHFXWCGdFx2vCSpMdWV5JECI5jkBafF5XPoECG2w5uZ6u7wUFnBp+JOuTrS0WV8Hl4qluSplGDjKunOA+MZdVEFY86HRNoKhcjNWC4mCDf2kZ16ddRFv3V/5CUcXhliUobewvZ0nyJ4NPmox9imF2aoyFxn0/RkRHZOjJuhIaAMl3hJME2+18lH89uixYw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(6916009)(54906003)(8936002)(8676002)(316002)(66556008)(66946007)(66476007)(83380400001)(2616005)(6506007)(38100700002)(44832011)(4326008)(478600001)(6486002)(36756003)(2906002)(6512007)(41300700001)(53546011)(31686004)(6666004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eW5MNmxUaGkzbXVlT21LTjFRZjlUZmZlTmRUdHErVVFWU0czdHJSamIzUnJD?=
 =?utf-8?B?cTZjWXF2R0xTMGprZEJoWXVkN09mMS9uYXNrY2p6dE5obzg3K202NGZaQ2la?=
 =?utf-8?B?NHE0VlZjZVh6SnpnRnBYc0pqb056akIwbkVKNWhOQ29rc2JiM09jQzlKRnFj?=
 =?utf-8?B?SDYwYjV5RFNxNEx5WFhxKzYrQ3k2b3FvckpNNVBqQ1pudDRqbmQ4UHQ3TGQv?=
 =?utf-8?B?dGxIOEVXSnpQTmFoaFkyR2FNazFkWW1JRmZUcER6UzcwM0ZXZFRZTDFnSDh0?=
 =?utf-8?B?alBZU1B2eGl0cTBBaSt4VGV3NG1NRDA2cGhLQTQ3YWZjZVM4VUdsSWxGczNT?=
 =?utf-8?B?Vy80eWRYc3gxQWlNS1RPL2lXWXRDb3hLQi9vZU9ldW5UNElyWDJNTWF3aW1X?=
 =?utf-8?B?bzhqZXIrOFBjOE1MMitTTEY0bWRGb3g3dG44cmpzeWl1SWFHSDZPM01yczVW?=
 =?utf-8?B?K2w4eG5DZUhFSlF6bVdvanU3ZDIzdE4yVlVkRjdwMHJmTkd4QTkvaTlsMXJL?=
 =?utf-8?B?RWo4V05uY2dsVDdIS2RjSkRJRStRc2hwRjV0d0FMNFlBOFBrai81WnpZK3Bs?=
 =?utf-8?B?dEhxdU54UjBrcmt0c01ZS3dHTDJxNDdDT0pSTTNPZVBrajRURDhNdzR2QVpF?=
 =?utf-8?B?dnU3OHdBRUJxb3lqV1p3NFZqQXd0ZmcvQzF1Ty9hQjFEQ2xQemdoTFZIUjJt?=
 =?utf-8?B?VDJmTHlUVTl0MFhNM2VqWlpxblhTdktTVmlQTG1rTmJZamdHaXJVdjIydHRJ?=
 =?utf-8?B?QmFxMGhNU25XcmUxNWJ3U2pmY1g5akhxeGo5ZkxTdnIvT0YxUzRETmg2R0w4?=
 =?utf-8?B?NDVGakp3Um0rZjE3SjgwaHpsVnEvanJxdnFwNzg3Rnc4M3JBMU8rc2RhYmVs?=
 =?utf-8?B?dmswRHl6WTZwaXJ5bERGWWdZRzN0U0RoaGV0UkhjWnNqSzc0bm45ZDg4K0xZ?=
 =?utf-8?B?V1pwRWdidVB4T05vcWx4RUoxa3dCb1F6bTBXYjUzMk0rRVEvZmswTmY0OVdY?=
 =?utf-8?B?ZGxiRFdJK3k5QktWTU1xQ3NwWnBtdzFzNTN4WFpKa2lQV2RHL3Q2L2VwQ2VM?=
 =?utf-8?B?UDExOUFpUFJ0WlhlT2ZsK08yY3Q1SmN1cnFpemEwVGpiRzdCUEtrM25uTzds?=
 =?utf-8?B?blFLM3RnUkFDVU9uT1ZBMmV5TStGL3RzMUpqZzFEVVd2WUhieVlZVXcyRXNa?=
 =?utf-8?B?SDVEQzdXNDlJMklUYklBN3c0UTZUOGNHeGZRaXZmd2l2N3YyVjRDSTJsNVRi?=
 =?utf-8?B?Q0lYT3YraWNrcXJqbXdxRjR3VWErTUN1OXJIaWlMTW5Lazk2SjBlbXJnN3ZI?=
 =?utf-8?B?VThWMjZ2WXVFNExMbHlUYjcxY0x6MVRLOXJxdWU0eGdBUWxWYlVWM2FwWVdD?=
 =?utf-8?B?ckZ1b2paaU53THFSVlQvVDltVUZyaVlqQnhna0oxOU1kNW5yWko1RXBWLzJ0?=
 =?utf-8?B?RzNTQ3RDMlZlZXNWV2JQY3pwY0VYZTN0UjZCTEpMNzluVUt2KzhEcDg0MHlh?=
 =?utf-8?B?aVROSSswSVlHSDFtYjNHQ1FpaUlWZFNjTFBaQ2svbWp1TDlISmlDb2NsdWt6?=
 =?utf-8?B?Z0V4azNESUY1cS9XQkNYNCt5ekxla3dlMzU1S0t5OE5vVHRqV1kwVUVpdU1U?=
 =?utf-8?B?ZVJQZHNXa21YT0VLTjRZdVhFakVyQ2d2Z2J1cGJaS0s5YWQrMktRc0dmamFM?=
 =?utf-8?B?TURnUGFqYUNPQW9PT01ld0Z1ZURiYWhPcml4L0FHM2w4Q3RqOVVmait3MkE1?=
 =?utf-8?B?d2Y5SUhLczlISjJLL3QxZHhaN0pIaFQvNnROVzJBbmkyM3VjNE9HWkcyejZj?=
 =?utf-8?B?dlR3dlNCMkdGbUhrcUVWMzQvQ01PdHZSS2NHd0Y5QUExd0k2amdBL1BvZTBy?=
 =?utf-8?B?OE50VXUzWGpLd2VsMnhKcFRadWZMcUhPYW9mRXE1b0dYT1VoWjljRHBuUjZi?=
 =?utf-8?B?WjFNS2NZaCtHSDVMcHJhTjlQZEI3YXJ1RmxiNjBjSGZEY0tkeElKYU9wNDNr?=
 =?utf-8?B?U09DeTlsSCt0aUpISko5NEhQaWk1UUVKdStpYlBidldtdS9hUkxhWUIrZGU5?=
 =?utf-8?B?YnVSMDBvMHVwTG1sT3JEQ3BvQW4vbThseXllU2Vpekx6NlJOU0svSEdyVUY2?=
 =?utf-8?B?YVJlTGdWN0FnbjE5NVlERkk2aGd3R1NKWjY1YW9yS1NHRlVRSkt0Z0Vjd29j?=
 =?utf-8?Q?rFwjrAJVIoPjuWEPjmfCwl4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aYo/t1IC2x3ZiV4ODjqIxFl4gKxpjySlGZVB50oTWgm7p486ba4b/AIhus6+m+Qhi2/qLg07710cMUOs4dF2y7l+3Vk1WwKCZowFrRaIAXc17Wg8Hv2c2x9WFHcXY2DPK5wb42v7kuImLSIvoi17M3o8cQLqj+NVKivjeZWRI0VF08DKYFdWGrG1UP2tZIGzDfoL6/68cnnnQMtlxPQ2ZlQ2fZTsRs4EDl1N6q3qtfUnhhA30XvFWDrhjyykM3wrcEYYg9aZ6SvZ6mlkQCc4NUI7iI9jupbEyzNinwHcnC6HpEan7i9mOwX9Y0R4/mUKpKXV4ESXSAqMr2SN+thBsvOwLpxEs1y5cwyA1tPPG6ZSGKUR0Gm7GwrFSv39Y9hmQVTLc5ZHvusn746kEwSaCqhDMuNmA6wpKGCMD22weYu2SchITIkJgrhXG63pZcxUPahv02qw08lDXQ9Tq2A4RMg++gep8/0g4MggiTCH6lspu40/QjoJR0bd9lkdHXzi0sMSrf3JlpvacSuiaMXg1duZeIbrl51htZOWoHjTY71NWS0ocQY7dx3CXhfQDXVUtxSfTWPQ+sJ8LSMppKfC6WqKi5vBhwyeSgkuNUgJqr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0546b0a8-2c7a-4e3d-4a2e-08dc030a7e83
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 16:24:38.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/RIQ/gXjUnS0ORazxKtq2ehCSNtCUBeXIQUVwEq61JYk6LSK2lH41ZITwVcZFv0HjyRaF/9f5aDfoQCxKxPZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_10,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220120
X-Proofpoint-ORIG-GUID: 1X9y3-AMdBoABhiaZVMhWYm7E-76DsI3
X-Proofpoint-GUID: 1X9y3-AMdBoABhiaZVMhWYm7E-76DsI3

On 22/12/2023 12:46, Jiri Olsa wrote:
> On Fri, Dec 22, 2023 at 09:55:09AM +0000, Alan Maguire wrote:
>> On 21/12/2023 18:07, Alexei Starovoitov wrote:
>>> On Thu, Dec 21, 2023 at 9:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 21/12/2023 17:05, Alexei Starovoitov wrote:
>>>>> On Thu, Dec 21, 2023 at 12:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>>>> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
>>>>>> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
>>>>>
>>>>> +1
>>>>>
>>>>>>>
>>>>>>> Maybe we need a codemod from:
>>>>>>>
>>>>>>>         BTF_ID(func, ...
>>>>>>>
>>>>>>> to:
>>>>>>>
>>>>>>>         BTF_ID(kfunc, ...
>>>>>>
>>>>>> I think it's better to keep just 'func' and not to do anything special for
>>>>>> kfuncs in resolve_btfids logic to keep it simple
>>>>>>
>>>>>> also it's going to be already in pahole so if we want to make a fix in future
>>>>>> you need to change pahole, resolve_btfids and possibly also kernel
>>>>>
>>>>> I still don't understand why you guys want to add it to vmlinux BTF.
>>>>> The kernel has no use in this additional data.
>>>>> It already knows about all kfuncs.
>>>>> This extra memory is a waste of space from kernel pov.
>>>>> Unless I am missing something.
>>>>>
>>>>> imo this logic belongs in bpftool only.
>>>>> It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
>>>>>
>>>>
>>>> If the goal is to have bpftool detect all kfuncs, would having a BPF
>>>> kfunc iterator that bpftool could use to iterate over registered kfuncs
>>>> work perhaps?
>>>
>>> The kernel code ? Why ?
>>> bpftool can do the same thing as this patch. Iterate over set8 in vmlinux elf.
>>
>> Most distros don't have the vmlinux binary easily available; it needs to
>> be either downloaded as part of debuginfo packages or uncompressed from
>> vmlinuz.
> 
> would reading the /proc/kcore be an option? I'm under impression it's
> default for distros but I might be wrong
>

Good idea, I think it would be an option alright. From a user
perspective though can we always assume the BTF id sets of kfuncs always
match the set of available kfuncs? If the goal of this feature is to see
which kfuncs are available to be used, we'd need some form of active
participation by the kernel in producing the registered list I think.
But again, depends what the goal is here.

Alan

> jirka

