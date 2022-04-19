Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A901C507A6A
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbiDSToX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiDSToW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 15:44:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36E403E1
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:41:39 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23JGdpoj024277;
        Tue, 19 Apr 2022 12:41:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EWrLZ0NGXQLsIfRp7NrEX6FQy62MWSnlqm+7H6DukrA=;
 b=rhkVdIKijnMxxUK1qvqw7ciUW1uw5ZE0NwIZYXE3rEycltLd5GUdEf3gpCqAtd3R73+E
 3gP87F1UeJxSsdeuUi27lYFSdJi+r24pW4GqKST8gxPGKKR1RNlavzsCe86Em6aYIhy3
 7DsKJtZy7Lp1oog0C/tRhbVxBXCeLIYFuMQ= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fhn4vn76u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 12:41:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlXajPstzVX1XAFhAJ9sMImI/NgPSiZjiPqJaWhjntBGQi/Dmr2mODDZnX8HpwmVEVjlvezngdyf7KnZNLIDsiZjFqQiVvyYHYzwSp4KhBVjB3Vtixvm9jOX7KTHKGYQVN7p5yRtgXca5QOci/aKNLJUz83e5oJQTX2eteoh+js9mFK0FJU2cA9nHOHJTjsosgMpoNEIjOI7zXws2zJR0sj0K6igp1vzBD12Jr0osrJUJX/gq6CuYSL+dvORfh+gIHwoIqtw7bzfaiskenkihzyVR5eYKmT5pirmpKwmrSw/s0x8tqvUvdnGnqmdOnp1xox51IjkQask1yFu5KPyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWrLZ0NGXQLsIfRp7NrEX6FQy62MWSnlqm+7H6DukrA=;
 b=dBYniLS3mbt8injy3I2osJUua1Lz+wkghvjdo0cyJUbh6cWYWGaAbnVZJ4Xwp9XxFgnz7kS8LWXv6+zKpAqvnXmUghUUxSrWtvtrY3AdQWuoyQVvExDWhssV75yGttwZJIF4kBKLxebp72+OkLm8yV7x//OvlHsWkZ5F4z63qlmBqBFgpvLaB1kTfGcTGOp80iv4LVZJdSTrd9RO09II6wA+Je1Ut+XSkbzCwuNmeCRJsK4yrw/c0+Odc2HA2ih7cCYJCZO0SBd3qXjB34xTdPlIgHO9xF0mdUIDghVsyCC5c24S2+Aml4i/Ir16uJJMdhorul0FNvF9L5eGShP/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by MN2PR15MB2864.namprd15.prod.outlook.com (2603:10b6:208:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 19:41:22 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::100b:5604:7f1e:e983]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::100b:5604:7f1e:e983%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 19:41:21 +0000
