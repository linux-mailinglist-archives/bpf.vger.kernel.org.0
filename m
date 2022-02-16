Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB44B8CA7
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 16:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiBPPlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 10:41:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPPlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 10:41:09 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D103A291FAA
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 07:40:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDIqb4Uuob7Q8L1eIINX8bFVdObmFBW73ceQXaulMTFM/fy1XfiYwrPK7XsJBc0sCnfqyxsbk2POFWp+1W9TFdhKHK1lXaIjKleOR51gcFCBnQ3ypfwoxPSpBlnbO4AsDm9AL1MVqif2FYr1bgrhlvYlcLksSONNEtGlHEOfVeUUpE/LzK1EF0eO7lZ91FaQqmFVCKx6/p0BJKtMkGhThqU1N2vMVr4qxSGfW/sgOk5jxQ4MYWoJSTxUVkKNn9tVKZQBpNLdmGClZ+0L8WFEBN0Dy6sWt9G+q2+jVK7jknniCa2TBv+Lwa3pvUkCDDgYgCNRX5E+mCqngkoRFXy5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYOy16shJbwTxnPItrEcB4yLNz24GVq5RZS+q174NYA=;
 b=dKsJiSzMOf/u3gxmR9dPUg+2qn7OPzXdePhF8dyvdaqVEPLFOhFuzesEWJlQefbhM/qJp3NkHox/Noq78jaACowtIvKhaovWoCh2TY7/UYEFiehRXOpVlN7rc7cQ/q91Hf8n5HSMxq5SIuLxCXMeQ1+IQmGZSq38p+2sLkR4PfEiItLEWmHjwwN8Bw22BgAjVYde4/LAj4iLSOj0X2zr4Qys9tXx4TEzHhcDICbTs2gG7CQbhIS280K9V1G79tCt4WoJpW5js2GN7KdKOep2kgcRNOuVL1pVoCkDFFo+i70ig3zA/7LQQjdAZZT0OolrGXMEcvZMk9QEBdXkQKrWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYOy16shJbwTxnPItrEcB4yLNz24GVq5RZS+q174NYA=;
 b=XMzfDfHlYc1mGIE8YWH4aLDeyyC6w1KN1Wts0Tu5qe/KFi9wfBg508uhwm2mhRFlv4c/VejLDaDndse1wYWnsd9sLoRJNIyLT+sBxsoDasC/mvV1erHoGMUcBP+bEdGPRCxhvIV4kZJ56jhcgFGu6ecQEFv0qJoaqQReGYcX0KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by BN6PR13MB1684.namprd13.prod.outlook.com (2603:10b6:404:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 15:40:53 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%4]) with mapi id 15.20.5017.007; Wed, 16 Feb 2022
 15:40:53 +0000
Date:   Wed, 16 Feb 2022 16:40:46 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Simon Horman <simon.horman@corigine.com>,
        David Beckett <david.beckett@netronome.com>
Subject: Re: [PATCH bpf-next 2/6] bpftool: stop supporting BPF
 offload-enabled feature probing
Message-ID: <Yg0a/v0y218LZHCu@bismarck.dyn.berto.se>
References: <20220202225916.3313522-1-andrii@kernel.org>
 <20220202225916.3313522-3-andrii@kernel.org>
 <86567f94-ec2a-5441-2657-4e8f3f21059d@isovalent.com>
 <YgzT81NRqceBfEa4@bismarck.dyn.berto.se>
 <ce295e8a-9b68-e385-d109-5af1f06c0632@isovalent.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce295e8a-9b68-e385-d109-5af1f06c0632@isovalent.com>
