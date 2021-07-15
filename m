Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3A3CA1B8
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhGOP6R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 11:58:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10956 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhGOP6Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Jul 2021 11:58:16 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FFssna028447;
        Thu, 15 Jul 2021 08:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eIVqMXl5Rq9i8FeGjB6umCKiNfVjwJtoH7rH/hdsrD4=;
 b=DVNPFoRGIwE4/XPr6A/vESIxZ5SHn2ye6hozzItD5TJkqylYBZguvLUxs6d+Z5V0mI2z
 ldV/eKL3i31XH99N1laKoaA+lINJmDWH/mCerCNaTGZcaZmOWEuQPrLjg9RAxCuFDb24
 9m7PLjxCI+IsqxcH8PUJzZnTv8yqjDTdKMs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39tp5g0sw0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Jul 2021 08:55:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 08:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX1LFANujTYRFskgMBFy+3uoGcSrlFXQe5wI2EyLJcRtkrhJWO3XbWW0RVFZTeiEaFOc/goZolrfhJGCd5VaykLGsfP35Jwcm+w+mhxdQ8n5GvJ9KuoghAKSmAjdE7l4Vu22QqJTYC1pD87INY9SaPp59TPGW5vgb93U9k34X5X6me4cMiT06Fv+gtZGAiZorvJmV7abr4yIRW4cfIDrjopJjyRH/WMiURaAQaKS6ED8Netr2x2PU5E7OSnRpPMmdZO4xh/jdyDUbyTp7ZdlIJR+jN/0u1SnmoiCrn5T6sPiH1LnRhFaK7F8VSwMrfiurhh4skWKM3XdoK7oQY+MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIVqMXl5Rq9i8FeGjB6umCKiNfVjwJtoH7rH/hdsrD4=;
 b=ESJ1hH055U+cmV2xeN5iWvsF4I2yBMp1aKf3V4Drvkfj2K3jIpC7vTjPD5MrAzkWdlnYbmkSfgN3mziuV34W0Ox1s+ICNYCYiuobdNwVNwiiWN7oC8HJqJSlCTACsiSKqsxUcgLc+bWYaP3v+sfdy2pjHiHU6ntf629cAHK4rKrskjLSjd/aXB+gFK2vF3YWV0AX7oxq11GatXdk9gTGDObs94zKYHEDW+vGDAb5XsVMv0KDvQQAiF2bUkangpB0enH7twQqbnEaH7bOzp8NZTZ0MYR/A34bKg1AZNNPnYxxmWc53Ahju3B490tuwBQ643+R0Dw/GU2LOv3mrtoW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: distanz.ch; dkim=none (message not signed)
 header.d=none;distanz.ch; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3078.namprd15.prod.outlook.com (2603:10b6:a03:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Thu, 15 Jul
 2021 15:55:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 15:55:07 +0000
Date:   Thu, 15 Jul 2021 08:55:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tobias Klauser <tklauser@distanz.ch>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] bpftool: Check malloc return value in
 mount_bpffs_for_pin
