Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF340B5C2
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhINRRS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 13:17:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16546 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231254AbhINRRS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 13:17:18 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG25fT002200;
        Tue, 14 Sep 2021 10:15:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7DLqSQFe2MnhDQ61js7quFNLtcebIACvHjhV+8MKzHk=;
 b=Voa1Kea9tj+wlvwKh/hOLlzc3UW/XXYWO08e01GgRcptNHoSqmzQO1bAwOupirXHsdDE
 E3RMm79OGf7AzhLpJUqJ6+bUDVeSGqYBEYpNTz6MjjesYug8HgmINCHnWl+LXoksOVmO
 QEhMUu7z/1Ludhe5P/C4W5N+PuR6CANeHnY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2jmm4jac-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 10:15:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 10:15:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQoL02wAHpD2fCEBeGDj5rdS4nLSW4JgdId7MKAXgJoP3VDcUwGBKxzqexgRG3Yzas97hp7G5rqYMA0tJzukex1CNzpzBKDSQQmXGP2t6/+pcBPzZJhC+/OTKArofawznImWSNQq/7rlwvJ0ySYwZEgykcMwJURazEGutlSl8V5PL/+jaV3Ifyyu0sahw/I+RiXYBMDJ7HMw781hT0Ck/5GbmhqvULt6Ovhlit9UHZokj4wK12d6Om/n0Qt8hppgJ5jnxlt56uoxktrgHvL81nnukMLL5zUzvacGfbfxV5ywDJCUo/QdBfWjR5BMOaQm9B0OUTuOUjj7xqZhWbyvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7DLqSQFe2MnhDQ61js7quFNLtcebIACvHjhV+8MKzHk=;
 b=Bcwo+LHbJLhH3wMcGNy97U2sEJJ+eqxfBOG8SyAtHwhRiUHlIBJTPslE1o1v4fG4x60RpIy2UT2012uCEutQTcxDupJRBhBG7Soe4pBmBUAKfEbcFBhll3hLX25Y4txj0gsGMM1nE2IWkybMlVIWiaEIw/ExL9V85CNKa6ec/wUH8S+1upzVW3yElE7YSjidNi6nYJi2qwiCECkKbZFg1XPb+KR+iUkXNaLfhSvYWC0+EgeIgpLGjP26KXrPhoj2/GUxFE0USVWOAY9ZNmS7lF0r2gqF8MH4pVMZQiZ/q0NHDGhyMIV8sJQITaBFe1AkF5bw6PxrDAvNnTGwJWtD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1965.namprd15.prod.outlook.com (2603:10b6:805:3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 17:15:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 17:15:44 +0000
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: test BTF_KIND_TAG for
 deduplication
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
 <20210913155211.3728854-1-yhs@fb.com>
 <CAEf4BzZoWe33fXy0BBz9zzju3dKUeBL25230_yBp-W38VWAnNQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e9408318-b7df-6ee6-022d-d063a15f0a67@fb.com>
Date:   Tue, 14 Sep 2021 10:15:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzZoWe33fXy0BBz9zzju3dKUeBL25230_yBp-W38VWAnNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:6de5) by SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 17:15:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 255a80f7-f6f1-451d-0e9a-08d977a34950
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1965:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1965E45A6FD232FC7D82BE9DD3DA9@SN6PR1501MB1965.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eo7kWvKMHtABEG2v5qcD3/Pz5lIgxYaQBifjJaE4FBbd9zy4/kyupnRl0jwWCN9nSbjL6aEVFU5YYqMRBEhbrbndo3APgABRpFIHLB814Qdnrcc3d0qIase0UldXL+vJMThbRha07HQ6SAwMCZJfeYhxutgr3NzdDUzba4bkcR3f6GtG4k6l2zpcNSTUC1s7rQPJJMcFqAJwGocKU5LRiS+RZ6hkMuH4BiWv4Wr8xGNMLcs3cYQIESdke0vRDdrQQY0tPlDiYB5tUzxbsYS8Uhm2EdcWs6M6DSQ2eq/kzMzTDVWs/TGtOXcwnOcWBDXGTPMZHLbZTukahTrbDJgHtjQhTiC/tHxJxFgjHTnLs2ejDG1UWH5BSdZt0J/0+bsfEuNOcRkHwf3kFHfRF329WoOvG3J87tjMZUApgzCoBsKng7UhirDfuQp/9btvi75y4+vgJK80SCfRd4BD2XBqocB6iDaPM+wk8y4tHb98RuL0UkiGeo+fkr+x7ZAHnxMmmEgVZFkTF3m1wCL4lBfKKlukh64ZuoZu1keseZNR/hfFSYYayw3NFr6QBXoBsQgDue4S+nHooxXqg3fE9LLbxGTwhI47YS0UMf797Ap5cfv8OhTDtc0tp9bwikkSH/55m7nZARJ0FqoBryf0feq7Sx9OZq/psPXmMlBNanOlem7gBrUppCWXnH6r2DR03WsZ45Bq2m/oUHOFnp9FBfE/nJ+R1dy77TW0LazQKnuO1K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(6916009)(31686004)(4326008)(38100700002)(8936002)(2906002)(5660300002)(52116002)(8676002)(478600001)(66556008)(186003)(54906003)(86362001)(36756003)(4744005)(53546011)(6486002)(316002)(66946007)(2616005)(31696002)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDh3WjlvTFQreHpwOHpibkZDcDlLRjBRb3MxcGQyLzBnVUF5YzFFc1dLMERO?=
 =?utf-8?B?VnNEc1J0aFlYd0JnMGZLL1B3ZWl4TVpEN1pnUnZkdENScnRoMm9uSXlNWWZt?=
 =?utf-8?B?azdiNC9WUEhkKzI3dGVGTVBDeWVxMUxxQW8wUGFETUFsVkhVUjNSbjB5dkty?=
 =?utf-8?B?SExjd25wbU15Z2ZkWHRvUkhxNHF5QlN2bDdYNEFwQXljRzM4anQ2dEdzTHp1?=
 =?utf-8?B?NElvaFkrS1JHYWVXN3V6WXlEcVNsV2tLUFpiNldXME50U1ZaSUdqTkZmaCs3?=
 =?utf-8?B?cnorNTFaaHhBNGMzWTRNNkVMenV4RDNMNHppcTVzdGJDQm5ZUFNvOTBGdnF0?=
 =?utf-8?B?RkZRclVCNkt4cGJXbnEvWlF3bDc2Yjdxc1ZSdmZSOU1hREQyR1YzUnU1YmxO?=
 =?utf-8?B?K0lMbFRtckVDM1FVdTNYcGQ1cXRYQzNoWjBvNnZsSWJHMmIxb0NWQVB5UUdY?=
 =?utf-8?B?SjNYbDZBaHcrV09jQzBsZlJSV0NCOWo4MFZrdWhvWnRBWnA1YlpheVNjL3hT?=
 =?utf-8?B?MFoxTVFGLzlQdm5jTWsxMWtoL0lWUTdONVZ1UFNaRHJaczAvaDhuZE1Yam4x?=
 =?utf-8?B?TUFWUHlYTk40NTkwQnJPeVUyS1VrQUR3UmxkazNKRGxlZktoV2J2NFRGZkVZ?=
 =?utf-8?B?bjlNQjJpUjgvYW04SHVUTU41M25QYVgrOUFiUytWL01rYVFHZEFEbDVXa1dU?=
 =?utf-8?B?cTdzU21vbnE2NGVGQm1aWE00YjI3VVBsNTNpZWdjdXBIQmpzKzhUSnd3b2x4?=
 =?utf-8?B?Q1BMd2wwSGdrUXZWR2djR1B0VTFPUVdEL2U1dFVkSWZMa1dqc3VBR256TUN2?=
 =?utf-8?B?MEpqMnN1UWlkakNJVStLcFJwSDhRazF5Q0crd0w1NXpSaEhramVrTTZraExG?=
 =?utf-8?B?OWV4VTV5TjIvRklrc2I5SGEwa1NFOThnSkVLd0RzTzduSmppMTd1M3ZPbWd0?=
 =?utf-8?B?dkM3bWQ4SDdINU5HTjZoenV4TmQ3RS9TcG0vNjFHYkpiMUk1dm9DL1JCenll?=
 =?utf-8?B?SHAvTndMbjg0Z25jeFp1Y2Z5SE9uOVluRHhURlRLVTM4b1hQRXAxY2I3Vk5W?=
 =?utf-8?B?clVGVXRJaXJhM3B0YkRaUWp4dnE5QU5EWGRXWFBWcW81S3hqT0dCK1B1RjRt?=
 =?utf-8?B?YmhWRitTUE96aDRKKzlUWUMzZkFSejluTXBRbWQvWlZLajNtRWMvVmhReFFi?=
 =?utf-8?B?cXN5RXBzUU9oL1IwdnZkTE5JeWJFa1hJUXpPb0hQQUJGd29GUmZVNERVVk9y?=
 =?utf-8?B?ZGR2ckZJcFFYa0tlY2QzbVk1Sk1SaXJJbHlLNjJYdVJTQlNBNk12S1pXQzkv?=
 =?utf-8?B?RUtESWhrT2RtTGM1WWhPSUF5SFM3ZDhXalFEUXQyWi8yK1dSWWp4SnRnMS9M?=
 =?utf-8?B?eDJGb29CckwyM3paczJ5UU80MGthc0NkZnVjNGw4OTVKWUx4My9NT0c2TUVo?=
 =?utf-8?B?cEp4cnYyMXJCNzZYOTZVY1ZDQ3NrVm9HTmpJUmo2Wkl2Z2xydXZKNnVkOVFT?=
 =?utf-8?B?YlI1UjJjaTVhcU1QNVNRWEdtQ1VaMFF2VncrUUpuNWtLM2QzWEE2NzVVY1JD?=
 =?utf-8?B?WFAzcy95bHRFeGl0QzNUSEVhVnNMTTM5SWhHdUlrRHZTazRzYmRGelprdXBs?=
 =?utf-8?B?LzFPdlAwdFkwYURvSFFnVjBBdmFjME5UYnBRK3owVzBPZlBhZVpxWGo0S2gv?=
 =?utf-8?B?dHR4Q0t3NEpoekRRUEZhcExCZFBlMjlSbFdvN3M0YmhhOUNsNlFyczVuUG12?=
 =?utf-8?B?NFBOQ0dJOGpCSzV4dWwvZ05tR1BEWTN6eGw5QU5WMjR6ZXk0NklLY1RZaGh4?=
 =?utf-8?B?aU82YkVKUThoeUZTbHgvdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 255a80f7-f6f1-451d-0e9a-08d977a34950
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 17:15:44.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO7clii8HwyJTJSfxl+lDWiObGVl/0p43UI/6PUsx6y7+7IcHiuao5Avwq3zakDP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1965
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: q6aJz-5wPQYGXbRFqjJFxcpk-lngyeen
X-Proofpoint-ORIG-GUID: q6aJz-5wPQYGXbRFqjJFxcpk-lngyeen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 10:38 PM, Andrii Nakryiko wrote:
> On Mon, Sep 13, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add unit tests for BTF_KIND_TAG deduplication for
>>    - struct and struct member
>>    - variable
>>    - func and func argument
>>
> 
> Can you please also add tests where you have duplicated struct,
> variable, and func (three different tests), and each copy has two
> tags: one with common value (e.g., common_val) and one with unique
> value (uniq_val1 and uniq_val2, one for each copy of a
> struct/var/func). End result should be a single struct/var/func with
> three different tags pointing to it (e.g., common_val, uniq_val1,
> uniq_val2). I.e., those tags are "inherited" by the deduplicated
> entity and only a unique set of them is left.

Sure. Will do.

> 
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 91 ++++++++++++++++----
>>   1 file changed, 74 insertions(+), 17 deletions(-)
>>
> 
> [...]
> 
