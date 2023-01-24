Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261E367A6BE
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjAXXPZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 18:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAXXPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 18:15:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226BF11162
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 15:15:22 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OKx6oi024855;
        Tue, 24 Jan 2023 23:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bPiCbOAhJvHoifM0qRWWblfMABb8rVPKuCKRH2YK+Us=;
 b=W23K8lYrtIEd6JyhLysW4M1K4+5yF91ggbsXfB/oyvLtdnrev/Jf4Q3h7PD0aRyA0Zsx
 cvuZZChZurAiUSMmYQZ8b2EcejV21DM22CRqbxPxp+FaLUT9bIMHIfuN/EEc51Gu8fWz
 fL/U8SyzOB+7TbepLda99QbnkwvJNJA/QktVZl685vFnOP4Sy09HG4qByJmelwHOimy2
 ND2624vjHJAmqGkteLDH5iEGi6WAIb+ZetomgNEQlX5Xsg7bA/VR9WUsFjP1GU2VpNo7
 xt/JbBn/eb4FvyHPWQiJ5gTYus2Lbj4OF8A3nBocPKIQLt9AYPOQcqGMe89Ez6/QFYKa Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0xsg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 23:15:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OMQ7Qc030414;
        Tue, 24 Jan 2023 23:15:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g5ymnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 23:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l52PUmr1ZVmAHxodhJ2dAA0vXiSV+RDKLqVtktLiuJZPLR7/saEkpsuJCAy8j5WEqUAqEqMdyioF6YtJ3Uu2stuEo8BI/5YzGvjzkfqDz3bnJ6sH6nZg92oZPAFcVIU5/OZLYDMfH5V3E4fBtKEvH288y/8IypIA7Shdm3O6i91Nt2kpZ4SIwxSpqSeZArgYEZI+rEAq5qCwqlfLgB3VcaVKNod5MQoTUVerOz3om77VMdUbqDAlNmccHozrJz/XcBEWiixe+IW4ITxWqnVbarkSSlLaGumfngugV7VIR3za17ISWgfAHnVvTcgyWcjDLRUfo8RA+15RY73HPZkE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPiCbOAhJvHoifM0qRWWblfMABb8rVPKuCKRH2YK+Us=;
 b=BeqYnpx4OmZrWyjCnuERNKUxe4XziUDpcXXTTnExlYTEUUNXd92rOTX63RFovbohmlGFMy5n2mOv3gaC2hUfoy0sJZRQA8UIvGEN3eEKAUjkPjxGBXYkRC76kiXFErIMs1sYoRCMHG3VtDbynYFpVVqrjFYT5utODNSjIJnhWIycwceeo8DEMwFs6CKpQzebil478MuDfmvdH7FYhHF22thXU3NJTmXKjwQxvYAqeemwDG00UDRlIgc1TRdmQrMTXcB9VyOo2WVP6Kxh0zeM4Ktl4tzhSEtls/8/4tbiUXKOpKGM9RKsC6pAfCt+u1yLP0bmGaO2DKWbUjDEne1+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPiCbOAhJvHoifM0qRWWblfMABb8rVPKuCKRH2YK+Us=;
 b=O845X1YZcyONcE8F70dGCPaGxqkQyJ9LRv/b7d1IUxbsvTP70bf+lTaDKaHlyhdVGwrqUmQItzmnbgPLO57D47CHBkgPi3NgM121mBTp73od/j/grkYquB/PN7fosWM6VokMbI07INtb1Ib0yAadt1qxi8icPHOAitxYUVAElLI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 23:15:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 23:15:16 +0000
Subject: Re: Is fentry/fexit support possible with an external BTF?
To:     Kui-Feng Lee <sinquersw@gmail.com>,
        Jason Ling <jasonling@google.com>, bpf@vger.kernel.org
References: <CAHBbfcUkr6fTm2X9GNsFNqV75fTG=aBQXFx_8Ayk+4hk7heB-g@mail.gmail.com>
 <296fcfac-9acd-9462-871c-b450fd140fa3@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <7f2372c1-73c9-cd8a-c0e8-30d3fef8c23e@oracle.com>
