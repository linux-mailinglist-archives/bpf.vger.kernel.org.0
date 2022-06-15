Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894A454CD26
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349522AbiFOPgQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 11:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347275AbiFOPgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 11:36:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE6424BC0
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 08:36:15 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FEvZaF030599;
        Wed, 15 Jun 2022 08:36:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=I7iL4kRvkZIbBXIRKApZ6x0WCTKkcga68Xn174q8D3o=;
 b=PnIA9M/jWoJMKLFCPXPdUOezZINqqF85rE/yHwPM8QOepn42le9p/qH0I4jPJvvch9WC
 Gmx8L70TPrhC92MG5q/6WH6dSyqOACmS8rVYf4fHEte5+i13ohbd02JcbbKTNbAl+oeP
 R2NTi6Th21TuynT6UlRV5HMCpRvvjoqFDLI= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gqd2d9x8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 08:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ioa6GfE2V1PAhRuCQfucA256yUhVj2VE+RUqN00IOclyEe1Qu1BxmqEoudmzOl8WeK5dZD3CTYuaI5oylX7nLRmBPAgRZp9HJVqAM0qkJ8Ydkw6x9tDrttdw6CXzpWWdvB8tGHBx5/2pXO/FWBqkcsK+oGhqtztoMeULGDrQwu6hCh5vMMBuN23797ilsjwchUNJh/dUtpD3dDcCEMdQHjys9hfP475X4ICTw2piSV3lmH+1V96ssqC+xSZypBSQwpkiqVU6TTa9OC5N5EdWuGAiRcj+R1VVVP6WusRisXtsgnnDJMc8WMBl7yjaaCWGH3c6i7LbEVYLiMq42am1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7iL4kRvkZIbBXIRKApZ6x0WCTKkcga68Xn174q8D3o=;
 b=FYaK4pfW626CAFSyExLykdK62x1J1kMPlEaAdd1y7wIWotHV8wNDEp9z/A29khUASSLIJFjCCmLJfBpjFtrk3vkNndnXqYHPvF0LwyHb6Yr9SSZ+L/NrWwVSySF7w7pTZBrS/bog7/7V2IypA7bMEzeoxsh37sEQYwUaH8/kzuCljguYnNyO00wBHIbE1GXtP4JZJF/RkCsur/TDfAZTwJqGHIo4JUSH5prg5uxlidvir3CQSFN+0hQrpT9R/e9VfVGkoj0pS3G7Af8ljAf/16Lg478kjqRcaf0jMNui1IFIHGBNh7sFJpu0BHy1IGKxuyYnEr0DXo1xgDnlSMb+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5269.namprd15.prod.outlook.com (2603:10b6:303:16a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 15:35:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::482a:2ab1:26f8:3268]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::482a:2ab1:26f8:3268%5]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 15:35:59 +0000
