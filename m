Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DDC6201A1
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKGWAH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 17:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiKGWAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 17:00:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A3B5B
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 14:00:02 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7LKqC7026797;
        Mon, 7 Nov 2022 13:59:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=caHarMrkvi8PPuLhhsSpZHj1bp4rZRf9lrySVDnQklo=;
 b=FhwQwVrYAYXFIEpdcmGmNCdluCCv40SPWjT6MIAQFm08AuuxZ23YVov6N2c1HvhoZPfR
 C91TMoEhGxvXyU85LOi9EzCINpuHNFdrdPV54lRjtlV3iqIfZTDSympbci7eijzgCF+S
 8co8JZIxBvk++ibLIvu+weNmtuz32yBo6cdp5el/imGzlZyRZnyUyLqBEnmyW7rr4SN0
 ipjcKUcxY4QLiqUtEvXgl+zO0i6nnCkiQAG4qchhuyxmHeVqXrxmDBBa9kyxWvw+vNoT
 8fydy9ivx9ikxguoAYOXzDLX+Io7Lqp4iLJqrxEEA/8tfibKjdIQGFq6/YLdljmTTSka 7w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knmxsu7j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 13:59:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egy3eoTcuiE6iUJfnYl9rZmdThFuZviEFlUa7sWsueUr2XIKx6tlOBuhWdfKTDmyV644nJr293uTmijaQPfSjZkIrr9la2qTPN24QbTMpzvhjjG8n1M8dpm0j1icJQyLPzTbFAKd7EaHIptkBZlsch0QegUwnPyg4XUuOQAOt25KW2Jdlxy3VzrDUtduSwyEy/gEZzNpeuGuow4v3lGMg4vAwv5UZqEZLYTLEnINuqrn6LqY0FJxXdFbVoOUJE9Ycly4km+OIc02b8uEMbaz8NjAjyQ5vywufXVrEd1BwhtxgccncHi9vTkeM+2jplCRKNrSqRNsIAiAly4tnAIE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caHarMrkvi8PPuLhhsSpZHj1bp4rZRf9lrySVDnQklo=;
 b=RibFq1/lWrHLaepJgtFgAm57rKnr3Ko5D4yCI1zSykyzNNRF086Q93tddj0Ft4Jc+u6I7XWuoai/G8hgh1mOzjeswy6GZtmF5OTVbJw92KNKPyZEb13zu+AxJxcG5nU4nfL3E1wulovPlzzvlj1IbOIFL3ocTEZSDpnujdzm9ZpW5aY8mpTbY57FTyuJ3zCBH5/MfRBrlipjdgri/PtkAo67OIiMdaWj/q7mHwzEA3ISKoo6vXhbIWTetsHQNAj6NaQE0MpDta+z+gWtRJXlIBcS3aE8VWIZZO7VZVNcQfHVn26hvfxmpzcvF4EMifE4z92hwytWVlkghmfQ5YO1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4111.namprd15.prod.outlook.com (2603:10b6:805:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 21:59:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 21:59:19 +0000
Message-ID: <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
Date:   Mon, 7 Nov 2022 13:59:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf 1/3] bpf: Pin the start cgroup in
 cgroup_iter_seq_init()
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-2-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107074222.1323017-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR1501MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dfcd63-b827-4df3-4f3a-08dac10b51e7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyfIlcgDJgal3n1je+LTZq/fuK+5roZcwT+ge44Q7vVq2/AOGDGexa3G2i9N03RT5U9QHHFzsgc4TyU+E90PhGOAAuHT3NjwzKY3paB5htewvXvbv09XkiXu1PMttnTo8BshSmmyAU+kSLZrA0BDedwzXtrLoPpVsxf5Lc3g78jzdP7AK0ZyHiYo61oZaVzJOIHBbOfLqyGhGJ7M5FOBWHUULU5mzIAdDc0k3l99xHp7GDDNBelxwxqmf49zL39owj0yQnZG/YE2p8vf4hPViUpatEnYdE63a8adDVizk4c9DHtDCiabg4okmI3CiQJf9BBJn4IU7HNZFOszdWajAK4QGAD2ipL8rHfGXZNBu1JUF+RjlsnFYuIX71fkF6M7ElPEt+kcGCpj9+ZGACmx2Qzq3ESk+6ojuvl9DlkyEW5YWQLpjEJlJIaYr2dZDaBZWaJcymvxaIsBoqnH7V4GnOjDQj7t8EsgNVcaQvjoNH91Xk+R8l4knpncTRkMNM6ZX7HhEm2pJObbNYyuPyJ5rF2RVRA+jDL15qxcgXciIZjuszMw0reSLHkMjZyGo85rXk9NizQLIGqz2sp8TVctSOvCxyxQU49a8TY9hZd7Tkrr92FFmbyu1w4k3J+nV+jCnlG4cX8udd8VFjzmxoUnUjNJoJ/ya0NifrM4T1vXNJVDIRvZl8xTCCoCAAvoEQCJl/TrGuSGNIhZnVHV6D/0dWUU8UBdXnLHUonnrwgXlc8Ul4NBa4om00CUXfJBnhz9BzpV0jtCveoIG9yILA1eChKJckqPpKjdE6JymG4oxrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(38100700002)(31696002)(86362001)(6486002)(8936002)(478600001)(66556008)(2906002)(6506007)(66946007)(316002)(66476007)(110136005)(54906003)(4326008)(5660300002)(8676002)(83380400001)(4744005)(41300700001)(53546011)(7416002)(6512007)(6666004)(186003)(2616005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlvYyt4Z0pmS3lPbm9CMnZGTnB5cjZsdEpPbXlKeFBtdTRlVWJuNklXeGUy?=
 =?utf-8?B?b1p0WEVWK1VzOEJmZ1l3VHkrRWI5bm91UVRzWUVPcUh2SzF0YzdQdWg4TFV4?=
 =?utf-8?B?NE9zSFE1VWdoVXRudHNQQWxZbVdSaUJLM0pBNS9JNy9ZMzdNN0hkai9tanRT?=
 =?utf-8?B?YWtNMTFNUjdxUS90eWdOa2NqQU9IUWlKVmQ2RllXK0lTMmlFVk5jekhEV1c3?=
 =?utf-8?B?ZnMwM3czSjBFODJjbEtWR0hEQTlpSnBRV2ozeEJXR2V2U2Nja0VsZ3JLMjFO?=
 =?utf-8?B?U1lYemlwQTZrMUdtaENhdUtjVjQyTzRhQ0F3NjFaWEFUOWdweG1id1pGcEJN?=
 =?utf-8?B?VlVuTlVEOVJhVjdrckpoei9hUmt5TTc3dTFqRVZ3UXpwblRXTmNhL0pobkND?=
 =?utf-8?B?OGxVdTJ4NXRaM0J5Snpzb21XYUYrS0R4M2tyUHA3ZktEblRvamg0WGZIY1Y0?=
 =?utf-8?B?UkVjMGlnL3dPNDBSS2tuUm90QzNhd2pXRnFvMU4rbENjSUhPSEVoaVV4dkg5?=
 =?utf-8?B?VFZyU0s4YXk0OXJiOHc2U2kyem85aWd1Kyt6aTF5NGxqLzZRaUsxU255TjF3?=
 =?utf-8?B?cFBRZXgyZ1VNNnNEWEcyNS94UnBaMTA1ckNTdWVVZHlDZHRRR0RlWmw4V2dm?=
 =?utf-8?B?VUx2RHNiL0Fma0lkNVloSHZjcVpjS0RpZnJCMFFuVzRyK1FmK25hTGhDdVhY?=
 =?utf-8?B?V1QxTmtzZnBlTkZYN1JqVmxzYU1RK2NabkEwM2Y3MG5vM0Z5ejJDVEtUbW40?=
 =?utf-8?B?YlltUGZ6ZFpKQUZucHE3ZGhDd3huK1IveWxNOFR0TkRYYXNHME4wTVpGdnJp?=
 =?utf-8?B?K1loUGFtMkNFVElhYUliT09sekhsVGJ3ZWhiUFhEc2hpQ2w1TWx4V1MvYmFy?=
 =?utf-8?B?SHkxWDlLTnIzRGxoV2VHZ21yZ0dJV2kvZjl1TFdUa0Z3ajg2a0swekJuT012?=
 =?utf-8?B?Rno5U2k2cEZQR2tGYXI0ZXQ4Tzdhcy9FdGdpQ1lFcmpBTit3NDZIckJGZXZo?=
 =?utf-8?B?TERnMDJ0V2xmK0lNR1ZxU2U5M1hCbDBMTngwQVBMNitVZUZxMGhYOTJtWWpM?=
 =?utf-8?B?NmJiWjFxZUV5MlA2cXJUdWJwS3hDVWoxQ215cWtGQ0Nwb3VnSHJOdk5Fc2Q3?=
 =?utf-8?B?MWwwc1hGdFgxYzNmaERGNTYrK08rQ0syUE9RQTh2R01ZcitrRWdHODZiU0Nk?=
 =?utf-8?B?Y0xLU3MvVTFheURaZC81MlNUN1A1WWRSRENQektHVzlsMXlrNzhVSHVMMUVX?=
 =?utf-8?B?SEZ5aWR1ZTZWTXU2YVFyTUx3NytWT2FmaWFDSTQ4LzZSRTJGaGpHSHFrUmRm?=
 =?utf-8?B?a3drVDU0S1AxalpVMnkyZEppeDMzQ1pkTG03NXhUQ0ZhaGJka1cwK0drUFBm?=
 =?utf-8?B?NGRyK3NjQW12KzFkODJIVCtaV0dueHppMUV1cDdYd0ttYVlCU3J6VnY1YmxX?=
 =?utf-8?B?K2xKWjE2a2E3VWxqQlRZUVF2K1NibmtuTlcyczF6bzlWSm9YVVlFWGFscnBK?=
 =?utf-8?B?eDE2ZWxmOXJaNkxheXlNdlBjRHNkLzBveFV4Q0d0cTRydzNYUS9ZYVBxUFZi?=
 =?utf-8?B?VmdOVjJZamFiR3c3Sm1iR0hnWkZkRGJmVER5aTRvTkU5enZ0clcrSnZCVktL?=
 =?utf-8?B?REVQZ2FBK3ZmbWcwQTErSnhtbC9lTVI3VE1FeGtRUXBpdTA2RVorUmZpblF1?=
 =?utf-8?B?MStnbGpERk9wZ3gvTW9KaFhwOC9qZnZnV0lGZW1JTVJDV3UrUXVhbjJFc2Z5?=
 =?utf-8?B?cWJvSHZYVE1vdS9NQ0puWTlXY1pUN1AwbGlDT1VrMnNJOEJYVDcwVzdoaXdY?=
 =?utf-8?B?MWorN0lSMHM2eWoxdEczaUNTL09INWhjMTZIUEZhaS9QV2xoazF4dFEvT0VJ?=
 =?utf-8?B?VWNsYU1jTWh2Tjhkekw4Qlo4U2lxbGhEZ2FzWGZhNXVwSDV2MGN6b2RSVmRF?=
 =?utf-8?B?N1EzeHhqcEJzZGFPS1dkT1J3aFhJSTdEcXlGNWdtNEJtMzJpSzhMMDFtcjJ2?=
 =?utf-8?B?MmM1MU9NVjZGRWMwRm1KbW1DRTkva09zMGxEL0g2eGYrcGc4Y1hGU2ZQREtS?=
 =?utf-8?B?ZzlIeFBWR1dvbXY3MkpiMktTUFBtUThOeFhJR0xuRjlpeG9MUHVXdmxhZ2hR?=
 =?utf-8?B?RlJyaXRnVFQ4UWtMQTcrbzFRTGdzZ1dHd1N3by81QVBiY0NxWlJyVWtsUCtz?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dfcd63-b827-4df3-4f3a-08dac10b51e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 21:59:19.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsroCABNIzR44BoCLm8/yI32mL4o4bHIBpoXMt3xUMA+jC++2tUTnzCeGQdXNqCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4111
X-Proofpoint-ORIG-GUID: 39C5VC9cTBS5lTeJl7Gkt1h1oZfcceQX
X-Proofpoint-GUID: 39C5VC9cTBS5lTeJl7Gkt1h1oZfcceQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/6/22 11:42 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> bpf_iter_attach_cgroup() has already acquired an extra reference for the
> start cgroup, but the reference will be released if the iterator link fd
> is closed after the creation of iterator fd, and it may lead to
> User-After-Free when reading the iterator fd.
> 
> So fixing it by acquiring another reference for the start cgroup.
> 
> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
