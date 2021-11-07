Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73144745B
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 18:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhKGRSl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 12:18:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231284AbhKGRSk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 12:18:40 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A79I32c004357;
        Sun, 7 Nov 2021 09:15:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WwixqsZzIyDLeGU5SY2YUNWOKRa0elsGYXVrnzAwJqE=;
 b=kt0ZiTR32OknVfM7wvXDZxrE4yVHj516SuiTcYPCjBG04uradyUrYEzOx0WWJ5t7mJpO
 /KGmQ5d9CZb6HbJ9baZr33as8xbKwFuXZ9yzlKQynn9ZLIb7q6v/XA4fsZd8gmKY4VAa
 mpMsfLSGh++w8XMM5ijqJPST7tdGLb6YZto= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c67uebrth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Nov 2021 09:15:46 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 09:15:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYgFRE8R5Jbp/AebEODq6RNXvljWMhSKF4VlnKd4WK86cmkz8jY2dc7W+WytQTOp+ew72TY4ztgvj93Vhjjxh2NUSJhL1RxP9naoQKe97lb5ItBY0ftqDmAcbAwGWC97XPgmXVw6wEaPnGI2DC/2weI0iWMtugzpjgkuLSBkidibD+mVpz8grA82C2fR7G0zvD9yzk0Z8m9r1tzmYDibK88MiWgDWJQLOlCRPR/MJQzPqwoT4MnibIzGc2WCGj9gWkDN892WCefRI6nxdAVLzgdkehIuzQhQTwFT+4JM5mRn10yv7/JeO2FOUa2NGxB1ocTFDcjx+m2Xe9wV5wxKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwixqsZzIyDLeGU5SY2YUNWOKRa0elsGYXVrnzAwJqE=;
 b=jMZBM5/g9snXIjiu8IrZ43/4B6stbYVrLjPHQcmyhqCs9j/Ipj0Hrb5XPHVXDqGQGq0PLz/Jg8ruuhWT4M+kjJiYDeHf7+XwH4up48H94x+qPy10o3RCsN0MTVdvWXRPOYAVSJ34nhYaNa67MW8F9CykyfOVmkVqh5636l8VsNQzF1lUKZoJ4srDaM3hQvsXaf7FKRVagjSJHRHJuY+9xl+3TYMmwXAE35o8W6dSOrEoHCGkapTjuRf1DYuMNsa6ykpatSCdnPJU9iY/d7c3i/3AozxO2aD2in3xkJVC40vFjcdfyrJ81mprexclVGA4FYU17fAvlUo9S99StciFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (20.183.239.55) by
 MWHPR15MB1326.namprd15.prod.outlook.com (10.175.4.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Sun, 7 Nov 2021 17:15:43 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6d87:d8f3:9863:9ceb]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6d87:d8f3:9863:9ceb%9]) with mapi id 15.20.4669.015; Sun, 7 Nov 2021
 17:15:43 +0000
