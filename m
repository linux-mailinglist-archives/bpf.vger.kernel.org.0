Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F028C4CC510
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 19:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiCCSZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 13:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiCCSZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 13:25:40 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA41A39E0
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 10:24:53 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 223Bb310020062;
        Thu, 3 Mar 2022 10:24:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qUhQt76tourk2z2zKn8NCCPGhksyLfJ210bF6K5nyu8=;
 b=QdUMlXyVHSCp/fuId5nkTFIuM/pWitlOp11Lpl2dgIT8+uxE62wzlSQHYhY2sMoJa4lZ
 FCNYz35HuG4Wdo5+k8KzoFNhMm+ugXbjAdDLcXIece0eRl+hZ9DVOn3BWrTfPIKl7K4J
 HfbFxobrQ7yPnj8aEPM5lQQMSweE0+As9Bo= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by m0089730.ppops.net (PPS) with ESMTPS id 3eja5t24p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 10:24:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWTqdUATjBDythQJC48a04k2dNAzSAR9vGVU4/SK9L5RGs1VqYUFSXvmjNQWHNLtiExLNIqGDwYt06a5Iute3di2GkPhzN5uToPwhoddcWRlo4fKIzTmRjlVs/MK63iwW3OFpKf/OPz2kWh2WixTyjGBcAuFaRMYqfkR98q1nyfgHcwHQdvBKiBRxU/6IieS7WvsY2yY7ujOnwHLTXvfX30oOZ1x8VYT8It0H7OXdCbv3FtC3zB52reHgO86eCjg7h0x5sgEkkCZf9SadtwIGF+2thwRVWsLTWPnI52EFmEnthOtHYzfQ8VvTZdxJ3fb/iBAlaJkgvksjap5D9Ei/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUhQt76tourk2z2zKn8NCCPGhksyLfJ210bF6K5nyu8=;
 b=h2X77g/crlAKVWJBL0XHBTw8yn3Oh3XA5gzLeLSoHIgnI3GnC5gNF5O+aHgNRG0mu0bky3po5P4Lcef5xd6fLCZLrIF39H0iMxCnJ2FW+yZDdsZE6ctpYeBJMouez03U2HqQyf+WbgXsCUaiYbEQbGlnGFrOs3GKcrQERTPzIV8Jn99OP5iTdaYkmrQXOrHIKIU8DiaAJkQUvBdsFGnXKvhRtVPrCPodRG5ksVJD+DUbE0xly31/cGgCnfONNDNbJwrg/1x9h/r1pLT416FVZkEdh5MypjN9PNUsGx1Gkyr2PIQNgBLpMWxBllfXJpusTpcyRQY9PdDwrDzCADoJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1307.namprd15.prod.outlook.com (2603:10b6:3:b6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Thu, 3 Mar 2022 18:24:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Thu, 3 Mar 2022
 18:24:32 +0000
Message-ID: <47222739-81a0-c1ca-fdaa-82a2e0b67ee4@fb.com>
Date:   Thu, 3 Mar 2022 10:24:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v4] bpftool: Add bpf_cookie to link output
Content-Language: en-US
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
References: <20220225152802.20957-1-9erthalion6@gmail.com>
 <a646e7d3-b4aa-3a00-013e-4fc9531c2d83@fb.com>
 <20220303162010.qcz7dovfg736h4ed@erthalion.local>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220303162010.qcz7dovfg736h4ed@erthalion.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d6e310-65c6-4889-86cb-08d9fd431033
