Return-Path: <bpf+bounces-405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F47700AA7
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEA71C21216
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9162413D;
	Fri, 12 May 2023 14:48:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF1813
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 14:48:38 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559536A58
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 07:48:20 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C5ACYp005288;
	Fri, 12 May 2023 07:47:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=3mZJD6A7QDSY8FY82xFRHzDBccMkql1ru6abRxG+fd0=;
 b=XbGCwjKsIa61z981cQ9zMVk/nQSyMgK4Rm7TbAyiSyNu2D59yLk4Co5bNLKdx9NAkuSF
 nLQvJWnJes5Y08r8LjtsusDQYXujms4D5w8Wm6x9eLlEZjWW/rKb4pumeTeWB5Q8DQnv
 MSlA0tNbusx6iMqfmkSeUUzIFqMMyUSNFrfIzo0lKBgu0RcD2m6wNIPknZJAnJbFntgj
 uCnv+7mxHaKhST4yDg7/mSoiytY8MnZSboEwnT6re5u0bWp0eCohuFNV/aAwpvR/riEo
 r3WxULjq5KLTBa3vvLsotNkN6adRRVikUZtvhY1dh97mXiuQrjP9+pYkswgLL/uwUrUl Ww== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qh991p7p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 07:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWgn0rjeHA2FwMG86uirPLtAwvHeJeGSaPYlbTlTrhWwlAiZaitfoIjfZNdSHipZXH5qlRFNf9Y1SMDmTvBprML/GRZCA5BdUku4+uumng3EekGK7isNo4tNhhsLszbQ6tUO0xQKRxZ53qTw5Wv5bV2YjemEpIujuKW3u2PXQsefUHlVKwWrdED8gXpUm2EcPqWe475bdQbudkcNRlBcf8TPTKFQkAYi29SVhxKNu2nXKzFqWfMRKaBOnmUhDoLCfklvuiUeOXa7IiVenags4NjWYuat1iU8tVgVfjXzL2wdbmnA35JorH2UMNc4tdPViRhCxC0keQ8+PcVuWriR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mZJD6A7QDSY8FY82xFRHzDBccMkql1ru6abRxG+fd0=;
 b=cRE805PmPkVC9R9B/fN7jEHzvKOEFj7HPPYpvxTSqNlqARnfX/DyvHC0asgLMPUZU5nYGwsslG6ufWARzyZM+PUdRqlgDm+eEJsrq2TXJiGUKH/tMb41EXCDVRkLPongJTyHGnbeBxL5QvA/i3v2ew1qPSq6uFLWSvv5cX0IXU9d+x9hM/y7I0+iLwAEqK9up5jSXnSTTABw3Idy24MKLHpofv+4/ICzJ/UwjPREQMhRCCdyXWu+V8Da9q6GIiHFVNMhTUW/N/tmb4Gqt8Gp7V1EZi3rgNPTmZ3l0+qGcHVzP6bU9E+POdcEhczwevzRKo77HEXFulegicYmERu3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4412.namprd15.prod.outlook.com (2603:10b6:303:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 14:47:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 14:47:52 +0000
Message-ID: <40817aae-bb4b-31b7-6853-eb4d37ca2518@meta.com>
Date: Fri, 12 May 2023 07:47:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next 2/4] bpftool: define a local bpf_perf_link to fix
 accessing its fields