Date:   Tue, 19 Apr 2022 12:41:17 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix usage of trace RCU in local storage.
Message-ID: <20220419194117.f2gvd7xdxdmjqo2r@kafai-mbp.dhcp.thefacebook.com>
References: <20220418155158.2865678-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418155158.2865678-1-kpsingh@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce9c090a-dd65-404d-252f-08da223c942c
X-MS-TrafficTypeDiagnostic: MN2PR15MB2864:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2864EEF61CC46696DFF0DF8CD5F29@MN2PR15MB2864.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqnnnVSvXRYCp5uvIhNMlYtNrav0lK/F1q7f1YWR5eCgXo/xT8eQd+xWd3dgkaTv/C0OixJC8PmHHsaLnElkKA6eX1eFVWnHFLtVXJZOGkiPQlzF3Y2QqTwJ5io6mGTjn2uUahEwTK5dEtN8h2omShCRBQ75TspVsJtKHHQ4C287RxsMzTAH6FtdSLd2pIsstZeHrnBiH7ZxnPtAnVGbu6ZhQ+RKQfwsVsVVpYNDNuSdCXPmKOScaKLYkknH2R0quys35VtKPa6sgSzq/DWcz9ChIoUYb7EUBPASUZuEITyCsF32k45O5MHLeSNRmUumwtQ7w+aZ240hjb9935AG1syvxUB9ez+PeTz1iVLXnSWzPYdtYI5LMSdg/5P9kYaGQE1cKCmCLELsxbCGZO6F3naaWCmNHXc6XaJrQD10h8GWGojoDuWPupmXmAO4Stlsb4zh599U6WcvVvho2HjUwT8v0qa8aAypf13hUNXxGPI48VUanEC/1zm1GjX25f2D0NOGWr37UyV2TcWmXev3/gVcjpuUS6Zvmpzaf4h6uTEQ1TZvrlDx69c5IRXs8YxLv8+yhBvDFj73i4nnL5ZeR9hwQ0q5XpA4KG14PiH4mGcD1u9DThjJWBMfUrVt0W6IA582iX/QCrpE1xl3zQxXog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(186003)(5660300002)(2906002)(1076003)(6506007)(6512007)(6666004)(86362001)(9686003)(6486002)(66476007)(66556008)(52116002)(316002)(66946007)(38100700002)(54906003)(8676002)(4326008)(4744005)(8936002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ooLwELec9KyXHSIQTOPSBy7co9AP6I3psHPvEh4Kdn0F3CbfqlF07ZpteTp4?=
 =?us-ascii?Q?VBY/MqwMwOspIUiz6lATEtzo9i3iPRvw7PczbStchgS5RBCIGYqD12hNk/ct?=
 =?us-ascii?Q?4GIJjA86Qvflgph9KZG57wB3mbEE+zK4usbptUxx/78XugHEbc1kxQ8UifF+?=
 =?us-ascii?Q?zPLEfGWXdvkQlnNnAmyu9Mumemr3kfJ+bmJ+R5pOhje/kJ69IewFQFE6zuEm?=
 =?us-ascii?Q?k5yQ+jjiWJMkdDL3CI9vQPqPrBvSWAfvUATqRZMscYppSzFd1YpAD61Oae7q?=
 =?us-ascii?Q?cJePY6axvQIcSg8J0eZGMMQZWVn4KZi+eH0ULfz0Qss+aBIivyHQH30HojvO?=
 =?us-ascii?Q?1g0aHinpCLkch0IsT82ZItHXoP/3nPLo6eXEVYxloG7BjNSBVdKviZQX35At?=
 =?us-ascii?Q?NQU6cC14meMilhLfYM0+RV5RD0CmNYpUA9Mfjso1h7wD7s/DFFqzVPQQW3mc?=
 =?us-ascii?Q?gbJ33EklR1tc/nKqFLp6VtXz05VuzsrjuTsRkohKDOqWWtjtucgJNM8ihU9v?=
 =?us-ascii?Q?Jk+Nc0+6rklAdRJVtwKYPwOIKgURe/3cEJjc/mBwmG9XKGZRfCWv+A8nymYo?=
 =?us-ascii?Q?b4LXoFj/A72JBS3ZxEiOTJM0NP9Z06woX6YvCkOJCv1mwV2zxhkvyz36DqMI?=
 =?us-ascii?Q?VbYa+uZS62wLuOuHs+YGVVHGyPCbtPr+UNVY3/9xEiaA4gWiVfwnUd6FSKhC?=
 =?us-ascii?Q?9pmoxtKSlmD5ngIZIOAhOYXci7IXKuM9r3xnpL4hfN5KOVrZIcE01uXXxsYM?=
 =?us-ascii?Q?lVSiuu9ai7of6omuLg/qGvSOIVF/ohPlJpZRYveXUIm7k8bL1KZcbK/uWDCS?=
 =?us-ascii?Q?bq/d2NAtQnni+yTSZMVqk/DTFsLuQsrABpKc/6cqjXlaYlUCi5Iyjq+oVkPK?=
 =?us-ascii?Q?awL89SErxx9H2Kde3pZlHi27ZfvTV8f7VMKPmlpCNBIjKrOPBaxdvqtUMswu?=
 =?us-ascii?Q?XKV9C3q2HEVhWZHKDyXPi0crn1tamcf/R1fNgoi7xHqpegGn9BlQjL9t/62B?=
 =?us-ascii?Q?HyzAQ69Xp0HEqXZXlp9o6ssx+fzs2WsIMAr2n3zN8FHOWWi/YdpmEj15tSEq?=
 =?us-ascii?Q?7YyMni7lhbxXuuuD6g4SGiwdcLHBxwosr2xqqXGFNAr9t9uWR+gKdCCFfz19?=
 =?us-ascii?Q?UvbfUQQZmUG7J7giuAQP5+uFr6j/NGq8yEdhhD3CP3d3rCnXRwrwFe4Hv2Wr?=
 =?us-ascii?Q?yypdyvaJvyIR0FfwWwu8a9SW8lK4OMlqWhntN92s7TS+PLqiNJv/Hn8dAfuG?=
 =?us-ascii?Q?bEB/uye8PavMsw1HZPPwcf3lcSYcHntvUMTp5/Vba9UnbpMXdpzwhDkQVTCU?=
 =?us-ascii?Q?JHHLOeiEeSBNyENYJDdWxNKXMqWagSsRegSddvcx1heARDW+4FC3PTSjVS/0?=
 =?us-ascii?Q?HP4tzh9bJoIM/B/05xFphKQGwilVpAFTyDYKUn0/49EeozjyZF+vZYn4JjJB?=
 =?us-ascii?Q?Qodhk9JOoSU2TzvYE44ViVIEvbNMDUNfAuKXzdB6DLLcHAmVXF0P5LCHDG/w?=
 =?us-ascii?Q?WVqZNg/Ib8dWwzO/HNb0W9KELrQXz2RClVOXvmwDFsc+eysADQ5ce0c+nNSc?=
 =?us-ascii?Q?Z8QL7G2DlZB9uhqsOGHmgLM8DmRfmiLB7xp93b7gg6nC4VfHe0JjKkbDUYgH?=
 =?us-ascii?Q?T0Tsqi0O3mbev788d8U9Y0VlVQ5Q7WWkpEzxjd5o61L8lpIpsSsqfgQMmevv?=
 =?us-ascii?Q?ymfV/OdS0tOB4QTm92lvQFs+52hOjibo3N0Mh72esoujZcvTI3eAMqyeXJEM?=
 =?us-ascii?Q?vG5zTLuNinCRZcZimjaiAks5SU3PqI0=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9c090a-dd65-404d-252f-08da223c942c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 19:41:21.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsUDsjJFPrIyrCbEA+4pF81WNY8dkMiNGEMdzzb2d/0ACHnULYvj9kDvtTedxLrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2864
X-Proofpoint-GUID: O_K5vERSshE5nhNYEU-3RlaXwTq4bFsa
X-Proofpoint-ORIG-GUID: O_K5vERSshE5nhNYEU-3RlaXwTq4bFsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_07,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 18, 2022 at 03:51:58PM +0000, KP Singh wrote:
> bpf_{sk,task,inode}_storage_free() do not need to use
> call_rcu_tasks_trace as no BPF program should be accessing the owner
> as it's being destroyed. The only other reader at this point is
> bpf_local_storage_map_free() which uses normal RCU.
> 
> The only path that needs trace RCU are:
> 
> * bpf_local_storage_{delete,update} helpers
> * map_{delete,update}_elem() syscalls
Acked-by: Martin KaFai Lau <kafai@fb.com>
