Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6631557F7E
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiFWQMW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiFWQMV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 12:12:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC645787
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 09:12:21 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25NFQ7hI017080;
        Thu, 23 Jun 2022 09:11:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=89exvbSVaOLlcM8+bS3aQz9/ElZAiuR4rZ9OzdY1yRw=;
 b=qKceuIdt68DA3tspJGp5a1gXJAtmUUS9IZsAZSDF0A9LypAStox7OVw+ueNZCMjcWtrm
 23RLbgEhV4gDSqU3nNqyGUE55wmH6At9Gssds74PzqIg4RcWgB+ll5Fpyds4I7cXtZSN
 JS/iztMWTsbPK+f+HFbiKN/HaDNN8UryBWE= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gvce7vsmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 09:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKRTzs+35IBa+F5ziqLRhZ3v7g6ar1DetSSC6XMxBpViZIEOmvQTyc+MQ+H5JKosVzA6tBxmPwgDrxV/Hjq6yaEB8rZcKBBIj9j7ytY+QCwYBVCYcFwvTGnZWSm3HXWE6ebOX9i1cVr269jeE5jq/aVbAfZC3ZhoVpG63Ig7zL2tW8poQpH/QTeh6q5qr/mWHPZzc1XKuYRdy6PlI0oKgR2juiEDPKYfFVrLmyQM39NPuc3iE+FtAPWQkJJADEbwdi7kvQRl54uTIS8CQ39hjn7oWKlzTFG65GVp3BLVh4Srb+81dTA7oLMKryEL4y5EZVyjHrtG4teiwRpUWAKVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fljcu8DUPcdBYyyRc1GYPyC6j4qOuREvHtoeRH4qAWY=;
 b=L49leFlvtoNPYyCN+307KLLheS2/ab3NPYPPZpL/dBTxZoAr6OWK5EMyQSfC6SS/DsVDjVDlIKkQHF1HPG3uSoZ6xHowbuBKQUlso4XEwN9V5Z/WtRG7uQDJlRUwc2r0p3wgC+Q+ScwCHV1gyeASDO46J4NHUOPSSpcidOsNjpH4hB/cMAjFWFh1UJk02NVDDgY6NAPFinxyCkqz5gW5VUGZe72ihmYFQBXGNC1cA8CEf7vcOntofbr545A5Bhq1jtIPC8hg6KN14S8NQcYjIr5FAJl6IaTVRGoKD3FrgZayPeuZ8SVJiDCZd/5T4TfgKGsPMBVTE0jZ2fVmB5WM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 16:11:52 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 16:11:52 +0000
Date:   Thu, 23 Jun 2022 09:11:50 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     =?utf-8?Q?J=C3=B6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix rare segfault in sock_fields
 prog test
