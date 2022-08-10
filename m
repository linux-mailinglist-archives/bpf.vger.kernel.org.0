Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957358EF18
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 17:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiHJPOn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiHJPOj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 11:14:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBD378235
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 08:14:37 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27ADBLjQ010219;
        Wed, 10 Aug 2022 08:13:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o+KfwbQWCJAGqtys3S2K8eSDAedLVvKrrRjQrz0JZFc=;
 b=YXL8nkjruNqLuhIJ+38IDjen1oGha9lqAqA/wmQti1xsgodMdc/0xzaP0aolHWTkb9Px
 XF3e3a1IIuhFtMjSLiNeR6ZC2VFD4NFGODIEGjCDG2FkwnamtsICmE0GybRB0fPN5mfb
 hXpPIhsd0gZ6RSq8Igjy5FsF+B8f+x/TVYQ= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hvdb6gxrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 08:13:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlbmyl8NVWbUEMdHxYBk8XjMCngqSFx58KUpr/RNuOHUjqbbPo9IVeKM/DO/2tJ8Pell4b+Lc507NiTcj9BKfyZQ+8WSRqXR2sWiHObyzq74kE+S1BXbaaIwaDN/zgPcSQSK8yLJjawRFHUcjrUa4H5ov9kaP31igvEmDnRrZh331hKE2KLtuYpUX1nUyh1F6bBW2mRrpvFO16kSK55Qwj7h2egEIp/LioQfa7WpO+ojt0O7bWJQKIzvopJUznz7nV3eXMCLWFODHxViZrobPd3V4DmN2TlkvMPaBZXb8lGV+/qgpN3eswhtS+O50jy13xEiUra26+RW5bdK13/o5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+KfwbQWCJAGqtys3S2K8eSDAedLVvKrrRjQrz0JZFc=;
 b=Sp1gzgl5SEY8AoJ3Wq++XaqAnWjcGeQHaoHTACY8kC634Hg7pa1u4RM2ptE+pRK0a4JDbrYcm54XL3BZaX2chxumnXwqQFZLt4V84AAhV/nuGeDsrG3+5XMVwDI3+e/p67p/570jfYLLas7vTwNgZqKBYf+FrTJM4gk5SEEmhU/DEY0HYZWDSQIlrTS+7M4m2lvMj5YFp01txY19DouiRMULAXEd4Ta1uyDHpstIBrrP3ykW7+G32VFzXjfe7qcTcIx+LivN3QE3kvlAupH27nH5atDm25U8EGvhIdgw+5PAFP2tgH2qducsKzm7xyuIDpf+Dz/8fYp2A3+/R8IeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2363.namprd15.prod.outlook.com (2603:10b6:5:8a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 15:13:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 15:13:44 +0000
Message-ID: <d5d2e818-24aa-b273-9e43-9d82b1cea2f3@fb.com>
Date:   Wed, 10 Aug 2022 08:13:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf v2 7/9] selftests/bpf: Add tests for reading a
 dangling map iter fd
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
 <20220810080538.1845898-8-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220810080538.1845898-8-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:180::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 658b7c00-aecd-47e9-a038-08da7ae2eabf
