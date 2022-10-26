Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C960DF4C
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiJZLLa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiJZLL3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 07:11:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3AF8E47B
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 04:11:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QAsKQM012227;
        Wed, 26 Oct 2022 11:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8aRqKg681FvNUPYp67xvZhc5DBQBAlZTe04fTQEBK+4=;
 b=N/h/k3PkrwFLFieGqj09oZSV7r8qBVRAQvmDfcNfV3gOnBBS6ryTCkY0sRipoxCChjSE
 j+49PN47Qh25V47k9hhXRBYb4jkdfslaIfc0wnNWxe6t5ZhCzMBXveKFaIJPsHuBwJLS
 C4rcxbKShkEfueETcjQxzKJ6Cz3mlCokvYWWz+A9St/nXXcmaBLGTk+iWDB0w7aHCQW6
 kIOLqyKfmw8e5XSJ0OtF+okRvnNAPULI1MxPsTTVC0UXJwkIaXvqXAfT7oTZY7LylHJv
 cf4tAH9xo71TU3xhhBcXXj4H69Fbw5OGyLn16pEVpm/Od63Om/dlJFRdVAfXPFZil1hY 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741xqxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 11:11:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q9xWa9032145;
        Wed, 26 Oct 2022 11:11:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ybp6ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 11:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/md976sdEvxlNojPQokDDStBxGnMM4zADFkcLBMpgBJN2cMlCqKKoGepcEslTKzIBshEKvPP2ri4BjSVA+pBM8y0j/73CYTVeI3lc4MUjZ9wI4PVCZtc2bBwxysMtcpNUklDQoGLL4EQPKknIF0YM/nU/whg7SfUQEdXINsUW4zNqfYlL3s2Py8uu5AOtWTz65+2dp37QDdmapFydrNRZK1ly/H77BivBaAiMSjGEKOjz38x516MMFYtHpvS5KWQM+Etl82I8IDaZfzsh5IG7/Kq2O4iWMUb+A3Q+sEG/3tchWGYKAREiGFwGOno+y2G4aLtXtsy1ijH+WH+r2XiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aRqKg681FvNUPYp67xvZhc5DBQBAlZTe04fTQEBK+4=;
 b=PnjSfDAUvqYtMr2g+px7T2EDxIpLgtY+1ZfgZLyWBuL9TH0Q2g06QjY4A6HCoTzeQw02gdwScZA3MJxlpdT0IoaqEYE3vg27jl8b8GdvU9I/Y3C3bA09SWevkG2uAQyAh/OGCZ4gemuWfs4Y0N+Xyi91gB/67UZJAFA5dV3muSUjMznmZoh7WBO7T0f03ZF3ComA/0usu5or5lig0LJfToJ4BRs6BccQudCr9MvJx+GVTw4mMCYyE9/fYytilMh+gHLJ0wEhi8hNiq+xKZNGOBIfeiArYbUaEDmb7GH2UzAsjABhZI/mRi5aOrfFWzobigM2XP05P9gaHm+B6edZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aRqKg681FvNUPYp67xvZhc5DBQBAlZTe04fTQEBK+4=;
 b=Lpc76ThI2SvpzNJUVyKHvEupjwZBdJ20oHZbrVob9vuZqbz1GuBNXRRqWwJP2dsNa4170w0CAfhWmzOuH+OOEULYfwBf+xN+dg4F9ohE8c8lhukywrGM8kCzSNZLfu2k8kNW3Y4Wr6R+TTS/akMFiE6ge995b6r95FpMTScO710=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6180.namprd10.prod.outlook.com (2603:10b6:510:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Wed, 26 Oct
 2022 11:11:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825%5]) with mapi id 15.20.5746.026; Wed, 26 Oct 2022
 11:11:00 +0000
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <81a01604-83db-25a2-d8e0-af1607ac30a9@oracle.com>
Date:   Wed, 26 Oct 2022 12:10:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:208:14::46) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f9f4d1-df0d-41cc-94ef-08dab742c37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VBM/IAkjOu83Ai62W1YNNpUs0K4LgW+qrZzBnOYyJ/JspMbVorS6l5paYV85w8n07h+euwQYc3mpLG0YXKTOkTXWLlUR4TPv+U+G1oBVL9XG+jXvBXeGDmQ/q4FTJn8Y9+swEsBWBDAFdBt2WGx+jOY1f9faVPt6aKY5ZWQBgWfr7IF0tSM+pGN00LaEBJa8Aotkb7xKxuTBXnpXS1fa31Ea5eU+FmbHhfdlIhoVMOSlIB8VgsRyhXZGs/UGQ78jykmQFv6pmHgXl1GF6iVg9PSYJuClSWpeVyC/FD6Jbg7n5WF2mLxUteGFVLPhdRTRs8G90AyMzG9/5NSsmRNg63BrvppTjF1tQ/Slk09G5AF36br8/06N1O384IsutVVGuU6R1bRbBTFvPmjbtEA59EUufbHnMd7F1g66fum7DAdeECUutPkyJihQLsrDdNf53VQku0SKBWnkbFgOBa5gNTCtGISlfoGOVzMtiKGCEf0zQHsKOEx15uzGEfkR4lEC0x96vdviebO+gvtD9a4k04OdxP2vFvg7xwTZ+DG4NnYruxSZKXbsbxaaWYQWgCQopcyvHTCxJjYMLoDmYMRaCahhsGRxUDYn4JTbzmdJ7eeGTapZiA7OmPLqMFivsEzvy39FbM/J6X44+Iai1h6JG7/K/Zpl38Qz/CARuxw/4urAkm2k5xrxhK9KzvbtgJtJQhYYJcs6PAqgckb4ozU7b27oze+JIixWbEqQ2h2AfMPVzOp+23d4X97aDVt9c5yq0qDWnvFwzjsjXgBPSIML66oKVDnDLxdkdqbuk/5cvZWe1H5q0kV/MyZgZjyL1bXF7yS2BhLHwuEynG5kNs5ANO2PmmB+uRC0xALV9xzLL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(30864003)(2906002)(44832011)(2616005)(6512007)(5660300002)(36756003)(186003)(41300700001)(8936002)(38100700002)(31696002)(86362001)(83380400001)(316002)(478600001)(31686004)(966005)(6486002)(6666004)(6506007)(53546011)(8676002)(4326008)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZMeUpVQzhoK3U2MHR3Q2pGUHBYeC9NQkJsc1ZsQ3FXa3hNQmM4L25HZU1J?=
 =?utf-8?B?S2lRL1dGbFUrLzVjbzFyUi9teHdDNUdUUEdLR0huOW1lcUJvNXFyT0IwWXhD?=
 =?utf-8?B?enNIOG1DU0dMK3Jock8vUEZZb0FHUEVNU2ZTY2lxRmZPbFA3UllHSUtzbXBW?=
 =?utf-8?B?MVJ5VTJpSTl4akNTR0NsTmE0b2pJR1pUemtsaU9INWJVL016Q0hoenU1Z2VH?=
 =?utf-8?B?Nk9WcVIyZHVwRG9oMUJUM2hhRDdyY21vcXV2K0toSXdud0dJdUpyMGpxR3N5?=
 =?utf-8?B?TFVDd3QrN09ocVJwdEpZbmsyTjVRQW92QWh6ZHh2YnRaRmxyWVRSeHNzaWVI?=
 =?utf-8?B?WW0vTStvR0Z0S0I5WFZFNW5WUEdSVE5VUlJtWit1VFFLT3l3YUE5RTBjMGtm?=
 =?utf-8?B?cWFWcXpTSlViaUF3bU42K3pCNzRzUGZzRUJxMlJYYjdhWVQ2QmZzaHR4VlZy?=
 =?utf-8?B?OGZmbDcxMmU3RmprczlKTUoxSklXaXdUYUNCdXdsUS9OS2U0UUZ6c2xlVUlK?=
 =?utf-8?B?NlUwTE50aDNkYWIyQnpLVDZDcnZJT2pyRFFGdTBUWlZWTzBqL3FRT1FyRDVN?=
 =?utf-8?B?cGtvb01WNjRDbEE0cmN6aWdQdXIzaHNORjNheTBZTFRvK1l5LytxSVd2K0VI?=
 =?utf-8?B?WGIveG1RRjZpTHFTVU1hZ3N0aXJXcE9BVHVLQ3lNcUlrcVZ3UkN1cnl5Z1l2?=
 =?utf-8?B?RXQ2bWhHWTlndXZYTUJ3M2c0Tit3VXhqdTJSRHhsRm5mSHJ5TUNlNnBDS2dM?=
 =?utf-8?B?TUdhWHYvRmhOUWRkYlBJc0lwMjd4TVAzYzhWMDJxQm1BTHJOeXBIRHdQblk3?=
 =?utf-8?B?aUFHdkh5MXhib0Y1dVpQUjl5WlNicHAvWHhTY3ROUkJpUnRaUTlTVUxLUGtJ?=
 =?utf-8?B?ZnI3cnIyZElQK3I4amZYT0VBVHRGbEtsaXNCTWVQV1YvRHAwdkxCWkVBRHIz?=
 =?utf-8?B?MmZGQ0hVKzNiMXVTTXdRVVJUeUhLQmQvLzNqUmcvODJlOVQ2MU5kZWJhUVhC?=
 =?utf-8?B?amk3Z2ZBQkw0VmZhU3NrajVyWGNXM3oyak5SenB4MU0wL3lSbURWc1FVRWZh?=
 =?utf-8?B?UnJyMUxsNWd1QmNhSUUrNSs3WjhjeW0wSW4zVmhtY3RDakN6TXZ1UTdhS3h1?=
 =?utf-8?B?M08xWGpqQk1GVzVZNUoxWFNXeDdscmdwbG40aUM1NXNmZWEzYm4yZmF2UGNM?=
 =?utf-8?B?Ky9lN0xNWUJPaVIvZFZ4WEVlTTRQYkRyY25BSkJBSWJUT3lHME9PbmM1UlJ0?=
 =?utf-8?B?cnZrNHE5ZG9mT2tCaUt4NlNyRkowRU8rUkhKQ3VVRjRoK2lYNHc2Rkkzb2tP?=
 =?utf-8?B?OEQydHRUdnQ2Z1BJcHk0ZnViNDYwRysxTjIyMVdxQzBhMk9MTW5Ud0ZuTTFC?=
 =?utf-8?B?STdtUjI5UDJQaWZFVy9MZlF1VFk0QjV3bUl3S01jS2E3ODhvZjN6ekFDQWtI?=
 =?utf-8?B?akNtRElvWTB6aThDQ3Y0OGZadm1jM0JwZm41em5DM0ZDVU93dUo1bjY1cFhU?=
 =?utf-8?B?QTZwUjBodWZmL1NFTU1XLzE0bUYvUXFmN1lxMU53OS9BS2tIWS9wSFBSbFla?=
 =?utf-8?B?ZHBPU3BGZmNLQlZmRWN2amMySEkzd1BqbGh3SmRoYTd3Z0pjOFkvR1pKTTRX?=
 =?utf-8?B?UkJ4QWpDM3BlODZFZ2hUYjFCVmVvV1lONG5XeTVxWENWNk5ockp4N1BZc2xX?=
 =?utf-8?B?QkNSZEhob3lKTGNPcTc0VFVyZ1IwaE8zZ1dDcGRjVENScStkTWxWeE1oeGYr?=
 =?utf-8?B?cVVCKzB6cDFuZThqQmM3S1JqcWpLUEhiSUVwU3VSK2JXLzc1OXVlcEk0THhM?=
 =?utf-8?B?YzI3Ry84elJiYW5oNVl0Z0I0WHZ4N2lHa0hHUmlZendLc2txTVJ5YVhYenNT?=
 =?utf-8?B?WFV6YlhtblV4KytyaTgxY2toVXVvcStkYVM2eVpuREo4eUxOLzB4a3lxZS9D?=
 =?utf-8?B?V0JzRmJBTGFaTnBDMHpUbWlwaHpXaTFVMkVOMDdOYlRLWXRVd2NCVThsU3F4?=
 =?utf-8?B?YnFRU3pMdTkvNmtCVUJDWkNDWTNLVnVlNzhBeVEvMWU3Y0J1VUcwd1YybzdN?=
 =?utf-8?B?VCtQQUxUeExTWTVpQ1dzTGJNa0ttWDIrdHJPdCtZMUt1VnNQb1QwVyt2cHZt?=
 =?utf-8?B?aTVGbTNoR0dBSEp5OHR6eEtwRUhrUGxWQW16OEc4N04yNmliWS9CRGpWZjJM?=
 =?utf-8?Q?bHh0+0sZ1i+sSJOA1ne9xC8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f9f4d1-df0d-41cc-94ef-08dab742c37f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 11:11:00.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUYRTbtXl9XaDeadDq6B64hMOAryqhkUPqN0/A7Df5705gbKdXhBfUaqO1l2zOa3XKKOxrsa51CoXNhG++3/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_05,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260062