Message-ID: <b7f06a1f-8ca6-ac5f-05af-6fca29b18841@fb.com>
Date:   Wed, 15 Jun 2022 08:35:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH bpf] bpf: Limit maximum modifier chain length in
 btf_check_type_tags
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220615042151.2266537-1-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220615042151.2266537-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a920aac7-6789-4c3e-ad74-08da4ee4be4c
X-MS-TrafficTypeDiagnostic: MW4PR15MB5269:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB5269E6553D3DBB9B26C3F42DD3AD9@MW4PR15MB5269.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkSD9ENMFzIKMcJyTf5RG6icUZvF017fdJkP0AZej+o9//TPGGGC1XPMwr/IXul6XBccr8+rZDyYEPkrVS/ZKohpaTqmfshfpGiKyXyzBKrv55X/S8DEXoDoqOwSA8jKUkRwBAj9TG03B23yHnnyTRAi7Zdimqv6FHBX7JRMP3VnLSqXJ3KdYV+TKR+BVq1L9qTACcAAIndEbN/55pVu6UOWUHYAYN3EGOCT3PJWCIrrvGDGDf/vJ0DE/idIBaiGGXlKm98OpGPtmskVwPSaEoVCijVAfjx6x8kbgr0JUNzpSxq6RsItZq9GWmmKxPQfaxXllID2Rm5dF1dLa1LxGplq7rMDgQPF2wUxCnpx7U0PBEMAm4FgKpu552O1VxgQ9v5cYWCDyZmyDIRAWV/M5Any2hhnj/g2SWHAMMfCuZmyWIV2iBZziUvkrSjPnoHCEhlw7mIE9TSkA+DEoCHSQjZ8GUe+YhwpqRhN+SzsM8XEKg5pv8LLHKJg7kmOHW80L4hgT/hQF6fsUoqggutf20Ew2WgcfwQvGbIRMELquV4BxgBfdWo6dp5Px/7zWZfr3lFlPqrRZ+aQ0pRl3Qv6leA7fXBK6EDqCFIUbKa0gTGOdvwwvTelLF14YbWq813BmsaFgBSFcaTpVhUrTnPT6XieiKo33ios66N/QhuxHrV1p83I7St8J3O0DMehcHNTVvXsSg41Ka54PjbnkQ9XT6+NQcqSYSkLVKmwIeeqlIQUNHzGh+M4c30x0cmzCD4w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(2616005)(6512007)(83380400001)(53546011)(6506007)(38100700002)(36756003)(31686004)(2906002)(6666004)(54906003)(4744005)(8936002)(508600001)(5660300002)(6486002)(66946007)(66476007)(4326008)(8676002)(66556008)(316002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE1DeFd4MHRDOUh1YkFoRGJkbS9ucSswMGNaeWF4T3RpTkdwR1B5WXJvblE3?=
 =?utf-8?B?ZkNveVVieG9ITjRBMjdBRGp3SkFScUp4UHREZWRLbDFZSnNpYzJjYUhrY0Na?=
 =?utf-8?B?YnJtVEV3UFhIMjVxYW10a0JQSVBrSkJZeGFvdXZmYlFKNDdmczd6VWJmNkpk?=
 =?utf-8?B?VVltT1EwN2ZwbGVWMnFpS2dvKzZSRHZjK0d5cmxVWmZVNkVObEFETmVkQXNj?=
 =?utf-8?B?bWd2czUzNHQ0TzNiNFI5ZG1JVUxYOUZwdTA0Z2JvdytXelp0VXRweVdnaTI1?=
 =?utf-8?B?MXgraUErbUJNN3lad21UMHA2Z1BOeVozWWpDdGd4N21xelJMSlMrMFpIZm1z?=
 =?utf-8?B?d2N5cjZpVWNKYnJJb2k0ditsU2RWUy8wOUsxMmxnTXk0bVhOaTNkZnpQRXll?=
 =?utf-8?B?eHg3YzdqTC81WWNHdU1PeVRWZjdzcmxNbWRCVy9kWVBuOFdDVGpEdWYwYzlL?=
 =?utf-8?B?dVZMdC9LYm40UjlVc1EvWHJlZW9KNXBkbGZIQXZDbzVocXM4OTh2VklHa0Yz?=
 =?utf-8?B?YWVhQ20vODViTm1LNDNFNThqc1pWcEhtbm1hZHJzZzVYMVNJdVhZR3VhRThD?=
 =?utf-8?B?MFUyNDBSQUJnMnY2K1E2djIvZW1ScXlybGl1dzZvem9NZ1VSL2wzTkQxVDI2?=
 =?utf-8?B?RW9ndGhxdU9ObmQ0MUN6UTNDS1NOdmlPQ1dCd3dJemtQUkFSK2hsdWpiUk1s?=
 =?utf-8?B?S293dGRQS2s5RG04aHd3Rmx1MDJTMlV4RitWWnFWV1poU3l0bzZWSkVkbllt?=
 =?utf-8?B?Rnk0Q01JUHNQd25xUFNkUDAyZVZvNDdxMm1vdEo5S1h5dWRTSHZ4NFZjekV1?=
 =?utf-8?B?OFZ2Rlc2bmRqbDBvVldERk9kSTdvRE9XU1RTalQvdzgyMXdTdytrVHl1cWpX?=
 =?utf-8?B?SGc0dml0OWlvajVmTU9RNS96M0lpUmFyejNmemNCbUQrY0J5UDRWb1E1eXZT?=
 =?utf-8?B?QS9lKzN6dmprRWowY3VSKzQxTGhCNENWaVlMQjI1WGswOVlrMDRhUmNlTmRl?=
 =?utf-8?B?Y1IrS0NrcmkzZW5rdUZLdXl2bUFsU2VaS2MrVjBHWU4xRld4Uk5vS3FVK3ZI?=
 =?utf-8?B?OXc1RmtYYzVvYXVmVjlGWjN4MXlHWElxTHdvWTJ6RU5tU3hoRHM5V1NLNUQ3?=
 =?utf-8?B?U0pKSzhSZldidE56S1Rjem9ZQXlHTElNbFdxRE5lWjdyeENlYW5RakkvN3FQ?=
 =?utf-8?B?VVJRaHd6ckxMZm0xYXA5cElVbXEwU2xTbm40RWN0Zmpab1R5ckg1Zm1iVmN6?=
 =?utf-8?B?QUt5UUZTdmlDTXZFczZOcUY0YVdDbGVDUll5djV5WmtNbGtDLzJuaWNyemU5?=
 =?utf-8?B?czByM0ZzbXQ3WHNXSndKeHlFc09zMEJ0K2kybm5TbklJQjZmdzVWYWZrcU5h?=
 =?utf-8?B?Vi9NWERMd3EyUzI5VVZjd2ZzNEI2TnJ6RHJMRmFDWk9lWTY3N0ZGN2tDTW9I?=
 =?utf-8?B?bHVDQmtjQVZQcDZwc3M1K3YvU3IycktINkhKcS9zNDFvZjUyQlVBa3dKQkR4?=
 =?utf-8?B?UXdmYmNvQTl5K2lCUUliWUJvdWFMc3JUb1hEeHRudFgxNmZCYTV4NTJKRisz?=
 =?utf-8?B?bDNHa0xqdWNxaFYxUTd6UUVQdzZ3M2oxUUxIZTlhc0EwUmlIeFlRNitGbm1E?=
 =?utf-8?B?bHdBVTNMblNpM0RYQzJ3cFFLRHlBanJmaHFWU2lCUjlVSHFEdXJyK2l2cFNu?=
 =?utf-8?B?VmYxakZtdytuQ24weVRGSG80UnN3cWorNXhCM0FLMit2MjZiT2I1L0hhL2Zt?=
 =?utf-8?B?WEZ5UEg0NEQ4aTRGajB0WmdRRVQ1ejFXVmxJRnR0REVrR3l3UC9aL3R4L0dK?=
 =?utf-8?B?S0pSTlZNT1dlTU5WTitGa21rcU1QWlM4QXFPZTdXRVBzUjlmc0hrRlZwbEdX?=
 =?utf-8?B?bVJhTk92UjBQV3gyaFpuZGxDbzJyTGI5M2o1Q2ltSk8xZW51OStSekltcE5C?=
 =?utf-8?B?UG1oMWpCNERqTEt0UG1SRTJrRjVVMkZsMXBEMUhmM1dHMHV1WHduUVFYZXoz?=
 =?utf-8?B?Y2hWb0x1RlNmUXFqMGhnV2djcStGanlDYnR6QVRHa3dMUVRFNVZzaFAxSHZF?=
 =?utf-8?B?YjZQb1h0cnd3YXdUQnBuQzViUUh1VVF5Y3FaRnpTd0ZpWU9MT3VQdkJHSUp5?=
 =?utf-8?B?MGswRUNLU2g1cHFnWitaMFhuYzhndmZSSHdTb2NZNkRMVkIyMDhPblN5MC93?=
 =?utf-8?B?NUJleUF3Uy9ZcnJpM2F0cDkwWEhyenphU2lGZFF1TTlySThPZExMblpMZG1N?=
 =?utf-8?B?Y1dHeTkxTG5XTGdoZTljd095T3hFZEwvcExjbUVVZFhud3dmLzMvaERCWitt?=
 =?utf-8?B?UHNhWUdpWDAxbnYvbmEyRzFWTVJBTy85TU53UUs5a2VURUxNUUVMM0d1QUpk?=
 =?utf-8?Q?eB/4TySMEi9+ySWA=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a920aac7-6789-4c3e-ad74-08da4ee4be4c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 15:35:59.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtrCh0MYH8IkPvZOV6uorf84xTZNXpra2jg6gptD1QZ0JQ9aElmMjitjWf9yxIuB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5269
X-Proofpoint-GUID: BfPzIGIbteb4JeoLp8xLA5PfT6sCr_MB
X-Proofpoint-ORIG-GUID: BfPzIGIbteb4JeoLp8xLA5PfT6sCr_MB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_14,2022-06-15_01,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/14/22 9:21 PM, Kumar Kartikeya Dwivedi wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> On processing a module BTF of module built for an older kernel, we might
> sometimes find that some type points to itself forming a loop. If such a
> type is a modifier, btf_check_type_tags's while loop following modifier
> chain will be caught in an infinite loop.
> 
> Fix this by defining a maximum chain length and bailing out if we spin
> any longer than that.
> 
> Fixes: eb596b090558 ("bpf: Ensure type tags precede modifiers in BTF")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
