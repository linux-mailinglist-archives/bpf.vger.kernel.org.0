Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A2A332EFA
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCIT0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 14:26:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27638 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhCIT0Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Mar 2021 14:26:16 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129JJTWd023546;
        Tue, 9 Mar 2021 11:26:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=u1s85DU5Vtn5JkqUtQorEvT3s7OZpjLLj0kqyxuNHxs=;
 b=gJMoG3gPInnNPVFjRYGjdzpFdjjbt8EiT8jg5pFjco94BHWa1HAkqkbCibf7ux3cX5Xm
 ZTcxajt3mkXqoDslH/X3HAoto2GbaSXpFhbuhZN9UusNt2KVBIh2K4eQMIxKak56ugUY
 y0h71Rfz6EcK2GfkDsJ+JKH+Ls6kJ4wDuFE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 374tamvsg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Mar 2021 11:26:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Mar 2021 11:26:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8JcSD1Y5dMniQUZvKaV415+FoVS6Bh1b2loRoK9Fk5FZ/RgZ5g+O4vz1WZgCXucCQ4JZsTcw2CauebokGQyc27/RQAW0zdFzQUlY2z66L4zkwK08dMq5ZXdtXtizrl1eNFHvJKk95y1zWh+WJjAWy8Y7qQDWyrQ5WErD7rGNrUju+LhlwgFMdIlYu4pwn3J4jDGR7T+krykE6HJRFRAut3gSju5V/Xn+7awDRdP6BzrvXFL7SYdwaeg+ss9UuTPq440cRxN8kzvYyBdPWuZFl07uluUZaBVPfdEW8MiXRZmhrQvrxRjQM+iVhV1Hz/6EwaRD8F66fdRetEjNxSCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1s85DU5Vtn5JkqUtQorEvT3s7OZpjLLj0kqyxuNHxs=;
 b=a1Dy8IXP7hyzChPkjSc7+tEZnAV0XLmQcHRDD3+1aJSMYVagSqWt6EodJtGHQT63NJRaoCDEqUbxdu3nv+/fiRxSAXmyogAHMC6+7jvNiBbACZM0NXbJNX+LW2aPjrVfYFZd3NOZfz+az7HwzlYD7GvzL+rcc+hK4Iwe9HStjRShpY3Ewq+715+uVI9XWCXePPNDLDjQWKolwCl0ji/v4DzUKTMXN5OMhm+wwaAgmvqw7pPsFe3FrjP7kk6ueSpO7uXLVi58wG0xlPJhZf7gMSfl3tuynUliGwuVgr5gCx80KyKAtPEYm8zRtzUECIUNkC2HPQkEcjz3kaltxlpB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3224.namprd15.prod.outlook.com (2603:10b6:a03:105::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Tue, 9 Mar
 2021 19:26:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 19:26:00 +0000
Date:   Tue, 9 Mar 2021 11:25:57 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf v2] bpf: don't do bpf_cgroup_storage_set() for
 kuprobe/tp programs
