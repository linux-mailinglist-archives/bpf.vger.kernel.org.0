Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E54403E55
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 19:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352470AbhIHR3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 13:29:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352462AbhIHR3M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 13:29:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188HPBvu016924;
        Wed, 8 Sep 2021 10:27:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=el7rOaRdCwgSzqTt47F/Oq/Jyx3jK7LjpF8sfp45q/o=;
 b=IWLrxn++QITykeEox1OCTsQiTsk9Qpx2DeW4bIyubycy4m5RA8k3NqXt4+FHtzuAZweV
 fC0lFEhWrnoBZMLTBxLqhB/9xER07NGU+wP0GhtSWgBbNw97RJZGYBmgqCfcOMskSUcR
 iXd73OL569by+pMhC8GbDl+fLNhmkmS//Vw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcqff9t0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 10:27:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 10:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mclpn0AOe+DoMXac+iD1ss0zKMPaSBPH5RZnWYFKW4SNXbBktgcXiuQrnpgbFobY0FwTnL7RHC8yq5b5c+GMGJKCXPYh/aTLehHj0PlRjJz/NcRopqG5p+5aq/H0rgBXkHuilB2Cyts5V2SXIBGCb6EVHrBMjsJdC6Jo4Wx4WTYSw2gilET2FcOQtAyy7TJI/4km8/J3K2ahyKuHM4qDEPjUWPrRktmXi5WoRkNQOWq/+XGtXmD3s7nQdobQ+ZYb4gk86AZzMcYClqXBESZg4+8RyNXFy3OqhlKVhDnqTq3HlQVbQrOh/PjeWnm41FEbnLmt8GgBXnoR9YUGqXS8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=el7rOaRdCwgSzqTt47F/Oq/Jyx3jK7LjpF8sfp45q/o=;
 b=UYR3kakOR+JNywIRQxkLX707jKtSQsEb5xxVcVbr/OAVcVnlPElmMMdaLOCqqKZAjMGvEC+tEL5WfR51MHp3d/YpkUTBJOoiyKFtpIWO7dPZFiEbFY1R27r0pnOGXOy2FiJJb61P1nryDi9Cd2PHiICXsBqWCN00YfiwvymIhx9bc2yJbPCsjgG/P/jDDnjL0DbFl0ly38rL4h1rROrXdl/K0Vpxu46ok/XGfj/WRKTbMblNHE6o2f3eXULfrJrl3lmwz57D1f8KksGaFJtG+HJMMdbOzCvf9pjMms8z7PmN2w1rN+U/AhDeNwW3nUZvUIhpvek5zgOKEgLRwusYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN7PR15MB4239.namprd15.prod.outlook.com (2603:10b6:806:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 17:27:40 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 17:27:40 +0000
Date:   Wed, 8 Sep 2021 10:27:38 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao1@huawei.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] bpf: handle return value of BPF_PROG_TYPE_STRUCT_OPS
 prog
