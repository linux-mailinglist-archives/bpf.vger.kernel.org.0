Return-Path: <bpf+bounces-18596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2D81C7A9
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E974A1C24D6C
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DBAFBF5;
	Fri, 22 Dec 2023 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l2rwnNmf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KJMEBqKv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC68FBE4
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BM8n1UN029318;
	Fri, 22 Dec 2023 09:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fMOVq8QxbKHBNEx+dLOiw833nj2TxUGEFIEVu/W49MQ=;
 b=l2rwnNmfzkH9S84/Njk/KjPEFxaTdrArSr6Bbxt1kBon7HkV/xcLuZDhvnxmXOfIhmei
 fGJS7qqfeHO7545Z2lppdJdC0mPFjvmhYVJfoXwBhzrbm10onycvgIW2dJgHW18+yaGA
 dkEBT/7PFAe/+ZSObM/thqQuE6OlBvk9ejOuHX3qAxXCut/qvpbJkZHxBN0z3lZYHSjo
 TTHLxjIitzePvPi20LSjGIK7BEXbZcgSmTMYBL8ZAKKrkp458sEYTA4kDGIpoHRMNWc1
 +ZLXvEu5yOzLINAU0Y1pCYABIRFysQydutgLtBg8bapxCcciJVJAZyYYs1gv7cGBya4g /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p4dc1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 09:55:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BM83T2H019654;
	Fri, 22 Dec 2023 09:55:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bkeejk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 09:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDysPb8TIZsl8JUJCiXd/O1/pY80Zrj9T9CLMoMMsTh6gvDYrx1O4mi2yqIO2hGo4zivILjm8yTOV1jQLgKlMtIdz04/eTVnP8PKcEOtKrGquIml3pf3BlyqN54zWX1X7xv44cejkVhudRkuxk8cgLNJrBNz57fp3dlYzuerSbGyx5UhyaAiPJM/6Sta+BQnop19Sef+bGoi4s7A5FkbuQiIHLtgrDy7kNquY6GGT6UyOi+0FpG8uQfyKWvGKrArE6efh5uB6VbakPdDdVSVOYyEbiR0VLDlnk2PqVLt2GHn7MpgKgX1R296FNNq5qSm4h4z2mNYeaI6W0xhD+xz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMOVq8QxbKHBNEx+dLOiw833nj2TxUGEFIEVu/W49MQ=;
 b=kY5d+wM6d8APvPM0lGKWD9M+iQhNzL/H24wBhhmb1Sykm78jotNy3PiWb4MeTu8eS3DGcyVLGKYEL3UJUGNDlqRHZv7OkskRKXIfhybKeIHp+LTDFXcxXMOYAhNflRwcKZmB83rRvLwejrKGlFqa42PjKLGvaxmH/Z3UpMDYcQU5DQc0OsHTo+mYNk9rRLUZ/kCpENWbTgBjyqvXt/qVL4Oh1KCn+lmlsaIFEWpJ0vrJMo9b890zOvQ9ruHD1VGmxFlAJowWepQpGU/Jmzc0OtyZJ2fRSLKdx3bLarU3adLBNH7K93s1eUulHj6RgPiESD3nQU+4mDY06jGzR+x73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMOVq8QxbKHBNEx+dLOiw833nj2TxUGEFIEVu/W49MQ=;
 b=KJMEBqKvSkQJQTffv3EEuitxUAijW+X8lvKCkmycZEUDia6pbx75Du00V4K9Jp3BXBDPrOcu+6/PdRQ2rWKBtGAo/ep6ADrliqHE1q9GVdzdcUe1AFNVUyWOPQUd0GsGqKETSyRTbQ9C0sVQqHJHXbjdNjA2vtCzUQXdHry0FTM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 09:55:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 09:55:12 +0000
