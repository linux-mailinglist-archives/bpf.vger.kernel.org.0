Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F52F28E2
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 08:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbhALH0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 02:26:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16760 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731300AbhALH0v (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 02:26:51 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C7EQUu001772;
        Mon, 11 Jan 2021 23:25:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fsJw6Ew46zT58UzMJeIKmCFYNHuIrWZgLVrFMq4ONPs=;
 b=BI0CVvx47FW2lBAIxt4/+p+igm5HRZLd/HRh6Ky+4hfSdCGrBFYF8BzBf674FJWYLXmJ
 9BRpZxx3cLtufQyZ/syVzToTq9I/PXEHZ8Oc5SLW1gY3lHh8oerOLgAGjnMvX062wWB4
 kEAN/JJurmutYqWAc9SvPZc4eZYu4iYEbVw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3613ytgpja-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 23:25:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 23:25:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l67/XlrcOtbtuMaFGOeEarFU5SbmDYmNOYmsbJHUGufrMnTYiA45oeZoWHNQgtSeiiZBSenJ8B8sEiV4ssVoq7PDVYQSgX1rMsNVuW3exCGcaUHgAeP83202o9s3tiowl2FdB/o1WD2XAZkK1HhnCv9sH7WvMwABDS1IMa94HC+Z+G4flzYAQf8uJoEkZykOA79nGzjqc2JSMtPhKqhJSaYl+XWr8GS1FA88s0bUCd5EmmZBKtDzAVAqY9P3h6KEIDowrMMEIT110Sj6wpG8lOIBTKCOD3eI9CzDqr357XW5Fy0tMKH1SVTTw33PxhfZ02F/qGJR0DhCZKjbbeHGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsJw6Ew46zT58UzMJeIKmCFYNHuIrWZgLVrFMq4ONPs=;
 b=SXoqbs7NBMTg3vRPL22c0rbzwxFjCXyjzfEzL+aGQkmMaHfoDJzqRMQbTfp5IrU0hvr3iG0z6Nkok6gwSfE+/m4hXQimrYkfS9vV+DLKuMwwve6zMnKiDHYOci9h5O34tBtUwgZHs5zB5MQ71wDkQ/UBUatheSOz1PdmvvpzS8tLMo+kwVojdh8pnkR0kg2Y64JbYYEbKF2JtG/yPksoqsG+MP79r12BkfboKhKOvU6VBSLMGLrl1H9BTG5GsGL1CBIRPSziCqe2EJDXDDlO56Ib5PNLILZ8mmjIqO8r5RQUkMY1azcSnBFcbxxWuREbdvg9tWmzUXohzxSX2BuD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsJw6Ew46zT58UzMJeIKmCFYNHuIrWZgLVrFMq4ONPs=;
 b=Hi7YcSoKi6c8kiMbWRxLibJOcmm0AxSusxS/lcdfA1e8iw2DNexMKIoTT1Xduno+BpvmWPVCQxc+WyMaHZb342UQFusXHq9DKQw60Yzm/zmgUhYkDUsmPbOGQkZ/Qkbt1T6M8hwd4JJpAshvcBJjWDbuJTN0OdrcEzrmXZb4Jok=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3569.namprd15.prod.outlook.com (2603:10b6:a03:1ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 07:25:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 07:25:52 +0000
Subject: Re: [PATCH bpf v2 2/3] bpf: local storage helpers should check
 nullness of owner ptr passed
To:     KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
CC:     Gilad Reti <gilad.reti@gmail.com>, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210111212340.86393-1-kpsingh@kernel.org>
 <20210111212340.86393-3-kpsingh@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f4e35851-7273-3b9f-3b11-e2e7ae05f67c@fb.com>
Date:   Mon, 11 Jan 2021 23:25:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <20210111212340.86393-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4443]
X-ClientProxiedBy: MWHPR10CA0069.namprd10.prod.outlook.com
 (2603:10b6:300:2c::31) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::190b] (2620:10d:c090:400::5:4443) by MWHPR10CA0069.namprd10.prod.outlook.com (2603:10b6:300:2c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 12 Jan 2021 07:25:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99ad12b1-a58a-4505-6ff1-08d8b6cb4aa7
X-MS-TrafficTypeDiagnostic: BY5PR15MB3569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3569BDDAF68DAB3AEBD760B4D3AA0@BY5PR15MB3569.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNYj+K/HjYasVKcbbTQJvFtWpFTVqG2eonlDGKO8/3vTgkfv0SP+AdwdlST6YMDbV4E5avz8x+jXxiyABEGj7DblShWWdrbhpEmeeLg6GpLWkpOJEy/9dcNargTrpwwAt7PwZAEB/9sIKzegD5lC0uJSZPME8uT8u5XrZYWtLrzS8DXCFqGi1dgcVqpL+y1bXN91QMsUtxDEQ8lX4InO7T5To7sImSK/xn9n1A7vGCMhDv6uGSYVmtKBsNdV9Uy+QaJ4O8g4C9lJ0uD3kDtpE4dLXpQSqAtU20IdVG6Ka3EXYlUb8I0S9mUrfX+Lz0krzaB1S9NJ9b10bmtc2JhPxFhD92/AbYKGvJRybSn5l/tlvek/qvO6rWTDSTtdAu/tOPegzij8fxx5CTmYISqB+ISTCIGbvTjI6qyKV0CB+rMCgxGFfjoHpVPN+Z486xDSGA0o5kfvYFXbNBsU8PxIBpG/Qrg6Y0fPrtcyXDSUU6fv+syVZCv0XSEAbjrWzJpeNnMJ/kbtbn1Z7ontMi5XSubNFZgVU8jFGCjBwfCdSqDkGmixx2fVAd/UhiG8qqqa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(376002)(366004)(8676002)(66556008)(4326008)(66476007)(86362001)(31696002)(478600001)(54906003)(52116002)(53546011)(31686004)(66946007)(186003)(6486002)(5660300002)(2906002)(36756003)(2616005)(316002)(966005)(6666004)(16526019)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y09jdVBGci9tbVRzWGlyRjJRUFo2TkxjTjhZeldWVm1EOE1OdnROeE1BNW5j?=
 =?utf-8?B?N2FqYVc3T05Ec3FmeERuUjBneGM0cUl1NnRIdC9vMWt2UDZ2ODJFTldBR1ZL?=
 =?utf-8?B?VFBUbkxENlVWRTNjNnh2VTk0Zlk3aHd5UC9FQy90YlZ6WG1ibmcrOHY3MFJD?=
 =?utf-8?B?SDNxNXVMeVJhNjk1N2t4ZlZKVXlHSjVML01TT2JjT1Y0dXdOZERTV0kxakdC?=
 =?utf-8?B?WWpXZ3I5WU5nQnh2NE00N2dVUHdGVUJaOFdFUnl6K2hTbXp2dTdTSTFHa1lD?=
 =?utf-8?B?QXV1NGQwRnhOdk5mbkdNLytRaE5RYXVXbVpMQmxRQVBocU1zaHV0Yzhab1p5?=
 =?utf-8?B?ejQrbEt0QUtCTEZZa3Bqb1FRbnFFU0JubnRUT3hxK0VJUHBoR0VjYUhySDA3?=
 =?utf-8?B?NjRHMEdIbWoyait4OVYxRTQwUGlid0V1NWMyY1RuMFBOTUJuOVlGSDdOZkZQ?=
 =?utf-8?B?ekd1L1c3Qk5ycDJNMDRUWjZHdWZSbjlEMWVSZFloTEpua0dyVFI0MUJ5bE9D?=
 =?utf-8?B?NW1Ocld3SlV5RWVncjRCR25RYkJpcEcyeUs3akhvVEZpUEJ6U1BIZUk3RmVU?=
 =?utf-8?B?QWRYUm9lcStRWTBpa24vL1N1M2E4N0d4eHN6eFR6N2diM2RsN0k0S05ZcGJP?=
 =?utf-8?B?RWV3WjRtalo4OFFHUjE2NEg4OXZwZmR3RWJnc3hZc1dnNHVpblUvL09sUVRx?=
 =?utf-8?B?UVc5Z2NtS29wYm44Q05HMmlTeHVrTXBUa0xwUzRCQ0x2YWprb3BmRlF3UmVu?=
 =?utf-8?B?eTFtS0pyZDJJUjBVTHVCeFdsaURXVUlxaTJwRTRZRDZ3ZnVkM0RyM01Dd0RU?=
 =?utf-8?B?RFIzU0gybzZ3YkJ6cGpLdjdlVERtMEhhWU9WVEpoSWM1TmxGSFNDNmFFQVVN?=
 =?utf-8?B?M1pQQVdFaGl2clZtcmt6L3hlNW1pdmlGcUFFRHhtaCtxWmVMRGFFQ0VsZjRN?=
 =?utf-8?B?aThKYVZ3dURXNjA5M2JUV2U5L2lUeXZPQjVPUU8vQk9wSEhJTHlTZU5vZlpr?=
 =?utf-8?B?cUE2a2hyUEVQZ0VOZGR5RjZGaXJGTTlGM3h0NEJrcCtWWDQ5MG4zQVExeFRS?=
 =?utf-8?B?UzJCYkp3ZHA1SThlTU1HWkVPSkkzWUo3U1FTRU9EbjFtREJpY0hCN09tNjlo?=
 =?utf-8?B?eEdrSUkyZUhEQ2M4Ty8yYndQQ3NCVmEyZk1pc0J5TzRkUnEyeUxlRVlsbE9o?=
 =?utf-8?B?YkxjQnBLZkpuVDE0Q1BLY1VhMGNld2JNRUJlU1lMMjBxRVBEYWIxdXl1WlBG?=
 =?utf-8?B?S2xNZmdVSkI0VnZjSkdsNFBpM21xdkpBdjNVTC9wcUREOHQvdkQzM2Z6Z25x?=
 =?utf-8?B?TVdiNnpHaHY0T2FPRXF1dHNWK1YzSWtmMWYrNW44LzJtUEIrbEkzL3NyYkFR?=
 =?utf-8?B?b1dlMzFQVVdqM1E9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 07:25:51.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ad12b1-a58a-4505-6ff1-08d8b6cb4aa7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ley5mDI70W8U8oPJtIGpn4/Q8H/uSjLeqGwiwWx8aChIdjo7K1LHXN4ryltjVe4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3569
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_03:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 mlxlogscore=888 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/11/21 1:23 PM, KP Singh wrote:
> The verifier allows ARG_PTR_TO_BTF_ID helper arguments to be NULL, so
> helper implementations need to check this before dereferencing them.
> This was already fixed for the socket storage helpers but not for task
> and inode.
> 
> The issue can be reproduced by attaching an LSM program to
> inode_rename hook (called when moving files) which tries to get the
> inode of the new file without checking for its nullness and then trying
> to move an existing file to a new path:
> 
>    mv existing_file new_file_does_not_exist
> 
> The report including the sample program and the steps for reproducing
> the bug:
> 
>    https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com
> 
> Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
> Fixes: 8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
> Reported-by: Gilad Reti <gilad.reti@gmail.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
