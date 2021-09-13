Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88290409E44
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 22:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbhIMUji (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 16:39:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241424AbhIMUjg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 16:39:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DH3mc4021327;
        Mon, 13 Sep 2021 13:38:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Z+w4HqmXuPqDiJt1m/DQitK1OTAdlj6l4vk+RnSpTFI=;
 b=nF7+8LAJ31JjI6kPuZXR+RK9yqT83qz6kCQHILk95ozoKbQMePWbQCcSroPBOs8HAinK
 rGnTf2xsbwrfwApDenGDI/s2pxOtrFfH0Odt2cT+s38UZAIwPOuAfCKVdEGR5XfhREYC
 WPfNiBkV6D7P/YoIJj8pNVzLitP/mD3K7sQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1k9rqh93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 13:38:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 13:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS0iEgjgZ0TAWsNvIw+xNeb/f9ZFWbS0cEXLRLi1Kx3Mbhep5I/kH1jHl/23l4wGpJWhWCQ6X2SXlq5N7EvnwSvQ0ldmVoBKpQQ52RTEPwcGqcNkmy5ofY+CVoGtWVa8uoxsVFvuFQEo90E6/yobvs7r/rEBgkcVZNIU6h2W/Ko+JWe1CwlLJ1et/8YRrYhmC/fwkFyDaRxHSEASESXHwT6r8WGNDaFeWaQH0jpHoPpBjODk2PBQTvN6YUyzDTGMfyxLAXI25WjfXnZvi5VMhdZeqUNSkimBcfdhzpek1Ao7IP6Qg19/J/WHwYSpLcSlP+PmCPIKjIDXybn0qXmLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Z+w4HqmXuPqDiJt1m/DQitK1OTAdlj6l4vk+RnSpTFI=;
 b=WkpEMyP4ul+o7vWy88kFb9HB1B/85fvJz6InfonNtE+0+hkp+bdh2P/n6U1DeL0g7YMdn61roLdEHOQGosSAKSQQqZ/DbhBL6ovmKxqoe0S4gQTBMLBVYWftk97tyr5kTexFlsfGSp4N8z7SltRmZ4Evq/80uZ19v7ukCb9RfNRJrhQOWLMWL7qeA4j3aBZhqT+TgNlpl/m3M//fWc9L8irFn8WLdDxNifXDGldJ7tfw3/Q9X02FxcACKa8kvofrTVftXKN0zJZIepprvUKfgTn76L/a1V14yaa7u0qBdolba8rlRs6AKOOb64StY/s6k/xFM8tmlhlluvYyQyLLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3952.namprd15.prod.outlook.com (2603:10b6:806:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 20:37:57 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%8]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 20:37:57 +0000
Date:   Mon, 13 Sep 2021 13:37:54 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao1@huawei.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] bpf: handle return value of BPF_PROG_TYPE_STRUCT_OPS
 prog
Message-ID: <20210913203754.nfc3eugxgi2x3hea@kafai-mbp.dhcp.thefacebook.com>
References: <20210901085344.3052333-1-houtao1@huawei.com>
 <20210908060611.jylpjegug3gs5gys@kafai-mbp.dhcp.thefacebook.com>
 <8e8dd070-ba19-2153-bf9b-8bbb16a70abb@huawei.com>
 <20210908171939.l6ozdyoji3n5baaf@kafai-mbp.dhcp.thefacebook.com>
 <427b92b3-417e-9dda-688e-c9e3c1b2b38c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <427b92b3-417e-9dda-688e-c9e3c1b2b38c@huawei.com>
