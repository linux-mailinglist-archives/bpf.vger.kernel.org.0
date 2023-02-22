Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9644B69FAB6
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBVSDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 13:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjBVSDo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 13:03:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6928A2D173
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 10:03:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MGTDO3008591;
        Wed, 22 Feb 2023 18:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pAbt45a+akhkGO8OC+GvJ7XqeSoTnPwi1FMhDQY83Z0=;
 b=g1K6ZlFdAF5ffHG5J1sQ1N4zJ7sW6n6VFOW1gNEUGjvL5hy7DkiCBkdUO1DengprQ+W9
 nfkpR7aPrF4wYtuE3i4aWN1XwibV7a3MJEog3+Qsm1wQcDVLrNTssLADPYyQ1yXK9Z8G
 D11Mcr+nRdEQU8uyEHqqXeVrhwNLWWzP0omjzbZvz/ikqtCGE7WCn2/0paiecyHyMXHn
 oGm5G11gBfKWzIcpSP6qwWU7XDVTAaII7O/VYDauPRUskyrIS1NHWZ/qvLBOJRdMYRFW
 xK8PAA4CxN/t+AiEUDc9IK1iKIphpu0J/IsArdp7jknQrHURyQvkRbVMOHOVRPM+LtUR wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3gmu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 18:03:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MH8kiq012317;
        Wed, 22 Feb 2023 18:03:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4e7uq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 18:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBfuOWw+Vl/Rf48JgSY6ZmV80WYPMWO7RVQgbSUtnTSmlwyJsevqjU5KYEuUVCmpdKJSW9TNAHZMFbXfhu704Jl8KX7637W9BUeHRuS5/V9U9WfQkfP43UDxuNIjI0jS+H5ftIY5fX70vXuD4/+ax/l8xilbm/nq4L+jFyM36urkW5qtoAni0Xc0+9OFsTKWWdOdZSw7mxBF/voJMlxOVQDZgCzuXx6Q+L/EtZk4e41c5bRmBz2rOWEhBAjIciS2X07PP7cNY0ZhgiikVyoVG2gOHgVgEXdee8fHd7E5dVSfqQPScpaKPlSsc5kOg1yLldmHzIDE4ZqsH8L2cT+gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAbt45a+akhkGO8OC+GvJ7XqeSoTnPwi1FMhDQY83Z0=;
 b=Bj2qE/cEr3Lpce9QB8cBER24mtKTglou3Mk9jpuczbWw3ThodVHe/XdW0nnWzvih292XAKiZ0zHtn4z+wGes0ScFgYsR9lBHHncJyKqcLNlzfXYUlNyE58n/7SvCjbrI+5nLquQaVTl5O7MvfahLWyhWgWsNxbX4RObDF3lh3ZilbaTfJPxIrWLdsvezo+pif2YDfQL4uWo7km1+CBRHmAtYfTulWiRqTgeOWztfP50kZLXf+gUo4MeesjNthNmFTRgFxTt5PGC3yOkF2pGgDfBWwTp/TKbrFbdzx2SnxEiLlJAFqRkN0ixcRBgjecyazeyZMsqeGrf362P6rKwzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAbt45a+akhkGO8OC+GvJ7XqeSoTnPwi1FMhDQY83Z0=;
 b=NR5zdTu2tqe2yzZesAa/u33lsM2caHGI21cT572Vtcb4iWz1fWKaokbBZIxuaAppF2vbOsW5nH27yBcfHs66HXjPjLJHUrXN7Oc5JNQMUJvXD+NXpG99XkazTyFdTNHAB1qKnFyiIFjrqlGwXlSulAZCAt2tvmPe4VmUv4ogaN8=
Received: from MN2PR10MB3213.namprd10.prod.outlook.com (2603:10b6:208:131::33)
 by PH7PR10MB6059.namprd10.prod.outlook.com (2603:10b6:510:1fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 18:03:13 +0000
Received: from MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::2248:8d21:35b7:f269]) by MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::2248:8d21:35b7:f269%5]) with mapi id 15.20.6134.017; Wed, 22 Feb 2023
 18:03:13 +0000
Message-ID: <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com>
Date:   Wed, 22 Feb 2023 10:03:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        acme@redhat.com, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
 <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com>
 <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
