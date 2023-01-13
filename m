Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42B669196
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 09:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjAMItq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 03:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjAMItf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 03:49:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C0A2DE3
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 00:49:31 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D8nAmc022262;
        Fri, 13 Jan 2023 08:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3swo3QfNUy6sVvZSEXPw0AOtZbKmtIi8k5/GLEagYcI=;
 b=tS6pCPyNFh+0ftktX1oVNRQXb7FbI0ENWk1IdGEBXpiVVGSd8BVV0MBsJALETW6qlrK/
 0kVz5E3kL8WUJlj9FdLouLqrPMWjEpDzVxd7tIzF/YiRw4exE8ZaFpgdMKbSQ7SiPT97
 JaJW5WFaT59iEXPM0paSD+0f7//F7stZLgC7LiBhCeKA0eY3touN1KjVOj2fZGp2VEW/
 Ds0ZPWnBvkCk/L2SOa081O8kUn1ZpD2m1DdhknCAsGgQbv/zAzm8hEpsQTDTobqjJyrs
 isp8VHSNW8/lomFRjhUg4Q9S1ymGpZQ5SibYga36qToywd8EM/2LlLKNIvqjlOu7tPvA Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n28jaaucs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 08:49:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30D8di0I007398;
        Fri, 13 Jan 2023 08:49:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4cbexv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 08:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X15et0btXHWjlnUwwoLmeTOCOhnzd/HtzrlPVfpcX0pVT1VN0MaPps6jYROXTOdh2WB7JvZAQzW1pHR1eOUQQPY3zOMS9qO/3oJr36LZZlsMOoa75PutXb0DfyxKQZh4rejf/5Ce2PFs/tyF7GjKY83QNDeQxr8A/lHM6mFhoO52640+mPbGMDWRtePrtwcZ9fnHf2o8dDFLIAt3q4Enw5zO1+K1Uy81CziYXh3YB77btYAcRNOSMaIrAjuDE8a8+RO1C7/VJCFIfLay88u7OpX0LVj53SW+Vkxo3uOgXOr4l4TqKeBTrxQSv9w4QVUBsi8ngYADLCMQnDVLwPztJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3swo3QfNUy6sVvZSEXPw0AOtZbKmtIi8k5/GLEagYcI=;
 b=becjiRHEMiOcUK2NULGVWBqa8mIFWCmX/+CD4Y9n8chqucTiqPZ6L/4NH2/SUHrhAckB3ZYC5MVibfjpm9PlNDg7oEBVpmqRIsJBn7fpAIFIg5fPKJHNHZ6EdYqjwgfTCl5+xvFS54IXId0787e0cH5uo+8XnFhyywZXymdn5CoB6SRqdXn5s5evGdC+Gft3Irp9lQIVZDZa1/AQ6pD72GwWkuDtj1wk7s8tCzp8++HzKfewd8saUHtDrFey8W9zGvuMZGOKi+FceZCtl9kM6Epw5FK6klsbtV5Yz45gRsZ20OakOHom5Bo4sBr1x8vKqBHpZGwttZSb+JPldefsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3swo3QfNUy6sVvZSEXPw0AOtZbKmtIi8k5/GLEagYcI=;
 b=Vl2OYdnKAHOtZhlM0ubkFWuOhTMh9hswENFPYc70w0zE+t6po05JFhL/UVwD54z9vqAZJbpHuLLodbKZDlx3E3xZLGe9QBfY051ikxLESFkF5915uPF7OlNLMNIIzhFFbKRNVnnf383+xEPelqBFGho2nYiZyrHzhH2kG7FkSx8=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 08:49:08 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%3]) with mapi id 15.20.6002.009; Fri, 13 Jan 2023
 08:49:08 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
References: <20221231163122.1360813-1-eddyz87@gmail.com>
        <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
        <874jt5mh2j.fsf@oracle.com>
        <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
        <20230112222719.gdxwdocfutpbxust@MacBook-Pro-6.local.dhcp.thefacebook.com>
        <790ab9fd-dbcf-4593-1634-6f706675cde2@meta.com>
Date:   Fri, 13 Jan 2023 09:53:01 +0100
In-Reply-To: <790ab9fd-dbcf-4593-1634-6f706675cde2@meta.com> (Yonghong Song's
        message of "Fri, 13 Jan 2023 00:02:42 -0800")
