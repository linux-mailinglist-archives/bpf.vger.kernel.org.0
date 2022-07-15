Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E748B5768E2
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiGOV2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 17:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiGOV2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 17:28:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325AA1A2
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 14:28:45 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKnKFH011956;
        Fri, 15 Jul 2022 14:28:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=VqJn7UejNjVKrpp50aZN010IOsJcqKmNniAlGdhxyD0=;
 b=lm7dncJd2hYa2IalOiiQQ1eYrqyK1Bv/t/w+1OdDwKvjUYn23tsnZDd4L+jWMsyb5/Gm
 K3ZtMWlsgatvkZNKzNzDrKtW963G1jx+dTqRe4Qnxse+PooWGzzOhp4qxLP0jdlUpKIR
 eoPTpEEHnWgkFMdQrso3mLytLpBOnMbUDaQ= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hae0wbuyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 14:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8uEFrafp/T3IlS1YiUxGEQmVx9kmlFgOoRvfVP3FBWCvjoe7rVPyPrbfQfBmwlYFj+ogj6sh98/0I/BHlAhSd80qgeixBwsroDfr/RbU5AFzDHdR1unlPVUBe5X5X2i/MqpVvNlCCebZ8Nk73SE/yQJfJIvN42cyhyqYy/EJlhNNjhCZv96aGJmrX6/AshqFBPRVgOe+m6XEZRuWakhPGqGZ2DlRi+lcAynoYK3A1R6r23HKTBEBKSa85NaS8eEnn/7yoq1iMxseHhFXiwz62YUjPnS8JdpfUoLJMiFOYLo+bue8phOx/Ae3bdg0Bgd06SCBwLUV6gFRSTdtsgTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqJn7UejNjVKrpp50aZN010IOsJcqKmNniAlGdhxyD0=;
 b=mu3O31jDtCKAERRBPwog9C97CBx9R83dAhXj0aZUgQWGr+WjR6iXeq1MkIaMC/k+/DSPyxXWny27GPOhUqucVPBllM92BUROD87XLeZ2w7Nr0yChFAaEn+NBIp/yrJIHW2dKwfs6ukiORQjwo1iLALs1pRwIOOBrw3C3wk07LGLtFWW60rs6wuh1iHmRIMe03vwsjNYRQBwzu3DCK9755o9vkklTzSteiKu/eCDY4Gj2AgBObzbATx/APdq5rx9Xi0DhGfzFWvj6j35cMtig41nOYpAcX4u4iV9t+71SIWG9V0pvDIdJlI8lw/O8lIa2Mtg9dh7mBjwbK7Z5ioNAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BY3PR15MB4833.namprd15.prod.outlook.com (2603:10b6:a03:3b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Fri, 15 Jul
 2022 21:28:40 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5438.020; Fri, 15 Jul 2022
 21:28:40 +0000
Date:   Fri, 15 Jul 2022 14:28:37 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Indu Bhagat <indu.bhagat@oracle.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com, andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf-next v3] docs/bpf: Update documentation for
 BTF_KIND_FUNC
