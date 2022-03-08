Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B964D2436
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 23:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiCHW1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 17:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiCHW1m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 17:27:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2136.outbound.protection.outlook.com [40.107.243.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F3583B8
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 14:26:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIWE8ugs/PKYA3GAmi7qB22TjYxKYvLHx3vANnZEftp4YOR2Zj5pt//OJIbYhBSmlGTS8TrB2gEvJ7960ccK7/xfPIrmm5BqFA6QrcraDRMt9tq7Cr65hAYUdAjK+CVKMl1spKxhkhkrNQ5XNo4CXPNfiT6az3UW7wXQNT1rarsOfEiKFWMCrdwDGANyulBAHv6FcksJkdAjAMZJSf6zr65pzSWvLAwkVp+DbrnOYhpmVs64UfvfSo6C3TFmj7z77e6YgqBwNANmXad6xIUGF80bpGBdgoMfYFXulYY5M2ZxrFS71ept99XlxixlwE1gfolzicCxsSZHZ2l/qUdUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGNpWy3bjMvgff625VMLwTJMXn2BRboHKVlNxswjVLs=;
 b=hjx+sfWoINVq8sGFODRwCG8aqUukQgIHdmzNBu1Z7c0/x6A+aVX3HIwkwk/zH3fOBZ2roZWJBu2wwSSKrblVvcJfVIKEWzB+d5YvL5qNXiEyCN43G2cm5TFuvJszlii/NfkJST0/qRTeciXGjH2qeOAIOQBk74dCp0wSywgZbQM/ZaIHZcUp5tEKyU88vjQHtaPCngj2oktT9o2oZH1q6jcsFFV9zBQzc0e5jGI7BuRk3U9zbgJ1dLiapQarGqbGv7740Q1L7r5iEnsWgI/o7dREyZS2FSoLBuOjpbUD748Ep0Yqj6l2EjboATCBxqE6WBHiquJhRpqV8QQn483xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGNpWy3bjMvgff625VMLwTJMXn2BRboHKVlNxswjVLs=;
 b=TuRFyW5g1YwBfyB7YRlSBoiLZ1HHA2cE7kZG2mVzj9KSKrdhpDOJX1Ow6GgBaYpeTFUYzTb8GmSsMJ8i0U6p5UkLtXgBDk+wH/rDatBkKgqmX7buT/byE4N4qpGK9CAm+BsKhtafiinMI6Q666eeC2kXQfm6Q6KYlYhW2kkr8rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY5PR13MB4423.namprd13.prod.outlook.com (2603:10b6:a03:1de::15)
 by DM6PR13MB2363.namprd13.prod.outlook.com (2603:10b6:5:ca::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3; Tue, 8 Mar
 2022 22:26:42 +0000
Received: from BY5PR13MB4423.namprd13.prod.outlook.com
 ([fe80::8d70:5e0b:ff43:8852]) by BY5PR13MB4423.namprd13.prod.outlook.com
 ([fe80::8d70:5e0b:ff43:8852%6]) with mapi id 15.20.5061.018; Tue, 8 Mar 2022
 22:26:41 +0000
Date:   Tue, 8 Mar 2022 23:26:31 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@corigine.com>,
        oss-drivers@corigine.com
Subject: Re: [PATCH bpf-next] bpftool: Restore support for BPF
 offload-enabled feature probing
Message-ID: <YifYF5PXzCC+VpCO@bismarck.dyn.berto.se>
References: <20220308113056.3779069-1-niklas.soderlund@corigine.com>
 <25f003df-97cb-549b-e117-2eb1fa2f3cc2@isovalent.com>
 <Yidskyc26yC9F1c9@bismarck.dyn.berto.se>
 <CACdoK4LYPAjPc-aeqS_G+gp6Nw+KoDjyL3P8ujvvy67DFMKfgA@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACdoK4LYPAjPc-aeqS_G+gp6Nw+KoDjyL3P8ujvvy67DFMKfgA@mail.gmail.com>
X-ClientProxiedBy: AM6P191CA0081.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::22) To BY5PR13MB4423.namprd13.prod.outlook.com
 (2603:10b6:a03:1de::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 556681d5-da49-4453-462a-08da0152b61f
X-MS-TrafficTypeDiagnostic: DM6PR13MB2363:EE_
X-Microsoft-Antispam-PRVS: <DM6PR13MB2363DF64BE4982BF19C31E9BE7099@DM6PR13MB2363.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysvKB4tQsgiTxInTSer4lQCCxQC4/a2/+cTnD+9q/UfLY0CuDJPZM+qJjwWQYw00B69yiOSigf5LGpnLMd+p7jqKwS97iIJyhhrujO/9dt7NNXdUH8pqp3uObNWFa5Sjwi8cxL6nf/F75P1v7A+/Zt6rbu9RTlyN7ULYgQJ5CUQANoMygDmbm9JU4DhDDVdzEpLsitNfT6znLtdWjfhz4ppISKphkE8tXLn2XI6MN4zch7kbQqHsySCm/Vy1kl1DLTtthRrTnwHaA8MaoK/EC2JUbUDI1tu1FPulRBkC1b1YoimfPsJilq7cCX4w6l2IqJZiNC5AzO6j+gpSh2yAo/QnTi5FNFD81y8zrX85np3U1JgY/Y4JOSRxXRIM+8MKF+AJBJMOjm2PHxoGTBS6wj//gV2QSICLZRZaDnDUbjjegcaJffAYFDQtdkTFDg66NXJEyR3fhrGhSANTO7qcVyhzsW/haIPB3qf9K2CcJ3QK/M74oXYeuMw4+8hGTUCtzpS79z4TvpN3jNstrp6L/XHrGy+5g3aVn3rOa6d5BFVNk6GiQIkeTMGeVJjtFlQ+7+UmZVgvdZrY0RYm0dAdgTl2MQb3UMLHbdutx7HqrrNo/AaCMivOOm5ktUwgOBFZpOKOC79v5+ab8e+WyFsuyW17ehx4jlEGgBsnucpEFiWq9HSDNIgldn0n+Vw8JDdHlNQj0+sG25V/HEC9Nj+5ckcAyCSkROdllfFtb/qjPRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4423.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(376002)(366004)(346002)(39840400004)(86362001)(38100700002)(38350700002)(26005)(186003)(66476007)(4326008)(8676002)(66556008)(107886003)(66946007)(316002)(2906002)(8936002)(5660300002)(6666004)(6506007)(53546011)(52116002)(9686003)(54906003)(6512007)(508600001)(6486002)(6916009)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vQD1i1n7kRduV4bBuW/J3IdcQJBYWdnx59wetUgi+jyx0egV2d4okVNXjr?=
 =?iso-8859-1?Q?/anhN4/n0e95bjHgBtqXLJ6itn8WGGiR57a4jnfIMqSFCtOH7ftFnoCHsZ?=
 =?iso-8859-1?Q?CmwCF29f2pWoERdc+PPh2rRfuetoUOdBsS27bDFFu0m++GvzzQ0EAnyheh?=
 =?iso-8859-1?Q?Fx/XHhhHPaF5c62SOmq/U4F8eDVbE4//hmxe1auPxhJn0TU1VOQqo2toRi?=
 =?iso-8859-1?Q?Lju4V8wf+ClV8PvHnoiw+uMuRalKL5lPsQv+g8kwi92UKhlAEPTZzJmMwf?=
 =?iso-8859-1?Q?2QaCmc+pJ31dd6yJ2CYUC6kUqg7b3KKv5PGVzJHZ1vsF8pnsPIjdpFF0ls?=
 =?iso-8859-1?Q?nVSzyMwUFVe/kzT2hcQCMxyi6ZpKHDKSYa3QDGD7yIDKpxo9pv8KHXIYIj?=
 =?iso-8859-1?Q?+7Kfy4heYq8gjarDa05zb5o2cvB10kxWFTfmZ/1A1NxVjiexTPwuDLoeBF?=
 =?iso-8859-1?Q?AbIN40RFoQcTeNTM6Y7qU8kyQx38/6tgPsmXUx/GQxk8X8HQw0WI4+0qCL?=
 =?iso-8859-1?Q?Bvnu4xtWoCYP9hGmKc93nanECiQecQZ9e1hg25O3o6MqgUQRL63YDNgw1r?=
 =?iso-8859-1?Q?4t+4Xv7AbF6qMSfE8ZtGarIjL1QJdF3p9TWaBYxg2sc/VI4GPbTzozz5kn?=
 =?iso-8859-1?Q?lh7hjJzT1lXDYkhNw++eyeYaq4+CO78au0GuOT5oXCpiEQ4lcg1ZNyS/g8?=
 =?iso-8859-1?Q?D+DWVpNkiIvVYMo/HCwV0hj85RBhik2JlhtQnKrJvWJnOQOyN0A2oosUDE?=
 =?iso-8859-1?Q?jVG6HVlVdoeACyYvyupiGfFKAL7ZX2lQWmrcRb/xE5pASOwINcr2XtFf2L?=
 =?iso-8859-1?Q?PKOUZyCi3xY242sSjrWUI/QRzAelhIYnUeHoP+TtjrWt2LDTllxWeVQATF?=
 =?iso-8859-1?Q?i+CF7Ct+143nx6LR4HYVQQO0r4skklGhdfBkySMiyHrXEMODQ8I5ey4Tdr?=
 =?iso-8859-1?Q?YVvjLZMpzEkbA+7ydd4cSYl47kLNdocUIstqJWen3M4/veRjSBQEjVENFo?=
 =?iso-8859-1?Q?thDXbMO7skALauIIBdL5L8gygv7Z0vATmY0UQPeCgXQleaqX+p1+bKKd3Q?=
 =?iso-8859-1?Q?JxiBUdbvjpyK1QWrwR9AbuPYyZ1iiBcSUOXEw8Fjg/L0osDsZ1Kl/rvD7I?=
 =?iso-8859-1?Q?RxIJDCrx8m0AfiFpoB5kpjbgffBMy5eqorou6mfZjKurPGrs9bHhwL24rF?=
 =?iso-8859-1?Q?YaGaJtp1pAtylJt0fZlCwS5DuEvlLUrtXWWgwnniqP2qThX4/UD6QXd3P2?=
 =?iso-8859-1?Q?op3jyDOvbE62fteuynChjBOybTs8aTbk8xnD6IuQ5SkEJ3lGv+0hy/nlP/?=
 =?iso-8859-1?Q?V1e9KMx3trY/8o70lmsDB+gfyXy/o9zVjlVCrM38jERh8qBdRsKp4Ou58I?=
 =?iso-8859-1?Q?NLqUNZ2nsxBUPx0bu20lKPB0XYFraZcigQH6jpS6DRUVQaFN+F6Z82i42X?=
 =?iso-8859-1?Q?YiECsJPYWp75PjM9mLu0V01jJpBbHrttM+ccPtyGjwrS255SeEpAmUADKc?=
 =?iso-8859-1?Q?Pi33trpugCOxJRAAn6XkwbGlKA+g3iRUEv4lY7Re0+Lw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556681d5-da49-4453-462a-08da0152b61f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4423.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 22:26:41.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jssa5ttdgKxdtdWHOEHZFYf8EzE8GzGjf29mSMa00JhsTjY6oM1YeVqqVUwxbxkO4bWtZUlXDodfJgjkLlJ4fu5jwxK7pOEeecsdMUota+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2363
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

On 2022-03-08 21:43:07 +0000, Quentin Monnet wrote:

> So I looked a bit more into it. I couldn't remember the reason why
> we'd probe all maps but not all prog types, but the commit log has a
> hint:
> 
>     Among the program types, only the ones that can be offloaded are probed.
>     All map types are probed, as there is no specific rule telling which one
>     could or could not be supported by a device in the future. All helpers
>     are probed (but only for offload-able program types).
> 
> I think at the time, I was referring, for program types, to this check
> in bpf_prog_offload_init() in kernel/bpf/offload.c.
> 
>     if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
>         attr->prog_type != BPF_PROG_TYPE_XDP)
>         return -EINVAL;
> 
> This makes it impossible to have other types offloaded; but there's no
> equivalent for maps, so we could theoretically have any map type
> supported. So maybe not such a bad thing, filtering out non-relevant
> program types but allowing out-of-kernel drivers to probe all map
> types. Maybe keep this part unchanged for v2, after all?

Thanks for following up with this information. With this background I 
agree, lets keep it as it was for v2.

-- 
Regards,
Niklas Söderlund
