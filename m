Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085324AA265
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbiBDVg0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 16:36:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233101AbiBDVgZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 16:36:25 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214JliLR022970;
        Fri, 4 Feb 2022 13:36:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dPu6ZNYj+WQ5mZTRuq9gz0f3/0m8cR7xFJwmIULAeu8=;
 b=OtkxR6ypoTlTgIAgBNrzYezWBpM25G3B+yAgXa12aE3tkFUzX41iuQYGp5EwjfnfzyQf
 NdoUtr6An9FR6gPhfSnbmtR/fstypui+Gy1ib8CSiDQh8JpqrHWlkMdD2Yx8ljcjDDjg
 VZIVxG1lB5M/S1jovqQuzgTJ/TlWsnTAkdU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e19gas4ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Feb 2022 13:36:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 13:36:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt4+vOV14Yw/nPQAKGR/DPPDweQ5d3M533sBQSnwflfU7iFZtwF2QJ0eNKYrjh+8xrPywrAGrCcCTU5VpuG4xjy8n+V9+x5KQ7nx2c31cp8WsRIV0DiM60sZbYCqgHMhFOhuq9VmzzWUzXT3tVS2OPZaVJmSI12bhbV7oGggr9cm4Q1BjW+ExSiombPoMa9K8IqZ04Q/YDhev4n2Gue6G9LvPDu0X3y+IXrsKlKoS5uEks3nqBNEDrCrtVqzmB/LhqL7kvEwH1sZnARbPLDbO+jK+yHi7acsn/uTmOxVvZ9AEIXjMQiQ/4vESxB66yIC4UOiQTvKmTrTRVpym0MdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPu6ZNYj+WQ5mZTRuq9gz0f3/0m8cR7xFJwmIULAeu8=;
 b=Pmg9KDSMH+chmcsL2dUjGU24UPz5hrxYgVyl8D/xYlR1/0Ac3+jLBqNk/GgVGXVa345kSgMvip4e6DmQNPBhzN0VHUyrP65nA0huBbQpFSqv5BbJd4BcjdQDaWZ1x3NiKbjRb7TCzEl1C8QuF7DSIjLPgXNAiOI0Vau86RvSEokpbvB4fJTSDauT1oqjt2Z1UWC/z0ILM/qJzGvuLpb8QJXY7+eAK57YY8NtHFOZnwIEgYfYtBrP9kAG1/Ul+ciIJPBNtF3ItYiwmzsOah6CXPXP4qd8X3sSHMhw6iwx0beoC324hwBW7n54fpigcYLiV5YBIKCbGstBdHHJJlunJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2294.namprd15.prod.outlook.com (2603:10b6:a02:8a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Fri, 4 Feb
 2022 21:36:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 21:36:05 +0000
Message-ID: <52770cbb-d600-340a-0120-c023e93378fd@fb.com>
Date:   Fri, 4 Feb 2022 13:36:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next] libbpf: fix build issue with llvm-readelf
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Delyan Kratunov <delyank@fb.com>
References: <20220204211302.302066-1-yhs@fb.com>
 <CAEf4BzZOYAoHtH9HT52j22FHj2rT=RJpZHK7ZUoY2cvrmbuxWw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZOYAoHtH9HT52j22FHj2rT=RJpZHK7ZUoY2cvrmbuxWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:104:7::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eba48a1-3568-4729-1282-08d9e8265906
