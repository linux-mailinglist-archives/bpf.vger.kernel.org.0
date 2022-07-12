Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777A572168
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiGLQvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGLQvi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 12:51:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61DCCFB46
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 09:51:37 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26CAJIDU016255;
        Tue, 12 Jul 2022 09:51:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=5ogMJMSembMqnGFdCYihgWv3y6JQke8gfjkabRzJM8I=;
 b=h7FXwdCauxyqOMgdtY6IzXgVooqTSNJvPporXrKnZps664PG/bOzqq2z1HQ662MReGcV
 PR7QzJvBqwA5WctgfsHUIklR0iLvaDOqhSF7aj69M0mnS/HsO3aiu78GLBQfdB4PAyCI
 nRoPj8Nh1NIfipJwwIqX4POuIbrwRmMBh1k= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by m0001303.ppops.net (PPS) with ESMTPS id 3h973fjcyd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 09:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwGv2GcODvPsVPnG4OrZ1C8Vl2MsbQvBx8jtmrv8hHDbfhUYIGZqsJ9GGG/N6fnsf9zPVFCOm5YsOyyNrOvz6FinZAKJGTu4lKOVGaFjpbfWF3zkA3XVD31A3ALxdjeXSOFNgsTK+3/OF04UN+D2qVErKBgDrxUS7iW13dSEbYgIkBV/S974Ic51KfvG/mdRFZ9R7aWRYKSf+l5l+g/g0yDljYmTw3mpQopSafWHrBVRRfQexreatk6mUiqoYhPi1oqXsd4xg8zCzPXM77pYnpom97rM/nMAsLSJ34SvKYgsdHERbx7JtPv21U4a/KKCy1W4VlI1iQkVM3gnHMVyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ogMJMSembMqnGFdCYihgWv3y6JQke8gfjkabRzJM8I=;
 b=SIcOqCar5jmLC9MkM1UE2ce1QIA0uUQAPvO4eBQbct6QQDCyUFPFFW1dDj1MuUvs/SLgPoLPSG6MNGZLl8BIKd8U8TIlohjZE3NgQSddNtUYCES8zs1H3VMkIOBWziCAozr9aA+ZmtMo9Vnu5Cw3xn5Ikp7XjkolH8w2zfsvrwJaoReTOcaUT+CrD3tRk3QbCJlDoA5G6pUS46aGfCXgp17IeRu3f5oqJ9xaYfv1hD66zRiXdDJPDMpidOaizIB3s2otQppsESwHg9wceoq7Red/SIFI8gJbMhp6bh5vVzs08U7eDbY7cSbvevOXcAmbMdfm8/4RfEQeRpU3cWVtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 16:51:30 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:51:30 +0000
