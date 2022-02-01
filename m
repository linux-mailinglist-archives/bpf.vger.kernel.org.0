Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F04A6504
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 20:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiBAT1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 14:27:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11506 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242391AbiBAT1y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 14:27:54 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDoTT003754;
        Tue, 1 Feb 2022 11:27:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=x1Z70isQm9sK7nvE4K8CyQ2EnimBDT0QEtmyZX/2hJM=;
 b=l4T8EjWwEyeOluRgAeUX2vv870x/M2uh/quGPzi04sdOxtg8btFyQ9/s26wbt7iIKOv6
 +NCpXkdZCWaFVlwnNgIhBWQGGHFu3ksYxZvSfLbX4d5bPBq4ttJcaK1dtsODJFy4CNXQ
 up0BW7eqor7CJ4CJV9J/n+pxaDY85r2S01U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxqxb6mf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 11:27:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:27:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byVOrtww/nAhQy0QdVaVeGmcyA6AeXLTMbtpTdO2mUaUO4K0R/WAiwB1cBmBbt9m8KazUwNQfBb4jOsWsjn32IyCU4sinNs4dXq+oo6tangN2Al3vkG9aFtZ3GhpqhWwPclEWexDEd1NIBplNG5Q9Uf2EisQVrXE6yd9B9XmLVPKxsI1s1VxwEYrhSLWgsTIocJGtCcvKM/auZnODNFO+qCe7gx/BC4s0Xfkhq1AKFroHCLEqHy+SQ0O01P6xbh6Vohe7qepXF0HkNq25aA7wJa21AL6Q5n6vC66yC8JloaUjevt2ATI0MWXyR+A7rYRZhZ9O4IWzCYJu+hlltVnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1Z70isQm9sK7nvE4K8CyQ2EnimBDT0QEtmyZX/2hJM=;
 b=QeHoUVsR9sA5CNsDwmkzmZuMPG8LTWgpLUGsFfzl7ttTtPGjMk2xg0isLNxU8fKq8lyK/crbPgo/NbH139AnOjSvBFXOl++PuEuvuwnZLtcNH2s1FCEj5pe+LnqXqevtuZHQFGD0pkD3TU08niH3gEE3lCNYi+zBwoDwQ7CWvtat8H8P8m/ZkFIS+TvXJM5FybIR3gdOGWx7XKtQA5KeYBZqUlLroJ0xArnZPX1gOsmQ32onCScokqmvWJ5CRC5MdDMZToOMpk9X/NCaoEmFm29AGSzFEDkCKMPJ5xhH3rSvF2bpZYpmmBVs+r926I30B5cN+LQSOW7angNRDxi2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by CY4PR15MB1704.namprd15.prod.outlook.com (2603:10b6:910:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 19:27:33 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 19:27:33 +0000
Date:   Tue, 1 Feb 2022 11:27:30 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: Drop libbpf, libelf, libz dependency
 from bpf preload.
Message-ID: <20220201192730.gn5x4wllpkr4dblv@kafai-mbp.dhcp.thefacebook.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
 <20220131220528.98088-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131220528.98088-8-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: MW4PR04CA0222.namprd04.prod.outlook.com
 (2603:10b6:303:87::17) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c39995-c855-4d42-49c1-08d9e5b8e4ec
X-MS-TrafficTypeDiagnostic: CY4PR15MB1704:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB1704D97F1EAEFBC6B486632AD5269@CY4PR15MB1704.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6jC8Yb5Cd7epFE4xq+n7SZsBqx8ZUv0/IvBzgV0bnS4zHTmesNPXhDAk6IqnwagD7CGSv+GwfpJ4IgjzeKBh7hEdIkdO09+FXSojRLmiSaOIh/g4HWup339Sg5ZqaQIxgzr30gsqr1imbjgvy53oINGi5qMA1Q1Qmk7K2xZjSHDwEOEIs/e9CCa9o8X29M6+Qh90LU9GBY0KkVCyfVGyKZie4VjgsNbJJUoLRk9OotMee6IkctQK/K38ivARwZ4GNGZ+a9oeOyzjxbDuCxfcocLre2zF4uzEINZCMqei2We/d1UT70Y/LBGOQqvKcQGdz8QFtWTTIAYRmky43pjLPZdwZsa6vZEoGFOvOJI/v1gmg7CtBjXBZ1Mz8cqFB38q3482DNCpPJ7bD1cUgAjzQugOsQgiFYE2SiWM85gmx+HIN5juYEb8uaId2smzmjE0TONbd0nGp5j8UQMySVMyIVgzTRpYiB9n04fRShKjVphnj6tw+4qcek6IeAd71tjYPfMpiBOroLKaWaI5sbHCPEuLrggmPwanQsvfKZuin8Pn0LePMWgNaclfytL66lXrlMfAX0dClndm2Gk6PC1nT6Gn7bbUTO3cmQwbhPXX+gsBnnAomEOhAhqGCSea65aTzEr4J1sVfjjCAYL8pwelg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(8936002)(6486002)(9686003)(1076003)(4326008)(6916009)(66556008)(66946007)(4744005)(508600001)(186003)(316002)(6512007)(2906002)(86362001)(52116002)(6506007)(38100700002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AXKwThbJE4xIJfofTfXcPHiIgWhgXSH6EG5QlvDVUC+50we2k5FRaqW4V65/?=
 =?us-ascii?Q?5OjHh+120dMv+lKcku49AuhmWswZr7gE2ydsxdQPSNd2zf/EGuOYeAZAKQie?=
 =?us-ascii?Q?QGOmhVmnhE3GyYVU2eC9un0ySQaNBKTsp4AAJvF7v1PoenmRrP8EPmCBKnQ/?=
 =?us-ascii?Q?/nxto7E7oOGMuNxP/hvU817R+lynhgRwZOA3NQNgjDfw14PH3oidm0g6I4li?=
 =?us-ascii?Q?rgZ+ivYTWvHat+IzxPTrlzE8hWDPNV0SPZ0pTfw8/IxyDqlMs9oeYbMnkQF+?=
 =?us-ascii?Q?X6Cyj+0YsJfgGix8iNR2y5mXDniN8IWYcdcqmxsLIO4HPFMvHm2aVK2aNdQD?=
 =?us-ascii?Q?bRC5QM95bZYfdbLGaWKbmWsuObJlEdVDAnkHlpAtrNLzu/pk+Tx6xH7HEoqN?=
 =?us-ascii?Q?FCr85gxdvOUGPjeNp7940fNrhtjG1tgoEf34A6Das9luS4NIRzSp4+jGxWyn?=
 =?us-ascii?Q?VpJSeA/DquvveV1dYtGXldNKNAK97OGPCoWAnFruz8i0JH4GfatM+fX6/9f7?=
 =?us-ascii?Q?ChLbfvFdgZirfgmg5EBNgXq9vc66w1aqSUBc6L0mmunZGh3S31th9xhwpp/Q?=
 =?us-ascii?Q?Un3kcXql9Fr/9jpwkyFXnE1fEH8Xs5PIV3nAgggc7LV1tHRoOXO84dtjFU9u?=
 =?us-ascii?Q?POZaKhnVg9WLQnLy+9lNJnAKm9LCKfhvT6n1wU7y896IZeoVtnLy8fZv12ZF?=
 =?us-ascii?Q?PwvC53YoW0q8dnnw6+EK5BGUAw+gDDaOcVpiMsp1h59/ydcwIYkvAqbTXjZ5?=
 =?us-ascii?Q?yS6C2PnpuHGaKttpYFiJiuORHM6hyoeJvoQEfjhCyoPksvjOwOryMGSy9z5T?=
 =?us-ascii?Q?0+PoxWLTDCWRaP9YmFnJx2Al4jEyFNDy3jlu88QmfAzT2XCr+v27akdmUcbC?=
 =?us-ascii?Q?5paZC2xynPhGOZ5xGlmResN1AncLlWCx6x4wAG6gebzouqUHq0mBXtnYQoW8?=
 =?us-ascii?Q?0O9zvn9j13uV7bGEF5irKzNqg5PD9B6qhMMdI0ltqL+OZnsx9t+TV2XV4aw0?=
 =?us-ascii?Q?2yWztNDaPJ9VMyozJK97GjDIAN3LO69xcLWg727JQEgo8Jd4t/r5sOVf4GDq?=
 =?us-ascii?Q?TrIr/9UdkQA7zVF4+7mO3pSHZ8ZW1QfUwP/4zYyPlTAC4XqmBbHL/GLuKl9+?=
 =?us-ascii?Q?US6c17UBchhMAWkuWw8Ibf9UDp1lD9E85JQtUXLcpaekgtFAZ75uw6bdZ7aU?=
 =?us-ascii?Q?/l/Vs/FzZtIeOLt6K1+DdbXobeAOS3mbyiXMKxJJilMc9rWvmE/ZNxPfqz6A?=
 =?us-ascii?Q?oA5ko0XRRBk8QVPVkHaL2qEjVVnsXoSvoueI+4hR3ptVqho6ysoWqXqbaynA?=
 =?us-ascii?Q?jT+68A1mrq22UoDlM0hGaDLmfiWU+VwxDdaQTa1GV8+QYL47GoULPDTF/sk9?=
 =?us-ascii?Q?ZTUIC07joccL4IqDp+WmL37o36mQDO/g5q45Tqm+oiMDhS9xZ/MM6LZ7gUc/?=
 =?us-ascii?Q?VAZNPOrxMACKG5PGZ0mQG7inVWnjW/ce5pbLczLP+TBOMYdBRtAIpnFMmau6?=
 =?us-ascii?Q?ZUG/PkR5mOuQAfyIJiaNEMV1P150lVnBSvBFZFxCWcOgtyYb2ma6Efr5Ajn+?=
 =?us-ascii?Q?yWS40EfRBA4q0Y3jlgrBZrIAKLGUf6/M/qU7lBr7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c39995-c855-4d42-49c1-08d9e5b8e4ec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 19:27:32.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oipYvqxg7pRV0+glRhgaX3mmYQJIG8cJtCseF2tolHeTfJHNRCEAwut1Ey9W/rjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1704
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ULQfYwxoJ05n1g7SGm27kJI7hwk8K_IY
X-Proofpoint-GUID: ULQfYwxoJ05n1g7SGm27kJI7hwk8K_IY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=547 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202010109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:05:28PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Drop libbpf, libelf, libz dependency from bpf preload.
> This reduces bpf_preload_umd binary size
> from 1.7M to 30k unstripped with debug info
> and from 300k to 19k stripped.
Acked-by: Martin KaFai Lau <kafai@fb.com>
