Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5755A58D9
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiH3BOf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 21:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiH3BOd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 21:14:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAFF82FB8
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:14:32 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMpSS0030579;
        Mon, 29 Aug 2022 18:13:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+uKmyUtVQYM4lDfNDCBFr/qVTBw60C/t1+xqpBo/DkM=;
 b=mUuLhEwkDGTnxNSoTTvC8+j4abSF77FBaXrJyTGC0OcYw5X0I5KNDyz0Q69JBP6GuM75
 XYa95C5zJ6IJMWBVWUkebfWCC75m4D2nBZis15NixPbzHacx57G71qMwtPVY6CbvMcNq
 DO453ZkXN3TSXwxpxQFt5L+Dbhk4EuEXbjk= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7h3uwh5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 18:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSqW2nDJo7lkHsKmIuS8moVnTyk9mtUtx9lpLfG57a3MH8UvE99o3hEckPqJAIFWjG8SZkkI64/pcUY4MZo/rHt9nDfvBCsHlIl5+DyG0mgReRUEaFKTJkhZux2zLEV0du61wqWm69JPvG8lZC8lf7aUODhj+p65FEeDqsMiIJoyMZtaP6c/YreGAC6B+FBNMe9wSQAUKP3TsnyzQo/fUCYfV8up65F/IwXHdzbdQc1odtpaNM33yL/k6eP1iVzIrzYZCkhhXcIiXq/1UqIMmVbutjvjM6+lCo1qzgdtcbTkLT9GlG+6G9lzKYvyNNThaYHlI7oE0y9v3X8XvMWBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uKmyUtVQYM4lDfNDCBFr/qVTBw60C/t1+xqpBo/DkM=;
 b=ONJPRZaD3sBqPytgv4nAOYSQipeRgMN5VUNa90HSvUxRtPpGIwpVlNaTINM3+hrwnSlboEP3xhsKvrgR0SgHlkue9mbNhkrFPZRC8//ju8vBL5NXAb/Fom5ieDtQ4hvVvemZkgSvSJrBtHb2B9r2JG75LkKtmiBVksR7u6Lb0t/UEAnC9pVWnL1uWeX68g+kGmaM2bR2bgGrtOa/n3uhFC5vzlpP4JJGPko2lk+N/Fc8NmuuyBEFYGeW8ZfkhkmBo6Jw7v406ShJXSYhNhwdkHNqJLrYIW3mSSG0w1qXy2S12OEdadkV7yisRztIVg/UQaL9FgBn/QBKMaHGRAYGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4628.namprd15.prod.outlook.com (2603:10b6:806:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 01:13:53 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 01:13:53 +0000
Date:   Mon, 29 Aug 2022 18:13:50 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Test concurrent updates on
 bpf_task_storage_busy
