Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E466934E
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 10:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAMJwN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 04:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbjAMJvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 04:51:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119F7A90C
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 01:45:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D9XAFm012455;
        Fri, 13 Jan 2023 09:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=e64gnMe8K4+JlSRn+5GcH3+U6gMkhpgeIBXnpbhBvdQ=;
 b=NgXodFgVacfm8yVPxcBPdnbeyyJgs1JZTUwnKaW+tI8FFzECR2UCxtnho0AZFwOcmXOU
 c5p549M9TVDlgmmMEine8xDMbWA+IHQ1vxfA31y5tnPj71Z88w4RzNViXlHLT8+ib8jz
 nyA3vSE8e9BgIorCiWdAQIF7Ul9KSiVsgky+LWFeHq0Genbx8joYzhau8l5CasvGIQrm
 qP3bW39kEs4WafzTauKrrptU8bh3Z9ylDuSGy2o9TQWv7x8fZX9jQaqmB2P7oJfG4uxG
 mUn+l1kQ7atVqlNxcrxYuOF2YjWtd8tXJN4y57szeQOkONJYyI86lTga4GDISBpZQ80H fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n28jaay3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 09:45:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30D8dQ7h012390;
        Fri, 13 Jan 2023 09:45:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4rxx6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 09:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES4iq0LILYe+pv1gIcG+hWxdeGfGDvzMuI99ySDpF40/PJivNebCVWYrPcBE9F+gHPotc33tDHNI9UqyHqB3oA50pdnC1B5TsuLMhcuFrljE588HX1dDgcZ5kWHLQqDYA68nsPWocOfzgOjB69zCCioO6ILjWEP2uQiDwl+6QloWr/wR4FQzou4Xeu8p/As/MCHch3xzH2wy/IwE3cYq9cEBKAH3FX16q6Or4mYajE72dJYTQ3xd+yBeJ8kYDFymHLo4KHqL9wsVSGbk9o0wRo5c4Rk9s4RNte49cGvgOkL2gIv59T6iq8jmwHZgqREnNpbJjWU1V8i5L1yGmMXQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e64gnMe8K4+JlSRn+5GcH3+U6gMkhpgeIBXnpbhBvdQ=;
 b=WOpGeFNXE0dhWz3WNxkTzoVXRAOdku7rmq5NAaz+HavHJGEbI3ZxJ1p3sNvigeVWRJFgZMnm83bCz9SG3F6X6NSeVTJxmp2V9Eq9TRX4CuUzg6ZcXIVZtiPlqktjyOKF538at0RDTlS83bHY7vUo5sDY0mg2BYHfdbHXSdvRJKvKTfRqbb+dXkoLEziuIltBK0BClSlqaW/qTh9407D2kdNp1XN9w4e01+Bw4qRIu6L8c+tyDSH196Ivk7AJRkYjFMY6J1X0n6RsgmJ4gwvbR9xfMoSGX+1JRfVcIhHqMmwTEGrKS3ahVpRkofBICCFKcc0Djc3igu9kYiXtyrqfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e64gnMe8K4+JlSRn+5GcH3+U6gMkhpgeIBXnpbhBvdQ=;
 b=C/0odL0LqNWXPJ10VxKIFaJVUW0aQaHkUhyS5qSntnFq9iv6aw8OrEvpg8nkGqxWDzqFEz+QLfGOaCkO1edxKd9CWRaB5IALoA3uKfNWfo5v9TFgxbJBohgpmy7rkQpwb9T/mWbRJyXYNGm6a2TtNkueukukXxIEMr+rSUCWD5k=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CY8PR10MB6562.namprd10.prod.outlook.com (2603:10b6:930:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 13 Jan
 2023 09:44:59 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%3]) with mapi id 15.20.6002.009; Fri, 13 Jan 2023
 09:44:59 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        david.faust@oracle.com
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <87edryg3zy.fsf@oracle.com>
References: <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
        <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
        <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
        <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
        <Y68wP/MQHOhUy2EY@maniforge.lan>
        <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
        <Y69RZeEvP2dXO7to@maniforge.lan>
        <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
        <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
        <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
        <Y78+iIqqpyufjWOv@mail.gmail.com>
        <CAADnVQ+b+XBukob0VAvxraUvXAf9zv8pa2R4QhRvjyULm9=zKA@mail.gmail.com>
