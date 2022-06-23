Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5955801C
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiFWQlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 12:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiFWQlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 12:41:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE94925B
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 09:41:48 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25NFDaHm016958;
        Thu, 23 Jun 2022 09:41:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=+0kVBC9BBI6e6m3LG6UsZ0PuPYslTBrnjGa/gNwPFUk=;
 b=ebhTzgtLaK7wSKMFsNEwb6CYUbDR/FuZ3zPLrBSfMexbv1DM8a/PFUdKASmTsoNkNQBf
 ZRKa2X4uMEiWn4FYN1rgEs2nRevahtLFbZqHM8L9acjVeCaK4CfuuM75kMY1J8E4emVx
 nQBupB/qk5UADnJM75ArVPyHI0RlX9En130= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gvce7w07a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 09:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1F2GdCCp1mge96k8ml7xuEBqHT/+8r83EYoKwSYP9ayM24Uci233DWjYbTSVLQg+bjc9X6r/eMlQxv2n2lypLz8kbLP6wH3tn7gxWeek4+Ow2RqWOSKIYYdZkSkfh7rdM2ZaONmVkf8KoMfX/qA1dyUZdgvJ/MRoc/XEGHbAY66uthuVQp89yTZAS+EzNJXOhpr0DjYjBJSSzHfK2MnMzqCMAzlanvmvDLLpPepOfrp+D+F5iJtu0mO34F9kAsjrGFb/1Es9/uKWxIMwQfB5a8l9HcKsxbFF+hw9ghaft+OmUpHfAMuF13KIrBdRgb93jxJxzdp8rzU5G0ahRgCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEWnkYpU8Vk3a7Kari+besMwH1zL/bzzAyNtVNoCO2k=;
 b=hUqmlvMFzw5EUA7xRE0Je+5WHwRMYEzw5vdcw+Q8beZ9SJvYe+5dRjCsUf3KG0JYbr3JgJ7qBH0l9crLq1KA3pvDPGo9jM5H1TsN2MiaLA86YeHH/I1WWoTscS7AzOzg3f8to1+xaAYv/0qZFj4ndvYHoyu6VTx5GqVP/C0BDP5WxUVltVl4zDVd/ABCar5JX2C8DqGFc2i1mhTLn9WfA2QkQJRalvYkzGQDFX2ZxS+T3/xCb+CbAtInsUG3gCKKzzpjF/pAfhnQRjv/6FBexKV7YtfOuhpVHOyyiCp5Xim/VE5gQtokCXxOnkgUUxd6/Rp0e0YT8XkbulcuVSiEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB4103.namprd15.prod.outlook.com (2603:10b6:a02:be::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 16:41:23 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 16:41:23 +0000
Date:   Thu, 23 Jun 2022 09:41:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     =?utf-8?Q?J=C3=B6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v4 0/5] Align BPF TCP CCs implementing
 cong_control() with non-BPF CCs
