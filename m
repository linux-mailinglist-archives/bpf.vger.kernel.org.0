Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD36B24406C
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 23:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMV11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 17:27:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48964 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgHMV11 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 17:27:27 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DLImuo011959;
        Thu, 13 Aug 2020 14:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zUuMWNB3crLtfgGOnlFP/dcs9YeClLDzpr9/uScVSP0=;
 b=F9LULPoqyYVFhamaXSUqZBcmh0fyeysjSryQWaMYKvyaoQliGk4T0Vc/mnpQ5IhCH1sn
 1KEIsKr8QUmnYa5v9dAP4Kv1N1t1nAEipo9Zb5WxUKPvySGitkcRIxUgH+wPpMIB9WOS
 DC6duTEeKP+o79KbprA83haoF7eVnRJhvmc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kfm80a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Aug 2020 14:27:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 14:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ/RPmq3BLK3PESw0p0FPge0uBX7iI+f1QBc1GaJdcvWWTbt4ZPkgqrRAaCG9LjPDdFyfKy4lh5seVtyBFjdsrwDdIglkltAu25z1o/emH0bCg1V0/xQuQhI+l1tnmoEzukYq2OkzL1iQqlRptwVhjPs8XvU0RsRQA9+vfNLpXmqB34qk1nIhnZebcpuc9TR8f2X+dTIkKopMlLEF9aKbj6Bj1qFAEGaJRJR5OEZfbnlGhekkOp9d6usiQNsmTPleb8NpQ4TKbiTUaE9i/RdJuONGO1TfVHAi3MSWxYS30LdTGyxfbxY7JPFBYUlOpUyEf7FfAglJLDPyd6uaZUfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUuMWNB3crLtfgGOnlFP/dcs9YeClLDzpr9/uScVSP0=;
 b=TskoGj/0K/Pg/nfJhj8VSEqnF5BMfuo2XlevEi2SrQ71kfQVuzz7odGag15deyBVyM6kRGyuAVm72rqQhmjta6U9OIHAxSX6t1MyXdO6B5qHlmPls85Osu37VzByy5CuK+xbTH7JUUVHs26r9MoEnoJYDTkj3h8cBCWzKuZlJw6QrK/hsYg65Gsoo6/bsI8MOI+sizW3s69JN1N2KjsK4gZhoQeh7hSAcE3mTIw+K3sRRa+bkX3FxTGRrfC5CKogY9/CfL2isk8k5tePouVvheKVY77sU7jkVbLwsYhMud/Mp67rNu8DoPYv0yeW3gZnsjGMgo/iEp1aLn0udYunEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUuMWNB3crLtfgGOnlFP/dcs9YeClLDzpr9/uScVSP0=;
 b=SDDMAw1EE20CmuCKLsLzaSQyiK/35s9pRmJW0ahIbVGIb1mV5j0JpTaiv9F305pAT2MnyqJWv/QZqsmrUbnR8ycbZQ6qLNXe62Jphv6FlCu/PPFKXMIvFGbCS2FXCHq3Wat6W+ZJ46OlLw5ekSBpFoZqNrdgGy4KPzICQ/JXfII=
Authentication-Results: wand.net.nz; dkim=none (message not signed)
 header.d=none;wand.net.nz; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2949.namprd15.prod.outlook.com (2603:10b6:a03:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 21:27:12 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Thu, 13 Aug 2020
 21:27:12 +0000
Date:   Thu, 13 Aug 2020 14:27:07 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joe Stringer <joe@wand.net.nz>
CC:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>
Subject: Re: [PATCH bpf] doc: Add link to bpf helpers man page
Message-ID: <20200813212707.6ym5qbbv3tzhplcm@kafai-mbp.dhcp.thefacebook.com>
References: <20200813180807.2821735-1-joe@wand.net.nz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813180807.2821735-1-joe@wand.net.nz>
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:fd4e) by BYAPR08CA0049.namprd08.prod.outlook.com (2603:10b6:a03:117::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:27:12 +0000
X-Originating-IP: [2620:10d:c090:400::5:fd4e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad740a70-a24e-47c3-093b-08d83fcfa47e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR15MB29492EB5A77BD83B1C779CE9D5430@BYAPR15MB2949.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9LGyqoENOARNwkWioSVF+K/HlfKvIbbLAFm1LH+po3n5SBhkZFtzfhOrpeqIQYQfQince0JwZXsWw8QX2s0dfMA+2ndNuuzy5UKC3YXlmefCKX1EB3ezkCwhevBc/9St4qIfEfE2sj0GwkwICiOah+lEvMd5jNtPbg4fXSE8SXwNbwvq/MHLmb+oMiwxKVoaNDnlcbVAH0aEjAA87oS+yIHdlWEUJ8ecpPiPK3osu2qrYgpzwG5KW6XUMjdL07BdjznHY4Hg+N1RAAkAlW0qhr/SJM3OEtgw2iebOEtkzew1pUgXtfg9tCHC6YAafG/qxInDjIvYbkeudymb9yToA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(366004)(396003)(16526019)(86362001)(6506007)(1076003)(8676002)(66946007)(66556008)(66476007)(8936002)(7696005)(52116002)(6666004)(186003)(316002)(6916009)(558084003)(4326008)(5660300002)(55016002)(2906002)(478600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wevefXmtto4HfOuCW9GzDuNvrrmcfNp3V2yhQnwHt5ZNGIjPFNfSaCawR4E7rG4T+IuZKCxY6L3UNNDuEP98idkf7DnfyJv3f0dNFsXpX5IsaHVFtjLOVpZyUWRQz3mL+IsrCRCiDhVlkY0wFruDAybY+MzYoLFl2DZK6srBMcEdJzdqyc7leSgwvNekwK2eqIJhUixBzAvA294VvcjIzaMSLOyzMZpN+P2rVVEfvTKo+QqLKSaAxtxH0jB2IkoNbxSbglrZ1VrWfCUDjZprWXC3YGBFt0PO2hzp3AyXx56RKu/AWYUH6ye+DyPTfZRcaF8QiKJAoF8IDU3jIYrBxL/IZltF6zuxdVt5m4BDcZ0DyWSn2LsEmj8X2s3hGWI6sEAYnAQL8SQ2RImHSG84/P+dZ8pk7V/yaPGymLL18dg3BhO0yTv+EQ2123Zk2F7YRGg+NcAXvTm57DJpGZNIoR0km0+/0LSFO8jImEaxb9HW1ZDKJUy1T99MYGjsirXT/CvqU63FztZHIIaWsYue/kvRv00hxZZqIKBfzXTRuCownWTcRhk4poVZ+NPgr1SDTy8Bd2YGkFZ9MKZgcN2i3gd6VX0bcxxjD4o4sqkmq11zmErzVWJyqAoMgD5mkp528OM8YPKh7knw65io3eJ7w1aeqP8plaiW3gK5rpJUw5U=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad740a70-a24e-47c3-093b-08d83fcfa47e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:27:12.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh8w5T/VMe2aUURX/KthPsZnY8TPiQfvVKYCxPMl3cTVX+VghORthJ8k1MC4hgaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2949
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_17:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=913 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008130152
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 13, 2020 at 11:08:07AM -0700, Joe Stringer wrote:
> The bpf-helpers(7) man pages provide an invaluable description of the
> functions that an eBPF program can call at runtime. Link them here.
Acked-by: Martin KaFai Lau <kafai@fb.com>
