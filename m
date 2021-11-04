Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE6444EE0
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 07:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKDGdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 02:33:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230213AbhKDGdp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 02:33:45 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A433Wd7030931;
        Wed, 3 Nov 2021 23:30:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kn58LJ0BzoXfVSZ7uJjl0tLMafXP2dGz/LR4ZK+r/lk=;
 b=i4ATOhZgLl1gyEwDRl5yPKdB5vQT7DuUwijS7al93c8u4Ee/cKuhhrpRG6sqrzhtpqif
 5s6Vuv7Pi2L17RwFe0dvqM+f4VIGAZVbYkaGp+6NhUIeWmJrLRrDu0ohoclyhzhLfBSM
 H56oi7NTPumxivkPhUn3LQwCSTBNbDv19Ws= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c3ves64a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Nov 2021 23:30:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 23:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuRbFp4FvlhKVXa2tdgper84XR1bUjpdiu8fAYDUyV/XuE5/rPhj3B2MaRuF8TeSOYItIjX1ZVJTSLmQrUfEEuzaGbKyOuX+LnnR/jGeIH8IOm3+zDbX7X+G8tvXnDhYfA17JkyDbKxUjGSk1YBcr5lR5iermHvrhujqr4xL8Yc84kcphkWx5DhUNOUb28epXaQhJqkMmJ38srGsvLqZAgLL7RvBoxeWETjIadepxMwQChLuEzvc+yK+5FbiX23ydoWpzu2tKJv4WJJIsaisssfTlkq4WoC1KP0Loi3b75rCnuhKH8LqNKMJOlQ6Zaq0o89Fqzsggct1gzlOaiF3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn58LJ0BzoXfVSZ7uJjl0tLMafXP2dGz/LR4ZK+r/lk=;
 b=auQtvfmHGkHNVuU93VE+E0NUiEPf9KPn0EI2emzqZjBkrSK0QMrIi1HNUi6TlRizPpp3j5hz62GpCsTF9X//j5CYXGCJPD2InNeZLMSGOrKDKbI/TtG8vKQ2ro6qP9gPBIEvs/r2bO/olTm0WT+UET1K0CzDkgShgIHHiiSHfGlhDd5u9YNk41klppa8PNvaBqlsgSeEkq9G1kexRt6hD9qu2ZKGeR6uXf/FtMQL5kdq75QZ3kipJLnBbbe5rbXqBiyu7FKugEI2TLJbX8mf/9wiRSSC75GWtwvgiHZUnj/rBCr2XJBVdpXAHopfsJSr9N2+yaLrS7DfoiAqGFgDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4497.namprd15.prod.outlook.com (2603:10b6:806:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 06:30:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 06:30:38 +0000
