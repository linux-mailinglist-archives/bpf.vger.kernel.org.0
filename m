Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4218FD34
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCWTD0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:03:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbgCWTD0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 15:03:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NJ2ppp024870;
        Mon, 23 Mar 2020 12:02:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bN8VN3EvzY4NLbXHxXyp9pZtDhtO9JLhyvs+Fwt/yic=;
 b=Z5ItajgSfqTjda/oTNl2GFe9yRDA/Arlmy8PoNLC3zXdmO5+W1j6LDHfHmCQ5winB90M
 PRVveAnjF8QbcWeyBC/L3EZIh6lW97AVXenbLENMgiYjBQveiJvZ5CkMJlfxga2rQjwp
 +nGhOfcsUqjwpjwLeuZ4arimydMPHURCuu4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx2xy6q9j-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Mar 2020 12:02:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 23 Mar 2020 12:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iln1j80IYC/ZcK4+V2MWGA3Mho9xqAxNK9BNN3L9nEGkllapSl+ZHTVBJMjwSCQaMHvl/SrbX0W7wzN75UluG05UxnvCe8AW4yNmYX1hUjUu078ggZKWTI2lnEqFwqAvXYlMBw0gB0n6F07aOTIyUOuypAVeHvmh0VQCTjtbfNAEQnQnMReMZPxCe+sQ1kD5yQeizCqz9RXU8EFucP9f1fjrOZDlFegofi6d/7yBA0o1JvdIe2WKrg2WuI9QO8f4eJtGspKaQTiAi01ifIXYCV//QjeT6fYMD/PuKHuQLI8gzhw0Deh2U3igBgt4sFDkR8wBUcpQXm6VPR8CHQh1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN8VN3EvzY4NLbXHxXyp9pZtDhtO9JLhyvs+Fwt/yic=;
 b=KbKZKHjhVbHbgonbwvYn3R7y4nkjzIxDnyZk7qw/2aMVdlaNWaci95UaAK7vjs9OfjZCtHcn6GkpcQaiAyYdcuANSR9sKf0LgREJlzlAKrDeRZmSscBvCsSR93pmnFcy8mymzipV4PNAYaEBFp6XIBEEZCf75zxuIWvzq2My/XeE3RpoqIOnD0P4XrSu0nlapzm0MacX0GuV10sNzI7PcDi1Df/VO52ZZm7dWGzZp4JgiM+3UEEbxIozteO+7lmoFkiifFPdsjMqCqGYmQI2mQYYWYeqwtvEga9L+Nbl2/S52vjSo6OFtsmqFVqb+EWoDMCwk1pQg9ot4ZkIn+D+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN8VN3EvzY4NLbXHxXyp9pZtDhtO9JLhyvs+Fwt/yic=;
 b=CJhQcQzgsqnVEj+mP3ZKDkHRhiqfUTNHDwW3f190iWu/Qmx0SoyENmKhe9bCyi9gqzgOQVvTPEg3P5I5FU5SVG6RAjAVQYB6ARqUCuwptPubgc0FjJIicLAlx1VZniqerNWSAtQiS6kpqdvJFd7CDcj5mU1z9wJnkIAwPDC1lm8=
Received: from MW3PR15MB3883.namprd15.prod.outlook.com (2603:10b6:303:51::22)
 by MW3PR15MB3915.namprd15.prod.outlook.com (2603:10b6:303:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 19:02:43 +0000
Received: from MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98]) by MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 19:02:43 +0000
Subject: Re: [PATCH bpf-next v5 1/7] bpf: Introduce BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-2-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8ad75b9e-5733-d5b7-3295-5d8915b19dfe@fb.com>
Date:   Mon, 23 Mar 2020 12:02:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <20200323164415.12943-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:104:1::32) To MW3PR15MB3883.namprd15.prod.outlook.com
 (2603:10b6:303:51::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:2131) by CO2PR05CA0106.namprd05.prod.outlook.com (2603:10b6:104:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.12 via Frontend Transport; Mon, 23 Mar 2020 19:02:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:2131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32a221fd-3826-48ec-6f7c-08d7cf5cc454
X-MS-TrafficTypeDiagnostic: MW3PR15MB3915:
X-Microsoft-Antispam-PRVS: <MW3PR15MB391563D6666E8C483C708E12D3F00@MW3PR15MB3915.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(316002)(4326008)(52116002)(31696002)(66476007)(81166006)(8936002)(53546011)(66946007)(66556008)(8676002)(6506007)(478600001)(6486002)(2616005)(36756003)(81156014)(6512007)(2906002)(186003)(54906003)(86362001)(31686004)(7416002)(6666004)(16526019)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3915;H:MW3PR15MB3883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hQ3d5oRx2enAqV2X+4t4A6F7yQ7NO0SKiPib/IId+/qcxnwz2NPASeCsZC2XDBiBTC1Xf4dFXj4HlPv+o0VcXNZiH/XcA/JkDwEdds/lJeIvRtyIg8ritkAItf6Vw022/fNkwZ8nR86meMLQu5NRXZjJ9folO4cY6qyBsOgXIZ39Lqvk7yQ4yZjpEsT4sTTODdi2oF48IaoTBdXUihUMocEejFJeYxe4QUOj0DDKlBN24PjpEyd0MFfX0zGm+8GXXSG/ElUCIsyTHlxO+Gt3/8UGT7DOfzHThEGLHFs2Wp9/M9iyToIb/j5moCTqqfrMgfYm/9RLJwHplmsfwOSzIDkjNiJz2A+bXKc5zZNhz6Siret1aXtAJRAVX5aYJAB7FYfWBTwC59GwU3IOV/AmoXr4omcqpj/C5/8rQJmhLUaTDQ0YCzutQD8p3f2+FC8
X-MS-Exchange-AntiSpam-MessageData: GBJSWVlXX+JlQ7yjyOmP9ifn0+bFoEtgFZP6+02KKCfUYI2OPRR5AdlGhH1Q5Qi1fwICX8f5KV7yqlXD1CYih8F9bGJZonlTE3Jr8pRkCOX3iBt2RegxOVPw5H5q1VW42axg3OHnf3yxSHlNU0cf4GuheDxhtTxw/89jj0H48oOLskPga9JQpxGow+Bya6EK
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a221fd-3826-48ec-6f7c-08d7cf5cc454
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 19:02:43.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Y4chj7WuMstKDXfy/bPZxkUd2sy4HuqgVBO9WPGxMlXCCSKKagGngrRggBXX11m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3915
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_08:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 mlxlogscore=931 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230097
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/23/20 9:44 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Introduce types and configs for bpf programs that can be attached to
> LSM hooks. The programs can be enabled by the config option
> CONFIG_BPF_LSM.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   MAINTAINERS                    |  1 +
>   include/linux/bpf.h            |  3 +++
>   include/linux/bpf_types.h      |  4 ++++
>   include/uapi/linux/bpf.h       |  2 ++
>   init/Kconfig                   | 10 ++++++++++
>   kernel/bpf/Makefile            |  1 +
>   kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
>   kernel/trace/bpf_trace.c       | 12 ++++++------
>   tools/include/uapi/linux/bpf.h |  2 ++
>   tools/lib/bpf/libbpf_probes.c  |  1 +

You may want to check bpftool support for new prog types
for proper output. It should be a simple change.

>   10 files changed, 47 insertions(+), 6 deletions(-)
>   create mode 100644 kernel/bpf/bpf_lsm.c
[...]
