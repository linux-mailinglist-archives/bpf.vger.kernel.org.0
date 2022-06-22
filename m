Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22156555537
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiFVUHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiFVUHg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 16:07:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEFE31925
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 13:07:36 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MJMati000578;
        Wed, 22 Jun 2022 13:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=m19e9pJefHo/KSzHDCJVM5fZ114dKetwEA9n1mkmX0E=;
 b=G7MVfrulEW8P4yIXV1O9u+W47MRfE7aHSSlzVayZtZlOlL8zot3e/szYwXHrlrj4Nc9V
 91kxVbnkj+XSnTR1SMtFKHcc1ZAoWlPwljLymGtLkWCJDts7ZIoZf6KMt/ILkjbr0zNY
 ZpT+mAVGXTb9JA2+plIBygjgtOsRPzFWRI4= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gv2nak8wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 13:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcI5tVCFE+h9LORe/XMuARUfMC8fbomnqDhTtxdwR9p4EemTTU8dnGdBQjo9bZEnGb2XyAJaefx/l8NHiwzYUBa814fpgR4ol018K0ksl539GAk/wJmjPFV7qXZKYwBiVG8lyZMiVfzn63jViaO4m8KA7apBvdcmPRn4RrqSkJcPhf0kQNiwgL9LZv26XlsFvkzIrdtEgahFCtoPp9+OuqMz55cJ74SiD6A+pkIQrvCMFCRF1P9H4BB/hh/NcLp3pBZJORXdYdJlLu74xLr0u9GAWsNTQsRQFMqo+trv2xnpgqydjuGmGlxs0/dGbslt6E7SRH5d5qp2HjJrhfQepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m19e9pJefHo/KSzHDCJVM5fZ114dKetwEA9n1mkmX0E=;
 b=nLPsHqpPbKUwpRsCmvpfXXOT1jDN81s9eDrKvtNSZHW4I85iPtPFuCR5OZOTVT/X+r1WGSCQ2QlRSJFaYsw7091YU9/duLU4vT/G2BJeC2HtbTBFQHQ4I+mY9+ZSE9Zt54llG7eq83BY8H9l974hxPHnFVvdFl+4hZ3GTIMSoQH4jE61UkV2B7RHMqHiWQ8PS1AMo0rZwYClicW6mw8aptv/OAXxXWYqAjEUQg8gVo7NF1zewC+M8Y7bxc2DslE1avK34eB2t9XGORsn8S00RIS2GQjVcf5mUKQs1bGUIw7V30SB8uCCa+7wpfWUlrww/GSW11ZK8Mk2AkyV9EG2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SN6PR1501MB1983.namprd15.prod.outlook.com (2603:10b6:805:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Wed, 22 Jun
 2022 20:07:30 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 20:07:30 +0000
Date:   Wed, 22 Jun 2022 13:07:28 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: scope id field in bpf_sock_addr
Message-ID: <20220622200728.yffuefokf54rijfg@kafai-mbp.dhcp.thefacebook.com>
References: <CAFnufp2KL-qNyDtWH5cNQ4DARqSQAygSi9GXgHD-iWs0XzJMcw@mail.gmail.com>
 <20220621012040.7tdjpw5jno3mv5l2@kafai-mbp>
 <CH2PR21MB14646DEA0B940D68DF13DFADA3B39@CH2PR21MB1464.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR21MB14646DEA0B940D68DF13DFADA3B39@CH2PR21MB1464.namprd21.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334c5278-cc23-499a-de11-08da548ad642
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1983:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1983EAB45F2D833CBACC588CD5B29@SN6PR1501MB1983.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/iob8wXTXbk2vogwfsVIgS3dXb2O/xlBzgnw47Zc4MCdYpN2lDbDW9e3RP47GCEQicDETSH28vhtMviTJjp/hXlri1Vn7hE9AOlk7hwtc8Mn4zO44tOGMw2VUmqGMJ9re8rzWtv93nqk4sZPx2iazUwEHs5VBttgQd4R7Fcybh/6fppmaYrl1jA+/VB/fovRK5igZudDTb0Q090YW/qs3njCG3qjnZ81CRruKg2DaX1gqljUgkBdRKY5sNiJUtEnQbLCBGGV97+eP4+zBHcPxrDQItWkR8nVSlWSN34Bt9LqNTzVkSA4Cu1YYq3wWe89FVjIfm0cknRuGVHOS9UKpGvESi3kVNRySbSEsphQ+9c8+ymWDmy65X2F7yXm8c+gTfBWFrl40nvv475z4gydKo/KYnWqDpxzF6paw1VX0G5hWY0hS12/JY8O8wpefjr/aWGxGc+tW5nlqkle4fXnCI5ONMTuWQR+jYGrvWn9kCqqf9OLZZMRAbsqFZ/N+6pp6mv7hRcSHzgZV702HR+LDBZ84qSrg4Zsc9ruRgjicp42nTRS6pRC2mM4yJTgu4BK8jwh6pBX9ww5GxDrktjv7KlkJao4sZVL5p/QGhKKBg8x34AJQ9+sBT0JeWBOkhy+UBzSucYTxnyYyDWHhBB0+LDrTyyPVGgYNR0OidJHaU8RVhIGDBL9/ninlom79O8mWgdkBrNqPfZakX0fqy0+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(6486002)(66556008)(8936002)(54906003)(9686003)(1076003)(5660300002)(41300700001)(478600001)(6512007)(66476007)(52116002)(86362001)(4326008)(186003)(316002)(66946007)(6916009)(38100700002)(83380400001)(2906002)(6506007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqtOFP28NJB+kx9Y0JBjBx9zcYEILtJjHXSqIWRLZC6f6pcWyPCR6nkJNODT?=
 =?us-ascii?Q?o6chnAur5QvnzA4+F/aM/jpw9Y0h75n0S/D97pF0AwIknlvLj52yAOfEpsJT?=
 =?us-ascii?Q?E1j5dQJRT+bRUGtP9NQRfbcYkAinXQvexmGMzJdJJe55OdA31ByGGV+BvjZ+?=
 =?us-ascii?Q?nqK3N7lxYewM0HJqC3WGJMrDK//SysSN8eyz7MsNwUPyyh8ZW1YW7IKvyNiR?=
 =?us-ascii?Q?L5mDQXrGtMQKsx2Zm18QTLSl2uiWBhJPiJdUY2ar34hYbI9gu+79I31rRFPB?=
 =?us-ascii?Q?2ABAYBlFeQbI9yewnj6OlMW2OlCM2qNKuE2LQS9lXrGdg9Mn33098oBR26D9?=
 =?us-ascii?Q?qUq/et4XXwKJxM2T3JBKIXkjJ6M6qBCyZw5yn3ZYOwndWITRZragjwR+I7Ec?=
 =?us-ascii?Q?aS4U4f0tY/4Afm6ELuPKIdw1E02CuDCMFy9mdS/ZrN7F/Uhc8vtNVL+r00l0?=
 =?us-ascii?Q?IEr+I6laojphuYsiqMOMtpTIAG0P9d+CZzQR7KKZqj3oWZDiTBqsxiy/SLM0?=
 =?us-ascii?Q?qYnJxX+A0gX0TEZWz6Tc8OuuZxwnxH0ClLPUNIAGBruhtvX8bQ6/F330hVDC?=
 =?us-ascii?Q?iKDPG6YNEAtO1stPRzJeBURtqN/09YJVPuAl9oHYfhsQJWqj0INRI3k4ZzZn?=
 =?us-ascii?Q?tT1tc7qOufIk2xRyELZJxVPQwo2jBqPxxXXFnyKjXav9FqpTthIsowgm6sqR?=
 =?us-ascii?Q?DfS3+9cVTU2UQZa9kBSmLVXOBarSQR0kc0cyKPsymRrlbt26DjuvqoS4G2mN?=
 =?us-ascii?Q?1iJ8XKQh35SpHOakQnR/GTXS7D3JRo2OK2kzb+UDZ3gAp0dgKHnHpYJDYanN?=
 =?us-ascii?Q?6KEAk9tiJ2ezDrOYZ8wAHwTIx1cink3Fr4HgY9Swx2jLbBv+3OHkcmdaWKJ0?=
 =?us-ascii?Q?ndQ+VZK2XsrLBfKKb28XYWFPnikbngVjiFyk5DnVTOh8UCYuEa235dnU2qDq?=
 =?us-ascii?Q?1PVEV4XaFppuY+3SJauh08QopNHAavAKEgsh+2d4wmsIG8w1BSPp2go8hcj6?=
 =?us-ascii?Q?3ILBoipvAAbTW4YqXxsu8JjyvObUDUaCrvXUO221CfCFd5LIUD1S/aytDhvI?=
 =?us-ascii?Q?MWs2UBB9KTv05KdpmBn8LWMeXKo1l3lsqbVi5rA7fMHGZFysKAi5BLZLULsh?=
 =?us-ascii?Q?X0xggfEf8wZorhsZ1An/4VNkNfrEhi69X9cNFT7vOyDp4LsotC5e5BOuV1Oa?=
 =?us-ascii?Q?Akw78uzCCCQYdTaZ/zRlnAnML/1ZD7kK56nP685g461l04CSvLRFGj+GiFws?=
 =?us-ascii?Q?GyO4VST8DeciIe0gZU8uHeYloYs5oOr8JkWgnKEkF9VFI8vDS5cyrJNUDV6e?=
 =?us-ascii?Q?Byp7gY8a9n7Ov4Px1XHpN0TiNXpmHIY7HXUKQpa4TuCdIZQtTUH2wxWm1id+?=
 =?us-ascii?Q?Zwx6T6gXlUAc3/8IVAHH/27ygx94xyW8ZYx/nCRiLVZyNGf1J4BQvbC1OLGW?=
 =?us-ascii?Q?rHBTQLS0gip6yc2IuXMtiZ/6px1I7iOYDnKGeT6tP0jFN6VVkh9IXIbbBIbc?=
 =?us-ascii?Q?Ori9vNcA+g1D4iU9/I1Kxbo4Ew2EbNoZfhzns+3VRP+0uW8iguHRur35wrgh?=
 =?us-ascii?Q?oR6YHTdeGz48i+J5Zx7CDBHeDG4ugUqYlAl4yHj7+7QRtSrppBMOIWX+Psr5?=
 =?us-ascii?Q?9EZnc2SNf0s5MZF83+xL883NuHRhEwOGGikmbFvUBiWj3oJJRI6cTSX9I9Nm?=
 =?us-ascii?Q?Z795Zp6zbyJ0Tl9SUdjvrIKTtHgVVLbVrpd2TT20JdwNqsHsv4yUYsNqurXp?=
 =?us-ascii?Q?eZBlS2nZaYMfqV38G5I1m6AzmOVwzko=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334c5278-cc23-499a-de11-08da548ad642
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 20:07:30.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy3+PINONi2OBls3GqfNbZSv0/HSzCQm5QJNi+e+bLMDwtGMWnbWuVA6iLi9xPn7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1983
X-Proofpoint-ORIG-GUID: QkvDE3qZtYQgrOG3vbTjlSOMahZt8UK5
X-Proofpoint-GUID: QkvDE3qZtYQgrOG3vbTjlSOMahZt8UK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_06,2022-06-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 02:05:47AM +0000, Dave Thaler wrote:
> Martin KaFai Lau <kafai@fb.com> writes: 
> >> I wonder why struct bpf_sock_addr doesn't contain the sin6_scope_id as 
> >> in struct sockaddr_in6.
> >> A program with type like BPF_PROG_TYPE_CGROUP_SOCK_ADDR might want to 
> >> access that field.
> >
> >
> > I think usually there was no use case?
> > Do you need to read from it or write to it?
> > You can try to extend it.  Take a look at sock_addr_is_valid_access() and sock_addr_convert_ctx_access().
> 
> For me: read it.  If you're trying to, say, track the set of all connections, you can't do it simply from
> the IP+port pairs, since IPv6 scoped addresses are ambiguous so you can have 2 or more connections
> with the same IP+port pair, so I need either the scope id, or an interface (device) identifier, to disambiguate
> and know which connection is which.
> 
> If Linux has an API to get to it, we'd ty to do the same in the ebpf-for-windows project as well,
> but right now I don't know the answer.
For read only into any syscall like functions, it is usually done with
bpf-tracing in Linux which can read the scope id and other args.

afaik, the cgroup sock_addr hook is more for changing the sockaddr
rather than only reading it.  If the sock_addr prog is to be extended
for sin6_scope_id, it should be changeable also.

[ Remove outdated email from cc list ]