Message-ID: <20220715212837.q7vz2e3egeq7pegn@kafai-mbp.dhcp.thefacebook.com>
References: <20220714223310.1140097-1-indu.bhagat@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714223310.1140097-1-indu.bhagat@oracle.com>
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415cb0f3-0496-4ce5-2726-08da66a8fc47
X-MS-TrafficTypeDiagnostic: BY3PR15MB4833:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90WfCxLi+LbvJYHlKwlQAxrNNM4UoqvUxndZfY0axRrGi3iqTUceq2Bdv90ZPoRu7XSdjQRWnPDGi5VM7bqyZ54MgqhdlDrzawFap4G7n34EIRrVJ0LI4oHTQNClh/pWu95QEwnT9Qo1TFJdpBO+J4sJ1cDPZpXVsZ8ybNenDCGqXQzPOL827zB+Xi4vRoy/YkhrcF3ANCC7kgvzQIk5/QOcyTTvkFaDZxi85rHFoUBz5kp5ROZsqtWLsNgcNUcyHoAsaJqFWaZa/R3aH10PTy8gBMxHaCKqoIfx3qbIW2rC9DeNdnAeu6gXeMcE06oXyWcS4dRjvK9/XY3YnYvRk4J667gAOQXhSqAxEY0vFYSaFuJ0ke5jg3mOd20BFzD+f8MSEQYVwhsE1p1Cc6IaCcehOSk15DhkKWvvW39tKiUw9gUoT0MYoIjBjonPU+d7/iLPqNR5qsUlwgBemrtauxh+4ZV17sT5OMnqyG22sx/8Qvr1ctOLsE/EAfC+oDUrOKTPZHH3zdwFXCHDnEVvymmjJUP7bLQAM7PV6+A6NKOfOc6QM94quNWLXfEE+EnoJl27a/GFXDAhGPca6/0WB/rHcVJJr79a+wY7MHRQeLxUzwU1i3+Te5u1ITGIWKOcpXY208M8J5UWdMy5Go7BR1I7lGRv95O5WY49t8NPr7np8Y+uAGi3c1OBDqlC923N+Y7fP0GBcUbUybd0vZXleRRdfareDmV5Ls+to/Ufkr1BPsQU+ODIcdR4oLIIiT/7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(4326008)(6916009)(5660300002)(66476007)(66556008)(8936002)(66946007)(1076003)(316002)(6486002)(86362001)(186003)(8676002)(9686003)(38100700002)(478600001)(6666004)(41300700001)(6512007)(6506007)(52116002)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgor6Gitku8Qe0rghlpzqV9lKicAO0/v3Wrx0k539JmWuggA934OionHxU6G?=
 =?us-ascii?Q?oLQfC5xrAXtAsJFnlcUcdErOZUu/+Iyvxh/CzR0MgfKhkYJB1ekJnkwcLujH?=
 =?us-ascii?Q?kgqdSZ3QxEAvHnQ5TbV4OBrC2qoEMNA+zeEQLr7iIe8Nj312IKC5vIjQjYmv?=
 =?us-ascii?Q?EGM0mm6wnJLjCs9omMh35HkAzCn1IpVKKAnEn6audY9gzefazioOA8799Kht?=
 =?us-ascii?Q?ZHqLmcVWA+iodxf3iFyn9cdLOhBTVC4YuoLhVpk+QOETki3DC7VjImx1GIOW?=
 =?us-ascii?Q?rSuNoN4fWhvAWymt2rhsH51CganzZwFOi9BMilqKxwfCmQ/j73Jy8CEWusqG?=
 =?us-ascii?Q?bvxxPl5sD1nqKX3BuJmi3wG5KE3A1Oqhck+2OW18KukdLwgsgQ3FKtCFFhNx?=
 =?us-ascii?Q?R+R5Qe/zGkGOWGrzSTDTO/4OlzR1m6XUZ1vhmqfvEsAN9UHu1WOHwQgMYFrW?=
 =?us-ascii?Q?LrVa5/nakrhJYvfOXP4wS6LaQViAi5oOsgPfKBb5w/iIQv5lR/Wm4FF9jV53?=
 =?us-ascii?Q?FNmc+1fhZ/ETpsxJ83L+Jodio3opYNo8ywnGAvQxJvr3tYyA1reA1I8Kwrge?=
 =?us-ascii?Q?txE+4wn9jesOD4xktg4f5WqsgTs3XMP5RwB9PAWLD11AGfbhl9ceDtupka8I?=
 =?us-ascii?Q?k2CTEkiTI99bkQ6kFyXk7wJk6LHSU4CyZhlr/tYhu80rmWW9bMmVEc0yPIUl?=
 =?us-ascii?Q?Ij8Gu5Wc5F7aBcIlUwOOUM9zaaX84wHOqVCGKloHWAzuWRTm3c7wMJp7VI8F?=
 =?us-ascii?Q?wKABMoYO2O9QA8GzYm/6kk8vKXizvWAqGr+RWptyXz2uJRE1iXJS00H+BfWO?=
 =?us-ascii?Q?WTNvtPnopGgh4AoLpgS6GHjnsUwjtNhk33DEe0S3cV+UrnUvMBxbihkEUCNn?=
 =?us-ascii?Q?4gvRPJC6xw50Pc6pjsKQ1NLIPATpUC3f+owuHFVF1blBlHVACvlG2sKydMky?=
 =?us-ascii?Q?c6tv1AlH/oTOMlQ6RBpLqdFWY8WqyqKXufYs7H++YZ63kCpkhsEY3780zWND?=
 =?us-ascii?Q?Ac+hsLOiE9zy7c1KGT1LzeDWpT6DeVWf6GBgXsN4Q4MntJ0SpBGICOx28+DB?=
 =?us-ascii?Q?8ocoMiqxWCq/dpsDAjK511+TKeTAg9OZKK6xjPmLNnr9A17RaIW4mmJ0254Y?=
 =?us-ascii?Q?Cu2QlwYRosaFngsZSa2ywRPerzgcqfB2caQQ96nS3/fdiWs0C1HTmYYvSC3A?=
 =?us-ascii?Q?BbGddW0/LFX83ZDdf2zug30EL6LHamz6JXdvzqz8fZhKglZULpXnGquz+lNQ?=
 =?us-ascii?Q?47YrWsRFtQ8Ilawu3uzaqSjq0vgxa4HffX0Nm/FXntA4e++G63DONDrqdEpp?=
 =?us-ascii?Q?bDmlU2Oe5lRIGPm5zEsAk3ReUXqgxfZs7q3zQF/Z9PK0M4pyQq8ikCy2ClcX?=
 =?us-ascii?Q?//IgYXVPYZT5fX7TfpFEgy3OSfJiw0mPibw9IoKlFUxKI8vOXch8v7xmQ9fQ?=
 =?us-ascii?Q?L+To+9dLu3Ysd+QSITdNkf6w2xlfNybfXIp3qdWfifOac70C2FndEkGD7FNZ?=
 =?us-ascii?Q?WuD/rfbYDgyaKQqCrRgo5QRkpy37qg8edfZxwL379n4tHsqfCBN/+mDRE1tJ?=
 =?us-ascii?Q?Jt3dCKYwxeIADrQr9xGTsVfLxop3iJl4N6FKkL8ZEqrHqG04dODCHCFAYYJS?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415cb0f3-0496-4ce5-2726-08da66a8fc47
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 21:28:40.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hfm7NyatyVEzwjQbl3J+h+bX6gDFTyJ5irDaF5u9AaFf7N06nKpIcYA0o7CWTJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4833
X-Proofpoint-GUID: osXLYUlJRIHDGsK8qToR6Jog5E0J8En4
X-Proofpoint-ORIG-GUID: osXLYUlJRIHDGsK8qToR6Jog5E0J8En4
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

On Thu, Jul 14, 2022 at 03:33:10PM -0700, Indu Bhagat wrote:
> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
> linkage information for functions. The Linux kernel only supports
> linkage values of BTF_FUNC_STATIC and BTF_FUNC_GLOBAL at this time.
Acked-by: Martin KaFai Lau <kafai@fb.com>
