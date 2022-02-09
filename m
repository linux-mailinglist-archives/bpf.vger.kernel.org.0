Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA94AF7C8
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 18:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiBIRHE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 12:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiBIRHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 12:07:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0495C05CBA7
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 09:07:00 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219DAYE0012915;
        Wed, 9 Feb 2022 09:06:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VtfVPZbD5U14WDq6j0O3HUB99PWrpRGrAiiO5yrEq+A=;
 b=kj9QfGbJAdGFRGPfbCz2Vg5NYScwhYuv7Bqe5RLxViyp63YsGKiWloDQzmI6PUjhWGre
 ROM5iz++B1JOBFXy6Q9zLZqnZ7FGiAS0BG8uMDgTZrnNmHG6sOu6T/lhvGvdTK3bCRkm
 jwB2FarcVk86I0LQVrgZikFS/lK3OuHoSuE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4e8nsrgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Feb 2022 09:06:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 09:06:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4Kn87nUlaaiZsRqIyFRXSOGijSTBZyks90qVYUWn99LgzlTk+jUEkEdrX6pk9EC+oJPh7C/wcWNKAyHi65ZrlQ6lXrdlTdEyStciS6zPR09Uc2b+OHjgdfgaLL3vL+vChusvoWgOdciE7BZ5aGP9sc1wWsG0HH5QPyuBzOo8YLc8IoRjQCku9gV/XzUnns76YG0bS++C0Ze/NKDxaaov6pDWARZM6i3MSgmKQqkhtkVC0um+NjjNRIo3bwGVkx4Y2bZy3H/gcYSyAlAQ7lmyvl8xxieFMO/jlpOr93byoaDpRJGgPuohYdYN9L+rBXzdTW5xntjWZ0d3vQ2OVFgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtfVPZbD5U14WDq6j0O3HUB99PWrpRGrAiiO5yrEq+A=;
 b=hszFGhYtrBev9j+VnXTsU3vQ+IuTQ7LrvfObwfucXwbTcT/hon8Ic9cQnkFlLyDiZxAILFwrNOoFz5qU3HYMdnEiKwmXOLjn7AY1rHtLZ9ChvlQ1r8yale/vCUPO8/sgSByfq7qAJ/29ta06Ql1iJR+Atjkc7Jo+nFGz5/N44HbF3udQGBKcBCiPUL+F3mAY2zvjF0hRlysQQpcsFGl0VLIkR5xgnMN7K+BsZzXQHItViyOYWXxepYTp7LmrnHGxwKO4EXVuW2nGxGx2SDshLn00syMyX88RiyJdv3WVghCk8D4hIWWs6x21+4LX4fxPMWRFywulX6KXM0sPwhij8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3494.namprd15.prod.outlook.com (2603:10b6:a03:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Wed, 9 Feb
 2022 17:06:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 17:06:42 +0000
Message-ID: <cd545202-d948-2ce5-dfae-362822766f90@fb.com>
Date:   Wed, 9 Feb 2022 09:06:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Felix Maurer <fmaurer@redhat.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:303:16d::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46dcd89-d278-4085-24dc-08d9ebee8b43
X-MS-TrafficTypeDiagnostic: BYAPR15MB3494:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB34946AF46503F81E88A9E0ADD32E9@BYAPR15MB3494.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDbCpsCeXDKE6OCp1p82BLg9EJi23WTLMPfWHadDKji30H73wxUxDuaS5nioZGwlgC7tNsO0meTenx3VwimUeDXKFJo9rUetmGjGRmJKLq1m5QSn6/pfz1CB4C2RsfAQLMFUZi7p1IrYKe1CasfYEkENCTDfb9GGmxhBcsj+Bqnf6R9VFndC0UwSCMw7L9s4nbAJnQjOUfvyKqBpNcQ2t7LkyNrgn3U0ttOrElol8GBjbMaf+zrSs7eLxWnGG38My+4BOpT3cp4ryGGjqm3RaOYD1kNR58wmarWsAN7lI/aw3M7YyATLEv9LCEA/5d7uQXvp9O1He9DlzX4JbcGPkd85iQa5T8kc5B8c/tZ0qQHJrcbWeJQJI6UtXt/e8INVbyENWrND53oO3+iwg1QT7CgCT//379pUJYA5xAAWrejHeVoOCvCk70sSQr29QZ2FrNsuVxAb+NAlK97FSKoh5lWADluMdqGwChFUm9HmBHQyEMTGhUpQAsYztchVNVr6fMvbkRtAfGzGbZ4ONuRGGCO3zILkB/SHjqRIVnkauF9KSomnT5ZLFbVzWW1FXbk9ZvW8w47Rhk+3TnvSMUZP18sE4hEplVVwaOxz087PUUnPq92hyJm1ADK21qCAxsSGwOGtFameL0LtjiCYtEfICyqrOwS7RjA2mKW0SMiVdj6Ld+NAyLj2segce5hkyN8IB2ph1zxOzO9Mc25U413/EjRLgONVi9KBw66m2PPt7H6SDZme7TTXXq+gqA27tL/k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31686004)(52116002)(6666004)(4326008)(53546011)(6506007)(508600001)(6512007)(2616005)(36756003)(38100700002)(31696002)(8676002)(66476007)(316002)(66556008)(86362001)(2906002)(186003)(6486002)(5660300002)(66946007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlmT1FoZTlyNGRQb0F4bEVaSVhiTlhDZHNCUFIxK09jREY5bkh5VWxGblpp?=
 =?utf-8?B?bTBQZzdNNG5xVm5BRXo3bGk5YUo1VVI1VVl2UHR6REkvU2hrVWlrdmpCS2VM?=
 =?utf-8?B?aEt1aytOWjhGNzFxZFlTOVk3U1g2MnFyVlU2RHFXV1NUelZObG5ZRzRBN0Z4?=
 =?utf-8?B?R1ZRNEE5bkFxNDVBVytWZnlycHdBM3dmRzJwVEh4ZG1ob1BlZHhMU2xseU1s?=
 =?utf-8?B?TG82VnhHV0d2Yld2Um52c1k5VEpJamV1MXZteFJqc0ZkbTNzQkxmYWl5dE96?=
 =?utf-8?B?YzVvSURQU2ZaZ3dlYUdNMEFJTFNtUlRSZnVIbWQ5OFdKNFNoOExBbldrN2hM?=
 =?utf-8?B?OUVsUFFrZnZ0NVRaMUJ4YjcrK1o3Y3hSdHRZdFI3Zm9GQzR2ZlpFSmtRQnRG?=
 =?utf-8?B?dDlGQVo5Y01pTXJCU0NVVlo3Q0R4clNsQ2lhcTFlSEwxSFV3T3BrU2c0QWQr?=
 =?utf-8?B?VHNRUVZLamJiUmE4cm9HQXJaNGhSdmRSVFlCbEFXelpPYi9MV0t6RE10V3R3?=
 =?utf-8?B?eGtwdmZod09XYllvalMzTld0L1lwbWZDUHlaY1dibDdvaUVIU0ZEWFIrN0JI?=
 =?utf-8?B?RjA3Y3QzTDRCUGlLc08xNTBLdWlMeStxVm9MRnNPanVsTVhzbEloU1FBSko0?=
 =?utf-8?B?U2tZTXl2M1hML1dkSFBJQ3ZHaVN6bWNNUTBUb0RMT05abjVJTmFWdDZmMnBE?=
 =?utf-8?B?TEFWa0RHRTMxM1FnV3hMUXNORnV6MTB4K1B4SWNEUUxZMjY1Uzl0QUFNY2dE?=
 =?utf-8?B?THhDT3ZGWWI5SWVZYmhDT1dXTlAzazJTd1EyV3JhK1pzMWYva3RpNG13NzY1?=
 =?utf-8?B?UmRPVjNZcE8vR1g0cllhc1lQajRGMGpPMWR1Y0pPYU1aNzB6NXV1TDMvRHRN?=
 =?utf-8?B?QWRwc2RkN1VNR3RwNkkzRFJhWm1udUF6Vkx6QXViR3hPampCTENKeFlXSS9r?=
 =?utf-8?B?d1B5Z1JxQlhDOVdPaDNxcEI1SWdMQm50djRtZ0FIVWRMMXlFV2xaT2o3bUtv?=
 =?utf-8?B?OXdZQ21SNlc0bWlISEpPc0hCRG85NWo3amtQL0FITnIzaWN1bWxIcXdlbWcy?=
 =?utf-8?B?cStNNU11MW9nL0tXc21oWXJOUE82T3IrTW4yYXl2Z1daWENselJnR1plSit1?=
 =?utf-8?B?SGxBYit5YUNmRXVOTUFqNnVNeFd3Zitmc2kyNzNvVnVGejR3TWVaN1FzNCtN?=
 =?utf-8?B?OEljdzZiUUtZQmRXYndJQTJpSDdWWDRnNFNaSlRMTks2N05xOUNoNTZJWkpH?=
 =?utf-8?B?WGs5VXVwSEFZeGlCTEJPNEFQQkFvVFNpNU9QZStmMXFzV1d4Z01nYU9UM05w?=
 =?utf-8?B?bUFOT053VGtxbEN2anc3eHZFSzBZTEFucTlJanpjSDdRZTVwV0taV01wb3VK?=
 =?utf-8?B?dmtSQ3BzdWVIM2lsN05oUXVjRWY4cHJSeEVnaWJKdTRVTTdLVm5XSk5rNmVU?=
 =?utf-8?B?ZklUY05tSVhweklKOWxRQm5jT3ppS0Q1ZW1IMEJSMWp4Z2hJOFhzTDhUVGhK?=
 =?utf-8?B?WEMxN2w4bmg4UDJoamMyT3hZOXU2YlVGR1FGYlB5SEtrODdCcUlLN0lkSzZW?=
 =?utf-8?B?UVUxbk9KZWVuU3VkM3Y2UGFsSnZnd2pJVmpLTDFtN0lKemlzKzNkZ1VWaWor?=
 =?utf-8?B?NEZpcTRNWVhFSk42WW9jTGxROElGWG4yQ3ZTTHZMUWgwZlZjR3VxZXpubVBB?=
 =?utf-8?B?T2x5U2cwRmtEcUlWZEk4UnJZdkI3VjIwd1RwK1hvRnBhVE56MEtIQnA0VkI2?=
 =?utf-8?B?ZlEvK3JPb3dDVGFoVDdVbmloZ1Y5UVJKLzA3emFweXVOUmlEQWVubTR6WVhT?=
 =?utf-8?B?aXl1TWgzS3JIeDI1Tnp3UmVYMVhCQjVXdkYvWk1VZ0s5eGZVRTJiNlU4UWla?=
 =?utf-8?B?Z0JLMUxtTElzUmdUUExKU2hDc0gzZEtsMVlXRENOL1FLcWNsQm8xWjY0YTVx?=
 =?utf-8?B?bU9hK3ExYmJ6ZUJlNUY0ZkxnRFJJVndVYm50Z1dheVNPR3NvcCsrd1VqQ3RH?=
 =?utf-8?B?dENIRTgyemRxdUR6VXd5T0w3Sm9GNWF0eTNVRFg1eXQ3dk9IeWt1dURNWjlM?=
 =?utf-8?B?b0FOSWRzU3NaMmZDRHlYNzJzUkF3WjExbTFieVEwempUSDFQYS9wY3RaaGVK?=
 =?utf-8?B?MzRFMkJkZGpLMkNNVnNSZXM4OExFNEpzTWlWUVJpZ2prVTBuK0J3Wkh6WTgx?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e46dcd89-d278-4085-24dc-08d9ebee8b43
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 17:06:42.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAXTydPJc1Bqh3tYYc4OKIvjX4x3+YUC7xz2ZsBMFLgrKRmbOquQE3TECETjghP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3494
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: j3cXKW4-1IoU1D2NnbeSqKtWMjpS3jaI
X-Proofpoint-ORIG-GUID: j3cXKW4-1IoU1D2NnbeSqKtWMjpS3jaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_09,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090094
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



On 2/9/22 7:55 AM, Felix Maurer wrote:
> If bpf_msg_push_data is called with len 0 (as it happens during
> selftests/bpf/test_sockmap), we do not need to do anything and can
> return early.
> 
> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
> error: we later called get_order(copy + len); if len was 0, copy + len
> was also often 0 and get_order returned some undefined value (at the
> moment 52). alloc_pages caught that and failed, but then
> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
> probably not out of memory and actually do not need any additional
> memory.
> 
> v2: Add bug description and Fixes tag
> 
> Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

LGTM. I am wondering why bpf CI didn't catch this problem. Did you
modified the test with length 0 in order to trigger that? If this
is the case, it would be great you can add such a test to the
test_sockmap.

Acked-by: Yonghong Song <yhs@fb.com>
