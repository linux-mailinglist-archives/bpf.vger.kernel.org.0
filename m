Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F042B457
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 06:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJMEvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 00:51:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6708 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232088AbhJMEvB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 00:51:01 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D3fVnn015866;
        Tue, 12 Oct 2021 21:48:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KbKs3WVIP7oVXqFlLcJFM74vg54DInNGBBLJ93mljCY=;
 b=pOyL//zJ9AMDiSEtBuwJGpQCBb7BaYlwlmP1ZN2QVFFP/95HixKWA8Q1mu0+SIGjzpew
 WvI3rXYIzK8J8HziN5g0SWyuamvmuYySMvG/8l6HYwEXnURZErs3W+rwGbfFsKLqT0/D
 iNcNOLKUTysQa8h7onem5FjKYTCJdELuR1g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bnqrygaer-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Oct 2021 21:48:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 12 Oct 2021 21:48:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUToOMv/ZaNhjd4RctgKWahBqwCdVep6NNaiBSzv+2FOj0zj693xFiyxIP30/J/WPbnZynbPRRrhKoIsUCHXMdvKS04Zsmjwl4F7vuhNyy2NN6nhEt2f90pvNaRLYCGRZwRYujlVaU2Begrz0ZV64D0cxH9YPuhCw+dvK+mFJa/LMugd0D5ICFmJHFXWcFq1QYufek5GPNPThvZDM0v6JJaHzicagSLV/o/grx1XLc+5vP6M2Wnd3pIljuh386TyzLu+oECuQdO2kqOjbZVBHXzYb1LMmoe3276PxZXBSckGgqOP/JOsBnpiiI4QSNUo9lwnpZ2siZYTWFVcNCfYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbKs3WVIP7oVXqFlLcJFM74vg54DInNGBBLJ93mljCY=;
 b=f6NUOM9cvSD7fRK+d7b/qKpY0YJWRrJzJ4yRczsU85ieZ4Oqd6GFvZN6UdImlrsGtxqmIXT7uGAgHBSmtvH+CgWwImRdvfz71HLMCuXjJgaB7L9i2dmOoBQ+7AE7q5PKLUMIKW6a+dhOpQV9keOCgy0vJ+5iDGfVEeUuZ+xa+72a9OYT0icfMFr33GYBzPsbRJQDo2hxQESerDFMm0GWw6pgAN7PDIVxE+dRq2mVVk4n33G1yNV2SGpcJicifCY+5qak3LisOO1VU+ykj1YN2bMjv8oThS2Hp/NgB2e6DF5t2OZk9ApfJECIh5zln//bQHEyvrKJfY+XRT1NvrXR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MWHPR15MB1325.namprd15.prod.outlook.com (2603:10b6:320:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:48:47 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:48:47 +0000
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
To:     Joanne Koong <joannekoong@fb.com>,
        Zvi Effron <zeffron@riotgames.com>
CC:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com> <87o87zji2a.fsf@toke.dk>
 <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk>
 <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
 <877deiif3q.fsf@toke.dk> <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
 <CAC1LvL3DxGWtk1vx3o=1XOj=M0m+KF3yT9z=gONWFXgnc_voiA@mail.gmail.com>
 <4f09d330-b694-e2c6-8ec9-388c088d1c34@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <e77470bd-0ea3-7d7b-8de9-20ad2ef2594b@fb.com>