Message-ID: <20220830011350.ig3djlqfume5wqz2@kafai-mbp.dhcp.thefacebook.com>
References: <20220829142752.330094-1-houtao@huaweicloud.com>
 <20220829142752.330094-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829142752.330094-4-houtao@huaweicloud.com>
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe27b17a-c0f0-4989-fb3c-08da8a24e6c9
X-MS-TrafficTypeDiagnostic: SA1PR15MB4628:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh9HdmqXgiYtgmJUdDs+Sa77UZwqSo0Aa+VhQEC0b1kDh6vDG71O1dLOtkYedx2PQnzQmZYJJQAfqvD8jmBTujZRq9CWVVFaZFAj+WCOJ7KaAEil0MewIMQhTbIK2yiJ6FoJLt5wmnzewmbb5iPDTiswTJHEPB4HcRrmiz2U8h44/ftR7V2N85psOmDYc9iYo6EM29j+NCcT/kAkG/w/QZFaqCUp+P+RU/0K5I3BBbi6TULwhfjY+XPAH4bMNxgfql99H+n+NbH99VIq3HsinNxiKiDRHBje6pmkkZR0G2nrJdKK9jjIyyaYczU5Jhb+66Ne8SE6GDMNNxN2jGAExhu3lplz30xQ7igeBJJ5BpDa/7yWKCLD/chNCAxzfJESlRQN6XG+Wtxz7K/mTkSduLqGM/7tf+UGBEeeq7AExoow918v0dPzsgL3bq2ynmIYosmJIeseWTRcQPkgRTETqnNUSooWjxEgsaQZUYtcEg2K/1KYhxmoFoDl+CFkZCk0zqyv10i2AaeWyDh5Qrg1vWKF8TpX6yIGHJPy8TTY6WVFCo3UTqQjQ+IJ3ZkP3xv665SC8L1WlJvC50m8a4hX2yYVuzxlAaYj4zJTbejXHDl6MRZyUepRu3xTiv3KWz72IoTmQ152N2a8JYc7Xgjjbx2KDA1GmweyIqPNik90HTWt7SE689zBHxJGQhDBJzcqyWM0o5KsdXK8M5s40lWgcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(41300700001)(6486002)(6506007)(478600001)(66556008)(66946007)(8676002)(4326008)(52116002)(66476007)(2906002)(83380400001)(9686003)(5660300002)(6512007)(8936002)(7416002)(4744005)(15650500001)(316002)(6916009)(86362001)(1076003)(54906003)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJBfy+0q3tRb3K5BgcJTI/qz1qf/nDjQl4Y/b2QVYXYKtj7LlFoV1hsAU8ir?=
 =?us-ascii?Q?TXHhPAz1J2QYeaJcVYueaUOwgfpYV0hufLISD31pXx9War6JVuawjKo4+5wd?=
 =?us-ascii?Q?owKW6k4A2VI0CrehKfVyoRHPpv3ZoLN0iu1ELJ2FPSRHzoWsm5oqbkbDo66l?=
 =?us-ascii?Q?9jAYPunAsim3ULn/nges1F5NandzhWy8vf//SSmCw/1T7HxjFD4DKj76slQL?=
 =?us-ascii?Q?RFAl2c9/pmm94wTAnxM4QXE10m33+PBp2Ns+PkGirvFHFkdQXnKEAd4dgmzn?=
 =?us-ascii?Q?4X4zc4oTK6HxrwdyvOyf0Ai+pJFqpVqyQfTe86qO1L0Bot7uDPtVIxPcNxRv?=
 =?us-ascii?Q?VtEuSbMB78kIDxVyyzJ0bUtzw+R0BxcfR+VMyCJBTxCZOyr61TVX32tlSM7F?=
 =?us-ascii?Q?M80AL8KdsZ+w2VPBMz6cEcuefhLgPquQyW74Os64oYdmQyoDJhGWHfl6WEgk?=
 =?us-ascii?Q?Z2KXWFE/rWhgJ18CPxgvwtZhev9AUHEj8solVgPjpNXWrUoVMqkiY0x1sAev?=
 =?us-ascii?Q?NbnEAavHDrd342BRDIFx2PE9+rfzSKjf59R9sXh7D1DvgmUFXTelUPB8F4qo?=
 =?us-ascii?Q?F+gf1ZMbRybObkng27ZUfx4aeoZpQD4eP1XgQaP7QV5PoOriK13syeVpuXFY?=
 =?us-ascii?Q?BwuzKQYy8+Oexd5FoeGC2fVArYB2chEI4IvzCw+8XiUAoWP9L27nsw/ZX2xp?=
 =?us-ascii?Q?6YlxaS1GwiD+wZSqITabO4yqN/c7WfoRMPdwh1/CAbQJCjjm26s5js+PUT1b?=
 =?us-ascii?Q?4xy9+FSODEW3MQkKocqxDbe9HJOEixnBv1gl9NfXwj6gZ9e2ZxbbLVcqDnpK?=
 =?us-ascii?Q?aunDBMGfM8vTioyMtkRIUcXCKsA6XE+MRbEf/uVGKXKwEjAxA7HqftEkahLN?=
 =?us-ascii?Q?eJnNp/z6NU9Urd4/X2YpIA8OgqewceI239f6qF5es/tAfDiyFPSp+80Sm21Z?=
 =?us-ascii?Q?tAVkbzMn2+P2F7+hW9NI1vM0ipe8CMjdzRGZG/tDCRrWL6vnWqDZ/sjaBOEq?=
 =?us-ascii?Q?wkKZNrFtgnmu61qAJxgGlIxCy9QyerAAcPf0xj78LxoyBOIFA56DCnM8m6Fa?=
 =?us-ascii?Q?L+cVR/4xNhiK4OdTQ0LPUjF63RKntgHs4gEyRSAIw/4vXhGSWGJ/YmD3QF1Q?=
 =?us-ascii?Q?Nj6DUcGb1wlARwsn8dJ4J6Gly+JMSEjrCbpohEyw5phya+R0V5A60XQlhhlQ?=
 =?us-ascii?Q?OYYl/pSyvbpL73Uyn7SuMr23VBckF7odzR2Xb/0r+9U/IXv3a8PIshJuHVte?=
 =?us-ascii?Q?cpcyXeakPFxP3BusysEQHvz0ulxlYRiRgi6ZuI4l+9frxUAJP7F8tzcCmXGP?=
 =?us-ascii?Q?hNlygjUFTrMXpJo3X/FDvMtzS864PXu6LuA1B/etmQ+pfpWGUt40FuWU1iEu?=
 =?us-ascii?Q?Eye/WsluitndbA/ojGaIZzyQpChJOyhQZxSis4iMVOuLhE3gJDnyD8DmA5y1?=
 =?us-ascii?Q?hV/NfFvYvp0PwA06gjS8DClRR+Q+H83lp+emy0uSL5CpOMLzCa7f4Y2rik2j?=
 =?us-ascii?Q?T1U47TF6KNXc69HeGy4DX70/JXGVGvMRcSRIG2cJ6nXuZm/RrGvDnSaiWyLT?=
 =?us-ascii?Q?qxOqy1flwK1vMIepFeWjHJ2MfToqJqr1EmMuR8hrBGab2Ml7mqGoX2GX5oU5?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe27b17a-c0f0-4989-fb3c-08da8a24e6c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 01:13:53.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvQxO96hNcWt50nSiqi/bAsvJ4awnxF9MHFER7akNzBS+dHt8YE/ppDDrScH2ycO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4628
X-Proofpoint-ORIG-GUID: vhFRrZY9Q6c7vxE_ywiFmGWl57XVhAKw
X-Proofpoint-GUID: vhFRrZY9Q6c7vxE_ywiFmGWl57XVhAKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 10:27:52PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When there are concurrent task local storage lookup operations,
> if updates on per-cpu bpf_task_storage_busy is not preemption-safe,
> some updates will be lost due to interleave, the final value of
> bpf_task_storage_busy will not be zero and bpf_task_storage_trylock()
> on specific cpu will fail forever.
> 
> So add a test case to ensure the update of per-cpu bpf_task_storage_busy
> is preemption-safe.
This test took my setup 1.5 minute to run
and cannot reproduce after running the test in a loop.

Can it be reproduced in a much shorter time ?
If not, test_maps is probably a better place to do the test.

I assume it can be reproduced in arm with this test?  Or it can
also be reproduced in other platforms with different kconfig.
Please paste the test failure message and the platform/kconfig
to reproduce it in the commit message.
