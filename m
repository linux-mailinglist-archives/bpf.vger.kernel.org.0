Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35746F0FA7
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 02:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbjD1AdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 20:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344527AbjD1AdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 20:33:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB246B8
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 17:32:37 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RIQ7Ru020342;
        Thu, 27 Apr 2023 17:32:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=uuiTMUdHqEiEgvpzMc2SBFZL6wIOHvkelz09tBcwF3k=;
 b=VbnK8YULrMSoeP4TMQJ6WPrfwesSkKU0VsEhANPeYOO/5U92tpEiVQ95fNOi0tG40sNC
 bRptiB+DBlubxHhNBlpXm3OPaNsfhUbgylKhkTJMp99wKull/QYFwVVDLoMbqLEf8OQq
 ZIBQGoh9/76CIiqXVNGgaVwX45XtOc1RpLjfoTfJXqNyxD9E5omSSUMLMzQhL5bgr9Jq
 3Roy9pWlFl8WKkrN28B6lxlsDX7f7UPgYC7hQuz7KSIUxpsx54+Aa/jWK+daU9pEi6Bh
 EMo8KT8MTTLJbB4sHrZUg0wrx0A5ath3eHdWyRLBV+qqKBbMcg2vVuhU6t1EREukzzSm RA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q7cst9cvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 17:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbbCPxwmax7D2e59yCphYnV+GZFqV8sovImda93Ujpfjg5SwBqRcbHqeI5QGZ+oAV6QeczYjOVEUgWwBecYYkeRNn2DmyONA+idcQbYJKGjlK8RitBZjdgHKelichFM+2DratKhWSfBs5YY5zDkG/GjaLs0SK9lhSCe87NpZstEdP4mAtm98hc/88rqkK3L6wVsRso1cepYi21Od6KzeoQOiZKpm0MthM4yNZHPcQJJoJ8y6pV1bsABJiP/oLybZz9kWKawx14LpNsMa2pOu7BMWPqrmylBpaUorpa360IX3eOzF8KmyHQW1zn7o3WiQqD62+zHHEvog2MhFKONoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuiTMUdHqEiEgvpzMc2SBFZL6wIOHvkelz09tBcwF3k=;
 b=UCgWgLfh2HoS9/jY7qRh1FnbpNCOsUyyy1GskixHUk1g56C5Xbp+XhMFuspX9KCu526524ju1xb1Si6qA6uTPTOKPrBkpkFpP3sf+b1qq90jFW1j8BZ4Mn+7mujENf9nD5HJ+c+jP6wwoH3W9RstdvJuWYcQcjHUur/U9yC9APDVMgdkk5e1N22hGTAzFc6rkA55W9gFEAyhnZ5+hGDZ4aERgHm47d5EYPeyMXxxBPikOP7WAw4e7QdO9ME6jARj9jo0ouvuQTG4ggskNtBq1NqH4/H6yCZluYWCOHtZf0ehtQoT+AP7YfEY0iLqvk4A4nlWwJdMalhDYbxtn9hq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH3PR15MB6307.namprd15.prod.outlook.com (2603:10b6:610:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 00:32:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 00:32:00 +0000
Message-ID: <7c81a472-2c0c-f5fd-5df7-abd939037370@meta.com>
Date:   Thu, 27 Apr 2023 17:31:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: extract insert_test from
 parse_test_list
Content-Language: en-US
To:     Stephen Veiss <sveiss@meta.com>, bpf@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
References: <20230427225333.3506052-1-sveiss@meta.com>
 <20230427225333.3506052-2-sveiss@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230427225333.3506052-2-sveiss@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH3PR15MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 0645e638-7113-4ea1-e721-08db477ffb1a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pER7/jNZ0g7s4M8pbwuT24oFZbjj1tkDrWEcQflOKL+M3NyyiaDXgDQyacuDsozt6rRG5K4yX3rk0P56GXVeC73uqNE+6JRl8kKmcO2UcKCWqLzyKqfD/JQB4bNNIwm76SwwO3b970eG5NDe2VapzJ6i3IuYBf/4E4z4x0FeNmcxaJGMMLr+iykr/iu67+GCmUQ82qCXiQ4o38WCft0McDDYjB866VCUdk/ABfA5v7jSY1D/prHFRhhbRYFO9vgmCU9F5JmArp/eyYMJf5qf8FnLF0WTvQ9OempL+SDWjANM9xDqFSjLECSXUxNm8FQlOkfh4gUzLzTETfMGs9a2L3qHmwjAVdA70UM5lrUMz2gukunvOj74i2iKEB7lx1UkZl2gkwgy/8WwIhhehxE8S7H3kVS571noqVp5Tp2TWaiJvmBUyjWlCARZ1v9IgQgKpHed6Htr5P8/yvy5xlryxj8mWql8AQ/skWc10Ph25QJBSsg3p7BtDl0IlA9qbTgnhVsaU2FpPsgtCFSAEfU0wfoWlkVkngtiDkCPZnL4Zu6i6Rzc39bJEwiSn2cDTONIpsdOJLzlJrMpCpf/rFqZtMX7pkVIZzpZl4eOOOzgrhVnDxOJGdQV+JNKqmsm+wItkTU0ea8wPz+Vl/jw8GeWRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(38100700002)(66556008)(5660300002)(31696002)(66946007)(66476007)(8936002)(8676002)(41300700001)(316002)(86362001)(4326008)(186003)(53546011)(6512007)(6506007)(6666004)(6486002)(36756003)(2616005)(31686004)(2906002)(4744005)(478600001)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZxYmZqeXBKa1ZHMVNHNW1laDF2U0x1UEJadHhrUi90d0NkazVDVnFFREFK?=
 =?utf-8?B?WElESmFmc1RINWlaTFVMRXViWU9lclQxWFdDejFmZElGM2NDRDR0UW1FQngr?=
 =?utf-8?B?MnRmMEZwMER5RVpuV1dnb0tkZmxFRUROZ0VhQXZuY3czdGkrNVNWNHVoYzUv?=
 =?utf-8?B?ZWNZUTh5TWs3SlhVaHQvNkFhd1c2emxtZXFGME9KOWdoMlQ2YjZJQlJRRlBO?=
 =?utf-8?B?M1lhY1lRS0N3QkRXWWZGVFNrWWlhbEV0TWhPZStQa3hSQmZRQ1phMDZPeVJB?=
 =?utf-8?B?MUkyYTdrblhweElQZ01mVG84L0F5STN0dXBOS1krR213NVVpVElxR2NaS0hi?=
 =?utf-8?B?OS9wdTZWRDZrWVNTNU50Z3EwelAxV2NkYUJCNytyVHVENjlpb0EwS0NxdkFw?=
 =?utf-8?B?YmEvWVZlRllzUHk2N2JkRitZV3hOem5Ea1NqbDdHc293cFpRQndGQURiNFdI?=
 =?utf-8?B?aXdseTZzaURJU2IzaW5HYmxmSmtwaDVXVWFoYVlCTjh0LzdkODhzWWJ5ek13?=
 =?utf-8?B?SFQ4SEZHb2kyUlNkZ2ZReFYrbXdWbkNObnROVHhGL2U1OEl2S3A0eU1zTWRv?=
 =?utf-8?B?bmJldG5TU2V4UmRaVm1XOC84YnF5dWJVaUJESmtVS25hWXYwMUtUalMzbHg5?=
 =?utf-8?B?WEZxMHBjSXZQTzMwaVcyNXd0NUdEUkNvbWh5QWM0YmJFOGxGVmk4blVEdmUw?=
 =?utf-8?B?ZnJCcG9GYnJ0cVlWZnJjdGtqQkhoWlFJaEhyOEpDYkZxMzFzVVZnZ096NG5I?=
 =?utf-8?B?SmowZVI0WTlKeUdRV3JSc1RXWjhDbU9KYkR5UEp6cmJIR1IzaXhBc2UxWFVU?=
 =?utf-8?B?VndjODFRVVBDd2hlNUNBNElCNGVVbk1RZ0dzUlVNSGJ2R0ZGcm1RUlRjOGNE?=
 =?utf-8?B?NWh0aDBRSTBmdUpCV2hOd0hQSU1xS1JPbWozM2hyVUtjVmpHTjJRODhmbWlZ?=
 =?utf-8?B?emI4ZjU5UDhYckJLQXJ0bXpDckUxSFB4TnJMeW1FQjluOGhOSTFUNjBXSHBI?=
 =?utf-8?B?UXBTd0NTbXFWMUxpMERrOHhtWENmVnlsTUpPNHdzUU4rWlRXWGp6UHhSdlRN?=
 =?utf-8?B?WGhmcGJyZ3pqZ2ZiaGRLcnhEQzExT3EvOFYrQlNvbXdKUGxFUlgwaFRFTEpw?=
 =?utf-8?B?NnlqQm1qTzljVUVuUXpIRVZ6MFppcEQ2L0xhVlIvVXZHa1hGcjgxSStKTW5Z?=
 =?utf-8?B?ZnR3cDQrYXJZMzdzVzR6bUs4aE1LZCtZTVJsbmJNUVBNTmJFbEFHOStkNzFz?=
 =?utf-8?B?Szk5bkdUd2kvTzBDMjBsR2Q0YlVwc29qbFdRVlI3Y3h2RlNqQ2IzUUVnTEgv?=
 =?utf-8?B?MkEwcUJTVFczQWUvcjRwTjVpeVNnMWkwd3RGM3JMckJ6TUp2SDJxaE96OWVZ?=
 =?utf-8?B?bFhQUmtRM1habVVraUFPbzhGRzhBTndaRm15bnJxVUpBRk91UDZGUnNYcjA5?=
 =?utf-8?B?T1FucDluUFpKanhjQjdQSUY1U2FvS1RHeURNWGNsdWc0SThaUXRCZ2c2NkdV?=
 =?utf-8?B?SzB4VVpEZHdWYi9XNnhTSktmaEJrbC96bjhHNUNTbzl1S3k5Um01MGg5VTVG?=
 =?utf-8?B?YlhHNWxBUmFxZ2RjT2J3bkNMaUV4U0hDOFByOTB5K0YyQzQwUWc5VUxrR2Rt?=
 =?utf-8?B?bUhYOW9mWUkzSWE3bTJtUmtiZmNnb1NMaVNYdjRsK1IrQm9NM0tTR2ZxMkFH?=
 =?utf-8?B?dlZmZjljUTIwYVlwOWlvaG95SGUvWkpBbWlFQ1pETUNZYnlyZkV5U1k1Ulhu?=
 =?utf-8?B?MEhOaFRVb2IrL1VQZUtodmtuZ3RnRkxTSlRHdnR5bW5FYklJUlRtd1BhM1Jj?=
 =?utf-8?B?U3JYTEF6RkVGVHN4WHEybm1BcGRPK1lQTnp1THBWdmg3MWdBYlVua1RsYm95?=
 =?utf-8?B?cERXVXhON1JPMEtTUDM0ZUdQQ0RKdmUxWndQSnlhNjZ6OUUyUU5mbEZyRFNO?=
 =?utf-8?B?c1U4RVVJZFhhUjZEZkhHbDhDSFpIMU5ZRzIxY2tuVGRNZ20zdlZlak5tK3pa?=
 =?utf-8?B?ZktzRHZ0OGFXV2ZTemdyYkU5M2czWGpGZGRPWHlhMFRReDg0MTZmTWo2Vzdv?=
 =?utf-8?B?bTE3VWkveS9GTkI4Z2RqLzVjWVVNSXFQcFhyeWV1dlkwSTJTYytHRkFROGta?=
 =?utf-8?B?bmRVS1JHekNuWWRFV2ZPUk1UVHF3eiswRnlBK2xwTG1KSWoxVWxLbzRnOUxz?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0645e638-7113-4ea1-e721-08db477ffb1a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 00:32:00.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5knLRhUQPrYD1OtwFA7J0//7gnEGK4yuDL5JYIzNn662gbaMF+RLuskXHg88FAaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6307
X-Proofpoint-ORIG-GUID: TEs00aNddviTOTYSQfi3ejqAE4D4tdoU
X-Proofpoint-GUID: TEs00aNddviTOTYSQfi3ejqAE4D4tdoU
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
> Split the logic to insert new tests into test filter sets out from
> parse_test_list.
> 
> Fix the subtest insertion logic to reuse an existing top-level test
> filter, which prevents the creation of duplicate top-level test filters
> each with a single subtest.
> 
> Signed-off-by: Stephen Veiss <sveiss@meta.com>

Acked-by: Yonghong Song <yhs@fb.com>
