Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F84024C716
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHTVSz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 17:18:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51772 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbgHTVSx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 17:18:53 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KLAS0I002592;
        Thu, 20 Aug 2020 14:18:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0xSFpu2nhp6f4M1XRkL+35l+F2uMUNSePBOcIBGRpS0=;
 b=bXCmqj1MWNX3ijtaKL+9BM5ZhBOl4KvxBW1jB761QpCVtjzcd39XURf3PTItouv5zi6j
 lNf4UF7McSRwO30zDKu+1kO8zwGpsWltvmPIwpfaJDjhXZ/ALk6iYBxd/qtIBSDaKWg3
 fKdC5aHWLGJQwnTE8g1Om+D0+nWc9gqoYH0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 331cue5th0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Aug 2020 14:18:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 20 Aug 2020 14:18:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUMELXiTJsxnEE84ijlr36WysvIm3kCfz1zArsHeettaPa3qQcXcLwup20uFEwkkjJaFD39fjHjcvXlp+b+CHQnS/KzPdqfBPU1LJAAQq/waIAYGGkfKVRr68jEa1hy2YuB/3xZkfUM/zH0NHP5PyGEr63/bKCsit/Wkh5lRd1orBOKrCl6NC6K3WKZTaUmZ0iAyj/1phAsZaNyuzhGjgh6vyfwy8WoLav8HriIzYXHbBsCklOoYShwQsRrJTesDh3C3t/kJu9SEM+znApPTaYsZSdVx/oyi6xkVNGbAWyWQXIRsF+cCflyD7+Uv7vjLSm9FUQ2HNTB2Cl81emVRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xSFpu2nhp6f4M1XRkL+35l+F2uMUNSePBOcIBGRpS0=;
 b=l3U4TNqTw+7CfkubhEWQpg3cysQhF8oRj2f8VZZcz5uIDaTAJ3Rfw2957/rC18kvAqNHqtlkF5DLF/PaSo9nfwh511g4GQIMcYt/tx67TTgQJc5M97xqBbUbx7ddCTM3bkA1ef/S57m6xtpWe2shTY0YuAqj44Vu3y9HoiDtlpXuQK4mXoLI2+DJ2xsQq5koy84bsEJhuZsAGSeJob2Anelw6Q0n/iFaNUuqt1rfqs6KFL4CgxGao8TYmKnXX56XLSn2thFntXk9+6uSgxx5ICLgHfcgx03WlM6Dg0dFj7hjwM/o332cfNjSyLXcc11cJs4GASSbC5r0ii1DKwRiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xSFpu2nhp6f4M1XRkL+35l+F2uMUNSePBOcIBGRpS0=;
 b=Q/tRLjvIhDhvNo9zxS/oszmErHhbSp3W3irXBzxNG2/GG9YNyJq616HopvZnKLh8Q5Ianyt+pshK6egVERcDkQBfFvBxoqrF/k1/UsuLGs6L8FAlDHgLmpE+sbmzbLRQ6eHENfUHvA3dddtlVXRfzV3OjBLVTHp7S5PQEV/W3ww=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2725.namprd15.prod.outlook.com (2603:10b6:a03:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 21:18:35 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 21:18:35 +0000
Subject: Re: [PATCH bpf-next 1/5] bpf: Mutex protect used_maps array and count
To:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <d8dd3a17e80558f9b57815f2165e403c1aa24858.1597915265.git.zhuyifei@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <39cef347-cfc0-77e2-05a6-62cc0b5c5acb@fb.com>
Date:   Thu, 20 Aug 2020 14:18:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <d8dd3a17e80558f9b57815f2165e403c1aa24858.1597915265.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:2d::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:2d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 21:18:33 +0000
X-Originating-IP: [2620:10d:c091:480::1:7a86]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8928f8b2-6fba-4ba9-3c36-08d8454e9937
X-MS-TrafficTypeDiagnostic: BYAPR15MB2725:
X-Microsoft-Antispam-PRVS: <BYAPR15MB272532CB10C933596D3F636CD35A0@BYAPR15MB2725.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yw2wo4dm+4JPBpnqDLgBBF/c4DwvsirGsOlIPvW4qZSJ4HdyRLXBZ3xjj7eczKPFMp7hvK36sXpQmlFHlhJENKvt2v9thHqLUZNrssGsIMmp4V3pq2DXhfW+UNEdsPjH+d8KbQlMKzstFy9q7cR+1Y09G3Q2H/YV+sveLhLFeanQ+FSXqNcXHEVsYqkG7nMJMSBSfo/weuDmvEtJpbQY/dJcqfr+dvQsG4+Nm5bGG8gScQVZAsKi/etfkEP8x7U2v2jHzC8tqOFzQAtsBhj/4COWxy2umjhCXkyfS2iioVNRW3omKGDTk5+vbMlKmIAWTJMm4sacJeNoct83BBm70QzoZHCOSGavVyxsIV0tfDCzuZrCF4wogncq+VcxAX7h6K3XTF11B4DLrz0WN0GfK3uVWbODDZuVJqCYvQFn73v5psHS3ZvusmMdP4ydUFS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(86362001)(31686004)(186003)(36756003)(4744005)(8676002)(110011004)(4326008)(8936002)(478600001)(66946007)(316002)(66556008)(956004)(53546011)(31696002)(66476007)(5660300002)(6486002)(2616005)(52116002)(16576012)(2906002)(54906003)(60764002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: R9kvukOJp+u5R2s4awe83zIM4KVD/ucV6D1TUjdiu3H/bLLqoityIHL2Wj2aTl41i/WM3LN5lSZ74FLdwDHvjvRXP85jA3C1GpkZ0yRaFJpWu9BcD/CQHVCLhRLP2IfpbTC1XmpkbmRZQ/0BFCYj1kVzUUGl+JIr37lU1SG+8jiak6UVueW9jE0AXxRENiHfgvLVr7aesdrMrrbUrg6Pdj03woCYQp0k/n3fCZD8C3tZHnJnY/gzF45Kvi73lfyknpVn783voHZ+Wb+9YsJ9w/vAsGQqimMhmt6Q8e36r7apC7ijjW/9k+7Yj9GG7+hs5JKd371jIFuNBlM/DlNM9d8rgltRyr/lUzzKyFEdhTCuGVXwCL3SxMXoCaHWCT7z9UPHcA+o3jlG8oFUxkz5pxkOQt33OyELMCMSaG5pnTFrDEDLMbfsrIJhQd0Oh7A7NZWs17e7a+PHQxgRhmkq7GZvBsrRAMiqo3jAkQYp8KqmSTq64vEGxH0uheJ7CDf+IodofjFp98UoHoy295RQcRaCg/ge1tDRitPZ5KqUQ0M4HCeIOZ/W7EhlNV09Cj8VErNsr5i6geXcudPlVbVqJsMqSq5DXfb53Yp6zyBqNOWaLFPEjEhPALiotDOoeVLgE9uWoD81VPCowoNVkUNXoZpDKMJPn5gXQXZi/IGXOpaPW8zsfICGu96rZyWKTWKu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8928f8b2-6fba-4ba9-3c36-08d8454e9937
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 21:18:35.5483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiZ3U1Jomua5r+lEnvwVK7PEmwXl4PFMGTrmbUGS3mfBIbQ0X08T/NIMH+Y2fiF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2725
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_07:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200172
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/20/20 2:42 AM, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> To support modifying the used_maps array, we use a mutex to protect
> the use of the counter and the array. The mutex is initialized right
> after the prog aux is allocated, and destroyed right before prog
> aux is freed. This way we guarantee it's initialized for both cBPF
> and eBPF.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