X-Proofpoint-GUID: B3Sw9IeqigQtaXYOb4dYc2Dvfm-1ZclE
X-Proofpoint-ORIG-GUID: B3Sw9IeqigQtaXYOb4dYc2Dvfm-1ZclE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/10/2022 23:27, Eduard Zingerman wrote:
> Hi BPF community,
> 
> AFAIK there is a long standing feature request to use kernel headers
> alongside `vmlinux.h` generated by `bpftool`. For example significant
> effort was put to add an attribute `bpf_dominating_decl` (see [1]) to
> clang, unfortunately this effort was stuck due to concerns regarding C
> language semantics.
> 

Thanks for the details! It's a tricky problem to solve.

Before diving into this, can I ask if there's another way round this;
is there no way we could teach vmlinux.h generation which types to
skip via some kind of bootstrapping process?

For a bpf object foo.bpf.c that wants to include linux/tcp.h and 
vmlinux.h, something like this seems possible;

1. run the preprocessor (gcc -E) over the BPF program to generate 
a bootstrap header foo.bpf.exclude_types.h consisting of all the types mentioned
in it and associated includes, but not in vmlinux.h  It would need to -D__VMLINUX_H__ 
to avoid including vmlinux.h definitions and -D__BPF_EXCLUDE_TYPE_BOOTSTRAP__ to 
skip the programs themselves, which would need a guard around them I think:

