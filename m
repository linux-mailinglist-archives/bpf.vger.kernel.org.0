Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8615B3BE8
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIIPbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiIIPbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6EC89CEC
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 08:30:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Dxuf9012655;
        Fri, 9 Sep 2022 15:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=X6KkBrsuaXIJILt63wnN2UkeCReVgrpZidyTlGg9oZ8=;
 b=Tw4edgMWPdcyXYr6PPeJZ0YmmyB+srRW0Fs5b6joOpPrea7n6FyfJ74cVO/sxgHJbKfU
 I9MoEmtVksUCEJUAHcchvq1jJMqEUsKDKvv/qCUNuwku4u5wFqOlGJMpGUIAi8FPY7FA
 EVoO8LlnuYNQtIe46HeHWNy/FcedCBNDPqbCk9vsFrMlSMM/AgIcXRTUkqIWO6CLbAZi
 +U1XPebffLIM97iprFQDrK4AgzF72tuKHynlRYBmK0U6Qv7hXHzFN4PzmJjPHBPissIo
 HkleiAF/JZDBy+pAcGh1VJ56Yspv9GtI+/dFtQHnUWZ6v0/7U6xav132a1brk1YFMq3N HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbcf4r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 15:29:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289DfhXO024565;
        Fri, 9 Sep 2022 15:29:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jf7v98js2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 15:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTODLgrJmHQx2/wwknoF3vux2DTOnCYITDQCv9zOyUJc1k4Dm7I4R18+VZy/nMi94/yj1cqLKoa7HZleiC6kMxAQ1Cao+bl3a4Nz8B86bnCSqDwH9MSFjd6L8BTegkTXfsY88aWc1EXIrVytVrhw7XIyH98iLNRXkIl8NIOMt+elV8UKiFZSiGEdxrnokuD+RcR0T+Pzc4VVpHIcifb0Q+5XyWRDqdzjv2bZ8TqDgDsKwsFKnU2IP7u1js5WLrkwnHoLiSZvQJGlHP/YDK1hijG+U5yB02h3hFZ7NS+Lou8sYv3P1O59VM9fdCJLbfWzI3LCh1eN9vhdl90F8k/urQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6KkBrsuaXIJILt63wnN2UkeCReVgrpZidyTlGg9oZ8=;
 b=MRqQqRHTofxrdLT6SDWuxj7Pfm2MZM8N7t7l1oNOwTzCv6tzkScRMn4T4rvvBgBZQnX07OB8JOudkiuLCHUFbVBmCfQdiYGOpnW21OEzh16SReMcVmvSrp7R+Qedui8Bfhyg7YgnokZrQB2k2SpjeefPHPb1EjerjxsrnC/vyw9DcLyx3d+kcKFi2VVEies6uWMxYa29FDxw4NMXJFdReNh4fdlIc6qgQVJ8tsEzsIUfk+jik/gKWmQR96A9kDAqVswtd4pBQyFmjO+9I7pwgL/aT+nLU+Fw0sdUH50YZyI4eBxAjXlge7oGuOYKnV3ySPPQlyAws6rSLMCkfWa2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6KkBrsuaXIJILt63wnN2UkeCReVgrpZidyTlGg9oZ8=;
 b=CSQng5vCb8+O1dfC7H2xbB2uehfsbS6YuBtgqV8UhgIOFQ5BGMKrIvdydIFFZFwA/QRlPahQoJiBZWDIR3W1qUvhsP6sLG9K5w+hpeAW6aYNai5RRgMnm2GitD9D5jD/NTDhvRVjaM9F3uNRQ/bjyMkAti7qXmaa88gyscRnnNA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 15:29:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90dc:191c:e713:64de]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90dc:191c:e713:64de%3]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 15:29:08 +0000
