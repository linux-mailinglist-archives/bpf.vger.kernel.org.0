Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4335324A8D
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 07:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhBYGaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 01:30:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232746AbhBYGaS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 01:30:18 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P6NxMa018966;
        Wed, 24 Feb 2021 22:29:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZggouhKHh5HbvjaxRNVG1SSqD3jhqi307ZSXEyrDc8w=;
 b=aeawy1NYY+oVUSO81LXu1cb5ucja3UEdb4B2Qo91xvuyRgGQrkk266yuAug0aEojeQfr
 3k8nGJxGIo47P26C9JCRchqohw4lcIfTgl6A9Us4KBABjmKOAV3/poZD76xooDzywJ/c
 qZ2Ai53/ok3u5c9TFjbFen3EpZ1TjwsUs3E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7avng3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 22:29:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 22:29:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnAxqEh8kJ9oBqE355lR2kyI9RjjQMZxQrJ41JmezH7FRt87ZNHoTKk86H96Giyi5Glkf8du+L1zJ2ALTSfG4zXHdPfFLs0Cnc9B1ViENwk33htAXpgz+JH6p3WQ1rpGNJuBSEfaUb8KVYJw6aAosvT9ggtNYhgB2Sms/I6hTDpJZR25W1TMt57W1NoTqanWjGQjxmFbvRLJ6uIlvv9jm/ZkB6JDB/n6/MxQWI3g9FzZflwfD/1PO8hsUpHPb9qNdnByic2WF68v8vUyx0uZDmVe0ARPuwzC68LTHzWMnscdRtvB4oXRzjXmOOJNwDyrCb680tBD1Gd3oIZCRWWslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZggouhKHh5HbvjaxRNVG1SSqD3jhqi307ZSXEyrDc8w=;
 b=XILLZUwPAFDp6tsm9L+37FjlDVN1SoI0lbQlHMd2xEdHCInkKK2EkxKs1XNmI753N++O6TZkIs3QRjr0WfIAV+o00D5mME8Y3HLub/7nR+ozpCDfE+zWeMER2AXE0FSa6mHhlP7BwxArDO5t+u0owL8oJ9itLpV7PJqe0c2irLEEG21swcmDTTxHMa0W2jI2uVWEsqdynnvC4i8h6wKepEhulLfaoYnryN0xrE/Jr8GcKk6PjiIVWd/lpDs9Zr6dPrWT0YnDKV24TOhR4k+n0mTn7E+wBbw2NC80RrOWQtPXdaJ0F++82vUFkTow0yVjYYDtKmhLm8TVxAo+UC1KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4657.namprd15.prod.outlook.com (2603:10b6:806:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 25 Feb
 2021 06:29:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 06:29:16 +0000
Subject: Re: [PATCH v6 bpf-next 4/9] tools/bpftool: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-5-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4f3bca10-1c65-10ac-ca37-89ae26d10ff3@fb.com>
Date:   Wed, 24 Feb 2021 22:29:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210224234535.106970-5-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:78a9]
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:78a9) by BL0PR1501CA0021.namprd15.prod.outlook.com (2603:10b6:207:17::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 06:29:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d84b9b3-0332-4151-1161-08d8d956acf7
X-MS-TrafficTypeDiagnostic: SA1PR15MB4657:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4657F3C2A0B8B2C5640F3A40D39E9@SA1PR15MB4657.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xth/UzLbddKPEe8laBydXl4VvXkmQoVXGoQVECaXtYex9vdtqTXuq1fc52D6AMujAKtBtWdV2pxbS5ZKN9k2zMupLQ1kz4TpjEMU7jOyJR+Gi/gWpA4/mdixjrhf5s8QnZm14E/H67Dx6VFquZnAgNbuOZ9OkzUg3gyaTCZqaiAWpBpFc4r6HW98CiaY1Wj8wFmGTnBLffa/Eub/GvvbwuP579YRlcSvgAQJXk1kiiqyC4vIeicHBEzC+zDoy2p6uXywTpb9p8msRoraDH1EI7q9dtVny7tOLB2Nw23qxdoUEhyqvl51bHP1kQhpceLw5V0cu8wSTQWmif8r1qlKj6jBS1GyBN1MNLIgb5ZtqtabRUu8RI1XNjRWZ7XE1XN6IiQ7xwU9/M01jpyxzGUvfZx4YD/aAvVduZ+s5RCs7IqseF7jVJzqaaZH5N/U+tawP8Vn9AeWuBKJF1UyZa3rwBjWr+aJsa16tviVX0lzbrkS/IbMu7GV6RKFlozapU3BeJPZJGGvdYd1WbA34MwyIBzCM6jHiYLFzzYcUydiGUfaC809eB54Ef1viwZmIe3GENZrKtG3iIyJnAN4J9iuH8uo2sLrQJ6ZRrePWOuLzrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(376002)(366004)(54906003)(8936002)(4744005)(2616005)(316002)(31686004)(52116002)(4326008)(2906002)(5660300002)(6666004)(53546011)(110136005)(186003)(66476007)(86362001)(6486002)(8676002)(31696002)(66556008)(478600001)(66946007)(36756003)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TW43N1g5K29wdlpzL0l2dVNoQXhRM29FWlArYVFPWHAxVmxMZGs3N0NIOCtp?=
 =?utf-8?B?ZDUrd2JhSmliZTMrcUROeWVHbVR0REhqaElkeGNkWmxyMGQ3N25GK1hYQ2Fx?=
 =?utf-8?B?ckpsWHlJYm5kc1BybkJ5ZzN0UE1LVXkzTUZnMWo0NWNzSCtPZ1hETkt0UXg3?=
 =?utf-8?B?S1I1cnRYUUhPbWFIcUtxdjUzRXd5VWNYZXdOWTlsRmZZQmswWmNvY3czdFVl?=
 =?utf-8?B?bVBoODVjemVhV2t3ZXFPa3Fkcy8zQVcxV0xwSHkrcjhsQVU0b293VjhzQ0ZO?=
 =?utf-8?B?U3R3MlFEZEdKUkxTVG16VW02NlAzUWZmQWlrSjFxR1UrYUxJeWh1azNhNjE2?=
 =?utf-8?B?alhDMTA0MHdhVlBHbUV5WUZxY3luZy94OUxuN2hybFh2ZlNnTEpuQU9SR1do?=
 =?utf-8?B?d1hIak1wRjNYSko4dDBhMHQ2bm8vYVp1MG14MGo3RkZqZVhtb1JEK3c4bk1i?=
 =?utf-8?B?QVJMa21tWXU3aU9nTWFoSVpFVytDUC82QXE2WnZSVCt3K1M5MXBrR0NDWE0z?=
 =?utf-8?B?TWt0TUt3d2xuWGx5SEFsTzVsTHBKaFNUb29WeUlsbkswREdGL1VqbEhQbWZl?=
 =?utf-8?B?c1FBYjZibFlnbVE3cEtvYU5BNkdXemdrNnZUQk1TYk9naDFMRmRUVEU5UE9Y?=
 =?utf-8?B?M3R3d0wvWjRJMlJnajY4dGY5WnJZRUwrcTRKSWVBeHQycVVoVEl3L1U2YUFs?=
 =?utf-8?B?ekc0V0pYeFlqU09MNTlTekZxN0RnWWNQb3RMSFpSMjA4NHR0RFdmS01ISzl3?=
 =?utf-8?B?R1BudnVxQ2dkYytGSHhJaEZ0VzUrU1huUWFERE5LY0tTMEt5cCs0L2hpd2Ux?=
 =?utf-8?B?YVlEMnlPMXkwODZZbjRNcGxKNEFKcGRjS2xnOWUxTEpWd3Ezc0ZRbWZYa1JR?=
 =?utf-8?B?cFI1YnFlblhOT0hOVGJwWWgxK2dtODc4cktkL3l3TjgrSnNsSFZBemRzc2Na?=
 =?utf-8?B?emxscXZVTmVuaXJxMFhJRFRNYng1ZkVyVlVLM0hUVHBFWHRVU3FFYVA3ZVhv?=
 =?utf-8?B?YkdqUEVGd2EvbmIzUXh6bVJETUlGWCtjbGdydHEwSi9kQmxXR1d1WkNWNEpk?=
 =?utf-8?B?Wm1DRm5VaGlBMVMwZ2xFbEhKL3IwdHZqTnlGTGNoNEZsQUtxOGE1RXdwbHlD?=
 =?utf-8?B?ZGxzZm9OeWxjUEF5Wk9CTFdoOUFqbjFLSWJPamtMNUttS0VNbjRubElGakty?=
 =?utf-8?B?OWFRS0pySmRBYVlLbVRTdDFBOVltTDMwNjF0blhVQU9qZ0NKSmx2TWYzYWRy?=
 =?utf-8?B?VkFPTGtvb1d4YzQ5RW12STVMcklUdGlpTU9yUFJTcVRQZTZJUHM4MCtUeGVL?=
 =?utf-8?B?NDdscURYSHNCOW1weVVxelZwV3dTM2thTmx6VGlVWUpoRytncFlXVDVKOGha?=
 =?utf-8?B?VVFQTFpNK0tQVVFHMy9GbFR0NFlGRmFBS1ZIamkwblViSzBDb3MrZkdlaWF3?=
 =?utf-8?B?M0hUNjFFOUNyemQrRE5WbGlnRUg3VmxscW9LN3pwd0lzVkV0Q2VWZWdkaFND?=
 =?utf-8?B?ZjNLWk5TT2ttTmtzZVhkRXVXdkVSNnZDa3hCN1J4NEFMaXhoTmdiOGNhN0ly?=
 =?utf-8?B?N0FIUlp3WHBYL3VZcFhFNjZucytvRzU0UjdpOWdRRk1jdjdsUnNoR0RqZFBX?=
 =?utf-8?B?aThEYTJKSlp0bEdLamQ3ZE05YnpPMldxUzRMeVExYWZZZURqczFySDZIamE0?=
 =?utf-8?B?dnArdVF2eTVrSXV2c2dINkt3UWQvcS8ya29kQVpWRzNBSXJscU9qelh4cEtB?=
 =?utf-8?B?UWVETW0xWnlueUl3eElYWXBKaVFET3VRZVdKQVlYNEdwaU45MEJuZ0Y3Tnpw?=
 =?utf-8?B?WXY5MFVPcDI4d1h1QVZpZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d84b9b3-0332-4151-1161-08d8d956acf7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 06:29:16.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+/4Sm3kLxv4qINIF8PD3jza1p+t2naw+2kzh0lxwJPgAK7ngEuCy6HmUSIc0B3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4657
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250055
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/24/21 3:45 PM, Ilya Leoshkevich wrote:
> Only dumping support needs to be adjusted, the code structure follows
> that of BTF_KIND_INT. Example plain and JSON outputs:
> 
>      [4] FLOAT 'float' size=4
>      {"id":4,"kind":"FLOAT","name":"float","size":4}
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
