Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080D06F0FAB
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 02:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjD1AfN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 20:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbjD1AfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 20:35:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2D8B9
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 17:35:11 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33RIPcGZ028210;
        Thu, 27 Apr 2023 17:34:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=5AwML8lWeWv6MCrFJSuQX4J1JAK4CUV4UDKiNFjxx9c=;
 b=XNY9JLFJankWoZ+zDh93t8huos5ljexuJeFD8E1AjgsXfgRIgnZXhFc0Ckh0ufTOBWin
 +xjw+iKW8rEWM7mhhSeEXoKJmjKnJZYNNu0zNpTo9Cr5yOzS5NrRmUd4X6nDoOsArgOs
 huZYEPM5s/5+39nup4UWjPvNtrjZNMDWD8rKUpCGS9+A4p/lSYQeMr1PetA3+ooT+7+k
 zcBZ2GQOb5bof1MrhVeVV4Bx3WiRo9Nc9vg234m1tuNWuHio3Dht3Ha4nVrTrbYkblB3
 mjUQwL/g5mSsctKOJVGnsyWptSvyMHRi2kDGYxJIGS20iDlEXOiGlraYwvkbtTQCRlFs Hw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by m0001303.ppops.net (PPS) with ESMTPS id 3q7rae5mtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 17:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS/xU0wRD9ih/QtvXKQEyBtAnBBxfBTg3pjADEKo2agsaHMEoCPjf/qzh7MpxMsKhBIJlnvXPNgCIdWByhMUXSdXXCgTOpDOIartZnlgICiK36Uc0GhVuNEtGlAvhPSdsYpF6CZRJZnEqpl73eddm5iubhOoJvhiaqi2xoupd94PPSYo4W9l4SIrCOgthlTpxZikWHVZTFL5sy4Y0CE+Ga5JfHwULsPjhZR88GtVwJE825aW29W94mRTRWt4sMZJWpY1dPPReZnASadqyzqKI7jO3v8oiFAyNwFfE7CI6wdSn6X+hsyBLocowxRgHFPvDbansc5tV4ZMUCKUQLfCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AwML8lWeWv6MCrFJSuQX4J1JAK4CUV4UDKiNFjxx9c=;
 b=GOxU4WiyHoNzCBy585OI0tY4bvNfr98NWNPBNSzXgeu7e0gc0Yh6SRYCjJQKWfcRFSvz6M7qFVvzCnowC+aAPmwookk2u3Rrp2DSGOWHT3Kr6mi7r5eeCfxWzGH039+EdSA5aqcqZgtRL61muDFDpzM09mheCzRmS7vjF9W1LOFLMSHMn2Exd5kIZ5AZXN3AUuCFVuBZwmp19i/KDgjnzSfvINIByduMMEV//dZvwIyrWVf3iR1isP8e8bPSYWI8gaEqoHDkhX3I5Ebj8yAC5NHljnrxxZfSpgKi7SGEpxSEAZh/2Udo1sL6NG8LXCwT/os5HuszXNDM/XES76a6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH3PR15MB6307.namprd15.prod.outlook.com (2603:10b6:610:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 00:34:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 00:34:55 +0000
Message-ID: <a4108406-57e9-12de-d3c2-74b1f4aab08d@meta.com>
Date:   Thu, 27 Apr 2023 17:34:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test_progs can read test
 lists from file