Message-ID: <87a62mhl3m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dedc3cf-ba6a-46aa-c83f-08daf543086c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJXbPVGWkO/VIuTPVdas8Gu/vUQSLM8xFkzo05KkBxK/g30l7VIRE8JsYRLjYjDV+p1K0pdRl0mvkgKa6blOScmFiSPqV2KYoeBM34Hi0Ys03XnB3Y2QXVFyYViaPjMOlAHxSs7Vlwc8NoSclTigzBg8BRm7buJsmg9Bu6D9SM2QvN7Yi+1Gkj3Ro9vRuHHKO49opAtfWqAzNNb7K4t6VorZ9r36Wlv5sDUYKMx4UKW99x2eNThzjuo+douKRE6NTLnNNkaduJ3QK3JZQ1oFXHw1GCD+I6xRBPNdZshWoaro0+nVy5npyC9J6VewmLkrCO/u54bSQuoVdORijqwXwjIBuQF/Dyh8GaP5rHGfr2yU0tXRFiR7BNkxzUQfMHJpIsMsxR1+0v7gu41VlsXCEASWCwK88Ea3x/fckovskpuxNiSUBzErVAleaKtj2FeprqIqQ6qwGiXAVc8HwryACRNWrnR/KHQOJ+FiFiKlvwGk6J+VUwgM7pt0YRegKeFkJy6wrqh69PNFmktl0k3vuK/h8RF0Oy3KZV4mqKpXBun1DOOm8LfZcF+IXkiQ1UWAlQGObWh6sEswXk299Iop8P/A3a7znNhiFc75GBdRcmo/Qwh1dse1nsngLy3YVcmw8gbT62fk2LvD0L0ZiwRN2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(54906003)(478600001)(6486002)(316002)(36756003)(86362001)(38100700002)(83380400001)(2616005)(53546011)(6506007)(186003)(26005)(6512007)(7416002)(66476007)(5660300002)(2906002)(6666004)(6916009)(66556008)(41300700001)(8676002)(4326008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFOV3l4UUN2dVJXY2RaV04yRWRQNmFkZklhN2tZN2o5ajZBMCtQRXZnYTY4?=
 =?utf-8?B?akcrblgycGlISk90NEJ5NXYyNDhsMC91Q2dmOTNlUVVHTFQyQTVRRkJUSEFK?=
 =?utf-8?B?TCtQVzFDNHoxbzRNbEVZWk5hZ3I4RW93Z2dpNHhtaldYTlBDMXJyYUJ1Mk4v?=
 =?utf-8?B?c3RKSTcyK3VmYzZ5UnBzWDF4YVJQYkhGQU5NK1I1NU43RXJxUEV4SGpNVnhE?=
 =?utf-8?B?T09HeXBCYk4xR0NVeGhHV0tqblFtMXZtRVI2OHVtNFdVRVpZd3dJV0ppNVFU?=
 =?utf-8?B?Zk5XbTlBTHQxRVBPdXpVM1NiVk5MMndCQ2s0T3BzcVV6ejRoa2tYU1lCK2ZH?=
 =?utf-8?B?TzZkaTRnUVJZSE9aSXJ4QXROaTdmMXFtR2hVZjR4bmJqNm00SHB5Skx5L2FP?=
 =?utf-8?B?MTRPMXFzbWVNOFRXQVRpZGpTYUhsc2c2UzlWd3RHMUtsYXJOSlR3RStFOGcw?=
 =?utf-8?B?eCt5N2dOaGZIVDVoUC8ydE4xejZHc0ZBdmI0VnhxOXg2SS90d1lBV3J4U2xX?=
 =?utf-8?B?SkljeCtlR09kbmhUU2dhUHBESUVtYTdBcERFODB2NzBwV1VFZ0VreEI5dWtD?=
 =?utf-8?B?MWdMdUthT1FvTG44WlZ4b3NmbytFSDk3VnpqSVVBTENKcEh3aEdaUkdHdFFV?=
 =?utf-8?B?aExwZU1ucVh4U1F4aWJKT1ZLRVpjTXhNYnNqNlJZZU9uRGtwcjEyczdUZkFo?=
 =?utf-8?B?bU9YbE1ac1VqUHowVyt4R3FoaTAvQ1FsRk44dmpzQlNCSUZmbnllbk9VTDV6?=
 =?utf-8?B?NHJkWU9PVXcxZHBmbks1OTdqOTNlY3dmNzg5a0lDeVJNckxhZzk1QUtZdGxT?=
 =?utf-8?B?QjhINVhRNG9nSG4zYVA0bjZRKzBWcGdlR1RCUlFwdllzamxTYk91RmM5MEta?=
 =?utf-8?B?UEhUK1lpdW9heHl4WEtRbkFUTDRwUVZrdUVQa2F4N2FjYWF3bk1EaVVjSWhF?=
 =?utf-8?B?V1hxVXcwcXF4Z0FvK0FmMzViSEt5aE5Iblh4ZkdwRE40a2d4OWxhOFFVc1Fa?=
 =?utf-8?B?ZWg1d3hTSm5tenFPR0YzajNHc1RpdE9Kd1k3QUJ0cEtOYjlINC80TXNRbW15?=
 =?utf-8?B?YThMM21GaVdrVWJUdDRZYW13WjVhM2tUK3U2b1lUSUFoeVdDWHVpOWk2dXU4?=
 =?utf-8?B?RUhJRWRNeE0zci9maElxOXJUTkh6MnFlM0pQTXlpSTBuUmg3T0U2ZDdXZlBK?=
 =?utf-8?B?RldWYVI1MVpXVjM2ZVBvNGN1SVRMMk0zazhhTHZZcDlMMDBXV3pDUjBEdGYx?=
 =?utf-8?B?VWhKTExrK0xJTi92WUhKOEpaVkpBZmRlVnRxbXFQdEJ6Y2I2YThSU3ZTbWdZ?=
 =?utf-8?B?R0w2aG12RE5hWlNiTENqWDRObHZPY1lXTDhXYU40V05welRQLysyTGc2SVIv?=
 =?utf-8?B?azM2dUJicDU5VDEvN1NaT2hDem9qdWcwVExwUlRFVUZ2OUhXQzhyaXhzc0Y5?=
 =?utf-8?B?UFlHNldXOUl6ajUrQnJPR3RIY1dCeXNvc0xTb1JwaUlPM2NDWmRLWE83dmht?=
 =?utf-8?B?ZG5Rc0lUQVlQdXFrU3gvNWRXaEZacytZKzQrVHpYaTYwSXltTHBNaXpTVXJK?=
 =?utf-8?B?cFh1aC9raVlJK3A2blhiUjBoQ0FYcHk0M2d4b3hyWGNUY1liS25mb0ZzZUls?=
 =?utf-8?B?RjhvSTRXZVVwRUZjSDR1U2JhT0lIRzlrTU10ZENmcEVEN09IRlIxVFR2YzU2?=
 =?utf-8?B?eGdZSG5ndXFjU3g1QVE0dUE4YmJxVEJHWENzVTlrN1ErRkNLV3lvUU9kdkVs?=
 =?utf-8?B?QUREYzE3THJEaXBXUE1leTR4Q0lPdCs1OUpYdVRTY3ZrWjRwTndUUktkRkhs?=
 =?utf-8?B?WlU5S2dhOC94VDZ6ZnE5czJyRytMWnd6RWd2NnhzbUhzNUVoVm55b0REcHVv?=
 =?utf-8?B?bEQ5clpzdjlDbUNqS3IreE1NN1NKS3YxUDVHUmFtdmRVZEt2eXBtR2ltS2lv?=
 =?utf-8?B?R3BHbytjcHZTcUlETHMyTW5ZS25aekx2bEZIZHRqMHlhM0o0RW9oNFFOZnA5?=
 =?utf-8?B?Q3czcFd0WnlpWWt1czBUaXVhMzM5M0MxZmdxQUw0SFB2ZHlWZmN4a2M3VllS?=
 =?utf-8?B?ZUJ6QUN5SjNnK3o3SVpLOVo2anlUY1RwVWtXZVY0NGNVZkpZVHRhZ2ZZTlBU?=
 =?utf-8?B?cGRBVTRhRE53eXZqVzMxRG5ZSW8rSXBaM3R1ZllQMEd2bDRVL3hyWXg5b3lG?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hM4YX8CLvilTtpvMAgeJZozSPeoug6AfQozCeR7EZDVq91eeoNgGGUgENq/6ytc+b3OLfjYHLzSwKoNWXd1N0tmxw1GQttk51of+HHZLOp4/ckr0FZbnMgxfbfL7T42yL7BqT7hQ7WgKVLnqWCselOCpH0ENG45zFGgoXLVpBEjd8ctbaoi8aiq/MEZKEIkR4HyEU3/3BHvvImcqnexpeEPJlXHoSyR3miki82YJYyTWfvqDbdt7aSBPXAO5w2trV7PT/rbsFhdBayLtaRUW8FCdcjcjSnNH3RbnguRgyKZS0IAw3SWhPSgnHXpltb5goXgjXD9RCFJo3Da47wNuJ9q5KBhgXMKIDlRURGE+LiF8XexXjQ05Y5ho/ZIff5X2s76WNFgh9L1MMH2kUiJ7sqL+BqDnKwEwd4cgJ5pn7O1BT58AGFQMd5DDDiAhKftV8H37cvWukR1P/D1kusmCMTxNpXr5eNbh/doD3+3vP5Xp8bhsQ82MqRv6xDPrKLrsFDBJbu3yD8ww9IPRV5MXt0gs9LPLlVt+hX6Oq9YTCPeIofTybAT8sQx2PuZswMeUR+PkmkiX7zyNcupaLeKuxXvoDLHiEs5pE+JEaCddRwx/RZt5arsQEilC5ElH+9T2rXthd/Ym0imDTGcM5/dxjgBuClIqkKmfYsjhzNqEbXfXzvmdoeb8jSwOypfjS5DnqJlij9K1jOuIcMhlMVUyrdHGUT2UwYjaZmoYwoV/QBazf2tmjPGx2Xy+DKbEuXqBdnlz1OofBt+zU/ByxScR4yGm2NGSUGha1RAxJkvhP0MiBWGxPSqQfdeSXE2muBY4IPRK9JBB4yYA/TFr8XT66I6eX0022w8Xm6llVXoGqp4/+8q3whaHF+YVZgPWt9IZm8z0lGStZqNF8ZXxOD6omw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dedc3cf-ba6a-46aa-c83f-08daf543086c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 08:49:08.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5G3bdiJt5eQq7g3KmdoPoVWlvrVoLFfo9rya4OjORzx/+1kNeJH4svHi7Xy94djL94Ffjhpn0AW6TjyI/UqsuC/QSeirddsyW6ZcvIb/9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_04,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130061
X-Proofpoint-ORIG-GUID: A5GFHlOvHjHLOdFd7B_g7IrMLMcSRQMN
X-Proofpoint-GUID: A5GFHlOvHjHLOdFd7B_g7IrMLMcSRQMN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 1/12/23 2:27 PM, Alexei Starovoitov wrote:
>> On Thu, Jan 05, 2023 at 02:07:05PM +0200, Eduard Zingerman wrote:
>>> On Thu, 2023-01-05 at 11:06 +0100, Jose E. Marchesi wrote:
>>>>> On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> =
wrote:
>>>>>>
>>>>>> BPF has two documented (non-atomic) memory store instructions:
>>>>>>
>>>>>> BPF_STX: *(size *) (dst_reg + off) =3D src_reg
>>>>>> BPF_ST : *(size *) (dst_reg + off) =3D imm32
>>>>>>
>>>>>> Currently LLVM BPF back-end does not emit BPF_ST instruction and doe=
s
>>>>>> not allow one to be specified as inline assembly.
>>>>>>
>>>>>> Recently I've been exploring ways to port some of the verifier test
>>>>>> cases from tools/testing/selftests/bpf/verifier/*.c to use inline as=
sembly
>>>>>> and machinery provided in tools/testing/selftests/bpf/test_loader.c
>>>>>> (which should hopefully simplify tests maintenance).
>>>>>> The BPF_ST instruction is popular in these tests: used in 52 of 94 f=
iles.
>>>>>>
>>>>>> While it is possible to adjust LLVM to only support BPF_ST for inlin=
e
>>>>>> assembly blocks it seems a bit wasteful. This patch-set contains a s=
et
>>>>>> of changes to verifier necessary in case when LLVM is allowed to
>>>>>> freely emit BPF_ST instructions (source code is available here [1]).
>>>>>
>>>>> Would we gate LLVM's emitting of BPF_ST for C code behind some new
>>>>> cpu=3Dv4? What is the benefit for compiler to start automatically emi=
t
>>>>> such instructions? Such thinking about logistics, if there isn't much
>>>>> benefit, as BPF application owner I wouldn't bother enabling this
>>>>> behavior risking regressions on old kernels that don't have these
>>>>> changes.
>>>>
>>>> Hmm, GCC happily generates BPF_ST instructions:
>>>>
>>>>  =C2=A0=C2=A0$ echo 'int v; void foo () {  v =3D 666; }' | bpf-unknown=
-none-gcc -O2 -xc -S -o foo.s -
>>>>  =C2=A0=C2=A0$ cat foo.s
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.file	"<stdin>"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.text
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.align	3
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	foo
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	foo, @function
>>>>  =C2=A0=C2=A0foo:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lddw	%r0,v
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stw	[%r0+0],666
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size	foo, .-foo
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	v
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	v, @object
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.lcomm	v,4,4
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ident	"GCC: (GNU) 12=
.0.0 20211206 (experimental)"
>>>>
>>>> Been doing that since October 2019, I think before the cpu versioning
>>>> mechanism was got in place?
>>>>
>>>> We weren't aware this was problematic.  Does the verifier reject such
>>>> instructions?
>>>
>>> Interesting, do BPF selftests generated by GCC pass the same way they
>>> do if generated by clang?
>>>
>>> I had to do the following changes to the verifier to make the
>>> selftests pass when BPF_ST instruction is allowed for selection:
>>>
>>> - patch #1 in this patchset: track values of constants written to
>>>    stack using BPF_ST. Currently these are tracked imprecisely, unlike
>>>    the writes using BPF_STX, e.g.:
>>>         fp[-8] =3D 42;   currently verifier assumes that
>>> fp[-8]=3Dmmmmmmmm
>>>                     after such instruction, where m stands for "misc",
>>>                     just a note that something is written at fp[-8].
>>>                          r1 =3D 42;       verifier tracks r1=3D42 after
>>> this instruction.
>>>      fp[-8] =3D r1;   verifier tracks fp[-8]=3D42 after this instructio=
n.
>>>
>>>    So the patch makes both cases equivalent.
>>>    - patch #3 in this patchset: adjusts
>>> verifier.c:convert_ctx_access()
>>>    to operate on BPF_ST alongside BPF_STX.
>>>       Context parameters for some BPF programs types are "fake"
>>> data
>>>    structures. The verifier matches all BPF_STX and BPF_LDX
>>>    instructions that operate on pointers to such contexts and rewrites
>>>    these instructions. It might change an offset or add another layer
>>>    of indirection, etc. E.g. see filter.c:bpf_convert_ctx_access().
>>>    (This also implies that verifier forbids writes to non-constant
>>>     offsets inside such structures).
>>>        So the patch extends this logic to also handle BPF_ST.
>> The patch 3 is necessary to land before llvm starts generating 'st'
>> for ctx access.
>> That's clear, but I'm missing why patch 1 is necessary.
>> Sure, it's making the verifier understand scalar spills with 'st' and
>> makes 'st' equivalent to 'stx', but I'm missing why it's necessary.
>> What kind of programs fail to be verified when llvm starts generating 's=
t' ?
>> Regarind -mcpu=3Dv4.
>> I think we need to add all of our upcoming instructions as a single flag=
.
>> Otherwise we'll have -mcpu=3Dv5,v6,v7 and full combinations of them.
>> -mcpu=3Dv4 could mean:
>> - ST
>> - sign extending loads
>> - sign extend a register
>> - 32-bit JA
>> - proper bswap insns: bswap16, bswap32, bswap64
>> The sign and 32-bit JA we've discussed earlier.
>> The bswap was on my wish list forever.
>> The existing TO_LE, TO_BE insns are really odd from compiler pov.
>> The compiler should translate bswap IR op into proper bswap insn
>> just like it does on all cpus.
>> Maybe add SDIV to -mcpu=3Dv4 as well?
>
> Right, we should add these insns in llvm17 with -mcpu=3Dv4, so we
> can keep the number of cpu generations minimum.

How do you plan to encode the sign-extend load instructions?

I guess a possibility would be to use one of the available op-mode for
load instructions that are currently marked as reserved.  For example:

   IMM  =3D 0b000
   ABS  =3D 0b001
   IND  =3D 0b010
   MEM  =3D 0b011
   SEM =3D 0b100  <- new

Then we would have the following code fields for sign-extending LDX
instructions:

   op-mode:SEM op-size:{W,H,B,DW} op-class:LDX