Subject: Re: BTF and libBPF
To:     Jeff Xu <jeffxu@chromium.org>, bpf@vger.kernel.org
References: <CABi2SkUVSMM-+7RzGu0z0nwsWT_2NiUZzTMNKsEc0iOPSiNr9A@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <1b9e4d2c-34d4-2809-6c91-d14092061581@oracle.com>
Date:   Fri, 9 Sep 2022 16:29:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CABi2SkUVSMM-+7RzGu0z0nwsWT_2NiUZzTMNKsEc0iOPSiNr9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR07CA0113.eurprd07.prod.outlook.com
 (2603:10a6:6:2c::27) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7b7b3c-2ada-40f9-a793-08da927809e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yuRTIi5xCFEt09DzAz/qqFosHMiJr03H7A/xP6H5+wyz5WopIesR1VbolpHQAz8bF34Zu3uur+tBaFQA08c7c5FnWk4TtT0glEyiD/LKw+pdHtc4vauOHCDLhEm/HfnFl04vSYGM89UWXAiVJ4DDi26Bg4rPFElKNmev2ehA/7tp0TQDbB61//hjZeUtymLVx0hooy77G7PeZQcl8dIe+aBZVzxzbp0+7dgf04RwN7IbwIh8bD/FWHMogrqmtYBVaiBU5juApj3mLSKM8ZX3NggaU1aDVE4RZ+4yjfDMKQ+R+8xNPZkffQ3NhhahXBpIO8D7hCNPwZNA/rmx6HIu0vNr9rIyIxpDad6ds3TZ80NT3alDRzKlTJ+zz0FP9RnHnsawwJc1Ls6fJ8otatlx2MDsvyNTu4fTx9hgY8fvoHb1YjBwTf2D3Jq9XrztwwFna4tnefgZG5bxwW6q6c1YyqGiTz50DfUuYt9wyZH+Yog6t+1y5OgUdL6/Eg3p3H4ungmWyJbX4BpLxUf4bj7YA57ypMeIMF52kdnJdawH9QUkGnTVG/uYAGVn5EsoAXvG1+qEAcGlUTS6HgC+rO/kzM9VTjZ6fCEEk1fhbe1F4Zefx8ZrrrQNGqHr+qYLN2quLEUk7QivcMdoYs0x9aNiFNqYWfaTct31iNPT3ExNeUZ08HCVwso1eoqrpMkim1GESCQGjBuI6EPFRikhkPBAOwxALNdfzBPCJZAA6j5NOuqhWEz9iQp/4Y3AW9DgvVMOkJirudseDZhOZTJ2zkuMsaW1w093GTLBvqWvuzBCIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(136003)(39860400002)(186003)(8936002)(83380400001)(2616005)(2906002)(5660300002)(44832011)(41300700001)(6506007)(6512007)(36756003)(86362001)(31686004)(31696002)(6486002)(53546011)(478600001)(6666004)(38100700002)(7116003)(316002)(66476007)(66946007)(8676002)(66556008)(3480700007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdqa1lSYmFJVml6N2x6VDZKY0FXd0VlTTF5aVl5M1o4Zld1ZHpQcVdqdWtu?=
 =?utf-8?B?ZVZHTE5mWEd0TGFVS054SEE5cDVhTDFHOGlYN2RRN29URURaWC81V3dBL042?=
 =?utf-8?B?MGZhd0NGSDlhNDlHb3FIWDhGN2VLSXdWMC9YWWp4SHMwWDVvckVSWFlqT1Ur?=
 =?utf-8?B?WGZ0eHRkUEt0Ymo4R0FIT3ZvU0lrTjBlQ1NiZGU5dDVWS1krVkdkVlBQbFE3?=
 =?utf-8?B?THZBMk9CT2hGVVVlWFU3REVoZ2RTUXpaUEhUUFl4WDVNanBMR09sRm53VUFw?=
 =?utf-8?B?Y2x4S3F5R3I1TElOZURTeC83OXlZek9WWkFJMXhQYlR1enlWVEQ1MExQSnFO?=
 =?utf-8?B?Yk5oZEVmalk3bFo3eHYrbmlucUZFUkhpT3ZsREZmRyt1SHZKQnk2WnZlSk1q?=
 =?utf-8?B?bGJkdnl4d3ptOFl3TnhwSTdPdHAwNHVHVVFvdU1iejBEM1M3TlN0K3B1M3lZ?=
 =?utf-8?B?VUNQUjdrZXRWMkt0Sy84R1hHaHZucmx6cW1QTm1HRGdzZ1grVERaSktVeWty?=
 =?utf-8?B?cTNTQXRmalVjOEFnSFQvM2FWd2czeUtUR3VHZ2NzbFFkQjZxOG9ZV21rRXpu?=
 =?utf-8?B?N2tTNCtBSjJsMHZTNklKK3owSTRRcEZBODkvWHpCcW1WOXZ5VW9EZVZSRFFC?=
 =?utf-8?B?YUNCZDZmSWViYWJPZENxY2p0Sm1zc3BHNjVpbFl3RXQ0YnZ3Z0ZLejdzODFa?=
 =?utf-8?B?ZVlqTEc3elBqUWkvNis0c01aSi91SFlkNmdLSFpwd2ljNjFqMWcxUWU2QmpX?=
 =?utf-8?B?MkFIbmIvRHFpeWd4ZWNvMGlOeWpGMEJTNVZvalJOMXNzZ3BwRmpPM0J4TWNO?=
 =?utf-8?B?SGhKNUQ3YllmbHRXMVFZTUZ2QXBiNnJQZjZ2ODZ4M25ESlQvVm1EdXgvK3I5?=
 =?utf-8?B?dy83dDgyTWRtNkFLMUVzUmNQdW9hTnE2Unh5d0xnWlMyeWNXVi9QdmhVdDBn?=
 =?utf-8?B?ZzdLOGRWWFNXTEdBdUhXMW9OVkxUUW10UVc5M0U1Sk1ZT2xhalg4WGZCSUtU?=
 =?utf-8?B?NnpzRUZITWxlb2FVYUgvUTFIUDgwK01wVlVINzduUjlYTHpqakRTaFAwc3RJ?=
 =?utf-8?B?WW1Oc2taNnRaMk9YcVV4WVdXYU1CTVZZSUtadmZmcGhkZTBqNU5lak91ZGRu?=
 =?utf-8?B?aTVZRUpGc0F1TzBmWTBiRVJhR0IyUC9NVHhCRVFieTdCRVZYMU82ZlNBUVdF?=
 =?utf-8?B?VWF6VmtPNS9Pd0ZhVWt2M2xtRGpLaDBSdVcwNnpHc0dTa2dqYjFjQmxtalJP?=
 =?utf-8?B?aFp3Vit3dmp1RDRKL3R4YnVrNUltNDczd2Mya0diRG04TXlTbHJHYTdqQ0lG?=
 =?utf-8?B?UkRmK3g4R25sOE4wUlhqVElvb3JlaElxSWVNcGpuRkRZbytzL25HUUtmQ1Ft?=
 =?utf-8?B?VW1QM3pDa3JwbEZHVkFZZ0RkZEo5RnVlVDNGcm1RWVVKSG5NYWZ0c1Yzc3ZJ?=
 =?utf-8?B?UG5nd3Q2VnArUkU5SDZOd0c2Y3VNbStuQlcrT1RpSHNvWmhiT0xSY1M4YzM3?=
 =?utf-8?B?UmJ3KzZORVV2cFR6TnBxSHRWZE5YdTd2N3RoRXRjY1RTVWJwdll5U0NBTTM3?=
 =?utf-8?B?MzNhRUptTjZTSVl1MURyalZKcWU3Q2NGdWlZZjB4UHphOFZzc1lTTHVWU0JR?=
 =?utf-8?B?dHQwanN4UVhjOXhQRk9YVG10VjJmSVRibmVuTzR2TnNRUm0yK21HSllRUm1L?=
 =?utf-8?B?bUViUHRyUDZReU1QYWovSUMzVi9UN25zYlFGUkhBMXVLblIwaWQxOUZTa2Z2?=
 =?utf-8?B?N0xxaXY4L0JYWGhBS0I4UkxpMkZzeG9rNllUcE5BZTBRdWs2eXh5ZFNJQkov?=
 =?utf-8?B?NmY5Q1E1RDU3U3pXRFhZemhudXlCbXQ3WUl6RVBkbS8wOFIzaCtieWh3b2Yr?=
 =?utf-8?B?MjU4eWIyZVpuNEpuYWIvWkJVY1dQeXRIdHQzS050ci9uNGRlcUYvYU4rNUNn?=
 =?utf-8?B?czFBMklSTWFWY0RPTUxNaDhSaVU2cTRjWHlqclhzSzZjUUU3WjY2MmdTK3RM?=
 =?utf-8?B?S1RwWXkvQ052YzNGa3lnUHBDWURnL0diV0FIWnpEMHlVZ0M3ekZnbkZMQ0lo?=
 =?utf-8?B?YUdPTVhSSnYzTXlrM0Y2bVhEM0MrakZMQW9RcWFhamNuS292MmtSa29QcFhp?=
 =?utf-8?B?ejRENGpKc0xiTklVbldRSGp5T0JLSUErRjZSa0NpY0ZZckZrQzFmb2VvNTc4?=
 =?utf-8?B?T1drRnoxWExkWTRFQWNSQmFnYkVCb3F0c1p3ampMNnd2Q0dWcWMxNGRpYVlS?=
 =?utf-8?B?QUV2dTM0YVV0QmUzSVJ4eWVieFFBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7b7b3c-2ada-40f9-a793-08da927809e8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:29:08.7725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwGi1h1cwHz+ajNTTX+8R0zMtXkfy8pSFySmUt1nYIWZbUFipsn1xKDgqQpAUiwb26i4ww7lp4OZeW/YfU2PfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090054