X-ClientProxiedBy: BYAPR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::39) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:9763) by BYAPR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:e0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Mon, 13 Sep 2021 20:37:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc3f90c-399a-4f3b-18d3-08d976f65e93
X-MS-TrafficTypeDiagnostic: SA0PR15MB3952:
X-Microsoft-Antispam-PRVS: <SA0PR15MB39520B2DA5DB9C36C77128D5D5D99@SA0PR15MB3952.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkmhoRXJC62niizOXJ63n6znPQ9QWkztlwWpNvOowkbGqTQDLuwXNDKl6O2P7BlCvySTx2O6Q8sPrugHvPpi3hCQNYy8XvRsPCTTWFKIk71pfVv4uBo0SohA5iKkNp+sywNsc2PCtWzP6jLFmTJxiw7wIRyax/ZAVRKWOGzos/hQ0S8N+rc+C0SZg55dfHEqf5JieDKP1M2r4YA8yMLAwu+LBmv/0e4LaZIWh8ONXr0DvurOfPNXR4rgu8nPnKlTMSBozN/mdP+wUFYU9j3Vwy780b7jumsFJCL86wxOAGsPsiaY9qIM0+9ROTi1eLz5SamtdaW0euvorwDxJLMyeBy6xqvdXXfV/I7+m9p8C+AKwHDfFzvHxTV/SNpOaRD0TsocQ1uYHss3SCl0V/QN6VWsLrgb6q691R2woYfotyzw6e1SgxaWXJO1RlTS/WbPiMeaDz17lQyiO8Iq68Bc4lEqC8iidImp66/Ozss+ScqxovUS/59pk11Cy2Vo5WcFj9h08yDGf9p/MWDcocSHerIbufoynk8KnOdUEZLcv15Rs9F0AoRTskyiuUrhKQZGWw4pDh+OFQaWwkI/hj1V6RAEKKxWqF2OK2TiAgEOnzPNQSgjcSpF2s8KjaM2hQ9DrojJ/dPVlZZtAO6R5Mpdow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(478600001)(8936002)(2906002)(1076003)(54906003)(55016002)(66556008)(6916009)(4326008)(38100700002)(316002)(66946007)(66476007)(86362001)(186003)(5660300002)(7696005)(52116002)(6506007)(4744005)(9686003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvTlc/ok/gIT42JyniUJ4A22Ojfccv17PcDpFkGV6d4iU02IE3/kLr0itUlW?=
 =?us-ascii?Q?5akm6yTpUHBtHDg76aaEEnNxBEDahvv3DxAzsAjPLakCniNEZ9VKYxJVP/X/?=
 =?us-ascii?Q?7tS3qs+JtFrDvG5POywCSKMKZMvBg2KxkXHAIpGGYt/XU9jgOl8XNlDHkI/H?=
 =?us-ascii?Q?8AjFAXIxzVUzx9tp5vQkSbzbX3A+k0krbI1Ix0k6sOfcik696A2J6xU/6R4d?=
 =?us-ascii?Q?QqnXLDzo0QGjV+TRnzIZ/otzuJulqh+WFYKpTdHr3bwwBcaKm+OcaGIeGm9B?=
 =?us-ascii?Q?swy+82SUEbFZa2XnoJbo17cJxyFIQBOBHbQMBw4un/Kzjh3RBQjEkkXOz32c?=
 =?us-ascii?Q?MEnZxduBwIiUT5BbnvEVMahUYDCDDru+AvtBx5dP+SfgqPKhLI1K59enWYsQ?=
 =?us-ascii?Q?f0W46rf/LobgZksoS4wAyRDJYt2g8VpXsrJN4FF+V/JK+q/Cn1r1RFGopJ00?=
 =?us-ascii?Q?pS4rr1mks9S/ErR582jN61NQSwSd/YiciTGWCPonHg/eyLdGPH1OEsEjHgV6?=
 =?us-ascii?Q?WzBbLr1VIxHYuAjBayBcZviTNu5zUJcktTMYulU1jaIsuizdjQLvZs+UvoU6?=
 =?us-ascii?Q?MrCM9k38cFe4hPc6UaTHfXIVeoMhNqSm5quEiJG/eUQEoQmSUTla2IhEs++i?=
 =?us-ascii?Q?+i+uG4xQ/43QzqPY5pQiNcUlD4WNjmopXIGWXcMpnS1eA/oALY1iArOUiF8w?=
 =?us-ascii?Q?QeHfaX17XtvP02QaW81hMZq/0uFFi55zO/C9D0mqY9ugoKaFg19ytQ4lPjex?=
 =?us-ascii?Q?iMfqCVComcrKKL7r2QCkUaMfIoqiNvx/OU8ukspMaXGyHKoUGw0Pb4SsY04N?=
 =?us-ascii?Q?/Fd1LrrHflpGXqHEuFf4KtRKa8/ZliC5gxqzCsRkvt97J0ZiUz4lo8+zo/Gf?=
 =?us-ascii?Q?rFySaxCzWLfQbnug5m2fRwpf9rFz8+qUBPRpAotVWptNKkKsJroOOoOpcLfw?=
 =?us-ascii?Q?7OrjlP3sLSRsSm78yyPWcDH3fUP2q1NlpoyEPfmLEpQwxSWQvj27u3oSxQ7g?=
 =?us-ascii?Q?IRYuSfoolKPl+lTndSTxGJ02rCU3IyXG5zmlqtQNu9tj4xSaFCfKoA3KUI1c?=
 =?us-ascii?Q?4y7iS73Qr8Tmu254+T6m3FRnT0GcmU2zECDj9DY2A0/S1BM114332EvKnOln?=
 =?us-ascii?Q?xX62KBQO7HxQQ9nKD5459f42hRU5ODTNPWPSL3OJIES0mVNgHtRsnD8GAT3T?=
 =?us-ascii?Q?mdaNgaKaKqZyn00lU9v3eBuUjpko5gY0zgY93Be2hqH7RGE/wHtX24yNht9K?=
 =?us-ascii?Q?xc8VSGnxlyEOH06OWRii1PMFpQFrxLoiSiKQWnuC+C6MJ9inJ5KZe9Cm+dTX?=
 =?us-ascii?Q?n0SgIQaZZLj9yLDTxyUFvpMRgJqR44kmHWY+HUIogjgEjg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc3f90c-399a-4f3b-18d3-08d976f65e93
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 20:37:57.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oh4sgsW6EWhnD4i2POqDi3ifzakX9hMxmwHNJlqfxmujkD4wSID3IKqf3zcdAqzQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3952
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: TePJkrJPJa_9AFThqhmmQPQNOzNet6xo
X-Proofpoint-ORIG-GUID: TePJkrJPJa_9AFThqhmmQPQNOzNet6xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=782 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 09, 2021 at 09:45:03AM +0800, Hou Tao wrote:
> > >From a quick look, the patch is created from a pretty old tree and it
> > is missing the BPF_TRAMP_F_SKIP_FRAME.  It is introduced in
> > commit 7e6f3cd89f04 ("bpf, x86: Store caller's ip in trampoline stack")
> > on Jul 15 2021 which is pretty old.
> >
> > I am only able to apply with the --3way merge like "git am --3way".
> > Andrii, is it fine to land the patch like this?
> 
> I cannot apply it cleanly if using "git am --reject xx.patch", and it's OK if
> using "git cherry-pick commit_id", so I will rebase and repost it.
Hi Hou, could you repost the patch after rebasing?  The dummy testing
struct_ops can be a separate patch targeting the bpf-next tree isntead.

Thanks!
