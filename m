Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7832500B0
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXPPy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 11:15:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgHXPP1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Aug 2020 11:15:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OFBSec004840;
        Mon, 24 Aug 2020 08:15:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UyHqqEEy3gnYP7OdzbYiM1LXmWkzBpZxaiRCknfLk8E=;
 b=l6DNahOLkft1h5qvz5XYRcxsfdGo36KiWD62AOrKIKEpDqZSKvFCbzsUrOkdnHZl//xM
 2a1/zlb5oWKirjHGvUePQKVNdDJo3eoF7x973aBLY9innL5NVeyPkaD7NyRFr4Uw9evp
 ZrTDO0SrBuAxgBvwi3Hys5lsgzUW2f4XnPA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 333ke6d4w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 08:15:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 08:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1tFL+RUQJpU9TL9WIC1nmf3AnQe6Kz2K08mz+l43h6524m3vMwGCrTip7cOpIKi+EYA5U8Y0axyW2A0zPyhL9XCOxccygv3p1eKNQk/t32BWwAtigYPXg/wCMApHiYlt7agXhFbXxy8x+PryonsRl6DoJsead7xgFgH/mTY0hgMF+bbbKEKTM/DzIqAHgC76N4Z09khacVunS4FZvRkdtyCVN/9nl6v72wr/6efvAW245Les9hmVDU3p5jhQbLU8NVE+05GHuXM+fzmD2/QXJ0lEOgVmW2Qihc565AdcmhNt5ZaQ98344Dpr9R0lppqqrrqhXyEzbsKMcD3Hl6LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyHqqEEy3gnYP7OdzbYiM1LXmWkzBpZxaiRCknfLk8E=;
 b=Fqj7IVU6U1C2TI3TYYlJm/8s4igxjLUs3M4+v1J2ZBVU5Xrao2uzdnLUgBVnvXRMHa3JZeD/gQldbk+eRC8m4wVr7HfzpiTU0NLnHi2PeYM04tIzhlyjiykv6ggF3cQ3BXLp0jPfQoK4W3fGh+tXv28kXS2MUdu58UaoEytwgvwpyvN2xpYvMxSPxC/jwStZN11jPsFd8SIk60ZjbMF8+GpaEP1/SGztM0KuQbmlOAlPl9Q0pAFRoEQpYb7FiXL9bGSNPHR0ztM/Xeyny/NBfis1BVg/pvcRZZzwVetFdzuSA2qIuDV+dK7uSy2II1gqb/HkPL/moKNro7Xv38ecYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyHqqEEy3gnYP7OdzbYiM1LXmWkzBpZxaiRCknfLk8E=;
 b=dpqC4cMHcbvFLy1mN8wjgLkL1P69TcPNOxUa5SoSskr9W/UYux/qn8TzYLzAjImzeUxHvaNxXVig3uKfWoZ0G2LMfDCtT1YktuHW6ewlwUmYTbWqeEPND1TA3aMzKzmj1As7lqxpb8vxuD673xCktTYYZ3vlU2tziYrYZ2dkuyI=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3255.namprd15.prod.outlook.com (2603:10b6:a03:107::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 15:15:06 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 15:15:06 +0000
Subject: Re: [PATCH bpf-next] selftests: bpf: fix sockmap update nits
To:     Lorenz Bauer <lmb@cloudflare.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
References: <20200824084523.13104-1-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f984a088-e9d2-7fbe-dccc-d732f924467a@fb.com>
Date:   Mon, 24 Aug 2020 08:15:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200824084523.13104-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:208:234::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 15:15:05 +0000
X-Originating-IP: [2620:10d:c091:480::1:355e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1d0638d-7577-4594-f584-08d848407ba7
X-MS-TrafficTypeDiagnostic: BYAPR15MB3255:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3255213F7E395F72503C96B0D3560@BYAPR15MB3255.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMfiywQQpe6sYEDM4LqITWew12Bc6x3GQnhdw2KwOAu9W0RkaoZENerDJCMlgOKfJkuARxebZKAEz8LCvI4KB/spqAQODnF0V3JgulDpZYEGqFoMC+DNErDEG9qZl1zwIZBM3y0i7slMFuTqdyN+ZhqE4Mv3vm8PJpJM9Nno5x7be0fTcJQGGwVli5tbdU26+fYb+HXyHsNRBD4drdP0K6F18EvQ1Pgfc8c3pL2c6I/etiBeuGduQ80KLVIW4USdTG5A+hDoM/AW2dfSf+nnWXquJeJuTutkDxV5duiiyQ4cBKp9kzASVB/Vq/aOqLYWjM2EVaLlCgR0ZzttOwP6jnjrGzo+Oi+w8G2URYBcKgWMNBUg83WA2gppVTdrKILP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(136003)(376002)(558084003)(16576012)(2906002)(4326008)(6486002)(36756003)(956004)(316002)(31696002)(2616005)(6666004)(5660300002)(8676002)(52116002)(66946007)(86362001)(8936002)(66476007)(478600001)(31686004)(53546011)(186003)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OLrA1bPf+q/oowX2epAWrkas0+3a8/u5LLE/2REOFdJlg99lBn5fqTvBGoKV2ek/zS9iwrOkWaM9i+ETwFi0JaLQLg96vHDBffbXIQGyK39WYIxx1YVFLhuTuIqRKbfPhcCRW/DdgRsAzQrFZA96zjI+Zt55i3EJbTE2pX+PMKVNwfUgZ2w5OLUBWgReC/hvfRLUQ75d6ZE3SNBbjGDfcELlJ65hWMNJ7KW6x0EHpVLhwJpTTEJo181KMa0Vt947s611lZE6gt4xM+JG2ygijpnBLNr7aN6LFXygZpjgaSbNGPuJmymSZ6Vpwgkr4Mgzhx5xx+36eYd0hE9MZdu3RaB8aahUnPz2KCYJUUDo574OlDrnCrNAqhtajFdBjkRwby4O6eORuntSYq1g9dU+C2SINBUAI6sau9KeGDZeNRjIBKbZZvXZqW6j3dzfqBFTZobhxI0cFsjI2+jqUbDJx0Rjz9vEcRdAQ5IxnxCfmKyC/olZy1AYXHHwSJalAv9aYYxesRHQckHRJTVq2qvKaCDXhqVCJk1DhRIZ7vmKOZZWZ14xoNWgnmRsa3S0ZZhjeIT+rmJdDUKUPBA+ZgtafkAsv2Yk26PrtLofxfCYnhggAsWel7F333rCQKMhydcAOFhOTF4CnKzrFx9uzvKF48Z8YD6wcdTfnAgBn5ms2PM=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d0638d-7577-4594-f584-08d848407ba7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 15:15:06.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB3Obx29LxEaA63dKnLyV6EZnMm4sErSeORjhtixlUdPmP0XUk5Xkvm7yM4j7gcn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3255
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=955 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/24/20 1:45 AM, Lorenz Bauer wrote:
> Address review by Yonghong, to bring the new tests in line with the
> usual code style.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Acked-by: Yonghong Song <yhs@fb.com>