Date:   Tue, 12 Jul 2022 09:51:27 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     =?utf-8?B?6Jab5oyv5qKB?= <xuezhenliang@sjtu.edu.cn>
Cc:     bpf@vger.kernel.org
Subject: Re: Question on BPF's capability of changing kernel's TCP behaviors
Message-ID: <20220712165127.57wudg436wjtdfhp@kafai-mbp.dhcp.thefacebook.com>
References: <422556411.14152964.1657358050994.JavaMail.zimbra@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <422556411.14152964.1657358050994.JavaMail.zimbra@sjtu.edu.cn>
X-ClientProxiedBy: MW4PR04CA0359.namprd04.prod.outlook.com
 (2603:10b6:303:8a::34) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3827454-a66a-4cb8-f9d9-08da6426c4c0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3141:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emE2rxbhQYpzScbVfDR7wi1ShURelFjlWMOrEsaOWkNppiXU1K1nvsbGxFdXIyADyMJTQiYRBhevjnQ7/oIOHLnKAK6TD0/7utUBuCpF2kj4hzTgg2l8CmlAOutTYIXMeH94PkHWNdWKg6uQQXR5uCYB7gTk0oQ1kvIOubjpAziOwef3XNkdRxYVMUkyD+tVyVkVKEhrJXj9tEK7Sa9nf7ey3Nr/RtZdxPkfpC6oGUiZp3esIe6cV7/uWAKmMKMBBYi5aRthUKf7P4C2rd5SzwYUn0aThtTq6xddnwU9xOxL/eLOiMMdkroqzQNfPLKIhiAxAFE4NagfEC8QSTUTGV/wTpaPjxyYGCBpkrEGnVEqxpp3u8dRMCt1rJmSqT4+Ex/Lo6THTbhbAk3pX5HpgCxz50YJwgM6cuDeyIUry/z4BzTn7rkvy6s11fxt4rclM8qwHpoPOTF0xwhJeJvUah9BfUV3NF1d4jswHJm2sBl6pmi9PeH8OJm+CU/zZF1uz5vgTO42hF9UJ35LH5Yz/ePoeI6lGX2J1X/kkFqsO9ZhTBYIK5afGvHA9q9etnzYDiATibikAGJKmY2a+0L9x2pLNKeXgVZM6mygDh/ZNftPRsf+v5E6jfGRwJ46l1XjsXlV3Hm62WU/eBMmILzEGQmrRKi2ByDwddSvlbuQshxdCCqWtd2q/8qaTLxNvdFV9fM37VjSYQNeLtdccZf7wnGdCT05Skn72LdOgPH8IdeuYUXZWoMoL+JA3pPBGjaV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(38100700002)(52116002)(9686003)(1076003)(6512007)(41300700001)(6506007)(5660300002)(8936002)(4744005)(6666004)(2906002)(6916009)(4326008)(316002)(6486002)(66556008)(83380400001)(66946007)(186003)(86362001)(66476007)(478600001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWlERUhueW5XcGNQZWxrU3J0OVJLMTZ1OTNIN2VNRGdvL29OTEZydEZoRUh0?=
 =?utf-8?B?QUFjS1RueCtlZThwaFhYREhWMFYzZEc0Q3hNU0lEUm5Rb045aXIvU1F1Y2xa?=
 =?utf-8?B?WlVOOVYvejE0b3B6bGwvcXFyeHYzeFV0a1o3YmFhZ1J2cnlMYkM0MzJwdU5H?=
 =?utf-8?B?bERnQ0pqMS9WKythUm9tY3ZFZjcxTHM4KzV3YmhGSXEzQk5qYVExaU9HWTRz?=
 =?utf-8?B?bk9YSklGbHFPdlBVeEtRUHhBZHdqOHFqM29YQ2xVRkNteEcyM2p4dzl4RUo2?=
 =?utf-8?B?K0tIVWdZenlGVy9qZDVKQkNmWUd3dmRKWExFTWl4NmZIUzU2NzNCQm5aRnQ3?=
 =?utf-8?B?eklYR3N0eHZnOElqUnJxWEhTVFlWbjhEL2NKdlRTK0pIZzZwOGxzV3AyNFNq?=
 =?utf-8?B?YXRxSTNSZXZ4d2xUVkN2YWNxZk1tNFZVWWFEY1lKa094WisrQnJSWkcxOXl4?=
 =?utf-8?B?dW1jRnJRTGtpMXJ6Qi8vcjlHQ3pMRStNUDA1ZThBSENEdHdHTjlDamVFNFlK?=
 =?utf-8?B?Z3J0SE9CTFczeEZ1ZUVXMjN1WHkxSWpsMmhwREphMHM0UXhnWVJVc2owU2ZV?=
 =?utf-8?B?T2RVREFsRUZzSXRNOWpDQjVBeDhTU0ZXNWVxeU9WbFR5Um9mV25DdzhkWUZa?=
 =?utf-8?B?UGlpVFFYQjlQSXpSeEVoK29aY05GMnlGODZ4RFBSV1RFMGIzMnVZMmF6OWUw?=
 =?utf-8?B?bG9hZVFTZThra1VCelZ2QVB2QjVzY3FzdCtVTkpWb1JVVDlvczBVcHpVZ1dR?=
 =?utf-8?B?WXU0S1BwR3UrZmtORy83M3U1RGwxbmhFbEowTnhTN1E1Z1ZEcHltRUxJcmYv?=
 =?utf-8?B?TWJ4a0NWTG1pUXBRbkdueTJ1ZFJSR0NBcHVWdk94TVVUL2Zsa1Brc2tlZEJW?=
 =?utf-8?B?Z1lmMkV4VUdqU2lsQ214cUZ5WEFWbmlBNDBjL1prQ0RUcU9RVFBxZzE0MUtK?=
 =?utf-8?B?cVd4bVZ3KzJvOWZnb0Q3VzlYSUlUK3B2S1IzaGRnNW9aOHJDUGs3azB6ampy?=
 =?utf-8?B?VkpnZ3hvUmI0K21CZ3lLSTdDMjB4bnh6bWtFY1Y3SUdlYlVpcCtwdFlPR2M5?=
 =?utf-8?B?bHkrS1RKNzZHQmE0MnlhbmE5RGJncmcwV29XdEZpTm9QVGdiM1BRUmlaaTgy?=
 =?utf-8?B?bzJPV0JhUGxNQUx1YnZacFdnTmtOU3VMenhzdHowSEY2eXRDaE5OdlQ2aENI?=
 =?utf-8?B?RjRRc1p3dzFWQWVvc0lVMEJIU0Z1R3Ztd0ZONXA3TTEwVEE0dmxQeGdoZEYv?=
 =?utf-8?B?OTgyMVRJUmtZblRBM0s0RTlnYk9zL1BqYStCRGdFWmw5bEU1aVNodWlUY0di?=
 =?utf-8?B?S1NncHk3ZkZUL0JVSDhxdGZpNUxVcFgrUlRmdUZCZzBOQzlYbW9ab0RNSGUz?=
 =?utf-8?B?aFBXUnNQL25Gd3IwM05ZUWpDVmcrZ2k0aEwwTWkvUDRUcDJoNC9tQTM2azdM?=
 =?utf-8?B?cllldzBFbEN1WDR0b2MzK20rZ2JlNTdLWmlYTzBaYk9pOHo5dmJBV1Zic3Z4?=
 =?utf-8?B?SG9TQzF1UVVreXh0aUtRY016VEl2QUJaYnpkWVpkRG1JSTNPcnNBOXVKaHhr?=
 =?utf-8?B?K1NwaG5VeEQ3NktjUUViMTd6TWNYMlNCeS9UL3VPL0lNbFVKeVhpYWl0OS9h?=
 =?utf-8?B?L213Z2h2OUJWblJQWTlnT0NTZC94S21kbndlU0Jaa0tsZzFvYTlTUFpsYWVZ?=
 =?utf-8?B?MHAzSk90RytqanA0Rjl1QXl4UUxhQnUycFJmWnYreXlaYTUvbzBhU3lLWnc5?=
 =?utf-8?B?dDdSUmRoZnRvV0FtMW1lVXVlWjcvZ0RHbkNvZkEyQlNNNmhTMTR2Q3NkOVBp?=
 =?utf-8?B?NTJneHR2TmRNREYxOHY2V0dNcTcrekIzd0RjY0VYVit1V0ZEajhwdkRhcjBv?=
 =?utf-8?B?ZjRtU2ljbk1BZlc5MjY2M3FUQktEbUFxZ09FMmpTblhGUmZwUkJmOUM0djBG?=
 =?utf-8?B?WFkzblMwQTdER1JadTFkbzJzV2hkWTlyblJwdHFxSHFhaDJlQlhOdUkvcEZX?=
 =?utf-8?B?K1BWb1BLU2pWd3QzSElqVnhNVFVNQVo3c2U4WWJaeU1wamhNTFdvUUpPVzNR?=
 =?utf-8?B?TkpxWFFiUGJtQng1VUVIQWRiZDYxY0JDNjdSZEliMUVBNFBiNnlPdGd0NWRi?=
 =?utf-8?B?cWhpdkNTYXdCOGI0eFRWNVBMM0FjaTEyUE9mTTduRERwYnAydFY3TFl5L3BO?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3827454-a66a-4cb8-f9d9-08da6426c4c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:51:30.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjFFGwoA2N9aMHoRWQCwD9ZKJbxQIjUtVTnGL4IWf+EqYITMy81XKnNQx4vhiEI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-Proofpoint-GUID: QUyJyBAC18GQZqdETDTEezw1eX3Nxscu
X-Proofpoint-ORIG-GUID: QUyJyBAC18GQZqdETDTEezw1eX3Nxscu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_10,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 09, 2022 at 05:14:10PM +0800, 薛振梁 wrote:
> Hi everyone,
> 
> We think BPF is a great and elegant technology to experiment with Linux network stack. Recently for some reasons we want to change TCP acknowledgement policy so that the kernel acknowledges a byte only after this byte has been read into the user space (e.g. via a recv syscall). As a comparison, a normal kernel will possibly send an ack once the data has been read into the TCP receive buffer, which lives in the kernel space.
> 
> We're new to BPF and it seems that there are many different types of BPF programs. We're not sure about whether BPF is capable of this task. Could you please give us some advice on which parts of BPF should we look into first?
BPF cannot change the ack behavior like the above description.

For other TCP tuning, BPF_PROG_TYPE_SOCK_OPS is a good start.

BPF_PROG_TYPE_STRUCT_OPS is also used to implement a complete
TCP CC (congestion control).
