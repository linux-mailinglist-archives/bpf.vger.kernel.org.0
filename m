Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DB397BDE
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 23:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhFAVui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 17:50:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234656AbhFAVui (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Jun 2021 17:50:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151LjieQ031740;
        Tue, 1 Jun 2021 14:48:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=pO1ww6m772xZAjd1wTFasO6ZgKTSdRQo13LIPv57blk=;
 b=m9y9EV4ZlCH0da9n4PqpHFt80Udd9Ur1IeMh8/GNenjqdDlZlXUtHURCDbiXy1HF1rRz
 Hghbf0NbEQE4xwVFvWFb7dFmof0cRg+ob0d/oxLQqmYPBeOtiwvATHHTJNxexA75Bd9e
 3mL3/9L6yHQaSgWx/34fFUCAYV4i+d84RMw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38wk53v1rp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Jun 2021 14:48:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7pMt2/IFD6Tgz+tKpLuzGrwCdaNxh0Do5O/TvmfwIDgOb9m/ch5nxP2PWJuVQEJBdQdwm1b4KDQNTGv09c0K80jjED5lP9nGdKINdcV4badWzbZJZs9uJaCWFf5SwTZM+3ZYS3kYuH7DwJ+z8jm6H4joNdXJRUl3e2hMLbKsX8JsgAUa18ITzLwnhDgdpRuGtNyghyr24RkOlsYmSOd0YPx+vekDFH6HIuRlkjgEZFRrupcIjA/tEYRC4Akhhi0A07s0lTXRXKaGBE9DS3va4XHxRzVohEOlltcusAr4Yg3Ruc84yxyRUGUFkV55fSpwGTgCS3gdif7ZotYTYJBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO1ww6m772xZAjd1wTFasO6ZgKTSdRQo13LIPv57blk=;
 b=dTpODB3GQt1n5c3jEBcvGHjIihDmVMI09zHZoZQzD39r4Xe/3Z+nDH6+v5PUIAA4WBm7njbpxnGjhJ15kSsYReMnaAlA9AaOGp6TQNTzSCLsKcfFGMWvWTDw5/GiT7QtowTxOXMRN6eBEH9u6AFKsHGw8wd91nc54ukPCLRsLrsmCHnPuarDnFSlwlLDC1SvkBDaTwS6jvJacNkkCHD2V9bmzuuPrx8HgBCW/EHBXeh4ztAZgUBBIlOvGBkHORB/eSv2zMbJuVJr3u6zFC+hHH0mNrhK7qhx3lR45b77aBxONBlq1vPik34qVuSTPanVS0Gx8DljHQKdt23MAnlD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4176.namprd15.prod.outlook.com (2603:10b6:806:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 21:48:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 21:48:52 +0000
Subject: Re: using skip>0 with bpf_get_stack()
To:     Eugene Loh <eugene.loh@oracle.com>, <bpf@vger.kernel.org>
References: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c65ac449-ec54-3dff-5447-8a318001285b@fb.com>
Date:   Tue, 1 Jun 2021 14:48:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:46bc]
X-ClientProxiedBy: MWHPR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:301:14::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1499] (2620:10d:c090:400::5:46bc) by MWHPR1701CA0017.namprd17.prod.outlook.com (2603:10b6:301:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 21:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17d386b3-bc7a-4042-5543-08d925470bfa
X-MS-TrafficTypeDiagnostic: SN7PR15MB4176:
X-Microsoft-Antispam-PRVS: <SN7PR15MB417673D8273A533D147DE64CD33E9@SN7PR15MB4176.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5soSZKw6p6gKz52WsYnOyLymz7K0dzcntco2vMeTmepCep0aKRWzEEFMmHolfBwVdeuzk0sviRD3vNt13tURxr/Y88F7gLn44rd1ljs6jbqy+rqEsS6ZwrbDL0RSMu3y9UsQrLc8FQIfjC7E1cITO0qIHHJaICkFHreIRYMwZCdEBavVBVr+2F0UF/G2hNcm/6eTrve3nOb8VoU2hp+bINDIgCL99NCh4YZheNCWCh+CfSVab8Ykj5PPgnVRUYDSENsqZGesiJkTzPgbJogJws4o94PvVFtYeyttrJl0UnSApD9Thn04u9++ZWr4H8DYwGaaqhM6bpBVjMCRQsn+Z+p4fFyl6fhYnftwQ1U1H1Q4HLgnK3qt9kZYgRE8qLrJpjkPkJ4dbLMnTY/vXjSSMRQDNO/H6cE1T8stLxWOD3O8tvw4T+7rW/339/kW6WmFgy/tpwG4eCV19zCkbRdiqx+gYSHrFsyDEC5KRZZFVSJTHfjGljNUiR6fdTpCI5HJ/obfkAPUyxVuyho2m1WZtLJrTgz0dH+qAkZz8dto3NxL8ft5d4PVW1DZmeo3wDNHtEon/jkWw0i2Qpq2daDx0r7DHK2BGtKdODB6cUh+hsw25NFbOAZE6qpMS4yPK8sXqNuB9wAIT11LmLHWpZF24uTUKc/A596cO3D0if4xpk9QGRuAekSiYIEYfVkBgdsz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(83380400001)(86362001)(2616005)(53546011)(8676002)(2906002)(186003)(8936002)(478600001)(31696002)(38100700002)(66476007)(16526019)(66946007)(36756003)(66556008)(5660300002)(6486002)(31686004)(316002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SFVRTnNjWit2VGhSeXdrVExCcWxFaHZndGxFZHFLMThqaXZOdUxpclZQMEh0?=
 =?utf-8?B?NWU2ZTdsZ21iRVdNREVVUjF1aXNsUG41VTA2VHFtMGdNWDlvZDV6bHVHdE1k?=
 =?utf-8?B?Z0srYnprKzVyLyt5VDg0TVlzYnZVS09jZll3dkM5dXJGV0lpY1NOb1NlTC9O?=
 =?utf-8?B?TU1hbFRmNng5ZC9jWXArNmd2Nk84bStWMk0rUnhUMGg3dlBBWVUwYkl6RUpR?=
 =?utf-8?B?SzA3NFBnZGRvclRZbDJFeTYraWRYeUt5UjRteFBEeHdOVEtQMmNwYnpuR29U?=
 =?utf-8?B?dFpIM29QWkZuZ0tPY3RkRVl5QTdMajRLRjM5Mm1vZ1gvRVFYbE5PTUdwdExS?=
 =?utf-8?B?U2JDTUNGajhxOU1Mcit3Z0RkYjJ3V3FxK1hEZjl6MStvWFdwRTJYYnAwamJi?=
 =?utf-8?B?bmNHd1VGQjJxTURZS2tnOEZ0MVBxSXc4Y2lhMWFKU1lDb2NsczFSUVNiQldp?=
 =?utf-8?B?bkdIeDNkK2VRQWpwYmc0M3dNeWtmdXZaaGhYdkF3MlRoc3dGSnROWWRTVjYr?=
 =?utf-8?B?M3M5Y1hrY3h3Z0VhTjQvY3N0d2djbTF0Q05UWGg2b1lyZ0wzZTQyT2RzRHJV?=
 =?utf-8?B?elM4Uy8yaTBpU2hzekx1VUtZcHowVTZRVUZJSTFwamtrR1RXdkVlN2hWMUxr?=
 =?utf-8?B?WEJWcW9lT1Z5c1hvTS8xWEtxM205VkNydmlObG13VkNDWm5XeGZNdkdKWHV4?=
 =?utf-8?B?WWRqTlFYd3ZpTGNQMEpkR2xmZFE3SnpMYUdsRUJsV2drV2xVZnByVGpmM3Na?=
 =?utf-8?B?NGhWQU5CbmRQSWRUK1puUkNlcERkL3R6MDlESm56RU4vQnRZbUs5OGlZOFZy?=
 =?utf-8?B?V0NrWlJnMyt5QnlpTUFMUkQ5eGgzSi9INkhZTVlYbEQ2aXFhRCtvemhnMEFp?=
 =?utf-8?B?ZUJJZm1KZk1SblRzZ0pPUVRvTlMyWjZmK1Eyay8wU1lVa2lOZ0QwLzZCVzNv?=
 =?utf-8?B?RFFicCtFaitIQlZpWWtKT0VvKzZzeW40dk8vWVRJdlJMWlY2N1RhelFYQUUz?=
 =?utf-8?B?aStBeG9HekhVQ3VHK2JVTU1Ra0kwaE1ScXFOb005ZytOcG84Q0dlT1JSeDU3?=
 =?utf-8?B?K252VWJreWJaQ09MamJIQ0RoK0tyN2FxazhHZDUrb2pxVzBudllhVENlTzdx?=
 =?utf-8?B?UTNJV0VRWEJORXdNTjBtVzR2VGtOdEc1T1dpZ2hXdXJmMExOQTlvVUZxLzdz?=
 =?utf-8?B?dFdLeFk2eUdOaU51aDRVSE1qbkVjWXMrUjluZ0lkS2hWSWo1SDFBYUlJQTV0?=
 =?utf-8?B?Vm9nZ21sL3U0STRuQXpna01PVnlqcEoyUjR2Vk45b1ZuOTgvM3dNQ1NKRmJY?=
 =?utf-8?B?UzVrUWtlaWdQRVgwR1JLRFZmZWVIQmdlbmtGVlpnN1lsbU5LUTBCcmJwTDB5?=
 =?utf-8?B?ZjRISnF6OWdhdDZPVXlGVHprbUZ3WFhxeUxDbkRQQlByaGVaUnB0SnNCSVBG?=
 =?utf-8?B?OFEvWHBKUkxuMHhVMVN6eWNEd05tNDVQVk5aa1J5ZFk1YjJCQ2JsZ0owc2NI?=
 =?utf-8?B?cTZwVFNuN21Peng5NldIbG5od1JHZDlnRWFrVElDdjRxWTJMamVjZ1dTNTNy?=
 =?utf-8?B?Sk9wbDhYYlE4cVVSVC9OWkpCOG9TWjVyME5aSG9oNmVCQ0hST2N2OWdub3Ny?=
 =?utf-8?B?MGt3YW5IMnRuWXBGSFFXL2ZneEw4TDdmZHFIV01IQy81VG1LeXVKRjhXV3JL?=
 =?utf-8?B?Wm5qUzE1b29DbHVsc0pwZkFocmR5TUlNSDBNb0IwblFsSHNYK3pYOWEvVVpN?=
 =?utf-8?B?aC9NQXBtWmFzRnlFc3paV2dFaU5DMTAxK1B2QUlqclVCc1FZbDFsT0Y3WkZX?=
 =?utf-8?B?dlZmalUwWkFLR0hqNGhXQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d386b3-bc7a-4042-5543-08d925470bfa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 21:48:52.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6QYyFRALh5rDRkUjYwHJ6W0MQCt4UNYHrWdAA7z6qF12+A7GPG2E1RDN9FYYITH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4176
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: YobYyW6Vx-69Fq9uTxUcxfPR95rbnPK6
X-Proofpoint-ORIG-GUID: YobYyW6Vx-69Fq9uTxUcxfPR95rbnPK6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_12:2021-06-01,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/28/21 3:16 PM, Eugene Loh wrote:
> I have a question about bpf_get_stack().  I'm interested in the case
>          skip > 0
>          user_build_id == 0
>          num_elem < sysctl_perf_event_max_stack
> 
> The function sets
>          init_nr = sysctl_perf_event_max_stack - num_elem;
> which means that get_perf_callchain() will return "num_elem" stack 
> frames.  Then, since we skip "skip" frames, we'll fill the user buffer 
> with only "num_elem - skip" frames, the remaining frames being filled zero.
> 
> For example, let's say the call stack is
>          leaf <- caller <- foo1 <- foo2 <- foo3 <- foo4 <- foo5 <- foo6
> 
> Let's say I pass bpf_get_stack() a buffer with num_elem==4 and ask 
> skip==2.  I would expect to skip 2 frames then get 4 frames, getting back:
>          foo1  foo2  foo3  foo4
> 
> Instead, I get
>          foo1  foo2  0  0
> skipping 2 frames but also leaving frames zeroed out.

Thanks for reporting. I looked at codes and it does seem that we may
have a kernel bug when skip != 0. Basically as you described,
initially we collected num_elem stacks and later on we reduced by skip
so we got num_elem - skip as you calculated in the above.

> 
> I think the init_nr computation should be:
> 
> -       if (sysctl_perf_event_max_stack < num_elem)
> +       if (sysctl_perf_event_max_stack <= num_elem + skip)
>                  init_nr = 0;
>          else
> -               init_nr = sysctl_perf_event_max_stack - num_elem;
> +               init_nr = sysctl_perf_event_max_stack - num_elem - skip;

A rough check looks like this is one correct way to fix the issue.

> Incidentally, the return value of the function is presumably the size of 
> the returned data.  Would it make sense to say so in 
> include/uapi/linux/bpf.h?

The current documentation says:
  *      Return
  *              A non-negative value equal to or less than *size* on 
success,
  *              or a negative error in case of failure.

I think you can improve with more precise description such that
a non-negative value for the copied **buf** length.

Could you submit a patch for this? Thanks!