Message-ID: <YEfLxejCYmQPGt7f@carbon.dhcp.thefacebook.com>
References: <20210309185028.3763817-1-yhs@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210309185028.3763817-1-yhs@fb.com>
X-Originating-IP: [2620:10d:c090:400::5:a938]
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a938) by MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 19:25:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6847b0de-5e52-4719-8e3e-08d8e3312bfe
X-MS-TrafficTypeDiagnostic: BYAPR15MB3224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3224E181C6BD4FD6F403EDA7BE929@BYAPR15MB3224.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wECY49YhgT79SF+REzKHXJ/qmLEcUufSo285CofU/fouRs3c5kM9A4NuQo0Pv6pqFC/mJedCMtAZcjsBluncTPKMmAkjXXZVGkIhFi9mzZTZya2J0h/MK424YRfeWCJe0BRmfRe17A964QVCjrh2vjZjRr4mXD2/6paRWvVLYa4RLIUQClhqsZv4pzt4Dfw0lTmj4W0AaII8E1dYzZzIM81MrtpfPi1Pcm+bkGtYJakK/Dj9SveVc5UU6SRNSRg+0XI4pbYq3nDBPF0ySzchy7N1VbwxGruzhH0ypSknSXpWc1xaqIiFC1TtBsk2H814HXKInFi614KT3ofu/1pQFMLIOFINO71ws9XbW7nLo0DEjGceiR+H2nNVsp889YNnN5NrufDGB4QlgGD7DxZJ7zILHqaNuzyOKST/q7OOfzN4RPrY4T76UnMWQQ+j12qOo8zs2RsrCp0KR7wqfJCVpDCkoerOa94eErpchgwj4zkvQfYlsQbj1VsWWAHQ0qABo+8CH7vsMRfhZ63lSNZrW0FqG7CQMVoWrBtfwvXAyfyDkDGul2sg88jJ1r0ZfJZwaA0XtwWC2g4bpvyEQOY8gNUHTjbK97LA5OKm0EWLgCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(7696005)(52116002)(6862004)(6506007)(9686003)(55016002)(66556008)(4326008)(966005)(6636002)(66946007)(66476007)(2906002)(478600001)(54906003)(5660300002)(86362001)(83380400001)(8676002)(8936002)(186003)(16526019)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0I2nPx+EiGN78bhacFVU0s9CG33JRUElQ3F3wunCQc7bjNnxJYYbgK2wKPKa?=
 =?us-ascii?Q?FeprGs/TWKG1ZaIA3w5IJJJ3QiPCJrKzYAem7Jajrz3iySRiOK+dQBAL/+jf?=
 =?us-ascii?Q?Bi6cp/YFmsXcwaY60zlnl2ReYLLUxrk4sgMx3z3KAA5UDq71cQAt9deQEDVJ?=
 =?us-ascii?Q?zPtAi4TxUND9vRQ4YpMUD1a1Ar4bT3XJwy2QyU/i9ur/6p1u1z+rjFxTfd8c?=
 =?us-ascii?Q?nwuy5jAe+cPC9W7OJIJPgfniuEvbd9UBAgMrzDV0WN/dUI6onvVWy3Dyppl8?=
 =?us-ascii?Q?PoYkgEZoq8Xa2YkWx2By8HZYm0xsk8k+qaGeFi0CgB7VkplGpFZ7yXq+UjmU?=
 =?us-ascii?Q?gFvKIDAlNPQ6KKcbB7UHLyrqEW9Ylcq3k3dFs4PEjSxrY31T48/G0Gqr0BGq?=
 =?us-ascii?Q?4FP4Cl9+Q/PYqbRD4ftVGr/PaGY+NYBTYcJE+50kgk2+HA8PssdwC7tX9Wav?=
 =?us-ascii?Q?zT4EDtXyevDc7MVtEKe2Zff3HTsoRf7TbnPS8N6Ek3e6HbiSDiiNb/OQVHwL?=
 =?us-ascii?Q?KOU2zQTak9kEq+rUNtXP9R936WLGZVL4JibUcncWK77yVIbshE63ITUeaj5h?=
 =?us-ascii?Q?hryqUNZSxfSC+aXVl6RRCMJyPbPMROpc9o2wq+soxqh1IhJVv2jS2qSDbOk8?=
 =?us-ascii?Q?YX5UD86EQosldqtnqLxp/R+tWwRidigW+tls/lNUv8edfXWkaJzLOZUC+gdn?=
 =?us-ascii?Q?8SFk1d5lyN/hxi58cTAmhQYQXEdkHQCaI1CLWbLSUqVpHU/GoEAIR9Xt+lgo?=
 =?us-ascii?Q?fdMNlj6aZYjQAYnf+rnNnFGmXur0NQD2+0fUgcs8BeEXWKtg9oSaw1g9S1Ef?=
 =?us-ascii?Q?bmv1AulGg+oy2k5H6hmHduZPrAyY8C4I/G8kuYrlQIHqpryAjihspQ+Aw05T?=
 =?us-ascii?Q?amM79tkP31O50d4JiLjzGLfz0787uADlZY+kMjgJ9mA0wVYfcCGsfch9DaxZ?=
 =?us-ascii?Q?CaJjfiinbfgYrDMrOBu4GeeSeJZeezLOtqy3PcX/WQ6K4AJHY3btvETpJ2bU?=
 =?us-ascii?Q?UTLySFdfGmhwRsYAPzpzqW6014CL8wCe6VxHnXQGK06+2kpNfFB7J6+JxaeF?=
 =?us-ascii?Q?oGz3HhXP5rTVe1hOrWDwAWkTeD5CJxF1PrfIR6ZE7xXZKVIKbu0gqJ/kWqNK?=
 =?us-ascii?Q?UM6i/XnGacWrZUcKglPiDYhMw1oSjuvAtSqhIdL+rII3/qDjO4AnXsiMp0lF?=
 =?us-ascii?Q?rMmeUkY8Cj7wJ8senBOlnY54CqnMxcJp1zO19WY5iJzXySrif1vAz8VaF7Hi?=
 =?us-ascii?Q?+3Yw3Remtl1M+w9gpngv0naucKyiv5t+vAI1QoLyZdYDPfJE82ng85nmh2cu?=
 =?us-ascii?Q?AZJFiMTcohdBCe3gAc5aWzTsRHH+tjpd8ui9DHRALG5gGQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6847b0de-5e52-4719-8e3e-08d8e3312bfe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 19:26:00.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UdfL95I5PZVa3vK9Fjchd3y9XTAGImCnXBOGnapvTEBmDFWXea7/ElZm4WMbtTl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3224
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_15:2021-03-09,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=878 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 09, 2021 at 10:50:28AM -0800, Yonghong Song wrote:
> For kuprobe and tracepoint bpf programs, kernel calls
> trace_call_bpf() which calls BPF_PROG_RUN_ARRAY_CHECK()
> to run the program array. Currently, BPF_PROG_RUN_ARRAY_CHECK()
> also calls bpf_cgroup_storage_set() to set percpu
> cgroup local storage with NULL value. This is
> due to Commit 394e40a29788 ("bpf: extend bpf_prog_array to store
> pointers to the cgroup storage") which modified
> __BPF_PROG_RUN_ARRAY() to call bpf_cgroup_storage_set()
> and this macro is also used by BPF_PROG_RUN_ARRAY_CHECK().
> 
> kuprobe and tracepoint programs are not allowed to call
> bpf_get_local_storage() helper hence does not
> access percpu cgroup local storage. Let us
> change BPF_PROG_RUN_ARRAY_CHECK() not to
> modify percpu cgroup local storage.
> 
> The issue is observed when I tried to debug [1] where
> percpu data is overwritten due to
>   preempt_disable -> migration_disable
> change. This patch does not completely fix the above issue,
> which will be addressed separately, e.g., multiple cgroup
> prog runs may preempt each other. But it does fix
> any potential issue caused by tracing program
> overwriting percpu cgroup storage:
>  - in a busy system, a tracing program is to run between
>    bpf_cgroup_storage_set() and the cgroup prog run.
>  - a kprobe program is triggered by a helper in cgroup prog
>    before bpf_get_local_storage() is called.
> 
>  [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
> 
> Cc: Roman Gushchin <guro@fb.com>
> Fixes: 394e40a29788 ("bpf: extend bpf_prog_array to store pointers to the cgroup storage")
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks, Yonghong!