Message-ID: <YPBaWIO6R016sYSy@carbon.dhcp.thefacebook.com>
References: <20210715110609.29364-1-tklauser@distanz.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210715110609.29364-1-tklauser@distanz.ch>
X-ClientProxiedBy: SJ0PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::10) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2e2) by SJ0PR03CA0305.namprd03.prod.outlook.com (2603:10b6:a03:39d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 15:55:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b66d4a38-9900-44fc-2f2d-08d947a8eaf0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3078:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3078C6A82602243E4D365121BE129@BYAPR15MB3078.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHskMA5h7tlxrZZaSemI6y/FQzc/e/OptdCT8IaCrIVoK5WATxb2DtjhJc0YY1Kw8YkNkBQlFlI0ZqlcL/ofZSwgeKLvD1oya988Tn/0Jlam5Sd0cVTqlVH4O6HA2iMnUoKD9nMdlMrQpnPrS99Xt3mpnNJ8fyCOnLQ5qs8m2rEnNM/Fz7Nm1tHeT+Uq2o0kdqfrKs6X5I2y6gQCchhN60ZvTmljVlRtRRpZjMCTQI06NZRB/E7bTuTsYlRWAhU+e360gjo3BsI2nbQftAtz0QwT8UpDic/0ZejFl+13uwjDzRReQbnsOJGXTNdB/BmyUsZWiaEcX2vHWcz9zB0Zcx+6N7yOd+E/xfJsO0bHEAOAM4JiWKFaSzHc58+r/Vc37Es6jX61fNCzC8Xm2GHPQhJE19d/SYtbVMCexCTIIByRLiyLL/eYHnpbiMU8IBF0ZZNzJI+it/mfPffscht58tJUdWUfwjCGnwKcsk8NvM030YqGgrCFTy9ccnW/1vYHdooEjo/HdsN2lCs4C3h7/SlEfWSzUiYYJv543xyCuVZElcytLczSnEjrtNyZGpS3cJM7Y2mOwWWfP2a88PZ2viBzUDkPMSCA2oOMUKXBQER2S5c4TbuntM1nV1V5qw1oStsMTlizzzfSnWZj8ADfbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(9686003)(186003)(478600001)(4326008)(2906002)(52116002)(6916009)(7696005)(55016002)(316002)(558084003)(86362001)(66556008)(66946007)(66476007)(8676002)(6666004)(6506007)(54906003)(38100700002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCahUbv5zb/rnqnhDjo/NH8pO4aOQDULwFJDOAr9DuZoHPpUBbYxqf0Xnx+r?=
 =?us-ascii?Q?FZHXkwd31ZO13Wyfae9+ZRPjgSQqIOfQqon0TJelsoiMkKXt2ub9fSPcJXOf?=
 =?us-ascii?Q?hNCYpJqBlO8vdc9IaOB5zy9MKTrmbLM0M62ReOOI+1eyGHpVKbGvsB3mi0QW?=
 =?us-ascii?Q?7d0iT/sVB0kLlTncqJvctQEP/AZFzYsQ9jOzTWthNYUxNDwtCgXK8M3/KmPt?=
 =?us-ascii?Q?topw83BW3pv8dZu/MnCAJSdQwg8engihc2v5bmvW7ptQ/+6cV1W0AcsX4PWA?=
 =?us-ascii?Q?tsjbgRC63t9myg7ex3Arr8r7BPknb16IOrux5fWiHjg5BqA8k7pERPR91g4+?=
 =?us-ascii?Q?vhhAv0bKQXRnRRLUW9eT+31NwnuONf3fFVMC0RIn/Mzi6ng07kVKrhEkZSE+?=
 =?us-ascii?Q?+89cePuWM3IFGojK3nP+qr7ha3vB/mHoA82Eel3KE2pwm3zdNyYEWBmXLrYz?=
 =?us-ascii?Q?8h4SWMwlP/PypBkZeMlRDeLFg6f4w/a8SEWBiIGxI7XiCSpRGa0BRbtN3JOY?=
 =?us-ascii?Q?LZVxWhp9JvgblPiZn6GkfueacmySJZ64H7UcNJqiblUkNd9dGf7X1vBprXJV?=
 =?us-ascii?Q?vGZFyQ2Y3FxsKW2tg4ZzBLbwBQ3crxBdWsviXDae+lrTqlVboY42QoybxbTG?=
 =?us-ascii?Q?DZoiMQlXjTrAYmBMLhcnkebhUCn+e75E3PLLjL0Zc/pIM2L8c1qeWZuMouxD?=
 =?us-ascii?Q?IXpbl6qpEAxyKFjcSqFexlaO4UqmLN67vCV+BtvKqua4IFfPzfn0qJPv3aj9?=
 =?us-ascii?Q?+cXBX8hM+lOKvg5DSFLtzRbszVvMccKtdkTP/dxmAa7JZyWAts/VM0ueBFEA?=
 =?us-ascii?Q?mhrRSCP3h1WEpJGH2AHRfqPm7eXDSuOgDz7/JbQDljMUDJTFkQCGnDG1FDB3?=
 =?us-ascii?Q?+CrqrX4J2Y8Woie/4jrFv6aJoVs+9Z5xjzRx+s5fhgUbgG6EIQxZOm9Jt/Jj?=
 =?us-ascii?Q?W2t70foWi+piCYHW0kMyNchaP6Bm5T4B+R9J5CArg4C474W1grSTJl9CoQLo?=
 =?us-ascii?Q?fpCgT/BUcyYQAgUS+FMxnFzd1F7wR4z2z6Vp0sCIW+mTMET7sp/PNrBISFXa?=
 =?us-ascii?Q?pFf9apXhMwPpq192ud5ppkNi3B9fobx/KmQAFes3q+U4relS1pDOJRno8byY?=
 =?us-ascii?Q?DXWqGqCHV25XoiVgmVmB8khjFUZCitOAOPs3ZnTlXqFTWvP8IkpbHUhi/C2r?=
 =?us-ascii?Q?BChRA0zmHEc0ETc+4n/c+jvqIplKf8wqaSsYoqJMtAGC5rOZgYSg32GDO4n5?=
 =?us-ascii?Q?iPs559fryrR7c1ajXSSvW2ZLldZy1QRmiEt2MjE48OedfBjtSLCt+bc4W0ps?=
 =?us-ascii?Q?3c8kxR1ldVSlSkx+O3I2UwcPGM2/OS3kWvhvL2APgpKdlQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b66d4a38-9900-44fc-2f2d-08d947a8eaf0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 15:55:07.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgbIDzVYW/KFDKixEt+LccrHiUiEL7FE6qKK1RycJ+VBxcSRz6hBijEbvGFacgVg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3078
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RtkFoIOyU_s5k_D6SNtfsqQmpPgi8bwW
X-Proofpoint-GUID: RtkFoIOyU_s5k_D6SNtfsqQmpPgi8bwW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_10:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=873 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 15, 2021 at 01:06:09PM +0200, Tobias Klauser wrote:
> Fixes: 49a086c201a9 ("bpftool: implement prog load command")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
