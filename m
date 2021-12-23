Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0247DC86
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhLWBGe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 20:06:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239969AbhLWBGd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 20:06:33 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMHwxXd013986;
        Wed, 22 Dec 2021 17:06:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/9BTucCzATajFtPcIpYmF7dF0BRFbGiYLzhYKhA5lKk=;
 b=gIHtKO0GTvfGVbhzmskJ7u5zSlJVY5K9DuJEKIlyavKHtJszaD8ba/Uk36Rr93Lyclh9
 /bZ7OJQnIxKVimynXYaJshgLZEgmp/fuDQOhJHYggJdF22Tmm19PQ19Sh9YfQCbHHnyt
 9CAJ05d7JkwOK37U7tGQzNDyq6Z689Aj+j0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d42mxn0md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Dec 2021 17:06:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 17:06:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLuou8xKK4TWmdv+JTstq7tR3L3X10PUdskTo0X6Aac8U78Pzp+vgrbhpIaZ+rtj0LgKbjNYvPe/+ffyP6hTrqnfSkZFF8ylVY1CS/hHVD5sgDL5In+eWeLlSofTszAQclJPPjjgTJgDK+JajOpj3HqWPmxVyoGLjX+QOU6U5R5qHFeLmU/mHoQsbEYlWgwnWFg4ZYPHNmkTtyiucs7lg/yUeBxoDzNtTwK18WbYSq6M5V9yqgXkGGHYapNfsfLTwT+meNbu1g/olXtmGvu4tOInX9RInP5IiTq1Abk7C1O98V+9J7fKb0L9dm2SU4Fj9dt3og3NjchsnvGoO6enRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9BTucCzATajFtPcIpYmF7dF0BRFbGiYLzhYKhA5lKk=;
 b=K5QCqAzs6JADqMzo71IJ/9mcNUvn4wmNuFZCnWcGpzZO7uZN/oSbpnhTUqzJiKgoOtyVpiqRvIoa+8NP0Yb9eXWey2uC6hbllbf60o4y86i2qa9lrPCITptBh5SDmFnvLhyyd8pc3Lc/uM9nW16pRXY/USoTacAi7SfeeopwADgK44jP3RQQZ1ECpddVtXo1IYt9sSsMQkpc+P85NQmoXNU57b9PGOchWVyGZkVwSmdZer+8kCbCv9kiT48bQyQk+ocao2QObsa31fecG0SsEJDxehPow+8TCKnlXEYWRvoLVNFLtJB3EhInogcFeNUBVpytHhhK6eUFaLCdAKG46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4095.namprd15.prod.outlook.com (2603:10b6:805:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 23 Dec
 2021 01:06:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 01:06:15 +0000
Message-ID: <c3408843-6ea9-ada7-8740-258fc47ffc33@fb.com>
Date:   Wed, 22 Dec 2021 17:06:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next] libbpf: improve LINUX_VERSION_CODE detection
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211222231003.2334940-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211222231003.2334940-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c68b9c8-323f-4cb4-69cf-08d9c5b06b52
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4095:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4095F8031A3655C8B84C8657D37E9@SN6PR1501MB4095.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DU7SHZ6/FY467WIoWFKfAZ7CehxB5B6BCxPXQZ8hlXn62ch2TisAq3RaNg/SNhG5pC4H0twKcI3qu3GBYS+Vp6PHQBPAk5l1FnZpLo1Rj5WzXLGMcynj0FcRbL+IyuGH6fd9LdUfRL2pKnYB8FufML0GT6egfxcvdBgvqj+c3TFPKDuIUzVx+d8h3xK8Z86yZaa+OMVebw8sNZ0dg0AFPbHBNUur4qiQ6DlyigcYp5QupJ7UnKuczjw8L3bTAyP8YEnhQM3/mWqQjB9TKCKmukdQJGx2y+3lq0DGW/67vPIw/wI0Fe39AXewQov2IJ0hAYD3EPrbhi3oboacSnTkgPVbZHINSOgGpoN0LImcGwjSRk5JXJR0q4VRkVE+Z6F3/LJllVz4hPzonlFhyvmrD+FubpXciIQTrFHqDCoSWu74hK46T/8+DlLTWnabVOYGFbg49Fz91mJ9CQQhF2ErOQJ51z9MZI+WTZcd8N7GPVJB1Sx/9kDvKfVPrBT4aAG3nRXcDtucG4jX4QbrZq35EXkLO5H4OK+FYFiz1XeBgEdGRaRXNH7DCDXGpx1zO8ijlNqwvj09D2RM27K3TSvOo2wf28c9NTx1M5+GuupymMA1E8x8Ze5iOSNoJnJGai52OZID82Ob7VTez7yuY7dA4XRFZYucnbfaOoU3OTEgKbLbKZ+F1Jr1w9uVprb9DNe6OGf+PuvofmKiCszIpLNi6gWZjTiukBCWLVn8g9RkvUt/2oQ3X2x41XeRnkEYSc2Cpp5flNNSJZbjAT5qmNaEgZ4l4Xoa5cy8AGu5XQr9Pcti+UgvXJj9iZ/V0B8HN6ivEPWLXUpk0k6JDZSLK1PPag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6486002)(966005)(38100700002)(4326008)(66476007)(508600001)(53546011)(66556008)(66946007)(31686004)(8936002)(6506007)(31696002)(8676002)(186003)(52116002)(83380400001)(6666004)(4744005)(6512007)(316002)(5660300002)(36756003)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlpaUTFxYVBxS2cwNnR1MUpublZGaW1LMmp6aUlyZktpdTh3bHhBYW9SbWM0?=
 =?utf-8?B?TlRiTTU3dUx1MEQ4dDZIV0VNSUZqTngrdVI5OWo3SUprdE9RbTdiZlJkUFRk?=
 =?utf-8?B?ODVsc1lld2JmeUoxTkR0NWNlbWF6RTI5M2Z0ZUpsV3NCVTB4YnMvRzN2TWNx?=
 =?utf-8?B?eFZJeUwzNzI1UE5pRC9uUzFVTUcrUkxuckppUmJ6UkpqTVFsR000QWhFOEVS?=
 =?utf-8?B?UGkvSWhXZlY0aStVSVFReXVUWG9hUEhHM1U0K1lFS3kxaVlxUVZEUy93UmtV?=
 =?utf-8?B?YXE4dXBvdFRwaHN1ek5qTml5a0RjZnBkNkdsSnJ1UFRnaTlGOEh6WDVyNlhG?=
 =?utf-8?B?MTF5VC9hbjhXTjJmeE9GZUY2dHRKN1NVS29QWlp6aStaSC9vbVVYTUNwMEJt?=
 =?utf-8?B?SkVTSkVvb2RLcWdyQml4emhyZHZBdWk4R1NlbWNYSkpJalZGNGwrWC9uZWdh?=
 =?utf-8?B?RmpHQTExMXVveU9aUVBpa3hpUG5TNWRnUjVDRExkNUZhZmhzMnl0ZFVHSUUx?=
 =?utf-8?B?QVV1bGxwZGtySVRMVXpOdE84ZjU5Y3IyV2lPdU9ycnROVHJpcHNDMnpESDRa?=
 =?utf-8?B?bjZkZHVmNkt0TGRNbjRtanFDU3QxRjJ2OFRMSU1wWXRYOVlSOFg1dHEyU05H?=
 =?utf-8?B?UFNPWXNhS2g3RnJvUnU4cjZqU0JCREtyTHVxSGRBbU56RUVxQXVPaHdoZEJs?=
 =?utf-8?B?OE9vZVFnc0hiVFN3K3p5bjBRd1BBRXBBQTRuUm9nZVpBblZMNFRmeUFHdU1Z?=
 =?utf-8?B?cWpvaXNSS2cvK2d4cGpQR0VtQ2JDSnZaZmp3SEdrVTBreks1dTFzRmpVUE1s?=
 =?utf-8?B?OE9GUXpicXJ5T2sybHFlSFY5RXNVeld3M1lSejNwUEtxUXN3aGVzMDU4RXM5?=
 =?utf-8?B?MVRJbENnUWtoNHJyZ1pyL2JUQ3lZVkg3b3MrZDZ2NXNCUVA0cXQ0eXF6S2pq?=
 =?utf-8?B?eUNCMzVsN1BrMnJ4bDJoY05lM0ZhTXp0eDU1UExJcjdjTTR2QlBualROalRk?=
 =?utf-8?B?M0NydjJ3QmVOZFVTOFNIeDZNUUpHMWhBWXVWMGx2U0pZS3JwaDlDc2JuZXRI?=
 =?utf-8?B?eVpUazJuN3NaZXZONG5jQWlyWjJIbkFxTGo5YVhUQ0NaeFRtdnY4QlBJcXp1?=
 =?utf-8?B?WUcvRU82Z2pUeU5mUnIySjllUmhFNE53R1JlVXNadjFXWlY2UWN0WXp5UUZt?=
 =?utf-8?B?SGp0SXUrOGpMd1JIdzlneHBqUjFSdGN6a1gwU3F6cmZseTJYcTRCclhJOThq?=
 =?utf-8?B?aENUNVhiY01jSC9xTXNuRHR5WjJmYlZzUXNnVjNxY0MwV1VNcURNb0lDdFhj?=
 =?utf-8?B?bXlLTFgya292Qm1XNTNyU2FWZUhTbEFFWXRXTWtxWkZ2UkJvTTVVT2oxTkwy?=
 =?utf-8?B?YUpVc1crOFAwaFhtM3dmbmVnQ3Z5Tk45Z1J1UXlCYS9oZWxJOXBhZlFZbElW?=
 =?utf-8?B?b2hYN3p1Slg0c0xzSDQ2VDNJaW9kU1d3TnZkRnp0T3BCUGtEb3o2Z2xGaEVT?=
 =?utf-8?B?MjRrSm1ZUGRHT29aNm5jTEwxUFE0dW1sK3AxRmc3aFVoOUljTmdqWGJhM1Uy?=
 =?utf-8?B?azAvaUVMUmh4VTdJQmoza2RySWloUnMwZENxNXdZcEt6UlZuZlBINmlQVkFY?=
 =?utf-8?B?S0xQRTVnWWVMamxUdXhEeC9GZ2V4WVFONkNUYWNjbjBMaktzYzcvZStZS3pC?=
 =?utf-8?B?Z2hJa21xS3lwQVJMYzk4dmlFMVFnR3U4ZE56ZVB1UGVkSXoxNDgyTTBNdkkx?=
 =?utf-8?B?elJtb2RNK0N3bkhSYzRYb1hHR3ZWUWJFUmRBcExYZVlOM1BrWG9sdE1IUERt?=
 =?utf-8?B?eUxsT2FWWFNiV1pmbWNPWXBJVDVta3VwSVNSdjRuNTVaL3FIbkgzTm5Dc1ZC?=
 =?utf-8?B?ZS96WEh6RkFDMi9FdFpwOGoxS1kvTlhaTW9XNHZqcFg5Z01pZmc5ZlBBOU5C?=
 =?utf-8?B?S1dSd0JwTllWOEtUYVc0a0tKaitiTkh0SkNXZjJneTJuMFFjbW5yZTYram1x?=
 =?utf-8?B?UFd2b1NZSTZNY0pndEtsYksrVktkU2YvcDExYXJTMVUySXZhMWc2T2VJMmxo?=
 =?utf-8?B?Z3RCNFhGSDU5a1lSVFZTUWgrbzVNcFpYa3R4dlBUQzBxWjBMcnYzbEJBTlVG?=
 =?utf-8?B?V0J1VGhvWFNyOVVER3R4ZkU4cUFkOGpTcVpWOW5rTmhLWkRBd3dzQ2dhbzZ4?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c68b9c8-323f-4cb4-69cf-08d9c5b06b52
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 01:06:15.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONAW8sX2kDkj8cA6LjkEfZUuZkYDB2pU0ju9dMOMfzSsXf4aIFVvMRHelNCadHOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4095
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: df31XjS6tEx1eKH8teTbzX0j2Y0QCJxF
X-Proofpoint-GUID: df31XjS6tEx1eKH8teTbzX0j2Y0QCJxF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/22/21 3:10 PM, Andrii Nakryiko wrote:
> Ubuntu reports incorrect kernel version through uname(), which on older
> kernels leads to kprobe BPF programs failing to load due to the version
> check mismatch.
> 
> Accommodate Ubuntu's quirks with LINUX_VERSION_CODE by using
> Ubuntu-specific /proc/version_code to fetch major/minor/patch versions
> to form LINUX_VERSION_CODE.
> 
> While at it, consolide libbpf's kernel version detection code between
> libbpf.c and libbpf_probes.c.
> 
>    [0] Closes: https://github.com/libbpf/libbpf/issues/421
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
