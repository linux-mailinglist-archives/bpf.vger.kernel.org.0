Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8860E64FBFB
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 20:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLQTFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 14:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiLQTEi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 14:04:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48628E28
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 10:59:26 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BHGImiw019192;
        Sat, 17 Dec 2022 10:58:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Hbx5G5EYSLNORltwCiF5+Z53R9R73V63mzXoxLi2yUE=;
 b=jKusBMLCQt5Swgor5ire7Sw4GQ62LmQJYdS543GhJ1Zmh0ttV5h1FMgA4NP6qBzU0cXs
 0U3d7e5LgO5HjI5HJoypRAYFRFD+X4bF/dLzEZMiAVCTm3Bv69U2dl7KPXwz7jA3EC5r
 l/QQt6ubnKotBu/hd7zbYgPwWeE0DR4ES0FOSoklDYSLl0IJdUTG/mAVakwI/AfKrORU
 c8Z2s3o9N7Iyfoil70K02/Sk6HF0jlCn37PpsaAn8AZ2fwQX2xCHVwXtb6NoR6NplAGv
 3nNAQULy7h0D/GGUBghhmvPBMdoiU2QlNsfGXnt9zNLoKIIx7eUbN87r9qMsOqcIgSJs HA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mha5bsnct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 10:58:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3TWZkqTSzybeE+LHdq9BGABBus+Pw8rtPXM4Zs8njw639EQmYVBFMf5gKDx5yk+UEj5MekU0e7/0MWXB4dA4cHBl1nbEvhLCFqRkF6pXhPIWq9N9p98K3jL7bsLpNPtJnULKvkphhVPE/Z6DdWBPwXpfKIv4KY4bWTHc9XH+5RfMYW7JS855wJMlpVCwD6KZUdyH4gF58TtA9unY3XTfC94q3XeDthUEC1SzMImlUnIcQd+CqDfiaWh53GiZceWHDkkEZfz0PBykyut//r9tPQkSB9SNRFPO+5BDSWvlGroFbGpKLWQiBUCkynPnXb02ouqzgLKhC8V1eZ+4mGA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbx5G5EYSLNORltwCiF5+Z53R9R73V63mzXoxLi2yUE=;
 b=i0BWufpBOY2LLfRtyNjOxrQM9uZ4Kw4yH24B3kx6amMkEA3N8iDr97R/3/IaPvYGrwuREviibgW5GfEzhedFCYRe3xYhrDAYtJQ4r3lPYPIbSTU/nNhrHlsXoalvdvl01KMj7rSJlhwZmobqHkodQWEQTr7NFBYowkoaG1eYTzpdqyPY2rpyTf+dHIyfcOZFSVrNbW+R4U7wooYnZfryngnGO3sy8xQ39ZKzHvAwQNgwkSoifZHB2uJGj0BRPUDIn0LtSQvl6so0uMla4vLmh0Qo+5NXio4Z5ClMBlPX5YHb/FpqaD4V51KW6fmhSjL0Kb3OcZM4kxMyx9C19hp1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3118.namprd15.prod.outlook.com (2603:10b6:208:f9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 18:58:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 18:58:33 +0000
Message-ID: <e8812ff5-f188-34db-50e0-9a79fa5752c0@meta.com>
Date:   Sat, 17 Dec 2022 10:58:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: convenience macro for use
 with 'asm volatile' blocks
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com
References: <20221217021711.172247-1-eddyz87@gmail.com>
 <20221217021711.172247-3-eddyz87@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221217021711.172247-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3118:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8a3f86-233d-4ff9-8c49-08dae060b1f3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCpfbIdkHpRDwqnRpSY+rf5NFvjZkIpvFiO9T3y3tS6gO/OU3+xNoNZbsUI8nCMGNmv54ZzVxo9DxxGVJ/Po2lOWI35f7DpUQtfEK3DrJmYr+g62E9ZJxU7f2qTTHE01AbKatRc604lqySlteOOH1Qnk3veiEs0ZhwboUcSuaSSHNJ2q0lfeobidKY1Y/WFNHRNLYJIdXQ7Jc1C8gaJHamwBrjcf1Mi12/iIKK7oN4QeIm8mIN+gkEdihuBKituNdvQJMMZ6EUUDWbjSznSo9F00eQlyuZUDwI7+yueUfuUWuPPmwKLlZmbDgij7GN1sSYN+adcxbMtrLFYGYN/HWLg0/sO+wIdf0VwAJShKVVr0nsG0jr2Yb/INoLULpoNwj6nRywJjnDJ3ySntWtP59XUQYaPhvkezzArgSVWn9tPEeH5Kdt0/9e1//FkKIXEGW1QohtC+toKcvyc1DFZvMiKPbgOZwuayqIZ+v3B9fsISr+VUHnS1wtnZFHiB/d4g+HvBs2Ytn2Md+zKzy2z6vgrpqq/Hp/aWp/amuWKX1bgxFRGxO96PCclCv82MRuW9OaFiIKZ/VqzDtP9faSIyA1WLZgV9RjUGh5vLaT2YnAEnvIzh6V1ZKsRVhVvk+yqPHCPXhjDMX+sPRCh+BvD1Emzfb/8kU1bMzLvqvTugDQ5uFEQo4N6wHlH0LJox1D7K1hp59G399Idqg9NWvKsqhyxHoDSwP6o07god03FhjUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(478600001)(41300700001)(31686004)(6486002)(8936002)(36756003)(6506007)(53546011)(38100700002)(8676002)(66556008)(66476007)(66946007)(186003)(6512007)(5660300002)(4326008)(2906002)(2616005)(4744005)(316002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUpaeEo2UTVhL2t6QUFxQWxiWWM3YVlCUVByZndoL1M4NXdqQWFnVVQwZFVl?=
 =?utf-8?B?RWVlb3hnallRU0x1RDkrKzhqNWlJdDBVdVRkWUxqRnVBNkRaM21pb3NKVTRi?=
 =?utf-8?B?NTBUNzRrTGw1M1VGWUJJTG9uQ0FVL0NMbmhGb2RTQ01PdysweVJaR2Z2TmdB?=
 =?utf-8?B?cXRlU3lTUDFCbkdIWFhwRzcvbjV5RThFSnpwaDJpUGV6UldIVXg1UkM3Mkh3?=
 =?utf-8?B?OXZRV2t6WHBxMzVVd1dBTHg5VXlvQWx3czRzMjNqZFN5VHhQdzB6ZkpHQ0ZH?=
 =?utf-8?B?Q0FIdkdlY2l2Y294b2gveFFHVzNldSs4ZmpVb25NT01vZFVibmE2NWZSSkQ1?=
 =?utf-8?B?Uy83Y3JYMG40N0JXSms0SG9BdG5VNVQ2ckUyVkFPZENjR1RIVzM5Qnd3T1My?=
 =?utf-8?B?eTI0TTR2bXZobmdyTnpMbjJRUjRaYndYcXlFVENmVDUxNmwxRDMvSVd4cVJl?=
 =?utf-8?B?bTdwNjRxWGF6bTV5UnFXaEFYRDYzeUFzK3gweFpobjViZkNobUsxbE1rbVZx?=
 =?utf-8?B?dEc3YXFUWkVXbGZ3MXZKVm1nU09rbCtDa2ZRSXBvWlpHdEdVU0RzYjN5dDlx?=
 =?utf-8?B?NUpReGtFRThNelgvZENNbVFRdVArRHo1Q0VhMEtRekRtWUZpK21WdVdPWDc2?=
 =?utf-8?B?alVYVlUvQStaMnJwcWlTTVJEejdmRzVITjBVOVVxdlNmcTRGL3l0OXZYb0N0?=
 =?utf-8?B?Nis0Tk5uTk5YdXhjSHg3VHRUYmRjNGhWRjE3MFdGYk1qWGVyR0ZKdTlFeHpY?=
 =?utf-8?B?TDZqUUk4aEQ5Y1dFMmpMc2dmQ1RsNVhHYWNVYlMzbmhJbmhFN251djI3LzAy?=
 =?utf-8?B?ZDhIMmRiMmJmMll3MWJydVZKVVhCWlFId0ZVSjllYmFHc0JyaGRUWFUrbjZv?=
 =?utf-8?B?K21FUnZKVURlYk03cVZBRVVnUFllc0tzV2RpODk2d3hSbmxTcVhjRmloQ1dj?=
 =?utf-8?B?R0hQTEhoRmM2NTNhWnRIU21CUTFROUpPN3JMS242LzJxQllIRSs5L0wycllR?=
 =?utf-8?B?Q3JveEwrZERqNnQxOW0zS2VBSlhvSjFmYzRwYUkvR1MrQjB2OHpzRGljL1NW?=
 =?utf-8?B?aFpteTNJdnpvZzMzeHgxTW1GSkQ4aFZRREpRSGExNGE1cFBnbk1rQnFiTEhF?=
 =?utf-8?B?MjlneStETlozTjNleDJaOFRDS0E4QmZkb2wweTY1MGRmUWZJSmZhQ1cvemgv?=
 =?utf-8?B?UTVxTEwxTTUyNXhybUYvN28zRk9yckhteWdETmk2ekRMUnc5TTVHOFQxaFhv?=
 =?utf-8?B?TytDZzhWUWdvVS9TZ3MrenE0YkVFRENMOG5lRi9WUXVSTCtXMGNva2plYVV2?=
 =?utf-8?B?R2NOckRkcGlqN04rZGdIaVVhN3gyMEQ1MVJIaGd1VXBLZTQ1VnNpUDJpOFBH?=
 =?utf-8?B?V2hSek5IS3RscDlZN2Qzcy9ldGZNd0RRVnJxbFJlZjdVTW1wS29OOWhTeUVM?=
 =?utf-8?B?eVF5ZCtJSXRnTTZCRGFkZHppc25OOXJBZ003UEtpakhlam03WFRMWXZ3Y3px?=
 =?utf-8?B?YjgxNnhrTG9pZ3dVbUswazBoRXEray94N3U3L3pZYmU3Z2NpRFVwc0FMQ3Vh?=
 =?utf-8?B?ek1wVktmRll4UTdGT01zQVp0K3I1VDdrU2djWXNTZkhwbXhRcTNIc0M0RHlW?=
 =?utf-8?B?MmVVaXV0ODBpdW5xVWIzNVNjWnhaUFJidFNPSGs0SmNKRDJJY05BUGdhREpZ?=
 =?utf-8?B?bWFnSTZkdTdtdG83SWd6a0hsSG9FRCtrV3FIQ0NEZTRkMWFXOUlhVm1GTmwy?=
 =?utf-8?B?N3JseVNPaUdJTCtUamtTdVdKakdUanlPYWJQQTRjNFVvMlJyQVFVTmlIZGRW?=
 =?utf-8?B?Njh0cmU4VG5jdk5mY0czcnpnRW5kbFZreWlVcmJUVDdCZWhiKzNlelNJbTFl?=
 =?utf-8?B?NTl3bEtwRTFEY201NE1DUSs2eTV4SnRSZkF0SllqTFZGVDE0THBKLzNlTnlO?=
 =?utf-8?B?VnNvSER2WGhnQWNlNlhhQ1lqa1U0bVlPbjg5WUxIWDY5Z29aMmdwUWYwbWIz?=
 =?utf-8?B?ZGtrYkgrMnp6U2dUQjdnNjNKcnUyTVo1S3BWRXI1T0pEVEgyK3g0R2ZSRmk1?=
 =?utf-8?B?L3QvcTdhRkxScEdxWmdoSjdQTW10SEFEMnNxNEFCbk1Ld1ZxV2JpYyttNlRw?=
 =?utf-8?B?ZVQycE1ZYnJtZjBFZUVDQ1hYbkZqZWlBSXBpbUhxcFVKYTRWZGROeU5HVFdx?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8a3f86-233d-4ff9-8c49-08dae060b1f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 18:58:33.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdlnZoi4Rl8HcRDXhc4A7iGUE5wJWXK5u+clCZ+KwN5oorHhojQ1mx1J8SAdA/NQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3118
X-Proofpoint-GUID: sr-yrKSE2oIupUIM9LlpLc6yUkUMhhNA
X-Proofpoint-ORIG-GUID: sr-yrKSE2oIupUIM9LlpLc6yUkUMhhNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_09,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 6:17 PM, Eduard Zingerman wrote:
> A set of macros useful for writing naked BPF functions using inline
> assembly. E.g. as follows:
> 
> struct map_struct {
> 	...
> } map SEC(".maps");
> 
> SEC(...)
> __naked int foo_test(void)
> {
> 	asm volatile(
> 		"r0 = 0;"
> 		"*(u64*)(r10 - 8) = r0;"
> 		"r1 = %[map] ll;"
> 		"r2 = r10;"
> 		"r2 += -8;"
> 		"call %[bpf_map_lookup_elem];"
> 		"r0 = 0;"
> 		"exit;"
> 		:
> 		: __imm(bpf_map_lookup_elem),
> 		  __imm_addr(map)
> 		: __clobber_all);
> }
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
