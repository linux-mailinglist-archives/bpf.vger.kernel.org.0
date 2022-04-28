Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B39513CFE
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 23:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351927AbiD1VFs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiD1VFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:05:47 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1FBE9D9
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:02:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SJfjmc005931;
        Thu, 28 Apr 2022 14:02:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AhcxgMeaMyhOCsUlrjEuC1qe9VhOJ9QUuN+dfEMshu8=;
 b=X03SXQ2k5z+zbQJh82G1GNR+7RQv+OcpOIvUSPLdOs1VXi+7Hycme80Tfv0sgyrtzB/l
 lVBgHrFdoeXeYk8uLBx2tduXimnXEWxTFDRUlEFFzQq/0SSaOEMgdxACahIiWIlkWc2+
 p//hzHik8jNis028UisRr/Zi4D/W5D5IM4Q= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqvxxtyjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 14:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAAnViaa1LLTTYrxw9uhFUV+yaiIuwEcRVGeu68dRVaWliSefpmea2Jnqvbc2JctjquB/xqtCXceo7IX/wICu2NbSJhDAtsYpySQ/KyXNCMaEBuHheDYLoO9+PQRiBFixz9N9p9jnzXN1BrgmQ6LIY/TXCzSTuAif6aFizqx1AJjuPFvkLE5Zl1HCBAs5IHjNG+Qxfcg2SIHhxoyixDMyR77Ojs24fZJEQKCPL6VGRrLJuSks9NHDvr0CsrPfa/S4FRgVopZlH24Nvig7EWC5JfE55GDKejQuQg98KdiUOLiVy9OsgP+5mHGxNjslXiYAt9N9oUgFFu9LK9/exAGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhcxgMeaMyhOCsUlrjEuC1qe9VhOJ9QUuN+dfEMshu8=;
 b=UyIhwUUMuv435PTL3azdcN/ep53zZuuKeJ0G0DmEcEbQwJ826ELC6Auk6HaPVMbza7wyAtZj2BENxe1mVbQFdCu1ow0zt4Sab9QEwPhjkY+ophXbflYzA7Ww5yN47O/xnFoOfbfRm7c2sIAGZwxl4xkxHcHYluy77lW2XBecozjlRodE03WJoskn3LBhr9yszrspTc9ISgO68mhxHXRqWoj/WY0vVJng1maehF5QkiErQZXldcnUIpECdXeL6+54qt0W3NydyQlM8AvSrhkB9e/FObKskH4+M87RB4XExN8zdVsYipCrpuf6IJNzPQSCM5arSrhErkpzK+mCUgYWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4760.namprd15.prod.outlook.com (2603:10b6:a03:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 21:02:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 21:02:14 +0000
Message-ID: <346052c5-b8ea-8b2c-5e89-522a7f5c4059@fb.com>
Date:   Thu, 28 Apr 2022 14:02:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_link iterator
Content-Language: en-US
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20220422182254.13693-1-9erthalion6@gmail.com>
 <20220422182254.13693-2-9erthalion6@gmail.com>
 <5b2afbe0-12ff-f975-59b3-89dd5bb3e35e@fb.com>
 <CA+q6zcXkSBrmnUt3jS+zggqJjUFJQ2J_qUmA4HXtcFmYzYppMg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CA+q6zcXkSBrmnUt3jS+zggqJjUFJQ2J_qUmA4HXtcFmYzYppMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:a03:80::45) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a98cb361-de89-4638-ceb6-08da295a5eed
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4760:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB476044FD6DF2998703A442BCD3FD9@SJ0PR15MB4760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sam0e7yowkS0raPhAG11QrbdActpvbS3dj8VF276n+1zDnAN7l6ZVnv5Gt6ujoaRQNHJem5KbiW+fd1gHlQZg/LsCN31QjBERDjY7zIQtw3g8EioNzViETozb9eviRdVRmi7l1uB+T9Yr/Fi2GE25VPy+OiQWANoIvQ6bA6+Lx3VvEsY6IXhMEyOowL/PpKgYHr13QVW1rIPMmYUALXfy/GMSInILsUtnOa499xWQKOviKpGLXgTsqOUhnYNNLC/CYebYahpd8vf4aSzHtFIjeXUshDp8Vi5ewtqa4hZLsavO/VA4q/OfQ/JDobTmlb1Xrv+EtpCRdBVYBp1IcKeZqr6rOIXaAITyauWK/htzmySznI31Ev0pUAXIWdSdAWNeXr7ZiLPvleQMQDgZXb+yeIeP76GbfVasjkQE7KjzdTcy80ZNI9/q1lO3hwtwNRdtvFy0jGRWuIgqio3aPwZec/1M8atthXSG+SJQiQmnboa+FvYCu6WuyxRNoZLTqAIPHCtkSV/EM2pOSOpXvoaaR7BBi39vaXba7O1YNCkJCCTeDCSgff5pLlkwrM3tOxxBQ0Lh6f9Y58Hyv9xMcLukqpgpGaZhQCVsdI8hb02eLeOLYbnSEA27x1aLfFrZOGQc8z1+dNwT6c/gaSiH2WzAEsn180zKLzvcdLDlSU4IQoyAez+4xTu89j+DiCgEIdY4d5VEOvI9m0BTtdAf+HScZvE7TgxafcHbjqyh4sjnHrXYA45Q6bIAyuaJhWWny86
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(2906002)(66556008)(5660300002)(36756003)(52116002)(4744005)(186003)(66476007)(316002)(8676002)(4326008)(6916009)(8936002)(31686004)(54906003)(2616005)(86362001)(6486002)(31696002)(508600001)(38100700002)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZsREN2eEJhLy9pU3o3cC90NnU4b1pmUnhxMEsrUU5MbXlpR3dCaVc0WURu?=
 =?utf-8?B?ajN3ZFhtQXVBNmdzTDNiTHYzWDgwd1ZxYS9UOERybHFFYXFhUk9GdEh1bXZi?=
 =?utf-8?B?Q1ZiY2RUSEt2c0tzNHpHMzN1OG82THpqTlhGWWRBR2NkUjh0d2YxekE3dWpa?=
 =?utf-8?B?QnMyUmIyWERsWWxZYzQ1dmszVFppSitXWGFVV091SU1rYXhHVHZkZCt5cDQ5?=
 =?utf-8?B?bWFPUWdaUmJ6WE53MEx4azlTUXVmTW5OTFdPcUYwOURUTDdXR0tNWFpNYm9S?=
 =?utf-8?B?SGt5MjlsZHlwck54YUNEd3ZZb0JhZmgxbURzNzVJVmlkNDVBVFRTY09LSVZm?=
 =?utf-8?B?bXUzREdUKzg3RW1zaG5tbXI4YklnMzJiekRBZFBmQ3U2bGZ2L3Z2YmFxbXJJ?=
 =?utf-8?B?Q1BueS8xcWcwSktBaUpwaWhsaXhRUWZKblc4ZFF6bW9BWlM1a3duNmlGWEZI?=
 =?utf-8?B?bEgxS0RJcGJkUlEvNXIxL1VJU2paWjAxSnVTSENQK3FncXBUcjErWXBuM1VG?=
 =?utf-8?B?b3ZaVkJYZEM2ZGU4UGNqZTdvNUczQ2JDUU9lSmZMWEpkOVp0ZDRjUktMcm93?=
 =?utf-8?B?N0dBckdHbEwrREhwNjF5SlhXZzJKRmduUGQwamhMWG5UQTFvNVJsOTdCdFFP?=
 =?utf-8?B?cEZhNWpxYUhSZHVyTXI5bjlBcWNzaUcvYkJkWVVVMWpWcldjUldQWWlGeFlE?=
 =?utf-8?B?TUhZV3UvNkR4UkxYQVZmTzl3c0RSYmUxcVBRc1lCSDd5MkcrdWh6MUYvVWJT?=
 =?utf-8?B?SjQyWHdpVmhSYjBtU1hjaFNRbDNmSTMvdXRSOFVZTENIdGtIZHF0bDdld3Vy?=
 =?utf-8?B?TkJZRkh1L2N0bTJIQURGWWhITmhVM3MweTJYMVBXem1lYUlXYmphekQ3VG5K?=
 =?utf-8?B?NytWSEZNdHptWnpManlobTczSVZxNlg2aWptUXhmSTJ1VXJ5M2ltMkNkVkpL?=
 =?utf-8?B?eXR4MDM1L2ZWeDZwS0xFVTZ5cVl1dC80cS9RZ2M3NTZ3b3VSazlwNHArUDNB?=
 =?utf-8?B?cVZWa3puWlJlUUliVERVOHdnMEpxNXFjdEVvZENOd3g1MzBnWUZxRVBoMUpn?=
 =?utf-8?B?ZE9GdnhYNHIxSjNwdWFWR01rcll3bUZ2SEloVVNQM2VTSVc4NC9MV3hkT0pQ?=
 =?utf-8?B?WEZteTEyc0VpdTloMEVqRUVzWmNUVitrUVh1dXIwR0ZTalc2MUY4SisrZGFz?=
 =?utf-8?B?SHdpVTdvUCtkVHROUTZmSExRRnE5M2k4bmQyaS9md3JBRUcwTUVYbjNienZ0?=
 =?utf-8?B?VCtmNVNWYi9VWjI2UDFDQXlSTjlZaFVocklya1FsM0hxRjVpRXRzcmpqYXQv?=
 =?utf-8?B?NjBPQWltN3Fzcm1BUVZuYisvekVnOEVrUmxMVEV6WFZGVDg4Sm91RUdDN1Uw?=
 =?utf-8?B?TDVDY1JFOXg5KzErMlAzV1ZQSm9yQWRGNGVPbGIyZ0NVaUFlOHd6L2QrcC9K?=
 =?utf-8?B?TDVESk1ubklobkUwdXYxcDZjZ0sxODNTRVBOUC9DSVFiWmFSVzc3c2tqcVVw?=
 =?utf-8?B?dTB2OE9paTNDQW1nUVkyTk5hNGpudUhHZ0Y0aWNxTlVHL0kzak1TY0xWVU5n?=
 =?utf-8?B?OGRxbzNydDVMMEdQclE0Rkc0RTNiQWh1RWZ0ei9hR1RrZEduSE9QRFdyU0t2?=
 =?utf-8?B?andReHFpdFZrL3Bkd2JWZkJzRVpRZmk5Uk1SSGtWRTFtTzkyNWVmTnJmNGha?=
 =?utf-8?B?M2JLb1ptT0RxRUYrY0d1WG9jRlZmZkxqTGswYVhheEJXc01ZSGRvZ2N3NkEv?=
 =?utf-8?B?bjl0aUhmak9vR2dDZkg5R2NkT1FTUEd6S3dEcW5JdW9UOTZUS3dCVlMzRjhD?=
 =?utf-8?B?YzBQdXNMYnVGZDg4blVpdmkxbzBMRTROekNRckVaUDd5U0hYMCtKSS9taUtv?=
 =?utf-8?B?TVpJZC9SS1lodXNWYjUyMHpvZ0ljVEtqdVZCQ2ZBZnVYRW9TSHMyQytaNVRo?=
 =?utf-8?B?UUFIbHZjRW13Ymk1ZmFhM1E0SnA5c3BjVk9PcWlsUGpYMzJ4VDQwVllQMm9X?=
 =?utf-8?B?QWFxazdlVGw4TUhPS2xRaEtZOTFhZG5PS1laZTR2YjJJNlVyOHBPYUE0RDRx?=
 =?utf-8?B?NWR0NFJtZk9oYTB3SlM0NlFSb0lkeTNMa3VnWEVMYVFIVG5EenFkaXhWWE5T?=
 =?utf-8?B?M1NCd0xTZnZyQ3VLL1ovcmtCNjlTSzRpR3F5Q1FLWjZldlAyUTNrY2k2TlY2?=
 =?utf-8?B?RUdkSnR3bHhxMFZaNG5nREx3L1RLODFQQW1XR3pRaTJYdmw1alR3U1diUEZv?=
 =?utf-8?B?QWJUVkU5dFRJTVhiOWNKVnVkMTlFb1BEQVVtN0Z2L0ozbEtjSGJQWUkveE5H?=
 =?utf-8?B?UGNRS0dsQ2VtZUtZeWV0VXZEbktPN0o4Ykg3R25qMzc5V1ZOVW1KTzFHQXRr?=
 =?utf-8?Q?FhSoP90LqoCaNIRY=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98cb361-de89-4638-ceb6-08da295a5eed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:02:14.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC3vSdH279T71LiQbbhiBLlWaYR1m9MczgV8qVWKXEpPvAv3suVyOafegaRU7Q50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4760
X-Proofpoint-GUID: BTIEeTnN71gBmK-KNuUrL8kTcpLwjF0B
X-Proofpoint-ORIG-GUID: BTIEeTnN71gBmK-KNuUrL8kTcpLwjF0B
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_04,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/28/22 10:07 AM, Dmitry Dolgov wrote:
> On Thu, Apr 28, 2022, 6:14 PM Yonghong Song <yhs@fb.com 
> <mailto:yhs@fb.com>> wrote:
> 
>  >> diff --git a/kernel/bpf/link_iter.c b/kernel/bpf/link_iter.c
>  >> new file mode 100644
>  >> index 000000000000..fde41d09f26b
>  >> --- /dev/null
>  >> +++ b/kernel/bpf/link_iter.c
>  >> @@ -0,0 +1,107 @@
>  >> +// SPDX-License-Identifier: GPL-2.0-only
>  >> +/* Copyright (c) 2020 Facebook */
> 
>  > Change to your own copyright.
> 
> Thanks for reviewing. I have to admit I'm not sure how should it look 
> like, is there anything like a guideline/best practices about what to 
> put into the copyright line?

You can do
   /* Copyright (c) 2022 <Your Company Name> */
or
   /* Copyright (c) 2022 <Your Name> */
