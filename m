Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82653283BF8
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgJEQFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 12:05:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33638 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbgJEQFH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Oct 2020 12:05:07 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095FiI4e032380;
        Mon, 5 Oct 2020 09:04:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XOk1z8ze2nME8dqjR2CmHugAbBeBoQjnmFfLOT9sUXo=;
 b=pOya8B0j11Ca2fNKS1gjU7vv1tBrUSQak6mcOzTOZ+5NdXPvvpeeAijzrI/GPwQUL/5/
 B7hzAUNqT11Y/g890VKVAXffYk5411+ECbVAAkgru4Gqbpg+FqkS8MdahW9DDqsfl4fZ
 6zlWio4htWIKY1OM2RW5RwMbx+AmoZAFFSs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33xptn01an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Oct 2020 09:04:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 5 Oct 2020 09:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lljgpkDy4xiJ0rkiaBclFwypS3hIBI5RRrGDXT+dU/ulwWFem24VF4eXNmVM53OSgi/5oqcmp0Wy5Vw/8FR4M/zipG2fg6CFqYu8YQZaTpeLDMBKavj57gAXHQ7XffNoKY0mT7HfXw+jtarhLg8/rWRD2PBAJsDlyfSCrcc6FHplB2VbaeqOWIBuAaCyltwh5R8KYE2iMIWg7BU2+Y0gtEfQY9EeC7kvZFBff9L/q8D1+npsJaeOOKUIaMWAMtVncHHZ2d9wxp6k2zBdWIE+nkb78npnGeGFMe3KqEu5VfO0YUVOHM7apAM/OrQrx4xEVUy85DDThiyXJwrQ7QYmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOk1z8ze2nME8dqjR2CmHugAbBeBoQjnmFfLOT9sUXo=;
 b=NJGBOzJ9ff3/QAGNcQhtghnq+vIh30fWlnIswWAHNw1QLrhS83Pe94VIGiGx+as8aT1LhKNV7LAWOge7yKATVEAMJfDkmeG0kpq0FuVg+AGq1i6KjC098gd1CCuuTwVaWtS5skL/wVYmn2K+WdKcBXf6nWMPe7sXRbgg7fYLRu8A8ggsC9VEyd1I10F+wfa9loDmqBlXcGZJCnRGTXfuepG6+Q912srjYjFKFXbmaxGMg/5YmlmPAbPajqvV5ypWBXcQV586INlHMJv+CVVgGxZUyudfVnzM2bf6Q8yZ2o5ZxsUR2XMjqyzN606iHPG8fO3DG4aBtdDiwlMdh+Nnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOk1z8ze2nME8dqjR2CmHugAbBeBoQjnmFfLOT9sUXo=;
 b=YSFenCKNcKh5MEaeaUYfYEuifocQ8IwP+W4m5tIoYe/JmnkQdnPeTRPTfyq8edFsOar7BBqjS2Lw5P+UXu62r1GS0MNp7cOMBknK1jxakM+bwZ6imjk+s7radsQj4ItQSMgSS5MaJj5w/clUfGJK4MVk2/LksjPPnumTLaxtsM8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4090.namprd15.prod.outlook.com (2603:10b6:5:c2::18) by
 DM6PR15MB3595.namprd15.prod.outlook.com (2603:10b6:5:1f8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Mon, 5 Oct 2020 16:04:49 +0000
Received: from DM6PR15MB4090.namprd15.prod.outlook.com
 ([fe80::20ca:dd59:56ea:4ed6]) by DM6PR15MB4090.namprd15.prod.outlook.com
 ([fe80::20ca:dd59:56ea:4ed6%3]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:04:49 +0000
Subject: Re: [PATCH] use valid btf in bpf_program__set_attach_target(prog, 0,
 ...);
To:     Luigi Rizzo <lrizzo@google.com>, <bpf@vger.kernel.org>,
        Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <ppenkov@google.com>
References: <20201005134100.302271-1-lrizzo@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <102ef3d8-e9fa-24c6-af96-b0d62ccf57c2@fb.com>
Date:   Mon, 5 Oct 2020 09:04:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <20201005134100.302271-1-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:91d2]
X-ClientProxiedBy: MWHPR1601CA0010.namprd16.prod.outlook.com
 (2603:10b6:300:da::20) To DM6PR15MB4090.namprd15.prod.outlook.com
 (2603:10b6:5:c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1273] (2620:10d:c090:400::5:91d2) by MWHPR1601CA0010.namprd16.prod.outlook.com (2603:10b6:300:da::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 5 Oct 2020 16:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4cb15f-a0b5-4c68-75ba-08d86948629e
X-MS-TrafficTypeDiagnostic: DM6PR15MB3595:
X-Microsoft-Antispam-PRVS: <DM6PR15MB359545F62E6D3DE337FD5108D30C0@DM6PR15MB3595.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ds4k91Tzhco1GE8FMsgaLbFRLFwgskQoBj35iMbASmAKf+KKf3ONz4UaDb3TLFFYCP3/rF29Bvt6GbbDZwfZMNV6Yu8Hx6rRLt9oBJkN08jx6HIobyfMUlfusgDRHT237EN86nRD9h+wpgY9NdBSf4sIeMF32AqCIlrn1DrKvjBFfCQU9rXYV1TAaWeBtXaSJ6KkLheG1SyUaSXrYw94WCahJDe9lRmWa7Sa2WRk9aIOOwgwh/dkSMXYYcbMXVYntTtPN5Ugmw0f5y161q6Te2aV93i/JuPvvqRnfYDLRkr3F5wH1mAX2YLstrkKT3PnKXk9RBGkjyXZ2wKR6QtDrFDlGFfQS73UDb0Okdh6eZZOECIi+GDlr5977nvSxHP1DSILzEB1/e+WQ/9GNoDPyzf+9QXZjWrMVZhxQgnrsiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4090.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(136003)(366004)(346002)(8936002)(31696002)(6666004)(2906002)(8676002)(16526019)(36756003)(86362001)(186003)(6486002)(31686004)(2616005)(83380400001)(4326008)(316002)(110136005)(53546011)(66476007)(66556008)(5660300002)(66946007)(478600001)(52116002)(101420200001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PztBmu+mOyz/JXXFjMo/pi5Bqv4K+xVBg36NML270GS+Nb50AubN/BxNmUnjLlrzDoP5/Xa/9Fl5az8V9Dn9fihS6BFq2K6WBDKxOSRLKDx/6TvcofkzC7XAucFlqvswtR9gDrCQcNFVFAY3Wo4ZkS1qDTBdvGyumknOJ2QzLf3LZpqlauuY38gRfcquK4vjC4WQ/6x0Bb5Isu8Pjd1umVEnllOrs9YyBcEudD5/L/E63OEeDs2BZCK+30AgJW1p7bxGmvROPUooyGei7kx5xyzd6Iywmf0KZdxJuQvFILkW+IuHBF+ppOIh1t7vI0DyDqv5U5QRp1wcpp6KWJLL8sowBzdeT8eAJTrJtrvtxnt+qOY2PzqdIn+xmI9n+Z1j90QDRUZRrNGccsBe3sVnEilQ2rrY2q9QXZOFn7ZVv4BBq6KV1PYYRdDuh64vccl8C8AEDZBLhRR8xPjpt69ZsPYtWizqUyp4f7KFnpoq/SYG7+Zf6L78IFRLUnyfgXKtoC9XN2xeo+8NDLaNKI8EyeFVGTCBaxlp1V44sJleK+BYJa+bZZlPMwb6q+kPbarmy9cIMBSeptuDkfjs1ysbooUHlx9B24kbPENiGf0H0koT+wJGbZAvEtap9QobmP9+qPECx/5BAn+a1dWaqaRCLKbgBW33PJYrPookHkHRqF8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4cb15f-a0b5-4c68-75ba-08d86948629e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4090.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 16:04:48.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGAfOUB8JgWVB4Q6FVE1E3cWqDsaBFGck8o3zXeEBZrGtWnUeVspyiexzHz9SkY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3595
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_11:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 suspectscore=2 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/5/20 6:41 AM, Luigi Rizzo wrote:
> bpf_program__set_attach_target() will always fail with fd=0 (attach to a
> kernel symbol) because obj->btf_vmlinux is NULL and there is no way to
> set it.
> 
> Fix this by explicitly calling libbpf_find_kernel_btf() in the function.
> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>   tools/lib/bpf/libbpf.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a4f55f8a460d..3a63db86666f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10352,10 +10352,13 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>   	if (attach_prog_fd)
>   		btf_id = libbpf_find_prog_btf_id(attach_func_name,
>   						 attach_prog_fd);
> -	else
> -		btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> -					       attach_func_name,
> +	else {
> +		struct btf *btf = libbpf_find_kernel_btf();
> +
> +		btf_id = __find_vmlinux_btf_id(btf, attach_func_name,
>   					       prog->expected_attach_type);
> +		btf__free(btf);
> +	}

Doesn't feel this is right fix. In libbpf, we have API function
    libbpf_find_vmlinux_btf_id
just doing the above.

Also, could you point out why btf_vmlinux is NULL? Is this related
to fd = 0? We probably
should fix the problem there since what if other API functions
like bpf_program__set_attach_target() wants btf_vmlinux. We should
not duplicate this logic to other API functions.

>   
>   	if (btf_id < 0)
>   		return btf_id;
> 
