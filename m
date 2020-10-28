Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6229E12E
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgJ2ByJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 21:54:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45622 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728678AbgJ1V5K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 17:57:10 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09S1KGKw003081;
        Tue, 27 Oct 2020 18:22:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=e4RL/7HCoPVcmioFolLk4LZu2wf6T+ZmDZ1xqXV6NRk=;
 b=kReSp1UnPXTNe+RTRF3mxwCj3D0eprPX7Mga5O1Y0oavq92okU5Y3AvpPP6I1sBzP9Az
 ak3y+Gra2jga+7wTIxAaW9dRUwkcc10Je0zNqAtooqS5WZY1bmGKkMJPIMQ3YK2lFJ5R
 Nrly0Y7mjxivd14iI5ln1NZDrzQWgOPvvpk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34ejk24ghv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 18:22:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 18:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nev0nFkr7V3IT9WTNmYCO+1t+Jz1PKC74YxlqF3OeFqaIiT+wXC8hkh2T8wd1iBxbTWV2i19HWMnkNbZ6E9p2u14MYcEw9NB46U9DQMNsUyj5+7SFXaHL1bG/nLPFr7kZunVQAWfiWinaFj2zSLAik0eYiXdT20PsaAcajVgir2TPBNy3OiZCdH3rn+IsASiP4DMlanE5DdKttk2E310H33Wk957XQCvbEPKHv+NHBQqOQwXktNof4TqjBNo9H3mPG0Go5qhhv+VgcAVX4QeSqs4Ldg3FZLgH4KhTLUFjjP88o8yd/mg1BB/VjoLShOiw4rLjTKM57BUtJVcdVg8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4RL/7HCoPVcmioFolLk4LZu2wf6T+ZmDZ1xqXV6NRk=;
 b=WPVYibrPNz2cjb8XO8gGAVzGontjQZHU/YZy8mg3XiX2/TM8jarCMjnqybKaIQ/7vnWPOQOmchliGeMd5sEdmlQGH2h+99Cq8MNXkPuU9VkpqFhHHEo9TVnHOswvhUVnG1F9YCZZqJSrxkuUBFCDUwJbNtc4l5W4KMce+OKGPxsyC+Hr8o6G+1LIqkvUespFgoDKyodzyDG0B5JrKQdma2q/pdbGAiNhfKv/OCWA6fnRoqF5it5XZXfzmoq4x7qNa+MK1KBSLZbKUu1IzdbwTNWSdrgsBiojMdKS+pkUWRghMPzCls3IMBZm7HxqN+XNzPEZ53OIFk1v4VCAPeaINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4RL/7HCoPVcmioFolLk4LZu2wf6T+ZmDZ1xqXV6NRk=;
 b=kRCEHVwlVcee821TbVXjNJbIzfKzBOiXdEJcBd2o4g6EdZRG9Mg0Akxiq2yxMpUSGByLthFVcOuw4hYXbjr5QdZJOWyHYaN4qurQ/EmLBsgGylcvEGmdOI3rqTjuB6uNBPR8MjHFrKduKfbSb94H4SpNagfeWYduCjuI64AOmVg=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2200.namprd15.prod.outlook.com (2603:10b6:a02:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 28 Oct
 2020 01:22:13 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 01:22:13 +0000
Date:   Tue, 27 Oct 2020 18:22:06 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
Message-ID: <20201028012206.zsa3udr7rqqe3q7y@kafai-mbp>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170317.2011119-2-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::4:9723]
X-ClientProxiedBy: MWHPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:300:c0::32) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::4:9723) by MWHPR08CA0058.namprd08.prod.outlook.com (2603:10b6:300:c0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 01:22:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77a4c03d-72b4-4a81-07d0-08d87adfe605
X-MS-TrafficTypeDiagnostic: BYAPR15MB2200:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22001B0F6F1568F5879A6D12D5170@BYAPR15MB2200.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYDBHy1xzb0pz78HpdawzCCQCcO0Vo6U+zR2bw8cJOgmpZNRgB7wOYXVURrxLIX7TFZILkSO0hlQbTHUkP7TspMkqWZmnN+fcN1jbh2qPhSL0tgHKGK3MBPNmqLsH0fgbqD9O/7VY3p9mbQttgXI+BGtmX2hGmmaQR92tYB6h6Si2JiZm8Vq1ewjZ7W5iQb/fsjVI3yQK2HBdLKGI5/1yf8t/VMMHmDWAZTTX1klKMHyb9ghHozlD80WKbeGWL76aWTRh6b86g7Qf/rBt4ExbVCwsm3cKXygz8ukqn3Twwlh5NcBDXtk9j1O4oANr0cyXqePFvqTy/v+54GpjOqc1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39850400004)(5660300002)(83380400001)(9686003)(6916009)(6496006)(52116002)(8936002)(478600001)(54906003)(33716001)(55016002)(4326008)(66476007)(66556008)(316002)(16526019)(186003)(1076003)(6666004)(86362001)(2906002)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QOxjvD2Zb5kRnQXjeEEec4IMFbl8D1pEC+S1wE4wEkexIKqgFiqGHrmlBjvEPro4F1pggzIpRvU9OIxLgbsulHxex4CATXxb09MIBBgmj6iR+1h/gUza6S1cG+60sWW0/hOEMqWKviZ3m6iVvM8805Uo+jLji9bOTq67T+tPV1OYBTdRoT8tTsFX/GzBbJ8gKlUuQX/rfBifSdPqcNKNSg614dYzN2a1L/d6+5TJioowMcDboMoiUp1WkieeW+S2KB1jxaWLziFE8Pv+krfLdjdBPzf27ASAkKKomeDBNjH682e5Xm6CdGdPRzkNYzkQCZXYaj4FKfk7jrQc+Pj7fZ1f3NxQIqdiSpcjrMqAjZ6urjAfl+6VbOyE7/UkwSeZTo/XTWV2bOnmb07ishiDX6uYeCp502QSQ15xHljyPD7EQ4ffxassHxuTMtcfnrdI64zq2VxYMBnLYBaLzd8p/70wzzU7G4e2YGopRApwxHeykc01YDAx7QL2Mv4tc6nPM6rj7fA+c3ZXXs0wVNBz8F8h3D2aJyXp85JCOQ50T2nbWjWuF5ef7shEnJ2Y2MQRSrqawzcwBU6D9T3eck/IgsEgmDNQPwKBLZUggOk6NU64z9UFA3De/nFbZLqVLjRdZKxe9P9FNy3EXkdUi6jBuq2A77UUqNSnm+2sl3whlMQCreUxgeUHL302Tj1uypSy
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a4c03d-72b4-4a81-07d0-08d87adfe605
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 01:22:12.9899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCnCO9ViOGYfcrNdZSqXqfQrYYPv89c39jVYB7EYlqk/XdMhNUE5iumgT6pCxGEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_17:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=870 clxscore=1015
 phishscore=0 suspectscore=1 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 06:03:13PM +0100, KP Singh wrote:
