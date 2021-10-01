Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EBA41F5BB
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhJAT3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 15:29:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354753AbhJAT3R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Oct 2021 15:29:17 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191JFUpv020268;
        Fri, 1 Oct 2021 12:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=arp5nhKveIAi7+SpMO49LUKcsZBszBs2mH17x8Z01pM=;
 b=Q60NA5jr9F+dZl1M7GJyyTxxQTf1NdXxUIXeFRVOg9t+bfLXN7gQWPa0WLEPsGQCSRvV
 4YnmRbe1WnjsJNm03cTl4jjelpe6wIEfdAnoui9qZ7g32k3ePKecSKbgPD9h/EBODSQ+
 va+uV1g+u6+3xmqT3ikOETAIjHFYo6HuKfU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3be8ax829e-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 01 Oct 2021 12:27:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 1 Oct 2021 12:27:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhOm6A/JQ46L+Btld2g3shqBQBDmt59uSYUZBDSBxym377ddl2QAg4dgW5xOXPa3twXdV0q9k9rbLxg5d4zUC1Q+N+qqHLv4ZNKyebhVEGwYz1wHuvmX4u1CZok8QuyI89xFy+C0kZT8eQu1ImVSSUstlwyEhxG2cEEiHXcQfD67E3fe5ycZx7hgqsj89/9YBMEKIUDVOBCDEOZReDdmP1h0zjLiycL4GbgYVxNFSka1QLGI51bQhiUxf8N74CRepFScp9kCh0LkRkPbvpNQDXkO4b+Gp4sjEuc4vBbNcUx/ssrZ0E6JsnUQ8DtXdAs08KkZTJ5X3yiOncqOJYRf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arp5nhKveIAi7+SpMO49LUKcsZBszBs2mH17x8Z01pM=;
 b=Lo9k2og4CII9zdbBnAg0tqxxcO6BiN2WdYS9O2nN6qxeKOmeT1HsFTAs8u3o2WDrC7NG5nzyT2j12XmrkuEGgIoqcUuIm8hkKobc4uFK4Pqdcw1o/AE7hdoPjKpydK1CXACWGY8B/mQyE3dIIscvoHysLvoeLSuFrBG4P8KourqNES4sHG9h+iAyhnb949iDNk185YRtqkJBgUSDah9wVFixzq+hjeIRnucgj0hrJ6vXzGmsLWXVgKzRbkq7s2qJn4kD/6lt2HXVKqL23DT4B6ugK29tJFpkME+iOg5/X75/gkAU9VSRzu3bOnAYlsnUzpCIYFIG6mvxh9nueIcrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4984.namprd15.prod.outlook.com (2603:10b6:806:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Fri, 1 Oct
 2021 19:27:16 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%6]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 19:27:16 +0000
