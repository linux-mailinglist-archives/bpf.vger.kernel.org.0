Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97424D83F
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgHUPPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 11:15:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbgHUPOv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Aug 2020 11:14:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07LFCiUY019743;
        Fri, 21 Aug 2020 08:14:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o9mr+NBO0r2gfQvdDRv9JZu3wfZYPzvy7LpnAUbMve0=;
 b=AmbSHvafksUyt7xnDVeaxqrZeBcHuHK+JNNSrk+7cedW1Mh+jmRFKBOznAs9WupWL3UP
 evaJxG6vE2A0hC3yfStcoxzRK4QAxdGSfFZcsPVuVidNtZ3JTa0Mvj902SbCheV/PjjC
 OlASTf5aStjcmCYFxNSkzROFp8vmkz9Tuk4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3304jjn387-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Aug 2020 08:14:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 08:14:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=extgaMGtVlCgzwkpGF7junM1QqJ6e/fxXVtvPWzd4Badtl2MzatyHgWG3Tve/BIZJRk4iqyoUwVx0Kyaavaqc0+lH0HzL1CtSEkGwn1pAruLqtjgny9rnddNaaRCSFO33Sh2Oks+y2/RwdpsxDHSH++ht+JMCkiFFxtK9N6Rs5vTDMZnkm+0m2OPJcnVxBLSPUxU/IXIkvwg7uKCDEFN6/r46y355jAwRko+ryiU9uT7zlC7GezUzYFukFYwpcNLS74KsmHHs02wf9SI4q4G/nCICOcpKs2bDN+pT94zdVpwLeKANQDktpv7/DVRQllciBGyAbZRpon9DiMpM1w3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9mr+NBO0r2gfQvdDRv9JZu3wfZYPzvy7LpnAUbMve0=;
 b=nPWNIP7x0Fc+NI0/L9JyNH0+G0QwYjp9VfXYsz4eVm9mc3HXd6XDaOHq0czh59HoVOziQTnUAQOlGOQcCkE55uwmHkgPEslAxjuct0PhXWkzn+VeIKDDIhTCfe2lqekWKosKTcl4LQC8Wseuw00/9rMjCRYa3e0v5WxyQ4nbW9D+6jjeeqycqhaBIfOxGnS0p6AuRAoYPmkLFu435a3z6Ce6f+pG0ab5S4FW1sEgwUgZSLwBx6t/i875nUIDWNfR4FNFzvAqxxE0xrDGW2A5Vx1neVYcofuYMfC8YzgpHa0oAg0Svckx+9rMlI/vFU6bYiTeD9nj9XwZu8wvNcu5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9mr+NBO0r2gfQvdDRv9JZu3wfZYPzvy7LpnAUbMve0=;
 b=LPDuwBJ39JKJMQlFI9K7IV/W3c+3WyMr3X3Ryd2mLVBrfw+kqTrNTani1CSWDDiWqxqYuwXEWq7Kr3GMnjUPp1p5gpmSztU2MxxkagcsLQbLwSb38Njgp/3r3pXcBeDNRnTgl4IjyPFzkKYZMGbNh72OxMlt5Cth3U2bR2BZZxU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 15:14:21 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 15:14:21 +0000
Subject: Re: [PATCH bpf-next 3/5] libbpf: Add BPF_PROG_BIND_MAP syscall and
 use it on .metadata section
To:     YiFei Zhu <zhuyifei@google.com>
CC:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
 <e4d7e9a8-19ac-b107-0f5d-8f9322ff9d21@fb.com>
 <CAA-VZPm_4q=nkx2PaawtdpesqJSMQdziNwV5=t3zgW8WM6Q9kw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <98fe7ba3-a15b-7414-39f2-8a2243132726@fb.com>
