Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0CE57FA60
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 09:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGYHlR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiGYHlN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 03:41:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B512766;
        Mon, 25 Jul 2022 00:41:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P6VT5Q000854;
        Mon, 25 Jul 2022 07:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7bYbivrtYkouEMOY/xFjwdGolUCqmvGJlLrJ7S2XD6E=;
 b=Nh5j8knV6QULv1tlNNBz68fmS7ODjEYuuY4EOQrFiWvHX4oBduLjLLzlbuuZidRIGLce
 XSYMNnJ3/aCoRhrPP5nb9vc/D+k6bf0jl3Ea5cgjid1zO+vdownXiaeM/SRvJk1J/GxI
 gH0qZQyMJbfggG1VEUbx5B4vqy5krhmeZYKVlbXxpL7iFsrychNcNFdNRthl+jlCAmFg
 6GbR4PDbO2c+4OEAuRMCl+JF8ACFlJcbDAtRW0n4prfOSMQxEzGqxXdMJEaEVUW1U1KO
 7lUdOHECF1c4Y0ApdEJNx/7SNTuxUaAZdopM7Al1USQfNxVr9+efuzJ8LeyTj8r8Z8S+ Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940jfjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 07:41:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26P58SA4023112;
        Mon, 25 Jul 2022 07:41:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yt5vp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 07:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PplctJED1LtQqzjA5SajZKDi64ZIsF2GtHuu7ccxI2b62cp4r8CE00N1oxq+1efFgmgt5S5OvDkcRnNgX3W8ZjvG6eQkA1K37xfsETp0/7vSx/7WDc5kQTqGEqKP2AU/oRrKQczvES7u5GAozSOrOJpLdupQZFgRKgiQbxH/vyCgzCIOjYHPSNkClp2VK1F3MG9+LXs5zHUphNVEHRDXy+T8xg9SUIBD39z71M6SZ0KAfBlwCHDT0eVRNYV929x4B1rqKa53H0RBx65sA/NQFprrnoQjDA5eoX/Jh65syOxJ6jl8LTjsN+N5idmWJARolcFiHH/yUpwPpbQ1NVE6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bYbivrtYkouEMOY/xFjwdGolUCqmvGJlLrJ7S2XD6E=;
 b=SJk3uzAMyyznJeltDOHEXsXZ6WpeDBf9Lpwxe5pGg5NT8ZBxVKB4H0YrSxFE150ajvBiFalhIFY0ZkL9IejpS4tXBmKMBeIzbGyBV4NVDFMb0qsQvTzAlVugRLBBbt0Uc5gEijKsseLyo581KaS5t+If1YqiuBu9bHJRM6RSlcVcbyc1jm0udOrLndvB9clVb73vBp7olabtKxr7ibObnRZAM0CXpuNa+eyJafBCi2Wh31GPaPkViTm9McWfse/AbozU1KAe1nkjBynS5In36tTTC8cbbgjjJsTKji1l2ijUuW0cZH9MjUEGjGhjmiLAsk+l38RoU42Qzw2IJawn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bYbivrtYkouEMOY/xFjwdGolUCqmvGJlLrJ7S2XD6E=;
 b=a3QoyTrAmjcVf/5HkMpmZ6nc51bVyvj+WTb1F8uxMTkt9K14e8HRHlUvx7DXQbCDm/8g9QA5JuUnCat7S8FVidaFH85mJrrbQ42+PoMXA6CUs3OftbiN8IKefJSRUJ5LVVFj2DRVhOGyi40ZdoPWNjALT/4drjT6geadr1nrucs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5101.namprd10.prod.outlook.com (2603:10b6:5:3b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 07:41:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:41:06 +0000
Subject: Re: [PATCH] bpf: btf: Fix vsnprintf return value check
To:     Fedor Tokarev <ftokarev@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220711211317.GA1143610@laptop> <YsyZY/tFm3hi5srl@krava>
 <CAEf4BzYGjNaqL4h8=4Jw7O_xxMfy=TbUg94VO6RZT5wOtV+_wQ@mail.gmail.com>
 <ef44abe0-81fc-9c97-a4e4-2b3ba19cd84f@oracle.com>
 <20220715070742.GA165641@laptop>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <ba445c37-1057-a71c-0ba4-cf8c348ccebb@oracle.com>
Date:   Mon, 25 Jul 2022 08:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20220715070742.GA165641@laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0161.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9648ffb2-da84-4bf8-8e4b-08da6e11086e
X-MS-TrafficTypeDiagnostic: DS7PR10MB5101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jv1qLvMLAp9vZsi2KoJ7bkOHJSVDDP2P7ADcXI3ezHixefr1Er1dvgBx2Z5983ZHQF7j/6ZCqMFaK+0l4NFEHH0HZMtJjuy0DgRouQZJ/3JAWDtvhTgXzflKMBUNFFMKjUIdRkMDev5fTWhNLKRZ3d32zLd7O02Spr1dBQcyC/lvC9KRpp6KamXU2bVZ0h5Ye6QHtQwTy4PdOPCeqyBBHS9/vXzaTT0vCaUOUDTLloQj2H3HP5eVLfCHPkLrk3iSTFCujPU/wSs52XRBit6jfSkYFO6roQto3Voc/avFQNaNvIhc+4OTR2JQoWC4MO2I46zGEXMSDLMHOnsgYJjBEP8qo09TabrA0Fk60/0ijgJEapal80r7jJd9t+l8e66Dzgi5tmIldlBR3KbMxxr8eQelo9djPH6DkixtPVWdYHo+Dp4o/j5c4NUtJ1gJ4dMJz2KgpekRzgba4crSQRv3fnNYunI1ZEvDYD0kQ52uy3y+6UGEWZoQi9tUsMxQApC/82yzt7kjD3KavNukV+z5zCxdz35YNdne107N8Oe6hnXrzP6YW4CD6Y5qXqzj10RnPGbYvwWtUYTfbKsTZ12f88SyZfenXNj/VtJX0W0NIG5a5uW2ekUpNbQLbIRif5HvIVQTiuuLOeExbgg4+sf5kgtZzQQ1CI5v9rq9vfIeFxzujrj8/0d4WCBo74ZwhK0+cXRqf+AtkwVDOkajer3EaukSXfNoVpv/pMgYLVi0jd74yxkwHRl+Qn8dLI7zO+KwT0EIGAQlPy7KfwyEeSqmWBVwsMqhpmBLSmrlH9mmx+5olLzbHTfFbr3dVQ/j3Qq5UIA2shyKXcTRhROa39JlKEXjh3v/ERhku+TDk2uWM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(346002)(136003)(86362001)(31696002)(6512007)(6506007)(53546011)(83380400001)(36756003)(38100700002)(2616005)(186003)(31686004)(41300700001)(316002)(6666004)(54906003)(6916009)(478600001)(966005)(6486002)(52116002)(44832011)(66556008)(5660300002)(8936002)(4326008)(8676002)(66946007)(66476007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVdoa2kxam5qSHlZQWJPQXhFWW5JQVdEamtDMXp5R3l2a3BjY0xLTHdZMTFn?=
 =?utf-8?B?MDBGT2JidnYvV1psV21hTVdZc1dFMjM5OTgvUmZsZnBXcTBlZUlHMkxFQXQx?=
 =?utf-8?B?ODFtZlJScG8yTTBoeDRyY1YrRy9aZVY5TFFta3ZDV0JsUUE1Smdib05zRWdv?=
 =?utf-8?B?Q0xxWDNnb0g2QzBnQm11YVU5VFNIdmxsWVpvYVNjMklpdEd3bVRyTE5sMWZK?=
 =?utf-8?B?VElmYXZnc0NDdE5lMCtDRjRBcm15KzdPamRwaEFhV2VkWnhPTE9GZ240ak85?=
 =?utf-8?B?eXdDSlZoZGwwTHh0MTcwbjVkbVUwQ0pWOWRkZXplVjJXd1kxOUlxRmhENkcv?=
 =?utf-8?B?d3RrV3N0RmozaE5EdWVmclcwSGIxcTZ4WCttR21RK0NoWjNWaU4rMTh6RDBO?=
 =?utf-8?B?bER3L2h4K1VLYTVJZmtnRHYvYVJlZE5uWlN4bG5KZGZIa2RHVko1UmNpbm8z?=
 =?utf-8?B?MVJkME0vN3RrN1pHM3pDd0Zydm52YTh6OURydmU5Y1MyS0FRcWRFR2VZa3Jk?=
 =?utf-8?B?SVNya2RRWkg4ZU5STlFTYUZ2SWdISjYrd3NvMmJieUF6RVJFUE14VmtOekE5?=
 =?utf-8?B?OFQxU1FtdThkd2NGdWlzeVM5ZlE1Z0R2M083c3RMcmc2QW9BeWlqRFFDazJG?=
 =?utf-8?B?dThuVFNqS0NuRnNHUlc5SFRSZUVBd2tlOUdNWWY0T2pDOTc2Q2FVRFpETCth?=
 =?utf-8?B?ZUErS3VLVVpUNHVScm1YNE0rNzE5MjFqV05FVkdjUmJDSlo1dlJsSkF1cHZ6?=
 =?utf-8?B?N1ZKZ2UwRTBDUXBWdnFQMjNOd1pkNnBoN1hidXIvVWtKa2xObUxxR0RlRmxr?=
 =?utf-8?B?YkRPSnc1TnlIMWgvYklydkNiM0t0azNPMm1IMHd4TmlNRUcwUXpZYWphMldX?=
 =?utf-8?B?dU1ZRE9VVVJxZWY3R3BPR0hsb0ZVRWFpVkkrNkt5Q2pLdFhzMmtnYTFyY0xB?=
 =?utf-8?B?NmdRa29oZTNDVElnTFhvaitWZVUyMUI2SzNIa0lGL3B0SzRhekIzbENJamdG?=
 =?utf-8?B?SG9mS1kycWg0VUQzbUtBNlpZbEdsNjZuMEQybmVSMlBBd3hXdUoxQU9HWDc5?=
 =?utf-8?B?QU0yVWJqdnBPMTNISEtLZTZpcWhWYXNGeHQ3ZzR6Y2dNUSs3dzA3V1hBSWtW?=
 =?utf-8?B?c3N0MDVkUVVOeTVGbmhjeGM5OForUlBxRjR2R1NoUEQ0YVdMOHdOSFk2VXFJ?=
 =?utf-8?B?ckw5ZEFaVzZhcElpVEFwdnp4cHJlcFY4VjZ4K1FGamRkdXIvOW5yZ2VEUjdV?=
 =?utf-8?B?UkI4NjRUMWl2MXNiMENld1FhQUR4SytIazRnV1NOdjJVUW9Fck93bTVYVVFD?=
 =?utf-8?B?TlRjeUVZdHFvY2F2UXRnZnl0cyttUUp3eGY3NmZzenljd244N05MSjRzWklw?=
 =?utf-8?B?QXJFWUZ0djRtRUtjZ1JwT2VDdjdpY2t1eTFmandiQUdYNFNGRVBVbEM0dEpt?=
 =?utf-8?B?RjdIRkpBeEdESzRvbVA4UlpZSzhwcXpUVVJFbGk5dkllVEdPVHRaZm1PY3k0?=
 =?utf-8?B?dk5jZzBJd2RxMXJWTEwvUFZQVXgzcnN4a2FscHJsK003QnMxQ3JVZXNNbzVy?=
 =?utf-8?B?V0ovOWxFUzlpTjhhV0NSN2hGM2oxVVNEYTlFUzJmcHVNeFp5VG0xbTQ1d3hO?=
 =?utf-8?B?dnU1eHBkcXo0clVzV1JwK0pFb3VQZVppb3dQL1lIVDNsUngweE11OG5wOUlO?=
 =?utf-8?B?MnU5SzlZTldXeUFJNkJ3WEFJUU9BTVlFUTVPWkF0MjAvc2lsYXQ2VHA4VCtZ?=
 =?utf-8?B?WUhmOFA2VHpaSVZNT0N6SElCcDJqcVpDSmp2WUFwbGM4NGlBeG43Z2sxdXh4?=
 =?utf-8?B?b290dWZoZUF0a3RGV1lFREJYSEpyQ09pVWU3Z0N2ZGUyMjk0blZ4YkZwQ0hi?=
 =?utf-8?B?amN3cVhwNzhQOUhGWm1NK2pGWU5QbGcvSEZIa0hzSGpPRWh0bUYxMVMxVVdB?=
 =?utf-8?B?dExqUk10SXExRGhFM0JBamJnVjZyOTZ5ZUhhZjdjOTA4UitOZjZOcmJETktZ?=
 =?utf-8?B?YUJ0c2hxaW1yWHlRQSthS3lwWS9ENktLRnJsZGRlSjZXTjN2NXh2UWl6RVJJ?=
 =?utf-8?B?d1J5V1pCa2h2bWU4TGJWVThPRncxVXNSR2NtRlpWaUdMN2RlQ0h2VHkrWGNk?=
 =?utf-8?B?TjA0a3VvdDN1MEJ0RWN1bmJvUWU5VUVKWlFzRndDekVwVEl1Y2xoU1Y5RjNl?=
 =?utf-8?B?bnVwbmgvQnhDbUd5MlNqZGdsSTdPQ0t3TjRSMTQvOFBYQXZ6QWw4NTJXbUZr?=
 =?utf-8?B?VDVSTEZ1bkJmR05pRk1LcnFNaVRBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9648ffb2-da84-4bf8-8e4b-08da6e11086e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 07:41:06.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrgXAcay2Y95vjob1BztU2/aTQ7SX+CPpiWifgCaXod5oJfbtwRGI6uJZaayMH4o/cWTC9JrJGpX3S+ZsJ+mBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250032
X-Proofpoint-GUID: k9HaIgc-_yB1zKDJ6bsyfZh9x3wqlB9p
X-Proofpoint-ORIG-GUID: k9HaIgc-_yB1zKDJ6bsyfZh9x3wqlB9p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15/07/2022 08:07, Fedor Tokarev wrote:
> On Thu, Jul 14, 2022 at 11:06:22AM +0100, Alan Maguire wrote:
>> On 13/07/2022 19:40, Andrii Nakryiko wrote:
>>> On Mon, Jul 11, 2022 at 2:45 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>>
>>>> On Mon, Jul 11, 2022 at 11:13:17PM +0200, Fedor Tokarev wrote:
>>>>> vsnprintf returns the number of characters which would have been written if
>>>>> enough space had been available, excluding the terminating null byte. Thus,
>>>>> the return value of 'len_left' means that the last character has been
>>>>> dropped.
>>>>
>>>> should we have test for this in progs/test_snprintf.c ?
>>>
>>> It might be too annoying to set up such test, and given the fix is
>>> pretty trivial IMO it's ok without extra test. But cc Alan for ack.
>>> Alan, please take a look as well.
>>>
>>
>> I can follow up with a test, it should be okay I think (we can use
>> the "don't show types" flag and tryp to print "10" with a 2-byte len or
>> similar).
> 
> I'll gladly give it a try.

Thanks! I've sent 

https://lore.kernel.org/bpf/1658734261-4951-1-git-send-email-alan.maguire@oracle.com/

If you could give it a try that would be great; tested at my end
with your fix and all works well. I'd suggest pulling it into a
2-patch series comprised of your fix + the selftest, but since the
fix targets bpf and the tests are new (so would be more like a bpf-next
candidate), not sure if that's the right way to handle this..

If not I can follow up with the test once the fix lands.

Anyway thanks again for finding and fixing this!

Alan 

> 
>> In terms of the fix, it looks good, but given that the code is tricky, 
>> it might be good to expand a bit on the explanation. Something like the below?
>>
> Agreed.
> 
>> "When using btf_type_snprintf_show(), the user passes in a "len" value, and
>> we use it to initialize ssnprintf.len_left, indicating how much space
>> remains for the string representation, including the null byte, so "len - 1" 
>> bytes are actually available for the actual string data, leaving one for 
>> the terminating null byte.
>>
>> In btf_snprintf_show() - which is passed the ssnprintf data as an argument -
>> vsnprintf() returns the len that would have been written, and this _excludes_ 
>> the null terminator. But we want to handle cases where the length of the string
>> to be written (excluding the null terminator) exactly matches the original len 
>> value we passed in (len == len_left) in the same way was we do other
>> overflow cases (len > len_left)."
>>
>> Acked-by: Alan Maguire <alan.maguire@oracle.com>
>>
>>>>
>>>> jirka
>>>>
>>>>>
>>>>> Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
>>>>> ---
>>>>>  kernel/bpf/btf.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>>> index eb12d4f705cc..a9c1c98017d4 100644
>>>>> --- a/kernel/bpf/btf.c
>>>>> +++ b/kernel/bpf/btf.c
>>>>> @@ -6519,7 +6519,7 @@ static void btf_snprintf_show(struct btf_show *show, const char *fmt,
>>>>>       if (len < 0) {
>>>>>               ssnprintf->len_left = 0;
>>>>>               ssnprintf->len = len;
>>>>> -     } else if (len > ssnprintf->len_left) {
>>>>> +     } else if (len >= ssnprintf->len_left) {
>>>>>               /* no space, drive on to get length we would have written */
>>>>>               ssnprintf->len_left = 0;
>>>>>               ssnprintf->len += len;
>>>>> --
>>>>> 2.25.1
>>>>>