X-ClientProxiedBy: AM5PR0201CA0020.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::30) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f10faaf-34a9-422d-ea81-08d9f162b6f3
X-MS-TrafficTypeDiagnostic: BN6PR13MB1684:EE_
X-Microsoft-Antispam-PRVS: <BN6PR13MB1684888B69639E3D52177A52E7359@BN6PR13MB1684.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGTauB48bTp3ZqPkjT2FebPl7rbxCSWXCYFN0UDFqnNjNHhu8WBi0xjI6MNncocrYQ8G47FFEWGagAzluVzAt2Hth+oiCBk4e8GmdcOcxJve4DFgwcOhzYeHo/0XPns+NASwtg3SCgkbmw5ysAlhIRApDRk8bwJ+1idq8OznFSK2tB/Ox+9FjWXU8pY7bZsrHiZRTctFr0z2b0+VvyHH9U72+i7cFZwSbF4E7szM42R7528UIgogGcebcccRNc+eAyJYLi4OpwqVKRZPwqMt+/cNIvUe4O+iHbOenZLP1qU+xDaLrGQ/tATsWbedNjqbYpGZECI5SZ4xHUkDMK/4dpgLJ2yuZeJqY8oRiXyT5eR4zHb2ndWbWypbJkL1kLEFC7uvwBPfuRGkSdIt3dsbKmkLfh686LVG8yiWWXYs4nvT9LG2xXS5OHt1OWm1JKKbW9FGWXfyylx2wvBtDWJfkdn7EPy4gvPtpaPVh2Bi9MV8igEHleMC7JUQvOE1Re7Lx7XltsKKUQamt38NpYJ3Tj3birzlQs9V9dv5ky0oSn98MLZKHsWHES5JWhOoYIu7CgtFItzcOHQp6XTkjp5elMdNUsyACYV0wijG+LkhaTP623z4TO4lelhYQD+oOZr05xP/uRwnWPQHACvg+RX405zyC4mTJwPlCjfvaUBYcl3YXXWWZzl4aBPv2qbRAoGWzoOG0KXXEmvuP/EUJ5RJlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(376002)(366004)(396003)(346002)(39840400004)(8676002)(53546011)(6506007)(6666004)(52116002)(2906002)(83380400001)(6486002)(86362001)(4326008)(6512007)(9686003)(508600001)(316002)(6916009)(54906003)(66574015)(186003)(26005)(66556008)(66946007)(5660300002)(8936002)(38100700002)(66476007)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wAXUrjKI71u50afXzItEPH/fnCmvqsW4XIxD4qAm1nMIXmt7/iwAU2iIIf?=
 =?iso-8859-1?Q?6VGloPLrhDgIVL+wdXV8+I5mUFT+93VJjF5+MG4pYbAfHIKVFdOCZC/6YH?=
 =?iso-8859-1?Q?UPGjhfSYZZAboTl50Brdz6GV5qzya6iSoTd7Fu41vGuTZ/4YJgENrVTfa0?=
 =?iso-8859-1?Q?VH8aS7GvNLN/EzjSEaqaOApZSkUIxk0JuIqTHgl1sVMfTGmA5Tz2hdVZzV?=
 =?iso-8859-1?Q?tkR0++HEnym2MG2CNYVahwNe2VrmWcSTCKXK4zgT3Qj3GO7ZFszLsLCopG?=
 =?iso-8859-1?Q?PUF50r6NA2Jb0GvQRDH5UY+j6nWUtUsEfEWulJenjZ3r6dPxc1CdTR7j5C?=
 =?iso-8859-1?Q?aWPjTxd/orcsWNhkYxHsknVw83zE+HDr91/Q5cHHS5m5p/F2sseUU4tN6r?=
 =?iso-8859-1?Q?k52lkvpoTKiY/RIInh1EZ/ZXorZXhiEE5neCd5NIR5aUVJuEqscG/EJI+S?=
 =?iso-8859-1?Q?NKl4p06atvgoNnV2sAgtQwWvnTvuEaUFXqpoQFrqMGS6OQR2ynywlkThd9?=
 =?iso-8859-1?Q?irJ1MrlcE3n6MEdYF/s0Lt9GTg48xL8BZGcJNVLEVp0TeRHqHYzCoOjEyc?=
 =?iso-8859-1?Q?MHLZIIpmlLKxQNeg964Ldmlkt12b19aLl5Jjxcl4UtT0hDeK2GY0N1sMz2?=
 =?iso-8859-1?Q?K2yaJ3VXlXtaHNoUL9408QBWvDxk7qrAs3RYHfu0jVGYmYabfslrewlVGn?=
 =?iso-8859-1?Q?gy6Ql2bkApTVoflc7DMM6sZAaaVyWpKazLqE4XK+k+0Ewnm8Il80WOryfU?=
 =?iso-8859-1?Q?WrE7jrWaEaVVSV79bKv+H2Ac65WinNCpzPPbYHtTQ++iRtuPXYA5XZZDWB?=
 =?iso-8859-1?Q?sVPadRP2Qsn8hNDbhjAx1ql3M8Nq9bAmycM5tXN8hWmr2176wZipdiv3bZ?=
 =?iso-8859-1?Q?oAGbGxSd5AMVhqcBLmcmRq+ug3QPuhYvIVtpnOQoJvRskB0ehZwAAT8SLk?=
 =?iso-8859-1?Q?61ZYcKMaiE9/nbpvpQCJSzIMpTWY/D72yJn2g6m+7XFglR7lzzzsxZCmU1?=
 =?iso-8859-1?Q?uMep4pJlrREQPJvh3GglapLQCd1HuQfWtdzePO/99BtCIKBP/hNnGNK/bw?=
 =?iso-8859-1?Q?4ZqncuaCOZQb2vWSWJdLZiRu1z+fGJrS27xeBFIobRqYibSk+t8pRTml0E?=
 =?iso-8859-1?Q?sAuuyuCM+dUn5qW+FT8zf3zmvwBDzedB2jG1pLDbLQF7QufHvb2tzMaWrn?=
 =?iso-8859-1?Q?6e9FQpPGlM3TdvymFVzfRKJ60/im47ESDz6S0K50wX5EASS2pHnHL6Ctrn?=
 =?iso-8859-1?Q?psv1qqgboAbHGKim0kwGg8ihsu1W2dSVRu/zdbmLVE6B1m0o1pEfRr7a8F?=
 =?iso-8859-1?Q?B3utoPzWGv/n0el4kDAzwwumdOdt/BsQ6kysRTUYCamyw06/AILI3nT4bH?=
 =?iso-8859-1?Q?uBco8498l1TxIjOYCFGVnq4cq4uVQS27iCcdyBgrPl44nqprHHGSn4fbVx?=
 =?iso-8859-1?Q?eu454QtRmn1XSlYGQX87wsbXDLceFhx3ynp5+0d9/PJqJrW91O/wTisFhw?=
 =?iso-8859-1?Q?wd02oUJPJ53tqxa/KOrTr2UvNy6ThwGYWL/pNRJR+7EnjtsTPwDYjgOGEZ?=
 =?iso-8859-1?Q?SpgZMU+bxH+meSAqwyQFPeSqUOeErPQJmk38gunorBSEEtwFMa2F9Lojh4?=
 =?iso-8859-1?Q?xj6g7Vh1YuBLo4zIbLsEksVvAY4MJdAj1bi41c/wiAc4HxfSdnKIItUYCo?=
 =?iso-8859-1?Q?VeOIj9TeIKsBo3wBTKiT3v/fZmW+8nVxWw6kD4EyeT6Q1VieP5PJ7KWBQI?=
 =?iso-8859-1?Q?QSyw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f10faaf-34a9-422d-ea81-08d9f162b6f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:40:53.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /04S3NMqVVevysR+ViYbUniOXNA3INROF5F2sVUzxrzkSvJDE+VoxBV6ynoNxSR6BLJ06eeFcdT1JqflWfUNrp0vq1tLcefszmKTOq4G7i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1684
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

