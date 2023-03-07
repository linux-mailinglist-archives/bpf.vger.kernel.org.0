Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F36ADB94
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 11:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCGKQp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 05:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCGKQo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 05:16:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2E136D0
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 02:16:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783sem023573;
        Tue, 7 Mar 2023 10:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yPKMrAlmyiukTYcbEeu9wFX+hkPOzCju8mwd0sOvVdU=;
 b=Lcq64/LymL9ilADEk2SbA7i2eIXiUg7M4kgI4LLXOYwKdPq7jkwVoWqrzQdz6VryQ5OJ
 abDGTdOBd4Q8BogPVyHXRTxQCh29mjG7OxoefHNb+sO2XGMkPLYwlKwViny73akaAIKa
 8ekVpgEq+ZfpI3HRjfxCN5zWenBNloJpYUBP2LDXR14K7gP8dO/+hd536TuFi25+h28A
 iXbDUowcLm48pBs5ioPa28yLEJ1Ae4abLuFpA5tRS/jP9Za3JIHwnHEy3UoDlt9eXlTY
 XJBYxldURM5LPzn1ZCHsA8kJFNAgkWd+mCjFE4UtHyPEg5rhWGc38RzFsdVjdxjBJ/wW 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wn5b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:16:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32787ExA025077;
        Tue, 7 Mar 2023 10:16:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4ttjshv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNBCUGXkH/I4ZYMJZxq0IE5sELiyK6GSsS/JUkKmxV7zUOKoeYoAE18euj/M+PPMgL4Ntvl22zzZTxEYFjzEGnWtnZlUFwUH4yk1Gs6qDeGGy+DU5x6EqX45/cmytDjDVfD5yeHnrq1Z9y376v5nt9jThtbQxZHuVngnRymsjhcaTqIIIgUYxNbfUJ91iUMzOaSBrFcgwwHA551UNU9MwIOCxUzJADDR4zcl6wMNLzP9pQPntGBVRz5UuDMjgkGRp7QeYE5gqmEJXrFAudTK645mFC14jOCUnT52scf/40iME7apYKArtbQ5VUgYFRvLDwYMgA5IsuAXCGMy8R+ztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPKMrAlmyiukTYcbEeu9wFX+hkPOzCju8mwd0sOvVdU=;
 b=nOb7we0cS/xcPvZofn7CdpIdv7IhABdkUpVLKkrpasFwTz5bSif6qfLjbiprjlHRAo7lKNt0jdFHX1SyVfG9b2CNBWfR+K8mIkpdQxMQVnK/zR98YM9xZOQApHHVj2xV+Z7ucT/hzrMqM66Z+zSp8xLannUkVPN8wahgoM7JtUIRYml803AW3FI7cu67ZTLkl6qN1AoNzLOE3m6Dzf5Cot/AoJeSkaCgWyN5rCud1RWJktSxU3u2QObvNx0YvkpmTBlQm6oksAeBJ5z2L00UpEkAtCCLGgDZMXBGUVQmf1zKsWZuIO/VvXfFJLWicaTtrvy9+WKVFyHexnblVQJ0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPKMrAlmyiukTYcbEeu9wFX+hkPOzCju8mwd0sOvVdU=;
 b=EiVw34IPyNXiEOE8OkdBFVWV0NBb8tuwe/oYWtqDcwK9aaknUfkzabeH/qaIJgR48UipVznCtTmXIwJBuk5/h3VC2yCwIQWRbTH43EbR2FEKYqsv8GDN4nBhhoIpAVchcVgxueC5knYRkPmC1WIPusl/f+9pMren7E3ebufyzDY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6631.namprd10.prod.outlook.com (2603:10b6:303:22c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:16:38 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:16:38 +0000
Subject: Re: Selectively delay loading of eBPF program.
To:     Dominic <d.dropify@gmail.com>, bpf@vger.kernel.org
References: <CAJxriS2W9S7xQC-gVPSAAkfim5EBfQhKBSLzYaq6EyOAWG-sCQ@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <d62f77e9-bd0d-9461-63e5-f9dfb6d19a5d@oracle.com>
Date:   Tue, 7 Mar 2023 10:16:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAJxriS2W9S7xQC-gVPSAAkfim5EBfQhKBSLzYaq6EyOAWG-sCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e3cb25-3bf7-47f6-f657-08db1ef509ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee50slxSRyFrafiAkHVyCYgYs1o/9iaTnLRap1x1T2PpJGZOgrAITXIIcr3tXhg3DWSgBqfFFVNpmfuJsvNI/58u9+Ew0CeLHA/EN6flmu2FWp1LVShrVQpFobabXICzolgoEifRwlY6dV7lNrMdPoGjH4V54/aZ8+5hY25TbmBgn4l7j/hG/MG0qVJaF4M4H860SprZZQt7jAE92FANt8hMAzQ0qO42Y7968wp+y67HELSZdWmhI0/YWFq5xCiKbx9mu4zWtgf3MsB9NPhCnlfMnGfR73BWfPI5nMlCC7KzQYsAjYwi92CfF2D7VEEYM3Pao5UY0RiusMapvMJS3SsWqSr3lLgKwLIQS0T5TYG8WHigcgqHyfW95zrnmPYet80lBV38lQ92ZSnIqlK2tcXBqPwz9xXjbHljcaDVHxToPL7NYsxkVIEqiE5CIzqLY/gqxHeq9x90DIHON1uF2Y9CtMLxJC3w0xa1ybml99vxN2JFFh4EwXxT2y9uIp+weHetfCFIz9TrueeOS9IRNN8OAhXOnzM+JDBF/xNP+MadJnCfit+pN64DmUluIxUTr/mV1ZkYwMwmMGt4ptLAzhtwursmv5KKtB812K/XjGdEXph1BMgoinSw4WM3bvLzYiO9GYESq7kbbf6Ag3BgXDRTqnUkrHXnSi7BHZlvzQazIEqcwWpZjG7d6EIo1IlvdCxx/TsM0Oi1m/bpC+G1reucA3/GjM6i1seoG6/5dvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199018)(86362001)(31696002)(38100700002)(36756003)(44832011)(2906002)(5660300002)(66556008)(8936002)(66946007)(66476007)(8676002)(41300700001)(53546011)(2616005)(186003)(6512007)(83380400001)(316002)(478600001)(6506007)(6486002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tkNTh2ZzBOd3plcmdyVG9oNS80N0pLSXlCb1dwK2s2RGpwL2dIOWdWcWJG?=
 =?utf-8?B?US9YS2RBZjNzUFhCL3ZIZ2t6REw0TXpHY1paNTlYZFhYRUp2b3FPREpFUUVt?=
 =?utf-8?B?Ly82TC90ZXBuaXNWNmpnN2tmWlVNWnQvanJOZ2liQWd6ZWs1NlVkMmt5a3Mr?=
 =?utf-8?B?cWUwZDVheTg2MC9MaXhrTGZvYUVvNEZFQUpDWTVneUpLdzljZ05LYnZPamph?=
 =?utf-8?B?ZFdraWViYkZvdEVjSFJhUGIxeDhHdDBiQ3ovTmVoV2s3aFVnUzBVS29JQm80?=
 =?utf-8?B?QW1SaTc5ckVSaHNWTUV5VHZTdDhCclBBeS9GRWYvQkVLWllLYkl1cnFzTjNC?=
 =?utf-8?B?dGtwY3JuNXg5Mk92b01MZFRFRlpob09GZVBMcW5DeTdudEZ3NENaKzZlY3JU?=
 =?utf-8?B?T0ZEUEdxWVM0YlNQVjkxdWxxdVo0YUFxM3Jab2YzVndLZlhEZDBGYmE3T29y?=
 =?utf-8?B?ckFzam9ScnIvOVZMS0ZyRk5WYks2WXpNNEVlMFBVaTcyWWRWcHZKaEdYY3N4?=
 =?utf-8?B?aEwzUThtQTlYL3RyVy9mR2paTzAzQ04rWW42QjJBR2tpV1B0bHpMcHc4Mlpw?=
 =?utf-8?B?ZmxpWjVYMUZSbzdvdFFWNnpPUGRtVmRNUDF2TGJhaTBDRjVKcHBhZkQ0NllQ?=
 =?utf-8?B?aStPRGFFbkJ5RXFMODNvU0lUN3ZNN2JjK2FheExyMWJrNDlsYVArQ0FxR3RC?=
 =?utf-8?B?UVhJQW42d0dsRDRjaDFNT2dXWnJSVlFORlBZdE9QV2JGajFZSEtNd1kzZk9k?=
 =?utf-8?B?ekFTMzVNYkJJaXNLS2c2a2hTRElSTFhFdEMvcEM2M0xLbld2UUpPWU9OdGtu?=
 =?utf-8?B?eDF4V1VvRXFhSlpKb0FXSThOSHc2dncwQTZ1ZWdTbjlXTHZQNHdSUFlVYmhq?=
 =?utf-8?B?d2VoZlQ4dG9jT3IwdWg2SWNvOWtSYXJCUHJQMzB6VWV1bmZRWEJQb0RBSGE2?=
 =?utf-8?B?YjNTMmhRTmtsYmlFSEIzcWxwNWNFSWo1OFRtVDhSY2VCalBGaTNoMUxCRmpT?=
 =?utf-8?B?SDg2TFgwVXI1R3QwRFFzVWpQNjV6R0pnbVBNYlJwSWQ4UnVtVTl0dmtFUVQv?=
 =?utf-8?B?VS9FdzEramRLYWNlVVN0eFFIcldqanJqNDZ6UWNQTzJTRmxNN3FmSGo2b1dy?=
 =?utf-8?B?QmJSR1dPVFhMWW0yUjdnb2RhNG03Y2NYY1NjcTNmaVZhZFVQdVd5MlA3RENl?=
 =?utf-8?B?bm1Jc2RKZzFaeUs4ZHhITUMxQm9zamVjcHVQT0U3KzNONVptcXc5UWhXZXdE?=
 =?utf-8?B?VTl2b1ZOWUdydHYydndtQzF4czFONGVEK2hvQURQV2gwQjBpZXg4OUJ2a0JV?=
 =?utf-8?B?RjlMcnpMbjBYT0tCUlpkanU1M25FY3hJcEEyUjlnR1N3Z3ZjTWZSYThPa3V1?=
 =?utf-8?B?SHZTRmxzRkdNcTN1YndTRkRqUVF4Y2dTQisyWVd0Y0x6OG1CdVpLbU5NbUU4?=
 =?utf-8?B?MEgzSEZhWWUyaEtFZ3hPc1JuZkpaN2hCaHdrYmZ3TER3Q0VaL3RlMFZYYVJ3?=
 =?utf-8?B?WnB0TWhyUWdkaUU0dWdqOUxoOGowMkVIQWE0NTZDZVRRWEkzQmM0TDFkelhD?=
 =?utf-8?B?RFl1MHh0UlVjYVVJQlpZc1IvZG9ScXo2WHY3a3dSeG8rU1A5dGh1NHBLem9V?=
 =?utf-8?B?Zi9RcVIrUEJxdXlKWnVNc2ROMVNaSHNjdE13S0s3NEpQa01rZ2gxR25MNWJW?=
 =?utf-8?B?Ykp1cXhaZXA1Ykh1c1pDb0dCWkEyV2RJYWhocmhhckZzY3ptMmg5VHJwQ2JS?=
 =?utf-8?B?U1RrUlFJTnpoK0RQM1F0YUFDamhaVlRDcE5oWTl2SEk2QlFYY2pWd2NVQTNS?=
 =?utf-8?B?WkZqK1ljWFJBK0NmNmtvN0RBNXZmZDVrVGJCaExUSXQ5UFk2RWdEZXZWY3R2?=
 =?utf-8?B?Nk5IWjlvVFFUcUxyTWFYd0VlYkk4R0xPdjBoRkxvdmZ5MXNEZ2xvNlBrSllE?=
 =?utf-8?B?VVVVS1RWUjU0RVlFZlVhV2VVdmJGRTBFRkdlSXNqYk5KOEVmaEJ3UGxvNXhB?=
 =?utf-8?B?V1MyekxRWThQWkQ3aVRiYVVUc1NOZ1FZUksxbHdsTlhLaWdTei9HbDlTN1lq?=
 =?utf-8?B?b29wWDE2RTdjUUh2YUh0Y2NsVkVFZ0w5RUZMb3cyaXdUMjkramJ2NjJIazN0?=
 =?utf-8?B?ZzZNaVdQVi9pYkFrTnBJaU1WYkRjVWJlN0JYcHY3ajMrM1BlUnFqaEZhVlNu?=
 =?utf-8?Q?ySCyUtIch4X/ykyRQ5pC96Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jvBaMRd9/db2ud8Iv/DxpAT3hA4mnmxeShPIzHlg/fgttdaapKkJ9PQvkJXjeS7284TOTlCUyldQj4YVlm5N5bphJnQef5ns4O7x3mt8lfex19nhNvDViyo0iZcPEdnIKmhmd1kfoavlKjcmqX1NJScqH6HYj6yEMfhQCrBIWomE72t4lpHHmqFeqmdpbg/yuus2f8rYYiwmFy8p5YHGFdUtQpNs78Lp4XF8d+3ZJYRRCQ0Th50fTHI6BRNacXoKd5cTt6jE7EqVTqA3vg/0+Pv/eKfv4YDHSOE3uHpmQih6vpbgJitedXpzLZD7Kq8XUaVmB3zRcNB2RAB4sUQ+9KI1i+/CnxErib4qyAz4nbrsRH5R+erwvNMcYLRp9dGTj5Qv06DCMhMQSIL68fvd5/R+kuLqAdIwp9alPqS/FYGDS/Eedfi+nnZeha/JB3hVdI7r8gtL1mmxdVQFDkGgzwoTnEc7x9gSdkYQjvmI6EYlV+5Gq7euorKf+gK9mPg57+MU2vkt4diAtf0v7hXl2Ew2CqCeUkWetQc41tm8IUgrciD2u6RRxIH6dVy91a0tu66AvP/1xYDPgyyOHnx41hJ9ClgxsxAuC+zRa/JEVQUe7jikOAQZWVJCU8gNNnFfz2gtOPGn0clb6zBRe5pKsGWDKHvLuRNL5HTZtIY9Z80UdpUieHgEOZRLXj81DF0eHRAFEUMXDoB6uKDzS80HS8ZTLbRlBhihxlsGbAarJDORqn2UAmHwk/tXK2ipWErbrZO/cfsj7hUI3YWCWpF5oV6TChTT38si92INPWsvilo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e3cb25-3bf7-47f6-f657-08db1ef509ac
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:16:38.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvqoHLGZztzHrfC4niKj3sLesFSWSEi+FDrgfS4z1eeN0uV9ff7fpoY/7zrxGkETp2TBTX4mUZgEQ0adWsc3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070093
X-Proofpoint-GUID: TiNNaPJWRdh-H1FDpt7_0n7b8e58aHVH
X-Proofpoint-ORIG-GUID: TiNNaPJWRdh-H1FDpt7_0n7b8e58aHVH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/03/2023 09:52, Dominic wrote:
> Hi, I have multiple eBPF programs compiled into a single skeleton file
> and I need a way to delay loading of one of the programs.
> 
> I am aware of `bpf_program__set_autoload()` API but once an object is
> loaded using `bpf_object__load()`, there are no APIs to selectively
> load a program (bpf_prog_load() has been deprecated). Calling
> bpf_object__load() again fails.
> 
> Wondering if there are any options to achieve the above mentioned behavior.
>

I ran into a similar problem recently; in my case, the problem
was that one of the functions that one of my BPF programs attached
to could be inlined on some kernel versions.  As a result the
whole skeleton would fail on auto-attach. If that is the
problem you are facing, you can try a full load/attach and
if that fails, start again - you'll need to destroy the
skeleton and go back to the open if I remember correctly -
and mark the problematic program using bpf_program__set_autoload()
to false the second time round.

Failing that, is separating into two skeletons and using
bpf_map__reuse_fd() to share fds across both skeletons 
feasible?

If not, can you provide more details on why the delayed load
is required - that might help us figure out a solution. One
thing to figure out - is it definitely delayed load you need,
or just delayed attach? Thanks!

Alan
 
> Thanks & Regards,
> Dominic