Date:   Tue, 24 Jan 2023 23:15:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <296fcfac-9acd-9462-871c-b450fd140fa3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca80ff7-de7b-4ba7-1ac7-08dafe60da68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jiqwqahl/rwmGBWAqTnwEqmQYoJRis8CbLvGbw6rPYxqLWNC1ftL4TkACdVBbX0ejNR02ACQm3hBz7UG1LMeCqPN/qf2sD07xhICu/9q9DzE/0vEIfoCqcKFnGwJRUuJWRETRMCBVzeC8qqgE7YwBjhpjp7bQeDJMwrH484KEXDs0SAr+SjscF6ZwTjN2EDz9FOWp1L7cd9/rsDHK7WCTOeaGRKREBcsH+TQkfO+KtZ8fxO2ri4fZt06IOXoWP0+mT/sV2/l9p7FdwOfuOf8FIcd1/Ljx7HrSwM/IBBbVDzdYLvAsdKQljX54ff7bAhAx78W4EHtjo1+IumLoA5C+B6IR0G4P+T8Bbnit0EyHxeVwyMiYKjHnibcJJPB85OROT5CmY6i5tq2lc6jDqmDlkyl/FYHWGduzu1VTnYXaH7mIV4dMsOzRpx8pMUIathrq+JHuLMMERlbpiiRNE6ThZsF4Lj2owwqb0I1FUGCh8n2HJQkCbWiz/Ulw0devIEqoi2BiT14KzwrQS7WWoPrVS22icKv0uilQmXOFkwPt05sHRsRR2TQtIBJj0hOl7/W725mWjMNTrymWWP3+NYQpoNrrZtw2CrO4642MMWYxjvCYAIme3Zmd2nehyyrPaEPjsnLtQSdhebPoVsOVqkTSAfLaSp1AdLToSk/P5cONtZM+yvCXFzcrLaGX76IVTWYTzR32gc2AJRBoqle6cgb3yn7YdIqAsrPpx3kn8TRQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199018)(8936002)(44832011)(5660300002)(66946007)(478600001)(38100700002)(31696002)(86362001)(41300700001)(8676002)(66476007)(316002)(31686004)(2906002)(110136005)(36756003)(6666004)(186003)(6506007)(2616005)(53546011)(66556008)(6486002)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWk4QkJucXlPdDdOQ0gxUVhPK2IzL2R6cWNraVh5VDRNOFhwaFlORFhSd1Fz?=
 =?utf-8?B?OGR1dWo0ZGZWV2xQRG1reXBvaEtHM0NnbWNnUlZkNWlsUTFacmhBVDVBK2w4?=
 =?utf-8?B?MTkzVjBnNnJWVHBpUXVxRUVQcG9rUEVmMFJNaG9tWmNvdktWUVg3bVRqZjVY?=
 =?utf-8?B?cmdET0tqQ3hNMGJJSEtJc1NlSVg3V0xKdVJmRHhsYWNZWU1uZFI5aWVYcHNL?=
 =?utf-8?B?THVwTXYycGIyZk5RcXBOejhjN2Rpc0hYVUZ5dk5rc3Vvck1sSlUvWjJEcm4r?=
 =?utf-8?B?a2M1OEg3dnM2c2cxYUIzZmxXa3pKY0ptTlg0ZFhoUWtYeEltcUdBd2U3TGph?=
 =?utf-8?B?bVl1TVpuUmpIb2xrcVFpbjIxNFlacm9nRHhnTXFaWFBTb25hUk5lYUY3MkFX?=
 =?utf-8?B?RnZMWGtNcVNTcjNzYVlzSjd2QkJJWmxBM3JaZ0FZYjdEVkVWTU9ydGFQUGpj?=
 =?utf-8?B?VDJPVVNRWWFiUmFmVUxodVdhMW81bEJnR0JRdzZYckpJRnRDNDE0TjFZdDlF?=
 =?utf-8?B?bUJTL2pHNFlveFg1SytacXJIK2pmejZJTXRrZTc1amRKaFhEUXZVTEttNmRC?=
 =?utf-8?B?ckcwTmErcW0rTm9WWlluQkRFQk93MmF3YXJFSXlOZisyem9HUkpTNHdkWnRx?=
 =?utf-8?B?VHJ5cE5LTkJTbmVVRkJHVWo3eS80MGVzbmtLUzJWMVVSazhQa2YxTFVRZ3kv?=
 =?utf-8?B?RUZiSXpsSTNRdUh4UVlzaXo5OWtyVXRPSFJQY1VDOFcxUmdsV0ZiN3NmTU5y?=
 =?utf-8?B?bmtnWHZqUEtDVml2RFBSK0tDNzRjNzBKQmxMaU55NWhMOCtqWmFhTmNLTFpz?=
 =?utf-8?B?TUxyZHNpeklJZ1dXZnlLYy9EMGU5M2hScXRRazZ1NkR2akFpd1g2a3FXSEhS?=
 =?utf-8?B?dmxjQW1sQlg5UDRqbThwdVRDN3dTR2FrWVVIa1AyYnVEV04rWFNqdHEydWZs?=
 =?utf-8?B?MXZCWHBIbzBDQnZaVjF1aUcxQXpzTHpQdzdUMVFlNVhQc2JqTVdKM09aNXNN?=
 =?utf-8?B?MUwyTHdzWmVtK0RnVXQrTHBsYTVjODlxRVo4ZFp1WHI0U1BYcnI4VzM5cXVh?=
 =?utf-8?B?eVliNnlkMWlseWdjYmJwbndlaTA5RWE5L2Q5OURXL3BkZVd2RnpyYnd1cXdj?=
 =?utf-8?B?Y0NaTlZuL1c1U0Vka28yZXdkeWFKVzg3Ty83RktqZGEwWEcyS1JSNnp5cFd0?=
 =?utf-8?B?aG9vOThhNmZrQ0svR1pwUlBRU0JiajQ4UGpLbGhMNkdLbE9mbU5ocVlVVisw?=
 =?utf-8?B?MEZtWW9hTHgwL3V1SlNyK3dNZWZ5ZGdhQnBtSkxsczBlYnUyaUIyZmp6VEgz?=
 =?utf-8?B?OHZDVkV0OGtPNTEvaGZFSW9YamdsT0J3cjZBWEE0Wm11emJyN3p2NnhsOURG?=
 =?utf-8?B?eXdnUDRraEh3VG9DOTV1S2lxUENtSjgrNnNianpjWkdtWGlQSDhsMjFQY2du?=
 =?utf-8?B?R2FZT2NyRGZhRkJtYVltNnQvMXRUMmR1NGxJQ29VS01zMDMrSnFqZ1FNd1RR?=
 =?utf-8?B?T0xZOFdsQ0NMV1g5bVEzRUlpdVRvQzZRaGxCUEtqT2RjRmN3SGN0VkozZ0FP?=
 =?utf-8?B?MG5rR0hWTTNmL0I4anZNNUJtbkk0djBMcmwyNEl5L2lkeDBBWnFNWlZPK0Za?=
 =?utf-8?B?L00xbkg0RXlMNVBaOFh2UkthYXUxZWdRMWVKM3pDbFJFSjVkQnFEcHhMNmJ3?=
 =?utf-8?B?clYyVEx2UFFTMVFOYTlwL3QyczNDN2MzSmV3eVd5a3BCalRYSmlQNkZRTDFv?=
 =?utf-8?B?ZElxbWk5UHNKcU9USDFLQTJBYjRGcWRsVjQ2eklsRzE3Y2w5RzhtZDN5UC9X?=
 =?utf-8?B?aVRpVXdYWnYrTC9IbGVFY3BxWjBKd0dxR0VyNk1NemNnUnlWM2lrcFVDWVB4?=
 =?utf-8?B?MVFJTEtuZll3ZWxJWmE5YitPOXJvUlZ1dm5iRTZIakhKeXVIRGNDR0hVb3l1?=
 =?utf-8?B?RStaaWxJYmpBTTd6Rnh5OEdaYlN2QUhaeGhZenBlcWY0S0Y1VWJUclBia29G?=
 =?utf-8?B?R1pnUk5JcS9TRVRwZjdtd21NcjBuUUczSWNNTjA4QkRWbEc5aEtDTjlwSFEr?=
 =?utf-8?B?UUVHUTkwQ0p2d2d2Qm96UmltdFpKcUE4bm1WYUE5WmxIOXVkVnJpOWM3aEYx?=
 =?utf-8?B?WUF2UE1LOXVwaXUwWFB4aWRsUFFtTTk3MHNkU0JZeGhGVm9aTWI2N0p4T0FY?=
 =?utf-8?Q?wDaR4rPgAcS97u9CBGMjY/A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R3G2q8vz0q3R4oYE2d4NJr7e/4TdGovGGXKfQmJNH2loS69SL/FMcFrsb0DtedALPaHOsNGt0KT2LkLXqiyYi/NoC4Eb+vWCiOKdLHrqlcua38KWqk6VYWs4S8N3HCPxcPQbtOmDi2bAU8yfLElrZmMMpnzKGfBvtExXPt3G0IKwBGXaecV0YliG3tx8e/aQDXWkEFmlgfdoXdsXV9MzYxgkNTMwaQ/oxBSxOMMBTRHY1lrtLEEGAcNEO4el8ElHzY/4dhgYoD9kMprFP0IcZP+FH20/qeTUKvETLaPVAA7lQMPkkMEZwuKVlPLcXgQ6ak1iBDbPu8hvPyfR+TM9FgHysYQ7uJy5LdUgheLQAyv5/SfQiWLj4M3lpe69ed8nLiCPFdWCABolIx5C9VL+Qe4ETipgOuFSsL3fD+bIjusOqp5lkdHr+9jx7SpTwfQSXbWnYm37NVP6zwRZcR8UkCevdTCYtXeOIZwWn427Imy+Cf0kwnq8/PMTzBkpYXZFnac6mMJEJf1PN9notisvL5SLMrHoy1zrOCXoGiyd+lzhzT1zyrfXbsEhf/Khgk9yDBn4nFr34eWv69OOKCyx1Qo8HECv315n2RT8LFBVM+3waIDKnsvk4oPhDM8LH+7zsuGF/Adxw5BUsY8fsCAB2bL5AnxgfUcfMKO5XN2dTm5VFgLnklvwowvb24SFVtMdAl+1KmEeRRAiWo9nRLvcj6mXKGBg6vvZBDLGXP0zqREeGhu9rkY+qu/MMxxvbUfDoVTc9eTg6OzMcerIKcLUAHSKNKgCWk5q5u7BLD9DyQcEjw6jg95YQG7tNE7+4boy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca80ff7-de7b-4ba7-1ac7-08dafe60da68
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 23:15:16.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmvtXOsmi3Yffqii+Qq/Fws9Q+VKqAMdpEFrhJxeQGPnIM66p/wT6Xs0t0lXiA0NwFX5O7u1sRfhP8u1L6/erQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_17,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240214
X-Proofpoint-GUID: E2kiWOPmxrtojft0Jv6vMNd9dKnNgZCk
X-Proofpoint-ORIG-GUID: E2kiWOPmxrtojft0Jv6vMNd9dKnNgZCk
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/01/2023 18:26, Kui-Feng Lee wrote:
> On 1/23/23 16:21, Jason Ling wrote:
>> Some context:
>>
>> The devices I am interested in have a small kernel partition (~16MB).
>> Building the kernel with CONFIG_DEBUG_INFO_BTF=y increases the kernel
>> size by about ~1.7M.

Would it help in this environment if vmlinux BTF was in a module?
I've been exploring supporting CONFIG_DEBUG_INFO_BTF=m which
would involve having a vmlinux_btf module that could be loaded
on demand.

Alan  

>> So I've tried to use an external BTF (generating my own vmlinux BTF
>> and placing it on a more spacious partition) but it seems like my
>> eBPFs that attach to fexit hooks now fail loading. According to some
>> comments in libbpf this seems to be expected.
>>
>> e.g an eBPF program that looks like this
>>
>> SEC("fexit/ksys_unshare")
>> int BPF_PROG(handle_exit, unsigned long unshare_flags, int rv) {
>> }
>>
>> fails the loading process.
>>
>>
>> My guess is that there is additional debug/BTF information beyond what
>> is available in vmlinux BTF that gets linked into vmlinuz and without
>> this information the attaching to certain hooks fail.
> 
> IIRC, the verifier running in the kernel also needs BTF to verify the code.
> 
> That means you need a way to load BTF to kernel manually as well.
> 
> 
>>
>> So my question is:
>>
>> is there a way to achieve my goal of using a kernel that has been
>> built with CONFIG_DEBUG_INFO_BTF=n and still be able to use
>> fentry/fexit type hooks?
