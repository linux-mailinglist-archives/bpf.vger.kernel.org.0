Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C141A1D35A9
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENP4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 11:56:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgENP4p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 11:56:45 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04EFsChQ003879;
        Thu, 14 May 2020 08:56:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CPjYngAEW7IisqSPj5BNlOcYizSJSYG4Q2tp1MtPP1g=;
 b=lFnLcDD0t3wkuJbAY0bCmnRCny/bzTzGxOXpyAee9ZPXgvWwNYm3LEB51Kdyk3k/Le0+
 sWi19X6hYc78UFwXlZ0k39X7qEZ133H41kiUwttokXP+CG1yxLSu2tPtrtC2XDzS9lVi
 cOcKtNZ0H1pQ4uq8ShG+dV5ARb1tWiCURrc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3100xhc7xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 08:56:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 08:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAsMU/ILr7JmS+6JKO9KVoQXvUmjOFvJcRoGbymn6GMl64zv4DwXywErp8EwHJE4l5+ZCYOL2xUTTvK++b29VYESKwL2JmfCwrGfErIn+7vrnctsPq5plbdMEOTSc6LBPznwvWM+4ompH2DhYUz3mnRHnegIr7fUVnt6sSjTTSqx9ZgN7Hbynp+RQBzr+8ZcJfcqSLF2DkMwyKQja2HlArtsNhDgsGOTSZHMWgWyiiJF7Mjp2fCHQ8b3ee22md23W9JErAGFfyV80s7xgEB5iLIs/I5IY2lM380LLPKIk8xp8hH/SY3XVZ9iODLl7yDM6e0vNfphVpDGylY0nGHhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPjYngAEW7IisqSPj5BNlOcYizSJSYG4Q2tp1MtPP1g=;
 b=QFdsJViUEsmxCre9jdboN3yKHaFqG/+DB/fP41O26CyJwq86HlAcSjHi726rUweRgAkrOHxJVeXAYeUfHV+opXZ6TfyZqEBXs3lzgJBc+fU5nCwEk9GMmYZH2j9ExuelfTPC7a/v9DcyJqJ8uxAII+aaMwGQsNrlFTshiimn/2emkvO8Mfsnx4T1ejcXVLiJqsH1x5qeayTsrHBulxTzQWEZR1oNAIRs8VeA6PXHXj/UYR9e//rOgqgrQDRzGCQWnJcpz1SfCutWQbuc7tulkIxMmGTulTPGaocZpHzc1Xd47QXxpUWrrmtuoH1vyd28sPsci4pUqR+2Lk2QGSRdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPjYngAEW7IisqSPj5BNlOcYizSJSYG4Q2tp1MtPP1g=;
 b=PDr9ggpl6t98Mv1lCivOT7FrMDbC8AF8jrNEUEFW/o2HyzlrbgNhbZXXluy+yt1eWa4nZ8bgDgtm+PxWMTA7lNQLuHuJ5p+2h142PCXZZ+DODr0NLvnTDmhK60AddetmgycBk5ZBaxmXXZCuLbKmFb1mEa8QSIYHGGo1W8vpCj4=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2854.namprd15.prod.outlook.com (2603:10b6:a03:b4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 15:56:27 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 15:56:27 +0000
Subject: Re: [PATCH v2 bpf-next 4/5] selftests/bpf: Add connect_fd_to_fd,
 connect_wait net helpers
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
 <bf2359639287db9adef2c4ddc1a5e16e466a594a.1589405669.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3f5d4625-32ee-7739-ccfb-53c19e38778b@fb.com>
Date:   Thu, 14 May 2020 08:56:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <bf2359639287db9adef2c4ddc1a5e16e466a594a.1589405669.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:3bff) by BYAPR07CA0040.namprd07.prod.outlook.com (2603:10b6:a03:60::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 15:56:26 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c80ebb82-71bf-468d-f875-08d7f81f5c40
X-MS-TrafficTypeDiagnostic: BYAPR15MB2854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2854D90C3539CEFB42839126D3BC0@BYAPR15MB2854.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRxjZ6vbXXa11t9wwGY0VJVtFjidvndCWxsXsrliCb84dwuwIetdUi9nJ2XfYXstqC8Skm4DH+ObcomyIZNX48l5SduyDOjJWAfksyq+AwEgPOPDplv0lGps0fQI2Wyelf/rHU0CwLssfgxktHzoP7sx6LRckvuDeIpXQCx4MAjY89L61Vg3GIkvYNt4VZD0EvEG55ZUl906ONsjY1vCqZdFSds8+Jau2V7iFTqMdj22u06/nvLyan4+BuUVy8ayl4RW+t4IXOkK3HVacsWezFkWmVe3Pp3LzoiKrgJX+suBBw1cy5VP3lF1Dfgm+F5UBP8PKdwHxZvlxLQhqXVI7K2ZZU5UkNh2dukhJV95NkP2XGh9DUocKr/8QoqRaQ8VSlcIwt3Yt4jwmDciggkTQQ3fxRU3vnamBE4ECAwgYPZwYFhoYHuiohkd2d3et7h6Bc0VgwQaFhApN5bZ+KEmytUXZf9JWGhmEGII9qeKa5ubHfGDLea3cARiRDZd7U50
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(39860400002)(376002)(366004)(136003)(86362001)(31696002)(2616005)(316002)(6512007)(6506007)(478600001)(5660300002)(31686004)(53546011)(6486002)(8936002)(66946007)(186003)(66556008)(16526019)(36756003)(52116002)(2906002)(66476007)(8676002)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: uNShrWGY2T9oX6Q18U+Zgy2xC3plXY4/xU6PyzojiX+B4KPK41P+Zjsz/CNobY/1xlD4lYbGk4QHA0Vx/h19FywGVHlwPl4igvWSwtMC+xS9I7cPLCC9irMJclnmC61g/XeND0mbiPXlvKgnWqfmSEhy9p4i5935JNzqeVA597hc8uTi7ORHbsjYnF34bi9B7w/QuKJBLZsmTthS6iBcI3lRPGVeOONRmNf/GQIQsjFluNct1Rw0LFALPd/VIKpAX788vqdlfM2NLYHK1gvGPtHzD4+ClVBc67zyo1nb8TC4CVSEz2gSulGrVWNNxKRjieRXeusP6YL55keTu+WAzy8X3E9LmugnXzrs5U4ZbW82OEXfuQf79cYCrj2YqR1M8rFIOvg1Ynls9OP8DwMq0Gv6eFlOTjwPR06F7mMM7I1woSNFlSWBLwIWNg0vpLSoOFnOFt1UwVjUNyU8ZiKFcRbVaUg+dTNoVSzoZPFtTnnPAqvkZ8Bha7AvyrdzptIATj2y2UYigFDwR/Hke0Y1rQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c80ebb82-71bf-468d-f875-08d7f81f5c40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 15:56:27.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP9V1luwp9rKyQUJhxGRSnwVbEORxsWmc2bZdfWvRukuqQ02ppbF80j5jDAt78tX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140141
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 2:38 PM, Andrey Ignatov wrote:
> Add two new network helpers.
> 
> connect_fd_to_fd connects an already created client socket fd to address
> of server fd. Sometimes it's useful to separate client socket creation
> and connecting this socket to a server, e.g. if client socket has to be
> created in a cgroup different from that of server cgroup.
> 
> Additionally connect_to_fd is now implemented using connect_fd_to_fd,
> both helpers don't treat EINPROGRESS as an error and let caller decide
> how to proceed with it.
> 
> connect_wait is a helper to work with non-blocking client sockets so
> that if connect_to_fd or connect_fd_to_fd returned -1 with errno ==
> EINPROGRESS, caller can wait for connect to finish or for connection
> timeout. The helper returns -1 on error, 0 on timeout (1sec,
> hard-coded), and positive number on success.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Ack with a minor nit below.
Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/network_helpers.c | 66 +++++++++++++++----
>   tools/testing/selftests/bpf/network_helpers.h |  2 +
>   2 files changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 0ff64b70b746..542d71ed7f5d 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -4,10 +4,14 @@
>   #include <stdio.h>
>   #include <string.h>
>   #include <unistd.h>
> +
> +#include <sys/epoll.h>
> +
>   #include <linux/err.h>
>   #include <linux/in.h>
>   #include <linux/in6.h>
>   
> +#include "bpf_util.h"
>   #include "network_helpers.h"
>   
>   #define clean_errno() (errno == 0 ? "None" : strerror(errno))
> @@ -77,8 +81,6 @@ static const size_t timeo_optlen = sizeof(timeo_sec);
>   
>   int connect_to_fd(int family, int type, int server_fd)
>   {
> -	struct sockaddr_storage addr;
> -	socklen_t len = sizeof(addr);
>   	int fd;
>   
>   	fd = socket(family, type, 0);
> @@ -87,24 +89,64 @@ int connect_to_fd(int family, int type, int server_fd)
>   		return -1;
>   	}
>   
> -	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec, timeo_optlen)) {
> +	if (connect_fd_to_fd(fd, server_fd) < 0 && errno != EINPROGRESS) {
> +		close(fd);

Remote possibility. close(fd) may change error code?

In my opinion, maybe convert the original syscall failure errno to 
return value and carrying on might be a simpler choice?

> +		return -1;
> +	}
> +
> +	return fd;
> +}
> +
> +int connect_fd_to_fd(int client_fd, int server_fd)
> +{
> +	struct sockaddr_storage addr;
> +	socklen_t len = sizeof(addr);
> +
> +	if (setsockopt(client_fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec,
> +		       timeo_optlen)) {
>   		log_err("Failed to set SO_RCVTIMEO");
> -		goto out;
> +		return -1;
>   	}
>   
>   	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
>   		log_err("Failed to get server addr");
> -		goto out;
> +		return -1;
>   	}
>   
> -	if (connect(fd, (const struct sockaddr *)&addr, len) < 0) {
> -		log_err("Fail to connect to server with family %d", family);
> -		goto out;
> +	if (connect(client_fd, (const struct sockaddr *)&addr, len) < 0) {
> +		if (errno != EINPROGRESS)
> +			log_err("Failed to connect to server");

Not saying it is possible, but any remote possibility log_err()
may change error code to EINPROGRESS?

> +		return -1;
>   	}
>   
> -	return fd;
> +	return 0;
> +}
[...]
