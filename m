Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0356026372F
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgIIUQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 16:16:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19576 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgIIUQE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 16:16:04 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089KF9hB004859;
        Wed, 9 Sep 2020 13:15:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=icbuOzz/yGiAicXC6zxap80mivcWK10cN4zT2PrGoYA=;
 b=VtT10WLUPcG+BGizDFhK2WUuq5DzycpD/dl4S/Bff/rMOZv9IUDvsG5F1x4Oh25Jpwwa
 9ns6wdlzh2dVnwAmtTWsPi3139DeY0nnnoebWcTgrya87/z/iDwyiuMiGpEP8Ues+ocn
 QVzWDOyVuSF0BCxf1+8EXZ2/REuMcYyzod8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33c8dwm56e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 13:15:49 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 13:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4U9BPi21/04TroWlY+mBIAZFAAijOAnvBkHc2VbkgHYB6qDc07Y2Hfenrl0aJEbAd1ZnAqpBhSxwDwK07rMDotX3QNtJ4+uhTrbZUjasYxh8oMLXN906bqcqSPurSsVq3URKZDB32H3XLrRWXvFXSL63ZKiUHLOXapUZg10yqOKVptOlLz0UZ12+yCu4EJW9NA528kYCvj5UDMIO8ssPRogxGW+KtnjfmGavtbRP9CauzucIFoefpLDzNItLSsbzTbpRbim90Wav4MAbLfd+zi8XjYEmyVion1/P0EH3vHULz4Wm+/Icmsjiknw0oVf54639Fx77GicQOtNye4oyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icbuOzz/yGiAicXC6zxap80mivcWK10cN4zT2PrGoYA=;
 b=Jj0LiHBHB8RiRwgpq/J3PFU6kL+u4jdB++UtSxM3+PiFiWS1nHeh+eBWj/GsZ2VfNnT7tXcna+DfBh+a64YQj+Sf5LVbGAdFbqX89rzq7+kjGXZB6k2tS1FKo5bzrVboA07Hz2gbVD3oYlXESVWG64xsqDeP0u7vTOo3QwOHqyJcXz8ha+nKtbT8Pcn5u0qMF5UpPbN4tkpm0hCpcL7rIBBE3F+B+CGCH7ehO4e8eyCociL6CBjV2iC3v21nBQwxX+B/bJdCjzVJnUu5CZvIMN7+P75f4aY4jvJq4LArRIlMlLnS9bQ5WfRlw+p8zEybwK92qH1thCOGWA5HxRh3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icbuOzz/yGiAicXC6zxap80mivcWK10cN4zT2PrGoYA=;
 b=DLXVHgrjnyI6uAKX+82TkAbYmpaYjiRTYO8OwJ73VZLjnxi1dJDWu2l1XWEi0uC2jirrINOyCTUCDQu24b/9kKDE+cM2wMJoNekrL9ROtbIZFsGZvNEPdk98xQxAOttjkEpFyvbRkMfsBSCY/rBr2k46WS0gFRPvXfI6E1jDmgE=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2408.namprd15.prod.outlook.com (2603:10b6:a02:85::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 20:15:48 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 20:15:47 +0000
Date:   Wed, 9 Sep 2020 13:15:39 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 05/11] bpf: make BTF pointer type checking
 generic
Message-ID: <20200909201539.kzjr5cnlpqywu4df@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-6-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-6-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 20:15:46 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e251858-d288-4d2d-1ea2-08d854fd23a8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24081833E621B7ABF32AC5A1D5260@BYAPR15MB2408.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5wBJLNzGlTs6tvDSTRR8UFg65IfmKRNgTFNzEtd/gNsTmoC5ELLzNtt2RZH7uC73guGutZrh5LeNstcznP/E5OK4xNLB+yfuHNqTDOvXwMpPLv6NRKdQQFSqvsM9fonQlx7dTU5C2nwoRbXVEteX34uvnRSX3vECuRs25PXe/FP0fwecJs6HZdlKASOBXm4XeKGpNfS7vEfO0/kfvwuCHWrtcZ030PuatYvfEqMrVCJAZoyY9pAlX3zuiWs5orrIHKo1QTg9xMPPfVo3rKrcGyMH3dkLVqu8zVtdWgdswUS+zPWQSDMCD3V8PY9dgobztU+gwUqp4OjPhEG3Qxz7+kw/N9DbyQR+vAaT9sfsZuo9/c5Ob3hoqJuQHx6k8iC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(2906002)(4744005)(66476007)(66946007)(66556008)(8936002)(52116002)(7696005)(5660300002)(1076003)(6506007)(16526019)(316002)(86362001)(6666004)(186003)(4326008)(9686003)(55016002)(478600001)(6916009)(8676002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Fj73Spmwt2SMb95iMcR85lgvLEGMLhllOPzZKksQitCs2lrKCja2Z/LY9u6dSdfM4aeYLGWiHLsOwE0r61GSTI0DnMJxxRxcELTBJLMnF8MJ9pkzKqtWxXCnI7KACi4s1H433UUwEMdcoM3CcaqD75mTDc+DPk9W1UN2uj88+BY188ABBlppJ2TRDH9rBCF3ptArL5flI4JG1LA7lSkSeLr8xvcHpI1DsNv57JaNVS0JgxsO5fhW/Xi+tS4qaWBiwm8uvwMUeyyM19kaaZOw5QK6KfOJn6Joch6WGUzQvOMkbfYvC0k8Nei5F7n2dTwYTU68jMGPGYi8vBhONjmi4iCPpOJ1up72xFEcamDs1V3UlkBy0hvRWA04lyj/eRQ3BPuWPmFQyEfXvkPkR1Z1uCM9kr/Y/PCduFGc6HlcWMA7QOjTEpuo2L4WH6gBQR438bAoZFgekvRYUrQ28ZFY8Ee2CSfW63yTj7UIpEMrwZ3VIcYKL9Ej/sxsAgTDap8vMBG/h4mqqWGn79UjQVeianl5KDZiANCQIQfVYcnpp2Od+3dUeAIcF8HIsPgzuwHJg8/TBV/6tTDkRImaFdLT35fFNdQ8dXGliq5mzGQQdpP3RCnpgZjcYVqWke7yx6Pw+o7zt/KiOG4c2HEM81VcSH3LYQUB3Iq1/2M3+F1QFHk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e251858-d288-4d2d-1ea2-08d854fd23a8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:15:47.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wkg2N0BrnRd3a2I535My6lf1diHQNk7d/Y7wzTcbH2ADaXt52uPV0wVprMnI6ET0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2408
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_16:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=833
 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:49PM +0100, Lorenz Bauer wrote:
> Perform BTF type checks if the register we're working on contains a BTF
> pointer, rather than if the argument is for a BTF pointer. This is easier
> to understand, and allows removing the code from the arg_type checking
> section of the function.
Acked-by: Martin KaFai Lau <kafai@fb.com>
