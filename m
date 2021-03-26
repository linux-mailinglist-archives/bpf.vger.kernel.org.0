Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41DB349ECC
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 02:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhCZBjl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 21:39:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63904 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhCZBjU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 21:39:20 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12Q1cqYL018878;
        Thu, 25 Mar 2021 18:39:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9ZwO4ADKiKpq3OE+fSQYvedCMTrtihnJopQON+SlSeo=;
 b=ISAVWE04SGzq3wcmMd8fHku7Mg0lXXGTMpofpuKbHslDxE+G3AOntSKR1AsKSTkCy47T
 6MMNez284Rw1t/3k2/N0P2+q4gnDkRTMJrTTu/qmsMaPt/CAHOb7VkfyNF8yIBBeeJ/1
 u0j+qqM2pKPUl2CTspRvZSnxvi+J9KOiZVk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37h171sfms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Mar 2021 18:39:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 25 Mar 2021 18:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2wL+YOqaUgsaRKIvArO6cGt40Zwz2tfVinauALDneZk1piGuTrSd/1dqToKlirLvrWhmijmebBFQtVinSzL+L2PrZnmDV175uBLJ/0yZDQvdO8ytSw26Ykg/+hIJ0sOlqcNIt0gian9paExhRGWJoQyhg2a7f6rmf0Yq+F2wkJuBx/sl0NFvFn99xL8U6d5NSmmxUCN3qxS6B50HDuBAe/pSTlhiT5AVIjSukTMbrvKJ8dRVuhrqkYsIIM+wa9gqtIU/Wpo1kwaLR7Hvf7Xj5fytnt9Z02hd4RkqlzDcsOLlOrkQ3oGzsGkj9WNmWpXRGA6cpqUptWMh0XagCicBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZwO4ADKiKpq3OE+fSQYvedCMTrtihnJopQON+SlSeo=;
 b=cywkz7KpVsL6h8Zsjn2h/TBCyX1FxmJupq9PPdyp7D5fvvU6Avr9Ya+FG0Y3YwBG6/EF1HDxd3SRbb6FiaTTB21Ws+3HY7Mlr7UZEdOUb59PLEftGrh6me9KC0I5d8gCXQ5dLJNCqe9nnSZcLcBTaljtpTP2wPxWNqSQF1wIcT3LuKw0rv7XdNuHVPIZL4JKYlhr52kejYJrrB9WmxOhe48qpx+e/caWoxGJ9KbsNctpmbX0mYzOYLKwz3r4tqIMw//v4jNvaR2KJHFRZRgFzAQp/ML6cGhW72CYZGsWRnOhIckFALE7kWI7t3dHj3Uf7qbh/nUM8X55LU/fM/kGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1858.namprd15.prod.outlook.com (2603:10b6:405:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 01:38:59 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40%3]) with mapi id 15.20.3933.038; Fri, 26 Mar 2021
 01:38:59 +0000
