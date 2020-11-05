Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162C02A898D
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbgKEWIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:08:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731508AbgKEWIt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 17:08:49 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A5M8XkC021436;
        Thu, 5 Nov 2020 14:08:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qqc11MGOXeMy+jqG9TjFb4KUaOE4ezmRiad58E4zxvQ=;
 b=qGXRsUGt/A8AJOy41MklJDneDEu23UqPkYcWWfONPotaLrM+l3N2THwP/nt7PgwwbMdo
 VH7n0e5Dol4+WduVlqs2JtQ9vAqe4QiFQNOcz7MA/MwvK+0Mu6T1VlEsbCvdRXxzfcoj
 Mj0XUu7GgXvo18ETapU+c+vvdwjKerdxddg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34mek3452v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 14:08:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 14:07:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGaARhnRnUtCSKuWhwrN4+12HnslW6VoFkR63MJLaDaYg5zD1QEHUIBWUzqeZA5dMbId50l5E62TL+c2THr0Fazxm1WDbpwg1/dnOSzH6bsAERMqK/UPK3uOlZo09K8IJKxHdqTyWmgKKox8bDuzs4xBp2P/fONUIhEJSGIWmyVbm1hDEgRIYBqVMC+BjByxGOkL1kQe7nE28GRjuv2YZzzfFppAvJT1W7PnM+dBql/yZCim37xKOwvigpv2TCUcQ52fSWtXf1ywQ6P9AxXdePL1znKFnRAvsnAmLqjQkf0ElIEUopVqdMyVKQT25USMyxm5t5rmvX/y8YJUxNuVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqc11MGOXeMy+jqG9TjFb4KUaOE4ezmRiad58E4zxvQ=;
 b=BIQzOctbe3ogYIgPo4DrK2ikQg7UhWV7QSiW/QpUgXNn+VIiHnQqGd4WRJzZzh+835VTZsERj2B6+EVIRBPI+YPRNONBCu8NFwz8daT5MwdpD0d+oFiUUF4uazPjSiyTVBV5qscw+rC4QmMPLTB/gA9PhUOW7cfHUOEHfJq+bsFg5rnt0jP+kceP+tAqBQ78EPWZJc62duu9kOnh+krR2qmlYhI3i49vHuNAM3/8w79Z65Q5V3+5vRJ+l8A6vKVEY8Tj4FxCC8dGqfRcl4RSeMiFf50amhcqvTxwxCZYEyIB6K1Nw8wmVZcdssPz1qMtTHrSsyip1j8eOjhCxOkPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqc11MGOXeMy+jqG9TjFb4KUaOE4ezmRiad58E4zxvQ=;
 b=OpmQZTGsdYqxEL0ejW3hW+6HiKKHPn3t2u7DYN8rSgM3UcX1ZrFGAoTCM5NRSv2eFg5iXVQMkBjneQemCsCaN1qNH/Ox4AjwxxVuLD1+A3r1KdssFm0hiUWKy+7FtHwe8laYcml9js2dci4Ng9oJrqdEkV5j/PbCxxFM9IHtNqg=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4202.namprd15.prod.outlook.com (2603:10b6:a03:2ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Thu, 5 Nov
 2020 22:07:56 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 22:07:56 +0000
Date:   Thu, 5 Nov 2020 14:07:43 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v4 9/9] bpf: Exercise syscall operations for
 inode and sk storage
Message-ID: <20201105220743.x75mr4qmijaf52gl@kafai-mbp.dhcp.thefacebook.com>
References: <20201105144755.214341-1-kpsingh@chromium.org>
 <20201105144755.214341-10-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105144755.214341-10-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MWHPR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:300:ad::30) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MWHPR15CA0044.namprd15.prod.outlook.com (2603:10b6:300:ad::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 5 Nov 2020 22:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67783dce-51d5-4d9f-0d72-08d881d73fd5
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4202:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB42024A9E64B271E9D61A2EBAD5EE0@SJ0PR15MB4202.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9WjRS2dN3yd2aqeV4dQiz6inNmxC0fAQ4BBLouieNg6uIiyzcXWq0tWLlnNfbOgH3Sm7tql9Ap84yR9jRHv8Rd8NvGVxanJpH+ckQ4yUecnRAmRD3mRLBgJaLosKiO6itdayQGXz4CIk0DrYnl7L4cnDs8dyBWtTtfBys+c4sEOZhLreTFOR1qoLM1HOEQ9De+OJgy+ASUJWtEDvbdM7dUg594p0uRMG5yvAZSjIsIQoprtFk2KuBx4aePUpz/J1eCtcmYk8PwzfDuXBziMQCWwLvAuQ3by0QXi3e/4xKqzyrByDH7QrczoBPjLFombcBpcZuCggJhIVvYjuz27dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(16526019)(66476007)(4744005)(1076003)(186003)(66556008)(6916009)(86362001)(66946007)(4326008)(5660300002)(55016002)(52116002)(7696005)(2906002)(54906003)(9686003)(8936002)(316002)(6666004)(83380400001)(6506007)(478600001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Q7Siomu+c+vAWe4YhsciDO0tqfWgCA1dd7Ts1f4J7qG5bMExGvVok2R/KSluNPfgkZVBhqBqauJcSYtlhw769VZIujI8jrLgljlL0f50CBCmXObb7ZdaxTQg8nv5qqNxvGjcDdGrLjCLDlgnZVeEa+JMFNAP/E34n18GMhqQW8DmFMIBybmAEKvk+Wzt9mipLeUaROVNpUCLK4kkyom2L/KcHkPzufUqPidvA25bH0H0hgsKvUa/TM2oWcKFyRkTYx+j9ORx1KSYl3KFZuhvD6kdtVY3ImEYEFP/mP9kvktZtWRVkI/CPyANPSGe9dvv0w+w269o6bgC3AMGLMcUgkGTfFBDsgVIw8lHXKDVlLnmbmganjoKCj2vh7K/ldZkg33DVi65LRZpV3fv6pVWy1a3BN81uQ9BTjQbobouIvk0l8bEdfQpzZNUdLozaKkEKWtuoAXeIG3mQG6JoI1n5j4h16AKNNhd+UVFsMY/bN97DGoGEJNOqUCsarfHkRocOtvuz9B0P5Aq8CQTCPw56KO4i9DJfIaN3WQB7zi9dxuc1uDfetw59CUhLsCaK/Ns6RuGihYySP4OOdaWHw9I77zIFSzLgZOj0rjBXX4OGvFLBKTyP3XUDazQXYUwC2kHPKshE9ASCPBn4Gmt/tzlEJtiR7mmeHDuaSoyikXrvy0/b3daCN8k0OVkaD9Y1Uxc
X-MS-Exchange-CrossTenant-Network-Message-Id: 67783dce-51d5-4d9f-0d72-08d881d73fd5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 22:07:56.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wtne8S2v4Ma2UU9e469+cl97ZlEbk64iIteuItcbFg8AA6AMSi7H0hK84Fi36Pc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4202
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_15:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 mlxlogscore=898
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 03:47:55PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Use the check_syscall_operations added for task_local_storage to
> exercise syscall operations for other local storage maps:
> 
> * Check the absence of an element for the given fd.
> * Create a new element, retrieve and compare its value.
> * Delete the element and check again for absence.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