Date:   Fri, 1 Oct 2021 12:27:13 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf] libbpf: fix memory leak in strset
Message-ID: <20211001192713.mkc4a3ethw6ebc3n@kafai-mbp>
References: <20211001185910.86492-1-andrii@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211001185910.86492-1-andrii@kernel.org>
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c090:400::5:8bbf) by BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 19:27:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b6ccbc7-4d4b-49c1-f674-08d985117a3a
X-MS-TrafficTypeDiagnostic: SA1PR15MB4984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB49842B981B4E660B15EA7B84D5AB9@SA1PR15MB4984.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJKUVUlMUGqktquS99OBvrHuCm1SFtCdJ1/UcLHFiAEe8z2orClvtQr310Wy7LP5sfzZqKCD5VZCIieEq73qd+m2JsKFM43olBoc/CheeBprj2o1X4RkbKnsxkXrWgH+89KQgKgzVsVu1YGwZuVRz2aCdrvjTiKfSi2w/bdY6teIx60IRi2NsQQxCwAn6hksQ+ZgpoTwKdHQxjVApaZbNU9lYGjCfPgPkLD4eaQAnMAlW3stfP8Jm+EK8b7XrQsUD6ycwu9G/keXbaQz/tHxMBZ3047VJEXgZgsmWsYxqPAj4LGocE5V5dZUXJb/eCu5U61cqZxD3Sg2H5nFPbEJp2xfPaCHEXbqsbgS7TsJivvlb3bjPRSIz5M86DZ8lCys2/xv+9iJ3iNYa3YWYSrYwXewYd/0WNO1TBPmlPLa71gTFecjQEf3JBVgrjoKNp8zMBQCZ+0EmkvlL+9LIBUHp8V/tNJ4IY2j2tIPggKyADwX9vSXmX1lkljyIpwuFAz8It2I6mfPSf6gofkTL6iPyyLjNws9yopI4iNFCB6b9p+CznFOp9bFFrdpiiPDeyi5tSH3QzsPRrtw2XdHtJe6HCMA3M5AwU3YalozWLMSv4s7zdHBMwqH8hhuWNB/Xcy12Ivr/LeDCRcMBZenHr6fOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(316002)(8936002)(4326008)(66476007)(66556008)(8676002)(2906002)(86362001)(33716001)(1076003)(558084003)(508600001)(38100700002)(9686003)(186003)(6916009)(52116002)(6496006)(5660300002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ElnC+MTVAiqwQrotlocAWlUbxIS+GdwWMP05TCIhH6QflU0Qu2kmFelxh2X3?=
 =?us-ascii?Q?NOxvTD0ZXXEWq7OBY9ibY1AluXlJYY+WtyQ0Ow436S9F6B+BtMfDFwIKuYRX?=
 =?us-ascii?Q?eiSOlw3Dm7NcvlX+UBf6EM7n6g8p/CUmvov0QGaEm0wvzHdXWGmdilSIj38/?=
 =?us-ascii?Q?OE/0+/vRSeACIJmUkg3t/WmwC5ah5eVdd3GP4LVWWv1XJ6NGOmtc9R778CG3?=
 =?us-ascii?Q?gaEyebR8Pg85X5qX7LCAYpuW5KAtnFFgGrsFcV7F1pz/0n8+6B+5dXO+3Qyc?=
 =?us-ascii?Q?nMfwuhZY+EP2cxPLSNAOf9S+gLxoDsG3BOmjEchgJDfkOGQvJlVHQsBljoFc?=
 =?us-ascii?Q?59GWFo7DTQUMsTxBBllrysh4uDlv0n2n0xa7EvSPJwROvIAbjSEYVMDI9TOC?=
 =?us-ascii?Q?3C2aF4kb6/fwnlrFjHt77IGSAl71ij4WMHTGNRIB/oRXH/En5htwb+G0J2ZO?=
 =?us-ascii?Q?OCg57eMivjhnkQ5Suqw1WLCGUStiv5iclF3Yk0ltK90a2VFx0ryoYYTe6Usp?=
 =?us-ascii?Q?wdBsXc2c6dnK6cjfyPRPD44Y9Cy8JRBetm5gfBujEhwz9OGdljkZMkUhP8sM?=
 =?us-ascii?Q?xD6BD2ap6HFo+XH8JilObJ2BF4ZtebTDdCEFJFRf+NfSIl6KQ1rHAVdYiJpb?=
 =?us-ascii?Q?GR/h1trEwb1OJCSc+IVWnc5dchmz6m3aBl/q2AECJI/ExPXNwVseghtJD3OC?=
 =?us-ascii?Q?AP/nmcIsul17Krahwr2AevKkZ2K4gnkVk9r0H6xA3srkNDAg1mwMEEQfOanV?=
 =?us-ascii?Q?010zfLvWMJFKzgaBu8kWPIYpOJUBNLXtYdEz9XE/PSvlYMo07blTyOasR+yU?=
 =?us-ascii?Q?M6VjBukgn67ls9Ul6xDt18FBr46Kji4+zNat9nAx+QdTA52mVZD6RWXjo1MW?=
 =?us-ascii?Q?3C2AIHhxhJ+SbLePQAjOKI78Y+LP1CWtexWigc7eP0OyC+K8SBPNrOxY0Sfu?=
 =?us-ascii?Q?lyegXfVpICKS0gSdQxYajSnF8zPIdbGURzbatukSI8etZ11cWqNg8H4PmIL3?=
 =?us-ascii?Q?GHKm0gUUrMZe8+etoMe/aw5MPtRHu5x8liQflkr+gdpNEj6vuLGLyFba3JAp?=
 =?us-ascii?Q?frzHD/iSME9aeV+ELGxbruweRNEpVvB6GwkgWZl7/hud02L1EUS6HtbAbIAd?=
 =?us-ascii?Q?5fYA9ZQ56gfJ33M7a5VKl86+hsq3VbWMDi8lzSQvlziPBMrQTX9F3vEVh+d+?=
 =?us-ascii?Q?cFe2rPTsBwYBxuaWZSBpwgCia/efMMjBXcWcCXaATgDBIXqcTe0Jsx5qFAll?=
 =?us-ascii?Q?F2+I4yv1TQwNpKAGIUIxYjBr8qWOFPU9m5NDJVwnQjq9I8A+ZgrTeaahn0nI?=
 =?us-ascii?Q?6KfZDrTtvO4b8cBlZ2a74unKWMTrcFqX8r049QfSicEgdg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6ccbc7-4d4b-49c1-f674-08d985117a3a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 19:27:16.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNiR3qklHs2PvcfsCJ219DrQFOqxbUbUtAv1J5h+gKPqbkXbTTmxukRufYe1Cwsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4984
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: fgQ7Kn4YMu8dVleHn-PJdLUBPF2dK8H6
X-Proofpoint-GUID: fgQ7Kn4YMu8dVleHn-PJdLUBPF2dK8H6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 mlxlogscore=470 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110010138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 01, 2021 at 11:59:10AM -0700, andrii.nakryiko@gmail.com wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Free struct strset itself, not just its internal parts.
Acked-by: Martin KaFai Lau <kafai@fb.com>
