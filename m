Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED72637A0
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 22:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIIUnR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 16:43:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgIIUnQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 16:43:16 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089KfvoO026803;
        Wed, 9 Sep 2020 13:43:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=K5uCWxfgrcAvbCH0I+G2vNObsNff58dlWyYsdgrVUyo=;
 b=Oec3MIA1kzrMyhlD6h9KR5eSJxXAJkWVzABRB8Xz3iDdeBZpLBROfTbCyijukw2uBBDV
 O7uTV/wjBFdNNk1wnN5RutVZfUrU+XGwnm/A37G18UzHYL7tOJclgB6eJqMMuF2vaswI
 U9pton/kY2Dxvf+pnCIJX9N1C38D9pmwCf0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33ct69sj2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 13:43:02 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 13:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9efaa/sNlxRMMNroaI0WhkLlrXOtmduOCL9YGAhYLkVkyzukj7OzrqmQ8VqVPpTLM+fj5V+FwG00MuTbDgIAClfM9hK2xXXWua2U7kYosPnjHDpvmvBs3yW4bpvristiMpDWvlC6UKHoR/WXKyXNPDlMzBDRRS6KoTGjbc+c2BOg6tVUiMU8dcPftvj64V+k25sOcqWHkIMTnIOmPOYazMrW0U0Fzq0t+4V9CZvk9Wit9J2XaFweLZY7A+sNpiiZLkZuLnwGFPdouIh0g8ob09ITHzF8y5Kj0L85/E6Kme6Xw3jUheYJVwhY9DJkAIeKhMlRtpeO9pF2Udebl8WZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5uCWxfgrcAvbCH0I+G2vNObsNff58dlWyYsdgrVUyo=;
 b=BY0DYAUcZAEy93VJl1/pcjtXOoVX/wD1Jns043LicR1NEU7r5E03cjOjpNAnrE/6xT2bYcAdNdAQs1Rku97eltS2MzsNgbKWwOlR6FdLIxGr3lgGNF4e/lvgrLejItDHjcVplCAJZ5I2rtwdgWXzMR/k8DKM57/IHKvvXo9jNyawpVF6055bBsiftMqN0v7d22XGzzpdAazK4wAR/0fQLRXG6DoEIohHxbusYkXX32IjvZb4iMPLKXjrH0/lYeY378RIbYOEu0o7vo9LYIehXL+YB6Hwl0EmuJlBY5yYxGKIPXHfL+IlkEoNDlMT9N/K2c2Bimk+69ziPWQeH8S/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5uCWxfgrcAvbCH0I+G2vNObsNff58dlWyYsdgrVUyo=;
 b=Bolnig0cBpsfNeEPudoFIToG93mNNiw0mExKqcbNxOHPC2T83RVI1rVPAGhXnWQQsS6BxzzU5RuF9rsyk2Vb8qidgmuFcJ2qOgTozr2a6/6jrKBi+BUfmb3oz8/3AYA/7Kq6qF3lMvfqW4rJM3W20RImh9TYyvb/NBHzgIeC6Vc=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2407.namprd15.prod.outlook.com (2603:10b6:a02:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 20:43:00 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 20:43:00 +0000
Date:   Wed, 9 Sep 2020 13:42:52 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 07/11] bpf: make context access check generic
Message-ID: <20200909204252.7aepntaii2hwap7e@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-8-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-8-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR17CA0091.namprd17.prod.outlook.com
 (2603:10b6:300:c2::29) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR17CA0091.namprd17.prod.outlook.com (2603:10b6:300:c2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 20:42:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844da6cb-6908-42f5-1510-08d85500f0a3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24073B621F54C35AF215732CD5260@BYAPR15MB2407.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wO2bxh3ZMHEZJjza+iY0W1kgv0zsfFan5egz7mHc2lhGRvGNGqubW8UnlqYa6ZZLXqutEpwwZMYOnKN52p5hn+RvgkdAGq7+/LQZi1xVIwfFW0NbN9Cy8bKw7Pit77bpC5wvHkr/BdJNQ7Fq7v+nSH9uufuVbIQM3df3KpNStgH5zsWLQHlcUS/ehlvqrCZMWIHhn1fjM3vy/l4jONtAo6mHXVVX/ouQUq9gJ5TmS0aAtWYc+QG+2VfdomFE2oVIir8djMpO03dYas/sg6DSNh/gwg/cUtFsuGUTT9sT21szmlOv8RLy+5J4FpHGXJutcRzYiSsv4aJWjaPSHucBWm3lsPB4aGI/BmMgdUIrSod2ch1Pj1M1TW2+PeAszKAr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(2906002)(83380400001)(52116002)(7696005)(316002)(16526019)(6916009)(6506007)(66556008)(478600001)(66946007)(186003)(8676002)(66476007)(55016002)(9686003)(8936002)(4326008)(86362001)(5660300002)(558084003)(6666004)(1076003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Al2lnjNIeb+xxEJBTe/0OtYdi7RIQvkrSeX9aAsgzE99xNPsP82VVWlxUBGUFLJsJKxfCR+JZTLURqtGNH4TzAk3xHyUnbVN41asDL3xlf/r2BVrs99/ZLdklxRwKIkvIkRuva4o+2XRl+bbBsQXmXv1HVOdHUf2bWhjlFA4jOO2h4MocjM1Iv5Og4VYbvBAFq1PEcmfVwNzDsDuZTL9C5rIQSdrAiTRWlFy+SmtG81yDCxl1YTMCrkSdTivCulDrKvGAZjR8FkG+azqrDKETxk40kfF4P0La8ii4tl4Hx20ew2SQRiY8lQw9yUnhl+n9M62Ks9AbgBch6nrELmX/rZDTrOusohya0NGGU7Nld79y81TyTvM/qh0t80+vaYaTZA9wvx1rnTLIZ0wOLx3mBZ7G4869Nw57LmtbDTkpxt97e+fZGMrgwX8nYhbg6J78BV7B/ymIv++i8lqjlv9LPENJOYDAyyvZHfijdxCZ6VNP+BUwpLqWoBFdrikYcI1CLk06Ed4FATcgjMiDt9OYbEgCl1YMOgSHPV/2tFy51igWIdTagCdqp9fRN5Jw47nalos6LsT7nq/rzd2k3sBj6kmdZSw1huTRH3R3Y7wan3jyk55P/ZvIzuMdfqlU4c+tVY2565SvDvYyMeXHTtnG1UFJuDzI0bWFiOboV+lDJs=
X-MS-Exchange-CrossTenant-Network-Message-Id: 844da6cb-6908-42f5-1510-08d85500f0a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:43:00.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Atnx5hk1iR2FyNQcJLZsWQ3T4n2WGZbXhqadS911djiX1yKfZcWuF8DbdLwi04Xy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_16:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=850 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090185
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:51PM +0100, Lorenz Bauer wrote:
> Always check context access if the register we're operating on is
> PTR_TO_CTX, rather than relying on ARG_PTR_TO_CTX. This allows
> simplifying the arg_type checking section of the function.
Acked-by: Martin KaFai Lau <kafai@fb.com>
