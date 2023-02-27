Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD036A4AE1
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB0Tbq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjB0Tbp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:31:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556423C46
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:31:44 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIhuh3018701;
        Mon, 27 Feb 2023 19:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NqcWnNWhIAbn3IJDoz+O3DcHz1c3gltQg64sFSHlIas=;
 b=rpZOsJ8wycC08o2p5OEbn3v7aj8nxpyvcmj1B2wBrrJDfv8JeZcpN2zuvy6aEn8bs2iC
 H50InkM9W/m/MbXkYfOLNNUGoUSH8mOM4aqwQXOUKdu+H1D+MxcV+/3YXxvUqX0XJ9v/
 fm6WwNbo1wqh17WzzTRCkYx7Xsn2an4vedpKXbiZ0nosDhmOialeeC22pe02BXKHyCQu
 mjgYr8hCepLgYrkAwBPkn/W1BYrzE5APg9UBGzQ6TgJ1WZY9l1aEvHDVjAUWciBZtl56
 tDyT/uXjohRWdxHwWVYVq3uvADPV9+lHPrJhPSuJh1ORVqTy1psy5WfBVsjzWyQMnrdD fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7cdh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:31:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RJ1wTY013137;
        Mon, 27 Feb 2023 19:31:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s5r5sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAQp26Lam1IGLXm/vDZ7MHlLITKqBPS6NrSKOCoh9vz7WN9dF93NhShXxO/yeagF48EDhymGyyhNH4PRJCjkuPOSm0bXO3DewHWwDqbVio7oHmnmtxy6O/QsuBEUo07k2gqx1SQqkvVZZitE00VD9hNPPneLY4/gR8pYmSLMW8y2bj2jlWa4laHUTlt3ukczF4nQ/hh3NlGqg8FhKO33mQuC4t96XGo714hJVE3TK+1AzrP0ZH1XDO6cNY92vPkyB0haKsI1FAPOgtbpNT+0TLxayt/ekclrue8pPZT2JuzgYqFOClE/Dav0hRztirCsbdrcFedHgdFRl3l+lhpfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqcWnNWhIAbn3IJDoz+O3DcHz1c3gltQg64sFSHlIas=;
 b=NeFu4/LOQofdI4ASZJ3glghuFZTiGs7ipap35lkAwnbYstt46G0eZ1oU4rjMmoY+hcsLMWzvru6A+Pnjv6FlpBccuUyUQIkKthr/EKp+cIti/uetQUOK3zKgZtxd1iezyKfWF+NAeceG4bG0r4pk3JLCsgt4enMvrbY6WOcEYhU0Auh8aGhPV3Nj3J0U1ShctS9b1QjhWHcNLAR1sZJVX+mE40Vl8pBn0TN7w4f6+h59VaWlKuyPq1+SQpxHpWxr2mO0vAGf+/2XVjTH9eeXDYwWtvBwLRqCSR557kE25+1dw6VlijU/JgOSFBlfLNOet0BVSRrd2nPh76vxicOkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqcWnNWhIAbn3IJDoz+O3DcHz1c3gltQg64sFSHlIas=;
 b=o9R/A8b0aso8ErC0CG3iLs2ls9oGvFS1jknckuO3hgAu3L5De+YuqHiQJi+PPtCBia4YGAQcazlz7dn/ecM3BC6l3srUlESbFKfBQwePXHbEazHUMIJJtMaYg5Botg5n8vuw5Q4AxQLsQZ8Ei9XlRnLp2zbSqMGJL2HZHcDHmcg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BL3PR10MB6114.namprd10.prod.outlook.com (2603:10b6:208:3b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Mon, 27 Feb
 2023 19:31:38 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Mon, 27 Feb 2023
 19:31:38 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org
Subject: Re: [Bpf] [PATCH V2] bpf, docs: Document BPF insn encoding in term
 of stored bytes
In-Reply-To: <Y/z9vtWfevaiRqtP@maniforge> (David Vernet's message of "Mon, 27
        Feb 2023 13:00:14 -0600")
References: <87y1oj7yvu.fsf@oracle.com> <Y/z9vtWfevaiRqtP@maniforge>
Date:   Mon, 27 Feb 2023 20:31:33 +0100
Message-ID: <87bkle9a7e.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::25) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BL3PR10MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7a9bf8-9592-43e4-4359-08db18f93ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5M9lwzl/bf7tlbTUOtwyzMcj45nn6zUm2xdEW6wTrE10wK0kAuC43akxzQZ4PSC610MkVJdxnL6YE+2e5yH9EZxjsSDZPcnNRiGV54ppPt5k3K7uvNziuAv7V60IjmwLu0ColJK0quqfl5+UAcGrRMbCj/dHYnAPgfAY7T5HKf/WkGaeoq1nPZ64HEj3FwdmGW9X4nEl7h7EpUVS4GFr3MyCSWgo/WonL6tzUWIIgMam7kcFLjCeHSrMogtAVwHuqJETHQ2GHvnhpoXCxPIx9bVm8jvyKChykWXLF8fkyyc/edKNrK5nSZ/FWBWSdYo4wYChEXJDqfQGX/gUQ2eP/9UQ6FkQPXuAXqeVBN/CKABDFrAQHWZ7+1v8QdoWeLUHrBKEDeFy6c6qY3RsCN/MJxdH5cJEPmE36lFDbtMEPN2IA9Mj84mZI1XGg3MAIxAT5dlJwcoJ7LEn2jkd7YCLP2WmUOiGTZZLlHTUNoNt/gk2GHpYMBJVKbHbCGnZ1mYW6aph6qnmQ8f2AcQuGPtlqRKer7IjQ9Egx4a07C59dXlAxr43Yn/gAmRSbwjn70vUvEr6tzdN4RXSwFNjReY7ojwe2LcyoKcHsCuqYAyNO4gfZUYnc1yD2WvdL6exFE8OX4KtHDJSEcohxIZr7ZdMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(36756003)(54906003)(316002)(83380400001)(478600001)(6666004)(6486002)(2616005)(6506007)(186003)(6512007)(26005)(8936002)(41300700001)(86362001)(2906002)(5660300002)(66946007)(66556008)(66476007)(8676002)(38100700002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5GYcJ2M+pINgQNGZ9GpSfI7K+e2k6fN+XxOw5ZChCV1GgBwKbdjF9u07i7mP?=
 =?us-ascii?Q?7gy9l27axP9HracnxgcEYwsrlTH8uQM/b6tnQK6yuYIl8sGVgULgh5pEg5lQ?=
 =?us-ascii?Q?lPY97yT5h3aJLEGr4POIkAGfpsZtU1ZzSFtNw0MP0Gakjd+Mu6PVWSiRoT1f?=
 =?us-ascii?Q?BGkwF5XKrBsswPcNRINYS03tPVVXJ/sqEp2ap3NS6kgPLxr0g25B/Ozn5Kol?=
 =?us-ascii?Q?BWOSTf8qQxjpCh1ksLR/h4QuepI1ffnSmHaEi3qTSr/xbXFkmnqProfsZaqr?=
 =?us-ascii?Q?kHWIwVN3dJn9uEBkRIZorrXysUzUKJLvrOPacfqqvOmIy+kFEKecRNqa/Iiv?=
 =?us-ascii?Q?77VHIlwE23QYQvL2IBXWoS+ezYYaqL3BwuGuKhsy8HTmFttMMsQR5mnQOfsP?=
 =?us-ascii?Q?kdE62K2i+juX6w2TEgPgwXeumFXFpF1UKHAoPJkg0HBUl9vVwtkG5Nei21Vm?=
 =?us-ascii?Q?IjIWm92sbRdu43T0kAx+zUSnwjxJ94pM68mobaNi5aCiCrDwhOslRsH3wXT1?=
 =?us-ascii?Q?yxyJXrRLoTLTvz0psKFdisfLITKwKUWaMIR5n682P2nNZD1Ur6BHDaXuDb6/?=
 =?us-ascii?Q?QmjEYcc3FvpDRnttPm7BK00ahMcgeS9VPJstaYhbolSB9SK3JOU5jieRMzoV?=
 =?us-ascii?Q?gJFZBnCoEY31fJpULZGgRHUq+EZ0tL2WdKoqd4s0WPK+7U9Irgug44cP7axL?=
 =?us-ascii?Q?FDFjT0xIdz3YFAgrW7b3ZhCH3lwpvrIPCg6XDkVrD0TOxPJUbWDPH+y6h5QS?=
 =?us-ascii?Q?X+f+js/vTMeMHx0+76Vp27fMPoIEdOsuzR+N2hNBNBq9wYU8cXUAsgdkAwXA?=
 =?us-ascii?Q?4yVT+Zot3GHmSYjmdRfJQCe6gtcSSZQ5aNc7Kc8Dzi1RkpvaAqMTZxhJGb+N?=
 =?us-ascii?Q?T0LUZK18MfsqjVth3vHpTSu52EYg8grOVl7lD8jwsjKFCSSZXx04yBdw3rLE?=
 =?us-ascii?Q?Wd8WrvU1CrqPkdlk3JrJQzN4fdfh8SCdUqCLmKHoebUscWiZjCRnJPk3gUWo?=
 =?us-ascii?Q?cl4Ol6mQpw5yjIcIfn3g3RYGhOoflNrzAF2bo74Cbw9yj1ql6z1H4PgT0pVk?=
 =?us-ascii?Q?ohOIjHCkhD9uwm8buhDW8XC8qQ1nGOaOwFL+nYwz7EIRHODO8xBNxz/w5Sgc?=
 =?us-ascii?Q?1w1e6SP2EdofCyuKq0tQTw4ej0KDjhiQqwCtESX6HEoJAL8o6WwWjOKtWObB?=
 =?us-ascii?Q?cMf2NyTvKElbSldCuPwLylQCgIRoAEWlVItMmwhYlZUP9Lz2Iv0yVc9IgBmV?=
 =?us-ascii?Q?okR8BwyIoOCTMM5KkQT09X9FyWhRrNtBLYpaSIW/bery2DimEDOkVG3fMm+t?=
 =?us-ascii?Q?tRzSCfQVNmrQveYNB3iYSMpO1keN0ivMmwjWPpzWYUv3oT/Kj9/8I4FH1P+c?=
 =?us-ascii?Q?PVO5CFz3eKfPaRHyhYnLV4KVaKhwl6E5MPZyjxT9xV3bs2/P5zUXQCrvf9zJ?=
 =?us-ascii?Q?pkfGPA4sk/+Cfz/KK9R2z/3/hGJOTB+BLH32vRokiU3u39JFk4stlJ1U5paM?=
 =?us-ascii?Q?pN391a7tjqJBk8v194pnLBTsW1DK1HV1N97dknro4NMAtOMeuR7aQeumsPKu?=
 =?us-ascii?Q?z04lGFFRTQ0AEiJXpsekPKYVg3ERRViI9OAOoxZmaaGu70cHHGGr4/TpW/o3?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I9TPdhzfGPuuajlGkPdgWK/Mef2t1N8YEeaQZoFCUHL3M7KrZvufOv8KE/Pf74sunj8Tu5DUTgwu/mS16ySKiVVeY/BBl2az/Z9hzdLLomy2lLEmWt9vTbcJ6tQ7yhJjgQFOLNQPxGbDjR/pXEVuIsglutqS4K8ftKjXTG3yWbJsZrOl3bzOz0OJrXmb6T1lXdDv56NkiuwviPc18nUtfsRnUtj8DvYuPXTjn6EPWn9mngMq+7wUJHk2cVCNOgZP+qrkL007pXyE21L5nXQWLMHqt2hjrQ9Lc3eR/9f8esBLllzfNG4AkPkYqPrLtqDSsKrnzrefesnGai0w1CkB0JBD0RBq/bdaWFHOYrgJTbofDWIpMh8ioeOtKtIACXev+D/b6iaBn/7jX8EWD141ztarkkOBBbNdkvsGn+UHFVSUJmXdtIyGwJYiZoPOmkqAiBc8j3n8uBh8yM5okGnxUtxNZ4RaAP7DqfrnykrhIC7cgTR7/gcNrpD1QaPd7ykOZ3c72ObjuMhQBPfFhu9qWJJ3+w8vELQLiW2o+hrqbXwn01KHwFCAB0lSiO2zvN9AGapNZ1XJNDEXzqOnCuZKTDpNKKd3JJ8mYT627jGmoLIe1sHkA4EuKHFbAXLOpguAjCvJKyr/Egart1cQkEEbvI2KkmGjKdTXV5sfaSx8fSqbgsJ87ba0nb55X4okcJPApzbcBKqaswaGcjAL6UZVgmsuwxMqYn+e+LdgVSqePcWawx5NXJ+V88drI5YzwkRzYPipU2xel5Od208JmmVswFKnsJ9HdiGBQw695eL4LSgmncEHV2W9yZQvnoYrXPWlXdsoWhYfB+TwUOBuh9aC0eowPJCV8anwwplWb/auGh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7a9bf8-9592-43e4-4359-08db18f93ee7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 19:31:38.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obNkyMY2mzvTer4zN1z8ucBIGso1f4Y88O+ZppW21qPSQ5BvCUSTsG3FGijIDj2Vh/sUiaN0iQBN9Iez6fGkSQG44ARd/TpUhODEpfkGV88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_16,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270154
X-Proofpoint-ORIG-GUID: KHaNptxZh5rlgVvaakNn81tEjOgL6mcz
X-Proofpoint-GUID: KHaNptxZh5rlgVvaakNn81tEjOgL6mcz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mon, Feb 27, 2023 at 07:21:25PM +0100, Jose E. Marchesi wrote:
>> 
>> [Differences from V1:
>> - Use rst literal blocks for figures.
>> - Avoid using | in the basic instruction/pseudo instruction figure.
>> - Rebased to today's bpf-next master branch.]
>> 
>> This patch modifies instruction-set.rst so it documents the encoding
>> of BPF instructions in terms of how the bytes are stored (be it in an
>> ELF file or as bytes in a memory buffer to be loaded into the kernel
>> or some other BPF consumer) as opposed to how the instruction looks
>> like once loaded.
>> 
>> This is hopefully easier to understand by implementors looking to
>> generate and/or consume bytes conforming BPF instructions.
>> 
>> The patch also clarifies that the unused bytes in a pseudo-instruction
>> shall be cleared with zeros.
>> 
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>
> Thanks Jose, this looks a lot better. Just left a couple more small
> suggestions + questions below before stamping.
>
>> 
>> ---
>>  Documentation/bpf/instruction-set.rst | 44 +++++++++++++--------------
>>  1 file changed, 22 insertions(+), 22 deletions(-)
>> 
>> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
>> index 01802ed9b29b..3341bfe20e4d 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -38,15 +38,13 @@ eBPF has two instruction encodings:
>>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>>    constant) value after the basic instruction for a total of 128 bits.
>>  
>> -The basic instruction encoding looks as follows for a little-endian processor,
>> -where MSB and LSB mean the most significant bits and least significant bits,
>> -respectively:
>> +The fields conforming an encoded basic instruction are stored in the
>> +following order::
>>  
>> -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   src_reg  dst_reg  opcode
>> -=============  =======  =======  =======  ============
>> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
>> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
>
> The terms below use src_reg and dst_reg. Can we either update these code
> blocks to match, or change the term definitions to "src" and "dst"? I'd
> vote for the latter, given that we explain that it's the source /
> destination register number where they're defined.

Will change.

>> +
>> +Where,
>
> IMO, we can probably remove this "Where,". I think it's pretty clear
> that the following terms are referring to the code block above. Wdyt?

I added the "Where," to make the reading a little bit more fluid, but I
don't have a strong opinion on that.

>
>>  
>>  **imm**
>>    signed integer immediate value
>> @@ -64,16 +62,17 @@ imm            offset   src_reg  dst_reg  opcode
>>  **opcode**
>>    operation to perform
>>  
>> -and as follows for a big-endian processor:
>> +Note that the contents of multi-byte fields ('imm' and 'offset') are
>> +stored using big-endian byte ordering in big-endian BPF and
>> +little-endian byte ordering in little-endian BPF.
>>  
>> -=============  =======  =======  =======  ============
>> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> -=============  =======  =======  =======  ============
>> -imm            offset   dst_reg  src_reg  opcode
>> -=============  =======  =======  =======  ============
>> +For example::
>>  
>> -Multi-byte fields ('imm' and 'offset') are similarly stored in
>> -the byte order of the processor.
>> +  opcode         offset imm          assembly
>> +         src dst
>> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
>> +         dst src
>> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
>>  
>>  Note that most instructions do not use all of the fields.
>>  Unused fields shall be cleared to zero.
>> @@ -84,18 +83,19 @@ The 64 bits following the basic instruction contain a pseudo instruction
>>  using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
>>  and imm containing the high 32 bits of the immediate value.
>>  
>> -=================  ==================
>> -64 bits (MSB)      64 bits (LSB)
>> -=================  ==================
>> -basic instruction  pseudo instruction
>> -=================  ==================
>> +This is depicted in the following figure::
>> +
>> +  basic_instruction               pseudo instruction
>> +  ------------------------------- ------------------
>> +  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
>
> Don't want to bikeshed too much, but this seems a bit hard to read.  It
> kind of all looks like one line, though perhaps that was the intention.
> Wdyt about this?
>
> This is depicted in the following figure::
>
>   code:8 regs:16 offset:16 imm:32  // MSB: basic instruction
>   reserved:32              imm:32  // LSB: pseudo instruction

Hmm, yes, that was the intention, to depict the fact that a 128-bit
instruction is composed by the sequence of a basic instruction followed
by a pseudo instruction...

This would be the bombastic ASCII-art version of what I had in mind :)

         basic_instruction        
   .-----------------------------.
   |                             |
   code:8 regs:16 offset:16 imm:32 unused:32 imm:32
                                   |              |
                                   '--------------'
                                  pseudo instruction

I don't think MSB and LSB marks are meaningful in this context.  Bytes
in a file or in memory are no more or less significative: they just have
addresses (or file offsets) which can be lower or higher than the
addresses (or file offsets) of other bytes.

>>  
>>  Thus the 64-bit immediate value is constructed as follows:
>>  
>>    imm64 = (next_imm << 32) | imm
>>  
>>  where 'next_imm' refers to the imm value of the pseudo instruction
>> -following the basic instruction.
>> +following the basic instruction.  The unused bytes in the pseudo
>> +instruction shall be cleared to zero.
>
> Also apologies if this is also a bikeshed and has already been
> discussed, but should we say, "The unused bits in the pseudo instruction
> are reserved" rather than saying they should be cleared to zero?
> Implemenations should interpret "reserved" to mean that the bits should
> be zeroed, no? Or at least that seems like the norm in technical
> manuals.  For example, reserved bits in control registers on x86 should
> be cleared to avoid unexpected side effects if and when those bits are
> eventually actually used for something in future releases.

That is a good point.

I agree that "reserved" almost always means zero, but I think it is very
common to say so explicitly.  A couple of examples:

Example 1, from the x86 MBR spec:

   *  Offset  Size (bytes)  Description
   *
   *  0x000   440           MBR Bootstrap (flat binary executable code)
   *  0x1B8   4             Optional "Unique Disk ID / Signature"
   *  0x1BC   2             Optional, reserved 0x0000
   *  0x1BE   16            First partition table entry
   *  0x1CE   16            Second partition table entry
   *  0x1DE   16            Third partition table entry
   *  0x1EE   16            Fourth partition table entry
   *  0x1FE   2             (0x55, 0xAA) "Valid bootsector" signature bytes

Example 2, this is how the PE Object File specification defines a
reserved field:

   reserved,         A description of a field that indicates that the value
   must be 0         of the field must be zero for generators and consumers
                     must ignore the field.

What about this: "The unused bits in the pseudo instruction are reserved
and shall be cleared to zero."