[ ... ] 

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e6ceac3f7d62..bb443c4f3637 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -157,6 +157,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_STRUCT_OPS,
>  	BPF_MAP_TYPE_RINGBUF,
>  	BPF_MAP_TYPE_INODE_STORAGE,
> +	BPF_MAP_TYPE_TASK_STORAGE,
>  };
>  
>  /* Note that tracing related programs such as
> @@ -3742,6 +3743,42 @@ union bpf_attr {
>   * 	Return
>   * 		The helper returns **TC_ACT_REDIRECT** on success or
>   * 		**TC_ACT_SHOT** on error.
> + *
> + * void *bpf_task_storage_get(struct bpf_map *map, void *task, void *value, u64 flags)
After peeking patch 2,  I think the pointer type should be
"struct task_struct *task" instead of "void *task".

Same for bpf_task_storage_delete().

> + *	Description
> + *		Get a bpf_local_storage from the *task*.
> + *
> + *		Logically, it could be thought of as getting the value from
> + *		a *map* with *task* as the **key**.  From this
> + *		perspective,  the usage is not much different from
> + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *task*) except this
> + *		helper enforces the key must be an task_struct and the map must also
> + *		be a **BPF_MAP_TYPE_TASK_STORAGE**.
> + *
> + *		Underneath, the value is stored locally at *task* instead of
> + *		the *map*.  The *map* is used as the bpf-local-storage
> + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
> + *		searched against all bpf_local_storage residing at *task*.
> + *
> + *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
> + *		used such that a new bpf_local_storage will be
> + *		created if one does not exist.  *value* can be used
> + *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
> + *		the initial value of a bpf_local_storage.  If *value* is
> + *		**NULL**, the new bpf_local_storage will be zero initialized.
> + *	Return
> + *		A bpf_local_storage pointer is returned on success.
> + *
> + *		**NULL** if not found or there was an error in adding
> + *		a new bpf_local_storage.
> + *
> + * int bpf_task_storage_delete(struct bpf_map *map, void *task)
> + *	Description
> + *		Delete a bpf_local_storage from a *task*.
> + *	Return
> + *		0 on success.
> + *
> + *		**-ENOENT** if the bpf_local_storage cannot be found.
>   */