Message-ID: <463e7e97-07c4-fc15-1b69-356c3faadb6d@fb.com>
Date:   Sun, 7 Nov 2021 09:15:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v4 bpf-next 0/9] Fix leaks in libbpf and selftests
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211107165521.9240-1-andrii@kernel.org>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20211107165521.9240-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:300:c0::29) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:3b66) by MWHPR08CA0055.namprd08.prod.outlook.com (2603:10b6:300:c0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Sun, 7 Nov 2021 17:15:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dfba12a-3931-4e93-bbf8-08d9a2123ab0
X-MS-TrafficTypeDiagnostic: MWHPR15MB1326:
X-Microsoft-Antispam-PRVS: <MWHPR15MB132691330B1C5EF04FE232ACD7909@MWHPR15MB1326.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11S5ibiAUp/ENjRM5h9ek3pj9MR257lJWKqfFDfp6TZrQD8/XRyeO03StPDqwTNiYWgMHXmABbGLnDBA5BZoWeQZ2fzTXzLEHq7xFV5LcYsZzWMdPWleVtKTCk0iQmKvnZ64t55v8A6qsRDT2Cic3VodOYy1152zUjBzCuGj3fAK3re7rc6qls1DPdj6nxgbg12pxQrgEGztmP3Vflcud62iNbrSSAv8DW9VZBlYkcB4pji7Gr3BVVRq76LB7l089NJDSPAPK4c3iIrBv6BTQb23BhyBeFlC/SNuRe6e+8KW2AfDhKAMQfbjmVjhbAlhscuuaKkVAAPe/DAxcRlNRCzpm0oEwd+P5AVle30G4PSU1sHAlvdUZ+9GNQgTwHgczKkUqSfYNPXe6vzuNgn06sLCiXzZqzwUOG+oSye5uYrKg3i460rZ/J7A2r69ujRm/Q9SoE61mD4LemngGphLAImsojccKUfviBc4pWnun4TRyZkBIjpVG9KSslwX4GzsYk61J/L0XrERKwc9Xk+sNGuftclFQ/Dud8w+UCvu7YPGhZFrVvvhx10Hp+ogmlbEO5r651UnDcq9oXpbcHK2Tl/xV3cQJm1Dc5BAhjPRwpikWJZzar2bn7l1lxbO7oQUdhBlmciEeeOhpmNnphsKe1CFxbYigquN/V/U7moM4411aUscP4Wzdg9i2QcELd1VBhv+llmfV/fzBUUHu1mLSbGAqL09Zakt9TkUJsuYuYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(186003)(52116002)(6486002)(36756003)(8936002)(5660300002)(38100700002)(86362001)(4326008)(8676002)(316002)(508600001)(66556008)(66476007)(4744005)(2906002)(2616005)(31696002)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hxYkVmTnFMWXdLZFh5V0J3aGF6K1dBbFJwdFRrSmxxdHA4bzFJOWJWcTM1?=
 =?utf-8?B?c01iYkswbDFXcW1LdkVXR3pTemx6WGxEbUU4bEdNdThCUnBDTnhaWXRpM2NL?=
 =?utf-8?B?TEV2N283aGJLUmRiNWYzbmlRZ3JEV3ROTUZWa2dqMndmNmJucmVqNUxaczZp?=
 =?utf-8?B?clNMWG5jU1hRamdPUlZTbDcyYThoQWRtMTJ2NjdyamRoWnVkTkNRMjZiTkRK?=
 =?utf-8?B?S2hnZGhiSkFyUUtLNXZPbFZ6RFpOWGF6c0o2cnQrQjl5MmtOamVQM1VKTk9a?=
 =?utf-8?B?d0JoT1dzQ3BCUFdsUkdxWm5EVFRsdnNsMENoRjBDZ2hlcTBUV0FQTXBGUUx5?=
 =?utf-8?B?a3doUjNxOFFCY1UrS2pyNllMYjZZSEIyaitTN1RWUVZCRE5OeGdvUFNhMGZH?=
 =?utf-8?B?MVVBWk5UYWZBbXlQMGI1aFJoRHV0WTcybEttMVUvRU8yWEVrb2k2ZGVERVRD?=
 =?utf-8?B?ZFBWZm83YXlZNjJzVjRINEJRNXRuZzcvb2tnNkNUdWdEaDZhMHJBV2dkaHhZ?=
 =?utf-8?B?RmtMd0gxYlExb1BXWjRNWGw3NWx4Mnd1bVZCT1Bjd2IveUVWVGhWRFFwZzZz?=
 =?utf-8?B?Y1hIMFNhdWFXa1ZRcnFmUXltVFFZTU4xQTlZR01ZbU1JaFZ1Z3VPVkF4Z1F3?=
 =?utf-8?B?bENvaldVSTF3cWdkOTRwRDdWUnpWV25qN2gwVXJTS2xHK3ZsaFFTT1FiTUxG?=
 =?utf-8?B?T1ZFYjcwMDh5UXZ2ZDI0Vno4TXlkVWpnTWpJMW5XaFg0MWJMczRBZXBWYTdU?=
 =?utf-8?B?UW9DM2V6LzhZQVVXZks1azJmdExJNDBQd0tkVi9NbmpMWGptL1hlV1ZjcEd0?=
 =?utf-8?B?NmU1MGIvYnloK1RYRVJyMllvd3lqQmlEVG5BT2MwUmdnRkdNazQ0d1FISXRh?=
 =?utf-8?B?aHVIVWJHckl5em5Yd2docDg5NkErN3h4WjN5R1hVZ2MyMFUrS01OYUtuVEJr?=
 =?utf-8?B?Wjc3eHNRazFnUXlKakcwMlFpanlqd1BLckhFdHhuYnNHSE5wcTVWaVBJVERa?=
 =?utf-8?B?c2F1TEFlUXFQWVJDazY3VjYyK3ZUWTFBa0VBYjQwbWx3bmRyZjhKK1hsV2Qx?=
 =?utf-8?B?VHVicGNlRTVHeWFTNUpJT0FaU2tVSmhXNi9wSWpRSjF4dVlGa3Y3RHYvYkpR?=
 =?utf-8?B?Zmx0TzM3dTNEVjRJTUdEV0hsUTNZWVduY3dkQmZpdnNWNUVVdzJOYXhjWnR5?=
 =?utf-8?B?bGN2d2xGRVNLWXVxL3BlOXpMcnlNRjVBSGJ3dTlrdFpxbm1JRDh4ZFJ0QmNu?=
 =?utf-8?B?bXdJeDZPald1M0hHaDdmalpOclFQNjJlemZDeUtORW1hUlVuUStybVlLTFVV?=
 =?utf-8?B?eHMvaU5OK01Qa2Rpb1VTdkJvVVBXcEFjS2ZBN0NpWUpQb3pSV09CdmlaUHBN?=
 =?utf-8?B?b1h1YVpPUXRBWUFjU2V0NmFPM3lWVWRtdzBNczJqNVVLc1czQ2l1NjVqVFg5?=
 =?utf-8?B?SGNEVG5Lbm1BdDVSZ1hBNjlOOWhXK09DZXFtZHc0TXNwUGlOZWRuU2xoTkQr?=
 =?utf-8?B?eXBoYXF4OStBMVh1eXJTb0ZQVFBFVVNic0xOVEVqeDFqdHd0Y3dzRm5nc1dy?=
 =?utf-8?B?NndZSWJNME40UGpReU5jRHI5OTRnTUJNTEI0V2FBTXY4TkUxMFdBMldXSlN4?=
 =?utf-8?B?cXlmUm1WSENrUmVLNWFWdnhrTEpaSHIzZzFqV1hseHNNek95TnlsSnkyVDFo?=
 =?utf-8?B?ME9mUTU0WjBoSXdkZHNiK1dYaFlFOVlWMUx2dEx1dHhuRXRnWUJ0dTluM0Z2?=
 =?utf-8?B?clhpTThiY2k1TnVKUzgxeVF2WnB5QVRaSUN5Z1QvM09zalRMNERyNmJEOXpV?=
 =?utf-8?B?OUR5Mm4veVpwMjh3MXo4MTNnZGMwdEtxTUlRbUErYktYRlFBS3lWaUx0NGdJ?=
 =?utf-8?B?aFZaZ2F5dGNHSGFLRm9nRHVlRzdxTmd1ZE5rR0FHSE41TGM1VWJweFpHZTZN?=
 =?utf-8?B?cHVhYWduY0ZKd2p2R0w4dzk0dkJGKzVIMjhmUUVKUVhNMGp0OGhIOW4ybERs?=
 =?utf-8?B?WmZ1V2pxU0RPUmdEZDhVZzVIaWhPVFphRDkwaWRpNjNiVkdPZnEvODVZQ1pk?=
 =?utf-8?B?Uld6K1JDSFIvOE9hbHRQSXRlMGpENHU5aDRCUUlrOFhQZ3ErT1Rsa3c4NStC?=
 =?utf-8?Q?CICqVx+XO8YsGAiQivadCR9D9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfba12a-3931-4e93-bbf8-08d9a2123ab0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2021 17:15:42.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+Qf6l/Rs43Q2212PCdHVKGAo1HAQkzN7ONgPTpzRLsqYu00aq5GGTgofnvRuUN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1326
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: dQfG_n8AQOLt_DFZWg6NxNI-HInJQc0l
X-Proofpoint-ORIG-GUID: dQfG_n8AQOLt_DFZWg6NxNI-HInJQc0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_09,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=889 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/7/21 8:55 AM, Andrii Nakryiko wrote:
> Fix all the memory leaks reported by ASAN. All but one are just improper
> resource clean up in selftests. But one memory leak was discovered in libbpf,
> leaving inner map's name leaked.
> 
> First patch fixes selftests' Makefile by passing through SAN_CFLAGS to linker.
> Without that compiling with SAN_CFLAGS=-fsanitize=address kept failing.
> 
> Running selftests under ASAN in BPF CI is the next step, we just need to make
> sure all the necessary libraries (libasan and liblsan) are installed on the
> host and inside the VM. Would be great to get some help with that, but for now
> make sure that test_progs run is clean from leak sanitizer errors.

Applied. Thanks