Message-ID: <20220623164121.rryvyjnjh6irbcoe@kafai-mbp>
References: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622191227.898118-1-jthinz@mailbox.tu-berlin.de>
X-ClientProxiedBy: BY5PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::16) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aacbaa6-20ca-4797-abce-08da5537353e
X-MS-TrafficTypeDiagnostic: BYAPR15MB4103:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAU9WN2zb4R7Y5DvF0/4Uhki8cqpx/TCStyJZ5qExyX4lgZ98NsGjXm/bFqAzYeBBQqEXDcrWU/p4AfqJbaqDY/SLdskKh6Z7IYnnkdqX+fK7nmhEyCBvYLQHAsKPp3FuMNtFFdV1PtMvAyaI/e1LZJZ+kMTjs1ukj9XRShsdnZj3D1aPDrZR8IlFAh+VdNpMW7uXi5LlHfWVxyzPDBfX0iJGBG2cwXqHs/JyzYf8LAQnulgDS2Ol8NsTndS/j39R2/nV0KoeRwHvCjkwCi3Zp8LVLwmewimKCJAkVcWgj2c+48T7YkLcVlyvBBXELEZbrjhxFWCDoBEGmVCygC10HEoYLaG9FsFPio0K7Yp/iiXJL6bPK6h6s4BlI9+Fv/I4GZK57tCLop4U3gZ2wabvhXzFyUH8j/UZNLVkC3NnrAklqqexwBcBYHULz/ySWuo7L3FoNRaxcuU6HJU5F+Wco9R2vA4r/GaSF3+cjuF+eEKHoZyHcBBht1XSEm6IbTlZCB1em5ACvRVdOdwVrAunabtu7XCGXa3/0ss2FWXpf7jVSCifMzbL8ukUl0ed+18AzwMfSy6Kp4uiGgbLLeHzVJoHyvTFH904mbiQYndL+YmHbMwAAXdRv/ffAfRE3iwoxqrAcW3rg5hruliSzyjtRlOfoLI+0BnojJv8UmbMrWjDC2xlG9lwJvYtWk2Qc04aFy70b6MjUQZ7eafgIzmZTrYymmxa6zGzl4liGekbv1q0FoNkBj3oGZJyv1zoR0g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(8936002)(66476007)(316002)(8676002)(1076003)(66574015)(83380400001)(66946007)(54906003)(6486002)(6506007)(66556008)(478600001)(4326008)(186003)(6916009)(4744005)(9686003)(2906002)(41300700001)(5660300002)(33716001)(6512007)(52116002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lR0yopkCBWhdc+BBATFdzgD+QoJoezAx3m5ffapI+KsMd45/+uvKmIA3Ox?=
 =?iso-8859-1?Q?u/5pbWj4OcWNKvr1De7T6NO2zdaxszmrLtXGY3UMFE/iM7hYESh7sDC3V7?=
 =?iso-8859-1?Q?8zs5fH31F/pfOrmmMjuT8fPWlD0LZxM85WSD5NI+uiuJ/6PdNI3AzlI4m2?=
 =?iso-8859-1?Q?gfcroKsxhgkIBgYt8G/4587EbLL5TdkHZcR45Naw9lIPwGvOUO+12X7bd2?=
 =?iso-8859-1?Q?8NDXJgfyymt3LYH9hnvEu5dkqZTmCsoJvYzG1ks4SxAr5rUGkeagf/TXyK?=
 =?iso-8859-1?Q?buBhUuQh9x9tnCQkQOGv3MZYt3Psnq0azxKTWyGBnBevl1grNozxmlIEnJ?=
 =?iso-8859-1?Q?JJFTVb/zSF+QH1zl6enztu2Wf4CSFBaaKuqx+BSN36vCMi2AybNzomA/5g?=
 =?iso-8859-1?Q?HLgqo3AZMq1xJLV2OColvtkfFvgvoYibMercp/4eWJYNnhyJZE8EEzqMSX?=
 =?iso-8859-1?Q?TKmgUi3Z80jjLyzevc12krC7IK7pwtComqwVDRMwEOhZuZ036xChNsZNfH?=
 =?iso-8859-1?Q?pbUnl/9TClpxf+rGBCPNN2MgcOnd8OJKVQe6l/dUaXoX/ULuaxG2P8XQai?=
 =?iso-8859-1?Q?IKYmxWLK04x6mwgRF7IoWgt8+hO8d9jQPLEaHl/3OOK9ZxYOxCFBH5LZDE?=
 =?iso-8859-1?Q?rAje4TXIH5RZCr6UTEmdauaMqe93788v25rKYZoW37r+X9J9u19xv5uO0A?=
 =?iso-8859-1?Q?woAWqLijdeNNQsLRIQImTEfqkwSoE01Y+4eLv1juYRXKnEgdRG73rwwKuC?=
 =?iso-8859-1?Q?9sfSquhDQK3r1MQNA0V43OaTBDdjuEPQJFnK27oyAqYYCy8c1Mk8iD2Zl5?=
 =?iso-8859-1?Q?Z8uoE0sPVnIl/smMxM/Qc0CGj7mjQOPJTTIL8OhjdszV5NNuynUwUw90tB?=
 =?iso-8859-1?Q?ZAGnvncDhrOJMcoOsMKiB7p50TpJl2JGd1p+g4cl41HS5+boTvTcKaYvSm?=
 =?iso-8859-1?Q?l74E8umH8KonZ/uvRyS6FBlCO5LP4I0aAewu3HXEwFfuGr7nDmQwQrt+o2?=
 =?iso-8859-1?Q?cwlXHzhb3YoVOCO3h0hXXNHVDrK4R9GltJiiHEvHd509peYh39rmwLou0N?=
 =?iso-8859-1?Q?fKuQ/PsPQBwMgcD1KVqC1VD8saix+FIc+6lC4ObPFimoJxiMTY3dZNUUD1?=
 =?iso-8859-1?Q?IVXmj1svnf/wF5ELc7O//8qtzwoaNiuXua60U4onRDoC6pwNNIFGhPgXDe?=
 =?iso-8859-1?Q?dUv0O1pA67SdoRQ0WzDBnNwqF8srlARrAxdSlLJy4Nh8UhNmGD7p12TmOJ?=
 =?iso-8859-1?Q?aeNlrTzKr37/aoiRPbZepfTyNXwEcgwElq2ZMQagRqxI3xNT7hTwjO4oxx?=
 =?iso-8859-1?Q?/JSOVji+pNsis4CPc5MJitkRk5cnNgDNm9kh0DN+kCE4fgQE3spEqmjGsn?=
 =?iso-8859-1?Q?yJQZY5/zYp9sKD6yM1hpHA/GAJcIuPVH/z+ZOON97FX3Hc5OKx48CmZYIl?=
 =?iso-8859-1?Q?h4Ooy6uqaihVJEJ20xZsTY3bTjGIU/xCff4KDmnKdgljQGZ4l+yq2OGNTQ?=
 =?iso-8859-1?Q?vlk3dvXl50lcd6BANq/Gvcc7aC9yQ+lVYuK1SAaI8llf7YkDLPme8ncaJK?=
 =?iso-8859-1?Q?g335Ao7Yg6ACtSUxC+V3qr0IXtQDD6vFule6AmW0J6Igvw5UZK5u+6/C1T?=
 =?iso-8859-1?Q?uRv3pwHnuT4yev7WkxnPAI9HgDZvWv5Tg1wm2xjRb30iavKSuB5GayaZ+u?=
 =?iso-8859-1?Q?U/hMNV+5IgIhfN9HRl4sJ/RnpsFxRgVtfW6ZxyWdo7+UT8MgEd/kUv2+hl?=
 =?iso-8859-1?Q?SncrUPn/r01outo9vHg01vhKAuB9+PWd8IiYGJs4HpSbVdyEjqZKOoseQM?=
 =?iso-8859-1?Q?meGAahlIATgiLAxAcLOXTv00nEIkPJ0=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aacbaa6-20ca-4797-abce-08da5537353e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 16:41:23.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2irxBH3P9Fs0zqlTFVQyrBUYaiTgJEUm/Tu/hlvCAp063rqtM855L4Lz8lN3NgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4103
X-Proofpoint-GUID: 82qazW_SUyaEJ4cMur7_34gKcTagGAT4
X-Proofpoint-ORIG-GUID: 82qazW_SUyaEJ4cMur7_34gKcTagGAT4
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

On Wed, Jun 22, 2022 at 09:12:22PM +0200, Jörn-Thorben Hinz wrote:
> This series corrects some inconveniences for a BPF TCP CC that
> implements and uses tcp_congestion_ops.cong_control(). Until now, such a
> CC did not have all necessary write access to struct sock and
> unnecessarily needed to implement cong_avoid().
Reviewed-by: Martin KaFai Lau <kafai@fb.com>
