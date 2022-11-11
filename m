Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1592625F82
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiKKQcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKKQcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 11:32:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0601F833A2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:32:02 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AB08PxJ020004;
        Fri, 11 Nov 2022 08:31:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HDJwGz7rhjP69Fq8DIJzFhhEtT9R1+Ti086qWi9QpyI=;
 b=H58GH8J4TW3ZFfwseNQmTzcwvvQ7xM00et+Zj6Y+66RYT2jP+soxp+a1lcQdrpVUofEY
 tXMKbHK2t7PuKJh+obkybqygPI429bDorN6pIk1kK7s4BcZxCAxqsocQAr/WwHJx/iWy
 RtHg7W6tbYtOU50+Gfcl7+BYlPE3ZmSez/qSe+zWU5Ypw7yUYo51CU86Q+Skr1JpbVwT
 M/lBmN2hao6aYOossJFX+UY5jqpHx+ZZtadWFkd6U+Klg5nVIM0sMPJpUau8YKk14359
 MHezqHUAgg/A5PIEm4/tqtehNlHYIQLKec+F1MXQTemRhoxDm7qIaWvk3m14Qg3jSRhQ +A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ksbjwd9eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 08:31:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMD5X37iSoYzi4RGz3hnWhyUPYDLeKwt/H/4uU1gnNyTPo0VO0sjvekvl3QXWD3O5j8gntzCmtkvqQrLMYyclUX4Z0HMFTWq2h20HcU2m2vEjUYBZxj2VnJxWJeDHYW17bBIsCFya0CDBfi1QTpUSVjiB9la+JehWINVEfKooLKpPg/GVOv7tzP8gny+pmJlr0oGm2kvzjg1zVPOOBxabokKPuy2gg50c81Z8NnGa/pUccIAwKuE6FHiWD0YYSl1GoStOBA/Gsic2tQVbi/HcgHylDch1eq7YTp3QhTHYHw6JwqfoVzV5jO59HJSQp2+vXOi7F8N9BQMdKJWYYbrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDJwGz7rhjP69Fq8DIJzFhhEtT9R1+Ti086qWi9QpyI=;
 b=DoPc3PZELZMTxlEeMXsGGC8iCKpd1WBMSuNk/8IB/TuxSM9orimYRnSyR0in4JcMEJP3yydzs4MLZBVAcoanNqAOVOJQh97fViFyEHZjGKCtgNMs63WYxG32uUyqM7xdCejJuK6uv1QUQl45aWQHqex4SBYCSC/Bnxj8N4fDxH0pUdCVURY0JwikV86XWmQvWv0ZJSyqj5l52dOJC+m1rYimiflY/8JZteygaTy76KLDG1ssJg28k4n4bwuL80NhQY1zise/du8M3eDOXd6YzYx2aABZDbTv058ovh/BKq3Bn+2SggEuF4T+V031G87dsMa8bVeYJM/loF0aKXFzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4958.namprd15.prod.outlook.com (2603:10b6:510:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Fri, 11 Nov
 2022 16:31:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 16:31:16 +0000
Message-ID: <00e96d17-bde6-d060-7cc0-bf4a2a0065e0@meta.com>
Date:   Fri, 11 Nov 2022 08:31:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221111063417.1603111-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb3df41-35fa-4a99-b43b-08dac402278a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggJIWGY5uDYT2k7rZDF+XKYO1sodfW9YR63DgJWlVWikZrTAaURoLN5iHHGsqNbNwDDs1PRhuTw6Ki24qX+fRsFXYWkIDFBDu8zDs6GOYIAi2wQKujRnUOAkXHzQZEy/4G+rYZVcMMAm7YRS0IQgbn2C4ehK+y5E8XRbWLDqU6tPvx/57ox0nyI5kZO8uY6/wd9Ls+tPfDCksdbAz8EkZG7E7MfAcnQfa51cbHFKQk1HBZ41F8Ntbwy9wZlnDe53Wh4EF6y25TurB/twpUVcYjTSPUBfxGtnJuPuFlVAoAwUXjMIYqFDkhnQmhvKN09EEY+eNYme2d5oqZP2OZrG9PyC9gw7QFeJz2U+F5FdOT2UIGLVc1vDbqex79JagEbn1ZxTdHW41EdXt+2y57DMXV60H5ODtTsAmDzaPeKRrj2KUkeZ3ue4ShXcghRkVS2xWo2nc4bdrTozL/bSkXyQC2qfE9vAsw9qRVqiYOPvONHk4JhtHU8n38qkzwxN8RHYPYtuQecKjK5/dX2JCkUG4h3tb+dxPzZg0iRU/zsBjy6DDlmhitZ3FLF/cXwRvISxZTLb2cRbaW7jEtoyU87hw6RG2qdO+3LOOB3tTfqKTCooHmm+MmNmuLhkF6hh5fvHETfFGmGZxFQHiLSiT640gJV9uiGfUtumRq4CAMYdnOjQbtF+ux1f5FoT/Z/JrxjCCz1g01nw4F8cSiwDJUp6X8B3lPUT0DB1chqvmpDpS37vG/WjHQf3H/MC/PITDgcO38tKXpX2tEgdjGzkQErPV4AtfKpfZ7JpvFICE3X7/g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(7416002)(2906002)(5660300002)(8936002)(31686004)(86362001)(66946007)(66556008)(4326008)(316002)(66476007)(36756003)(31696002)(8676002)(186003)(6486002)(83380400001)(2616005)(110136005)(53546011)(41300700001)(54906003)(38100700002)(6512007)(478600001)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFNFd09nYU9EOEJROUhEeWxTK1NqTjMxTDVzZnNETVRSYStTK09qOFNmWVN1?=
 =?utf-8?B?R2Jsc01WQ3VsZE0xQm8renV2dGQydWpQVk1VUVBQVFp2d21xMTJLL0I4c2hD?=
 =?utf-8?B?MnZkWXIrWVZqdW9SVVNqQ2M2dk5YME56UUh6MFJZQ2dxNVhvRklWdnpkK2wv?=
 =?utf-8?B?NXgwNTRWZzBNbElXKy93aDZUNCswc2JNdW5kaWdqa3IwV3EwQysra0JwUHFS?=
 =?utf-8?B?OFVwRHp6aVJEZzFlMzd0YVZ5Yk5EREhocXZjRXRqYmxQV3FwdGQzR2lHckho?=
 =?utf-8?B?Z3B4d2wwbXpJMkRGSVNPU0xwNjBGRERBQjczbVFXS3o5ZkphaHBHc1NDbkx6?=
 =?utf-8?B?b1BxT0svV1k5ZnJvenBscVNQUnlSVlcyWEZvWGhxMzlEbkFkSW1KbE5MT2J3?=
 =?utf-8?B?QmlEWnBGaXNXdENoZWpqNG1tZWdGREVMb0dobHpMY1NvWUJxTElOdkxJSmZt?=
 =?utf-8?B?RHp3YXMrVkhoMldlNkVzWkVhNUxNbEhLbituZHVOaWhaS0gxWlI2QzBiSDV1?=
 =?utf-8?B?VU5zSjByZ3h4RmhZYnBENGdFem9KV1lCM3hQdE9PMmlNamRyNyt4cndOK0w4?=
 =?utf-8?B?UXk2bEhDMEY3QWViTThCOTBjbWtrWE40SmN6REJ5WnQwRmd6OWJJQVc4N05v?=
 =?utf-8?B?U2pQTEQ0UWFxNjh2QnUxTHdrYTlCR2haam9yNGJPVGJObmJYMkJDSTVmUEpO?=
 =?utf-8?B?SDZkNkRYQlhpRDlyTGFTc1hXcGNFKzUxUlpVQjByN0xYRFRLUFZibStPamxr?=
 =?utf-8?B?UU1QRURLNDBLY3A4VXFSS2JXUXBwL3FDT2p1NDJkMWg4bzBhRmNHVndleVpu?=
 =?utf-8?B?N2VMZ09CQzErYmNOY1ZDOEl6YXNBTGhFb3pIUW5mbUlIRmpBT3Joc28reExD?=
 =?utf-8?B?OEpJeW1pRWxYZklReGYxTEEyalFCWk9wcTRvYit5RytLWnp4UFFCMVp1M3lu?=
 =?utf-8?B?dmxpaFNyV0lzTzRkdUExblVGbCtiK0dHcWFkcTBjc05ncVhvS29UaFBXUmFE?=
 =?utf-8?B?TWhEZTluVDlSOEEwK0NjUDRZOFJsRkRqbzhzNzFVeXlDZlpRcWg0QzFXaHNT?=
 =?utf-8?B?ZmZGWWpkR1BUVlRYaWhjYjNya1FNdGRmQTMzR29Qb1JUMDRhMmp6U3Bmckpk?=
 =?utf-8?B?MEZmRmxvYi9TZWd6VGp0MmR5YzFlT2dBUGNYVmFGZ3AvWGh6UWV1YkV2Ri9R?=
 =?utf-8?B?dnlOSnl5MWZUMGF6K3ZQTi9HNkJ1QkptMkF1cEd1elFUTlRWbGdDbUp1UW5G?=
 =?utf-8?B?S0hmak1Bblp2a01LK2Yra0tnbmhzN1g5bmRCQ2hqZytGY1hVTWVnTDFZN1Rl?=
 =?utf-8?B?VnFTazR2Q3lITVRkSEhlWkxWOUg3TzB2Q3Z6ODQ5NzBPV3FjVmdKRGQvalBz?=
 =?utf-8?B?eXFIV09rZFlJVDdlV3NGc1dQdUM3TjM0bDk4aSs3QXVjQlJncnN3eHlBOHR1?=
 =?utf-8?B?UStvRkpSYXdOSG5rL3hBQ0dEK1JHV1BFQXlndlBRNHhJeHQ1Y20yTncvSkNG?=
 =?utf-8?B?UUNqTW1mWWxKMzNtaU40SjlnYmV1YWROeUU3T2pOZXBjdHV5V21lSlNhWlJa?=
 =?utf-8?B?UXdkTUUyRCs5czFvck5iL1JZVUZidnFhUFlza1pGZ0tza2NoanppQzRIQzJ3?=
 =?utf-8?B?QitlYjBMSEZxTWdaOWpvTmVGenJGRm9HQ29KZDRWNTZzazVEVk1UaGdnY1Fh?=
 =?utf-8?B?eGd4RXRDd3hqMWhwbkUyKzdPNk1IbGpQdmlwb0dBVGM1TlVXMlBkNGlZZnhS?=
 =?utf-8?B?eUdqTHVCaXEyYVlzYktJMmxSUy96ZWhpdkFKVmhxSkN0ekxiWVpCMDhSaHV5?=
 =?utf-8?B?bGV0enloQ1JCVGhoU1JsK3YvNTZJS0hmMVhxYlhremh1QmpyM2MrbkVjNW9F?=
 =?utf-8?B?bG1xS29jNk5MT0piUDVMZGVvbi9Rejh4ME0xZDJYWmhIeHlteTV2dTZSSGwr?=
 =?utf-8?B?dVlEL1ZZQlhWSEdnTm9BWnZ4YjlWM1dHYjVPMGEzSWZHZVVCWm1Ua0sxVmVR?=
 =?utf-8?B?bjk1VlN4N3FvaVFYTFA1YmJJMWo4OHljZjhLMHkxenljOE82UmJ1MG5ocnc1?=
 =?utf-8?B?NmpuNVdEL3drSzZjSFFTWkcrV2JRUlVKOHRCL1JqWVVhQnFKTmNtOUs2dmxi?=
 =?utf-8?B?Tks0NVEzdDJoQzcrUGZDbkxxYUk2dDM2cCthOUIyazBOR0dOMkVLc3lTSllt?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb3df41-35fa-4a99-b43b-08dac402278a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 16:31:16.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXoomCSD6iuSRTPcJEHvBR0XEvuEuxrqOHUt9SZYYRuaxPQPW2nUYp3lv5OlsYrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4958
X-Proofpoint-GUID: QNd9AUAD14ITaiPM5wlSulTuAYN8ZTZR
X-Proofpoint-ORIG-GUID: QNd9AUAD14ITaiPM5wlSulTuAYN8ZTZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/10/22 10:34 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> For many bpf iterator (e.g., cgroup iterator), iterator link acquires
> the reference of iteration target in .attach_target(), but iterator link
> may be closed before or in the middle of iteration, so iterator will
> need to acquire the reference of iteration target as well to prevent
> potential use-after-free. To avoid doing the acquisition in
> .init_seq_private() for each iterator type, just pin iterator link in
> iterator.
> 
> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Thanks. LGTM. Once this patch went through bpf and circulated back to
bpf-next, you can revert the change for the following patches:
    f0d2b2716d71  bpf: Acquire map uref in .init_seq_private for 
sock{map,hash} iterator
    3c5f6e698b5c  bpf: Acquire map uref in .init_seq_private for sock 
local storage map iterator
    ef1e93d2eeb5  bpf: Acquire map uref in .init_seq_private for hash 
map iterator
    f76fa6b33805  bpf: Acquire map uref in .init_seq_private for array 
map iterator
in bpf-next.

Acked-by: Yonghong Song <yhs@fb.com>
