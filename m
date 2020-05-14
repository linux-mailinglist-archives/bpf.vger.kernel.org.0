Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0681D3703
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgENQxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 12:53:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10522 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgENQxJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 12:53:09 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EGnORt032496;
        Thu, 14 May 2020 09:52:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9DlQWW3gqIXJ1kQCMVx+KxDDKl3ESM1bzkChBTy+uzM=;
 b=gw1aSByufYjxyekZmnur1sDQrakXuQVBRRLgXTaBGX7drZ90w64os1Ohk2gD29pvuONj
 Ss48pBGIvKVwIbDQPBnwLKSd5nGnuKz0UG4bR6UZraOeZA1nPZWrTl8E1+PP/aqPJTKF
 d3XNmr0SELyRmtsbKYq5e4FVUXGQitWQwVw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3110kjtyw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 09:52:55 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 09:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVzuP+r7vm020Vmk/H4utV1ymh4NGikgKbwC5kHZzf1tVP4jGcXKKg8066usj6oMFjLnXeJJfbh3otqqkJH+vq3Pf4xs7IdjG/vPEj78rkKWQmPe8BhuEhzdJn8+T2k5elzviktCliSRuwxUYHiT1FCj8b3Y44L/8gFFogttQqWXXNNEY9hEgmK4EmTktZWfeIk2LRA366hEujxU0NdT6/hINdeO3dPPsaRdCDbPcFGTIKkos7qWAvp31CuTl+Rdhsjc/Ab1JJTkXp7QBjQVvRPNMKUjvNlAHVooPBo9huWxa1Vy2SFDrMSihN1M/NuJptJAdKrL5tbiC8N6ho8W4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DlQWW3gqIXJ1kQCMVx+KxDDKl3ESM1bzkChBTy+uzM=;
 b=LkhzzWzs+r9jzC/jMi64AdXK94Mc3SFGdmVhAHml4XTZOarOwB6WAPvz1YWwjCwjpJbAwYH9Ap/IaflHTfTI2mNnX400271djG0etcgdf2JZQWH6f/oF3Wk7ctu0TNcloP1KqhLfCjEbb/W3jYsX4gUkgzes1v91USCIwVNEGXS2/AZ4jTZeNuuGlRfuC6Dcz8vbNXd3bFDqeUPUEYgFwdnxQQS01CsUzI6IGNxqitNkvKUeZQkbsMlmrm2vxKcb1lB5OH6HWWkpcebnvzm5sqpvf0owLaa6K65RZa/MgtTm+f9MgNFbniT4NahE8ikbefmg7m+sGciIrlvBdGfoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DlQWW3gqIXJ1kQCMVx+KxDDKl3ESM1bzkChBTy+uzM=;
 b=gz2Hnr6xnI/dE01YoB5aOEvwFF4vKvL/sR0tGtmAVcd5DVTms95dtwRBuNr1+cZQ+GRd6MWQLGSfIwpJhQJTZL2MRaNIqvi06fMGVJKt5oe1Ve2bnpNYKJPPw+I6/k+hz9sit2LhH6dsvr3d396kBVB8YFv7IxhaDhCy/XL/9kk=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2839.namprd15.prod.outlook.com (2603:10b6:a03:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Thu, 14 May
 2020 16:52:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 16:52:52 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: Support narrow loads from
 bpf_sock_addr.user_port
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589420814.git.rdna@fb.com>
 <c1e983f4c17573032601d0b2b1f9d1274f24bc16.1589420814.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8cefda24-320f-41c0-b73f-78be006f31f7@fb.com>
Date:   Thu, 14 May 2020 09:52:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <c1e983f4c17573032601d0b2b1f9d1274f24bc16.1589420814.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:3bff) by BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Thu, 14 May 2020 16:52:51 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 011f1e4f-8a3f-4860-609f-08d7f8273def
X-MS-TrafficTypeDiagnostic: BYAPR15MB2839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2839D6042B70E9899D599113D3BC0@BYAPR15MB2839.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFrVylXU0jWZB+gb4BocnD+YjIBRLckNURrIlBFJBXXw7cZ7VthPCN7G7atmx7casmndmrgur6k78kHRJ4Wl4EmANNLTz6//a32BMrOUL1ySlVFJN/7sxITNDMThWxbxhIJ3eV+3ZtUk3BqufL+rvKtKMGSd8516eCjX85gWrMkdAWteo7PQvhWS6WHcieldT7tBgNtdN1DrIDgjK/FRDiTY9aMqRLJJcr490Yk0zg36HhCHOZpEum1CFUQWclrMdFXfESqEGqNN6CsOEvrrUuKseVJ3iJfgJr8h+VmMejAs19noGaSo1Dd/cXoJQBkcZisC8gTbQzE/d0+lTSOz2AaPS9gL7KWwiqyqnjPNMKNR4wLGgJrx0g1p0ntD2DnNFGZJFfMAgoYD2ydrXT3Jpn2Xp0p/WlGl5RJaybCvYlZos6aPqDJ/gWIQaMEcPAheCbgfWEPbeW33Y4YG8wtgg0rhrT7lhsCwJ1oB6oCQsVBEcRTVQwEL/3uxoVwDkCsw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(366004)(346002)(316002)(16526019)(66556008)(4326008)(31686004)(31696002)(66946007)(2616005)(4744005)(186003)(8936002)(6486002)(2906002)(66476007)(478600001)(5660300002)(53546011)(8676002)(86362001)(52116002)(6512007)(36756003)(6506007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QHS2/27N9LESj8Stpx5IjrSBPHGYWPDBxWRTPiQjpdYDrsWmo78YSrn0AvTmMCj6kGkWndCF4DMHVnRzkFCFa6MLLDnob9PgX9LrQR8TdTHECoJrUfJT5OP4qFfewywCbpXtceVLaykB7rkPB9bconZVacR5nwpaOCx0D1DMRfn2I07rfvzCns5qnKnuPXEQaV6oFGvl5GCA+D0OXYOqBuOEIcSoCYCvd4LFUOcUhiuDBehm5KXnpxv2n7AGxeo9zf9i06GpVR1wLsqKwak8iNJa6h7hy7EOxdtxNeNM61UC+RtCjSIH2MISjczT+HTXAF/E/HUhoZENoRISg0arcqt59oPv9REiSYTt8sDaJQAsff3ahBKyhnB1x9RoKgtFpoTcPw9fPM0qC1WvqXtF/WKTdC8nNSMqXwvzeiCdQHStqxSEw8Sxpu8RwKmHOx8IGsoaj83FCcLNCd1nEhtrYsZXxrzYW/Om8dkauwA5/+DHubX6sGm7qgwlPfKeWWCX/l/Aw8zuwajrVSZoVA3Eaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 011f1e4f-8a3f-4860-609f-08d7f8273def
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 16:52:52.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DAuSeTB4u9eCkd5H6Viag2GsojmEZTAInMkKc5YhdNZjw5mmFdp53qNNvny+yg2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2839
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 cotscore=-2147483648
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140149
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 6:50 PM, Andrey Ignatov wrote:
> bpf_sock_addr.user_port supports only 4-byte load and it leads to ugly
> code in BPF programs, like:
> 
> 	volatile __u32 user_port = ctx->user_port;
> 	__u16 port = bpf_ntohs(user_port);
> 
> Since otherwise clang may optimize the load to be 2-byte and it's
> rejected by verifier.
> 
> Add support for 1- and 2-byte loads same way as it's supported for other
> fields in bpf_sock_addr like user_ip4, msg_src_ip4, etc.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
