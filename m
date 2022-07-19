Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F157A907
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiGSVel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 17:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiGSVek (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 17:34:40 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF752441
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 14:34:39 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JI4vqb006636;
        Tue, 19 Jul 2022 14:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=goIJNaTD6zG7fu+/EsgeR5QaRvI6D20dr2+UIlY7I+Q=;
 b=ERkDssbq7hkhYLI9AUfusEQI1tQqelzyERQ9foPxOft+ax0JyPU0YZ2pCRQkAy6qCuw2
 ya49BeceITbkj94SL0VioXRWjjVXx+XeRA8KmPzgnj9OQq5+kYL/v0IJcGWPobeSGwvW
 gDki52+dS1ZC6Rz2d+GJLhirphvWXiMWHoc= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hdwnabcr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 14:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA26JNLT5W3ISnoQC4/jH2zIC8EGSF9s9niiG4cGWLQlA9mFYxnlWBDnHtC38PgCxzetCFDiOGm/h8Rc2Q9OhO6qcGGCMVkIEW3XWPyC8X+yFRgUlwp0rUoDEOk4mznv5lZxEs91t/+6ioqGip5rlPWu2onsjUZyz5QtC9e8tiZdrk+ui9GUsGuVz5G/Kylz1ox/PiuVi06HvFxBXEX71XhJ0Ew3Wpm11iYDl6/G7F4dL6zEcp2J22iSHPF5tOjxBU36tD/PbpA1RCEQOAsbxcdv77tWtDDP/4X2cZfX2RajNepQSXWHFSjcyry9KY25ursj6Cv5nzRGW3lOe43O7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goIJNaTD6zG7fu+/EsgeR5QaRvI6D20dr2+UIlY7I+Q=;
 b=GgeQPveUmorbfKB03pcKAq86xK6Knbzq8OmKiOFFI1WyTHXYgMArYifKlQmXlNoaBLyN1K6NIAypujmme/W2Mmp+fufEt1+gC4mkx+Zxfebjv6kJzLZfc6l6ysHHQ+T5js2DH+2x+P8RJIa9oFmbUd9mYzh+Dd0dWN2JupN9Z7jVX3/LvWWkiO4MtPJEcrFO7hiO3uI4pGxFyDOHiNRG5n92/CF3NgOwo1InxhizqIt2DrRY4k9/NYMxAx50HPhAgMhwo+KS1Bdlo99EjF6xBgtJiJzVL4OZVkrZjS3+gUU9QFYWBWBWc7z5D1tHsG9bFMiIr3jge/t2iXMDLa0ZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4724.namprd15.prod.outlook.com (2603:10b6:806:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24; Tue, 19 Jul
 2022 21:34:23 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 21:34:22 +0000
Date:   Tue, 19 Jul 2022 14:34:19 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Cleanup check_refcount_ok
Message-ID: <20220719213419.h3u43w5nnjmxch4x@kafai-mbp.dhcp.thefacebook.com>
References: <20220719185853.1650806-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719185853.1650806-1-davemarchevsky@fb.com>
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a35de96e-ae0d-48c8-fc54-08da69ce7216
X-MS-TrafficTypeDiagnostic: SA1PR15MB4724:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTnQ64w+D/zrW8Yrqr++cCM2NU+qzn7l+s8gX7aAp/4zJ+E3Z+3AXkHvnNZnDNMc+dz/AZSeB/iuh9G9o7MoUvXDsnnSBG+K5o+q1DuV75p3HGn9tBgOi9nnjrzw12UkUL+LWHSlZtyVekf4BqvpnuH0B+KWLEVvm03IRBZh2Sid3uBoouPTQkWamPkB063TD5XeUl5xlknUB4LyYofQ/6LGnI07Chig7P+OM3SRa4G7OAxVDBDcCCmE+l6DpXSnqsu3FnACw2ySw5tf49Rz7LyIg2F9YY6XfXtwTIIxkoaKeTsRq3Oq1ID8IY+/OefH3BJGj1tTpjmKn4DCZEZ7ICcxiejb3t9WIf2bz3g9cwGdzvMHMvGRSJptiGKxjunhC9FpvWIdfxh/pqy+tVRDxVN8lWaN92jkWw58fuEE74b/SitRyzQj+hh0hU+GFsB0Vt6QZ4v8CpdYOP/ylyY3a+HONX066m7zcaMTWJ8RIgXKkLNl5JddDerbg5GpWP8ISgPciQSRwUC8X8857KTCafIwA+IXBupCTQpJQ+9zdeFFSnuFYfCjLR0kwrYDgkpke+LLn2vjU0mkuLaWd2oLptViQQmRdM6ZFuHBnDL2eN/pTVZ0oUSqheYgodBVjgwzM8DYkX1JnlsQvqsJtGMqkAbBTkOYw+rgnkpDJdDk0r9xJzgifQup9kIODCle5HUahpjAC3/4y2Fral2ydKmEIRmnUBDVMLBxClaMBqL0gqpAUO4QkGJYuNVqEgCJ/KpcKvKzTzkLVANBPofRyaHBlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(38100700002)(86362001)(478600001)(5660300002)(6862004)(8936002)(41300700001)(316002)(6486002)(6636002)(4326008)(66556008)(186003)(6666004)(66476007)(66946007)(1076003)(83380400001)(54906003)(8676002)(84970400001)(52116002)(6506007)(9686003)(2906002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uDp2k3AuVsjh3pGhY8KVYbVSINDPaqU7w0IloH8f/O16H3Vmf8MccFV4hAkS?=
 =?us-ascii?Q?ALoYQ4GMwK4dkZvAu4vsAMFEYqa1hTN66E/BKPTYRt09Lpcswb77IGNYp73E?=
 =?us-ascii?Q?6NP06kUrItwkZcboLzGv5YrAWlrbz9WTzSRpz8uxNDWsdvEmWlhA0SbhSwLs?=
 =?us-ascii?Q?mxu9BQPgCNYW6SeLCvcMR21QhmZ66a34LF58XdRaLfgd8tt9Pxr82rB/K6ib?=
 =?us-ascii?Q?OLaK/lqkTIcilO22p+Qrtv+xajrCy//XVodRcpZg3+fD7I924rEHnj3/b2uX?=
 =?us-ascii?Q?uuS1CHEx3pz5GcYmM3LGGVOetrLlxwXVJMLUgWqQs6W+xvLhpc2mZHAFKTjT?=
 =?us-ascii?Q?ZSoDI89loxVItwcnjRUvCxsrr1p3oY1rV7imwcYwBefM+KyKCUmu7SEPB/5o?=
 =?us-ascii?Q?ibi8Dt0ORPCN2S09FoknutxXKZ0u6koJo4gRX9caKFDXvU5DIAjJsZZSNc9Q?=
 =?us-ascii?Q?uHS+waJfxt7pQiYO/SZMk3b2FpMxgc3xpxrwojB9tHlPbkUVOSPLiv0+1h5+?=
 =?us-ascii?Q?nvsDn8zNMmus8hFqy5m5bk8Ld7UTvVKMiVyxdhWQxHGjbjQvqkAcmX6+Wjgj?=
 =?us-ascii?Q?+SOhxUkOb+1IjpAJbm7UcFZYAiLDMdYgDQ3Via5XI4XnjPsQerGT9tCNMbS3?=
 =?us-ascii?Q?WWsREBVlfiavvHr3vReQvI6wF/9JJw0/zsKXyFmyHHv81ePMeLMlooWt1FL+?=
 =?us-ascii?Q?nKQLzrCGq6cpUiuyfW9+uhXJig206flkKsFD/zSB0+7w1htZ4IgZ0NnAMsIq?=
 =?us-ascii?Q?MqAbz18CdnLWs81ZW52pW5l81CeMS6Yv9C9Wru5hv+7mYZSW6Ca+eC+zIrJ/?=
 =?us-ascii?Q?+dLykfHU4ldEakN26omq3msKtFpZ9dC1cDxc8NgE5KGA41FOhh8Cqs/eZe44?=
 =?us-ascii?Q?JGCqlnCFm8WA/6Urv+biq9uouOkJ+kfXvwuJmOJ9HLwr9L2U9DOt74oEh7jj?=
 =?us-ascii?Q?zYrXY94ILjn9PxwzISzplNKvIyaZ7w1+SQkng3jscKtXmxwjPIoQ3Xx6gP7v?=
 =?us-ascii?Q?KYhbt/RVcAXrQERFIDImYT0VUnNBFoQ2EMMEDGah96m154nm9f8JBXM8+a0O?=
 =?us-ascii?Q?AB+SH74V0kNSRSuv7wH4ykzul29NRa0XvPlzRcLKFUDkNPhtd9v+KJEV4I0r?=
 =?us-ascii?Q?JpiEG48fvyEN6bPG/IxBoUr2mr9vkfZhEFbsmyEszvmBQt+8hVdkeKz+AuoD?=
 =?us-ascii?Q?C014D/LesYZgM4KS1imhlb7uW0vEJgdrIgsF4lgavPnFv6errbc1eT+GC+HB?=
 =?us-ascii?Q?dtynNYQvkdNLUD5P8D4Qv63UKWsQgh9WOyNKF0il/Dnjl4iBjUzwwhGvRfzs?=
 =?us-ascii?Q?1YPKPJt2NoWg1j6TW470BNtWqtjeyy08LXKAdCdODZLbd7B0CazPKPMhc1ZC?=
 =?us-ascii?Q?v2FLnJ/zp2p6Q6y76Z7e4q/XGgGbgfYlw/sasDG4MVdp8UdH/D00XlCDZWG4?=
 =?us-ascii?Q?mfzFAzUVbT+0v4OfEWUUWob4OqPgg9uwZL9qEApjDTboLJSJaA8gyCZqW/KH?=
 =?us-ascii?Q?DkTGb/rX60koph4FPOgqAwcSqZqstbmHYNYZKxTGFSmuT1Mjl7Tg4Y6uRWR3?=
 =?us-ascii?Q?u1/2Eafel6t49KsfK0ILs/H5WvXdYm7EqHNPCKoE?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35de96e-ae0d-48c8-fc54-08da69ce7216
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 21:34:22.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUeN+sT24WNA9l0iIOf51bjoyRrMj7W1ZRM8mcnYXMKSedAkjOFPfhtK6iM/vdgk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4724
X-Proofpoint-ORIG-GUID: KRwa3Xlw1_3tkbaC5SZsih88Ucs_nH6E
X-Proofpoint-GUID: KRwa3Xlw1_3tkbaC5SZsih88Ucs_nH6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 11:58:53AM -0700, Dave Marchevsky wrote:
> Discussion around a recently-submitted patch provided historical
> context for check_refcount_ok [0]. Specifically, the function and its
> helpers - may_be_acquire_function and arg_type_may_be_refcounted -
> predate the OBJ_RELEASE type flag and the addition of many more helpers
> with acquire/release semantics.
> 
> The purpose of check_refcount_ok is to ensure:
>   1) Helper doesn't have multiple uses of return reg's ref_obj_id
>   2) Helper with release semantics only has one arg needing to be
>   released, since that's tracked using meta->ref_obj_id
> 
> With current verifier, it's safe to remove check_refcount_ok and its
> helpers. Since addition of OBJ_RELEASE type flag, case 2) has been
> handled by the arg_type_is_release check in check_func_arg. To ensure
> case 1) won't result in verifier silently prioritizing one use of
> ref_obj_id, this patch adds a helper_multiple_ref_obj_use check which
> fails loudly if a helper passes > 1 test for use of ref_obj_id.
> 
>   [0]: lore.kernel.org/bpf/20220713234529.4154673-1-davemarchevsky@fb.com
Thanks for the clean up.  Make sense to me.
Please continue to address Joanne's comments.

Acked-by: Martin KaFai Lau <kafai@fb.com>
