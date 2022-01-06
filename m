Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF622486D9D
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 00:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245409AbiAFXRn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 18:17:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234795AbiAFXRm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 18:17:42 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 206M46ug017588;
        Thu, 6 Jan 2022 15:17:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5zOQDC+iQAde0ZbXLPSeBgX2GhjBr6SDVibJBby1tlE=;
 b=JiDrpUWjgVN6KPO+qrD6uefSP3aQfJlZAFF1zAnYXoDl9zonCrrgYvthkvJhq8cbjhjn
 vatTFBluwiuJ0iDW/YQ8nePes6woPISH2QTYsXLzAQzV2axWMEpJq/DATg2kb07VcbGL
 0cSwwsAQkqAepPve5ydL3uAj8yHzXuGA8q8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4vj23qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 15:17:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez6NU7N4I4BV6atpI/YddYTNF6Dd3jLqzLxUEvEpVrhfeWurQMO5qLmHgUDhjUG2M7tfuELlxljzhvfiHZeKs7gA3RZt0JChkymYPfltqGtzePj0SjrbscAG3c8M5YzSi728HaDiqNVf7wGoWLy94dstrnrpYVi/zvADC1799U7DC3/KV4Z8naLGYz1a+RjCq/vovOHD0qNTEKPv9tG87ZaKkkpd7f5vxJsD0zzBBJ+hzjW/XFqgvYGzTM7sRTYwRbl4NDqoE1Ef7Jqe0nJsskQNPxKFZG36KVLgl22j8J92jCYWdDaTaT0obcVg24dBLxVLBHuZLXRdurxqMVNKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zOQDC+iQAde0ZbXLPSeBgX2GhjBr6SDVibJBby1tlE=;
 b=FukVhGGwvhYMFMjmdjjJAYcKc35+2wbSdhABMoySOwS344NVdOk9+O8BVy5Ta99j0PqaLSXn+H4eTUB1PIa8YYC4sewyQYdABhrhxJ6sInN5iyRyq6ZxM5AaVuskBpKQLJUfjOntkXP9rL4HYu4qsnQSK1LWbtkZ5nwjfeXUinpSIV/cNf3+ilFrA8oFYr6qo3wd3MbH96GKLLVu31q/sz5VNy8SqGa+1uo8lHyp0TRUlSq4008wiDQp3Jb37wlgR0kq3yla9uFIwA0a+Nq9phqmMbvT+KVlpRZQJfE0G5DmI05e00iG7ZjEFOZ3aZHcTbbYHg9Jado7JU5SBT6XNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1968.namprd15.prod.outlook.com (2603:10b6:805:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 23:17:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 23:17:24 +0000
Message-ID: <ca6e2085-251b-1dbd-3ee1-d990b0eec810@fb.com>
Date:   Thu, 6 Jan 2022 15:17:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v2] bpf/selftests: Test bpf_d_path on rdonly_mem.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
References: <20220106205525.2116218-1-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220106205525.2116218-1-haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:300:c0::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9982f1b-4009-460f-c2c3-08d9d16ab297
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1968:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB196818539AD30A8E90384BE3D34C9@SN6PR1501MB1968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/ZQplq2nBArgmGP+IfbQ6D7f/fnQApGjCZNNIccyMc1LsthcvAHKXSznN+NUzNbfWR/llCJqJB9BrHnid5An+iJLkrEZ3qDndXK5rJXTSHHFcVcOK/8GhArDTACKrXVnXxzm1dBaRHJI9x52V1LZ1Wl3gMF2fqDj03wS/uG+qDh9tZ2NtSGLdghE1mV70rX5kr1UROsNNGyqRmE4R8HjCdc6aX3hsgpRAdil4iV2OHr29S9Jvzt1hPUacQLBUbNtpf4BMEEWrnimg2umJzr9Nc6IZ71spUC5VHxgZ0VZNISaP8cN8MryNi4hQPHZs/VA81un07I3+YnfazAxUqNLkkTJRPtQ19qvjB6v/ehTQdX2JccdGrfeML7o71157cnaVVLokFfPP3lc4PYBl1DGr7/Ga1nLBJrPQpaDHBXCOyVIBskcxv8fptCTGf5pzqrVAcarHNj6C2rLK2/Fg6opsfUhu3/z8XDpLYq5guIu+fWjVNsqNCzM4QUchsZtEFAn5IQ+r4X4nZSDmdZdU+r+lBceuKapmhjw469Dq8J9ozzGfjxVYxhAaRfoOZ2x3ZAV0X+Xw5wx1h2EXfFGxncvuriqn50215Vy8XgXnC/EgBlVZ8QJ8qMM6aMgb1sJoY5l3L06rrbI7OPUXiJsRXI7QYpBrXQYacac4vUdLO80kUJD9SZWpd4BvXvvUI3c7xIjOXLGc2e1W4lrnvI8zQuV9VP7ZBFUmfzvqjJaJ7e9eE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6512007)(86362001)(6486002)(31686004)(6666004)(36756003)(31696002)(38100700002)(53546011)(6506007)(110136005)(54906003)(52116002)(508600001)(8936002)(66946007)(66476007)(66556008)(4326008)(316002)(5660300002)(83380400001)(4744005)(2616005)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhYNEdmaUplUlJMUkptUVBYL2p6T1dvNWNLNk5hei8wUFRWSENVQUhNcmdW?=
 =?utf-8?B?ZmZoUFR4b0xHelJ4cTgzbFZYdDJHbTZJdkVBNTBHZnFDc2xEVVZPcHVka1dt?=
 =?utf-8?B?ekt5V0tzVlZYTnBnYlZtcGxZb3lrMlJ6VDd3RnJyOGZONDNpTDBFWkhiRllD?=
 =?utf-8?B?Z1ZhUWtTUmc2ZC9HQm5PejBQamxVMmdmT3Q2d21QdSt0WUdCSDY4eVFUU2cv?=
 =?utf-8?B?TnI2c0N1KzB5T0RNSGpBOEVJOTFkUmFpdE9CSldyTEtHaGtsMU5TakQ4ZXlB?=
 =?utf-8?B?Mit0TFRGczRqT1Z4YnF3NnByWnpFSFR0NUQ5Nk9JbHJZTnZqSEtCZnFaY04v?=
 =?utf-8?B?QmxNbjFVd1EwTzl3dUliSE45bDdodVlpaStleW9JS1dVMklET3ZBZ2ZyR0ts?=
 =?utf-8?B?ODdPSk9DNTRad0t2ODF2eHU2V0p1aWgvUWZhZFRJeG1JaUxJdG4zZUxGeFlH?=
 =?utf-8?B?S1JWMXRzUVlBODVVaXcvS0dCRlg3cTd6b0thUHc2a2lwMlZiUk9nUk56U0lm?=
 =?utf-8?B?TUxBSDE2SWQ5dGZnaEZNY2JHc3NNK0JVcS9mMEZva0h3SXFDcnA5U2xOUHpN?=
 =?utf-8?B?TnUya3J6YjlZeWJFTmZ4R25NbHZ1cDBQcGpGVEhYalVmK3Z6UVZkMXNLcDhE?=
 =?utf-8?B?NzlxMU1YakY2R1hUZWJCV21lUmJIaWxyZUpBZitOc1ErcVA0Vk92MkpzUEto?=
 =?utf-8?B?ZitqelZDME5FUjZGN21mTnUydFdwTllzZmJxb3NITkhRL0ZJMDVRbitiNVh1?=
 =?utf-8?B?Q3kzQWNpY0ZvanlVYnRSSjAxeDUwUkpDSWJmbmFteFIrZ0NxQ2JiMm0yM2Qw?=
 =?utf-8?B?WXo0VDJJR09yOHhKbm9sMVUrU1lzNlBVbmtJOHdXSmxyUkhEUlRLbU52V25m?=
 =?utf-8?B?OWVGaTJxMVE0L2FFSkF5Uzc0Sk0rWVp3RnVLYnRzNFVJWXYzNzRIWmJYWU9Y?=
 =?utf-8?B?WDNhRU9WdEhZTmw3cXpzTnQyS3ExclNFZlo4aFNvVnhWYVowTW1wMFpqWFVx?=
 =?utf-8?B?ME12U2gyNTIybXZYTjkrM1JwMnhrUmVvbFkwVHk3d0hGZkwrOTZFZE4rcnRM?=
 =?utf-8?B?UWtmWm5iYzlHWFNWZWdBb3huODh1TUVKc1VTNnE2ZlI1RjN4aEgvTksrQmVh?=
 =?utf-8?B?R0lXKzArN1hUbmxseHlPMmRrdHg5T01YYmZKeG9aWjY3VERhV1VwUXB5U1lC?=
 =?utf-8?B?Q1lESWRXU3hZRGpucEY2Si9wenZjbU5idXc2Z24zdVhBRUpHb2JlK0FNOUEx?=
 =?utf-8?B?RWhXNE9xQVdQdmI3RVdqNWc0TEpCUnlMVlZoRm1oOWRjYmF6bitMRVZCSm16?=
 =?utf-8?B?US9MeWxRSGg2bEJRTnFaakxyWCtxU0RtbnJtTk1tRktvUXBHZS96WFBBMkgx?=
 =?utf-8?B?ZkxIWjJwdlJVLzVTcmc5bHdieUJFRmZDSWN2RkdaUThMVzlSMzBRUUhzbFZu?=
 =?utf-8?B?TVBudEJLMjdvcXZ3RDhjL2ZFWHFRQ0lpK21vVXhwcUM0WmhHVGVaczBFRHVi?=
 =?utf-8?B?RUtwNDFNekQyK2I4ZW9sd0F4UFhXaUlSb3YzZzN1WHk1Ti9HaEFOV1U4L1FQ?=
 =?utf-8?B?VWd3Z3NmK0FMa29KMHJyMDBMYnFUVjNuYWpITXJoOGRrUEt3MU9IQWJkakZp?=
 =?utf-8?B?V2xZZnAwTUlaMDlyWjRKMU9JbDlTRzZWalhZcTBiMWJObzJ5UmVMNzAvMmFD?=
 =?utf-8?B?NkM2d2VwS3o3QkJCWnVGYytpNHJyNHhtNE85WVI1VWxkTFJTZ0NaeGUxZ09Q?=
 =?utf-8?B?ZWZxMmYrMkRZZGhudUFvbERNVEFld3A1a1FybGFiRjM4aW5KcGVLVUtxc3p1?=
 =?utf-8?B?eVl5S3o4UUo4SSsyeU9mZkpEMTRtMWQrcWUzaDZzWUtWdUpHTk9QbTNFMHlx?=
 =?utf-8?B?MUk5bUtjQ2FBcldRNFN6ZmQvUk5rRTRUY2NpRkFmQkZTTkhaSTFZUC9JRVd5?=
 =?utf-8?B?bUVPSDBXSTBMaEZIcUJHOEN3d1NwN0NVcmpNV1VFdnU1WHc3TC9PYTJWYUl4?=
 =?utf-8?B?WWREQWFnNUlqVEVRUUlCejFnbWJhRURmOW1Vd2F5TDdSdHQ0WXQwS3NYeStU?=
 =?utf-8?B?d2p1N1pqTWFyU2ROVlk3SVAxd3VUOHpjVUpOckczTGJRZjJiR3BpNUtZZVpj?=
 =?utf-8?Q?4HPPAZ5UztxbhtlYiwmap2g1q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9982f1b-4009-460f-c2c3-08d9d16ab297
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 23:17:24.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBeB81uZAMuArtAN4Rtl1strA8BN3Fn/LHVd2YUU33j13zoAZTsXDeTK8pAy6NPs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1968
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: oIbOM1UWMXkbLS41Y_ncvpcMwhzSHqLT
X-Proofpoint-GUID: oIbOM1UWMXkbLS41Y_ncvpcMwhzSHqLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_10,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=780 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/6/22 12:55 PM, Hao Luo wrote:
> The second parameter of bpf_d_path() can only accept writable
> memories. Rdonly_mem obtained from bpf_per_cpu_ptr() can not
> be passed into bpf_d_path for modification. This patch adds
> a selftest to verify this behavior.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
