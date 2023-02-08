Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7068F1EF
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 16:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBHP0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 10:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHPZ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 10:25:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A345F46
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 07:25:56 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318DU483003698;
        Wed, 8 Feb 2023 15:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UiZXs2DS9+zfjS0pd7O1B8ZFe/CGeqjAa1Cot+Pni4c=;
 b=Xz+n7MprurxB2zhJeE6gZ0c1L+KZfbo6mS4c8XGkS6lbPvwFD7OHT8pUmZMOA16hoTGM
 lTpypI/XuQpL+vPfiZpuapYW1QRwhz052C/hzJTl8G12HwlvKxo1hu32DJBGS8oB6iJ3
 gdF58uLn1BDlY1TyybbKNZL7r4zNBE7tuEXKWKraycPaTtyJ/Vh79II7M3PFIvO07o/O
 jobdWw5WhFbyxKg4CHzk87/r+nwT+X6NR8e9d+CFCvP/mDXY1Ndz2uJp0r70vyRJ90oP
 BFZb0loT8+/RyZjjgwWIeJwTkg2xSWZOoVxXHivGj8mVt1qdP8mkJXarKHJMBURAuQWP zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nge3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 15:25:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318F3XNK028564;
        Wed, 8 Feb 2023 15:25:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtduv0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 15:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USeY/g/Q7QwWGu7ZO29PtkyN6kFXhSFiJQXQm3NHiA+OKjV2LThgjGHLLP9CWiyQWEQb1QrgB4EHA722vwrwl891D8/1VGgbx+n1IOSYUoKdhbxIXtvv1aBuf9nH5nBapOsWNDJJCkJvMw4n+A+RkqQPgNr39uH+N6hKY7LFHAVuKCiBuWFxqwFc4v1k0+UbNjJP+HU7JxopgTSGpq2lCshhk5xs9DJhTczQMuRnXGtthUHkmr8MNq6Ifbf0oFihoNaS0K9s3jGhCpitDNFHw/IIK5O44Dgi2mWfXUEPgjvctqAYlkGjbTHcHI2m8klbRaQ1SGqyz/63K0gSa8OgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiZXs2DS9+zfjS0pd7O1B8ZFe/CGeqjAa1Cot+Pni4c=;
 b=U83uIrUD6NwlWYcTNbIytlMJtGDWWszpM63+TdZVkb79D3E6bYLavnfke2B2ea7oUjjApJ0rm/37U/L4Fbs0vsoFggw2KWOMztsH9yS9Xj3jMTB6xCKw3ztsvhu6lNqX3oW94xpKF6r4o/lQak+vF6Xy31J/E8V4jT8ker7j+dwqhJ7wKtSx9oJM6jlNQ8TGtZptR+yaZi3H9Smd6/hgCO0Blv7+aF3RRc36Hoy9gfJx/7/Ha9gMKmsigvt21WW/bxDYmyNVviY01xBLMEnDwfjh2qyeZbkmgXqJ5wE9ay9BluIGbixXpRaSixoF8GVRhwvZWwOACJ0t6QrAXnQN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiZXs2DS9+zfjS0pd7O1B8ZFe/CGeqjAa1Cot+Pni4c=;
 b=I2ZNg8SDb64qU8pFDbpmlufQRKqR3XEPPWfcuPWAClO6JD96p/jFL6C4VPYIbIg4n57pPUtXWwjPs29xJNfIhv8IP/s1Y+PSybaWA65RPO4lXE4FGxzliLfrN53B3pKz5VWrgpt9wcairv7w6d11C5VMUPgsIvjU6fkvb/iw0do=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Wed, 8 Feb
 2023 15:25:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 15:25:24 +0000