X-MS-TrafficTypeDiagnostic: DM6PR15MB2363:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ty5hO6bonU681C5hlQ7AJBaHBeEvdwyOx23cnrl29axemGApeHaEAWg2fVMX4p29nPmBpwzNvxTmhgPGvXltI3TNc2HEhEemhqOHGeO/73jrVqWiPkRSedwDqJYTZ+5Jho66NOgr90HJs5EtqiVCgUvLuVxFZTGdoTu4B5jRfkrDO6Zdrv7WTGvDeLhQ6xsSX9xuzO98eOQYQhOeTB7RJvSGSvqIvXzuIm4hDpEPB/TuKwvKwdHLGMTU9c8SrEqSPJAUrCSlg8bkHUSkb3Y+OQRqzfyyydIfodLZR2jv0y8Yj3xK2+DvauFIPKpAlzss8Rp43CPhUILPemCBlt6E3zuEdq6Mq6vJE/3WYB+40sNvToWbSXjFVPpBPd3NPQwPljhjIysGdVEmG7H6Fc2KYXPf9Mo7UvuWSLANPRD9ocZuCiPcUty0J94Gk9tNhgGaHKNRO1ZimPQ9EsMC+ek0GEI8dk7wiyGyJ2pWGuhej/pdlTghdA573PCYFxFRVEkLlpAMQ/JHmBGdsSM/eX2Y2IzqS+YS66FOQ8pf49FGwTu9QKq3a/6l6KxMT9aJTQjPluz6OaWFHI5sW1ai6CzGzfLu0SB50DLKuEsZnoaghwcjgkliCAPZLUESx1d0ovdrzQ7nRRQK3gYMK6nOSBsPveO9MMj07DMxjjyQ4idZYd+2rbuxE9nOtJ/Dkj768qEuxZ5ot0139Jf7n7oFjvIz/WWnthwI/GcYE2kwZVkPqJYTvQiH0skABh7V/QGglb5wz8T/0EvztkoaepUGLxEAKu9OSCNkO/kuE+1GW4+Le+NwcNzbi+rYOfz+P4Kz2jHz7SgtIT05nGzfBql1g4nPvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(558084003)(2906002)(2616005)(7416002)(31686004)(36756003)(8676002)(4326008)(66556008)(66476007)(66946007)(8936002)(5660300002)(54906003)(6486002)(31696002)(41300700001)(6506007)(186003)(316002)(53546011)(6512007)(38100700002)(478600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0M3WVVaaGdyNUM4dUZ6VFdBVmtCdHhYSWxCVUU0UFpjS25RbUI0MjZlaFRy?=
 =?utf-8?B?MEpRbkhURXk3RjdJZWxwWDlDUTIvWTF3QWlNUFNYMW1iRjJQcmM5OHRaTi9Q?=
 =?utf-8?B?ZFB2bllUOEQ1azRnUmtBZkt3ZEkzWVFyOWhUMkVFZGdXUmQrcjB2OGQxeXd3?=
 =?utf-8?B?bjlRWWhmSDRwS0FzV1ZEMnkzVTF0SVFYdGd3VzFQaU1VZmd4NWVQeG5YQXRG?=
 =?utf-8?B?NUhFR2lrSFRBMnRmQUQ2SFJKZndQWnBRT3M5TGZiSVBYMzRHdGFhcFZEcG5T?=
 =?utf-8?B?RStsZ3F3VENsc1FIaGVqZFZSNTIwMzlWR3NnTHY5MHNEYnRMbURIRlV1djBV?=
 =?utf-8?B?anhGdDgzdkRUMWN4QVpYSEJFYnV2MTJCYk5UbWI4d3NlaUl5NUFYVVFuVGo3?=
 =?utf-8?B?VlJJalArSnVzR2U3WnlXRlhOMDhOaHZzNnNBNmNLcnZRb29yclJNS1NhME9p?=
 =?utf-8?B?eXcxekVqTkVPczhkRTNoWVVITitHLzFDbkhDZk90Q0IyYXlFU3JETWo0L1R3?=
 =?utf-8?B?blhtcUEzeG02dlRtNnAvaDFuTDBmRGVUK1JPVDlUNFJSNzJ2dlRIV3JJRXN6?=
 =?utf-8?B?ZHJnRHRUM2xLaExxSjJxTW96ekg0bGpnT1U5elRpZC8xNXNhWWZNbkU2T0Z1?=
 =?utf-8?B?Q1Q1S0J0aWhBSU43MGVTRWpqSW1Lam5kakpjb1VDbFBpckZjNmlLY09JQjNK?=
 =?utf-8?B?bXV3TGlVaEgzVGRzN25QSTFWTGVDQlhaWmtMY2dqVnF5MUJEVnY0S3cyVzc1?=
 =?utf-8?B?YVliTlROb0haR28wUXRFOEVjTkErS1dsSTY0SGJsMEJHTGlGRG9TaXdVMzNl?=
 =?utf-8?B?TjlxSnpoazNnSUxoZVNuTDl5aXRzSVl3T2Z2RTBUempEVlRLbzhFYXhNWnFT?=
 =?utf-8?B?RnZyakRSVVh3VVBPYjFWejkvbEVEYjlCbG14WWlWODY5RjJzVGtkTEFxcUxI?=
 =?utf-8?B?T2s2Wk5GZ2J3a0NyWUVWQk1CYTA1VkRqVGFEY3JSQUM1elBwMGlQeUdXY0hs?=
 =?utf-8?B?MkZZb3BaYnQxQTk3WmtwYzhpZkthenBwVnZJWTJVU2ExTnRwS3FXRTAyOThH?=
 =?utf-8?B?anFxUTMwc0hyenZraTVPWDNPQU42eDU4MW40VFo0aXY1c25sN0RMSlZXZmRa?=
 =?utf-8?B?Y1FQUmZOM1BwSXdiODdIbldZbmdmNklENVdGWmVOSEFaZkxUM0NIUmVaem11?=
 =?utf-8?B?bWdmajErLzdKT3k1MEswaXNDVk1PTjA1am9sKytaaDByRFIvME1LaCtzWlEy?=
 =?utf-8?B?VHdWQ0RObFZHY3BaTjI3VGFPMXVRL3YzdXBBR1JLcmdsdEhQWWFSQmFvbmV5?=
 =?utf-8?B?K09TSHI4WUhIdjhBREVFNkszWVpLbC9WNFlaS3J1RjJaTGFVM29lWFR4cjZo?=
 =?utf-8?B?MDhYUCtJWUJzejZmb2ZJSklFRTNGSFZnWXN2QkQ1SHExVWdMS2lyYjhZYW1P?=
 =?utf-8?B?OEZHVjZLSUozOGF4eUl6ZWpZL2Y1V1BaeHlvNlRiY3Jla2RCVENDT2QyeG8w?=
 =?utf-8?B?d3M2RTJtUVNyUjU2M3ZvWDhmZ3ZoV1JkaUJ6Y0gyRXVYSjRBc3hZdGNmVXJ1?=
 =?utf-8?B?dHdHV29ELzd6emxRMFRXVmFzUmF5bDlkeHI3dytQMVpiOWltTU5IeXlQeFFY?=
 =?utf-8?B?b0dpMmY5YVVZSG1QSFM5bDZ6T09SdmttcVRQRi8ranpKY0NJQkNZQWF4eVh4?=
 =?utf-8?B?Y0RDYmtuMVE2Y1kwTXZPZExRSHZoY1ZuL3lYMW0yVTJHNnphRmY2SEdBMjRp?=
 =?utf-8?B?U0pvYjdhSEgya29iQlYyUXN0RityM2MrcUpkSGxuZDV5NlVKK0p2dHozNWtx?=
 =?utf-8?B?MVQ2OFo3L2J5YXJDTDlOTDNQbEdDNDJZMVNseEo3RUlHcGIvUEE4akhMQkZu?=
 =?utf-8?B?WkJLMW9nUGJ2WTYyczdOQXFOejJlTGNkL252Qmhhb24wU3J3NVo4K3cydEU5?=
 =?utf-8?B?bVRJbEJpVU9ZYTBDQWE3QWw0MXNrYTBOMjRaVGlvNytER0pDVHlYUEt2ZE5l?=
 =?utf-8?B?MnczOFNMTFBZUEdkVXdEK0l0YnNlMFdEY29VYkNSY0VGSVpxZkU4bDdrY0xa?=
 =?utf-8?B?UDJpZHdHT1ZKY05SMS84YzNPLzM0UWRzZ0NUUDdPVjBMcFBydEJzR2M5WWcz?=
 =?utf-8?B?TzhHRU9SQmpzQnlsYlJpNXhVQzFJVWQzVmlPWm1Cb0FqL20wb3ZyOUpsSk95?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658b7c00-aecd-47e9-a038-08da7ae2eabf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 15:13:44.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbWorqSuXi4xyAqmGI5cZ83dCjzxCrQawOAGKBVo4oonNgu4wQIjVUw3vXJloCRU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2363
X-Proofpoint-ORIG-GUID: TpXBUoz-xRWKvB6vADEWAN960lDCyYOK
X-Proofpoint-GUID: TpXBUoz-xRWKvB6vADEWAN960lDCyYOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
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



On 8/10/22 1:05 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> After closing both related link fd and map fd, reading the map
> iterator fd to ensure it is OK to do so.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