Message-ID: <20210908172738.6cez2tca2drqteft@kafai-mbp.dhcp.thefacebook.com>
References: <20210901085344.3052333-1-houtao1@huawei.com>
 <20210908060611.jylpjegug3gs5gys@kafai-mbp.dhcp.thefacebook.com>
 <8e8dd070-ba19-2153-bf9b-8bbb16a70abb@huawei.com>
 <20210908171939.l6ozdyoji3n5baaf@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210908171939.l6ozdyoji3n5baaf@kafai-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:6717) by SJ0PR13CA0137.namprd13.prod.outlook.com (2603:10b6:a03:2c6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 17:27:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 112a87ad-2b5e-4da5-f3c4-08d972edf59c
X-MS-TrafficTypeDiagnostic: SN7PR15MB4239:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4239914582598EBF51269DE7D5D49@SN7PR15MB4239.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: At0BYX/uSaP5T8uSBxoY0/sW+K4EFVfxOdaH418OFUO0ZoxnALS84sGnF1CN0kxmNbolol8B19JNtjSTZcY/W6mTXgmTIjmAVsHD/zPfj9jiOS4Zd7Ckx65syrqscIXz1q0vp0Pj/5sf+uAf/eyqV40sCYUo5IndlChu+vNcEJL8uoxgzivuGSBB3K/MbSlEWPtWnGH1GhprrTN3WkNRaJSAZg5O7R4Uvib8MGkIgq6KotqGNOf17TdqrxczB9wQmL+Ra33Od1keOho2/554cf7XK/V3z7bEkgBw3qO6YB0hZ9zBx1R6ssP4giNf0LMqIzb3B+t1XXxpzwcua0rze/qP3w0TxfTJueZbsC3xtUPr94gQ6LO+1UHo9vO5oEEyjC8y1jsgM2tWHpbrk6UqD5T8y2qYADh2S0Q5pIwAcWXR5vVCDZrLyoTyxK0o3CdvLCzn/hdjHD1pStvZ+gICgzmSm0ZPBXmQc4T3acq8k30atiepb7XwJs1feuZrjxSgFix0DnDOeJF5kWf5OQAynz4N5wToL4mjWBrrtA5Rw1YSBZ3gGejtIMrZ80U9PwPrRT4hi8raaYXZZ5ap9dxbghGyCx+SDDGaC9ZWE5xFE/EI6Vm7uYLr6DUr8i/anT+n8apCbl6pc7gJVPIGEYW53Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(55016002)(8676002)(66946007)(66476007)(66556008)(478600001)(1076003)(9686003)(6506007)(5660300002)(186003)(2906002)(8936002)(7696005)(316002)(6916009)(52116002)(86362001)(83380400001)(54906003)(38100700002)(53546011)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HduR/oWqfaj8zEmDdlJtXKb1qqczFK7/OxZnymhSSV/LZi1Zay1E1Db3sgO8?=
 =?us-ascii?Q?ajshEX3raCiFdYMXVn9SyvVkkQuWxRAdesW5IeLv5yj8UKFNMk+PA9oORji/?=
 =?us-ascii?Q?ddAD9o2OPBAWW7B0W7G5PyopObeGJusAl5PRFpfz8lbjl5lmDbyQ8fiDrWwg?=
 =?us-ascii?Q?X9n/gQzOapUwlWki5SHCDEitrubJVpr4sRCG0dsgZ1wJanaMMlSDAe1U/dCF?=
 =?us-ascii?Q?Xn/BdXFgkR5ZKtvleoO5M8mBXf5tR4pjJxkVXUHDGOV/DfaIyZNXVrZLCl9Z?=
 =?us-ascii?Q?KFI7e0ZHahOrigzbvIyp/OBabZSLXa5UWHpr0331iV471AvtVc4pjal4iLT9?=
 =?us-ascii?Q?AKNaod3AFFbs5Rfmu5BFRe1nq3Gw8ijWFjWYGE8Ugy/8dKoRNHwxMDPXyFHz?=
 =?us-ascii?Q?+zM+6fWJj7tP4wZ9iZLTRSq1xDqZSmKlNq/BryOve5zKObn8GL+WL8YcEwTg?=
 =?us-ascii?Q?LoHfx8TD53Iazo74Syzhrutqx2f4x/ythw7Kn2HnvgStxlVy35XXQNputmms?=
 =?us-ascii?Q?8IAVHghPNTkElBNnCKRc9Qvx4+XAYZEThJ7+Pxbu2ZWnXQAIyt4nWEl14fzo?=
 =?us-ascii?Q?Mw+VGwiD7xzZMhRO0AJB7fyJVw70C3q7570babLUBaVLK4OZG8iKJQPEMrcD?=
 =?us-ascii?Q?XTF3fyLrPuaFNnJ12OROL6KgHaMLLcxOTCAYpuHms4ygjGTrIj+EsUfr/m/a?=
 =?us-ascii?Q?qb6XuOU9QNWliMmxcF/kG7/mEK61D9a9A9ErNzO7LcSUwWvPox7M6sA3hSCn?=
 =?us-ascii?Q?GD+L88yTIfv/blwCncvfvP6y6hjNotTq4sSBNn8cj9/eYsrYQo/+pG5cg7xr?=
 =?us-ascii?Q?mUA0FZCIE3cFlIRlJ5ten/VcXMbRi75awFSiTQhXhMggsYHkZQzYj8VlCE27?=
 =?us-ascii?Q?zlhSq92AedTkSqtNNLgn1mly/9U/FJlEVi11a/ghFXXTJvAQJaKDSeHqiA7K?=
 =?us-ascii?Q?zQsbjeXVtJcIWv7qsullQlcriTWAGG3ZA/TLun69FMm9E/YhWIok4EJ3Akvb?=
 =?us-ascii?Q?sl80iVdhQ6B98koJLunMr3VEND0Huka58l84jpIHuv9NuKDjH8VZ0FZ01Y//?=
 =?us-ascii?Q?YO9GEai7ZLoMBgM6aHghLu00a122gjLlByPChMdBGooeUS5JAVe/cY+yVJq+?=
 =?us-ascii?Q?WiJjK13D/9HqMSfY49IdF91Xso+PRHrGA9VCEsHhxJKXdX914tgbcdxYY7Xd?=
 =?us-ascii?Q?byQdX8YbukB70dQjNgjGQUf59TMpi40iyQuL+X5Y5rhUoYDy8R9P78chO5nR?=
 =?us-ascii?Q?aPxd/2vvUTVz9Afjn9zhHUq6EKype78Oxr3F3LFs7YXlqCA0ANlZyYwqZSNp?=
 =?us-ascii?Q?QpDCyhV6zar1l+BMZVPV8uelmb/znmE1+cRrM9F3eK0mWw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 112a87ad-2b5e-4da5-f3c4-08d972edf59c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 17:27:40.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7ovjIUanTLvtvL0yNV6yZ7WRQMkjt+0Pof541QZgs9NW64QYVo8gHIoVMa+f8oS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4239
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 83DE0aUxTI7JgoyyNTVMyuJ7j7kse8g4
X-Proofpoint-ORIG-GUID: 83DE0aUxTI7JgoyyNTVMyuJ7j7kse8g4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=706 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109080109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 10:19:39AM -0700, Martin KaFai Lau wrote:
> On Wed, Sep 08, 2021 at 09:31:55PM +0800, Hou Tao wrote:
> > Hi,
> > 
> > On 9/8/2021 2:06 PM, Martin KaFai Lau wrote:
> > > On Wed, Sep 01, 2021 at 04:53:44PM +0800, Hou Tao wrote:
> > >> Currently if a function ptr in struct_ops has a return value, its
> > >> caller will get a random return value from it, because the return
> > >> value of related BPF_PROG_TYPE_STRUCT_OPS prog is just dropped.
> > >>
> > >> So adding a new flag BPF_TRAMP_F_RET_FENTRY_RET to tell bpf trampoline
> > >> to save and return the return value of struct_ops prog if ret_size of
> > >> the function ptr is greater than 0. Also restricting the flag to be
> > >> used alone.
> > > Thanks for the report and fix!  Sorry for the late reply.
> > >
> > > This bug is missed because the tcp-cc func is not always called.
> > > A better test needs to be created to force exercising these funcs
> > > in bpf_test_run(), which can be a follow-up patch in the bpf-next.
> > > Could you help to create this test as a follow up?
> > 
> > Yes, will do. The first thought comes into my mind is implementing .get_info hook
> > in a bpf tcp_congestion_ops and checking its return value in userspace by
> > getsockopt(fd, TCP_CC_INFO).
> The bpf-tcp-cc's struct_ops currently does not support ".get_info".
> It will be a good addition also.
> 
> Different bpf-tcp-cc implementations have different infos, so it cannot be
> bounded by a fixed struct like 'union tcp_cc_info'.  The format should be
> a btf_id followed by the actual info-data.  The kernel should be able to
> learn the size of the info-data from the btf_id.  The ".get_info" is
> also used by inet_diag for tools (ss) like iproute2.  libbpf can pretty-print
> the btf described data and libbpf support is added to iproute2, so pieces
> should be in-place for iproute2's tools to handle data described by btf.
> 
> For ".get_info" in getsockopt(TCP_CC_INFO), not sure how the application
> may use them but I think it will at least enable the application log
> them as other kernel's tcp-cc do.  The implementation details may
> need some more thoughts but should not be a big issue.
> 
> > I also consider to add a new BPF struct_ops
> > for testing purpose, but it may be a little overkill.
> A dummy struct_ops for testing makes sense. It probably should
> be the one done first for testing purpose.  Although "get_info"
> is a good add, having a separate testing struct_ops will be easier
> to test other interesting cases in the future.
> 
> > I just check that it can be applied both on bpf and bpf-next, do you
> > have other commits in your tree ?
> There is no local commit.
> 
> From a quick look, the patch is created from a pretty old tree and it
> is missing the BPF_TRAMP_F_SKIP_FRAME.  It is introduced in
typo. I meant missing the BPF_TRAMP_F_IP_ARG.

> commit 7e6f3cd89f04 ("bpf, x86: Store caller's ip in trampoline stack")
> on Jul 15 2021 which is pretty old.
> 
> I am only able to apply with the --3way merge like "git am --3way".
> Andrii, is it fine to land the patch like this?
> 
> > @@ -1949,17 +1972,19 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >  	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
> >  	u8 **branches = NULL;
> >  	u8 *prog;
> > +	bool save_ret;
> >  
> >  	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
> >  	if (nr_args > 6)
> >  		return -ENOTSUPP;
> >  
> > -	if ((flags & BPF_TRAMP_F_RESTORE_REGS) &&
> > -	    (flags & BPF_TRAMP_F_SKIP_FRAME))
> > +	if (!is_valid_bpf_tramp_flags(flags))
> >  		return -EINVAL;
> >  
> > -	if (flags & BPF_TRAMP_F_CALL_ORIG)
> > -		stack_size += 8; /* room for return value of orig_call */
> > +	/* room for return value of orig_call or fentry prog */
> > +	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> > +	if (save_ret)
> > +		stack_size += 8;
> >  
> >  	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>   	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	
> >  		/* skip patched call instruction and point orig_call to actual
