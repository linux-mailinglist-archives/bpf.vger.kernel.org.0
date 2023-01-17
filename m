Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7568566E38C
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 17:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjAQQ1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 11:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAQQ1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 11:27:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788CD18173;
        Tue, 17 Jan 2023 08:27:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGCMQe018709;
        Tue, 17 Jan 2023 16:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xStEp5MT+xYfJlHexa2SBd8Gc54wcIrCYFH1mfa1u4s=;
 b=MAArM0hMOOZgKHFix/0bytc4UMHy+4ftkYKA4DLUZXTTcExdLt7b5kIF91wIJoGvvAk0
 GLgD0fai9YL/O95cioO6i37ri2sZ4quIgAymNbtISFKM6zYbjmyQYwIss4LS1Hptq+x8
 vK60xZY7dvkVi09IlG5lfujVOLeiRXtFh5Z/rNYB1gfhjEgTWSty/xXSeltO6wU/Iy9z
 jKov6fntHPTvTTyTeFRkNXP0SCgz+d1iEApVe/diebpJP9mAKa7ynW3TzTOKwOhoF/g6
 6JFoKTeP6pLcVAeAE3BduiqGSu41SlECpTi/lCYcLO0mx4AdI4J9eQYzy+jfw0z/8Rkf 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tn6c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 16:27:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HFtJEC031066;
        Tue, 17 Jan 2023 16:27:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rx51td7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 16:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqeuG7d99np7bXCZ4Ztz41edkoZxRRnEUXAfDbjc3+6LFxAoaqwxFkI/ugwvFR766MKhgYueiPbuzr7T4RD4MzDrZhJON4dL6FonsV8Q/AUIh1vMT7S6PjZK9dWpN9USpqnKVglphnDgzClZ3pMONffTeNGaisUdCg8UkhznpuyOhC3+kfWhkJakP8AY8fB8pEq6rMMTguP66Rp7XnEU0Hl28G09xrbUKArl4A8N8EzD+345t+ePIHNIpe25DclXKRnV49XOCC0mzL/N13yyNw8D5twvHYoqpBZUThlzQaFV7fWnaHWg5SiKY87klmszJcnpgWa7IvyZZnN3WsQ6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xStEp5MT+xYfJlHexa2SBd8Gc54wcIrCYFH1mfa1u4s=;
 b=Od5BsU1BtijoZe0MbW9pXXRyh9+m5aOyYRTM2uGataBdlLb50sSySKbMn34xQ9miEeEgbQQTEjGSu1+xWGxlmdhfpRHZJFKvo4s9ibU+jZ/WTTTYshqeJk8xQEWfVY43ErA32BE37xYHXiLDBwLdP8MsGcHIslUiaqeuKOQcpWXmHUDzz2DbWSSBQY12bqOsfCnMrC/wwLh7Kt5MnovKegcjN3eV8hmr0E+4wynxqLVEQ0mfHxGrarC4fY0nKHUpcTQHElI+1PvYuXIdF+dhOGmWe5TSwNf3ZPagp4RLqhg0TW+xFHVTsJLxfTk5/FImjLlaTIy5aRXaWY19vpKFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xStEp5MT+xYfJlHexa2SBd8Gc54wcIrCYFH1mfa1u4s=;
 b=olRdY+JANWHYJnQYWDhHKNKYqPYXWqp2ETql6izr6/ojv6G3COy/jjpBwMINerkJ1n2+OIIVzocJd1T/THTnr67gbX3xRSIiGGhjYbZDPhnCIimzM9OF6ngagV17FHwHws8yFl+u3xz6yITvbe0JMiZXBFON1AbBupC27w+Vq1Q=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS0PR10MB6248.namprd10.prod.outlook.com (2603:10b6:8:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 16:27:01 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%3]) with mapi id 15.20.6002.009; Tue, 17 Jan 2023
 16:27:01 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Peter Foley <pefoley2@pefoley.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        david.faust@oracle.com, elena.zannoni@oracle.com
Subject: Re: [PATCH] tools: bpf: Disable stack protector
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
        <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
        <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
        <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
        <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com>
        <87bkmx9tw8.fsf@oracle.com>
