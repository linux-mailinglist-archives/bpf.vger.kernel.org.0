Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1744940B5F4
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 19:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhINReT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 13:34:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231210AbhINReR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 13:34:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG2xfM026808;
        Tue, 14 Sep 2021 10:32:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nqGBx/BxGFCRx7lVty9vaP1hmVyjAaZe4WUHwqzU3m8=;
 b=NuWIrQy5V/ukS0eiVCy8rP64Tk8y59f4XLIzwzfT4nNA/2ZgmczxGgGdMb7oZc0LjVZ0
 TEagLESmM2SzF/PvagGPb0vyo82/kr79PZFagNXJpHh3XwikOqVIGHrJHHAmZBe85s8G
 Zq5PMT22BZH5jRmIX6zrGkHIJP7V+rAMhzE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b2k1rmhkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 10:32:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 10:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDMxKrUD2OPT/CjW32WhWE7kK5+VedrsipjOq1AFY4RIgojsn4M/r6jBGfS1KEdmKqLbb5RTW8ajFlKtZtGsFaWX50KVQhVjyIis1iOpZ3nATefSDW7gxOEUVzUuRXqDwbLofzYVCD+MyyjFDwlYgYwziXhLoWwCBCpLTXCiThnjbldO3oIQyzo3D1IKemD4UaVg45VhYu9udXlgoz3aSfJHdd+8jHbpug3M5tmKOIH3Yptr5AXu7xyY20MjP/VgAyQbkG+7CojmMnQVXIijZYPGXhuED8BhkLh+NMrheChdCEpdzBOco5pTnCeZFme/vwQAyWL1Wl9kjuShxUR50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nqGBx/BxGFCRx7lVty9vaP1hmVyjAaZe4WUHwqzU3m8=;
 b=gko4yPE0OFqzpjhEac8Wkrqp+ggBp+UV7wapf1Sx1fHecYEeyMOo7DDUwyWS5QegTtqRq4mJLOJKm5Y/8jM1iC0HCfSRwsCNUKdd6LyzQABeIIJyPYLab4/aOmLQUpSJMXWkGCbyPxe29pPiVsUu0Gia+ncjBgKs8CMIDfkaEL3o730+RU0n9QsBdVfmJL14InU/VZ/ncIFudEsW2OUOsSCAraprWDL7R/EaYR8vSp3qyTgmcsLs8X85Hn22Log+5gX4zhXcziF0WUL4nEzUf3LYGdxQWxwjP4RczLEw1mo/TuOx11SvYSysXZ4fD1ThYBG5WNG1YyRSCNYpuIyG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR15MB2304.namprd15.prod.outlook.com (2603:10b6:805:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 17:32:37 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 17:32:37 +0000
Date:   Tue, 14 Sep 2021 10:32:33 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: simplify BPF program auto-attach
 code
Message-ID: <20210914173233.pegxx2phsmaqtns7@kafai-mbp>
References: <20210914014733.2768-1-andrii@kernel.org>
 <20210914014733.2768-4-andrii@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210914014733.2768-4-andrii@kernel.org>
X-ClientProxiedBy: BLAPR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:208:32a::33) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c091:480::1:c86c) by BLAPR03CA0118.namprd03.prod.outlook.com (2603:10b6:208:32a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 17:32:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ede7f5ee-d7e9-4123-9c0a-08d977a5a4d7
X-MS-TrafficTypeDiagnostic: SN6PR15MB2304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB230459276D92DA6C76E7BD68D5DA9@SN6PR15MB2304.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDndjfRyjbEW8gsk0RsoF8BS9L4OgoEXRJQh8tex93XQ5V1/BmWVeGhu99Dj/nboGli6YyjhJpHKa+Zhs7RVs0CvDZi4WHz+LLdxJmP5AfObiW9BQEfvxRn2tiKopKdpFNJTgR+SLgFYtcvlh+PzL/8bq3ql0qL558Tmd/vNle1lq8Mg/3eUmUPlabUhJODBtlzj7cVFFZeMKwJLaGxX8c7u8wsgXOYVSBbrI7nfMLP9MeUK4PCINdThJ1lxKq8GIq6eeHC4USfQl0lUCEfs26zFggip8QwuBBvgAOGDNA9kP7wkOWZz1Cdr+/7yTascyAPRCOG/dVB1ahHDfI9Qg/XUJsGhM7o7oCPJ5B1b24apNRugymnbcS88qFX2qOzFJ5mV1W8ydA3ZqB3XPE+UPK5RPN/vUOcuYxJYiuVj7p30qR3Ju3eiwQOMRMU8MWVEavZDlaVvUwaLDehOUtS8mNQvz4LG1ucV5w1IqvNN4DJWlATvhWmSgR+fay8vDQYYy4GLat2CdmQVEfF4HbZXJF2+ouC3iQYeKbLJcvLoTNvPxJS2BqB7KvGTYkl90IQjJ4A0eVhxj9a3hsWsQIae5GxkXWrzidZpyoeUqgSp+Mp9YjzFRTbHgcrHOh9g3hLbutZs0l5YrOgHYEKb9XznGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(6496006)(8676002)(52116002)(33716001)(6916009)(8936002)(66556008)(1076003)(5660300002)(66476007)(66946007)(4744005)(86362001)(478600001)(9686003)(316002)(38100700002)(55016002)(186003)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZYKCXB75q92FfVFV7Be+N3VXgzpaclVhPTukf6TR8jhyjC5E/CVMOE7A3z+L?=
 =?us-ascii?Q?vVVbs8fHbFqHN9mX7QW7pROcYtyjSs7JZELgkRiSZxiWSi3AmT0kMSeNm6he?=
 =?us-ascii?Q?gtXVcdva9tNJmZP2FZHGqnQxPOQDZENXGbaons5vO34YJdcoWYXUzxJ1/V22?=
 =?us-ascii?Q?XcLcZIMwaerVknfVtjYAGKn22rdTrlAAAKObVNLe21Dip+UoKDG4oUMPOD5G?=
 =?us-ascii?Q?EapZVzo8+TjyAv90uixXJu348yyGAwI3ErRG98sW+3AZ8TxvJ8QkfwbyzFJR?=
 =?us-ascii?Q?VNBmSgOdMfpBg9pn6lqkMzb40B1gGXV/FnCKTlQdJLHCP2KRDMVwoPXDdMNS?=
 =?us-ascii?Q?J5joy94E2h16LQDIyjelzVjznSmik1chM8aAyxP3pLpYZIlY3ni354yCQgl/?=
 =?us-ascii?Q?jXJNQCBiYfsHKVIkHF8G8XQVSuOrNviqEPy4YqFdGxnN5OnLiiPKIeSMDapM?=
 =?us-ascii?Q?3HJZulyGVdyzqLYzx+/4LM9YzUj1kc0SQrMIPkQJ8UGKAWTZCoTX0vvWFQrZ?=
 =?us-ascii?Q?wDzrIgVM8eefsXjOpcx12naFECE50QNat1N2CQlvJxHMSp7aEdOTiOnXJPYt?=
 =?us-ascii?Q?LuCqb0n8Fy9T+lHuwdvPCAQI7Nh3qFBGpL1dBpgNY6Ku4Jce08QQrWNJkU7j?=
 =?us-ascii?Q?n6FreLjR10f04KX+trlH1hUy/menP5bdD+XzWoNoNDZtGA+b/27qoYkqFEfa?=
 =?us-ascii?Q?XUYuN9oMGEDIZWvV4NnHcyqPUrvOyZbq5bqsPzG+cPtpqp2jqh2WuBO+8kRn?=
 =?us-ascii?Q?K2yfTsy6u6KBUJpgyNZ/bn7ahmi4/irF4EMq8xDALZR7YEkcoXg4rUtXlpq2?=
 =?us-ascii?Q?z8RB4QyrHIf83oaMaiBdqZsAXJquMOr75dkGlPGuoGQqqU/nTq5RuOU1Jmo3?=
 =?us-ascii?Q?HJeSmtIWFMgWl0K6I8+AB1tMdx7jdbo/cITgXML531pL5L/BU6bQLmnviJAV?=
 =?us-ascii?Q?oZhzWCB+Acc/0v5enmV9KNv5BqlIXTgfkWcZKBera3jkzZLCkkofP3c/M6Yb?=
 =?us-ascii?Q?/HJI0tiOaYGRrmROrWpDMwJ8924n3SgNEABm7YgsYWs7TM1+o7350JBhH5+0?=
 =?us-ascii?Q?vMJKINe5VV/Ia7t2g84GffrWqrlewPNvWTbjNDpK0k79Mch2Z/BP6c9Npcvv?=
 =?us-ascii?Q?BpK9sq1uCMDqHaQVjt2yICEl3OoxSDltYmMdSjFfIXOOPDOrVVWpkUHu8E63?=
 =?us-ascii?Q?WMBXKlXo5y2KXQjTle+XDuhi4K3soZ8F1XqAxgrgyP71Yqt1ZtRHUPYHHZ/c?=
 =?us-ascii?Q?XyU64k573HMxynjTNHXYNBBEwn/TkBNWSlWj3UuRKukSOrnsUrspZhahDoZY?=
 =?us-ascii?Q?Lh9iSEspiT+IH9Xixobg+cjblsUZXKU+mcmEOHp13ZFBrg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ede7f5ee-d7e9-4123-9c0a-08d977a5a4d7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 17:32:37.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l27FSPM9f0fiSMI1R/x5OFHG70Bc9X6+QpcTZak1QlfUVM5QGoCY4QCn9ZOwlEeF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2304
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pOqjlrkWhxUC9nLrFmk6EsoF8lEfBUbN
X-Proofpoint-ORIG-GUID: pOqjlrkWhxUC9nLrFmk6EsoF8lEfBUbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=412 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 06:47:32PM -0700, Andrii Nakryiko wrote:
> Remove the need to explicitly pass bpf_sec_def for auto-attachable BPF
> programs, as it is already recorded at bpf_object__open() time for all
> recognized type of BPF programs. This further reduces number of explicit
> calls to find_sec_def(), simplifying further refactorings.
> 
> No functional changes are done by this patch.
Acked-by: Martin KaFai Lau <kafai@fb.com>