Message-ID: <20220623161150.ox56m7lpjyxqxh7i@kafai-mbp>
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4be9ec94-8a28-4d2f-5e2c-08da55331578
X-MS-TrafficTypeDiagnostic: BN8PR15MB2513:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wxOetktPMwxi3jMAK2XjFbR9wuEBEVS8640DH0LnrUPvmlAmgtgTNd1d8rPJsBP6zz1o0jBDd5zOkb9vDWqsIpTejz8Fsa67AIj6jQqdf0xMq/fx/Fxt0rsEeVZioQ4X+TbFAJTtSag31ZMJ4ScNFQU3sM9M36s7QxAt0td5rQNJ0dysop7bVzhTVjPYBGqbIFuGCRHA13vdt00U73fORC5DcEyZ0HI3aTy9SK8LJ/WW8BLaMES/0hnNYOQodwNOZ6m2KL9u8M7TkQLJOBUTXQdJuDwd8DOsvbe8g87FlSfF+E+/8esLeeb5H7IEvbrZqDVxMk4LyTwevRIrMnljzfeOSafgSb5gC4hR3jTbSsjsbp2kJkzvOgU84VAakcvZU28kt2YeewNEr/SqgWrT6Yy3otFOurIonCFGhQNOhqHfb/l6GjGMc0+TPUnKYnJKuzrbMmu6fEclInTUEph6d7x8WoWsqxax1DdBUq3EpKAJ5ia42PP569MnjaSJloJRSr8Emcl/mfKTa3gGliZLWlFgx6Ckvt6YfEanpTgITZ/D7Sr2x1lJJ9GtbwYehSEe0zxa2+HKa9G8mGyQH89KUxAFWwSkgzXewMRevx8Fc+hgsdORkVoPR3oc71r17WwNhmYQULGH2SjKyyD7RBU1mkIBNEPtWVJcD9LlcQoeVfkX4+nS/+5NZRZrF30zanQxdGdcTQ7xNypB3MMuPfHmaSXYqsoPhMOZrGCEb54TXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(39860400002)(396003)(136003)(366004)(346002)(1076003)(38100700002)(186003)(5660300002)(8936002)(66556008)(66476007)(8676002)(66946007)(6506007)(41300700001)(2906002)(478600001)(558084003)(33716001)(6512007)(54906003)(316002)(6916009)(52116002)(6486002)(9686003)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?s8y2e/ZifD7g53415Pl6n2uE6LZJ7XqCT9Q5XX0FFKZ993rvoXK575TwHb?=
 =?iso-8859-1?Q?HpJoVLNFxH60AzJ5zF0b6DyxteE0sd4J2bGP7Nts87ltmjXu2j7FJwKVze?=
 =?iso-8859-1?Q?56v5s0Xg+cW09++yBjR1r/DinZhFwDVSppbpd98BPdG6J0a7S3Bq6a1ZRs?=
 =?iso-8859-1?Q?Ie1kKd4uESsnO1308ntPkYMcYRJeHKV4an2smInx+6+pW70wjWFJRUAX8L?=
 =?iso-8859-1?Q?MNPJZigKIbSXGH1AUYL+qOFv3soeG1onhnYcprEOf/SJ4xNu/pt/0GZhIM?=
 =?iso-8859-1?Q?xhfDAjTNN3eeMVcJCqjXJdLc7wPclBII8KiT3qloOKomrFOWwkVVEjo0l/?=
 =?iso-8859-1?Q?Im34M9XhhpzWznWj37nBNp1IGxG0fb/lRdDtI2kOFjUdIAzuKqOZE7Lp2C?=
 =?iso-8859-1?Q?xqKhMVPEUvpLqykXjo2iu6q2msvhGRXAzytL1PtfnaPhteJLjX3v7SSHz9?=
 =?iso-8859-1?Q?mmmeNEaxv9aiaNFqOll/DXDlWxd9s2v6iKZleXmntHTZX6Kre3ucqwDSOj?=
 =?iso-8859-1?Q?etoqIX5f78z/XVR4ZIAi/5TTNbAxZ1YiM5psZ8vp+El/aMmtcO3LHdEsqy?=
 =?iso-8859-1?Q?Y9WMtcLJebcWWgSNaSHnu1ph32NfkI/yDp5Uyen/WpGrYzzYncJRhU2He/?=
 =?iso-8859-1?Q?x4IHAv5Z6kqjfyUfSNRCyBDyjU00K4Mo+bpLZ6/2g9mAoYqW0ahUq2cMCg?=
 =?iso-8859-1?Q?YPcVHaGZiTl6e7wPPYdNYYzd3Aj4xUxe0hxdjYkNC7bEJ3mfObPpB2JHTh?=
 =?iso-8859-1?Q?CnFyhIU2yX89F6yhpP4AoZXXsb9PxxBz8m1jPLku8Qi0N7cAZb/YNtUPhl?=
 =?iso-8859-1?Q?RFfYNwW6ytrUi8ZxiVf3qKrI+x4pJWWUEO0NeYKhu0sUhV4C6f2amIBbZB?=
 =?iso-8859-1?Q?Qcfiylegbp/DXf6qlI/TM+hjLZP2NvBomsh7hkhWjzBwdqDaRKfYuqOfM2?=
 =?iso-8859-1?Q?a4g5pFvj4iqaZjSLWO2Bfks3lMtX29YlPZmfHminSp11gX9bFwW3Kel7SM?=
 =?iso-8859-1?Q?TB3+mtIZO+kW60d+5RMC/Hb10b6DZM9OnEiVpdzMDcbQ4ruZb73gIrdNpv?=
 =?iso-8859-1?Q?BMXMt675UBEg5LuYbwNtirI5rmh1IM06XihdvMUwQdMzr7W83tW1yRnTSi?=
 =?iso-8859-1?Q?/BE5jYTw4XvOYm2b1/XR2t21K0DzfRsZoYcnXiMACUIZ1h4prI7DLM0L8t?=
 =?iso-8859-1?Q?PM3VM5IovJD1zfhGJj41Xd6KWowOSb0syqBVMpvW7acN1pX+bFc0m1Q7Ky?=
 =?iso-8859-1?Q?0kdnGa78ymerceq4AK1f9hq1FZOr94AdZG1MtVFAyLWXRhgICbBbiXHGMi?=
 =?iso-8859-1?Q?Dzfjew1tyeqcnSigHYaWUONQVS23twVR6Aos9pnljmkBwu/PsvDCNOpoRe?=
 =?iso-8859-1?Q?2uxkSnGqRUkEo3SgVUxRYUKxkX54wnglrWSGj5v+9VS0+aFXSBdLIGqhp3?=
 =?iso-8859-1?Q?qMfdbRtF90OpG+KYrXq7cWwkpXkYqplJGZ9OG7cf0lhAXuyhBEL77jlJhQ?=
 =?iso-8859-1?Q?WMOQlz67p/blWlyrXFYY0LN2KqU26Fdd9CLpolW5xq7i8XgiWEfCaBRAPH?=
 =?iso-8859-1?Q?6BRAILKrl0bA8s+i57KLE2cWlrv/DGmljeT5JbowrsCJJgm9X37axB6T51?=
 =?iso-8859-1?Q?h9FxWLJL16Hip1ZloN+x9AfIkfHfJ5xjLK+ToDMlvlpWaJ7Zb8jkrrlwRQ?=
 =?iso-8859-1?Q?mGHSZsX0Tjf00ActOXm05wSlv7Y1bIouxBXE/XVCueupSOWiHuwcef5vtj?=
 =?iso-8859-1?Q?hMfpGbV0pdkKxvFyHmrIjJiig7Ie+8B8acwADGb8gAmxgjERYk4ClFCjpB?=
 =?iso-8859-1?Q?QkvaiIW01d6mR+P4w7Bxm/WPT1tL7wI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be9ec94-8a28-4d2f-5e2c-08da55331578
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 16:11:52.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTOayArJ6hn61GXkM2uLQsbv8wIEZCb/xO2Rn8wwkvmTNMqzcqIiX5BEIq8izV3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2513
X-Proofpoint-GUID: jzZCVW8mgQEkJS7O_R94ABjPMBx3ibD8
X-Proofpoint-ORIG-GUID: jzZCVW8mgQEkJS7O_R94ABjPMBx3ibD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_06,2022-06-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 09:01:16AM +0200, Jörn-Thorben Hinz wrote:
> Go the easy route and only call test_sock_fields__destroy() which is
> null-pointer safe and includes detaching.
Reviewed-by: Martin KaFai Lau <kafai@fb.com>