Message-ID: <64f6db18-ebd5-501b-2457-a8abe6187a0f@oracle.com>
Date: Fri, 22 Dec 2023 09:55:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQ+9PZvTc034oHa=7yQFPtyV=Yvjqef2+r97SyKFOgV=RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 335ab031-beb9-46f6-657f-08dc02d41733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Od8OWL5RqGdkv3TL7hRUsLrhXIpdXAfMSZeVcI8ZDrUSvaxyzWm7cfPO9VgLn8G54iBV6xaqBNk4Batc7VUkUxcRounUn8GhAU5a0janIoQpnVCj3mbhYlHHetL3ap9vFmaVaAHIMVSvpCgYICmpxP6/RfaGA3bRNbYlvT55DsETSK0VbYrbibflbIpc1hsziVQ/k6muzuGODj0C6/6UpQywU5iPVU6hr92VShUsIpj6OnDJcTDMq2PzzDDhyWAuVMEBQefX/oGB5pYQGa5FoaFxehMmnY7YXX0IpeyNd24jp3a1EowbgT3CMg+iKy+JT3A22VAnsJ0gMX0VIZVO48Aj0jI+nwzi9CyFVxAuNMW3n70KS1UfgTZxymnddtF811FPzVoye5u/dUme8VUUChTao+wLNl1iFXi4QH3V8/LfEhrZe7J3jVNLXcVJZWj3+mtNV31xS7PZ7cNFtIaGaEivymT7EcVGRNQ7Lk40MGeJM0/f3rAFT4QlTA8eWhsO1A85xWDfFwk2OkMMoKzDboI+qAjkGRw7wlRwLA64HCDWjNUHNOTZ3uxmlHZ0gkmvu3X17BQTzOjW4+5sS2QPEvfEDBSHNOq/oxT4dkG3fcKqopkBHWxrGyYhUGHfz6iw9xqyNvPI4iSmh0w4EFF/NA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(44832011)(83380400001)(31686004)(2616005)(6486002)(478600001)(8676002)(8936002)(4326008)(316002)(2906002)(5660300002)(6512007)(6916009)(54906003)(66476007)(66556008)(6666004)(66946007)(38100700002)(53546011)(31696002)(86362001)(36756003)(6506007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXU5MXpGRFhhOUpOODhaODRaMkFJekJqTTZFaCtYQ3ZiaXdVSVVBVENmWS9H?=
 =?utf-8?B?aGRlUkhyMU1rcUhIK2ZlSFhSeVhoT3FBV2MyKzRrNExPQncrRlVybmxhKzVl?=
 =?utf-8?B?c3ZxaFZBaXg5aHovSWpjZHdiZ1JGNm5aZi9EVFN2dDVib2k2R1BnYnFmby81?=
 =?utf-8?B?N0ZCYVlNYkk0VGM3bGxpOUFyMWF3ZDIrcmhuaURXTG01QW1VNEFpZGErK2Ey?=
 =?utf-8?B?ZVZyampxSHpLSXJORTZlcndvNWx1dmREak10SmMvVHdIZHVoM1pnYTJpdDhm?=
 =?utf-8?B?ZTlWazZ6Z05YUzd0bWtJS1pvMGxhOHVkV2JSajN6a2p4TDNoUk5RR25DN2Rh?=
 =?utf-8?B?aUtKcWdsOHFqRVJVQmJWMVo3c2N2Vzg3WjhwdmtlYm1CY1E2NGtIaXc2NW45?=
 =?utf-8?B?cnY4a29OQk9lNTR4b1Q4T2IyZk51L3FHb0N5bXVEV0JXS1Z2TzRJdzA5KzRo?=
 =?utf-8?B?bkdveGMyeDAwMWdSbU02RktoNTBJcEJwRGNJRXpWSkVSQkc0Mk1kNFR4SWpW?=
 =?utf-8?B?cFdwYVh5dFpzUmV3cHlGa3ZZN0hwN2wxeWVSK21tUk5XVXNBTTZvcFg4WTVF?=
 =?utf-8?B?RkdkZ3kxeFZ3QUpRV0RPUFg3K3A1TFplN3J6eUFmUkZLNFdjMW1oVEJ6OXdM?=
 =?utf-8?B?bndUK0toYlVQNTk5cERKdmFpYWxBdXNQdVJlbEttQ0NKU2RXUGxkZUM3bnhk?=
 =?utf-8?B?R1lBN2JOaWpJS2RkZCtWZFdNelBmRHl6Q2RPQXVCSW1yT0dCZy94blRyWUZD?=
 =?utf-8?B?K0J1VDNpblZnZE52SEhUblZVbzJKOXo4V01Sd3JyRHJHWXV3eXRTdzJDOWxQ?=
 =?utf-8?B?eUJqcS9pamd2UTlTMU9SdE9HSmN5eHZuMEJxbzIySzY5NlhIVzFIcGdqWWY2?=
 =?utf-8?B?bEkyWmNtTUpqOW5RTG5wZmxmSld0NzZsVnpjbUVYamR6cXZKcHBGS0txZVpD?=
 =?utf-8?B?NUpsSXVaRmQ2ZGNBOUs5V3lVV29hWnBVbitHZEh2VzJwN1JsRENFM0NVRkVt?=
 =?utf-8?B?NTZ2Qyt2eFVlaW43LzZFMGdBOHBBY2NjbUtwdmhDRG8yMndqS2dYOUxZdjVx?=
 =?utf-8?B?YU9EZGVmS0xIOTVZc0QvUVJrR3VRVXpoRklLQ0F0aHBKZ1FYRHBrMTZJMUtB?=
 =?utf-8?B?Z0FwUUR5TUoyOTZCYlgvT0EyOTBYbkNWWWlpSkFwZ1hkT0xZSjY4RVFlWDJr?=
 =?utf-8?B?MkxlaGZhVldSVm1GeUlCNDBacldPUFh3cUdxODVvSUdNVlpnQzhiMDJEL0U5?=
 =?utf-8?B?V1E4YUMyOUo1SHY1UjhSaGlpUjdNdWJ6eU4zZnJ6TXYvc1JWM2F2ZTFrMm1I?=
 =?utf-8?B?YkYxOHNYUjZ5ZGt2R2ZVS0pWUm5NWlYveTFkZ3lUYkozZFA2cG1XMzVZTEw0?=
 =?utf-8?B?Zm5Kck5iVCtSTHVUQVhsV3RCVi9YRFBBc1h5L3Z2QWJ1SEZjeWwya2FjT1RF?=
 =?utf-8?B?M3diYlk3MkIrYXY2VmFld3dRdTB5d1ZRcW1tNldRalNmaU94ZzV2YzMvNXpR?=
 =?utf-8?B?ZFV5ZTVodGtUZXEyUkFhQTRpRFFJRDhxVFZ3b2w4Wld6S3RxMDRjb3pnNFA4?=
 =?utf-8?B?RWRnMXhpWnh0enp6NUhUSm1iVU81Q082N29PcjUzQ3V1WUdVN2tDa0J4YUty?=
 =?utf-8?B?R25FM3cvWEJ4MlRPQ2IzaEVQd21KM0VsR3U5dVlwQlRSTlhwb243anhQVzJx?=
 =?utf-8?B?and2Y0R6WVhNWEpTNTBWc1FmQ3Q4U2xJaTNpbkVVMlpEQlYxMjUyL2pvL0Fj?=
 =?utf-8?B?bXVGaXFzMkYydmQvVmg2elVtMG5ma1VNaEVBazVaQ3I3ajZEWHl5YkNGb1o0?=
 =?utf-8?B?cEZSeXNNL1hvQ29ERmlrZ2xVY3kyZ0w5TkoyNzZyT21kcnBKVlNoZWFSa3ZN?=
 =?utf-8?B?dVVNQThZSnAvd1Q2ZVFVZ2FaMWtpb3JjRmh3SnMrRlFhaFhxcmp4R0dDWDJL?=
 =?utf-8?B?LzBlRjh6QXNtVDJtdEpkME9QUTV2NWVVVVQ0TitMUyt3QmNyRGhLZ0VWY09R?=
 =?utf-8?B?Y3lTSks4V3hLbEx5N0VZUDV5K3BmaEhuOURESDF1YTBnRS9SYVQrWFVYZVh0?=
 =?utf-8?B?cmZNa1R0Sy84dVJ4eXZyZFdlQXY0Mk96N2JNWkdPWHlrUy90RExsd2J1ako4?=
 =?utf-8?B?VnoxYUZVNjgvMHlnZVlMYUxVWmlBWXBiT2FLV3gvRlVGS0ptYkdMaDJic2tV?=
 =?utf-8?Q?4CdSJNqYbU7bjPbWVQVAdCI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OvD3fiDd3GEd5b3XE9q+DnBksdquoIvHuKv7GJLoTp+nevs2bjjbQsfGm78gao3IVcw3n+DC1CACHsCBm8aiaVW6gFaQ6u3UFBfQlo1uK33qzXMohbLZMYmNksVMwYhxkmaoQhSe3A8iwcwNfQwAoRtQSUTO5TFrxsZE09Jup3nFdhsMbpvsanRbwmz7UxRj3dhPhJ2y3uZO7sTGKXsi/m846fGS+QjVggNqGKP5JunmxahqxJWn457EOqQ0NGhMvJL1PcwuZ4+aiRC2xy0YMCEBh+s7bMdwu8aO/szRFIKnI/gOIRHp95qYEvWnx7GubP6PR1P2iDKHTmgIEIkWxMswgX6K07WNUmGaFufiX0xrUeC6u4O4rzWmjRbmCxSinzXxrXY71TAY2kN6fY2Y6mfWWTgivuDZ7YbbzXAWpCJlqclgaAzjCyRV0WksuYBf2BPF+lSyKy3yNUx6/twMwu7qXqNhbX1CrhbOHCAvpNMXgAM/aU4n21kJ7vMD2QhCp8Xo9bEDJDvz8C/ECOk+XLmLzvym2U+d47ooLhB/czyqWh/bJWBSi22lGRovdtc/p/Ov2ExLu3gFH76xCSKdEFZ9tiEGrRQ+s2uuTeH0PWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335ab031-beb9-46f6-657f-08dc02d41733
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 09:55:12.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuGjjREZKOTnNqh5T7mITbb6JTszhF9gnV3Lf7SzvddNRAO16NHQ09hwEAutyGrkRlh2c0UsFC4MdiPODktKEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_05,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220070
X-Proofpoint-GUID: oUj0-3DZoMcqh9V-iFooM3N4nbN2ZEL-
X-Proofpoint-ORIG-GUID: oUj0-3DZoMcqh9V-iFooM3N4nbN2ZEL-

On 21/12/2023 18:07, Alexei Starovoitov wrote:
> On Thu, Dec 21, 2023 at 9:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 21/12/2023 17:05, Alexei Starovoitov wrote:
>>> On Thu, Dec 21, 2023 at 12:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>> you need to pick up only 'BTF_ID(func, ...)' IDs that belongs to SET8 lists,
>>>> which are bounded by __BTF_ID__set8__<name> symbols, which also provide size
>>>
>>> +1
>>>
>>>>>
>>>>> Maybe we need a codemod from:
>>>>>
>>>>>         BTF_ID(func, ...
>>>>>
>>>>> to:
>>>>>
>>>>>         BTF_ID(kfunc, ...
>>>>
>>>> I think it's better to keep just 'func' and not to do anything special for
>>>> kfuncs in resolve_btfids logic to keep it simple
>>>>
>>>> also it's going to be already in pahole so if we want to make a fix in future
>>>> you need to change pahole, resolve_btfids and possibly also kernel
>>>
>>> I still don't understand why you guys want to add it to vmlinux BTF.
>>> The kernel has no use in this additional data.
>>> It already knows about all kfuncs.
>>> This extra memory is a waste of space from kernel pov.
>>> Unless I am missing something.
>>>
>>> imo this logic belongs in bpftool only.
>>> It can dump vmlinux BTF and emit __ksym protos into vmlinux.h
>>>
>>
>> If the goal is to have bpftool detect all kfuncs, would having a BPF
>> kfunc iterator that bpftool could use to iterate over registered kfuncs
>> work perhaps?
> 
> The kernel code ? Why ?
> bpftool can do the same thing as this patch. Iterate over set8 in vmlinux elf.

Most distros don't have the vmlinux binary easily available; it needs to
be either downloaded as part of debuginfo packages or uncompressed from
vmlinuz.

