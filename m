Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631E933FDD8
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 04:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCRD3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 23:29:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230245AbhCRD3Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Mar 2021 23:29:25 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I3Of6c024509;
        Wed, 17 Mar 2021 20:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=I6Ys27DsFqT4JX6uSBi8oTmAGnR84tB6rigAO0XE0QI=;
 b=bzYoHprGS6LwdH5r6UtVg9+GY9yaWldV/poKNK/9cnXHzzQYIzNM/gCimjSu9WOLD9H8
 bFnph8tP2+/PaIAMY73VoFWuWo4oux4cGAE3mQzDk3fPU3LzdmksOjyTgAvWV9bJR40y
 TWfF9oPEIkzVwNuI/gRSLFsDnL8hmTqSNYc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37bdyy5ws4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Mar 2021 20:29:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 17 Mar 2021 20:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFuFR5vTmLfF0wOYQtayx3+dh8QvMg7mvzUuyQY6T38WW6P4RsM1uF1FosZmxXUPM1EtvLnRSog/j7sNwGRMfiNlNDN4JF8pBh8zLzg/jBl6rpnb6MsO35vv/DfE/HBpYpbXnlLRMN550+H+cnwLaGbJpAVeOUTmUg2tEMSs9K+YcVo7fr8gODMkEXGaHbS1nPCJhbBTvdpWyhp5j3DX2Y8DD7eLTGIySZdYdXJEZxVc6eeEjV0Uezqf2nyAHj+JHuH9bDDgPHetk8+ftMzSZDK4d4bsCfJzHANvXGHhxmU7JzyPtryQjgljoeQH+Z3tPd9KXtCveW3By40MIjw9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Ys27DsFqT4JX6uSBi8oTmAGnR84tB6rigAO0XE0QI=;
 b=WKYP3sqpFLP3MlLFbCzvc84oUFgrnShAH6tB4HMLdqPAZz9aHKqtXfs+r44+8asORK7sUQ0ZW+NsQA2AO5eOTSzxLMnzpCZGzrLedL4hi1vea6BuJRbMfxFi+eaUTSWFAt4hxJ/f1+VApP9Yses2Xa34N896ctKtCu9ZruIzxu8ZhNgeACcz/ji+7F5kdxOW5OMap6ih29V8c1Fn/h0d/g20le32zJ6V4PNXCQj+mgUv8BxhBD5bpSeS2kXa/RHwxgEWOtEPrCbhz0uezuwDEkcQEJ0t5RSXA9KoS5PR/Dgjx5ezcpZziaYLFVOydsxKbBzzHzxhwlRpkgqD9SpVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN8PR15MB2722.namprd15.prod.outlook.com (2603:10b6:408:c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 03:29:09 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40%3]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 03:29:09 +0000