Date:   Fri, 21 Aug 2020 08:14:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <CAA-VZPm_4q=nkx2PaawtdpesqJSMQdziNwV5=t3zgW8WM6Q9kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:208:239::22) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 15:14:18 +0000
X-Originating-IP: [2620:10d:c091:480::1:8c09]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1128080f-815a-4610-13f7-08d845e4e137
X-MS-TrafficTypeDiagnostic: BYAPR15MB4088:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4088ED756A6ACD7669D2FA15D35B0@BYAPR15MB4088.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9DoaISRFfezDi+fpOI6eY8haXUL+K6mhTa54GWEmIebAh3G852WU+EFieEne4CQxoN+BTorej1oK4uELHd3K9Ebg3tMFR8l7lPCX4lRzF5LCFnqqp/JLe2ClTN4hCgeOoVWxD7c/M8YKboQbMbDSD9ddBh+aAK8f4a7Hf1p5kNEjQ+CztlYP3/tpYyJnjzpfz7clnGcUYnJsII+caO7vW3gSYbFPjM+5fUCzzF88nd1es7Kx8khQSdUmFPRV/eKeOJqFquASSC0AQeKD82R19B3xnvL2oyqyCuaLiHVNuEQst/2SabLp962GuvnSfqLv5Sb7SyLj25X2fsVPIAikAeLut4M3EL2BPQjTOOIKcRPgTXJA9Hxu8wMmY834ctUfINuxaVsjfjJgg2cJzc2QdvKnRq3XurvKj2sFhPctT18Iw6sL5UjzmSczB71aO9w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(136003)(396003)(54906003)(52116002)(66476007)(6666004)(316002)(8936002)(66556008)(66946007)(5660300002)(53546011)(31696002)(83380400001)(186003)(478600001)(16576012)(956004)(110011004)(2616005)(4744005)(36756003)(8676002)(86362001)(4326008)(6916009)(2906002)(6486002)(31686004)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OOGjeNJUfvgPUQXaTWmKTi/irRrgj+AM3UyJ2rhZjG/NgnoBhMW/J9bmnTvIcUz5QHCZ2J+MGRwytmgwFQPRGm4pWB7/mQVHp9Pfh/Tq0+Br6UePN4NFJrzgA2YslVYdWtKl9ZQqpQEIyUHxvdw8U+tSBnFFv9v1KaRsAYS/fiyHK38cmPsdFKgMCL0KYyyu7Jj4AXtGbNoXumJSZxWw5/S4Zs/5x+EorBrXP0349A/smEx24etZbJm125u8H0NnUXWFDELv7QQI4mqoQ2lASMBLKO4SOkBxHnPz9GH4P8JW1+M5bY8jIemVkgZE0VnVixlayZT7052WVCDIigZm79XsgDSBuyqtrDPZpFaPdlbCszEYD7c2zbpYnFZJXFUgGMWTD+1nDsxLg8A0QWLNqJFmlAI0dG1yNdXgwwMFWTZYGRbZX6JxEByvKBmjmlgMeXRvvmFVdc8+h0PHMftK5vdemWyiImvcpAmsldBvItJStOICzdOg38wk9HNOKXNXoxmGYfOV+sy3ZZFRPg6NyEHPu75YLujnCXL+pcnnwVxslg6n5erEGFSwCc+jyLZ0DrQqakHEv0PnHaxS20HlnAfpBMfLTTsmAeQT0Q3fdW4k8tyZ07MgBpzbPZ8+Cbu61z4+aQzh5sogHl6otFg72cXJ7BxigMIznLRoe6k5Wa2C70lJnc8EVL7qvrQx4LeI
X-MS-Exchange-CrossTenant-Network-Message-Id: 1128080f-815a-4610-13f7-08d845e4e137
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 15:14:20.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsHzz0BNzRQany4HxLqghgohodcD/dSHwA2l6ivR/JAGmlmozpySLLPn7u3zCNGe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=734 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/21/20 12:52 AM, YiFei Zhu wrote:
> On Thu, Aug 20, 2020 at 3:38 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>> +                             int fd = ret;
>>> +
>>> +                             ret = -errno;
>>
>> libbpf_strerror_r understands positive and negative errno, so no need
>> "ret = -errno".
> 
> I don't understand this one. The use of ret = -errno here is that when
> we goto out later we return a -errno. If this line is removed then fd
> is returned after fd is closed, in the case of a bind map failure,
> without writing to *pfd. Am I misunderstanding something?

Aha, sorry. My bad. I missed that 'ret' is used later for the negative 
code return value. Yes, your code looks fine.

> 
> YiFei Zhu
> 
