Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7732A88E9
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgKEVYg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 16:24:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732162AbgKEVYf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 16:24:35 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5LG56L024936;
        Thu, 5 Nov 2020 13:24:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=65U0XN+LyXnagBgEKEfw6/bRWNML48oXzwGKJEr0Be4=;
 b=Mz7TVtXrngBXWmGJn4aPPcPwqMqp4p+5QOlLVeWPAih0YFIJj2zb+zx0vbd/EGuHDLfu
 oedDrUEslREkVHH2VgFYXH9UtZuXKNAP2HZgr7wc7VkVN3b2xhEgB2WzJsmi4U7POiBe
 K1NEQT8cEokOvFVr2AuCpdEwJfWHQzF5inI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34m81m5beq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 13:24:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 13:24:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnVRKtYLvd5PreQqaqySumTIOwNEEUjeM3i45m4xmG8Ns3/5GWtqcQJ6XEm6Eze/t0L2aIn/Yalf7oJovpruSwkZFrJHaKmzC/CT4XQkNwmq9tH5UxdMwkFeeJ1lhs7t9yiC8lBpjfBMaI43nsVZfcqG0s78ESZGcTCinv2uCM6/vHGBoN7o4OWV5z8fveJLVcHlrEtGeEY0wg5bSvq3MlwAbz3/P81jO7CsI503ZI/xZxczk6lUFdVrz1vJOEzid5er8v/eUFYrCOmsDBFBXozA2Kh+3SPQZImTMaMr25Xgxi3DtfZqLZPG6fnAaKd7+7ymcIauG18SX5ZOLpEIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65U0XN+LyXnagBgEKEfw6/bRWNML48oXzwGKJEr0Be4=;
 b=QgH6yEwKkOlf56M/lcmiqYK+rgKRIh9+YXDLZ3Ih6MR27gY1uFf3jR7llTQsUBJWxHFtRjn4yPYA2OIHPS0l064vsq58mhSYC12TEQm6diLez4qDItkftf510TGuPcL0kLQic+hXmrKRSJam9DqGR3GFoRIJaKAyqNXxPftTQ9/O+s4DiGV4JphxmZeOgBVLGCQxaZ4uby8zbTX44BhwEclB2l2UucyjLAaUpZkTHj8MLwC1z9o0QTgWL975R5MH7x5Oh1fRCmyqrcaGLnVUo39T7AOtnsccOC/AjGWy4zWe0/+6Ckj3Ni8GrB3gOu1QWGxOSXjuOLi2aeM/PItj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65U0XN+LyXnagBgEKEfw6/bRWNML48oXzwGKJEr0Be4=;
 b=hoMQ01Sl3j6enZ1BPUFInYe0eDcU6v3CzdN286k2ueGvDS5YINdUWpchZeTvR7LbznD6L/uwtiLFLU4cfiExQE79xfmWaU2VUIfUyfbJiV1bOee4yEOPqpU3gXjCJ+BTaazqPSAlrSjoIcF3n9010vdWVXKXiNwPG/hRs+3QyoI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3365.namprd15.prod.outlook.com (2603:10b6:a03:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 21:24:16 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 21:24:16 +0000
Date:   Thu, 5 Nov 2020 13:24:10 -0800
From:   Martin KaFai Lau <kafai@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v4 5/9] bpf: Implement get_current_task_btf and
 RET_PTR_TO_BTF_ID
Message-ID: <20201105212410.pngxkh6yqhhg6syc@kafai-mbp.dhcp.thefacebook.com>
0;95;0cTo: KP Singh <kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
 <20201105144755.214341-6-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105144755.214341-6-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: CO2PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:104:3::11) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by CO2PR06CA0053.namprd06.prod.outlook.com (2603:10b6:104:3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 21:24:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ae519f-f014-4f9b-cf0f-08d881d1265a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3365548C2E0BD35F9F4AEC46D5EE0@BYAPR15MB3365.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SE3mGBLxCPA872L46Cy4yNSqiN7gcWis+OhUTDEF3U5qPkWOXwUOIw+19wDvQ5OjbFsvcC/trflYmXmJkn8Cgti7iPFSeY3C59dBuN5sQ02px65yHKkD7/dgb821FKhxRIXfbLqWryIu46Unv/CC1LOMmWhobZ2Y49lPxok62S4UGUv88z7xSp57jfyL1ngXtu9MPRqRFn7WTheftqnS5g8BN6Ogs0K/ctW7UUi+HTdlgt5gEkrylJBR/DZ7TiTLTGvZ8FfhmjewgPbyBZrIozG4npDEE4ADrhToR11VIqkouvxIFX/hdyV/wRmNzSRE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(346002)(376002)(5660300002)(4326008)(8936002)(316002)(2906002)(66476007)(8676002)(66946007)(83380400001)(66556008)(54906003)(55016002)(186003)(1076003)(16526019)(109986005)(6506007)(9686003)(4744005)(6666004)(478600001)(86362001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QzYyuDrpLVBGa1rw5mn8AAo+ldsLD0HQ7Z+ob7xMZfUAM4nuZpwNsH6bOF4Nrb7m4/Y1loLuT4fOuBjcBkSuXJmB5L38glBRD3NPAVGoovcHelcJFPJ5D9vCI85FdIBWTaviyweQlhjCiaG6CjXaw4t2bFRx4fAqP3fUT8rvvClXSkrK+QgpdAendP+RvwKh8MexJv/gesmhUayBlSxtWsH2Re6ZV7nav2o6HRsZOVoO/UkWTK8QPZkOWIOuAy1pygEYXeH6DAsVSdfFtHAq8Cvt82Ma9mkFvibWWVApMpUqPc0nAFW0uMy6zYQWX1FUtO+GE3TKYIGSKDUrNfCmMwViuXEzEp+wr+BFhTesNESUoBSIjNN5Y8wfV4MwZk8+SIprn0cdQUBgYnuGJID4Qr5s5N6xdoInPH6aXRjwGQBX3KDlXh6KjVUNP6OJ8gzLiKO719JzYStkvkp60MiIbKUgBOF0LnQdiaBjwQBEzEzOoXnq/BlNPM5kVAtZ5e+jMHWkCUGofP8Wkrat/TGSbLBZxqbwvppIEV+E2XhYml4OgJiurT9dlTNzoqzviQ/uiVfHtNmj0J1OUZamLZ0l2REoRLm5je3DuKeEx7xdv4yLvH8qgiFzIvnYHS3iTFibdhMz6v245Sl9Lvxo6kXoWOFs2RhBzLUWMyJhH6cCgse8FHT9q2b0g6xkfL1oBxDy
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ae519f-f014-4f9b-cf0f-08d881d1265a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 21:24:16.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ak0kBFABVw7I8xfWoCDJWGi+34luiT5ZttFZHZj1AzhxmfZfVp6Y1xU5aBif4Rg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3365
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_15:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxlogscore=885 lowpriorityscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050138
X-FB-Internal: deliver
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 03:47:51PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The currently available bpf_get_current_task returns an unsigned integer
> which can be used along with BPF_CORE_READ to read data from
> the task_struct but still cannot be used as an input argument to a
> helper that accepts an ARG_PTR_TO_BTF_ID of type task_struct.
> 
> In order to implement this helper a new return type, RET_PTR_TO_BTF_ID,
> is added. This is similar to RET_PTR_TO_BTF_ID_OR_NULL but does not
> require checking the nullness of returned pointer.
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
