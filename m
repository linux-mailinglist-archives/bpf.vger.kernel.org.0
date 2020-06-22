Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CFC203EE9
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgFVSQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 14:16:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729873AbgFVSQg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 14:16:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MIGEBu020656;
        Mon, 22 Jun 2020 11:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=k1M61F5Xv8Phs291FjBK3O30doyvXKFLGAuCEx4Dorw=;
 b=FhZ31lTz0u1DzKLBkUKT4BFxFR3atCLVpP41RYW/xZYA8eJGpb+cAceZfCZoY9IvDN5q
 sW7tUCKkcvVR66usDaGzXPAVbj2cxrRJo+jXXFkmsHKKwlOU74tzXOd1VqGPSWESDibX
 P/6Guckyclm3NGvQoJ0AUVBGBl9Ny8y2ONs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31t2qpxs8y-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 11:16:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 11:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg7ZXsD+uUdqjfDnYBmCSK5gkODXI55j2l3PLgdA+rJGzqNhhDo0gAhYqBLjo09gkpv67KXnJoe2wOgcQt+LF0OS5C7LBCLnW2rJfi194qA0xGrfYCFFC/TSChwc8qBoj03a6uzPVZTPZhsiGrASISlLKqCowSjGmSwAang08O2BJaYyQkrp511p7zIuLeEUE1lI/mKH26bS0h1ZHpLnmIR+Pwt7MycsuMRTJjq7VA/xssIVw0WcWASz4D5by4Ws1dI02pjUtmxfS5joj3w0aM7iKRtrKSVLOR13HSBUwwtW8x2uePkY/6JWk4/DT+0onu3Qj6Ybp+E5HwiEJcL5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1M61F5Xv8Phs291FjBK3O30doyvXKFLGAuCEx4Dorw=;
 b=ckngWXpQ38+ESJpmf3XJ1V6k0mRhxukRVMRz0dIBhsInrc8CrbBSf6tN5W8nAoC5Vou9aw/OmzMW0fpMuY40BXdTonpwpK08JsqCd9lvRGNigos1mDQLr6WaNWjp2jSocUEzZHjXVaa+wACM8UfjA4SK4rAvBMnUeSVydpTzYaRpxOp7JfKhWFjrLcvK1G6nJmrjxFa3rVb6uxQ7LpNsxDoze2WYC30bxPeW4bAi8Yf4E6T9gIHEoohdgnNb/CUOnQLRluxYcdQzToRaKunGG+EGDtHO5JdMBAzqyBaEIfRYrvJ1i54HaYgyjKMFC5ksCXandiMQGnJ8MYD1PWzKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1M61F5Xv8Phs291FjBK3O30doyvXKFLGAuCEx4Dorw=;
 b=S8iO1gmh9xFM9wbfRAXFyEKJc9AHDhUocHSUTtYbtBb2y0/HitlQR0FsoD3iMiINhagLYrU/XJGb/TxYnwhkSeUX05/9yD3XF1mXuIZpV5udbMCcDu41nmSCQGr265fWLNihut3I4mWDIAK3hI6FpfjTMy9Fs44a6C6gfe3xqI4=
Received: from DM6PR15MB3580.namprd15.prod.outlook.com (2603:10b6:5:1f9::10)
 by DM6PR15MB3740.namprd15.prod.outlook.com (2603:10b6:5:1f6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 18:15:51 +0000
Received: from DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4]) by DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4%6]) with mapi id 15.20.3109.025; Mon, 22 Jun 2020
 18:15:51 +0000
Date:   Mon, 22 Jun 2020 11:15:49 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 02/15] net: bpf: implement bpf iterator for
 tcp
Message-ID: <20200622181549.bnw2baskan2oundq@kafai-mbp.dhcp.thefacebook.com>
References: <20200621055459.2629116-1-yhs@fb.com>
 <20200621055501.2629441-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621055501.2629441-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To DM6PR15MB3580.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a594) by BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 18:15:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:a594]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8ead5b-56ec-4081-c318-08d816d84bcb
X-MS-TrafficTypeDiagnostic: DM6PR15MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB37404B1D5EC779A3C949479AD5970@DM6PR15MB3740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KA1Ottnd+SIv3ayRxNQWw+8nIY4F0FCo2sv2orvJ/GCGvGP8vPehVMEA1nV9RivJRZ+taDRxDB46osB8GfHiyWY1uevkjCdsDwSB8/pqlrNZa3Ij5tNZVBn5lQ1/E38atQS+ClVsWYjlGTxqdUww+WYOYoapDLcgztCX0TpHEABi0I9H6fffbB1qVJvSU3FIeZjmIsXleqOEi4bCe1LMctaH8C3bsOwz3RRnliQzvhUv5V6Dl7qW2RVfrUaudo66o028w9NARammgiklxog1eCxZ5CHTGkbabfNg6o5yHPpqRZm8lOuar6Kg5BT7Qw50zDg4anu3v6P2Ida8gln/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3580.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(39860400002)(136003)(376002)(8676002)(1076003)(4326008)(66556008)(316002)(8936002)(6636002)(9686003)(558084003)(6862004)(186003)(16526019)(86362001)(54906003)(55016002)(5660300002)(6506007)(66476007)(2906002)(478600001)(52116002)(7696005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /r77/UxD/QBS9GpeG5CW3mm6adNJCyrH0eG/oLIulexCZbPKR4Jc/km9/qNN+DtVf3/JqZIOYT/QBPAPljP2cBtFAHPBU7uvS1LhetUTDcHpiMrUvO76M3U/3udC1gXpthh/D+7F2ilpZi8diK288eqPzUYXOqMVQsc8zAgjCIjTGTal66rNIrOxHrIPbnpkACs82+uObZK9zB1le8+nAQjLgN7FkbbKdV8iBOR0YvaBDutH36IWPj+n36WF0CVG6jfZ3aEwD3P6aGNBKf8CRx4fb3adIuSVwiz1q8svpSOux8nWTFEGQHXTqIlOaybKp38ZUuD0/TYZPxIZjBPpngPhyKWH4CSWWyo5BtxeRiA0ibFL163VftueEH9JJwUdXpVP7N5vDodweSiIUlRN2fgAudF0ACPCcm8hbjeTg7NqaDt6ZNE28XxqKIS9y8PvPx8ZS+4nBV1XKKmjX6YQiCKESJQsXrR8zK+MoHrQ+IicEL+BVKUBZaLzFLzMILK56cC+D4aotowHR0Dz+4Tq6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8ead5b-56ec-4081-c318-08d816d84bcb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 18:15:51.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juFZuhT/CNoDL088O4PX0gGSMAWxiaQRHspHAXOyYQuOJ1DCYuRUVuE/gjDOrUyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3740
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_11:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=673 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220123
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 10:55:01PM -0700, Yonghong Song wrote:
> The bpf iterator for tcp is implemented. Both tcp4 and tcp6
> sockets will be traversed. It is up to bpf program to
> filter for tcp4 or tcp6 only, or both families of sockets.
Acked-by: Martin KaFai Lau <kafai@fb.com>
