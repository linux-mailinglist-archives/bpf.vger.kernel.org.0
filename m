Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B584E78E3
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 17:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbiCYQ2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiCYQ2P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 12:28:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181ADA6C9
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 09:26:40 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P0IaFD022295;
        Fri, 25 Mar 2022 09:26:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VirnYWsyleQwj9SydCs5+bi7WtzZDUviRPaQXwkOyKM=;
 b=oaaJKxrDnGwjTcLchdezv1v/ZBAE2XC3QS2SRYSreXwYV6U2Qu+4kc83bAT/7Hz7Z7FZ
 +aSO34ZT5K+7JIe8BBIu+VdOyGQrkg9/CyavkHJZSQRvXJO4MBxx5mIdfFkZIGvH0aB7
 h8VfvtxCJfQ1vgqnjPKGOWoo9igLtAXBfw8= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f05kfbb96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 09:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAVRV/r+mwvTsHv4z82Ar4HksU7wkOIAxzeoMDQqfVaqtYxLz/lwmnQNkmX+JH8e8NJNYBB0IxBUkKx0Q+hO0blek7CNFCxms2LWXKsOJChc0SsT9vKJwWEqDkOSqDbskGv97S4cd+7g+CUrBtkHvN2XM6nTzf5hYZhmHZ/V5bKzFXW7k3zXlGIi3uji8sz09aLwqteBTGYGdY/MceVMkNKJFvzuWo7goxRtsFeeg0s09m1Rcu5ohydZHZJmgLDp1C8XkPB+1/zW+b5mC7mxDl0ZufR+bP6aCuXNYpgaa2t+38xgjS5Z/zZQchypXVWT8iD70w99bdroLHWl3O43Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VirnYWsyleQwj9SydCs5+bi7WtzZDUviRPaQXwkOyKM=;
 b=FnPXMtviGD7tcokT2irrQ/mDyVu6VhYEHjkHkPvgBfNeb8JgdzEx2VTNUppW53GGYUuKnbiiQqtX02rC6+l8B9jAnKWZTAZvsFvLTuE+NqQ0npjPjo6XNbhO15nvNMD0Laq8Li/MOHq/jNqWxWyXa9WDrCpUUiL0StpNLH2b3mskn4isD27Gkqx/TtE2VXE6bJDwHmApKIWpKPclfTTvRt+m0z/w1T56kiEDkIqeuJXx2P6DxnRvKQBmfP6tCN+VuTvcN/O3J0/74b5DZnvXFgP/+NJuvhIUs6Z6o2BhIZtPQDyzyoWsBNFGuhmowyGLzQ/5rF3VGBPKy/AFPHJcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1863.namprd15.prod.outlook.com (2603:10b6:910:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 16:26:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 16:26:35 +0000
Message-ID: <461b9c1e-fb5f-2c5a-b658-8808aad29ed6@fb.com>
Date:   Fri, 25 Mar 2022 09:26:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] [PATCH bpf-next v2 1/3] bpf: Add source ip in "struct
 bpf_tunnel_key"
