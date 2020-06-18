Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E41FFBEE
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFRTmx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 15:42:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgFRTmw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 15:42:52 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IJaROo031243;
        Thu, 18 Jun 2020 12:42:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=C0vNVIzbpirmTR8SIILftGIBe2FaIJR+nRDQCf7otNM=;
 b=n9tEH3YnVOT1Nwo5jrULBvCT9Zx0F0AE3gWYqoFEcGlpBq7Ux4qFtCxoBBcTNDiolJ7Q
 Xo6VHI/Ubp45NhWLtKlsqWAivkEOzB3WNZu/0Bhd9f+kgFRfGmDLK30Bny+JyuRROcGz
 A6FGXeC/9UAIwkGE+Iug4fJjIVO7E2HbwLU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q65de544-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 12:42:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 12:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnAiXAhJPIfrw3vi7uwwhrER3MCCf0btNhgMN2bm2Drn+Ably7cJMTWafZGLzE0K7LS/5qGW26wwah9n5p4ctxqxAdFe+mbUUp/dSrYrX2YfNMxLvpE3mozP+aCi9s5E0d8HhNiFb20gUEVibYpHx2MWrTDzUZXvgSCNU2pDXp+2WXhpwpWzULnKabE3EJa7croEEV/EJQ9LNHuqfheNWLW8iHSG8xBKa2u5IAebuGoJiVaJNnOYfOxpMvg11aEDzMfDUcvISR3Rsytn6Ac+BwHy3WkMJhnwpJdUwU5n8qGMoiUxkt5lkXVCPOE7kJHr1R2pbEdlYhq5BtaAEVPv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0vNVIzbpirmTR8SIILftGIBe2FaIJR+nRDQCf7otNM=;
 b=RgwuNKim7z+oDGmMh4SSjQkmkZTrb7pBTvoZr3mcSbzijSjlbXb90f6LaewEZHHYJy9BPmz3GUZLqluB6SqC84RM8CMLDxwdbG4uTzwgs1WoY6eN0OVmE3Kc2Z6TFzUVXsio7/42761dYcb2RSeZi859hUzF3IBGQKvZqYyYqppHjifJwJ+iJuU2n11DzmD/hHl0pL/xnQicQ1EFlMJgo/12O3vlPWfzPopMutiYRkTAHwdnbYhnk0cJ65XDRcJUchIzdaEUwvTCWAlpAgsne5jvWzZFXc9dDhDW0kZtUBzo+4/iTs9UngkbrMfn69CVtVccoA7sIkCJVqf/qfZaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0vNVIzbpirmTR8SIILftGIBe2FaIJR+nRDQCf7otNM=;
 b=K1ksVrvgqif/fmMcnQdgVBBc7vCcLac/4oVb47L3NbbxhZ0B9OWYFn9YFliVcW6TkmTkkY5phVFxR4Q0h1h5YRHk1x8MAls56RK1vNuOGVJ4nVhb8ePQMznifx1L+oR28a+x2Id8O+oYz3NGYzX5Zw+YIi8M/q/ymKsAv1eNnVw=
