Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24A1FFB5A
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgFRS4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 14:56:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41746 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728210AbgFRS4J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 14:56:09 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IItnrP013089;
        Thu, 18 Jun 2020 11:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wh/naKERPFadU6H49Z6Yez6c5H6FtN8ozQM0L2w1oyQ=;
 b=drskCtH/S7zCO21YN25i0Wy4p9YperB74Qm6+al/pEIyK3RV8JXiVUlU5rLarLzYMKhW
 HwdQCQ80aIA4787XLKPee819bqyklBUQb4Zaiy8B4qmkuS9+s+Xd7ocAbc5Sj+ltRoCU
 Bw6zhoSkxbAr6RBU1nOqX9SuU8xctT4wk30= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653ns10-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 11:55:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 11:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJIjcOfQ8UKJrUJ82wJjj50bCueDSvLu55c/X39jbco6wPxo8qKehAiDtfnPbUNOQ4A51oF4F4AkwQBZsqBOHGalsszpWvk+4Efhi5uJxom+AOciIwcobDFIHED3gdvPgMRzNog1Bp80t0tFDPCNJh8Pfqj9M70xbb9U1FEWBpILRUuiQaND+MlSccatmmjT0JTkEJvbUECqi6YMYtlsEz5zx4P4O0UwfYfJ6f5DufRmXbSK559c3bCI25POeuA2MXosLsFq8kWIkWGOm7r/JA/dhdanPARrGG3Rqc+M24UzUd7jdsK9zh7diJAeeodSduQv/2S2Q2hQIpQP28EclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh/naKERPFadU6H49Z6Yez6c5H6FtN8ozQM0L2w1oyQ=;
 b=dtADkBk0K+gYeaXiFK7VlnkF/tTKHgtW6u0zZqCy/11CHQ7Qp3OzkmvL1qaShrd8LAqEyeEhsAV9wOwizYf1gU45zoZfH5uHH7/C65fPnHqct2B94IAp2xcaqSLXM+qYAKyJydqyyv0tfkj2yCXVmfdmwMUnjWhB6Ndp7JtzRxyR8P3SmrQLlKRUOg1luNLgVOL2qyJGOahCT3sGsaHeFKzq3KmG4KXM2YDMVT0a30GkfenuR8WyV0lyptHcqG2OuPfsl1OODenm/Cca/YHK/BYUxIzlY/VLsl738NgjP/lBJxEVTcCuXTJbdz8rFtP2DBUMRetqJScB61l2yDvJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh/naKERPFadU6H49Z6Yez6c5H6FtN8ozQM0L2w1oyQ=;
 b=eXOaE0yZUCnFTH1LyVF57DruA5BaSB0f3Hyfg5Py6sKoNZzzns1I+clccucOI02y8yRe2EAaEXmfJiXxzsBJrFsdyNL4ys1QOSBNoVd2/OOfriTmVPDoZhRRa9xsCqvMRH/TcM1y3ltI6o2Xk0Br0NnFOnbcSC/nTqMP16sSzGA=
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2405.namprd15.prod.outlook.com (2603:10b6:a02:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 18:55:50 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:55:50 +0000
Date:   Thu, 18 Jun 2020 11:55:49 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: support 'X' in bpf_seq_printf()
 helper
Message-ID: <20200618185549.hwngyqa74exvq7dg@kafai-mbp.dhcp.thefacebook.com>
References: <20200617211536.1854348-1-yhs@fb.com>
 <20200617211539.1855882-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617211539.1855882-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d71) by BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 18:55:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:d71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6a9b91a-210a-40ae-47c5-08d813b937ca
X-MS-TrafficTypeDiagnostic: BYAPR15MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2405FC574B2117642A67A6A3D59B0@BYAPR15MB2405.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xh0RrY+pT/sgFUyB6tzhFE1E1IuogDq75Xxh238BxK5YRrB3QoqM+G3qcfd+OvM77Jzcxa7HahXKcRfChSQvVs6cN3nC8GwfRVz0knP4HDdH2bvhl7PX0XzbAWVCggayrg1WqWRWl/c/7D7A1PxLWDO9aJv75rkX4waICI9znhs39qFQWbEMXIMucAQCM24i1K/S+aO4tVVpiwgwbIRbK4gblGixHsUZmbYtVyXD2iahsLvgityPhoqwOC3CodvY4S/QhyWCqgXFqNakRZ94Nc80kTrQKT1aAmPykEEqkMJax3DKbwfMQb0cfd4+w42K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(6506007)(478600001)(186003)(16526019)(8676002)(6862004)(8936002)(52116002)(7696005)(86362001)(55016002)(9686003)(6636002)(4326008)(54906003)(316002)(2906002)(66556008)(1076003)(558084003)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 73mLXFs3cCeg6rPOIl1zdzM4QhBoKad2uMXw9hCkOkIpSinIcusdPxU4njK+YJ6S18CdHHO5Bt1u/mv1YFWzXH17Bi3FjviZwDcM8nWs7GdDN1VBcYghaKDENkTbosPVqOIdWml+w9SeUG6+x4DvCfOMBh23EgHKphEZXyMXxVZSmQaeqwoZTkXDOGJDlhy7QVPRpmS8cbDl2rDw8ETKV0VPOUACTBAHU87We6TJ6aIhSmWGzc9wgiXcNLnIXTSAwp73GXpPGURfrQdkw5Ud6Hocj93kM+QvgYhrqnQzk8Dk/kqg4g9rp76+WJcF18wdR/z608caBWiditmaY583O5wFDmXbMYScWgYZDeB2gwBoTw938/JpnBgWf9GsD0GioQn0+/lKHD3X7g8HButoOGKKMUHLmUWjn6pEnJiwrHC02J7EkTglzwc80fIWkkAv3RqDH8LXmtih1VaLL/00XOwjkrJfFsFuS11H0hmCoWrSDkAFPq6RZjcnu39INfbwtMk8Og7Ubqy5zhPKlELdKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a9b91a-210a-40ae-47c5-08d813b937ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:55:50.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHdnXuYMsbg+TXL9Wb26w4h3HdGrO+ZwHovQvI0ktFSEXq8s0AmZ+hFN10ZUAqgo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=874 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 02:15:39PM -0700, Yonghong Song wrote:
> 'X' tells kernel to print hex with upper case letters.
> /proc/net/tcp{4,6} seq_file show() used this, and
> supports it in bpf_seq_printf() helper too.
Acked-by: Martin KaFai Lau <kafai@fb.com>