Subject: Re: [PATCH bpf-next v3] bpf: net: emit anonymous enum with
 BPF_TCP_CLOSE value explicitly
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210317174132.589276-1-yhs@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <29e17d55-b3e1-c4f3-8335-2d8cff9eb8e7@fb.com>
Date:   Wed, 17 Mar 2021 20:29:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210317174132.589276-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:38a2]
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103::3b8] (2620:10d:c090:400::5:38a2) by MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 03:29:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74324b3c-a42f-4c80-9679-08d8e9bdfddf
X-MS-TrafficTypeDiagnostic: BN8PR15MB2722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR15MB2722C988AF7D9B6BF5D1E1B8D7699@BN8PR15MB2722.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UX82OW8H2q1BsTe9eL4aSrJdeIvHcfjEMni/3VNRvEM5OXUTAc85JbHvOpgsrAIzvlgWktvo1zU+bZsG5inhL2UWZQvcFMUp5ywk1tjX1zyiDOYESBks8pLXvmXGT++A/ydvkJ+1SqwEQlOSDweqgMcQVdLi+eCHizAaXX9vYek48oLBD77vxz47XdXP+bsTdckDKpG3Qztt8Ql4B8mSUrxdWroBVms1cmkmt5rXt4UVX81eXwHlh787S/z9YIkAUOEsjrnEFW8P4viymCeSkp8MObQpnNGjPCjBalpYp7YAL+vs7+wLc5SbRt57a+QuxgJM1rFdlfeR/bT32fT/3V4Zjy8KMV6+OSARQzSR2YPFh1Dt3KrUOZcZ0Al0RR/2kb3r4tSCQ9HTMkOTnd3IiKPcupZgUH71sgoyCdKVM+3/Gvzt8ycqGMcsozE/qOpbJy9bQ9eCGOkFscg5CBTgLZgoPQXdzWakgT/pxTYVZH9D7p5DN9UdIgAAYoY9yM6sgKEluSeYmpL6mQBuAICCocXIYfJj+pDyoLSDRYxQ3ZVR2zO4YNC2sEAjzi4+15Ak2dSYeT2PZ7NlOVUZxXN1obftWZToTOKP0lmSFF81XE2T86MUoCqkyEnohe+JlOPgx+F1MYn2pw6zfKGpdGawZ3PF9yYkeXflFI99xIbEsN9q9wtaNgTCdyPYdf5rxeWm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39860400002)(31686004)(478600001)(4326008)(5660300002)(6666004)(31696002)(86362001)(38100700001)(66556008)(2906002)(83380400001)(186003)(52116002)(6486002)(2616005)(54906003)(316002)(66476007)(16526019)(8936002)(36756003)(8676002)(66946007)(53546011)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R1A3OHM0MDd1OGY1MWVmUzJYODhXeldXRUlyclhweTFDLzVETE0zdWp6T2Zi?=
 =?utf-8?B?QTZVRmJVakVqZHEyS3dZZC83eG1WRkllbmtNZU56d1pXQ0cyQnJxQmxRS2xm?=
 =?utf-8?B?QmkzLzczUkN5TnJQbHptL0dMT1IxeGZkZDd2NjI0R29uSGJJNU1kUWljYnpw?=
 =?utf-8?B?UlVDWTBrTFQxM0pQREg2VGdhdXh2ZDBYcW0zMEVYSjN1VTNtSkJ0V2JnbXk2?=
 =?utf-8?B?QnBoQzU3elVLVTVVVTF0QWNvbXlEMEtIMVV4aEV5aDBDZmpOeDNQajZxNGkw?=
 =?utf-8?B?U0tncFN2SENOTjdiTk5XWHJheWF2cnIxeGRsa2Y2U2FiTFR2SG1hZllEWTRP?=
 =?utf-8?B?ZDluRUpCVHBaOFF0Wkt5VmRmWWtnZUFKR09UMlhCZmowTEJtMXp4YVFwcU9G?=
 =?utf-8?B?aWY1Mk1kRjBENzVEVWR0SXRIUVM4bGJjT1RyRmtGbDVhLzZibXhoTUsyNHl2?=
 =?utf-8?B?Y3JNQUpjeXpJYVlaK1kzV2N2NjNNckRxRDIrYXdKV3lLMUljVUFackdOQlN4?=
 =?utf-8?B?bmdobHI5cnBOaU5vSVB1c3JYSWN4dGZTT1hHSGJHdW9hNjBjTE5mREFqdEk1?=
 =?utf-8?B?Q0I0VUF4dmlBV0lRbkdwNnNQNEFXZEZCR055a1ZOL2hqZExWWlVCZkltMFcz?=
 =?utf-8?B?bDdYSkhybitQUHFZUGs1UGJhL2NocEJoSkZUTk52QS9CUGNjWU95c3ZGQ1k0?=
 =?utf-8?B?RkROd3l1NDA1cU4xSnB2VWVNWGZmTXpDSXRhZXdPWE0zNGREeWU5djY1UGxD?=
 =?utf-8?B?OXlHbitNcDBoRmtCdWJzTWU4LzdMUzArZFllZ2VKOUJaS2I1MHMrdXZjejZ2?=
 =?utf-8?B?TGF6bktOZUZOZGFvMXJOR3FTS0ZDNGROclNXaDdORTV3TVZQd2JYVm5SMGo2?=
 =?utf-8?B?VUZ6TVpsVE1lTjVzdU9oak0rS05KaCt1ZytSc0hlSVpLNzBUaTFtKzBySEF0?=
 =?utf-8?B?bWpkVGFyNE13RSt4YUV3bDVta01pZjZSVk5QV1NBUUZEQXRmQVM0dW9lVkFP?=
 =?utf-8?B?dUlYNytVbWVacXo5dVR2Rlk5anRHaVNXcFZqU2tKTGkzM3ZWaHd4VUwxSDFD?=
 =?utf-8?B?YnhnRnRQTS9DZUNRTkg1N2dLVU9CMG80bWNGb3oxTWxobWx2VTZUZlg2d1RM?=
 =?utf-8?B?MVJTWDA1WVlCN0F3eXduYnhYcjBvN0lIU251QkJjZmkrVmVCWU9taHAvbUxM?=
 =?utf-8?B?bW9uR3FKOXRSS3BlQS9DMDcvZ3ZIZ1U5aWF5bnpPMFBWNWVTc3l6OHphRUh6?=
 =?utf-8?B?U3Y0OHB2MkxXcDVDd2czSzVpcG5EMHVQSzRnMUNqRDVGcW51UlVKb3B0TG1K?=
 =?utf-8?B?QVp2U0dXT3VRWmNSZnRWZW5pbHBpUEo3SzJJNUQ5UHcvbFJrbk1IQ1NMVDRi?=
 =?utf-8?B?ZHoralczTjdDQWNkNE9XUXJ4cXpVTzFGQVRpKzdsaWhnM0RqaW0yN2dTa2w3?=
 =?utf-8?B?Umh2RDczUTRXQmExTUZDdDF4Ykt0WUdUdFJQb0ZwV2k4VDcxNVp6eGx1clhl?=
 =?utf-8?B?enUxaWlqc00rSzlpL2VXTXh1dnV0MmxmNEFNOVpsTWJsWVF5SHpNT2tSNnl3?=
 =?utf-8?B?Skc5d2NNOEFDUzZScm1oa1hJdTZOeXlTVHJheFRvdWZtK1NuVzkvWEFPV1Nn?=
 =?utf-8?B?Z2tDNU8wanFieUN5U1I2b3djZHNSSXBLdnVXd2FvWFFkRExiRXc2NEhDMXV3?=
 =?utf-8?B?N25oLy83VkxUM3ZRVVp1andwa201dzFLNjlrNGVjbTgyckQzTHZsdjNnOVRH?=
 =?utf-8?B?aER5QzFjZHB2ZDRmeFU0RjErZFNrbGRiZlltMFRVTS9laVlnYm5ERjJvVzRy?=
 =?utf-8?B?V2Jjb2JpTVMwM1JzYWZDZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74324b3c-a42f-4c80-9679-08d8e9bdfddf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 03:29:09.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFaLOVj42hAMo6/qikOQWjxxDJ95iSBd99uHLl1nDe75wZOjXoUZj06qB2Cdg9uY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2722
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_01:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103180026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/17/21 10:41 AM, Yonghong Song wrote:
> This patch explicited add an expression after the
> above mentioned BUILD_BUG_ON in net/ipv4/tcp.c like
>    (void)BPF_TCP_ESTABLISHED
> to enable generation of debuginfo for the anonymous
> enum which also includes BPF_TCP_CLOSE.
> 
> Signed-off-by: Yonghong Song<yhs@fb.com>

Applied.