Subject: Re: [PATCH bpf-next v4] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
References: <20210323055146.3334476-1-yhs@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <3a2052e8-eb4b-fefc-4a0c-ad051b5609d0@fb.com>
Date:   Thu, 25 Mar 2021 18:38:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210323055146.3334476-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:8cd5]
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:8cd5) by MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Fri, 26 Mar 2021 01:38:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4314f400-58b3-4bd3-bb34-08d8eff7ed0e
X-MS-TrafficTypeDiagnostic: BN6PR15MB1858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB18584F4BDDF8F9791ECD7DEBD7619@BN6PR15MB1858.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjPxP7FCRm7ur93AK7rXeAOkZ1sBrxiAYsPRwnn1gBpBTDwMtY7QIjH89oPesfjUEgTmArClnMwlO4PYdtrGcdFb0fcz+/YlzCMY9HOplxOCk+Yq1TWFAY3oK3fc9h0V0MQNry8iawS2BfDGSCJxh2oOL7lpFU7VGQ57ud/WFVLpdwk6hO8htATrhKRX7VsgKWH1ZJwB75CAzYjHJ8tAXfRCR5h/oJnhZwyURHhAA89YjHiyscbP9DXuI18UPnI32QNtOmP613GfPF3oMPUEzaW9BhgRV3t4BWmXLVJT+wGYMJhIgc07qgHTwFpdsd6bcpONUCSWIYItj4hyOLHXLmbdtsvRF8eHTJ+4PuiTKIpBtzs/+bh58kOywlyTZLE7VYaXVeCWrQmD5n778fEVf0qLueYNclzaLOpgubKyVVK67Wh67C6lWVhxidMZk43HFYbywtCw/kV4lC2NM0CcvIoZsVS7InJCnlbDgvmy7L1etjG2Ojd1v8kX3D4oMsEdQsTJssrhUiSq+Oejt1DarZqEnUmvIjwtr+etBU9boU4MXRQCiFXHCgAPh8zwIuJbpNaGTpDfUqSpKJSepA9jP013a5vJmwY6zVAPzOmozXz+7IwCuHar/YlBXo9Hy9w7DtVXd72bGHAKUV6wiytG8/K7wDLdr33TkklTh56ICmus5JikiD+NfC7Z/YJgIk2rvqwxv/sOmDmz3GEuiQM5lSqugLfDcEf2ZGn09QqWm9H1nov7zfQJRJKwNdc1VE4ScztrcdaXz0UphhvWHFCuWf5U/GfjciZzDewHNlMdE+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(366004)(53546011)(66946007)(6666004)(52116002)(2616005)(31686004)(66556008)(66476007)(2906002)(478600001)(86362001)(5660300002)(54906003)(4326008)(966005)(6486002)(8936002)(36756003)(316002)(8676002)(31696002)(38100700001)(186003)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OGREVWxmb2hHVWpOQ29aU3UvbmJDYUtKbnpudUVJR1ZLUVMvcTBQVmVWVGNr?=
 =?utf-8?B?RFN5eXNCcXBESzRaMDJsakU5TVRqcnpCeVc0ekJQa3E5dllqUTdJaWc0ZFZR?=
 =?utf-8?B?bERPMkVBVUxzRExEVWVEcGxpdE9iS0ZqRERJQ3hpeDZpOE1xcnIxbTJxTXZP?=
 =?utf-8?B?MXVpbDFWTnY2WTJ2RnpDNklXMVlGNXZ0ZVFKV1M5aEMzbjlBU3A2VFY2T0sr?=
 =?utf-8?B?Y2pHV0Z2a1d4dEVvMGNKaUJISGJNSGluSldqdGhTV2hVTHZwcW1TODdIUDY0?=
 =?utf-8?B?UFdDZk9hKzMreCtYT2NXQXlmZjZHZDJvaE1DVTdTOWt4a0hnUS9XdjV2aFht?=
 =?utf-8?B?ZGJrbUx6Y2ljL2xGUkgxK2pnSGRETWRFS3JTWUo2R1RsNFRNcTNYcUQ2WEYz?=
 =?utf-8?B?UVRpWG55T2Z6cmtuQ1BQelNkWkplbzM4REE4YnJJWXRXZXJlT09tWkl3bVU3?=
 =?utf-8?B?ampqUk9IZk9BMnc5b0RBMmMyRnR4WHY5dnoyNmJwb0x4VzN5WmhTTW5acnZ0?=
 =?utf-8?B?MjhoR1hMNXFkVXhNWU9CN0Z5RG1pQkh2V1dqelpNT3pEenQwcURHUnFMS2JP?=
 =?utf-8?B?MVEzRXc1MHg3ZVJydkUxa1dHNjJKN2hhZ08xeU9NTjVIQTAzdFZBNG9saHg5?=
 =?utf-8?B?QWgwRHNMRnVld29WcUx0NklNYmNWcVdlQ1BKZEpYVEUzTUs5eXYxcWRLQ2g0?=
 =?utf-8?B?WWdseWF6T0ZNeVRodE9KaDlsSFVMc09yQ1kyZVdPdmtjVXFUSTFUaFY1Q3JP?=
 =?utf-8?B?cnFGaWRLS1ZVb24zWXJlbXpka1N3WThqNFh1SGRyTUZjQWhVTXhZdmd5aWVB?=
 =?utf-8?B?dCtiUGdIalo3aUlVbXk0VWIrbU9lZXpwL3VpSWdBSDZ5WTJZWTc5SEdQc2xk?=
 =?utf-8?B?MWo0bDdkS1p2dkVRbVJ0Y3ZtcmtGVHBmcE42YWN5V1RibmRBWEUwYzExM0ZX?=
 =?utf-8?B?UTJrcHVSZTMwSGFuMnlZaHZQZ0J1VktOei9vMkVkVVRld0oxQUx4WlRrUWJk?=
 =?utf-8?B?Szk4VWxnY3pTOElZNDZzenljRUMxNkpyOUdLZXhiY1JiMmR0dkpGQ3U0N2hi?=
 =?utf-8?B?cTNZQy9sZy83UEJ5VHRkbXN5dzNtMEtrd2g3WldxRitONm9BVlkzWmRkRkRZ?=
 =?utf-8?B?eWJrWk0ycWJBQkRMeUdIMVRTWTJBd0x6enlFSXpLUnBoWlZId0FSZXFaQkdK?=
 =?utf-8?B?OHhWaGNrcEFRM2t4b0VYcWg2c3JLSUxIZzVPclR6RlliY0pyd1pzb3ZLaG16?=
 =?utf-8?B?TEN5Q1RxVFdpMlUrcjBUQUViN1czeWpYamFUWVA3T211T2ZVU29BV3gzUzV0?=
 =?utf-8?B?bXlvVy8rZmJOdFBHQnRaK2R0bnhSb1ZSeEFvL2F6NzRwYVlxUHpaUmhLaWxO?=
 =?utf-8?B?SXp2YVJwZmRxK3JhaGtMWXZqMDBrcHlaYW9TcUM0R2xNZVhRV08yTDd2ci93?=
 =?utf-8?B?bzBTZE9NVGIxUml1bnpVSHFxMHc0ZlIweUJoSURVUnMxZHZoaVQ1U092dy9F?=
 =?utf-8?B?eDdET2dWWVhYSEp4SDJPSjgwU0lndUQwdDV5VjQyKzhFL05PTWNvOFY1Z0J4?=
 =?utf-8?B?MjBDQWkrSXpySFpabHl0WHc1SEFKekQ2RkxkV0xpWGhadTczZ2dscUpja09P?=
 =?utf-8?B?blZ1RGJsd0ZmSHZFREMzUUtBckdUbTZIYTI3cWtPQXZOZC9vSjNtc3hWOE9B?=
 =?utf-8?B?OEk5V2hYWlllMEpxaDJBOUR4eUtYUEx0TklYRFBGckhOaDZwVmUvSGVPWW9C?=
 =?utf-8?B?bHZCT09JWFhSdDFNSTdyMXJxWWxFTEZIcGNObzI3UHZJY1RnMnV0ZEpNS0xh?=
 =?utf-8?B?NWFiTFU2c1pnamhQN2VLdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4314f400-58b3-4bd3-bb34-08d8eff7ed0e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 01:38:59.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAcONZ1qMkMq206BLio0DQvwlpDjQVIxop1aW6E3bMkxZzRs3fveT71ums1P/nos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1858
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hoxxdq8B9w6-wbGAYEAmZ5lzrptD8MwH
X-Proofpoint-ORIG-GUID: hoxxdq8B9w6-wbGAYEAmZ5lzrptD8MwH
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_10:2021-03-25,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 clxscore=1011 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/22/21 10:51 PM, Yonghong Song wrote:
> Jiri Olsa reported a bug ([1]) in kernel where cgroup local
> storage pointer may be NULL in bpf_get_local_storage() helper.
> There are two issues uncovered by this bug:
>    (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
>         before prog run,
>    (2). due to change from preempt_disable to migrate_disable,
>         preemption is possible and percpu storage might be overwritten
>         by other tasks.
> 
> This issue (1) is fixed in [2]. This patch tried to address issue (2).
> The following shows how things can go wrong:
>    task 1:   bpf_cgroup_storage_set() for percpu local storage
>           preemption happens
>    task 2:   bpf_cgroup_storage_set() for percpu local storage
>           preemption happens
>    task 1:   run bpf program
> 
> task 1 will effectively use the percpu local storage setting by task 2
> which will be either NULL or incorrect ones.
> 
> Instead of just one common local storage per cpu, this patch fixed
> the issue by permitting 8 local storages per cpu and each local
> storage is identified by a task_struct pointer. This way, we
> allow at most 8 nested preemption between bpf_cgroup_storage_set()
> and bpf_cgroup_storage_unset(). The percpu local storage slot
> is released (calling bpf_cgroup_storage_unset()) by the same task
> after bpf program finished running.
> bpf_test_run() is also fixed to use the new bpf_cgroup_storage_set()
> interface.
> 
> The patch is tested on top of [2] with reproducer in [1].
> Without this patch, kernel will emit error in 2-3 minutes.
> With this patch, after one hour, still no error.
> 
>   [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
>   [2] https://lore.kernel.org/bpf/20210309185028.3763817-1-yhs@fb.com
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied to bpf-next. Thanks
