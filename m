Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3107576ACD
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 01:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiGOXi5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 19:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOXi4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 19:38:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D226110
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:38:55 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKnFRs007772;
        Fri, 15 Jul 2022 16:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=neEldI3NTkuSytrYfjZDMIpcyvo/4+Qj9IVVR+eAoBQ=;
 b=WILrTam7jOvMz+beC+98fsJ2GO6697pgftZYL4YZNyqHEDJ58Gq3jxcEFfgjI6tNNyi0
 MkBltMgTGxwqrvStwcqyCTpoF1Vkcivz6gMAjaENq4IANUuhi+Rbx9eyl+ejUP5QaVBr
 M0xF1kUXL/F8675nDtIX0fuAG3VjvkS5aDw= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3haktcatxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 16:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMqot+dnB3j084zx4Ef3E8Fz2b89i/kQH+0Rh+AYT4lMUSrtJUWjSf1ddLZ65BE7HjPkL8vKAeHUrGldeJIOVNtXE929XaU201gJBdRltvLiSkZRqls+WnXmuT55fkqnoBzSn/sdy2Ze/UEtDtHWVnuGzEdPeuHtjh3wbA6pSIt2ZVfpk1S45Qdyf9Q2XdKSRDSiM5x8XsyFAN+lbIVaht0lsMume8vkiDlKiIxiUg2LL1lwB+BaylXLMxPlow0fS/StO05EZx3D92HAZGEHzuSWwY/MHF54yQSLN8Hd4Gtob0IikOs7h22Eh/w4uGa45KS+Gy9jHoXWT6o1jzkKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neEldI3NTkuSytrYfjZDMIpcyvo/4+Qj9IVVR+eAoBQ=;
 b=P6nZnntLgxezI7JP4f8rVruH6X4V3/Bt2GA6z9l3VBX5+xC1eHPRlZvKWNu29qdfxNLpNN5FGx7x9gwII0gtaP/Ja+C4bdlMmPD87THBORAUZ4TcJS0czueQnApD9Xk0yNa5Bv4x7lrZL9P2TTGLUYU6VgvD33d8iknI2kisq2APAQrIYqpHDcDdKKNvfdSB77sHxp24BVwb3UMHOOi/j0/u2ClSZAnHjSDg8io7KNtepHOTAClLnN44F3dcCCHjETAAqGUwJYc/joqZ4BIGrVe2xin8DxfLMOMiK0w28+qmZqsIBDdjSrSjy15PbTX2FoHehit3Z2y7BEe/JFo3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4401.namprd15.prod.outlook.com (2603:10b6:806:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 15 Jul
 2022 23:38:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 23:38:36 +0000
Message-ID: <ca57e143-5e4d-f915-9256-71481d97d81b@fb.com>
Date:   Fri, 15 Jul 2022 16:38:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: make RINGBUF map size adjustments
 more eagerly
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220715230952.2219271-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715230952.2219271-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd7d1cd-dab4-4b2b-74b6-08da66bb22f9
X-MS-TrafficTypeDiagnostic: SA1PR15MB4401:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QN/EY9IW8v1ph2wtNdrDTAjQuyyy5u6n6kcLRip4t33e/ia3d3l4p92KR/UXLSK0AuzOXB19maRXLUhzb4D4ZQLtEkhZrQ97D6joBQQNFX7StARJYpvb3dLQtUPEA2CUr/jY4KSTglvE1K33NvIwiRK3JJLE9uhoLzeqyCzzUSijdQgJudMcumFi2OZg+1vQWyw1pRIiDtDK8cOhxX8f4J2S7r7Kp72nHyfwn673ENoR7W3OgJ3+J16Ga8YIzJA39T1lfhUmf2IioAQbNZjwNoW1jfeQiKr8yIpbxS1s6zhfLOGBHR06zemBQlqNDSe+DDChgJ4SuHjZld08eurP0mOlxrABANxU1GSyLCUCQAa8hcrUJsmj9Y7ep/kplnbx6I2aXZUVuFDVwjnYli8e0nQPnPaRyDJCoi4nlna/GJ9g3wAD5wSr6bEW6pHB1+qGCbOptKDBtkjBhsWYjTgPDDfndl2mT3YvgP4kLd/PCJSVcx+FOVBzRCQNp5jQuVdy8bBb0FhiO36oTSchHrmWQTiAGW6lMkG6AzKMO5lyKZnswYRz6XiG1Yey1HPDhZtLzj4TwMh5paGmBj0BngG3MBKjAAse4ZLqFsvbR04Xu/fycPGYcmRMUEHRytSMfSVTbJY+TYPOjp5B/gq2SmpKauIjHkUi2aDhHiUWJW8hcac5XdAmfLvdhqhxhIHa22EQtWTSa6wrQVCr6R4rfRCxaUDh+Sif5tiOwHNbUO58JOfdQbFl1XHSVem/lZwBVEPX1/QtDfUQed8YE8Q271BlWsxZcyTxbn15M3XLI2UweoQ/oUc9wGxauEMnc3fq/SbepPGqhDmVVVQCPHYl54kB7A0VerK9fpobGx3zZBYkGT09Zav9uhN0CqC66NZ3uO6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(478600001)(6506007)(966005)(6486002)(41300700001)(2616005)(53546011)(6666004)(66946007)(66556008)(6512007)(186003)(38100700002)(83380400001)(36756003)(2906002)(5660300002)(31686004)(8936002)(66476007)(316002)(86362001)(4326008)(8676002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmo1MkVQYlNkUFRUUEhEdGtvMnhSdlVhamdQcFpIRk9TalNaQjk5c1JqaTVU?=
 =?utf-8?B?Ni9DUmRXK3JiNkhPdUlETElHMVEvWHk5YXFoa3k5WllkQzZMNjlHTE5ERnRS?=
 =?utf-8?B?dGFuSzU4YnFwT3JyZmo1akNES3NEYUVubGFBUFhvelprKzRhbXEwU2Q2OFJ2?=
 =?utf-8?B?a3ZlVDkzN1g5WXJJQ0N5L0RZbDZadGJPNTFHVnZkRFN2N0NnZnhuM0dCYUk3?=
 =?utf-8?B?T3Frc0RFeGdIY2JheGFySzVEd1kyS1lhdlBMN3R2TXBjOW51NHZrVTM3RVQv?=
 =?utf-8?B?MzJYZ2JHNVJKUWlVNHNPQ2ZKbnpDOVQzTkpFY1lDSG5ORUN1ZG1sOEgvd21L?=
 =?utf-8?B?bWtHV3FGcTMxMXpVSlVqSitsZ1AzRmZQVzhtNzNPK3dPY1dwalUwSndDUm9R?=
 =?utf-8?B?SVJLemFHU01CamM0MUcweHBvRGJnSDJjWW5ReHV4eFVPQ1dlSHVONnFkWUp1?=
 =?utf-8?B?WCtHdjVnM2dXd2lLMzNCaFVUK01VSmQvSmdMTEJlMXpNYTkvQXRsTXFJN1JF?=
 =?utf-8?B?TmJnaFRWcXA4V25hVi9zQU5MdmlGeFZhZElwaVhJWUNoR2YxSzEzMUp0TmRt?=
 =?utf-8?B?cXpnNEZWWnd4TFhMLzVJQ0hBTWhSL3JMenRuRElXTXdMWE9xUkk1VWVRd2R5?=
 =?utf-8?B?RG85eXppL3BERHBweTI4MkVTNjlZN1BtOXNteXc2WjNCWnFnZnhkSExUcCtt?=
 =?utf-8?B?ZHE4TllJOEk4eVp0TjF6b09tY1JqbHJFMUlreXhIYlpoZEc0YlBKNmNzMXBn?=
 =?utf-8?B?bVVoeWlKUW80RXpzbjNxeUticXg5S29hZ09NZ0RXMVFSWG5aMGhVeVpEaU44?=
 =?utf-8?B?a1BvQkJuRWg3cXVvL2d1OW5zNTROeCtjNCtCOGpjZllnMGowYzYwSW1Hd2Nw?=
 =?utf-8?B?dGZFM210dCtnb25qd1lxNXM4VEt3MG1tUldoQk9LdktMNWlJWmdhUzF3b1ow?=
 =?utf-8?B?SzhUMjUveGhMZXFNVm56YmRDR1JHUTRPRlFsVzBCbnc1bGNsWHd4U1F3V1lM?=
 =?utf-8?B?OEZvbHFkVHU5ZEVzSVVyMzZGeklwK2NKVmI1bWdDUURVY2taSVFxME1YUmk2?=
 =?utf-8?B?UHFQSmcwV1pXb2tKU3FvNGgwK05yY2t5TllsSlA3Z2hFMzFVM2FheEFkbFAv?=
 =?utf-8?B?OE9JVEhHNVhLUm1wZUs4MDR1dG5IMUxEcEEvaDNoazRseFlTdzhSeDJhVkIv?=
 =?utf-8?B?dmUwNTZFTzhCQ0FGMTVqcjgzSEhRb3AxUFZPblk5S3pEckh5OEF0cyt6WGd0?=
 =?utf-8?B?Tm00QWt5dlF1T2hhR3E1VnordGpkWWZTOTF3MVU1VWNWMWhoak41R3ZXMVNR?=
 =?utf-8?B?SWZhZCtnRnlZZ2ZrZjhyTk5XbksxdG5TVS9ycVdkMkRvQTB1UCt4M3ZWdUdT?=
 =?utf-8?B?Y0FLeDFQVURTay9nNnlvVnZDSTN4L3RRbHhDYkh3SjZLeGxJdmZROHdVZ25M?=
 =?utf-8?B?WDdZL0dBL2FCODV6V2hlQnpSZ3hpc0E3ZkgwUUVFSFMyVWl5MzM3djhBYXBo?=
 =?utf-8?B?dThrVlJFd2VyOWRXZkJXNVkzVk5wYmtZdktVMms0VklUbXBiM1BlaHp5bkRQ?=
 =?utf-8?B?SlozczJkUjdPODZ2UnYwM0NEdlVpNzRCWFRqUUlKVHM5RmtKRTRuS0lJeUYr?=
 =?utf-8?B?dklHSEF4OFRIcCtMZEh2elR3Z2xnbzIxci9EVmhxZ0tSWkFwNFlaNTc0bnFs?=
 =?utf-8?B?QWlna2NyZXN0YXk3MDdCc1lqWkgwOVprbUI1ZjhKRHA1TklrRW12VFlxdm80?=
 =?utf-8?B?dW9ZSUNKWjBQSWYrRGlkYUFwZFE4UUo1Z1R5R1lHWDhDa1I0THFQQllBbkxt?=
 =?utf-8?B?TEpMSGdhNksyZmhMc3c3ZWxEblhlbWRJdG9oYmhJeUdrWjlRZGlRVW41Q1RO?=
 =?utf-8?B?YnpKdnprOVZBemhneVR6NHNTeHZZbEhGYVl1UGE3ek5KQ09FZ2UvVDE3MFUy?=
 =?utf-8?B?amw2dzFtYytiSmt1K2lRUitTNjNGNU1CaXE2YmIxS0xhRDNQK1p0cGFTK2Za?=
 =?utf-8?B?disyM1Fmbkd6aVY3NjBzMUxWcUtzdWxNeVVMa0RlaGlHdXRYakZCUUU0T0lF?=
 =?utf-8?B?RVY3SUpqNlBYRkhpUC9GSHVJK2xVYW5SVlZWY2Z6NW51dzVHcjVIL0FKR05V?=
 =?utf-8?B?ZjNPaEV2TThrbmp4WWlkdXFDNTZSK2k1NW5QMGZYUTBkcnhQZVVkVWxGYlR5?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd7d1cd-dab4-4b2b-74b6-08da66bb22f9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 23:38:35.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxY2J0YnmJTUrBj1sU9TbDpFZGQwDYJ+ytEHyQxXQI/LVMJqkS0N4RSWHf3jrliF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4401
X-Proofpoint-GUID: 6tZteN6vMmb_x7b5cFnuyxPtmalK9U3m
X-Proofpoint-ORIG-GUID: 6tZteN6vMmb_x7b5cFnuyxPtmalK9U3m
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_15,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 4:09 PM, Andrii Nakryiko wrote:
> Make libbpf adjust RINGBUF map size (rounding it up to closest power-of-2
> of page_size) more eagerly: during open phase when initializing the map
> and on explicit calls to bpf_map__set_max_entries().
> 
> Such approach allows user to check actual size of BPF ringbuf even
> before it's created in the kernel, but also it prevents various edge
> case scenarios where BPF ringbuf size can get out of sync with what it
> would be in kernel. One of them (reported in [0]) is during an attempt
> to pin/reuse BPF ringbuf.
> 
> Move adjust_ringbuf_sz() helper closer to its first actual use. The
> implementation of the helper is unchanged.
> 
> Also make detection of whether bpf_object is already loaded more robust
> by checking obj->loaded explicitly, given that map->fd can be < 0 even
> if bpf_object is already loaded due to ability to disable map creation
> with bpf_map__set_autocreate(map, false).
> 
>    [0] Closes: https://github.com/libbpf/libbpf/pull/530
> 
> Fixes: 0087a681fa8c ("libbpf: Automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
