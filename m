Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDA6B7DCA
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 17:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCMQio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCMQi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EA2129D
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 09:38:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DGY5tL012809;
        Mon, 13 Mar 2023 16:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5ZuSeTNSGe4DxIQeH4cnOzhs8aFeEhhRk4mr63sJ1jw=;
 b=gSnWutWanJ+4ERcKgTnDsUR6d5psiOKnaVwKabcpTFT+I7KH5OYlT5eSTHKUjGr3zDUz
 VrWfYGz1Uzsp7/aCsFQn/CAHG5J2IXOFJsgCzLttJTITUcfDPAVAjzzWtCDtTNlcBk61
 5yNZKCvNpws6dilDIAPZ2YfBPQycBt/9/ZvWtlCNQyq81OQu8yKfIQJDga2LHmAKbYFD
 eGczEMV6aOiSKC3GZMXoz9wiU68bOlGtZyopDDx5WfeEC9/GX+1fF9VKXuHbQhFC6C2X
 XwYFeM9uStciaztdpFncx/LOepN2f+nFsqIDqPBZrLwrpNBUMcM1baSNcxVPVmK3dIQD Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hpcv9k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 16:37:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DFPv67002422;
        Mon, 13 Mar 2023 16:37:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3beqw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 16:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTadY54Sn3rcW3+CEwUJ1L/NmmpYp7u+92V6lf66cQDhp9Qsb+4hSocy2zJMKCgPZrJVfATHiMSQRjl0PoNRNsBICOlQUfQJPYbVmYVz2mxC2Oxusakh/mdR218LoxnFyS6zfGxTxr31H2R73W8hQpADfdwQUDruQr0opHkUWkoSoZnwtrOcwxzAmj5ou7cXJBMeZSvBCeDfiFM/40Hx7AKwW3rCJh/aVeEDpnQZSU0IvrIOshCywwvhWCHwfTHtdrLE5BBzTtDKddEy7gl3CApFDcNcjEAYuuBWbyJ+W4XKsq5QTHbFmGIlvcvKRZXWeXZu+X5XMU009UHpCSrhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZuSeTNSGe4DxIQeH4cnOzhs8aFeEhhRk4mr63sJ1jw=;
 b=Z2jeIKEugv8NXylK9nlm+95KO6to0O8dfuLm6uMEURKTmnBaY4X9ZFH2ptNLAd4V2e4CN7QeHvxoaPyoHkHpM+E2/rLS5i6qPS92sdVaLlaV4i0Xm7t1XtT5CGYPzDnatq370scPQtGMSGH3WLx/6oSCYh4f8CDCpoTTOOvB/vzoADqTrTE/vvoqjAbX6Ss8m4X3chMnBp1R+YuqEO0JzpsyFZ6IZEjCAPUXf26Xyhg7SHw3wEP40OI/NqZsXv7EXHAKNOvki0E6era/gvSwDOjkia4cDNQeIrF0OSAdqx6pvip471muj1ZEAQIjCyENA3HPfQ9QyH5LCFDfeJi+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZuSeTNSGe4DxIQeH4cnOzhs8aFeEhhRk4mr63sJ1jw=;
 b=RNKKThoIHAwGQRq+ZWCpBGyv0Ram1yNX335H1AmEoubu1/t0WG+gfdsfvknBIHOB+PTLQnOgRwwdLMXeNy05nFhTvgXW2A6vHjX/ib7qhzrmnFuFJr07ZmnVfXMjs92UMaVAMn4oZF5m7EKjeoFAgtgjjv44mmfwehzGcgfnO+c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 16:37:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1c91:fd13:5b72:4be6]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1c91:fd13:5b72:4be6%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 16:37:40 +0000
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
To:     Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, sinquersw@gmail.com, martin.lau@kernel.org,
        songliubraving@fb.com, sdf@google.com, timo@incline.eu, yhs@fb.com,
        bpf@vger.kernel.org
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
 <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
 <cba295426f5bd157688b3393a4f528df06d2eca5.camel@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <157b8d32-4628-4b78-a587-c492946e5e10@oracle.com>
