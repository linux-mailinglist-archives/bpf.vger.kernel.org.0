Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F215EDE6B
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiI1OGz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiI1OGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 10:06:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36EA52E7F
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 07:06:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SE5WPS032167;
        Wed, 28 Sep 2022 14:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=m8b9aFxhhvgbMI1GcpAKeYOTV/PWoce1HT4fNW7KSq4=;
 b=h87StKCXADRlBd+eHpY090cB1+uuDxZNZTOQBQkBgwBH9tZBr8rLKhG9I0ho0yEF2Xzj
 7hf5tEp+rkfy6hExsfbPsU5TV7PMi5PkqKr9qMjN5cS2ZKDJvqC0eNMyXG0DkuMiXDN5
 MSoigAu0CWWNDNsCHHKaUuUi9IOa6HT21TBkXgMtDNkxaofvH+/wibRaB36/A+h4MbCJ
 WlqxjdeNNrXokkh4w0UN/jKaboywwnWd15NSxVLxp6C/Nrdpp2oPN9KQ86hn37meJaXt
 M+Q1Jn7NUXRifRHSrFHikYMr/MIDeUwjuFvK7Z17FVIpKM5uZpjCnrrog3A4NIKwZ43G og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0ksrb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 14:06:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28SDbD5e036921;
        Wed, 28 Sep 2022 14:06:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvfbqa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 14:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpYGrFk7AqxkVoLfc9hVbBp+aIH/izs5lLB9l2BSJcvtXie6ENh95bHUVaSSoKIUHfEwKj/g0boJ4ctutLfWmTTueIiW82mlQaDa9oBr8J2yGVmj2kQjNSoN0A37AsRlwKTBPq3hfiE1BETGf4ZMmqhidgWpS5ZAkrKKuYvHAbGqLby7zw++6S3oatBvzdBV7goWGp9G80+Dlo+NBolwi8w7dRyK6uXUtdrDSVkbutX/HLoZHT2p0ZzMu9dG/Ps6vwqerTn54LEhpiAstKm8hxdjb80OlfmaPV7Hkz/P+fum5hDKxK8+Px6oXln5sVrwg93zUmgRoH4Fd3Cn1Hi9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8b9aFxhhvgbMI1GcpAKeYOTV/PWoce1HT4fNW7KSq4=;
 b=hPCBU2kTgXSq5FtwxP1M6CefRZZuAi8iOlswBsBt5RciNQD92Rsy7kYuIKDwImhjD2jI6xMonIemWUvXwk3vGiiqrcV1MlyFMrlsGYA6v6MwltVUis3YDMAPajM/7Uha8NJR3cwFMLxRYl8spPnqkV/Qh/TVlAPpew7cZLrxcHtvV8KL94C6n/zaIeNnwUZaXjv4W1xgHxU1V4xf5Y5a/lsuTFyE5D+OQJcSphmYQ41+/5E/PctyEOYPJHenHWbK+9QC03VJMQ/hDgDenkDyAJDFvewV+PcAcVPsZWk7xRmPnvfzVxNOJodX6NAM3K1gxBXKYVmOPHg4dF9n19M3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8b9aFxhhvgbMI1GcpAKeYOTV/PWoce1HT4fNW7KSq4=;
 b=ThXu9jfYbYNMsSx0rXMSTz9+LunBRxBFetqrJmmBiyFJq95zV78LKsv6jsnlMFysNH2LCVxfo347bJRwXR4dah2MVyuGy8Ll5eX/GbrrCHvZ4/SSPIPVsAJt/dENjqmokzdLCM29c92VW4SGV3nlex2lfGrYHidiIUNuD3UCx4E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB5157.namprd10.prod.outlook.com (2603:10b6:408:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 14:06:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9578:125a:8d2c:7b9c]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9578:125a:8d2c:7b9c%9]) with mapi id 15.20.5654.028; Wed, 28 Sep 2022
 14:06:14 +0000
Subject: Re: [PATCH bpf] libbpf: fix BTF deduplication for self-referential
 structs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <1664292894-21490-1-git-send-email-alan.maguire@oracle.com>
 <CAEf4BzYfU0ajPAHrvJQW+ggFaQ4Ut3eVs6rLjbnjcPwDtEQv6A@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <02af4666-22a9-2d26-8ec9-9bdb1a4d141f@oracle.com>
