Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B92A8AA2
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgKEXW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 18:22:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgKEXW3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 18:22:29 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5NIdg9022214;
        Thu, 5 Nov 2020 15:22:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RqShB2aTSqVHpJQVESE5PAdo29qDj6eN0UCVl53on5I=;
 b=kYnWa2OVwR/BcEt8kzJ0DELMHaAQ9bGsWfYCJwzkCGvAfOKr91WYEKTvm3u4CcDpM2Kf
 ZXFmDCfVMDdLd1OfeDe2dhlk3AN7nz43sKpaDhNP7VQ7lVf7hiwuWiP6ItFEKzabqJEr
 ZXxJTHJ4HcWXAIfF6ePn20UpSK7zjrd9uic= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34mr9b8wsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 15:22:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 15:22:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL13NvtKVQbQ8vEdct1m9zE1MnXTLsAC0Gif79BFdTAdPyUeCX1eX0K95+7My2NEMYJGMOvew07RNT6cVxltEtC5p2zHYS/+0xwLXmkCrQKCMjihV4dL91W7kkGkbb2z+5JgBSj09BGAjqtslY0ybULuW1yTQKeujij0lb9Cyb2X4xqgcKWyemqDDA9Bky7ThToqBP06myOzRaVQSxW6AdeBu/2ccvRjApo1lJsqX99NJwGz6hN9gPbJHr4G3ryAp3aw08wjtOTYj4tLScxTuZ+iLxF0QsONCZHBkh8POAp6zmLVGM/8XcvyOqxEgHlm5m7DE5CJ9wndOcxPzEcq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqShB2aTSqVHpJQVESE5PAdo29qDj6eN0UCVl53on5I=;
 b=e9/xicX9yZKM9fG9ZJDuLrRAWWJbk5Y4cE4Vgop9A9NVTCegrpee5ruq+32SPUU9gucKxXZHBHnYApdCt+If27G+xoStW276E0+XD9eg3dnYUQP1bzQkGaU1mFpbkhyV/sKJnWiLjNVpVUUZIpgfWo1hql9GUHnPseeXBTc1mkJ8oOoBPSHsPCxDhd5zeVzeCnLNA338zPWsya1B/A7XpIg0iKDxEtquF24LFHHboQzuAaTpWu7oZccOVj97k/Eg1QUofbqjVuc8lw4hsSZjY3l5ChpqEIlC6TJ89IQaqZZw9LfLD+Zwh6uMtdspi46RF/L2NZr1j7maEa7CDYzIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqShB2aTSqVHpJQVESE5PAdo29qDj6eN0UCVl53on5I=;
 b=Ez13szVPK6+rkkyOng66rF724WxcyuFmstaQiIaMpo+x4hT9Xc24MQaagKoZxKspPtzPXYvB4DV9g4SFBRYCt10uxhTkPxUnFB0vID4rStJIxMn0Jw/wTvGjd79Z1CtW6fDnd2xyMKXZrFq+WJ5ne0ug0jESGAg81UbFnzbH4u0=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2200.namprd15.prod.outlook.com (2603:10b6:a02:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 23:22:03 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 23:22:03 +0000
Date:   Thu, 5 Nov 2020 15:21:57 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v5 5/9] bpf: Implement get_current_task_btf and
 RET_PTR_TO_BTF_ID
Message-ID: <20201105232157.4kycxicpntldhwnx@kafai-mbp.dhcp.thefacebook.com>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
 <20201105225827.2619773-6-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105225827.2619773-6-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MWHPR18CA0054.namprd18.prod.outlook.com
 (2603:10b6:300:39::16) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MWHPR18CA0054.namprd18.prod.outlook.com (2603:10b6:300:39::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 5 Nov 2020 23:22:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc76a5eb-541f-44c9-d9a4-08d881e19ab2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2200BF4DF28805AFEDDEEE45D5EE0@BYAPR15MB2200.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9X5J0auciwS5U8BXhPw2JrJXAxo5IucwareuTC8bfB2Yh2pT9Jp2LtvwdaoMi6x0tsffm4jhEA3hV0kvbRLkjnBIQEdBp+4++EmgQOfRLHUJSaMw0DHYovsLygDmbsFM6jIhKGTpPcvOtG721Jq+V0bMRnw8gJFXV1GTV0fDrL34oCyQy8GquDyk8EYYgUWRvmcFv1VWHXXMoOu8HlA8MkBuInpAUSBrjDMBOq8WLXc4pyY4i4igft1xF8wcN9l21amvjEQOY8b8tp25J/+v+9z/ACcrFbkxRVXOT2qrGdjJoESPVZ+1w1ibkaPqrAu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39860400002)(136003)(55016002)(5660300002)(66476007)(4326008)(8936002)(478600001)(6916009)(66556008)(8676002)(1076003)(86362001)(4744005)(66946007)(6666004)(186003)(54906003)(16526019)(6506007)(2906002)(7696005)(83380400001)(316002)(52116002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wY2ODFhhjh+itKbKbI0EwKaxhHdYM3Aeirfi7UViJ4Tj/tfogD7zBgTvwKAXw3Dpsg1nYYzW5nnIszHjmt7LTusOiIpc69HJJPdzn/0P1UskRqWfac3kqH9kyhJQqcEhjla5ptZSuuWH4BmxP/YvMfqC5Fc4jCMzmSWgaIp7WjTt9eN5+PRypyC9Bx4xAf6kEZ+EQpobCblq0UwN0KgMT5T5FeZF3zCqkxBpZzfQzkeCE0cDwDGgEr8snjyDhNX8XaZqGuS6TtV7Z6lZboU8B3p+q8W4oGCHtpfOESMFVK6sbjzQ9IIXqcxdUVI5h1XAYKEWilbAZ3+i8NLp3v0TdaqMDEfN4K0aYFhkW8oqr/zhF8XYo5D9zM8BxwpX2FDVR2m/hKPv7esgVcRpYXdIuXvGn0DuKpxW1x3Ll8y4o8SioyeNH5AJe/+CC/a9soN8dr+VkpcNq4svyPqSLG0ri2xDmovdalCBUQessbQHcjY1PLTR5ocagxJYNHdJccZLFjC24B72tUWu6kIxkF0sO8sQ8BHdIOhnBjHXNE7Vi0s8xobDZxbH1udiob2BJnuHENHzcKGzbNSqNu4H1ebVEMNPta4ZLleny6uCKsTE/pw8byotibB1P9sjoiFfI78tBY/hvgA34J7UyuAGaw1lSRx7K43ToZ24SuvIL5I3iewPwbrZexOwpNw57Lm20abw
X-MS-Exchange-CrossTenant-Network-Message-Id: cc76a5eb-541f-44c9-d9a4-08d881e19ab2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 23:22:03.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7Jn4sfaxRAy98IpR1poNovX2iHqBnRwcUJPcJL3YwEX3VczMvOgKjNrnXCbR5Jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=966
 suspectscore=1 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 10:58:23PM +0000, KP Singh wrote:
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
