Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B36623061
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKIQpi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 11:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiKIQpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 11:45:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6954122BDE;
        Wed,  9 Nov 2022 08:45:35 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A9CWLch000753;
        Wed, 9 Nov 2022 08:45:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ee7UR+lYWesgrxLbZL0ShmTfth7huwpCSCLZDq5/PxM=;
 b=YzaqsmrW+I8bJ0Kiz9rOKwxvt/GqKcVi2t9UseMp/LWhwG2HMZ2Fk1RV9WfLXjq+Rpmb
 J930JZVb7eH6ld+Ed2MZ1CMO4QBErQg5Vhyu8CTltY/aoUu46Mi++l35z8gSdeTvRcud
 vug1TZWdP1iDk22QUGRSE0vp37XRef0mPhWvLzhn8xuLflo/s5l9KaLwn0orIKjmnmq9
 CgNE94+AIwio63gZjZKK6l16KlDk/Zr4zaBVsZkI3WVuSjfWhB54Ytp3PK33hauiE2tb
 9Zt4wWPiL5Fv+4jAjHdGC9ojYFqv6ZYNt4N6UxKe578Tz4qjYO0U3P4KarRvo+Gs5XnK zA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by m0001303.ppops.net (PPS) with ESMTPS id 3krca322bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 08:45:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyGLnebpNKdEybpxmckVhl2ZfI/hwJx+i56Yb7mAgLjeONWrOOXC4bOZdLz1rtJvpnr+7k+T29UfSwbg1hY3DyvqFCP0sgnv518Rj9DTO/hu+TFCgeXKI0k/dAQyGLjEIm9DmLXpqIc50YBakTwRwJWILKuKMeqnmrc4Hc6atoUya3GmFeBcrhWaZMm79NCjfyhar3mWsb+A7T26rKFPzMzM1EjX2MeiL9ml/UKHIpO5SKEexqx+/KbYVT3vZ5OTp+b9cfPBPBhx8rE8UtM/VDdehmbDC7UvMVaN/ixF7esjovbAnRw6pX39a9jPqewaOXTCPuzFKur5tVWJG9xAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee7UR+lYWesgrxLbZL0ShmTfth7huwpCSCLZDq5/PxM=;
 b=k46D3CajfWpqDc7ES76JzziAovxqPQFhbF/UQ6xZPUJsgqi1i/gtxxf/k/a3xKOQnVO/CUoOVmRe+Z8DsfAhMMMHBFL80di0PAnmcZo0C0VmzjI11LJ9YF3WXL3YvkN47EPfsWsuTJKLB7z8OfBqHBNTMkU863XCatJVe8aXA8kJHn3cYbgSgKdILaM/TSZ8R62sCSv65ZHShjOUE8hLbiFYCk26L/PQZ9DUqp0v664Eu1DRA65l5xMhLkKujmongk+qNGX2K/5O2hBfTqPhJBdlO1AvQlvcpAw0cWi7RahSZ6ytvd9wmNLDbmuRDREkps1mBfiirEjagV5/WlbMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5192.namprd15.prod.outlook.com (2603:10b6:510:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 16:45:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 16:45:11 +0000
Message-ID: <5708a47d-5400-e75e-ccf6-96177366ea38@meta.com>
Date:   Wed, 9 Nov 2022 08:45:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next] bpf: btf: don't log ignored BTF mismatches
Content-Language: en-US
To:     Connor O'Brien <connoro@google.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221109024155.2810410-1-connoro@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221109024155.2810410-1-connoro@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9720a8-a099-4205-f332-08dac271c48e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJ6+p2+KXlPtb+fICGH4h7VNPzuG4APZkGJ1f+FxXO/phtwlKeXwSKSKxYuWOwcPMlQrBCN9ZTR+TtaGkyA6NFPC4oRtIM98jguk9wh2BMJvN/VzPLO1Gz/9oGgiWdAm6kJW5hvD8bE1wF6kSoDkqsspNHhly5CD+DPW36BtaZUESKsUz26nZ6V+9Sd3jPzwKUJL1AsIcjt1n2BA2N81kaJo7pVY7CwX68FmAMcrhgJRR93F/NsV24Znv4HZnUSjJe3awBFeCh/dzMSuODYklWDwvM8EEfHlf8iZdCiCd6rHv9xGPjcwkQlfeBxhii4SHtUnR1oo+LpuU8q834jxdMuy5Hby9/jkoxpt1yxGgUTkUhkDYVnjJtnhON6vW72kTOStbLIMdaUDQPwcJPwETz8m6qvd+ec6pz4Ykfd+UGpDO6B2b1uSlLnJPtSlX2QmOTyBAm6v4MHQokOaWNdlwCP/Dzg5GSedVg3oAh5vbGDShp6BfHEmIpvw3mgNfmh1INHYxDtzSjakRYnISfI9T2hSZ+M7wasOcMR0dfXbziNnOM/KZTwvDVR22dMVeHCyRAehZvBiQPkLxBchYYCba2Y/FtN+qG8QtYdcAPBiDqsNrk1ax3x8922MN1Teb61ohtpVPZCF4uTk1GOcqFHDire7cSBOEXW17peXO0PWqPO3427QOqEpAz4V0VqC7SjwzyjL0d6oYm9zZ+m6fvHL6+Pjp0yt9/XA/dWD6zqeLA1IDhErLLmU2YOo06YDh764NCivg3XR5tU4gPr37mTLXY23A3yNOJgJDvHzSQasTDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(31696002)(86362001)(38100700002)(6486002)(478600001)(8936002)(6666004)(66946007)(66556008)(54906003)(2906002)(6506007)(316002)(83380400001)(5660300002)(66476007)(186003)(7416002)(41300700001)(2616005)(6512007)(8676002)(4326008)(53546011)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2NFUkx2M3g4RGRqTCthWnVVZkZyaVlVOFV0WE5LSjhvcUFrakxlb3hjZ1RI?=
 =?utf-8?B?NHp2VlNIcXhZQ1l3QmZiRElWRXZLZkFsODl1K3NiYlE1Smp4T3hCQ0hzZFlt?=
 =?utf-8?B?aG1RN0VsdUVpSFJlOHVFc0xVQU03YUNrcmZsMWRQZCsyMUJ1QUtZRE5ScmpJ?=
 =?utf-8?B?WGRZOHd3N0Y2eHNsQTRNeVhWS0RKQ1ZaZVVQOUUyS2FtTURvRVJacGFwMWxi?=
 =?utf-8?B?dUVBeWRFbEhkbzJLUlo1L1ZOQ1BpOGlkVmFlUlZHMEFhUWFpOHVkeGQvb0J2?=
 =?utf-8?B?N2VVNkE4aHcxUFI0S0kvL3NJcUQ2a1BOK0RCcWZQWndCQk96dnBMWFZNNEFz?=
 =?utf-8?B?M3hvNy95ZjV4M3NJM2ZlRWxwMlo0UTdZWGl0VHJJVS9zak9JTVBocXdYN3pv?=
 =?utf-8?B?SlprVGRLU29rTjlPdlNWQ29yMng4VkVIaXM4VGFCaURuY0FaSlZMajlIOHFD?=
 =?utf-8?B?ZnRvNUxyeDlWVElJWTRqMWZlYnJMd1krREF2M3doNUJZSm45L055UzA4dDhP?=
 =?utf-8?B?ZWZYYkdtNHNka09wQ3VwL2xldnQ1ZVRYcGpUVmhkOHBTd3BhcERzMGdsT3RW?=
 =?utf-8?B?cU1sVUNVTElxVUhGVS94dXJuSzJRYng5bGQ0NkF2RWNMblo2ZzBvYU1sZzl3?=
 =?utf-8?B?Z1Ivd1Y1MEdkRlAvamw4OWNxY3JzVFNKYzRvOTZNdFdzQ2ZkV2p4RTdELzVU?=
 =?utf-8?B?ZFh3bjJ0b3RZNnBodFJRaEhwbnJBLyswU1BWR0V4bzFISHo1VHp2UDNhZzJl?=
 =?utf-8?B?UldlQ01XN0lJcDhtcGlUdGhNMGFHdk04cFBOSEFCa3ZaL29TRjFZR24xdmU0?=
 =?utf-8?B?eXRhMnNZbDM5VVhEN1RZUE1nOWVGZEFSaDROTVBGdmZabGI3ZXk3U3haOXIx?=
 =?utf-8?B?NE53YVlFeUhJenUwY0JUTkwxM2hHaThYcTlFVDFKYjdvWG43QU5FL05manhw?=
 =?utf-8?B?bFRFcityOHBIWHNJMStxV1JYNDBVWnhoV2c2N3dPb3R2OThxWXIvTHRVbUdh?=
 =?utf-8?B?ZzlWMGNMOXVXY2JEQUQ1ZW40MzJjVk5XZExha3lXajZoSWNCUXJkMk5RMlZX?=
 =?utf-8?B?L3U3MDg4d2xhRWI3c0dVejcvUEhpSTZ1UFFYZmpsbmgxWXI2RUtGTFAvK2cx?=
 =?utf-8?B?TUkvOXZocmhORDdKekJDTmZ5UnA3UFZXVWF0T3N3MlViVWpsSEcwTlNwVUFx?=
 =?utf-8?B?NVdMUzFXWjNobm5Md2hiUDVqUmZlTDhyc3lTbzdkdzBpQjN5QzFyRUdPdnRX?=
 =?utf-8?B?eFlaVDRpR0xHelp5bUMxUGJldURtN2U2WE0rNmt5N3RYUHlZdmVQbWtybTNO?=
 =?utf-8?B?WHJvQnc2UW5WQnJ4WlphcGwwVFo4SHd4bk1YNHk1ZmswSkozRm5HYWdJU0Ns?=
 =?utf-8?B?dEVEZEdTS0NnbHEzRmdSUU1uY2srenh4ak9JM2FtV0xJZGVvTlhNbjdtWHZU?=
 =?utf-8?B?a0lSRGc2N3RoTC9xQ0R1TXFYOC9Dd0IrUnhvOEUrb3dTcUdCVERiNzBzb240?=
 =?utf-8?B?dXNmNEtOekt0V1BLZU91dlRBK0lGZGhxV0k5ZDBqLzBScFYxV0tKNEx2bU5p?=
 =?utf-8?B?ZXNxa05yOCs4dlFsNU9kemlRaUxXNER5K2Q1N056cjYxTXVqcjdMU3RvQkZl?=
 =?utf-8?B?eVNXdXRXU0FGa045SFl1RzJGajBDOFozbXl1M1NMOVlGQW5RdndCY1N4QzJ1?=
 =?utf-8?B?L3djenRuWk1UZjJEVzR2NHgvZVpFckxtNkNEd0tYdHY4clpGYytnQ2tBRjAw?=
 =?utf-8?B?akMyM0tXZEFHZGNxZEtmbUJDQVd5aHY3emNYL29qTXJyM0lXMFpoMEJQQ25t?=
 =?utf-8?B?Qk5FcEFOb2NlZ0pwQ0Y1cXp2dFNQditCajFqQVRjRkpKY0pIREk5UlNKejdI?=
 =?utf-8?B?Qy9Cbi8xTVF2cWFYdlZZYTNHYi8vVEE3WUdYNytxZGM3Wk9SYUdIV0UydXRl?=
 =?utf-8?B?QklxbFZGaWFuUkpBa3FyOXlOYnNyaVdJeWpRWFZnbFRKVHM3MjNPSDQ0bDZF?=
 =?utf-8?B?U3JsejhRWTREblNDdnVmajJYTFRwZGs5M2xIZlE1dFpZdjVQWWJSekhlVjI1?=
 =?utf-8?B?QU1HMW9hMklxZHRHdVhvV2tkeTNRY3JXMXVidC9oclFrcDR2RXFyV1dzS3FU?=
 =?utf-8?B?eUZ4bTEyL1hHN1BNTXVoUG5yVkFpYVBkL0JWd1Y0elVhVkY4eUd5TENLLytx?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9720a8-a099-4205-f332-08dac271c48e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 16:45:11.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACcL+nOTWtc4oAA9OvdB6rbys++2ZcMPFJp6wPoQkuTGvR+a5ngEEzY0ChlWt+C1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5192