Content-Language: en-US
To:     fankaixi.li@bytedance.com, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-2-fankaixi.li@bytedance.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220322154231.55044-2-fankaixi.li@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58a0e78e-a848-4dca-c0ad-08da0e7c3ab4
X-MS-TrafficTypeDiagnostic: CY4PR15MB1863:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB1863F6F61028A9F999665308D31A9@CY4PR15MB1863.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OviOClbZYZ9aSr36UPsJ9HKNLshJQ+ae07WFy58gdpMR3xiMJVellGwj6/D0e9mcesbLo2UeDfHJjahzE1d6R3643sp/2VebpJO5zOc1SzqteOaMn943Zd5RMGdnZh/wErzYTfLyc42cqqS4SUtxFfpLNCU+IxJwCBzMzATesyFZX3tmB1E0UwrA9NBndCo9sVkwjfWwxExijMSwaQ4+ibZsq/m95mQZumEM4HfVOKVQaYjVrH84oV02KMh+H6QGV89pk1nURkb8aR+FC5nTm3OHI2M/snOqfVaG4NRERVkJ1GPmm8/kjTUeKXhQwaza8drU2/QJ72N6QURPGJgN6226wN6NJK2e+deGDPm6arlxKY9TM8+ogQmBITf51Ik6sIsrkI1CMoPjeWQjZrLXWx2v2Jew5CDCWkCViYKRXxPckR3axiYsL+dgAn9f6D+3jZk0uUyfccj5CM/io61QhQNpfh8mLDZHzeyqG01ERlHbbhuc1qAOZ8GwNyxQGKTnEciw5OoMuBYQoNS8aV1JW9OVB1VtwAXI7QNlFPbP7NfWfgN4EIx+RLROanmy2xb1QqGddjmkNIsjI5GNiZAwaRFjE0Av0nA7XfQfsm6ibeXY36RMR/BCBTfK3sRJM9Lj3KwlUeX/v3AQMhI+WpQHOx/NmIGbNwj7ZWqkLjFR4bCpoOBGXiDTn1Q2IGAFFS7lDVORhaomO4ThNdSTKTcPaj36icPYiDz1byuSJIZoPkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(52116002)(53546011)(86362001)(4326008)(316002)(508600001)(31696002)(38100700002)(66556008)(8676002)(66946007)(66476007)(8936002)(4744005)(6512007)(36756003)(6486002)(6666004)(6506007)(2616005)(2906002)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVkc2xKNGNqMG13QTV1SEcraEpsZlhxK0swbk4wV1B4OU80VythRGNVTzFP?=
 =?utf-8?B?ejkrcWJzQ3ZuWWU1Vm83eHdiaWx6L3VEMHpBUGhEM2VkNit1WlJQYThWaE1D?=
 =?utf-8?B?VEtZK1U4NFkrdGFTVXowRWN4Tko0a2pJVjhUV2NTVHM1dDFkQWFYeTArbjhp?=
 =?utf-8?B?S2YrTEo3Q1FrYjlqUXA5UkxoNTg3bGtQczNjeGRIc2taM3pBV0FCTHdtMkZR?=
 =?utf-8?B?OXhST0NjaTl0dGt0OTZwZS9wYWVSSldRQTNRdGVUemozNENQTmNRVjRaMkEr?=
 =?utf-8?B?QWZRRmN4UjMzQzlWbGxHbVJxakdoSmRQNk44WitsUUdEM2xDS253c080K2pD?=
 =?utf-8?B?NjY3QVlZdzdmdjlPQ1VQMmo4UmZSVUhtSnVHUUJpSG96b3c0SWFvei8waDBS?=
 =?utf-8?B?Vk93UXhPMjVxNXJOK2R1ZjFvK3BJckYyNnl5MlFDTjUxRTRkNS80MlYzL3hO?=
 =?utf-8?B?M3JjaFEwYkpHTEptbDZ5dEZPUEVMdzdjT2UxK2hvREVnaTg0SVZOeG1xUnBw?=
 =?utf-8?B?SEFhU0RVM2syQzhxZjA0SVREclFNL1ZyM2RFYkJpTzZZOVNFYWU0ci9YbXNi?=
 =?utf-8?B?VUwxVk85aUd5K0xsV0JIS2lON21GYWVYbUJJTWJZQ1p2ODRqN3pidjdqbWhS?=
 =?utf-8?B?aDIwQkptbGljcGRBZmd2b3pIQ1FmY0lyaVp4ZFVCa3RaUkExU0lpZG4zS2Ev?=
 =?utf-8?B?dVNRclJJbkFydEV3T2JhdWVtMWk5UXFSaldhNHJtSFd1dnRJSTF4Zjk5VTBI?=
 =?utf-8?B?US9yVHp5dVpDYmpWdnJvUHY4aFU5TUpzcDgrTEoxbFhzemdWclIwUHQ1UDBL?=
 =?utf-8?B?RUF4c04zS0tKNEF5b2Z5bVlyVWRWSVJkTEpITlpCaVFac1p1aEhYQXVxcTFF?=
 =?utf-8?B?ZW5DU0x3TzBaZDJHOExxVTZzUUdQSTRIaXNzTUwrL1haQkxwSXg3clJzZktD?=
 =?utf-8?B?N0VHZk1OaGR0WGp1ZHZEOERGQ1djTXRSNGR1Wm54b2ZvMm50NjlZdVpCQjdH?=
 =?utf-8?B?NTU0bXkvUFRWaVpXazZBVGZtUTJBOUFZVjZjdlluZllNUkxuNlZxYmRad1Q1?=
 =?utf-8?B?T0hHSGczNlpnUVdpMXAzenh5MkRMNll2K0JpcjZTNnV4R2V6d1lwN1NLN2Uw?=
 =?utf-8?B?YkJ2a25tUStKbFpiOU1TSkJkblRqenYvNGQ5UXQyMzRuUDlQWitkZm8vdkxE?=
 =?utf-8?B?T1IvNWY1b0EvOUcwaWdoN2tsd3ZRaG5yTnE2TDNHVUxWMnA5WHNLNjM5eThp?=
 =?utf-8?B?cW5jOXY3c3hIa3hEUDBlUnZudW82OW5FVlhvTTZMamRwZzNzQ01aWHd5bENP?=
 =?utf-8?B?d2ZCbUtMdVc5QjQxWDM4TmY1Vkk2UXJSblQvOFhQdmtPSTVwR2JqL2gxQ1pY?=
 =?utf-8?B?NUVGVlc1bVI4eGgrd2tER0JQL1VWYUhQLzRTQUQ3UlhOUVVkaE52d3BOTVVr?=
 =?utf-8?B?QmJrNFdTYjlpZHBycFd6VWw0UkFQNzlBQTFjMElqRlVrdWZBZFE1YWVzQTli?=
 =?utf-8?B?L0Qxd0ZyTXlidjYydTdDRDhJbUNoaHo5cmh5VXZ5MEpvSjJBT2VyclVnbS8w?=
 =?utf-8?B?OWhxTjgwNkxaMjd3K3FkWW9nOXR1ejdiUFZHSTlEY0x4T3FIaUx3MDh6NVpo?=
 =?utf-8?B?a2ZNQjRvK3gxcXUyVEMwZElSYW5mUTU1U0JWaGhyOHZKcGVGeSt5dWZ1YTE1?=
 =?utf-8?B?cWpxRTV0MXBGdWVLSDBZRHVoMGtwcDhrZW1ZRjNuQi9SWmNjbE5uYVh3RzBS?=
 =?utf-8?B?aFhvNmQvQ2RIaFBhZnlZQXltemsrUTNEV0NqMXVTcTV5ZnM4UStSQ1BpN2M4?=
 =?utf-8?B?TVZ4VFVIbFIvOER1Y3VJZ0RoWW9sWUltWnd3SVltWGx2QWpYejBsdjUreWpk?=
 =?utf-8?B?SzN0T1NmTVl5VjdQSklNV2RKbWpCSkh3K2t6UnVITlc2WFhRQm9rZ016TTlh?=
 =?utf-8?B?aWhBUG1KSjlIdWl1TGhCWVd6NVV2Q2ZCSUZVZWJ4MnQ4d2liK0xUSHFCVXFj?=
 =?utf-8?B?YVJFL1NpaTlYOWhGTVVsRVlOMENjSDZRUkdYT3dkNGNlMzNiOHl1bndkTnY2?=
 =?utf-8?B?QkNTYVVwYWkxOFZkOWgvdlNyMHgvcTdqNFdVQ3BBS2RCZmk3ZFZYRVVUdUNi?=
 =?utf-8?B?c1lSZXZ4V2dTeUF2emJFZXU4eXBndXQyVThYMVRNd2xQZXlzY0dFS3NLay85?=
 =?utf-8?B?UXUzZ3VGTUhzTEVqeXR6ZFZVYXZaZ0EzdHovM01ybUJYZjFhMm1obnU2ZmRP?=
 =?utf-8?B?YmpGRGFTVVRFbFVuTU12YUIrK01yTWdQWmZReHZjZXZnczdoWGRpc2MxRnRa?=
 =?utf-8?B?cmJLOGJ1TTZjdXBTRStiOTl2aFNHVEgxTVdmYWRjWFUwUTVmUnJ1ZVluYm1I?=
 =?utf-8?Q?nxdYtmoyF7g+OBkw=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a0e78e-a848-4dca-c0ad-08da0e7c3ab4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 16:26:35.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXWZ7zVj3gnUuFuyOYWMhoGxI8sYh/SNq9T8C6lp77HlFSNftBI4O1o9GqjTJCXP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1863
X-Proofpoint-GUID: iLKYq7ynaZMLpVdrIhsxIq3l7EuR2a58
X-Proofpoint-ORIG-GUID: iLKYq7ynaZMLpVdrIhsxIq3l7EuR2a58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_05,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> Add tunnel source ip field in "struct bpf_tunnel_key".
> Add code in "bpf_skb_set_tunnel_key" and "bpf_skb_get_tunnel_key" to set
> and get this field based on the tunnel key from "struct ip_tunnel_info".
> 
> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>

Could you use proper name, e.g., "Kaixi Fan", in Signed-off-by tag?

> ---
>   include/uapi/linux/bpf.h       | 4 ++++
>   net/core/filter.c              | 9 +++++++++
>   tools/include/uapi/linux/bpf.h | 4 ++++
>   3 files changed, 17 insertions(+)
> 
[...]
