Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8968465EF9F
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 16:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjAEPE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 10:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjAEPEH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 10:04:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C155BA19
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 07:04:04 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3nEr014075;
        Thu, 5 Jan 2023 15:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cZVLcsb/2DpBswIO/ov8QZN/6y1+/FFxEl98RsFzRII=;
 b=qi8RC9AxlLElMg3RAKHktvxA90zLPx8RlO9A+R14XwzrdqZOPpqBQilu81Ip08/u4vAf
 WCW8SGweLeYtkGy1avjDMEUBKGAp2qMNZOoL3JRkTiNxHz+R6NhvVRmpERX8M+ZG7Q4a
 eCR1u/lXGYcUJir1INg8fr6q9qyrRa7v7LKRuDje6OBDHZJwSFV1hXrNPZiPH6gnPwB9
 n2L1vBfYY4swTP29rBLdA4XoOsK+reVcKKNYSJ6SkNo7mGKRNAY1mV7RVavsU6SNooqo
 ZTVSg8a/a4YL78QTM8IIMejL+Kcs0se/VgzyDoIu650KDCEIpDKvi53YydaSrQV8aXfF gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c93v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:03:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPKeY040170;
        Thu, 5 Jan 2023 15:03:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjm94s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoORKMlXnCUzVzJISwhMUTyJwjP/Ch0LN6VEyXQz6lRImBbHCwICHC5AzLlTrF8K1rx3CcI7UTBNvB5ECjdEnS0NH0oCa1Od11ecce0isf0STdgTPEXTnjmq/OA26OhuBxnvrO3Xaj3yR2oxtKMj4LN/kX/Z7fSfLzKpNv19hK4UqIJXPtX5Y7S9o1py8Y+uuGTEXs93rH23BYFvbLMP5nwMCXwXdVMJ9VAmJAwDUqHPw1hKmO34D177VjjKDdqD4q/CGBsGK9m51Nh7QgErFEP9BnzYp8sCxa7Yt1j76zYcxCUEBrGUMIJVoLvpPJ2ohX/k8wts3Dq/G6sluEHNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZVLcsb/2DpBswIO/ov8QZN/6y1+/FFxEl98RsFzRII=;
 b=QASbtKTVu1lEoGSXtQquITUmX6pRllorqb4lsQRLwlQ+sQ/r3oqIjiDhW9gWAe5HejcrnGw4x8yPGPW6RnjqryQIUKPI97eDdnjB9d0sj7Vg9w6cP2Fve2B0rkgYS8gGt3EAN8cqi8e2JjJyUeQbkXnQqIRkQxcGecuaNtmijT7XA7LykLs9hiYRgOkUs7E4+GFUOtNND7ZrcYZK0cpAgjJWS+Bl1NWBNGC5xQlYERXN6iMjqp9FR3cIhXqKayl2tnEUZg9AUc46kT5mOei0Y2khYi8SNTOAoNyV2uuhgAZmA0ezqhEV0TSOmINrcFcpLXOcDoD6I9+RWuuX0ThATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZVLcsb/2DpBswIO/ov8QZN/6y1+/FFxEl98RsFzRII=;
 b=WaCv0NodB09F7ffExcLx9bDDEqPA3r6qIX/taboKDK/7QsU2f7CQn0WdpGxwu/9C5ByhUrfMv+fEoPl6dEcG9pEOKp6Y1PsIYtiFN2y/5COuBa1U3z5+O7Z1gWHPiSV58tQdwWfmg9I1AkoBaxdHvbUsvkMSImuA0sKKB7EnHjs=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH8PR10MB6502.namprd10.prod.outlook.com (2603:10b6:510:22a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:03:36 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:03:36 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, david.faust@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
References: <20221231163122.1360813-1-eddyz87@gmail.com>
        <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
        <874jt5mh2j.fsf@oracle.com>
        <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
Date:   Thu, 05 Jan 2023 16:07:45 +0100
In-Reply-To: <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
        (Eduard Zingerman's message of "Thu, 05 Jan 2023 14:07:05 +0200")
Message-ID: <87fscpj9z2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::26) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH8PR10MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a7ab1c-cb02-4382-2ab2-08daef2e057a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cARZoYKR48LmG59HHwgDSZ4xkGlXKj7UHULVNsuH+GRlioEkCOZsXxrEFLTXhJAZIiMpX733whPL8j5CHwgF8jdzyOZ9XPN3QNWbnDIz9itYlLsN2OGB1Z2G9Hy33U7FzuoGMztBdw1PXDVFRfz3JcH7pnehvX5FoByVfjO9tY91ASweBEkh6DcLu/WBasw10HSCsVZlLPhXnJCgkJoVhbI2yK/ytB/FziYEvT7DAAaekYZRshjG+VPlI3KQCnQlLtMbSONQUvgNN48vxxkKjd1OZX/l748JejstID9GsN9Y15gukf2NWTuk04tfCyqCp2skGmZF7bJhD2JhOmezXW5xciEVeRRU5PSPCWHr+pL1AFnX7S9XbMF0TRAI7gE4ae2g5yKUcIpE4i/X+yBSlwWEWjuQ2npc8TmHa52o2xXRnboK4t9PFIJbWFB+ngSgt5F5X/wqiM8D8QuTa1L2yAAv5NUuzJiRfta1Rz9J4B7OVETC9bPrxfrB2TMWuz3Yk7Ecv6yc7vGLZHc7+2OBkxr9xdZSFCZOJWgs335tj7aNSNPozhke7hqQXRVLcSpAR+ha/VanHhWIBJVCh9uzEDKZ39XwQB9FMI3uuqaKu0yjwgSMwZkk494EQbeS3YSvLAlnx22eRqLu2MfQHMvjqwmUEhdNp2lT0DlB7cBSqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(83380400001)(86362001)(2906002)(8936002)(38100700002)(5660300002)(41300700001)(478600001)(6666004)(186003)(53546011)(8676002)(6506007)(2616005)(4326008)(6512007)(66476007)(26005)(316002)(6916009)(966005)(66946007)(6486002)(54906003)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTI4ZzZScVpTdi8rcE9IQ2NtMjlzMmRpcXdBR1d0VklpWlRDcjA0NjRHYWNa?=
 =?utf-8?B?MXJsNDlHTmREcDBGd0hibVdGdlEzQlU1bkFlWDl1SU9EajNWa2c0ZkVYejQy?=
 =?utf-8?B?RGZ1ampKRDdQUC9WcmkxSGY5bEVMdVBybUhWVVZjcEdBRDdzNmx4UEMwc0kv?=
 =?utf-8?B?YmhKaXJ5RHpKTUc5ZGtzZkowckEzL01oaHBQOTQxL21GQm41bkxXRUh5RzdU?=
 =?utf-8?B?WElzYW13YWF5SUN2VG00S2VMMzJ5aGFBTFcvNkRQcmdYNzhCMjVpNytwZFd3?=
 =?utf-8?B?Uk80MS81WU54d0pzaXYxY3Z5cWROb0tCVC82WUhEdStxWnlzNkVxcEdVTGNW?=
 =?utf-8?B?Z044Q0xReWo2WG14WlluU3JaQ3dkbVozWWdVRFNCVHlnNFQ1cFJ0TmhTOHRE?=
 =?utf-8?B?cEYxVS82YnMyeVhQd0NPZmtvbVdBaDdQbjJmN2hqQmpyb3huOGkrTmMvV0NU?=
 =?utf-8?B?S3F6UjliejJzU25vWmV3cTdCUUF5SkpOenJISXhnWG13TU9HdHhSNXIySnNF?=
 =?utf-8?B?QUFsOXRaenRQMEFPdk5nVHlBV25BQVhWMTMrSWk4VDAweFdMbVVrR2pGR3pC?=
 =?utf-8?B?WXI2RkZsbzgzcnFqS2I2MGxHc0dHaktMMWlPdys4cFV4azVqZ09JL0dEQWgx?=
 =?utf-8?B?cUdVanNRVEd4REJIcGNKdGhNck9DdlBEcXZwSHlRNG1PbVZma1R1ZjRGTEVL?=
 =?utf-8?B?QTlEU2VZVWdhWW5wdHJ4Y2JJMzlZSitQWlZJQzlISm1keS9BamxscWptaDBT?=
 =?utf-8?B?eGlyWlYreU1VZDNaemp3WVNYTlBxUFRiQkZZaDIzYk5EanVSMWNrUUdhc2xW?=
 =?utf-8?B?dTlkZlFaUmRTK29VNStzZEJYWVNQaE9CUjJXbEk0bGY1VyttU20zTjRtOUJm?=
 =?utf-8?B?V2VsaGp0WjVoMk00cmZtdndEbGpCOEl6WGE5a1V0dzB4V0k1bWZ5UnduK3ZW?=
 =?utf-8?B?SkRzcWNEMWdKdUdRRUJndDFBL3RDZCt4bWo1OGhSOWVrV1ZnUHl2YTJ2OEU5?=
 =?utf-8?B?NGtHbXJJUjV6b21OcVEwY0w3alh3aDNwM2hCNCtyb3hNc0hjM1R0U1hkdFUw?=
 =?utf-8?B?eHM2czM2QXEyc25YVENWQTUzN3UyaHdKcE4xUHNPWURHemU3UlBoQ3dHb0Nh?=
 =?utf-8?B?Skh2RkwwM25MUk9aM005SmdTTjQ2NStQcEhGMXJXMGMzZVg0THY0aHlSRzdD?=
 =?utf-8?B?MlJkZmxwb3luaEIxMjhYbGYxWEZ2V1lxY2pzMUhmU2hyVHUvaWVjKzV6YytV?=
 =?utf-8?B?WlkvRjR4QW9kaHZtMGRpd3hCSEN1YkJrNUQ1RDUxZ3VBY0RvRXZLY0cxYWEx?=
 =?utf-8?B?M3hHOE9Fd1NLQzhtN2ROQmlxa0xwU2tMalRZZnc5VXRScE5uVyt1ZlBVZUxq?=
 =?utf-8?B?WVh4T0V6ZnFhRGpkUW5OOC9TWEQ4b3Iwb3RVblhMeFVobEpzMnNkOEZjdkdn?=
 =?utf-8?B?dC80YjVQcDRremUvWjJBZ2xnaFhGbitDMk5pSnkwczJsTEJxZ0NoNFpwdFhL?=
 =?utf-8?B?dHppdU50eWUrT0lhcC82OHNvemlMM0ttblNxOWxzTzlGY2ZXS1ZwYWhFLzRE?=
 =?utf-8?B?WDhYSlI0eXlBK3RGUldJaGxCcnplZ1JPT240U09DNXBienErdHNGdmNYbDBN?=
 =?utf-8?B?WW9qL3VKanBRMGVqT1gwQkhpdmxZWkN2QWluRS9rNnZvejJDbEZTMGUwbHZG?=
 =?utf-8?B?bk1VTVJWN3JJUDVMU1pIdGZ4RjBBaWJnZlR4YXpscDRON09RNTdJYVJyZzNu?=
 =?utf-8?B?MXJJVExDTGxxUEhRZEJzR29ySTR6UU5RWHRqVW5XVGNGUFVXOW82bWZWNzJl?=
 =?utf-8?B?M1Y2dndLRndQNUFRbXpjSFl6VEFtWTNkaWJmemY5Ykc5ZW5wbGViNU1KVUVK?=
 =?utf-8?B?bSsyaWpzSS9peFBTOUgvZTBXbEpJdUxndXhBd1RiV2FwZUlmZVVKZ0g3ekVS?=
 =?utf-8?B?dXc0bGw4bmZ3a0VrMmp4bUJYeHorRCtjL3BEZTg1WkQvUVhJdGVwbDdYTmNJ?=
 =?utf-8?B?ZldBbldjclZBWUwyTVM2SnRHVS9KT2MxVm85ZktvZUFhSmRXODdyQ0Y2VStk?=
 =?utf-8?B?aW8xc3VjNGZzQkh2WE92STBUbjhHL3dIcmpnTTY4QTdYWVBEVjg2Tkx5eDMy?=
 =?utf-8?B?S0cxM21DcER3V3Nxd002dlR6WnowUjlSWXpwSVg5MHZwN0NOZStaMGlKZXhG?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTdWUWJxMWRyWTZKR1RERzBkWkl1WlZ1eHJWbnM1MW85M1ZKdjJGMzlBL1NZ?=
 =?utf-8?B?cGRSZUhnWTJKeWdkTnBhaEh6T2xyeU1lZUhVNHFaMWxvdDF4RkRwYnp1cmdO?=
 =?utf-8?B?Z3ZwN3BzeDNiNnhKdEJuV3hxU1lDZXJWSTREMkY2SDNYZWltMFhEci9yemY5?=
 =?utf-8?B?VFNwVldTR2xUcUNxSy9taWpPMDRaa2ZYdmNiRy9pYUhaVFBzWExGcFFNZ0tB?=
 =?utf-8?B?bjA0amVCZWlXeHdIUU0vSDdhVEY1ZDJNRlE4Mm9YNzNEZkNlUXV5YnE3ZjVD?=
 =?utf-8?B?YjhSNno3ZFVhQnNUaHgxVmJORkVXZEwvMFY4VzNHaVBRMHRseG5zQ0haZVdj?=
 =?utf-8?B?ZWtoUXhxR1B3UTRyVHJIOEg0VWFZdTNXZHFIeEVtK01EK2dyQ0hVc0lxQlVR?=
 =?utf-8?B?dlRxdUV6L0FySElKZkhzcDVzaGVkVnRUbjBxTmJrQXJ1eGlYUzVKMTBWMDlo?=
 =?utf-8?B?b3pPZ2RhZE5BNUlyTGk4bG1UbmpQb2lLV0FnQk1LRzU1MXAyVWIzbjJqOEVj?=
 =?utf-8?B?M2Ywb21BeEpyM1lNTEV5OUF1cUwyZlhyZ2NqK3J0b1hldm9wcS9sTVhManVW?=
 =?utf-8?B?d1VHZWttdXJSMFlKQWJjdkZxbGNUTU9ibnpqOXMyREZReGxHdUpLTDRKSHFl?=
 =?utf-8?B?YjJwdVZkS056dFBwZHRMSXZNUW1WMHg1cytDY1dmRitzVmdIVzdOSUJrODFV?=
 =?utf-8?B?WExVRUMrcmVNSWhEYXNCdWpEYjQrVHpLaWFaK0tudmFwQXF1WE5pUkNwaGZT?=
 =?utf-8?B?RjBlK2lweTFGajIybi9OYXhzOXNDR3YrcHBDb1hLYmg2UWkwb3hMQXNaR0xJ?=
 =?utf-8?B?WmJTZDZRY3pFSm5xMVMxaTVaOW9xMlJld1JsT1pVRzJUaElpOGl4TEtKRndF?=
 =?utf-8?B?bmcrUmMrU2g2Zjd1RHF2Um9MZG0yTjA1QVl3ZnhlRHQvWHFnKzRzdnJaZUZ1?=
 =?utf-8?B?b21YYUpvZnRHdnVhVy92UEhWR2tGZUVQMnBCT3ZHcDZBOEpoTTFTbS9GSEtl?=
 =?utf-8?B?T09GY0tQanJ5RFNMMGRnMWR1Nmg5K1dSSCtCUit2V3lKUjZkblZWUGZUemtL?=
 =?utf-8?B?TWxIRHNxV3ZwN3Y5VkdZUnkreGh1dVFUb1dNRXpJRUNyYlFhZkRKaWltT2Yy?=
 =?utf-8?B?Q2ZNK3loWjd2a0NXNi92Zk1hS3dzbVdxQ0dINXAxdmNoc2dMOFJPbnY0c3U2?=
 =?utf-8?B?RVk2ZjRxalM5M2JhaHVPU3c3RFZhUEVheTFnSm85dmN6YUdMalpCVjBGS2ZI?=
 =?utf-8?B?MVh1NVBlWDlwaVh4NmxvUnk2dlJ1NXVsc2xEYUI5NFpnSWI0dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a7ab1c-cb02-4382-2ab2-08daef2e057a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:03:36.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoJ3kNKCm68AvQZ9DXQSL37tu0daH4gAIIrvLBg0Lu9u9p7fUHpP1p/PYMEUtRQQg9EZxJKLmRMZsvEysInXY7EQEZ/hGOfnjDxjcwSWoJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050118
X-Proofpoint-GUID: HD-BMWsjdRT8Aj98GLwkHjKbpZtsaEfx
X-Proofpoint-ORIG-GUID: HD-BMWsjdRT8Aj98GLwkHjKbpZtsaEfx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Thu, 2023-01-05 at 11:06 +0100, Jose E. Marchesi wrote:
>> > On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> w=
rote:
>> > >=20
>> > > BPF has two documented (non-atomic) memory store instructions:
>> > >=20
>> > > BPF_STX: *(size *) (dst_reg + off) =3D src_reg
>> > > BPF_ST : *(size *) (dst_reg + off) =3D imm32
>> > >=20
>> > > Currently LLVM BPF back-end does not emit BPF_ST instruction and doe=
s
>> > > not allow one to be specified as inline assembly.
>> > >=20
>> > > Recently I've been exploring ways to port some of the verifier test
>> > > cases from tools/testing/selftests/bpf/verifier/*.c to use inline as=
sembly
>> > > and machinery provided in tools/testing/selftests/bpf/test_loader.c
>> > > (which should hopefully simplify tests maintenance).
>> > > The BPF_ST instruction is popular in these tests: used in 52 of 94 f=
iles.
>> > >=20
>> > > While it is possible to adjust LLVM to only support BPF_ST for inlin=
e
>> > > assembly blocks it seems a bit wasteful. This patch-set contains a s=
et
>> > > of changes to verifier necessary in case when LLVM is allowed to
>> > > freely emit BPF_ST instructions (source code is available here [1]).
>> >=20
>> > Would we gate LLVM's emitting of BPF_ST for C code behind some new
>> > cpu=3Dv4? What is the benefit for compiler to start automatically emit
>> > such instructions? Such thinking about logistics, if there isn't much
>> > benefit, as BPF application owner I wouldn't bother enabling this
>> > behavior risking regressions on old kernels that don't have these
>> > changes.
>>=20
>> Hmm, GCC happily generates BPF_ST instructions:
>>=20
>> =C2=A0=C2=A0$ echo 'int v; void foo () {  v =3D 666; }' | bpf-unknown-no=
ne-gcc -O2 -xc -S -o foo.s -
>> =C2=A0=C2=A0$ cat foo.s
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.file	"<stdin>"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.text
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.align	3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	foo
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	foo, @function
>> =C2=A0=C2=A0foo:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lddw	%r0,v
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stw	[%r0+0],666
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size	foo, .-foo
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	v
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	v, @object
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.lcomm	v,4,4
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ident	"GCC: (GNU) 12.0.=
0 20211206 (experimental)"
>>=20
>> Been doing that since October 2019, I think before the cpu versioning
>> mechanism was got in place?
>>=20
>> We weren't aware this was problematic.  Does the verifier reject such
>> instructions?
>
> Interesting, do BPF selftests generated by GCC pass the same way they
> do if generated by clang?

We are still working on other issues in GCC; we are not yet in par with
clang when it comes to build/run the BPF selftests.  So I guess we
didn't reach that particular breaking point yet ;)

> I had to do the following changes to the verifier to make the
> selftests pass when BPF_ST instruction is allowed for selection:

So, if the current state of affairs is that the kernel rejects BPF_ST
instructions, we shouldn't be generating them from GCC.

I like Andrii's idea of introducing a -mcpu=3Dv4 and condition generation
of BPF_ST from the compiler to it.  GCC is defaulting to -mcpu=3Dv3 atm.

Yonghong, WDYT?  Would that be acceptable for clang as well?

>
> - patch #1 in this patchset: track values of constants written to
>   stack using BPF_ST. Currently these are tracked imprecisely, unlike
>   the writes using BPF_STX, e.g.:
>  =20
>     fp[-8] =3D 42;   currently verifier assumes that fp[-8]=3Dmmmmmmmm
>                    after such instruction, where m stands for "misc",
>                    just a note that something is written at fp[-8].
>                   =20
>     r1 =3D 42;       verifier tracks r1=3D42 after this instruction.
>     fp[-8] =3D r1;   verifier tracks fp[-8]=3D42 after this instruction.
>
>   So the patch makes both cases equivalent.
>  =20
> - patch #3 in this patchset: adjusts verifier.c:convert_ctx_access()
>   to operate on BPF_ST alongside BPF_STX.
>  =20
>   Context parameters for some BPF programs types are "fake" data
>   structures. The verifier matches all BPF_STX and BPF_LDX
>   instructions that operate on pointers to such contexts and rewrites
>   these instructions. It might change an offset or add another layer
>   of indirection, etc. E.g. see filter.c:bpf_convert_ctx_access().
>   (This also implies that verifier forbids writes to non-constant
>    offsets inside such structures).
>   =20
>   So the patch extends this logic to also handle BPF_ST.
>
>>=20
>> > So I feel like the biggest benefit is to be able to use this
>> > instruction in embedded assembly, to make writing and maintaining
>> > tests easier.
>> >=20
>> > > The changes include:
>> > > =C2=A0- update to verifier.c:check_stack_write_*() functions to trac=
k
>> > > =C2=A0=C2=A0=C2=A0constant values spilled to stack via BPF_ST instru=
ction in a same
>> > > =C2=A0=C2=A0=C2=A0way stack spills of known registers by BPF_STX are=
 tracked;
>> > > =C2=A0- updates to verifier.c:convert_ctx_access() and it's callback=
s to
>> > > =C2=A0=C2=A0=C2=A0handle BPF_ST instruction in a way similar to BPF_=
STX;
>> > > =C2=A0- some test adjustments and a few new tests.
>> > >=20
>> > > With the above changes applied and LLVM from [1] all test_verifier,
>> > > test_maps, test_progs and test_progs-no_alu32 test cases are passing=
.
>> > >=20
>> > > When built using the LLVM version from [1] BPF programs generated fo=
r
>> > > selftests and Cilium programs (taken from [2]) see certain reduction
>> > > in size, e.g. below are total numbers of instructions for files with
>> > > over 5K instructions:
>> > >=20
>> > > File                                    Insns   Insns   Insns   Diff
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0w/o     with    diff    pct
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0BPF_ST  BPF_ST
>> > > cilium/bpf_host.o                       44620   43774   -846    -1.9=
0%
>> > > cilium/bpf_lxc.o                        36842   36060   -782    -2.1=
2%
>> > > cilium/bpf_overlay.o                    23557   23186   -371    -1.5=
7%
>> > > cilium/bpf_xdp.o                        26397   25931   -466    -1.7=
7%
>> > > selftests/core_kern.bpf.o               12359   12359    0       0.0=
0%
>> > > selftests/linked_list_fail.bpf.o        5501    5302    -199    -3.6=
2%
>> > > selftests/profiler1.bpf.o               17828   17709   -119    -0.6=
7%
>> > > selftests/pyperf100.bpf.o               49793   49268   -525    -1.0=
5%
>> > > selftests/pyperf180.bpf.o               88738   87813   -925    -1.0=
4%
>> > > selftests/pyperf50.bpf.o                25388   25113   -275    -1.0=
8%
>> > > selftests/pyperf600.bpf.o               78330   78300   -30     -0.0=
4%
>> > > selftests/pyperf_global.bpf.o           5244    5188    -56     -1.0=
7%
>> > > selftests/pyperf_subprogs.bpf.o         5262    5192    -70     -1.3=
3%
>> > > selftests/strobemeta.bpf.o              17154   16065   -1089   -6.3=
5%
>> > > selftests/test_verif_scale2.bpf.o       11337   11337    0       0.0=
0%
>> > >=20
>> > > (Instructions are counted by counting the number of instruction line=
s
>> > > =C2=A0in disassembly).
>> > >=20
>> > > Is community interested in this work?
>> > > Are there any omissions in my changes to the verifier?
>> > >=20
>> > > Known issue:
>> > >=20
>> > > There are two programs (one Cilium, one selftest) that exhibit
>> > > anomalous increase in verifier processing time with this patch-set:
>> > >=20
>> > > =C2=A0File                 Program                        Insns (A) =
 Insns (B)  Insns   (DIFF)
>> > > =C2=A0-------------------  -----------------------------  --------- =
 ---------  --------------
>> > > =C2=A0bpf_host.o           tail_ipv6_host_policy_ingress       1576 =
      2403  +827 (+52.47%)
>> > > =C2=A0map_kptr.bpf.o       test_map_kptr                        400 =
       475   +75 (+18.75%)
>> > > =C2=A0-------------------  -----------------------------  --------- =
 ---------  --------------
>> > >=20
>> > > These are under investigation.
>> > >=20
>> > > Thanks,
>> > > Eduard
>> > >=20
>> > > [1] https://reviews.llvm.org/D140804
>> > > [2] git@github.com:anakryiko/cilium.git
>> > >=20
>> > > Eduard Zingerman (5):
>> > > =C2=A0=C2=A0bpf: more precise stack write reasoning for BPF_ST instr=
uction
>> > > =C2=A0=C2=A0selftests/bpf: check if verifier tracks constants spille=
d by
>> > > =C2=A0=C2=A0=C2=A0=C2=A0BPF_ST_MEM
>> > > =C2=A0=C2=A0bpf: allow ctx writes using BPF_ST_MEM instruction
>> > > =C2=A0=C2=A0selftests/bpf: test if pointer type is tracked for BPF_S=
T_MEM
>> > > =C2=A0=C2=A0selftests/bpf: don't match exact insn index in expected =
error message
>> > >=20
>> > > =C2=A0kernel/bpf/cgroup.c                           |  49 +++++---
>> > > =C2=A0kernel/bpf/verifier.c                         | 102 +++++++++-=
------
>> > > =C2=A0net/core/filter.c                             |  72 ++++++----=
--
>> > > =C2=A0.../selftests/bpf/prog_tests/log_fixup.c      |   2 +-
>> > > =C2=A0.../selftests/bpf/prog_tests/spin_lock.c      |   8 +-
>> > > =C2=A0.../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++=
--------
>> > > =C2=A0.../selftests/bpf/verifier/bpf_st_mem.c       |  29 +++++
>> > > =C2=A0tools/testing/selftests/bpf/verifier/ctx.c    |  11 --
>> > > =C2=A0tools/testing/selftests/bpf/verifier/unpriv.c |  23 ++++
>> > > =C2=A09 files changed, 249 insertions(+), 157 deletions(-)
>> > > =C2=A0create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st=
_mem.c
>> > >=20
>> > > --
>> > > 2.39.0
>> > >=20