Date:   Wed, 13 Oct 2021 06:48:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <4f09d330-b694-e2c6-8ec9-388c088d1c34@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:301:2::26) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21c8::113c] (2620:10d:c090:400::5:4b7) by MWHPR12CA0040.namprd12.prod.outlook.com (2603:10b6:301:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 04:48:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf4b42c6-6136-40b3-ed97-08d98e04be32
X-MS-TrafficTypeDiagnostic: MWHPR15MB1325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB13257FA583E809A313997882D7B79@MWHPR15MB1325.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkK6P/zUHaeqW5W3qQon/hhvZ+HDbmvhHdzTdjFjfFTj1+kEL6b5TbLoxQU/UWR2VyhbLwUfWBhfXalrl0eztjU4U336v7GxWU0KjlruzwC8guL94pQ/pjTI4oSOyCbXgqlZdF9ze6G3rLranJfNc5U6XSwVgffGpt8Ckz5AfCdkvAZDm/Z15NPc5ODO8TUlbld8d7i7BQdoFC+sulhvBMCeHLRDKHb7L5Igh64aAGhWBquNpwzDdOKGgO4xUiiRRmwDqKup3ToVJfVY1Zfh2Umi22W4vnsvLSSgi+R/deWC6rdSyTU9jw7jH0WLzDZSRHhISQJA+p7U9Z0ycMH7zGM3wGtJjzY67EA8Qp4b9H2al7zDMH+aLp7fCyzt5nGl8eOqWYJALmLsx3i21RTRDGQI0yAFm5xCutKnadzr+bzjKRib/SpHfYZ5WkOxBGQO+MPWC4Uoo9LFICtre6p7RUgOt0lG4Na/2JJDrLjz/STB6M+eYWO4XVw5/Ysdwo3Ls8z08xZe8JsxdpUX8FdrcD9dwrwnn7R+nkB9xNhmoTU8emXPsXVMhqWqCN7nnYJc+ke7ZyslkqXyr7Nu3MNnBmn9MTqQhTiGRUnfmOc3tiiDvi0F84ma4EXWOZ0fr4giCZEApDCz56wU5Ea529h1EAdAegcQ2kt6KPA+0wbMj+ryHwINUbFBlekiDVhxNr1Pmq75ghrMfBFqvoIDFRYkaWpyumgxoGoqamkMbcLl+jI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(36756003)(2616005)(66946007)(508600001)(53546011)(66556008)(38100700002)(8936002)(6666004)(8676002)(186003)(86362001)(6486002)(52116002)(5660300002)(66476007)(31686004)(316002)(54906003)(110136005)(4744005)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXBZQXJUemR2RGt1TnYzSU5PelgwcGVXT3NnaDVjVlBrQjNzaEZJY0N3cGpv?=
 =?utf-8?B?SEJXelFhaWpOcS9xSTNaL3pRWFBRVzB2d1piY3hlUVZWMzNpMnM4clVTNmdM?=
 =?utf-8?B?WHJPRXV0eDdYN2NFYjd0NnRWc250SWx6NzQ5eFZ4eURDS2JyaXBCYmV3Q1lW?=
 =?utf-8?B?VEZmTmZ4Y3YweXNEN1lpNkkydXJmSTFNbUNyOTc1VVJCNlVIUjMveWxBSy9l?=
 =?utf-8?B?QVdiN25DZUdkZWhvc0V1Q0VWQVEwT0dhY3JldUJMYTB1YkZvcUZ0ZjBFNmV0?=
 =?utf-8?B?OTdWNzJrWGo4QmZGN1I2alhGZzlDTUF6SDBHMDcxbStIdzZNNEE4Zm4yVnN3?=
 =?utf-8?B?MjQxYlFsc0tBSjMwSllENU5UdDZsbDhtTnhWTzhPZUpZZENmbGQ4NFlEWkNX?=
 =?utf-8?B?OFNVdjlHRUhYcWRHc2tGMzFCZzNlNkpyUmEvbUJTZzZtYkJ5TzNnNkxxTTZy?=
 =?utf-8?B?OGNPMy9BSks1QnZiZTIxamYyVjhGeXczTkZRb252Z1NKeXNsMk1MUGl4bXJO?=
 =?utf-8?B?WDdpSHdhTWFaSVpSUG1PMWh3SEk1LzdSMFlLQWRTNFgxbitQUUxaQlV1am9P?=
 =?utf-8?B?aXZ1VkdDeHJuNU82eVpjbDB3NWRLWjdNYUoybDlIcWlXSGMxd1dJeGQyS1Nh?=
 =?utf-8?B?dnFlaHdvekt3QWNrZStMb3N1NjhXOTY1KzhGY2RsTDFkUXJqV0FEUFlVM2ZE?=
 =?utf-8?B?QjRDNXJ4MEV2ZDVCVzBZY2lpaEFRSE1aQ1lLVjdaaVQvZVltRmVnMDVkMk5a?=
 =?utf-8?B?Q2ptMXB6R3g3TTE3ZXZLUlg5SkcycXkyQkFPckVoT3RhbnF3OEJNRnZMcDdY?=
 =?utf-8?B?UzhZZDdvWXpTbldvekFtRkZ1SFBmeWtEaldNdmV2RXljQlpEcjloM3o0NDRz?=
 =?utf-8?B?aVpjbFhJQzI2SG0vTXV5YzBPOWNINEpNQUx4cEYvZHk4c1pEVWlaTTdFREpY?=
 =?utf-8?B?R25oV1dGNFRUNWYyZ1pKaytFUVVqeXppSG04RDVRUThUaUJGTm5oeXBWNmQr?=
 =?utf-8?B?ZG5rcFhzemlVQ3M2dmxWZ1pBY2ZHQkt2c3JyKytwZEg4SHhrSG5nTkd5UlQ2?=
 =?utf-8?B?T0lZb3ZocmFDR2F6TEtybyt5dTIreUxmNm1ZUEZkU3VBc3NERjYzelZDbWtK?=
 =?utf-8?B?ZGMrUXRxTXdVQXp2NXhaUDV4QmI2Tm5YZGZvRERFWm5nVGNLdFJJeEJSRGl5?=
 =?utf-8?B?alRZd2NLVnAyc0tOc2RIbFN4L1V4V3haaXlLUVl3TS9GV0dVaENYVmlubFpp?=
 =?utf-8?B?d3ZPTzhQV0VESU1TZUg5V2wyWHNsYWlML1RvRXh6YjZWQ3czTjRrV0UvUFky?=
 =?utf-8?B?aGxUUjBoeS9TQzlxWkJIT0xwNk1IdWdNeG9weXJMTXprZ294UTloUUNCcS8w?=
 =?utf-8?B?K29nMFpPRHEzZ3dHZURmUFdmUUNtQjBFaDlodmtFeFRCeUd6cTNmWUFDa3pa?=
 =?utf-8?B?MXk2N0Z0UVN5cWRMVUtLeGxFenJZS2kySUpYSjBUM29ibTBMakhweHJPMVZj?=
 =?utf-8?B?NVlmWmJtZ01INzg5NFgyRVlIQjM4RWcyc1pkTGdkTmMxWmh2dVdzQ3pHS2sv?=
 =?utf-8?B?dUlrWXQvbis0OWVuZTAybWM0UFBabmYyWklQV2tWaWlhaHA5Q1Q0YmJ1S1k5?=
 =?utf-8?B?Q1pCT2hVMUtHdlAvMHQrSEgreklFUWdqd25tb0dMSlBDL3BCSStCc2JPVkxK?=
 =?utf-8?B?V3p2bTMrSDZmbE8zQWU0ZFpoa2JjNGFtTjdSTGw4MEoxR0J3SStCZDNIMC9C?=
 =?utf-8?B?bmFMbCt3Ukk1b0RQSDJzcHU4VlZXaWtxSzJxRFpkNUtHaUEwR2lzWXlaMmlY?=
 =?utf-8?B?MzE2Z0hPZDJPVFovMzQ1QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4b42c6-6136-40b3-ed97-08d98e04be32
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 04:48:47.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+v503Xg1XTQ/CR5HVyTd4ID0x9z3YKPIz9dwfQU2Q5M/9IzUTz8EPBjuflmUQE1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1325
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: W9FBaPXJ-89ECL0fM4tYC9W1sRZ--rnz
X-Proofpoint-ORIG-GUID: W9FBaPXJ-89ECL0fM4tYC9W1sRZ--rnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_01,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=817 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/12/21 6:17 PM, Joanne Koong wrote:
> If the bitset data could reside in a global array in the bpf program, 
> then I
> agree - it seems like we could just make a helper function that takes in
> an ARG_PTR_TO_MEM where we pass the data in as a ptr, instead of needing
> a map.

The main advantage of helpers for bit ops is ease of implementation.
We can add set/test/clear_bit along with ffs fls and others
very quickly.
But programs that need to do atomic bit ops probably care
about performance, so non-inlined helper might be too slow.
Doing the same via new instructions will take a ton more time,
but the long term benefits of insns are worth considering.
