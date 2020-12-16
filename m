Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F22DBBD8
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 08:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgLPHJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 02:09:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbgLPHJ0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 02:09:26 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BG75CW9013837;
        Tue, 15 Dec 2020 23:08:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+VZM9gXMa+PcF6BUOP0nKEDRLRiJiH/5/BgnqjstVqk=;
 b=RwuWsP9XkRGvv5wd3jjglfBWgCAYEmSkmIpJoO2ELyUKPkXFTna99bBIQYwX8OuYUlNa
 Fk12Jjfu01+RngOHHRbK30yPKKx6CFSMLEK1rMUGNAN1hyHOkuFZSvboe2NqZkY5xPVK
 FyEZscNLss+Z6+J71nWdyypkVK0WTPueJeg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 35f7h61cu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Dec 2020 23:08:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 23:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msWHIB8G0SNRn08q+HgjLwzutjWkI4BcS5IEtYeBPrZb5ETBB5Z08O1LlPLVjYS9gFQuM3wvhtBdMIdjBmUnEI5WF841Hz0z870xcalFlXk+Vtim2LKjojL+jqUMi0M2TytQRu40Y4i6EKb/cvPz7x8MbjCRtfEPnntISzFh1VBExdz1gl2fVNNFKwu5mmEvfrJ9wThbWv/XTjgoR3Gyi26U7i4nFOJote2y7hzp1sLTGkwlhXFGeaGbYtrbl8TwqEMD/9YhmZhvcgPS0sf/BVih2fHfxA+egDEPqwNa/+PrEV9e12ElayQZz4odGwXaxoR9GfzdzJPuyZa41xJpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VZM9gXMa+PcF6BUOP0nKEDRLRiJiH/5/BgnqjstVqk=;
 b=D8vrXGF0lruDFyD3UnO/woXil1y6r5DTDDt7G/Hy7ugwdLMpvfujLIiumf/kElf3N4tjQ+DVFuVJ1a6e2xCGz/OBkqS+b0hZH7wpZqmlA5ohm974jMfw8zgcGKW0e1mVR8gEo1QMPRjbbWMvbAQe14nuq7v7OSGR/OHUxixYk5+E/LgfXCM/INEDrv4hMRcmM2WIdvECYcPo0lEdMa/T28OvcG1irVWiE2xSAbWr49ohVqD9YT8io/6/e8CeJwJ+2h5L5mUtvsUTGzoqpKAS3McVJibM3fW/07FJg8NZiUpoaq20hu1PMmeoNYgj6xshd41kW/LDPZyWzs7WbEN8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VZM9gXMa+PcF6BUOP0nKEDRLRiJiH/5/BgnqjstVqk=;
 b=BQyIxnxGyKNYfGMOXCvRGSUZlyFn4zYDXgJW1tcn+J1qBzpwHigO93z1/0H9xDNNx8MEFzpVuvkT5PrMiMLBOBNrjJFb9I2sRe6kqLl6MIStiNwt4D1gs7h9efExRB1MGvqKsI/uZV7+53F2CQl3BHVYy4T7LWoBhSPnutEfpf8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Wed, 16 Dec
 2020 07:08:15 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 07:08:15 +0000
Subject: Re: [PATCH bpf-next v5 11/11] bpf: Document new atomic instructions
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20201215121816.1048557-1-jackmanb@google.com>
 <20201215121816.1048557-13-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <fcb9335c-000c-0097-7a70-983de271a3b7@fb.com>
