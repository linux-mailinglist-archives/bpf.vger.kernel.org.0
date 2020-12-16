Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9162DBBBC
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 07:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgLPGyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 01:54:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgLPGyw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 01:54:52 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG6m2rS010364;
        Tue, 15 Dec 2020 22:53:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qyOlOQRUTd23lr2qx2de4Lb9gG8WV+r7DbvDRJuz8UU=;
 b=E2uAlP/pQfszVDqLKn4/+E1EptwN7EQmPmAaUcEclauCGgSNn2/B+uXdSM7BsxsSbx55
 7ywJw2pTSUGX1nW81znIgU4Aaq3Zu0CF7TrEeFIo2W5pPakmw5rFXTeAaQcgp+fO3oZs
 n09AV6HWWAAudEraWdPt/PS0lQcCz/MazTY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35descqq48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Dec 2020 22:53:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 22:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwQosIYCTF1OnywXKQKdIw6z1hFXH4AmJtGBWto3u4w2/TH2VW2r95gtyYJqiO3hi9cOFb795llneYJv+Bdn5tv05KRO1T3JspxJUHptnCmjRE+zzpHsMohyMuKH1G5TAfwQ1ResaCtbtSLwx0u73v3hkMR6GidGnpFSWfjQAb43ExgHr2fPljV6IlW7IHfSbUbPSXmKadJg8E0ngpEVDaIoAWEHs5SPb8P8yEPsvuzkaHjNTP9iG3eNhK8y606t8gSue2X49VqkPsasIqqS0iXJXMKixokSiIJFbOIPwOLIq2TfEoQbZEGGBC46OOsgG6e6OgYj+N6eB1WuFBNIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyOlOQRUTd23lr2qx2de4Lb9gG8WV+r7DbvDRJuz8UU=;
 b=h7gf1RjU5Y07nwRypVf0lh1QVFoZG/wCqeo3Rba9OaCRJR1supHhj+kw/VpVyi+x/ehMOKYJAssySwCNd6ESYbrx/WZY8/K6jzQDSQvsDgK8euI5KfuUqUGvGQR3N98DjmDjfPlflXA3jwPGDS5G/V5XiNMHAfmZe4Uy+wVxf9iUJJyfEqfTMl2EaEcvaOSwWCWX58tdUUK8ghcIqF7zc2lpNBhH9DLjmIHjqDP/4oHDF99rxOrmzP4uwlxfLTyoMQxa2hFDvNnlvVBygmgL+AG6ac+2k7YTkm8BkDO1/POn3bBN/Xtlh0R08fvwpccyL6np1dv6dVW8vtAJsGBJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyOlOQRUTd23lr2qx2de4Lb9gG8WV+r7DbvDRJuz8UU=;
 b=DEvyv+EB/Taiui/Q1wnywRSv9+2/2cQzRreximYK4RsxbuakpugRAhJ7hZoqFCl+wd2cTeHwKF4wQIHTNGq6xfwlIKawanRWKBNWwGoUFsr4cRDtk5IAB/xj0ljKP4n+bpsz3uvdGqQCJzXmeNLfAnZiXkjkv+xTz3j6xamBLoc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 06:53:54 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 06:53:54 +0000
Subject: Re: [PATCH bpf-next v5 09/11] bpf: Add bitwise atomic instructions
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20201215121816.1048557-1-jackmanb@google.com>
 <20201215121816.1048557-11-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b1a991a8-4254-285c-d72e-029de284f50c@fb.com>
