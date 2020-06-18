Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B291FFB69
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 21:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFRTAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 15:00:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61680 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgFRTAd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 15:00:33 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IJ0942016571;
        Thu, 18 Jun 2020 12:00:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7LiugD+4mPDuecXnMDvgk4EZaq+hWUHfp4/gL2AG/d0=;
 b=VjVh/qETleUSV+7XdnZiZtCv8CCqtyb+SojI8lJHlSv51Eu1SNMerOQCy4Qt25F3jyvd
 p4JCZlfBYgo4PO6Bm608FhigDhDX1NRhXDoFXwKFTawR2hMK20fQeFC/Sp/aG08/PZGq
 BIWw7gw+ZEvPNF2JVdPRCJjtXfRQgDiW7g8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q656nr0f-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 12:00:19 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 12:00:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oln9aRqhVtl8KoDut+WKpUdOfbSpOsfXe3SwZXl9fUihLJkK/n5vtdLVbdPodsK5K4jtBngerPBbxi6QueNhdlftzVSPnueGtRMlNh1rJSsyLIvlIocNL8Lh6+R27VDosUIuCk1W0avzmBVYuuzqF02kngFSAcJHj06ZrFi84oPY+YXW8bAGWprBFAMaEyu4KAZKA8R7iCtaiXO5kUJKV3cFzPUXrFv5u497n7OZgfqStK0TxHwfWUsqvoUusnUFQf3A6JG3GHzzr2Z11b46l7mJ6fpD3Yc0+tRGaM1rgb+dzEsXdGU/7Sm8ETWJ4/zpL1Tf3FvzrwbWSpLA41xrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LiugD+4mPDuecXnMDvgk4EZaq+hWUHfp4/gL2AG/d0=;
 b=URTeRFCsw9tdUdOp4RSGAAq0U87ltSJ3rFtR+zqvZ0B2vUWnweVxMydqOJEOQwDiIIVO1p/I/IrQp35t6MQu8IOSV8RQ6OjeJnlTkj/g2d3fj2aMEu3m9+tE5dD/o3NDz/yYIp+DsbMtOZac3+fuNZN9+bvWu1ggxIun7gs8ZkwdxPTJmpgYPrS9UTvlLqTPbgB58egQJ1H3/UFdXb6bTsUYDOMNVcDyxnAH/yuer8B1WLJy2hhQ8eU58XdLDRIRDpXcdRe4dPK7RjYgUnFOvHl6dk1RML2ZgFVvAUp0cS0jYHraY1MCRidcqmfVvSninoi6cyKLBSfhoR7Cu9BLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LiugD+4mPDuecXnMDvgk4EZaq+hWUHfp4/gL2AG/d0=;
 b=ZqHqhJ9dxCbKBLXTXO9wqfk2bq6vZvvMX3+S9xhdTymcd6Sle31EamcMOIhkrpiv38feHUCES1BWVcML7RzBGcYlnAlrhxmhyUFGUf6bBpz7Weaby01waYPR4pF7AURUY8Hy69JHqLjAeisM7v0GdTMue00CEi/HbAtZlVmfAEM=
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2405.namprd15.prod.outlook.com (2603:10b6:a02:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 19:00:17 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 19:00:17 +0000
Date:   Thu, 18 Jun 2020 12:00:15 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 04/13] bpf: allow tracing programs to use
 bpf_jiffies64() helper
Message-ID: <20200618190015.62iioipchwn35l7n@kafai-mbp.dhcp.thefacebook.com>
References: <20200617211536.1854348-1-yhs@fb.com>
 <20200617211540.1855961-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617211540.1855961-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d71) by BYAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:a02:a8::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 19:00:16 +0000
X-Originating-IP: [2620:10d:c090:400::5:d71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b060e5-4168-4e0e-36bf-08d813b9d6f3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2405F65FBB1F99C360DBDBB6D59B0@BYAPR15MB2405.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGg/p8OwFLmab61Kk4LwYqsWWyRTuTf8DkqPePESQbZqK/hEd9Hec9+2JrXUIBo3/KDRierHqXSUd8jpXGzt0V1Osn192/q3HVq0eCHiYX0Fxeevoa6Zso7I16T+KlwBMidwg+LZo3KI5nPMSlbVNR1O6y5gmVQMtZ/CIaN6ZRD4TE6eUWbtQ9r/8/kKGduEaRvyIpt/GL34Grc8gvsOkXI39s/PcpGrO0weQwhLy7S4KTK1n8YDcNfJBy5Wqmbq5mYXFFQyPwg4tUvBmqZ0b+CitU+syjeyA8tBey3qa7mE7nMLZhIBmLxi7bHbv0+nSGDGzuqKH4XZIV5KZ23QoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(558084003)(1076003)(66556008)(2906002)(66476007)(66946007)(5660300002)(8676002)(8936002)(6862004)(478600001)(6506007)(186003)(16526019)(54906003)(316002)(6636002)(4326008)(52116002)(86362001)(55016002)(7696005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9/NDf/9eCd+2GkF+kdgFU/9VIHoq+DdwczYMWyEtTsHTH8upy/WWHIvGyI0H2N0p8ATRzabgXMIuvfSof8ZYgJBYsRlneaDhdERY9wErhOX21gLL+B+Ov9PLiXcp5Vl8dpPzPKxeoz2qOtmFid8U/1xM7KMJiVCwfS5mGbpC5bfCcOGjnSXWljM1FNtuFGnsy2lhkA7IS2gGo+X53wD0k+mVTLKdmCnonnef10tzT8k0jR0rHDMDpCdCn4MCr4BPaqU1940YgJJysCqYW605YDChouP8tjLvFbaTGpcEFoKNVBLwSx1itsduUhBrwQBM2mbryHHa6UJobbsfEZDljj2L5aX1swQ72LOvXqxhMlp5kVGD9yKOxVAJtL1AEKYaWvZBe1Wzld9y4oBChQEQMNqk1lF90k4beX9c4NW5NB8xqUPmSMVcXEsLAy/IXE4sTIdfNp2Gaz88O5oGWiciLQl9f2uOKIX1tcxP5Mud+QPx00VcZCj0kjsUmDXwdhBBPvzSb8DPIFTRFRZTSSvz2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b060e5-4168-4e0e-36bf-08d813b9d6f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:00:17.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Erw+Adiqedcx2/YDOPrAerebQ9KyHqI69taPTlwImUiojVH293fbZ5YLvivmdIH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=506 clxscore=1015 cotscore=-2147483648 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180144
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 02:15:40PM -0700, Yonghong Song wrote:
> /proc/net/tcp{4,6} uses jiffies for various computations.
> Let us add bpf_jiffies64() helper to tracing program
> so bpf_iter and other programs can use it.
Acked-by: Martin KaFai Lau <kafai@fb.com>