X-Proofpoint-ORIG-GUID: V8cFASOVQ8jTbo79iTTeMrEz_xkwl4TY
X-Proofpoint-GUID: V8cFASOVQ8jTbo79iTTeMrEz_xkwl4TY
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/09/2022 06:22, Jeff Xu wrote:
> Greeting,
> 
> I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
> Please kindly let me know if this is not the right group to ask, since I'm new.
> 
> To give context of this question:
> This system has limited disk size, doesn't need the CO-RE feature,
> and has all debug symbols stripped in release build.   Having an extra
> btf/vmlinux file might be problematic, disk-wise.

Thanks for getting in touch - ideally I think we'd like to be
able to support BTF even on small systems. It would probably
help to understand what space constraints you have - is it just
disk space, or are disk space and memory highly constrained? The 
mechanics of BTF are that it is generated and then embedded in the vmlinux
binary in a .BTF section. The BTF info is then exposed at runtime
via a /sys/kernel/btf/vmlinux pseudo-file.  So when assessing overhead,
there are two questions to ask I think:

1. how does BTF inclusion effect disk space?
2. how does BTF inclusion effect memory footprint?

For 1, on a recent bpf-next kernel, core vmlinux BTF is around 6Mb.
However, an important thing to bear in mind is that it is in the
vmlinux binary, that on most space-constrained systems is compressed
to /boot/vmlinuz-<VERSION>.  When I compress the BTF by hand, it reduces
by a factor of around 6, so a ballpark figure is around 1.5Mb of
the vmlinuz binary on-disk, which equates to around 10% of the overall
binary size in my case. Your results may vary, especially if
a lot of CONFIG options are switched off (as they might be on a
space-sensitive system).

