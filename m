Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E73C94D5
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhGOAVy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 20:21:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46518 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhGOAVx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 20:21:53 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F0ATXx016785;
        Wed, 14 Jul 2021 17:18:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Zd1NYFbRAUfFiU3GtxEwgSYhbL/VzJRCplUiZ5YnU4M=;
 b=PhQoLvqKWioxebt2PQyLsYMsvXXt1I2vF/Es9EVWFCIauvLxR8cRA8AUcFkFxDwS0XSD
 NuU8NDNH2qDVedgRwuIwdFmCRBA/eEJu+MJ+7n39wytS7rZBcAHr3ySjwirEeWINVLIa
 ZBea0qSGl0/gsAlYa30BUAJ7fKKMLNyv7iA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39srasechv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Jul 2021 17:18:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 17:18:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZEPVAkHQ1IuqGQgm/YBTc6RxeyIgj3GZJCTgMUJ5ZXIxJ8BBQS2v4SecAdTWoisC4X23mLG2mzVJEErBBP55oYy9LodXkPiT9lPMeIqAfDrQARudtMQsNQsba1sEY7slie2ZvIw8NAj7JSelILzW20A0JU/tGvFfFj31elx/8l64c7ytoR1Tz+axzNIAp0LXP/jtrdJLXE/fvNbVHVro07le/Cnm3B9QDW7W1NCJRDAkq17rm6neW3ZYRbLJp24pMEVkJ2wbKtLgjtqYJFNUJaHXfQtQKLMxQi0H2pdvhScle93YZyxtpfmyDSwEFzYRMmdbpcKjOzHx9DojPsZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd1NYFbRAUfFiU3GtxEwgSYhbL/VzJRCplUiZ5YnU4M=;
 b=C+t5Xu2/RycdBlZrKNcjMI7xPS5xZAivVi2GROxLvCQMiHApPH9UVbUGjpT/xkxbqC24Swrf54cUk0TV3j3gB277HsW3Iou241XjlD7fCI1+lqpUBbbTGCcB82Y0kW3duf9An3MOXZgxqHtGBnbAEpuLj+x5JOuO6zTOP7h8wZBhawOBsOUpLm/EnFsttKvq3SfzH0/GZrPSmfZqRoGpUnEXTmsUYTxHjeZzoYj6zuCKjLzvchzZEznwt9qJhUIT7xUugG//cJ110ogaPMW+lgh2IJwBf4jruDD0/PawMyaVbMAUsWdcB9DwjTLmMxzgfiI4ZEnD6jRSP5xji7CaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2285.namprd15.prod.outlook.com (2603:10b6:805:19::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 00:18:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 00:18:57 +0000
Subject: Re: [PATCH bpf-next] bpf: Expose bpf_d_path helper to
 vfs_read/vfs_write
To:     John Fastabend <john.fastabend@gmail.com>,
        Hengqi Chen <hengqi.chen@gmail.com>, <bpf@vger.kernel.org>
CC:     <andriin@fb.com>, <jolsa@kernel.org>
References: <20210712162424.2034006-1-hengqi.chen@gmail.com>
 <60ec94013acd1_50e1d2081@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6f42985e-063e-205b-820e-6bad600caf54@fb.com>
