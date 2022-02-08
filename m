Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487CF4AD139
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiBHFrB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiBHFrA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:47:00 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CD0C0401DC
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:46:58 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 217Id5cU025537;
        Mon, 7 Feb 2022 21:46:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2lMpcHgfby9tkM2fHqW/9hrHrg4eI4KDPARvrtwrRDA=;
 b=Mg6YmWVeJ6TN+2M2Wd8wBZFBxevW6v57kyr/hm5XTZADrHOSmSBPTwBBbAcAjUVA0hoT
 RIlQNIlTlsy6CI09Co5D6sjHhLCLWlj2rvh77OkGS6sGqeJGNLk606aI4UdDWI0CHvk/
 sWzCGtxksI/dHexdRXBxvPL48GKxc7yH6+k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e2xd5yhry-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Feb 2022 21:46:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 21:46:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1HXRd9qMuB8nuD8TH+MNYJq7rkgKcSEQDgrhzcZFCAvF5eqcH0AnrsRrokJzVFpNxH1zKJHL6blZ1EGM3ZRytrfAJxdQNW9r7Jrdnx5+6A5GVW98Nt3xP9avA1s5ZaQ977mkbWNt7CDBttkJo8nbCyH8rKe9vkFIODaDtQEDmmo2jia1R4Hec7TdYnWY6sC7tpDUTzpvSjN16IKwLxtbVrcHvNUnl+vw9iDUQarrTZGQ3z00/cetwVMHaW9/2gHDCcdHT/WDTbTeBxk8UWyc3zLQ1+vvRQlsvx6xrPS5bNPfZzqlUp+PhU4cHprm8MDy3HjImue2Ida3uJ9uB2qkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lMpcHgfby9tkM2fHqW/9hrHrg4eI4KDPARvrtwrRDA=;
 b=hwsFQKepg6GWWolZuxsZl/WbpxF//PKGjJ+SktuzhjRuE0gK/lXbTenVPnOVb8S5Ns3WoFIpb/rK5kn8thefQZhkC2VREiee5kMdpNNLie1Ia+xlxWHD9DJlnsV9tzLwBnnMuV4Uic/GpElc+rVUGtQvMeOHoFLoFycKLtyrjlklVJm6ysTgAxp8/6WLXNjnloCRYzhHw7QDHGCw2H7O+2J1xgqCUNP5N3kBRrV0Vmq2U+0u0y6jpEUfdqG4jNb2K9fXNnOMLs8o9I7tKNVoxDxdLEy8IYkGHyTkrlrbIy2ihkqT623drXMJCRNi2I30SyLtLrz9HYZOUY1z9+l2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5148.namprd15.prod.outlook.com (2603:10b6:303:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 05:46:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 05:46:40 +0000
Message-ID: <c81ddb7b-1eff-b5e8-a80b-ef0e8c3bc513@fb.com>
Date:   Mon, 7 Feb 2022 21:46:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
References: <20220204181146.8429-1-9erthalion6@gmail.com>
 <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d7e73de-c461-433d-dd36-08d9eac66130