From:   David Faust <david.faust@oracle.com>
In-Reply-To: <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To MN2PR10MB3213.namprd10.prod.outlook.com
 (2603:10b6:208:131::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3213:EE_|PH7PR10MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b34c4f-413c-4e15-7b13-08db14ff105f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9q0VqCMfnh6+nEW58JRAxwMlAGlu9xsRCH+YX2qZG39eDTHg700Zo35S3QhwlBnuv8aG9+3gr52l84+l6FxEod+LujDKuoK3eKLOhnsSeC+n15iJQI66CPUDea6LqBglZG7SV9Zk6jZj3RfRdrgMwyAzkui+o8IBMIJ+1aLYBX9iTOEeWJpYZSUZ3nJRj4+wmwfeOsxLDZNBS3nEkXC36Br6x34Qqf0B9c2eLBP+hHBN495csrzU0oJNDoGnG9aZ7j8VBj+H3WaBeoLtWvQCczRfyCLbGZyVi19NIWMXW8RTxOL0hKdHTsHab4AtBDVsPjMqGwx8tYRwBbMym80RTJ9Skc67NV76XTesNwrGtzR11mYmuZk3Z0ZzfFqaGOYyiIef9CRS2dSvgHS+o7uOtVIfTlaqKP4SiNPCk2VUzxfgZ8PXaMq89DfcLumaQkxUybEPOBa8KoZg9SOQP4uBRikHxJwgkenS/3yByYKawwIqaV7qZgURVj8Ylt5rIn+J/UPoAdvBcu70OJQRe6D2Z6lrYwM8kgoT37+ft4BbRPLUcnfHh4OFjmbkYuAxux9h3+TZ/ox9Ek0GxNfaFOkB85DkZgP4jiyfnS1N+tUhjR/s002Cn0HfwlPNFSCrKAc5XAU7ZT+D2Z32k4BmqUef9LuM/ao+9CwR5o8/iYLXt2aqzvXvGg7IMV9+fLTgxTUeiwplne4+De6bd6ojcD5BRwAzGdIePNDk5Gx5jGSdrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3213.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(31686004)(31696002)(86362001)(36756003)(44832011)(41300700001)(5660300002)(2906002)(83380400001)(38100700002)(66946007)(6486002)(66476007)(54906003)(66556008)(478600001)(110136005)(8676002)(53546011)(26005)(186003)(316002)(8936002)(2616005)(4326008)(6666004)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZQT3lZbWM4T0JSa0RWUllDbHRKZm04bzd4RG55R1Jrd3g0dElPSmZTcGE0?=
 =?utf-8?B?cUxLc2N3YlhTVDNBN2MwQUwyRkpNYWJDS0p3eDdsTmJQZVB3K3JFNFJuSDUz?=
 =?utf-8?B?bDBBVkVFUDVQKyt6d3gxdFNkQ2hhSXRMYkZuamFhWUF0aEsyTGlFb3Q1Y2VE?=
 =?utf-8?B?TXd6U2NwR2ZaREFIUFJXYkxJSktSV1k4VVVNamZkY3JEc0RzUzZsZGxaSFhP?=
 =?utf-8?B?UnJGeGhkL3V1TmFobjNFb2E2eUt5cmttOUlCem1KdHROZFErMEtmN2oyYVZk?=
 =?utf-8?B?S0lONUtGWUJxZSsvYjdrOHEzakh1MUZvaWZKREZyZTdFeEtDVk9SWFJVOW5j?=
 =?utf-8?B?OWoxVDdlU2I1SytOQXBWaXgzcTdWUW9uSjhKTG1qUll5Z2dPa0dyZmRRemxJ?=
 =?utf-8?B?R3lySWRDWnhpZHRueDhYb1dpWTZ0QitiWklQUm1uVVR6V3lFeVZybnc1dG1X?=
 =?utf-8?B?L05FTWtZME5zZHlVd0xwdlJyaUF6eWE0N01vU1QxZjhiZm9ycitPSGg1d1Fo?=
 =?utf-8?B?eC9IYUIzcHNKQ2xWL1hiajM2NENoaFBCUEtWMkdMYy8rMncySTNJWlNpaTlO?=
 =?utf-8?B?WjBOMWZ0K2dJOTBobmZaREcyNDUyMklGZ2pmbldQaGRVV044US9jd243Rysx?=
 =?utf-8?B?cG1mcmZnVG5BeEFiUzJHb3Awb2xmeEZSN1ZLWTZTVDVTa2lDWnlvb0sydk1O?=
 =?utf-8?B?RWNrQkRFVUtMRWZYNXA5SG50ZnZETVFPSXdJMzlRNFFucnZlM2NvTGFqc2s0?=
 =?utf-8?B?dHU2WlAydVBHaFkvS2NsV3I1ZXRoQjFTY1gyKzZmTFZYYTE2VVZWbFV6U2da?=
 =?utf-8?B?NHZDWC9hdk44aDVva3RyQTcyQTJZRUV5Sk5ldkxqa3o3ZGFtY09MRXdqVVpO?=
 =?utf-8?B?azg5ckZZdTZubHRGK3E0UjlHejNqaDFjamo4Tkg2Uk9nbWxSaFEySzlkNjN0?=
 =?utf-8?B?cHVSRDA4c3B1NXNLR2ozYmF6YXk2SVM1UlNKMzFvbFJiSXZZb0RvUGxweFZr?=
 =?utf-8?B?Q2liekNhS3AwekFWVVhOVlZDcmJtcWJBUDhWdDZWNG41bzJrZ0pFMTlZVXRU?=
 =?utf-8?B?MnRpWjVwWVFxZm1CeVVHZnRnemhWK3pxK1Q1NHUvbmg4czFGV3d2ZHFvcmFt?=
 =?utf-8?B?VEZjSlVyWDFya3kzak1aNWUvRUdldTkrYnBIYk9xdUxiTGJyVHVXSmZEWUhH?=
 =?utf-8?B?L3lmaCsraWNSUmZaaEcvQ2NsWER2RVVHSUgvd2c3NjJ4SWdBMitXOXFKSWdG?=
 =?utf-8?B?endsZkVVc3p2TjI0cEtjb1Jva2NpRUpGeC93MGp1bHVabTBhMFRMWFYrWW54?=
 =?utf-8?B?QW5CeWV1dDVWT0JCTG9TblNZaHMvcWpvcDUrUXk4TXVOUFRDNjQ4cnhmbS9K?=
 =?utf-8?B?Z3lNcEhUVForT1pZM21IQkQ2Z2tSWGRGeGxXSXRkY3YrcUtKVkpQbC9CME5j?=
 =?utf-8?B?SHU2cXBTdXdXdGJ5RGV1QXlmRUtycFZ2OUlEcDNkTHNMZTc1VENWcVFqeWlI?=
 =?utf-8?B?WkRVcE5HbzVpTi8reWlrN29iSkJwUjJtUFljY2k2Q1VUNGFUQ0Y0UUE1TzJB?=
 =?utf-8?B?S2NGV3ZzS3FVQUV2d0xWdFRTd0o4NVZ2dEdQS3JtZmFSWkc2dHhrMkFUOGFl?=
 =?utf-8?B?RjZGQkY3Sy9YZE1yOGxvSCswcGtnNmhRUU9hUDE5S1RKb1k4U28xWVBIWTdW?=
 =?utf-8?B?SjY2WWl5OFJUQ1VadXFQbjdmcWNFQlllTmZFSUdBcE1PaEE4eWgwYitFd0Fw?=
 =?utf-8?B?RWRsTTVkUlp6Vm1zRUhPWUg3T0kxaWpSRXNSam9UTndiU0hoQmFhUzR2MU1K?=
 =?utf-8?B?dlpHaTZTMlhpTVNWa1psbE9ibUF6VW1qVjA1b1lXNm15MGxyMFk1OEpOb0Rx?=
 =?utf-8?B?L013ME1CeklnV2gvZHRKOElvMzJHY1hGZHI3SjNPUjVEM3BQT1pIK2JWY1RL?=
 =?utf-8?B?VEh0YWNnUnR0WjgvUFdyd05LZk4zZmwvb1pWaHhsVEsraWVwOU4yMXBGK0s0?=
 =?utf-8?B?UlZYeUdhaHlqNk1wSnY2dGRNQjc1YlhUcGRZNit1bGh4eWdpWGhuZWJUeEM3?=
 =?utf-8?B?L2pUSWhsVzNreUU0eHprUXQzVlZmU3UwRHg0NXhKMURjcThNV0YwYWtQVnFs?=
 =?utf-8?Q?R8OxIEJ7f1TcypStYQ60lSsAL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OV3MiCQ86r/6Ga1PKRGa8RqYkvDsOxfMPLaHZhLdfyT8x97ADVCHXMogDrECcr9U3fZgkjHU2wr/mSPF5SxXpXB0ycjuxL+QjByHZMzt2h5cNyRNG+1dAl4VgaHNWjvAChS/iUCrD9ljVdOOJGxD/QwN8LPfYsSdVw3NOXTTVApe2CTxurSRBNWDq5WBQp7QpxflrhBJUfREwox3uuOsKy21DxOdnllXNeyBCkAVgpR1RWVueQ99QHm92Z2d4yxTfhWyYf/C9dz7E06PyEpZWVwodSFm1UV0CzGS9/llI5CeOgUl77mbgYYSXXJO/4vQzAIzC420ddDRdmsOrv9RVq9mTwvRMc59q+aCMtVWnZnkVJsR3czaDK8xQXVAFry+a66vFBrql0BTnQsBFQKuhl5+ztQwrRpuZy0qQ2fPd2DmReBejhtYOZziIgCg7Hk598aRX44D2T1xW0lvjQBCUaZBd05r6rfsehQaDbL3jYssO+/A4cPBvJsZljlSWoj/+rCHkBdbt5nInZjJ8bR5x/Cdemwshv/8Uy5YReVIDnCslF91ZYPUMqmI+lSA4hP4GLDdMZiAhdcOvad3kh+/qdddfaylcFOaK56OjGK/00F/HBbeUrup3Z3c6aWerk9z3CZqP13Z8y1RWqjZe11IBp2/gf3PQx9h6eO33bPQm5WokR5H0UOI4D58KPWBx8ZRBfea49TUcsxjIxzTwyR5OTCihQd1bG8auPxWqRwQu5naLwYq1T9POxyfUOS8FRjy4j+jXRGFYTxbtbAYYMM4v4SxWNXX/fGokrUsrucP9JhR/hBDCHRrY89ujxzyDKCJVlC3PYbWm3wvAVfLMRZfTQU21BmI39LGvucSBi2hmodSIM2HSlEOt6to/RhZkQ0/F2hD0PqJX0pDpWItPrk6bA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b34c4f-413c-4e15-7b13-08db14ff105f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3213.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 18:03:12.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVQIEM7nvugq9h4KBHu2zX8C085hlfW1IwE+diAILNaxzlYBfcoIZZf6Yw8xOxjFbXHaXpCQi2Yu7Z3RY3copA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_06,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220157
X-Proofpoint-GUID: 0ouDAcruudXxHxwAMGwqYnuwSsi2U9Ql
X-Proofpoint-ORIG-GUID: 0ouDAcruudXxHxwAMGwqYnuwSsi2U9Ql
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/21/23 14:57, Eduard Zingerman wrote:
> On Tue, 2023-02-21 at 11:38 -0800, David Faust wrote:
> [...]
>> Very nice.
>> Keeping the 0x6000 tag and instead changing the name sounds good to us.
>>
>> From the GCC side, support for BTF tags will be new either way but
>> conserving DWARF tag numbers is a good idea.
> 
> Great, thank you!
> 
>>> Both [1] and [2] are in a workable state, but [2] lacks support for
>>> subroutine types and "void *" for now. If you are onboard with this change
>>> I'll proceed with finalizing [1] and [2]. (Also, ":v2" suffix might be not
>>> the best, I'm open to naming suggestions).
>>
>> As for the name, I am not sure the ":v2" suffix is a good idea.
>>
>> If we need a new name anyway, this could be a good opportunity to use
>> something more generic. The annotation DIEs, especially with the new
>> format, could be more widely useful than exclusively for producing BTF.
>>
>> For example, some other tool may want to process these same user
>> annotations which are now recorded in DWARF, but may not involve BPF/BTF
>> at all. Tying "btf" into the name seems to unnecessarily discourage
>> those use cases.
>>
>> What do you think about something like "debug_type_tag" or 
>> "debug_type_annotation" (and a similar update for the decl tags)?
>> The translation into BTF records would be the same, but the DWARF info
>> would stand on its own without being tied to BTF.
>>
>> (Naming is a bit tricky since terms like 'tag' are already in use by
>> DWARF, e.g. "type tag" in the context of DWARF DIEs makes me think of
>> DW_TAG_xxxx_type...)
>>
>> As far as I understand, early proposals for the tags were more generic
>> but the LLVM reviewers wished for something more specific due to the
>> relatively limited use of the tags at the time. Now that the tags and
>> their DWARF format have matured I think a good case can be made to
>> make these generic. We'd be happy to help push for such change.
> 
> On the other hand, BTF is a thing we are using this annotation for.
> Any other tool can reuse DW_TAG_LLVM_annotation, but it will need a
> way to distinguish it's annotations from BTF annotations. And this can
> be done by using a different DW_AT_name. So, it seems logical to
> retain "btf" in the DW_AT_name. What do you think?

OK I can understand keeping it BTF specific.

Other than that, I don't come up with any significantly different idea 
than to use the ":v2" suffix, so let's go with "btf_type_tag:v2"?

Thanks

> 
>>> As a somewhat orthogonal question, would it be possible for you to use the
>>> same 0x6000 tag on GCC side? I looked at master branch of [3] but can't
>>> find any mentions of btf_type_tag.
>>
>> Yes, we plan to use the same 0x6000 in GCC. Support for btf_type_tag isn't
>> committed in master yet; I originally worked on patches [1] last spring but
>> they were not committed due to some of the issues we've now worked out
>> (notably the attribute ordering/association problem). But 0x6000 is not
>> currently in use in GCC and didn't come up as a problem for those patches,
>> so I don't think it should be an issue.
> 
> Understood, thank you for the clarification.
> 
> Thanks,
> Eduard
