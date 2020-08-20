Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD524C724
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 23:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHTVYA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 17:24:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49544 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbgHTVX5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 17:23:57 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KLDmNs006770;
        Thu, 20 Aug 2020 14:23:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=02iki5hoIQ/fJFdjO+bwD9StKmU3Mq9+IgOEiR3gnZk=;
 b=LqdNDo05/5gedCKtSXIYjLt8ER5XmVXNBEgwucSjYtpWwAHN81GIkTN6NQon2aIT9wZW
 RPc0m5IbNm+IUTWE7tI6ldwxWjZa99HfyMePArl3JdF2MDXSfRFXjzq2QccaJQW6to1j
 R+bHMG2F7pIs10NDie7t6c/RHh9lJ/HCFqo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304m38xu3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Aug 2020 14:23:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 20 Aug 2020 14:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXfiENb0030h11t9iKwNTfl82YJKeGM05gxTeXjfaaufR49NhIXHT9hTGkEvkHlkH/T5B35wFHYgeb3gpgc64hIAq9kHDtC08SfWzbKb2UDkz+SmHovhLoqZTBLBAvRos8T/VDvRP+oMC2Hkt73B3ddOWDC+khqbmC8WIyf4eVfZ4nMGaGV5Lb+8zumWJNPoaZZeTUe8RBM0TskMYt9j+fRSGieMBPorJdFq7wc5QCyZMZc6v/NGuqHvq9deSvBfAsxrsEgwE8T9Dt1HPTT2DmM8rN6TMsJaKvCwqPQlinfxnubdcU8iDFWQuDMgM913NRENaMZAo6fa8brQvoQZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iki5hoIQ/fJFdjO+bwD9StKmU3Mq9+IgOEiR3gnZk=;
 b=jFCUUhH4A2XxC95t/AOjE57ex/KPMW9xzeCksoCMmlLnB2LFo3Cz5iZQu8gXaSmTWo6pe7dfor1zE1ORpu8UcK0nLgboRJZmU8nQbuYNCltPMtukgOgdyQpbbfZUwxUemkNRnmgt3yBeZEoHBqzYSTFl7ZMA7bfWllaN/xB4X19iGgoV7JTDc4t2Bb0XNyu6oFa3yNdrSRDgcpLuc22X12cdN7Ts4ub3bf9giPRwh5Hclwrw1fBXGXb9G9P0u+7gQ4lcJP45lYONlINVPuxovur5NldJVpDti+5vAjD5VfFKqOV/inLWOOePgUR1WBOFO5TisDNKGTaF0Uf5fo3b4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iki5hoIQ/fJFdjO+bwD9StKmU3Mq9+IgOEiR3gnZk=;
 b=Yo/PqCk2PIrlFeHHTn+7Ic7CgM4Td2rFuw7t5/JOzNh3xgnglYgB/Kv/rX2Ov374ZelX7LqNePjzF+/Lw7qLEZypdWpnumj4jK/Poj3q1rthKEX5tkQATwhVfhqlRnx03iarhEpVDNBYQ/hFLL6BMg8DKog4nvvOU1uKIGYuJjw=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2886.namprd15.prod.outlook.com (2603:10b6:a03:f7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 21:23:37 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 21:23:37 +0000
Subject: Re: [PATCH bpf-next 2/5] bpf: Add BPF_PROG_BIND_MAP syscall
To:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <8ef54583bd3e57af53f3e4f16198907465f7c3c8.1597915265.git.zhuyifei@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <539eb0a0-474a-f8f7-f2ea-22e3c2ac0b85@fb.com>
Date:   Thu, 20 Aug 2020 14:23:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <8ef54583bd3e57af53f3e4f16198907465f7c3c8.1597915265.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:208:257::19) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL1PR13CA0044.namprd13.prod.outlook.com (2603:10b6:208:257::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 21:23:36 +0000
X-Originating-IP: [2620:10d:c091:480::1:7a86]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a5795f-d610-464e-6ddc-08d8454f4d2f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2886:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28868DF89B87DCC5A1633B09D35A0@BYAPR15MB2886.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzxeCoFCLVm3W1p2Vhq3IrEMf7jrBJknbkBBqKUC5gBWhqkf8qGRkFGHFTbQ4/NpVMUcmOxdRhWmlB5zihhe7gFQJ0Oofn0fqGPZk0/nE2ePY4Nrjh6mTOrA8Xeg3wXRLULbc52NspEL+IYkJbTWEYIuo9qJE4TLFDj8Rp8Po1NH4TPUmLvu+DeyjbSQ1lgEfFoVtuLG6Xb0ddsRwdFsBY8vX68kux+BnweK+0vIZJIMGHIAprMN8xub8L+7cJ664zZN7DAQGbbiiwkV1/y33nk+4IpR4WMo/T6/gdhklQjKG/M/XRJxuRjCR/9/1jKB4Q/xqfqwFUvS7zga+BHdqECl7c9+hE2ozFdRwXR1nqsNtKAdZ3cOckVV7H6bAvTULGATPA2Al/oScpzfbOpt2A8jdI5938uE0Ljrap0dNGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(39860400002)(346002)(16576012)(2616005)(956004)(66946007)(52116002)(110011004)(8676002)(5660300002)(66556008)(54906003)(66476007)(6486002)(2906002)(53546011)(36756003)(86362001)(31686004)(31696002)(186003)(4326008)(558084003)(8936002)(478600001)(6666004)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 16BhrU5GowokGh8k350iizQFC2qzySYeBDhbp7R17NlLpn8iBuMSrQwbslFgjyHJNvOB+tIeckkw+4WDmjZrjmxuJlCy4BscU/M0K9rqrJkXDeZzpc7HHzvOuUrpKhjOemtP3GLoNgs3v2oNvUDNi8mqEzGz4PAYKM4yAOjQZDfoTLRNbR/c0p2tyyjCO4f2VPkwCGpXO2mP+rmT4n7RnFxXK7jPI4MY5IZCqO3us7YDNkN+J1vUMpVqvCjCp/6WcWN9YAA+kooaUSJOHDpsJEPKNT0zKxouCudGXmOcgtceKK5a4l3U25LtdSoJehYM/ZesDRh2lwr+FoS8sb54heORwt5tRBqyXHvySsIwqrR/djuKnzxJYfLInyskcFnJw55LHH+wdW6YPZd2QiIb07fYbznhbr1cVDSwFIrQwuVOTUbWXS7+JASBSVBPu0ZpQsvPqNQHsxB3oCOS9M5hpXXr3dX88Nj4Wbv/4Z35OH6QjJia8KocQHqRXD0/Tn3RD5Ib7Eemedgdxlf1yDY+dPAZ9q8vEObefmT9TzY/lDbXLUngItD2JHQ/ljsH/JiF9PRYyMFsAhz+8tg+28s9rQuODvhW5LuqtcvYa9B2lSzvtBVQ8TQcnrw4+zfgjLL/uVxMsgkm8P6mW9LEEFpDyALxi+nclXlDgUfzc5u8PxFjcg8u+akKMcW05dLrplRH
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a5795f-d610-464e-6ddc-08d8454f4d2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 21:23:37.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZ2mX0nPG3AE+G/c39KW60xdE6MTeHkwis/LWdkiVqWqJ8lE/2YEC4e2XO7o/5a2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2886
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_07:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=577
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200172
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/20/20 2:42 AM, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> This syscall binds a map to a program. -EEXIST if the map is
> already bound to the program.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
