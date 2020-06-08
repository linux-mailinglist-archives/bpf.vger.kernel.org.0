Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2B1F1E66
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgFHRdO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 13:33:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729550AbgFHRdN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Jun 2020 13:33:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 058HTDmU014018;
        Mon, 8 Jun 2020 10:33:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BTZeXcg+g+LlhAmRESeE1XljxBzvoui69RK+d80F00k=;
 b=g5G8/IAdLCsMc0Z+pE0l5V1W9oVlUu06hhHtys/R2idnte3RoDRkqGMQgo6OX8dcrP7a
 n6koZ0dcc3pcxe1olIqlzhpXvsqVH3RTrIeSxxeGuZYW11ml6uq3yUW0syPAm3PVV43M
 KAtPsoPxiv+JkIzCnU7uRv8Qzxs+wv4woZQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31g6mx0r7p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Jun 2020 10:33:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 10:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHohlyfuxFVLp1qizwxS1Ukv3wwi6dk+2AIwzAHD9sprfd0Yk7Y9Wscg6s2dlMFnmW2tiAP9fDIxcCHCltKqh8PALPR55DCcwQ70StVPkgu5O9+dcH794ujFokDEYfcLA5JMBYO6+gzvru7EI+K21RxiBFJifaifSI9HrLRO7JNnkoEN+iVFvasb29/F1GHM1bDwMLLDrvC4/fQpTYc2iTxd2ubDEACaAnbsGJuHumfK0HI46lR0G/spD/Itke9oNKsZK07PKuPxIojx8pEbDmeBDweYyU+sYGGYcnWUhg1irFHYL3Dns9qa7xq4USxeDy289G5qLzB1vth+OG3RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTZeXcg+g+LlhAmRESeE1XljxBzvoui69RK+d80F00k=;
 b=GwopA94T1DEL8o54MbD5k3Gd5WjOGHpjqzwUxIKDUvYem6PKfeRkYiygcVCzgGVkVkTd0mPT9rJW7Qt391SIfP8jec/90+IaCP5XmbpWWFmA+fDyT8tsjECfMRjswLBgyMfQm4IX/zyFQu9fMDGhevWKFvXxWaVrigWV6E3AGRBfiXiUKNzmGqLU0bJzg05trPnHhGngkHW//Piv1kjVYWWZ7fZY+O8yuwu8zxZx3GXfdBtMyV79tsMGpUMfJcGf8zzCQwIwCq9CjbINS+rp9HQOf4Q8Pza/8+9xMWOE1I6/Jdq81jHP50fuKKOYRKwsw9Rt97J6yrr7kUNjNitU2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTZeXcg+g+LlhAmRESeE1XljxBzvoui69RK+d80F00k=;
 b=jDWX18QK4J12Wzh+3C8K7QrJDMlhgfiCHUaYBe+nUqyQjqFBiVbJa36tTn4YcMwpE5Ca8g77qQsvS62oHR7CunWzzjAKr+J63z4yg+WzRFrZiUGhYannshOi5iEie2RqokV/5QhM8ADxFE1z/PLddZCTnpAjskF953rNcR/Vkjo=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2998.namprd15.prod.outlook.com (2603:10b6:a03:fc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 17:33:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 17:33:08 +0000
Subject: Re: [PATCH bpf] scripts: require pahole v1.16 when generating BTF
To:     Lorenz Bauer <lmb@cloudflare.com>, <daniel@iogearbox.com>,
        <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@cloudflare.com>, Ivan Babrou <ivan@cloudflare.com>
References: <20200608094257.47366-1-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3318a5fa-e4c0-67a7-0d69-9eb16d397f73@fb.com>
Date:   Mon, 8 Jun 2020 10:33:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200608094257.47366-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::167e] (2620:10d:c090:400::5:85ee) by BYAPR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:40::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 17:33:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:85ee]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8eb3e4b-b1b3-4201-678b-08d80bd20221
X-MS-TrafficTypeDiagnostic: BYAPR15MB2998:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2998EB7538278E659E06DB22D3850@BYAPR15MB2998.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CV3GxTXZr8bOIUaBBUyK31Ra4ucKixQy2AQ3HBFx6COda7xUEXv2KEABNx1BXiwluhr4EMn4RSy4ZTTepbbQT+DuwWg9r+S+XRZtuF60NPvtldVt0rEVsbcM5E9ILheSQmc/OGyICHl+HLxU7jYSx5E3BLAi3PPYUlnkK/oWuKrDwsOTwUnx/fTrhWjup4YuY68lHG6iM4OdqqSf3oMGnGLrdEeeGosgWNj1mmBGDcg+wnb2NY4+/KhMZNTslsdOXyJdMrxlFkKOsr3DkemWlRCG6GaxnYF7ACV9O1lWIA01ypAxt7MRGgKUElQm1/1zMtfuAEFYAtLF/xY76jA0QyHqIQu0B55WYGrd+jeh//sBqyCW9wm6IAJN8Y46zdDd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(376002)(39860400002)(136003)(316002)(52116002)(86362001)(2906002)(478600001)(6486002)(83380400001)(66946007)(66476007)(66556008)(31686004)(8676002)(2616005)(4744005)(16526019)(36756003)(4326008)(31696002)(186003)(53546011)(8936002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: R9IxhHWgsXtXzAXXq7MuVZRpIpJfyzpDoYrInrIDKA7tVIO3zbQi/R1mtJKwojfx1i30BJvCH13pF9JMShcMEgZGmWnnXpyloxSijWAHl1tvNPt5qNOM6BT4L5O3A94YEIg5mu7Dr1/xxzqOBr3TkJd6qlDAaLv19navWBVU12Vz9tTHSwuMfdCy3AOMjSNVMimEcQI1maSFwboEzmS7fLt/D8tcmZBPWzOzkzrgPXe+OQ2hmN1XWXrZR6bMAL+Z6oTVPP0XXiG2sewfrlQgDmZOiySzbiIFo4FT8HyC5Pdch0VCcRRMLYVYj/P0XGEVfzKC2rY4XsZ276nAr+QkKN3GGHIWC5DyV4Yx58yAM+onHCPFHn3DLMS6XzFpTzc45Dut+FOW+hkFWcV7i/ezrbCAFX3mM2zgxSwVJmUJMCht/KA5lHQJ0J2S2HMi81WZ2ZTTGxiRWjbrTc6K+p/HH4w4/gYyFhR6tmbt9nC4WwuHDb1gxrO3riHp2u6YD1hMCD6nWhBFcW/AE+0KpgcncQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eb3e4b-b1b3-4201-678b-08d80bd20221
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 17:33:08.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTZDLcItp+LvIuIjwrlv4MMQnJLQihAL7n2wazu8DlqbW4haT5JlXiZEtgW0kqWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2998
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_17:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=838 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1011 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080124
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 6/8/20 2:42 AM, Lorenz Bauer wrote:
> bpf_iter requires the kernel BTF to be generated with
> pahole >= 1.16, since otherwise the function definitions
> that the iterator attaches to are not included.
> This failure mode is indistiguishable from trying to attach
> to an iterator that really doesn't exist.
>
> Since it's really easy to miss this requirement, bump the
> pahole version check used at build time to at least 1.16.
>
> Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
> Suggested-by: Ivan Babrou <ivan@cloudflare.com>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Acked-by: Yonghong Song <yhs@fb.com>