Date:   Fri, 13 Jan 2023 10:48:53 +0100
In-Reply-To: <CAADnVQ+b+XBukob0VAvxraUvXAf9zv8pa2R4QhRvjyULm9=zKA@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 11 Jan 2023 20:48:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0013.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::18) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CY8PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 2163c333-205a-4abc-f3b1-08daf54ad5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oYHzbVhvI9saW/oap6s2xgSWH2nAjUtZPasv05otxPNLMu/GZjqiWVnRVu6z2fzEQaMOtiVvfPT8Teqj7Cj4VlhIZKqFiOy+SB45Va1GcRmorSjKkXhUdhYV3lXeuFS4qj2nwfUKSR6En4lAtT2MIjYUVGfdCPnuzAC2s70oQEMoU3/Cd4cx0C2w514tZzbIaEnS2gjTJtflZ3bqMGR8nAnnG++/Ow4WyM3p7h2lvvAXcZ5aARRg0A+KWFK46M8VIN4+YEyzqGMqSvXwtX03N1NEa4kFp1wUDVVAbzMw+OkklJv39dYsYshSDeH3zC8TpN4TRZMAQT0AeCsrhfq/7Xmt7wmFY5sKMWcSQ1bzpyiV1c00ILPRdn7WIRYT2bOIkXB4uCCel5nzbALGJfFi7avlb5/h4twS/EJaKXjq29jmu7i/92YE3bz9ZfDJ2FcOFjK+H9+sM/v0NZU3Zj4aIzoePemkPTo+t31wa1iU5znhQ+A1larF6+3488um9OW2QoeFJKbMNZggNl8L00krpNPV1ebnTF96+w74k+WPDcWOrecXpthK+tqClCodcSnKbMp765vgl70LO1Qdc2zGBKiFGvbLghP0/PQqR14nGeaRRjSQN5K3p4Eiu16Y5qfk8pPUKgyyo06vJDLK9qEvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(38100700002)(6512007)(2906002)(41300700001)(26005)(186003)(7416002)(8936002)(86362001)(6506007)(5660300002)(53546011)(4326008)(6916009)(6486002)(8676002)(66476007)(6666004)(107886003)(66946007)(66556008)(2616005)(316002)(83380400001)(54906003)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ULP3ZBlis+jrRN1BwNM/97x3Wq0BMRvmvjOoLOKK5EWDQ8Sanz+hvj+hHoQW?=
 =?us-ascii?Q?raeVjDbYrTLHGOXYbw4eAzODu+G49WPDRxPyLZrVEjrlDnBvd9amT0JBGSo7?=
 =?us-ascii?Q?yjPyk8fd16MLbz3VkOWsyMl70KlA/MhNhmSYX50gZA4dvtvvOVjQIoIUD/ij?=
 =?us-ascii?Q?4GmvHs1RhyQZASe7dSJVy34HFEa9PJuxTy1xUkitM2LQdnWSAQTfq+hFcMrO?=
 =?us-ascii?Q?M0a/fLq4Sdle/QYwInsQrtBkRASptsW50kcQo3KYrqdn/leQJvyFQigAI4vn?=
 =?us-ascii?Q?rEGhVYBm2Z96HGvpdzocqpcHvxIwpfEQUEXeWmS5A1ZUifSn3oOQpZmZPoy9?=
 =?us-ascii?Q?Q/bJrGRaUsgG3HHUxjliRkbiUXe1UdizsvYUITy0Em1YLuLkQVMfr2+kBQzY?=
 =?us-ascii?Q?h/R7K4SOYZozBTVAXczpzo8PrTqSzpeuFDNgNwRSOOCUC5q3VkvxBq08iQ02?=
 =?us-ascii?Q?JLWeH0cq0V7s8BIhBrr40/PmahPU0ozv2LoGOc50SXR6bYyTy5S573s+b0ow?=
 =?us-ascii?Q?iEE76igtfjMSCVyF17NFPe1lFYwOf/WcdQm2ruh/xPiE6w8zNOSB0Df6pP4t?=
 =?us-ascii?Q?zFkW2XeR6aMT5HBi78WbY4Egh0yhSSBgXTkqXbhKQRsfAtJ3YSShS4vyMJCL?=
 =?us-ascii?Q?lJ9vBiTZ3sdRopWnueqIfQgJl7qhVrfeAbO3BS1UHgLmG3RhHAnBvvc+xX5Q?=
 =?us-ascii?Q?LpEH3a3cEeOYIf43KlKkZczzXIodFR3ekhrdzt0x1/noHBw1zduW8TEM1Mhw?=
 =?us-ascii?Q?BRtNcKm5yK/2BOsU1WkoTUdatj0qXLAeM5MHS+GK81Fenf+3cKUwSvy7kUKk?=
 =?us-ascii?Q?aGZAuILK4Yj6grw6SZhvkkqMAUtH7SWgRsVloAaPXrXGOO/wrUCYH0Gb3N/M?=
 =?us-ascii?Q?jzCgEodzfAAosiBHAHsOlxWTG5CoMy+OWZKsMwFvRu6luFG2d3Z02r+LP2Ai?=
 =?us-ascii?Q?s4cS65KCnhvGDGuOQ6vJaK93d7+GnB7PBIq6E/JxYi+AR1/CGMj6bF7dJOO2?=
 =?us-ascii?Q?1FrzFKbmRTSb9m4Bcf1XJyGGIH9Ls5E4i6H/dP2AfNJUqdavDbOxv/RDe+gq?=
 =?us-ascii?Q?HIjC/GJLXfrrcnJMPbQeEYcYdVEAeEmdOTlZRw1eWfWSwvbXH8SgTdW6zrRu?=
 =?us-ascii?Q?LFB36daCwLrkppjyWNgxpIIGc2u84sLnSEnB7bjl5MD3415JJNnoqfcPX4Xq?=
 =?us-ascii?Q?8Lm3jXkctjJgjju+4Q9mvbVL1Qb+GpFOfHzDZxW2yNDyVMEf3N9iJN1J/RbN?=
 =?us-ascii?Q?y3ESShPege/IY7oEdOC6G6aLK2dcNkLLC6BTkYz+ibp2YNw3RmzH1bgOvhxp?=
 =?us-ascii?Q?qAtAlL6k0+TnP3cVCCa7aP2MQOYEJ0R+ukFhHWCWhoff4UbScB7xCpb6bTH6?=
 =?us-ascii?Q?aKMV4L9Q//4waPpkCP7FwLwJix3HlrHdWHMK6uf4rO5DnhLZrgW5NFRAkCsA?=
 =?us-ascii?Q?Ntpr+wPXHmBjfHWrh04NnUadpyYWxGomdl+1DXPCpZtAQP0cY1okEc6X6A8L?=
 =?us-ascii?Q?2etsy3tvB+07QdJvm0HuUVJEmyfGuZZ3oI0jDhxPC41eXm7tehgV7NCmDUoF?=
 =?us-ascii?Q?90J3SvhAJQZ4SSNGd10UDu+fvxA+HFVwyPyEH/zWAIx39rkXlQia2A3Onr7B?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vd8msdv238k/Aux/cjt9SlepDQ7uVLh+HzQT15hz8TuahibSi7ha36x2E9Hj?=
 =?us-ascii?Q?sDm7TLtXDz1zcDpHoPHwymAOCoSTHvbcjZzXqEwpbn0dTd5yx/H0Y7DGZKFC?=
 =?us-ascii?Q?8Yarmo/L+tlpMg0jTx3rr32wChiZNi9odYPVCGyBnGU2tecujbH7f112nlRy?=
 =?us-ascii?Q?OQVrm4nZwu3s5M2ShH8K/NTGbswiksjks3ap8nXJMzPOqjGHPVa4DgYsSDMz?=
 =?us-ascii?Q?kHCLj5gAG3UblCRDAMQQlnVBka0nTN43MtDlcBJIPDMlXWWQtZZVtgLbGCjX?=
 =?us-ascii?Q?nVT5OANY3Oo6xlPp9zrZWmkvljNLEw4acHspE4OWbahTIwR70m3XBCR7UGCF?=
 =?us-ascii?Q?PL2t2uE4bTZlbg9H64Nh3M/94nuIOJeMT54NXej5MDVsakN6Z/8nOBQvhkHA?=
 =?us-ascii?Q?GstfRel2OCd5TcEV4R/PTsUl8icycGHwBJ58/Di5oIFRNupLwhWNo17/FPL1?=
 =?us-ascii?Q?SlXn1lCzbfdQ1XTvWXLPmQohTclGS3pBfKEB2E179viWfqn9KwPiUFhxJbs0?=
 =?us-ascii?Q?IpSIJizmGKDstoPelMoUAyTfZrTMWjt50wh7Tn+Qtlv5VBcUS45E8VNJItA3?=
 =?us-ascii?Q?P4jBTtJ4+QHel2vEOxAWNk9hdoAZ50OUt8k2Bv/SAOZzxRfPw3lIvjEQTwkK?=
 =?us-ascii?Q?w1/xVp0GIOnyAzakwi0Hp5YhVpS2pI+veuvu9ybBrFyEMLmZhfri0lH8oZIE?=
 =?us-ascii?Q?gXykf6wrQc8iGWybzHECro9S414vo1rcdspNHuNpJvwr2+OJcuKuZDN5MOj1?=
 =?us-ascii?Q?9e3r/3Sf8KI07k+smOuhYxd9FU59pzw0NaAjw0TqCHws2UiFU8L1HVI1LC9a?=
 =?us-ascii?Q?ltkKNzt+QWIWMBcgtoZQ0V18ea/1Ouou6IflGhHfz0n384KK7XlL54tI0ogW?=
 =?us-ascii?Q?OC0eUyJJXCH9lYhbXLx4gounLLMc5VdActkdEedoyzI8mMQLbGb8cXbYre+v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2163c333-205a-4abc-f3b1-08daf54ad5c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 09:44:59.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgA6ZB25laCdcG1mB/LRpxpUmCuX9jC5nYngxYzhEwGsXI+n1eDumnkkRgR+YchhiknAulMb6G598Yk5AsgcUMr8K+tcMwEImnCk5u+2R3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_04,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130066
