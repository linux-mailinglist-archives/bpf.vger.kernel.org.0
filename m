Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509995A6893
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 18:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiH3Qlm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiH3Qld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 12:41:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A1AB4CC;
        Tue, 30 Aug 2022 09:41:30 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UFxLf6021056;
        Tue, 30 Aug 2022 09:41:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YQWMvv73ewq94/MYy9Z9O6tZEZ8CWiIFUI7gsQ2259c=;
 b=C/N2ugmPc9uayDn0BD/tIE+EreGCrR5R9NvfPei5DyDuH0zT5nXaoCejeEm4X/0+EIEZ
 XjT4Y2dPe4fNJ60H9ZBQ/HyMPdfdOUTJdrKtfkUGftwueroTERXNgHRU8Yh9ySFiQ9B6
 MJDZNzsLFkZGe/OC8fwbATveVzVppUl3XZ8= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7jk4shex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 09:41:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyMZ1ss/LlD5Sw0sroaUzvC/rKGQYGM+Z8Sz+iDdxzHjbGpIZ5dGlyFDD0HyPDuFyMLVNrqWPH9bWscbF8o949/aRfpkZrQZWU4HU49E2z8BV3ElBl7wqdoYS8MaCaZ8EHeJ/s8cHfwU60qtwbATxAtuLl5dmDAy9B3gLUfq+VqujIXNVWtze4LzHqr7XY3+VAYEhjkyZsZm+dtZOK8xNsPpE4VXucZzTRbBH/hDFyGHbFAacLU2EMkByM/S8L/VDeJmHnYKze44BNwJD/7YFY38Rx9nWxGNAE1FxvS0yyVXa3p4eJaNnerG3xi61ElxQ4bqS7fPnvlttPu86JxbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQWMvv73ewq94/MYy9Z9O6tZEZ8CWiIFUI7gsQ2259c=;
 b=fY+aJHx0qsbKq8jtW3XcfootFaQGQdi7Oh9v99e1x7a38pwf6bvSOrxRSZimM3HOefVeZs43LchRhaZgTVGLV/d5u58N2Ku3JuAVZ8LuZOz4aaUg5OSVpZzpNb1vePowXM9RTXSZQ5edaU/LxMyPnLrCz4UMwMEm9gt1NGq/BS7DFOGlj7t+i7QOeZ9qmcivhHQqkBgq8IzpFIH58T+8dbD3sJ1j8qi2yNvxTzIpC1jhKBtOOwuaLZQEkQ1lHTVAFc9wfl+asY3TP3XYhce1r6b3GOdtTLwieuMOZPyCVhlO1IOGNjxHQKCvBDWgIlhEl+YcPH1Iz+hif5Eh+obNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1584.namprd15.prod.outlook.com (2603:10b6:300:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 16:41:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:41:09 +0000
Message-ID: <c84fa46d-8f37-c449-06ea-5da795f091e8@fb.com>
Date:   Tue, 30 Aug 2022 09:41:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for querying cgroup_iter
 link
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20220829231828.1016835-1-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220829231828.1016835-1-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71ad9c88-afb2-4d64-e378-08da8aa670bb
X-MS-TrafficTypeDiagnostic: MWHPR15MB1584:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSOSvXxIklYtadC2rncQXOf7z/gTVJxw2MTB44eiy6xs97Oe5eI585OAXXgSL6JSo8x4hN+EzWE+RDCbJwOHNHSS2OA4dfaidz+w5yz2+GSYBT0JNNf6CrwK5rojKqIJF1kNdpGxVV4hacM4T1c2X/NFHzJIWNKyLWAuiScQZXVmUz3DgXhhRXU04FlQ34XyVRfiFuwJ9jgZmqWOcRMB4gL8/id2rQUYw4xODhxa5bCc+EVhkdbP2FCbHykr3evVexgHDunzojjs+rY6JYGTTL4F7DEdB5JN/Tkw+7vx3mz+5YO/Rw+zBhn5ZqiG5JGlQ5MefxiimSsvUXIaEPqFWMDF6VZ8NbEYkhes0k3L1wlPFx0v5MC/93ksJqT5lhyDeDlXKBPQpgJa2N+Wxl51tpD7YMQnJby9W3JYTh/tZO3KnhB1Bfp1UAXrrJNlWvBou1U0VYJ4DtEiZnQLGoHHLgxGOv4fuYQtF06JHGrZkbupPC204YTnQmHTRVzNtHjEypODctkXPinyARBSCsMX98wsl0OGikNrP0+P+TGPgWluWU5MgFF4QyLZIIM0SkEGHB0xcH6yYwUgSdYLa/miw7ULZZnzAm2jf67q0cThtOYR2vA1LWSORhCnmlpOuDqWdYSC6EKlD++GL34GCbUI6omqAfnfhdBEVj12oDdyY2LxT2MYSkwEz42w4ZetsKBvkpMgDh7rSzDOy9vw3Af9qVlvXZCn0yrNgWo0AC/wi3u4LqEkD0v2YA0wauX0A2rrD+tIdioezLjoXoa6u+F9eyOl/4W7W65Xc/Jm4o/bZQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6512007)(4744005)(2906002)(38100700002)(6666004)(53546011)(2616005)(6506007)(83380400001)(186003)(31696002)(54906003)(31686004)(8676002)(66476007)(6486002)(66556008)(4326008)(316002)(66946007)(41300700001)(36756003)(86362001)(7416002)(8936002)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amI3Z0FGYVoycTUxV2lIVHBKRUlHdzBvSHRTVHZKdmZCZG9MK01uUnIwNnNJ?=
 =?utf-8?B?N3RiTkJiREdXUnlhV1YvWU9HVTNJU1Nvb3pEM1NEYXFjdzZiMHFLVURZMXNq?=
 =?utf-8?B?d2lRT3RlV3AycEVucCtaZVVKdXBuOVBPWG90UURRaGI4b3NUdldKR1hJSTBq?=
 =?utf-8?B?MzRnZk5vQXc1T1NHd3FkWWVQSlAzWEJBeERTM1BNWHZWUHFBTUpZZDdVTHQ5?=
 =?utf-8?B?b25EUXc3dXBUcDdtREhidHo2aHptMHJkd1J5QjRlejNYaGpDM1BLa1BmNis3?=
 =?utf-8?B?cTdkdmVxMDFxVUJCSUZHRmNaK241ZFFxbzdKRmRKbkQ1QXdoa0FGeEFaMVZY?=
 =?utf-8?B?YnZqd3RJNUNjOFJ6UG1VZ3NOdXZmWTkxQlhIcFNGaTJ2aUE3MkhVREhPb0hp?=
 =?utf-8?B?SVpqWHhVRlBac2RuWkFtQUNsTkVkUXBFbEx0bXhCKzZGalJmdGROWjlKb3Ux?=
 =?utf-8?B?Ny9mdGtZUnNjSUtsWXA1ckVDMnNxUTIzQ1h4ZVJRNTNqSTVQblkzSHd5djJE?=
 =?utf-8?B?SW9CdGZZQ2VtMVdvSUFIKzNIMmpKcXZBOUVIcHgvT2MyUGN3a05PMVdhWEsx?=
 =?utf-8?B?aFU5YWNQNEMvSUVzOHdCSUVXTjd0L3hPUXlXZnFKUWxOQURYMzZScXFUOVVw?=
 =?utf-8?B?UXZ3WVllSzVPOVJYNDNXQm5FWE1sYUxteWl3YnJIK1N2aEp2b0REdCtLOXN5?=
 =?utf-8?B?TmVVbWVKNm9hVjduWXR6TUpsMnhFZGw3UGV0SjlaZU52cTVpLzdScW5NN0dv?=
 =?utf-8?B?a3hFOHBGWWhOWitHbmd4S2VZNTZqZzcvazg5UEhQV0Zsd2tROWNxcjRubWo1?=
 =?utf-8?B?LzJlNm1MS1hSTE1QZERVQmJrZnBYQXA4cG1WOTRCbG1zdy9lLzZnNnpxaFk2?=
 =?utf-8?B?TCt4MCtUMENOT1J3eW56dHFTUGJKN1VLa2dmR05YVjVnWWNnWlcyVHFSTTY3?=
 =?utf-8?B?emFhMjFRYVE5aFppdFlyT1g3N2ZNdnlhMm1iTFhqQ0hWQ2Q1MmpMemw1OEUw?=
 =?utf-8?B?cGw1SjkrQXgwRWkvUk5uVUYxa1FyQ1lHeENIcnZnQ3ZkTHhGZjdMci9XTUpO?=
 =?utf-8?B?UVdOUTdMeFZoMjZzSDJ5TlRLZVg4Vk9Mb3o5cUtHck9lZmYyLzlncmtTNHpm?=
 =?utf-8?B?Yy9vb0o0Z3JjYldrWWFiOEUwTndGQzErZ2cwZFJSUlRWc1E2bDNpWTJ2SDE3?=
 =?utf-8?B?Ni8xR0tqV3Uzb1N1Q3ZXUHU3K3VmaHQ5VXQ3Tzl3ejhVUjh2K3EwbnVIRlBh?=
 =?utf-8?B?R2czM0VFVnd3cjR5N0JUOUtaQWdISUVFdUc3VHF3eVByMUVuVE4vZ2RlYzlJ?=
 =?utf-8?B?TVI3N09KU05BUlYvNUMxaUFhVGtoMW9sY1BoZkVJQWtlM0hxd3pnTzRFSjhv?=
 =?utf-8?B?ZTNvbndpb0V5N2Jnc1NVM3h6dGk5RmRnSUVoRVlOY3VjTFpmbzJ4am1xcE9l?=
 =?utf-8?B?aHFpWHcvankxOEsyeVhNNzRnaFZmY0lVWGxHWGE4R09hS1RoOElFdGx0czVB?=
 =?utf-8?B?WFpScGpKMW1JdFdMdUVxUFBLeHc1Z2ttSWlkTGM1UzJRSlk4cisyK1dDV0J0?=
 =?utf-8?B?dWs0ZHhGZzJZMjB6UDlYSHREeUxLWUVvaTFmNmZmRjltUHRPUDdnWWJIT1Z6?=
 =?utf-8?B?Zm9MQlV0N3lHVkdzUW8zZFJxVUJiS2QxSmo1eVNyeWlCTmxoUFluUEZ3eVl2?=
 =?utf-8?B?UTlra3ZSWDArWngvdkg5VEtYOG51NHpTOTRVMURyQVpHOENkcFBWVndOS04x?=
 =?utf-8?B?SXBaWVg0TDJRaTdPVzlLSFB4OTkrT05nNUVIOStYVG1BZkZlWEtkc0kraXgx?=
 =?utf-8?B?QjV3Z0I0dTcxRlNqajVMaHV0MzVESlN4OTloSGhxZE45TCtNR0pXeEU3c1dv?=
 =?utf-8?B?aW82UTRUdkp4YXFpYlVxb2o2K0ZpOEMzMkRRNmgwM1pDcXYzUTdYWVBqWDlW?=
 =?utf-8?B?cXBucngyVnUwRlhNT2dvT2xIQ0dmSGRIUkg3cEpRaXoxSFNvN0FBbmJBSitv?=
 =?utf-8?B?ZVh0aW1EWkZkY1dLYkw2UjhDeS8xbDRUYyt4dFpGSC90Sm11THVKd29KdlZG?=
 =?utf-8?B?eGRCZXNuZXMzVWtEVVNaRklEK1F4d0VJS2hPRUozbDNJQnRrREFUcHpReGJv?=
 =?utf-8?B?NUszZlhtY2hpWmhJcXhmU2VkVi92cjNHdEVlMjJTNGdWL2ZGRE5OdXJmV0JU?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ad9c88-afb2-4d64-e378-08da8aa670bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:41:09.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31qv6yrnTTY1u3GLxkC0rxnsIqkZi4EmJNDKJ+fsmIQYFs5iefQ12Ll9HNg5QyCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1584
X-Proofpoint-ORIG-GUID: Gi3FLUjfe3q6GB1a1ur0kaR5FHe8OvGn
X-Proofpoint-GUID: Gi3FLUjfe3q6GB1a1ur0kaR5FHe8OvGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/29/22 4:18 PM, Hao Luo wrote:
> Support dumping info of a cgroup_iter link. This includes
> showing the cgroup's id and the order for walking the cgroup
> hierarchy. Example output is as follows:
> 
>> bpftool link show
> 1: iter  prog 2  target_name bpf_map
> 2: iter  prog 3  target_name bpf_prog
> 3: iter  prog 12  target_name cgroup  cgroup_id 72  order self_only
> 
>> bpftool -p link show
> [{
>          "id": 1,
>          "type": "iter",
>          "prog_id": 2,
>          "target_name": "bpf_map"
>      },{
>          "id": 2,
>          "type": "iter",
>          "prog_id": 3,
>          "target_name": "bpf_prog"
>      },{
>          "id": 3,
>          "type": "iter",
>          "prog_id": 12,
>          "target_name": "cgroup",
>          "cgroup_id": 72,
>          "order": "self_only"
>      }
> ]
> 
> Signed-off-by: Hao Luo <haoluo@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
