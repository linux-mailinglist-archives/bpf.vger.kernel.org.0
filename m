Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF82A88C5
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 22:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgKEVRO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 16:17:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKEVRO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 16:17:14 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5LDpDp018468;
        Thu, 5 Nov 2020 13:16:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4vHsk7NmuZBUqea4IHFtpIkqUEGXf61XVUV6V6/7Ze0=;
 b=aLwiNexOMKSGXPj9vxXj27caB7YChcPbIfMcALvWxNd7MM4Z2qJikGPnRJXGULAmnytI
 f/ZbSvNMzMyK8kuEMvfOXiBYCIjQuLKeREweDWesQbLWIZDVN2hcZL1Bl+rXMOzTxiOF
 +QT7WXD2hs1KeKwFSy3ns4ETHnWSfPHAc5Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34kg7m4eet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 13:16:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 13:16:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0RmGd2F3Tk2aGchmf0st8OChiDJnUN8aj1xfFGOBH74dlfrlQ7oCjx9PQ7fdqWKEwJBwwqoCE2FTrHeM71w5xdo/T6AMUCsEn0fQ4mxlSmxE6bvyxu0sGmqdHnCK7jUN5My3QOi5yxv6LSwrHrzbB24lP34bfgINamLCrpKAtJ82Cj/oJvkQmVXdIPJDHRA3RY1GQOKuPCwKKo18t0s0g5QK7Dpt6On51mV5T0GrErMvjO1YKMDTmKKcWNLVFLjoq/lKKL9eDo5i9TrdS3F1GAC0Hh4iAKWbE2itb+TgkYHfbDFukMzPyOWtyXDFXHSXx8tgujKqTfVCKrTZeciKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vHsk7NmuZBUqea4IHFtpIkqUEGXf61XVUV6V6/7Ze0=;
 b=Qlx965Az7CuORK0tWDtD/OdV7v33+2R4HD3oDcKvit4x4KG8xNzY6/jF9pbA6MIe2NNCJ6/isiPZS0yEIg+NV9YFQO69BpxGeMoqAZ6LhdZbSm2inpeCQEk7FuMkxc0/pVV37mzYDq6I0H3e4XOtYMA3djmmge6EoqHDFiv5SWiSYm8tMgAvQqj8L59ZnzYEvDI1DzBt+oV6n+iD3eeqr6Zz7Dpo0SOWHh3LgavjOP0coX/KRKrqrY8+XzTwuUjgefc0QRJTPtEZLekunM85YOSSkPIfcd1Q3vAu7lW0vElQSi6ekCWuzoMTxHq5ZSCsvrk8YHst8LPoXLvbEbCr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vHsk7NmuZBUqea4IHFtpIkqUEGXf61XVUV6V6/7Ze0=;
 b=L6ndOaBJJgfkXA/XxuRAb0neEzAUUstqYKetnN6QGgx6VG6w63K6R/WWFk75X8/ro9IRu2TbPeOgEI7Y/rlrswOfS2915psDxk3nKneCX50Gf2IQma1EiQRlViceXSLwv6SpDFG0xdpmnhkq/S8h3a3qbEvX0DY/AVxuU6DlENE=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2454.namprd15.prod.outlook.com (2603:10b6:a02:89::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 21:16:54 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 21:16:54 +0000
Date:   Thu, 5 Nov 2020 13:16:44 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v4 2/9] bpf: Implement task local storage
Message-ID: <20201105211644.onspyd6cytrskiw3@kafai-mbp.dhcp.thefacebook.com>
References: <20201105144755.214341-1-kpsingh@chromium.org>
 <20201105144755.214341-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105144755.214341-3-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MWHPR14CA0057.namprd14.prod.outlook.com
 (2603:10b6:300:81::19) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MWHPR14CA0057.namprd14.prod.outlook.com (2603:10b6:300:81::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 5 Nov 2020 21:16:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdf136f8-84e4-4bc9-a959-08d881d01e63
X-MS-TrafficTypeDiagnostic: BYAPR15MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24547B8B74DB5616D97F83E7D5EE0@BYAPR15MB2454.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLen14Rq4fW54mM795UmpBqWOO+f/ZG1fxYwqWcee+/OQbiYUT0AJrMj0iRqeLV73/UhXUIX2307Xq0LYqBlu6Jmag2RdMPfcDn4SsjibTiok8i9RLSLh+EELBTiwv9NmEGsJ5Q8aNPV9+wqRQhqPcEqJIu6KGV67dukXkpvCAgjvSIrY9FU1h012AynbA/No6NjDI+KT+7agf/MbYvP6u+0Te8gPfui/z4FrQV48WN5zkgEKLo56GDYLgN3R782kU1isDXk4uRntjzFG8qFkMDMkB5q7eWa6qE7CB3d5luFNxVF0/ZIslEhvO+7//CjWVQlr7AJYjRp2isWcthDGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(66946007)(4326008)(7696005)(66476007)(52116002)(55016002)(5660300002)(66556008)(2906002)(16526019)(9686003)(186003)(86362001)(478600001)(6916009)(54906003)(8676002)(316002)(6506007)(1076003)(6666004)(4744005)(8936002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WI6kTQMpgFC7PjMFcqc0GRO2vzdI0KxV3ukoYWSPDnywjiB38comOzdBKAGfVSvLyMkYtAiKl9xyC0vE0f8o8KcFrR9N4lanzJiOf8wWkmejMVvUWCEWkZZNHABxEekL4S0xmGzuAmmJOYzXNGSebMz/XxrskYGDm3S6T6TRLT3otc3kU4BDYct1TxvrvbN9cox8+bvPykVrDRwGKrVoUKGneb8YfBDNU5Pwyhv7iPg1aouBwZl9XBvpz292y8yir86q4PR/fhJ1aUf9bNOWdMVFPIbWR/zDJk9hY6cnlhFDuc4hmCYGgPU46G9f6F/IP+7ZuTJrVmE/8zMTa/xw9t3vuQTO/5p5KMuBlywc5ytSn/AsDgD0Mn4ogkAIy1pMBdx0xn7djBR4LsCu/60UlrbR3SrkLtgVe3+1Mx3jFfsFTOIseiW0qbln4H2w1hkG8C+NivtQxt10n+DQwhuNEtNBl0P+NcxUlCo6qTtD7NacXhGry+7MFzO8L4ej9tOypbf7g/fXOpK1RAiO63FuK7aFKRb4oXbYKBdNXD7R0O5AlyhG8e89gOGE3vjIVZYFZfFCA0Igub6q0tyHFGM/C7hzd4IN4T0NRQ4AtsmLe/EkNt/SlYUz58BouUs9KSJnFAIDFXiB9XxsUDcMAYZG4kQ7gOWqCPYHvJq3AKcnoA3os4Sa32kMvIERVki/MKWn
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf136f8-84e4-4bc9-a959-08d881d01e63
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 21:16:53.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEG7vnH+Ehm7xZUz+mxYY2ZO1FC2ikjGzH73ErX59nXZiqLUhlH6pR6om8Do0c5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2454
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_15:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=5 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=509 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 03:47:48PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets and inodes add local storage
> for task_struct.
> 
> The life-cycle of storage is managed with the life-cycle of the
> task_struct.  i.e. the storage is destroyed along with the owning task
> with a callback to the bpf_task_storage_free from the task_free LSM
> hook.
> 
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> the security blob which are now stackable and can co-exist with other
> LSMs.
> 
> The userspace map operations can be done by using a pid fd as a key
> passed to the lookup, update and delete operations.
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
