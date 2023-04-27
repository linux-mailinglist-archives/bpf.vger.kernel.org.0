Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4D6F0401
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbjD0KOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbjD0KOT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 06:14:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7CA0
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 03:14:18 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R6I0V7003320;
        Thu, 27 Apr 2023 10:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kE5qQDUpHkBThxv2SBQKxhmvmEupQyErwx+udnU994w=;
 b=UjmRCvOdRRjNHI6gMyeXbIfb1aB7D1TiExHKkm9q+KGfuAaCMG4sbg7OMPdAPqn5ldKr
 Wr9KB1F7kaw8Si5PG/38X9Hy1Hdqn388D1SmxvvLhI1a9KNJOiWVw9Da3YRl488EhI0Y
 rSEz5Z+5ywumzMtyaeTZS644nfnlmVikshN+wg5CAoKdsWoohuFKLVtNmvniQOOgsCMu
 yR7aFf7uVpV64ybduPIcnt567SKwgocRWFUePFJDVUTU1KLKl7AUEOQEl/xhzZQnQGxu
 /5/ExS53dDr+zUImkO5zxxgEJic3wXsz/ZBnABODIMVAn4GLpITgckMZCWY7Dwuso6m2 TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbumue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 10:14:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33R9X1BM008690;
        Thu, 27 Apr 2023 10:14:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4619c2ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 10:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVZljqfpzJ5ZuARAS0k0HFiureC9o+QBIg6StLji9s/TZWOvi7f99a9gFrq+8V2hMlXBZnQQXo/l8XocP2eWdnNYs1/7vmIv4eNYg+6EEyOg935M3xTK2Fbs32CayR00yF8e4rlHSRvm8zpV/mPM7RT68TEXnlGgHIs14xaQkb7MBlv3NK9SosfIRFjj6jwcYjjpCejWeevQt82IbY56G40dyHX45FzGwUzgTQ2fnXRmdrR2VlM127L9OxBI+ygMuFVwA/Q8Upj/9HqTDk+ax4ceoOMBH6fSdqVBC7gTUTUSaV8jenLguqepRghIlUlt3k5zQeuqnxiIGV+riu/X8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kE5qQDUpHkBThxv2SBQKxhmvmEupQyErwx+udnU994w=;
 b=jIkJ0wPMzwjiNVYNRpEHlJZCN4qQd0KLGRRdj5QyihbrjFObj42RImb5E634d7usthQhHWbIWbuhGjIyj9n4xDJ9RM6ehW6IQn76cypBhxuizrfyO7dg55sYtqjmH+CZFFOnrlgg7mJQKK07Dk3JJnge4MCYsIEEnUBVP8u7stSO83quh7g3nqY9+u44MVQ79Og+F93/nGALSr+GxnALTRosAB2qMqtd7D1FA7rSi1ySZV0vVRvsGkKyR9NYzJnZVIwrRdEVgOOBka74+oA+VRMXyZiZnduIHsh93I3y5Gq2BAodqkhfJA+qUC4ZrxVT4YGKqnNPTqM0CmkmVZ2AMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kE5qQDUpHkBThxv2SBQKxhmvmEupQyErwx+udnU994w=;
 b=h1oEFB0FZMWAahZrgxP+AgiXuJh2F0htDj7iVrtEdXnn/Isxysz2j9w6lS0sLMokk9KNORU/CrIJ8rcf7aoRXUagwfb22NboS8PCoVVfrTzZxtDCWJK4EWG1JKWJczfwmxJuVjFmYsMzKrC5lAwQxLedRSyiI67c/Jdve8eA6LI=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 10:14:12 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 10:14:12 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eddy Z <eddyz87@gmail.com>, Yonghong Song <yhs@meta.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        gmartinezq07@gmail.com
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
In-Reply-To: <CAADnVQ+MNbWCWD14xf50nK-CsAdzQqsnY3x4uSuxO=pNDdmZXA@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 26 Apr 2023 13:05:32 -0700")
References: <878reeilxk.fsf@oracle.com>
        <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com>
        <87zg6ufnrr.fsf@oracle.com>
        <CAADnVQ+MNbWCWD14xf50nK-CsAdzQqsnY3x4uSuxO=pNDdmZXA@mail.gmail.com>
