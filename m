Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3987212EC4
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGBVYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 17:24:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6394 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgGBVYb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Jul 2020 17:24:31 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 062LGEGV032281;
        Thu, 2 Jul 2020 14:24:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=E9ErZ7Q3XrO1F+FMeO1UneUfzofohKzl5vKl5NdzPCI=;
 b=HCC0PMSPKMveKu4zIN4oSwCDcJcCBuTw/t+iBNjhvZEZ2c0A3V9DaPAlLB/0UHSghncT
 /XPUiZ7NeJKx5/jdB7SMsd9l0ESg926XxQQvym+6EixkPTwLerBRe/8jaTEYTliNF8lY
 QTP1zbB8sqQ384VBd4gcMjciBGSaZq0FpYk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 320anfbxxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jul 2020 14:24:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 14:24:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKOzIeeDSA6jIx5Zn7HwN4j1ZVEhkBDYFv1/pP4rdHsYX6ZKgAhwfnOiBcbxhEDibM5tIhA3uH5pFi+obPdnpTWD6gctKNP9hq8R7s1ppW3J9xupXoDJf1vgy3/zcBrVC/F4OlfPaHaizlT3aorEepHMz0jKJNB3EROMe+0yxBIOkeoAxjm7tQV4nNcVkHy9c2/98N+JxrQrQ8ysYlHPw5SaB6QpCH9XPIXwj39qf7OuGz4BXcuQwVQeuS3jZcCEW+9TVa/fgSfXd9iSCfdJaasptKgC6zDtgNnRMk8bp+5TnkBWxlvHtfkoHP5qVfFqu38Z0WGquwQBAdzU/FArEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9ErZ7Q3XrO1F+FMeO1UneUfzofohKzl5vKl5NdzPCI=;
 b=UEfv+XgejxNhdFj97tcWw+MtGQs2pI3Ah/jNx88MOcjLuuFPwywupUAri9QwWJOF058flTQVlyNOMzCoY8+WNCKjtvmxXyStwY1RjYsstjEOkmc8aAHImPJxck5N9m+54kdiOQS7lwppIduiq36cU/a9BOYSdcbgwxo2JDkE8Tb5eceJQMDjJ8COnh//X63N11MmHgapAjvHwN6acGvIqLPBx72vZ6YZvP8pP1b5dNMBUEB5WaVihR664DCKEnDznpa8bz6RAb4Aeg0YPxRDi7tAqgrsFwd8KZ6iZ2rPO9WIc5XlkOFOoAAJnnkSLPmBCi0cJfEsB+cxvJFYtHAj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9ErZ7Q3XrO1F+FMeO1UneUfzofohKzl5vKl5NdzPCI=;
 b=MGLjIywM909awx4SRm/31yXYtlpo+LxHOcpOLrXA7O870cqbm/d5aIVRG5To0ytcG5tKEf47Mdkpj4pXGtftnxzaiSJpqYqI81CTfcP/U+eZ7Fdn0FAusGxDFCU9Xhjos/0DrYGVANLCxDVaL89xZO+8mmz+6F5wAwlMshtvWhE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3189.namprd15.prod.outlook.com (2603:10b6:a03:103::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 21:24:16 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 21:24:16 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs use another shell exit
 on non-actions
To:     Jesper Dangaard Brouer <brouer@redhat.com>, <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <vkabatov@redhat.com>, <jbenc@redhat.com>
References: <20200702154728.6700e790@carbon>
 <159371277981.942611.89883359210042038.stgit@firesoul>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7b3f6c32-78e9-69fe-1f49-7065149e943e@fb.com>
Date:   Thu, 2 Jul 2020 14:24:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
In-Reply-To: <159371277981.942611.89883359210042038.stgit@firesoul>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10fa] (2620:10d:c090:400::5:1771) by BYAPR02CA0030.namprd02.prod.outlook.com (2603:10b6:a02:ee::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 21:24:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:1771]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cdf4b12-7acd-40a6-c5f1-08d81ece4639
X-MS-TrafficTypeDiagnostic: BYAPR15MB3189:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3189F93327FB41A497888BE0D36D0@BYAPR15MB3189.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2H2FIr95L/TRbT5b4jpoQPGnt+jCcX9yuFDJC3J4lz4y/hAlALE2HJskhhf6peUEfYsrOcZLL6o5p2zGDMLempmJ35JasRzbuijXEaFJAxC/hBSSC4YoSH8smtRJcCDVTei8vpe+oJxM77Y6bofYTjQgJX8J7JsufGfIj69WxtR7LbmH91I6Zl7Izof3A1cC5hOAPYyO+BwjKTPCFxCpDe+gU9VW8Pzc7+0w2QdSJl1pn37jxZkPlSIO4rIafEjkZS3NufdTtCnjVpBzWNedGqkwbKzE4ZTQR46oUOXsaCfO5qOFQ9Xf6THvBo2UfIFgB5VJwP0nbM4Itft387dialHl0zrLrLoAUL18Zsd74qvEgsJ8uhiWKndxWKAH/bC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(31696002)(16526019)(186003)(83380400001)(86362001)(5660300002)(316002)(4326008)(66946007)(31686004)(2906002)(66556008)(66476007)(478600001)(110136005)(2616005)(54906003)(36756003)(8676002)(52116002)(53546011)(8936002)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gIhKeY45H+g3xorkSfef3BjRmoc37VG6tGf4pd0MjUKoMYKl0kXJE93mMmi9gY65vBNXbqTupAxgzZxxn2TZriDOhrfWhGCv/J3OP/bkEQ1oIWCiApYd+l3woZjd2dKvIu67QBadLMiexOgSC4hjF9fjPnPHT10REfr/ddEG7beB7L7z465RsVYMDpvB2uf60fRuVLV7Cltx1E+kDMnY7AQmg1JMgxS1bVHjmZS/VYXs9RAqY+tQheOBTtESyrAuRxHhTKDcQ+XqgA0ZWYmpIDu558lAtrUjk1wUYW1IVbNc7FSnDRSPvpUgt5EAaDxV/Szpx3Jr1yVL/iOzMES9NlJZ480GB6xYYsEHjaC+vbNJqjX/mG96M96dBysS5IfA9/kgigAHvSXoT/y4/nPakHaQ2H8jbOkA8c6NpnWcT3MK8R2fyimw+SI0AMJ/OsPlRSW8UX5hpoLYnDGWzHSryOn+NCkZFSiKN5eipVY5CsnYo7rzwHu2dt+9wUaq3FpFvH485fpdpnD1TdCMQMhQew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdf4b12-7acd-40a6-c5f1-08d81ece4639
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 21:24:16.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixMeXE/9bu2Tan4Owufnqwv0rYfwTzq1CYO8K/lFC/JYTXo989G4F5qD1FMWOoeV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3189
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_09:2020-07-02,2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 cotscore=-2147483648 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020141
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/2/20 10:59 AM, Jesper Dangaard Brouer wrote:
> This is a follow up adjustment to commit 6c92bd5cd465 ("selftests/bpf:
> Test_progs indicate to shell on non-actions"), that returns shell exit
> indication EXIT_FAILURE (value 1) when user selects a non-existing test.
> 
> The problem with using EXIT_FAILURE is that a shell script cannot tell
> the difference between a non-existing test and the test failing.
> 
> This patch uses value 2 as shell exit indication.
> (Aside note unrecognized option parameters use value 64).
> 
> Fixes: 6c92bd5cd465 ("selftests/bpf: Test_progs indicate to shell on non-actions")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>   tools/testing/selftests/bpf/test_progs.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 104e833d0087..e8f7cd5dbae4 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -12,6 +12,8 @@
>   #include <string.h>
>   #include <execinfo.h> /* backtrace */
>   
> +#define EXIT_NO_TEST 2
How do you ensure this won't collide with other exit code
from other library functions (e.g., error code 64 is used
for unrecognized option which I have no idea what 64 means)?

Maybe -2 for the exit code? test_progs already uses -1.

> +
>   /* defined in test_progs.h */
>   struct test_env env = {};
>   
> @@ -740,7 +742,7 @@ int main(int argc, char **argv)
>   	close(env.saved_netns_fd);
>   
>   	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
> -		return EXIT_FAILURE;
> +		return EXIT_NO_TEST;
>   
>   	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
>   }
> 
> 
