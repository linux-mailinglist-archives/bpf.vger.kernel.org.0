Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3D9320167
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 23:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSWhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 17:37:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229515AbhBSWhk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 17:37:40 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11JMQxOk018659;
        Fri, 19 Feb 2021 14:36:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Jmb6sLVERuMJ1JVB1Xnk/sdFIfg5ta+9aG1LRhjYBBA=;
 b=rRoh5yK1ZwwI8zKmX+Yq8W3ky5rMfd0Rq2KXM9GAE2Q3xZp9spo60XbBeHeAD7F+NKgC
 8ip79bn9FgCRBI46FJT/6lmJAYG4brDaz+EWVyFXbNG9Vhsm6hze4DStQjYic5cwo5ZN
 8gDkvWqggmGsUHq2Xg1fxq67FuSFLrG+TKM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36svm7g09k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Feb 2021 14:36:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Feb 2021 14:36:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMsNCNE3oQUzt7EhUCwo49cW//fMmJi6JNV0Ik6ZkVtJRdwLcbMhSPx3e3a+a3kXwmiruHsi7fh7rXpNBiOTUPaA2ZhdjXqAdYRHRFQRLSd8iLU+SIbhRLumu2Fu9W1j74ztbOt8UubycgBHDmM+8KebFDMxycskd0D3O4FzFhTkEUZcoTuLa4ofxlm6EYFPHsgqmbdMYW19EZf35J1an8Pm42NjkGKxgTglVm3PS/04mbAq7TjJgD5+mWC5/dlVO2A9xQi6luPvXI8GTph7lWfNlKQwrcmlDWcZ6oZg6LrtgNLYrxYLOPlPF/OkrQVANH+Fu3FMfUhIRelaIeUVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmb6sLVERuMJ1JVB1Xnk/sdFIfg5ta+9aG1LRhjYBBA=;
 b=cAelMi7QekuDA7jp/Y6DE+4Arz5UuQ4S7HdSJLcT7K7zV6nlByUYP+GnWPo+w6QbMojDywwlplG9CEY2fYPE8vz7g82bwCcWCrCTdPJ5vdy27JfCUOF29rktWzuiQD5QQhKVIEHAckW0RD24V0sqUV4M8lQpGXL8qwvG0CPv/Hm74qibdhzXljqsXFA656z74tcJ4wsh6duY2nBrhglY6izqiAbeexS1LDTIKmfBxK+6FLB6Cs6uz/Y9sFjdcRddz3ueQDKvff+h1mYGGWSU4zRQSOjxyMGnHhMwyw0gUciHxRJWgOoIYdHxnMdTWNEQRNkuaAXIx0gUDbhblMx76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3000.namprd15.prod.outlook.com (2603:10b6:a03:b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 19 Feb
 2021 22:36:43 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c585:b877:45fe:4e3f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c585:b877:45fe:4e3f%7]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 22:36:43 +0000
Date:   Fri, 19 Feb 2021 14:36:39 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     grantseltzer <grantseltzer@gmail.com>
CC:     <andrii@kernel.org>, <daniel@iogearbox.net>,
        <songliubraving@fb.com>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO_BTF check to bpftool feature
 command