Date:   Thu, 27 Apr 2023 12:14:06 +0200
Message-ID: <87o7n98wep.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:208:55::14) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: c19d0a2c-8989-4972-0691-08db470825cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA/YtkN5sxPJBduSAfGyg30XOdPBrFhLNcaVz45teDsuq0PkrEIu8L6l7k/8/KTXFz3ZhTMs6sh6mUuCN/u6b8lJRmz7aQl9oDX/k+cOZUmsyTRzwunUj2VuW/nTTLLXLVKLfBZVqj134zO3aTsXOZxysxM8QvIT5u6egxROZ1czFMWygPuDmClL5q3KylBg5BtrR5vPgyiJOOojuxTEmK/MlSeYqMdrIk9vX029v2FbrFYxJuRdu9hsd3v7DzyL11yNlaX6ZgAqXD3EIYaBYn+k4/Ue4khk9v5RIW/w5pmp+I46se0YChiR5SBxrldhVjrfkWqRFbTEXZL+E1JQEXUurC8evdH36Ja3t3+9QmleJb1pW6twLrExnMCsfHOo9ixy793f91+TENeBGn1x12gdkQFDtDn6ZpYay7kDlmeXwJha4SYlmecmad0GNTPJZeAVxXtGtzj1OKV3f+k901kKGeipSJYGCENAJJyBebJ4PyVHnUs9CmDQseipXKyRkckopbVebM+FmSeOMIGUu8cYINwAHqsz0yvx32Gu/LY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(66899021)(4326008)(66476007)(66556008)(316002)(6916009)(66946007)(54906003)(6486002)(966005)(6666004)(86362001)(478600001)(36756003)(186003)(6512007)(53546011)(6506007)(41300700001)(38100700002)(2616005)(2906002)(26005)(5660300002)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJHbERxZUNtSzdDU0tJQml0K0I1ckRFbGhiT3MrbkFqQlM0MnZwMG5NTFox?=
 =?utf-8?B?VDJ4RXovYUVNbVdrb1VnOUcxVFp0M0ZScGlTODUxelhiZkliOThyam1iSWtV?=
 =?utf-8?B?SCtFRGpFbndKSzhrcHVWa1dlcmtWd3pkNGFoMjN5amxjWEJLdzBxd1pBdkNU?=
 =?utf-8?B?ZXdTaWdsYldMb3JRM2JzK0p6S0R3V2EyeFpGUEFhOHhHdHpJcXNOUnM2dlE4?=
 =?utf-8?B?Wit5ZGtDRFFXUlpqZHdZdWp6QythbW9vR0FZZ2RwQ2FmeEkvcWlJMHZDR0k5?=
 =?utf-8?B?TEwxQ3hzL2cvYm13MFM4Zk5Fa0tUMy9aKzlVTGhVT0t5eEd6VXVrcXBwNG9z?=
 =?utf-8?B?Q3FmYmNVanMxZUhmMmRyd2dSc0dBaDczUE85QWY0MWpQZ1BZMDJNaDlDczYy?=
 =?utf-8?B?QXgzeGlmcjRaemFORWRqU09oT3FMWUgwa3VtWGFmR1JtNzZtOE5tMlRNNnVy?=
 =?utf-8?B?YUNIS1JBOE5IdlF5aU5pM083UUVqa1FnMXk0VmxlYTZleFhUa0tqVDl2Tmth?=
 =?utf-8?B?a2lyeDFBb29NTllGcXZOWTJuUmdBbTdtaXFTcXJmaFc3cDZuKzhHc0pSQ2dU?=
 =?utf-8?B?VG9iSS9zVXRuSXJTeElqczNvZzZTUGhtSXRVb3FaK1Q2bkdvV2kxZkNqT2F5?=
 =?utf-8?B?YzlpUTBBeEZJNVZ2VG9xYlA1NlRCdkQzaUx0RUNvbG9uTkR2bE1HeEwrSFB1?=
 =?utf-8?B?Z1JqREMrN3lqdUNZZXFjVFpscDJ3cXhqbFpKV2t2b1ZiaTZuOFpjQXluSm1N?=
 =?utf-8?B?U0hXbFpJZTRrL1BXOVRkTGNiM012R2dSaDJlR0pST1dneG05N0VmQW90RGlt?=
 =?utf-8?B?RUlEREtYdkUrTDJqWDN4dnNnYXR5clhHOFBEdUN0bnhLcWIwN1hRQmYxaTht?=
 =?utf-8?B?aEJDV0k2ZnhPZ0JSY1E4U0c2RkNwY1Q2K2Z3Y05NNmVzS2RpR2RqZERscUVs?=
 =?utf-8?B?d1NIUzR0bk1naHVNSEUxaFRRZEZrVFBkN3dXby9qYlZ3YkRCaXkxK3BMb0pL?=
 =?utf-8?B?NUZIOUsvbXpLbU5qTk9MTjloS2NabVpyY0RzaTJHR282ZVNjL1lLR2hkejRw?=
 =?utf-8?B?U1lxRFVhbCtMNVJaYVFtWERlZitsVkhFMzRiZzFLK0xuRVd2NWFTQjkrbmQ2?=
 =?utf-8?B?NDNuS0Jsb2h5ZlF3UW1PdjBjV21hTUxTamxCMEwxUTlFdkV6OUdpbFBlZjNm?=
 =?utf-8?B?M25CT1ppUTdnRnZkNUhUMCtFS3lpaTFmakJnQlZoMUNoTFJUV2ltd2Q0Mkg2?=
 =?utf-8?B?eWt6RHV2eUxtdHhtYXAxM1V2WDVaU1RCSU1JZTdVcFo0UDJKWkJQQi9nS2RB?=
 =?utf-8?B?ODF5QmI1YWZqMDdoQnVUS0dBMkZ5K01IaEVodFlCdkhvaVRFZFlwVnliamJD?=
 =?utf-8?B?V1hCMVNQVkora09vbTdxdHVESlEwaGVQQ2NFc3cwU3FkTE5hNnprR2VoMWxB?=
 =?utf-8?B?UEtWZzZ2NllqUE02NXd6ZDBmaWVkdlVXdjNMc1g0cWdNdGFtSkNjdDQwcDVT?=
 =?utf-8?B?ay9kaEdBQWRkQzVaK3lSSkM2UEYyWmZidzZ1Y3FjWXRjQk1zZGFSblpjZ0h5?=
 =?utf-8?B?eFFaVG10UXhQcnluMmFOVlJ1SHYwNzZOZ292b3hoaWpOdnJDaENsSXpGM3pI?=
 =?utf-8?B?TjJvbldYUmFJbkMvNUxFT0d0aVhabUU4dnFXQ0U1OUFud0ZlMVF3UmRFNmdM?=
 =?utf-8?B?L05DRXI3dE9PcjE3ZFE3RXBscUtqKzUzYlNWSmNZNnhRRjVtWUEvOFNnMWIr?=
 =?utf-8?B?Qk4vc05BR0RYVWR2R3UrSTY3ZzVkWDdTWUt3QU5Udjk2clorQjdLZGZWUU9Q?=
 =?utf-8?B?TExKd0pydmE2b2xjbEFHbnlYWjE3dEpMc1ZpZjlqNW1VbHVPdEVmc1F3MGVw?=
 =?utf-8?B?LytpTjI0YWdXSlc5YTVhQUQvSjdXSFJWWmdySndUNXE1OVdnT1FGWnZ0V2Nt?=
 =?utf-8?B?UmgzK2dEQWtlT25WYll2VUQxMC9lZ1dyTlp2dHZOSlVUYVBycTNnTmlMWkJr?=
 =?utf-8?B?TXNaejNqcndTaWd3dXdpNzdYa05OckJTcnh6S3ZsVWZYWkhyNlVoaGc0bzN6?=
 =?utf-8?B?MnV0dmNKejBuYlplRGdkSjhzdzNSVDBFWnVnS2tRc1lvb0tpOExZQmtENEU3?=
 =?utf-8?B?NUhFZlpja1hUZVVYeXp0RjVsZUhtOXRha0NzamR4VnhDcDE0amQzWk5RM0M2?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lmCH3O2S4keuUGsYWfC1Ni0TenNr48WM2DVgKmjuR11YzMen/PiVzTjDj8TXPIvCdK/RlJncgLAMxrkHYmarCQWTCRsmBurhlil2c9ixxRqZwLqq7qH5C4UkN/NtTLIrQ5EFCIsEi1nYJS7kun7K/6eTL5joauZAiS66RQ+OUlXtJim+NRl2LvPa87qqxTD0gZYjFoGBnhKR3SWsc367E+jgpPGq+IqywAh5m2eVRH3UOfI1KDxA2niqgc/Lbc32K8P2aggxx86HC2yYlO9oXit5K1BRBLz2veiSV31P8I9UZcBBGiB8xVrRF2xTak+5Eg+anXdkt4IlQ+L8x0GQo0TfI9eZ0eTteCUwc7NT1CUb6Ie6iLh9sK0/8j56Cyjlpeh5HKj7e5B3rQ/dcmatiJjUEfli8+F625Xyc5hdCV//K6g4M078XJzYIdnU8gpZAXzjzj79xTjvW/SnlOP0ZSunlT4Er/hfgzWxGPxJ4pS1DSYv/AjoJodaYYppe7BqDJ23tPsqdo4YVJXwGAk9/1qw6WiUE2Jq9hsH1d3Us5OYBkTGYTYlHf3YGl/S92MLWEhha1IM7UJG0q/rIIReGF4dQY2GaiR7c+11HjLzkgUklEzqQveraf/fEjmaucHmu81Tki5hwRVMpItYb/M2VkkragG4UUe02Bwfd/X7Y0wbqXDcGbDjc7cQ35BTScATTFFLsWty7wOX8PZaEMTpxvPVeww8ClsEWokDd08jmfPIa1QWHf78XRkMCjVRPM1U6VaA3ubQqdNaUHirn2oXrQKmoZ+R/9eJvIUIzzaZTxm0jpOcDMbkO9/z+FCsjTow
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19d0a2c-8989-4972-0691-08db470825cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 10:14:12.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2stQg3YvPGuEjNKiZw6Vh/AKL/CqgTqz3qkS5ZjbeYxQuUx7k5ZP8cKgW/5YfPrUYi8Y5R0pf4tfGsAJCWEZyH9saUL6DmWY+vdgw8pcCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270089
X-Proofpoint-GUID: xldg2Cs0WpphjyQdQzkkLGyvO2s8GCAW
X-Proofpoint-ORIG-GUID: xldg2Cs0WpphjyQdQzkkLGyvO2s8GCAW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Odd.  I replied to this yesterday, but somehow it wasn't sent.

> On Wed, Apr 26, 2023 at 12:35=E2=80=AFPM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
>> >> Just a heads up, we just committed support for the assembly syntax
>> >> used
>> >> by clang to the GNU assembler [1].
>> >
>> > Thanks! Do you which gcc release is expected to contain these changes?
>>
>> This is the assembler, i.e. binutils.
>> We don't need to update the compiler.
>>
>> >> Salud!
>> >> [1] https://sourceware.org/pipermail/binutils/2023-April/127222.html
>
> This is awesome!
> We recently converted tens of thousands of lines of bpf asm from macros
> to inline asm in C.
> See tools/testing/selftests/bpf/progs/verifier_*.c
> I wonder how gas-bpf can deal with that.

Inline assembly shall work.

> We had to fix several inline asm issues in clang to get to this point
> and probably more to come.

We will give these tests a try and fix problems as we find them :)

We actually came with some ambiguities, undefined stuff, and other
issues with the syntax while doing the implementation.  We hope to
discuss some of that during the LSF/MM/BPF next week, so we can
consolidate the language in both toolchains.

Speaking of which, we are preparing the material for the "compiled BPF"
activity during LSF/MM/BPF.  I think the BPF track hasn't been scheduled
yet, but how much time will we have to discuss about the topic?