Message-ID: <a71dbff5-753e-b66d-31c8-946851db8d50@fb.com>
Date:   Wed, 3 Nov 2021 23:30:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Content-Language: en-US
To:     "zhudi (E)" <zhudi2@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "jakub@cloudflare.com" <jakub@cloudflare.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a65e2f2b9aa441518000b4741bc29a90@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <a65e2f2b9aa441518000b4741bc29a90@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1253] (2620:10d:c090:400::5:d1a6) by MW4PR04CA0176.namprd04.prod.outlook.com (2603:10b6:303:85::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 06:30:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e402cd0-23b6-4b85-17fc-08d99f5c9db9
X-MS-TrafficTypeDiagnostic: SA1PR15MB4497:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4497008D218E41D6BEF7CC16D38D9@SA1PR15MB4497.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yz0WqoC+XVwx4HVxIq9jH4/v/T8uAbJoylyjnzShkc2i/8M/5O79Jws9+GMQ22x9wvmqbsuSAhftlx10zvoU9oWlE+5x6cnlw1KbtagvsskcgI+A+7RsUw38P9ZcnP8r87038sOeXVpIOug/CUjkYcObrNVP8QjxMfZ2+JcCw2dTBpQOC9LylclIyDevihfucT6oTVBq1DMN3IbrJ6VtSHEOEPa3z7MZ2IeUxim1g+ykUI5oq2sFxHOFUtkHAtHjYatkPoXvtqRRDIP+8cbTINE0qSyGbdMXe3Plg9+uOVdyTmX323qoUt2rSdCS2wxz/QXskNfJ5CAnqCR3W6NWfk7ra0CzWHbBVYd1STgQ7Y2mQWCUL4FPX8lmpoPX5CGO1oAM/tH0ksMOeEnBvGfcc+R1KTgwRTI0J32ulbaBsZvDdnVX/jh0PfnAYuzJD9JPnTde8Tfgamv8pwDJgp2oGoM5A1BmKIeM1Vo1HcIsWQap0aIayvJ5PJdD6IKh2JeMzPqSwLp5GqhG1oEYDiodcNj/khikxPwt9NJ1gN33e68VMnEExzF6Snk/6UEd9uB7uRF85a5gwqNa39rUpCQOUU7Q73I03gtX8rA0oorGV3kCVpKmtI9rjzZUUkBMwDbyQw+z/hfBTuyqYwH9PN7dLjORiNvmMOf1NMcIVza6jGwNUgj7Hh4lzDLzX6xWv+GWQy+xIcrCNR8szqG8IIYHkVMm7hEnWwP2QZnhKcQs5j03UpjaNOwtPpgWpjMxMoIk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(38100700002)(52116002)(31696002)(508600001)(2616005)(4326008)(921005)(66556008)(83380400001)(7416002)(66476007)(6486002)(54906003)(31686004)(316002)(86362001)(8676002)(53546011)(6666004)(2906002)(66946007)(8936002)(110136005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UldZY2UyUlE1bXlLamVvNmVGbFpjenhXS2NyQ0htdkVpbHU0MSt0c1V5ZGNj?=
 =?utf-8?B?MG9TL1dzRmxZUFU0emxXY1F1RnJRSnhNOFFabjVYblBsZGE5VzhQM3o2UzBr?=
 =?utf-8?B?SzlvbTBOSU04QVFCRTl6bGNWYzUveEFtUVpGSmVUMjZhUUtmSHlmME9jejBT?=
 =?utf-8?B?MEl5c0JKd1k0Q0lXWDdPL3o2T0Q5OXY1czJ6a3B4RXkxaFpuYjB4V1lUSEpw?=
 =?utf-8?B?M1JZelVoREl5VGt5aEhNSTB6U1ZaemtURGFjbHdHSks2TEI4VXVBZzdwMFBu?=
 =?utf-8?B?VG1EcjlQazBXc2hrZzBIcENTU2liRzdBNE10NnBqNEJienNEakMwWWZZZnpj?=
 =?utf-8?B?SmVIQUJYUElVY2hQanlvbmxSU21QMktWOHlPcyt0Mmx2STMzbEdnekFXYzJH?=
 =?utf-8?B?Y0xNc0pINGNXWFB6MHdEVDlzZlNuWmtOanlnTDBkZWRURWVuVWhWTE5XOHRZ?=
 =?utf-8?B?RW1zbStjZEFDRUc5QzhkUnl1OENqK0JSa3dpaVlJbTFUT1lQUXZuVWUxcGRF?=
 =?utf-8?B?K3dIMVgxY0x3OGEvQW1LaVN3eGNLcXhSdmx5Sm9zVVVIRFFVUW45djN2SjU0?=
 =?utf-8?B?a3JtU1FlajdadmMzRGtkMlhDaGo1RTJSWnpnOHdWQUppV0NIMFZ4Y1h4eVcr?=
 =?utf-8?B?ZU01T0VaYTNuK3BCQjJuK3A3MjlwY2pWKzlmd3p3MS94SVhiRDZ5bldmSGhE?=
 =?utf-8?B?SmVmVDlSeU5qU2dUTG1mUU5CZ25HY01IazV4YjB4Z1JCZ0xFamhnd0VMbWZ5?=
 =?utf-8?B?OFRmV3VCRldrd0hqV3Nka1k4SVpoTGxGNFF3Q3JVenNTZzRxMDdCRTBDY1RW?=
 =?utf-8?B?VlF1TkNsUXp5MGxDUE1QNmxvWjg1Z3pmVitNSlhHemVmVGdBMVdqcjJSWXNw?=
 =?utf-8?B?cmYreVE4Um5ia2JCMGM1ejZ5QU1IV3N1eGRDOVppbk5iZHpqSGFWQm5mN29r?=
 =?utf-8?B?dUNEUWlqcmpnQVdjRHpPajBabjVQSFBrNmVzRitwWDBieTBiTHBWRHJXbkYz?=
 =?utf-8?B?dWtscUlqa20wNjRST01SN3dXdzZqQmpOTytScUszSmJpQVd3U3dGNVZGZ3hk?=
 =?utf-8?B?UURtMTJGMlU5UnJCalYveXpoMnRpZnM4azRiY2hNZFJnT2djYjJSdWQ0UEp5?=
 =?utf-8?B?QktSZ2dsb2dlSXdkODFJcVp6RXJFS2ZMd3I2ZGdpTDdoQ2hEL3Y3Z0ltY3Vh?=
 =?utf-8?B?M0dvK1R2RjJza21hMXFNQnN1aTYyN1RtcXF2M0lPYTRPanYrcUpPQkxNOGVs?=
 =?utf-8?B?b3dQT3lWcllhZEdvNHYyK2tKcjN4WlF5WnpBMTlwamxpYjRTekJkVDFmZFBt?=
 =?utf-8?B?aGJVUlVTbXV2R3JlVWpQZ0ZBS2RYMGdHajhOTDFXNWNYOHJkZXlhUDA2YXVn?=
 =?utf-8?B?WUhIK1EzL0dKZ0ZnZXlpeDZKWmNTYVhQSnVyZnpqcHpOQUdnZGtZQ09XT3g4?=
 =?utf-8?B?SWt0aTNpZWYvZTlTTWlsamNVQnNwK0hpQ0Q2M2pibm50eHl0UzBRRnJXRmhL?=
 =?utf-8?B?d1FoUWJiL1c1N3JINUhJcWJTYXhSVzhvTEVsN3ZRYTB6OU4yL1JoUyt3YmhR?=
 =?utf-8?B?YjZBZExxKzMwN0NFQkErR09MaDVLNTBsM3JOTmdQVm1uc1RVTERFQ2pVd0ZI?=
 =?utf-8?B?TFU5ZDZtS0lZVWdKNHV4ci8xMEZMeXFCK2NreGUyeXVlQ29GejRCM1VpVmtz?=
 =?utf-8?B?K2h1TWJEVkNhcHhhQ0FTUVpYTndUZHkzQW03ZUFucGI1Q2g1TlpSbE91Z3NF?=
 =?utf-8?B?bS9tbUFMeHl0UFk3cVJucTJlVnpmb3JwZEYweFFWelBDVHdUL2RrU0ZRbzVo?=
 =?utf-8?B?R1RZOEJTMjJzYWl5RkF6TSsyelU1aHA0bEdaY213RDNmV2tHNGtiSzlJWkhH?=
 =?utf-8?B?ZmFKc0Z6Qjk4N0FjS0pSOWFNUk9yS2h5ZDB1N3VxMi9Xc2lnZFc1dU10WlVG?=
 =?utf-8?B?bEN6Q1ErTkxsS0RyWk1PM1JlNEdtOGk1aTlMdU5YMXJVUU9CbTJVc1hjRnhn?=
 =?utf-8?B?SGh1NE9GT3R6Y3Z0V2lPekNUeUI2aHRaZTArQUR1VUtsR1lpbW93dmxjb3N6?=
 =?utf-8?B?MzQreUk1YkZ2eEZGanVlUmNvRTk3bm9MTzk0L3VaV3JVVngwcXF1UGxmWGJH?=
 =?utf-8?B?UE5GdmxvZ0VieU9lTzlTQjFQZnlacHFobkFsT052VUZvSXJYK1hJMmI1bmNZ?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e402cd0-23b6-4b85-17fc-08d99f5c9db9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:30:38.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5yB9SAX9z59RVNL2DMG26LquO4EAoV3O/lOCiuaQ2sIepD41GmbAf8cVE+18FC1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4497
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: W4J-upS2xztJJLUW2vLJPbCSv4r1SaYA
X-Proofpoint-ORIG-GUID: W4J-upS2xztJJLUW2vLJPbCSv4r1SaYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_02,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111040033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/21 11:07 PM, zhudi (E) wrote:
>   > On 11/3/21 6:07 PM, Di Zhu wrote:
>>> Right now there is no way to query whether BPF programs are
>>> attached to a sockmap or not.
>>>
>>> we can use the standard interface in libbpf to query, such as:
>>> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
>>> the mapFd is the fd of sockmap.
>>>
>>> Signed-off-by: Di Zhu <zhudi2@huawei.com>
>>> ---
>>> /* v2 */
>>> - John Fastabend <john.fastabend@gmail.com>
>>>     - add selftest code
>>>
>>> /* v3 */
>>>    - avoid sleeping caused by copy_to_user() in rcu critical zone
>>>
>>> /* v4 */
>>>    - Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>>     -split into two patches, one for core code and one for selftest.
>>>
>>> /* v5 */
>>>    - Yonghong Song <yhs@fb.com>
>>>     -Some naming and formatting changes
>>> ---
>>>    include/linux/bpf.h  |  9 ++++++
>>>    kernel/bpf/syscall.c |  5 +++
>>>    net/core/sock_map.c  | 74
>> +++++++++++++++++++++++++++++++++++++++-----
>>>    3 files changed, 81 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index d604c8251d88..235ea7fc5fd8 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1961,6 +1961,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog
>> *prog,
>>>    int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog
>> *prog);
>>>    int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type
>> ptype);
>>>    int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
>> *value, u64 flags);
>>> +int sock_map_bpf_prog_query(const union bpf_attr *attr,
>>> +			    union bpf_attr __user *uattr);
>>> +
>>>    void sock_map_unhash(struct sock *sk);
>>>    void sock_map_close(struct sock *sk, long timeout);
>>>    #else
>>> @@ -2014,6 +2017,12 @@ static inline int sock_map_update_elem_sys(struct
>> bpf_map *map, void *key, void
>>>    {
>>>    	return -EOPNOTSUPP;
>>>    }
>>> +
>>> +static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
>>> +					  union bpf_attr __user *uattr)
>>> +{
>>> +	return -EINVAL;
>>> +}
>>>    #endif /* CONFIG_BPF_SYSCALL */
>>>    #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 4e50c0bfdb7d..748102c3e0c9 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -3275,6 +3275,11 @@ static int bpf_prog_query(const union bpf_attr
>> *attr,
>>>    	case BPF_FLOW_DISSECTOR:
>>>    	case BPF_SK_LOOKUP:
>>>    		return netns_bpf_prog_query(attr, uattr);
>>> +	case BPF_SK_SKB_STREAM_PARSER:
>>> +	case BPF_SK_SKB_STREAM_VERDICT:
>>> +	case BPF_SK_MSG_VERDICT:
>>> +	case BPF_SK_SKB_VERDICT:
>>> +		return sock_map_bpf_prog_query(attr, uattr);
>>>    	default:
>>>    		return -EINVAL;
>>>    	}
>>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>>> index e252b8ec2b85..0320d27550fe 100644
>>> --- a/net/core/sock_map.c
>>> +++ b/net/core/sock_map.c
>>> @@ -1412,38 +1412,50 @@ static struct sk_psock_progs
>> *sock_map_progs(struct bpf_map *map)
>>>    	return NULL;
>>>    }
>>>
>>> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog
>> *prog,
>>> -				struct bpf_prog *old, u32 which)
>>> +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog
>> ***pprog,
>>> +				u32 which)
>>>    {
>>>    	struct sk_psock_progs *progs = sock_map_progs(map);
>>> -	struct bpf_prog **pprog;
>>>
>>>    	if (!progs)
>>>    		return -EOPNOTSUPP;
>>>
>>>    	switch (which) {
>>>    	case BPF_SK_MSG_VERDICT:
>>> -		pprog = &progs->msg_parser;
>>> +		*pprog = &progs->msg_parser;
>>>    		break;
>>>    #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>>>    	case BPF_SK_SKB_STREAM_PARSER:
>>> -		pprog = &progs->stream_parser;
>>> +		*pprog = &progs->stream_parser;
>>>    		break;
>>>    #endif
>>>    	case BPF_SK_SKB_STREAM_VERDICT:
>>>    		if (progs->skb_verdict)
>>>    			return -EBUSY;
>>> -		pprog = &progs->stream_verdict;
>>> +		*pprog = &progs->stream_verdict;
>>>    		break;
>>>    	case BPF_SK_SKB_VERDICT:
>>>    		if (progs->stream_verdict)
>>>    			return -EBUSY;
>>> -		pprog = &progs->skb_verdict;
>>> +		*pprog = &progs->skb_verdict;
>>>    		break;
>>>    	default:
>>>    		return -EOPNOTSUPP;
>>>    	}
>>>
>>> +	return 0;
>>> +}
>>> +
>>> +static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog
>> *prog,
>>> +				struct bpf_prog *old, u32 which)
>>> +{
>>> +	struct bpf_prog **pprog;
>>> +	int ret;
>>> +
>>> +	ret = sock_map_prog_lookup(map, &pprog, which);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	if (old)
>>>    		return psock_replace_prog(pprog, prog, old);
>>>
>>> @@ -1451,6 +1463,54 @@ static int sock_map_prog_update(struct bpf_map
>> *map, struct bpf_prog *prog,
>>>    	return 0;
>>>    }
>>>
>>> +int sock_map_bpf_prog_query(const union bpf_attr *attr,
>>> +			    union bpf_attr __user *uattr)
>>> +{
>>> +	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
>>> +	u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
>>> +	struct bpf_prog **pprog;
>>> +	struct bpf_prog *prog;
>>> +	struct bpf_map *map;
>>> +	struct fd f;
>>> +	u32 id = 0;
>>
>> There is no need to initialize 'id = 0'. id will be assigned later.
> 
> 
> if (!attr->query.prog_cnt || !prog_ids || !prog_cnt) is met, the id will not be assigned later.
> At the end of the function, we judge whether to copy the program ID by the value of the id.

Ya, that is true. id = 0 is indeed needed.

> 
> 
>>
>>> +	int ret;
>>> +
>>> +	if (attr->query.query_flags)
>>> +		return -EINVAL;
>>> +
>>> +	f = fdget(ufd);
>>> +	map = __bpf_map_get(f);
>>> +	if (IS_ERR(map))
>>> +		return PTR_ERR(map);
>>> +
>>> +	rcu_read_lock();
>>> +
>>> +	ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
>>> +	if (ret)
>>> +		goto end;
>>> +
>>> +	prog = *pprog;
>>> +	prog_cnt = (!prog) ? 0 : 1;
>>
>> (!prog) => !prog ?
> 
> Yes, It's just my habit
> 
>>
>>> +
>>> +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
>>> +		goto end;
>>> +
>>> +	id = prog->aux->id;
>>> +	if (id == 0)
>>> +		prog_cnt = 0;
>>
>>
>> id will never be 0, see function bpf_prog_alloc_id() is syscall.c.
>> So 'if (id == 0)' check is not needed.
> 
> 
> Because we do not hold the reference count, the program may be released synchronously

   synchronously => asynchronously

> and its ID will be set to 0 in bpf_prog_free_id().
> 
> Is that right?

Just checked the code again. You are right. Maybe add a comment here to
make it clear why we check id == 0 here?

> 
> 
>>
>>> +
>>> +end:
>>> +	rcu_read_unlock();
>>> +
>>> +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
>>> +	    (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
>>> +	    copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
>>> +		ret = -EFAULT;
>>> +
>>> +	fdput(f);
>>> +	return ret;
>>> +}
>>> +
>>>    static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
>>>    {
>>>    	switch (link->map->map_type) {
>>>