X-MS-TrafficTypeDiagnostic: DM5PR15MB1307:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB130728E6D9FB0B85389FE823D3049@DM5PR15MB1307.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nh89zIXyFl6KHZYyHuL6ji6Ag0gIlqR+OFMWB/onL8/nd8yIBM8WyQ0rGtVYiBOflcektrKG9U5R6quNxs2PY3vWEIGRmhOk7DqAX1PbJCiYV67GHjlyYxIS87aP4oM6riQ/Piv4cHfdu2usWmSYcA80MdRPYRtiVtp5SIfVF2zrLY3da3e01F3gYecG737Z0h9OB4nUAhaN53/n6YZY951clKkWAkIJLsXQd+pDGfAztSJG8Bpy70yh4vMZ+6qyVa58mJdMBFh9uoE6MIv9d0Ud1IG8evsSufiR0mzfNXEZzrMj/WqSdt+be67c+qo43O10U8RWcqL/mAXcEbLaZ1g70hG7snnwNT9AxAsgs9FSGiSvtZpcX9LivtGhS6BhQOL1X4hUDjfeu8JnIpIs1Lhwd+YVac27sUlya6T5BGhkcuIO6Wow/2oVex0zUZv354lYHvZdPSdT//GuHXmrNYMLNPf6AQR4wZawRGLKo/dWQ2acirsTXlt0c2v7JyRntAnZ0DNl2Pc+Mh8WSGvGaPBj2KBma/xAYAN+G+2IqCvA0m9T9ouOwm9oxmDvZUVk96nsXWAVTfGHwPtKsqTfbTK9tVB77dik9Rk66vRE60AeRezzJHIcz2T3QfdscuIVxsy2aPpliC9X6fENQ+xZgbMJjFhYDk+H9J0RA708HzRfMS82CzEjgSEsdPkhACbQ/DypvifX8W1cOcHYxQFHacDybCI5kSBP6qxOqfbpPcSLka8gKmRDlgmVe/GZBla3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(66946007)(66556008)(66476007)(52116002)(53546011)(6512007)(6506007)(6666004)(6486002)(31696002)(2616005)(31686004)(6916009)(316002)(8676002)(4326008)(8936002)(36756003)(5660300002)(38100700002)(83380400001)(2906002)(86362001)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enh2c3RwMzNNbUcybUMvbFBoWmkxVlNhYjlGQW12d0ZnMlhzRGNnUENuM3c5?=
 =?utf-8?B?Mmk4b2N1YTZTV05yNm5DMDkxdEMyMGk4RFVhaHNCeFVzTDNJelJvdW1kNVB0?=
 =?utf-8?B?N2JWTjF3N2ZEUTl4RElIMEJqWVE4MzdicVpOZ2djTlFwejZDbFFMcW1aUTJj?=
 =?utf-8?B?UzdpbzZqenVxVzFsTE80V1RscE4wd2NtTEhPT2g3VDltQTVEWTJ0OWJ4KzVF?=
 =?utf-8?B?RUc5Y0I1NTdrR2FSemFLaWgyTDVpRCtGR0RiNnhEUmNPV3ByQWJRTHpVS3Z5?=
 =?utf-8?B?ekhPWnR2d1lTb1lFZnlGZFhZam55NnR0QXFxaFhvUm5FcmRGSGw4QmdQTURR?=
 =?utf-8?B?czlOVDY2RFo5TUxtbnE3bDE1OHUwbDgyOEplODVGMjVucHNXNUJXQkJCMkpv?=
 =?utf-8?B?MFprTk9TNVQya0ZhOWNCWDE5SVdpTkZYbGZIUmtUaXBFMHpmdnpUWDF4Vkl1?=
 =?utf-8?B?bEVNdzE2MldZNkxyVWZDczFyWDk4WU1sY2FvRFBOSEVMTGNaSWY0UHBtQk96?=
 =?utf-8?B?WHpRTnRrSVljdlN6YU5DQ3ZxSjcwbkd5UTVnckhtZ3B2WXA1RkFmSUpKL2Rs?=
 =?utf-8?B?WDBBcjN4dWVSSk1nYU1tcXdpam5qdE9nUTNUVC9pVWVKVnF2RlRpMHFmeVJt?=
 =?utf-8?B?Q29sUm5jeHRjbjY5dnE4cm9sbE1CZ0pac2M5UUVBaXhTalNTNXRkZGlFd2hv?=
 =?utf-8?B?Nlc1WEFYc0ZHaDFUdmpoUmpVNzFzeDU5VHdFS1o1eDdmNnVMNXlHbEVHNnV4?=
 =?utf-8?B?VWNnYTNFcFJZbnRMdDF2WXZLUXNEZnhmaTRFaWdJSGRLL3V4UzNxZGhOM1E0?=
 =?utf-8?B?N1BRMERLT3pNb25LVnB3bTNTeGV4MjIrTk9RU2FpcWE4TzRMWFhueVNIaXZD?=
 =?utf-8?B?TUtwcmVVZkZDc1J2V0tGdkh6cnlNNys3a2J6b3ZIeWVUNDQyVWM4bzdZZ1Zy?=
 =?utf-8?B?bGg0Sm42b0lhalNSYXVNYkJxQ3hDcUpCbzFHRmdGekx5cFlSYWdzUjgwRDJQ?=
 =?utf-8?B?MllDdnQwS09UYXRQQk5veWVNTVFLOUZlTFBVeW9zcnRBVzJZamM0Y1FhNThR?=
 =?utf-8?B?MWZ6SXJTcGtKMXBwSnpiYUg1NmhiZHRiQTZsdmVEUWpBNFYwKy9RUFlKZEVP?=
 =?utf-8?B?SmlnYTBsMnFGK05EcDk0MWFtSzlOcDhJdkt4TDRUbzBwaXEzYml1M1hTVC9H?=
 =?utf-8?B?VjBDL1lvc0lDSW5CV1ozWW0yZGNLL09mZ0NLNHMyVGNhSFU4RnZmdnoyVUFw?=
 =?utf-8?B?U3VnNCsrakxWaVVhcHphQVcyMUljalE3NkdTZG5NR2lvMGdJK1Z5NkE0YnNE?=
 =?utf-8?B?cXdBV3FBbU5qUVdMazI2ZnFaVUhJUTl0WUoyMzM5MXR3S2V4S1VBbHZBaVh4?=
 =?utf-8?B?WEFxcTB1ZXFRNldEbGg4YUxMajJSUDUzVjJiVFRTK3Y3aWJaeVEyOWhxWUpj?=
 =?utf-8?B?QTBnRWpnSDNzYTdEYWc3ZEp0THlhNnRvZXhCZTdnZHVUN1JERGZtWWhkRktw?=
 =?utf-8?B?UlNmYUdKYTloZWt6RUFWSndmZW0zdk5xS1RqSnJtbHdSM01kUnpYekRCeXBi?=
 =?utf-8?B?cXgxbzdRd2RyWDE3RHlJOEo3alN6NURXZjhWWGhwTWNmdDJKZDg3K211dEF3?=
 =?utf-8?B?a2VxUXR0S1hJbFp3WTdvT2luYWgzcDZ4RGdyWE92OW9jYkd1K3BnYWdVaWdP?=
 =?utf-8?B?aUVrVXRBUE44UUdSMWh5OWg3VnFTS0NIcks5SnZuYzcrU01PQVh1TVVKOTlk?=
 =?utf-8?B?dGp6ZkNrWHhtNTZOcHEvUHJjME9pamtYOFk1a05Nd00vU0JRK3dyTW91VTEv?=
 =?utf-8?B?T2NEV3M3bHVwazBMaU1YTGkyWTJxek03L2dsNnJITlF3d0pQbEt1MUNBUjk0?=
 =?utf-8?B?eUN2NkxJeGRvSUFsbXZndEFyWHRlVDhqL3NWUVZPOXlOMndSYWMzZk92ZlBB?=
 =?utf-8?B?cFIvOTB6VDFybDBCWkR6MStDZlNtMmQ2bEdjRThkWmtPYno3dG1jV3V6MGlQ?=
 =?utf-8?B?WENnTGRuRld3THhJMEF1TU54Qmh3bGVBMk95NDJETmJFdWo1UlBWdHVyK2c4?=
 =?utf-8?B?eHdGRVI3N3ExanlCM1lkSWlXekx5bVZyNzBFZlBNbUpzWE5PWEx1aERReE4r?=
 =?utf-8?B?Y0lIVCtmK0Y4MEVabWFnZTJrcS9yWlNpcDVlR3dxek1OUWxobEVrLzlkT3B4?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d6e310-65c6-4889-86cb-08d9fd431033
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 18:24:32.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+oXrRgBVO3NgD2DyR0ZmkLc6vJO1PPnHq9vbDtQAEObbYwTaxIKsQ+1W+xkvOjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1307
X-Proofpoint-ORIG-GUID: usW1DnS4bwuVw-523Y2bMl3Xb5GTtHWR
X-Proofpoint-GUID: usW1DnS4bwuVw-523Y2bMl3Xb5GTtHWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203030084
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/3/22 8:20 AM, Dmitry Dolgov wrote:
>> On Tue, Mar 01, 2022 at 11:53:56PM -0800, Yonghong Song wrote:
>>
>>
>> On 2/25/22 7:28 AM, Dmitrii Dolgov wrote:
>>> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
>>> BPF perf links") introduced the concept of user specified bpf_cookie,
>>> which could be accessed by BPF programs using bpf_get_attach_cookie().
>>> For troubleshooting purposes it is convenient to expose bpf_cookie via
>>> bpftool as well, so there is no need to meddle with the target BPF
>>> program itself.
>>
>> Do you still need RFC tag? It looks like we have a consensus
>> with this bpf_iter approach, right?
>>
>> Please also add "bpf-next" to the tag for clarity purpose.
> 
> Yeah, you're right, it seems there is no need for RFC tag any more. Will
> add "bpf-next" tag as well, thanks for the suggestion.
> 
>>> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
>>> index 7c384d10e95f..152502c2d6f9 100644
>>> --- a/tools/bpf/bpftool/pids.c
>>> +++ b/tools/bpf/bpftool/pids.c
>>> @@ -55,6 +55,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>>>    		ref->pid = e->pid;
>>>    		memcpy(ref->comm, e->comm, sizeof(ref->comm));
>>>    		refs->ref_cnt++;
>>> +		refs->bpf_cookie_set = e->bpf_cookie_set;
>>> +		refs->bpf_cookie = e->bpf_cookie;
>>
>> Do we need here? It is weird that we overwrite the bpf_cookie with every new
>> 'pid' reference.
>>
>> When you create a link, the cookie is fixed for that link. You could pin
>> that link in bpffs e.g., /sys/fs/bpf/link1 and other programs can then
>> get a reference to the link1, but they should still have the same cookie. Is
>> that right?
> 
> Right, I have the same understanding about a single fixed cookie per
> link. But in this particular case the implementation uses
> hashmap__for_each_key_entry (which is essentially a loop with a
> condition inside) and inside it returns as soon as the first entry was
> found. So I guess it will not override the cookie with every new
> reference, do I see it correct?

They are not return if pid is not the same.

Let us say the same link is used for pid1 and pid2.
The pid1 case will have refs->bpf_cookie[_set] set properly.
The pid2 case will trigger the above code, and since for the same
link, cookie is fixed, so the above code is not really needed.