Date:   Tue, 15 Dec 2020 22:53:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201215121816.1048557-11-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:9412]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:9412) by SJ0PR13CA0083.namprd13.prod.outlook.com (2603:10b6:a03:2c4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Wed, 16 Dec 2020 06:53:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13dea035-6956-4e33-7323-08d8a18f5a78
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28226CFC940639A2E0963A7ED3C50@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxv9g67siyxzYs2HKnBgBLsTbVk6hcf5NjleFbg3hBBsyX+RIqcc2GqM0a+Twx4zqGx3zM9NKiY4BzktHTzqQd7v03jdNgXpa7RBcvery6s8BTh41DFSYaZ+DRQw/yD+DqzDpI+K1J0crLOWoeLtGMOIpLg3onsV8d+ZNu1+T1BYQzI2Iixhfx6gqfu1WIaydS0+eGq7ezuFf23I89AGZZ+SW9AV2LtKppj6AsV/3OqTKyPfj5oadhmeOzcpFDQWmjh/E7/UT93lgRWiiLd3XeLT9jOlYnKTO7hmPz9e2hzddjELv+bQ/8OU0U5Zinv0PTdYC83i9uzqz+M7D6I4CguDVeGrgbUBXPolr1hcPjbX5azx0hJgqf9lOubvH3JngfsKwxrq0cguVTi9LNhpqdBZtxiwK2a8bPVuVygjzJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(136003)(396003)(376002)(4326008)(478600001)(52116002)(53546011)(186003)(2616005)(66946007)(8936002)(6486002)(66556008)(66476007)(36756003)(54906003)(31686004)(4744005)(16526019)(2906002)(86362001)(31696002)(316002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RnJONXczVFVuZkJBem82bW1hSGxPV2ZFckwybFNKT1hJU3ZGekxoMjJXVTFN?=
 =?utf-8?B?T0grdE82ampnODBzdDhhVkdsTUVuMlBqMzArR3dPTy9LdUVISGw4T3J3V1g0?=
 =?utf-8?B?QUNBd3FFaXphZHF2cEgrNk04Wm5kb0ZpUngzenFacTZDbHVPMnpNSk9DTkha?=
 =?utf-8?B?N2t1RmFnalIvK3FYOWpEYmVGall3bkQxUVRwcEhaSE11SUJhd2gyd2tGOXdY?=
 =?utf-8?B?akdmUzI5ODRadDhBYTlEUis3OGRJdFp5T2R4d2dIUzAwZUxGK041dXFQb0dp?=
 =?utf-8?B?d2RleW5EWWk5THQrdS92L2FtNDRKVS9leFJ6UVpreXZzNng4WlBUby9HWndj?=
 =?utf-8?B?K0dQMGZsaGZna3YySzZDYnpqUXMwQVNUMzlXR3ROUVUvekE1RG1zTjhRc2sy?=
 =?utf-8?B?cEhqaUVLUkNpQmZzS0xLd2syMDFMcmEvM1cwcWR1N1BCVzJjTjRXbUVINEJV?=
 =?utf-8?B?MlFreW4xZ3RpeU9TTzVmNW1MYlRrK1k1a2M2SFpnOGpQSVp5dnRIcjcrNWtk?=
 =?utf-8?B?S2hWVXdIeG5qbWNGY1ZGL1BXb3ZrSDJXOWRRODk4YXdXcm9MSEYxeDBVZWRT?=
 =?utf-8?B?akV6WEJ3VEtnUzVoMExPOXN4Z0NNalpLVWpwVm1RbEp5NkxXcWE2TlBnV1M3?=
 =?utf-8?B?Z2twdkZOYTAwUC9GdjEzZXhxT0hqUmJBVDVmVmYyR3c2VWpNN1ZxaFkybG9w?=
 =?utf-8?B?SERDazNvUEVkcmxFb3VnaWZsb09Ydy9IMkpPRkwzVFZqeTJqNFdyb1R0Sitz?=
 =?utf-8?B?L1k5T21qZ1EzMGxtbXYraE9ncUlZdjRNOW9YVEd1MENmQXFaNGdsV2dqbEN3?=
 =?utf-8?B?dUJwU1BmbUMxbzdSOVUxMnM3WnpXRlNOTCsvRHUzWnRlQ1MzQjdOY285YTZp?=
 =?utf-8?B?d2ZYa1pZNWZNSW9rVXFBL1ZoWFdlSEdOQVZRZHNudVRWRU1pSk1ENUxUaHVz?=
 =?utf-8?B?Y0JGaHpaRDZTT0I2RjMvVFEvYlJGb1lNMUp2N1REdUViMVZBTSs2dDlkOHZB?=
 =?utf-8?B?Qkk2alBlZnFOWGU0VVpZWGpYSWdvaU1sUHBvVkovOGNnaFhPbUVpOVBVU3pN?=
 =?utf-8?B?OTlTbjNHTDhHR3BiT2tXVFpxdDZxNGhOYS82eDRKWVhmM0xkTGVLQzVBSGUy?=
 =?utf-8?B?MkNmeXordUlRTXNzMzJ2RHQ1ZkdxVmk4MDBtQW1aVW1xdksyVjAzSCtXS3lT?=
 =?utf-8?B?RCtZVGdvTnZWSUJVQ1doM2gzem9VdUszSXlZUzNjNnJvaWN3NEsrRmd1amxE?=
 =?utf-8?B?cDZnQU5rZENnWUlHTlRWYmx5WkZiaEJpZTNoUHpHS3JjdG9QRDQ3N1FZRU85?=
 =?utf-8?B?QWEyUGRyYlBmazY3S1pEK3R6SWZoek53aXNxMW0xcU9lK00rZ0NDSFBtTFIw?=
 =?utf-8?B?WkRVd2N3bUkvREE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 06:53:54.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dea035-6956-4e33-7323-08d8a18f5a78
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhakcaSEVCKLVq1y+Sfzhl9iZEnlasPh9w8qiWHqUWyR8NAtoS3d1sPA7ezKCs7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_02:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxlogscore=851 phishscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/20 4:18 AM, Brendan Jackman wrote:
> This adds instructions for
> 
> atomic[64]_[fetch_]and
> atomic[64]_[fetch_]or
> atomic[64]_[fetch_]xor
> 
> All these operations are isomorphic enough to implement with the same
> verifier, interpreter, and x86 JIT code, hence being a single commit.
> 
> The main interesting thing here is that x86 doesn't directly support
> the fetch_ version these operations, so we need to generate a CMPXCHG
> loop in the JIT. This requires the use of two temporary registers,
> IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
