Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74E518FD47
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCWTF1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:05:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbgCWTF1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 15:05:27 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NIus6Y008960;
        Mon, 23 Mar 2020 12:05:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aWI0ufuT2jljY7C07J2YbCR3c+JaS8oFlDcenGBsKKQ=;
 b=qelVB0EHQ7uJcUsEdiJoVQZ/T0tWfQQpUriBWyYVIacLBs1/acYzIKkt6jJR9j1lp2n+
 +ncwHQyplUPlcjby7jMkjwuayLA4TipXgk8SOqY66k+CwLXyJT77vACrgtAsRblKWfQf
 s4vtlMlettQx11blNEm1Y/dZLLVzW9p+cPs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx32wen7e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Mar 2020 12:05:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 23 Mar 2020 12:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib3B1i/HQL+vvmTWpRWmMpSQuyLhVqaiPsWOWHPTB6u8dgYA4lDgEC68/2JEkoALMiO1b2nhYxtuj6Lt7WYdOdA0zM8DT6nRO6oB9fpss1uOQceDp0tcwq9WIP9iZYGyrfDLPbCU0mXCoe+1ivKWhoTS2bNT2g6N7s946CEFzW+eFD+jm8CO/6WeG9nUu/nvaSyvCqUtwzQ88uiQwAfZWgc6Ei9Yj4UD06JqZV1vjxxOEzR3P4nL78HVlp62fEUNkwGFp5seOSRw8WVavitOTDkJ7t0448tXy1ksqHHYW0GnohQsLXk3waA/datBhpSe9t3qS/7JP8xFSVHuSPKNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWI0ufuT2jljY7C07J2YbCR3c+JaS8oFlDcenGBsKKQ=;
 b=D7n1hN8zSGWerxp9mTtxK3rsrorkov/vqZ5IkkNUR2WMft6cvjL2JmKxVQY2MDy9qGvRye6oScOY/1RsIDQmGUQMND0G2PqCP5wxXDQIaKrWLqmG+UDasbMVe2zjAj5zPPgMeD3qW4UZ7iVuT6i1dT23k6Kl0eNXWp51hTYvy6rEjiSiDV40RXn915Ml9I2kbIrhfJpGsdnNPHckUpYI3cdBGnOXDJYGGF99jysOucWzMKsIuOmrQfe9aXcK0Q15kPLGC+dNP8MM2xB6a8b/v1qB60J+cRCxlJN6SihDvrn/2UISBmekcnRyzAE9ykwfSTV+flhRxObJP7i6G6FEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWI0ufuT2jljY7C07J2YbCR3c+JaS8oFlDcenGBsKKQ=;
 b=RhzOubAmHtK5ZqGznf7hYKhzXA4/W/6dlVAql/8hw3KPmzU718Gk0BOf1e4V62qzbCUdVjYmeNppTwg22zWLWgvouuIH9eLVKN8lQNO9TT/B2qDo5GQKOHXIWOE+jX9S7FyQl3PUx2b6N6FujAkEgqqv86o1WCG/x5E1R1Ogtls=
Received: from MW3PR15MB3883.namprd15.prod.outlook.com (2603:10b6:303:51::22)
 by MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 19:04:52 +0000
Received: from MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98]) by MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 19:04:52 +0000
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
To:     KP Singh <kpsingh@chromium.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-4-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5ce03d5b-fef6-c48d-0d9a-3ea6bc4e1401@fb.com>
Date:   Mon, 23 Mar 2020 12:04:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <20200323164415.12943-4-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:320:31::19) To MW3PR15MB3883.namprd15.prod.outlook.com
 (2603:10b6:303:51::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:2131) by MWHPR18CA0033.namprd18.prod.outlook.com (2603:10b6:320:31::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Mon, 23 Mar 2020 19:04:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:2131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7feb8bd6-0dbf-432d-3e12-08d7cf5d1107
X-MS-TrafficTypeDiagnostic: MW3PR15MB3882:
X-Microsoft-Antispam-PRVS: <MW3PR15MB3882C0BF1936D519D1F721CAD3F00@MW3PR15MB3882.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(4744005)(31686004)(2616005)(54906003)(86362001)(316002)(31696002)(2906002)(16526019)(4326008)(7416002)(186003)(8936002)(81156014)(81166006)(8676002)(52116002)(6486002)(478600001)(36756003)(66556008)(66946007)(5660300002)(66476007)(6506007)(6512007)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3882;H:MW3PR15MB3883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDN1cc9/a7UksVj4UoSFVZ3+HOsw8LzYtVZd36Hyb0xAHIHPPXAxwSq3YMC+yXcDHJVnmqxPh6lpwPB9dO2a4dX+VbrMvwuU2rgz+CBH4wwO4pbrRWphe8805WsTwi/Umw66OnQXKMic3eRDEjsD2fogcv7ma4eM/EQuvj9MGLsp8Kz87XTkKzHvluDu2LgZfXtOhdGLClbHXh+/2dB/GT1zlTamlj/sWKHSFm3K3OG7QFzJ3ryKIgDr958C22OSEZw7sH5UOb7tTLg9+S6xASnSHYuOX5BG3YTHWtCyh1D2/sYXRFApx9bPs3gFLov6MfddlgjVnTVYeyc2y9Oymht2saKDYemEKYtPBUy/+CxqdSbg0zmNeBn4T5Kw9O0vOj3fubhodPfyKJwxTgFCPKkp7HAbrCmwMVsEW35qSX3dSis8Y6P5ePxH8b7TWdSr
X-MS-Exchange-AntiSpam-MessageData: AyP5NkOSOHWqpI9e+2I0hUQC/Ytht22Ns+cl6yQ5KzT4gfNVIbOXyackrXN4/VC+8K+Y93qo2WtnS+YUwCWkNBNkrJNXP/oLoJHXNcwPgzJ8BWGGZ+wHvrIeR/KJUw8dO7G0bt/pV5z53afBBeF6nD+WpbjzsqMQbl1eMpjtAjCrZO91cezBEu2IFRWqQSVE
X-MS-Exchange-CrossTenant-Network-Message-Id: 7feb8bd6-0dbf-432d-3e12-08d7cf5d1107
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 19:04:52.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih1cUTI1BEHEzb1/g15b0hgxO3EFEN3XOSc+Z31Wnr7ITggpzS2eyHoadcqY9915
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3882
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_07:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 mlxlogscore=686 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230096
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/23/20 9:44 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> generated for each LSM hook. These nops are initialized as LSM hooks in
> a subsequent patch.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
