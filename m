Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3444AFD8E
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiBITek (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 14:34:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiBITej (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 14:34:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1491C050CF9
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 11:34:33 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219HJ8dN020339;
        Wed, 9 Feb 2022 11:34:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aGvBdJsFT5R/7/fSHx6EAnKZNHi4iVMWyBgtRQNUvPM=;
 b=RlTCbCxT2OgI2nl2RDlMgvFO+1Ep4wPE+yMD6feem8ks+2YTCBKfIUsjwZJ4uXK5jmGj
 juhEpRwhfTRk+IaOpACoNb3Fyfdt4oryQ/MbG/4P7KMCcmpDZ/hlLxwFIdMyap5URlMq
 hdOvLWoGsQjnex3GtyY9cRtjLGXyTWc7oco= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4fyk21tv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Feb 2022 11:34:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 11:34:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKAvCxw1poHbBYSU/WLxIk1NIMaLzgWnqtoj4pFo/NW020TH28gEUBAm7HAHKwTtdnx6Gg9LTKK0mOQT6zTZpsZk+Z4O9hZNKKWiXlNxesApz+bHRiL0bjR/tS+/FMwyysqxaxonmpT0Q7w9MjlTQdMIQfp12F/EOJRf/qWT5cxlHM9juYQzkHqUMctpfj9D/xlR9KN36DK/J2JvTOfrG6vtVvA+0/rQocrdTZ71722GtlqS0zydYZtex2j74iTAaG8v6AOB1T7CbiX86x74HfVnV/vuYUYCyhUEJnNBpiE6mqdzkWxAxK2C2DaaU4jKP1/uqsWZPOnzkvQZor2NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGvBdJsFT5R/7/fSHx6EAnKZNHi4iVMWyBgtRQNUvPM=;
 b=eO0JzRK/5xSVah25FQm+jaqvp8rz0F2J7DUBSIDxbjxEXHss+1oV+gzYY6nSFVTfBS/GEz7d9QWsUtbwtB+tN3f0tIy7QrMaHmq9ck1+b7Yhh+AZms10lu2h3132B71pQ4FdlSv759exBz5sYW46WC0k81icUa/4lZPNpHRUsVQJ4s1d0g3jAAxjj22qOzzDVATtzY19nUndcIWtiubEseKKlzjDdQddyqkH169lL5xJQmdBaResveq8j7Z+dNngZEqp3IVL6QrbMQuuTKvPbovC9s71xR0R/WULh4rWo85/j+ATvA8yoHTA0Bh9R+FQ/7bJ7Nz6+IclGXwKXwK7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1495.namprd15.prod.outlook.com (2603:10b6:903:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:34:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:34:14 +0000
Message-ID: <78c73411-690b-5cd0-d149-32009cacb9d9@fb.com>
Date:   Wed, 9 Feb 2022 11:34:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     Timo Beckers <timo@incline.eu>, bpf <bpf@vger.kernel.org>
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
 <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com>
 <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
 <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com>
 <24b0f506-00f5-77b9-dff8-9a1db8aaa1c5@incline.eu>
 <b33e24d0-3539-3c7c-8be0-7d9ea335b28d@fb.com>
 <CAK3+h2zMRNKqA5k6FE4BG8RnJ2Tx1itVJiJGbhXaCu=v=0U47w@mail.gmail.com>
 <5bc02911-9ebf-6f4a-3804-d72c405326b6@fb.com>
 <a9afc769-5e6c-cdb9-7adf-90ed1a6c1974@fb.com>
 <CAK3+h2zD0NGjGoqK8rZqtp=-c4e7YV8OJEooun1XF8=y1kxo+A@mail.gmail.com>
 <CAK3+h2wNtitdBANw+qW+HoAkKfJynM9EH4xuom4Zi1UsrkiS6A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAK3+h2wNtitdBANw+qW+HoAkKfJynM9EH4xuom4Zi1UsrkiS6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:320:31::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b400905d-bab1-4ff2-4fc9-08d9ec0327a4
X-MS-TrafficTypeDiagnostic: CY4PR15MB1495:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB1495978287168AEC7C88C67DD32E9@CY4PR15MB1495.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YeSJItynyZqKdQMoLnwcsX4SK0xbFPs73VVMz60Ixp8vv1suR2zwv6AOfrHabYfVdaTsVjenlYnDET8Wimma+M6Bbal02/XiRhYBitBzX5NXWS5mWYPJJyKTdkH3l7Y30sUc9uuv9o7CG1OtwuWR+YMIj40urJiU4nGT2Fhle7OTq1rFnOAWvvjV9yE+wwcUeB5zRfvz9u5Jt8PkO49Lwcx3whn7jRIUmPkZfrZ4qw5zSu1wvnQUV6XdLLb3yWGZuOazZlx9QcCIW7tjuzL6aaaq1v3eKCxUNqCjAHzk4ojZb4aMI1nx65pOcYtdxTZWli5f7pe39Hkmg1QCK/FLJMlVuhQpU0EnMxUWC27rK+CISztzPyVh0m7MJG4RGBUVBzii+bCdit148Oe8eqsvsNOvHGV+eW9eVc/gLNxZpVwjRHowMrlQxDTniBIWQkw9/s09HW0sQAl1VkBrqPKHnZkK2su6frjwet0jgnkkdgzAaevd9fjLKRghknAFWerY5LVHdD/igXDLA7eZnvG7eiyfmDFoQuOGjSF0eBrSS0FlAal/aAOYUVcx6/KI6w+ecj+swfAhsfpb8XW0b6O0vB71/prtjwNX3O0XcAvWZTxto6dvBtBwbIW5vc1rYbNOTKFWEJPK4iKmtdV+IsX8oj7bKPHJ12B27JTWbspNm8+3+uWhKbdeXrvCVtuQplKKYNeFXd4ySvEbpG4mLVYNq3tCyaR8hxjAMZ6+UCSRvl8yCiZ34YkkXDlrWB4uTdU9NjO5EoC57QVAxAjKK6tGql+KynOXtcqnI1O5lZQrQFLYMvZnGcaoCiSGlY1A6c4tsdikk9FLSTJldXhLhdbrmTc00xlzJDjeyBUUplD4fgSGXiZ/FzNVJ8zfKYGVf5mY1EEdpHwEjHSOuMi/DGiX0wmrb/PM4NTbhh6e+S71tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6916009)(186003)(38100700002)(54906003)(316002)(5660300002)(31696002)(86362001)(2906002)(30864003)(8676002)(4326008)(66476007)(66556008)(66946007)(6512007)(83380400001)(2616005)(6486002)(966005)(52116002)(508600001)(6506007)(6666004)(53546011)(36756003)(31686004)(142923001)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9mNHJHcHdwMHAxTUhoL2JJNnBkUURMQk5oa1VLQUpUbExIYlcrZ1NEK0Rn?=
 =?utf-8?B?MHlNemtObDRNNGtJT2k4SlFNL0tkay9uUEhVRmF6UGxkdmNJUyswQndTcC9G?=
 =?utf-8?B?NHVZdUlIMzc0WEIvV3ZJeEp6UWFKdWdNWVVPT1o0R05wRmdnQitEcGRCVEZK?=
 =?utf-8?B?SHFrZ1JQR0RjRmxEdWVOcmtCTnBNaHJXOEhZdlA4b3ZiallKUThsYXo5QTR2?=
 =?utf-8?B?QXFGdXNRUk9qMjVndng0UGVnaFA4YnRXY21rQ2Rua3diLzhONFIrNTFsb2dl?=
 =?utf-8?B?dHdySWNDeEZYZXNxNUpyMU40bitJYS9KSVZwQjZmcVY4Q0hiVWR2dXR3WWJx?=
 =?utf-8?B?emlURncrWVJ5WlFGcnRpVXZJZ2hRdThpejFwUW96Q3BjK1dKdW1ISHF1Tlhm?=
 =?utf-8?B?V2R5d3RzMURjUWx2QlN5aTFiMmQ4ZjBaTTY5bXRlanF3cGNKSmFpNjRkcERM?=
 =?utf-8?B?YU00OUROa241WStQZ2NnRXRNUlQrSEVubjBEV1lWZzBubkIzekdTRFpSeE1D?=
 =?utf-8?B?RjBiMXgxOWFxNDZYdzVzRHNSNkI3SUhiQXhLSVZ2aFdDK2d4YkRZR2lPK1lr?=
 =?utf-8?B?YncwM0M1ekg2T2QrWmw1RmJUTzlidkR0dkdjR25mK0psWk54R3ZKVTZzVzBp?=
 =?utf-8?B?SUk4V1JVVzdCeFlrL2FGUXI0TlNPL2ZtNy9NSTJhd2ZTRFNXb2N4UThGUXFx?=
 =?utf-8?B?eGZxWVRRODdMa3EydnMrL1BLNkhVcDQ0YlZNTU1LZEtPQm9nOFBBMkhGbWt5?=
 =?utf-8?B?cXN5a05waVdWYjNRSzhXV1NNUm5RTHVodGtIS1dWTnBEWWNwK05wZUtmTTdw?=
 =?utf-8?B?eXQ1WW5peUV0ajUxMHY5RUw4cmdRQkZISHk5T1d1OUdNWlErV2QzaWJTbG14?=
 =?utf-8?B?VVAwT3NSZEZSM3RnMDJXVWpTQTNRQ3ZuWFYwRm1RYkRZTy81M283MzdGVVY4?=
 =?utf-8?B?WDJicFcyQUhDazdMSWNDVFo5c0s5Z01QSHVJdWJnVHJ0MFhUcW9qUWw3Rkpk?=
 =?utf-8?B?VWhsQXVDR1lEWDNuVzdGbk1temtWcnV5TkUwdWhEcUk2ZEFiK3VCKzBPdStH?=
 =?utf-8?B?NlV4ekN2N1JJQWlleDhneFdwM2RKek9tR2phallKUkhjcHBIMVY3b1NrUUd3?=
 =?utf-8?B?cUcwWmdnTTlkYlNRem1GTWJpTnJzVE1pVk5yVk1mY2h4Y1ZYQlBZQ2paTlhp?=
 =?utf-8?B?TGlKdXhHNGR2SFNOcUdaY1gvNDBCR3JDNmk1QkRYR0tScGVXNjZCY0xZb2dv?=
 =?utf-8?B?YUdnTTFLbklUSmNkN1k2ZEZnSFJjbHBjdHFxTkN2OUFDVVBONkRqLzNDRjhL?=
 =?utf-8?B?V3FvNWNuU1BPektEV2c5Skd0SjdsTjhQNVVJWmJQZXJ0TDdFSzlVcDE4ak9k?=
 =?utf-8?B?UmJ0UTcvRU5RbkxRYzhpWDdwRmZmZmpkb3BncGdyZE90azJBY0tWaGNLVVJS?=
 =?utf-8?B?Z3loUlUxa2VkRFRLR0dIL1V4Qmg2OUgzOU1QaGJESFpJUzQyWmRjQ2hlN2Nt?=
 =?utf-8?B?TVNiR0c4WEVQN1RnbHRlVFpQNnEyTGF5WGx2YVVtOWZEZG1lZ2JsZUVpSXoz?=
 =?utf-8?B?eXYxdXFsMzBIREZaclo2UVBNbU4zRWlzeHBRYTFPeEs4WmN2UHR2L0UyQXhk?=
 =?utf-8?B?Q1BUY3VzNnh6R0pxYWZVTzNYNERPZW1icktramR3cUEwbWRINUN5QkRxY0NF?=
 =?utf-8?B?WDhDbW0yRFhBM0tiRiswK09JS3kxMDJ6TjN1TEh5K3FUVHRwU29KQk43Y2RC?=
 =?utf-8?B?WWFoR3ZLdUtrbWtISEkyV0FxRXZaRzhjUTJYTFpUV3RET0FkUnYxblpwTDRw?=
 =?utf-8?B?SDE0djBuUmN1bXBDaEZCa3VjT3NYejFnOGNPV0NpbDUxQjdKbE9zM2pTZTU3?=
 =?utf-8?B?aVlpNnhCekVtNmFRMHJsd0xjY0FjSXJheXVnUlNrNmdjcmZURDhacGU0MjVZ?=
 =?utf-8?B?bTlGRUc2OTdjNFkyVjhTN250REFTK3Ryei83V1RkWWNLRmxubFFhV0VUWHd4?=
 =?utf-8?B?Ujk2dkRXUzlsVlF3ZXFvbkhqK1FwWUJQcUJiTmEreDVVZExhQkFETVIvTXNm?=
 =?utf-8?B?S203b3ZqQng4SDIyL0RvTVlqcGdKakh1Ly9MVkQ5UjNUeUJPUWtOd2tjc2hM?=
 =?utf-8?B?SnFzeXdoaXRJTXR6MW5oaTVGVWhGc1lCbEk3blpVd1hQSjdwWE9jUkt2ZC9M?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b400905d-bab1-4ff2-4fc9-08d9ec0327a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:34:14.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQRMSIFsNHMUAXOziekE19qEfpjOSNWZGw/ifNCdHclRrhHYU4VRoNd/dnfVmzBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1495
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 20GHfCLLx-lvY-mQVXSL1HshRfRn7nSz
X-Proofpoint-ORIG-GUID: 20GHfCLLx-lvY-mQVXSL1HshRfRn7nSz
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_10,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202090103
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



On 2/8/22 10:48 AM, Vincent Li wrote:
> On Tue, Feb 8, 2022 at 10:28 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>
>> On Mon, Feb 7, 2022 at 10:47 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 2/4/22 1:22 PM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 2/4/22 11:39 AM, Vincent Li wrote:
>>>>> On Fri, Feb 4, 2022 at 10:04 AM Yonghong Song <yhs@fb.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2/4/22 3:11 AM, Timo Beckers wrote:
>>>>>>> On 2/3/22 03:11, Yonghong Song wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/2/22 5:47 AM, Timo Beckers wrote:
>>>>>>>>> On 2/2/22 08:17, Yonghong Song wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2/1/22 10:07 AM, Vincent Li wrote:
>>>>>>>>>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li
>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li
>>>>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> this is macro I suspected in my implementation that could
>>>>>>>>>>>>>>> cause issue with BTF
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> #define ENABLE_VTEP 1
>>>>>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a,
>>>>>>>>>>>>>>> 0x1f48a90a,
>>>>>>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>>>>>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>>>>>>>>>>> #define VTEP_NUMS 4
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li
>>>>>>>>>>>>>>> <vincent.mc.li@gmail.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> While developing Cilium VTEP integration feature
>>>>>>>>>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a
>>>>>>>>>>>>>>>> strange issue
>>>>>>>>>>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>>>>>>>>>>> implementation, the issue is described in
>>>>>>>>>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know
>>>>>>>>>>>>>>>> much about
>>>>>>>>>>>>>>>> BTF and not sure if my implementation is seriously flawed
>>>>>>>>>>>>>>>> or just some
>>>>>>>>>>>>>>>> implementation bug or maybe not compatible with BTF.
>>>>>>>>>>>>>>>> Strangely, the
>>>>>>>>>>>>>>>> issue appears related to number of VTEPs I use, no problem
>>>>>>>>>>>>>>>> with 1 or 2
>>>>>>>>>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance
>>>>>>>>>>>>>>>> from BTF
>>>>>>>>>>>>>>>> experts  are appreciated :-).
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Vincent
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Sorry for previous top post
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>>>>>>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>>>>>>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2
>>>>>>>>>>>>>> members
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a,
>>>>>>>>>>>>>> 0x1f48a90a,
>>>>>>>>>>>>>> 0x2048a90a, }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above
>>>>>>>>>>>>>> VTEP_ENDPOINT
>>>>>>>>>>>>>> member <=2. any reason why compiler would do that?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>>>>>>>>>>> you have some 32-byte constants which needs to be saved
>>>>>>>>>>>>> somewhere.
>>>>>>>>>>>>> For example,
>>>>>>>>>>>>>
>>>>>>>>>>>>> $ cat t.c
>>>>>>>>>>>>> struct t {
>>>>>>>>>>>>>         long c[2];
>>>>>>>>>>>>>         int d[4];
>>>>>>>>>>>>> };
>>>>>>>>>>>>> struct t g;
>>>>>>>>>>>>> int test()
>>>>>>>>>>>>> {
>>>>>>>>>>>>>          struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>>>>>>>>>>          g = tmp;
>>>>>>>>>>>>>          return 0;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> $ clang -target bpf -O2 -c t.c
>>>>>>>>>>>>> $ llvm-readelf -S t.o
>>>>>>>>>>>>> ...
>>>>>>>>>>>>>         [ 4] .rodata.cst32     PROGBITS        0000000000000000
>>>>>>>>>>>>> 0000a8 000020
>>>>>>>>>>>>> 20  AM  0   0  8
>>>>>>>>>>>>> ...
>>>>>>>>>>>>>
>>>>>>>>>>>>> In the above code, if you change the struct size, say from 32
>>>>>>>>>>>>> bytes to
>>>>>>>>>>>>> 40 bytes, the rodata.cst32 will go away.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize
>>>>>>>>>>>> rodata.cst32 then
>>>>>>>>>>>
>>>>>>>>>>> Hi Yonghong,
>>>>>>>>>>>
>>>>>>>>>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux
>>>>>>>>>>> and
>>>>>>>>>>> stores BTF type info in btf.Spec.namedTypes, but the elf object
>>>>>>>>>>> file
>>>>>>>>>>> provided by user may have section like rodata.cst32 generated by
>>>>>>>>>>> compiler that does not have accompanying BTF type info stored in
>>>>>>>>>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>>>>>>>>>>> guaranteed to  have every BTF type info from application/user
>>>>>>>>>>> provided
>>>>>>>>>>> elf object file ? I guess there is no guarantee.
>>>>>>>>>>
>>>>>>>>>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
>>>>>>>>>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
>>>>>>>>>> program BTF.
>>>>>>>>>>
>>>>>>>>>> Did you actually find an issue with .rodata.cst32 section? Such a
>>>>>>>>>> section is typically generated by the compiler for initial data
>>>>>>>>>> inside the function and llvm bpf backend tries to inline the
>>>>>>>>>> values through a bunch of load instructions. So even you see
>>>>>>>>>> .rodata.cst32, typically you can safely ignore it.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Vincent
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Yonghong,
>>>>>>>>>
>>>>>>>>> Thanks for the reproducer. Couldn't figure out what to do with
>>>>>>>>> .rodata.cst32,
>>>>>>>>> since there are no symbols and no BTF info for that section.
>>>>>>>>>
>>>>>>>>> The values found in .rodata.cst32 are indeed inlined in the
>>>>>>>>> bytecode as you
>>>>>>>>> mentioned, so it seems like we can ignore it.
>>>>>>>>>
>>>>>>>>> Why does the compiler emit these sections? cilium/ebpf assumed up
>>>>>>>>> until now
>>>>>>>>> that all sections starting with '.rodata' are datasecs and must be
>>>>>>>>> loaded into
>>>>>>>>> the kernel, which of course needs accompanying BTF.
>>>>>>>>
>>>>>>>> The clang frontend emits these .rodata.* sections. In early days,
>>>>>>>> kernel
>>>>>>>> doesn't support global data so llvm bpf backend implements an
>>>>>>>> optimization to inline these values. But llvm bpf backend didn't
>>>>>>>> completely remove them as the backend doesn't have a global view
>>>>>>>> whether these .rodata.* are being used in other places or not.
>>>>>>>>
>>>>>>>> Now, llvm bpf backend has better infrastructure and we probably can
>>>>>>>> implement an IR pass to detect all uses of .rodata.*, inline these
>>>>>>>> uses, and remove the .rodata.* global variable.
>>>>>>>>
>>>>>>>> You can check relocation section of the program text. If the .rodata.*
>>>>>>>> section is referenced, you should preserve it. Otherwise, you can
>>>>>>>> ignore that .rodata.* section.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> What other .rodata.* should we expect?
>>>>>>>>
>>>>>>>> Glancing through llvm code, you may see .rodata.{4,8,16,32},
>>>>>>>> .rodata.str*.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Timo
>>>>>>>
>>>>>>> Thanks for the replies all, very insightful. We were already doing
>>>>>>> things mostly
>>>>>>> right wrt. .rodata.*, but found a few subtle bugs walking through
>>>>>>> the code again.
>>>>>>>
>>>>>>> I've gotten a hold of the ELF Vincent was trying to load, and I saw
>>>>>>> a few things
>>>>>>> that I found unusual. In his case, the values in cst32 are not
>>>>>>> inlined. Instead,
>>>>>>> this ELF has a .Lconstinit symbol pointing at the start of
>>>>>>> .rodata.cst32, and it's
>>>>>>> an STT_OBJECT with STB_LOCAL. Our relocation handler is fairly
>>>>>>> strict and requires
>>>>>>> STT_OBJECTs to be global (for supporting non-static consts).
>>>>>>
>>>>>> There are two ways to resolve the issue. First, extend the loader
>>>>>> support to handle STB_LOCAL as well. Or Second, change the code like
>>>>>>        struct t v = {1, 5, 29, ...};
>>>>>> to
>>>>>>        struct t v;
>>>>>>        __builtin_memset(&v, 0, sizeof(struct t));
>>>>>>        v.field1 = ...;
>>>>>>        v.field2 = ...;
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> ---
>>>>>>> ~ llvm-readelf -ar bpf_lxc.o
>>>>>>>
>>>>>>> Symbol table '.symtab' contains 606 entries:
>>>>>>>       Num:    Value          Size Type    Bind   Vis       Ndx Name
>>>>>>>         2: 0000000000000000    32 OBJECT  LOCAL  DEFAULT    21
>>>>>>> .Lconstinit
>>>>>>>
>>>>>>> Relocation section '.rel2/7' at offset 0x6bdf0 contains 173 entries:
>>>>>>>        Offset             Info             Type
>>>>>>> Symbol's Value  Symbol's Name
>>>>>>> 0000000000007300  0000000200000001 R_BPF_64_64
>>>>>>> 0000000000000000 .Lconstinit
>>>>>>> ---
>>>>>>>
>>>>>>> ---
>>>>>>> ~ llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf_lxc.o
>>>>>>> warning: failed to compute relocation: R_BPF_64_64, Invalid data was
>>>>>>> encountered while parsing the file
>>>>>>> ... <2 more of these> ...
>>>>>>>
>>>>>>> Disassembly of section 2/7:
>>>>>>>
>>>>>>> 00000000000072f8 <LBB1_476>:
>>>>>>>        3679:       67 08 00 00 03 00 00 00 r8 <<= 3
>>>>>>>        3680:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2
>>>>>>> = 0 ll
>>>>>>>                    0000000000007300:  R_BPF_64_64  .Lconstinit
>>>>>>>        3682:       0f 82 00 00 00 00 00 00 r2 += r8
>>>>>>>        3683:       79 22 00 00 00 00 00 00 r2 = *(u64 *)(r2 + 0)
>>>>>>>        3684:       7b 2a 58 ff 00 00 00 00 *(u64 *)(r10 - 168) = r2
>>>>>>>
>>>>>>> Disassembly of section .rodata.cst32:
>>>>>>>
>>>>>>> 0000000000000000 <.Lconstinit>:
>>>>>>>           0:       82 36 4c 98 2e 56 00 00 <unknown>
>>>>>>>           1:       82 36 4c 98 2e 55 00 00 <unknown>
>>>>>>> ---
>>>>>>>
>>>>>>>
>>>>>>> This symbol doesn't exist in the program. Worth noting is that the
>>>>>>> code that accesses
>>>>>>> this static data sits within a subscope, but not sure what the
>>>>>>> effect of this would be.
>>>>>>>
>>>>>>> Vincent, maybe try removing the enclosing {} to see if that changes
>>>>>>> anything?
>>>>>>>
>>>>>>> ---
>>>>>>> static __always_inline int foo(struct __ctx_buff *ctx,
>>>>>>>
>>>>>>> ... <snip> ...
>>>>>>>
>>>>>>>         {
>>>>>>>                 int i;
>>>>>>>
>>>>>>>                 for (i = 0; i < VTEP_NUMS; i) {
>>>>>>>                         if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
>>>>>>>                                 vtep_mac = VTEP_MAC[i];
>>>>>>>                                 break;
>>>>>>>                         }
>>>>>>>                 }
>>>>>>>         }
>>>>>>> ---
>>>>>>>
>>>>>>> Is this perhaps something that needs to be addressed in the compiler?
>>>>>>
>>>>>> If you can give a reproducible test (with .c or .i file), I can take a
>>>>>> look at what is missing in llvm compiler and improve it.
>>>>>>
>>>>>
>>>>> not sure if it would help, here is my step to generate the bpf_lxc.o
>>>>> object file with the .rodata.cst32
>>>>>
>>>>> git clone https://github.com/f5devcentral/cilium.git
>>>>> cd cilium; git checkout vli-vxlan; KERNEL=54 make -C bpf
>>>>> llvm-objdump -S -r -j 2/7 -j .rodata.cst32 bpf/bpf_lxc.o
>>>>
>>>> Thanks. I can reproduce the issue now. Will take a look
>>>> and get back to you as soon as I got any concrete results.
>>>
>>> Okay, I found the reason.
>>>
>>> For the code,
>>>
>>>                   for (i = 0; i < VTEP_NUMS; i++) {
>>>                           if (tunnel_endpoint == VTEP_ENDPOINT[i]) {
>>>                                   vtep_mac = VTEP_MAC[i];
>>>                                   break;
>>>                           }
>>>                   }
>>>
>>> The compiler transformed to something like
>>>
>>> i = 0; if (tunnerl_endpoint == VTEP_ENDPOINT[0]) goto end;
>>> i = 1; if (tunnerl_endpoint == VTEP_ENDPOINT[1]) goto end;
>>> i = 2; if (tunnerl_endpoint == VTEP_ENDPOINT[2]) goto end;
>>> i = 3; if (tunnerl_endpoint == VTEP_ENDPOINT[3]) goto end;
>>>
>>> end:
>>>      vtep_mac = VTEP_MAC[i];
>>>
>>> The compiler cannot inline VTEP_MAC[i] since 'i' is not
>>> a constant. Hence later we have a memory load from
>>> a non-global .rodata section.
>>>
>>> As I mentioned earlier, there are two options to fix the issue.
>>> First is for cilium to track and handle non-global .rodata
>>> sections. And the second you can apply the below code change,
>>>
>>> diff --git a/bpf/node_config.h b/bpf/node_config.h
>>> index 9783e44548..b80dd2b27b 100644
>>> --- a/bpf/node_config.h
>>> +++ b/bpf/node_config.h
>>> @@ -176,15 +176,15 @@ DEFINE_IPV6(HOST_IP, 0xbe, 0xef, 0x0, 0x0, 0x0,
>>> 0x0, 0x0, 0x1, 0x0, 0x0, 0xa, 0x
>>>    #endif
>>>
>>>    #ifdef ENABLE_VTEP
>>> -#define VTEP_ENDPOINT (__u32[]){0xeb48a90a, 0xec48a90a, 0xed48a90a,
>>> 0xee48a90a, }
>>> +#define VTEP_NUMS 4
>>> +__u32 VTEP_ENDPOINT[VTEP_NUMS] = {0xeb48a90a, 0xec48a90a, 0xed48a90a,
>>> 0xee48a90a};
>>>    /* HEX representation of VTEP IP
>>>     * 10.169.72.235, 10.169.72.236, 10.169.72.237, 10.169.72.238
>>>     */
>>> -#define VTEP_MAC (__u64[]){0x562e984c3682, 0x552e984c3682,
>>> 0x542e984c3682, 0x532e984c3682}
>>> +__u64 VTEP_MAC[VTEP_NUMS] = {0x562e984c3682, 0x552e984c3682,
>>> 0x542e984c3682, 0x532e984c3682};
>>>    /* VTEP MAC address
>>>     * 82:36:4c:89:2e:56, 82:36:4c:89:2e:55, 82:36:4c:89:2e:54,
>>> 82:36:4c:89:2e:53
>>>     */
>>> -#define VTEP_NUMS 4
>>>    #endif
>>>
>>
> 
> I may misunderstand you, I thought your suggestion would stop compiler
> generating .rodata.cst32, but it appears
>   the compiler still generated .rodata.cst32 after applying your changes
> 
> readelf -e bpf/bpf_lxc.o | grep 'rodata'
> 
>    [51] .rodata.cst32     PROGBITS         0000000000000000  00045f48

In my case, I didn't have rodata section.
compiled with `KERNEL=54 make -C bpf`
clang is latest upstream:
   clang --version
   clang version 15.0.0 (https://github.com/llvm/llvm-project.git 
4f97aa7e1d70f1b259e5fddd85de05235b01b192)
But I think any recent compiler should have the same result.
   readelf -e bpf/bpf_lxc.o | grep 'rodata'
   <no output>

> 
>> Thank you Yonghong for the suggestion, the original code is kind of
>> hack from me to work around some issue :). now we decided to abandon
>> above code and use BPF hash map for VTEP lookup in Cilium to avoid
>> this issue and to be more flexible, so it is up to cilium/ebpf to
>> decide to address the rodata or not.
>>
>>>    /* It appears that we can support around the below number of prefixes
>>> in an
>>>
>>>>
>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks again,
>>>>>>>
>>>>>>> Timo