Date:   Wed, 28 Sep 2022 15:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4BzYfU0ajPAHrvJQW+ggFaQ4Ut3eVs6rLjbnjcPwDtEQv6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: ad77c93b-fd49-4712-1434-08daa15a9ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jiWZuz1/bzKhuaUlhcnyVrKUJgWm0QfK6Pv9LfndTx8JoAKq179ap5iYpKzVbfHIfgjoW8fS83HsaAVapTuYULenKLYP8Um61l1/5N7eCgrrS44SiD7ufTUbFCJ5IVuwDksVAW2RDOan66dl/EEiQHC1A6HZNzMdPF6V9bQnwGtDGKsjXMqY36PTQEBpr9KrMNz9xxU0JzVMDjNYSAucNizuQjFCjpPal8ylGkjfvvlisnf9D48U2/1rx2jUH+vtRQPEce1yLKvKhJ2BxdvEXLbesp/ur8stn/09Or1Wwjo+7OyEMgC/LFKoiclz1Yo7uxA3Mkv8BPgfSOSouOI39uz4xB5M1K+n+HTu9S9leu+NIQgAr+Swvc1xDp3iIvO83A5vidFEnwYBurkYL4UKmscKMg0y8BCUPkbqb95AFxb8S4Gq0VP8hIu/sS74sK4eN7jQ1PGc4BrW0fLbzC1jWKMmvkinwtxCpO4Z5VJARFyap5vKpeN52WtiMYQWnniz4Hj+Jt352Eb0QCKN+dGS1PHf3a49OIad9xW7UvRu++2dypFW/H0ex3lfD5Hc07xGDFInchyEpOeezCtGFlFAybdRQ3TiL1jpRl67eh1k9hkaCRYgquHd2+LKXz0Mlg3tjS2Fs4CWHEKuKR9TNKJ0WpTtCaRJw3GOAyEdRO1xotYbXdwNDJSHC8XusVPZ4n/TZN3BM3JviS0KamyYpPmtxW6Zjhdu5FwxPtGU0B/+1mZiUK/PjnMVU3yzgXLlM1/OtZidwmjxrRRK8eAThit9Lz5bYnRZDAl6ADnJE2mKFf2HzXIdw4G4k12IgYk9iwL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(86362001)(31696002)(36756003)(2616005)(38100700002)(8676002)(66556008)(66476007)(6916009)(66946007)(316002)(4326008)(44832011)(186003)(8936002)(7416002)(5660300002)(41300700001)(2906002)(83380400001)(966005)(6666004)(478600001)(6486002)(6506007)(6512007)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5nZ2RXWGJQUXI1di9LMDdhYmxQOEtrTmI5ZDAwZUt2cW10Zm9ERWNFZjRj?=
 =?utf-8?B?WW8yVHl4L3ZwcHFQSXVLak03b2tKVkI4amYwYWRaOWxCZVg4ckxtWWxlOUxv?=
 =?utf-8?B?d2NwUFhCekZRc3VxbkI1SnF6c2JXS3NHVnVucHBUcVFPeVlyY0lGNjZYOU92?=
 =?utf-8?B?Y0l4anFEdXdGSFhzUHE1VFg4NnRxQ3dPeE5SVjdqSXhpb3dROER2Si9DeWJR?=
 =?utf-8?B?WVVZZmtqSnV0WFdxaHc3UGRBMkY0RTVnazFnUXJFcjdtTmJqMDRNdTVpQ2ov?=
 =?utf-8?B?ZklZZWtOcXpHQ1ROQXBDNzhNZnZXcDNkV2tGOXlaQ3VWODN5UDJoNHFuVTA3?=
 =?utf-8?B?VmpPSGIybVNTOG5sMnoyZTIza0FWZjhzSWRDbkV0MWRPT0FFTHFGU2NOVG9K?=
 =?utf-8?B?Yk5zTCtrVVVSU1pWTWJwcmJ0dGlUa0dGQ2l2d1Bnakg1ZitLZ09Pa3laZ1px?=
 =?utf-8?B?V0cxdE1kcWFwb0ZqWTFHN2JEZitwMS9tbWNFSzZmRUFQRmpBS2UzR2U1ZTFl?=
 =?utf-8?B?OFNnQlc4aG9xaDloOUZUM1Q0dHEyRXRoSHZ0bEh2ZnUreUZUaDBEak9ZNUc3?=
 =?utf-8?B?ZnZwZXBOQVI5MU1lVE1QandZcUltb3NhOFRodUQ5OC9nWW1uTWh5UWxTcEdC?=
 =?utf-8?B?dldVRUkyQ0g4NFhOODRIcmNNQ0s4eWtVcVF0WTU3cHNRSFZXSVhYMXFWV1Zv?=
 =?utf-8?B?RG9FSnRaOXpWb2ZFTGJjZDgyU1hNTGVQb0xad2JTVWhoaTBRV0Rzcm83Z1la?=
 =?utf-8?B?YUNndWxGNzJxNXhZc08veWd3ZGN6OTA4V0E3M1BlZGF1U3VKSUpUNysrenFJ?=
 =?utf-8?B?NzVTZVJMSVVqaE1MaHpqSG9uUlR5d0pJNk84akdSdnkzS3lPeFpIaW5VUEpY?=
 =?utf-8?B?VUIwa2dZY29FSlEwd2lYN0dnaklvZ1AzRE5lRW5CemlSMDNBaW5wWEtiUFJN?=
 =?utf-8?B?NmdZL3lUeHZuRlVSYW8yKzhDZDZhU0lSU0JmY2ppSU40cFhSMjJPcGpEaTNW?=
 =?utf-8?B?M3VUWDhScy9UMXhuUno1NG0yaU1VZjl2VjY2ZWJRVTVMWDkwcW9rSVFpSUJi?=
 =?utf-8?B?T0ptbURXYXRXVEEwSCtXRUJRd21JZUhhT3doa2ZlNEYvaDN4VUx0Mm9JU3RM?=
 =?utf-8?B?Slk1bUVKQ3Y2TjdGSjdpeGZ5QS9udjZPQUNjenhvNTBMaWs0Z1U3OE1EdWxI?=
 =?utf-8?B?V2UycHcwSGloN3c4UGovc2RiYnR3K2tOZjVqY3RVK0F1R09ZYWliRm9GeDlz?=
 =?utf-8?B?SnQ3TjJ6TmlTTXN5MkUzNDJvU2EycmR3QWlnT05sMjVrL3hJaDFXeHhxd3RT?=
 =?utf-8?B?MWQ0aEFycTlnR3NUekVrSHZOMER2UkV0amlmbzNWbmxqcDlRU1Z0ZHZlVktV?=
 =?utf-8?B?SmpVSTBuSG1LLzFnT0ozT1QrOEFDc2xxYUtoRVdFb1JHMUFPNDB3WGF3a2hK?=
 =?utf-8?B?YklKdmhpb21WalVQYVI3VzdDdE9Pa0I4R3U3dXJrR3Y3UHBIWFBjWTQrN1ZT?=
 =?utf-8?B?ZGNVMUFqMnorK1R2cGcyNkZqK3VQRjRIRTRXV0YrQlJHZlNTR000aVhNU1Vl?=
 =?utf-8?B?d1I1WGgyaEFvSlJXN21JQ05uZWV3UmJ2dFBhbGlMY2c5S3RHazNLTlBqd054?=
 =?utf-8?B?VVRkOTZEaU14QUVCUGtzSUVqRng0M0N2RmhtYlNNQ00vK1FldDlZWnluME1I?=
 =?utf-8?B?NUduaHphV2F4L0laMjhEcGxnRDZraUpPVTBWdkkyUURsV2R4SnlMRTdxRzJ5?=
 =?utf-8?B?cEcxbDd0MnNlL2FZd1dxc1UxblpZU0FGRkxoOXd6b1ZaZmhTaGRNRmc5RkJQ?=
 =?utf-8?B?dWNOMWM3NjJSdXlsbWpjbllRVWpiS3h0K2c2ZkZqYTVtMXVOVlFSUFgvVk1G?=
 =?utf-8?B?VXlhbXdBb0JPQmtKTnJFTEg3N2dYeFBOWHZGdUV5Tk1EK2JRcVpuUUNUNmc2?=
 =?utf-8?B?bmZ2WER5QmRhYVB3bnNkTmZNWS8wQ0tpUE1rUVNCZmdKdzNmalFEOWNVOU52?=
 =?utf-8?B?bUgvQWxOYTRpWDdRbW5ZNGdMSk5iOU9Kei9ZMVM2UDhlSTBMQk9JNlN3SFRv?=
 =?utf-8?B?OFp3NkNLeWo3SWZPZFQ1cGZocndtakE3V1BLOU5ocG9jMzJQN1NGOWVEdzRv?=
 =?utf-8?B?RFpHaU5jdm9XcnVFRlFPV2daQlJnWGNpUWdlalNPSDVtdzNVQmxJSjNxTS9j?=
 =?utf-8?B?Y016VnYyZU5EemRJRm5ySU9WcmVkc1g2ZW5FM0ZjMUV2cTE1N2swNGFTcTN3?=
 =?utf-8?B?ZnRzR1lRdTNYUnQvNVRBSmxOMjV3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad77c93b-fd49-4712-1434-08daa15a9ae3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 14:06:14.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2iIfwVhb0j3Ncj30owmyRlqQLBDkGbrGpSiC+FiLQclBwtdrT1jRDLdL7dF5Chzf9EHzLMPgSBKFw50GjrzDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280085
