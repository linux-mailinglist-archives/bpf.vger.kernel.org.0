Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CF2BBD8D
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 07:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgKUGyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Nov 2020 01:54:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19496 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgKUGyu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 21 Nov 2020 01:54:50 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AL6fDmG029707;
        Fri, 20 Nov 2020 22:54:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dngeAtw7EEVjr7/lAEudQRdeyAgcmJ+vS7c4kVgWxZw=;
 b=cdHlsssGNq0QMBP8NTpl09K0x5fyd4zs8ZugVD+nMrRSuzYSs3G8aphaf7D2cREMZo+o
 atGh/z3R2yfMOKMIX9wDWXciLDX3HZFqsOrzIfuT3LzQbib168PMo7aUVRRh5mFhPoBI
 +brHb6E98Y+N0sbKgz7JHh1ReuRaSVp/ais= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34xat45g1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Nov 2020 22:54:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 22:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFZ1J1ZZrSGJgWGRWcCHzxHnhRadkDJ2qMUhkwM2T4to0YYpxewYga1cp4KByzQ5e77Fg932ichyhmr1CkLTR8GWr4XaHG68L+x3d13+6ia1wxPDQhUXFIIjdV9MAUxUx3wAECTSDt2QU4zN/bYrTZCIk+JOn6IHalyEG9EXdytfKJjBOaXxoSBBjCjIqfHZ6a07RjWWAURt0toAmnLDzZ/rdPA4AmTSkb/90BwbGgibll6W+KdjWyVVbC5nGGfXJgp0EAsqAznoyzAjAH88c+XxNfHqPGdUlxu9QJihvyYUHrFPBgf9YZ8qlg+WCGWm1wKfE7g5U3W1n+C6jUBysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dngeAtw7EEVjr7/lAEudQRdeyAgcmJ+vS7c4kVgWxZw=;
 b=KkpH/nlnOWcVdWQDdirezCGZzvgGPaNagiZ/+gJYEU42NuNKI3iMp9++S/NxegdxLyn5ReyTR+KuE62wQhn8cxt3T1sIj4BJ9GCgytUqp+AxGQgwdEr/C452AGLoMX5oJdw8F6q+vVfBM7uLZkQdwPCuVquEtlBWMiZYgO95U5n1XcBMTJtz1tqnCrcP37RfoydHSERyuw0bi8ShIDa8+AIv3wrWsuQ4dcJy8PE32F6YFE9ignyL7vu6aLpAQwez/1iiG0JB1AiEdIKenWpDjTQ0DB5QYb7lxNTv7jG9mNegVS5WgrQpk51h9xSANwTQ+u9gYF+Z62rl+xTW0IyZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dngeAtw7EEVjr7/lAEudQRdeyAgcmJ+vS7c4kVgWxZw=;
 b=KzP99PDW56bR22OZqkHZRn8APd6il6wuKTIxwbRECzRyAcTta5TDGn+0NeYSRSYUpxNhGlk6qzbqK6L1Ga36YLWPD68Osgwazp8iuOXqU1eYFdrpmE+Oz6gY2nQ85SCW1cnVabWLCvMn3poQ1ECgB5GNtXTv8/hn66LSXZLWZV4=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Sat, 21 Nov
 2020 06:54:29 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%6]) with mapi id 15.20.3564.035; Sat, 21 Nov 2020
 06:54:29 +0000
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-2-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2904135e-9ba6-b945-f5b1-5617cc131c9c@fb.com>
Date:   Fri, 20 Nov 2020 22:54:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201121005054.3467947-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b539]
X-ClientProxiedBy: MWHPR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:300:ad::11) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1688] (2620:10d:c090:400::5:b539) by MWHPR15CA0025.namprd15.prod.outlook.com (2603:10b6:300:ad::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Sat, 21 Nov 2020 06:54:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0422e56-e3f2-49c7-2f8c-08d88dea4b35
X-MS-TrafficTypeDiagnostic: BYAPR15MB2696:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26966920683EB12822DDDCC3D3FE0@BYAPR15MB2696.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 482Cg61Ursr4TcGsCCK4NF5SviEKYjfdJZ8PA5JwWRy/SR3ZfSUS/uCBfcsE0djo15dCedAG280y9WcD7xZw+77vLUivc8WXMCDZS76dTB28B0S0IKjMJ0LfWta2/pqoe9uZSQQNJGD9J2ivb4+pPdetp4XgyQUxEkjw9/3inRXBdMxGNdTDYhSvtGPb6qSAhYubA09raSAixuRxohF10DQq/D6XGnoGaEXD0r4vLpwR5+5FmC2HDbweTVrSlttQJmRPPfiuYoNoCJcNzeczsWVf227rbW5MVnj4nRDEvi7pXpatbacBXsdCdqEbqCFJqlos2XQEFD3LakYOOmh4Y5nYNIHLp5tch7Vt87BwEelKlByABHfE2kGGATYN68Mm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(8676002)(5660300002)(6486002)(2906002)(52116002)(54906003)(83380400001)(31686004)(110136005)(36756003)(4744005)(316002)(31696002)(4326008)(66946007)(66476007)(66556008)(2616005)(478600001)(86362001)(8936002)(16526019)(186003)(53546011)(7416002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kRTqGWr0rSDUCZe8+sDnOldDqdIpnFPcgZau6MZk7YYBRuYmYTR5WCOhCJl3WyzqqpmGPorJi1riJQkjpXMR9j6Gt9/d3ObU6DhRN/Jfa94XjPcXVxaf2IBuloCSl5XSt1IiHy0Mz75Sgp1XvgTj97jh+lWdtnGlB1muHuABtH2km7FLlp9KMXRakvY6HTjbkjUn0TsURSUi7PaZFm261Zoxv881ZhoNHL1r14nBdy+7SVpz5b+2zDlQsczxHP7+liY8Fg1gJ38UalgsFaaoYGk1+yrN5rcf3GTdH07kWb+e6gQzuY6Iys9L3ycfH9Z7GdYhVOBMPM2K7pGkwLtTB+vBahVU7aSWx0dcuiEQg+LOceSBvG44QXwUJ8/wpM2Ee13gZBbhHW/JKgleXEkgphpkwEruAwEsd+hH+U93avxJfNBazOeGBDP4cFnUhDlftIlHjE/vnvadap0D2OfTEH5PbevbThwMMpMJ0dIRlSnNsUV0aV7ogxiiK0hmMXaL4o0TbO/IexJlcb4UxjlozVtNJnk7HKDB7k6e/SE3dQqWp94lAQSNzrSj0L3oe7TZz02v3DChxTW+EtiSP/zil0weONTafjvkzyGIC3nTIqB6rOsrY6h27eioGqXKOnaqAtawlPO496/JI2e7KCx3DovA2d0uB25Z1qssC5qMKp6SR1fIbPQIQgdXblwOQD8SyrlqSHZZ4QNjd/khcknPv6wmgYZESglEVZheKy1Z9YJuZ1wMNphlv/+ZrFomdHaffLHV1sxlcW8qsrqcItWr8ADPSCqlM30Vxe0G4TSTV80x9GHQZRo90zgxdLxdIRCzI+Hc0hgv7g4DdMSr1lrmFoaJpvuROfg/XzWTLoayUYNJn6OBPn/m15+in99Qauy1LnBQ3C03mMTt4P1f+dB6KWkndD0rQmH476IV+zVZjT4=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0422e56-e3f2-49c7-2f8c-08d88dea4b35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2020 06:54:29.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANGig8z/tDzEqHqhnaJfVpVUzwLP9Jt83ldenDZku1ZM+4kzkCVeL5w5zaa5fFzH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-21_03:2020-11-20,2020-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxlogscore=931 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/20 4:50 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Provide a wrapper function to get the IMA hash of an inode. This helper
> is useful in fingerprinting files (e.g executables on execution) and
> using these fingerprints in detections like an executable unlinking
> itself.
> 
> Since the ima_inode_hash can sleep, it's only allowed for sleepable
> LSM hooks.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
