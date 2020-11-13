Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D092B149C
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 04:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgKMDSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 22:18:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgKMDSp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 22:18:45 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD3DhNK029547;
        Thu, 12 Nov 2020 19:18:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wu4lFqRXnfeFCjWLOOpqglFKUMyIXcbVrKo46J958hY=;
 b=Ty5Mq3VKxnmwO5SW8P4zsbOXYiQPEPaDB4Tu2EydmjBVAtky/MRrQQ6MJYSZ7wX6ht4d
 Kc0ESdHMDIkSyn5XLQa/RXCNIcHXXweYxdHunt71SmhQGOvzvZbYiReFBALl1Z5J9i7G
 hL5sx0arCkY/d9UhCnUyAz7ienr6eG5eyPM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34s7geuu1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 19:18:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 19:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI1J2XPkIFOgppQWvlxQZHdXdlMz77CzCZredgiosS4ELqGThvUlDv3zgEnYKNZ72xSTKMKeGa3AXlfiiKOVVr8uJQHgTn3ifEdknrDvrCUrjatKndKp/T9gz8lRx92OtPMkhD+Z3r6Fj2s1OGESzk68yNbXwE+aUKagmKVt98Y9C/4I3AenBtzrdxl/Qaq3Z6NQgP4AFQy8C7uo8K67w/u1jbrvP9fX9KMzQ+1sZ8VL3pPocv1ZApud4ZzQVyXJlxnCw6y/STq4xyh0GyqLc5E/B9+MDi/5K+iuGkszdvfNyoY7XZ8zhnHJf3mTOtcZwV5Svs0VFWEgQohSmsHxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu4lFqRXnfeFCjWLOOpqglFKUMyIXcbVrKo46J958hY=;
 b=Ev9tQ+MlVkqcOsUlBiS7WVJ2C9DBizqf6mvj0C1aBbR0DnMrSOGXMPc3S5DikHxnqfMuCX+rd2xVVFCRV0vQMUizmuJZdcMZmmpRAUlRVQ8QrX5xafdP4DwBXq2fhPb2WIB3PWncx8XeZxscMmBPHEVr1gW2+IozbSQ8Q64hzjqgfArwQVpqTcHIO7neDiB+r0q+mzMx6Da6m3iwFzPJDFpfkBoX4jwlVYugC/clLlor8JZ6/8YNFiGWeFynuGL01OetmWCMxM11aUV860tevcYAbDJ1jOnf6i9I8L0bbQmE4oRvMULvTJPvH08su2QdPXfiq2RIVHWAMrO4EqONSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu4lFqRXnfeFCjWLOOpqglFKUMyIXcbVrKo46J958hY=;
 b=JiUaBD1b2CTSWPV8okpzrR3D8KNxaIoxUA159nzPPSGQCAMyjhT90siG0q76XTaHWA7ChUok/X6b+9B+umewrXIXGWxJZCI6TVpz/lUSwQhu7X8iWK5FclQ/KyzSQYzsatTj2zsA41tA92Z4jHIDfX5xlOriWc/g0W/A3MJyyzE=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2488.namprd15.prod.outlook.com (2603:10b6:a02:90::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 03:18:24 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 03:18:24 +0000
Subject: Re: [PATCH bpf-next 2/2] bpf: Expose bpf_d_path helper to sleepable
 LSM hooks
To:     KP Singh <kpsingh@chromium.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20201112171907.373433-1-kpsingh@chromium.org>
 <20201112171907.373433-2-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <63870297-fffe-f01e-9747-219b63c5d7f4@fb.com>
Date:   Thu, 12 Nov 2020 19:18:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <20201112171907.373433-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:303d]
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::11f6] (2620:10d:c090:400::5:303d) by MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 13 Nov 2020 03:18:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be310b22-a4a1-4a0f-b661-08d88782c7cc
X-MS-TrafficTypeDiagnostic: BYAPR15MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24888450B23B6908F88036EED3E60@BYAPR15MB2488.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8levkEkNwXOfjFCO6/tjVqxiN+2h4IaRQnhLcyLkBPUYqBxiSPBWv7wIllSNMWLeg7BxuofeApmrJASpwrWR/0CmRaNj/YACQyV+30690FcfimEXtUOLT2rPtDQtfXzpX8WVQZtwc4LShbXsXoEBpteNB01qIsMLerZSCdLU0WFqp3xHpm007EKcKLg3VuB4IV04a18dnIUa0uGmJLiB5R4lYZpnYNmLNrv0BUzkH2dGGM71ug7Zouh85S2VjOJziubmA8MV8IpJxXm/bgzJOot2qMdsNJk3bwixph/MWPLfQu3wAgKOTNILeMnmunJRgxo6NuI4DrY572CqBp1/ZUVRYGGs7MPFbMIKLL5BioMJqLUfSZdAZ6wXF7y+5Oa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(2906002)(53546011)(5660300002)(52116002)(66476007)(66556008)(8936002)(186003)(66946007)(16526019)(6486002)(4326008)(31686004)(2616005)(86362001)(4744005)(316002)(478600001)(54906003)(36756003)(31696002)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VWVUlYzVLa5JxgBMsB6sW/b7EFeOPUY5G46eH/semXiznR14upeCV7l8VZoMyjF0a1ejbccHBxbuQNm4MOLZ9qdM2HizMxrlHnlj1ceRg7vntteqHGSfhlJ9yhpDP2qcoKs10alGb4xLZ+4eT/SVkl74PgjsK+/LiPaZUuZ+9Gz4VlFPdJTrjrdjDKfSaBTk00xpVGUYKaSANX+aIdS3XJ5s2UeEA1DGGBilWHxhv8xyQSNmvztygZgOGH24cSCVOpiEOTKOrdYCAW4OV6Ma3MX0aV8cDMuCiRJslr42akBuI5DYHcqHbkNWvurF84y1vcV5akulnk6sZItXMpnWR89AtHCJVBs/7cbjKEsIpfcymnodv2ae3Qn4fWKwn12gCO1e2qopRqfLAHAZYMxDnkqOGbFNmNG0UMYC3Okck/qoBix6My6+r5Mrsgz+nvj7Oy1Ol9R/PLzpAbZGILm3E5sKpZ3Uj5xO5xgniINYustlCj1PwRIbnwEl961tr89YpnNkMST3jduyneZsgmC/hs+veWKv1uBt9PSeXa737mOO/4jdWKwzMIFUXmz+tAdQR+LLwCCiGAZaWxBG3iY6181jjKBG3e5EYeSRzEYNUHCJQDZ0xFttZwZOUGAlKaT7VSDVcIiPohKdnrFRTBYlb8Izwt/MHjDKhWgXJGJCoMIz2DmkRXYwelUJWpt72lRfwrXgIKG/Cl+x5Ha43FQjhiGpQvkFFzoTEOTwSmQ/ZPsvc+IUexXpOPGNSb5enb6TI0WFCm8eJgOtdt+E3O7jgzbYYBhOh4dfEqQOmBjcIAkddsECetNJD5aVC71HcGJoaPT/iq0eTyPCVeN/dqZxf8+sqHIa2btJ0C++Me+eL+qcBKIftl5+YYrix55lEW3nUIPA7z5+m0gVTIRTgzfAqcpX3xg9e+OwyOQ7CSA5Fig=
X-MS-Exchange-CrossTenant-Network-Message-Id: be310b22-a4a1-4a0f-b661-08d88782c7cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 03:18:24.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k18IbmEB6Xl9o0Upz9vjfPUkR8e+K9LPESeZOpscv/mpPBXSAAOjN7ir/nQBa89
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2488
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_02:2020-11-12,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=610 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1011
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/12/20 9:19 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Sleepable hooks are never called from an NMI/interrupt context, so it is
> safe to use the bpf_d_path helper in LSM programs attaching to these
> hooks.
> 
> The helper is not restricted to sleepable programs and merely uses the
> list of sleeable hooks as the initial subset of LSM hooks where it can

sleeable => sleepable

probably not need to resend if no other major changes. The maintainer
can just fix it up before merging.

> be used.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
