Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB25E1D346E
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgENPHD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 11:07:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14518 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgENPHC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 11:07:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EF5wJD015730;
        Thu, 14 May 2020 08:06:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=j13xPheQT7Dr9glpxzV0CwKa/9blMa1fiqMUOx13Ifw=;
 b=IFMQuKfSXc36sWqtD8/aaVX+oY81nOWvg8hvZTVRKaE2XEMXEnMWBMsot78NCaJ7v9JK
 N48lMXc4CuPPOT+m2eAgoC0K2gaqJT1HsmrusXufcs0dr4Wn9JT8XOsA5dCCm5VqArRk
 f3WHjG26BL4DGWS/rOQPkAe9kphncug1wLM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x73urt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 08:06:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 08:06:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfOS4kIrUhaRdaYXDU1jr2eQDm7O1bSYkiORYxt+4z8tQam78lGZPufOSp35LEbIrPSI3dxLDaNLfBRiEX49WX72j+OcGyGsbH/XV7QyS/VooGiEqLKSO0i330aoH4moo8Y/zK320Nh4zgqdraCmwJ1IzUtbK7EqvHg8Q4PzWAY+5vLuq5crkLgb4h7rkyce1/FcpJS+D0CTtWmOtHDlANy4Kl2A7gwblkbSZsmVSkUrJhRZOic7hLw9FHvEaZaTiQbKErScN7j/5wy8jBK4rbSJGxFfCDQdXUd6EFkDMLDHxGUXfBTUnG0CLlpCofGocA7wVuF6PHt6nv7l//udIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j13xPheQT7Dr9glpxzV0CwKa/9blMa1fiqMUOx13Ifw=;
 b=VHhg3WpUHSk69Saon86vdtyGOgOwPRoQgl20j7Oy8vI8F6TATmkguENIGym+J/0nSs8dLdzjfuyDbH4wy1bpt2LemUkV8GuFxLXj1mbNU+PgtP31EuII992/AnJfkQqKEodwDgicuswxDv6+01xrBY2YqsZgcZjfzmyx1Kb4hAAt3karePD+umjrWwaWbsTGeyez7gqdySM+akBN35PvVwrs7VRGK6Tzy57+lnUKEjL60nEBSOwi/PfkJjYwbbA/VfKYISrUMCJaMI8ZUrtft0471IOf7yHGXbPooUeQd4wFXo0xT5HxyLpgJjz8JAmsFt+/wEUTgm0a3wvgBZY47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j13xPheQT7Dr9glpxzV0CwKa/9blMa1fiqMUOx13Ifw=;
 b=Av5OzMQkGi5T2pOJmVWIAW2+KguFjhZeObVxDcbRQmWifwiw3Ifoyd0ioLjTSQqU8zS4oFuR9P2RXTLX/YCOWqXXAyU3PEaVx1gRIsM8Ug6IslxGg6HHo8PBiMP9kk4fzNc3piUTDjjG9a7tbHdmcBTzAv2Vtzl+PiSssQHK9t0=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3479.namprd15.prod.outlook.com (2603:10b6:a03:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 15:06:46 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 15:06:46 +0000
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Allow skb_ancestor_cgroup_id helper
 in cgroup skb
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
 <3cb2908c5690d20e1575ed36177b5881838a9079.1589405669.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <80275db5-c1a7-e8a5-3862-fe66d5ab255f@fb.com>
Date:   Thu, 14 May 2020 08:06:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <3cb2908c5690d20e1575ed36177b5881838a9079.1589405669.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:3bff) by BYAPR07CA0091.namprd07.prod.outlook.com (2603:10b6:a03:12b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Thu, 14 May 2020 15:06:45 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4783530-959d-47af-ac02-08d7f8186b76
X-MS-TrafficTypeDiagnostic: BYAPR15MB3479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3479E10E8A57967272692E8CD3BC0@BYAPR15MB3479.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ousaWUeDizgGNPeY5jXkL+kv44kBMvPLUW/U++VPdpYJ9i/PGTONYCIJe/YBtqpCGqkkww60sCXwJTGfKWPRkX1xON4eW3cb+HIu4LlNCPqRln7wGrJsmNF8NcVKgyfhwbKQvqcBGCcH2rGl6fbMwP4uANtQEXO7T+t8akZd2ZbY/48TQVR3T4fBAsIIcrhzsZhYvoE0M96IqEJXWYT2VINW7ELYf/lCDikkvD34DhuD7YThhrvMmK51eV6yAR65lRcJ1q6h29RSm3GTRCFYzFN3Z22IU5uMfJ+W6W9Ng8wqRpQnB521vJVu116zcUmfRKXtGFAjGmnHxigdhAJaEIYC0+VmbM9wYeA8U7lhdW9dr9KX65p8JNinm1krlm+Uj1i1pzx5n7huMHvPHQvooz2TwkYbEcSKsfCu+VsBNwk42aVWxQ017q7ZAA7XXMNJhxy0du4pmvNl/AVINlJlN1uhjqoCteHLmMBgyZcBp8QD7l6+/xOfstKu+/1gmiDq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(36756003)(31696002)(66476007)(6506007)(53546011)(478600001)(16526019)(6486002)(66946007)(66556008)(186003)(5660300002)(4744005)(4326008)(6512007)(316002)(8676002)(31686004)(52116002)(2616005)(8936002)(2906002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ys5+04tSpnjYAV18X5zPmHIZxa86D8pEBFlodSgJxLXtTdEvD3nWo79OLsHf7qg4j0pR9mrX9i+2o1evPMzUxHTCmtOFdmHTjF5SgylmhaXy2yN2z3Tb3LsWTEdznDtSwIVk5G8zVyEbH2J0mrJolM78XWsv35JslA2wZA8q7KQqBJQdX+hISJ/iNXi0qh7yydvy++EAEstLKF1GUfHECJrwCuwVdrBWcVLbf+/9EY0QBSy4Ana2DYiR6uNrNMrHKCUX49YrDfwYn/k55tLkWhfrPQIHGuwo5O84c1Vi2j5doz7xaLQA0DTywdDz9ScrwgZ/w3jbHTO4TTdT0100RGY0feRvf3AGkHvTPQFy7NoxW4IFZmMPvlVe3xTterr76s5gquUqtK6b/MlYBOCRRrOnutyAChFjev2dspc5g4x8dFuVhdnGnRFinf+ojgWwLSAqOwFOVY2HOge9h8Zf/IF4a1p/XXMzKaSEkjmfPzE+WpFvKOXrI6JV2AVTsQci9Da//HH9iv3jcXB5XPMpEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4783530-959d-47af-ac02-08d7f8186b76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 15:06:46.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgBC9Q69IGD9AMBXDn2HQkRyM0xQb9o2AFG81nTPuVAvYf9HgjjeEZYg/MAaErK6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3479
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxlogscore=851 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140133
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 2:38 PM, Andrey Ignatov wrote:
> cgroup skb programs already can use bpf_skb_cgroup_id. Allow
> bpf_skb_ancestor_cgroup_id as well so that container policies can be
> implemented for a container that can have sub-cgroups dynamically
> created, but policies should still be implemented based on cgroup id of
> container itself not on an id of a sub-cgroup.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
