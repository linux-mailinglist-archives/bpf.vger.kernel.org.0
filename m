Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575DB6B9012
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 11:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjCNKdE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCNKce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 06:32:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B075B2CC71;
        Tue, 14 Mar 2023 03:31:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8TE9d024733;
        Tue, 14 Mar 2023 10:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8mmgpc4pkvgDDPMr5WKoVb01dkFmyGuk/0Ae1Sr5A1Y=;
 b=Oxqva9WbuvKL2juzoybHhJmYGNAV0hZT3VgAvSPPQMA+e1TfgXOT4tZ9sObQxh1jvTxx
 gWvk43RFWKBNA6b/YN3oBXiiSTTP1uX745wRpO9byF0JP47MaBaZtat9zJvppepUUyzL
 92yFanNE7xC8W13+INRKwarVr6l/+xqVH4/TD98mpl+PQ+I5ZF2J6nBLo7/RKazq62HZ
 0oeV0QSWNFt/RYCzAnYj9C3n6mQmbmEWx4uf3PuQktuby32Urt5xOkqDy30zAVU8NKVM
 tvPJmDq6ewNUE8wo03SYQTzDj6FreXSiyJegC655oRE7z3kSYWGd6S5oLIfw7OiB+hQz 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u62r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 10:30:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32EAPvEd002280;
        Tue, 14 Mar 2023 10:30:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3cej5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 10:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQMU804LkNsDP5/IY7NDctRG3bw7pHqBusQFX0U+sz71bhumswVTlQIAfQ27KQ+4g3twpqyLggBVEqndp/VJj4W5SaEPna+kheWlHFUBZQwsWneFyWyjhJP5zNT4lnusUDlgdI0pAXuUzo6H+AjsP7Awj9kZm0Nd9hbb4Gz2UB1Xp734jAMyqHGAq2LI+6H69PHqvcDUh2BBGEnd4pPC5KnX0EIFhkrrjmWdIXN62NpdxDE5pMHZ3P7zV16vqfoz1FxcnMwsPoSHthAvIyumVznQvnwi0OJe5TjpiHH3MdaPoM1KWxr0oKHjmNPkBFv+uShKrFY6B1CHGNzXTyfkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mmgpc4pkvgDDPMr5WKoVb01dkFmyGuk/0Ae1Sr5A1Y=;
 b=jYA189vmtiIqrF5NVroUnSQBnqly2rpNqFilSNsyyWzOTAJzI8CMPLUxJ9CrOLCvyDg6fcnZ9h61Nmhz05DuFQFmORRsDX7vJwlZiuz3xmzMGmApPhRfK/DfprLfwy9G8H9DtemeBc2mMdmo9X6E1DCCAIx6tWYdU7h+TCLti5XcVAIluaWOwKRvuEU2zM6Pdrx6hfLwxuKHMJUT/amstMhjV1HKfCNe4y6SrgEU3b5VNzcJYhh69OewnnylMrIsQ5dUiuUg+8tmdYu53HJVn92JboKoQjWeiTky7DTRwkihcK7vYkLyOx8pAKFl0kRNUshE7FEVxz50V95ETOAqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mmgpc4pkvgDDPMr5WKoVb01dkFmyGuk/0Ae1Sr5A1Y=;
 b=Mi475co3verbcTjDa3n10AJZOBUqRn2qkGN65JlHUTovBFZG+26Abvi2qW51fNGmu+dCDSkVNGaIABB6VRlLwCEhzZ31ZLYbhfjrOzM/3dT62L+/tdbpvJ61flBuZs4ZbOCAltJICU8SsMhDvahPlXDhCtPHXSScSOoAPkwrO34=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 DM4PR10MB6206.namprd10.prod.outlook.com (2603:10b6:8:89::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Tue, 14 Mar 2023 10:30:23 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::29d1:6768:1a30:b32b]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::29d1:6768:1a30:b32b%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 10:30:23 +0000
Subject: Re: [PATCH dwarves 1/1] dwarf_loader: Support for btf:type_tag
To:     Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com
References: <20230313021744.406197-1-eddyz87@gmail.com>
 <20230313021744.406197-2-eddyz87@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <cd8636e4-0d76-b26d-7ddf-b28d2896b05a@oracle.com>
