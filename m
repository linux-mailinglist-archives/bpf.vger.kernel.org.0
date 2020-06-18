Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062F41FFEEC
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 01:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFRXvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 19:51:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgFRXvn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 19:51:43 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05INldDc012947;
        Thu, 18 Jun 2020 16:51:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CRlopSCUNdslakC9iF70wWLnn/qh50GBFZbTK+m5V9c=;
 b=NH+tyQabRG6qYbh89fMQMdn/0BX4tlDB8o3mMUbJP8zYwo0JBd6HPQq3RLxWoabMlMgd
 xo2L9vwwxQeWeYP2z7SRkR9u0QiaB7pTDNQkpogCn9e/Cg2UDV58V6D5rFdH7oDwSAs9
 rZzgXG1exvBe7KOgi8aDBfmJZMRaUclZyMM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31q644y0tf-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 16:51:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 16:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7reeoKVDOBpx4aSdT/eMmQUqmC+Npz/cPMoZHnbXyhdFib/benRX+gDJ83z1gOfKUA0dbXNFZ8V7/wY7fvv5/YOsrNdsOG1ObDVJJ+AoltHNY1ozXzhkE1Gng/bcZjcU+WqNR/Jw70CHWTZCf2kgif9Li/pEeCyIbcsjfPCipvyGYDC3OCMDSqwCRrceV//2vNF1PWBz1BVY88WVo7x6mEhA5BZJdTqlpw4ZiJ0U23FYbTwnLCCVIDjjJlhxsj2SQ4wQuZ4xKWT4fKYBpcs1fIixvLnyIKQme25eaZfY8HfOb2TiQCjw5TAJsZPGyswozSBOowJdzdIgfBG8zlYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRlopSCUNdslakC9iF70wWLnn/qh50GBFZbTK+m5V9c=;
 b=BfKlcHmlpkJKGtHQXMgTmh7G8JtxH1vnWBGMVa23uCofSTwgjb15qcRWDyPd/givqbB2uU3odo0GHxREbJMIb2IxhUeTX2lPQzPqMOMV72vz3L8uBZ/U3CSYK3awsX/1TFph++bLLKD4TXfojlSqNwyhF0aYKxtD0eR9XfyBnlmiiGdIp1/VuwMv0EeLfopsKF3Xri4IkHKHrgzsj4PV5xu8HiJJVMadsw6Hkk8a7KAVJf3wPvbsYEXMCA+w58gBr3odH9ivMCrYZNju2bj3ImaXjuHes9rV1Ui7++FlxoyTuxaacXOSZmaJq+27+36SJ0WD2wl9RVvy+N4kT8j7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRlopSCUNdslakC9iF70wWLnn/qh50GBFZbTK+m5V9c=;
 b=Ly8KCEmkDMBP7ALQkoJ92vWmY0+gCFrxsoYq5BGELlGNLTfmAILCQxGknUY7C4oCvQIZ7c7tOcLYHva4v680EkenOAZh3gS4sMirUPxtDcpAKCpzO53+/IEA276hnXpnoqZw9DM3Q4nKK4d/83/69I36yhOM5Q7agwGWRQdKBV0=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB3190.namprd15.prod.outlook.com (2603:10b6:a03:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 23:51:24 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806%7]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 23:51:24 +0000
Date:   Thu, 18 Jun 2020 16:51:22 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Support access to bpf map fields
Message-ID: <20200618235122.GB47103@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1592426215.git.rdna@fb.com>
 <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
 <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
 <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:142a) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12 via Frontend Transport; Thu, 18 Jun 2020 23:51:24 +0000
X-Originating-IP: [2620:10d:c090:400::5:142a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 254dd05d-3407-4956-b98f-08d813e28232
X-MS-TrafficTypeDiagnostic: BYAPR15MB3190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB31900A7FFE03E17941EE3997A89B0@BYAPR15MB3190.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngODUYm65VGuw8OxcWYAb4scl9UroH1G5JfacBjpugNYWhavv9Uqp7mPPox/3FWWkGn8aqxRRBG4Fs6IPPLMciAumu9jmSLLvnBvZVLdl9ex40a8/PLoYFUMpMKTZP2l3fNJTHzHZmSZOfvbjqasjTQFZfAv+2T9nu4xYMa+EGmuKIZGKGQeW++YFIGRab2iSy8uv566iLmzGYANwS0Nb1RdklSnOiZOH+KPhwD2vVy9684NZmXcJLw+ihyaiX0R8ZnQnKnviIjN4jDNg0Z7mWDS/5CL0K1HLc1G7A2AAntkpGrNKJ0pTVvUHTRop3go
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(136003)(376002)(39860400002)(66476007)(66556008)(66946007)(478600001)(9686003)(316002)(1076003)(6486002)(4326008)(6636002)(86362001)(186003)(5660300002)(8936002)(2906002)(6496006)(6862004)(16526019)(8676002)(52116002)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bczd52irTYbLCiFj2zLWwJD9I1fZsAIofFmWYzvP97xbpSDSEo3p8Jqm8jw614wnECu/ozPxBbhYiX4McTTo8zPg/3O/5Gs3LfFzMDdtsD558mlnbfQjhoWrdEbUNXElQAdx1DAQmgaiwjLcnXcnREZFhWd6R7oaProbxMPzLoSXKK4XQcFsrRIvluETMauV8rujuot/iGssSSAnai7NpPSrUi9OfHw/FoWVbddcAYFwaXsqC32LLORiyDcnHLTmb0S/cXDSuKUcV3UchpRe35ibML/2vQwWaOuKL1kDfADTW9xGIWAW/cLsO3Ep00IkAjTlSetDoXClFOgqA9Jh8d1kbw0U4lYjapzEISapHMIbFOq2xB7ILEjruKAMyX6FwlYirgcaPxtnllMW6SeA07RWvi0WAsWYVK3qSDdmFlf9HIvU+PNGrkIakuaJ/F5LhRPUJzOyFNAKF7cVW8FQEPSIv/RLiSjgnKRenpZxzu8TtYbP2zxk98GlRxQEcDylBhvTjL9uiDNeTWb/2e1A2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 254dd05d-3407-4956-b98f-08d813e28232
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 23:51:24.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izo24TuKMJWfPtgFTSVpuJOMNgLhL42p/fiBdy2yRncvTFvpqU8FoSj8u12g5MDY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3190
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov <rdna@fb.com> [Thu, 2020-06-18 12:42 -0700]:
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
> 
> If both this and having one more field in bpf_map_ops is not a problem,
> I'll move it to bpf_map_ops.

Nope, I can't do it. All `struct bpf_map_ops` are global `const`, i.e.
rodata and a try cast `const` away and change them causes a panic.

Simple user space repro:

	% cat 1.c
	#include <stdio.h>
	
	struct map_ops {
		int a;
	};
	
	const struct map_ops ops = {
		.a = 1,
	};
	
	int main(void)
	{
		struct map_ops *ops_rw = (struct map_ops *)&ops;
	
		printf("before a=%d\n", ops_rw->a);
		ops_rw->a = 3;
		printf(" afrer a=%d\n", ops_rw->a);
	}
	% clang -O2 -Wall -Wextra -pedantic -pedantic-errors -g 1.c && ./a.out
	before a=1
	Segmentation fault (core dumped)
	% objdump -t a.out  | grep -w ops
	0000000000400600 g     O .rodata        0000000000000004              ops

-- 
Andrey Ignatov
