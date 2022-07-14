Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9179B5756AF
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 23:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiGNVAw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 17:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNVAv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 17:00:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00B6C109
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:00:50 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EKenfl019299;
        Thu, 14 Jul 2022 14:00:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dPzI+3uYzxFAp4NGbQfqmyN1atLTBNzr9mPPJWaCB5M=;
 b=WGmOiseGlKnOdfd06AyW1Wwq9aKue6usOztoiWBAadFjrI45ufwzx7i/Uz8+ALxGl/am
 HvZJCHJ6RiAQTkMOmDQGUa5mTwTDKZvxugvCUZU7JxxkKmVqTWNU6XgC99Em9H8I82vi
 /scY9s0BUxPrAm+LlBtW4/KdXO7brQX7JCc= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hak0ebhd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 14:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWESAguO97MykT366Jpx9/HczSNrzLs8t+pR4h10oNz43PDTYJFqnIdA/5EEv1pRIFuwh5drTplKIbAwgYW8OUTYe7p3cqzadBuR1a8AkNSw1ZfJJ9GfEvBAtnp5bSiBOLSWQ0PIocM8ysPSUzUkiuvg08nXMF3p4/nnJBc1gtMLb9GJEr7wYL7pknR5OaAgukJp0Ca2QXMvAed8notsdgT/kAIBkVmwvNEhDiD48Qgwn+1RsPJ69XI6aUyoprHBDu8rq9rHVNX2AlWFiRYOebgu89GNkYP0/rIS9WZ9aya1rRNMvR3B5QyAZzauys9HE57SWIra5/l5Jz30oWbGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPzI+3uYzxFAp4NGbQfqmyN1atLTBNzr9mPPJWaCB5M=;
 b=gg1jb08qzVdNm5d9np2rWPkB8e7VpHz02+WtvcBiV+aTHPcZ9wOgnCXL8CQCFeU3BEX6O7McPS5W4V69i4z+SobI8a8Eb+9bJPrpfHsaUESpAZ0uoyJfrR3SxdTiN3bH19uETIYd1rcgKGJqGdNxQ6eQHzfM/Nx0nmDS4XgQGRx3NvNqwA+WhOjCftKDhc/Kk2vznWl7nz6vxQZrq44W8eC3jUkv8rsTGTE8Qfa2uo8AoKw1FedVmEm6L5/K4W/7+Xe7YimV/lJrd7+bRm8db+eaPLQsC5ov+h7ZXn4lJyBjxkkzjbVV82q7H7CPelteyBQy37+DATYVMVNHYM36jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2552.namprd15.prod.outlook.com (2603:10b6:a03:14c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 21:00:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 21:00:27 +0000
Message-ID: <3580b8d4-c1c2-e156-b957-eb64bae30558@fb.com>
Date:   Thu, 14 Jul 2022 14:00:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] bpf: fix lsm_cgroup build errors on esoteric
 configs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220714185404.3647772-1-sdf@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220714185404.3647772-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f917b846-4d2a-4faf-91e9-08da65dbe10f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2552:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6j/POG9sfbit/ZB9h1qaTajrsB/5ukelVbkSJdLgZ2nX3EusCx7KY2hLLrzTs10CqKLGeBfDsiwTxqpjXApKxOQE7k+Uh9nJosYg6qEKRgmLTXydBE7T4SKH0IPXHsi+BHa8EWZlZnsduN9nYu8s6d2ODDDZvjygeLmRBjB6lRxWuSHLgiHpuTwLObnuHx/qnOTG79zcPqHZx+2dzn+Afp0JF9TD5N6oI1SIHNY+EuTQrH1KaDiLWFyx1XbqPsJ5w4OP4PgYd0z+50cb1zsT5v1qJTTF3iKWOTOaonM71OSmGShaQ4npcaT6TRcEcR8rwAEEVIPm2f/rFjjEDsys7hVeivVhXqDWq747/rvVPTYzQSKhnsrqVHwA4IajeQtYpqQdWcnWvuqArfcvBZemTyNgv+cWNQjfcMA7yKW5vrfosYh4MSV1WMBfuzwyUIFcNONC6Ry1qkr1XeK65oucchhqZEl5PI00HHQBrEXCUZUutcN5Ot7GJCg6VPZ43L+1UNNEtP9HWPuxPL2QRauE1AZCuARf8c6/yNKlVsmgOSCN8HXqfyHLcp+g+80N8+eIeUMADHdunSjBbxlb5CV4TVZ1yoxA0bkMRYUv3XNay+LWcGAB1w08yMKT/Be/xOw8DuXxp/MrMD37a8QGFsMbga+dCmYS1HuOc8yMHLcl9KAOU6iZQSYCbDgL9kccPrzKYEC1CZtAybhm7sxxi8OGqEWsravQb+xSL5GHnvm+k4xzqdBj0u09NaWqXL/6TV5GACbHR+5ozwviKc0B/MQmG78qHBdhRxgnnqMve2qJycEzxfqAegHGXXDIaPrcejwYycvTTwBvxREc/JDJF6xA3K08xFKGp+TvAjISqT5q/5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(36756003)(86362001)(66556008)(186003)(6486002)(53546011)(2616005)(6512007)(31696002)(38100700002)(41300700001)(4326008)(4744005)(316002)(6666004)(66946007)(66476007)(8936002)(2906002)(7416002)(8676002)(6506007)(5660300002)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJXNGxGNW9BRlVQbDd0Nmh6OWh1Y2xrWGNaZ1M2ZTFPQkd6OGdJSmV6WHRJ?=
 =?utf-8?B?YVBkZnRIMS9BRzN3cjlHVk5vTWpOQTBhSUo1OFpyTVlSNnlMcVZhNlYvVkdX?=
 =?utf-8?B?eDRVM00wZ1JOTG9SSHdidGN6M0g4anArZy93emZVb1VVRE1IWDFac3kxNTBh?=
 =?utf-8?B?WkIxYlZLeEdDYjJLQ252MWhPMk41enNqYlJnK1Y1ZktUTFVHQU84MTRONm9l?=
 =?utf-8?B?RllUbW0wNExxWUQ5TzN0aXJpenZ0TDE4Q1JFSTVqTkpEWUdCUWJSNTBHZ1dZ?=
 =?utf-8?B?Y2FvejFRaU1pKzhaR3dFQ1RIdXpaZy9IZG9JOXo0aGZ2Q1ZVcm9kMi82ckRi?=
 =?utf-8?B?VisyN3gzZVE4NVpSMDZoZ21NRjVhVDZ0WXNjc1hZMVYwLzVRMDZxR1YrY1Np?=
 =?utf-8?B?OUYweXVJN0NJU25jR1dqQUFld3hxcFk0OE5SemhpZ1ByR3FQUlI4VmNRMTJY?=
 =?utf-8?B?aGpHelFSSEU1bkZQbjgzQWtqRTBrOTZEay9zejQ4djJkOXZqWW5hWE5FSlY0?=
 =?utf-8?B?RWEzWU95Q2xqeFRHR0w3bE9vL09xbEVmV2dEU0FqdzY2RkdDcjZYeEtFSFJo?=
 =?utf-8?B?WVNSbVVuNlgvWmJnWW5hN0s2RjF0SlR4VHFwY2prTDQ2eUJaYVVKWXZjbi92?=
 =?utf-8?B?MWc3TDVaS05xVlZHNmp5UWozampJVlY4TjFYU2dvbDI5cTNlR0lNV1JlaWls?=
 =?utf-8?B?YUhEZ2Z1RXJsYTM1RDU2YVlZYzcxV2pKbG9EWEhaYnAzNE9iVnNFekhoWE11?=
 =?utf-8?B?K2FseG5QYjVkSnl1RE1BZXdFY21yL3lqZHZUdVFoTnJJcXdjVzBJY2FIYUtk?=
 =?utf-8?B?cTBsMzdRM1FrRXNBdW8yc3RneTY1WWRSRElwMkZVcStURmN0c2dmMkVickx3?=
 =?utf-8?B?RDJ6a2JsQ0szK0lQNmwvd2ozN21mTHlJVzFxRWpSUW5PWFZsYlVuM09EZjZH?=
 =?utf-8?B?d0ZXMXorcXA0NytiOFpJTnlaMU9KaUgvc2tSR3ErcEtIQ1F1VnFjaUZQZTJG?=
 =?utf-8?B?bnlKVG9Wc3JwY2tMeG12OGZWYmoyZ3kwTWFPS1N1TURtL3k0UXRrekQycU40?=
 =?utf-8?B?Z2YvK0tVK3B1VlZuY2RPK3BTMGdmQi9yUk9OWENha2ZCak91M1QzeC81Vy9E?=
 =?utf-8?B?bUM1R2tsZC9SbE03NEF3ZWJnNE16WE1yMkQ5RTVUczBqZjhYRzk3RS95eng2?=
 =?utf-8?B?dHdPQ3pmKytpNXIxcGl1cDU1ODVNbTUzU2czYVJNRnVSaWhKczl5eXdXeFJ5?=
 =?utf-8?B?K3NrcWxyKzUwYkdDUmY0UnFidkZ6cHc0VlpCdnlqa1VjK2JhT0RVZDlNS244?=
 =?utf-8?B?enA2N3A0ZmVsU3JBTXJmd1V3V3hCVmtMbGdYZlFtVDA4U0RMeEZ0c0pnUEJ6?=
 =?utf-8?B?Q2EveGVlQXdwaHJjUkljV3loTmJXT2ZMQTJyQzZOSG1rRUJLM1l1VXNoVG9Y?=
 =?utf-8?B?bVY2K0h2QzYxVER3NjFsU3E2bGRZMUt4WStzSU94R2x4TmR2TERUMmRVcFNB?=
 =?utf-8?B?S0g2bm9Ha1I0L0hVWGNLWW5kM1hCdERFV1hJb0hKdlMza1ZrMHlCNGt2Uksr?=
 =?utf-8?B?NHRUYUMrL21NamUzWTJGUXhLYUlkVDB2RTVqcUN6Mk9weUhXdy9jNkJ4am5v?=
 =?utf-8?B?S0F0eUVrbUtYWFB3WjZyRnRnYU5jMnZ5bms2SDU3eC8vb0QzREs4dUpZTXNB?=
 =?utf-8?B?VFd4c2hlaGg1cndsK2VnYVpLV0d0VHM1MnYranVzWWF3OFE2TS9uMTk0NXhT?=
 =?utf-8?B?R3hOc1ZZaHE3eGVaa1FLd1p5YWhDbUFBakZTTHVXbnFsVGQ0Mmo2aStlZzl6?=
 =?utf-8?B?NkhUVmdDZVR4cnpyanBzeGtWZzBnNGs0cVdjUHB3L2FYbG5kR1Y3dUltUkFR?=
 =?utf-8?B?NUhPek9WMWdYcW05M21PckRxYnFqTUVqcGJoRm5RanFacnlLM25JamUxV1NW?=
 =?utf-8?B?WGZlV3JTUjRkQ2s0aUJhVFVRK3Y4TmNIcTE2YzgrTHBvamhPMXdUNU96WVl0?=
 =?utf-8?B?eWwxcTVKRmNUb3dNMkxnY0dZaHZCaWNHTnJmVWg0RzRtSE96SFp4ZEQzcGl4?=
 =?utf-8?B?K1RXOElXVEtld053NDc3YnoxMUYrNGJTL0lNM013dFJlQ09temw0MXZxT2lk?=
 =?utf-8?B?WnE4aDNoVkVNM0s0T1l4WVJnSjVZRjNsMVR3aFoyQlo2d3c5MlQ5eWJncDNz?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f917b846-4d2a-4faf-91e9-08da65dbe10f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 21:00:27.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a42WoXkZJJjPklRg2gQvUzUqcn8FPtt+K0N4wQMT+pF19flmZeZCsknwxPit14Fq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2552
X-Proofpoint-GUID: bo1OYRCIP9KKYRPnib31d5cAREerYvgk
X-Proofpoint-ORIG-GUID: bo1OYRCIP9KKYRPnib31d5cAREerYvgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_17,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/14/22 11:54 AM, Stanislav Fomichev wrote:
> This particular ones is about having the following:
>   CONFIG_BPF_LSM=y
>   # CONFIG_CGROUP_BPF is not set
> 
> Also, add __maybe_unused to the args for the !CONFIG_NET cases.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