Content-Language: en-US
To: Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Alexander Lobakin <alobakin@pm.me>
References: <20230512103354.48374-1-quentin@isovalent.com>
 <20230512103354.48374-3-quentin@isovalent.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230512103354.48374-3-quentin@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4f535c-6603-45c6-708b-08db52f7dd4d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Kkh0cLfKJJgMuDL4H6dPsbJGhLzivF7GfdqrgC5hf3wNapxXNFCe0BcZ+EMRFZzCHEAU7G7vN4rAUrQJjD/vQAiLlfvrsOeJgCEJ1w9DcpIRfeBXyDk0+UpBCqwYRgqg/CME6JIELmf/Hb9Oy6N4JarYCuZYs4spqKhWDHjTIG7eDBYFc3x+muTBWhRlu8ynWdK8k7fj5zLCKZmkqv9sB6OdBq4IpSHdPLW8cVVDqlKIk53abtHJiXj8ZRA1BxBl7bv/1ThzkJI+4Glx9HJU+6lUXnAT4HiRhn1Fg52woDfgEojq86tuylus0jz7uEwPpvxq3byFcJpPGpZr4+eRlPKqg7yq0uorW+Y+mZhGWRA65zFOiuXZhOSpQucwpZug+ju2vhmb7wlkL0BMJJ/GiFdEaSfFhGSBywr7//BUAtQWU4XQGPVj09CxG3KZ+qofjgeXLWD2YrfgvVZSEfvvpjaMHGLoZdaBhr6cV6Xbjgm00DhirpJ+o2q5yX1fN2L3sPSrNXtUZ/ruuXM/HrZRqUtImOiuS2HNERAPf4NztdZx0JX37TxyTWcYtObf5zagfopPmFQQ14fvkVKHDzFVvZM7dTOA0cTGGTT5D8L4UKFDycPXEQUg0EvCDsphb5NeLIvSUnaNy+HAZrAO9GlfoA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(6666004)(478600001)(66476007)(31686004)(66556008)(2906002)(66946007)(4326008)(38100700002)(5660300002)(6506007)(53546011)(6512007)(86362001)(6486002)(2616005)(36756003)(41300700001)(31696002)(83380400001)(7416002)(186003)(316002)(110136005)(54906003)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUYvcmx1cWh5dkZ3S0pFRHNKbGRMU1ZSREJ5U3Fobm4rb1Q5ZmsvKzE1b1Ru?=
 =?utf-8?B?Qjc4bFNWT1l3dzZITHUxSEF4TXF3eUg0L0pQNWpuVnNnOGNpZFpyK0kraklD?=
 =?utf-8?B?WDJQS1ZtUmFtdFRSN1JGb0NxOFZFUDdRNCtGMDZhUzFHcm5yWkVNelJDTllu?=
 =?utf-8?B?ci9kenZ6YmYvdnU4ZUxkRkgrNURsSFdhRkMvMGhrUGlyMmFXSDBKdzNDQnJm?=
 =?utf-8?B?b25uM09hRGJzOVREQ2E4dnQ3V1NyT0g2OHRHaUJGNWZHY0trY0RyYzJLVXFF?=
 =?utf-8?B?T1ZRNkZxMDA5NHFWVlJVYzRGNFZYZldpeXJGdlM4SU5GV3JUQTBUcjd2M2NR?=
 =?utf-8?B?ZGs3aUF1Y1NxZUFWR0lKSVZmcXpCR2J4bW4wQTBpanZScnp6cERldkJacklG?=
 =?utf-8?B?eUg1ZWZDaUxoaXExMUVSNnZSWEtmM1ZUNHJRK3RuU1B4YkVKSzllcUlaaDNz?=
 =?utf-8?B?VlV0dmNmektFZHBaY09heVpaakhNQlRpeXRtekM5eDZIU0ZrWm41cVIwK1Rp?=
 =?utf-8?B?Ni91L2RON05jckNtbThzdGsrZzR0dXAzc0pwVUZsK05nMkdMWElnV1lvYU5S?=
 =?utf-8?B?OXJJWndEcmRicTZZTElzSVpCOEE3UGtVOTFnUWVjOEdPbzdYM1ZiaitaRWw2?=
 =?utf-8?B?Um9nUTF0cnNnNlpyUXExbi80ZkJqTzl5ZFRXVnBHb1lLV1NPV2pZTEVpU05Z?=
 =?utf-8?B?WWJadHpDSkJ1UlE0eE5nVzl4NDREU1ZiK3J4ZUsvN3YxcGdOUjRQRU9vL1RI?=
 =?utf-8?B?WmVHQnJteTM4S3l3WkxnakFYcDdvcVBoOVI1VHlNOW1UWERUSHdFRURFS1ZT?=
 =?utf-8?B?VG1oeUxCc1grVDhEYnBScEs1ZFR5eWVPU1RxMmhhbHAzUzlCM1lGSDF2UGhq?=
 =?utf-8?B?ZTc4YnllMmovd3UvQllnaTdtNmhjNDhSa3pHYmV1SFRTQVBHUG44Wi9qN2Y0?=
 =?utf-8?B?dXlTd28rM2hHZFBtV0V3U2RvT2V2dXNjbGh5RHhiTzdhUGRPUmwvaGZVRTNQ?=
 =?utf-8?B?VDJTK0JqblBqR056NkJKdjJZSDQyWFlXSVVVS1l1ei9kYk42VmhmVTQvRkJ4?=
 =?utf-8?B?R0ZJaXRjcEtvOHd0U2dTMGgwNy9mZjBBMGVsSUFYRW5LeWJ1ZjNkbkphdmFM?=
 =?utf-8?B?YXRwT3AvaEpsNUd0MXpvQ05laS9ySHh2SDlTTUxiOUJpMjhzZTQ3VXJHZW1a?=
 =?utf-8?B?c0NUUm5iRlJJMGNsamIwZG5vVERNak95Y0x2SDhGdTk2UFh5YTlHQ1VnekxV?=
 =?utf-8?B?bnNsQ2xPVFhBWFEveUVvTjhZS2xqZGlaZUFtQTkxR0pNZlJPaFJrQzR1aWFk?=
 =?utf-8?B?WWxIenpYeVBmNHlzVU95dlBFUFlWMHpIV3AwSDJrNmZVYVVRcmR1SW5TZWRP?=
 =?utf-8?B?aHl4RmRybFBodS93RWY3MmRudTRoUEIrRkRoUU5aN083RW5KWndTQmpwM3dE?=
 =?utf-8?B?bCsyUEdQQmY1aG1LVmJTVGtUWCtndXd2NzZQOG9Rd29nYXVPYmNWQ25PTWVr?=
 =?utf-8?B?UldYVkVWTDUvcnBDc1pveklEdG5kTjdOMmlYZDZFNVYwMGpTSGVQN0VSMm11?=
 =?utf-8?B?VHQ5ck91bGNpQlJWK1dvbnBWblJQWDhxZTB0RCtMSTRoSHlPYUZQMVloYnhl?=
 =?utf-8?B?Z0tLcjExTWZuV1lHc2lJMlFkdEV1OWo3eGN3Nlk4OXhmM1ZCQ2hudncrWUVH?=
 =?utf-8?B?eGVRVG96c1g5dHBVWTJib0NEcU9OODBNMDFPd2tnWUkvTXV6VEJ5bjB1aWhD?=
 =?utf-8?B?YVZhQzViYitsVDBvRldFREFRSGtjY3hWeGxIVGc2Q1dkWWNIaDhreWVrbDVV?=
 =?utf-8?B?NHJ6RDhtNnVxTVN2bkdOTjNqMVB4ZjYxYU1POGxTQU9ZckNBMFEwQklUZ2tV?=
 =?utf-8?B?RHRyYjJtc0ZacFhvWkRUT3RDRjVUQ0JDWGFxSUJ2b0VjT09DSS82UE5TWlN0?=
 =?utf-8?B?UythaGpmZjN0bnFmcWR2dTJYd1g3VEdEdEFUaGozVERUczJGbURkUXpObEJz?=
 =?utf-8?B?RGxhUG9ad3ZxcjE0RnplbGZYQXBlNFN6L1psczZQV2sxWm53c0F0K3pwc0hG?=
 =?utf-8?B?RzJGd0plN3hrNjlZZlpMWXd2VXdsSGRyK3gwdmk0U0ZLRUhFeTJlbm9MQ1h6?=
 =?utf-8?B?L1FvMTZEekFnM0NJSStGUzJycjBxNFlaWE9ialZxQXpGZGtBTmR4aVA4SGt0?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4f535c-6603-45c6-708b-08db52f7dd4d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 14:47:52.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XBdSj9nkuSBiYpG4rpr5LbZoS4NO8WTas5CH4q649/W6MmZ0bjlXyI34qXXWnn9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4412