X-Proofpoint-GUID: R0ddbwE_VOtNxhsz_EGRa4VYfuoTGb5V
X-Proofpoint-ORIG-GUID: R0ddbwE_VOtNxhsz_EGRa4VYfuoTGb5V
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 27/09/2022 22:06, Andrii Nakryiko wrote:
> On Tue, Sep 27, 2022 at 8:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> BTF deduplication is not deduplicating some structures, leading to
>> redundant definitions in module BTF that already have identical
>> definitions in vmlinux BTF.
>>
>> When examining module BTF, we can see that "struct sk_buff" is redefined
>> in module BTF. For example in module nf_reject_ipv4 we see:
>>
>> [114280] STRUCT 'sk_buff' size=232 vlen=28
>>         '(anon)' type_id=114463 bits_offset=0
>>         '(anon)' type_id=114464 bits_offset=192
>>         ...
>>
>> The rest of the fields point back at base vmlinux type ids.
>>
>> The first anon field in an sk_buff is:
>>
>>         union {
>>                 struct {
>>                         struct sk_buff * next;           /*     0     8 */
>>                         struct sk_buff * prev;           /*     8     8 */
>>                         union {
>>                                 struct net_device * dev; /*    16     8 */
>>                                 long unsigned int dev_scratch; /*    16     8 */
>>                         };                               /*    16     8 */
>>                 };
>>
>> ..and examining its BTF representation, we see
>>
>> [114463] UNION '(anon)' size=24 vlen=4
>>         '(anon)' type_id=114462 bits_offset=0
>>         'rbnode' type_id=517 bits_offset=0
>>         'list' type_id=83 bits_offset=0
>>         'll_node' type_id=443 bits_offset=0
>>
>> ...which leads us to
>>
>> [114462] STRUCT '(anon)' size=24 vlen=3
>>         'next' type_id=114279 bits_offset=0
>>         'prev' type_id=114279 bits_offset=64
>>         '(anon)' type_id=114461 bits_offset=128
>>
>> ...finally getting back to the sk_buff:
>>
>> [114279] PTR '(anon)' type_id=114280
>>
>> So perhaps self-referential structures are a problem for
>> deduplication?
>>
>> The second union with a non-base BTF id:
>>
>>         union {
>>                 struct sock *      sk;                   /*    24     8 */
>>                 int                ip_defrag_offset;     /*    24     4 */
>>         };
>>
>> ...points at
>>
>> [114464] UNION '(anon)' size=8 vlen=2
>>         'sk' type_id=113826 bits_offset=0
>>         ...
>>
>> [113826] PTR '(anon)' type_id=113827
>>
>> [113827] STRUCT 'sock' size=776 vlen=93
>>         ...
>>         'sk_error_queue' type_id=114458 bits_offset=1536
>>         'sk_receive_queue' type_id=114458 bits_offset=1728
>>         ...
>>         'sk_write_queue' type_id=114458 bits_offset=2880
>>         ...
>>         'sk_socket' type_id=114295 bits_offset=4992
>>         ...
>>         'sk_memcg' type_id=113787 bits_offset=5312
>>         'sk_state_change' type_id=114758 bits_offset=5376
>>         'sk_data_ready' type_id=114758 bits_offset=5440
>>         'sk_write_space' type_id=114758 bits_offset=5504
>>         'sk_error_report' type_id=114758 bits_offset=5568
>>         'sk_backlog_rcv' type_id=114292 bits_offset=5632
>>         'sk_validate_xmit_skb' type_id=114760 bits_offset=5696
>>         'sk_destruct' type_id=114758 bits_offset=5760
>>
>> Again, sk_error_queue refers to a 'struct sk_buff_head':
>>
>> [114458] STRUCT 'sk_buff_head' size=24 vlen=3
>>         '(anon)' type_id=114457 bits_offset=0
>>         'qlen' type_id=23 bits_offset=128
>>         'lock' type_id=514 bits_offset=160
>>
>> ...which, because it contains a struct sk_buff * reference
>> uses the not-deduped sk_buff above.
>>
>> [114455] STRUCT '(anon)' size=16 vlen=2
>>         'next' type_id=114279 bits_offset=0
>>         'prev' type_id=114279 bits_offset=64
>>
>> Ditto for sk_receive_queue, sk_write_queue, etc.
>>
>> sk_memcg refers to a non-deduped struct mem_cgroup where
>> only one field is not in base BTF:
>>
>> [113786] STRUCT 'mem_cgroup' size=4288 vlen=46
>> ...
>>         'move_lock_task' type_id=113694 bits_offset=31296
>> ...
>>
>> and this is a pointer to task_struct:
>>
>> [113694] PTR '(anon)' type_id=113695
>>
>> [113695] STRUCT 'task_struct' size=9792 vlen=253
>> ...
>>                 'last_wakee' type_id=113694 bits_offset=704
>> ...
>>
>> ...so we see that the self-referential members cause problems here
>> too.
>>
>> Looking at the code, btf_dedup_is_equiv() will check equivalence
>> for all member types for BTF_KIND_[STRUCT|UNION]. How will such
>> an equivalence check function for a pointer back to the same
>> structure?
>>
>> With a struct, btf_dedup_struct_type() is called, and for each
>> candidate (hashed by name offset, member details but not type
>> ids), we clear the hypot_map (mapping hyothetical type
>> equivalences) and add a hypot_map entry mapping from the
>> canon_id -> cand_id in btf_dedup_is_equiv() once it looks
>> like a rough match.
>>
>> when we delve into its members we recurse into reference types
>> so should ultimately use that mapping to notice self-referential
>> struct equivalence.
>>
>> However looking closely, btf_dedup_is_equiv() is being called from
>> btf_dedup_struct_type() with arguments in the wrong order:
>>
>>         eq = btf_dedup_is_equiv(d, type_id, cand_id);
>>
>> The candidate id should I think precede the type_id, as we see in
>> function signature:
>>
>> static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>                               __u32 canon_id)
>>
>> ...and with this change the duplication disappears in the modules.
>>
>> Fixes: d5caef5b56555bfa2ac0 ("btf: add BTF types deduplication algorithm")
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index b4d9a96..a4ee15c 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -4329,7 +4329,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
>>                         continue;
>>
>>                 btf_dedup_clear_hypot_map(d);
>> -               eq = btf_dedup_is_equiv(d, type_id, cand_id);
>> +               eq = btf_dedup_is_equiv(d, cand_id, type_id);
> 
> Unfortunately this is not the right fix (and CI points this out, e.g.,
> at [0]; so yay tests). You got confused by candidate terminology. In
> btf_dedup_struct_type we iterate over candidate types that could be
> canonical types. So what is cand_id is meant to be canonical for type
> identified by type_id. And type_id is pointing to a candidate type as
> far as an equivalence check goes (that is btf_dedup_is_equiv()). It's

