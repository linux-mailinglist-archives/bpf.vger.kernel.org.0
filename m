Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810F5873D6
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiHAWUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHAWUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:20:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223A26F7
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:20:17 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBEff014439;
        Mon, 1 Aug 2022 15:20:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oE72AyZGNULE9eQkKuqFmUcAQfBFCZgwiXi8xFkmPjY=;
 b=F7GnVspfUUkgDXZufDo+QPNadFabMBFK+xkUiiHSxBlpd8BZGb2ChoLqp4qjsz75O1r2
 Z5xlhee3xveh0nr7fAuwYSUD9w1bIayHSELBZYrzMlcjuK9IYRqAYat4VdvoMLRHd8Z1
 j2on/joXKN3H+U6M9loxunfI+d1tH3jC+bQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn3y3eg43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 15:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqBRvmPfdZ5fZRlfZZlmBg7skmAl6jrH1aEHKjktAELFQINR5MPTEb24w0El+MAJ9b/8N8tPxyR99iMnWaJ7ege8Ht3w1zl3skrvHaGGPPvVAr/XLZcB2hNfoTpQE4f+F+Lv818Cu66CL0One5xG+/j3QLLm7l8ecv49eOC5XexeE3pYD9LTVbBpvQHIXhR6zQKAuRENjRjDkodEQhxb4WfNiUe/NVgcjw25sWc4qLwk20BmN9CHXlif28v5gclflnoMIB1HM9pVMC5FSj6Ev6mhRCe3s28I6xKvqWGF+LRLUpySuTPC6AiSfJjPY4/cKkxtQ1BsR7CeWdv4KwLtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE72AyZGNULE9eQkKuqFmUcAQfBFCZgwiXi8xFkmPjY=;
 b=h3ZcopErKdHK5XpvvvnxnKpChqO9KmOUGOeMowPqky4sjEHa70yw4EwTfzrnHhwGrQ18PtvEqlC4yYilB1DhtdUsc9k56kVgVuzqcyVrGydQWi4zoXW9AyjOlZoA5htBEtuyjVZU4zFs1ASWQpooRimKbvWSaT8rwX6xiEvJGveh2O1cxPzEEb/2eu4yaDGwHje/OhKIPqFip6b0ZWlejy8cDr6thT7458/5p2ZbRg5om943QypCVJoheC4xVxpiWLLuOiOFhynHEaLY5vxAcMOs1ZdETu5dRaq0LFbMmZeozvE0wyvC3m+V+Gw8gIk+j54GZoltRXP2v+0h5mleGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by SJ0PR15MB5279.namprd15.prod.outlook.com (2603:10b6:a03:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 22:20:01 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:20:01 +0000
Message-ID: <fe588859-6318-475f-39a7-07c6058169e9@fb.com>
Date:   Mon, 1 Aug 2022 15:19:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 03/11] bpf: Add rb_node_off to bpf_map
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-4-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-4-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 693ae471-250c-4da4-56a0-08da740bfa1c
X-MS-TrafficTypeDiagnostic: SJ0PR15MB5279:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8ipAyXwkvYX+KEc7qaET+K5V5Mosla9QczLONgL22zq/FsZyYzRrAqOmoJRjHf0xAyFk2Jr340YbC9wFMGoKqHpBFVfG6WTuBv13VlCk1iBD8Qy4FgNF8sYOYJYWv9feSdm7BIdFPnxYW1mRG/dUXbdIyXLI0kI8x2MmFJCdZls6Q565JyHkt5VEDm23Y6G1OhxpA2wReJ9KTL0ZGDTEfQtSZ4CUuSjPDLGlbrfWlvqP+Q6zJkv4ypOeuaGhseV0EoIKf0xCxSegLzeBKeBJWeVSwPzm1s9lRTrRwG7VTpFiXSmVmr1XyfbywzEyIf2Zt832Z/d7l3eEmagCxdCD0LLqzGNldhMDP6+OIo4F1gE3qOpeixSYrUiP49fJmJN1WPzj0aPI4Ne2NQzOFp0sFkXHWw8XJq7UewUVjHN6OFzWyP8Ve9ulkGDUVVvx074P1cENRJ0/8UhJnwzic4DkEUc4dWkOJVnSn7lL2bZstKLb9i91/NzV/EoH/irxVMBaBEuuZkJ/0WcEYGQUUmdoecRZVFPtgOFwXIhHFPJnFegWL169dZO2Zd9cQdDFVthWF+7rF2oKHXvz5IHpfrFAFaJNHRqlQFnotZi4Gm78YPw7ZqnJQVnu2WG7wrNo0IGGkwmZUCNN7Tf5K1llMX9CtttRjzjwRjGoPjh693WtwO7s9A5RbOAa/BeTeMvzjxOCFGeWugLidZKObf8qmWXs6kWeoUCQKd1ukOQBIeeiOhsTBRp6+wudtCOHBhwuCQm6tUxCcaCXTDrhm6V6noPBMY4dMFgQLSTzVXTMmmxPNUdrV22iSsYJ0kfOD8zVo6m4yLjuJKIbpujJ1lN3zZxLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(2616005)(54906003)(186003)(31686004)(316002)(6512007)(52116002)(53546011)(6506007)(4326008)(8676002)(86362001)(478600001)(2906002)(41300700001)(31696002)(6486002)(66476007)(38100700002)(66556008)(66946007)(5660300002)(36756003)(4744005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGhHeHRrTE9SNHpJaDIwbElxbmVFZ2lIWk4xS2hwMmMwc2hzaGl4SUx5VEwz?=
 =?utf-8?B?R1IyS200VHlXc1ZBWUhyUy81ckdidjVVa3V5OUFsbE9YSm9OV2tNNzR1S1lz?=
 =?utf-8?B?UjE2N1YzSEhEY0tMZG9rUDNxN29ISnVhQ0dsa2ZxTW9XZVRTcWxyaG9aZFFF?=
 =?utf-8?B?UGxFeTRjeUJvSVV2Rmh4RUFTTTJab0pnSnAwQVhQc2dOR1hHQUFtN1FWNmt5?=
 =?utf-8?B?SGlBSDJSVlo3RlVVaVVrQm5YdkN6empnUC9HK2Jzem96cGU4ZThiT3VqZzAx?=
 =?utf-8?B?aUU2ZzRkNFNqSU1OTC9YeXpMV0daMFl6cTJSQWpRczhNcEZOeWYrUXZJZFA4?=
 =?utf-8?B?VHBkcEpKZzRLbHdGYmVsbjlGd2p6T2hKelprUkRCN2M0RWVwekNWUmVJdVNs?=
 =?utf-8?B?T0laUFJYdjBxVkpCZDdsamZqNEM2Ujh5cDh6WWQrR1pOWW1pZFFwQVl3UnFQ?=
 =?utf-8?B?cmV2WVcrVWs5Q2tmWi9yV2J6Z0MxV1AzRi9FS2JIZUxUYzZ1cHVMOWNyR0E1?=
 =?utf-8?B?SURXQUE1T29XcURmMFVzUWllTnF4QnpDbkFNZEdBWHdGbjZLdDlVcVR4S2lz?=
 =?utf-8?B?azlrSld5dHZhY3Z2ekhWSlpiejVhcG1tc2FWRjMxblUzNngrWllic2xzQUdY?=
 =?utf-8?B?cW15aCtzaEt4dGh2VzgwNTJmUXBRb0dzaUovek16MjM2US9OWG0zRVRDVlBk?=
 =?utf-8?B?RGhFQnZKS2RJcjZQNWVIT0FvblMxZEJDVUR2cUtBN2hLeS9aWG9pbFhoTS9z?=
 =?utf-8?B?LzM3T3hQT3NTbGpHdG1LWVhVd2FIRlBjc3ZVV3Q0N2tKU3RqZGdLeG00cTcv?=
 =?utf-8?B?cFlvWkJFRzYzZXBKVkdrWllVQWRwUUJKY2lTSk9nTGk5OUgwSWhQbkpBWUhG?=
 =?utf-8?B?NjdDeDg5RENROTFYUDBxM0ttbVlRSUdyaElBTjFJQ0JxTXM1aUNaRWI4RFRF?=
 =?utf-8?B?Y09UNmlSUUdLK05YaXBNUnNHODgxRzlXdEE2cFd5cUptTE14VUc0dHpPa2pv?=
 =?utf-8?B?R3FWWTYyZnZhY1MzZTUraGpGUzRTUTVmVnR2RW1hRFJ1c012bzZCWnlUbjdI?=
 =?utf-8?B?aXE2bHdoY3V6OWM1cUhIcGpsNElDR3llYWdpZjJ3Y3k1N0VDelN1ak1TeXow?=
 =?utf-8?B?TTExVUxvcWxaM2piVk5UZ2QrTmFwaVNLcnQ3dnJLU1dseGxDT04yOWp3M0lK?=
 =?utf-8?B?M0p6cEpDbFRDaFYzei84aDhTeEJUVzFjaytPTWN0R2cxK2FqK092R291bytQ?=
 =?utf-8?B?Tyt6S0RrT2s4RlYzVC9uREVCamRhTG05TTI0UkhEQmZLMEZNWCsrN3VRWTlC?=
 =?utf-8?B?cUY0MklTaGpYTkY1M2JJZ3d1a2ZUYW9XdWdOeWF2Vkk4aDMrMEdybXp6NVo2?=
 =?utf-8?B?VzhkbEtwWER4a01YVGpNeVdTNHNPL0VYUkhWWEhhTVhwa25EeWN4K1VDKzNl?=
 =?utf-8?B?b0NlYmJjSjRYbmlKZFhmYkpXOGhiRndLN3RRRVJKVWVOdlJzNzAxV1hYNmkw?=
 =?utf-8?B?UWtET1BTLzBseHRRY2lKcXNWallUT2VVSzVITE14c2w5S1FPWHhFUWRtVUtI?=
 =?utf-8?B?UTF4VFhmZVp6QlJsT1hUazRDYlBKc3kvZlNwTUlEU3ZsM01GZFlsS1pFZ0xR?=
 =?utf-8?B?OUJRZ0poRUNZbXE0YVVod3A3aUowSUdMOGRTcDluN3hLM0IrcDE4aFJTVnZq?=
 =?utf-8?B?cXpaYjVnY05ibmU2TEU3UHZ4ZEhqNXNQNmcwRUFxNGNMb0dsUEsvN2d5UTJJ?=
 =?utf-8?B?QXhNM0VsZ0V0Rm9rNWRkR1FxbjJvdXRuaTNKVlRYV25udWRieDR1aGM4dHVN?=
 =?utf-8?B?bTIrU091U1NleDdsbGlRbHpPRldrRWxacEMrZXdxMnRKVzY1NE8xNUJjNVZR?=
 =?utf-8?B?bFpkMVgrZU1xVnhJU3VoR2V4c2VxRnNraExOQ2pPY1MwdHBmY21GZjJKSlFE?=
 =?utf-8?B?UmtDRGhrbHkrTXdHSFIzeWdLdlE1V2hHOTRzSTJvQWxYenhZVGozOHgrRXZx?=
 =?utf-8?B?d0tFRUlQbGFtRnlKcnhYSi85bWQ0N1VuRmxWZHJ1djZqVzd5T0xnYklRaXV5?=
 =?utf-8?B?YUJyQ0dzQTZRSElYaWdidHV5c3RkQ1QwSnNCZjRqdHFMRGR4ZGdSY0w0REUx?=
 =?utf-8?B?ZWpDSnArZnVodDNRc0duTlluOG5uT2RrcW1BK3RySzRkRmFUSXNVQ3h0YWtY?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693ae471-250c-4da4-56a0-08da740bfa1c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:20:01.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JY4p1rrv/qfZPmpMLSp+ExA9uNvG1zwzrIuWrVKc8O5XojTklFyB09QPk8EuhB51
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5279
X-Proofpoint-ORIG-GUID: ra2DxiO_WVjSTAywrD4ydVAWoNN3UDj0
X-Proofpoint-GUID: ra2DxiO_WVjSTAywrD4ydVAWoNN3UDj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/22/22 11:34 AM, Dave Marchevsky wrote:

> +	case BTF_FIELD_RB_NODE:
> +		name = "rb_node";
> +		sz = sizeof(struct rb_node);
> +		align = __alignof__(struct rb_node);
> +		break;

and its usage in bpf prog:
+struct node_data {
+	struct rb_node node;
+	__u32 one;
+	__u32 two;
+};

may break from kernel to kernel.
let's wrap it into bpf_rb_node ?

