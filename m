Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72D3C89EB
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGNRn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 13:43:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30190 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239756AbhGNRnY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 13:43:24 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EHV3CQ023604;
        Wed, 14 Jul 2021 10:40:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hOFph3efFRXl7JlttRwbJCJFFz7x4oV8xrGXd6dmwlk=;
 b=Mwyy2gpmo4SAhOzllS4M9rr/X6C1unGDkBIPog66N7SEKELp6giCUqaCDzfNaxS2X+U8
 lJCXy8TFZJJ6lpUwS5HM4E7kgEwIvt17/s0qEcNdLRpviJawQrGCWud1xDjCxOU3PdO+
 CDX8XX7ZwdLZ5utXahmAE0bRD+1TGC4FL1c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39sr5hvgm0-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Jul 2021 10:40:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 10:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSsshLHx7Go4ArSNFSvexcrQl/jNsWojCkxRYyWL196dE34DJmI0GlAxjKfE/SzTRg0VANdEr3zAirzo2twqtjTLU3jq2NHcTDppj1FChiZ6O/tjrs03RVaDgbcnUWnNho83BTyBC5eHCsTx6FoYIX9nWRGP8tQADJf0WptdqkGlD3aMrQcyGirxWyvx224Xs4XwmG3g+dQB1uE/t3GD1RZINLK7Hk6hqUnDTRIdrVca7TXhb3R8pbkdCudMVe8H2A199u42O0Ydv9FHu7NFPjvJsFoCPmkWrsVDJj9a4v6y+uxYQsqqWqCavcLXkGGci8sMW02Y9xTiUmWgtuDy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOFph3efFRXl7JlttRwbJCJFFz7x4oV8xrGXd6dmwlk=;
 b=Ur/DJxidwOXKxlq8RB6+rJC/zBiX4IjpL9WqEvHjEdfR2GyUp7lM5rOgNZ809/cYAQCpfuiQzh8/CwmiJ62h0yqzuAJTCjWZnXLGciGDzpGJl3l2/9ZVLXtj+1OPkBFhk+cSM+cTAmLEuQIdjdNRHkZ4SaBv/1UZkf0Rn89oBv2ION+z9zex0YcBWEFq0SG0ivaXau/LkjxLr87/0Oy4anFW+oqanC1kFHJ9LcD0Q9qAlsjbO5r2CBukhZlMKcC65p4eeeQtQhd36Crm75XHlwbkHiB45IbljGivXKIyVLTLHtPhcDanc9FdMlGTkG2s6uVVTwpT5KirFluiJB9v8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: amazon.co.jp; dkim=none (message not signed)
 header.d=none;amazon.co.jp; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB2191.namprd15.prod.outlook.com (2603:10b6:805:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 17:40:15 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1b5:fa51:a2b9:28f]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1b5:fa51:a2b9:28f%9]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 17:40:15 +0000