Date:   Mon, 13 Mar 2023 16:37:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <cba295426f5bd157688b3393a4f528df06d2eca5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: df288518-a133-4966-8b48-08db23e14343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7XAgdx5zQODhbr90Av3JIeNO4nHweq1FNBlAza+uXLLEDu0ErnPTqofHRxoE2urmk+Kd/uRmklZKXM3GURTyoM7W1Th6p/GvcCyCK1JLwo7kMX8UsDfu9zQoe7iRddHMQxAfHUPg1Dfd2Nee6mAPLocp2pZFd1/SCatSPbIa6UKO0cESsZAZwV1MQw04gECyNQ1adgLh+1l8Sv7Rt/UxigcOSJ6MHj0oyFd67/GH19PI6K/hNh6OiAlEzpcP8A0QdU5FQL2EjBD3Kgc80tQdqlTEyXFj6krxnTnkhfs6gJKpu3uBau8hh/c3Oz7hSg6xS2Y6kjf6ZFFxFcoG/NlmHXROWzVAd695zRTVYBubIqBac1VRK9paRxL8RYWunFIIse/Y7pinFR2zSEudyJ++3k9ZQ87Yd7lIG8dBQpgj8JDlsmoheH68XOfcehWsflpYYzY7U0vJzNkn80aZW8UYuBUXaMNOxyqY3x/AjLyDVUriN95IWiEdiEAB2vr5bG8k8pSgbnE8BOrpGEws6BsuhTNFF+ehFytLygV/L37Dwq6wv0upX3a2/Ee3oQTDaIB6ANJx476dNpHp9EntlpyG63OVex4A2nTHCbeQBmka08QLiBFYnCu6NnyZNYEghMPuTP4o8HTkdEbuMOAOpWtgNAGkr8FYxlbXsbWU1JXdP2qq6ORVL9aqUcwvKP/oEXtLiM/skHuZ/2cVJUEd8b3JkBBALieWbN6XbyvBl0pwcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199018)(6666004)(83380400001)(38100700002)(316002)(478600001)(8936002)(186003)(6512007)(8676002)(6506007)(36756003)(5660300002)(53546011)(66556008)(66476007)(7416002)(4326008)(66946007)(86362001)(31696002)(41300700001)(44832011)(2616005)(6486002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC9rWW1yTG1BeHAyR3pXQVVDdFh0L3dXeDJQU3JwZ2dlRFUwU3pXeHQ2TGo5?=
 =?utf-8?B?ejQ2d1djR2JvcmF6c2pWZHRoekI3alE2MzlHN0xYSHV2cTZxeW5PSEFBT3hR?=
 =?utf-8?B?T2FiOW42ZExudjd0NVVjKzF2bUtRcEk5QUZCRHBaUjc1SjhSMzhjSk12eVp2?=
 =?utf-8?B?NTZWVm9QQ2tyZDVETEhyV29vbEJlVndKUTg4bU1TbXZ6SDNOOHd6R3pSZGor?=
 =?utf-8?B?aU10RFlsNlRpNFZRRzVlUFkwWWdoRWFUeis5RXYwcHMrVWFpRnJZTEg0c0pW?=
 =?utf-8?B?U3VURndsTC80QjAzTFRySk42dHZ3WXlOVG5RODR2TTlUSlZjd0YyekxmZzFT?=
 =?utf-8?B?U1lWc3phWGF1azZYWk1WdDVWUElSK3ByN1dCaWxvd3ZNTGJwQWt6QjNVbGZ4?=
 =?utf-8?B?R1RCczFIZ1phYnJQc3lrU0VHdHlxbDRjak5MUWpFR2JmalladkNsMXZjY1dH?=
 =?utf-8?B?dGF1MTBtN1VlbTgwVnNPVlJhalN3dlZtQllPb1UvZGExckJwLzJFdkZjWEJn?=
 =?utf-8?B?eEZoZUNBMTh4YXp0OGwzZ2ZqdnhNNXNSVzUzVDBGUlM0TkRaMzhiM2FkUlJ6?=
 =?utf-8?B?czlGZWVNZ3VSNFZGTFREdWQwaWdpZG81bjJXSWtEODQ3VFFYN2ZtUmpFa0l1?=
 =?utf-8?B?L1hySWpRT3F1L1A1eFJHV3BCNWNtd1dYRmNaMU13NXRucU1lV1hpMUdwSVAz?=
 =?utf-8?B?QUo4UnlzaW04bVZoQlE4M09UemJOaWFic3FPcWt3bk9UQTc0TWd4ejVteUsw?=
 =?utf-8?B?ak9qTnhXVW5SMWoyRjNYS3dqK1hPV2NBZjZxdUc5ZTdTL2sxWXFISFVpa0RT?=
 =?utf-8?B?QkVoeHExQ3NGanVEaTc0cWpXTFoxbk42Z0Z5RVl6YXI1RHlvOUF6M1hxWThn?=
 =?utf-8?B?Y3p4NFVwT3RuRVZUbWMzc3RZTlkwQnBUeDJUd1UrMGE5V3l5RzBiR1VIa3VQ?=
 =?utf-8?B?RjVmbVUwWTIvWGp4YzNycnZmbzlHZmdQUUxBOEVYaUgxemdJbzdEeXQvNGEx?=
 =?utf-8?B?ZzV0SWVBL21GVEV3TWNYa3FsdVI0dEFGeEl2S2RBWjF4dXZzZUxBdDIwOE5M?=
 =?utf-8?B?VnROVjYzU0loTmZmUGtzZmlmb0k0ZXl0QlkwV1BoYWdYNEpXT2dwaG9ER0dj?=
 =?utf-8?B?U05xQ1NEZHR0WXpOU0xiMTVMbllOMmxqTUloNHJaTGpjT1Z4YW9BYm8ycis5?=
 =?utf-8?B?VlJGQkhiU3U5V1JCMzJCN2Y2UktZYkpNaHl1Nm5tdGRkM0RySC9OWDhtMEFo?=
 =?utf-8?B?SkpzUS9kZVB4eUI3cDhuSWxpYnRpdHp1WWhmQytwOVRFQi94ZXQvRlk3UEZn?=
 =?utf-8?B?TTFCd2JMTkxJVHNkL052UjVQNnAvbG4xZ0pPU0QzbkpGMjhST2MxRnhRU3hO?=
 =?utf-8?B?cXk2RlFTUG5pTjJ4TEhRNmF1NlV5T0hPNkprOXlKcnl4dllsRytFTEo4b1d4?=
 =?utf-8?B?T1J4T1ZrWTMwcVNkd1JOb3JVV3E1MFVsNFo3emt5Z2FvVDdPRk1WdTBvaTRo?=
 =?utf-8?B?cXBlOG95N2diZzB4dWorcFRYbVAzK1dBQ01HT0JySEwvc3BvVG9yNE9jWEtV?=
 =?utf-8?B?K1MzVThqVWxXZVc0alBWTXRoYmJ6U3dud3AyRG1mT1VDU29ZYmk2WWxSaUh5?=
 =?utf-8?B?TmkwN3luRUQxcDhaYytWNHpkY2tXcks1L0o1MFEreVFRNG9tZWNyVURoaW5W?=
 =?utf-8?B?TmczRjNTVzV3MGFNQWlhVmlBejdBdHgrN1l3andCMHJVdDVGQWVxRFQ5U1Vu?=
 =?utf-8?B?ejdta1IvNm0vNC90SUNuKzI2RnRwd2FUTmVsOVg1RkFsNVZvNFJsUjFGYmhP?=
 =?utf-8?B?VFQwd25sbmpYazlYYkdKSEREb0NBVTI2V2llL2RHTFRRQ0VBVE5mb2tmTlVY?=
 =?utf-8?B?VnlTNWp4ZWRMeHJpWFFYRDRsZ0E5S1pIRkhJdHZaRnlUZm5FL2xTeEsrQjVz?=
 =?utf-8?B?dFVTTXhiZHFnb2tmZCtXenAxS1dNbk12RS9ZRWpOd0RXbkxyQUJrOE42eEls?=
 =?utf-8?B?em13YVBsTkwwZ1ZIMjl6YnhXRk0wR0VBWWYxSVExZGtDcEU4MjVGWkVhUnFQ?=
 =?utf-8?B?c3NzbjMxTHZSbTY3NVJLbzlJL0ZOS3RFTzhGUm5QOUdaeE5OZWp0OXdIVm9X?=
 =?utf-8?B?TXhLbFo1b0NqRWxadG1LWkI5ZktGVTVKdEpXR3ErUjhLS1N3YTJLZ1JKTTBK?=
 =?utf-8?Q?Eg45+zjwx+d0WqvbOtTvn2g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NkoyY0dTRkZYNFVxNC9rSnZBRW9HVGxQZE8yZDA2dFZYSnJRbVZ6UjRBQ1cx?=
 =?utf-8?B?LzdTZHJWMklRVXFjT1Z6UlpUODNkMi9ndFBUbU1aUktUUUMzYmVsY2lEb1Nv?=
 =?utf-8?B?N01JWHlVbmdkSWRRVSs0NnUzUkNkVlhvRXBxU3B5VlFLQzNNeGJCSUlzMkRX?=
 =?utf-8?B?RHBodXpMN04xQW9kY0ZWc3g5SzhOdkJ3eDU4VVZYSjdNVlQ4alovNCtHaEpZ?=
 =?utf-8?B?QWpHSEEzYlU2Y3JocEFpaWJjZkRHRUhWcVd6RjBrUHk1Q1NIK2RJbTJkanBl?=
 =?utf-8?B?M0hRcFc2bFB5RW52RUhoM2c2Qmh0MUlXVE41ZVMrbXBwVjFRRGJCb2xZeThR?=
 =?utf-8?B?Q2NGV2dpdFgxVXd5d0tRNUFwVno2MEhMZmlXMU1Xa2g4cjZyeVlZZFVQRkZr?=
 =?utf-8?B?VVM1dzJZdjdwV1Q4TmU5NlFOdmtFYWs1YkR2TTl1dDc1aERyVVBlT1VPeENI?=
 =?utf-8?B?Y2FRZEFuTGt0OFRPaEZUYVgwYkNINHRubm11MitUSEE3R3RrU3YxczhDNEo5?=
 =?utf-8?B?QnlQa0NMSGlRVU1GT1NDT3JwUHprMnFVa01YNDYrU1ZoaGJrZG53ZE1MVUFK?=
 =?utf-8?B?bUtEb0tMQ2N4VVpTdWpzRW84VUFqdllkSDBuOVlOM3FPZ1dTb0t1TUZyQ1dX?=
 =?utf-8?B?OE55anlmNHdvMlhITUpWakNDek1MU1dOZWdHZFo3YXl5TThFR21BU3pGUFlD?=
 =?utf-8?B?OWx0MmkwenU1aWJJUTNoWDdUbFRBMHRBelJnemRSVTVMVDRDKzdNc0todWJY?=
 =?utf-8?B?dXE4aDlLTFcrOWs2WEF3ekNlNkZjZ0swOVh3SklBTDErMXRRaGIrSVJkbWRy?=
 =?utf-8?B?d2NlOXpIekhhdmtZREZpNHlINy9sY0d0aXlPRzE4SnNpMitxd016NCttM055?=
 =?utf-8?B?UEZxSTZaMlVpVkpWWC9pUm9CL2NxSk1takh3STYvWnR3YXBRQ25iRFNUV3pI?=
 =?utf-8?B?K3pkR1dvR2F0SUVIaFhHYUhEeUtlZUJXN1NDY25GNVV5ZWV0YUoxTTFjWmcy?=
 =?utf-8?B?MUF3Vk5xVmgrWGRUdlRVdDlpcGdEMUFxZTl2TlJBSXhWcjBobkUwd1IvS1I0?=
 =?utf-8?B?aS9PRlE5Z0NnejVWd3kyMUE2b2h3ZmhkUHJsSjNRbkUyd0syUnZKUWY2bGpW?=
 =?utf-8?B?cmZUaGV4OEtXdDlDTC83eit6SnJHMkxzL0VTMnErZDFjOVZyVjFRZTBGTlgv?=
 =?utf-8?B?S0ZCQWlpUHppUzFkcEVIMWNrL2JsWVJOQ0FETzZhQm5QTGRsQURWcWJnQVJu?=
 =?utf-8?B?a3hBY2F2cWtBWTlHU0sxZlZnbEQ1a3VjclU3b0lSeWRGc3pHUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df288518-a133-4966-8b48-08db23e14343
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 16:37:40.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YYruhXYeDpEgLQlbBjIXPWMmywSkeVScTaXe/e39VplcRJb0sEOOwJ6be9t5sl04djg2PtIlx4MtUjEB5IDsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_07,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130129
X-Proofpoint-ORIG-GUID: 9NBGRyYN0kdIkl0AC_g7cq_eVugSvNKA
X-Proofpoint-GUID: 9NBGRyYN0kdIkl0AC_g7cq_eVugSvNKA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/03/2023 13:50, Eduard Zingerman wrote:
> On Fri, 2023-03-10 at 14:50 +0000, Alan Maguire wrote:
>> When doing BTF comparisons between functions defined in multiple
>> CUs, it was noticed a few critical functions failed prototype
>> comparisons due to multiple "const" modifiers; for example:
>>
>> function mismatch for 'memchr_inv'('memchr_inv'): 'void * ()(const const void  * , int, size_t)' != 'void * ()(const void  *, int, size_t)'
>>
>> function mismatch for 'strnlen'('strnlen'): '__kernel_size_t ()(const const char  * , __kernel_size_t)' != '__kernel_size_t ()(const char  *, size_t)'
>>
>> (note the "const const" in the first parameter.)
> 
> Hi Alan,
> 
> Could you please share which command/flags do you use to generate the
> 'memchr_inv' with 'const const'?


sure; try adding "--skip_encoding_btf_inconsistent_proto --btf_gen_optimized".
I was testing with gcc 11.2.1.
 
> I tried the ones used in 'btfdiff':
> - pahole -F dwarf  --flat_arrays --sort --jobs --suppress_aligned_attribute \
>   --suppress_force_paddings --suppress_packed --lang_exclude rust \
>   --show_private_classes ./vmlinux
> - pahole -F btf --sort --suppress_aligned_attribute --suppress_packed ./vmlinux
> 
> But don't see any function prototypes generated with 'const const'.
> 
> On the other hand, I see it in a few structure definitions, e.g. here
> is original C code (include/linux/sysrq.h:32):
> 
>     struct sysrq_key_op {
>     	void (* const handler)(int);
>     	const char * const help_msg;
>     	const char * const action_msg;
>     	const int enable_mask;
>     };
> 
> And here is how it is reconstructed from DWARF (same happens when
> reconstructed from BTF):
> 
>     struct sysrq_key_op {
>             const void                 (*handler)(int);      /*     0     8 */
>             const const char  *        help_msg;             /*     8     8 */
>             const const char  *        action_msg;           /*    16     8 */
>             const int                  enable_mask;          /*    24     4 */
>     
>             /* size: 32, cachelines: 1, members: 4 */
>             /* padding: 4 */
>             /* last cacheline: 32 bytes */
>     };
> 
> So it seems to be a general issue with modifiers printing.
> 

So it seems like the modifier ordering isn't preserved, even though
the final BTF representation looks right? Thanks!

Alan

> Thanks,
> Eduard
>>
>> As such it would be useful to omit modifiers for comparison
>> purposes.  Also noted was the fact that for the "no_parm_names"
>> case, an extra space was being emitted in some cases, also
>> throwing off string comparisons of prototypes.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  dwarves.h         |  1 +
>>  dwarves_fprintf.c | 26 ++++++++++++++++----------
>>  2 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/dwarves.h b/dwarves.h
>> index d04a36d..7a319d1 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -134,6 +134,7 @@ struct conf_fprintf {
>>  	uint8_t	   strip_inline:1;
>>  	uint8_t	   skip_emitting_atomic_typedefs:1;
>>  	uint8_t	   skip_emitting_errors:1;
>> +	uint8_t    skip_emitting_modifier:1;
>>  };
>>  
>>  struct cus;
>> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
>> index 5c6bf9c..b20a473 100644
>> --- a/dwarves_fprintf.c
>> +++ b/dwarves_fprintf.c
>> @@ -506,7 +506,8 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
>>  				struct tag *next_type = cu__type(cu, type->type);
>>  
>>  				if (next_type && tag__is_pointer(next_type)) {
>> -					const_pointer = "const ";
>> +					if (!conf->skip_emitting_modifier)
>> +						const_pointer = "const ";
>>  					type = next_type;
>>  				}
>>  			}
>> @@ -580,13 +581,16 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>>  				   *type_str = __tag__name(type, cu, tmpbf,
>>  							   sizeof(tmpbf),
>>  							   pconf);
>> -			switch (tag->tag) {
>> -			case DW_TAG_volatile_type: prefix = "volatile "; break;
>> -			case DW_TAG_const_type:    prefix = "const ";	 break;
>> -			case DW_TAG_restrict_type: suffix = " restrict"; break;
>> -			case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
>> +			if (!conf->skip_emitting_modifier) {
>> +				switch (tag->tag) {
>> +				case DW_TAG_volatile_type: prefix = "volatile "; break;
>> +				case DW_TAG_const_type: prefix = "const"; break;
>> +				case DW_TAG_restrict_type: suffix = " restrict"; break;
>> +				case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
>> +				}
>>  			}
>> -			snprintf(bf, len, "%s%s%s ", prefix, type_str, suffix);
>> +			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
>> +				 conf->no_parm_names ? "" : " ");
>>  		}
>>  		break;
>>  	case DW_TAG_array_type:
>> @@ -818,9 +822,11 @@ print_default:
>>  	case DW_TAG_const_type:
>>  		modifier = "const";
>>  print_modifier: {
>> -		size_t modifier_printed = fprintf(fp, "%s ", modifier);
>> -		tconf.type_spacing -= modifier_printed;
>> -		printed		   += modifier_printed;
>> +		if (!conf->skip_emitting_modifier) {
>> +			size_t modifier_printed = fprintf(fp, "%s ", modifier);
>> +			tconf.type_spacing -= modifier_printed;
>> +			printed		   += modifier_printed;
>> +		}
>>  
>>  		struct tag *ttype = cu__type(cu, type->type);
>>  		if (ttype) {
> 