For memory footprint, BTF will be extracted from the .BTF section
and will then take up around 6Mb.

Another piece of the puzzle is module BTF - it contains the
per-module type info not in the core kernel, but again if modules
are compressed, on-disk storage might not be a massive issue.

Anyway, hopefully the above gives you a sense for the kinds of
costs BTF has.

> 
> Question 1>
> Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
> CONFIG_DEBUG_INFO_BTF ?
> Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
> /sys/kernel/btf/vmlinux removed.
> 

It really depends what you're planning on doing.

BTF has become central to a lot of aspects of BPF; higher-performance
fentry/fexit() BPF programs, CO-RE, and even XDP will be using BTF
soon I believe.

So if you're using BPF without BTF, there are generally ways to make
things work (using kprobes instead of fentry for example), but you
will have less options.  I seem to recall some fixes landed to
ensure that absence of BTF shouldn't prevent program loading in
cases where BTF is not needed. If you run into any such failures,
I'd suggest reporting them and hopefully we can get them fixed.

>  Question 2: From debug information included at run time point of view,
> (1) having btf/vmlinux vs (2) kernel build with
> CONFIG_DEBUG_INFO_DWARF5 but not stripped,
> are those two contains the same amount of debug information at runtime?
> 

DWARF5 will contain more debug info, but will likely have a larger footprint
as a consequence. I'd suggest running the experiment yourself to compare.

> Question 3: Will libbpf + btf/vmlinx, break expectation of kernel ASLR
> feature ? I assume it shouldn't, but would like to double check.
> 

Nope, no issue here that I'm aware of. I've used KASLR + BTF and haven't seen
any problems at least.

> Thanks
> Best Regards,
> Jeff Xu
> 