X-MS-TrafficTypeDiagnostic: BYAPR15MB2294:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB22941C140B715F74F56E7B5BD3299@BYAPR15MB2294.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD49ZmRigxF7i2XXUmORy1TQTlF7ZEAwoxmzZ+E2sVJzYegPXEAz9w3NySkpGfCE4xZi/MEWhndOzB2NENlAnlQDy81YettPi31HCDQqSDqxB8vNd2XIiLp7cZh/U5jTrCfK6/ligUNm0GWsP/nCLFpY0WJufHGo9ovkHIwr8i64pQrvsZEbqQws5e2HHPMZls+IEFLFGIS6dSvc7cMGeguSsdh7NjnP8UOFFBl8DtnEKl+71Omce4I2EJ/VFR+ih/GrU3gaQ2lNDCDzeyUEGc6Fzl+QksQ9sj6yKtozb41nkxGB7HcNIilFr1FSl3fepFo57y/BNpEXHcDGf6GmZzDbMpYkW5arOnvuV7nUw4V3ryYUzJuougKi1N3FluHfK8274zIH0kRMQ/Iat1iEPl4Z1SMd+t4hyt9c3JKA8685P1fBtWDMG7h5pgm/r+VX0qpApxJ5nqpnZ95h11lHLl2k+DXE0UTnORPf/Xh2Hu2v1ssCGGJO8//jnSDe2pA5s5NJo/ezkLL4MCGEX1XIDv1OvaLH8SD5nBFeP9SlB1d+CvWQtip1emAoeF6Wu/NxrwMb1/qtI5MRgPcp/g8wlrJs/bhqZ+xmtydf3b3g7RDi1WcFYbi4LbGKfuaBN9l2c295yQxwr649B1cJU/ZUeyoG3YtaT8nQhBxZm2zIpH04jeDqNaTa0ufKyKA3mk3iodOlGJ2XYhhDFK6lK33T08nheiU+khtilmvwVToXZm1qk+TVPH7EuxoM2PPd4uZc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66946007)(186003)(6512007)(8676002)(66476007)(66556008)(4326008)(36756003)(83380400001)(53546011)(52116002)(38100700002)(31686004)(316002)(2616005)(6666004)(6506007)(31696002)(86362001)(2906002)(6916009)(54906003)(5660300002)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5nUXpzcUhXV1VLUnFaV2paYmJicUVhUEllcUg3QUxWNWlhOWRBMzczZWhD?=
 =?utf-8?B?VUQvQkduYlYyMlZUbWpyczluQk1JeFFxR0I3czMwMEhGczFzaWIyempRSEo4?=
 =?utf-8?B?Q0dEaXJnY016cThmdzJRYlRFRENYOFQwU1VUdnRobjY5MWh5c2c2WjVUQUV2?=
 =?utf-8?B?YTNhdmtQckp4ZFBKY1ZTV1E5d2FpOXFkYjJic0FIbFQveWVCUGpnRTlXRmlq?=
 =?utf-8?B?Mzg2SjVidGJXd1dhT2sxTk9uVmpMaDRyNjRybHphRlg3MURpZWV3RlYyMm1S?=
 =?utf-8?B?VVM1SlgveDYwV3VnTWZJT1E2K0ZsRWV1bmp1dHdUaVVrZWY1VkhoMGtxMmlC?=
 =?utf-8?B?VlhLcWxlZjJNM1NRRWJlY0cyVzhSVGhLYy9WU1BsMVJVTFgrSjNxKzVnUEVp?=
 =?utf-8?B?aCt2amdqYnd0Rm90Z2cxK1hDdXJvRG1oSDkrL0M1NHhCM2lZYW1qdFR4VzJp?=
 =?utf-8?B?TFB6K293TkFvNjBhWUFoSm5MdTk0NGptTkplTzdaNWg2SzJJZTVHMjVQZWJ1?=
 =?utf-8?B?TUhReUd5RVZxNVFWdVAxdVNyNHZGUWRUaWJCQlpNUnNZd28zNG1uWmd3U0sy?=
 =?utf-8?B?ZW0zRTJJUUhnV2U2NGZwbkpJSnFuZlVXQlBKY29SYk9MSFRIdlFvTWhvamZR?=
 =?utf-8?B?eW95U0ZwZDBZWHdqNWpDVjhYUmtIMU1ESmMyTU9acW1ZMnl3anlYdy96LzBD?=
 =?utf-8?B?N1JhWlBRUHEvdjkxcE9qTWZWOGtZOWV3WHphcW00aWNDYVdBS0FITzRRWXZj?=
 =?utf-8?B?Mk9sek9hQldKeXNEWHVXcmV3cHltd3htNmN6WFJwWnZHMEt1a3NGRzFsRnJJ?=
 =?utf-8?B?VnRqbUJycWdVbVA1WVZCRFBzWC8xdEZMQjhQN2d6STFxeE1FRThsc3NDYjlr?=
 =?utf-8?B?ajZaYkIyTVhnZENlQmdYQ1hOL1VuaUVZNG5OYVVkTmJZbitOVS9EeGduL1Az?=
 =?utf-8?B?UzJoZ1ZTbktGTWRyUTFSb3BLYm5pcFFuK0IrK085ZFY4NVh4aTVsTlpZMHk3?=
 =?utf-8?B?UHdOTk1QOHhFR2FOTWdkSUYrUUQwYzRhVGRLZm1mbW5FejZnMmNydGd4SzFa?=
 =?utf-8?B?Q25tcHNIMmxGbjBtRnVKM0hjc3k2Q245M0JxWnNrTU1UbVZYMWU2ajBOMFB1?=
 =?utf-8?B?OEZacGxiRmtWME5KWGhHZ20xeEVpOWR5cTJVSW0ySDNJTldmRk5oQ2Q2WTU4?=
 =?utf-8?B?NWZicGxUTVdsNU1BTDBVaFlka2I1OFNBNmVYbWNNL1lWK0xRaHdPYWtZSGZ3?=
 =?utf-8?B?VTFOWWwxTTNoK1hob1NoU0FUN2xZQmtPUy80YVJqaWk2R2ZzalJ3YUNSb0hq?=
 =?utf-8?B?SWpOdGhUQ1JkU1NrM0pwUFgvdFhBWlNlRjd3bmhrbmYydEhERW9JUUNab1pD?=
 =?utf-8?B?L1pVTTNlMVJJcjFDN0F4L1NrV2MyOXczaElKaFlydnlVSVZGNDR3QkJVbGU3?=
 =?utf-8?B?WHVRUXRlVElCdVdEVUxBMHpTRU1leTQ3Y1VIekdSYVJ3MVhtbWtRY3Q4TDlu?=
 =?utf-8?B?N1FWWGZpblhQaWl5R0FsSmdJQUdHajFDTG4zaC9oZkJCT3BEaVZtNStocWRS?=
 =?utf-8?B?WlpJMEVNcXphd1d6QnNLYlVOZjZ1QTlYSGFvTU41ek5XbXBrakZvRXpYQkxW?=
 =?utf-8?B?Y3JRSTJSbGR4SkxsY2xGVDBGcmJyY2c5RWRkRDAvcWxNc1FreEdBR3VlajFn?=
 =?utf-8?B?amZnYVh0MDNubnpOZy9pS3E4THUvZFRNeGJXYlZjYjJEUjdhM2s4bzdrcWJX?=
 =?utf-8?B?emhScllxZzNORDBuYVcrc1M2VG1wNmkyc2VqQTN5TXR3cWVBTVh5b3NZeVhO?=
 =?utf-8?B?ZVFpeGRmZ2JvbnJudmNZaFFONFYyNXM4S3p0V1V1WGh2WDF6eG5EMjVrTHpK?=
 =?utf-8?B?NHNYY0oxbk16MnpEa05aNlY5clhLSGkreFcyR0U2OHc2Mk8zdm9Sdk05UkZJ?=
 =?utf-8?B?S1did3d5blBPNTFlU0tWbCtpRGFmNFYzdVB5N2dFMWNYVlphM3FjbmpkcHNU?=
 =?utf-8?B?WHAyL1Q3akZ2Ym16cURHOXFrNVI5Mk5JRm5TbU5vK21CdGQxWmFWd0ZqMDdr?=
 =?utf-8?B?a1pkSjJiNEM5QlFjMzdscDV1UURHQUVBZ25YRlFPeHVRT2NhSnN2bnRWem43?=
 =?utf-8?Q?Y2qClEzhR/KJvuPggXvzXBpfm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eba48a1-3568-4729-1282-08d9e8265906
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 21:36:05.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfFOgxQqKO9eRY4NBhFBz8lCrixiwuFIHiFUj9WyXwsnA4O4p+IqI0K9zjQ+c7UJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2294
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 68YooPgPaEYN0qJ1ogChHuQCZEnZ5xrt
X-Proofpoint-GUID: 68YooPgPaEYN0qJ1ogChHuQCZEnZ5xrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202040119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/22 1:31 PM, Andrii Nakryiko wrote:
> On Fri, Feb 4, 2022 at 1:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> There are cases where clang compiler is packaged in a way
>> readelf is a symbolic link to llvm-readelf. In such cases,
>> llvm-readelf will be used instead of default binutils readelf,
>> and the following error will appear during libbpf build:
>>
>>    Warning: Num of global symbols in
>>     /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o (367)
>>     does NOT match with num of versioned symbols in
>>     /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so libbpf.map (383).
>>     Please make sure all LIBBPF_API symbols are versioned in libbpf.map.
>>    --- /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf_global_syms.tmp ...
>>    +++ /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf_versioned_syms.tmp ...
>>    @@ -324,6 +324,22 @@
>>     btf__str_by_offset
>>     btf__type_by_id
>>     btf__type_cnt
>>    +LIBBPF_0.0.1
>>    +LIBBPF_0.0.2
>>    +LIBBPF_0.0.3
>>    +LIBBPF_0.0.4
>>    +LIBBPF_0.0.5
>>    +LIBBPF_0.0.6
>>    +LIBBPF_0.0.7
>>    +LIBBPF_0.0.8
>>    +LIBBPF_0.0.9
>>    +LIBBPF_0.1.0
>>    +LIBBPF_0.2.0
>>    +LIBBPF_0.3.0
>>    +LIBBPF_0.4.0
>>    +LIBBPF_0.5.0
>>    +LIBBPF_0.6.0
>>    +LIBBPF_0.7.0
>>     libbpf_attach_type_by_name
>>     libbpf_find_kernel_btf
>>     libbpf_find_vmlinux_btf_id
>>    make[2]: *** [Makefile:184: check_abi] Error 1
>>    make[1]: *** [Makefile:140: all] Error 2
>>
>> The above failure is due to different printouts for some ABS
>> versioned symbols. For example, with the same libbpf.so,
>>    $ /bin/readelf --dyn-syms --wide tools/lib/bpf/libbpf.so | grep "LIBBPF" | grep ABS
>>       134: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LIBBPF_0.5.0
>>       202: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LIBBPF_0.6.0
>>       ...
>>    $ /opt/llvm/bin/readelf --dyn-syms --wide tools/lib/bpf/libbpf.so | grep "LIBBPF" | grep ABS
>>       134: 0000000000000000     0 OBJECT  GLOBAL DEFAULT   ABS LIBBPF_0.5.0@@LIBBPF_0.5.0
>>       202: 0000000000000000     0 OBJECT  GLOBAL DEFAULT   ABS LIBBPF_0.6.0@@LIBBPF_0.6.0
>>       ...
>> The binutils readelf doesn't print out the symbol LIBBPF_* version and llvm-readelf does.
>> Such a difference caused libbpf build failure with llvm-readelf.
>>
>> To fix the issue, let us do proper filtering for LIBBPF_*@@LIBBPF_* symbols.
>> The proposed fix works for both binutils readelf and llvm-readelf.
>>
>> Reported-by: Delyan Kratunov <delyank@fb.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/Makefile | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> index f947b61b2107..d1577c26c16b 100644
>> --- a/tools/lib/bpf/Makefile
>> +++ b/tools/lib/bpf/Makefile
>> @@ -132,7 +132,8 @@ GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
>>   VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
>>                                sed 's/\[.*\]//' | \
>>                                awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
> 
> have you tried just doing !/UND|ABS/ here?

It works and even simpler.
Thanks for suggestion. Will send v2.

> 
>> -                             grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
>> +                             grep -Eo '[^ ]+@LIBBPF_' | grep -Ev '^LIBBPF_' | \
>> +                             cut -d@ -f1 | sort -u | wc -l)
>>
>>   CMD_TARGETS = $(LIB_TARGET) $(PC_FILE)
>>
>> @@ -195,7 +196,8 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
>>                  readelf --dyn-syms --wide $(OUTPUT)libbpf.so |           \
>>                      sed 's/\[.*\]//' |                                   \
>>                      awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
>> -                   grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             \
>> +                   grep -Eo '[^ ]+@LIBBPF_' | grep -Ev '^LIBBPF_' |     \
>> +                   cut -d@ -f1 |                                        \
>>                      sort -u > $(OUTPUT)libbpf_versioned_syms.tmp;        \
>>                  diff -u $(OUTPUT)libbpf_global_syms.tmp                  \
>>                       $(OUTPUT)libbpf_versioned_syms.tmp;                 \
>> --
>> 2.30.2
>>