Thanks for your feedback.

On 2022-02-16 11:47:33 +0000, Quentin Monnet wrote:
> 2022-02-16 11:37 UTC+0100 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> > Hi Quentin and Andrii,
> > 
> > Sorry for late reply.
> > 
> > On 2022-02-03 10:24:57 +0000, Quentin Monnet wrote:
> >> Thanks for the Cc. This feature was added for Netronome's SmartNICs 
> >> and I don't work with them anymore, so no objection from me (if 
> >> anything, that's one more incentive to finalise the new versioning 
> >> scheme and have this change under a new major version number!).
> >>
> >> +Cc Simon, David: Hi! If you folks are still using bpftool to probe
> >> eBPF-related features supported by the NICs, we'll have to move the
> >> probes to bpftool.
> 
> (I'm realising we forgot to remove the documentation for the "dev NAME"
> option from the documentation, by the way.)
> 
> > 
> > We do use this feature and it is something we would like to keep.
> > 
> > Do I understand the situation correctly that in order to keep the 
> > functionality in bpftool the functionality of bpf_probe_prog_type(), 
> > bpf_probe_map_type() and bpf_probe_helper() needs to me moved from 
> > libbpf to bpftool and used if probing an NIC's features (ifindex 
> > provided) while using the new libbpf functions if not? And the reason 
> > for this being that libbpf going forward will not support probing of NIC 
> > features?
> 
> This is correct. Given that the SmartNICs do not support as many
> features as the kernel, it should be simpler versions of the probes in
> bpftool, dedicated to probing the NIC; for probing the system, it should
> keep using libbpf's probes which have a better chance to remain up-to-date.

I agree, I will see what I can do. If you submit a patch to update the 
documentation in-between could you please CC me so I can restore it 
together with the feature later on.

> 
> > 
> > Is this something that can be added to this series as to avoid a release 
> > where this feature is missing?
> > 
> 
> This series has already been merged into bpf-next (this is commit
> 1a56c18e6c2e). I'm afraid there will be a bpftool version without the
> feature, because we just updated and bumped bpftool's version number on
> top of that :/ (9910a74d6ebf ("bpftool: Update versioning scheme, align
> on libbpf's version number")).

Do you think it would make sens to add a Fixes tag to a patch restoring 
the feature so in case it miss v5.18 it can be backported easily?

> 
> Quentin

-- 
Regards,
Niklas Söderlund
