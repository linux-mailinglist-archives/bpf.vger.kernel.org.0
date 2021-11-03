Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06257443CEC
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 07:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKCGHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 02:07:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhKCGHh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 02:07:37 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LaLNh016118;
        Tue, 2 Nov 2021 23:04:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8sYuWJBN+XT0oIesZ+f2stMOyEAKhIHOdl/U5ptCZPs=;
 b=aG5vuozGwNFTkChp6WBR4ztOH6nkJfBsyqnViqdo5j7V4ApfPslSK/j4dZ6wIn8U4HnI
 HCGE5N5PWtPpuHmhxRyBRBfehTANaGNDhlBl9oiI8RoVk+rMdGnTyAo8Pf/4x/XolHw4
 oN1aNxYMAXkBo/OaKJUobx2icwLROlEhF/s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dd32g46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 23:04:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 23:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI79I4esx/r5XV5KonW9jp++f0YSV21dR5ZsUM8GVAkSkG8vLpUCBN+Evwj1JJp/Q1TYKIDTL9ZHr05aCymqAVQyOWP8zZCZG4RTmVHH5qjvLJWDVJSzlxzyXYETYzgltT/vWmdwiiEaPvdCLkY1zA1lGKL5T7PudxIY9TDto9SgPF6KCsa+mqjwq+qfoM47jnQ808dM47r3UC55cp5bf6tCP4RrTlNqNCBEMpIni63o1W4Hi6A2DUvJeShbnbJaGULd5fLEkCv+6VqBXZb0wa/PFtlkB0tDJM7LPOqEmpxhhNQwR0RDs6UThUmt2snLLErkI9c1oABFO2GKZz0SWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sYuWJBN+XT0oIesZ+f2stMOyEAKhIHOdl/U5ptCZPs=;
 b=jr/0/+LlSKJKGxYSiSf8AofqDZcEtanqArUzvbmI804IlTO5u1NOxQ/uKZLNR80SsGF/XwAUXyGR1QvQVEbucsT2sR1mm+QA09gxOEW2uNFd9KuEbjlaqaeGHkiPAxbI/Te5UMFGC3X8Sqr/kXOF5DDKrcyncWeq8OIax7OATxCtu+pLl7SQJ2Mf4JMClTToqeSiHx9zaFjjDmXktfSnhnB8YcjdfGPtm37mLcn4vP77EJfPSVwfxMzBBYHoVkpodHblUix4wiiUd2kMHkSZnG/Z7PQ4mP1/VAzTa+9nkcPnuQod03ZNIp4VeJT2McBzKWirTocGgG+wsFWNFlyU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4240.namprd15.prod.outlook.com (2603:10b6:806:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 06:04:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 06:04:46 +0000
Message-ID: <0f17d683-15c7-18e7-6a5c-2cc4da7ba2a8@fb.com>
Date:   Tue, 2 Nov 2021 23:04:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 1/5] libbpf: detect corrupted ELF symbols section
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211103001003.398812-1-andrii@kernel.org>
 <20211103001003.398812-2-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211103001003.398812-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1066] (2620:10d:c090:400::5:b3c5) by MW4PR04CA0157.namprd04.prod.outlook.com (2603:10b6:303:85::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 3 Nov 2021 06:04:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbcc2b0e-2145-4b9c-8e71-08d99e8fd667
X-MS-TrafficTypeDiagnostic: SN7PR15MB4240:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42403170C112BAF862262F11D38C9@SN7PR15MB4240.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlL4eKxrcBzRwKtDo+gUW2jdAYQ1bhn8HpyYsed/xZ+yMFR1eZaPTzN4xOAdU0/44roh2oYPiWWGUcCts+Y3deAgsUSTa2YMhrgWK2CcV4ePkWqN9COMYkE8/9cAZlCP7z44Ko1gL9PliVGK1bQJaYDAWj8iXzyK6Xt0plHl6xe+wiWKDEhIxgnWJrHkdREqLXlPZj6CNPlOZHigsYT8dq/Qa/XjFwIUr155hWesPtIxC25PUNeqRb3Rd/qsBSxuIvTuGvylrWMeVov6gML3f2AHR2dJXMme52Kjl5LorfoFQQ9o12TVafKI98+AsX9Rrk7vHBk44tPT6XyAKZd8taqevjj0QIbWMkid/k2q95yJFD8C5OzXNftt7yh7a+OvzWcZgS4y17Oe3L3QoaiA+h/wHFs3UiuVug3su1p4PlRJsZHfxknCIw7o6ANBSF179LPeZVJF83LuvE5XU8E5RAOe2Yh486b5Y9iS3ET01HhfHrIRqD3rdY9Lkt145kcTehfyi4oQHsb6El1dIeDe5vLnnUCmWV0x4z2anl6knRVKW+gR+P2h0YnaDVGe8oM5MuIWbaQW7zmHRYIp/G07HZ0u5i6frAXAju5BMBZJKGP7F3214lgmkkMmhTmefzDDsS+DTx4hyZ+5J5+PswitUrHE4I1GaRtm2HryS1YKMkSC3j4oSzqSJAXUtrjlK7rlAu4iJ5P8vj+92xThJ1NuRIIhEEVEX6Gca7uwx1k8XCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(4326008)(8936002)(36756003)(6486002)(5660300002)(2616005)(8676002)(2906002)(52116002)(66946007)(508600001)(66476007)(316002)(66556008)(186003)(558084003)(38100700002)(53546011)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxwQ1NMSktuSklJS0thcU5Rb2ZudFdabmNabXd0elJzMThvQ0dBOEszQ3hI?=
 =?utf-8?B?V1dMR0lsbzhWNU9QSlZpZHQ1QVhNLzVQTFN0eTd3TVIzNVorOU9SY1ZjM0NY?=
 =?utf-8?B?cGV2TkFodkhYMXpRZXlKYUp2N0xvY2FUSnZYZ3pjVEFwOS9yV09xMEVqNEJN?=
 =?utf-8?B?ZmM3VzczeGhuaEsvd3VOazRvTExPS2ErVWo0M3hYcDQvRmQxd245cVN3K3ZM?=
 =?utf-8?B?MklyNWlBN1BERGdpeWNaSlJWMjB6Z0FIS1ZaY0FmZFBoMU55dHRyRCs4dXlu?=
 =?utf-8?B?S0dKZGw3V2ZZcHVsRlJCTDVEdU53Z1NrdlZTT01OVEhyOFJzQlNWdEpGRkdF?=
 =?utf-8?B?YVhIUTJYUkJ4YzdMZWJBRnc4TzZOaXNuaEhFWGlzOUlPc0hVZXF6dFhOQWFo?=
 =?utf-8?B?ZkIwenpXdFRFQmZkTEcyZGhvS21xVkpETVNhZ2lBbUhOL3pybEZhY3ZsWlli?=
 =?utf-8?B?bGM4SU1vM21PVHAzNGhIckN1Mk1GMjRnVVgxaUZBRG45UmI3MUZ2RDJrVitq?=
 =?utf-8?B?aFkyR0tVSXJxOVJqdHhSVUhDa0JhYlhBbHhQSGpja1o1VmRRYWViSXJab0sz?=
 =?utf-8?B?WWVwUUV5M0lnbGlWU0xiTEQ5RHF4bEFLNy9wOTdJeE9Xdm9VM2FUay85Qmtv?=
 =?utf-8?B?SHRoOXRRK3hhaExLR0tjM3ZHUlBJM011anVnQkxoTzNnaDE1QVNPV0ZudmtQ?=
 =?utf-8?B?aC95dlhwc0phN1ZObUFQRk0wbFMvL2g1aWMzeTlqT1hBTjZzVGtXdDhLNjlj?=
 =?utf-8?B?SVlIZDdZcWd6S1hyR1ZxOXArTEJJRkZaMEc2VDBRZVhma3I5dEMzdmR2d04v?=
 =?utf-8?B?c25RL1B1bEs5c1Uvd3lCdElWYWpvNWhGL0xFSEg5aUlQU0liTnR4ZnI1cjJ0?=
 =?utf-8?B?YjBubWpxckVDbU9CMUVkTWdneTVQQlYxcE5jeXlDZ0ZQYzUrT1ZsUVhZYXR0?=
 =?utf-8?B?YjkyZG1FYm5ZbEYwd0ttOXd4QkllMytZTWIwWmVTUFdzRlFKaEtUUE90ejll?=
 =?utf-8?B?b3ZJK25yL04wZVd2Z1JrUjd3YnRENnkvT2FlMW51dkZ5ZTRVVWcrOXo4cXA2?=
 =?utf-8?B?cm9uQ2psRmVVem50dWxjN2REdWZRSnEweXQzSXR0UmVoY1N0UEZYZlhjRksz?=
 =?utf-8?B?SHN6M0lIZjQ3cEpTNWFaZk9aT25VUVlGZDdHVlkvU0p1ZUZDM1Y3dVZ5YWVu?=
 =?utf-8?B?NGdOYTBIRXFtTlJvUUZSeTdzekEreEl2a2RNWnVMVEoycjU5QkJFaVlZTlFS?=
 =?utf-8?B?aUJteUdKcm9Wbm1icXVvQ0swVlFzQ3RLN0F1Y1pkVFRsVnZOWVUvcGdwNFYv?=
 =?utf-8?B?TVpQK1d1ekkxWEZkYmNaZDdjUEpCbVhwUlRxcmIwUVBvdDFjTXgzMG5pS3VY?=
 =?utf-8?B?QjF6OTAycVRXU1ZSb2JINytubG93dlF0UHVZTXpKUEQxTnBpYXJaRWVva0pa?=
 =?utf-8?B?QWpIQ0pRaXpsMWhPKzdoM0hkUDEvRTRYNCtCMkd4Z2VaWER4RjUxNStPSkdR?=
 =?utf-8?B?TThyYUVtUjU0TnFEWEtKenhuQ0ZoY3RaK2Zma0Vqbk9qdmkxVkNjcjE5SDNH?=
 =?utf-8?B?eEp2UWZMN0hXL0VBbDZvYUhqSy9uR0lLbnZGYnYvMWVtZXhodFBSa3A3RDYy?=
 =?utf-8?B?TGZFTEZYMzZoQ25LYmNVRytJMnVPaGpoQllSdGdVUG9QV01KSDJySGVPTm9M?=
 =?utf-8?B?SGZ4SitrU25DL05ZUVAyd1o4TzR2eHFkbE1LNUVxQWp1WHpUSnpCcFdyUzhQ?=
 =?utf-8?B?Mk5EUU5remVkV0tnSktuYnkyWWFtVXo1aGE3L3c2cVlzSXFkZkN5LzVHNXhF?=
 =?utf-8?B?dUh1SUtTUkIxM1BhZy9BSi9GVW0rSDFab0plc0lWcFgyVFF5VERpVC9zK3Fj?=
 =?utf-8?B?ZmF6bXM3a0VYL2V6VFJoL0JqNXFSUW9IREpzTEg2Ly9jTjg3eWtsekZVNkg0?=
 =?utf-8?B?RTk3VlRaVytOTkhBMnpmN3lHVk1kV0N2dHN3dU5xOGZiNlpNKytXMUdpRFZR?=
 =?utf-8?B?TTNyV0F3QXVIRVQrTkRCd0NSa1o3b0VyampFVmZNZmdQZG9CTUQxaG9ITTB4?=
 =?utf-8?B?cGFLSkdsdXhjNGxDM0xPM1pnOFJBTVhRL2wyT0NtU1NIR2NuWHBPZkZKNGRO?=
 =?utf-8?B?ajZuTEc1UTZmakhTK29tQ3ZMV3JqdENoZVg1aFV3MnRGait4UnVUVTZiYk11?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcc2b0e-2145-4b9c-8e71-08d99e8fd667
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 06:04:46.6707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0JaSkW+18Gw2W8GArwjVXX7tfiQyXnezw6tdZ3240FmUCpxh/sfRpClfuydEYD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4240
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: wJ_jBwq--9R1lvM_w190dAjQVeRWe_2v
X-Proofpoint-ORIG-GUID: wJ_jBwq--9R1lvM_w190dAjQVeRWe_2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=862 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 5:09 PM, Andrii Nakryiko wrote:
> Prevent divide-by-zero if ELF is corrupted and has zero sh_entsize.
> Reported by oss-fuzz project.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
