Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA929D390
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgJ1VpJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:45:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14000 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbgJ1VpD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 17:45:03 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S1NG5o010394;
        Tue, 27 Oct 2020 18:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WsM+lcS2bLEBZmF9n0F/D+H0IWH4imIpvFtzJ+gdvrs=;
 b=q4p0Xili46tdFzr/Na3UOG9qXjnu3se+e+w9tehlMdiYbBACdrNcr91LfiOXpLL7mdpV
 XdJ5qSrl4wQt9JrvyYHkjbVlKO3nUbPPLOclidEBCV8yNOzZbDlID5Rs+N0kIpMZZS/l
 oE13cBj0l/0+LrCfAjxZJCM8tJ21WnI8C1U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34d4hpq0fu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 18:28:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 18:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq31DN9l1ZnCa3wrXHtLj7jtnsTYzlzIHgKrZAgmforHCQ3GU8WQMX4C5whybTdkudd+vSOZmAEij5/Vqj3wqzTJoixFAk8yCfUGcUAjqEzJ90pioDioIfN7t/twPRr8A/eduz9+FtExDpd8mMpJSizSoQbpjryJ19plDy7aVYNKxXLStZP+CgZTlLCoLjgsfzh8lCxc9f+V4B28fqYvQMSjunxNswkeHAf2iZrwhlMUP/WATKf2gb+s5X08SnzpQe1ODIY+XsmPG2FmOdsG5xyctGzhy+OysGGxYkr2J8MxEwlrBNDArwGAO8K/FWWITgIaDi9yIpWR6qqbyv3KYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsM+lcS2bLEBZmF9n0F/D+H0IWH4imIpvFtzJ+gdvrs=;
 b=mBQ7hGzsKHw/sWd8cmkCYvdfDnOKRtU5nImVSEUL3SUxMhjlw+5OE2ip2Dz3VgXj/Elcg+MiheYbkEh+nzJbmAU5MbNc9e2/vVKQWhamx6BecS3/3wfIssJEGo9K14cwPI2Atj+1RSuI0Ythk+r/9lLxmmdJ3WWF4ssDDv6Xw+a/uv3hduwpLOPmwTfEzZ5QUwrBEGqpHcAMAfeD/f5Z3PlmwpqeWDbYhtpPw2QTEapaBkyKtNvxHvm6ZuI6QcQ9sjSTaKiEJstYO9GTVxnLvV64WvQTLh9NuX/P9kp6kBxTf4PamFDs6Jr0JSW7aLjiQoBXZxvE+aNoAR9fdDR64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsM+lcS2bLEBZmF9n0F/D+H0IWH4imIpvFtzJ+gdvrs=;
 b=TxXn50IgOMkTccqGXGYRNYiX98gp8NVPXhWR0Bc402FMoHSPy82zfjGQsd5D2+pmdnx8ZwTYGNhBIv3uKXwKf+NlK243qx/iE8k07sFaub6HzW3/2V4onBnEiCqjyxWLFJ693W/zFd3bxwdbMMBD0skmCcQOgFu0EpDEpbTLeCM=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3512.namprd15.prod.outlook.com (2603:10b6:a03:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 01:27:21 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 01:27:21 +0000
Date:   Tue, 27 Oct 2020 18:27:15 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement get_current_task_btf and
 RET_PTR_TO_BTF_ID
Message-ID: <20201028012715.z57277wl45odspbs@kafai-mbp>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170317.2011119-3-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::4:9723]
X-ClientProxiedBy: MWHPR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:301:4c::17) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::4:9723) by MWHPR15CA0055.namprd15.prod.outlook.com (2603:10b6:301:4c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 01:27:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7674bc1-facc-4ddc-e628-08d87ae09df7
X-MS-TrafficTypeDiagnostic: BYAPR15MB3512:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3512C5FE4F5BD7BE447EDF74D5170@BYAPR15MB3512.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyoAe7KJqRa5zad4lAQywB8kxhensHrd5gLK7i0F1DAZ5paVmYc5eGCAkACRVw44wTXMBcT5vIS14a+8AGypLstAgUMpAhh7QT0Sbh9QYawm0xTCLXJUnD/KRqYX8fUhaY8KIqfAH00vCj2qHhZGgjIUcv8qQBl2MpzGGh6CienYDNx537gBy307WFo2WO8shsFzR8W+v5xrzSNE8dXY/QWuul7GwcL9W/mvwq5J/iuTGCmErzKk/BqrGYa3OO8z1EX1n9RTihDXWejB1LQUxdClHh4+5bFZoQ99rC3gYLJ8P2xJZOAwqkFDRdo4L25T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(376002)(39860400002)(396003)(6666004)(316002)(8676002)(66476007)(66556008)(9686003)(5660300002)(66946007)(86362001)(2906002)(4326008)(16526019)(8936002)(4744005)(1076003)(6496006)(33716001)(6916009)(186003)(52116002)(478600001)(54906003)(83380400001)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZFRud/GvEWsAn0EGpsHV7RYpONi3eD68EFcUkMNZ3qnPTY95Ho5N9PF05drJMTbM2qdQfE2w3+N8WVzOtz4mDEVbFClyqj9zHJ097w0BUZaBAGo+B1DvCs1EDunCtXt/QsYSSShRjXL96lsm6QioygcqhQ/nfQt7il/tiOOMeJu9vACM46Jkb7pi3KbCTYEJNERor1CYA+zHQ52BZByakrYNKGMwLSsvESP2JeEOzUF3dZZyRL8BTPML9EmeQVGjJ4y0JgSSm70G2XEcKnW8vwlCni9vLScCHAZrKsDwtZLwjkwj955Eufp4ipso2sr4OarqLNktIJP/5BLJ1wcPv2iSDOZG2WERP9kfEE3K0zeJePCZxHqdjUAw48eo7rigCLjhlk5OHUx3bQLz/7M7lpI0jl11vkA1Fy9tghrGFvMkSZVO2CTTo3hRl94plMDxdDkbm+qGxzkWIdg/TEveaCQlCEV2sNR4bXFI3QUIg4Z+I66pdT3JDv+uuIWXmcuOWXcQbw6WZx5vIdljpp7sGLAcXty7SsoOM73PR0n7LX0Fh96ALr2D5iToAz35ebVQ83H0L2X0fsJnNfXqUzR94dBu8uDXGej36Mazvg+08UGPiV4o9N1/bZHegjWJKlF4U5gbLUICeRr/lLSv5hdA2E2OGlK2r2toEuQDNM9PL1LQ1dQI4/aBXrEMxgKynwpH
X-MS-Exchange-CrossTenant-Network-Message-Id: c7674bc1-facc-4ddc-e628-08d87ae09df7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 01:27:21.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yS+/F8kG9htwIKjn8DtoJpblw60YLqbwLekZJlJzxbjZ9W08y35lksOSaP/DJTfZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_17:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 suspectscore=1 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=993 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 06:03:14PM +0100, KP Singh wrote:
[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b0790876694f..eb0aef85fc11 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -493,7 +493,8 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
>  		func_id == BPF_FUNC_skc_to_tcp6_sock ||
>  		func_id == BPF_FUNC_skc_to_udp6_sock ||
>  		func_id == BPF_FUNC_skc_to_tcp_timewait_sock ||
> -		func_id == BPF_FUNC_skc_to_tcp_request_sock;
> +		func_id == BPF_FUNC_skc_to_tcp_request_sock ||
> +		func_id == BPF_FUNC_get_current_task_btf;
This change is not needed.  The helper does not take any
argument or do any type casting.

