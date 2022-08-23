Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B22A59EF87
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 01:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiHWW7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiHWW7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:59:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF42C64C
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:59:48 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27NMUMWJ018489;
        Tue, 23 Aug 2022 15:59:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zQuA0nYMTCv1je5GdnxOhfIFRG6bvPMvzsjFQFamtys=;
 b=Tl9TJinjrAqknuGJz03F6wVAkRn3SNwzn3fdPARLwUcEnmso/7PE7dwdA31pyEFq8p+M
 7BfKEYkStxjy5CbMo+nz4QIpnNFbCaaLWMPl2JL1KJ6HTZOEsRCzxCTfJ1VfgxnhsGFR
 KkItLcRnzJ9KzR58SpX8wHWF4fDJwQVAez8= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j4x6vmqv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 15:59:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1aJlURdSIB0i19a3v4FqAIik+TQ/p0B87pFRqLcmOR+d+SDMVEezNQKUtz4C6FWZAH7dR/KK457TH3C/c/EHld7acVoQQqM723h59FfUBYlbzR2yeVCObVmElETGH5MA/XiDvLgGVTtbrVtzQw6+E32jlljsBdkLFKz2+2sGvB8k0U5OHVaNrAmAdiQMKiTiud9I7f61lTQlbg0Gvjij85GPJQihx2l6mJIrjUxDjySRQIHp2gK/7N1qKyQr4rBxmi6t3cPxyd7YNdwoL5Y9U1ryAk73xbzDHX6/tAVFWydW9QGUBraotVR+Kt3gIVrUdJYDLnTMFswL2oM+mjRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQuA0nYMTCv1je5GdnxOhfIFRG6bvPMvzsjFQFamtys=;
 b=e2DIc9XiAtIsogdOZmiz+SgaRgKTv37oFPctyGNffc1uWZc4MKZUoD3lk3fTiDrcY6sO3tm9Aeg4m84IGlcl37zvZb6FpGAIsqznqGPrUe+UyDnb5O7GXhIaXFGy4MNDizOMLby+eKamOPFsc3Xe7Lm+EklXrsER8iYDvXoQmUdTNstTUO65p8nRc36CiiXKIv9xp779RESq2d2tUpNiwc0B3OLo2sN7hhr4QfvgCblEgGj9KKox0P8lE7Ha4Oiyw8b1yiE2t9K0d90csgaWbFlqxzDGmzm0IgJHFKmdHvO0HnNmm0s/AlW1Jn1dRGcokh+3xt/ELDMdPbN1D7DCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB4106.namprd15.prod.outlook.com (2603:10b6:5:c6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 22:59:23 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 22:59:23 +0000
Date:   Tue, 23 Aug 2022 15:59:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Introduce
 cgroup_{common,current}_func_proto
Message-ID: <20220823225921.upbdd5rrbel4dadn@kafai-mbp>
References: <20220823222555.523590-1-sdf@google.com>
 <20220823222555.523590-2-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823222555.523590-2-sdf@google.com>
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb7f585-329f-4466-e67c-08da855b1ece
X-MS-TrafficTypeDiagnostic: DM6PR15MB4106:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLFRSp/Qekjv1oie9tLDYWVpf5mzQ+pifyAmOfs5KqFl0CQNIjW4c5cLuP1tekY0WHdqT6lxHrU6Ni8A5Zmt9ioqhpS818iZQgDhrf5D2K0nD1HArevkJUw85imb0ixdTNyBorRhkrofFzXsdaksZ6RyTotPSchXP9nxNRaI1NTN6/FUhV9rxNBcxaW7MtPildMrl6sulDB18HDwU2qxPzqIcCM8OwfKSP1sstcQdw8iSIrgx3ZY77Bejf0sTVXT0+JPIBAsFzIYUBk51spChsj5/Dz6V8rEXsH5HR0UpEDBa1D0pccu8Zj4O9Fa3VY5HS4jWorzCpHVZBRp2QOKmLXH+WH/fyqt3EnrRxZBWfMTVFhgezVOwGyMwNqpPIXB+wYnCtw+wCbwrCkao3CiNlZkoJSFG511LMSiKR9NMqjYzxBcTfEX8PKDgefucKMC+UxUElfWFwLSTAC7Z77j/M68w3KD76Zzh/wqDMel9q8xv6H2kKIdtT692bu6CbKtBqafJS22o02bsbzvCVUD873aEzS0Bkuu0pZqCOaUH3EHitYda24xa5CeDwS2wipmcetYvhwOSP3Q/WV9DlCGuHbzF82TqdG6NGvayL01M5TtEvKQieKo+EG8YBwd7ctWtmd6r7IPUBrXARhVAvsAdwN21lXA7CeTjENjN+2CV1aa+P51QzbenzShZ9KhwjNcUV/5eXnOo46ztebkmqkFAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(4326008)(8676002)(66556008)(66946007)(66476007)(86362001)(33716001)(6916009)(316002)(83380400001)(1076003)(186003)(478600001)(38100700002)(6506007)(52116002)(6486002)(6512007)(9686003)(41300700001)(2906002)(7416002)(5660300002)(4744005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TkuKB7vJJK0d//SFNBe4Nx+i+KuVdUoeO+6BxY08DsDrz1J0SMCM5ZqO3qjb?=
 =?us-ascii?Q?NapuPsFg5Cihi743orEINp1TtT71StEhyA4R1RBJ8MG1G4R11P0vZujFsz3S?=
 =?us-ascii?Q?MB57On6z2N8bfTBQ/iSXRBHNzClxjU4+hRMJOeWBHOYQ9cNouPHirtlowIIZ?=
 =?us-ascii?Q?VS9V36KBiuDoTnZ2DlTfRe5Gtx8ijGsobYZaItxyL9Sf0rlGc8waD/LPoTuf?=
 =?us-ascii?Q?a+3GRYK1LjcmGjho/FuW/apn2bOkHOkAqFRChvGgb58w4f7Vvv/P1OA72Tcj?=
 =?us-ascii?Q?tEaHFzuXYW8DYYJRZ8996BtZ79z+layduvnr3QQpE8xiD8tjFryTLPoXIOyY?=
 =?us-ascii?Q?gkZftUeYExPlg19cuPh2AgXX+dVBBLQUwbsrkFshwftCDE3rkvTh7tnERKEA?=
 =?us-ascii?Q?IfReVvUQkVylhMNWkgMUVcsEPPJyj2XOItCoUDw14tyTGvY8/8t2TPY7P1lN?=
 =?us-ascii?Q?ypBUQf/E9m2IPfIsaavyoIqVxaO/9UKjJRUoIjVpuga4h96kh8W5NPIAZ4iR?=
 =?us-ascii?Q?9/BxxCFj3BhwQct4ry+RhAb+WcYCYUw8rFE1qX6PbUU6sgE49Hl42mZ/1wHP?=
 =?us-ascii?Q?lxT53D/tsfsOcmaCCfRTbTyQpeImFs/XjbUjznRI7af/1zYzEUs1P5jFUdGt?=
 =?us-ascii?Q?Dkldh7TSq01GgMAhaLFz5hhW9sbO7AaqYJEX/9werVteW71ESNoHdZ+gZp1J?=
 =?us-ascii?Q?YBx1Wpua8dA2nmViluigLDNJaAhZLqGjytFWnTNem/09MHzGgLjp6oR658NB?=
 =?us-ascii?Q?Rq4V8Yp2jirOwEppzS6j2RTEAtLEE/jrY/vszd/OysxXV7HUvifqrCaUshNy?=
 =?us-ascii?Q?hi/cau5qPPFvEvI1ny4yPtccQiu7ThXBYHhxE+SsAQ+xC/dWBy5dw/HXQNhk?=
 =?us-ascii?Q?SLwTln+9RwcBgkwAbNIB3FzEGATUfVKak3tS46pyCJCDrPx4hUWpCYdeRZ6n?=
 =?us-ascii?Q?SH6xVGii1NR6u7SgjJuemA7tXqri+sZOflMUPFT6RqG5C1c3yULUyiErC5Qp?=
 =?us-ascii?Q?BBMdXrgIYqOPtnr/YQyi/uauYGBQ04BSHqJWKziYXI+Dp+EwQnQMPd2oC4Ei?=
 =?us-ascii?Q?rf2hb9uRpp+LLqeH6yqmARNOE+8VSaNa6ThqQ6CHLufLC6+KevQHg+NL0ztz?=
 =?us-ascii?Q?UJCM9icU3rxaUgBldueZ7enePJyk7IzUj3UAcl7Px88LtSjAZi323AXBkJpM?=
 =?us-ascii?Q?yTuQQ8TqazI6PlLUiIiUJUMHkV+R8Vxkb7FM761BENqF8oj9ak+vLIPys9qL?=
 =?us-ascii?Q?Sa97fqnsYwH/NHbhIpYC3ybRUlDifa3sV276HcxkzvdC0qB1jIj2D6GDL4iB?=
 =?us-ascii?Q?F3k613AqtUoNyIYCSWTqAKUqQHH8YY4R3PpGt7HQeoC9uHt3+9lW6EBkaJAj?=
 =?us-ascii?Q?MGfmlcvYA/CmYQflpUoVqDt8BfAGiJsWiG7oGUEySbfu4t2TO0eVVYp/Wflk?=
 =?us-ascii?Q?skd7chnwwiY30Xt+i12ixpS7H9V+6Mhe2lDMQUdMJImU40uS8HQKE9r5KgXu?=
 =?us-ascii?Q?U3U64I4sJBZ83FBPj+DMjZye52oiH8lld1mn8YMVuHrL75aYn9wm1T7mpwbO?=
 =?us-ascii?Q?/n/CaecgKRk6wL3GjWF6JEnA98Z2OR9lLnqADvVyMdOay+0C65vkvaL4LfK2?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb7f585-329f-4466-e67c-08da855b1ece
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 22:59:23.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6hogHQOc1rZmrLpn5cQUJ+CA/oxjhRF0Mc2PVN1h8lgRIT8kgAoL8LZLINOG/zK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4106
X-Proofpoint-ORIG-GUID: EGW2H0OLcRJQbUMxg36n2YDjw0QTvH5v
X-Proofpoint-GUID: EGW2H0OLcRJQbUMxg36n2YDjw0QTvH5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_09,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:51PM -0700, Stanislav Fomichev wrote:
> Split cgroup_base_func_proto into the following:
> 
> * cgroup_common_func_proto - common helpers for all cgroup hooks
> * cgroup_current_func_proto - common helpers for all cgroup hooks
>   running in the process context (== have meaningful 'current').
> 
> Move bpf_{g,s}et_retval and other cgroup-related helpers into
> kernel/bpf/cgroup.c so they closer to where they are being used.
Acked-by: Martin KaFai Lau <kafai@fb.com>