X-Proofpoint-GUID: 6YkcXEjSf1cbvImiSNCz5mkT6zBQkg6R
X-Proofpoint-ORIG-GUID: 6YkcXEjSf1cbvImiSNCz5mkT6zBQkg6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/12/23 3:33 AM, Quentin Monnet wrote:
> From: Alexander Lobakin <alobakin@pm.me>
> 
> When building bpftool with !CONFIG_PERF_EVENTS:
> 
> skeleton/pid_iter.bpf.c:47:14: error: incomplete definition of type 'struct bpf_perf_link'
>          perf_link = container_of(link, struct bpf_perf_link, link);
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:74:22: note: expanded from macro 'container_of'
>                  ((type *)(__mptr - offsetof(type, member)));    \
>                                     ^~~~~~~~~~~~~~~~~~~~~~
> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:68:60: note: expanded from macro 'offsetof'
>   #define offsetof(TYPE, MEMBER)  ((unsigned long)&((TYPE *)0)->MEMBER)
>                                                    ~~~~~~~~~~~^
> skeleton/pid_iter.bpf.c:44:9: note: forward declaration of 'struct bpf_perf_link'
>          struct bpf_perf_link *perf_link;
>                 ^
> 
> &bpf_perf_link is being defined and used only under the ifdef.
> Define struct bpf_perf_link___local with the `preserve_access_index`
> attribute inside the pid_iter BPF prog to allow compiling on any
> configs. CO-RE will substitute it with the real struct bpf_perf_link
> accesses later on.
> container_of() is not CO-REd, but it is a noop for

