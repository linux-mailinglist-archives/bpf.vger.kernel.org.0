Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785191D37A2
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgENRIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 13:08:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgENRIz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 13:08:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04EH8cEo020740;
        Thu, 14 May 2020 10:08:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3rtl/RaHQiOYmxEgFRDRFZWSWD0FX1DeUrx4FjOFrpI=;
 b=MT3RdSG8VBurVbSObiK3yQ7mGbSI5m4nDsg9sv5Woxn9uubW6tLETw3nmtookVsrFsDq
 gn28tu+9VJQUA8lvGsKKk+q/heqGDj1TFcynlygw1hVlmoTqAg5QdM2lA9xC+SfBerdx
 G93owFiYKipXqwawniPVEH5dou5wVJ+/uio= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 310kwsy03s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 10:08:40 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 10:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUAOVJtgxkyyX/aJArtsC52xXWtY8LBz2U/lPUvSCX70QT0g+v+fZ+tDE47JAzJjyWSUp99KRT+YZtaSXffi7ifbWpjXKGDIvGFS8+bsXINBrCIY2Aw02oFthOvBgviZ65CzppnyOzW9LvJnPsHvoIzDj+IJNk6TYfEaBXtLn4gmVKJPhx1iz5UCIke3kV1QQ/rarYv2lN3R3Eer2yJouVot+NDWmEiaGBNXL/gxkbr1OeLTYPRoRNTOzHPMw3v2SanGpVE4n2yLHu1JXl+7aEIhoFHHPT6Arc7wuMu3tqbdEoF4MgTkSSlZMa/d6TengVSkpZSfNIWhp2JeD5D2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rtl/RaHQiOYmxEgFRDRFZWSWD0FX1DeUrx4FjOFrpI=;
 b=AQeiV66iEM0dN+m3h07AYkf4yqAcwovTyMfudrboo7MDZMaJ4aSWP3+d/62ZD8M5PFRYjOyuNX+2cDwXGIq7j+YMSvkulx4Q9kcXPb8TGCgFJAXdbu0XUDSbz/AAaOEZErRBfbV59IYIA4I7Vo0MRY2CEtnZ+Xvsetfuo86rpKEedkE4m1WzJS45AZIihI1ZzngVMTR52wfv06u6R/ZsV9zmmCKW81mreBtG1HXAY6IfQMlCzgSfHbyoFK3wVPR3gn9prfuYjX5DtnOb9xZ7pDp3Jzo2FXr5xydhbeY78TDndy1SjKwafUSG3XLYIKfprGzU0FzS2NHmNDZ9ODkNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rtl/RaHQiOYmxEgFRDRFZWSWD0FX1DeUrx4FjOFrpI=;
 b=XHYm2NNT6MX8tyjlu/FimVuVAMwujkJFatCBFKLTaNWvEySoNbPabY0YQg3BaugR8d8M6sGLKDfwcmHbr7hYDaHTITEP7HA8bCsvIqar2F25Z9iEZwriP87qPqWxX2blYNzVfxZ5qPebUCPu0ZCqM9JuJF8yvVxbknWAZwiGKp8=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3414.namprd15.prod.outlook.com (2603:10b6:a03:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 17:08:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 17:08:08 +0000
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test narrow loads for
 bpf_sock_addr.user_port
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589420814.git.rdna@fb.com>
 <e5c734a58cca4041ab30cb5471e644246f8cdb5a.1589420814.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <977755ad-3211-c957-e866-7182f769a4c5@fb.com>
Date:   Thu, 14 May 2020 10:08:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <e5c734a58cca4041ab30cb5471e644246f8cdb5a.1589420814.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:3bff) by BYAPR06CA0059.namprd06.prod.outlook.com (2603:10b6:a03:14b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 17:08:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88cfa351-d4c8-4392-7e25-08d7f8295fed
X-MS-TrafficTypeDiagnostic: BYAPR15MB3414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB341468E76EA4F66C176DE123D3BC0@BYAPR15MB3414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0Hztv3PHhyM3FRRsW79tGNdRyMd8dHeBE5BLfQKyIX3j/dB8UBTAL51nEjpZKELlWrz0CPM1JwXcFaSSRo6avjQlHiEDBU4EFXBno6rN9AN4xQVpaSB5heDVgoxkN1TmSj4TTxqm1qxHdpH3H57/TX8yrIT0PxRBhx6US3H+g3NAfdmZ6IS+xwrdZBIeS61YGw5Axpu4YJO0hjxL77xSY9FOiMAIoGAIUo2SVAeBZmHqmM2NP8RLNdIdVduR2rACyxAndAp8MnLj+ZqfDobb3VTbDoGR94Qr7ikdAkrd8Kr9pKSL4zpD1CWlP4eynPG1BWo46Q3lsgwGUfzWef+3uTXOiuZnwf7RbT7tBIJKQ5s85hYcfJSsqDgDZRS0NAPZe2D1W7/mrVSGZLQ8N05S0Ta/668hNJbkZ4ia231AF97/C15MJuVhjM30UGnpfspENw3s3Js0xJb9oj3tSXi9s+5hv6aL1esAotaXTMqLYGBlAdtcgmPnLU2X0ShwVa7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(136003)(396003)(366004)(2906002)(4326008)(66946007)(66476007)(186003)(53546011)(6486002)(2616005)(36756003)(52116002)(6506007)(16526019)(558084003)(8676002)(66556008)(8936002)(31696002)(6512007)(5660300002)(31686004)(86362001)(478600001)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8dXcFh2GMfM88hTOMpUXUEKUPuqcfxZ0XYKXGvLDvwEKsqDTRzp/RhuG1v7BV2i1JMWnFaexOV0S1AaLxZ6MofHWb3szp5aunN2KzJjAHpFuc82/hSeOeEzwyDsIC3SarFmSWZ/+JDZaypxjD0EYBCJ9igSSUL093i99WnnsweslpfRnqW6S+mNLWCVT++Dp0hmCtTtauZeigVzzrAHQX6JfEM8+rJDbcKuqw6NV1sBf4Akm/FGSte7QQMiMb3/Pvp9RSYvgn+Ql0x4Ssh5rRV08+fiVxwY2IOVoXwIG59OVSv0C4n6whCWWOBxb6Rt1Wh9ebtAavFRLmVCXUOs2B6BT89noR1EFe4ZX/7v8GcomUzaCT8aCLnUFXcquDworuRiyA7U9/zB8NK2TvJmd9LDzzVT8smP+NQ6RmIyiVynKTLGUDyugIMAwc6/vcRUSRJ2p1KleV53nnjXBmXztKZPRBlHbW+8EKqxcpZ30/b4IFT5x34OBbwIj+eZZCpQctM4TukJ5H4IHcn44Os4ZdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cfa351-d4c8-4392-7e25-08d7f8295fed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 17:08:08.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X5JTaFkwBDfjvYuIrjRK1ncmq3WpQ+uHdvfZNz2kWCu23GIn8k2fplYGlBJmYv4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3414
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 cotscore=-2147483648
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=922 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140152
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 6:50 PM, Andrey Ignatov wrote:
> Test 1,2,4-byte loads from bpf_sock_addr.user_port in sock_addr
> programs.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
