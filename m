Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F13681E36
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 23:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjA3Wig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 17:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3Wif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 17:38:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637EF2D168
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 14:38:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UMNvUV001810;
        Mon, 30 Jan 2023 22:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kd2KN+2ksCk7kqqJyMAB7gU03IlxIo3FRux3tQAqU/0=;
 b=r4qviYrlxUJnA1bOWDKl1t2C5cBdLKQODw2y9IX2SglMhDRdoBW/J3DpTt9FZaLcS84P
 Wjt0zN7zRCc6aSzb8tZC6po7A713t7irIRgmf5pq/eUuv1eFyfMhubZptPZHAnHgnL5O
 LYer+vh/6Km0MjrID3/PQ17kJHSjc5GAqF+mTAMgioxX/oDbnJMMMuwkVSTtZKv/wXaS
 KOyDH/IJAnNmqPBWDt1Gh3vvy2ol6VDc0W/yxV2UrbEyt3bSVZXt7KsmVLJV8SPbbjDv
 /5HEKS47sMySy0sfXgREJ8KHjwvMtiyIqn8lemKWGtTA55mWJ3qz5sL9zLcQj9fkWTFw Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhm5vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 22:38:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UM5Fx5027760;
        Mon, 30 Jan 2023 22:38:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5c2bv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 22:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGDwljlb6r2cvp2XAzwk4RNzkHh5c7c/qNQ98PQTl/FP8dRmQfjXS2af3NfAg+XCPKH+hMrSpzSredQuGyd1XrxGDeT/Nnxus5B3/5+zQd+GQZfiT83HyiuX9D7S1gsmP6sS495El+6tHDFNB0jFIDs/AvWLyOJW7lA4lKdURtk+3mF2kOo6TdBNxriGIRyA8C1swF5bOW56JTZPeiLcVdmIhlLm1iBloCj5cWkBGdwWuwiKR7V/2Wcih5qC0+7+kYVrKJQWmwZiH3SBooroxjyScnKSbElIHfQA/pL0X+N11/pnwx7gpS//k4AcbqxhmEiGBkosZKplEDuR+3K1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd2KN+2ksCk7kqqJyMAB7gU03IlxIo3FRux3tQAqU/0=;
 b=dzwMp8RnSwMaTr7+Oi17FR+RVvm4VMnzcATsl7aAhVfv9FYhBruO7jUeU9AI/USf0vKRanr07WJn6WdSipgQpKAUGrFOHhbRjZ4Cdl0vr9zI5dVc/q5TI0cVfcvaORq4SKSst6tUJqb2ygyNGMoL7HLXSGuPuY+1PQvi75IQxYb6hpvyI1nuyfaBi/sJ7rvHqfCcikCBMNORNRt5ABV25+yO4YjR+Vj2gixBrKZov5+tvlUnqDTz59aRksgDv61cDsSKsUDrhsFGMMAnAxRTMDs5/x4mVMlsYbBehx8yzQDmfjDBTobv71p8ekFEQ7MthysOU2+YzoUREKoRfoC5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd2KN+2ksCk7kqqJyMAB7gU03IlxIo3FRux3tQAqU/0=;
 b=aZ4rNrY2EVCZiH8xGjlzKirKRu9q+9PT9RZt/NDNdD5dZFqwB3WoQBpZMY2T77NGGfNgWhupiparZQoGGGK1Ez9lagi93tGQfUmMPbNmmnEiqMJvDVE5dKE/Uqk/4U2Gl15TlfhdLZaSItI3oPxy9cVqdBb0HXWxBJMO9pgKQLI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Mon, 30 Jan
 2023 22:38:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6064.021; Mon, 30 Jan 2023
 22:38:04 +0000
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org> <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
Date:   Mon, 30 Jan 2023 22:37:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9gnQSUvJQ6WRx8y@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0182.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW5PR10MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: da8c4b8a-2dbd-495c-e1b9-08db0312a6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zf5PtQhU79+tM8JtpPjwe9UUHBKjZTT3OJ95Cq28eEtKqFn3mXse96pIod6+p+L385bmOUc7t/QyaxQI8dXsJK5MPe9O/PP7zBfJUj8jfZrsAo/2snaPfsypHchhdVc0DES7uQdqSHeEcdSIXJSZyMOlWe9quUNWqzANNHBgjZPhBDRyjnHJioP3XhmrJo6PPh/X5I/sOeSpa98Bw5NyTt2wUoI2gbv3Vc4TCbXc+2Gwd8DafoQLHvrp0a/t9g/zYKEd1tt5u6D+474yTTF9wdeplrkgJb6y0erolEMmeB1y8tgPLZKYq+Zp0mo4B7oSr1Tpn1hm1TD+RQp5Bhro5ISFpFojekP8cMVkihZ95b+CARdZSSb8BGnau08cSrPcjOVgqZgrc14f96dqi35MKuHdviHky2ab3sLcoasLsDQ3k/mmDDxNfmPPY1fBsEdeCyB1Bi8GwPLzvgXBu9mX50smGr9Hca3VC3LuzHM4iKAcHJrlg4CIMWv71UOjZd3sqOWW///Mbnzh9CqFIBJtxwRO7N0nB/GKh9E931wJyND1/2HqvsM/Us/qzurq7v60osv2Qu9tdRoKZYI+CVCMfPQaFyT/RWssTvTE5eG8dbKHuq8Eu6ZzMfMBGTMTmWlutDNiQqa5wlBbIrgP2PsCo1P7B/ypaQpYthVc1tWriWxpapIWfuIRkxX84JS8IB3QiJO3wY4OFAqs6tWgmr6dZ2211R/qmQOyw2YNdiUm72Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199018)(31686004)(316002)(8936002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(6916009)(4326008)(8676002)(7416002)(2906002)(44832011)(6486002)(478600001)(6512007)(2616005)(6506007)(53546011)(6666004)(36756003)(186003)(86362001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzk2KzNxTVVQMXYrY2pXRHg2UXdPR3oxMmNKbkFKNVZ3QnBvZFRZb1dqWDRO?=
 =?utf-8?B?c3p2am9xdU1abS9JSEExK3pwSDUzeHRmRk8waGtuaGRHSFpGWjdiUXk1US9o?=
 =?utf-8?B?L3BiemtpZ0wzeCt2Q0FLc3RmdGlPaUFuakJtUThMUk1GSkk4aWFUaE56K21y?=
 =?utf-8?B?eEQ3N2VXQ0FEOTFCZ21saEhiQ0RzQ2ZDN05Mb0lmdTlXUjJocDY0SlpnNndh?=
 =?utf-8?B?Y0x5dk9kOHRsbGlVT0pPME4wQzV3OFYxM1RyWXlxWU83dGFOSG5pVFFHUERn?=
 =?utf-8?B?ejVLWGUxWWNsaGNhM09zdENZMFg4K3ZjdFkzbjJRTE5ZdldqeUNrcHJOMEgz?=
 =?utf-8?B?bXc3OGkwNTE3QktGaHA3aUNEZS9VSG5ZQkdsazN0Q3ZWaUpEbFljK0JkWXcx?=
 =?utf-8?B?T2JtdHRBY1VYQXRueXZIdzVvRDg5VFNZc2FpVTQxZkJnYWxRTlhDTlhrSWNy?=
 =?utf-8?B?QjJrMUJRaysxUCt4eS9xSitaRlBDQ1l0R2U3VkcwNVhMYWhTYjExMTJKMXc5?=
 =?utf-8?B?NEk2ZmpnZ0dhMUsyYXFUKy85cGFVeEtEbkUvOHRYYVlUOWwvMzEyYkxsVGRa?=
 =?utf-8?B?eitrcS9SOVliQ2o4elJuUHZKOWI1Q2RaR2Nud052dHhaRUc0ODhncFRWM2F4?=
 =?utf-8?B?WXViblgzQTJ3bjBuUjdraUlzTmkwdURFdGNtSU5FRXRXVEVuazNDM0x4MHJa?=
 =?utf-8?B?WHRkZENpVTlrVjZyTE9RWmIvQjJZN0xsTFZXWU1iUnQyQjVOU3haM3p2RmYr?=
 =?utf-8?B?bHlpZFRNYXIrc2xkcnk1ZStGTDBkSkJmNVRyWnJHcXJiOGI1c0QrVEJlWWdr?=
 =?utf-8?B?YlVLN3BKNTZYb3B1VjJLMUpBeVBjM0Y5MGd1M1UwYTNDa3ZlZTRRNmMwK1BS?=
 =?utf-8?B?SUgwWUdIT3NldFk4Rzk5QlNsUG5XRnJQeWNWNFRHdDM0dFdpOFhQZno4QzNm?=
 =?utf-8?B?bkpja0Jla3N5SU95Y0lXeEFNNlZlN2JrK0VrdkVKRTNQOTJaam5qY1JjUDhv?=
 =?utf-8?B?WkNkUmxwSG1yVkN4b3M2d3dLc1N6SVZneWpNM2E1VDZXaGFkTUxqMGtuOEFu?=
 =?utf-8?B?UzE4Y2YzelFUc1VXWnJlZGJRZFBDZytZalZDek5uS3UvOS9LcnJKYmt0MTl3?=
 =?utf-8?B?aFJ4RkoyN1hWT2lYcG81QzNtbEhiMWNFL21iVUdtQ2tsUU9LRzU3TTNrMThL?=
 =?utf-8?B?R2U2aWJmK0NybmtBRlYzUVdwSDRhaDd4OEZBZ3dIMG9MU0dLVlR3SmxMUERY?=
 =?utf-8?B?c1ovZCtrVWJpeG5KQXZRNHRvWUNMRndGY212ZGVmN1UwVEpoUXR4aWFKL0x5?=
 =?utf-8?B?SVpJWnE0U3RkbGFHYmhFQ2JNNkMxckhta2hpRVhpclM3VGdoZDRxSjM5eTFB?=
 =?utf-8?B?Q3NVMEJwM2hMbENzeHJrNlJoTXNWNVhua1YxdnQzeFhnWFI2SVFURjBCeDZx?=
 =?utf-8?B?Q05CQlhYTTBQeWxRMm1KOWdJZUZSaVRsNVBabjVSVDZEbkk3K2g4TWk2ZzNm?=
 =?utf-8?B?dmhPTGpsYndCNk1nNzBRdHhpeGNodDJqUUE0MlBhdXJHcUZ6UkJIYTR5QjYz?=
 =?utf-8?B?Q25TZC9xRGRubDRYdmJwR3VzNXRNME1iUCtQNXIrMU1td3dJSUcwSkgrYVBz?=
 =?utf-8?B?aFVTVnROZFZKZnNrZGlvU1htUitPcW9STUk5MjhTcEhVN0Z5eitFbmpUR2E4?=
 =?utf-8?B?T3BUVTdrT2s0Nm41ZHAvUHM5NXRiNXV0bU52WWJna1RoN1lLMGZHdVdIV3du?=
 =?utf-8?B?L1FMdlBsNXFnYmJFZnJ1U2tRcWthaDgzQXUvV1U4ZUo3cGliUVRGeW5aZ0ZQ?=
 =?utf-8?B?azJCWlk5QTVSWlFSYmZYcnN4dU1TUms0cGN6YzcxRHl5SFRGd0poVjJHNVFy?=
 =?utf-8?B?R01jb2MvYU4zSGFDUW1OSGpleUR1cXBLcEM5a2hnQU41NlZoM29ZRzU1VFF3?=
 =?utf-8?B?ekdacGltRlcyMWJ4bm5TR2k1RE5zR204bS9pR2RIRWtKNzlRNkkwQlZiaFRY?=
 =?utf-8?B?NGw4WUY1ZVprVk9qd2tEQVVSZURrdk9zSUVVMXR2endMbkdCS01oU3d5eU5n?=
 =?utf-8?B?NWh4R1UxczZMT3ZuS0JzSFpCZFltdS9MSzRSQnJRQ0NoRnJFUUlwYVdqaUVN?=
 =?utf-8?B?M1c1cCtIM1RqS3RRN3J5UlVkc1J5cGhtWTlPQzhFckIwUzJ5TE8rQWRFOFg1?=
 =?utf-8?Q?gJyviM2rAElbkszgjg5reGI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bU1jdm1ZWXhvTGxKcDVTR09ob1VHTThzNStLdGVreHF0UkY0NmJXcWhoZUpG?=
 =?utf-8?B?dXRVbG80N3JjZEJYNTZLRFBnT3FyTWl2SzdyRHdyaVNYc3d0VXUxS0Jld1FO?=
 =?utf-8?B?RDRIejV4aFFNZ2pRd2Y0b2VPVDQ1REVIRFJqOUwreHNzTTBxaXQ4S3BLNlFY?=
 =?utf-8?B?MDd6K3EzZTJrZ3ZCdURQMGJaVW5SMTlJUVFreDZQdkcwUUhENnhaSWlLbGF3?=
 =?utf-8?B?WmhoZmthczNTbHduMEFjVWFBMndDcU5UNllPRk1QVG9yMUdWUFlXV0V5T2gw?=
 =?utf-8?B?YmExS3JveVNOdXp2cFlVYlY4alVISWU0RXIrOW1UTWRyOTlTNWl0eGRFbmNv?=
 =?utf-8?B?T2pWWG1EWXVMOFM0VXo3VUhxdnNhTDFXdXYxdGtNVkNhTzRhbkFyZksvVk1L?=
 =?utf-8?B?ckdPb3h6SjNxNEc5N0pNejJaak9OREl5dEFwM3AzNHJmSWRTK2hWdXlTWi92?=
 =?utf-8?B?YkFNM1NXZ0NXSlVjZDdHTnF5NXVkUEtYTTAwTWxOYjJRWHJUdlJCK0h1UkRh?=
 =?utf-8?B?MFE5ZC92NFpPbEN3WjZlMFVETFM3NEN4WUh5NEFTMmJ2dDYreUR3NGEvMkZ2?=
 =?utf-8?B?aENpVXoyWWQzZ2tQSmNkUnN1eWc3VkJVeDJ2K3diOHBGT2JCY1o2NVZJNmp0?=
 =?utf-8?B?eHk0bUdkMXlLYjJOWmdXbmlBTTNvcXlSVnJaTmFuRkxaQy9QNHg3dlpGSkhM?=
 =?utf-8?B?NTcrYkh4TXVGZ21udHg2NEJjQ0QxL1JPKysrOGVoUnhLZThNaURoOUdFNFQ5?=
 =?utf-8?B?RWZMejJCaFllR0pkMWo2THdjNEdNSzVCaEVKV211RWdDRzF3c2RaWXR1dU9s?=
 =?utf-8?B?Rm4yS1BuaUpFZWgxRElEdTRXa3RWQkhjcWNSc1crUEIrMG1ibkdmTURhQkZ4?=
 =?utf-8?B?K3I4MXYwcEp3NkdhaUh5ZHZNK0VyMEczZWRNZExwQ2pySjI0QnN5R2UwM0lv?=
 =?utf-8?B?Q3g3VytJN2xlSnlvSklhK0FMVjBYSVMxOGw2bFBQUjhucTRjd1Awb3VJQ0hF?=
 =?utf-8?B?eWZBMkdzeHc2VHNjeVZzMGhnc3N0OEdiZXdPTEdLTkxHWTVUQUtxU0d0Qmt6?=
 =?utf-8?B?eWN6cnF1YzdFR1A5Zk1FMmpsNVppcEdLbGdocWVncGpiblRIOVhxbWt2SXpj?=
 =?utf-8?B?NG9HeVNVUFZFMXFPcHVDVWtpM0xzWmxxdkhuSFdRdktHWjR1dS9vbTlIbUVp?=
 =?utf-8?B?Y01QelY1UWVBMzhWRDVnZXlRL3Noc1Z0cTNXczAvelFiUS9qWTZ2NlJSUWp0?=
 =?utf-8?B?NHpRWW1iYk0zT0RzUDZrWmlaR09CbTRJK2hmV0lHQVkyRnNidz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8c4b8a-2dbd-495c-e1b9-08db0312a6ad
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:38:04.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzdEQDpAxM2Tw1Z/qvpssttc/Wi46ethMDVa/YukZvojw1w3c9oN3OYJV7CA05FZTGRg5JNF+B0QzMvnRJL8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300207
X-Proofpoint-ORIG-GUID: r1RSMhpzIN26Xw-NL5x6oSoO65qLRJRa
X-Proofpoint-GUID: r1RSMhpzIN26Xw-NL5x6oSoO65qLRJRa
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 30, 2023 at 03:36:09PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> +#define NR_REGISTER_PARAMS	8
>>>> +#elif defined(__arc__)
>>>> +#define NR_REGISTER_PARAMS	8
>>>> +#else
>>>> +#define NR_REGISTER_PARAMS      0
>>>> +#endif
>>>
>>> This should be done as a function, something like:
>>>
>>> int cu__nr_register_params(struct cu *cu)
>>> {
>>> 	GElf_Ehdr ehdr;
>>>
>>> 	gelf_getehdr(cu->elf, &ehdr);
>>>
>>> 	switch (ehdr.machine) {
>>> 	...
>>>
>>> }
>>>
>>> I'm coding that now, will send the diff shortly.
>>>
>>> This is to support cross-builds.
>>
>> I made this change to this patch, please check.
> 
> And added this to that cset:
> 
> Committer notes:
> 
> Changed the NR_REGISTER_PARAMS definition from a if/elif/endif for the
> native architecture into a function that uses the ELF header e_machine
> to find the target architecture, to allow for cross builds. 
> 
> ---
> 
> - Arnaldo
> 
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 752a3c1afc4494f2..81963e71715c8435 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -994,29 +994,29 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
>>  
>>  /* How many function parameters are passed via registers?  Used below in
>>   * determining if an argument has been optimized out or if it is simply
>> - * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
>> - * allows unsupported architectures to skip tagging optimized-out
>> + * an argument > cu__nr_register_params().  Making cu__nr_register_params()
>> + * return 0 allows unsupported architectures to skip tagging optimized-out
>>   * values.
>>   */
>> -#if defined(__x86_64__)
>> -#define NR_REGISTER_PARAMS      6
>> -#elif defined(__s390__)
>> -#define NR_REGISTER_PARAMS	5
>> -#elif defined(__aarch64__)
>> -#define NR_REGISTER_PARAMS      8
>> -#elif defined(__mips__)
>> -#define NR_REGISTER_PARAMS	8
>> -#elif defined(__powerpc__)
>> -#define NR_REGISTER_PARAMS	8
>> -#elif defined(__sparc__)
>> -#define NR_REGISTER_PARAMS	6
>> -#elif defined(__riscv) && __riscv_xlen == 64
>> -#define NR_REGISTER_PARAMS	8
>> -#elif defined(__arc__)
>> -#define NR_REGISTER_PARAMS	8
>> -#else
>> -#define NR_REGISTER_PARAMS      0
>> -#endif
>> +static int arch__nr_register_params(const GElf_Ehdr *ehdr)
>> +{
>> +	switch (ehdr->e_machine) {
>> +	case EM_S390:	 return 5;
>> +	case EM_SPARC:
>> +	case EM_SPARCV9:
>> +	case EM_X86_64:	 return 6;
>> +	case EM_AARCH64:
>> +	case EM_ARC:
>> +	case EM_ARM:
>> +	case EM_MIPS:
>> +	case EM_PPC:
>> +	case EM_PPC64:
>> +	case EM_RISCV:	 return 8;
>> +	default:	 break;
>> +	}
>> +
>> +	return 0;
>> +}
>>  
>>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>  					struct conf_load *conf, int param_idx)
>> @@ -1031,7 +1031,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>  		tag__init(&parm->tag, cu, die);
>>  		parm->name = attr_string(die, DW_AT_name, conf);
>>  
>> -		if (param_idx >= NR_REGISTER_PARAMS)
>> +		if (param_idx >= cu->nr_register_params)
>>  			return parm;
>>  		/* Parameters which use DW_AT_abstract_origin to point at
>>  		 * the original parameter definition (with no name in the DIE)
>> @@ -2870,6 +2870,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
>>  		return DWARF_CB_ABORT;
>>  
>>  	cu->little_endian = ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
>> +	cu->nr_register_params = arch__nr_register_params(&ehdr);
>>  	return 0;
>>  }
>>  
>> diff --git a/dwarves.h b/dwarves.h
>> index fd1ca3ae9f4ab531..ddf56f0124e0ec03 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -262,6 +262,7 @@ struct cu {
>>  	uint8_t		 has_addr_info:1;
>>  	uint8_t		 uses_global_strings:1;
>>  	uint8_t		 little_endian:1;
>> +	uint8_t		 nr_register_params;
>>  	uint16_t	 language;
>>  	unsigned long	 nr_inline_expansions;
>>  	size_t		 size_inline_expansions;
> 

Thanks for this, never thought of cross-builds to be honest!
Tested just now on x86_64 and aarch64 at my end, just ran
into one small thing on one system; turns out EM_RISCV isn't
defined if using a very old elf.h; below works around this
(dwarves otherwise builds fine on this system).

diff --git a/dwarf_loader.c b/dwarf_loader.c
index dba2d37..47a3bc2 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -992,6 +992,11 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *c
        return member;
 }
 
+/* for older elf.h */
+#ifndef EM_RISCV
+#define EM_RISCV       243
+#endif
+
 /* How many function parameters are passed via registers?  Used below in
  * determining if an argument has been optimized out or if it is simply
  * an argument > cu__nr_register_params().  Making cu__nr_register_params()