Message-ID: <20210219223639.ml445wsp5otz5cqs@kafai-mbp.dhcp.thefacebook.com>
References: <20210219222135.62118-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210219222135.62118-1-grantseltzer@gmail.com>
X-Originating-IP: [2620:10d:c091:480::1:f41f]
X-ClientProxiedBy: MN2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:208:15e::15) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c091:480::1:f41f) by MN2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:208:15e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:36:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582d808b-53da-400e-58d7-08d8d526d527
X-MS-TrafficTypeDiagnostic: BYAPR15MB3000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB30009920541C9139533CC6E5D5849@BYAPR15MB3000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LXfTs2gRrhBo5HzuLW1DUsODGES6LGa2k1zT1jlTbx0ETdEVzdC/y5Woe/RlsWJ0enqVZ9EKHgYAHfjOFlK6yH6QgoLl2Vdfcgd8fADM06iPMMdzuUsJyGWuPpQ36XWaApvMb1ytWz7mlalqTCaKl6qStC3Xon0+Um2SopbPt8o1DWvgeQwHtGa243AIgaDuFarzYNAHZd0xPN2WRU0HX8n2CPWy6SXi6MDLONVCEOIh1JATsbOQBdjQ2sPxfOM3DlxCvAXGkPdF8ZzJaLlsr4hevM/mkpSVXdiAcDH+Orq/JyzGQgjWW3EPfaFUVd7vtS9vi+TZv5gKYXmvCA+AwxpSD8DvAfFybIm6N3t0fumOKZPzzjTcnuA8yjxH7Ol2IOHWTGqHLzMDMPMVLRtqBmpjg8GjDiKigoNlYChsHRkZ+r2syWZYD+3Gj51aqTfhj04pmxQmmD7LgUhzmQ/xFLF0AdMQA/7VgLMU54fbqiWGR3s1d9rNWZMANmqg8oIzV8jAZTCkTcK/tpKQOMOjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(478600001)(66476007)(6916009)(66556008)(52116002)(16526019)(316002)(66946007)(186003)(83380400001)(4744005)(1076003)(9686003)(55016002)(8936002)(86362001)(5660300002)(8676002)(4326008)(6506007)(7696005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jbni8t2ifurruid32bXGKBjsxJUvhL9UkYYO//q/ESYy7m1tVcXoYBoQnvDW?=
 =?us-ascii?Q?xYDWDsFCARRJxJulGeHA/lTGPSXZAjN23L5QXlyp4ji2mobD+5orMJeSt6FW?=
 =?us-ascii?Q?y3hKttjm8rUoxGqn5dGsQ30nzXRmPmsdFKX8SS2UzrgUniEMdF2s/8XyMVKf?=
 =?us-ascii?Q?H4HpxXox3vK3sJW5tCROT/wnh3TdptVksIcDf44/uTFS36FO/Gp2MrcXjJv8?=
 =?us-ascii?Q?FSFWWHe23LU4zCAmYkZ6MQ214S3hjygHgHN5sMNbblBnJJ4d4PfASpWLxj3K?=
 =?us-ascii?Q?cJHqWhzP2vDotY8obZwUD+j/jttOUsZ1ZpvoPdNofQTPd7ruD5nR1wsx+Rvy?=
 =?us-ascii?Q?LvxF4JuKsHyWW3e9gZetDyyW2jeFPYIx5weYSFLDPsgTW2rkB9noI+KGrj3i?=
 =?us-ascii?Q?hOl6EW3EsMRNxW7xZMG9lFbhZMmln80xBYr4Ui0hsp+ZHxmkWILyAsXH2IPp?=
 =?us-ascii?Q?LBxMXFF1ht9EBW0C66eIn/MwynGhWGd3cw8mZT8bMMwaqaeRoud3Kip6obVM?=
 =?us-ascii?Q?qS87DvoA917AHFYZyxP7r+J3cx1re5Vw+wQJ8KJqrpzqpw+pK7gYif2p5Pnb?=
 =?us-ascii?Q?kMCZLgnvJHUkyFHSFvHGjalBJBsvRCXpRjf4wDOFesdewZaiJ/YyzffhCq66?=
 =?us-ascii?Q?9odFs8mQm+di5XPaghTjAOLvT+eiRjeekqJUmLxbAib8Nlvyod+og78gwZeA?=
 =?us-ascii?Q?BbzyCernSfUY0ZgVDzozDkawqgbp4LMpmevFTlNnYnHeAibf6XU6jVRGIWkk?=
 =?us-ascii?Q?+NMEdCm21bvMqEkWMp6Q9Y5h7ChD/tb8NuMpTU7eVTg4fd96YT4g3feniFlY?=
 =?us-ascii?Q?HI6WwAKKV8kZS/Vf4KeVra+hIYCDzH60Ppv46W/VM80xAHVQGum3R9JMCp74?=
 =?us-ascii?Q?Ddl6QPYzKJ0BFHypVsDbt6QmmRMa738wTcp3E/hAli38ucAkiqA/0O6Xw/lw?=
 =?us-ascii?Q?M1GLXJRK2DhZCUFwPnwrlCx4T8ucF24E4rI8uelYB+FgcSuzkhxj2lywIcvn?=
 =?us-ascii?Q?nF2GKeBbV7+qpnuZVGyn7VwoCRto/r3AP8rXspi1x0neDuAx4XxQx8ACclV9?=
 =?us-ascii?Q?VgGtkegfR82Ehf2//E73OGjSM3Li2lQAOwgd3qm2ikX8h54EvSjyDRa+01mF?=
 =?us-ascii?Q?7g+fBNVtzYCctRS4VRkf+9lULdWX5KBpHiHItqxlr8I9j+Nx6SlQa4Y6nvyo?=
 =?us-ascii?Q?mkyeOgPb2w7wGDLF5CvQsP1RirLG6qmujEJ9qDJzU9tpmh9Bwivkbo1REbJH?=
 =?us-ascii?Q?kGvlvu33+/xPl+ablRRnALf15El+Zqwulew7MbaqxopnPq7dkkUc+n/6a3Sc?=
 =?us-ascii?Q?Mg9u8ZCYOCt9ZRq5AR+3BygSCUw36SvxBDRJ8wkw6r0GrKx9hchoIOvzxIGm?=
 =?us-ascii?Q?i43/CJQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 582d808b-53da-400e-58d7-08d8d526d527
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:36:43.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEdMkXKgAci/Qxu6AwNqjV4Kjys8EqMF/ZqGWIX7v98/a6Hm+42bICwwV1e69iHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3000
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1011 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102190181
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no description.  Please provide a commit message.

On Fri, Feb 19, 2021 at 10:21:35PM +0000, grantseltzer wrote:
> Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> ---
>  tools/bpf/bpftool/feature.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 359960a8f..34343e7fa 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char *define_prefix)
>  		{ "CONFIG_BPF_JIT", },
>  		/* Avoid compiling eBPF interpreter (use JIT only) */
>  		{ "CONFIG_BPF_JIT_ALWAYS_ON", },
> +		/* Enable using BTF debug information */
> +		{ "CONFIG_DEBUG_INFO_BTF", },
>  
>  		/* cgroups */
>  		{ "CONFIG_CGROUPS", },
> -- 
> 2.29.2
> 
