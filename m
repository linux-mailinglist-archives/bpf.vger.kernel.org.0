Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF69E56CF39
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGJNGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJNGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 09:06:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB59713D7D
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 06:06:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26A4uT59017410;
        Sun, 10 Jul 2022 13:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=h1aMDoA5uzF3EUyJPqxyqILpghRy/l8nFpiqRlRJH1E=;
 b=UtIZAtYAJChNFJdnwVxmeNbNFXO7K3Rv/mXozjbW62sHkr7Z+PNcBb98/h23ZntFyqLj
 4EHcsP1qFYVma11pEsv5uO6s4za5h9ZpPVZ7EDiIiEB8TeedsY3kVNwlqr3spuXbdGJb
 oerf+rN01IaoboE4dplfW/fmZ+w4iFisYcI+EzoLRFIB+IAP6D9taFsos37XXYOIFMrC
 kf69VnZpGdKnU8xTQQzn8hpdolgt7xSFZVM9JP65osxzjhcoahLwjwXo97+7FdtowYKh
 CG98/uBExi7dEYZrzKrF9qbd0MS4O+ie1dsv/zU9x1AwnbBd5m1iuBMyA3KfcEhUma+e /g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r11had-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 13:06:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26AD6SZ7012016;
        Sun, 10 Jul 2022 13:06:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7040sw8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 13:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8k9i97rWNf2umuGOLqcWPboQzzTvibBhfOQNdEE+bO8mixE8YpQi7Qle0QC+gHNOcZ/2z/dtowE5TzuPTYbB38NCfzMkZ0PcKrc+i3NfYhdxf3dZXduKY9XetyF/xHfmjqqOXdcZ7EhsO9I7uNecoXUYfuZltlgOBi3OpY9wJvE8Nk+RCvgdbRrDFxYaA3o0jzW7QjZMaEhWANJQHfKwx95i57PLOUQhe7W/c1uswefHfvOr9RhFfAyRtIF7JtWfk9HhtRryppKtbVJyOgXlV9qb8zKntTxv70xRbkOffKonzHjP4cKSwTDfD5jxRkRUyAxgBghvXwvs12hVp9iDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1aMDoA5uzF3EUyJPqxyqILpghRy/l8nFpiqRlRJH1E=;
 b=DvSifz5500Hp7DyrXqjpAScX2QotB/sP/0/rRdjIjYShY6197hjSX3P46p1BMbVcZ36FaucU881BGDaLR48hYSFCIS8i3x0TOTiQRRlDfmRw4QHoPFBsYYaQADPAs7hbhvz53QbeQXzwR6vcT70/FbP8vhIHA7rLVRdufblM8evldZSMR+DVBgbFFOD75k42VjKPciUKh6aAE6iUGkamgqQIdzTBuG46EzXzpV8iD8Q6fXDPM4W5T5sM8VPxKf6ol+jpwe/XWlIkD4OGPVLGxsvRkg4t1aKveO2DHhBrO+mZ3mBq5nqibFzw3PQwZLAlXyFcFIU0mCekMBmJD9lAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1aMDoA5uzF3EUyJPqxyqILpghRy/l8nFpiqRlRJH1E=;
 b=DTsvCcZlnULOXvKPYDyB1Ydd2Qn2f00mW44MJpget0f89pCqzaw4CYU/5udYtWCfKaNxZF0sBoqDDkSJLesM7KAkgdO42lN8E0FEjGsiPYt8Jr+x7JNR1C/35wcnEgI7+1YnJioNcZbS+t9JFyj6DTxSGm1xiz/vq+uPRh67G6o=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM4PR10MB5967.namprd10.prod.outlook.com (2603:10b6:8:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 13:06:22 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd%4]) with mapi id 15.20.5417.025; Sun, 10 Jul 2022
 13:06:22 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com>
        <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
        <87v8s65hdc.fsf@oracle.com>
        <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
        <8735fa3unq.fsf@oracle.com>
        <CADvTj4r+1QB2Cg7L9R-fzqs_HA3kdiiQ_4WHvj+h_DvuxoM5kw@mail.gmail.com>
        <CADvTj4pFQmS6XHpHCVO8jt-8ZRdTd--uny-n9vA0+vm4xUoLzQ@mail.gmail.com>
        <87tu7p3o4k.fsf@oracle.com>
        <CADvTj4r_WnaC-nb-wQwqrzfJsERaX-TnR0tRXZF8fE5UPBThHQ@mail.gmail.com>
        <87h73p1f5s.fsf@oracle.com>
        <CADvTj4qiz0xHnN+s32tiYm_WA8ai4cHUVPkKm7w6xTkZXUBCag@mail.gmail.com>