Date:   Tue, 14 Mar 2023 10:30:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230313021744.406197-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0680.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::9) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|DM4PR10MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 937bee8b-4446-45ad-b91c-08db24771e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2jFhsJ3Mz0xQ/SKfc61VB557B/16FtEiVr+Djnvj2pANtzDL6pjUQ+YipKjI3gIz0MCOg9sMTpYujCU1j6sjELKgq/MDm+YghpryU81QByeXQHJ5T0bvUMPXrk7sj9JhSCpJ1AEMHomqT5SBVL6POAWQC/5kK4hFkL7L9SillA6U97IX0Q2/eDamcpkkPzSN6+lZBFqPqQP/KN8DvPDXn011b5ujPfxBCQruYVwVVMIucXIjCqUpz6qph1s29dUEK19OP0d5hPVxJmUgQtJMwNU3+fwf6va1wqhgZ2xu2GD+qvshfUl6eAc/AWVa1fpU0fmXjC9CzbXLL7WkBs10JeB93uZvgucfWV/Rqik9hFyyLvm/i3o9Yk85T4sAKflJxkOfRnWFnBGeR2vPUBgJ/S+Qdq0A+7Qo/4H7VlAkTpBTPNeDjC58kl6BjU/bOR74U9aS4/FQ1QCZYzWkB7kMLvBQFI3prbwJRUkKmE10BnZoRYnkqR7tgsKCIWyoVwDaqtsYzNMXVQdhWEZO98NKZSaP1pVxz1MClKoCcDabGrHmsvm/p3FsDWkbmZYF5djGFjYzl8Y3yivI8dipO+LVrF3c04FyksJfmEaVCE/HiPOAd5fa2N9YMjTtn42dNrRdwQ1Dt9QANobVZFm1uMDNm4we9OKO2isZbHXT5e/s4aspNw+dlLWo4yle7SVW1Vtgv5cYMfeTK4io4ss5EkenvXmCvSFlvVSTLNPHVs8ee0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199018)(966005)(6486002)(66556008)(6512007)(8676002)(66476007)(31686004)(107886003)(2616005)(66946007)(186003)(6506007)(6666004)(316002)(8936002)(4326008)(5660300002)(41300700001)(2906002)(83380400001)(38100700002)(44832011)(53546011)(86362001)(478600001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNLK0I4Z2VjbjMxTlA0L2o5YU9sdmRRazN2ZjdJcFNLdHh5R2M1MndtdDl3?=
 =?utf-8?B?Mk5BZ1NJYUxJTmRWSTFQM3RyQlVnL0oyN3lXSStBL25NUW5UeHVVT01Sdk95?=
 =?utf-8?B?RU14MHlkR3A1ZjJDbE1FNlRiQy9qVEpxU0x6ZTg0MXo5ZHp3VlI1a21pZVNU?=
 =?utf-8?B?SEdRZlNIa3NlWThJckdOT1Yyb1R5WWxkeUxLeld0ek5QRGoxbFd3NDQ1dmVU?=
 =?utf-8?B?dkhhbklNdzM3UHNhdkloWUVhazI3OFd2OUxjU0FEUHhiVkFnK0hEV1RweEhz?=
 =?utf-8?B?SGZKSW1iU3FOTGR3QjdoaS9XYXM1ZnEwWFh3UHJBUlRoaDhOS1RWNkhKeWkx?=
 =?utf-8?B?Qlh5YUhyYVRjR1k3MkY4ZmFmcXRkYi9lMGtIbkgyOThUMHNIRUZycmxPNk5C?=
 =?utf-8?B?Wkd5bi93UGZyaVg0THcrQnZVUkpHMk1SS2dKSjk2MlRSZGduZE44NmZSalZD?=
 =?utf-8?B?OFMwWVdpb2N4OUphcUp2ekJ3NVlnemJzN2wrTTRvak1JOFJ0NW02bjhtN2J0?=
 =?utf-8?B?SjFIdGdIMGt0WlpvOWZoVEZYaWpXeHlUZUNrR0pMcGtkcTBXWldRWkp6d0Nn?=
 =?utf-8?B?Z3A2ZGZWNDV6MksvNFVLSXdkNzZCald5MllZTThRbGRNeHRtZXNxbTNiK1Jo?=
 =?utf-8?B?MExKK2c5RHdVZFFwaC9aaHQrbzBwaml6Y1lqcGdzVEtzNHI2MTVmQzBnaUhh?=
 =?utf-8?B?TGhwSDF1bWZRWkRNZGQwM1k3OFUzeVA4a3R6ZlNCdzlxcWExZlFncGVaaUEw?=
 =?utf-8?B?TGNZUVoxNTNPWUhWRTh1RlN6ZGRsYTZaQWdZRG81bzJHd09ONTg0bFR2NkdF?=
 =?utf-8?B?dDBtbEtxc05RbzkzaVR0dGJNVU1Damg4QktqbTVIeVo4WDF3SnIzZWxMVGNU?=
 =?utf-8?B?akhHYU9Fa3RGbGJMdjlLbk1qZjF3UjgxSGV3MEhuYml1eXpZZldtYkkwbE4r?=
 =?utf-8?B?TktSbTFoS3BBYWk2bXFKd3hYOFY4NGdUZmtCMTBDcGpsa3VUcVE4MUtNQXdo?=
 =?utf-8?B?a3JhNkRYWnhVMG0wNzVWWHZtRVh2WFhLdGxCenR5Nm1rL29ISlgzTUgwNmpU?=
 =?utf-8?B?ajJDd0IrK2U5VW93NjNsS0llTlJmU0dmdEhIOTlVT000UGl0YkRjVDk4WXBV?=
 =?utf-8?B?TERpVFNCdFI1UmZyQWR3SExoUFRQZ1pUc1pOcEhNbVdlRmpva3NtQjNKTVF4?=
 =?utf-8?B?R2RIL0lwL1lJYzR1dUF0NDFnVWhXS1hweWsvNzg4UkpQKzJ1OWFoUUs1d2dI?=
 =?utf-8?B?bTExenEvb2ltaUpMenJ2cmZpQnRkTStNQ3oxeDZTZ0NWMG8rQWpZYjdkeFh6?=
 =?utf-8?B?bnordXhQVUQrNmRKQWVkK1p6OTI0ZXNaVzBYUUhZOCswdmFTWm04di8xQkdN?=
 =?utf-8?B?YjlNU0M1bFlDZlhyQnpyclQ1YkMvZ09KWExiUExTK3ZnZndqWWJTckZ6cm9x?=
 =?utf-8?B?RGROYkxiSzJxSXBxeU1HSWgrME92elQrNTJMbDI1aTNuYzNQWFEzU0pORWhp?=
 =?utf-8?B?Tm4vcjRRcGxxeWFzYXNxUk10ZnVMYnVhZk9jUlJIOUlDWExzUFVJK2JUUGww?=
 =?utf-8?B?dUV6cVF5VDhvOHY4ZDFINDhiRld3OTNsUjZEVEhmUEIyQzJwbndjVlJVQWdl?=
 =?utf-8?B?S0FjWDV6Yk5UalpsZ3hjOXB1SW1TYWNGbS83aUN4VEE2cXAzWjR2NEZFMWJI?=
 =?utf-8?B?dmZKdTY1bzNaTnhsbG5wU0lvSXNpaXY1MHFJUjEzZDB4TXpDMnpYRm1vWmtS?=
 =?utf-8?B?WFRYQmpwRHU2T1dhS0RtdGlaakNnbHR0NUlWOXVZTkQ1dXdacFFKYnRScEc2?=
 =?utf-8?B?VXU0U2xZWHhMamJRUlcvV2I0T3FTNzlpZnU4bVhoSHJNczRkc2FKektYYjd2?=
 =?utf-8?B?cVlWa1AzdldUbEl0dHpqOUllekp3M2F6aXQ0am9BUXZ3b1liWmdsM21Mc0Jn?=
 =?utf-8?B?dnJZNElYelRHTUpBL3JFOG5FK3BkdEVlSS9NR3ZmVG53R1pvM050Wk5rNGxy?=
 =?utf-8?B?ZkFxMDBuY2JJeldnVnA1M0QrMlBFeGJ0WWhIVEtRMWxZdlBLbFZYdGo2eTc4?=
 =?utf-8?B?ejUxdlh3TDU4NHVvd21yVWVlRldiOVJxc2EvQWhJQ0FQK2Jjc0V1Vnd0bG12?=
 =?utf-8?B?OVFsVmVkbmxBTWdsWWwxMndrNjFqWGxUVG0zODZ4RUYwUjY1YngvK3d3TS9N?=
 =?utf-8?Q?Zc8bKfOrfiQreM0B1pbYeiY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TJSN4mspUBGAY0/dQk+d5qGAklfEJCjAbxrLRioCYgpwjqo8X6ze3+Pv+NZjteIfEr7m944mwREKBHy/+sV13tkmJoQtaozl2ACNUaKUVtsfOwqKUFdMbFJU/3bxjFaHrnVZAWyddeCHdFKKGwHF2dJM0i90dz0zkll/K/cG0RZS9t22FwOlDQhJ7yDm3BHNdXA4RTbu7A44v1xIcttnC1lWvAYYqFMcXQhWXM4uMNf5avK0yVnktyg65aqE/ORaQvadRxnN0PTriK8OgIUA1M9jY4TOm8NV5liajmrIxAQKP2pNEj4tLeFg4N3/naDCGcbQSZDvthFtLmgnsxbG3g9lqaTv6Fqk1B5euz+73UZ6X8TiWKrRooh5PJSXykyi5YPXvGqV/OVYfv1QIYG6TWUSi2Q+Iv93zMyPYg8uNodY/8w3JBXKjFvJq3B4IPsWwWIXWDfaLBid35ro80XtflnSvY8tTPcEO2ntgMvpg7htTBNAxv3KuMNAhohBcvMn7pfZGWdPBKR0jDpwv/nURF+yTYWoXpolTvfrJVQ7a1vpDbXEPCLUIAuTsYcGicoUksDtJG6VMYiSbdaeN0rTILMJmgmjQ3OXufPkjJChzVuWIX+CVLVBLKHiUIXiuY2084vNcsJ9feuRhlTAoE9PZg73EA8cGptn9ul0Hsc7RjeOxcY3OA1A8k7Plpo3YddZvqBuYrn3rQNJH83qa0V51LmQJbZs5FJXfPdoBBng2f1wLecRDJivR5VQTZ6DS3IhmLwmzmIVxZ+OGW458CbbfLf4GLtg0NPAgna0eg0fEFJ1DmOeQwvJmxg/imLSUGN3trwzsEWkPx/ercmmJ7XbnWbnaQcGppMqiBwq4svPmgWbu3wm5+Jxpx7S2YN9bkWc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937bee8b-4446-45ad-b91c-08db24771e3a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:30:23.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCIq1dnXCE9dsA1eklskj+LYBYHMMbkAQ6WdMEMe4uDIQbQQTXTTmWBDinihCF6kiJIQq+9Gu4btr5ACdeFIxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140089
X-Proofpoint-GUID: 8VkLXhls4-jyja7_0s8Xr8woHetq1Q9e
X-Proofpoint-ORIG-GUID: 8VkLXhls4-jyja7_0s8Xr8woHetq1Q9e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/03/2023 02:17, Eduard Zingerman wrote:
> "btf:type_tag" is an DW_TAG_LLVM_annotation object that encodes
> btf_type_tag attributes in DWARF. Contrary to existing "btf_type_tag"
> it allows to associate such attributes with non-pointer types.
> When "btf:type_tag" is attached to a type it applies to this type.
> 
> For example the following C code:
> 
>     struct echo {
>       int __attribute__((btf_type_tag("__c"))) c;
>     }
> 
> Produces the following DWARF:
> 
> 0x29:   DW_TAG_structure_type
>           DW_AT_name      ("echo")
> 
> 0x40:     DW_TAG_member
>             DW_AT_name    ("c")
>             DW_AT_type    (0x8c "int")
> 
> 0x8c:   DW_TAG_base_type
>           DW_AT_name      ("int")
>           DW_AT_encoding  (DW_ATE_signed)
>           DW_AT_byte_size (0x04)
> 
> 0x90:     DW_TAG_LLVM_annotation
>             DW_AT_name    ("btf:type_tag")
>             DW_AT_const_value     ("__c")
> 
> Meaning that type 0x8c is an `int` with type tag `__c`.
> Corresponding BTF looks as follows:
> 
> [1] STRUCT 'echo'
>         ...
>         'c' type_id=8 bits_offset=128
> [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [8] TYPE_TAG '__c' type_id=4
> 
> Void pointers with type tag annotations are represented as objects
> of unspecified type with name "void", here is an example:
> 
>   struct st {
>     void __attribute__((btf_type_tag("__d"))) *d;
>   }
> 
> And corresponding DWARF:
> 
>   0x29:   DW_TAG_structure_type
>             DW_AT_name      ("st")
> 
>   0x49:     DW_TAG_member
>               DW_AT_name    ("d")
>               DW_AT_type    (0xa6 "void *")
> 
>   0xa6:   DW_TAG_pointer_type
>             DW_AT_type      (0xaf "void")
> 
>   0xaf:   DW_TAG_unspecified_type
>             DW_AT_name      ("void")
> 
>   0xb1:     DW_TAG_LLVM_annotation
>               DW_AT_name    ("btf:type_tag")
>               DW_AT_const_value     ("__d")
> 
> This commit adds support for DW_TAG_LLVM_annotation "btf:type_tag"
> attached to the following entities:
> - base types;
> - arrays;
> - pointers;
> - structs
> - unions;
> - enums;
> - typedefs.
> 
> This is achieved via the following modifications:
> - Types `struct btf_type_tag_type` and `struct llvm_annotation` are
>   consolidated as a single type `struct llvm_annotation`, in order to
>   reside in a single `annots` list associated with struct/union/enum
>   or typedef.
> - `struct unspecified_type` is added to handle `void *` types annotated
>   with `btf:type_tag`.
> - `struct tag` is extended with `annots` list.
> - DWARF load phase is modified to fill `annots` fields for the above
>   mentioned types.
> - Recode phase is split in two sub-phases:
>   - The existing `tag__recode_dwarf_type()` is executed first;
>   - Newly added `update_btf_type_tag_refs()` is executed to update
>     `->type` field of each tag if that type refers to an object with
>     `btf:type_tag` annotation. The id of the type is replaced by id
>     of the type tag.
> - When `btf:type_tag` annotations are present in compilation unit,
>   all `btf_type_tag` annotations are ignored during BTF dump.
> 
> See also:
> [1] Mailing list discussion regarding `btf:type_tag`
>     https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/
>

I know there's a v2 coming but one suggestion and one other issue below..

this is a great explanation, thanks for the details! one other thing that might help
here is specifying that the solution adopted is option 2 described in that discussion
(at least I think it is?).
 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  btf_encoder.c     |  13 +-
>  btf_loader.c      |  15 +-
>  dwarf_loader.c    | 763 +++++++++++++++++++++++++++++++++++++---------
>  dwarves.c         |   1 +
>  dwarves.h         |  68 +++--
>  dwarves_fprintf.c |  13 +
>  6 files changed, 693 insertions(+), 180 deletions(-)
> 

<snip>

> -static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu);
> +/** Add @tuple to @ctx->mappings array, extend it if necessary. */
> +static int push_btf_type_tag_mapping(struct btf_type_tag_mapping *tuple,
> +				     struct recode_context *ctx)
> +{
> +	if (ctx->nr_allocated == ctx->nr_entries) {
> +		uint32_t new_nr = ctx->nr_allocated * 2;
> +		void *new_array = reallocarray(ctx->mappings, new_nr,
> +					       sizeof(ctx->mappings[0]));

older libcs won't have reallocarray; might be good to either replace with realloc
or define our own variant in dutil.h like was done with libbpf_reallocarray()?