X-MS-TrafficTypeDiagnostic: MW5PR15MB5148:EE_
X-Microsoft-Antispam-PRVS: <MW5PR15MB5148CC1B5FCDF3229CF3D147D32D9@MW5PR15MB5148.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUJUHpi1iDdw1S4wvy9OgHlCJakctqjA1Qa3TArw7oUUuO4E77u8zomyKcqPqi1w751Iz1FIbQ53/R68Sis655foTv0UOZZ+vVDwtuLBCO2gJVHSG0y3LCfFlBWhtISkLILiqS4cSl59FfbszM/UnEws5HDnia0yf1Sy0KjRZz5vSmvmWNRQEL5aFrzKNBmwOKIC2FRW2QCXjhQLki11aoGkZy/JWl9wkSOlCzYtecP/80BSlfDXpfdUHIDogunxGnxTbCiSMUsy3gbW6feYNeniToFcCalGl03QehQ6GjPNK63gEDkwi3Nmg1/VxAGHLqGOmfQEoN8rF6P2GyvIQ6Kd8TwvoyNzX4Bcze8FWA7I7lSQ5sFhrhSQpG4MACS/Aep84DS9oyLTBrvKlUezCL7sxVQrgML0j79ery4GuDTY5+5TzLh3K4PGO6W2xUGF7nTbiKz0TVprSIOfzlzLLovkh5ABh7K3Ug/4E99xvfQI9qTZJI5cnr+JoFGTpRytEygfcyuiyvXFCbmUGuY9G6ucCJd2pZIpyz5d805yd9EiL1+mmKYPtsZYno48Sox3xFHrKbZCyqusUlWGt+rA07eG/5HXH3by85PfH9XpqZ1dv47Dru0r9mJvp/GcHbOMGQ6zdGHfESFCVvbooJe8zj1EsanCu0j7ye7L+ieho8LcwzOylczlzQKyWCcahiOi7ywiBulaoZDKYyMZouTg84CNoDv69XCE97p3KfsuBVssgwfMTraYYOHhKvk6MjJ0WZ7ShO0vvJU1jVqhBp26uuUiCDS0tOiAexA7mWwXF1IbTaTZ7KlK7udDfRhuNrPR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4326008)(6486002)(83380400001)(31686004)(186003)(36756003)(38100700002)(66946007)(508600001)(2906002)(316002)(53546011)(52116002)(6506007)(110136005)(2616005)(54906003)(86362001)(6512007)(8936002)(66476007)(66556008)(6666004)(31696002)(8676002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjgxQjNVeEl3Rnoya3R3S1RLejJPU0xQQVphRktQZk1ZL3Z0WWVUcUxYUXA1?=
 =?utf-8?B?Mm1tcXpmbXNETDI2YkMxdWxSa1p6d0F4RElTWWRYeXlmYUtiNEtNRUtpdkJh?=
 =?utf-8?B?aVJ6ZDVydkRaZjhkNXJQT2V3Wk1FNTdIeVVVK0JQTzlzTTJzTHhwRzlIV1pC?=
 =?utf-8?B?K3J0RVFUekVmWXkrcHcybWhUWTFVN2R5UEgvRm9pNzJsKzhiQkE2TjV5Y01B?=
 =?utf-8?B?QjlYTFQ5MVAxUjRUWFcrRkFsNUl2RmxhdHAyZExKUGlhN0JjaGs1NjF6Ym1O?=
 =?utf-8?B?djZING4xbFJ2T0xSOW15dXJ4ZFphRjBUazFKRWFmVkhqQ2pCK3N5TjZLVEox?=
 =?utf-8?B?VzJ5VkpMOVNSd3BwS3Fyd2xEekRBVXRCdWRFZjU1Z21rTVhhZ2lWWjI4Qkpr?=
 =?utf-8?B?QWYrZkpENnVwbUd5YjlLWWtXdXNqRUpodm0ydU9uQUNiUEw3YWJzNW5vU3Rt?=
 =?utf-8?B?RzZZM0k2eFNiNnEyTEVuQWZZdk5HSHo5OXlCUEN1a2YxcWNFcmtpZXN4VWM2?=
 =?utf-8?B?MGNDLy82UHpTZkRQdk5FZXRuQ1N4L2tyOWduTWZaMmplbzlkYXBlZGlkendo?=
 =?utf-8?B?YStiUnNxQUVMUm01TFFPWjNFU0NOWlhMb1RERWgvd2tmRVNLQ0x0S2RwcjZ1?=
 =?utf-8?B?bnVDSnNvM0J4dDdLa1FLZDhWdXhGbzV1UldGT252QkNxYmZGTkRNcEhuRUlZ?=
 =?utf-8?B?ZURiQ3ZKaHNac2tzb3k4OHYzUENLR09pYURhbGxZOU44WDczS3kwWkExYmI1?=
 =?utf-8?B?bEZvQXNXYkJWZ1hrLzExSnJ3UC9QK0hzVmRQVTAyZG5vRFkrcDkvRlg2Mndz?=
 =?utf-8?B?aFZ1cWQ1OUlOeVU5QUdad2ZXeHFpVzh6OWpjamhwbDRDZ0tueVJXcHd5WUl4?=
 =?utf-8?B?VE50cEtwYmtHdGNBUWRKR2ljOTlRZWRRc3phZlAydVNQeFNMa01QZGRHZ3Vw?=
 =?utf-8?B?U0NWNW1RRjZhWS9yQzJJSjVpMExmK1BYOUh4MmxWbURya1lVRlB1WWlpQVBm?=
 =?utf-8?B?M044TzZhSWszSVE1a2tkeDJwYnpHbFZXVHFxb1VwU2lIMXFFZzNFME5sSXFB?=
 =?utf-8?B?QURFWWplVU1OYUYwTUpGYlFzRVVNeHgza1h0OVFlQzJXSnAzSW14N3lESmZZ?=
 =?utf-8?B?T3JGMU9EVVNoK0dPTEpRelkzUk9adHkwdEpxMklNUzNLVlhKazVDcUFvb2NI?=
 =?utf-8?B?RVd5aWNhM1ViNS9Wa0tMMGxKVU9qL1BtWmsvb2FsVWhkUjlkRDRKOEk5QmR4?=
 =?utf-8?B?SUYrQy9HZml3a3c4TTh4OTNCNEdKaDZrc0F6VlZtaTMxMTFFYytHRVpEUjJa?=
 =?utf-8?B?RG9ZZE1RK2JTSWFQaXN1eGxpVFBabEtqditRMzZUZWoxQTNMeTZIRTZ0M2pi?=
 =?utf-8?B?V2tFZ1ZUS2paQnllUEoxNVAzajQyVGVaQU51QkxBUThBaWhGMmRSUzhnbVFm?=
 =?utf-8?B?NnM0bzltdGg3Y3A0ZDRydFNUaTI3RjZpdUdINjhiZWRxRHhWNjZqa01XQys0?=
 =?utf-8?B?ejdPRnp4cjdiejd0Ui9KYXlGRFE2aXAzZUdlZllQOFFLTG1YcFpyUUdDSmlH?=
 =?utf-8?B?WnJQYnFaK0xEMk9wem0wWlB6a2RJTUlZTTg5d0NURzlpSUFldzhrS24yb2FX?=
 =?utf-8?B?SkdkK09HWnM2ZjMrTXJQdXhpMTNpU1JPVytvVHI0QUdRR3RLa3Q5VVhGSUkv?=
 =?utf-8?B?ME81RTA2ZDA5cnNlSjFpUEVXWXA1YjlPa0RkWmpCL3Z3TGJYbC9wbUZNR3RG?=
 =?utf-8?B?MVdLY2Ivd1IyZ0poNUo1bDZkUHY1cnpXNGVLck13d2FPYlFlQzBiaFZuaEgz?=
 =?utf-8?B?ZDBtUnI0RG5sdWg1ZmYxQXM0cDJCdDJySzgvNVJwenZGVWtmYW1qSndCd1lj?=
 =?utf-8?B?aHR3NTZrOTdGdUVPMitQOVEwNGpPQlBscWtEOHRjUmlSQXh6WjVIOTYzUThl?=
 =?utf-8?B?ZGd3Lzd4NDZSdVA5U05jMWdwcnNjWmxFKy8xbEl0RmtMYmFEdXFFRGJmMkxQ?=
 =?utf-8?B?U3cveks4VnZFbDhERVVmc2VVckRONXpiSFlIQnJQSUo1Ym01V2lQNHJPSWJl?=
 =?utf-8?B?NUlod1RZY3gyRitZdGNBR2lZK054Q09wNE5jcUltZlFkWWhwaUhTZG5WNGQr?=
 =?utf-8?Q?cVFdsxeSs9Bo3toR4esEKJnrT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7e73de-c461-433d-dd36-08d9eac66130
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 05:46:40.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXuhYvjF4h5G4P18RcpGm238/Bt8Faht4X5fETNfCrfnrIKPKcwx08kqXIv0zVe7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5148
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: O4pjP-lnEqHMXYwOmITd-U2xVhWXicMC
X-Proofpoint-ORIG-GUID: O4pjP-lnEqHMXYwOmITd-U2xVhWXicMC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080027
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/7/22 2:11 PM, Andrii Nakryiko wrote:
> On Fri, Feb 4, 2022 at 10:12 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>>
>> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
>> BPF perf links") introduced the concept of user specified bpf_cookie,
>> which could be accessed by BPF programs using bpf_get_attach_cookie().
>> For troubleshooting purposes it is convenient to expose bpf_cookie via
>> bpftool as well, so there is no need to meddle with the target BPF
>> program itself.
>>
>>      $ bpftool link
>>      1: type 7  prog 5  bpf_cookie 123
>>          pids bootstrap(87)
>>
>> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
>> ---
>> Changes in v2:
>>      - Display bpf_cookie in bpftool link command instead perf
>>
>>      Previous discussion: https://lore.kernel.org/bpf/20220127082649.12134-1-9erthalion6@gmail.com
> 
> 
> So I think this change is pretty straightforward and I don't mind it,
> but I'm not clear how this approach will scale to multi-attach kprobe
> and fentry programs. For those, users will be specifying many bpf
> cookies, one per each target attach function. At that point we'll have
> a bunch of cookies sorted by the attach function IP (not necessarily
> in the original order). I don't think it will be all that useful and
> interesting to the end user. We won't be storing original function
> names (too much memory for storing something that most probably won't
> be ever queried), so restoring original order and original function
> names will be hard. If we don't think this through, we'll end up with
> kernel API that works for just one simple use case.

The cookie for multi-attachment is indeed a problem. Some of original
cookies may not be available any more.

> 
> Can you please describe your use case which motivated this feature in
> the first place to better understand the importance of this?
> 
> BTW, bpftool can technically implement this today without kernel
> changes by fetching such bpf_cookies from the kernel using its pid
> iterator BPF program. See skeleton/pid_iter.bpf.c for pointers. I
> wonder if it would make more sense to start with doing this purely on
> the bpftool side first.
> 
> As an aside (and probably something more generally useful), it seems
> like we have a bpf_iter__bpf_map iterator, but we don't have prog and
> link iterators implemented. Would it be a good idea to add that to the
> kernel? Yonghong, Alexei, any thoughts?

We already have program iterator. We have discussed link iterators
for sometime. As more and more usages for links, a link iterator
should be good to improve performance compared to generic 'task/file'
iterator.

> 
>>
>>   include/uapi/linux/bpf.h       |  3 +++
>>   kernel/bpf/syscall.c           | 13 +++++++++++++
>>   tools/bpf/bpftool/link.c       |  2 ++
>>   tools/include/uapi/linux/bpf.h |  3 +++
>>   4 files changed, 21 insertions(+)
>>
> 
> [...]