#include <stddef.h>
#include <stdbool.h>
#include <vmlinux.h>
#include <linux/tcp.h>

#ifndef __BPF_EXCLUDE_TYPE_BOOTSTRAP__
//rest of program here
#endif

So as a result of this, we now have a single header file that contains all the types
that non-vmlinux.h include files define.

2. now to generate vmlinux.h, pass foo.bpf.exclude_types.h into "bpftool btf dump" as an
exclude header:

bpftool btf dump --exclude /tmp/foo.bpf.types.h file /sys/kernel/btf/vmlinux format c > vmlinux.h

bpftool would have to parse the exclude header for actual type definitions, spotting struct,
enum and typedef definitions. This is likely made easier by running the preprocessor
at least since formatting is probably quite uniform. vmlinux.h could simply emit forward declarations
for types described both in vmlinux BTF and in the exclude file.

So the build process would be

- start with empty vmlinux.h
- bootstrap a header consisting of the set of types to exclude via c preprocessor
- generate new vmlinux.h based on above
- build bpf program

Build processes for BPF objects already has bootstrapping elements like
this for generating vmlinux.h and skeletons, so while it's not perfect it might
be a simpler approach. There may be problems with this I'm not seeing though?

Thanks!

Alan

> After some discussion with Alexei and Yonghong I'd like to request
> your comments regarding a somewhat brittle and partial solution to
> this issue that relies on adding `#ifndef FOO_H ... #endif` guards in
> the generated `vmlinux.h`.
> 
> The basic idea
> ---
> 
> The goal of the patch set is to allow usage of header files from
> `include/uapi` alongside `vmlinux.h` as follows:
> 
>   #include <uapi/linux/tcp.h>
>   #include "vmlinux.h"
> 
> This goal is achieved by adding `#ifndef ... #endif` guards in
> `vmlinux.h` around definitions that originate from the `include/uapi`
> headers. The guards emitted match the guards used in the original
> headers. E.g. as follows:
> 
> include/uapi/linux/tcp.h:
> 
>   #ifndef _UAPI_LINUX_TCP_H
>   #define _UAPI_LINUX_TCP_H
>   ...
>   union tcp_word_hdr {
> 	struct tcphdr hdr;
> 	__be32        words[5];
>   };
>   ...
>   #endif /* _UAPI_LINUX_TCP_H */
> 
> vmlinux.h:
> 
>   ...
>   #ifndef _UAPI_LINUX_TCP_H
> 
>   union tcp_word_hdr {
> 	struct tcphdr hdr;
> 	__be32 words[5];
>   };
> 
>   #endif /* _UAPI_LINUX_TCP_H */
>   ...
> 
> To get to this state the following steps are necessary:
> - "header guard" name should be identified for each header file;
> - the correspondence between data type and it's header guard has to be
>   encoded in BTF;
> - `bpftool` should be adjusted to emit `#ifndef FOO_H ... #endif`
>   brackets.
> 
> It is not possible to identify header guard names for all uapi headers
> basing only on the file name. However a simple script could devised to
> identify the guards basing on the file name and it's content. Thus it
> is possible to obtain the list of header names with corresponding
> header guards.
> 
> The correspondence between type and it's declaration file (header) is
> available in DWARF as `DW_AT_decl_file` attribute. The
> `DW_AT_decl_file` can be matched with the list of header guards
> described above to obtain the header guard name for a specific type.
> 
> The `pahole` generates BTF using DWARF. It is possible to modify
> `pahole` to accept the header guards list as an additional parameter
> and to encode the header guard names in BTF.
> 
> Implementation details
> ---
> 
> Present patch-set implements these ideas as follows:
> - A parameter `--header_guards_db` is added to `pahole`. If present it
>   points to a file with a list of `<header> <guard>` records.
> - `pahole` uses DWARF `DW_AT_decl_file` value to lookup the header
>   guard for each type emitted to BTF. If header guard is present it is
>   encoded alongside the type.
> - Header guards are encoded in BTF as `BTF_DECL_TAG` records with a
>   special prefix. The prefix "header_guard:" is added to a value of
>   such tags. (Here `BTF_DECL_TAG` is used to avoid BTF binary format
>   changes).
> - A special script `infer_header_guards.pl` is added as a part of
>   kbuild, it can infer header guard names for each UAPI header basing
>   on the header content.
> - This script is invoked from `link-vmlinux.sh` prior to BTF
>   generation during kernel build. The output of the script is saved to
>   a file, the file is passed to `pahole` as `--header_guards_db`
>   parameter.
> - `libbpf` is modified to aggregate `BTF_DECL_TAG` records for each
>   type and to emit `#ifndef FOO_H ... #endif` brackets when
>   "header_guard:" tag is present for a type.
> 
> Details for each patch in a set:
> - libbpf: Deduplicate unambigous standalone forward declarations
> - selftests/bpf: Tests for standalone forward BTF declarations deduplication
> 
>   There is a small number (63 for defconfig) of forward declarations
>   that are not de-duplicated with the main type declaration under
>   certain conditions. This hinders the header guard brackets
>   generation. This patch addresses this de-duplication issue.
> 
> - libbpf: Support for BTF_DECL_TAG dump in C format
> - selftests/bpf: Tests for BTF_DECL_TAG dump in C format
> 
>   Currently libbpf does not process BTF_DECL_TAG when btf is dumped in
>   C format. This patch adds a hash table matching btf type ids with a
>   list of decl tags to the struct btf_dump.
>   The `btf_dump_emit_decl_tags` is not necessary for the overall
>   patch-set to function but simplifies testing a bit.
> 
> - libbpf: Header guards for selected data structures in vmlinux.h
> - selftests/bpf: Tests for header guards printing in BTF dump
> 
>   Adds option `emit_header_guards` to `struct btf_dump_opts`.
>   When enabled the `btf_dump__dump_type` prints `#ifndef ... #endif`
>   brackets around types for which header guard information is present
>   in BTF.
> 
> - bpftool: Enable header guards generation
> 
>   Unconditionally enables `emit_header_guards` for BTF dump in C format.
> 
> - kbuild: Script to infer header guard values for uapi headers
> - kbuild: Header guards for types from include/uapi/*.h in kernel BTF
> 
>   Adds `scripts/infer_header_guards.pl` and integrates it with
>   `link-vmlinux.sh`.
> 
> - selftests/bpf: Script to verify uapi headers usage with vmlinux.h
> 
>   Adds a script `test_uapi_headers.py` that tests header guards with
>   vmlinux.h by compiling a simple C snippet. The snippet looks as
>   follows:
>   
>     #include <some_uapi_header.h>
>     #include "vmlinux.h"
>   
>     __attribute__((section("tc"), used))
>     int syncookie_tc(struct __sk_buff *skb) { return 0; }
>   
>   The list of headers to test comes from
>   `tools/testing/selftests/bpf/good_uapi_headers.txt`.
> 
> - selftests/bpf: Known good uapi headers for test_uapi_headers.py
> 
>   The list of uapi headers that could be included alongside vmlinux.h.
>   The headers are peeked from the following locations:
>   - <headers-export-dir>/linux/*.h
>   - <headers-export-dir>/linux/**/*.h
>   This choice of locations is somewhat arbitrary.
> 
> - selftests/bpf: script for infer_header_guards.pl testing
> 
>   The test case for `scripts/infer_header_guards.pl`, verifies that
>   header guards can be inferred for all uapi headers.
> 
> - There is also a patch for dwarves that adds `--header_guards_db`
>   option (see [2]).
> 
> The `test_uapi_headers.py` is important as it demonstrates the
> the necessary compiler flags:
> 
> clang ...                                  \
>       -D__x86_64__                         \
>       -Xclang -fwchar-type=short           \
>       -Xclang -fno-signed-wchar            \
>       -I{exported_kernel_headers}/include/ \
>       ...
> 
> - `-fwchar-type=short` and `-fno-signed-wchar` had to be added because
>   BPF target uses `int` for `wchar_t` by default and this differs from
>   `vmlinux.h` definition of the type (at least for x86_64).
> - `__x86_64__` had to be added for uapi headers that include
>   `stddef.h` (the one that is supplied my CLANG itself), in order to
>   define correct sizes for `size_t` and `ptrdiff_t`.
> - The `{exported_kernel_headers}` stands for exported kernel headers
>   directory (the headers obtained by `make headers_install` or via
>   distribution package).
> 
> When it works
> ---
> 
> The mechanics described above works for a significant number of UAPI
> headers. For example, for the test case above I chose the headers from
> the following locations:
> - linux/*.h
> - linux/**/*.h
> There are 759 such headers and for 677 of them the test described
> above passes.
> 
> I excluded the headers from the following sub-directories as
> potentially not interesting:
> 
>   asm          rdma   video xen
>   asm-generic  misc   scsi
>   drm          mtd    sound
> 
> Thus saving some time for both discussion and CI but the choice is
> somewhat arbitrary. If I run `test_uapi_headers.py --test '*'` (all
> headers) test passes for 834 out of 972 headers.
> 
> When it breaks
> ---
> 
> There several scenarios when this mechanics breaks.
> Specifically I found the following cases:
> - When uapi header includes some system header that conflicts with
>   vmlinux.h.
> - When uapi header itself conflicts with vmlinux.h.
> 
> Below are examples for both cases.
> 
> Conflict with system headers
> ----
> 
> The following uapi headers:
> - linux/atmbr2684.h
> - linux/bpfilter.h
> - linux/gsmmux.h
> - linux/icmp.h
> - linux/if.h
> - linux/if_arp.h
> - linux/if_bonding.h
> - linux/if_pppox.h
> - linux/if_tunnel.h
> - linux/ip6_tunnel.h
> - linux/llc.h
> - linux/mctp.h
> - linux/mptcp.h
> - linux/netdevice.h
> - linux/netfilter/xt_RATEEST.h
> - linux/netfilter/xt_hashlimit.h
> - linux/netfilter/xt_physdev.h
> - linux/netfilter/xt_rateest.h
> - linux/netfilter_arp/arp_tables.h
> - linux/netfilter_arp/arpt_mangle.h
> - linux/netfilter_bridge.h
> - linux/netfilter_bridge/ebtables.h
> - linux/netfilter_ipv4/ip_tables.h
> - linux/netfilter_ipv6/ip6_tables.h
> - linux/route.h
> - linux/wireless.h
> 
> Include the following system header:
> - /usr/include/sys/socket.h (all via linux/if.h)
> 
> The sys/socket.h conflicts with vmlinux.h in:
> - types: struct iovec, struct sockaddr, struct msghdr, ...
> - constants: SOCK_STREAM, SOCK_DGRAM, ...
> 
> However, only two types are actually used:
> - struct sockaddr
> - struct sockaddr_storage (used only in linux/mptcp.h)
> 
> In 'vmlinux.h' this type originates from 'kernel/include/socket.h'
> (non UAPI header), thus does not have a header guard.
> 
> The only workaround that I see is to:
> - define a stub sys/socket.h as follows:
> 
>     #ifndef __BPF_SOCKADDR__
>     #define __BPF_SOCKADDR__
>     
>     /* For __kernel_sa_family_t */
>     #include <linux/socket.h>
>     
>     struct sockaddr {
>         __kernel_sa_family_t sa_family;
>         char sa_data[14];
>     };
>     
>     #endif
> 
> - hardcode generation of __BPF_SOCKADDR__ bracket for
>   'struct sockaddr' in vmlinux.h.
> 
> Another possibility is to move the definition of 'struct sockaddr'
> from 'kernel/include/socket.h' to 'kernel/include/uapi/linux/socket.h',
> but I expect that this won't fly with the mainline as it might break
> the programs that include both 'linux/socket.h' and 'sys/socket.h'.
> 
> Conflict with vmlinux.h
> ----
> 
> Uapi header:
> - linux/signal.h
> 
> Conflict with vmlinux.h in definition of 'struct sigaction'.
> Defined in:
> - vmlinux.h: kernel/include/linux/signal_types.h
> - uapi:      kernel/arch/x86/include/asm/signal.h
> 
> Uapi headers:
> - linux/tipc_sockets_diag.h
> - linux/sock_diag.h
> 
> Conflict with vmlinux.h in definition of 'SOCK_DESTROY'.
> Defined in:
> - vmlinux.h: kernel/include/net/sock.h
> - uapi:      kernel/include/uapi/linux/sock_diag.h
> Constants seem to be unrelated.
> 
> And so on... I have details for many other headers but omit those for
> brevity.
> 
> In conclusion
> ---
> 
> Except from the general feasibility I have a few questions:
> - What UAPI headers are the candidates for such use? If there are some
>   interesting headers currently not working with this patch-set some
>   hacks have to be added (e.g. like with `linux/if.h`).
> - Is it ok to encode header guards as special `BTF_DECL_TAG` or should
>   I change the BTF format a bit to save some bytes.
> 
> Thanks,
> Eduard
> 
> 
> [1] https://reviews.llvm.org/D111307
>     [clang] __attribute__ bpf_dominating_decl
> [2] https://lore.kernel.org/dwarves/20221025220729.2293891-1-eddyz87@gmail.com/T/
>     [RFC dwarves] pahole: Save header guard names when
>                   --header_guards_db is passed
> 
> Eduard Zingerman (12):
>   libbpf: Deduplicate unambigous standalone forward declarations
>   selftests/bpf: Tests for standalone forward BTF declarations
>     deduplication
>   libbpf: Support for BTF_DECL_TAG dump in C format
>   selftests/bpf: Tests for BTF_DECL_TAG dump in C format
>   libbpf: Header guards for selected data structures in vmlinux.h
>   selftests/bpf: Tests for header guards printing in BTF dump
>   bpftool: Enable header guards generation
>   kbuild: Script to infer header guard values for uapi headers
>   kbuild: Header guards for types from include/uapi/*.h in kernel BTF
>   selftests/bpf: Script to verify uapi headers usage with vmlinux.h
>   selftests/bpf: Known good uapi headers for test_uapi_headers.py
>   selftests/bpf: script for infer_header_guards.pl testing
> 
>  scripts/infer_header_guards.pl                | 191 +++++
>  scripts/link-vmlinux.sh                       |  13 +-
>  tools/bpf/bpftool/btf.c                       |   4 +-
>  tools/lib/bpf/btf.c                           | 178 ++++-
>  tools/lib/bpf/btf.h                           |   7 +-
>  tools/lib/bpf/btf_dump.c                      | 232 +++++-
>  .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
>  .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
>  .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
>  .../progs/btf_dump_test_case_header_guards.c  |  94 +++
>  .../bpf/test_uapi_header_guards_infer.sh      |  33 +
>  .../selftests/bpf/test_uapi_headers.py        | 197 +++++
>  13 files changed, 1816 insertions(+), 12 deletions(-)
>  create mode 100755 scripts/infer_header_guards.pl
>  create mode 100644 tools/testing/selftests/bpf/good_uapi_headers.txt
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
>  create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
>  create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py
> 