Date:   Wed, 14 Jul 2021 17:18:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <60ec94013acd1_50e1d2081@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BY5PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1287] (2620:10d:c090:400::5:3a2) by BY5PR17CA0021.namprd17.prod.outlook.com (2603:10b6:a03:1b8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 00:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d431d06-360d-4a61-0a6e-08d9472622b7
X-MS-TrafficTypeDiagnostic: SN6PR15MB2285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2285EB6F5A18D18F91E1E8D8D3129@SN6PR15MB2285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Mu3DkZFTiLzPAhzueArjMf2cMuPWSDjdq+cKu6G4kP6k1qxXp8ZZLXUJFWOIbqP3uOSBaPikTUmNFgKhTxyZC3IcfI/PI87/AxI5o33MS8aLZD9hOvBQ0Hv0UdyxQGikax1PWP/7kzde3Hf/0J1K1HIr73KQ+eMuyHfhHvCZ2BdQiNkwZwFMnhf9e/T+qSReWtv+rtsesYTKslVtYQ0ry5AidSoBFWl4MsSUzomR6VAeSpHrv1ihhTd1kj4ertO84Y1HO2yEyx/37/drsa5BJLdSyuGD0EGMa3m6CZw7DBRefPk/N/xMh1ApSBOwPlFamtSX1K0pDSPgEhb7zBJSgfsrM4jdeBGyd43yIyHUQjlFtUwxj+9rDayjii+COwXzKu31ai6Z99MCoXKVmvPJimHTCAmy55u+Kx4Kl/Z/t6VUE5kBjWQ6TZUrttCXSOqylWHY+D3la7GJXwZ9zsMKUrWKzPhBgc9ryCrLXISyhlSPW2qREPnD26ud3oxRVSzRqN3I61TRx0MTvtreWhBN2xlLfz59fTw/fIh/6lVML11XZgxANbphCgua0pby92wc86j+ju7hcqwzmnxD6k8hqKIhK3xhN32ia1kum7YYYSb8ouwi3WwdyoKmlUBkEwfo7UvZLt+QN+Yp0Jq3k19IlGsAaUZuBoxoCuBD/A+iGbKSNMsa3/yVJHnungD9COlg8ZjHNlqJeWzaM2AudlQqkYWumDl9tEntRBMW/DOB8mVQc3D45NybZqcMkyIyMPCC9gzT+i1EHS39F2TgB8K7ipdpQTPfnyVJlc6PMeVD5yCuxxl8k43gopKHOtlnR2s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(38100700002)(2616005)(478600001)(966005)(8676002)(53546011)(66946007)(31686004)(186003)(6486002)(4326008)(52116002)(66556008)(66476007)(110136005)(316002)(31696002)(2906002)(8936002)(86362001)(36756003)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVob2ZqYXBsUXRUaUVNOVlrRjVYVnZPUW0vaFJSVm5GZmdtcWk2RkVldWxX?=
 =?utf-8?B?SXNCOTV0cW5xaUJrcDJVUmZ2ck02UVRiczB2TWd5TWY3Uktvd2ozcGxVQUhz?=
 =?utf-8?B?MytzWjY1SjRUM0duVENSY1VlTGJlZHh5VndxUkR5b3lJRmNiaDAzeHMwQy9a?=
 =?utf-8?B?b3RDc0RUSFV5V2R5bkNkVE1RYTJXTm42UzRnZWFNUnZpUjNRYU4rTDRwbVUw?=
 =?utf-8?B?Zld3ZG5pVFJ6cVVmc3k4ZUY4MUdnY0haMzRlWU1JKzM4L05pb3VGWmNhVjR3?=
 =?utf-8?B?RzY1dXY2TUVVem5sKzZUaVBuS29hS1h0Z21KeU5odWR5SDJlUU5YbkxsV2lS?=
 =?utf-8?B?WlNTTVZ2dVRtaVJramdIMTQ2VFJzWC9CWlJVTys5WHlzMmgzUGpUU1hoK1RG?=
 =?utf-8?B?Y1ZQWHExRSt0VlRqTDhMcStyOThOcWdNdnpDZ1ZFQ1lKZndtVGRHNm02THRQ?=
 =?utf-8?B?cVFKM1hFU0pyL1JjdytsVXI4dGNsWEc1Q2xqY1h3d1ByeHhrbk1VY1BhVlQ1?=
 =?utf-8?B?UkpseFBYSTNwNU9lNHkxOHBGdFEwS05HN0l3dlB1UWhLUXlXb2ZBcloyR1Fy?=
 =?utf-8?B?WTJIZ2Y2TXlFQnpMV3crYUJmMm02ZlBUdk5ReCtFRTVQeHZsSVRxRGVTQTlX?=
 =?utf-8?B?b2hHQmdRazZXaTVqck1vVEJSY2RaYXkwUHliRHpKbGIxcDFJZlJxVWp3VEpa?=
 =?utf-8?B?eFFwbDkwN3VrbGtHenpYN2lWTGZyVXUzQ2I5MHBSbDN1b3pNbEtiSUJsZmVH?=
 =?utf-8?B?a0d6c3Z1NTU4ejZET0VFY01kb1pTTVFxMFJLRGE1Z3ZHWndKQi81bjVpYUlQ?=
 =?utf-8?B?Yk03NUIxQ1pHSkF2K3kxbmJFOFVuOXpoTDY3R1NBS2FVdjZEakJoS0JGdTJZ?=
 =?utf-8?B?YXNlZlkrVG50TEI1ckRNbGNWcy9GNDFJUXB2UEIvRDI0NWJtbmpiRUY3Tkcr?=
 =?utf-8?B?YmQvUVBadHJONGlndm5TaWJmNnJZYklEYXRYb0hRZXN2V1pEYzN0cDk5Skw2?=
 =?utf-8?B?Z0NJV28xNnlRT1h1SWkwVkRwL0NWeVFEdTRFSGdvNC81ZGg1MUZma1pZOVgv?=
 =?utf-8?B?L01DTlhVVDVJYlBsK251LzlIRCs3aG9mRjBvQ0czSkJOQ2dUOXovMmwySFkx?=
 =?utf-8?B?WW5Zb2FzUjZNMXFrU1VESENUU1hFTjdnY0drR0ZxNTR4eUFmOFBqRHp2cU51?=
 =?utf-8?B?cEZoOWZyZ1ZhM1BvRVZwaEdtdnQxUmlFeXExN0NPUDFKb1g4T3AvTjkycUV0?=
 =?utf-8?B?TTIzN1ZPb1k1NCtaZUlEMmhKbHFTazM0NnJqZjdlMnNtYXlIdzhjTWdGZ2xq?=
 =?utf-8?B?R3lNOWdjRGVOT1JFckJZRzNQTUxRVktNMElSd0NOakl3YWZVKy9DRDAyU00r?=
 =?utf-8?B?U2Fsb0tNaEJ0Kys1VE9vWVNBbzlPTFZMSWJkWEZ2dkxyb1ZXVHl3RHQvMVdS?=
 =?utf-8?B?VW1FWTZld2VLamVhVlU0aFNHTGtoTEEwN3crdHRkdXk2SG83cDEzSHg5cEo0?=
 =?utf-8?B?a29rY3RpcTBYMVRtOGUxakh4aTYzaXdQbzNWeFJiMWJnTnBWbHp2Qmxmb3Jp?=
 =?utf-8?B?anRWV2VxdW5xeWF3b0tXN09LL3BXaXdFSlk1ZFJPbHpSMTE1NlI2bmVtWHJ6?=
 =?utf-8?B?eXdLVFYwcjFwNk91R3QyZ3JqWVdNR3FySlFwSnkvRFdNSVFiUlpjU2tTK1dI?=
 =?utf-8?B?eGhYVHdHZUVSMWxub0JuT0ZsWGdkTjVJYkZlUEJlUjJEbVVMQzUzV1kxNWc2?=
 =?utf-8?B?VzZEaXplYjRXL2ZnS1UzWEpmSEdneHNtZ21UWVEvcnR1R2pjbkQxUW5kWEFW?=
 =?utf-8?B?ZkxUV2FlcXBuTHZJZW0yUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d431d06-360d-4a61-0a6e-08d9472622b7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 00:18:56.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUDvSadovM2CeD/UQKGle7b+arLoIN9NjZHhhkjT3o+m6iT+AHh0RSvj7RNeeQBb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2285
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: I26B61Z5TE5G2CdornVxDRbCMAiYPYkK
X-Proofpoint-ORIG-GUID: I26B61Z5TE5G2CdornVxDRbCMAiYPYkK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_14:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/12/21 12:12 PM, John Fastabend wrote:
> Hengqi Chen wrote:
>> Add vfs_read and vfs_write to bpf_d_path allowlist.
>> This will help tools like IOVisor's filetop to get
>> full file path.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
> 
> As I understand it dpath helper is allowed as long as we
> are not in NMI/interrupt context, so these should be fine
> to add.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

The corresponding bcc discussion thread is here:
   https://github.com/iovisor/bcc/issues/3527

Acked-by: Yonghong Song <yhs@fb.com>

> 
>>   kernel/trace/bpf_trace.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 64bd2d84367f..6d3f951f38c5 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -861,6 +861,8 @@ BTF_ID(func, vfs_fallocate)
>>   BTF_ID(func, dentry_open)
>>   BTF_ID(func, vfs_getattr)
>>   BTF_ID(func, filp_close)
>> +BTF_ID(func, vfs_read)
>> +BTF_ID(func, vfs_write)
>>   BTF_SET_END(btf_allowlist_d_path)
>>   
>>   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
>> -- 
>> 2.25.1
>>
> 
> 
