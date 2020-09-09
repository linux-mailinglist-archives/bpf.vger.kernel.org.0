Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA3263599
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIISJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 14:09:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgIISJr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 14:09:47 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089I4ju4019975;
        Wed, 9 Sep 2020 11:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mgGglJbQAd3bz37I0JI/NltmQ7OwIF4JoVKATo8SUGc=;
 b=GqncOz4p2jAONGBj/7yIYCasXIa8gyeg09LQ2G+GAADX95kJe/VicvWb+WDJtU2MoYOj
 3ijJackzr0NbtyM2GtYACbA5x9OdZ47+H1HlbjgE6g2CWJgIu2RsZqeYpRwSUbFUmuJl
 xrIMuFzwVkuj3CftGu7wBXT3dLPq3/mktLY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33ctxn8qqk-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 11:09:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 11:09:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWyMvLMO0SKmwESC+CXD0vT1xXaMhbbSQuf1LSPNlsxFLrlxz4iYog0Db+S5Mpmd42MJqX/fv+K+lz9lA0qVnEvzFkydNjqodjid9/SVtS7X3TjsI/F9pFfM6UMZfCU9X3sOF3x5IuVpe2Lpxw/LHz0+t2S2xGFymUkqiCYzRoryX2H4l2N/wd9Szmb6xioQcvjU24nEQ+GXkqYMlHf9p6AOSRSy1E8H9zhyLcxuGK46eul3o2W5Sc0fNRtvy88KtANdb9olJnNhKlN9wrjWT1nL1MMij/ME/P6QyAO9DtzdtxiUSEOdtKFXzIkv30F0NZwfpkRDwlzlF8Xp0giP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgGglJbQAd3bz37I0JI/NltmQ7OwIF4JoVKATo8SUGc=;
 b=ehFPkhYXsKc5VSzlJazE38CV6rU58zrT25Rbj+7nYdgoZNBldtIyYgPPipV5gRJ5roicfagpc8DODaKmRHmQ+CwU6STuDc6vJfD4yTQ9EL5YiL1hvfqTG5eC718fvX6P7Y9G5Z5mHAnQfiDnt3FWrwK+Nfh99yrSG6+RJP/HIhz4IfchC7VGO5WGIl950ZqB4I3XQuwT4OhxMnDNdocDb2+IR5gFkV3hFw10GM1gseETsuXZDF325pjCQBStNijUgl2RLj80VEcAa6Fjp0aeEP/j4Y2Jb2BWI3v5Lvvbak2SehfugRHTFX7AyhS5JVJs8LrypqfGj1UYlkX8v18r4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgGglJbQAd3bz37I0JI/NltmQ7OwIF4JoVKATo8SUGc=;
 b=SFOa+xNhZnymdb/MC7mw2N4aM3FN7GTdp0hlGlpbL3n9ub8ekI0il9fOaE2qWesGnr0x99X7eMefG6vkZm6oFITxsF740mNd4IJqpYmteb0QkxBng4mMnX47TzmkAWEHZNvIBIzRP2OC6dyc3LQ08W742ZQxBAVRh8FCcjOuIZs=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2326.namprd15.prod.outlook.com (2603:10b6:a02:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:09:20 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 18:09:20 +0000
Date:   Wed, 9 Sep 2020 11:09:12 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 03/11] btf: Add BTF_ID_LIST_SINGLE macro
Message-ID: <20200909180912.5xnrrduocdjdz5dc@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-4-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-4-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR19CA0088.namprd19.prod.outlook.com
 (2603:10b6:320:1f::26) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:cc17) by MWHPR19CA0088.namprd19.prod.outlook.com (2603:10b6:320:1f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 18:09:18 +0000
X-Originating-IP: [2620:10d:c090:400::5:cc17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8790ca3-8cd0-4a4e-82f7-08d854eb78e6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB23266D8F6A04004463DCFFD1D5260@BYAPR15MB2326.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dEPgOOge75W2wB1mIZMqw8o1qd6bumKmMZuVC04HSqXzyOExO98vPxWf4fwQCs5sK7IJiflO/F0BfRV+PPoBp+U56aEoOhsMhmRb4+D+vw7/f834xs3ksQ4G/BScai7Jej2SPeQ4waGWseGcVlGghlPIBo+vrXJmO05+WfohwIARj/ecA93A/DQrN+dSVAzACbPp7K6L5evYFth3warcEJksK4fOVhHIG5+mi1jLsvvtDRjZuEiWnk5C+ub8kWm9BOWRKUrmpEZzuN/4e5qOkOVbwl/GrGHGBnpwHKtfUU9X/HI8Tyf12OVhjEc6LrIkAHQu0NxTwo0jgOSifTyyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(66946007)(6666004)(66476007)(55016002)(1076003)(4744005)(52116002)(5660300002)(66556008)(7696005)(8936002)(8676002)(6506007)(9686003)(316002)(16526019)(4326008)(6916009)(478600001)(186003)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TAL9kyrDtxA6fVZd+8OLBZ9TkRw+RHeb9MKC1FAJe+1YxZEfk7GS6hJd07QGaJkGOm6BbtKDiF+xrmVbS7b8Cg78UiL1ndDE0v712vyppUO2Qn3p/aSzLjbEaC5qJf/+wlp/BE7eZ07+nQ6aCwlEl9QnwRrSfROZJAyZkjK1mdsEDV2tf7B+gyEkfFMVzu6b5PafuN0jfWzqtcoU5oR3oFOa+xo7SPBJa39FnL65aCAJ82aKk+SKZQbRWabsKouqyo0naTTBKSe2pHdir9vwGlPPnR3M9c01MfaKy7i0ddBwxK056oGbBo/0aJD2BI+k9MvzxOS2wiapVNVWp0zP9hMev7UMFb+lxz6cFj1W6UywbguFAGQLv7jmux5X/7mDlvzdp6UpVLalhouma7bswPaPyP8/ekwNw/OVXAk4o4WJByIptWnsZr+awFw/YiO+UbL/hGK4Rc3fk+3iyRZ+8lmJX/VcWrSlFkOLGr7eFZm/bIlozs5fFxiZ84tDf+A2W46HZ/nchk5OWK0KaNI1TJwZEUyV0sJWH8NMpUKf5/qpcnDdRp6pP7Ll3hLMNAS4hglN5t5A0hoUrxq4F+pztYx1yzPTQGAEti1E270gShMWaArmZj7CvGBwGo/tipkxUtPU6NOSn9+tG8CgT8sOcCb4ZK2HCLLTvg3PMI2LHbU=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8790ca3-8cd0-4a4e-82f7-08d854eb78e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:09:20.0382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/9sQDIjbprMrSug0mw6xmcpJ6msXyzFf9onAGmUgW6zY08FTAfTmERkPARnPI5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2326
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_13:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=1 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090161
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:47PM +0100, Lorenz Bauer wrote:
> Add a convenience macro that allows defining a BTF ID list with
> a single item. This lets us cut down on repetitive macros.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Suggested-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  include/linux/btf_ids.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 210b086188a3..d6a959572175 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -76,6 +76,13 @@ extern u32 name[];
>  #define BTF_ID_LIST_GLOBAL(name)			\
>  __BTF_ID_LIST(name, globl)
>  
> +/* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
> + * a single entry.
> + */
> +#define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
> +	BTF_ID_LIST(name) \
> +	BTF_ID(prefix, typename)
> +
The same is needed for the "#else" part when CONFIG_DEBUG_INFO_BTF is
not enabled.