X-Proofpoint-GUID: sY93e0vLrjtZETiWMU26cUJl-yMTsGdq
X-Proofpoint-ORIG-GUID: sY93e0vLrjtZETiWMU26cUJl-yMTsGdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 6:41 PM, Connor O'Brien wrote:
> Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
> mismatches are expected and module loading should proceed
> anyway. Logging with pr_warn() on every one of these "benign"
> mismatches creates unnecessary noise when many such modules are
> loaded. Instead, limit logging to the case where a BTF mismatch
> actually prevents a module form loading.
> 
> Signed-off-by: Connor O'Brien <connoro@google.com>
> ---
>   kernel/bpf/btf.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5579ff3a5b54..406370487413 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7190,11 +7190,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>   		}
>   		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
>   		if (IS_ERR(btf)) {
> -			pr_warn("failed to validate module [%s] BTF: %ld\n",
> -				mod->name, PTR_ERR(btf));

I think such warning still useful even with 
CONFIG_MODULE_ALLOW_BTF_MISMATCH.
Can we use pr_warn_ratelimited instead of pr_warn in the above to
avoid excessive warnings?

>   			kfree(btf_mod);
> -			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
> +			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
> +				pr_warn("failed to validate module [%s] BTF: %ld\n",
> +					mod->name, PTR_ERR(btf));
>   				err = PTR_ERR(btf);
> +			}
>   			goto out;
>   		}
>   		err = btf_alloc_id(btf);
