Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC2526ACF
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383934AbiEMUF1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346904AbiEMUFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 16:05:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA213D46
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 13:05:24 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEKrZl013626;
        Fri, 13 May 2022 13:05:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JJdKT/S21z+bg8De3RDAlEsgxp3BJmKKdkKjcSTGMt0=;
 b=SitL4p1bqMHsZwNCZn7Pwayz+iA7ze8YZ6n+sOJT+A2g0oQKN6ML9kCCEls2zWavlLzV
 K/pbSY3QPhNYWavv82rs62/3mg1Lk0n+AYWxz+YXWTgAdoTTfZoPY/iWwN4AQw3gHL6Y
 UbccjSf420eE9w9ET9sJ99v++lK2ddkNuNY= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g19w9ya4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 13:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxwUZ8Crxu36S+bpICx62FbmmfvklXzGwxuKQlJ7eqqU9L+cdWFldSRWSOS5P9KDSMynze+tePIvKBTARH1v872Pd4EWyi3Q4ctIPXekpCnA3su9vhytkO32iDPBTBZz+fkkUFymxgAF8GvbRYFIW1URMeor1AV7L24fjdhkN17MKBSIQN+Adc4T/PBlObvn3uocIR6ay6TAMxmA21aEDM/RFrv4+dy2kYOoJuJgzxsxxRrsot8JiUVn2SCWGVaZdpoX9xIJZsZ9YPLCHmPsIdP8IipmiPOXZTdzKjFwcAGyzkW2WIjSoiqOfAa6SYYfhuYu/Ue0Mu2xAH6/fjjbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJdKT/S21z+bg8De3RDAlEsgxp3BJmKKdkKjcSTGMt0=;
 b=H7O9eoSWLn/T/7+DBWsyUF6nXsVLPDgOmd7IuLsLKzi1wnYAKlNIp2oNE58XIXTQnP0NyC9pKl5CZvfNPtdYHJPN98IDjOearvkS8PfTbh5rorAbNpTkST9PQoqArVIquqhsPa2iKCzFEO/+oDFLyaAwZZ05rrNhjeNFhu1ekSU0RSuRx4tUIOiCzoGVbOZQUGLBfMqJZOc+IRCGktQ1yuD7imR1P02FGbPquT9yNnuKq0kGsai8NIoBfQik6zfTHO2XlBtunX5qlUtZ2Dd5qrb6auPdSlsvrjpHPLXKNw3BR8xmdwfw+cB/4slb85LEusInTotU7uFJiQmo6+Hs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3995.namprd15.prod.outlook.com (2603:10b6:303:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Fri, 13 May
 2022 20:05:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 20:05:05 +0000
Message-ID: <cad60f6c-3470-b65e-d26c-329352ddcc1f@fb.com>
Date:   Fri, 13 May 2022 13:05:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix usdt_400 test case
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Mykola Lysenko <mykolal@fb.com>
References: <20220513173703.89271-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220513173703.89271-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a491d0c3-7e3c-4b58-1347-08da351bdf03
X-MS-TrafficTypeDiagnostic: MW3PR15MB3995:EE_
X-Microsoft-Antispam-PRVS: <MW3PR15MB39956142D1A4BA7C4773740BD3CA9@MW3PR15MB3995.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLIHXhGPeDDBpgZyufGwpyHuvXBYZpK2I2wsyBQGCFWpy4YVGLDDRuNKPzTA/IB4ASYOI28L4rsCBWmDRmyn4Vzpdvy9hoPcrhRUqV+EQIfzB6c7QTxz8qm6LN26e6cVPee/elUalQEpv800svR/me50EKt4jXUbK9AdySctvyQnksIWQyMufXHv9Y0oS8dY97YcHcrD+R9Dhbf6NZsvRqeIkPbbVtFU4K/v68XJ8KFPMBZq6iUVIrQDnf7R108D4v51jFeOnwESU1A+4udzkkW8DBxugEKGZZV76PJdAyujm1drVnfwGatGPBEw7Je4SmQt+xfZr7kR1srWPGoS1WYmVfTF7WGEZhExo25LHTbVHqILi16BYPkSfAatbxkBoWGoNFM8GdlYQlqN3WFpY/lSUvXzLo1MKMk6b10RY1KsVCY4yWQ5eafRS+h0OkQaclfu2CdtVALkVbO50ZdFjklQ3nG/rG+BqT7BfG11kkXcSH748+1iCCmYWDtsalTvLj17RLdMpb0WyC1QkC14gJN5esFO2OxQZIRhOQef6i1YjrZ43hCVhAq2qs5HsNsM6XEn+Tjg0vbz8ICUMg1bAP1maByXs2R7c1qu9UuhvU3FRaOQQae9ksF8vlrcsbgOQx8iCdqn8gDR4csoEWnaS+eMpB3OgCzAt5fp97MhZ99wldqzkk+6XRNKgyeIi7+eFueD4B+CRUY8n/xu/Sk1M23FEBrewAnM1gfLcJaNx7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6506007)(5660300002)(6512007)(86362001)(8936002)(6666004)(53546011)(31696002)(186003)(2616005)(6486002)(508600001)(31686004)(4744005)(8676002)(316002)(38100700002)(2906002)(36756003)(66556008)(66946007)(66476007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZDZkx2N2lGSS9yWlVuYkZvdTFuclNWbDFRajR2T0Y0dFdGc3NUN0s0UnBV?=
 =?utf-8?B?c2YreitXRVdvdXJ6M3ZKOVNtTGtibFBndE1VTkE4dUppVkFtcHpidSsxdkcw?=
 =?utf-8?B?dXV4SnNJRlRSVW1OcFNHR2hIeSs1aTJlZHo1WnIxaHlPY3I0ekVkbFZNNFRS?=
 =?utf-8?B?UWVubFMyaThxMi95K2huN0V5TTZaYlJ4a2NaYWplem52R1UrOVBianFwT2xO?=
 =?utf-8?B?TXAwS1pLVkQ3MXpkMGhINzBmZ1o5b1FCeXFYTkttbGI5WmdxM3VWZU91ZVpy?=
 =?utf-8?B?aUdxck5kWlgyZ3FUQXJvU1kwa29FTDUxcWxoVC9EalJlMnhWU0N3b1lwdHVS?=
 =?utf-8?B?R2JsQWRXVXpINXBYTStOcU9IYytkR3BrbDdUa2NIZWxKT1FQM2pnVDBGTU9u?=
 =?utf-8?B?WlFaQlcrNmJSTjRoUzJJQnV2cjF1QnRNYWt2bFpRV2liSEN6cVROM3B2QUYy?=
 =?utf-8?B?U0J2RGNydlc1alRCa2ZiT1J4WURoZFBNY28zaEdZVzdJZ0FpS3dkTGR3d29O?=
 =?utf-8?B?aVMrY3NnY0ZaYzB6eDI3VUE3b2VXbVdxVzJYeHIzQjZhWUtSMjlrc25hMGE5?=
 =?utf-8?B?QjUvUjRIS2lCWjhZSUduc3FuVzNMaGlmVU11UWFkR0l0R0Z1a1FXallZYWlF?=
 =?utf-8?B?VEtZZVhZdEdCMnhLRnNLMnM1NTczdlVGd2FpTkM3S3VmdTZ6bFdSdkk4bnM0?=
 =?utf-8?B?SjV4TlYwRnJVcXkzL3BYdzVQZUhIZk5Qbk9YeHkzVHl2M1dZNVpRanMxeFc3?=
 =?utf-8?B?cG92clR2Rnl2bmRVYSttc2JTNGxZSS9wL3cvckJlQUFEVDdkS0dEQ3dqaG5Y?=
 =?utf-8?B?N0QyZHlMZWJnbjVYS0tuNzBuK21sWXI2ZnFtWUZ6RXRGaURlQm5zUENyVVZ2?=
 =?utf-8?B?Vy9YQmdEY0lUbFRxRFdVLzVZVU9qcWlyazdzRGk2anMxVGJ5T0lSN3FjMk5C?=
 =?utf-8?B?dVo0aHg0Zkd4V2dsNmM1ckxNWm45TGtBYjUzU3lSUE93ZzVHb0ZZc1lsSldz?=
 =?utf-8?B?Tks4cE00ZXNFYXdZQm02V2RRdld3WXQwenlUVHcxbzFNRkNUMkNKWEhHYml0?=
 =?utf-8?B?ZkdGM1VKM21DN2lMZ1lzWTU2YVhoQVZYc1BIR1RHbHRYelRiUHlKcW5TNUJ6?=
 =?utf-8?B?VlQ4TzdRdjc1RUpVYXMvbUEyb004QjdtSmI1OUNFWmZ5dnhBd3RFQTJ2amdu?=
 =?utf-8?B?d2tJZ3REUGdhWWRyOWZoenJ4Q3lmUTFmb0NMbVNWOWlKMXU2RjljTWNyd0RT?=
 =?utf-8?B?S2hOTlA0dm5vV2FOWW5sVXUrb3JJRDA3dVM2RjdrNVdwdnB3OFRBOEk0ZG0v?=
 =?utf-8?B?SGF6elkwR1RJMnlabDkzVTdOR0tjbk9GS1J3WUZrTWx3dk1FeXhHT2t5R0Ni?=
 =?utf-8?B?NjI1c0U5TFU5NUJqRTZ5YmVyVzBNWGx5cUx3Y2tNZXVweENSYlFuVzlFMlEw?=
 =?utf-8?B?emgrVTFGMkhEZEJNRTU5bWVLQWNBN2ZnVGEzTEtMUys1Mm5ZMy9wN284cEZh?=
 =?utf-8?B?YVRtdGdKaHFlb0lGL1NXOEVDZnVJcGdMNWdkTnovOXpWenhucE43QmMrWlJQ?=
 =?utf-8?B?dlNicjg2V0tUelZlbVgwMGZkQ2I5b3BCb05QeW9sdm5sZmZIL0dMd2x4OW8w?=
 =?utf-8?B?OVBqRU1BNVovWjZRSjd2NnBmVlhjWW4yRG02WkZjQmdqcS9LUkpTQytZRHNC?=
 =?utf-8?B?cFZOcWR2dEliZHNsZlFVOFpFZ0d6TUU0NVkzNmZoWG5BaDRvc1RyYi9PNkhr?=
 =?utf-8?B?QnFNcnE2NTRETVAvQ0liN2lDY0k5MFpEQXRRV1NxejZFVS9KTWltclpEeS9q?=
 =?utf-8?B?anlCeDE5THJmS2xXcjVUZlNoWnkwVmJvY3hNT1d1WStFKzgyZjB6UjNOVXlX?=
 =?utf-8?B?dGc3RjF2RmNvYkN5R3dwU2U5WXhGLzkvblhiM2xwczljY1VGZjNXcC93ODk1?=
 =?utf-8?B?OUFZaXl2TkFNOWRYNkpiNHAzcDBNeks4cVhva2ZUWE1OT3RoTFNvYmkvd0Fq?=
 =?utf-8?B?L2x4ZkpsUi9nVmFsdnFnYU1YTWFUcFJDVCtieHRiZ0t1cWNkeE5PQjJBQXVY?=
 =?utf-8?B?QnVVZ1M5RDZkZnB6WnNGY3d3c29SdnpGaGZTSFdXbG11b0Q1V3FuMUZMYVhu?=
 =?utf-8?B?T0dZbjlXTnp4RGFHSi9mVW1SeDQwQzAzdk5ZVEp4VmpGYUhRbEVaSVByblVO?=
 =?utf-8?B?T2VLY0VnamZLZXlQbXFVcTc0WWNjV0l1V1U5MzhQNkRsWTdaZFVMeXh4MFc4?=
 =?utf-8?B?cVdOemNDWXdScndaRTUzRittQTNScWRFNGp5d1pqaTJMQ1FQNmhRd1dkSXVC?=
 =?utf-8?B?a0JtWWZ3ZzVrMWQzOHBVelNqSVMvMGh3Y2EwVloyRU5HYU5HaElHNGFGK09P?=
 =?utf-8?Q?i3DYE+y8cqNE6Ic8=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a491d0c3-7e3c-4b58-1347-08da351bdf03
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:05:04.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtnQNbgaAHnDtdxjDlNtqDKEQYAtSYQDofK827GsyJInBJSuM6S6YO9xPqXajurf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3995
X-Proofpoint-ORIG-GUID: mOnk66-Tke-SfxhKebamusXd9uDHcpGg
X-Proofpoint-GUID: mOnk66-Tke-SfxhKebamusXd9uDHcpGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/22 10:37 AM, Andrii Nakryiko wrote:
> usdt_400 test case relies on compiler using the same arg spec for
> usdt_400 USDT. This assumption breaks with Clang (Clang generates
> different arg specs with varying offsets relative to %rbp), so simplify
> this further and hard-code the constant which will guarantee that arg
> spec is the same across all 400 inlinings.
> 
> Fixes: 630301b0d59d ("selftests/bpf: Add basic USDT selftests")
> Reported-by: Mykola Lysenko <mykolal@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
