Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79918FD87
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgCWTVx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:21:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727479AbgCWTVx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 15:21:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02NJLKNY023310;
        Mon, 23 Mar 2020 12:21:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kspl+/Vr3R+euAZFlRMaJNG6sb6mhZKWN3GWnLtSr78=;
 b=nUiOjHHhumBpHSAn7n9ih6K2HI4pmm2xuiU80DZlsetvhDn3dD0uA26aYnP3qplkEwqY
 k2DIT9Y8EZxpKV2nroHo1Ui7yrNwn/tmiLEwugIA4RcXD7Jz8LL+CVT8wouLk6U+wjdk
 Qi2qpnyAbkkLwgIbVEfPqNxK1DRBCZ9p2tk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2ywedxsyjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Mar 2020 12:21:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 23 Mar 2020 12:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msD1lB3X4FxL3XXrXt3JWTJlZmlK8RRU67/wj6dvlxoh5tSTjlbC83ZetDSftHXlp3OBnGYdHKMlpNt7Ii7A4fIwIQJiJN5OXlxyIeTQy3GP6KfZTllaOQ4QxVithu2PQhCc42yhhsE982+xY/oTaZx25U2Q3hG0/2fLAgwzsI7+7jHfe275NXYexsNR3WS/jAFlk//zylOpI9EDgBp5czpXmJ4+PFAToqh7R1Gb8oF7RUan0XvIUwSz/gKLz4cuqff7n+JKl6gpTqgNKtMEpkJHrbjAyNvjg5NOKEL7wLTvczGUUL1rdaqOJOsvkXU+UIAVY87B5TNf9ftiVdyWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kspl+/Vr3R+euAZFlRMaJNG6sb6mhZKWN3GWnLtSr78=;
 b=SRB0z2hc6da3ZjHjjYFEDv23Gh0COIZbcZtstVq8c55AdZ0jCf/DpznWuSttnP/SJRGnv1dFg3gOdTs04Qef5hqYH4RZe8ItcFsWb0AGrxXfzaSrWRarkA54+OU+QmHzlE4BVlgQYfUK3BS0GfXjuf6lbcu6Nwb8sSu/QsR6GWKLQwClKUzWERVCzuEAA++SV46BDxJv0/UCZ9PbcrmpVyUBrFn3Tnq8hIuBLS0LA7HHYqwLtEA22M4vW0lKqjwMOIXHPYo3IWwdiDa9htMFoWRwLH5QkiLFJyQ5im2Do0H0TD04MMcPphZ/jPKF23H00lyrJ081JVUtS1ogA9+vCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kspl+/Vr3R+euAZFlRMaJNG6sb6mhZKWN3GWnLtSr78=;
 b=kRv5rTrRLTzerEVXEgLFFCdLtwzY6eqK9XwRbzNvrQjmjLCX+mKxtE7ghmebZ3tqcTo00tpvnH5N5p4PoSZnbZQ+SuKY78YO3tDDiqzQTv9d0mPGmW0Ig/QNRLurjUhibcxma5Q4lnwVXBPPTIjsWR7aNNbw5QTYsHr2loFGt44=
Received: from MW3PR15MB3883.namprd15.prod.outlook.com (2603:10b6:303:51::22)
 by MW3PR15MB3915.namprd15.prod.outlook.com (2603:10b6:303:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 19:21:34 +0000
Received: from MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98]) by MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 19:21:34 +0000
Subject: Re: [PATCH bpf-next v5 6/7] tools/libbpf: Add support for
 BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-7-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5790d135-1a66-eb33-4eca-3f710e08a675@fb.com>
Date:   Mon, 23 Mar 2020 12:21:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <20200323164415.12943-7-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0046.namprd22.prod.outlook.com
 (2603:10b6:300:69::32) To MW3PR15MB3883.namprd15.prod.outlook.com
 (2603:10b6:303:51::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:2131) by MWHPR22CA0046.namprd22.prod.outlook.com (2603:10b6:300:69::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Mon, 23 Mar 2020 19:21:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:2131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 788c2215-64de-489a-1102-08d7cf5f6681
X-MS-TrafficTypeDiagnostic: MW3PR15MB3915:
X-Microsoft-Antispam-PRVS: <MW3PR15MB3915F4662EC25B2EF27B27BBD3F00@MW3PR15MB3915.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(316002)(4326008)(52116002)(31696002)(4744005)(66476007)(81166006)(8936002)(53546011)(66946007)(66556008)(8676002)(6506007)(81156014)(478600001)(6486002)(2616005)(36756003)(6512007)(2906002)(86362001)(54906003)(186003)(31686004)(7416002)(5660300002)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3915;H:MW3PR15MB3883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDsVsOwVCXd9/0KtBhNc+FciF2UAY60wdn6rfQ9m5IkWMWn0d1pv/IDLA95cHmrHoRMAP6EtMo7zv3+4Fm/KiGcDPPT16+sXKMh1tzpQxwfohbuhi/4E8nHLsflL+l9h8ET2pbe8ezgGQJjZI9BwuvhgXKtdoRjQfbJ59z/wX0zwjSvo6HoGmdbawZsju6asyawuVKQfqNr0uGkSpAdwm2JBVqi2JTODpVAiYw9Ha/9q3w9m08MVYargnUHypN5YkZIIxdLf4CqZKtsMxy6aFNulVqnbutGDalO5+0xw8Ukn5PDw+KM5XXBgBmeNqFMUy5IvPCTwNbvMq4T7w/fhQ+RNPb3VN2O4OePLYdmc4loogLhCrLsLgwIUNmg+d8fC44c5Gzli4vMkUHeeZLaBSfeObpyUiaof+Q4t02OyPsOOwZVikj/tt60aDMIBvBWx
X-MS-Exchange-AntiSpam-MessageData: KoP3kHJdkwz7CYKa3dnyvtjbDynq9pn+tz2MDEgyOnU5BTzkUBbJg7eJ0oltYp1bmn9JcR9DilLBeVOXJC2GzwAvjgcwrl8afz0aRJrjG6lueIOMOl+MlSwmEJ9m+csxHganv6bSBZ+vEzk5pZWf7PGl2nWNOnc5cLu4rYD3AXeo6X0l5eJox8UJih1M/KX0
X-MS-Exchange-CrossTenant-Network-Message-Id: 788c2215-64de-489a-1102-08d7cf5f6681
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 19:21:34.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQJuTfrVYeCxV0akOSZ8PJuuS1ynQtax8kgVDdo5Rw2Hf+6sVcjitbiREvFCp8I0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3915
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_08:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=927 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230097
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/23/20 9:44 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Since BPF_PROG_TYPE_LSM uses the same attaching mechanism as
> BPF_PROG_TYPE_TRACING, the common logic is refactored into a static
> function bpf_program__attach_btf.
> 
> A new API call bpf_program__attach_lsm is still added to avoid userspace
> conflicts if this ever changes in the future.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
