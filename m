Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19081F1C06
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgFHPZy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 11:25:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28040 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729668AbgFHPZx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Jun 2020 11:25:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058FKMeP011123;
        Mon, 8 Jun 2020 08:25:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1qXaed7cRxgD3RY6QH1IOACZhuutbG7nCAAaiqRI1GE=;
 b=qCmWpK02nGb/a47oxpfrZE4tl1/jzA7jjYR4Ve3rbCXHhMjZimRO+x22/cgWvMP+myUT
 YxUysXzrH01IZmKlymKvqVICxgOOtT8LPC+kA7Olv+itHDuxDw0ayaL0A2VD3icXk8Td
 5RSZWOO7BpK9Aj0UZOt9JfSSHpIsxodU+04= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31g8vn7jt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Jun 2020 08:25:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 08:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELYpmR8xQu2RJwo1yH6CQZZW9wwfS+MrD2qjcOkkXEKQvgkxEph7ZgtdhsUxLaj04SpJM1IYHRcWGc5uWLewSPCnsO+5XU+I//TD6Kwm1UyZx9Ia9XDobNBkmaEHSDtkd0vSUsBmZGpNMI3R3fchAkUOrVATbLz7hLfksMqtpqI/M1ApwfW4NQP5p02i20xroW9Q4bVeQrr4Kj4zyh/6zwFauFcCQb0NJEMhZY5N1hf3VKmzaijQ6Kbru7qHzturt9Fcb5W1ipuWv9TkZNjVmM7XQgSoM9fBulNhWf5XxdVO/U6SeGrHWgCCuiCmNz/LVC19uTy+qQrVE0D18saJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qXaed7cRxgD3RY6QH1IOACZhuutbG7nCAAaiqRI1GE=;
 b=IxsXwaVNGl+47319YXb5LnYYAMg7FepNEH2l9XspW9T5ont21Sh7GSc30WwAdkdTF+q/1OLpy1JF3Pg9KhMln0zqyp9M5kQmOS0TjBVhYFHRBS2sHna6fQfgMmP9j6jNDDKSiGG9mdgiVSrShcXf/8tIrLZNQH9MZ2zEXzd06TU1aHbJYswmeCcktwu7OUXRzfPmHgZu1Cun18qwFHYWUwjol4Y8d2IMyep8Y5XQmTIPcw5o/e4k0mTxXQsUEbxMjVI4e11z/1OVKyGTIIF42Zvt5bDodjjA14zuRXG5q9VhtsC1aXAdFj2tKIHL2zABHiKxq1P6WkvvvRj3IgrHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qXaed7cRxgD3RY6QH1IOACZhuutbG7nCAAaiqRI1GE=;
 b=kfwxhsThNeLFIU4xT0xD7Ux9xnUJovoK5Dl0L4Ihu/BkeaVn2jbhP3r6hNwZ+GiXo9QWG+eE9eZHnNP+7XRb6Q7KQT/noiR8r2YbvIb5jlxFPn3EzhLQPszdhjXaXIL/5CddGhq3p7mWdMMMCVf9NfyWw2G6OzZP6R1Gg+pUSmw=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3207.namprd15.prod.outlook.com (2603:10b6:a03:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 15:25:01 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 15:25:01 +0000
Subject: Re: [PATCH] tracing/probe: Fix bpf_task_fd_query() for kprobes and
 uprobes
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <mhiramat@kernel.org>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <andriin@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>
References: <20200608124531.819838-1-jean-philippe@linaro.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0f92dbbe-3e63-8646-7baf-01480dc5fb6c@fb.com>
Date:   Mon, 8 Jun 2020 08:24:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200608124531.819838-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1093] (2620:10d:c090:400::5:4e11) by BY3PR10CA0022.namprd10.prod.outlook.com (2603:10b6:a03:255::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 15:25:00 +0000
X-Originating-IP: [2620:10d:c090:400::5:4e11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebd1f09a-0b41-4002-7b32-08d80bc01ca2
X-MS-TrafficTypeDiagnostic: BYAPR15MB3207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3207278724B98F41C4D31D93D3850@BYAPR15MB3207.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tF3WzZ6+JzWLz+EYtx9ZwWWV6GgB7Xw98pIZ+eb/Z2S+fMfyhK0ODb3FH8VXBh1qTyodJjaUopRqflFh0cuWgObRwxUPHHZdaKbfsG8RjlCx4jvWdje1E+Ll1ammkfGGl+Zi9/k/v5GZeGn2apkXZ11BQEZG8SKQZE6XJRky7ZbZcIVM31RGPlGQcm4IAyrb5Z6maEIF2ordYdaULFuhiobIsmXsyYpQaCGFgYsTiiU0NczAFObcLgnLNwK5ZsKV3EWag8yzzuoZzoMVatDAAImz0NQvVQ2+Tkxg6SHFLtawcFEKw89t45z4rZtqOwwP6Gg566cpbbPY9Jq37v9eGIDuzzAL9n8aV12JBCW1l4KpbsVLtuXQdK/XDjMIR3S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(31686004)(4744005)(86362001)(36756003)(5660300002)(52116002)(31696002)(8936002)(2616005)(8676002)(2906002)(4326008)(53546011)(16526019)(316002)(186003)(6486002)(7416002)(66946007)(478600001)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OYq6O4ghN2RzmwCuwAc1UMx7mmXZCgBBZA6rEkLvlBc/C0xEkzXxA9Vln9RX6tqVO09fARVEI5P1VxPZRkcq5WqE6EgcPgxAAN4jRLLT5/0XMuyiSTTcl8FXKK61mY22BO9Pqrg5GYxyT6NRwdKIiYV3tnPb0+6JGtldcn4hxC/xfeIbeY4JbpxnNJVF1TexwGCOpE2tiylBHcmab06xuAmT+YUbvzGvo4gTqNo/sOcUcLy8HD4dxy21TKD7qf136xyMnrDX2zaaG325HWAmMh1Iv5CaiM4VEEfTlKy2Gbbvkovy35Q/QGoTlgAcYNRra9DpHNBS+sy+KHX3lzTxc467etrkBGMhMiUOaDeHP+iT24niPMVkWjabkaH62OhmkEWyUzvpha4kQxAcWA604MyGZzzkVyc44c3AksPixrpxoMe97hkI9oA+6vVTpzRIwaJEwNMvZ32nLksH+cQ7QBeUGLm0g4XS3q8f7vIplMgPw0M7PoA2SSNLu20cX7rUcPC6eJY33SC0i9n3jbEfsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd1f09a-0b41-4002-7b32-08d80bc01ca2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 15:25:01.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaid5Se+tosJC3hnAsBKONLVS42L2AnnnpiEyl1c4apdFYmXzqr2qrIQcYaryq+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3207
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_13:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 cotscore=-2147483648 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080114
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 6/8/20 5:45 AM, Jean-Philippe Brucker wrote:
> Commit 60d53e2c3b75 ("tracing/probe: Split trace_event related data from
> trace_probe") removed the trace_[ku]probe structure from the
> trace_event_call->data pointer. As bpf_get_[ku]probe_info() were
> forgotten in that change, fix them now. These functions are currently
> only used by the bpf_task_fd_query() syscall handler to collect
> information about a perf event.
>
> Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks for the fix.

Acked-by: Yonghong Song <yhs@fb.com>


> ---
> Found while trying to run the task_fd_query BPF sample. I intend to try
> and move that sample to kselftests since it seems like a useful
> regression test.

That will be great. Thanks!

