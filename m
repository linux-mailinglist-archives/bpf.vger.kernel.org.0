Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19F2A88D3
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 22:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEVSx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 16:18:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22164 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgKEVSx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 16:18:53 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A5LIWfn021607;
        Thu, 5 Nov 2020 13:18:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XUxKuBKN7tgr7zn0HOvFBagE38idUXpo4OWiIJxSXSw=;
 b=LaxO0C+/ZIaxeYl/Xa78SEG2RtEFYDN3FLx4yoH4Xish8MrsA9gRotUDD2DU0dgmOKNr
 DoNSVfCVyrRXUQI8hXv6r6U4b4TbseyWiWJ3mRs5mSAJouwwQ0D+kt9CXkEmjnnch6/y
 fXfHFyxPdsgTxXbNxCcXfOEcMHWH4Zg7owU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34mek33wey-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 13:18:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 13:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te8FeaBqUY9xPk9YFn4nlRfwrnqawJQKvvMKkAF7UlDOvfl22kWNI2rAV83LAEk+hjBoU0TWI+FAnHx+iAyIw5s2lyBoyljQtWFU946bDQ57xYzLSccVdTpTBG6eLdLxijc5L0yy4GBllBRgtV84F+dCrz6Cq0qFvKLhafg6OhxwCmyhC11P5aZQ9hdupuXt62DzQrvkFEe/XCy9/KdrVskodqBYAsusoSLbPCNPXv+Qnz1IqYLHIK+JXT3ceW1HCo5hxpHwxZwn3kpRPu47w2MiWRMR75giyqitGipzMDb6uHSykk3Tz/JNBfE1OFva96KCax+8ihJQL8C17HPz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUxKuBKN7tgr7zn0HOvFBagE38idUXpo4OWiIJxSXSw=;
 b=XlPvqNL687nVW1P97zf08+av54n5wgThDs1ttordiHNivaX6/pc0tSAqxKjQoyOJDQiTozIyiJIWZD78jn21DIZdWlbmV10ka54u2LFo9QJNhFzwlAg25mef4uFJEvnQrcg/xWEoigepIHmhnrpjoB+iPEdC8d4y79CTIt35hgpHimcAVbOhdrq7PPa2C8MqRi3U6te+b99d8N9XqgF28p1I2dAUW//szR6w/G+aZanWaxTsdJklMz7pEDXLEEIrsZJszniWlJ/tZhwgnJe872QTenPm2QWVt9xdw2KeA3LVebHZINDEZ9wjYLF/X38tc5Jt88P8AaASOccZfi7QaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUxKuBKN7tgr7zn0HOvFBagE38idUXpo4OWiIJxSXSw=;
 b=WO8Cn85QvMU00P+Is9gpSRypsz0+niSbWzkm26hubGcvLdWvN5Dzx3DZNuy+j/Z9COYdjRJTD1/0bc9bFNjIN4d/LGbVhzCGIkxXKuS3KyZOhfQMMDzomiwSo5HZyNeixxAqPt+7knOcA2Q+G/Jh81Lgpm5DNews8/cjOFoRgB8=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2454.namprd15.prod.outlook.com (2603:10b6:a02:89::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 21:18:24 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 21:18:24 +0000
Date:   Thu, 5 Nov 2020 13:18:14 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v4 4/9] bpftool: Add support for task local
 storage
Message-ID: <20201105211800.pvs63wiiakxq7csy@kafai-mbp.dhcp.thefacebook.com>
References: <20201105144755.214341-1-kpsingh@chromium.org>
 <20201105144755.214341-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105144755.214341-5-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MW2PR2101CA0035.namprd21.prod.outlook.com
 (2603:10b6:302:1::48) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MW2PR2101CA0035.namprd21.prod.outlook.com (2603:10b6:302:1::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend Transport; Thu, 5 Nov 2020 21:18:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a155f20c-59d4-4e6d-2ed9-08d881d05447
X-MS-TrafficTypeDiagnostic: BYAPR15MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2454E81B52FCAE7A57D71388D5EE0@BYAPR15MB2454.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nO2tIeZb98GfLVKjdsYsYppqdUoArf94xF9l9pKKQyYGgPy7nSjc1ZRx5KpW/lPFewNetPAoQFTSeVD3RA1n6bVesQ0P6KrSj7D4kqLetJ0NE2pJPT232K4xYP8ip1ZwOLcjwuAlySTdvQd4ABGslU5Rh+waYYbh13m4d9ZzSW46N9f2ao1Vkox8ozndpN8Qw0PVQXQkSlnRtYdm9tMXE/hyF7OK3RAWsvVnuN+moQc+3nlZuWH3q5YxnhmFK0St2a3UOJUd/TPOmaGKFuTCrJaSIRLce9rfKusFvdQP/+72HC/J0wopy3FtVkYYDDdFSBWEwznmLrK74GVOrxA5oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(66946007)(4326008)(7696005)(66476007)(52116002)(55016002)(5660300002)(66556008)(2906002)(16526019)(9686003)(186003)(86362001)(478600001)(6916009)(54906003)(8676002)(316002)(6506007)(1076003)(6666004)(4744005)(8936002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mFhxjTyKZMPIUE5vvLH/jwvaaO15tyhgiz+aX0l20LiWHSKoxqrgJ7q4TBoSetMmvvCAcvQKbuaqHEdYMYokkDBbbBSR2AmvgHsgMiUC7v9fagiTUSQp3t9S86rt+l7PGLV1nSKe4EWRSodcNrhWVIBaJirnSi3B/POQe67i1THTWDOY3CVkVQLcITXIuTrisB2NsdioqCjKjSyaswscwy1oZyfIgqdvCDCDgsxLQwuSJGRCvZgi3qVPXbPJYhzgZ4Jz4hwRAAfJwV/Nrm6e0cIVjMgl0EILP+EiZeALUP8/lHvrEn1oCfWpviq9Zity1dLCv1Ra2S4VWeDNrd5ycDXRIeUb4dm91Q00Brks3GjpEqKzUjv63sILY4/T42UWNXaJjVzJ1OZVk89WDXyya52r1y1DPbNRHm0tQ3DONMlS2oQmbWVrFm23wUB4LPmkAbkeB4/hoD42jM4C31yQTUdgd2iRpCjneIVKjw90xfDE6DtejtkOTgKIay3sarSNwxhmmGEjRihr9JN1/Brrr2fCWrwHeW7wISQ2+rlRBXhg2uw5OSCS5Nr4P3yAPixe9WBbTPyy+HYXLproToELFY7eNecvOq2raPAHgy0KV17TUsJeJ8GOnvnTTIrykS8sEH0uKhzUeYMa/0uQuylO1TyBCOE/c+IpUVquXeMI2qHLIDq9PTTk1XuNUDUS0GIn
X-MS-Exchange-CrossTenant-Network-Message-Id: a155f20c-59d4-4e6d-2ed9-08d881d05447
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 21:18:24.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVT+JG/SG0IP0jYKOgC027vDapmObg3N3HuhBWWqylmzwyRDsbspHYHI1UGBGoMG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2454
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_15:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 mlxlogscore=814
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 03:47:50PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Updates the binary to handle the BPF_MAP_TYPE_TASK_STORAGE as
> "task_storage" for printing and parsing. Also updates the documentation
> and bash completion
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