Content-Language: en-US
To:     Stephen Veiss <sveiss@meta.com>, bpf@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
References: <20230427225333.3506052-1-sveiss@meta.com>
 <20230427225333.3506052-3-sveiss@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230427225333.3506052-3-sveiss@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH3PR15MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: f4347f5b-0065-4804-924a-08db478063af
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgGBSwT0QQT+tXvwr9t2HofE/XYtLhIaQxXnLFC0m73HU9gMrtgEn3XEl0AXBn1OfrUg3y2OeuQBuZ5S4oVfKdPTLL1NTshz15Nh8JRQQs8zilSnE/vZWTQERMDlL0qbHtlE4BntZOTInO/as76HyDOSLBwoxmOzrcHNQQJ9/hi5JlU/F5vdSenDPoWRv1wv5QtkGMrM67UPxFD8qAHBzJzPSzElbDVBQwKQRj9/iw1pulkc4XMg9fs2/lujIovObRykh886ai8edkS/9flUcmO/wjIhsHjjSWF9cjRZX0ulUv0tMMCLmlNa2/ek2p6vozICgdWo7uYozWBnQqLCcwgecjm9VPp+RrBRs6GR5KVDuJfzxUTG7EMgNKYZDzWXar5RtuXv+oMM9BNPeyQkapOqmvMCYeKk5USBrgHP8brwFpe9gTXzSZ5qfiTeruYrLC2eWPE/+otcyOTRaSC1uzboZH6dNQwzQW48p7s79VGu7pLyBa1n1AV+tLKWCS2CAsevLcVK+s8I+a+Ncqhje35ucYdpI/HshaxUt02F9yvXDkV3jJZtNaz14oHti6oiywf2V3zO5TLboiFAcK//UcKaQhvFwGgtrjWT6Ucp7XHAvdpfN5VHUp7LLPagN3FzaiZbmOBs3nTu42vohnTS8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(38100700002)(66556008)(5660300002)(31696002)(66946007)(66476007)(8936002)(8676002)(41300700001)(316002)(86362001)(4326008)(186003)(53546011)(6512007)(6506007)(6486002)(36756003)(2616005)(31686004)(2906002)(4744005)(478600001)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pRb3UzTitvQWpiSFVvcGJIKzN6bkEzZ1dqV3NKc3hmMmw0cHhQaWZWcThn?=
 =?utf-8?B?em1OdjJscmFHV0prNHJQVEFyV2hBSFcvMFRPdHdWazEyVWs5WkhyWE50VE5a?=
 =?utf-8?B?L202Y2FGTUZFNkl3azQ1aVVxaW5JTlF3MldZSVo0Sml2TFRId2NNVHRybVhm?=
 =?utf-8?B?ZU5PbGtFOUszMXdvTm51R0gzb2w4dTdTcHRYSVFHN3NXV0FnUTdvMXI4K1M3?=
 =?utf-8?B?dEJwbW5aTFdmY3pBSlpYaWZCbXp3TDJITnJjRURmTDNrWGxyK2lsdnB0dk9P?=
 =?utf-8?B?dWJsSjdmaDJJbkRRd0FUWUQ0U3Ewd0FrU1g2WkEzMGRYYkhuVlF3aGpCdGNn?=
 =?utf-8?B?SS8yZVFHMTdEQ1J5aWlqOFA1OXZYMGQ2UHNFcmw1bDFiTU1GSXlBQWxteHQ1?=
 =?utf-8?B?OGUvazNLQnJmUFNzTllMODV3WHFGVnNBajNmRm9NRlk5S0Fsa05PYlhaQjg4?=
 =?utf-8?B?aHc5S3J6bXRSR3owSXJQSXcrRUVOb2Q0bUZLSXpZMEdVRnBQWWppSGRRdzNE?=
 =?utf-8?B?OGVBMnFkTno5NXNBeVByRVZTZFB3V3VucWIyeVRDVmFpSUQySUFjSHh1VGlC?=
 =?utf-8?B?d0VkdE54NmlvMWY4RmhEbDhLY2NMQlI1YnliWXNZbkhESEQrZXhIajZmOEo5?=
 =?utf-8?B?V0Z6TkJLeEVLd2wweVg4bFdNMHpsK1NvejcrampieFJGbG5QYU5DSGFUREt0?=
 =?utf-8?B?Q2RORjROcnZWNy8xWU1SbEJZUzgzYkJ0ZXphcTJja3pWTTVDcDN2cEZmREtP?=
 =?utf-8?B?b3VmeWhvNGZoS0pCL2p2Uk5CSkNUdG54a3gzeWdraThGd1JtQU9yUG1Eajl6?=
 =?utf-8?B?aVlPSGhndlFCTmJVa1BTQWtRR1Q1ZU12cEtESmw5ekNVaU5jUng2V1BsUlJ2?=
 =?utf-8?B?SkhPM3JXN2E2a3dVS0pMK3BLS1ZUckhlYWdxR1h2VTFnVWd2c2xZLzhMV1F5?=
 =?utf-8?B?UVhPdERFY1htN3J6eTVQb3IrcEoxem9pV2JBUk1BNG53TEZUcVVqczVOQmpY?=
 =?utf-8?B?K3dSVzdSSTNlZjQ0NW5ESGJob0VLcFB1RHcyYmw1dnZVNkhNYmVjMUxoRFR3?=
 =?utf-8?B?QlJwOStlOVViaUx3OTA1djJ6UWNZcFgyZndSVzRobFBEZmJ6UjZCbTFKSllX?=
 =?utf-8?B?RDFwZEJKRXU0cnNKNnl1czU5QjRhMjVHM3MvMlpabmtXeWVoR0ovWXBqa3Bt?=
 =?utf-8?B?OWtvQkxDQzYwb3VQdmtuSGIrTnV1SXlpT2xpeUh6YXd4QnJHZ05mTWFjR09u?=
 =?utf-8?B?czU1MUFYZEZ4VURtN09uK0I5R2RJYTJZc2xCVlhGQXhZbUh6U0w5LzZhaVNl?=
 =?utf-8?B?dzZtRmdrL0ZyNnoxMVkxaVRLc2Z3cUdicXNBRzBZY3VXZjZPWXFCMTBQb00z?=
 =?utf-8?B?QmhIeEhrSHlwNTU5NDdxZlBvYWNsRjE0ZE4vejVENmxiVFhhUGMwOHJaVitF?=
 =?utf-8?B?QkZhaVlTMEhOY2wxa1F5dHdianp1anFYWnM0Rk5RYXl1dDZqajYrQWZ6RytG?=
 =?utf-8?B?blEvdmd1Rm1Fclh6ZWZZa3c0aG9kWUtjNHRGbVVmeCtwL2ZGamNETFZETGpp?=
 =?utf-8?B?b0kzcTMxTlZNQnAzT3I2azRpV0RqcjNsYk0yNFU5WElrZmVPTHREUVBvSmds?=
 =?utf-8?B?ck9rUHVOSTZKY2MwU01GRGs5ZWl3aXJ2UDRvVDZLcFE1TGVLWHZlSnluZ2di?=
 =?utf-8?B?QkxpOHBsR3lOSWRmNlRUVkI0SXdVU2pxbCsrTExETE1uMHlmcVYydnVTc1Rt?=
 =?utf-8?B?VFE1aE9ZTUMraWxicExqNDJ0UTI3WWtwSkh3QXVCTUY0K29sS25vOHpVeVFQ?=
 =?utf-8?B?enNzTTZUZXpRcWJGVDNBTXUxYlV2WnNLWHhGM0lmeDFKVHM4Yml6U0lVY3A4?=
 =?utf-8?B?WjNpTW91ZFVBZHBvdUdEY3YxUlpLdWpwb2NkMS9SWTdqRGNMcE5ySjc1YVp2?=
 =?utf-8?B?cm9NbC9jcGQ1RUZ6d29UQzFjSy9JVUxMeXpEekVoTk84NXdxdjlRZG5maUhw?=
 =?utf-8?B?N3JvTEVDWXlnbHMza3lHTjl3RmMrRUE4ckQwQVZ6MTM5NDUwZ25uYnI2VU1x?=
 =?utf-8?B?dHFZN01IdndVMndJazR5c29FUWMvQjU1ckVrZU5SV0RVR1RFTzdLNk05Mjcw?=
 =?utf-8?B?aGNzV3kzVzFmWkhhbGM4VGJIZGQzOVNKYUN4UUJWaTk2N2s0aVRBaWV4Nllr?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4347f5b-0065-4804-924a-08db478063af
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 00:34:55.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btS9QTsueRi3dpUb7jfNNhWGR3DiKTFcWaABUJ14UOYQOguSbtl7vFYnjNgKWG9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6307
X-Proofpoint-ORIG-GUID: wlwztPWlTWqkE5JP9xpds5O_jVMvQqwB
X-Proofpoint-GUID: wlwztPWlTWqkE5JP9xpds5O_jVMvQqwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/27/23 3:53 PM, Stephen Veiss wrote:
> Improve test selection logic when using -a/-b/-d/-t options.
> The list of tests to include or exclude can now be read from a file,
> specified as @<filename>.
> 
> The file contains one name (or wildcard pattern) per line, and
> comments beginning with # are ignored.
> 
> These options can be passed multiple times to read more than one file.
> 
> Signed-off-by: Stephen Veiss <sveiss@meta.com>

Acked-by: Yonghong Song <yhs@fb.com>