Date:   Tue, 17 Jan 2023 17:31:15 +0100
In-Reply-To: <87bkmx9tw8.fsf@oracle.com> (Jose E. Marchesi's message of "Tue,
        17 Jan 2023 14:23:51 +0100")
Message-ID: <87sfg96s30.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::14) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS0PR10MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e23047-6a18-46e7-48d7-08daf8a7a90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IG+nTgPZmYeRiE3v6cB8KPt4xANnW2k+IjWNmVDwpuXBa7ecWXke3JyGNaic45A8eR3VBnA0y0/S7lYfURqtMguXIHTZph5Y5jBxhylgkg+uSxAmfNen33Qbb7IUrMU41vCfHUB3ZaYetZeb/jY/0Nw2CZl5mlJlXCDfo2xAQ6s3bBlzzCdJEsIn2Yyw9MpYdwXJnfuICvrI28AQhWe69zCW2kgJB1M7PdvKwUK7S2LHjgnFuoRUHFDFzBwfDCf6gF2bVQllGt97UM+YDDAy9a4o8pb4kj1TtPv+n56WdmoLu57yPA0FKU25XeBIqWyN6Kb6Oiak+pYZqRrWX0Ry31Isi/B231LQ949Onlub8WULLB4hU/ajdJ8rTEJFhoYZtsoL8kxm+GRpTJNI92Bxi69xbEpu+RWlbtumtFuo2wNDynKkKcf/3/JbSnKtPVVDY4TP/E4B7uQFfj30JhypLYZZxXOb7GmoPbtTLXa5gYlg6/eOeOeubgn8X9byJvtTw3izaX9oN0H2hUA5aNknNhgk8XV0GsDnHZp7+Hsf437k9CAhcmCCYSIBO+O8MqqiJmVtxSLBDf/xG6FJCeHcb0JyhJLiHkxqCyuvLJOJBsj7YoxV1LfdPzBEUr7XvA49rC6cz1olS1vQDhih5CZD5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(316002)(186003)(6486002)(6512007)(86362001)(36756003)(26005)(66556008)(6916009)(8676002)(66476007)(4326008)(66946007)(478600001)(41300700001)(83380400001)(5660300002)(38100700002)(6506007)(53546011)(2906002)(7416002)(2616005)(54906003)(6666004)(8936002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhlRUNqdGkrY01HOVJsQ2IyZkxDYmV3SG00VFJXVk9DZkhQblNiTU9Wb0Rh?=
 =?utf-8?B?NnJvMkx3MnlLOFRXS3pheXNMenRZT1BzK0lJVFByQnE5VU16R01Ca3BMSWFa?=
 =?utf-8?B?dFE5eFd2dGh2eXlKZ1VGdm5jSWF2R3ZHMVRPNkJtVys5Q1VxSXh5RzhtOUwv?=
 =?utf-8?B?WGpwTlNERU5Cc1RtU3hXaTlYdWZzUm1TS01SL1RiZ2Q5WWVFY1BhYVJFTCs5?=
 =?utf-8?B?WC9BenRBVzQzMjZQOENUQ2toMmVOc3Z6RU1lM3JYcDFnanp4Y2ZHbXhCejJq?=
 =?utf-8?B?OHRROThQNm95M0hFQ2VMNW1xdE9PMFBNTTVqRkdQM3FqVnRLcmVGZUszeHh6?=
 =?utf-8?B?ZC8zYzZRWnNHbDRiNGpMVzVnNTFpc0o1ZnI5L1ZCQW91TnhJS2hTVjZrY21j?=
 =?utf-8?B?bkdoM1p5SXEydHpkL1lwL1IrUUFhWHM3L2dlWWpaa2JOZHQ3NXdrYzNnODFk?=
 =?utf-8?B?Wk5XU2dCV0Fjd0R0QWVZS3JmRDcyekdodGN0dXozNHlzVHYxcEpnSGdtbWh1?=
 =?utf-8?B?amlFdTVIQlVoMjRGRzhyV2pBRmFYRFVRVmtlK1JyYW9pOWRraXRBYUFDN3A0?=
 =?utf-8?B?M1pwc3lxUlNtMlJqcXFSMW1LRDI0UjhyaU9TaWhZa3RjMWwwM21iTVBjUjRB?=
 =?utf-8?B?aFZYK1ZCRVo4a2FSbTNTbkQrNmVqUU50N1F2bnBIL09QS3R5YmtxVUVqQW1C?=
 =?utf-8?B?aWxnZHppcnJoRjlJMUpVa3FFUTRSaCtFNGlsZWQ2dEwwTEduVVVycHVhVlIz?=
 =?utf-8?B?aGNiUkloUVFNbU5BNG9QbjFWR2FBbHROSjFzUTJ0dmk0MnFmRnJ3c3pkTjVC?=
 =?utf-8?B?UVRnYzJvcE1jc1VuRGR0Yk4yTTBKTkRNWUZ6RU14TkY3d3Y2QzV4cldKa1hn?=
 =?utf-8?B?SG8yK1ZwMDZrMGtQdDd6SllJMnNGQmh1SHNLeDdpTDBMdGhxK29hQWUxNFcz?=
 =?utf-8?B?QWhYelBLL3ZkWnV0LzNxREFBQWRQcU96dFFsK1hsNWNhNm8wMy9OZnpxdHJJ?=
 =?utf-8?B?dDNzcndiazhidXpHYXl2VzJZSmZVTWVSS3BQMFRRbXIxNGlUWnROTjlSU0V0?=
 =?utf-8?B?ZFBoQUFMYk04N2d1RysrZWVoeXJFM1hmVFhqeE53ODFUSytyYkQyVUtpcnd5?=
 =?utf-8?B?b1Mrb2FZOTZYQ1hQNjBTLytNRHRxQVltcDBHSDh3ZlN5citMaWRncWMrY0h3?=
 =?utf-8?B?RE00RWVQdDBtTXdud1I3eWpkd0pRVUFrSmxyYlhzcXZpTVNwbXhiclFtZ2tl?=
 =?utf-8?B?VSsrbHYxb3hpOEVMdEhiYTE3M0NWSWQ2a1lCS09KZjNsWUlpL3c0UXdLTUE1?=
 =?utf-8?B?L29sTUcwbjdFTkNiOVRMWGZJd2phVG0reStBY2FlQzVRbEtHSXd4anhFdWN4?=
 =?utf-8?B?ekR3MnpySXdnV1BaWmhCdDI4bTlQdHFwSVZBaFlKMEMzRW9WM05FR2FrQ1lM?=
 =?utf-8?B?WUVLU09TKzgraHlQNHBUMUdacXNZWmkvQm9DK2lRd0Ftem5nbXJtUWorRCtG?=
 =?utf-8?B?R2cxdkI0bXFpMW1HQjJsSzYxVTkrMmlBVDRrOUkxakJzQkQ3Q0V1Z0xadE9Z?=
 =?utf-8?B?Mkh5ZnBvd1RzbTFmRW0xVE44MUdUdVFpbTcrM3hieHlIWDN2OFVJRjlhRjdS?=
 =?utf-8?B?akFtdmJCSzhiYVdUbEkwc2RmdVM5SG5iOEhsNmhBM1hhSHN6U3FRdmRQbVVv?=
 =?utf-8?B?ekwxdC9kalphWm9ubkFHSmIxVTRXanc1cWxHb1NGanRDU2tTaW96RndISTFE?=
 =?utf-8?B?dDYzMGxEenRYMXo3QTRGS05icG5pMFl3TVdYckpzR3RIbVlSM3V0Qm10QThS?=
 =?utf-8?B?WGxkSGlma05ka0NRRCs3NDczaG9JbWhhKy9hV0diU2ZGVmRzT1UvamY5aWl3?=
 =?utf-8?B?WVY0OEp2WEVTd1l3TnA4V2pZMXFIamJRZWNyQWJtL2lvdUFycDVIL2JyaGlu?=
 =?utf-8?B?SzVUMmp1aGhMc1lGakliWUprdDBoOENweFNRWWxqQlpaNFRrbS9iZkpwRjYx?=
 =?utf-8?B?bXFySVVpU2RxdGw2YWdmelFHOW5IMUl6TmJVai9kNTJ6TmFybGZ0ZnBDSzhl?=
 =?utf-8?B?VjR4U1M5RnRqdVphcjZvMWdZRFV3SWpFZVhlakZKMm8vUTlteGphbGhJYXNO?=
 =?utf-8?B?c0Erbm1ya0xCOGsyK3h5OHg3YzJpRGFqQ0F1V0l0dEowUXBNaHozNWtMMWoy?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SzN3RWZIM2hjeDJmS0NzdDVNWExNaWtjdFdLNUlac1ZaQUlNaXVDSkVwNUFW?=
 =?utf-8?B?ZHZvcWwxck5zTDlGb3o0bjhSK1ZPa2E3akRqUjhkcE5ValZHNVR1TVlzQ1hR?=
 =?utf-8?B?dXJUWW82eEM0eDhOTS9BMGV0NlNYU2wxWVE0NDUyVHhpbHlzd1JwY0RFS3NV?=
 =?utf-8?B?Ykd6TGUxcjJ1aHZvazN0MlI5T2JjRkpMZ09qYkV5N0dtM0FXT0Zsb1lkZG5X?=
 =?utf-8?B?VURNaVNQR0h2TlUxdGdhak1vQ1RjY0NCK2NTODZreU1nNmxvMjVwdmllelV5?=
 =?utf-8?B?bm53Ri9ZYlI4QnRISllsSVVwTUJZQlE0RlVoZDNUdzNieEg2aUVyVnlaeVZP?=
 =?utf-8?B?QmQvVm5pS2xSclU5cFVhM2FoZ1hldzNEYk8zS0E4U0tsR2FtTnBZYm9wV0F0?=
 =?utf-8?B?TnpBMWRFTm05N1EzUEtsQkQ5bU4wYXhUUStLL1NkdWlBT3BxWmFxUmhDT1I5?=
 =?utf-8?B?ditiL2VxQU5WZ3YvRStIRlJRQmNlU25CU0l1cmkvZXk2Q2dEV2s4MDh2eG9C?=
 =?utf-8?B?WVJmbnN2VDc5VDJ4QTJYS2FNWlVRU080M3FWcldldHQyYklocUxtcmRqRFEw?=
 =?utf-8?B?dHVnQVVLMXhaVElmazRtRzdjZUV0RVZ6VVQyQWxOVTFzR3hSWmRRQXNZVEM0?=
 =?utf-8?B?MGxvNlNDZUllSExmZDRDeVl6cE8wZVllVDl3VFJ1MXYrT0trVnp5aERFUEw3?=
 =?utf-8?B?ZWhxUWhFc2czRUsydEdMRWRxRXUwS1loU0FWNVBTeHZCUmkvbUxhVU53NllC?=
 =?utf-8?B?cHdYa25wMzhyeXlLWWpoOHRUTGl2aU9CUkRXVGNuOGNKSnZaVXEvN0FGa2Q1?=
 =?utf-8?B?SGxjcHhjVk84UmpVamREL0RXcnZlb3pHK1AwSDdKcWdwcTFtTHZNb1ZNUE9h?=
 =?utf-8?B?RmNTcVVmQlB2czR3a2ZIMk5RM1JURnl1TitXUTZwV1Rjdk5sbzFhOHZROVYz?=
 =?utf-8?B?aXBPZ0N6RFFXVzNYci9uc2RQdTlRWkl2UW5mN1VQeStZaFRzcDFCNDJWNkJu?=
 =?utf-8?B?bG5kUmJhbHMxaWMwRnNZWk1hTDRWNnY4VWN1K3QrSWdJWldPR3d1OHFlZnow?=
 =?utf-8?B?VDRYaExLcHk1NGFDd3JmZExZTmRZajJlOVI0bkhkOG9RUEVqZHl6THBuVFVV?=
 =?utf-8?B?YzVKUStxTnNDMDdqYVVkUzRsbi83a2FlUXEwSnZIcmF3SWMvWmVqMXdaU1Bv?=
 =?utf-8?B?RjNMRU5RTGdkYkNCamNGZlRFdnlMTEQwQXJpQ0J3OHdSNjVIT1I5bXliM2ty?=
 =?utf-8?B?cDBpVStuUUp6cllmdEpYQ0lJTDlkRnJuN0dhYVRpQmtJaFJGS24yTVVGR1Q5?=
 =?utf-8?B?N2gyVyt0bzRUNVcrMHFaREFWQ090T1Y1ZmtUditRQjNGeFo0QjVvTThSL09O?=
 =?utf-8?B?OGVkbVhXcWFUVzY0SnBGWVNmSUZZQ1IrU2NuU2FqN0hCLzVIZWdBc0tWNm8v?=
 =?utf-8?B?ZFFwMVJ3aWtoNVBkcUVnbjV2MkllNzVqY1Awa2t3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e23047-6a18-46e7-48d7-08daf8a7a90d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 16:27:00.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv3rHZMeLYC+/8f1ywEUxplc/iBL9k0W6/jm6o6fyXwj1N4oxassmO4SiHXHcymOo9zAR2YcP14RnRFe51zKaAE7izidR0CELIeaNw+khOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170132
X-Proofpoint-GUID: fnHDBs40URzioc8_X0Te6pj-aMiz8LLh
X-Proofpoint-ORIG-GUID: fnHDBs40URzioc8_X0Te6pj-aMiz8LLh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> On 1/16/23 2:49 PM, Peter Foley wrote:
>>> On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wr=
ote:
>>>>
>>>> A bit tangential, but since BPF LLVM backend does not support the
>>>> stack protector (should it?) there is also an option to adjust LLVM
>>>> to avoid this instrumentation, WDYT?
>>>>
>>> That would probably be worth doing, yes.
>>> But given that won't help already released versions of clang, it
>>> should probably happen in addition to this patch.
>>
>> Peter,
>>
>> If I understand correctly (by inspecting clang code), the stack
>> protector is off by default. Do you have link to Gentoo build
>> page to show how they enable stack protector? cmake config or
>> a private patch?
>>
>> Jose,
>>
>> How gcc-bpf handle stack protector? The compiler just disables
>> stack protector for bpf target?
>
> It doesn't.  -fstack-protector is disabled by default in GCC.  When you
> use it you get something like:
>
>   $ echo 'int foo() { char s[256]; return s[3]; }' | bpf-unknown-none-gcc=
 \
>     -fstack-protector -S -o foo.s -O2 -xc -
>   $ cat foo.s
>   	.file	"<stdin>"
>   	.text
>   	.align	3
>   	.global	foo
>   	.type	foo, @function
>   foo:
>   	lddw	%r1,__stack_chk_guard
>   	ldxdw	%r0,[%r1+0]
>   	stxdw	[%fp+-8],%r0
>   	ldxb	%r0,[%fp+-261]
>   	lsh	%r0,56
>   	arsh	%r0,56
>   	ldxdw	%r2,[%fp+-8]
>   	ldxdw	%r3,[%r1+0]
>  	jne	%r2,%r3,.L4
>   	exit
>   .L4:
>   	call	__stack_chk_fail
>   	.size	foo, .-foo
>   	.ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"
>
> i.e. it pushes a stack canary and checks it upon function exit, calling
> __stack_chk_fail.
>
> If clang has -fstack-protector ON by default and you change the BPF
> backend in order to ignore the flag, I think we should do the same in
> GCC.

I went ahead and pushed the patch below to GCC master.  If
-fstack-protector is ever considered useful in the architecture, we can
always stop disabling it.

I would recommend to change the default for -fstack-protector in clang
to be off by default when targetting BPF targets, and to emit the same
or similar note to the user when the option is enabled explicitly with
-fstack-protector:

  note: =E2=80=98-fstack-protector=E2=80=99 does not work  on this architec=
ture

WDYT?

From 3b81f5c4d8e0d79cbd6927d004185707c14e54b2 Mon Sep 17 00:00:00 2001
Date: Tue, 17 Jan 2023 17:16:32 +0100
Subject: [COMMITTED] bpf: disable -fstack-protector in BPF

The stack protector is not supported in BPF.  This patch disables
-fstack-protector in bpf-* targets, along with the emission of a note
indicating that the feature is not supported in this platform.

Regtested in bpf-unknown-none.

gcc/ChangeLog:

	* config/bpf/bpf.cc (bpf_option_override): Disable
	-fstack-protector.
---
 gcc/config/bpf/bpf.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gcc/config/bpf/bpf.cc b/gcc/config/bpf/bpf.cc
index 576a1fe8eab..b268801d00c 100644
--- a/gcc/config/bpf/bpf.cc
+++ b/gcc/config/bpf/bpf.cc
@@ -253,6 +253,14 @@ bpf_option_override (void)
   if (bpf_has_jmp32 =3D=3D -1)
     bpf_has_jmp32 =3D (bpf_isa >=3D ISA_V3);
=20
+  /* Disable -fstack-protector as it is not supported in BPF.  */
+  if (flag_stack_protect)
+    {
+      inform (input_location,
+              "%<-fstack-protector%> does not work "
+              " on this architecture");
+      flag_stack_protect =3D 0;
+    }
 }
=20
 #undef TARGET_OPTION_OVERRIDE
--=20
2.30.2