'container_of() is not CO-REd' is incorrect.

#define container_of(ptr, type, member)                         \
         ({                                                      \
                 void *__mptr = (void *)(ptr);                   \
                 ((type *)(__mptr - offsetof(type, member)));    \
         })


offsetof() will do necessary CO-RE relocation if the field is specified
with preserve_access_index attribute. So container_of will actually
do CO-RE relocation as well.


> bpf_perf_link <-> bpf_link and the local copy is a full mirror of
> the original structure.
> 
> Fixes: cbdaf71f7e65 ("bpftool: Add bpf_cookie to link output")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---
>   tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> index e2af8e5fb29e..3a4c4f7d83d8 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -15,6 +15,11 @@ enum bpf_obj_type {
>   	BPF_OBJ_BTF,
>   };
>   
> +struct bpf_perf_link___local {
> +	struct bpf_link link;
> +	struct file *perf_file;
> +} __attribute__((preserve_access_index));
> +
>   struct perf_event___local {
>   	u64 bpf_cookie;
>   } __attribute__((preserve_access_index));
> @@ -45,10 +50,10 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
>   /* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
>   static __u64 get_bpf_cookie(struct bpf_link *link)
>   {
> +	struct bpf_perf_link___local *perf_link;
>   	struct perf_event___local *event;
> -	struct bpf_perf_link *perf_link;
>   
> -	perf_link = container_of(link, struct bpf_perf_link, link);
> +	perf_link = container_of(link, struct bpf_perf_link___local, link);
>   	event = BPF_CORE_READ(perf_link, perf_file, private_data);
>   	return BPF_CORE_READ(event, bpf_cookie);
>   }

