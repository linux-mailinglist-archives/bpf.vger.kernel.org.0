Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B775528F0
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 03:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiFUBVP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 21:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFUBVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 21:21:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D236634B
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 18:21:13 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25L1LBL1009177;
        Mon, 20 Jun 2022 18:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MVE2Xzs0KKex54fRrrhUG7UoZOx70pUGad74TgTH0Ts=;
 b=Ci4+M1j8zHs3wgACYixxA49/2/nBJGFrxl0xhvu7yizIsNCrhGcO86THCjy6/Vwncl6z
 V8+pLtEIcKaDYiOh7oy8V7TLFegt/ecsjl4eP9keOZa7BhU0zReg3P7thDUmUtjxHsGw
 XX6VRbQJkkhF2KeCFhGk2+FbPdXSaFsOUCg= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gsacvw1d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 18:21:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9rEeAizOsFGXbg1PUM1kFmcYj2fLmN6zKLQn4NEf85DNchlweOlMe4qOgw9m6vQm4jN5ko5u4MHw2n5PVaq6Nv7dAEaXJr91rMr+vf8zoje2LX7A9cAyFk76KiU/CrFF5Ly3051Rb/7QMBiGL8dXVBFIPKsNBp/naG5MBaxM6zDccfRpYEDaY7flfbOmt48p0Gn/hNSh0OBORtz1mrBQiOM/wFSBxQTdQpJcUEUS5PGl5IyHKpElxvfNPSE2WmKNTLV2CDOBbGuKH2jY8MJc1PENTuj1B9OWIfK+HGgm0ZZBDQQwBVY3eapr++pbyuHDtS4jlCBtpVp6XVhs4bjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVE2Xzs0KKex54fRrrhUG7UoZOx70pUGad74TgTH0Ts=;
 b=TbM9KDO344b4ZCCJV+EZIpIcaQ+1HcFQvgAba3/BxzB+7KGaLK5hWkzRPhOpuxZ5c/q6kUCRIk3hbjZ/57bVEWK3Vnphb5xyUzr4kacBPuOSjXpncTFgl2y8RRqZeitSHSMGl7m0xUAt/J1yXpJFCSjT0MrzL1qCCsFFpb1p/lY1ks9gNegP76c/EPyMbSvGrySY3VA5ySSmSRAU0LEuM93XY/YvNUC7aodgOMRncREjnDbId5/donF8xvn7EDFq1IG1Fp6EA906YAYVuVq1nwlBKYSRmqw6uM3NR+4ecWYm+TrLJk5Z0nAdZ8exbhPH6QLa/OJX2rDc9cSkfDcl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN6PR15MB1140.namprd15.prod.outlook.com (2603:10b6:404:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 01:20:42 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:20:42 +0000
Date:   Mon, 20 Jun 2022 18:20:40 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Andrey Ignatov <rdna@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: scope id field in bpf_sock_addr
Message-ID: <20220621012040.7tdjpw5jno3mv5l2@kafai-mbp>
References: <CAFnufp2KL-qNyDtWH5cNQ4DARqSQAygSi9GXgHD-iWs0XzJMcw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp2KL-qNyDtWH5cNQ4DARqSQAygSi9GXgHD-iWs0XzJMcw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f31e569c-0185-4c7d-5fe6-08da53244253
X-MS-TrafficTypeDiagnostic: BN6PR15MB1140:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB1140B464F0384C5A57687130D5B39@BN6PR15MB1140.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iR2AeMLqVH6EhfNPSMYR0Km3m0h316+qKUQeSrq3SGvTkvm5GaCvzKeGUoRA4fwU3Zx6aUOaimS4sTWBtvxiZtPQI74GKBVVKo8JTYMxv8NzaMqCkto6rWyjoF+ex27hMmr1TZfUgmhuSrP+FiXgGoULQNo80o2QNlCobSjotRXVD8rGXPUaUFVVTiRrK3FcNWkxOA1Yij+5opaXuCZajfP021Kr/z2NDVkTwZyQEhzfoNL+0+h9nSiQIc0VabRV0jQzQeZLuuQcDR+NK3Mc8SgqLlhuAbqWWoYv1LA1UVdmQlnGoLTPltVBNI3fNKatUKwQcu0sIC8ETyUofHxG2cv4b2NXCwRZcN7NttQc3G9WTp1gg3QpjvmPszIt8Z8kNpvW0hPNItGGxx785+U51jjPtdKMA4sx6KMuqhn0PTEXheXzQ3qav6RjJwQ2TjoHNi88aKhOAQMIvGqJWST/HduyGfSG+WTWfXTa2wX6tMd06Lg/6k2P9doz8R7WePvMamqtnlIHBgIeff+8Ynv8n3W8QBNrvS6Wc4R0H5YZQVNSOjNepkFgjkZSo18Iw6Pw1BppNmvlsUz/LevC+MsoKi8VEsTPWq1oPlhWMkgOIE86HbUChnnoOpGHkP1TfX0mlQP9VxSiMTVMul9VZGlY0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(39860400002)(366004)(346002)(136003)(376002)(6916009)(66946007)(54906003)(66556008)(478600001)(316002)(2906002)(1076003)(5660300002)(4744005)(6506007)(52116002)(9686003)(41300700001)(6512007)(8936002)(66476007)(4326008)(8676002)(86362001)(83380400001)(33716001)(186003)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D0vf3rjQsuKugZvyIsCdQZAdUGw3q6g8Lx7TW0FjCKGMnjJdVfs2moh8m3P3?=
 =?us-ascii?Q?Re9WzQkTrHbgh3a5kKWeFZBmY/ULMAntf2pGbmPjFJ5M+FFYoyBZG1duy/96?=
 =?us-ascii?Q?uRj9uDBbNwAtZapZj2dzJrjlCw+Zvi/b0ZNrxsiEe/oyDvxPnygcEmCubcJ6?=
 =?us-ascii?Q?sK9oguwVjLXlhNoS5wFhzu8BBMjBuAGXKPnhY0x3PmUje2sNSZNXn4Y14QZA?=
 =?us-ascii?Q?QP+O2ITF5GQY61NNCTSGeuedEG5bAfLKs9duFIi0fnMumlU4fUr1mQ2uE7KG?=
 =?us-ascii?Q?GLSw4RW+Q6SwgN6N+Ehp4P5/YcQbbYVPzHEBRgN95VPbOFfcMsDyjHWz9TKw?=
 =?us-ascii?Q?T8bvheafPjxvXMy1h9R/Vwe93ewE8QeVDBaKFzgkWYlr5iGKqINJpnrIEnkd?=
 =?us-ascii?Q?shqge3ZWgBNzcBcps+SLg8fIhQwbFx/O8H+rL9O8/oqp3I2mSQr5AM8LBivB?=
 =?us-ascii?Q?fhQAu1ROz04wlomTB/pDjTgIU6pat1gkUYtNN0wpfFWZA9wNgr3dT+xAHUEK?=
 =?us-ascii?Q?4XEdw/+rISUelbgvT9icIqkP6XEyaTkGHYxncC+JSdfc2b76XJjKcUdjILWW?=
 =?us-ascii?Q?WWQYy4uDuTQgs0i0TwZUGm+ILcBTFbzdgf6UMmzH4oXYywb3jP4QQBIzJ9Oc?=
 =?us-ascii?Q?flLtUH2jdGEwyD4yq0ucKfce+o5YYHh9zyRWYXXIC0qGkdyHOejUGBKJNQ/R?=
 =?us-ascii?Q?+F/x1LXHhWndbR/1NFnZbYyWvooKRvJW66fhA0C4s5kXRk4VJ2xqh1a1Ue9m?=
 =?us-ascii?Q?qiUOTPyGNSxlGwl6VOpWH1WdROmsebuxKElVJ7fi1/GbARMIy2p46YhtKPus?=
 =?us-ascii?Q?TiLvO57/D9/+pWUQNmkASgPFBbhJS2SWFnxfTRpaulIZAGX88d8af7eAc6wY?=
 =?us-ascii?Q?cWpCTD4Nw4MD0C+VjilHfRD8PnyHmOufadjQu1H5ciR5t2+pqOagYHJ5W4CJ?=
 =?us-ascii?Q?3RC762optnSY7/7ORoKGufLytoN5Kv9oF/seqMNwoE2DaFLueT1td1I5AbnG?=
 =?us-ascii?Q?XZsUqi/+6VG3xovc+UACJWX9Ygi4k8sp97jtoOoYeAJn/AQ7g1C+Cld28HTb?=
 =?us-ascii?Q?Uw5ZkaEDgD7EMbemP485846cjGNt5qn1fBRnkD5CtoedqmkCZuf2Zo1xfHwn?=
 =?us-ascii?Q?tYl9guJkjqc2DJx7Whp2T8nysL8ll7qjsnFO7Br2cIDdObuA4gzpxtKlaz/y?=
 =?us-ascii?Q?COPFriPtEEvI8URLK56tAxbRCN+bMvnrJUJVHeFD+HqhAHHc8q5WLqgUrWAS?=
 =?us-ascii?Q?Bdi9tEsBpbXciZyID5wSKC15JtJHY+byjVt3+zY4o+C/zNq4CP8job8UTtRw?=
 =?us-ascii?Q?gadf7MUzbm+G38ZHmpuDCBnERBtVT7aHQWLYTgosmLQKLAB39fzZEVuWiQjH?=
 =?us-ascii?Q?NEfEO/2NPNh70aS/EPMfPOY6xyOSIlM7l4XNS0ZvfzMjKYyYfPglfWSrJA3/?=
 =?us-ascii?Q?0g325uKtFo9+HYMBeEQXmbTYiVv9fjQ3Y9AKLA+62u2dLrYk7404Bfw+OiCF?=
 =?us-ascii?Q?l1z1DIctPhQ/7OfFkgKiyz7cd13xvjEKzbnURljbKNzX4t94NP12RHFAzWW2?=
 =?us-ascii?Q?4aBWAeVDlQjxd/x99oeAgNoai8HKd66S5yPAZjyAorIbnLI3ZDYSjYAwboFF?=
 =?us-ascii?Q?cXNyR4zYl9nNDvI1MwOgTIE+rEsO+mVtcYaLBWVhQesm74gaWbXJZziqGDnK?=
 =?us-ascii?Q?/rqf4HDC0+5H17+oWPNJ1naF0NW0SodFY51i5cXainQZaeyTJktC5lvxsHsI?=
 =?us-ascii?Q?qYTk/C5BHIqSaRlaVP0GCTcDm7JHWcU=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31e569c-0185-4c7d-5fe6-08da53244253
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 01:20:42.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPvYgxMJOjvDi1cOexHY3y7/sqFGdwicd9U2vfOyXUXdHvyoSU4FoEKJtmiR/T1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1140
X-Proofpoint-ORIG-GUID: Hk-DDPkba_V4PUbR0THpiX634zvApujg
X-Proofpoint-GUID: Hk-DDPkba_V4PUbR0THpiX634zvApujg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_06,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 06:11:11PM +0200, Matteo Croce wrote:
> Hi,
> 
> I wonder why struct bpf_sock_addr doesn't contain the sin6_scope_id as
> in struct sockaddr_in6.
> A program with type like BPF_PROG_TYPE_CGROUP_SOCK_ADDR might want to
> access that field.
I think usually there was no use case?
Do you need to read from it or write to it?
You can try to extend it.  Take a look at sock_addr_is_valid_access()
and sock_addr_convert_ctx_access().