Received: from SN6PR1501MB4127.namprd15.prod.outlook.com
 (2603:10b6:805:63::25) by SA0PR15MB3758.namprd15.prod.outlook.com
 (2603:10b6:806:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 19:42:38 +0000
Received: from SN6PR1501MB4127.namprd15.prod.outlook.com
 ([fe80::7c6b:6612:6e3c:8bb2]) by SN6PR1501MB4127.namprd15.prod.outlook.com
 ([fe80::7c6b:6612:6e3c:8bb2%5]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 19:42:38 +0000
Date:   Thu, 18 Jun 2020 12:42:36 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [Potential Spoof] [PATCH bpf-next 4/6] bpf: Support access to
 bpf map fields
Message-ID: <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1592426215.git.rdna@fb.com>
 <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
 <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: SN4PR0501CA0091.namprd05.prod.outlook.com
 (2603:10b6:803:22::29) To SN6PR1501MB4127.namprd15.prod.outlook.com
 (2603:10b6:805:63::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:5788) by SN4PR0501CA0091.namprd05.prod.outlook.com (2603:10b6:803:22::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12 via Frontend Transport; Thu, 18 Jun 2020 19:42:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:5788]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf430a02-e378-42b6-bafd-08d813bfc162
X-MS-TrafficTypeDiagnostic: SA0PR15MB3758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB37581E1DDB192ED13B29BE8FA89B0@SA0PR15MB3758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJu0PDLVKMvcBUh7ZY8XjIDRugKhZg5cLUd5InQKWfm0Cih/0lOytzFJsI2v5Yqh+rqrucgFSRMZ0b9WMbZcg3mWh+gQK0pxNTraEaTfu2nsqP8VTg52WraoPIVF+s2D5kwSc3oTYKdKzZjRsI9rGvH+OEgXef/ayzgAN6iYNcqrYReQA3gf083BNlX3Q0fSEYoVXegxZFae8ZOaNo3QhWMpOCdl5se6Seujq96M7ATIm/GaszhzGFwhjiijzPJJI0chns4Pz9CXvQalIrMh7f91MmoXZDw1rO07teaOUgzQsw/sNoIEryvMS/8o6iWd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4127.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(396003)(376002)(136003)(346002)(2906002)(16526019)(186003)(66946007)(5660300002)(316002)(66476007)(6496006)(9686003)(52116002)(66556008)(33656002)(4326008)(6862004)(1076003)(478600001)(6486002)(6636002)(8936002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 86BMZHKmiT9Pe1g3XUyzPuzx1+UrRb2L+Kg5t8Q6Pdeow8N1l3bLj+sORKhTfhaGotArvAK2HCLhBLLmv+dMzMUXRwSejEPYX9yfJA2rkYUTtk55E0X0kk+qAdyZvIYWatDcurM34PSI9CPCMSPvPRkKyYRo7S5PNot17Ur8KJXZeQfsn/M+igVSzQSLr+kY4njWWnZsYxjiqcxWyDnCcW+a00Irenx56nGNOYQkF+rt0mv2D5vv3NzUPTtZsf5Up8s4WRNcvtZGOcWCty6sjfgLa5xXpDiii6i1I47ZUd3L8472dS97a9adgCo3QFwUUSfJH7nDUBUb80nR5hJFawNCQE41pjZaIwD2wnLgUaO1uFDvl9mKpDy3ANXwD+eXeyz41sz5ioG3SJX0VDJ0y2/h5SzqbwixHsbPMTIQMAG5kyjuAq5EY+tdC9u+e1eUJUgWiLj6QqhnoxgMmFl935/PfLPdeF0u9xFF4bofJCj4mQSyRlAlRcPmomB9dCPA1+Z851Ssopc5fT3zES4xgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf430a02-e378-42b6-bafd-08d813bfc162
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:42:38.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udI+3VjZXCeo/CVHoGsy8Yz5oRc3Fni7mZD+wx/fOjBdeFSQHT+t3pOamuIaz04O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 phishscore=0 impostorscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180149
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> [Wed, 2020-06-17 23:18 -0700]:
> On Wed, Jun 17, 2020 at 01:43:45PM -0700, Andrey Ignatov wrote:
> [ ... ]
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index e5c5305e859c..fa21b1e766ae 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -3577,6 +3577,67 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
> >  	return ctx_type;
> >  }
> >  
> > +#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
> > +#define BPF_LINK_TYPE(_id, _name)
> > +static const struct bpf_map_ops * const btf_vmlinux_map_ops[] = {
> > +#define BPF_MAP_TYPE(_id, _ops) \
> > +	[_id] = &_ops,
> > +#include <linux/bpf_types.h>
> > +#undef BPF_MAP_TYPE
> > +};
> > +static u32 btf_vmlinux_map_ids[] = {
> > +#define BPF_MAP_TYPE(_id, _ops) \
> > +	[_id] = (u32)-1,
> > +#include <linux/bpf_types.h>
> > +#undef BPF_MAP_TYPE
> > +};
> > +#undef BPF_PROG_TYPE
> > +#undef BPF_LINK_TYPE
> > +
> > +static int btf_vmlinux_map_ids_init(const struct btf *btf,
> > +				    struct bpf_verifier_log *log)
> > +{
> > +	int base_btf_id, btf_id, i;
> > +	const char *btf_name;
> > +
> > +	base_btf_id = btf_find_by_name_kind(btf, "bpf_map", BTF_KIND_STRUCT);
> > +	if (base_btf_id < 0)
> > +		return base_btf_id;
> > +
> > +	BUILD_BUG_ON(ARRAY_SIZE(btf_vmlinux_map_ops) !=
> > +		     ARRAY_SIZE(btf_vmlinux_map_ids));
> > +
> > +	for (i = 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
> > +		if (!btf_vmlinux_map_ops[i])
> > +			continue;
> > +		btf_name = btf_vmlinux_map_ops[i]->map_btf_name;
> > +		if (!btf_name) {
> > +			btf_vmlinux_map_ids[i] = base_btf_id;
> > +			continue;
> > +		}
> > +		btf_id = btf_find_by_name_kind(btf, btf_name, BTF_KIND_STRUCT);
> > +		if (btf_id < 0)
> > +			return btf_id;
> > +		btf_vmlinux_map_ids[i] = btf_id;
> Since map_btf_name is already in map_ops, how about storing map_btf_id in
> map_ops also?
> btf_id 0 is "void" which is as good as -1, so there is no need
> to modify all map_ops to init map_btf_id to -1.

Yeah, btf_id == 0 being a valid id was the reason I used -1.

I realized that having a map type specific struct with btf_id == 0
should be practically impossible, but is it guaranteed to always be
"void" or it just happened so and can change in the future?

If both this and having one more field in bpf_map_ops is not a problem,
I'll move it to bpf_map_ops.

-- 
Andrey Ignatov
