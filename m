Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC5C5768E6
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiGOV3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 17:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiGOV3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 17:29:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828278224
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 14:29:32 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKnLSJ012013;
        Fri, 15 Jul 2022 14:29:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nMAfCdIL1abuokgy3gJbqHRv8zMkS1/b6g1XdOTWCG4=;
 b=eQCE/CPFdReDzgtavg5c5B5Z7ayPowDhSo7XTskJUdOSlxeZ7rE7vAjp1lVOilpE3hfo
 WewvuQWogIgeTuIuI2oGu99KDV3cKHSKlInzR/kv6Tld//BWtdJ/0+hyygheG7s9wUlQ
 I3gwqrw0q6BJ3SfcXIKttzd5iUDmk+f6SpQ= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hae0wbv4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 14:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxqinsUYSvi48chFN+SENQ+r+IUkOzansTQ0nxUR7K85RMDn1F5iGY9amP2PqKZObpQpHdiKFUDl1OJkngRoLL82I50Wz0AabFLD+GkSqHsYc6y+NWWxiaIzg7bcBdnt+90T1CnfmjGN6qtRj6OQjna70gy5vj0qfoooH/l7qNV2B+e2uSskbG7Z8EZzMes8i+sKrxIa9b3gMtSPQlha6USQEJk//aGocnV8qB6FRsvqRghjV9DVfsnLHaFGqQU6y2XfP3UBz/cicCqTZt2fAW9/ajQEip8UCAZlrSugL7inaZMTirJ+EI1tlzXFNjmEXQ7Lll64CEk3fjMSId8wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMAfCdIL1abuokgy3gJbqHRv8zMkS1/b6g1XdOTWCG4=;
 b=TDDApUu5eqDunZMyCTnnQDAsPuUExWqZPhluzfL77uhcnFo2fP7oo1iDbpTNNIsa5Znzx6w9HSyZdzTD6OmKE0CbUENrl2gfMWCSn/p97GvdOIXYP/o2nDiTt3XntvyDKxlgOycsnzlGOLs1taleW0lqCOE1Oo4La/wwWxWHbRAigzib8Hwf9DNi1YFHOfJQvymt3ZfAIt1IR3pCnQzRPhV1q2fFyxV77KvA0N9gWQnSCdiBN0IECoByHT9zCiq+55dF2yhfHBt62OYcQAYAZdwl8QZIXJusUeDfqCy9oKlONTf84QZJbfc9uLcPjMk6CZ7Y9vfaC3DjBmhEybfh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BY3PR15MB4833.namprd15.prod.outlook.com (2603:10b6:a03:3b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Fri, 15 Jul
 2022 21:29:15 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5438.020; Fri, 15 Jul 2022
 21:29:15 +0000
Date:   Fri, 15 Jul 2022 14:29:13 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, quentin@isovalent.com,
        andrii@kernel.org, ast@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: fix bpf_skb_pull_data documentation
Message-ID: <20220715212913.wxgysjghjm5roedr@kafai-mbp.dhcp.thefacebook.com>
References: <20220715193800.3940070-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715193800.3940070-1-joannelkoong@gmail.com>
X-ClientProxiedBy: BYAPR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::47) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e49e19f-87e0-4609-8ac7-08da66a91115
X-MS-TrafficTypeDiagnostic: BY3PR15MB4833:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: so8GJdTup9HGJGpvTLs2YuopW1f39aC151d19qDkKqk5ym4yt+pKYUXdHUkuDIMJpx9OLHUOzQviXR3yb/7PKgJhndFjeL8mmukDEn1e/4XjKmkCMC5d/qcos8okvDnDmkH27tBdGVIOt1uJVWJTGgwD/cJzDAMOvtx82SETeNy8FRgyNQaoBNZ39a8GbeMQDfM1pA8Qdn6W4OBjpeHCl+WmDpr05fFBX8GYBNCKwEVbZ+BZoZf4N6XPqKqBwxrXorBpERHzTip7wbc8geOnCzE7AsJ+dd2bhQz59sJjpcCYqL5OaU20tV1166q9TNFZf6yGxtCgSqGA63+hIqrH/2LNryd/VOYnQwExnrR2ZtyxVwOS+oo3HM0Ir/vpEa5ReNscBRXYC5t6ZB6OMUxk/q3mKbJejLWG8rLlEkGbA3kgv1tM1RDN2hvCbmEHY/3SW23rJZtifNwvUV85Mj8yeAy4h2KWk7ik4aB3XNuV4o4Mr/8HInKfOKcgimPxQkb545QbfoSHBbboJ9gD5FMJQJ6yQ2c/e+L1AvTEw+/SwI+ccTXdQUm7XSWHy5YdOvcCjSrfaWXu66Icm1Jznw3kpM9vAn3kbb8/78dOW7m58B16SUvCOHMubonj6p013/acF7uuiIb1vWb//xjJRdpkLT5LjvzMSjLbG/4co3DzmROlbyBluwClbFPwdX4R9ORkD8CeNqwMe61UQBAllafCNlM5eYYoUTKYahCaIQe/TfrtXJ1WZ6xceb4xgsSJmDEE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(4326008)(6916009)(5660300002)(66476007)(66556008)(8936002)(66946007)(1076003)(316002)(6486002)(86362001)(186003)(8676002)(9686003)(38100700002)(478600001)(41300700001)(6512007)(6506007)(558084003)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wHYee56e8YfEh/psQCP/iWzboTKHiFKJgKirSCY4DISGqT1DnP/G6D5ttA3L?=
 =?us-ascii?Q?z/NQwYf+z9lHSbHRmyGZfWWbdUXtXhlKdrOqXg0g2H6zivaCkYClYHNYbXEj?=
 =?us-ascii?Q?hNjfTstEf10aH+35pCN0tIdwqj/hwiORvmQOSMgbenB0AbFvYqcAZHEvgpSE?=
 =?us-ascii?Q?xsZIjca2YWOTFnZVVNOeBWRXcH8j+yiP1TDnpirSGEP91XzjdungHg2w7oEb?=
 =?us-ascii?Q?vjOKsEgUYqlldfTYC7R5CQwvenYNSQSK8xBTOvLTyKJzznevwcKQEZIAnQ+g?=
 =?us-ascii?Q?UfslUxQNIMjVrJtk9iWshq+9+A2hDE/D9Nu8MHqzkjiwqV8KPmcY7/pBRl6+?=
 =?us-ascii?Q?yJDKfpcoPS+rDpB7rV1q7sPJIAqjOazx4wTD1yeuB8wP/BG9mUYN1pxnIvjy?=
 =?us-ascii?Q?0wXlVdfUse6TW8KHiFiBNA9HTmJArGLv9UgQgf3vrZvtksqnAdCNyhX89PK9?=
 =?us-ascii?Q?rN/44/syql80g6Qh7md0dlXjrFtQff2AWwmf1EYz5QCVkPQ2IihM7HHD3+vM?=
 =?us-ascii?Q?PcCm/tMx4q9/U0huWYQTYnrMrH4CdZMGy9uwHRqcvepUGE9sGpbqXNqeML+D?=
 =?us-ascii?Q?u6tXbLb31mFB0a05XWg2SJo1bswr0cEKjWaNpyM2Hi/4AzlAeEM1VuOKa8jh?=
 =?us-ascii?Q?n/H/a+BnXEoNZhh9ajeuf5W452cVR+e5+HZmFW0TSmFsMJx0aryx4AICZEVx?=
 =?us-ascii?Q?rjyCFquhMhITfZ5kqElBUBNFpBf02xUIIYVkTKHlQj+Z9kwjZhTFAoT9EqO5?=
 =?us-ascii?Q?rw1O1p6+OZlaUNyq7/OjPOiKi5mFFdl+e/bFGWvhzVeeVTXR5+jJQz45W6al?=
 =?us-ascii?Q?BLHHy5HNhpKHvf+AQiSCuXunSPHornoH8nUl7ue9znPszR7paU4T8eC17AF0?=
 =?us-ascii?Q?WThkUEuHXCHKnxeKMxq0zlTgW5gpsjWp0Njo5h0ljMP4gpWM2KBj1rkplU/9?=
 =?us-ascii?Q?XwCvJcAKDqkJ0+Zolo34z9epJ5HTvTi1d2d2abil5AB/6FZpOUUIPjuW8BQr?=
 =?us-ascii?Q?v7Do+PQnlyMikxFz1QVj/f8REyZTADJC/+FMeQRzRITCfdAFnJqcOvf7Iqjt?=
 =?us-ascii?Q?J7JxvNdeBqiWgnCB2bvDYGQazkNfJkkv8r2m/kWV0XldQdRwYn5ExS5hshu2?=
 =?us-ascii?Q?oXN55BUzgWfmiCd28daCdCRhF2JH+4k9M0gqZFbkbvHSJNCU/YtQiMRTQuS0?=
 =?us-ascii?Q?A6ZbOfXS/Q5+BwIQGCyASNAQq67E1ccSshhM2Qme/RD/cwWJrcgNraPkbQq6?=
 =?us-ascii?Q?moO0pOTHYpclBUbXlT4vDtRGloDbsiCxHJmvCRRUMSkacIUggVtodHyvHR0X?=
 =?us-ascii?Q?qybNQtqlJlpp0xzHHUJu+j4+P7LtBfKHwqBb1OtpEsIg9jPUbEk9D7mG+7HT?=
 =?us-ascii?Q?AxoqQEqhwHEYwtqwzaxHMT/IGoRMbq6IdZk60IqUsz3K2Ji9cmmKQJV0ON3M?=
 =?us-ascii?Q?sDNNA4SBE0EI725QaVAmBsr8r+0DcKK91VHavh/nm0zJIN8d9qyofzBujdW5?=
 =?us-ascii?Q?can7GLy6mw8JcssOlhBVz76g7Hh37v8ryZQuEgjzuKYlIRUAyicIdz/1i5vx?=
 =?us-ascii?Q?CVXgYLi68tpMfR3CUeYhPv0UU7kcdnYNjsaMtBhdDQMNogUlOp6DVRHcodRV?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e49e19f-87e0-4609-8ac7-08da66a91115
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 21:29:14.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmitjwPf1jQmchQe2Di+RniH+iOEH/g2FjX2lVzee0w8NKyC1d6d2furEZ701nEW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4833
X-Proofpoint-GUID: qCzGjklmb8WaoYrau5N9yH5ImrXdNPLN
X-Proofpoint-ORIG-GUID: qCzGjklmb8WaoYrau5N9yH5ImrXdNPLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_13,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 12:38:00PM -0700, Joanne Koong wrote:
> Fix documentation for bpf_skb_pull_data() helper for
> when len == 0.
Acked-by: Martin KaFai Lau <kafai@fb.com>