Ok, I _think_ I understand. So the cand_id arg to btf_dedup_is_equiv() is
the one we hope will - through deduplication with canon_id - get eliminated. 
So here's my point of confusion then - when we do the hypothetical map lookup,
why don't we do it using cand_id?

I'd assumed the idea was the hypot_map could be used to map candidate
types to the suspected canonical type, i.e. "we think this candidate
type will dedup to this canonical one". The code semes to use the 
opposite mapping, getting a hyptothetical type id from the canonical type,
for comparison with the candidate. I can't figure out how this helps
deduplication yet though, would you mind explaining this?

This possibly explains why my "fix" worked better with self-referential 
structs; with the arguments swapped, we actually used a mapping from
candidate -> canonical. At the top level of the struct traversal,
this mapping was established, so when we later reached a reference
type which pointed back at the struct itself, the hypot_map
considered a self-referential pointer in the candidate equivalent
to one in the canonical type (since the hypot_map pointed the
candidate type at the canonical type).
 
> somewhat confusing, but really type_id is a candidate we are trying to
> dedup and cand_id is a *potential* canonical type (there could be
> multiple potential canonical types due to hash collisions).
> 

Yeah there's definitely something going on here, but I'm still
struggling to understand the dedup algorithm so I jumped on the first
thing that looked like it might explain it. With respect to the
test failure, is it possible that we're getting a better dedup?