Date:   Wed, 14 Jul 2021 10:40:13 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf: Fix a typo of reuseport map in bpf.h.
Message-ID: <20210714174013.oksmjoc5l5bq4b5o@kafai-mbp.dhcp.thefacebook.com>
References: <20210714124317.67526-1-kuniyu@amazon.co.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210714124317.67526-1-kuniyu@amazon.co.jp>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a2e4) by BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 17:40:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4c0a5f-2fac-4458-d97e-08d946ee7095
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2191:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2191DB31279C015AD1FDF49ED5139@SN6PR1501MB2191.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yVML7Uw1pnBo0kSWHb8iXIZdFfDY3N1g3mD7fqPtNgro/ZGV/K7xpuTj8RIXQwOONOMYnZopSnr3jy22vvtRxRqLVyXTrG3/k0OpecNeehQOG40PK4ZqNz7Ls0be/Rfo3jE/PGURla4T/QFFlWEh1ouy6BCS3bkKfuVyvqsaKwUW/4BbOtj1TR3Kc92U3/o2W+6vxnczxkD3aYXayaNN/zF+34IaBZNLzBRH2gxLQCZ0KCpmm+499r7kpLXcTEozb6ByBKiahVf74dvN7HNJJcIEFdRgG/FUFSHyyql4D4Ql6N5sAupo1iRjYpkL1md6bF+VuBd3vdKYjkgj+3PpUuamQp0kOYj0swDEjAt+pk27kpZ2x2cINfeuHOnaY5HNsZCt8urYHiutpo3X1wfHu7kA8Un8yiE/hr1F/CzYbpH8B7NTAaDrclWDIKUwlHCybBfrm+t1zrQ2k/NKmOLznrPI4GhB68CLNsk7/3N6X9ucEfg5kbD/hl7EIbkRSbXEAnQbCVfirz0ffB2YqnksZg+nlA9EPxoUS2MzG4lVh3SQ4rAzdmlZvNk42l1iFMh3z9yRrv7C7r/mrrKapDrh5ujSlLL2j+fQrNFMo+JaMKKm60nCxsCmgavkvuD4v6AuGXpGMbCB6SOoiPrHw9Qtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(38100700002)(2906002)(6916009)(66556008)(66946007)(8936002)(55016002)(86362001)(8676002)(186003)(478600001)(66476007)(6506007)(7696005)(9686003)(54906003)(1076003)(5660300002)(4326008)(316002)(52116002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N3sliRXGrP/1a4PKWzxyW373dTX6I5qyrQRkYBK6EXf+GXlazvzvuq7a5vvY?=
 =?us-ascii?Q?B5kMeGGBCMe2XgTt9JmCsCCzuGH/NDStefctIBX2FLJJvusDzfS4Mcphu4Q0?=
 =?us-ascii?Q?/eSaBdfjKZ0kFJS2yDckiJDnYTHvJugA2ftQdp2HMa6IHyKwTTvqD0RAxfb6?=
 =?us-ascii?Q?wQIOpedGnsx4PPNoXOufue0IacPvkcnZSlpzFcqgY27riKNg1+XtjGA3xfau?=
 =?us-ascii?Q?6cwhLlVU5fymb10U225y8bllZBbmSecoAtscHs/0TY309PdvtXpbXbnBeJMw?=
 =?us-ascii?Q?sKdr5h/zD3XBf+0sNO0jqUDUEw4BABMloggAuJpltp6m/863p/71fA/cIVaJ?=
 =?us-ascii?Q?Wlp29yRLl3upkUM4QmXRaJ8FErBaL24AYbz7RW2OAEpOnEiqPwgqchsqQvKi?=
 =?us-ascii?Q?wnkS0DwUgtGaFhiSr72TnyIyWiBeCn9FQJY0lQ/vgBnORAqoO5bOyts7eKWI?=
 =?us-ascii?Q?8RE6O+6ex7Qj5sSgs40D1saUEkp1jnEjhxsW0QoDvcye2oK6oNZH0Yk7YtOE?=
 =?us-ascii?Q?vf5wyIfWNX+PjiI3VP50iZgdXm8vcWw8NloGZkpEZO+u+Kb6gOEWjYw/OMo9?=
 =?us-ascii?Q?XURdOpgus+dH1Fy+h6ZMjDgYLlU8WL51LjnSvfcUWo0UayLXA3tALJ+Ktu6P?=
 =?us-ascii?Q?NqDn3195l50SJganHcV+sBZRs6xuJBJi4TtSlUSFgyAtT+FayqorIt/U4pzU?=
 =?us-ascii?Q?bkEvrGp6i+EDV0Iy5FlEIxjkBIYVBSgcpvMMS+bucOUsmJ+nVEG8X8eChCY6?=
 =?us-ascii?Q?vrRRI0ZghyC/CcoCYzJd+DJP779CHbdEkcmMJvk2AZppgg5+gFycoznq6Z70?=
 =?us-ascii?Q?YRNsCMuihNn+pqUoeqYvsL1KM6v6eNrw8otpQdbQgGWUiyMXBM/DTPgW6Gl0?=
 =?us-ascii?Q?+xGohIJZB3rE7ik5ovSumFR+3eh5XzwxkO6jrL2WnQy1OTCmhljnKvC6u1g7?=
 =?us-ascii?Q?YRxi7GIc6uzdmkCiSgW87BFzLteF8gTpYSMe0l12duowlW9Sr95EoPGxb/8i?=
 =?us-ascii?Q?00ZRfX2cXdmHdkgjmS81PU0sh+e72NvPOHhRLni0ykmtcanylhCnhzGq9qcK?=
 =?us-ascii?Q?W4rUsrd0EiIdzZ46lJ3u0+24KLSiMfHpygmXLt18QvKKJymvd+/ZCKIFuFVM?=
 =?us-ascii?Q?V6FC0D6q8UA+3iksIgVeZmF6tcIzwQbapaoLNYPnTO7r3tH+GU4+CZnknqtl?=
 =?us-ascii?Q?k7gbX+P6PuU45A+HyyKWbS4xbxda9m8VxNun2qFmW1UdWXK7XLY1B/gyD8M3?=
 =?us-ascii?Q?55l4nULStzthsRP2FYTWWsW4YDNS+7Oyx1X4hGqzS8+p/MndwTgegugw7+kR?=
 =?us-ascii?Q?iINSWaBRcgwP6zTzh+xhi27WDdbtz99KC+N53odDAyKkKg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4c0a5f-2fac-4458-d97e-08d946ee7095
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 17:40:15.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMh+b/AyHnyCz1m74eyyRM4RHwnAjsVJ/AyTFQsXYjmCmd3gkdEw9vAEOpO39n7p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2191
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: QgFathzwzOwnD3-do8IhjrydGBGc8jOn
X-Proofpoint-GUID: QgFathzwzOwnD3-do8IhjrydGBGc8jOn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_10:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=713 spamscore=0 impostorscore=0 adultscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 14, 2021 at 09:43:17PM +0900, Kuniyuki Iwashima wrote:
> Fix s/BPF_MAP_TYPE_REUSEPORT_ARRAY/BPF_MAP_TYPE_REUSEPORT_SOCKARRAY/ typo
> in bpf.h.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
It could be bpf-next.

Fixes: 2dbb9b9e6df6 ("bpf: Introduce BPF_PROG_TYPE_SK_REUSEPORT")
Acked-by: Martin KaFai Lau <kafai@fb.com>