X-Proofpoint-ORIG-GUID: jmWSdzXF7E3JPoSjPbYnCI_wHZy3rje9
X-Proofpoint-GUID: jmWSdzXF7E3JPoSjPbYnCI_wHZy3rje9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Wed, Jan 11, 2023 at 2:57 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
>>
>> On Tue, Jan 03, 2023 at 03:51:07PM -0800, Alexei Starovoitov wrote:
>> > On Tue, Jan 03, 2023 at 12:43:58PM +0100, Daniel Borkmann wrote:
>> > > Discoverability plus being able to know semantics from a user PoV to figure out when
>> > > workarounds for older/newer kernels are required to be able to support both kernels.
>> >
>> > Sounds like your concern is that there could be a kfunc that changed it semantics,
>> > but kept exact same name and arguments? Yeah. That would be bad, but we should prevent
>> > such patches from landing. It's up to us to define sane and user
>> > friendly deprecation of kfuncs.
>>
>> I would advocate for adding versioning to BPF API (be it helpers or
>> "stable" kfuncs). Right now we have two extremes: helpers that can't be
>> changed/fixed/deprecated ever, and kfuncs that can be changed at any
>> time, so the end users can't be sure new kernel won't break their stuff.
>> Detecting and fixing the breakage can also be tricky: end users have to
>> write different probes on a case-by-case basis, and sometimes it's not
>> just a matter of checking the number of function parameters or presence
>> of some definition (such difficulties happen when backporting drivers to
>> older kernels, so I assume it may be an issue for BPF programs as well).
>>
>> Let's say we add a version number to the kernel, and the BPF program
>> also has an API version number it's compiled for. Whenever something
>> changes in the stable API on the kernel side, the version number is
>> increased. At the same time, compatibility on the kernel side is
>> preserved for some reasonable period of time (2 years, 5 years,
>> whatever), which means that if the kernel loads a BPF program with an
>> older version number, and that version is within the supported period of
>> time, the kernel will behave in the old way, i.e. verify the old
>> signature of a function, preserve the old behavior, etc.
>
> Right. I think somebody proposed a version scheme for kfuncs already.
> There were so many replies I've lost track.
> But yes it's definitely on the table and
> we should consider it.
> Something like libbpf.map
> We can declare which stable features are supported in which "version".
>
>> This approach has the following upsides:
>>
>> 1. End users can stop worrying that some function changes unexpectedly,
>> and they can have a smoother migration plan.
>>
>> 2. Clear deprecation schedule.
>>
>> 3. Easy way to probe for needed functionality, it's just a matter of
>> comparing numbers: the BPF program loader checks that the kernel is new
>> enough, and the kernel checks that the BPF program's API is not too old.
>>
>> 4. Kernel maintainers will have a deprecation strategy.
>
> +1
>
>> Cons:
>>
>> 1. Arguably a maintainance burden to preserve compatibility on the
>> kernel side, but I would say it's a balance between helpers (which are
>> maintainance burden forever) and kfuncs (which can be changed in every
>> kernel version without keeping any compatibility). "Kfunc that changed
>> its semantics is bad, we should prevent such patches" are just words,
>> but if the developer needs to keep both versions for a while, it will
>> serve as a calm-down mechanism to prevent changes that aren't really
>> necessary. At the same time, the dead code will stop accumulating,
>> because it can be removed according to the schedule.
>
> That sounds like 'pro' instead of 'con' to me :)
>
>> 2. Having a single version number complicates backporting features to
>> older kernels, it would require backporting all previous features
>> chronologically, even if there is no direct dependency. Having multiple
>> version numbers (per feature) is cumbersome for the BPF program to
>> declare. However, this issue is not new, it's already the case for BPF
>> helpers (you can't backport new helpers skipping some other, because the
>> numbers in the list must match).
>
> yeah. I recall amazon linux or something else backported
> helpers out of order and that screwed up bpf progs.
> That was the reason we added numbers to the FN macro in uapi/bpf.h
> That will hopefully prevent such mistakes.
>
> But practically speaking...
> The distro that does out-of-order backporting and skips
> certain helpers is saying: I'm defining my own kABI equivalent
> for bpf progs.
> In that sense there is zero difference between helpers and kfuncs
> from distro point of view and from point of view of their customers.
> Both helpers and kfuncs are neither stable nor unstable.
>
> This discussion is only about pros and cons of the upstream kernel
> and bpf progs that consume upstream kernel.
>
> If we include hyperscalers in the discussion then all
> helpers and all kfuncs immediately become stable from
> point of view of their engineers.
> Big datacenters can maintain kernels with whatever helpers
> and kfuncs they need.
>
>>
>> The above description intentionally doesn't specify whether it should be
>> applied to helpers or kfuncs, because it's a universal concept, about
>> which I would like to hear opinions about versioning without bias to
>> helpers or kfuncs.
>>
>> Regarding freezing helpers, I think there should be a solution for
>> deprecating obsolete stuff. There are historical examples of removing
>> things from UAPI: removing i386 support, ipchains, devfs, IrDA
>> subsystem, even a few architectures [1]. If we apply the versioning
>> approach to helpers, we can make long-waiting incompatible changes in
>> v1, keeping the current set of helpers as v0, used for programs that
>> don't declare a version. Eventually (in 5 years, in 10 years, whatever
>> sounds reasonable) we can drop v0 and remove the support for unversioned
>> BPF programs altogether, similar to how other big things were removed
>> from the kernel. Does it sound feasible?
>
> Not to me. Breaking uapi in whichever way with whatever excuse
> is not on the table.
> We've documented our rules long ago:
>
> Q: Does BPF have a stable ABI?
> ------------------------------
> A: YES. BPF instructions, arguments to BPF programs, set of helper
> functions and their arguments, recognized return codes are all part
> of ABI.
>
>> > "Proper BPF helper" model is broken.
>> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>> >
>> > is a hack that works only when compiler optimizes the code.
>>
>> What if we replace codegen for helpers, so that it becomes something
>> like this?
>>
>> static inline void *bpf_map_lookup_elem(void *map, const void *key)
>> {
>>         // pseudocode alert!
>>         asm("call 1" : : "r1"(map), "r2"(key));
>> }
>>
>> I.e. can we just throw in some inline BPF assembly that prepares
>> registers and invokes a call instruction with the helper number? That
>> should be portable across clang and gcc, allowing to stop relying on
>> optimizations.
>
> Great idea!

+1

> It needs "=r" to capture R0 into the 'ret' variable and then it should work.
> clang may have issues with such asm, but should be fixable.
> gcc is less clear.

That inline assembly should work with GCC as it is now.  Both compilers
use the same syntax for the `call' instruction.

> iirc they had their own incompatible inline asm :(
> It's a bigger issue.

We are taking care of that, by adding support to the GNU assembler to
also understand the pseudo-C syntax used by llvm.  This covers both .s
files specified in the compilation line, and inline asm statements.

Should be ready soon.
