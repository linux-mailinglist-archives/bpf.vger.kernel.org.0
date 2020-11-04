Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE852A709C
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgKDWgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:36:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36398 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728952AbgKDWgK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 17:36:10 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A4MWLsj025810;
        Wed, 4 Nov 2020 14:35:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=JFP4A5x9me4R37bvSepYreE16c/X1Yb2KTsoWPqMBn4=;
 b=ZtMq8SWPg7pfmoXzUNaUpWNoaRcW+MlKH1kVP2zq11CiG+l0zonpZLrHNOL8V1jod/x9
 39/Wfj3GBn/ijmTB9cTSmRQ0fn8WISvdW6CGvRRAixapH84ei6c/JRPJbGJSK0nA9mZ1
 affDB5xgD0+4kDufdV7zXSTq6gA966Qhklo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34jthen288-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:35:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:35:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Q4R3OHscqVP/RdzmT8b0q9ZG9mVlOb7c5K60E9OUgJGbT6HUj1sKfDy/hqI2tdMJxTGZuyZ9A3/8Ojvm0iY700EwwNTAz0dwsrNrrOkS1bvzXb9EqPD3VKNhBx70E2I7txeV7zFe7VLKeqyTlEKAHCFOVTU+YysfiM8mwJuk4HXby9h/VEVUw+d5WG63BWZi/1iHyCDJ1rFFsrWTT6xJhdtRm5JUtsx+UgSoTYpOUJ1Opmj4/EYVWZh+Mw9Z8vVP6/5PcdOrb5WD1jl/wYHciQy+hoUIxmaAnSSBxP3joeUiu8oAqhX7ytWFRH6WWY5+LrYa4qTKdvlWwR5SiLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFP4A5x9me4R37bvSepYreE16c/X1Yb2KTsoWPqMBn4=;
 b=EdVh7ZWvdZeAQlE0OfzKyA1TS2AeWwwaJbWWzVF+M3gW0wB0xSrsrS1hDda/9WyL+XO3KZMZYZwRJKFvI9e04iBukhBvwWCgjUtTIuMC9pNJTMCVMyHyZ494JVhttmVqY99V9Yu02XzYRNaTubVe5DmrePASHd0YYBwh9wSO1ICyz8zaOhsclKCV7VWSCxuWjysb/po+Z2A2r8RwZua8qFdhK9ujJdfEtgNIM5p1eoOzFp+hj4p9IZbBmZRt0KS6HNq5wXm8bGveLrZYRqx4FWh+D8aUFmsxZakdIkb4nEz6SfafTaUBCsp4vh7dVkqkM7UUkYewcO9yecNRzFafKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFP4A5x9me4R37bvSepYreE16c/X1Yb2KTsoWPqMBn4=;
 b=XNog0l0G3cMvQeNkhJU6iv7ZqF2TtauHODCmD2bignnYnXCK1WmlOT1zWCyYoTA9DnB4kILqz91T7udgQ6LIgRCP+ZKigNYc25ZAQiQnnDFhVjQklHyvPsiRXW1TGlwBjh03kyxEjtuQAEnvwrl3ZAQMdfmBQQjncP9g6tG5vL4=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 22:35:46 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:35:46 +0000
Date:   Wed, 4 Nov 2020 14:35:39 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v3 5/9] bpf: Allow LSM programs to use bpf spin
 locks
