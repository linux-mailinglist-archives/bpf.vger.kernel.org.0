Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854CE217C97
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 03:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGHBah (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jul 2020 21:30:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24208 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728061AbgGHBah (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Jul 2020 21:30:37 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0681Stw7020945;
        Tue, 7 Jul 2020 18:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oeZTIzL4Fj/gmjZd2vB2EzOo19SugG6F4unpu6lXWEc=;
 b=Df0Q/AIFrzkKaxNbs0Bkcy5lmTyvv+jl+KxFLHvnKr1jtYyFoU9dRejaex+pYA8h15eu
 sVs4SVTphzXKuWLe+UDDHjiqXKFnrvIQfzhVkV8bJIvydFTyWbUVQ+dJJmJz5A54MgRt
 Q3LcxStrv/1wnmfSJabLcBUIph8EuHy+5xs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 322qkgfeq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Jul 2020 18:30:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 7 Jul 2020 18:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/rhXZ/8XefYSKrzg52lotZPESRO6NQMA9mXWeB8qR1ZS/51e4BbLLwXbjIBVbR+maT0JtmVPvXbj40u1iwjfy1sB9zB7lNI6ATZ3wrfoqDGCvpMJ6cbBN1lYJBbxDKvDvFBOx7rk2Juu4n05QZXl88Wjn+6N3t+OKm8vP8UGNYO4syQ49BE1a4u7x6fFBkoJJ6DG5JVUpHlnH+Be1rprMf48LlJp1P3qMJoO4JYDPIqDSA2LroyAP/a6pnhDmgaJ96tEivvuPa3gDMAgkWxHfrwA9F8E6e2z8a6BibZlrIyJcFAay5Yk7Tv9RgLBLeHFZ/K6iOAnJOnlEFp5TJDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeZTIzL4Fj/gmjZd2vB2EzOo19SugG6F4unpu6lXWEc=;
 b=ikSIfHFhooKk23NCKnYxVIv4lJM3DVAm4z/3MJ+oHvNnqsfBUVGbsjkdEarLCuipXpokGSEj9mKu50tVKYMwVM3YyDE7/OTRl+B4mWJtSN85ycF1cQ9krt+uCKqR9djJPvOK9l0Bkd1DREka+0PJ9tUTecjKj1vz0FiNKfw6rMKWH+hieZvzcBRspcyD15gV9ZT+j8RhhhMLEZICkXEBtsZDKfecNjnwHsTKSIAI2Fcdse9+rHMY8VP8UQ1CphGSVl+OLRiMxO8qwKC6ZSNZfVk545DIbLfVYC/6nfMsSplY+hxFyeuwVFkUFjIpHGzulL+XzojEfZ+dp+fUkmQXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeZTIzL4Fj/gmjZd2vB2EzOo19SugG6F4unpu6lXWEc=;
 b=emTR1Icax4yu96IcUaj6z+9NNCZfCb5WKxdflqQAFx5xMLphyzxRIqsLg+S/0aAsRWztF9TIkWzGgUKLZrjXh1ks53i/Yu07OZ5ktVku+jKDLwdsxIu3SeLcWXTrL6/uzsfLIwhUYYc5K2goH46rgsMB95q5DCUJzEORXVNae0A=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2821.namprd15.prod.outlook.com (2603:10b6:a03:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 01:30:17 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 01:30:17 +0000
Date:   Tue, 7 Jul 2020 18:30:15 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <sdf@google.com>,
        <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
        <kernel-team@cloudflare.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 4/6] bpf: sockmap: require attach_bpf_fd when
 detaching a program
Message-ID: <20200708013015.hlsdmbafk2w2p7js@kafai-mbp>
References: <20200629095630.7933-1-lmb@cloudflare.com>
 <20200629095630.7933-5-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629095630.7933-5-lmb@cloudflare.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:df09) by BYAPR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:e0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.9 via Frontend Transport; Wed, 8 Jul 2020 01:30:16 +0000
X-Originating-IP: [2620:10d:c090:400::5:df09]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cda77f6-5d9d-46d6-d8aa-08d822de7850
X-MS-TrafficTypeDiagnostic: BYAPR15MB2821:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2821108E5AF30C550FA506A1D5670@BYAPR15MB2821.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBiFdf1f4Ld8HvuAzM/jIJi0ljGw0Zfzt8ODfoglk38VGQ6RZOTO/xJdw0dAvxeWx1JF1oS6tMAc387x+UqO3i1F0DAoxSF4fFMs35nXq5exFt2nQRqrVwiVqPcXqiUdVwFKpmSFIvRc9sw8Qi0BSSt/8oChZ4fsjs5sv84770e1t0tWZu1rJCzbioL6uSU60zf0u3NL4B2blXC8srnS2cl13lKA7Mvk2z7gfrZR+fuSqg+QOD+E9I5nQWwCHc1ZBFCzyqBhDbD9TfVvJV0LDoVWNlxlTkeoWueI5BA6kiQHD3LcwKzRtP7oapL6Nu5tbK7vOQ+8ZyENy5JTfBY8Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(6916009)(316002)(186003)(55016002)(4744005)(33716001)(66946007)(66556008)(66476007)(16526019)(5660300002)(8676002)(86362001)(9686003)(478600001)(8936002)(2906002)(83380400001)(6496006)(4326008)(1076003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: thK3nYwqVIBpFxZFnh8c3GTBGsEzdEm3kBDuVaJklzuvtig9rOFbHVWDB+Qvkl15/QEZPpZnPcj8GLtzLs1cZ362QOTg3BVtUIa8R/WTqstB/pUsMn2LSB6Dr1Or6ENxU05OY9Ez+4oc8fCwa5+rn1ZaEmWAbY8zpFbfiRR041s/6hABMKviNqnegAUqQZlkIQp1yzBwqBNbfnS1UnKYhCBe0ynPUPQ8meoUzthuHj4YtRW+lhoq/TuAycbq+RhIqxj9oeW2dc8q4lhIkkCau4WZEKObMaz1s0MSF71foekDuJVXRCqZ+yzyP5LeY6BAJXNJJ+fAaX24gEAd1aqRLt6ekjEwd13KCfwEyQw/KCU8ng46qGECW1q+/KnyuMmVrsnYJldKuIQdIvEhYfU7exSmrV1FDU8GFW2LufoxR7GS/Jm1yWCw5rFweX2tKGT2IqSftQoQ92KOjaxz4uWQ7YZZh89PdcN/D2qMUU4xVPdQQLh10X1hVy/E7RtvvIGBv48L61+zQnjf1/PsNt08ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cda77f6-5d9d-46d6-d8aa-08d822de7850
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 01:30:17.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDT3WD/ndISLIqIB8b5VaibyV7AXHr1Co2OClBH67XhZZ5akfDdvcOEtgvB4sBqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2821
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_15:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=733 impostorscore=0
 suspectscore=0 spamscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080007
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 10:56:28AM +0100, Lorenz Bauer wrote:
> The sockmap code currently ignores the value of attach_bpf_fd when
> detaching a program. This is contrary to the usual behaviour of
> checking that attach_bpf_fd represents the currently attached
> program.
> 
> Ensure that attach_bpf_fd is indeed the currently attached
> program. It turns out that all sockmap selftests already do this,
> which indicates that this is unlikely to cause breakage.
Please update the tools/testing/selftests/bpf/test_maps.c.
It is currently broken:

#> ./test_maps
Failed empty parser prog detach