Subject: Re: [PATCH v3 dwarves 0/8] dwarves: support encoding of optimized-out
 parameters, removal of inconsistent static functions
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     acme@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <Y+OhotzeEIdPByi6@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <7255224e-696a-f0b2-993d-4659667f88fd@oracle.com>
Date:   Wed, 8 Feb 2023 15:25:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y+OhotzeEIdPByi6@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: 15534d18-4c1c-49d3-59e6-08db09e8b2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvRwButQqDcqOq+kOZvjuQn+PFhVw7MuTl0P+KaBhs0X5EA9Ov/TaMJ2w6iJ2NlY68PtzjsJgXDshzTavqrQYpee1sGpIB/M+zBqwvNjzzB83Jq2+r6zB0aNZkW05rC3e4MvH8Hba8pIBn8DeM/IEaEEtLbn+Ixof4aAEITw2tdYPE3RQXLr+n9H6lqKUgaXd4Ok1dXGx0e2+t8mVCSPtwzsUBlcPnqYjckgW31/qUa9ds9/F+xlLb9q9P7u0wuDxFboOq7GllG8BdxXERdWE31JMxV/5xZYZKmEos/hbRCIsAy1o3n81DfmJdPOb0PuJcfp+3HU+wZAaxZ9XBv6eDF1neQiWlvHXPhHaeRpkjIS8SyCg93SsTsbDZwG6ZSkBpDmsE/9OxOjVGuBUryDcX+u5OALG+IwttivvZ3DmSK9Lci/qhnBBZmgL+R1OpxXf04pAgmNvs1PoURikcqqVldA4EKx/YPqnszc6HwSAYHEvrFhfOxlwgAPsCEHqgHa4wdtJwiptYiOA9rqorXnlTEMLFE8Hn1XHE3wGiSe2FMEhLnZmI+mla3n7k7dlFuCUs/AkFd5TPzLBmi9mfwaQCXb5oouoMJUvdX7o/rH/SDt7tP7xEXe7nGwl7XGCa2puNL6BHwn2NeTxr4tRbD4VUGX9btdvmreCsfEIIO1oZpN6/o/8yB/h6LvDuWIZoHAd85C2fQJSjnHDyWsWe6ScOzi2m5QJIojPHPs1/Llj3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199018)(6666004)(83380400001)(86362001)(2616005)(66946007)(6486002)(6916009)(8676002)(66556008)(41300700001)(44832011)(4326008)(66476007)(478600001)(36756003)(2906002)(316002)(31686004)(38100700002)(8936002)(53546011)(6512007)(186003)(7416002)(31696002)(6506007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTgrTEJuVWJWejdPZno5K1pTZS9ENnlTNWkvRG1VVVBlL2h2OUdYN0VpdmxI?=
 =?utf-8?B?VHhTcytJS0F3a285VDh2OGJ0bmZRRTdDUVEvOHhWeU83bUdnakZFWFd6cW9z?=
 =?utf-8?B?MHQvSHZObWlieEx6aFZ5QUhMRGdqVmJmZzVDeDQ1SStYd2RpZ0gxa3R2WnZj?=
 =?utf-8?B?c0Jnam5wUEpycmgvYnF2Q2ZWM1FKLzB5UmhUZWlncEZWOVhBUmtlQStJM1cr?=
 =?utf-8?B?TkxGSkJvaE9YNTBuZ212UnZOUkV5RzBhK2NYaXRuVytBM1lHOVQxQTBYUURO?=
 =?utf-8?B?cEg1OUc0V096SWRrakZrQ2ZCbEwzcHh1bDNTelRTYUNLa1JNUUxSd0lFQzZM?=
 =?utf-8?B?aHd5dGxablU5QkxPOTc3VERzbVBvSW45K0VFdElSNFhNZEExYWExVDRHa2k4?=
 =?utf-8?B?UHE1Q0ZJZGxHNnBhQWVuejRESG4xRmlNVnZUVFFZb0FKS0ZyTndsTFFjYkJk?=
 =?utf-8?B?TTRxWkw0eFljSFRLMHpyQ2VrZ1VZWVVacHRaZ0JoU2hvSFlzM3Z2Ym8zOFF0?=
 =?utf-8?B?N2Y3T1pJQXcreGJpV0VqUWpwL3Zla2J5NVpRb0JXcU1zSHV6dkl2R2c4cEZR?=
 =?utf-8?B?TDNSb1BBVXZjT3VXdFNpNTgreFBRckVlbXlMVkttRklqQlMxeFhza20ydlZD?=
 =?utf-8?B?Vi9oN290dHVUSERBVjhhV25XMEN6ODlXLzhMZ204MlI0ZmJmUmF0ejF5c2VD?=
 =?utf-8?B?bXJqM1JRdHZLZTd4Q2xEdkRFVEh4YWU0WnJaMjRrNEFnZFpwb0NKNjhuQytp?=
 =?utf-8?B?cmc4UmJKc2tVVFRnUXV2K1ViZU9CQW5QYzRnVWRpdW0yMVQ0OGNBMS9vcDRG?=
 =?utf-8?B?NHBjVWttMVJDV05uNUp4Q3llM1IrKzN4d256aC9jZitvVnRZWFNlS0pOOVJL?=
 =?utf-8?B?SnFOLzExaEt6MVRIUlBDUWo1N05nT2RvZzNzTHd4Ry9QZmlpbVV0blF4Vk4v?=
 =?utf-8?B?NGhQb1I4QnhwL3EwU1JFVFFoZkkzVDNXakpzUThsYnhQSVROeEVrYjZKVVI3?=
 =?utf-8?B?SXlSOGRXVzEyYlFCVisxQVIwNWJsbkZqVmdaMlZ6ZFBteEdMa1d3M3RLdWxr?=
 =?utf-8?B?ZC9ZN3p2N2lIRVpXWlhWam10NFlvYk5EVmFKU1FocWVBRkEyeDA1bzhPUzl6?=
 =?utf-8?B?RWRDelRQcVcrYnBBRENzSHZjVUlBUlIwSUxXSlJlYnJvYW40clZsM0NIZkFl?=
 =?utf-8?B?QTkvY0drY2lVNWdQQ2krSVV2WlZzOG9xMG5yemVJUlFHRzJYcTFZN0NhL2VK?=
 =?utf-8?B?R2VXV04xc0I3RkJkTHpxck1EV1ZpOUVWK0N5Q2JQYlJyS1Zobkh2Z2ZOeUd3?=
 =?utf-8?B?ekN5bjREYzBlV3ZpUndGMk0yV2xOUEhLMU9ieXVIYWlHb1VPUE1yV3BhY1Rq?=
 =?utf-8?B?Z2ZWc3IzTTVPL3MwUkhPWTh3M1JHcU5xMExCWUhEMUJCODE1TUZVMHF4RFNs?=
 =?utf-8?B?WFdVSmZBN05FVG9CbHV5Z0c3elI2clo1Q1lzV0FEa0JaYkNYVUUxREtQQVph?=
 =?utf-8?B?eHJMajVkTGJpNk14T1kyeUlmT0RGSG1pMitlcnA3SStDR0R4UnBVbHhxbnh6?=
 =?utf-8?B?TXRCUldVc0N2OURRSnV3alZFQzl6ZFVrN0Z0UTJvTS9Xa0xqK1l2RGpQRXht?=
 =?utf-8?B?K2V1NEFDYXZLN1RLdW9lTkN4MTdmL2xiOUVBR2xIeVo3eXpIdGw2UnpUclhh?=
 =?utf-8?B?TCsvdkpTclNSRFNxT0RVa1NiY0lkejNRWFV0VW14d0dLNS9hVm9OUnAyWDlP?=
 =?utf-8?B?VDBnVDV3YzZDTno4REorc3orOU1venRXay85YVVWNXlBQ1d3cjM3NDhYRzlo?=
 =?utf-8?B?bGFpTW9YYWdWZWRlcmEzVXhBVVlkU0lTY3FGT2Z0eTJDUWtIUXFLc2MxNHlV?=
 =?utf-8?B?cHI3Y1lBL0poQjZ5Y2NiRkVIc1N6eHZHUjBNc3BHa2ZjQlE1cUlVZHMyMEtL?=
 =?utf-8?B?UWt0UEsvcGxOYnoyUHhvRXZiWkthVmdpRTN0YzlhMFA1OUd0Mi9Eb1dCOXZ4?=
 =?utf-8?B?RmNWRzg4MXNJTnd6cElCNnZMZWl2cHhwMXZyelh6aERTWk9kTGFYSjQ5WTdT?=
 =?utf-8?B?TEFUaEdDMnZ3bVVYWVp5R2VvbFFRaWNheEkvL0xKc1NZcnFzdzEyN1RoczRG?=
 =?utf-8?B?U1BBVnNZV21HUkg4VFN4OHZRK3hWL3hmZkc5cDRTblA0Y3lWYmJ2K2U1U3hD?=
 =?utf-8?Q?kbcGRk/6nJjK3WIvFFU2uBE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a3NQdjVWVm1IbHF0RDRRd3A5RG9vRS9TczNDQXlHbjkvNzg2L0huK0tjY1dj?=
 =?utf-8?B?ZU54cnIyYU1MMjkxWnhhQkhYYkRkckJzQVB1UjBRRlRaUzZ4djVOSHN4YUoz?=
 =?utf-8?B?TEhnWjR4N2FYVytKTzRBU0UxL2hjeEl0cllPOXpMQnBYT0pRU1BFZDJaNHYv?=
 =?utf-8?B?akRhYk9sOWFjdEFvaWZUMDFkdkNOY2F4MDMxYjVyUW8xd1oxOWp1Vkt4VkQ5?=
 =?utf-8?B?cW8rUndnZko4b00ySkFEOUNsK0FURTZUMkJzUEtwQlBCcmFsRjFXZkg3eUYx?=
 =?utf-8?B?NFZVcUMyMFppUnhJY09VTmt3ZThRRFJuaGRVbG5McEhYWDVRR2lMR0ZuVjVZ?=
 =?utf-8?B?S0M4SjBrbStLVytIb0svTm9rR3FYREU0alJUbU0xUWV6OFF0RUlLZjF0WHUv?=
 =?utf-8?B?Smw2RmZHTGFiVFRDNVRLNXg1aTNwcThzM04zbDVFSlFhdmdlY1lwZkxhcnFP?=
 =?utf-8?B?SWo4NDBUdmtYQzBUWFNENlBmaWV5MlcveDZxc1lrblR1eStyQmNlcUdDRTha?=
 =?utf-8?B?N1VTZGk0Ulg0OVlUbmxPUlRSWEUvSmNNcHV5aGVmMnJoZmNaRFRjSisxek5K?=
 =?utf-8?B?ZTY1M1pjN3BmSHVSQ1ppbVdTTFhqZmRXY3VxUk5oV0R1MzhlQjl5Um5RYVVl?=
 =?utf-8?B?c2ZxeFhRZ29RaC93QkVCaVF4UXhJeG9rUlM3UWFwUG5BWUFNTzVmalM5MEpy?=
 =?utf-8?B?dHRkbktZTVRlMDl5U0NHNzd0RHRvL1lyend4aEI5Q2lZdzZodHg2dCtLMTVK?=
 =?utf-8?B?ak0rQUlyZ3Ewejk1NCtkT3V4ZGZjVks0QkZ3TDJUemhJdUZEeTVKSWxSdUtQ?=
 =?utf-8?B?Lzh2VEJVdXhGWGs4blNMKzhxaW1CQzVJenpxQ1ZXN1BpMVJYaFREdlJtL0px?=
 =?utf-8?B?dUMyeC96b2ViVWN5UkRpL1lyOE5zQkx5ZVVpU0RHek8wR3hYMCtSZ1hGTERU?=
 =?utf-8?B?cGFVN3pNdzl6dGFQTmVyaWxnR1U4cXZOWGhaSjA4bGpTaU9qbjJhbUhDeEg3?=
 =?utf-8?B?bEgzNnZ2dUczUDVYUHp3QTdEaXJqS0pKSGJZcFVYWWFWemp4cmJqZHRRSkVh?=
 =?utf-8?B?U2ZEU2lYdGdSZ0Zob05wdGN3cmZtYkxTQkRjQUZGOE9HdHlkQzdnN2VCR2wv?=
 =?utf-8?B?WG5vS21SV0tuU2FNMUlpaEVuMC9GMDgycytPcVRSd0Q0T2t3ZU42OUUyTDhp?=
 =?utf-8?B?Z2VSVjJqbUlHOHlSSTBob2xKd2RyemdvYjRFNm1FRU9BNXZ3SkRRRFk3TTdT?=
 =?utf-8?B?NzJVV2k4dFprWklYNFljQkVsbG9nOUNhb1VKcWRqMFJqNklBZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15534d18-4c1c-49d3-59e6-08db09e8b2c1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 15:25:24.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RC+ZAPRmn+BQS6PA+QZ/6RNPjUTlzvFuTxMXFYzOQzYADVEh6FPIZvXWeTZAl2u3baqFaNI8+IB85U5RUgYMFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_06,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=836 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080137
X-Proofpoint-ORIG-GUID: fYX6jQ8u3wWpjmfP7FEDbGQ15W8Mb0Ai
X-Proofpoint-GUID: fYX6jQ8u3wWpjmfP7FEDbGQ15W8Mb0Ai
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/02/2023 13:20, Jiri Olsa wrote:
> On Tue, Feb 07, 2023 at 05:14:54PM +0000, Alan Maguire wrote:
> 
> SNIP
> 
>>
>> Changes since v2 [2]
>> - Arnaldo incorporated some of the suggestions in the v2 thread;
>>   these patches are based on those; the relevant changes are
>>   noted as committer changes.
>> - Patch 1 is unchanged from v2, but the rest of the patches
>>   have been updated:
>> - Patch 2 separates out the changes to the struct btf_encoder
>>   that better support later addition of functions.
>> - Patch 3 then is changed insofar as these changes are no
>>   longer needed for the function addition refactoring.
>> - Patch 4 has a small change; we need to verify that an
>>   encoder has actually been added to the encoders list
>>   prior to removal
>> - Patch 5 changed significantly; when attempting to measure
>>   performance the relatively good numbers attained when using
>>   delayed function addition were not reproducible.
>>   Further analysis revealed that the large number of lookups
>>   caused by the presence of the separate function tree was
>>   a major cause of performance degradation in the multi
>>   threaded case.  So instead of maintaining a separate tree,
>>   we use the ELF function list which we already need to look
>>   up to match ELF -> DWARF function descriptions to store
>>   the function representation.  This has 2 benefits; firstly
>>   as mentioned, we already look up the ELF function so no
>>   additional lookup is required to save the function.
>>   Secondly, the ELF representation is identical for each
>>   encoder, so we can index the same function across multiple
>>   encoder function arrays - this greatly speeds up the
>>   processing of comparing function representations across
>>   encoders.  There is still a performance cost in this
> 
> awesome.. great we can do it without the extra tree
> 
> I wonder we could save some cycles just by memdup-ing the encoder->functions
> array for the subsequent encoders, but that's ok for another patch ;-)
> 

great idea; also provides extra assurance the layout of the
ELF function arrays are identical! I'd started to explore having
ELF info allocated once in main encoder thread and just duped
for other threads; should definitely save some time. thanks!

Alan

> thanks,
> jirka
> 