Message-ID: <20201104223539.pwtwnx6penoqm37j@kafai-mbp.dhcp.thefacebook.com>
References: <20201104164453.74390-1-kpsingh@chromium.org>
 <20201104164453.74390-6-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104164453.74390-6-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MWHPR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:300:12b::15) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MWHPR14CA0029.namprd14.prod.outlook.com (2603:10b6:300:12b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 22:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 062a28a8-8b28-418a-233f-08d88111f898
X-MS-TrafficTypeDiagnostic: BYAPR15MB2327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2327600661A965462BA20945D5EF0@BYAPR15MB2327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUtCSXErxtx7yNi3nw61McigXlxLgZcgdc9lMHUHkbEspYHZHo2XIAx4f1MfKSWoTBtdyUYwAxQfIf6jv/Ne6TeVkXr5imhN/IlmJCfPBg6DnMzpVFcBsMm7FmpP0qsuNBl6i6MIeZT3UKldScgZxp7ChVN1OgGurOK4gnYdDato9Vr4iNFhMnVUBG8Mlbf8jmGZHooTfn5NXY1iOLFBPqE74cSXkNW3QFWAQhSFCwbnZmcrEEbeQ2Yfeon++9Fa8Cpp9vfyzFbtZMMQgtPAZF37IqUbjNxWbKRVjilYWKqwBRbtK3ygGIs1PSzqB1Jf69J48Q+eZrOx9MTC6ReBK1Bd2xqujjUk4f7iV8Hd7CLQIPArnbwD7WKkml5ngX7m5bzd6yHFVU5Cg57lnr49nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(83380400001)(8676002)(66556008)(66946007)(86362001)(8936002)(478600001)(16526019)(186003)(4326008)(66476007)(966005)(2906002)(6666004)(316002)(5660300002)(9686003)(55016002)(54906003)(6506007)(7696005)(52116002)(6916009)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: atUgtFgWk6MTKx96m50SQDGxruwkQpbzkhZiOysQ25QM6Swar6vAXbjY+lYcamBkw6soGUnG3k3HTjMbJOJ4Dzlif5LE31Hic3BWyx0bGgXohQ1OoRjCRgj6Xf4thlAvuNVM+2/sJmomuOzp4y3H4g3N/PgNS4s215xYMsgJOm7pnumw5JwiTs8HvyQd0uLwIZ93bzOefVN61IAwNzJWam61kWCvGVu48OsAU3VUMUoQ+HtsDh1BvEmGUygSpd2wvf96/A6R7vcW+iYdb7po8IiHfMPMq+gvUSFpdXAsXXDD6JHuFgLlwKv6yAuk7wMgPKGGEUefUD1kaZ56bNOUqmpofhOQZqfzzK0nP4Q5+qXKIY1v2hMDLEsssClUrWoPMIXqWC9tOMM0KMbrABtNJgA7K/dKHMhpggGhCYlgYJRAhINydXlc8p1CalbzVfCateS3mo6t/gl8yu9tuhInRr3A7ia/pVmLprMEQo4hQRZu6PTlhGuya1cdBuWcoGi/hXHa477968uXK1rN0BgGaZXp7LOEXCrq/GMCIFgBEkxAcioQlJkoOhkOlm1C9FGQ+CukphP4hgk4StRJnrURPbe9LFEpAniXwNXQubJQjf3oAmYeRp6UZHBYl/5ScH+5n2f9Knoq/2fNuGz7sJBnReS794HmhjIafUgvAk6loTzSfEXvG9IYAuhU1XHDFJAb
X-MS-Exchange-CrossTenant-Network-Message-Id: 062a28a8-8b28-418a-233f-08d88111f898
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:35:45.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq4pAenmi+EOJK64WdxvFhgyQuv/eHFBAmFr+CHTx/SLwGr9PDYwUy/xQ3QhhkUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 05:44:49PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Usage of spin locks was not allowed for tracing programs due to
> insufficient preemption checks. The verifier does not currently prevent
> LSM programs from using spin locks, but the helpers are not exposed
> via bpf_lsm_func_proto.
This could be the first patch but don't feel strongly about it.

> 
> Based on the discussion in [1], non-sleepable LSM programs should be
> able to use bpf_spin_{lock, unlock}.
> 
> Sleepable LSM programs can be preempted which means that allowng spin
> locks will need more work (disabling preemption and the verifier
> ensuring that no sleepable helpers are called when a spin lock is held).
> 
> [1]: https://lore.kernel.org/bpf/20201103153132.2717326-1-kpsingh@chromium.org/T/#md601a053229287659071600d3483523f752cd2fb
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  kernel/bpf/bpf_lsm.c  |  4 ++++
>  kernel/bpf/verifier.c | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 61f8cc52fd5b..93383df2140b 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -63,6 +63,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_task_storage_get_proto;
>  	case BPF_FUNC_task_storage_delete:
>  		return &bpf_task_storage_delete_proto;
> +	case BPF_FUNC_spin_lock:
> +		return &bpf_spin_lock_proto;
> +	case BPF_FUNC_spin_unlock:
> +		return &bpf_spin_unlock_proto;
>  	default:
>  		return tracing_prog_func_proto(func_id, prog);
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 314018e8fc12..7c6c246077cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9739,6 +9739,23 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> +	if (map_value_has_spin_lock(map)) {
> +		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
> +			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
> +			return -EINVAL;
> +		}
> +
> +		if (is_tracing_prog_type(prog_type)) {
> +			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> +			return -EINVAL;
> +		}
It is good to have a more specific verifier log.  However,
these are duplicated checks (a few lines above in the same function).
They should at least be removed.

> +
> +		if (prog->aux->sleepable) {
> +			verbose(env, "sleepable progs cannot use bpf_spin_lock yet\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	if ((bpf_prog_is_dev_bound(prog->aux) || bpf_map_is_dev_bound(map)) &&
>  	    !bpf_offload_prog_map_match(prog, map)) {
>  		verbose(env, "offload device mismatch between prog and map\n");
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