Date:   Tue, 15 Dec 2020 23:08:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201215121816.1048557-13-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:9412]
X-ClientProxiedBy: MW4PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:303:114::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::12e6] (2620:10d:c090:400::5:9412) by MW4PR03CA0376.namprd03.prod.outlook.com (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 07:08:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc60af1b-79a5-4449-4513-08d8a1915ba1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-Microsoft-Antispam-PRVS: <BYAPR15MB341300CDBFBCB53C1E7CFE01D3C50@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzvp2LrCNxPa5LTiRF+TPmyL/icx6DDsnD1xi7N/hmDrz8jLVEkQBIib3N5UUabIWDHndi0jnaxgi5I09/ZGj26/Si7oxAeyp6MGzsqbdBH9vqTfWrJZXRW31JOD0phmSQIqdxhx0ftzoT6OkszP3HJM17JH+dz3nb629P1NLImKwYWVy9orlchFT5muF+4tH/Mg8FOD1UtaBQqKdIDNdryxWEtZfpYgOPTHLh+5vb83F5OYVhLgIf0VX3loSUsgBc/Ou03V8A1IUwLLBPLtaqDn3nZSaHrV+FnzH4UAoXvteeF6urS0sogLqtiUeF1jhqVSlqpYUdKi6rLqauYTn/Y2xpleH14JlMsPruqhDMg9oSC1G2FDKHVGwrga3fV4k8DbBx+xw+TzyKm+V6iaS1yaktxBQpzmnegvIxmhi28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(66946007)(54906003)(5660300002)(2906002)(186003)(2616005)(16526019)(6486002)(31696002)(36756003)(4326008)(8676002)(83380400001)(86362001)(66476007)(478600001)(8936002)(53546011)(316002)(52116002)(31686004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: V68Ee01TJGW3fMJ7CKZV12WOBvzBMqeApL6QxBtFM/Bf2RmaRM/e0EJ2hIu2kqymMmVp1hTl9AuorK1VNySzbb/12pCTWaaDgCv8ymzRiIMbHqkJvwWpz2rH1jNBxQmnzS1wN1KTCTpmtpGu0sZWTixAfIKHm5og5LCQaKLpoTZpLXWoNFCMRiK1LhrYvKIwsGErcnrnYN39ZnAq908IDJSAFEzW/oJdJJ/YDnMCc2yjKnMl6nwKao0+WPFK93f6iX358kbuyzVpNFriJQARrrIb0GOGHwWT5fMjarEZTxVsAZlBGpJG5kViyRaFUfoYwb2p5HZbBWM7X5SWw1ocPK1IX0q+NpX/C2hknUe+kTin7knVj3u7DzPgWCQDbDcLkKbj4WMX0ji6nONObZt9HK3StApuY5Q7DPYMWvBumVHmNXwPZYvvNTUnzlUwEhjLRBAkEVzbX7Pup9doc8eNJb1nh/sr3ER+yfGQ2BLQVBJ9voewvHgKmRCUfiSz95jt7uJWBaTFZCsPMVY+4uD/DLez5yHJ71eCOJuqqvy6bg9I3OJi+2OGsOHv+8iWkBPyh5T1yoLP1k99WhAW3T5Jxzcok4vvO/eOwzUHqKHYgwUjhE76+zBpTx175N28mB6Mt+n0+yU6uSEiS1j/ZKR4zLeYbdiIH/1aAElc42nBIeQh5ZNUVoDTtoFx7M1t2m9fxmEjZagH/hVhUISzWnyDltlSVPYupCrk+z2/vrg5z5h7DedkDDbdOMzAAnZI/IqOknpLnWzklwja/lgHX8eD/g==
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 07:08:15.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: fc60af1b-79a5-4449-4513-08d8a1915ba1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecn/8pGlEunPjOZt3gkEJoO5QztImD0mvq8x33hw2t4lJHBuPnTyC6pMUdvRsvwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_02:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/20 4:18 AM, Brendan Jackman wrote:
> Document new atomic instructions.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with minor comments below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   Documentation/networking/filter.rst | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> index 1583d59d806d..26d508a5e038 100644
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst
> @@ -1053,6 +1053,32 @@ encoding.
>      .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
>      .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
>   
> +The basic atomic operations supported (from architecture v4 onwards) are:

Remove "(from architecture v4 onwards)".

> +
> +    BPF_ADD
> +    BPF_AND
> +    BPF_OR
> +    BPF_XOR
> +
> +Each having equivalent semantics with the ``BPF_ADD`` example, that is: the
> +memory location addresed by ``dst_reg + off`` is atomically modified, with
> +``src_reg`` as the other operand. If the ``BPF_FETCH`` flag is set in the
> +immediate, then these operations also overwrite ``src_reg`` with the
> +value that was in memory before it was modified.
> +
> +The more special operations are:
> +
> +    BPF_XCHG
> +
> +This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
> +off``.
> +
> +    BPF_CMPXCHG
> +
> +This atomically compares the value addressed by ``dst_reg + off`` with
> +``R0``. If they match it is replaced with ``src_reg``, The value that was there
> +before is loaded back to ``R0``.
> +
>   Note that 1 and 2 byte atomic operations are not supported.

Adding something like below.

Except xadd for legacy reason, all other 4 byte atomic operations 
require alu32 mode.
The alu32 mode can be enabled with clang flags "-Xclang -target-feature 
-Xclang +alu32" or "-mcpu=v3". The cpu version 3 has alu32 mode on by 
default.

>   
>   You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
> 