Date:   Sun, 10 Jul 2022 15:06:13 +0200
In-Reply-To: <CADvTj4qiz0xHnN+s32tiYm_WA8ai4cHUVPkKm7w6xTkZXUBCag@mail.gmail.com>
        (James Hilliard's message of "Sun, 10 Jul 2022 06:16:41 -0600")
Message-ID: <87k08lunga.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d65f3d90-c16a-4337-4b7d-08da6274fbfe
X-MS-TrafficTypeDiagnostic: DM4PR10MB5967:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bc9A9dK6Va9CiZ0BqjKRJV6IXB9/JdvdXi8q3m0sYFBsesxS5zEvEMFUUGmC9z3T93lUwrBSkiblfaq5xAG/oHwnkEnTTfbBGLuhbjMGS8C0pSvVvWv+YWUQiz1EPgn74ftbJzzsKaGo9J8jlXvYQDSqP7WzkYsUic8KoKUImoL94iv+UnZ6GZNmEKundWxNkTuoJUacvrONQmImNm+7M8K/APOdMFpB2QyrekeqAh/AblG0NeaNEvMesDEAhrBcv2Io2KscioNLPcJ0QmCibiknVlQlSwnch1nj4j02m1cFm5XY0xtqiLYRvlF+aUFa4fCWU5jOSCXbkOAeiJ/C0kQsxAQHTZhM4eSNe05iInLtlZwDCmEs/ei5joUHEec6jxumaMwBze0rxYaxD0r1h2cv1OgEyS6EMcQ0++Qotwx7dyg9IeKcMXgrgzqXBUF8Y+UO+eOEt9a9MDn0w1rRTzOti3PGSbt4RgUVlyOzKwu+9RgjG6bj3z9c0XFlMOWOn0STpLBul++qpSOVPnGdyuX93mRBH6herAcecqOfas/u17V4tQWjJyY2mq1uJ7Yx951XLUpJ6xSLe26Dk5cfwTjDE8wX+OsjYhDK6dNKLxbwYde665FsU1Y1YWOWN6awwyfw5c+O7EFHzbBE6Fm5RCismdf6o4pqSiQdbvOBFuma5+A0IyEFdoBSqY4gEKe7hD1IeQNkSlhOOinVuK2TiyKiM59IHzrS/jsM9z3FfXD/7Hjj2c29HSJUx+7OMy2zkiPqC7KaMUxE6CrxEucl71XCE96flxlAjBGh7qOUBeHoWeZjPNzLKKoPj2P6zoEZDsmbXcbmPbUFUm465Nvcmsxdwlt/UBAbs3ad7icbUoKr9PS5ait9Ay5CSNReIo0nbSCWhIqUefo8sfRhsl4na6hh4PuEQVSMSnivn/PXrbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(346002)(39860400002)(26005)(6512007)(86362001)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(5660300002)(30864003)(6486002)(966005)(4326008)(107886003)(52116002)(2616005)(66556008)(66946007)(41300700001)(8676002)(186003)(66476007)(53546011)(316002)(54906003)(6506007)(8936002)(6916009)(6666004)(478600001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVyb0szNDFrSnZQVEdVbFdJeWhmUkdqWStQSnBpSlRvVHFUdHNlOHBjb05I?=
 =?utf-8?B?c2FxWVF5ZzU3aXBFWHdJZnFIYWZoaWIxVHVxNjg3R3UxbHpwa2xPR3A3ZUIv?=
 =?utf-8?B?RzFaYlh4RjlqcVZORkh0UzdzeEFWTGZoblJNbjRVYWEvSlRyU2JCR0lNUXow?=
 =?utf-8?B?SlZMbFZ5Zk1QWlphSXlTcmtSRURsTTlRRlZUZjJ4dG1zN2RkVDVoeEhvNm0v?=
 =?utf-8?B?UWlob1pXR1dNdWIxa1NjbjZ0b2lKTGtwWi8ySTlvcjVGZzRZcFZQc3BMaXZP?=
 =?utf-8?B?MjlacGxkb05CK1Y5dU1LaW5FakJSS2IzaEROK2hCY0NjbnZTNFkvRmhXak1D?=
 =?utf-8?B?REtNdkx6b1UvbVU0YnQ0Q3BMSDgzZ3VNL2VqQjhWWkkyMDdGQ3Z3SkhRUHgw?=
 =?utf-8?B?RWY4V3ZSVFBLRWxiMUtGNzlSQXF0Z3kwamhod3Z4c3ZLMVRkbVIyM0hGYzF4?=
 =?utf-8?B?NkNxMm9OZzhkYmpXVWtWR3AyQmxHQ1cxL2tLQmZuSlBqNHk4WXVvU2VSSXpW?=
 =?utf-8?B?aURLY01uY3lEM2dHU21GeTZZTHhUZmdFNlN0TEErUE5aN042cWVFb0R3MkJJ?=
 =?utf-8?B?NlFhRUVLWkVvWW4rL241MHJqMGtwdXR1cVE0R2I4Q0ZuUTVEcjFzUG81bWth?=
 =?utf-8?B?Qmt4bWgrVGt1ZmdxeExEUzVNNjhUcm5vSzdFTXZjZkxJNzZYTy9tR0hILzQ4?=
 =?utf-8?B?dmpsU0Q4dGhCaEdrUmxPejVLVFlyaW5BRE5Ma1dITFFxTnZyZ2dhSmtETVo0?=
 =?utf-8?B?Nkw1K3JuNUlHSzArZ3pjVUVadGFMR28xdGQ2Y2V3bUUzc0V4cUc0S0hyd2Rw?=
 =?utf-8?B?Z0psQmVPNUtLQzhNdllPVXlmODBYR3IzRTd4MEtMaWN3b3MxNjM2Q0JwR1dk?=
 =?utf-8?B?WVFMdE9jWFdWRHpUVjdFR1VCNlB4S0xUL1VtSUpCbDNJOUQyZWY4RDZLWS9l?=
 =?utf-8?B?ZVd0d2gvNitLVEZ3bFo1dlcvZ3JZTUhaUjJoeWhtanVLS3M1STBDdE5kSmcz?=
 =?utf-8?B?MlVya09qcW5kdUxHZnJpNk5UTk9TU2pTM0M3cUtrQTBSY0VadW0rbVhFanRy?=
 =?utf-8?B?amNnY2pYYXljazBnTWFqazR5b2tjOVdQeVRRZy91VmpZUDVVLzF2aTBScHQr?=
 =?utf-8?B?ZDBxcFByNlZmcUxwODV3ejRyUkpXTGI4Z0tMZlE0dTcwMXpxdEJGSE1EVXBN?=
 =?utf-8?B?Zk04LzNET25BMUtrK3dnNklMeExyNmtmOEM4U2JUdjQ1cU9LU3p2bmNhWEpW?=
 =?utf-8?B?a29nRlFobFl0STMyeFdQcjNocHFPMDdReWFBY1hBSGp2c2RadmRJYlgwbG1Q?=
 =?utf-8?B?MUMxMkFqSUNkMW1kWG53a0x1bkNxQW1yR3RmVi9OampqYTRxcTFjcGdtMDJw?=
 =?utf-8?B?eG1IOU9pZERrVUY1N3g0Z0czSnpNZTU1YkgzeWo0ZG5BVmlpSUFCeWtsQUtm?=
 =?utf-8?B?MWxZV1NmeEtBZW1QVzhLNDFUYndHcXBITnp2OERpRXJpMFg4MVVYWnpMUFZW?=
 =?utf-8?B?OVliZy92dHZ4M3ZzR1dsaVErVHhLSy8vS2tMaEU5SW5QaEx6c1JQZFVNNks3?=
 =?utf-8?B?NlAybDRuTUJBdHB0cWR0U2lTSk1lOGY2czVMcnJkKzZPcFhic0w2NjhMejhm?=
 =?utf-8?B?dVJnUGJoRDdKVkd3NmlYTkk3TW5QL2V6U2NqamJ3M3lTR0pxRGJxRzFWWUJO?=
 =?utf-8?B?MlR0dkQvaE9tSFZ1blhmMmZYd0Vqb0hNaUJjUVM5eEtBQUxiSGlrV0pseFNu?=
 =?utf-8?B?THZZOGlpdjdnYlNxcUVndHdXb3FXVnBpZlpOMEhodjhlQmVJMkVmakJIZG8r?=
 =?utf-8?B?QmZGbHp6V2JyTTVsZ0FYVHdIbjJCZTcydkhJM3oxN295OUFJcFdQWnBIakVo?=
 =?utf-8?B?ZEhGTHNlWFBtVUFYNUZkZ0Rza3hoOEVCai80bzc1d0ZBajNkK3VxMEZXcjBp?=
 =?utf-8?B?STFYTmtGd1RjNm9tdkFrUHIxYUR3TjdVeFJQQWZaaVl5YU5rR29tN0NLVnZK?=
 =?utf-8?B?eFdpMzg1NEFDY1FoaTV1QmkwS3NlSWdUa200TkdkOHBJY1dJT004UU9ZbWVU?=
 =?utf-8?B?TTNhWTJYVHk3VHRFU0FEYnFROU1BZEc5eWlXQUN3dkxqWXh1L0p3ZWlYNmM1?=
 =?utf-8?B?L3ZoTkFIOFpJK1JLWWxUQ2VCd3REMWJSNmlSRFl5R0ZIdUd6ZFdoWTg5ZFZ5?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65f3d90-c16a-4337-4b7d-08da6274fbfe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 13:06:22.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cww8KBMMEdT5GcfpGWhWteurpVNKwCK685XISqxiPVh4LgCm67Fzd0Mbjy5TBokJ1vkzAM3sjlDqB4xdTgj72xFdJEgRDTeVsZ5zqcaI0g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5967
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-10_11:2022-07-08,2022-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207100059
X-Proofpoint-ORIG-GUID: OmzOxlJ8e3KoriJuVzHFQYypgqkEEdSc
X-Proofpoint-GUID: OmzOxlJ8e3KoriJuVzHFQYypgqkEEdSc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Sun, Jul 10, 2022 at 3:38 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Sat, Jul 9, 2022 at 4:41 PM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >>
>> >>
>> >> > On Sat, Jul 9, 2022 at 2:32 PM James Hilliard <james.hilliard1@gmai=
l.com> wrote:
>> >> >>
>> >> >> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Marchesi
>> >> >> <jose.marchesi@oracle.com> wrote:
>> >> >> >
>> >> >> >
>> >> >> > > On Sat, Jul 9, 2022 at 11:24 AM Jose E. Marchesi
>> >> >> > > <jose.marchesi@oracle.com> wrote:
>> >> >> > >>
>> >> >> > >>
>> >> >> > >> > On Fri, Jul 8, 2022 at 12:33 PM Jose E. Marchesi
>> >> >> > >> > <jose.marchesi@oracle.com> wrote:
>> >> >> > >> >>
>> >> >> > >> >>
>> >> >> > >> >> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> >> >> > >> >> >> <james.hilliard1@gmail.com> wrote:
>> >> >> > >> >> >>>
>> >> >> > >> >> >>> Note I'm testing with the following patches:
>> >> >> > >> >> >>> https://lore.kernel.org/bpf/20220706111839.1247911-1-j=
ames.hilliard1@gmail.com/
>> >> >> > >> >> >>> https://lore.kernel.org/bpf/20220706140623.2917858-1-j=
ames.hilliard1@gmail.com/
>> >> >> > >> >> >>>
>> >> >> > >> >> >>> It would appear there's some compatibility issues with=
 bpftool gen and
>> >> >> > >> >> >>> GCC, not sure what side though is wrong here:
>> >> >> > >> >> >>> /home/buildroot/buildroot/output/per-package/systemd/h=
ost/sbin/bpftool
>> >> >> > >> >> >>> gen object src/core/bpf/restrict_ifaces/restrict-iface=
s.bpf.o
>> >> >> > >> >> >>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstr=
ipped.o
>> >> >> > >> >> >>> libbpf: failed to find BTF info for global/extern symb=
ol 'sd_restrictif_i'
>> >> >> > >> >> >>> Error: failed to link
>> >> >> > >> >> >>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unst=
ripped.o':
>> >> >> > >> >> >>> Unknown error -2 (-2)
>> >> >> > >> >> >>>
>> >> >> > >> >> >>> Relevant difference seems to be this:
>> >> >> > >> >> >>> GCC:
>> >> >> > >> >> >>> [55] FUNC 'sd_restrictif_i' type_id=3D47 linkage=3Dsta=
tic
>> >> >> > >> >> >>> Clang:
>> >> >> > >> >> >>> [27] FUNC 'sd_restrictif_i' type_id=3D26 linkage=3Dglo=
bal
>> >> >> > >> >> >
>> >> >> > >> >> > For functions GCC generates a BTF_KIND_FUNC entry, which=
 has no linkage
>> >> >> > >> >> > information, or so we thought: I just looked at bpftool/=
btf.c and I
>> >> >> > >> >> > found the linkage info for function types is expected to=
 be encoded in
>> >> >> > >> >> > the vlen field of BTF_KIND_FUNC entries (why not adding =
a btf_func
>> >> >> > >> >> > instead???) which is surprising to say the least.
>> >> >> > >> >> >
>> >> >> > >> >> > We are changing GCC to encode the linkage info in vlen f=
or these types.
>> >> >> > >> >> > Thanks for reporting this.
>> >> >> > >> >>
>> >> >> > >> >> Patch sent to GCC upstream:
>> >> >> > >> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090=
.html
>> >> >> > >> >
>> >> >> > >> > I applied that patch on top of GCC 12.1.0 and it appears to=
 fix the
>> >> >> > >> > bpftool gen object bug.
>> >> >> > >> >
>> >> >> > >> > I am however now hitting a different error during skeleton =
generation:
>> >> >> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/s=
bin/bpftool
>> >> >> > >> > gen skeleton src/core/bpf/restrict_ifaces/restrict-ifaces.b=
pf.o
>> >> >> > >> > libbpf: elf: skipping unrecognized data section(9) .comment
>> >> >> > >> > libbpf: failed to alloc map 'restrict.bss' content buffer: =
-22
>> >> >> > >> > Error: failed to open BPF object file: Invalid argument
>> >> >> > >>
>> >> >> > >> What is the size of the .bss section in the object file?  Try=
 with:
>> >> >> > >>
>> >> >> > >> $ size restrict-ifaces.bpf.o
>> >> >> > >
>> >> >> > > $ size
>> >> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/rest=
rict-ifaces.bpf.o
>> >> >> > >    text       data        bss        dec        hex    filenam=
e
>> >> >> > >     386         25          0        411        19b
>> >> >> > > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces=
/restrict-ifaces.bpf.o
>> >> >> >
>> >> >> > Right, so the .bss section is empty.  I see a `const volatile un=
signed
>> >> >> > char is_allow_list =3D 0;' in restrict-ifaces.bpf.c, but that go=
es to
>> >> >> > .data and not to .bss, as expected.
>> >> >> >
>> >> >> > If you build restrict-ifaces.bpf.o with LLVM, is the bss still e=
mpty?  I
>> >> >> > don't think the code in libbpf.c even checks for this eventualit=
y...
>> >> >>
>> >> >> LLVM version(which skeleton generation works with):
>> >> >> $ size restrict-ifaces.bpf.o
>> >> >>    text       data        bss        dec        hex    filename
>> >> >>     323         24          0        347        15b    restrict-if=
aces.bpf.o
>> >> >>
>> >> >> $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/b=
pftool
>> >> >> btf dump file restrict-ifaces.bpf.o format raw
>> >> >> [1] PTR '(anon)' type_id=3D3
>> >> >> [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIG=
NED
>> >> >> [3] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D1
>> >> >> [4] INT '__ARRAY_SIZE_TYPE__' size=3D4 bits_offset=3D0 nr_bits=3D3=
2 encoding=3D(none)
>> >> >> [5] PTR '(anon)' type_id=3D6
>> >> >> [6] TYPEDEF '__u32' type_id=3D7
>> >> >> [7] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 encod=
ing=3D(none)
>> >> >> [8] PTR '(anon)' type_id=3D9
>> >> >> [9] TYPEDEF '__u8' type_id=3D10
>> >> >> [10] INT 'unsigned char' size=3D1 bits_offset=3D0 nr_bits=3D8 enco=
ding=3D(none)
>> >> >> [11] STRUCT '(anon)' size=3D24 vlen=3D3
>> >> >>     'type' type_id=3D1 bits_offset=3D0
>> >> >>     'key' type_id=3D5 bits_offset=3D64
>> >> >>     'value' type_id=3D8 bits_offset=3D128
>> >> >> [12] VAR 'sd_restrictif' type_id=3D11, linkage=3Dglobal
>> >> >> [13] PTR '(anon)' type_id=3D14
>> >> >> [14] CONST '(anon)' type_id=3D15
>> >> >> [15] STRUCT '__sk_buff' size=3D192 vlen=3D33
>> >> >>     'len' type_id=3D6 bits_offset=3D0
>> >> >>     'pkt_type' type_id=3D6 bits_offset=3D32
>> >> >>     'mark' type_id=3D6 bits_offset=3D64
>> >> >>     'queue_mapping' type_id=3D6 bits_offset=3D96
>> >> >>     'protocol' type_id=3D6 bits_offset=3D128
>> >> >>     'vlan_present' type_id=3D6 bits_offset=3D160
>> >> >>     'vlan_tci' type_id=3D6 bits_offset=3D192
>> >> >>     'vlan_proto' type_id=3D6 bits_offset=3D224
>> >> >>     'priority' type_id=3D6 bits_offset=3D256
>> >> >>     'ingress_ifindex' type_id=3D6 bits_offset=3D288
>> >> >>     'ifindex' type_id=3D6 bits_offset=3D320
>> >> >>     'tc_index' type_id=3D6 bits_offset=3D352
>> >> >>     'cb' type_id=3D16 bits_offset=3D384
>> >> >>     'hash' type_id=3D6 bits_offset=3D544
>> >> >>     'tc_classid' type_id=3D6 bits_offset=3D576
>> >> >>     'data' type_id=3D6 bits_offset=3D608
>> >> >>     'data_end' type_id=3D6 bits_offset=3D640
>> >> >>     'napi_id' type_id=3D6 bits_offset=3D672
>> >> >>     'family' type_id=3D6 bits_offset=3D704
>> >> >>     'remote_ip4' type_id=3D6 bits_offset=3D736
>> >> >>     'local_ip4' type_id=3D6 bits_offset=3D768
>> >> >>     'remote_ip6' type_id=3D17 bits_offset=3D800
>> >> >>     'local_ip6' type_id=3D17 bits_offset=3D928
>> >> >>     'remote_port' type_id=3D6 bits_offset=3D1056
>> >> >>     'local_port' type_id=3D6 bits_offset=3D1088
>> >> >>     'data_meta' type_id=3D6 bits_offset=3D1120
>> >> >>     '(anon)' type_id=3D18 bits_offset=3D1152
>> >> >>     'tstamp' type_id=3D20 bits_offset=3D1216
>> >> >>     'wire_len' type_id=3D6 bits_offset=3D1280
>> >> >>     'gso_segs' type_id=3D6 bits_offset=3D1312
>> >> >>     '(anon)' type_id=3D22 bits_offset=3D1344
>> >> >>     'gso_size' type_id=3D6 bits_offset=3D1408
>> >> >>     'hwtstamp' type_id=3D20 bits_offset=3D1472
>> >> >> [16] ARRAY '(anon)' type_id=3D6 index_type_id=3D4 nr_elems=3D5
>> >> >> [17] ARRAY '(anon)' type_id=3D6 index_type_id=3D4 nr_elems=3D4
>> >> >> [18] UNION '(anon)' size=3D8 vlen=3D1
>> >> >>     'flow_keys' type_id=3D19 bits_offset=3D0
>> >> >> [19] PTR '(anon)' type_id=3D34
>> >> >> [20] TYPEDEF '__u64' type_id=3D21
>> >> >> [21] INT 'unsigned long long' size=3D8 bits_offset=3D0 nr_bits=3D6=
4 encoding=3D(none)
>> >> >> [22] UNION '(anon)' size=3D8 vlen=3D1
>> >> >>     'sk' type_id=3D23 bits_offset=3D0
>> >> >> [23] PTR '(anon)' type_id=3D35
>> >> >> [24] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
>> >> >>     'sk' type_id=3D13
>> >> >> [25] FUNC 'sd_restrictif_e' type_id=3D24 linkage=3Dglobal
>> >> >> [26] FUNC 'sd_restrictif_i' type_id=3D24 linkage=3Dglobal
>> >> >> [27] CONST '(anon)' type_id=3D28
>> >> >> [28] VOLATILE '(anon)' type_id=3D9
>> >> >> [29] VAR 'is_allow_list' type_id=3D27, linkage=3Dglobal
>> >> >> [30] CONST '(anon)' type_id=3D31
>> >> >> [31] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSI=
GNED
>> >> >> [32] ARRAY '(anon)' type_id=3D30 index_type_id=3D4 nr_elems=3D18
>> >> >> [33] VAR '_license' type_id=3D32, linkage=3Dstatic
>> >> >> [34] FWD 'bpf_flow_keys' fwd_kind=3Dstruct
>> >> >> [35] FWD 'bpf_sock' fwd_kind=3Dstruct
>> >> >> [36] DATASEC '.rodata' size=3D1 vlen=3D1
>> >> >>     type_id=3D29 offset=3D0 size=3D1 (VAR 'is_allow_list')
>> >> >> [37] DATASEC 'license' size=3D18 vlen=3D1
>> >> >>     type_id=3D33 offset=3D0 size=3D18 (VAR '_license')
>> >> >> [38] DATASEC '.maps' size=3D24 vlen=3D1
>> >> >>     type_id=3D12 offset=3D0 size=3D24 (VAR 'sd_restrictif')
>> >> >>
>> >> >
>> >> > Skeleton generation debug output for GCC(failing) and LLVM(working)
>> >> > which may be helpful:
>> >>
>> >> Indeed it was helpful :)
>> >>
>> >> The GNU assembler generates an empty .bss section.  This is a well
>> >> established behavior in GAS that happens in all supported targets.
>> >>
>> >> The LLVM assembler doesn't generate an empty .bss section.
>> >>
>> >> bpftool chokes on the empty .bss section.
>> >>
>> >> In this case I would suggest to fix bpf_object__init_global_data_maps=
 in
>> >> order to skip empty sections.
>> >>
>> >> Something like this:
>> >
>> > Hmm, that seems to segfault:
>>
>> Yes, I see in bpf_object__elf_collect that sec_desc->data is not
>> initialized when a section is not recognized.  In this case, this
>> happens with .comment.
>>
>> All right then:
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index e89cc9c885b3..887b78780099 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -1591,6 +1591,10 @@ static int bpf_object__init_global_data_maps(stru=
ct bpf_object *obj)
>>         for (sec_idx =3D 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
>>                 sec_desc =3D &obj->efile.secs[sec_idx];
>>
>> +                /* Skip recognized sections with size 0.  */
>> +                if (sec_desc->data && sec_desc->data->d_size =3D=3D 0)
>> +                  continue;
>> +
>>                 switch (sec_desc->sec_type) {
>>                 case SEC_DATA:
>>                         sec_name =3D elf_sec_name(obj, elf_sec_by_idx(ob=
j, sec_idx));
>
> Ok, skeleton is now getting generated successfully, however it differs fr=
om the
> clang version so there's a build error when we include/use the header:
> ../src/core/restrict-ifaces.c: In function =E2=80=98prepare_restrict_ifac=
es_bpf=E2=80=99:
> ../src/core/restrict-ifaces.c:45:14: error: =E2=80=98struct
> restrict_ifaces_bpf=E2=80=99 has no member named =E2=80=98rodata=E2=80=99=
; did you mean
> =E2=80=98data=E2=80=99?
>    45 |         obj->rodata->is_allow_list =3D is_allow_list;
>       |              ^~~~~~
>       |              data
>
> The issue appears to be that clang generates "rodata" members in
> restrict_ifaces_bpf while with gcc we get "data" members instead.

This is because the BPF GCC port is putting the

  const volatile unsigned char is_allow_list =3D 0;

in a .data section instead of .rodata, due to the `volatile'.  The
x86_64 GCC seems to use .rodata.

Looking at why the PBF port does this...


> Differences below:
>
> GCC:
> $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> --debug gen skeleton
> output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-i=
faces.bpf.o
> libbpf: loading object 'restrict_ifaces_bpf' from buffer
> libbpf: elf: section(2) .symtab, size 336, link 1, flags 0, type=3D2
> libbpf: elf: section(3) .data, size 1, link 0, flags 3, type=3D1
> libbpf: elf: section(4) .bss, size 0, link 0, flags 3, type=3D8
> libbpf: elf: section(5) cgroup_skb/egress, size 184, link 0, flags 6, typ=
e=3D1
> libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
> insn offset 0 (0 bytes), code size 23 insns (184 bytes)
> libbpf: elf: section(6) cgroup_skb/ingress, size 184, link 0, flags 6, ty=
pe=3D1
> libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' at
> insn offset 0 (0 bytes), code size 23 insns (184 bytes)
> libbpf: elf: section(7) license, size 18, link 0, flags 2, type=3D1
> libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
> libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=3D1
> libbpf: elf: section(9) .comment, size 49, link 0, flags 30, type=3D1
> libbpf: elf: skipping unrecognized data section(9) .comment
> libbpf: elf: section(10) .relcgroup_skb/egress, size 32, link 2, flags
> 40, type=3D9
> libbpf: elf: section(11) .relcgroup_skb/ingress, size 32, link 2,
> flags 40, type=3D9
> libbpf: elf: section(12) .BTF, size 3606, link 0, flags 0, type=3D1
> libbpf: looking for externs among 14 symbols...
> libbpf: collected 0 externs total
> libbpf: map 'sd_restrictif': at sec_idx 8, offset 0.
> libbpf: map 'sd_restrictif': found type =3D 1.
> libbpf: map 'sd_restrictif': found key [12], sz =3D 4.
> libbpf: map 'sd_restrictif': found value [3], sz =3D 1.
> libbpf: map 'restrict.data' (global data): at sec_idx 3, offset 0, flags =
400.
> libbpf: map 1 is "restrict.data"
> libbpf: sec '.relcgroup_skb/egress': collecting relocation for
> section(5) 'cgroup_skb/egress'
> libbpf: sec '.relcgroup_skb/egress': relo #0: insn #4 against 'sd_restric=
tif'
> libbpf: prog 'sd_restrictif_e': found map 0 (sd_restrictif, sec 8, off
> 0) for insn #4
> libbpf: sec '.relcgroup_skb/egress': relo #1: insn #7 against 'is_allow_l=
ist'
> libbpf: prog 'sd_restrictif_e': found data map 1 (restrict.data, sec
> 3, off 0) for insn 7
> libbpf: sec '.relcgroup_skb/ingress': collecting relocation for
> section(6) 'cgroup_skb/ingress'
> libbpf: sec '.relcgroup_skb/ingress': relo #0: insn #4 against 'sd_restri=
ctif'
> libbpf: prog 'sd_restrictif_i': found map 0 (sd_restrictif, sec 8, off
> 0) for insn #4
> libbpf: sec '.relcgroup_skb/ingress': relo #1: insn #7 against 'is_allow_=
list'
> libbpf: prog 'sd_restrictif_i': found data map 1 (restrict.data, sec
> 3, off 0) for insn 7
> /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>
> /* THIS FILE IS AUTOGENERATED BY BPFTOOL! */
> #ifndef __RESTRICT_IFACES_BPF_SKEL_H__
> #define __RESTRICT_IFACES_BPF_SKEL_H__
>
> #include <errno.h>
> #include <stdlib.h>
> #include <bpf/libbpf.h>
>
> struct restrict_ifaces_bpf {
>     struct bpf_object_skeleton *skeleton;
>     struct bpf_object *obj;
>     struct {
>         struct bpf_map *sd_restrictif;
>         struct bpf_map *data;
>     } maps;
>     struct {
>         struct bpf_program *sd_restrictif_e;
>         struct bpf_program *sd_restrictif_i;
>     } progs;
>     struct {
>         struct bpf_link *sd_restrictif_e;
>         struct bpf_link *sd_restrictif_i;
>     } links;
>     struct restrict_ifaces_bpf__data {
>         __u8 is_allow_list;
>     } *data;
>
> #ifdef __cplusplus
>     static inline struct restrict_ifaces_bpf *open(const struct
> bpf_object_open_opts *opts =3D nullptr);
>     static inline struct restrict_ifaces_bpf *open_and_load();
>     static inline int load(struct restrict_ifaces_bpf *skel);
>     static inline int attach(struct restrict_ifaces_bpf *skel);
>     static inline void detach(struct restrict_ifaces_bpf *skel);
>     static inline void destroy(struct restrict_ifaces_bpf *skel);
>     static inline const void *elf_bytes(size_t *sz);
> #endif /* __cplusplus */
> };
>
> static void
> restrict_ifaces_bpf__destroy(struct restrict_ifaces_bpf *obj)
> {
>     if (!obj)
>         return;
>     if (obj->skeleton)
>         bpf_object__destroy_skeleton(obj->skeleton);
>     free(obj);
> }
>
> static inline int
> restrict_ifaces_bpf__create_skeleton(struct restrict_ifaces_bpf *obj);
>
> static inline struct restrict_ifaces_bpf *
> restrict_ifaces_bpf__open_opts(const struct bpf_object_open_opts *opts)
> {
>     struct restrict_ifaces_bpf *obj;
>     int err;
>
>     obj =3D (struct restrict_ifaces_bpf *)calloc(1, sizeof(*obj));
>     if (!obj) {
>         errno =3D ENOMEM;
>         return NULL;
>     }
>
>     err =3D restrict_ifaces_bpf__create_skeleton(obj);
>     if (err)
>         goto err_out;
>
>     err =3D bpf_object__open_skeleton(obj->skeleton, opts);
>     if (err)
>         goto err_out;
>
>     return obj;
> err_out:
>     restrict_ifaces_bpf__destroy(obj);
>     errno =3D -err;
>     return NULL;
> }
>
> static inline struct restrict_ifaces_bpf *
> restrict_ifaces_bpf__open(void)
> {
>     return restrict_ifaces_bpf__open_opts(NULL);
> }
>
> static inline int
> restrict_ifaces_bpf__load(struct restrict_ifaces_bpf *obj)
> {
>     return bpf_object__load_skeleton(obj->skeleton);
> }
>
> static inline struct restrict_ifaces_bpf *
> restrict_ifaces_bpf__open_and_load(void)
> {
>     struct restrict_ifaces_bpf *obj;
>     int err;
>
>     obj =3D restrict_ifaces_bpf__open();
>     if (!obj)
>         return NULL;
>     err =3D restrict_ifaces_bpf__load(obj);
>     if (err) {
>         restrict_ifaces_bpf__destroy(obj);
>         errno =3D -err;
>         return NULL;
>     }
>     return obj;
> }
>
> static inline int
> restrict_ifaces_bpf__attach(struct restrict_ifaces_bpf *obj)
> {
>     return bpf_object__attach_skeleton(obj->skeleton);
> }
>
> static inline void
> restrict_ifaces_bpf__detach(struct restrict_ifaces_bpf *obj)
> {
>     return bpf_object__detach_skeleton(obj->skeleton);
> }
>
> static inline const void *restrict_ifaces_bpf__elf_bytes(size_t *sz);
>
> static inline int
> restrict_ifaces_bpf__create_skeleton(struct restrict_ifaces_bpf *obj)
> {
>     struct bpf_object_skeleton *s;
>     int err;
>
>     s =3D (struct bpf_object_skeleton *)calloc(1, sizeof(*s));
>     if (!s)    {
>         err =3D -ENOMEM;
>         goto err;
>     }
>
>     s->sz =3D sizeof(*s);
>     s->name =3D "restrict_ifaces_bpf";
>     s->obj =3D &obj->obj;
>
>     /* maps */
>     s->map_cnt =3D 2;
>     s->map_skel_sz =3D sizeof(*s->maps);
>     s->maps =3D (struct bpf_map_skeleton *)calloc(s->map_cnt, s->map_skel=
_sz);
>     if (!s->maps) {
>         err =3D -ENOMEM;
>         goto err;
>     }
>
>     s->maps[0].name =3D "sd_restrictif";
>     s->maps[0].map =3D &obj->maps.sd_restrictif;
>
>     s->maps[1].name =3D "restrict.data";
>     s->maps[1].map =3D &obj->maps.data;
>     s->maps[1].mmaped =3D (void **)&obj->data;
>
>     /* programs */
>     s->prog_cnt =3D 2;
>     s->prog_skel_sz =3D sizeof(*s->progs);
>     s->progs =3D (struct bpf_prog_skeleton *)calloc(s->prog_cnt, s->prog_=
skel_sz);
>     if (!s->progs) {
>         err =3D -ENOMEM;
>         goto err;
>     }
>
>     s->progs[0].name =3D "sd_restrictif_e";
>     s->progs[0].prog =3D &obj->progs.sd_restrictif_e;
>     s->progs[0].link =3D &obj->links.sd_restrictif_e;
>
>     s->progs[1].name =3D "sd_restrictif_i";
>     s->progs[1].prog =3D &obj->progs.sd_restrictif_i;
>     s->progs[1].link =3D &obj->links.sd_restrictif_i;
>
>     s->data =3D (void *)restrict_ifaces_bpf__elf_bytes(&s->data_sz);
>
>     obj->skeleton =3D s;
>     return 0;
> err:
>     bpf_object__destroy_skeleton(s);
>     return err;
> }
>
> static inline const void *restrict_ifaces_bpf__elf_bytes(size_t *sz)
> {
>     *sz =3D 5616;
>     return (const void *)"\
> \x7f\x45\x4c\x46\x02\x01\x01\0\0\0\0\0\0\0\0\0\x01\0\xf7\0\x01\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\xb0\x12\0\0\0\0\0\0\0\0\0\0\x40\0\0\0\0\0\x40\0\x0=
d\0\
> \x01\0\0\x2e\x73\x74\x72\x74\x61\x62\0\x2e\x73\x79\x6d\x74\x61\x62\0\x2e\=
x64\
> \x61\x74\x61\0\x2e\x62\x73\x73\0\x63\x67\x72\x6f\x75\x70\x5f\x73\x6b\x62\=
x2f\
> \x65\x67\x72\x65\x73\x73\0\x63\x67\x72\x6f\x75\x70\x5f\x73\x6b\x62\x2f\x6=
9\x6e\
> \x67\x72\x65\x73\x73\0\x6c\x69\x63\x65\x6e\x73\x65\0\x2e\x6d\x61\x70\x73\=
0\x2e\
> \x63\x6f\x6d\x6d\x65\x6e\x74\0\x72\x65\x73\x74\x72\x69\x63\x74\x2d\x69\x6=
6\x61\
> \x63\x65\x73\x2e\x62\x70\x66\x2e\x63\0\x5f\x6c\x69\x63\x65\x6e\x73\x65\0\=
x73\
> \x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x69\x66\x5f\x65\0\x73\x64\x5f\x7=
2\x65\
> \x73\x74\x72\x69\x63\x74\x69\x66\0\x69\x73\x5f\x61\x6c\x6c\x6f\x77\x5f\x6=
c\x69\
> \x73\x74\0\x73\x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x69\x66\x5f\x69\0\=
x2e\
> \x72\x65\x6c\x63\x67\x72\x6f\x75\x70\x5f\x73\x6b\x62\x2f\x65\x67\x72\x65\=
x73\
> \x73\0\x2e\x72\x65\x6c\x63\x67\x72\x6f\x75\x70\x5f\x73\x6b\x62\x2f\x69\x6=
e\x67\
> \x72\x65\x73\x73\0\x2e\x42\x54\x46\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\x58\0\0\0\x04\0\xf1\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\
> \x03\0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x04\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x05\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \x03\0\x06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x07\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\x6e\0\0\0\x01\0\x07\0\0\0\0\0\0\0\0\0\x12\0\0\0\0\0\0\=
0\0\0\
> \0\0\x03\0\x08\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x09\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\x77\0\0\0\x12\0\x05\0\0\0\0\0\0\0\0\0\xb8\0\0\0\0\=
0\0\0\
> \x87\0\0\0\x11\0\x08\0\0\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x95\0\0\0\x11\0\=
x03\0\
> \0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\xa3\0\0\0\x12\0\x06\0\0\0\0\0\0\0\0\0\=
xb8\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\x28\0\0\0\0\0\x63\x0a\xfc\xff\0\0\0\=
0\xbf\
> \xa2\0\0\0\0\0\0\x07\x02\0\0\xfc\xff\xff\xff\x18\x01\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\x85\0\0\0\x01\0\0\0\x18\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x71\x13\0\0\0\=
0\0\0\
> \x57\x03\0\0\xff\0\0\0\x15\x03\x05\0\0\0\0\0\xbf\x02\0\0\0\0\0\0\x87\x02\=
0\0\0\
> \0\0\0\x4f\x20\0\0\0\0\0\0\x77\0\0\0\x3f\0\0\0\x95\0\0\0\0\0\0\0\xb7\x01\=
0\0\
> \x01\0\0\0\x15\0\x01\0\0\0\0\0\xbf\x31\0\0\0\0\0\0\xbf\x10\0\0\0\0\0\0\x5=
7\0\0\
> \0\x01\0\0\0\x95\0\0\0\0\0\0\0\x61\x10\x28\0\0\0\0\0\x63\x0a\xfc\xff\0\0\=
0\0\
> \xbf\xa2\0\0\0\0\0\0\x07\x02\0\0\xfc\xff\xff\xff\x18\x01\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\x85\0\0\0\x01\0\0\0\x18\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x71\x13\0\=
0\0\0\
> \0\0\x57\x03\0\0\xff\0\0\0\x15\x03\x05\0\0\0\0\0\xbf\x02\0\0\0\0\0\0\x87\=
x02\0\
> \0\0\0\0\0\x4f\x20\0\0\0\0\0\0\x77\0\0\0\x3f\0\0\0\x95\0\0\0\0\0\0\0\xb7\=
x01\0\
> \0\x01\0\0\0\x15\0\x01\0\0\0\0\0\xbf\x31\0\0\0\0\0\0\xbf\x10\0\0\0\0\0\0\=
x57\0\
> \0\0\x01\0\0\0\x95\0\0\0\0\0\0\0\x4c\x47\x50\x4c\x2d\x32\x2e\x31\x2d\x6f\=
x72\
> \x2d\x6c\x61\x74\x65\x72\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\x47\x43\x43\x3a\x20\x28\x42\x75\x69\x6c\x64\x72\x6f\x6f\x74\x2=
0\x32\
> \x30\x32\x32\x2e\x30\x35\x2d\x31\x33\x32\x2d\x67\x35\x32\x38\x62\x35\x61\=
x36\
> \x35\x66\x36\x29\x20\x31\x32\x2e\x31\x2e\x30\0\0\0\0\0\0\0\0\x20\0\0\0\0\=
0\0\0\
> \x01\0\0\0\x0b\0\0\0\x38\0\0\0\0\0\0\0\x01\0\0\0\x0c\0\0\0\x20\0\0\0\0\0\=
0\0\
> \x01\0\0\0\x0b\0\0\0\x38\0\0\0\0\0\0\0\x01\0\0\0\x0c\0\0\0\x9f\xeb\x01\0\=
x18\0\
> \0\0\0\0\0\0\x9c\x07\0\0\x9c\x07\0\0\x62\x06\0\0\x01\0\0\0\0\0\0\x01\x01\=
0\0\0\
> \x08\0\0\x03\x0d\0\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\x02\x1b\0\0\0\0\0\0\x0=
8\x02\
> \0\0\0\0\0\0\0\0\0\0\x0a\x03\0\0\0\0\0\0\0\0\0\0\x09\x04\0\0\0\x20\0\0\0\=
0\0\0\
> \x01\x02\0\0\0\x10\0\0\x01\x2a\0\0\0\0\0\0\x01\x02\0\0\0\x10\0\0\0\x3d\0\=
0\0\0\
> \0\0\x08\x07\0\0\0\x43\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\x47\0\0\0\0\=
0\0\
> \x08\x09\0\0\0\x4d\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\x5a\0\0\0\0\0\0\x0=
8\x0b\
> \0\0\0\x60\0\0\0\0\0\0\x01\x08\0\0\0\x40\0\0\x01\x6e\0\0\0\0\0\0\x01\x08\=
0\0\0\
> \x40\0\0\0\x85\0\0\0\0\0\0\x08\x0e\0\0\0\x8b\0\0\0\0\0\0\x01\x08\0\0\0\x4=
0\0\0\
> \0\x9d\0\0\0\0\0\0\x01\x08\0\0\0\x40\0\0\x01\xa6\0\0\0\0\0\0\x01\x01\0\0\=
0\x08\
> \0\0\x03\0\0\0\0\0\0\0\x0a\x12\0\0\0\xab\0\0\0\0\0\0\x08\x08\0\0\0\xb2\0\=
0\0\0\
> \0\0\x08\x0c\0\0\0\xb9\0\0\0\x1f\0\0\x06\x04\0\0\0\xc6\0\0\0\0\0\0\0\xda\=
0\0\0\
> \x01\0\0\0\xec\0\0\0\x02\0\0\0\xff\0\0\0\x03\0\0\0\x17\x01\0\0\x04\0\0\0\=
x35\
> \x01\0\0\x05\0\0\0\x4e\x01\0\0\x06\0\0\0\x68\x01\0\0\x07\0\0\0\x81\x01\0\=
0\x08\
> \0\0\0\x9b\x01\0\0\x09\0\0\0\xb1\x01\0\0\x0a\0\0\0\xce\x01\0\0\x0b\0\0\0\=
xe4\
> \x01\0\0\x0c\0\0\0\xff\x01\0\0\x0d\0\0\0\x19\x02\0\0\x0e\0\0\0\x2d\x02\0\=
0\x0f\
> \0\0\0\x42\x02\0\0\x10\0\0\0\x56\x02\0\0\x11\0\0\0\x6a\x02\0\0\x12\0\0\0\=
x80\
> \x02\0\0\x13\0\0\0\x9c\x02\0\0\x14\0\0\0\xbd\x02\0\0\x15\0\0\0\xe0\x02\0\=
0\x16\
> \0\0\0\xf3\x02\0\0\x17\0\0\0\x06\x03\0\0\x18\0\0\0\x1e\x03\0\0\x19\0\0\0\=
x37\
> \x03\0\0\x1a\0\0\0\x4f\x03\0\0\x1b\0\0\0\x64\x03\0\0\x1c\0\0\0\x7f\x03\0\=
0\x1d\
> \0\0\0\x99\x03\0\0\x1e\0\0\0\0\0\0\0\x01\0\0\x05\x08\0\0\0\xb3\x03\0\0\x1=
d\0\0\
> \0\0\0\0\0\xbd\x03\0\0\x0d\0\0\x04\x38\0\0\0\xcb\x03\0\0\x08\0\0\0\0\0\0\=
0\xd1\
> \x03\0\0\x08\0\0\0\x10\0\0\0\xd7\x03\0\0\x08\0\0\0\x20\0\0\0\xe2\x03\0\0\=
x03\0\
> \0\0\x30\0\0\0\xea\x03\0\0\x03\0\0\0\x38\0\0\0\xf8\x03\0\0\x03\0\0\0\x40\=
0\0\0\
> \x01\x04\0\0\x03\0\0\0\x48\0\0\0\x0a\x04\0\0\x14\0\0\0\x50\0\0\0\x12\x04\=
0\0\
> \x14\0\0\0\x60\0\0\0\x18\x04\0\0\x14\0\0\0\x70\0\0\0\0\0\0\0\x19\0\0\0\x8=
0\0\0\
> \0\x1e\x04\0\0\x0c\0\0\0\x80\x01\0\0\x24\x04\0\0\x15\0\0\0\xa0\x01\0\0\0\=
0\0\0\
> \x02\0\0\x05\x20\0\0\0\0\0\0\0\x1a\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\=
0\0\0\
> \0\0\x02\0\0\x04\x08\0\0\0\x2f\x04\0\0\x15\0\0\0\0\0\0\0\x38\x04\0\0\x15\=
0\0\0\
> \x20\0\0\0\0\0\0\0\x02\0\0\x04\x20\0\0\0\x41\x04\0\0\x1c\0\0\0\0\0\0\0\x4=
a\x04\
> \0\0\x1c\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x0c\0\0\0\x10\0\0\0\x0=
4\0\0\
> \0\0\0\0\0\0\0\0\x02\x18\0\0\0\0\0\0\0\x01\0\0\x05\x08\0\0\0\x53\x04\0\0\=
x20\0\
> \0\0\0\0\0\0\x56\x04\0\0\x0e\0\0\x04\x50\0\0\0\x5f\x04\0\0\x0c\0\0\0\0\0\=
0\0\
> \x6c\x04\0\0\x0c\0\0\0\x20\0\0\0\x73\x04\0\0\x0c\0\0\0\x40\0\0\0\x78\x04\=
0\0\
> \x0c\0\0\0\x60\0\0\0\x81\x04\0\0\x0c\0\0\0\x80\0\0\0\x86\x04\0\0\x0c\0\0\=
0\xa0\
> \0\0\0\x8f\x04\0\0\x0c\0\0\0\xc0\0\0\0\x97\x04\0\0\x1c\0\0\0\xe0\0\0\0\x9=
f\x04\
> \0\0\x0c\0\0\0\x60\x01\0\0\xa8\x04\0\0\x14\0\0\0\x80\x01\0\0\xb1\x04\0\0\=
x0c\0\
> \0\0\xa0\x01\0\0\xb9\x04\0\0\x1c\0\0\0\xc0\x01\0\0\xc1\x04\0\0\x0c\0\0\0\=
x40\
> \x02\0\0\xc7\x04\0\0\x0a\0\0\0\x60\x02\0\0\0\0\0\0\0\0\0\x02\x1f\0\0\0\xd=
8\x04\
> \0\0\x21\0\0\x04\xc0\0\0\0\xe2\x04\0\0\x0c\0\0\0\0\0\0\0\xe6\x04\0\0\x0c\=
0\0\0\
> \x20\0\0\0\x81\x04\0\0\x0c\0\0\0\x40\0\0\0\xef\x04\0\0\x0c\0\0\0\x60\0\0\=
0\x78\
> \x04\0\0\x0c\0\0\0\x80\0\0\0\xfd\x04\0\0\x0c\0\0\0\xa0\0\0\0\x0a\x05\0\0\=
x0c\0\
> \0\0\xc0\0\0\0\x13\x05\0\0\x0c\0\0\0\xe0\0\0\0\x86\x04\0\0\x0c\0\0\0\0\x0=
1\0\0\
> \x1e\x05\0\0\x0c\0\0\0\x20\x01\0\0\x2e\x05\0\0\x0c\0\0\0\x40\x01\0\0\x36\=
x05\0\
> \0\x0c\0\0\0\x60\x01\0\0\x3f\x05\0\0\x22\0\0\0\x80\x01\0\0\x42\x05\0\0\x0=
c\0\0\
> \0\x20\x02\0\0\x47\x05\0\0\x0c\0\0\0\x40\x02\0\0\x52\x05\0\0\x0c\0\0\0\x6=
0\x02\
> \0\0\x57\x05\0\0\x0c\0\0\0\x80\x02\0\0\x60\x05\0\0\x0c\0\0\0\xa0\x02\0\0\=
x6c\
> \x04\0\0\x0c\0\0\0\xc0\x02\0\0\x68\x05\0\0\x0c\0\0\0\xe0\x02\0\0\x73\x05\=
0\0\
> \x0c\0\0\0\0\x03\0\0\x7d\x05\0\0\x1c\0\0\0\x20\x03\0\0\x88\x05\0\0\x1c\0\=
0\0\
> \xa0\x03\0\0\x92\x05\0\0\x0c\0\0\0\x20\x04\0\0\x9e\x05\0\0\x0c\0\0\0\x40\=
x04\0\
> \0\xa9\x05\0\0\x0c\0\0\0\x60\x04\0\0\0\0\0\0\x17\0\0\0\x80\x04\0\0\xb3\x0=
5\0\0\
> \x0f\0\0\0\xc0\x04\0\0\xba\x05\0\0\x0c\0\0\0\0\x05\0\0\xc3\x05\0\0\x0c\0\=
0\0\
> \x20\x05\0\0\0\0\0\0\x1e\0\0\0\x40\x05\0\0\xcc\x05\0\0\x0c\0\0\0\x80\x05\=
0\0\
> \xd5\x05\0\0\x0f\0\0\0\xc0\x05\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x0c\0\0\0\x1=
0\0\0\
> \0\x05\0\0\0\0\0\0\0\0\0\0\x0a\x21\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\0\0\0\0\=
0\x03\
> \0\0\x04\x18\0\0\0\x73\x04\0\0\x27\0\0\0\0\0\0\0\xde\x05\0\0\x28\0\0\0\x4=
0\0\0\
> \0\xe2\x05\0\0\x29\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x09\0\0\0\x1=
0\0\0\
> \0\x01\0\0\0\0\0\0\0\0\0\0\x02\x26\0\0\0\0\0\0\0\0\0\0\x02\x0c\0\0\0\0\0\=
0\0\0\
> \0\0\x02\x03\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x13\0\0\0\x10\0\0\0\x12\0\0\=
0\0\0\
> \0\0\0\0\0\x0a\x2a\0\0\0\0\0\0\0\x02\0\0\x0d\x24\0\0\0\0\0\0\0\x24\0\0\0\=
0\0\0\
> \0\x2e\0\0\0\0\0\0\0\0\0\0\x0a\0\0\0\0\0\0\0\0\0\0\0\x02\x2d\0\0\0\0\0\0\=
0\x01\
> \0\0\x0d\x09\0\0\0\x53\x04\0\0\x30\0\0\0\0\0\0\0\0\0\0\x02\x23\0\0\0\xe8\=
x05\0\
> \0\0\0\0\x0e\x2b\0\0\0\0\0\0\0\xf1\x05\0\0\0\0\0\x0e\x05\0\0\0\x01\0\0\0\=
xff\
> \x05\0\0\0\0\0\x0e\x25\0\0\0\x01\0\0\0\x0d\x06\0\0\x01\0\0\x0c\x2f\0\0\0\=
x1d\
> \x06\0\0\x01\0\0\x0c\x2f\0\0\0\x2d\x06\0\0\0\0\0\x0c\x2f\0\0\0\x4e\x06\0\=
0\x01\
> \0\0\x0f\x01\0\0\0\x32\0\0\0\0\0\0\0\x01\0\0\0\x54\x06\0\0\x01\0\0\x0f\x1=
2\0\0\
> \0\x31\0\0\0\0\0\0\0\x12\0\0\0\x5c\x06\0\0\x01\0\0\x0f\x18\0\0\0\x33\0\0\=
0\0\0\
> \0\0\x18\0\0\0\0\x73\x69\x67\x6e\x65\x64\x20\x63\x68\x61\x72\0\x75\x6e\x7=
3\x69\
> \x67\x6e\x65\x64\x20\x63\x68\x61\x72\0\x5f\x5f\x75\x38\0\x73\x68\x6f\x72\=
x74\
> \x20\x69\x6e\x74\0\x73\x68\x6f\x72\x74\x20\x75\x6e\x73\x69\x67\x6e\x65\x6=
4\x20\
> \x69\x6e\x74\0\x5f\x5f\x75\x31\x36\0\x69\x6e\x74\0\x5f\x5f\x73\x33\x32\0\=
x75\
> \x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\x74\0\x5f\x5f\x75\x33\x32\0\x6c\=
x6f\
> \x6e\x67\x20\x6c\x6f\x6e\x67\x20\x69\x6e\x74\0\x6c\x6f\x6e\x67\x20\x6c\x6=
f\x6e\
> \x67\x20\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\x74\0\x5f\x5f\x75\x3=
6\x34\
> \0\x6c\x6f\x6e\x67\x20\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\x74\0\=
x6c\
> \x6f\x6e\x67\x20\x69\x6e\x74\0\x63\x68\x61\x72\0\x5f\x5f\x62\x65\x31\x36\=
0\x5f\
> \x5f\x62\x65\x33\x32\0\x62\x70\x66\x5f\x6d\x61\x70\x5f\x74\x79\x70\x65\0\=
x42\
> \x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x55\x4e\x53\x50\x45\x43\=
0\x42\
> \x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x48\x41\x53\x48\0\x42\x5=
0\x46\
> \x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x41\x52\x52\x41\x59\0\x42\x50\x4=
6\x5f\
> \x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x50\x52\x4f\x47\x5f\x41\x52\x52\x41\=
x59\0\
> \x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x50\x45\x52\x46\x5f\=
x45\
> \x56\x45\x4e\x54\x5f\x41\x52\x52\x41\x59\0\x42\x50\x46\x5f\x4d\x41\x50\x5=
f\x54\
> \x59\x50\x45\x5f\x50\x45\x52\x43\x50\x55\x5f\x48\x41\x53\x48\0\x42\x50\x4=
6\x5f\
> \x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x50\x45\x52\x43\x50\x55\x5f\x41\x52\=
x52\
> \x41\x59\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x53\x54\x4=
1\x43\
> \x4b\x5f\x54\x52\x41\x43\x45\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x5=
0\x45\
> \x5f\x43\x47\x52\x4f\x55\x50\x5f\x41\x52\x52\x41\x59\0\x42\x50\x46\x5f\x4=
d\x41\
> \x50\x5f\x54\x59\x50\x45\x5f\x4c\x52\x55\x5f\x48\x41\x53\x48\0\x42\x50\x4=
6\x5f\
> \x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x4c\x52\x55\x5f\x50\x45\x52\x43\x50\=
x55\
> \x5f\x48\x41\x53\x48\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5=
f\x4c\
> \x50\x4d\x5f\x54\x52\x49\x45\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x5=
0\x45\
> \x5f\x41\x52\x52\x41\x59\x5f\x4f\x46\x5f\x4d\x41\x50\x53\0\x42\x50\x46\x5=
f\x4d\
> \x41\x50\x5f\x54\x59\x50\x45\x5f\x48\x41\x53\x48\x5f\x4f\x46\x5f\x4d\x41\=
x50\
> \x53\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x44\x45\x56\x4=
d\x41\
> \x50\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x53\x4f\x43\x4=
b\x4d\
> \x41\x50\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x43\x50\x5=
5\x4d\
> \x41\x50\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x58\x53\x4=
b\x4d\
> \x41\x50\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x53\x4f\x4=
3\x4b\
> \x48\x41\x53\x48\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x4=
3\x47\
> \x52\x4f\x55\x50\x5f\x53\x54\x4f\x52\x41\x47\x45\0\x42\x50\x46\x5f\x4d\x4=
1\x50\
> \x5f\x54\x59\x50\x45\x5f\x52\x45\x55\x53\x45\x50\x4f\x52\x54\x5f\x53\x4f\=
x43\
> \x4b\x41\x52\x52\x41\x59\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x4=
5\x5f\
> \x50\x45\x52\x43\x50\x55\x5f\x43\x47\x52\x4f\x55\x50\x5f\x53\x54\x4f\x52\=
x41\
> \x47\x45\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x51\x55\x4=
5\x55\
> \x45\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x53\x54\x41\x4=
3\x4b\
> \0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x53\x4b\x5f\x53\x5=
4\x4f\
> \x52\x41\x47\x45\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x4=
4\x45\
> \x56\x4d\x41\x50\x5f\x48\x41\x53\x48\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x5=
4\x59\
> \x50\x45\x5f\x53\x54\x52\x55\x43\x54\x5f\x4f\x50\x53\0\x42\x50\x46\x5f\x4=
d\x41\
> \x50\x5f\x54\x59\x50\x45\x5f\x52\x49\x4e\x47\x42\x55\x46\0\x42\x50\x46\x5=
f\x4d\
> \x41\x50\x5f\x54\x59\x50\x45\x5f\x49\x4e\x4f\x44\x45\x5f\x53\x54\x4f\x52\=
x41\
> \x47\x45\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x59\x50\x45\x5f\x54\x41\x5=
3\x4b\
> \x5f\x53\x54\x4f\x52\x41\x47\x45\0\x42\x50\x46\x5f\x4d\x41\x50\x5f\x54\x5=
9\x50\
> \x45\x5f\x42\x4c\x4f\x4f\x4d\x5f\x46\x49\x4c\x54\x45\x52\0\x66\x6c\x6f\x7=
7\x5f\
> \x6b\x65\x79\x73\0\x62\x70\x66\x5f\x66\x6c\x6f\x77\x5f\x6b\x65\x79\x73\0\=
x6e\
> \x68\x6f\x66\x66\0\x74\x68\x6f\x66\x66\0\x61\x64\x64\x72\x5f\x70\x72\x6f\=
x74\
> \x6f\0\x69\x73\x5f\x66\x72\x61\x67\0\x69\x73\x5f\x66\x69\x72\x73\x74\x5f\=
x66\
> \x72\x61\x67\0\x69\x73\x5f\x65\x6e\x63\x61\x70\0\x69\x70\x5f\x70\x72\x6f\=
x74\
> \x6f\0\x6e\x5f\x70\x72\x6f\x74\x6f\0\x73\x70\x6f\x72\x74\0\x64\x70\x6f\x7=
2\x74\
> \0\x66\x6c\x61\x67\x73\0\x66\x6c\x6f\x77\x5f\x6c\x61\x62\x65\x6c\0\x69\x7=
0\x76\
> \x34\x5f\x73\x72\x63\0\x69\x70\x76\x34\x5f\x64\x73\x74\0\x69\x70\x76\x36\=
x5f\
> \x73\x72\x63\0\x69\x70\x76\x36\x5f\x64\x73\x74\0\x73\x6b\0\x62\x70\x66\x5=
f\x73\
> \x6f\x63\x6b\0\x62\x6f\x75\x6e\x64\x5f\x64\x65\x76\x5f\x69\x66\0\x66\x61\=
x6d\
> \x69\x6c\x79\0\x74\x79\x70\x65\0\x70\x72\x6f\x74\x6f\x63\x6f\x6c\0\x6d\x6=
1\x72\
> \x6b\0\x70\x72\x69\x6f\x72\x69\x74\x79\0\x73\x72\x63\x5f\x69\x70\x34\0\x7=
3\x72\
> \x63\x5f\x69\x70\x36\0\x73\x72\x63\x5f\x70\x6f\x72\x74\0\x64\x73\x74\x5f\=
x70\
> \x6f\x72\x74\0\x64\x73\x74\x5f\x69\x70\x34\0\x64\x73\x74\x5f\x69\x70\x36\=
0\x73\
> \x74\x61\x74\x65\0\x72\x78\x5f\x71\x75\x65\x75\x65\x5f\x6d\x61\x70\x70\x6=
9\x6e\
> \x67\0\x5f\x5f\x73\x6b\x5f\x62\x75\x66\x66\0\x6c\x65\x6e\0\x70\x6b\x74\x5=
f\x74\
> \x79\x70\x65\0\x71\x75\x65\x75\x65\x5f\x6d\x61\x70\x70\x69\x6e\x67\0\x76\=
x6c\
> \x61\x6e\x5f\x70\x72\x65\x73\x65\x6e\x74\0\x76\x6c\x61\x6e\x5f\x74\x63\x6=
9\0\
> \x76\x6c\x61\x6e\x5f\x70\x72\x6f\x74\x6f\0\x69\x6e\x67\x72\x65\x73\x73\x5=
f\x69\
> \x66\x69\x6e\x64\x65\x78\0\x69\x66\x69\x6e\x64\x65\x78\0\x74\x63\x5f\x69\=
x6e\
> \x64\x65\x78\0\x63\x62\0\x68\x61\x73\x68\0\x74\x63\x5f\x63\x6c\x61\x73\x7=
3\x69\
> \x64\0\x64\x61\x74\x61\0\x64\x61\x74\x61\x5f\x65\x6e\x64\0\x6e\x61\x70\x6=
9\x5f\
> \x69\x64\0\x72\x65\x6d\x6f\x74\x65\x5f\x69\x70\x34\0\x6c\x6f\x63\x61\x6c\=
x5f\
> \x69\x70\x34\0\x72\x65\x6d\x6f\x74\x65\x5f\x69\x70\x36\0\x6c\x6f\x63\x61\=
x6c\
> \x5f\x69\x70\x36\0\x72\x65\x6d\x6f\x74\x65\x5f\x70\x6f\x72\x74\0\x6c\x6f\=
x63\
> \x61\x6c\x5f\x70\x6f\x72\x74\0\x64\x61\x74\x61\x5f\x6d\x65\x74\x61\0\x74\=
x73\
> \x74\x61\x6d\x70\0\x77\x69\x72\x65\x5f\x6c\x65\x6e\0\x67\x73\x6f\x5f\x73\=
x65\
> \x67\x73\0\x67\x73\x6f\x5f\x73\x69\x7a\x65\0\x68\x77\x74\x73\x74\x61\x6d\=
x70\0\
> \x6b\x65\x79\0\x76\x61\x6c\x75\x65\0\x5f\x6c\x69\x63\x65\x6e\x73\x65\0\x6=
9\x73\
> \x5f\x61\x6c\x6c\x6f\x77\x5f\x6c\x69\x73\x74\0\x73\x64\x5f\x72\x65\x73\x7=
4\x72\
> \x69\x63\x74\x69\x66\0\x73\x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x69\x6=
6\x5f\
> \x69\0\x73\x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x69\x66\x5f\x65\0\x72\=
x65\
> \x73\x74\x72\x69\x63\x74\x5f\x6e\x65\x74\x77\x6f\x72\x6b\x5f\x69\x6e\x74\=
x65\
> \x72\x66\x61\x63\x65\x73\x5f\x69\x6d\x70\x6c\0\x2e\x64\x61\x74\x61\0\x6c\=
x69\
> \x63\x65\x6e\x73\x65\0\x2e\x6d\x61\x70\x73\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x03\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\x40\
> \0\0\0\0\0\0\0\xe5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\x09\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x28\x01\0\0\0\0\=
0\0\
> \x50\x01\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\=
0\x11\
> \0\0\0\x01\0\0\0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x78\x02\0\0\0\0\0\0\x0=
1\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x17\0\0\0\x0=
8\0\0\
> \0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x79\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x01\0\0\0\x06\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\x80\x02\0\0\0\0\0\0\xb8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\x08\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x2e\0\0\0\x01\0\0\0\x06\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\x38\x03\0\0\0\0\0\0\xb8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\x41\0\0\0\x01\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xf=
0\x03\
> \0\0\0\0\0\0\x12\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\x49\0\0\0\x01\0\0\0\x03\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\x04\0\0\0\0\=
0\0\
> \x18\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x4f\=
0\0\0\
> \x01\0\0\0\x30\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x20\x04\0\0\0\0\0\0\x31\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\xb3\0\0\0\x09\0\=
0\0\
> \x40\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x58\x04\0\0\0\0\0\0\x20\0\0\0\0\0\0\0\=
x02\0\
> \0\0\x05\0\0\0\x08\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\xc9\0\0\0\x09\0\0\0\x4=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\x78\x04\0\0\0\0\0\0\x20\0\0\0\0\0\0\0\x02\0\0\=
0\x06\
> \0\0\0\x08\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\xe0\0\0\0\x01\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\x98\x04\0\0\0\0\0\0\x16\x0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
x08\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0";
> }
>
> #ifdef __cplusplus
> struct restrict_ifaces_bpf *restrict_ifaces_bpf::open(const struct
> bpf_object_open_opts *opts) { return
> restrict_ifaces_bpf__open_opts(opts); }
> struct restrict_ifaces_bpf *restrict_ifaces_bpf::open_and_load() {
> return restrict_ifaces_bpf__open_and_load(); }
> int restrict_ifaces_bpf::load(struct restrict_ifaces_bpf *skel) {
> return restrict_ifaces_bpf__load(skel); }
> int restrict_ifaces_bpf::attach(struct restrict_ifaces_bpf *skel) {
> return restrict_ifaces_bpf__attach(skel); }
> void restrict_ifaces_bpf::detach(struct restrict_ifaces_bpf *skel) {
> restrict_ifaces_bpf__detach(skel); }
> void restrict_ifaces_bpf::destroy(struct restrict_ifaces_bpf *skel) {
> restrict_ifaces_bpf__destroy(skel); }
> const void *restrict_ifaces_bpf::elf_bytes(size_t *sz) { return
> restrict_ifaces_bpf__elf_bytes(sz); }
> #endif /* __cplusplus */
>
> __attribute__((unused)) static void
> restrict_ifaces_bpf__assert(struct restrict_ifaces_bpf *s
> __attribute__((unused)))
> {
> #ifdef __cplusplus
> #define _Static_assert static_assert
> #endif
>     _Static_assert(sizeof(s->data->is_allow_list) =3D=3D 1, "unexpected
> size of 'is_allow_list'");
> #ifdef __cplusplus
> #undef _Static_assert
> #endif
> }
>
> #endif /* __RESTRICT_IFACES_BPF_SKEL_H__ */
>
> Clang:
> $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> --debug gen skeleton restrict-ifaces.bpf.o
> libbpf: loading object 'restrict_ifaces_bpf' from buffer
> libbpf: elf: section(2) .symtab, size 384, link 1, flags 0, type=3D2
> libbpf: elf: section(3) cgroup_skb/egress, size 152, link 0, flags 6, typ=
e=3D1
> libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
> insn offset 0 (0 bytes), code size 19 insns (152 bytes)
> libbpf: elf: section(4) cgroup_skb/ingress, size 152, link 0, flags 6, ty=
pe=3D1
> libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' at
> insn offset 0 (0 bytes), code size 19 insns (152 bytes)
> libbpf: elf: section(5) .rodata, size 1, link 0, flags 2, type=3D1
> libbpf: elf: section(6) license, size 18, link 0, flags 2, type=3D1
> libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
> libbpf: elf: section(7) .maps, size 24, link 0, flags 3, type=3D1
> libbpf: elf: section(8) .relcgroup_skb/egress, size 32, link 2, flags 40,=
 type=3D9
> libbpf: elf: section(9) .relcgroup_skb/ingress, size 32, link 2, flags
> 40, type=3D9
> libbpf: elf: section(10) .BTF, size 1988, link 0, flags 0, type=3D1
> libbpf: elf: section(11) .BTF.ext, size 376, link 0, flags 0, type=3D1
> libbpf: looking for externs among 16 symbols...
> libbpf: collected 0 externs total
> libbpf: map 'sd_restrictif': at sec_idx 7, offset 0.
> libbpf: map 'sd_restrictif': found type =3D 1.
> libbpf: map 'sd_restrictif': found key [6], sz =3D 4.
> libbpf: map 'sd_restrictif': found value [9], sz =3D 1.
> libbpf: map 'restrict.rodata' (global data): at sec_idx 5, offset 0, flag=
s 480.
> libbpf: map 1 is "restrict.rodata"
> libbpf: sec '.relcgroup_skb/egress': collecting relocation for
> section(3) 'cgroup_skb/egress'
> libbpf: sec '.relcgroup_skb/egress': relo #0: insn #4 against 'sd_restric=
tif'
> libbpf: prog 'sd_restrictif_e': found map 0 (sd_restrictif, sec 7, off
> 0) for insn #4
> libbpf: sec '.relcgroup_skb/egress': relo #1: insn #7 against 'is_allow_l=
ist'
> libbpf: prog 'sd_restrictif_e': found data map 1 (restrict.rodata, sec
> 5, off 0) for insn 7
> libbpf: sec '.relcgroup_skb/ingress': collecting relocation for
> section(4) 'cgroup_skb/ingress'
> libbpf: sec '.relcgroup_skb/ingress': relo #0: insn #4 against 'sd_restri=
ctif'
> libbpf: prog 'sd_restrictif_i': found map 0 (sd_restrictif, sec 7, off
> 0) for insn #4
> libbpf: sec '.relcgroup_skb/ingress': relo #1: insn #7 against 'is_allow_=
list'
> libbpf: prog 'sd_restrictif_i': found data map 1 (restrict.rodata, sec
> 5, off 0) for insn 7
> /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>
> /* THIS FILE IS AUTOGENERATED BY BPFTOOL! */
> #ifndef __RESTRICT_IFACES_BPF_SKEL_H__
> #define __RESTRICT_IFACES_BPF_SKEL_H__
>
> #include <errno.h>
> #include <stdlib.h>
> #include <bpf/libbpf.h>
>
> struct restrict_ifaces_bpf {
>     struct bpf_object_skeleton *skeleton;
>     struct bpf_object *obj;
>     struct {
>         struct bpf_map *sd_restrictif;
>         struct bpf_map *rodata;
>     } maps;
>     struct {
>         struct bpf_program *sd_restrictif_e;
>         struct bpf_program *sd_restrictif_i;
>     } progs;
>     struct {
>         struct bpf_link *sd_restrictif_e;
>         struct bpf_link *sd_restrictif_i;
>     } links;
>     struct restrict_ifaces_bpf__rodata {
>         __u8 is_allow_list;
>     } *rodata;
>
> #ifdef __cplusplus
>     static inline struct restrict_ifaces_bpf *open(const struct
> bpf_object_open_opts *opts =3D nullptr);
>     static inline struct restrict_ifaces_bpf *open_and_load();
>     static inline int load(struct restrict_ifaces_bpf *skel);
>     static inline int attach(struct restrict_ifaces_bpf *skel);
>     static inline void detach(struct restrict_ifaces_bpf *skel);
>     static inline void destroy(struct restrict_ifaces_bpf *skel);
>     static inline const void *elf_bytes(size_t *sz);
> #endif /* __cplusplus */
> };
>
> static void
> restrict_ifaces_bpf__destroy(struct restrict_ifaces_bpf *obj)
> {
>     if (!obj)
>         return;
>     if (obj->skeleton)
>         bpf_object__destroy_skeleton(obj->skeleton);
>     free(obj);
> }
>
> static inline int
> restrict_ifaces_bpf__create_skeleton(struct restrict_ifaces_bpf *obj);
>
> static inline struct restrict_ifaces_bpf *
> restrict_ifaces_bpf__open_opts(const struct bpf_object_open_opts *opts)
> {
>     struct restrict_ifaces_bpf *obj;
>     int err;
>
>     obj =3D (struct restrict_ifaces_bpf *)calloc(1, sizeof(*obj));
>     if (!obj) {
>         errno =3D ENOMEM;
>         return NULL;
>     }
>
>     err =3D restrict_ifaces_bpf__create_skeleton(obj);
>     if (err)
>         goto err_out;
>
>     err =3D bpf_object__open_skeleton(obj->skeleton, opts);
>     if (err)
>         goto err_out;
>
>     return obj;
> err_out:
>     restrict_ifaces_bpf__destroy(obj);
>     errno =3D -err;
>     return NULL;
> }
>
> static inline struct restrict_ifaces_bpf *
> restrict_ifaces_bpf__open(void)
> {
>     return restrict_ifaces_bpf__open_opts(NULL);
> }
>
> static inline int
> restrict_ifaces_bpf__load(struct restrict_ifaces_bpf *obj)
> {
>     return bpf_object__load_skeleton(obj->skeleton);
> }
>
> static inline struct restrict_ifaces_bpf *
> restrict_ifaces_bpf__open_and_load(void)
> {
>     struct restrict_ifaces_bpf *obj;
>     int err;
>
>     obj =3D restrict_ifaces_bpf__open();
>     if (!obj)
>         return NULL;
>     err =3D restrict_ifaces_bpf__load(obj);
>     if (err) {
>         restrict_ifaces_bpf__destroy(obj);
>         errno =3D -err;
>         return NULL;
>     }
>     return obj;
> }
>
> static inline int
> restrict_ifaces_bpf__attach(struct restrict_ifaces_bpf *obj)
> {
>     return bpf_object__attach_skeleton(obj->skeleton);
> }
>
> static inline void
> restrict_ifaces_bpf__detach(struct restrict_ifaces_bpf *obj)
> {
>     return bpf_object__detach_skeleton(obj->skeleton);
> }
>
> static inline const void *restrict_ifaces_bpf__elf_bytes(size_t *sz);
>
> static inline int
> restrict_ifaces_bpf__create_skeleton(struct restrict_ifaces_bpf *obj)
> {
>     struct bpf_object_skeleton *s;
>     int err;
>
>     s =3D (struct bpf_object_skeleton *)calloc(1, sizeof(*s));
>     if (!s)    {
>         err =3D -ENOMEM;
>         goto err;
>     }
>
>     s->sz =3D sizeof(*s);
>     s->name =3D "restrict_ifaces_bpf";
>     s->obj =3D &obj->obj;
>
>     /* maps */
>     s->map_cnt =3D 2;
>     s->map_skel_sz =3D sizeof(*s->maps);
>     s->maps =3D (struct bpf_map_skeleton *)calloc(s->map_cnt, s->map_skel=
_sz);
>     if (!s->maps) {
>         err =3D -ENOMEM;
>         goto err;
>     }
>
>     s->maps[0].name =3D "sd_restrictif";
>     s->maps[0].map =3D &obj->maps.sd_restrictif;
>
>     s->maps[1].name =3D "restrict.rodata";
>     s->maps[1].map =3D &obj->maps.rodata;
>     s->maps[1].mmaped =3D (void **)&obj->rodata;
>
>     /* programs */
>     s->prog_cnt =3D 2;
>     s->prog_skel_sz =3D sizeof(*s->progs);
>     s->progs =3D (struct bpf_prog_skeleton *)calloc(s->prog_cnt, s->prog_=
skel_sz);
>     if (!s->progs) {
>         err =3D -ENOMEM;
>         goto err;
>     }
>
>     s->progs[0].name =3D "sd_restrictif_e";
>     s->progs[0].prog =3D &obj->progs.sd_restrictif_e;
>     s->progs[0].link =3D &obj->links.sd_restrictif_e;
>
>     s->progs[1].name =3D "sd_restrictif_i";
>     s->progs[1].prog =3D &obj->progs.sd_restrictif_i;
>     s->progs[1].link =3D &obj->links.sd_restrictif_i;
>
>     s->data =3D (void *)restrict_ifaces_bpf__elf_bytes(&s->data_sz);
>
>     obj->skeleton =3D s;
>     return 0;
> err:
>     bpf_object__destroy_skeleton(s);
>     return err;
> }
>
> static inline const void *restrict_ifaces_bpf__elf_bytes(size_t *sz)
> {
>     *sz =3D 4272;
>     return (const void *)"\
> \x7f\x45\x4c\x46\x02\x01\x01\0\0\0\0\0\0\0\0\0\x01\0\xf7\0\x01\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\xb0\x0d\0\0\0\0\0\0\0\0\0\0\x40\0\0\0\0\0\x40\0\x0=
c\0\
> \x01\0\0\x2e\x73\x74\x72\x74\x61\x62\0\x2e\x73\x79\x6d\x74\x61\x62\0\x63\=
x67\
> \x72\x6f\x75\x70\x5f\x73\x6b\x62\x2f\x65\x67\x72\x65\x73\x73\0\x63\x67\x7=
2\x6f\
> \x75\x70\x5f\x73\x6b\x62\x2f\x69\x6e\x67\x72\x65\x73\x73\0\x2e\x72\x6f\x6=
4\x61\
> \x74\x61\0\x6c\x69\x63\x65\x6e\x73\x65\0\x2e\x6d\x61\x70\x73\0\x72\x65\x7=
3\x74\
> \x72\x69\x63\x74\x2d\x69\x66\x61\x63\x65\x73\x2e\x62\x70\x66\x2e\x63\0\x4=
c\x42\
> \x42\x30\x5f\x32\0\x4c\x42\x42\x30\x5f\x33\0\x4c\x42\x42\x30\x5f\x34\0\x4=
c\x42\
> \x42\x31\x5f\x32\0\x4c\x42\x42\x31\x5f\x33\0\x4c\x42\x42\x31\x5f\x34\0\x5=
f\x6c\
> \x69\x63\x65\x6e\x73\x65\0\x73\x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x6=
9\x66\
> \x5f\x65\0\x73\x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x69\x66\0\x69\x73\=
x5f\
> \x61\x6c\x6c\x6f\x77\x5f\x6c\x69\x73\x74\0\x73\x64\x5f\x72\x65\x73\x74\x7=
2\x69\
> \x63\x74\x69\x66\x5f\x69\0\x2e\x72\x65\x6c\x63\x67\x72\x6f\x75\x70\x5f\x7=
3\x6b\
> \x62\x2f\x65\x67\x72\x65\x73\x73\0\x2e\x72\x65\x6c\x63\x67\x72\x6f\x75\x7=
0\x5f\
> \x73\x6b\x62\x2f\x69\x6e\x67\x72\x65\x73\x73\0\x2e\x42\x54\x46\0\x2e\x42\=
x54\
> \x46\x2e\x65\x78\x74\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \x4c\0\0\0\x04\0\xf1\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x0=
3\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x62\0\0\0\0\0\x03\0\x70\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\x69\0\0\0\0\0\x03\0\x80\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x70\0\0\0\0\=
0\x03\
> \0\x88\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\x04\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\x77\0\0\0\0\0\x04\0\x70\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x7e\0\0\=
0\0\0\
> \x04\0\x80\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x85\0\0\0\0\0\x04\0\x88\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\x8c\0\0\0\x01\0\x06\0\0\0\0\0\0\0\0\0\x12\0\0\0\0\0\0\0\=
0\0\0\
> \0\x03\0\x06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x95\0\0\0\x12\0\x03\0\0\0\=
0\0\0\
> \0\0\0\x98\0\0\0\0\0\0\0\xa5\0\0\0\x11\0\x07\0\0\0\0\0\0\0\0\0\x18\0\0\0\=
0\0\0\
> \0\xb3\0\0\0\x11\0\x05\0\0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\xc1\0\0\0\x12\=
0\x04\
> \0\0\0\0\0\0\0\0\0\x98\0\0\0\0\0\0\0\x61\x11\x28\0\0\0\0\0\x63\x1a\xfc\xf=
f\0\0\
> \0\0\xbf\xa2\0\0\0\0\0\0\x07\x02\0\0\xfc\xff\xff\xff\x18\x01\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\x85\0\0\0\x01\0\0\0\x18\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x71\x1=
1\0\0\
> \0\0\0\0\x15\x01\x03\0\0\0\0\0\xb7\x01\0\0\x01\0\0\0\x15\0\x03\0\0\0\0\0\=
x05\0\
> \x03\0\0\0\0\0\xb7\x01\0\0\x01\0\0\0\x15\0\x01\0\0\0\0\0\xb7\x01\0\0\0\0\=
0\0\
> \xbf\x10\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x11\x28\0\0\0\0\0\x63\x1a\xfc\=
xff\0\
> \0\0\0\xbf\xa2\0\0\0\0\0\0\x07\x02\0\0\xfc\xff\xff\xff\x18\x01\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\x85\0\0\0\x01\0\0\0\x18\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x71\=
x11\0\
> \0\0\0\0\0\x15\x01\x03\0\0\0\0\0\xb7\x01\0\0\x01\0\0\0\x15\0\x03\0\0\0\0\=
0\x05\
> \0\x03\0\0\0\0\0\xb7\x01\0\0\x01\0\0\0\x15\0\x01\0\0\0\0\0\xb7\x01\0\0\0\=
0\0\0\
> \xbf\x10\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\x4c\x47\x50\x4c\x2d\x32\x2e\x31\=
x2d\
> \x6f\x72\x2d\x6c\x61\x74\x65\x72\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\x20\0\0\0\0\0\0\0\x01\0\0\0\x0d\0\0\0\x38\0\0\0\0\0\0\0\x0=
1\0\0\
> \0\x0e\0\0\0\x20\0\0\0\0\0\0\0\x01\0\0\0\x0d\0\0\0\x38\0\0\0\0\0\0\0\x01\=
0\0\0\
> \x0e\0\0\0\x9f\xeb\x01\0\x18\0\0\0\0\0\0\0\x10\x04\0\0\x10\x04\0\0\x9c\x0=
3\0\0\
> \0\0\0\0\0\0\0\x02\x03\0\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\=
0\0\0\
> \0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\x01\0\0\0\x05\0\0\0\0\0\0\x01\x04\=
0\0\0\
> \x20\0\0\0\0\0\0\0\0\0\0\x02\x06\0\0\0\x19\0\0\0\0\0\0\x08\x07\0\0\0\x1f\=
0\0\0\
> \0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\x02\x09\0\0\0\x2c\0\0\0\0\0\=
0\x08\
> \x0a\0\0\0\x31\0\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\0\0\0\0\0\x03\0\0\x04\x1=
8\0\0\
> \0\x3f\0\0\0\x01\0\0\0\0\0\0\0\x44\0\0\0\x05\0\0\0\x40\0\0\0\x48\0\0\0\x0=
8\0\0\
> \0\x80\0\0\0\x4e\0\0\0\0\0\0\x0e\x0b\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x02\x0=
e\0\0\
> \0\0\0\0\0\0\0\0\x0a\x0f\0\0\0\x5c\0\0\0\x21\0\0\x04\xc0\0\0\0\x66\0\0\0\=
x06\0\
> \0\0\0\0\0\0\x6a\0\0\0\x06\0\0\0\x20\0\0\0\x73\0\0\0\x06\0\0\0\x40\0\0\0\=
x78\0\
> \0\0\x06\0\0\0\x60\0\0\0\x86\0\0\0\x06\0\0\0\x80\0\0\0\x8f\0\0\0\x06\0\0\=
0\xa0\
> \0\0\0\x9c\0\0\0\x06\0\0\0\xc0\0\0\0\xa5\0\0\0\x06\0\0\0\xe0\0\0\0\xb0\0\=
0\0\
> \x06\0\0\0\0\x01\0\0\xb9\0\0\0\x06\0\0\0\x20\x01\0\0\xc9\0\0\0\x06\0\0\0\=
x40\
> \x01\0\0\xd1\0\0\0\x06\0\0\0\x60\x01\0\0\xda\0\0\0\x10\0\0\0\x80\x01\0\0\=
xdd\0\
> \0\0\x06\0\0\0\x20\x02\0\0\xe2\0\0\0\x06\0\0\0\x40\x02\0\0\xed\0\0\0\x06\=
0\0\0\
> \x60\x02\0\0\xf2\0\0\0\x06\0\0\0\x80\x02\0\0\xfb\0\0\0\x06\0\0\0\xa0\x02\=
0\0\
> \x03\x01\0\0\x06\0\0\0\xc0\x02\0\0\x0a\x01\0\0\x06\0\0\0\xe0\x02\0\0\x15\=
x01\0\
> \0\x06\0\0\0\0\x03\0\0\x1f\x01\0\0\x11\0\0\0\x20\x03\0\0\x2a\x01\0\0\x11\=
0\0\0\
> \xa0\x03\0\0\x34\x01\0\0\x06\0\0\0\x20\x04\0\0\x40\x01\0\0\x06\0\0\0\x40\=
x04\0\
> \0\x4b\x01\0\0\x06\0\0\0\x60\x04\0\0\0\0\0\0\x12\0\0\0\x80\x04\0\0\x55\x0=
1\0\0\
> \x14\0\0\0\xc0\x04\0\0\x5c\x01\0\0\x06\0\0\0\0\x05\0\0\x65\x01\0\0\x06\0\=
0\0\
> \x20\x05\0\0\0\0\0\0\x16\0\0\0\x40\x05\0\0\x6e\x01\0\0\x06\0\0\0\x80\x05\=
0\0\
> \x77\x01\0\0\x14\0\0\0\xc0\x05\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x06\0\0\0\x0=
4\0\0\
> \0\x05\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x06\0\0\0\x04\0\0\0\x04\0\0\0\0\0\=
0\0\
> \x01\0\0\x05\x08\0\0\0\x80\x01\0\0\x13\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\x2=
2\0\0\
> \0\x8a\x01\0\0\0\0\0\x08\x15\0\0\0\x90\x01\0\0\0\0\0\x01\x08\0\0\0\x40\0\=
0\0\0\
> \0\0\0\x01\0\0\x05\x08\0\0\0\xa3\x01\0\0\x17\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
x02\
> \x23\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\xa3\x01\0\0\x0d\0\0\0\xa6\x01\0\=
0\x01\
> \0\0\x0c\x18\0\0\0\xb6\x01\0\0\x01\0\0\x0c\x18\0\0\0\0\0\0\0\0\0\0\x0a\x1=
c\0\0\
> \0\0\0\0\0\0\0\0\x09\x09\0\0\0\xc6\x01\0\0\0\0\0\x0e\x1b\0\0\0\x01\0\0\0\=
0\0\0\
> \0\0\0\0\x0a\x1f\0\0\0\xd4\x01\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\x01\0\0\0\=
0\0\0\
> \0\x03\0\0\0\0\x1e\0\0\0\x04\0\0\0\x12\0\0\0\xd9\x01\0\0\0\0\0\x0e\x20\0\=
0\0\0\
> \0\0\0\xe2\x01\0\0\0\0\0\x07\0\0\0\0\xf0\x01\0\0\0\0\0\x07\0\0\0\0\x61\x0=
3\0\0\
> \x01\0\0\x0f\x01\0\0\0\x1d\0\0\0\0\0\0\0\x01\0\0\0\x69\x03\0\0\x01\0\0\x0=
f\x12\
> \0\0\0\x21\0\0\0\0\0\0\0\x12\0\0\0\x71\x03\0\0\x01\0\0\x0f\x18\0\0\0\x0c\=
0\0\0\
> \0\0\0\0\x18\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\x53\x4=
9\x5a\
> \x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x5f\x5f\x75\x33\x32\0\x75\x6e\x73\x69\=
x67\
> \x6e\x65\x64\x20\x69\x6e\x74\0\x5f\x5f\x75\x38\0\x75\x6e\x73\x69\x67\x6e\=
x65\
> \x64\x20\x63\x68\x61\x72\0\x74\x79\x70\x65\0\x6b\x65\x79\0\x76\x61\x6c\x7=
5\x65\
> \0\x73\x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x69\x66\0\x5f\x5f\x73\x6b\=
x5f\
> \x62\x75\x66\x66\0\x6c\x65\x6e\0\x70\x6b\x74\x5f\x74\x79\x70\x65\0\x6d\x6=
1\x72\
> \x6b\0\x71\x75\x65\x75\x65\x5f\x6d\x61\x70\x70\x69\x6e\x67\0\x70\x72\x6f\=
x74\
> \x6f\x63\x6f\x6c\0\x76\x6c\x61\x6e\x5f\x70\x72\x65\x73\x65\x6e\x74\0\x76\=
x6c\
> \x61\x6e\x5f\x74\x63\x69\0\x76\x6c\x61\x6e\x5f\x70\x72\x6f\x74\x6f\0\x70\=
x72\
> \x69\x6f\x72\x69\x74\x79\0\x69\x6e\x67\x72\x65\x73\x73\x5f\x69\x66\x69\x6=
e\x64\
> \x65\x78\0\x69\x66\x69\x6e\x64\x65\x78\0\x74\x63\x5f\x69\x6e\x64\x65\x78\=
0\x63\
> \x62\0\x68\x61\x73\x68\0\x74\x63\x5f\x63\x6c\x61\x73\x73\x69\x64\0\x64\x6=
1\x74\
> \x61\0\x64\x61\x74\x61\x5f\x65\x6e\x64\0\x6e\x61\x70\x69\x5f\x69\x64\0\x6=
6\x61\
> \x6d\x69\x6c\x79\0\x72\x65\x6d\x6f\x74\x65\x5f\x69\x70\x34\0\x6c\x6f\x63\=
x61\
> \x6c\x5f\x69\x70\x34\0\x72\x65\x6d\x6f\x74\x65\x5f\x69\x70\x36\0\x6c\x6f\=
x63\
> \x61\x6c\x5f\x69\x70\x36\0\x72\x65\x6d\x6f\x74\x65\x5f\x70\x6f\x72\x74\0\=
x6c\
> \x6f\x63\x61\x6c\x5f\x70\x6f\x72\x74\0\x64\x61\x74\x61\x5f\x6d\x65\x74\x6=
1\0\
> \x74\x73\x74\x61\x6d\x70\0\x77\x69\x72\x65\x5f\x6c\x65\x6e\0\x67\x73\x6f\=
x5f\
> \x73\x65\x67\x73\0\x67\x73\x6f\x5f\x73\x69\x7a\x65\0\x68\x77\x74\x73\x74\=
x61\
> \x6d\x70\0\x66\x6c\x6f\x77\x5f\x6b\x65\x79\x73\0\x5f\x5f\x75\x36\x34\0\x7=
5\x6e\
> \x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\x6e\x67\0\x73\x6=
b\0\
> \x73\x64\x5f\x72\x65\x73\x74\x72\x69\x63\x74\x69\x66\x5f\x65\0\x73\x64\x5=
f\x72\
> \x65\x73\x74\x72\x69\x63\x74\x69\x66\x5f\x69\0\x69\x73\x5f\x61\x6c\x6c\x6=
f\x77\
> \x5f\x6c\x69\x73\x74\0\x63\x68\x61\x72\0\x5f\x6c\x69\x63\x65\x6e\x73\x65\=
0\x62\
> \x70\x66\x5f\x66\x6c\x6f\x77\x5f\x6b\x65\x79\x73\0\x62\x70\x66\x5f\x73\x6=
f\x63\
> \x6b\0\x2f\x68\x6f\x6d\x65\x2f\x62\x75\x69\x6c\x64\x72\x6f\x6f\x74\x2f\x6=
2\x75\
> \x69\x6c\x64\x72\x6f\x6f\x74\x2f\x6f\x75\x74\x70\x75\x74\x2f\x62\x75\x69\=
x6c\
> \x64\x2f\x73\x79\x73\x74\x65\x6d\x64\x2d\x63\x75\x73\x74\x6f\x6d\x2f\x73\=
x72\
> \x63\x2f\x63\x6f\x72\x65\x2f\x62\x70\x66\x2f\x72\x65\x73\x74\x72\x69\x63\=
x74\
> \x5f\x69\x66\x61\x63\x65\x73\x2f\x72\x65\x73\x74\x72\x69\x63\x74\x2d\x69\=
x66\
> \x61\x63\x65\x73\x2e\x62\x70\x66\x2e\x63\0\x20\x20\x20\x20\x20\x20\x20\x2=
0\x69\
> \x66\x69\x6e\x64\x65\x78\x20\x3d\x20\x73\x6b\x2d\x3e\x69\x66\x69\x6e\x64\=
x65\
> \x78\x3b\0\x20\x20\x20\x20\x20\x20\x20\x20\x6c\x6f\x6f\x6b\x75\x70\x5f\x7=
2\x65\
> \x73\x75\x6c\x74\x20\x3d\x20\x62\x70\x66\x5f\x6d\x61\x70\x5f\x6c\x6f\x6f\=
x6b\
> \x75\x70\x5f\x65\x6c\x65\x6d\x28\x26\x73\x64\x5f\x72\x65\x73\x74\x72\x69\=
x63\
> \x74\x69\x66\x2c\x20\x26\x69\x66\x69\x6e\x64\x65\x78\x29\x3b\0\x20\x20\x2=
0\x20\
> \x20\x20\x20\x20\x69\x66\x20\x28\x69\x73\x5f\x61\x6c\x6c\x6f\x77\x5f\x6c\=
x69\
> \x73\x74\x29\x20\x7b\0\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x2=
0\x20\
> \x20\x20\x69\x66\x20\x28\x6c\x6f\x6f\x6b\x75\x70\x5f\x72\x65\x73\x75\x6c\=
x74\
> \x29\0\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x6=
9\x66\
> \x20\x28\x21\x6c\x6f\x6f\x6b\x75\x70\x5f\x72\x65\x73\x75\x6c\x74\x29\0\x2=
0\x20\
> \x20\x20\x20\x20\x20\x20\x72\x65\x74\x75\x72\x6e\x20\x72\x65\x73\x74\x72\=
x69\
> \x63\x74\x5f\x6e\x65\x74\x77\x6f\x72\x6b\x5f\x69\x6e\x74\x65\x72\x66\x61\=
x63\
> \x65\x73\x5f\x69\x6d\x70\x6c\x28\x73\x6b\x29\x3b\0\x2e\x72\x6f\x64\x61\x7=
4\x61\
> \0\x6c\x69\x63\x65\x6e\x73\x65\0\x2e\x6d\x61\x70\x73\0\x63\x67\x72\x6f\x7=
5\x70\
> \x5f\x73\x6b\x62\x2f\x65\x67\x72\x65\x73\x73\0\x63\x67\x72\x6f\x75\x70\x5=
f\x73\
> \x6b\x62\x2f\x69\x6e\x67\x72\x65\x73\x73\0\0\0\0\0\x9f\xeb\x01\0\x20\0\0\=
0\0\0\
> \0\0\x24\0\0\0\x24\0\0\0\x34\x01\0\0\x58\x01\0\0\0\0\0\0\x08\0\0\0\x77\x0=
3\0\0\
> \x01\0\0\0\0\0\0\0\x19\0\0\0\x89\x03\0\0\x01\0\0\0\0\0\0\0\x1a\0\0\0\x10\=
0\0\0\
> \x77\x03\0\0\x09\0\0\0\0\0\0\0\xf9\x01\0\0\x62\x02\0\0\x17\x6c\0\0\x08\0\=
0\0\
> \xf9\x01\0\0\x62\x02\0\0\x11\x6c\0\0\x18\0\0\0\xf9\x01\0\0\0\0\0\0\0\0\0\=
0\x20\
> \0\0\0\xf9\x01\0\0\x81\x02\0\0\x19\x70\0\0\x38\0\0\0\xf9\x01\0\0\xc8\x02\=
0\0\
> \x0d\x74\0\0\x50\0\0\0\xf9\x01\0\0\xc8\x02\0\0\x0d\x74\0\0\x60\0\0\0\xf9\=
x01\0\
> \0\xe5\x02\0\0\x15\x7c\0\0\x78\0\0\0\xf9\x01\0\0\x08\x03\0\0\x15\x8c\0\0\=
x88\0\
> \0\0\xf9\x01\0\0\x2c\x03\0\0\x09\xb0\0\0\x89\x03\0\0\x09\0\0\0\0\0\0\0\xf=
9\x01\
> \0\0\x62\x02\0\0\x17\x6c\0\0\x08\0\0\0\xf9\x01\0\0\x62\x02\0\0\x11\x6c\0\=
0\x18\
> \0\0\0\xf9\x01\0\0\0\0\0\0\0\0\0\0\x20\0\0\0\xf9\x01\0\0\x81\x02\0\0\x19\=
x70\0\
> \0\x38\0\0\0\xf9\x01\0\0\xc8\x02\0\0\x0d\x74\0\0\x50\0\0\0\xf9\x01\0\0\xc=
8\x02\
> \0\0\x0d\x74\0\0\x60\0\0\0\xf9\x01\0\0\xe5\x02\0\0\x15\x7c\0\0\x78\0\0\0\=
xf9\
> \x01\0\0\x08\x03\0\0\x15\x8c\0\0\x88\0\0\0\xf9\x01\0\0\x2c\x03\0\0\x09\xc=
4\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x03\0\0\0\x2=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\x40\0\0\0\0\0\0\0\x0c\x01\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x09\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\x50\x01\0\0\0\0\0\0\x80\x01\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\x08\=
0\0\0\
> \0\0\0\0\x18\0\0\0\0\0\0\0\x11\0\0\0\x01\0\0\0\x06\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\xd0\x02\0\0\0\0\0\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\x23\0\0\0\x01\0\0\0\x06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x0=
3\0\0\
> \0\0\0\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\
> \x36\0\0\0\x01\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\0\0\0\=
x01\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x3e\0\0\0\=
x01\0\
> \0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x01\x04\0\0\0\0\0\0\x12\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x46\0\0\0\x01\0\0\0\x03\=
0\0\0\
> \0\0\0\0\0\0\0\0\0\0\0\0\x18\x04\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \x08\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd1\0\0\0\x09\0\0\0\x40\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\0\0\0\x30\x04\0\0\0\0\0\0\x20\0\0\0\0\0\0\0\x02\0\0\0\x03\0\0\0\x08\=
0\0\0\
> \0\0\0\0\x10\0\0\0\0\0\0\0\xe7\0\0\0\x09\0\0\0\x40\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\x50\x04\0\0\0\0\0\0\x20\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x08\0\0\0\0\=
0\0\0\
> \x10\0\0\0\0\0\0\0\xfe\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x7=
0\x04\
> \0\0\0\0\0\0\xc4\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\=
0\0\0\
> \0\0\x03\x01\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x38\x0c\0\0\0\=
0\0\0\
> \x78\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
> }
>
> #ifdef __cplusplus
> struct restrict_ifaces_bpf *restrict_ifaces_bpf::open(const struct
> bpf_object_open_opts *opts) { return
> restrict_ifaces_bpf__open_opts(opts); }
> struct restrict_ifaces_bpf *restrict_ifaces_bpf::open_and_load() {
> return restrict_ifaces_bpf__open_and_load(); }
> int restrict_ifaces_bpf::load(struct restrict_ifaces_bpf *skel) {
> return restrict_ifaces_bpf__load(skel); }
> int restrict_ifaces_bpf::attach(struct restrict_ifaces_bpf *skel) {
> return restrict_ifaces_bpf__attach(skel); }
> void restrict_ifaces_bpf::detach(struct restrict_ifaces_bpf *skel) {
> restrict_ifaces_bpf__detach(skel); }
> void restrict_ifaces_bpf::destroy(struct restrict_ifaces_bpf *skel) {
> restrict_ifaces_bpf__destroy(skel); }
> const void *restrict_ifaces_bpf::elf_bytes(size_t *sz) { return
> restrict_ifaces_bpf__elf_bytes(sz); }
> #endif /* __cplusplus */
>
> __attribute__((unused)) static void
> restrict_ifaces_bpf__assert(struct restrict_ifaces_bpf *s
> __attribute__((unused)))
> {
> #ifdef __cplusplus
> #define _Static_assert static_assert
> #endif
>     _Static_assert(sizeof(s->rodata->is_allow_list) =3D=3D 1, "unexpected
> size of 'is_allow_list'");
> #ifdef __cplusplus
> #undef _Static_assert
> #endif
> }
>
> #endif /* __RESTRICT_IFACES_BPF_SKEL_H__ */
>
>>
>>
>> > Starting program:
>> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > --debug gen skeleton
>> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restric=
t-ifaces.bpf.o
>> > [Thread debugging using libthread_db enabled]
>> > Using host libthread_db library "/usr/lib/libthread_db.so.1".
>> > libbpf: loading object 'restrict_ifaces_bpf' from buffer
>> > libbpf: elf: section(2) .symtab, size 336, link 1, flags 0, type=3D2
>> > libbpf: elf: section(3) .data, size 1, link 0, flags 3, type=3D1
>> > libbpf: elf: section(4) .bss, size 0, link 0, flags 3, type=3D8
>> > libbpf: elf: section(5) cgroup_skb/egress, size 184, link 0, flags 6, =
type=3D1
>> > libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
>> > insn offset 0 (0 bytes), code size 23 insns (184 bytes)
>> > libbpf: elf: section(6) cgroup_skb/ingress, size 184, link 0, flags 6,=
 type=3D1
>> > libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' at
>> > insn offset 0 (0 bytes), code size 23 insns (184 bytes)
>> > libbpf: elf: section(7) license, size 18, link 0, flags 2, type=3D1
>> > libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
>> > libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=3D1
>> > libbpf: elf: section(9) .comment, size 49, link 0, flags 30, type=3D1
>> > libbpf: elf: skipping unrecognized data section(9) .comment
>> > libbpf: elf: section(10) .relcgroup_skb/egress, size 32, link 2, flags
>> > 40, type=3D9
>> > libbpf: elf: section(11) .relcgroup_skb/ingress, size 32, link 2,
>> > flags 40, type=3D9
>> > libbpf: elf: section(12) .BTF, size 3606, link 0, flags 0, type=3D1
>> > libbpf: looking for externs among 14 symbols...
>> > libbpf: collected 0 externs total
>> > libbpf: map 'sd_restrictif': at sec_idx 8, offset 0.
>> > libbpf: map 'sd_restrictif': found type =3D 1.
>> > libbpf: map 'sd_restrictif': found key [12], sz =3D 4.
>> > libbpf: map 'sd_restrictif': found value [3], sz =3D 1.
>> >
>> > Program received signal SIGSEGV, Segmentation fault.
>> > 0x0000aaaaaab4fd2c in bpf_object.init_maps ()
>> > (gdb) bt
>> > #0  0x0000aaaaaab4fd2c in bpf_object.init_maps ()
>> > #1  0x0000aaaaaab52178 in bpf_object_open.part ()
>> > #2  0x0000aaaaaab544e8 in bpf_object.open_mem ()
>> > #3  0x0000aaaaaab2a58c in do_skeleton ()
>> > #4  0x0000aaaaaab1e204 in main ()
>> >
>> >>
>> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> >> index e89cc9c885b3..e3a6808f0bb6 100644
>> >> --- a/tools/lib/bpf/libbpf.c
>> >> +++ b/tools/lib/bpf/libbpf.c
>> >> @@ -1591,6 +1591,10 @@ static int bpf_object__init_global_data_maps(s=
truct bpf_object *obj)
>> >>         for (sec_idx =3D 1; sec_idx < obj->efile.sec_cnt; sec_idx++) =
{
>> >>                 sec_desc =3D &obj->efile.secs[sec_idx];
>> >>
>> >> +                /* Skip empty sections.  */
>> >> +                if (sec_desc->data->d_size =3D=3D 0)
>> >> +                  continue;
>> >> +
>> >>                 switch (sec_desc->sec_type) {
>> >>                 case SEC_DATA:
>> >>                         sec_name =3D elf_sec_name(obj, elf_sec_by_idx=
(obj, sec_idx));
>> >>
>> >> > GCC:
>> >> > $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bp=
ftool
>> >> > --debug gen skeleton
>> >> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/rest=
rict-ifaces.bpf.o
>> >> > libbpf: loading object 'restrict_ifaces_bpf' from buffer
>> >> > libbpf: elf: section(2) .symtab, size 336, link 1, flags 0, type=3D=
2
>> >> > libbpf: elf: section(3) .data, size 1, link 0, flags 3, type=3D1
>> >> > libbpf: elf: section(4) .bss, size 0, link 0, flags 3, type=3D8
>> >> > libbpf: elf: section(5) cgroup_skb/egress, size 184, link 0, flags =
6, type=3D1
>> >> > libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
>> >> > insn offset 0 (0 bytes), code size 23 insns (184 bytes)
>> >> > libbpf: elf: section(6) cgroup_skb/ingress, size 184, link 0, flags=
 6, type=3D1
>> >> > libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' a=
t
>> >> > insn offset 0 (0 bytes), code size 23 insns (184 bytes)
>> >> > libbpf: elf: section(7) license, size 18, link 0, flags 2, type=3D1
>> >> > libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
>> >> > libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=3D1
>> >> > libbpf: elf: section(9) .comment, size 49, link 0, flags 30, type=
=3D1
>> >> > libbpf: elf: skipping unrecognized data section(9) .comment
>> >> > libbpf: elf: section(10) .relcgroup_skb/egress, size 32, link 2, fl=
ags
>> >> > 40, type=3D9
>> >> > libbpf: elf: section(11) .relcgroup_skb/ingress, size 32, link 2,
>> >> > flags 40, type=3D9
>> >> > libbpf: elf: section(12) .BTF, size 3606, link 0, flags 0, type=3D1
>> >> > libbpf: looking for externs among 14 symbols...
>> >> > libbpf: collected 0 externs total
>> >> > libbpf: map 'sd_restrictif': at sec_idx 8, offset 0.
>> >> > libbpf: map 'sd_restrictif': found type =3D 1.
>> >> > libbpf: map 'sd_restrictif': found key [12], sz =3D 4.
>> >> > libbpf: map 'sd_restrictif': found value [3], sz =3D 1.
>> >> > libbpf: map 'restrict.data' (global data): at sec_idx 3, offset 0, =
flags 400.
>> >> > libbpf: map 1 is "restrict.data"
>> >> > libbpf: map 'restrict.bss' (global data): at sec_idx 4, offset 0, f=
lags 400.
>> >> > libbpf: failed to alloc map 'restrict.bss' content buffer: -22
>> >> > Error: failed to open BPF object file: Invalid argument
>> >> >
>> >> > LLVM:
>> >> > $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bp=
ftool
>> >> > --debug gen skeleton restrict-ifaces.bpf.o
>> >> > libbpf: loading object 'restrict_ifaces_bpf' from buffer
>> >> > libbpf: elf: section(2) .symtab, size 384, link 1, flags 0, type=3D=
2
>> >> > libbpf: elf: section(3) cgroup_skb/egress, size 152, link 0, flags =
6, type=3D1
>> >> > libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
>> >> > insn offset 0 (0 bytes), code size 19 insns (152 bytes)
>> >> > libbpf: elf: section(4) cgroup_skb/ingress, size 152, link 0, flags=
 6, type=3D1
>> >> > libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' a=
t
>> >> > insn offset 0 (0 bytes), code size 19 insns (152 bytes)
>> >> > libbpf: elf: section(5) .rodata, size 1, link 0, flags 2, type=3D1
>> >> > libbpf: elf: section(6) license, size 18, link 0, flags 2, type=3D1
>> >> > libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
>> >> > libbpf: elf: section(7) .maps, size 24, link 0, flags 3, type=3D1
>> >> > libbpf: elf: section(8) .relcgroup_skb/egress, size 32, link 2, fla=
gs 40, type=3D9
>> >> > libbpf: elf: section(9) .relcgroup_skb/ingress, size 32, link 2, fl=
ags
>> >> > 40, type=3D9
>> >> > libbpf: elf: section(10) .BTF, size 1988, link 0, flags 0, type=3D1
>> >> > libbpf: elf: section(11) .BTF.ext, size 376, link 0, flags 0, type=
=3D1
>> >> > libbpf: looking for externs among 16 symbols...
>> >> > libbpf: collected 0 externs total
>> >> > libbpf: map 'sd_restrictif': at sec_idx 7, offset 0.
>> >> > libbpf: map 'sd_restrictif': found type =3D 1.
>> >> > libbpf: map 'sd_restrictif': found key [6], sz =3D 4.
>> >> > libbpf: map 'sd_restrictif': found value [9], sz =3D 1.
>> >> > libbpf: map 'restrict.rodata' (global data): at sec_idx 5, offset 0=
, flags 480.
>> >> > libbpf: map 1 is "restrict.rodata"
>> >> > libbpf: sec '.relcgroup_skb/egress': collecting relocation for
>> >> > section(3) 'cgroup_skb/egress'
>> >> > libbpf: sec '.relcgroup_skb/egress': relo #0: insn #4 against 'sd_r=
estrictif'
>> >> > libbpf: prog 'sd_restrictif_e': found map 0 (sd_restrictif, sec 7, =
off
>> >> > 0) for insn #4
>> >> > libbpf: sec '.relcgroup_skb/egress': relo #1: insn #7 against 'is_a=
llow_list'
>> >> > libbpf: prog 'sd_restrictif_e': found data map 1 (restrict.rodata, =
sec
>> >> > 5, off 0) for insn 7
>> >> > libbpf: sec '.relcgroup_skb/ingress': collecting relocation for
>> >> > section(4) 'cgroup_skb/ingress'
>> >> > libbpf: sec '.relcgroup_skb/ingress': relo #0: insn #4 against 'sd_=
restrictif'
>> >> > libbpf: prog 'sd_restrictif_i': found map 0 (sd_restrictif, sec 7, =
off
>> >> > 0) for insn #4
>> >> > libbpf: sec '.relcgroup_skb/ingress': relo #1: insn #7 against 'is_=
allow_list'
>> >> > libbpf: prog 'sd_restrictif_i': found data map 1 (restrict.rodata, =
sec
>> >> > 5, off 0) for insn 7
>> >> >
>> >> >> >
>> >> >> > >>
>> >> >> > >> Looking at libbpf.c, it seems to me that this may be due of t=
rying to
>> >> >> > >> mmap 0 bytes in `bpf_object__init_internal_map':
>> >> >> > >>
>> >> >> > >>         map->mmaped =3D mmap(NULL, bpf_map_mmap_sz(map), PROT=
_READ | PROT_WRITE,
>> >> >> > >>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0)=
;
>> >> >> > >>         if (map->mmaped =3D=3D MAP_FAILED) {
>> >> >> > >>                 err =3D -errno;
>> >> >> > >>                 map->mmaped =3D NULL;
>> >> >> > >>                 pr_warn("failed to alloc map '%s' content buf=
fer: %d\n",
>> >> >> > >>                         map->name, err);
>> >> >> > >>                 zfree(&map->real_name);
>> >> >> > >>                 zfree(&map->name);
>> >> >> > >>                 return err;
>> >> >> > >>         }
>> >> >> > >>
>> >> >> > >> I see no check for zero sized sections in
>> >> >> > >> bpf_object__init_global_data_maps.
>> >> >> > >>
>> >> >> > >> Is maybe GCC failing to allocate stuff in BSS that is suppose=
d to be
>> >> >> > >> there?
>> >> >> > >>
>> >> >> > >> > Stripped file passed to gen skeleton:
>> >> >> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/s=
bin/bpftool
>> >> >> > >> > btf dump file
>> >> >> > >> > output/build/systemd-custom/build/src/core/bpf/restrict_ifa=
ces/restrict-ifaces.bpf.o
>> >> >> > >> > format raw
>> >> >> > >> > [1] INT 'signed char' size=3D1 bits_offset=3D0 nr_bits=3D8 =
encoding=3DUNKN
>> >> >> > >> > [2] INT 'unsigned char' size=3D1 bits_offset=3D0 nr_bits=3D=
8 encoding=3DCHAR
>> >> >> > >> > [3] TYPEDEF '__u8' type_id=3D2
>> >> >> > >> > [4] CONST '(anon)' type_id=3D3
>> >> >> > >> > [5] VOLATILE '(anon)' type_id=3D4
>> >> >> > >> > [6] INT 'short int' size=3D2 bits_offset=3D0 nr_bits=3D16 e=
ncoding=3DSIGNED
>> >> >> > >> > [7] INT 'short unsigned int' size=3D2 bits_offset=3D0 nr_bi=
ts=3D16 encoding=3D(none)
>> >> >> > >> > [8] TYPEDEF '__u16' type_id=3D7
>> >> >> > >> > [9] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encodin=
g=3DSIGNED
>> >> >> > >> > [10] TYPEDEF '__s32' type_id=3D9
>> >> >> > >> > [11] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D=
32 encoding=3D(none)
>> >> >> > >> > [12] TYPEDEF '__u32' type_id=3D11
>> >> >> > >> > [13] INT 'long long int' size=3D8 bits_offset=3D0 nr_bits=
=3D64 encoding=3DSIGNED
>> >> >> > >> > [14] INT 'long long unsigned int' size=3D8 bits_offset=3D0 =
nr_bits=3D64
>> >> >> > >> > encoding=3D(none)
>> >> >> > >> > [15] TYPEDEF '__u64' type_id=3D14
>> >> >> > >> > [16] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bi=
ts=3D64 encoding=3D(none)
>> >> >> > >> > [17] INT 'long int' size=3D8 bits_offset=3D0 nr_bits=3D64 e=
ncoding=3DSIGNED
>> >> >> > >> > [18] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encodi=
ng=3DUNKN
>> >> >> > >> > [19] CONST '(anon)' type_id=3D18
>> >> >> > >> > [20] TYPEDEF '__be16' type_id=3D8
>> >> >> > >> > [21] TYPEDEF '__be32' type_id=3D12
>> >> >> > >> > [22] ENUM 'bpf_map_type' encoding=3DUNSIGNED size=3D4 vlen=
=3D31
>> >> >> > >> >     'BPF_MAP_TYPE_UNSPEC' val=3D0
>> >> >> > >> >     'BPF_MAP_TYPE_HASH' val=3D1
>> >> >> > >> >     'BPF_MAP_TYPE_ARRAY' val=3D2
>> >> >> > >> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3D3
>> >> >> > >> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=3D4
>> >> >> > >> >     'BPF_MAP_TYPE_PERCPU_HASH' val=3D5
>> >> >> > >> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=3D6
>> >> >> > >> >     'BPF_MAP_TYPE_STACK_TRACE' val=3D7
>> >> >> > >> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=3D8
>> >> >> > >> >     'BPF_MAP_TYPE_LRU_HASH' val=3D9
>> >> >> > >> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=3D10
>> >> >> > >> >     'BPF_MAP_TYPE_LPM_TRIE' val=3D11
>> >> >> > >> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=3D12
>> >> >> > >> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=3D13
>> >> >> > >> >     'BPF_MAP_TYPE_DEVMAP' val=3D14
>> >> >> > >> >     'BPF_MAP_TYPE_SOCKMAP' val=3D15
>> >> >> > >> >     'BPF_MAP_TYPE_CPUMAP' val=3D16
>> >> >> > >> >     'BPF_MAP_TYPE_XSKMAP' val=3D17
>> >> >> > >> >     'BPF_MAP_TYPE_SOCKHASH' val=3D18
>> >> >> > >> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=3D19
>> >> >> > >> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=3D20
>> >> >> > >> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=3D21
>> >> >> > >> >     'BPF_MAP_TYPE_QUEUE' val=3D22
>> >> >> > >> >     'BPF_MAP_TYPE_STACK' val=3D23
>> >> >> > >> >     'BPF_MAP_TYPE_SK_STORAGE' val=3D24
>> >> >> > >> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=3D25
>> >> >> > >> >     'BPF_MAP_TYPE_STRUCT_OPS' val=3D26
>> >> >> > >> >     'BPF_MAP_TYPE_RINGBUF' val=3D27
>> >> >> > >> >     'BPF_MAP_TYPE_INODE_STORAGE' val=3D28
>> >> >> > >> >     'BPF_MAP_TYPE_TASK_STORAGE' val=3D29
>> >> >> > >> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=3D30
>> >> >> > >> > [23] UNION '(anon)' size=3D8 vlen=3D1
>> >> >> > >> >     'flow_keys' type_id=3D29 bits_offset=3D0
>> >> >> > >> > [24] STRUCT 'bpf_flow_keys' size=3D56 vlen=3D13
>> >> >> > >> >     'nhoff' type_id=3D8 bits_offset=3D0
>> >> >> > >> >     'thoff' type_id=3D8 bits_offset=3D16
>> >> >> > >> >     'addr_proto' type_id=3D8 bits_offset=3D32
>> >> >> > >> >     'is_frag' type_id=3D3 bits_offset=3D48
>> >> >> > >> >     'is_first_frag' type_id=3D3 bits_offset=3D56
>> >> >> > >> >     'is_encap' type_id=3D3 bits_offset=3D64
>> >> >> > >> >     'ip_proto' type_id=3D3 bits_offset=3D72
>> >> >> > >> >     'n_proto' type_id=3D20 bits_offset=3D80
>> >> >> > >> >     'sport' type_id=3D20 bits_offset=3D96
>> >> >> > >> >     'dport' type_id=3D20 bits_offset=3D112
>> >> >> > >> >     '(anon)' type_id=3D25 bits_offset=3D128
>> >> >> > >> >     'flags' type_id=3D12 bits_offset=3D384
>> >> >> > >> >     'flow_label' type_id=3D21 bits_offset=3D416
>> >> >> > >> > [25] UNION '(anon)' size=3D32 vlen=3D2
>> >> >> > >> >     '(anon)' type_id=3D26 bits_offset=3D0
>> >> >> > >> >     '(anon)' type_id=3D27 bits_offset=3D0
>> >> >> > >> > [26] STRUCT '(anon)' size=3D8 vlen=3D2
>> >> >> > >> >     'ipv4_src' type_id=3D21 bits_offset=3D0
>> >> >> > >> >     'ipv4_dst' type_id=3D21 bits_offset=3D32
>> >> >> > >> > [27] STRUCT '(anon)' size=3D32 vlen=3D2
>> >> >> > >> >     'ipv6_src' type_id=3D28 bits_offset=3D0
>> >> >> > >> >     'ipv6_dst' type_id=3D28 bits_offset=3D128
>> >> >> > >> > [28] ARRAY '(anon)' type_id=3D12 index_type_id=3D16 nr_elem=
s=3D4
>> >> >> > >> > [29] PTR '(anon)' type_id=3D24
>> >> >> > >> > [30] UNION '(anon)' size=3D8 vlen=3D1
>> >> >> > >> >     'sk' type_id=3D32 bits_offset=3D0
>> >> >> > >> > [31] STRUCT 'bpf_sock' size=3D80 vlen=3D14
>> >> >> > >> >     'bound_dev_if' type_id=3D12 bits_offset=3D0
>> >> >> > >> >     'family' type_id=3D12 bits_offset=3D32
>> >> >> > >> >     'type' type_id=3D12 bits_offset=3D64
>> >> >> > >> >     'protocol' type_id=3D12 bits_offset=3D96
>> >> >> > >> >     'mark' type_id=3D12 bits_offset=3D128
>> >> >> > >> >     'priority' type_id=3D12 bits_offset=3D160
>> >> >> > >> >     'src_ip4' type_id=3D12 bits_offset=3D192
>> >> >> > >> >     'src_ip6' type_id=3D28 bits_offset=3D224
>> >> >> > >> >     'src_port' type_id=3D12 bits_offset=3D352
>> >> >> > >> >     'dst_port' type_id=3D20 bits_offset=3D384
>> >> >> > >> >     'dst_ip4' type_id=3D12 bits_offset=3D416
>> >> >> > >> >     'dst_ip6' type_id=3D28 bits_offset=3D448
>> >> >> > >> >     'state' type_id=3D12 bits_offset=3D576
>> >> >> > >> >     'rx_queue_mapping' type_id=3D10 bits_offset=3D608
>> >> >> > >> > [32] PTR '(anon)' type_id=3D31
>> >> >> > >> > [33] STRUCT '__sk_buff' size=3D192 vlen=3D33
>> >> >> > >> >     'len' type_id=3D12 bits_offset=3D0
>> >> >> > >> >     'pkt_type' type_id=3D12 bits_offset=3D32
>> >> >> > >> >     'mark' type_id=3D12 bits_offset=3D64
>> >> >> > >> >     'queue_mapping' type_id=3D12 bits_offset=3D96
>> >> >> > >> >     'protocol' type_id=3D12 bits_offset=3D128
>> >> >> > >> >     'vlan_present' type_id=3D12 bits_offset=3D160
>> >> >> > >> >     'vlan_tci' type_id=3D12 bits_offset=3D192
>> >> >> > >> >     'vlan_proto' type_id=3D12 bits_offset=3D224
>> >> >> > >> >     'priority' type_id=3D12 bits_offset=3D256
>> >> >> > >> >     'ingress_ifindex' type_id=3D12 bits_offset=3D288
>> >> >> > >> >     'ifindex' type_id=3D12 bits_offset=3D320
>> >> >> > >> >     'tc_index' type_id=3D12 bits_offset=3D352
>> >> >> > >> >     'cb' type_id=3D34 bits_offset=3D384
>> >> >> > >> >     'hash' type_id=3D12 bits_offset=3D544
>> >> >> > >> >     'tc_classid' type_id=3D12 bits_offset=3D576
>> >> >> > >> >     'data' type_id=3D12 bits_offset=3D608
>> >> >> > >> >     'data_end' type_id=3D12 bits_offset=3D640
>> >> >> > >> >     'napi_id' type_id=3D12 bits_offset=3D672
>> >> >> > >> >     'family' type_id=3D12 bits_offset=3D704
>> >> >> > >> >     'remote_ip4' type_id=3D12 bits_offset=3D736
>> >> >> > >> >     'local_ip4' type_id=3D12 bits_offset=3D768
>> >> >> > >> >     'remote_ip6' type_id=3D28 bits_offset=3D800
>> >> >> > >> >     'local_ip6' type_id=3D28 bits_offset=3D928
>> >> >> > >> >     'remote_port' type_id=3D12 bits_offset=3D1056
>> >> >> > >> >     'local_port' type_id=3D12 bits_offset=3D1088
>> >> >> > >> >     'data_meta' type_id=3D12 bits_offset=3D1120
>> >> >> > >> >     '(anon)' type_id=3D23 bits_offset=3D1152
>> >> >> > >> >     'tstamp' type_id=3D15 bits_offset=3D1216
>> >> >> > >> >     'wire_len' type_id=3D12 bits_offset=3D1280
>> >> >> > >> >     'gso_segs' type_id=3D12 bits_offset=3D1312
>> >> >> > >> >     '(anon)' type_id=3D30 bits_offset=3D1344
>> >> >> > >> >     'gso_size' type_id=3D12 bits_offset=3D1408
>> >> >> > >> >     'hwtstamp' type_id=3D15 bits_offset=3D1472
>> >> >> > >> > [34] ARRAY '(anon)' type_id=3D12 index_type_id=3D16 nr_elem=
s=3D5
>> >> >> > >> > [35] CONST '(anon)' type_id=3D33
>> >> >> > >> > [36] PTR '(anon)' type_id=3D0
>> >> >> > >> > [37] STRUCT '(anon)' size=3D24 vlen=3D3
>> >> >> > >> >     'type' type_id=3D39 bits_offset=3D0
>> >> >> > >> >     'key' type_id=3D40 bits_offset=3D64
>> >> >> > >> >     'value' type_id=3D41 bits_offset=3D128
>> >> >> > >> > [38] ARRAY '(anon)' type_id=3D9 index_type_id=3D16 nr_elems=
=3D1
>> >> >> > >> > [39] PTR '(anon)' type_id=3D38
>> >> >> > >> > [40] PTR '(anon)' type_id=3D12
>> >> >> > >> > [41] PTR '(anon)' type_id=3D3
>> >> >> > >> > [42] ARRAY '(anon)' type_id=3D19 index_type_id=3D16 nr_elem=
s=3D18
>> >> >> > >> > [43] CONST '(anon)' type_id=3D42
>> >> >> > >> > [44] FUNC_PROTO '(anon)' ret_type_id=3D36 vlen=3D2
>> >> >> > >> >     '(anon)' type_id=3D36
>> >> >> > >> >     '(anon)' type_id=3D46
>> >> >> > >> > [45] CONST '(anon)' type_id=3D0
>> >> >> > >> > [46] PTR '(anon)' type_id=3D45
>> >> >> > >> > [47] FUNC_PROTO '(anon)' ret_type_id=3D9 vlen=3D1
>> >> >> > >> >     'sk' type_id=3D48
>> >> >> > >> > [48] PTR '(anon)' type_id=3D35
>> >> >> > >> > [49] VAR '_license' type_id=3D43, linkage=3Dstatic
>> >> >> > >> > [50] VAR 'is_allow_list' type_id=3D5, linkage=3Dglobal
>> >> >> > >> > [51] VAR 'sd_restrictif' type_id=3D37, linkage=3Dglobal
>> >> >> > >> > [52] FUNC 'sd_restrictif_i' type_id=3D47 linkage=3Dglobal
>> >> >> > >> > [53] FUNC 'sd_restrictif_e' type_id=3D47 linkage=3Dglobal
>> >> >> > >> > [54] FUNC 'restrict_network_interfaces_impl' type_id=3D47 l=
inkage=3Dstatic
>> >> >> > >> > [55] DATASEC '.data' size=3D1 vlen=3D1
>> >> >> > >> >     type_id=3D50 offset=3D0 size=3D1 (VAR 'is_allow_list')
>> >> >> > >> > [56] DATASEC 'license' size=3D18 vlen=3D1
>> >> >> > >> >     type_id=3D49 offset=3D0 size=3D18 (VAR '_license')
>> >> >> > >> > [57] DATASEC '.maps' size=3D24 vlen=3D1
>> >> >> > >> >     type_id=3D51 offset=3D0 size=3D24 (VAR 'sd_restrictif')
>> >> >> > >> >
>> >> >> > >> > File before being stripped using bpftool gen object:
>> >> >> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/s=
bin/bpftool
>> >> >> > >> > btf dump file
>> >> >> > >> >
>> >> >
>> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restric=
t-ifaces.bpf.unstripped.o
>> >> >> > >> > format raw
>> >> >> > >> > [1] INT 'signed char' size=3D1 bits_offset=3D0 nr_bits=3D8 =
encoding=3DUNKN
>> >> >> > >> > [2] INT 'unsigned char' size=3D1 bits_offset=3D0 nr_bits=3D=
8 encoding=3DCHAR
>> >> >> > >> > [3] TYPEDEF '__u8' type_id=3D2
>> >> >> > >> > [4] CONST '(anon)' type_id=3D3
>> >> >> > >> > [5] VOLATILE '(anon)' type_id=3D4
>> >> >> > >> > [6] INT 'short int' size=3D2 bits_offset=3D0 nr_bits=3D16 e=
ncoding=3DSIGNED
>> >> >> > >> > [7] INT 'short unsigned int' size=3D2 bits_offset=3D0 nr_bi=
ts=3D16 encoding=3D(none)
>> >> >> > >> > [8] TYPEDEF '__u16' type_id=3D7
>> >> >> > >> > [9] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encodin=
g=3DSIGNED
>> >> >> > >> > [10] TYPEDEF '__s32' type_id=3D9
>> >> >> > >> > [11] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D=
32 encoding=3D(none)
>> >> >> > >> > [12] TYPEDEF '__u32' type_id=3D11
>> >> >> > >> > [13] INT 'long long int' size=3D8 bits_offset=3D0 nr_bits=
=3D64 encoding=3DSIGNED
>> >> >> > >> > [14] INT 'long long unsigned int' size=3D8 bits_offset=3D0 =
nr_bits=3D64
>> >> >> > >> > encoding=3D(none)
>> >> >> > >> > [15] TYPEDEF '__u64' type_id=3D14
>> >> >> > >> > [16] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bi=
ts=3D64 encoding=3D(none)
>> >> >> > >> > [17] INT 'long int' size=3D8 bits_offset=3D0 nr_bits=3D64 e=
ncoding=3DSIGNED
>> >> >> > >> > [18] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encodi=
ng=3DUNKN
>> >> >> > >> > [19] CONST '(anon)' type_id=3D18
>> >> >> > >> > [20] TYPEDEF '__be16' type_id=3D8
>> >> >> > >> > [21] TYPEDEF '__be32' type_id=3D12
>> >> >> > >> > [22] ENUM 'bpf_map_type' encoding=3DUNSIGNED size=3D4 vlen=
=3D31
>> >> >> > >> >     'BPF_MAP_TYPE_UNSPEC' val=3D0
>> >> >> > >> >     'BPF_MAP_TYPE_HASH' val=3D1
>> >> >> > >> >     'BPF_MAP_TYPE_ARRAY' val=3D2
>> >> >> > >> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3D3
>> >> >> > >> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=3D4
>> >> >> > >> >     'BPF_MAP_TYPE_PERCPU_HASH' val=3D5
>> >> >> > >> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=3D6
>> >> >> > >> >     'BPF_MAP_TYPE_STACK_TRACE' val=3D7
>> >> >> > >> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=3D8
>> >> >> > >> >     'BPF_MAP_TYPE_LRU_HASH' val=3D9
>> >> >> > >> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=3D10
>> >> >> > >> >     'BPF_MAP_TYPE_LPM_TRIE' val=3D11
>> >> >> > >> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=3D12
>> >> >> > >> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=3D13
>> >> >> > >> >     'BPF_MAP_TYPE_DEVMAP' val=3D14
>> >> >> > >> >     'BPF_MAP_TYPE_SOCKMAP' val=3D15
>> >> >> > >> >     'BPF_MAP_TYPE_CPUMAP' val=3D16
>> >> >> > >> >     'BPF_MAP_TYPE_XSKMAP' val=3D17
>> >> >> > >> >     'BPF_MAP_TYPE_SOCKHASH' val=3D18
>> >> >> > >> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=3D19
>> >> >> > >> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=3D20
>> >> >> > >> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=3D21
>> >> >> > >> >     'BPF_MAP_TYPE_QUEUE' val=3D22
>> >> >> > >> >     'BPF_MAP_TYPE_STACK' val=3D23
>> >> >> > >> >     'BPF_MAP_TYPE_SK_STORAGE' val=3D24
>> >> >> > >> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=3D25
>> >> >> > >> >     'BPF_MAP_TYPE_STRUCT_OPS' val=3D26
>> >> >> > >> >     'BPF_MAP_TYPE_RINGBUF' val=3D27
>> >> >> > >> >     'BPF_MAP_TYPE_INODE_STORAGE' val=3D28
>> >> >> > >> >     'BPF_MAP_TYPE_TASK_STORAGE' val=3D29
>> >> >> > >> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=3D30
>> >> >> > >> > [23] UNION '(anon)' size=3D8 vlen=3D1
>> >> >> > >> >     'flow_keys' type_id=3D29 bits_offset=3D0
>> >> >> > >> > [24] STRUCT 'bpf_flow_keys' size=3D56 vlen=3D13
>> >> >> > >> >     'nhoff' type_id=3D8 bits_offset=3D0
>> >> >> > >> >     'thoff' type_id=3D8 bits_offset=3D16
>> >> >> > >> >     'addr_proto' type_id=3D8 bits_offset=3D32
>> >> >> > >> >     'is_frag' type_id=3D3 bits_offset=3D48
>> >> >> > >> >     'is_first_frag' type_id=3D3 bits_offset=3D56
>> >> >> > >> >     'is_encap' type_id=3D3 bits_offset=3D64
>> >> >> > >> >     'ip_proto' type_id=3D3 bits_offset=3D72
>> >> >> > >> >     'n_proto' type_id=3D20 bits_offset=3D80
>> >> >> > >> >     'sport' type_id=3D20 bits_offset=3D96
>> >> >> > >> >     'dport' type_id=3D20 bits_offset=3D112
>> >> >> > >> >     '(anon)' type_id=3D25 bits_offset=3D128
>> >> >> > >> >     'flags' type_id=3D12 bits_offset=3D384
>> >> >> > >> >     'flow_label' type_id=3D21 bits_offset=3D416
>> >> >> > >> > [25] UNION '(anon)' size=3D32 vlen=3D2
>> >> >> > >> >     '(anon)' type_id=3D26 bits_offset=3D0
>> >> >> > >> >     '(anon)' type_id=3D27 bits_offset=3D0
>> >> >> > >> > [26] STRUCT '(anon)' size=3D8 vlen=3D2
>> >> >> > >> >     'ipv4_src' type_id=3D21 bits_offset=3D0
>> >> >> > >> >     'ipv4_dst' type_id=3D21 bits_offset=3D32
>> >> >> > >> > [27] STRUCT '(anon)' size=3D32 vlen=3D2
>> >> >> > >> >     'ipv6_src' type_id=3D28 bits_offset=3D0
>> >> >> > >> >     'ipv6_dst' type_id=3D28 bits_offset=3D128
>> >> >> > >> > [28] ARRAY '(anon)' type_id=3D12 index_type_id=3D16 nr_elem=
s=3D4
>> >> >> > >> > [29] PTR '(anon)' type_id=3D24
>> >> >> > >> > [30] UNION '(anon)' size=3D8 vlen=3D1
>> >> >> > >> >     'sk' type_id=3D32 bits_offset=3D0
>> >> >> > >> > [31] STRUCT 'bpf_sock' size=3D80 vlen=3D14
>> >> >> > >> >     'bound_dev_if' type_id=3D12 bits_offset=3D0
>> >> >> > >> >     'family' type_id=3D12 bits_offset=3D32
>> >> >> > >> >     'type' type_id=3D12 bits_offset=3D64
>> >> >> > >> >     'protocol' type_id=3D12 bits_offset=3D96
>> >> >> > >> >     'mark' type_id=3D12 bits_offset=3D128
>> >> >> > >> >     'priority' type_id=3D12 bits_offset=3D160
>> >> >> > >> >     'src_ip4' type_id=3D12 bits_offset=3D192
>> >> >> > >> >     'src_ip6' type_id=3D28 bits_offset=3D224
>> >> >> > >> >     'src_port' type_id=3D12 bits_offset=3D352
>> >> >> > >> >     'dst_port' type_id=3D20 bits_offset=3D384
>> >> >> > >> >     'dst_ip4' type_id=3D12 bits_offset=3D416
>> >> >> > >> >     'dst_ip6' type_id=3D28 bits_offset=3D448
>> >> >> > >> >     'state' type_id=3D12 bits_offset=3D576
>> >> >> > >> >     'rx_queue_mapping' type_id=3D10 bits_offset=3D608
>> >> >> > >> > [32] PTR '(anon)' type_id=3D31
>> >> >> > >> > [33] STRUCT '__sk_buff' size=3D192 vlen=3D33
>> >> >> > >> >     'len' type_id=3D12 bits_offset=3D0
>> >> >> > >> >     'pkt_type' type_id=3D12 bits_offset=3D32
>> >> >> > >> >     'mark' type_id=3D12 bits_offset=3D64
>> >> >> > >> >     'queue_mapping' type_id=3D12 bits_offset=3D96
>> >> >> > >> >     'protocol' type_id=3D12 bits_offset=3D128
>> >> >> > >> >     'vlan_present' type_id=3D12 bits_offset=3D160
>> >> >> > >> >     'vlan_tci' type_id=3D12 bits_offset=3D192
>> >> >> > >> >     'vlan_proto' type_id=3D12 bits_offset=3D224
>> >> >> > >> >     'priority' type_id=3D12 bits_offset=3D256
>> >> >> > >> >     'ingress_ifindex' type_id=3D12 bits_offset=3D288
>> >> >> > >> >     'ifindex' type_id=3D12 bits_offset=3D320
>> >> >> > >> >     'tc_index' type_id=3D12 bits_offset=3D352
>> >> >> > >> >     'cb' type_id=3D34 bits_offset=3D384
>> >> >> > >> >     'hash' type_id=3D12 bits_offset=3D544
>> >> >> > >> >     'tc_classid' type_id=3D12 bits_offset=3D576
>> >> >> > >> >     'data' type_id=3D12 bits_offset=3D608
>> >> >> > >> >     'data_end' type_id=3D12 bits_offset=3D640
>> >> >> > >> >     'napi_id' type_id=3D12 bits_offset=3D672
>> >> >> > >> >     'family' type_id=3D12 bits_offset=3D704
>> >> >> > >> >     'remote_ip4' type_id=3D12 bits_offset=3D736
>> >> >> > >> >     'local_ip4' type_id=3D12 bits_offset=3D768
>> >> >> > >> >     'remote_ip6' type_id=3D28 bits_offset=3D800
>> >> >> > >> >     'local_ip6' type_id=3D28 bits_offset=3D928
>> >> >> > >> >     'remote_port' type_id=3D12 bits_offset=3D1056
>> >> >> > >> >     'local_port' type_id=3D12 bits_offset=3D1088
>> >> >> > >> >     'data_meta' type_id=3D12 bits_offset=3D1120
>> >> >> > >> >     '(anon)' type_id=3D23 bits_offset=3D1152
>> >> >> > >> >     'tstamp' type_id=3D15 bits_offset=3D1216
>> >> >> > >> >     'wire_len' type_id=3D12 bits_offset=3D1280
>> >> >> > >> >     'gso_segs' type_id=3D12 bits_offset=3D1312
>> >> >> > >> >     '(anon)' type_id=3D30 bits_offset=3D1344
>> >> >> > >> >     'gso_size' type_id=3D12 bits_offset=3D1408
>> >> >> > >> >     'hwtstamp' type_id=3D15 bits_offset=3D1472
>> >> >> > >> > [34] ARRAY '(anon)' type_id=3D12 index_type_id=3D16 nr_elem=
s=3D5
>> >> >> > >> > [35] CONST '(anon)' type_id=3D33
>> >> >> > >> > [36] PTR '(anon)' type_id=3D0
>> >> >> > >> > [37] STRUCT '(anon)' size=3D24 vlen=3D3
>> >> >> > >> >     'type' type_id=3D39 bits_offset=3D0
>> >> >> > >> >     'key' type_id=3D40 bits_offset=3D64
>> >> >> > >> >     'value' type_id=3D41 bits_offset=3D128
>> >> >> > >> > [38] ARRAY '(anon)' type_id=3D9 index_type_id=3D16 nr_elems=
=3D1
>> >> >> > >> > [39] PTR '(anon)' type_id=3D38
>> >> >> > >> > [40] PTR '(anon)' type_id=3D12
>> >> >> > >> > [41] PTR '(anon)' type_id=3D3
>> >> >> > >> > [42] ARRAY '(anon)' type_id=3D19 index_type_id=3D16 nr_elem=
s=3D18
>> >> >> > >> > [43] CONST '(anon)' type_id=3D42
>> >> >> > >> > [44] FUNC_PROTO '(anon)' ret_type_id=3D36 vlen=3D2
>> >> >> > >> >     '(anon)' type_id=3D36
>> >> >> > >> >     '(anon)' type_id=3D46
>> >> >> > >> > [45] CONST '(anon)' type_id=3D0
>> >> >> > >> > [46] PTR '(anon)' type_id=3D45
>> >> >> > >> > [47] FUNC_PROTO '(anon)' ret_type_id=3D9 vlen=3D1
>> >> >> > >> >     'sk' type_id=3D48
>> >> >> > >> > [48] PTR '(anon)' type_id=3D35
>> >> >> > >> > [49] FUNC_PROTO '(anon)' ret_type_id=3D9 vlen=3D1
>> >> >> > >> >     'sk' type_id=3D48
>> >> >> > >> > [50] FUNC_PROTO '(anon)' ret_type_id=3D9 vlen=3D1
>> >> >> > >> >     'sk' type_id=3D48
>> >> >> > >> > [51] VAR '_license' type_id=3D43, linkage=3Dstatic
>> >> >> > >> > [52] VAR 'is_allow_list' type_id=3D5, linkage=3Dglobal
>> >> >> > >> > [53] VAR 'sd_restrictif' type_id=3D37, linkage=3Dglobal
>> >> >> > >> > [54] FUNC 'bpf_map_lookup_elem' type_id=3D44 linkage=3Dglob=
al
>> >> >> > >> > [55] FUNC 'sd_restrictif_i' type_id=3D47 linkage=3Dglobal
>> >> >> > >> > [56] FUNC 'sd_restrictif_e' type_id=3D49 linkage=3Dglobal
>> >> >> > >> > [57] FUNC 'restrict_network_interfaces_impl' type_id=3D50 l=
inkage=3Dstatic
>> >> >> > >> > [58] DATASEC 'license' size=3D0 vlen=3D1
>> >> >> > >> >     type_id=3D51 offset=3D0 size=3D18 (VAR '_license')
>> >> >> > >> > [59] DATASEC '.maps' size=3D0 vlen=3D1
>> >> >> > >> >     type_id=3D53 offset=3D0 size=3D24 (VAR 'sd_restrictif')
>> >> >> > >> > [60] DATASEC '.data' size=3D0 vlen=3D1
>> >> >> > >> >     type_id=3D52 offset=3D0 size=3D1 (VAR 'is_allow_list')
>> >> >> > >> >
>> >> >> > >> >>
>> >> >> > >> >> >> GCC is wrong, clearly. This function is global ([0]) an=
d libbpf
>> >> >> > >> >> >> expects it to be marked as such in BTF.
>> >> >> > >> >> >>
>> >> >> > >> >> >>
>> >> >> > >> >
>> >> >
>> > https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifa=
ces/restrict-ifaces.bpf.c#L42-L50
>> >> >> > >> >> >>
>> >> >> > >> >> >>
>> >> >> > >> >> >>> GCC:
>> >> >> > >> >> >>>
>> >> >> > >> >> >>> [1] INT 'signed char' size=3D1 bits_offset=3D0 nr_bits=
=3D8 encoding=3DUNKN
>> >> >> > >> >> >>> [2] INT 'unsigned char' size=3D1 bits_offset=3D0 nr_bi=
ts=3D8 encoding=3DCHAR
>> >> >> > >> >> >>> [3] TYPEDEF '__u8' type_id=3D2
>> >> >> > >> >> >>> [4] CONST '(anon)' type_id=3D3
>> >> >> > >> >> >>
>> >> >> > >> >> >> [...]
