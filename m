Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB92B599B
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 07:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgKQGP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 01:15:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgKQGP2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Nov 2020 01:15:28 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH69TDJ005664;
        Mon, 16 Nov 2020 22:15:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MsfmEl6SGvYGo7NbuUchWr2H2wzfJhOWEVEcaNiC1Ng=;
 b=Lrg8V6K0qSZ6qUVBbqJBlm/krpnmSUI8fkw5KU/YRezakIlwD3CyrYnQqwAorOr2jAHn
 tnfb8sY7natGrPevlAcx/N25ZE3CtuQtLTFmWA5STjZAdhYmVPtbu48xJWnO5/B3tu0j
 ila/KIAZxi5mMizbopn3quO+t9Qt9sFoLfk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34tyxqsanu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Nov 2020 22:15:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 22:15:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K22pbAmcvcXl6O7UIaHg3nUFW48yF7qBXYizECuv8doPvPhKuVqG7b6UIyb3wfVMdTI/BG2tRxyRMyNZK6wY6djp5ylf6gevvPJ/ePS6SWHDlTCgL8iJrIjQXexhDKpPNHEiZxnVg7XHjPI/Wkwo0VIcOK5VqR4320TYaDZl74kLX9Pu377lbKsRi1W34zRwOzD8aNiJ4yPhGrRiqiCXsn1ne5Ri/7UesF/8JQVP3om5XLCIyAKnY0Qi65PXfjawwQOaQrhg8/7v6NyHwr2QpoxSydKxSZBxv26YCaWuEl4bJZ6zIxbzq3yCyLJwPoeqa6JsIo6o5Z2jxr63TVyQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsfmEl6SGvYGo7NbuUchWr2H2wzfJhOWEVEcaNiC1Ng=;
 b=EdVXAYt15tvp70mcJ3xOLMN3ewvnqZuOLc/q6Q10/FSODEKqeCzUFO+V0nalDZ2n09CtHW0PBpiE/2ecOVwm8Z949vcxSKBnulXL4kztEQy5GqeajdtWzEHgjMSJG6dH98EYCO5MolVTV35AuwD9Bnoa+v4uOq9uCxeDGMGI7oPwsTMt01P7ziNaBJivoB50tFmmv7ZxJXB3uaogcTwYWRDU4Mli0koxJ7HdORrQjMbJEjkov1slLVW5X3vpgJzGmn9+R7oUNLKDcMBZCMdGI7lifBzGQMTzcG2BItIoRKfH7YiLLdai4KyeEK2d+QqdX+UeEVEXSOKNuSU/NN7Kwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsfmEl6SGvYGo7NbuUchWr2H2wzfJhOWEVEcaNiC1Ng=;
 b=NnLhgRatD3H22uLVM5dKJuj3jKWpRP8wRSzdafHOnIqLKxfFbPJNYJkouCdQNV/RUyvexcM1P3a3RDk1Y9nnNkFcQgUMeEzhrbnhDG/GM3urk01GhmHSiXAiFzZgzMvC0/iQnp845sda/01SzHgUfJTBYI3fPWbD8yBxkoXvRMY=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2728.namprd15.prod.outlook.com (2603:10b6:a03:14c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.26; Tue, 17 Nov
 2020 06:14:53 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 06:14:53 +0000
Date:   Mon, 16 Nov 2020 22:14:46 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
Message-ID: <20201117061446.pbszrrezas4wn2kf@kafai-mbp.dhcp.thefacebook.com>
References: <20201117021307.1846300-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117021307.1846300-1-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:8f7f]
X-ClientProxiedBy: CO2PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:104:7::18) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:8f7f) by CO2PR04CA0116.namprd04.prod.outlook.com (2603:10b6:104:7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 06:14:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1497ccd-4ca6-4b76-a94b-08d88ac01912
X-MS-TrafficTypeDiagnostic: BYAPR15MB2728:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2728AD589488FBAE5F375E45D5E20@BYAPR15MB2728.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNIzO4w3OuX/jZUenFqAa9ebci0Y7PyGxxfSK6kPOxljuf210l7GbGSOXVdGgYv31TXZD7lqcJfG/Enxp59C8ZwsUVjQnJP2tbvVCABoTuXvP1DJbIL2z8bUsGDzh4Y6JeW2RIwx14XokPN+CXBXa3wZFwE+aJYW5z58Es9DQ7glVJSkc45tQVnInVGPYnc7Xng/8sUTvn25Cy3+VMRXeHpUbEaTN9VvSnJrHYPyd5YnLf7+qNjpkQjV983Is8+AITfDVN08akMe19cx7hiEwLEBDCME3LV9UTgFNZUgXdbF7+ES4Ua9M85POH2IIpl1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(4326008)(186003)(7696005)(66556008)(52116002)(66476007)(6666004)(6506007)(83380400001)(8676002)(16526019)(55016002)(8936002)(2906002)(9686003)(478600001)(86362001)(1076003)(54906003)(6916009)(66946007)(316002)(5660300002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /DlIoZzkTFpAkcExMz86JaXES+UHKOuF4kxNEbIcRkqqGI9w8/j/RLs8f4scNAJ51ngrswr5fKam2rWciFYCK5wP53619ZXASkhBY8YepmvGE0VflqMu3b0zwt4jp5axT1z5TTL3f5vcSjDh9rq7dIi4PCddPUfjLD3MXfgvU7wIQL41+ve24J+BsDhm/Ntbbs6K8E0WyrkL/YBMB8zH4Itq5uUMfhNSgi705H3ocD1nVhKVTb3Wpj95c5nHD7j7AUv++wD0Stbwvt1jea6wRBZyE+ob06m4TJHoJRwcrXKYqH150pYJMfH5RF0GTIh5CG1apyA7mlnZELitlSOrbO0TuVhRVUudYq5vOeW8y+A/Xw8bJjh2dGY87muF72uiuWsSYg+RJH62ilEUET09C8PhEJJgjP8F2eWWzPdS4uQNAHyyxwnx+pQ5Ja9XIal2d2Et5e+kmzJIrn2EjOBuwFJuMctFtp4aUaXS/aST0mG7WVpUmVG9Kmi7jEpaAmVQyhC+qerLxVQn795PVJeZa1AfWIww4GhDZXN0wihM2+udHVAKqafOc45nfPL+6/XNz8bkTLzHqbuGMR7GWI4xqBUz6bwU8hLzdMp8xNBsCc7/7r1+6eoEdqTvrkmALsCeqv+u1EtOsVIxqVpGn0eUz4Q8Rd1MJQIw2PkRfyxxIk8fYyIHY4xj+tRGbm6SSKSmalkAh3rWvdo7Kz5oQ7V+iG27ElsBcLn6DxO1BY8kSGK5bQpDns3kB4NWcH2GXNeVBH0J8qHj3lkN2BjZFRoc3h4dubm+EUBPOdG/IgPiawbYXVSCK/Cp7+UlGednjwR9JbrgH9ONqnglvYFDyNYRlefW+mQnV4xExKQygyxbaVcEetvS9iO3jgDhFgAQyW+wMJlsaTZ8W9Ro5K2mE6Sr2g+05PmSjxOrRIVOtH953Qw=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1497ccd-4ca6-4b76-a94b-08d88ac01912
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 06:14:53.5890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrYsTo9AzK525hMdOYzaShf7uwfbU6uVJK9ARK8bHXeMDMVZuTgDD4455lBQzXmZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_01:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=1
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=944
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 17, 2020 at 02:13:06AM +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The helper allows modification of certain bits on the linux_binprm
> struct starting with the secureexec bit which can be updated using the
> BPF_LSM_F_BPRM_SECUREEXEC flag.
> 
> secureexec can be set by the LSM for privilege gaining executions to set
> the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
> use of certain environment variables (like LD_PRELOAD).
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
