Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331001FFD18
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 23:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFRVEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 17:04:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58470 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgFRVEA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 17:04:00 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IL00KF012135;
        Thu, 18 Jun 2020 14:03:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=emnYEvRSl6XaxYuYwdQeYVL2qaPatQdH/O9Rbo5M7WQ=;
 b=KxQ/g0CeMrALqggBfezB0y4W3UQE3gQuS4yhoGdNO6W3QgvNESPn+K76q5AWpJs6AbWw
 Tc9Asp027tqQMuF/OMiM7gT42w9iOozo5044KXTbzmjSE311WsFme3TwTyl5dTvTZw5Y
 VTKGCDSUATpICayd1V3tEoMqGY3fRTKd5So= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q656pa09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 14:03:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 14:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikROfmgN80ayJGU/padL/zXTfDH4+cWxy68feP+ckvzHQRBTZ8ZJ9uVqCdZqF0zwtmTvOpSlZOBmI/zhxgE4xtF63Z64a3PKKnHtZPWQPbSZ/BNNGtPG4G/YMZGWCG44GhySgG8XsqV6TIeL/dtVUX0XI9pKZ6WnaY4FDuYU0axR+vPHunTEx2lMKAJG4vNEyreO6wNopYDT7DVr7VFmR5N0mT549QWfKpQXrxgj73846wxhVQc6KdK0uBArr0fdcbn6UcVmE8MuMK5N8bXkz4HgV5wSJeNR7PBadLH2GtBxZMG/i2e8U9Zq071GmfI0KJwSjgharkhZku6BF8Cx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emnYEvRSl6XaxYuYwdQeYVL2qaPatQdH/O9Rbo5M7WQ=;
 b=OoKV8lg+JDSyp7zv1SDcCgSelQlBUd11SrBvH+0vK7Gg54WG2RycOZ/eq/hmWDxTdN2dcbUw2neHnj3jwX10gbcpWStbjjQMW9ljWY63Ua3uLuqCCEH6NMB7IROSNwNp4hFAKp6Gqjud0CgQb23b39AqHcnpzigxzM/OGvOSRRRO7tvbcF1RINRF2HjGMTYUM/5Bf51caB92vNtn7RWKy8VnTNdIKihK+H1FB9a3nV5e5nE9xwvU9lSGjsCSfWSPN9zolU0R82KciKhSw5IX6efRDLglye5e23VmTMyh7724IDU/o7j7eOWpw59u1y0jxUB5FCHzqp/Lxh/CdUKAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emnYEvRSl6XaxYuYwdQeYVL2qaPatQdH/O9Rbo5M7WQ=;
 b=aSocb1sZbjnPMv6zKYTKFNltTRPvjljcsO3d54KM85iDqt9jjirxfE+sRqG9O94fR0TICrqgT0XKuF9fxu+vGBOfdIdX08ETV2u1CBV8kEbCTMhePnWo9bOtTgxJhXgBGh9MH5ilAEuYRsWKxFxUrsRSBPCHU9sKJv2KNnDDLW0=
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3192.namprd15.prod.outlook.com (2603:10b6:a03:10f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 21:03:43 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 21:03:43 +0000
Date:   Thu, 18 Jun 2020 14:03:40 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Support access to bpf map fields
Message-ID: <20200618210340.zg4mnrak2cniiuom@kafai-mbp.dhcp.thefacebook.com>
References: <cover.1592426215.git.rdna@fb.com>
 <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
 <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
 <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: DM5PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:3:ef::22) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d71) by DM5PR04CA0060.namprd04.prod.outlook.com (2603:10b6:3:ef::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Thu, 18 Jun 2020 21:03:42 +0000
X-Originating-IP: [2620:10d:c090:400::5:d71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97655d4-4430-4931-87fc-08d813cb1596
X-MS-TrafficTypeDiagnostic: BYAPR15MB3192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3192057FDB7E457C5EF46664D59B0@BYAPR15MB3192.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ge6i2WOBpToRhPy7ZZeO5SiZbrDnAaW9T8uqHmMuLMuqHJ5z6NFyiEd+y1zl9PAF0BFGv78j/jyBDKTuVioY7Iam1BFZ+noN2BDqGCdI724PNQ5Pp6mhkYwJv8h7eTeqXdRQPJUdat2QgirwueA6W7MQ8v5Z9Aa+E3MLaDXYTKK6R7hvb5m3w08sHa5A4IsYpVr93KUesbcGKNzDPv/dGwdf77z2KrCsDTUSQkRY6x8eoy5Mlf3x0D7A//hg0W7dPGQnp7YPKCOcYp/4Dfuhv9AMRB2kcpK9aitWS7IMaY9oIHz7jygA/ROJ79MOArtK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(8676002)(4326008)(2906002)(16526019)(186003)(1076003)(6862004)(55016002)(8936002)(66946007)(5660300002)(478600001)(9686003)(52116002)(7696005)(86362001)(316002)(66556008)(6506007)(66476007)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fFoKJRTtvMq6q3BwDfNvAwE1uwm+uhveilIwdkj5v85YoNwgJOU8q1jzDajiGP52BOs9J/Ch+6Op2dkhX/yWW4uqjaS9k+1AWeg9VGZbP+GOPv3yhhqyfF8DzwyQkg9ZtVLZFHhEnq4LJCVz7ZtnSGdw4TpU4vHCfWoAurbwOWfprs8DxmBiMYI0EQfrH5XPCZKsn5tL0PEhDVlvVu821Uuywtw+buQh3EWmI+fUB71IavxK680oef0RBOH6S72SVS+CEt4Vd9BZHVT73f1+XAN64+lguMuB/K5k5iA5TpqLDQsykMLM/a752qEow3NOpvFEnVlcM1WCst7o4yv0MCSJ8Wp8Pbu8ZEdeW5yw61QTewYFXsS1m+goEFZU98zq9SxGHflOINKKli5LxslZ0kaCzRtNmlkYhJ+xl11AV/xd63aLFx5B9u6j9RTsDgIZ/KxosKQEkMqwZIgu8g7fV/uIbeoWbKQwG878NCH/jVl+00hLJHaEuTAfIsf+jPWWSNLjL/uPp7r5kQBHr2OTKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a97655d4-4430-4931-87fc-08d813cb1596
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 21:03:43.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5hatGbT0bbZ/UgZuPNly4XxtX+PtEUh39FmGV0E02WhrsN5E8vd5rorzKCnOw9U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 cotscore=-2147483648 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180161
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 12:42:36PM -0700, Andrey Ignatov wrote:
> Martin KaFai Lau <kafai@fb.com> [Wed, 2020-06-17 23:18 -0700]:
> > On Wed, Jun 17, 2020 at 01:43:45PM -0700, Andrey Ignatov wrote:
> > [ ... ]
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index e5c5305e859c..fa21b1e766ae 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -3577,6 +3577,67 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
> > >  	return ctx_type;
> > >  }
> > >  
> > > +#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
> > > +#define BPF_LINK_TYPE(_id, _name)
> > > +static const struct bpf_map_ops * const btf_vmlinux_map_ops[] = {
> > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > +	[_id] = &_ops,
> > > +#include <linux/bpf_types.h>
> > > +#undef BPF_MAP_TYPE
> > > +};
> > > +static u32 btf_vmlinux_map_ids[] = {
> > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > +	[_id] = (u32)-1,
> > > +#include <linux/bpf_types.h>
> > > +#undef BPF_MAP_TYPE
> > > +};
> > > +#undef BPF_PROG_TYPE
> > > +#undef BPF_LINK_TYPE
> > > +
> > > +static int btf_vmlinux_map_ids_init(const struct btf *btf,
> > > +				    struct bpf_verifier_log *log)
> > > +{
> > > +	int base_btf_id, btf_id, i;
> > > +	const char *btf_name;
> > > +
> > > +	base_btf_id = btf_find_by_name_kind(btf, "bpf_map", BTF_KIND_STRUCT);
> > > +	if (base_btf_id < 0)
> > > +		return base_btf_id;
> > > +
> > > +	BUILD_BUG_ON(ARRAY_SIZE(btf_vmlinux_map_ops) !=
> > > +		     ARRAY_SIZE(btf_vmlinux_map_ids));
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
> > > +		if (!btf_vmlinux_map_ops[i])
> > > +			continue;
> > > +		btf_name = btf_vmlinux_map_ops[i]->map_btf_name;
> > > +		if (!btf_name) {
> > > +			btf_vmlinux_map_ids[i] = base_btf_id;
> > > +			continue;
> > > +		}
> > > +		btf_id = btf_find_by_name_kind(btf, btf_name, BTF_KIND_STRUCT);
> > > +		if (btf_id < 0)
> > > +			return btf_id;
> > > +		btf_vmlinux_map_ids[i] = btf_id;
> > Since map_btf_name is already in map_ops, how about storing map_btf_id in
> > map_ops also?
> > btf_id 0 is "void" which is as good as -1, so there is no need
> > to modify all map_ops to init map_btf_id to -1.
> 
> Yeah, btf_id == 0 being a valid id was the reason I used -1.
> 
> I realized that having a map type specific struct with btf_id == 0
> should be practically impossible, but is it guaranteed to always be
> "void" or it just happened so and can change in the future?
It is always "void" and cannot be changed in the future.