Specifically, the test that fails is

VALIDATE_RAW_BTF(
                btf2,
                "[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
                "[2] PTR '(anon)' type_id=5",
                "[3] FWD 's2' fwd_kind=struct",
                "[4] PTR '(anon)' type_id=3",
                "[5] STRUCT 's1' size=16 vlen=2\n"
                "\t'f1' type_id=2 bits_offset=0\n"
                "\t'f2' type_id=4 bits_offset=64",
                "[6] PTR '(anon)' type_id=8",
                "[7] PTR '(anon)' type_id=9",
                "[8] STRUCT 's1' size=16 vlen=2\n"
                "\t'f1' type_id=6 bits_offset=0\n"
                "\t'f2' type_id=7 bits_offset=64",
                "[9] STRUCT 's2' size=40 vlen=4\n"
                "\t'f1' type_id=6 bits_offset=0\n"
                "\t'f2' type_id=7 bits_offset=64\n"
                "\t'f3' type_id=1 bits_offset=128\n"
                "\t'f4' type_id=8 bits_offset=192",
                "[10] STRUCT 's3' size=8 vlen=1\n"
                "\t'f1' type_id=7 bits_offset=0");

Reconstructing from test failure output, the actual BTF generated is

                "[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
                "[2] PTR '(anon)' type_id=5"
                "[3] FWD 's2' fwd_kind=struct"
                "[4] PTR '(anon)' type_id=3"
                "[5] STRUCT 's1' size=16 vlen=2"
                "'f1' type_id=2 bits_offset=0"
                "'f2' type_id=4 bits_offset=64",
                "[6] PTR '(anon)' type_id=7",
		"[7] STRUCT 's2' size=40 vlen=4"
	  	"'f1' type_id=2 bits_offset=0"
  		"'f2' type_id=6 bits_offset=64"
	  	"'f3' type_id=1 bits_offset=128"
		"'f4' type_id=5 bits_offset=192"
                "[8] STRUCT 's3' size=8 vlen=1"
  		"'f1' type_id=6 bits_offset=0'"

So the difference here is that the two struct s1s were 
deduplicated, whereas they were not expected to be.

Is that a valid dedup? I'm not sure, but the s1s shallow
match on size/vlen/names, and certainly the first
member is ok, since in both cases it's a ptr reference back
to the struct itself. The second member is a pointer to
a fwd definition of struct s2 (type id 3) in the case
of the first s1 struct, and in the second it's a pointer
to struct s2 itself, which I _think_ are supposed to be
equivalent?

> So there might be a bug with dedup, but it's somewhere else.
>

Is it possible the hypot_map usage could be the real issue?

Thanks!

Alan
 
>   [0] https://github.com/kernel-patches/bpf/actions/runs/3137048529/jobs/5095008504
> 
>>                 if (eq < 0)
>>                         return eq;
>>                 if (!eq)
>> --
>> 1.8.3.1
>>
