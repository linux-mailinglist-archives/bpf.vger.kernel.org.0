Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C580264BA3
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIJRlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 13:41:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23714 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgIJRlG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 13:41:06 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AHen6H003778;
        Thu, 10 Sep 2020 10:40:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=c5oatoK0mb/vudutndiUfPXFwJxKvJbQ2r7vqjs0Dv0=;
 b=ch7iQU/I1vvRWW9GJO1LahNxrkPMk4+xAKK2PMALPRgj/wv6BD4CVCWemwTNiRA33VsP
 zurt6XSRwtqluEt6OnfIrO74iAn+6fkNLUrX9aK/XmxpSHXm7BzvAIhdAr1Z7dwuCid6
 B4vf4Bz3rXYJaS2+twp7Jrrlad1ocK/y0c8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33fqeergwd-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 10:40:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 10:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju1vzOGU8fNtCi43FaFufs99Vk+wiQ5FEIuXYXveAYiPsfpvaLlgbj/gInwQ5ypQTTfNWR5abVLnm0ZFIstCBmjwZu/q3Rpd9zZtkrcV4DlrPhaj8TW3gVAVMyQdnofLyjv2PvtCJ3Su6Zfj4GRNr+j6V3qEfUg+RuZ7xPk6Nn7gtRpax3IRmg6GsPlN3pRZ3ij8aVNwvLDLPVdd0vZ8mQEZugy94C9rU+C6zxjYa5G47KlWn3dNamzad/xTbTm34mj4taqRNd+Ongtjj43SoTI6fCxSIkm2B9fYMA8dyGlbk26ErbYX/B+m4GFiz+3zsgyru7VFGvBzssJqSp/rrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5oatoK0mb/vudutndiUfPXFwJxKvJbQ2r7vqjs0Dv0=;
 b=Ab4f4lnQt9DGStFJWqLGIdpChFNoPgSO+k0jiy0tssv5INXucqnlvkxv8A1hSOAae3zrOpYlEqzqOBUov5jiNRNfttH5lYhmGw/r9NJgXIshmd5UrHG9N05qT+mZcMUsBHDCn6Vqt28sje1tZfFGJ1vLfAjsNNXZEEsHOBrYWmXIiJVHFbrnxqZNzv7b6eJeNgv2b6lbEAg77J7iNAtqeIZyhLZ2DQ8CW4RH+YP/583ZL48UkrURFUIB+kzPznXZQCgO0C6XVp1L7GekFu2M8a4SrGfDeHPgjOWOwjLNkNIrkPD0uovSm5vDjZwDKVl6yVVWWZ3Wi+C2OMbeZ9zZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5oatoK0mb/vudutndiUfPXFwJxKvJbQ2r7vqjs0Dv0=;
 b=KPRB8s6kLaN33qOBnp8b68VnL9CDNxcVxxvaMfapkaNiXble8RiPwT17zKKNNcmOqUFrKmBEJOrCtqf3QT7K4MjsOHPPLcK9mrmBIex0uJvv4PFtm69YJPvHM0QWIrQnNPiqEAzFo/PwHakkbwnwEqf/L5+wsXB7NLDt8Ix48rE=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2263.namprd15.prod.outlook.com (2603:10b6:a02:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 17:40:43 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 17:40:43 +0000
Subject: Re: [PATCH bpf-next v5 2/3] net: Allow iterating sockmap and sockhash
To:     Lorenz Bauer <lmb@cloudflare.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <jakub@cloudflare.com>,
        <john.fastabend@gmail.com>, <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
References: <20200909162712.221874-1-lmb@cloudflare.com>
 <20200909162712.221874-3-lmb@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <edab476c-9a21-f0c9-156c-4f12e40dae32@fb.com>
Date:   Thu, 10 Sep 2020 10:40:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200909162712.221874-3-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:101:1f::11) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11ea] (2620:10d:c090:400::5:271c) by CO1PR15CA0043.namprd15.prod.outlook.com (2603:10b6:101:1f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 17:40:42 +0000
X-Originating-IP: [2620:10d:c090:400::5:271c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e03cd704-2054-4e7a-e8d3-08d855b0a440
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB22631FA88D0255AB3C375E00D3270@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLYPAYGuTZ8pP8kXlUPXlXDW/rJuGIG119vp+nsz9qYH+sxJdpDa0DoluCM5R97lQROSdHH6J/UUvz70GF4NS7MJy8ghgR/9GVVcGKyUzAtBooQLwjhLK/x+O7yWpfYHKnj+kjjTP8ghsSbJUOW4j5WvLm3pJMU1xi2DFW1dVfaUhoVk4BoTs6j7WFyj1PVIoVEhqcRQpGLYMO8CenuB3ClnUFXbxd5i2kfRgwk7CmXaUGUrJc3qUChhZ2iCpV1Q+RrN3WhXwgy6VyfpAMV95JZCSQEP6MytNScD4ovHtdqFugKOXKlgtnRiE4K01tWvezBVouAr4wH7Imlj0CaKSOD2vk3Vyhy6Ax/M1r1MOSJLCgFcindfzPqnEsUu3YDq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(36756003)(8676002)(8936002)(4326008)(186003)(53546011)(16526019)(52116002)(2906002)(31686004)(316002)(66476007)(5660300002)(6636002)(4744005)(478600001)(66556008)(6486002)(83380400001)(31696002)(66946007)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lYkyX76YzUtT17Ak3X23j7UwFzWD9NspRCYhT9kl+eD3kkNnUnPJWprXbwUw4xYAoVbP9tktvMRF5qjNiDN1ryiM1vG2a2g+n7SqXyqq4Oeb8Q67cSt293DE70WePiF/rMszNmzH/oIBtc4gHjzaCrui5NWcBky2ILMZJb2v8wCTr9Lpxf3JxnKgLxCZnlGUE7Df62wp+LQeGRRBkk2pbRWNcYZitdGiUyaI2awnLCWZ4AOSWLUpybjIATCQwa+LQsJ4WnJBAoygiK6oAQA3mRqpEEvUDNAfXHMMgI0zaFCTb65XLcmczF/aCe8t1UZUVlprJvSGu4Ia9AfnGiKRDTkfY6tduCXqnczoGUff5n8bbLQ6DTQfZjTGCiHqF9uNwfJYWMQ8gAvsSRYb/QUmu1w0lSdssvStfHFzMaQ8GXwwi24aF8FkwKY8hKhxsEuJQN/L6Bd0O0tqWmzUIWcTte2zLT06Vxic4SnTPlLFbF/tQN4H2ZE21tyI8YGGW3523bSi/29YWOcJoj9gyMS+XLTc1MDLcqAkMBTEI/YZO3CKbj0ZNxLqlAMZOMW2gV8miNiQbwrbXzUbMjXH7RS9TsKNHjOxVmZEdfclCz6qBcC0lI+BvZl/Y6Gz7mN24pMQVE+uS+SJWPCFe2ZWr2JWaXEVV/aSS5EtTHSSXo4G3dk=
X-MS-Exchange-CrossTenant-Network-Message-Id: e03cd704-2054-4e7a-e8d3-08d855b0a440
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 17:40:43.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zaczg2J8HPn6x0IEW+aQhiliV+u2Gs+r9os6gNQAqYr946IedculgP8GcXP8Hg2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=972 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100164
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/20 9:27 AM, Lorenz Bauer wrote:
> Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
> hashtable implementation. sockmap and sockhash share the same iteration
> context: a pointer to an arbitrary key and a pointer to a socket. Both
> pointers may be NULL, and so BPF has to perform a NULL check before accessing
> them. Technically it's not possible for sockhash iteration to yield a NULL
> socket, but we ignore this to be able to use a single iteration point.
> 
> Iteration will visit all keys that remain unmodified during the lifetime of
> the iterator. It may or may not visit newly added ones.
> 
> Switch from using rcu_dereference_raw to plain rcu_dereference, so we gain
> another guard rail if CONFIG_PROVE_RCU is enabled.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Acked-by: Yonghong Song <yhs@fb.com>
