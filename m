Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5FF247B4E
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 01:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHQX5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 19:57:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgHQX5a (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Aug 2020 19:57:30 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HNrFaG026384;
        Mon, 17 Aug 2020 16:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=JyPoqiu5TW4AKyL1F9dsJ0JJZbWJwO7roH6bBGbLS8o=;
 b=jXdx16xmLRY69l7xmDI9HuH34zYSNcaliPyoct17MD043HDjdV9Xe8w2bdpZrpyCMCB4
 m+ymNb8acLhNhhPZY2lMoynSKyeQywxHdOy570nzJ2r38LgzAVmRv/FIy877+c7B/dAf
 hlFa2FDqou4PzvuUydk2bM9ARdMUUcQEd6E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32xyhk86yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 16:57:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 16:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv4haipfr13M7GT8bfoxEyq327T7NYQC/zGQqN1agaYDM2gG71mLm2nMhOUFV+smp5SHZBUZ0Ra+TD31vDVXxuS4HXE0DopXC+qQMwSYxLwZnhGLBZyeufSk8lPgxnQ9EwoOeJLnf6qFInsd+YOOmBvCqFiFYPx6cW8DdK6kNoR/v1MaySfr6YTXtwlFHuX5qIKJ1l5O2YGb7OQRZd0ukmPamoAhPOglAvColxcMlx9FHXafS+0ivp068YSizUD1HobaSCM0XknGtz1RdPCMNZyQb23EAa82cg+Kdu/FNz0tcscx62YrckqS0+3Ck7GLmKaNu8TRPhRlqq8PFvTRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyPoqiu5TW4AKyL1F9dsJ0JJZbWJwO7roH6bBGbLS8o=;
 b=hH24hQ8tFlchxV18J7wXZiyQWcaTb2v2wXdEKQKFNmd0QsTpL/ZdGQzYch2QB1YvFgBFDzQGyJKed9CzOVCv3DS9TKPkE68nB3zDd7XkwfJwN0FRRGrUyJpczxxqc7i+ItXUwp63BIIvc27ErtHpf93NMKc6o0+w41Qo7anXYW1L/QVdK74Ghm6Iadbqi6Filz5RQVI4HKBRFWqv5xojRh8X558l5oQsETHw6VKAzM0NasB0xNcgu5//iblYDVejY5hc6axncszgtsCqJICdScoVGgoaGKDakXkaT/HcKYc54wqyrSe1w+cv/3ElIDRLCMjQ/Lr+dUiRKaSuBGmngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyPoqiu5TW4AKyL1F9dsJ0JJZbWJwO7roH6bBGbLS8o=;
 b=ekJ6BguDLss6FMi1UMroP1MYD9NyrHv60GeksSp/hiEWKnqxPUCZZ0O6ABbJEz42nl8jj9RfekLLf3Ed2y2JaTgZweVcLtNWAL10voVYxVvEzC3A3aXCiFMMeCQuYLJxymuyVpY2yDh+plDALo+VQf8dR0Q9zvyc/STB07hb82Q=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Mon, 17 Aug
 2020 23:57:11 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Mon, 17 Aug 2020
 23:57:11 +0000
Date:   Mon, 17 Aug 2020 16:57:06 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v8 2/7] bpf: Generalize caching for sk_storage.
Message-ID: <20200817235706.2mstnzvbodreebs6@kafai-mbp.dhcp.thefacebook.com>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803164655.1924498-3-kpsingh@chromium.org>
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:4b70) by BY5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:180::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16 via Frontend Transport; Mon, 17 Aug 2020 23:57:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:4b70]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a185b16-1476-4d8d-82ec-08d8430941e6
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3413C7471A06ACBCBBBF4A46D55F0@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEv/iIU7RcJuNimpu6SL/578ANGvu9z2SHco1Oo3IjL++SuJ8S64ZpJF0h1r8R9StQgsA4rhVDxbhqzhZTJ9PoUfj2mn1LorjHhfGBqwGw9RGUT84d1kbPKrBH73UPb36GbEt8WShreAtI3DrsPyLEJGYLLjoPX4GgTDF2VRG9kcaG3C9TbyRKGfMIfMw9jPUdW06vMGRzlD8Nu7yqcdLNiUysvh0G6xDN7StsEb7a2Kw1r2s7KnbcE9SNbuL7aHzw9BBGJtrusknL9jKXNRiL8DM8eLcgiJwHRFUDbKino/5USRRFO1Bxa/ULQ3bLkh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(52116002)(316002)(2906002)(66476007)(5660300002)(4744005)(66946007)(7696005)(1076003)(66556008)(6666004)(8676002)(54906003)(4326008)(86362001)(478600001)(55016002)(186003)(8936002)(9686003)(16526019)(6506007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8WAPPWB33amNJB2jzfqrxK4KTsdajcj4cVq1kJXfhNVIUzcm3R3bcvp4UiSwPRmllAc70todK9lYZm8xzpD6Hx9c1qra57pXCg+ZHjMYgbnVvnRIsC23/amvKbrO0Am3iXIMr6junBpDuL48pNLgs0r/bb+AK04T3dPpk59szSN/6TO9hq4MyECK1tGIHucsHNjr91J7cCpIIPCuBWrGAuiJaoVklB/r9X9qqmccZ4JkENhZty7YIuYiVdD9MqWssnuIKyBnSnz8xgwG1bnoCPz1FkJ0tdEjm59bQbio8b6lvIe/re+fKoK0a4RD0FfDSiSzyobj6wLAmp1ljlnn//BDBQvxl54L+ato+WLkxZRIJokKvKHAq1w3WoQAf8Et8gB+aYmyhD3NWAflyj7L4+vmhwVIQtVOxDEyMSuTPcjeKyAuZIaIaddeVfPRm8SwqYIV7tcL3eT66EnuBzIpqQkFFTJ7RtevQSlNaDOtt6QZn/Vn4xe1NQy8gH5QXT8C0BpU2k6nqp4LwBrTp7lMrF1xXBISYDJEggdNikiQ7Dx3xlmbJAvRvl7OVnQ+fbPxYNr+26oBKpGYaZ05Uay+OsDamUTMS6bbqtxe/M7szxJ4J3nVyx9EAFWAsvw6xAbarlmxstCF3U68MhXnvs0nOGD0786erUIAluQQG88JdBg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a185b16-1476-4d8d-82ec-08d8430941e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 23:57:11.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uetn0OZNFRusMP/YP1xS8l8Ehpo58wSI7YuhqyupzMG0zrf7+ycIDDah/zf9Zq7F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 mlxlogscore=716 spamscore=0 phishscore=0 bulkscore=0 suspectscore=1
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170161
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 03, 2020 at 06:46:50PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Provide the a ability to define local storage caches on a per-object
> type basis. The caches and caching indices for different objects should
> not be inter-mixed as suggested in:
Acked-by: Martin KaFai Lau <kafai@fb.com>
