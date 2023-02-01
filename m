Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451D6686CAB
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjBARTM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjBARTK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:19:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AEC5598
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 09:19:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311FYjnj027015;
        Wed, 1 Feb 2023 17:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0gcrF/z6sDEueSNLECPMFcjY/4WcrZ+8194WyC+pH5s=;
 b=actLBB1b0nMcQk9vpN5XXE1/yBTqCbQ0afr3f8C6/2I6MF7cKuO24OVYR2rumlGVzI1d
 RuVm+6C0VP9PAQCoJ5vIZl17vqz+oIozQecchyBejPplWFUfmrvJIJIvsVDSn0mO76vK
 T5SLHx/NYrOV8FngWFSaX6z9+7c15iTeJoOf/RgHd5S2PcltMmLJBfuwiAf7DUuMKeRD
 09ygxKBODEvoSaN6irxvxKvggJlJKs27k9plwHbGwdLXFx2vdH77ovrbCZoqgibuPpNk
 IP/3xHu2qwT5Tw7/cQU4eb5TN3tMBNSkGUZa1ksiNrA5jnPgaXnMmDLOwtirFaS+GDjK Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkd1s9xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 17:18:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311GU8i8031835;
        Wed, 1 Feb 2023 17:18:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5ecd8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 17:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX0rmrwOM0ZYQLGO9o3SYR8hVJaFM7w3wYLwo+b7qANTv30If2Wrx8WU8gglu+vknTxGMfBXEis7rWnA1oH+zNg0hj7iRk4fVIc0UrtZyb8oafBezq/8nFFMeYgscuja+T0wJk6EiMRZgqtscXtO52PdwOayAWVlXfBEX+8lFRu7MXDkVecwwwATF1NSvfgJ0IPlidp5CjHWllLtH+j0fZaRP7NW2v3CjpEbvSCxAM1IE2N6Rt5PTNmRadjS74UtdI3pbmKuw3CAPgk0y+WV+QJDDFce+6GSalhVDtUURMIIfiqygiE98QuaXu6z6lpZcOQ86vgoFT4gbXXZ8QdVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gcrF/z6sDEueSNLECPMFcjY/4WcrZ+8194WyC+pH5s=;
 b=J5EwNJZMzKnRRGXtOqrg7utlEj55y/QtMh4TWDiSfQaRWUyiesfP/kGCeS4i7xdJqbAyiRJ22hFe4lDjjo3Q2MGKh14IsiWSzn8F9WGwNIFAn+q+s9slP2YWJHUFQO1rRqcoZ0yOMwzNoVqcyfwdjww6jkaslMv+GkwPIE8sDxxhVycmjwHSjG3hPHvdx4/0QF5QHClEnnJeVgbzLL1E/8BCLoV3+r1BUurqKo5t8ZEIkMCzMHI9fKZhCC3wORgfAtyHe6vI3/+1xAnQIvPr1pTARza01D2dfB5mjeE4xuKCBMeUUx9/Zi0YyN5qH9NRJRbCZON6yPZ8uKuExd/euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gcrF/z6sDEueSNLECPMFcjY/4WcrZ+8194WyC+pH5s=;
 b=ZLpZ94/g650NOEMI3EeySombWBk2YNT5bzOZUdHGHBfSwiMhob1oZiRy0t3wrxS5plYqViBJcUBRAJKwGS4kIoWqtnC/USF9aWqarvkjelTFeAR2Qo1w4HveWkEOCi6Aka4X/oFWtxKtpiB223T8DuKfbIPvyonzHP45ZMZ+EKU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Wed, 1 Feb
 2023 17:18:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 17:18:37 +0000
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
 <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org> <Y9qC5UQaw9g6cPwz@maniforge>
 <CAADnVQJQQQNw0X-jDXquFYcYeSb0f5T3657KqC8+YevFO6A0cA@mail.gmail.com>
 <Y9qa+yFq+8jT+niu@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <a9679d64-4860-a404-6030-22e104aec67f@oracle.com>
Date:   Wed, 1 Feb 2023 17:18:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9qa+yFq+8jT+niu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3957bc-4ef6-4ddd-1e6f-08db04785ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrthGmA10Dh+7guZu+SdoQ4vmMYmhQeTqfPLnbSdIYJ4y/CGB+BdTXF0jnlQm1FmrqIb+NIGxJUlUlp3GVp+9tB+10njfroX7dU8SC9QWBYYS3JQfCowbBLzz8VLcZIIqjnaO6Z2uPGy+5FnFVppwqUDjXb/FQU6EQlU8iVnynqu0z2ZIohXii7TCapFZZlWVbTkrLdCyynaWayeLtuHaRmkq+dBBlWsgqPnUJMPEyrFt2P911lnDWdFsy4paqJaWBeAIp+BcuwuJkICIYN+AvpFP66thPOfJtOIJzEFzICSVOiCBSGE6+HIfG9meu2g2zsSZo+ou/3fSZqgPk9yt9j/DhasVrqJBmrKbV9CYz2Sg35hk5YWgFF2DepNquyZsEWFQO2LP+U808Hsu99Ay2wEKTBa99Hfy1/6blo6OcrBwsa1YW5+G2AEn84UYFffH9VBWc7eEExmnlXqZItH0gQqHnYXMGn4DA/LEeQtIbmvv+nv2Il8fQfINS4PfEvfU08ThD3iYkAe57dXOcndfBOQ3BzCuS30fG792x8gNn0w0vVcZaj75eE69UjUabDnudU69oziCVgdS2OOmo1pKpz9RrdXMeQeogYKYr1S6Kcg/+gGUJTmjuO9ZcgFbfOXr/yR//eiNWhlFknpV6M3RFOuWIl85WTysrk8wF3Y02bBrcJyRlaLnKNDoNYoV7D9w+XGXs7aA41p/WDKGH5B/P6FHn6CfyvJrIYln9siBORpot1VwAHqUODzxCpnSZiGgdCqaA+MLd/NhL/6dDXwgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(83380400001)(86362001)(31696002)(36756003)(38100700002)(44832011)(2906002)(41300700001)(8936002)(110136005)(54906003)(5660300002)(7416002)(31686004)(316002)(8676002)(66946007)(66556008)(6486002)(66476007)(966005)(478600001)(4326008)(6512007)(6666004)(186003)(6506007)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGp0NExIR1RRR1JqQy9jaWgzNFlQbnhZWDluMG53SDFPdnBpdVpsSTc0bEVU?=
 =?utf-8?B?MU1aSFFjbGtZaGZBbTBmT2FRYmdqdDVPSWRmOWpXU2lPTWcwQ2g2TkdWRHZG?=
 =?utf-8?B?bEdzY2tSck5Rc0VXdmlUWVp0MXBZYUlHamZDaUdPblVLOUNoYmxkZ08wd1Y4?=
 =?utf-8?B?NENicjJzUEQ4OVNpQVIxNnBpZDRpQlJ4M0IrL1h5OTk2R2tOZk5XUHdOd25U?=
 =?utf-8?B?UGtGaEZIa083STJRM3g4czVEd0J4TG96Sk5taDdEeFYzd1VIVUtkK2xNc2tG?=
 =?utf-8?B?S3JXQlBGR1BlRWIrNVdKVERqa0Y2c0F6NWF5bzF3ektDUUVHZmZFUVRMNGlZ?=
 =?utf-8?B?ZGNCRUc0cUI5R0VWK3cyRkpaNnBETlVrUVpzRDVzcXVHMk5zYjVSR0FqbzEx?=
 =?utf-8?B?ZnhuaUMreGVtbmdTTG9KeEhzWlRZZDkrMXQzeWg2c3RIL2poUlJWN1FKdkJu?=
 =?utf-8?B?Tjhkcy9LSHBwRXhKMzN1bklTOGRUbm5heC90cXJOc3UxYTVrOFhRc0grYXh6?=
 =?utf-8?B?S3FFcmF4OFNYbmZ5bkxWVzZXbmg5RHczeGZ4VnMxVm5VS1hpbzRMd0RIazlh?=
 =?utf-8?B?bzZPVkhwNE92Tks1TW9UVGZXNXVjMDhTa0RReko1Ui9heXVGSmJhTm5hRkRw?=
 =?utf-8?B?Qm1HYUtMTC83Q0diRm9nUC80ZnpxK296Mm5raGgzYUN0RWdZYkYwMTY2bDlI?=
 =?utf-8?B?MjZJWk9qZi9xcnFKOG0rcHVVTDlvY2ozVm93Qy9IZVU0RkdOU2JXajhCSDJs?=
 =?utf-8?B?eFJ5QVQ2bXp2WU52TVNmOGNsZWZBMGZ2MU0yOHdDTXhSRVZ5ZWNUTTV5Nkhz?=
 =?utf-8?B?bWtCTjF5SmZQbWhmMU5JaCs2UFdpMTllcmJUS0k2OHd3QWtkekpWZm1yY3Q4?=
 =?utf-8?B?ckUyYUVYaEdRUTJqVVYzd052SU93NGN2NlpTQmF3S2dUQVpuOGJ2eWJvclgw?=
 =?utf-8?B?SjhFUEJaZmdJSjJhZTBOZGhRakdZd0ZIeHJveDRrODd4TVMxTmJxTE1ZZ2Vr?=
 =?utf-8?B?MnZYSGdxNlZQWXhIWm13WFZjUWxwcmEzTVozNmY1Nm5ZZm5yRHFZVkIyTVhZ?=
 =?utf-8?B?SU1Nb0xoNFhOd3ZNSHRFdTV2bUo1eDQ3dlBqTkhjQ2VnLzNVQWtteVVUQlNi?=
 =?utf-8?B?QTZYc3hGc29ZU2gzNkFmalVVRlNoaUw3UTVHSElJMDdlQlJWUWg2QUZSNTRh?=
 =?utf-8?B?SklvLytPckI0ZlN3RTVtcW1mdURGYVJjVW1UQ1REQlFOcXVoWW9Dd2I4QkNm?=
 =?utf-8?B?cno5dVpDeEl6TW9FUmM1b09xVXFGdEswVE9RazNuS0NKWUxoRk1EaHVyODdn?=
 =?utf-8?B?N1NHcCtuY1ZIRTdpNUdVNTVoNnR1dGQzdHNVcjYzbXRQc2NnMXNxOGFDWU5W?=
 =?utf-8?B?Z0ZhQVBwaEl4UmN6QkJUK0RDK0VjZlVzVURrbFd2RUhyT3hqRHJ2eFBEcWpu?=
 =?utf-8?B?b0ZzdU1wM1NRaGZmc2d0ZUdRSGRQSk5WSjNtUzZoY2dqT09LS1NXVUhVMldI?=
 =?utf-8?B?eDJRZk1WT2VFU2tLdDY1Mk40aDVxRWNLTFJibWZtYW1FRUIyNXNuS2FLenR1?=
 =?utf-8?B?aWk5eC9Nc2FhLzZxMFhaWUxYRFkzT3NKY2poL1lKS0N2S3ZwSVFwMGxlU1Vr?=
 =?utf-8?B?TXI5dXJjT0dvUmp1SExUb01qWTIrbW1YT3c1eHNxdTUxKzZTYnEveFEwTmdP?=
 =?utf-8?B?WTZaTGk5dWNteTNjVGgwZEl4ckFQT0F3WE9ZNm9oMUJaeTFLVlNmNmthQkJO?=
 =?utf-8?B?cSsrcDFZQkZHelNnam1hM3VhTUxpR0RYdXY4ZThlZFhjYm9ackhuQzh4VjBV?=
 =?utf-8?B?dHBDRkcyazdEMktmeS9xUDFNZmtVQkF6ZkJtZ2dudWE0MkZ1R3p0cFo3S3V6?=
 =?utf-8?B?Z0swMFpvUTByajNkdzlHQVNObHRMd3RJZk55ZHNzbDhYQ3ptaWF6Nk1RQkd1?=
 =?utf-8?B?cVBGdGdvVzBYRzM5Ym1hZHBNdE9lbjdqaCsrc1VGcmNyQW9QTUxxdlhkNFhX?=
 =?utf-8?B?aVlobFB1YWtTa2FWWklDMFVrNzZ1VldhaXJHRWFkZVFNRVpWYk50MkMxRWwx?=
 =?utf-8?B?VU9MZXEyamMwV1hSRzhhWkdoRTc3VFpVRWNCSm5Na3FDVmpiK3hxMUVCWnRE?=
 =?utf-8?B?clk1Q2huaS9QaUgxTG1xRVZPMnRtN25wSkxYbjZUaE13ajhucURhbHhEWFlz?=
 =?utf-8?Q?MYj/+eTM6kfiFN2Mnha6MKc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WlZWM1V5aGpQa3FSTy8yaDM3WkJwbEg3cHh5bVBvb1Awa201U3BkTElNU012?=
 =?utf-8?B?c1gxZWE0aUtXR1ZkZ0xJR0hXVC8yOURkRHBIODRYWWdqMGhQUmhPaDJoUVBX?=
 =?utf-8?B?OWdIdzJxSHFUM1A3VnpCSVNVYUxOTm5rK0ZSWmtGdFNORHd1cWQzL1p6MHVZ?=
 =?utf-8?B?ZFN2U2FjVFJ0ZWJQWVpmSjF6OXhsVkE4NHBYT0w3T3hKSDY0VUo2akovVzJJ?=
 =?utf-8?B?OUpSUHczM1RwNzB5blRWSUxVN0h5UXRSSzNCdEtpeXFQVnNVK2ZRZmdINmdn?=
 =?utf-8?B?MjJoVWgxeXZuckxhT1ZSTUtsTVVBQ1FiWEpNTkhVNFlDSDM1bEV2VS80cnRL?=
 =?utf-8?B?SGVad29BYXd4dlVFMmZtYzlqSTNjVGhkbkR2bGlUMmhiWStKZXV4MkxvYytZ?=
 =?utf-8?B?OVJ5Z0FtU0R6TWJ5cU5zTHlkalhyYlYxeVJudWZ4ZDZ4RXIwQXc3aEZXYkZW?=
 =?utf-8?B?a2VGK1Q1bFVBRnFYZDcrNUIvMDZKZ1A2dEpVSzBnRzdrdkZGQXpQOVd1eXRh?=
 =?utf-8?B?OHRoYWNLcS9MdzBvbVZFMklDSVd4TGFDUGYwa3lhbjBLQSttZTlDZUxKc2NK?=
 =?utf-8?B?dVhmNWk0Q0p5RjBXUnJvS2NBYjhUb0lDcG9TazZYalNiR1JLOWNSU2hkdER3?=
 =?utf-8?B?bVJ4R0docU5sL0ZZcDhkVjN0bm5qL1VaSEk4NDVVV3d5VXQxOS9FZUwzNHZI?=
 =?utf-8?B?ejZkdEIrKzhvWTB0MlVnT1FNOWZjYTRVQ1M1dElVN01CdFpIVXJrVEZyL08z?=
 =?utf-8?B?LzVoY3BvT3EyQ0VSbHpEVnZ3TjVyQWt3S2NqbERDNHhnZ2syVEl1TEhESE02?=
 =?utf-8?B?SWRLSi9FalJGTXhQN0NOckVSNXFtV1hrRnFyUnJmVGc3TVNFU1J2QUNibTRC?=
 =?utf-8?B?SklOejlEQnhKbVNWWnZiZkVva3RjeGxCbThPdi9wU3pSS1RXZ1NuOEl6NVlT?=
 =?utf-8?B?bjNjd3EvQ3NsejRrck5TQlBqdGNYWXZQT1liSGJDUXJ0aFlBN3ZrNlBJMERk?=
 =?utf-8?B?MGJkKzROR0I1a1lraDJoM3F6RE50MU5FQmhYd2s1VFdqS294cGdRTVh2WVVq?=
 =?utf-8?B?SFdzaWNNUXM2OStjR0ZPcS9JUmk4bTNDMDVRMFB6cjUwNGYxeEMrL3dFQ1Mw?=
 =?utf-8?B?OHdwS21nUnNaVUdvZWpTR0ppYlA2OXZobzA4QlllMnhiay82MTJ0amRIdi9o?=
 =?utf-8?B?UmRXVG1hNG9DRElVU0hWYVNMTHpyeWROcGk5SzhSenZKU3pOTnMwUlVKR0pG?=
 =?utf-8?B?cVlXSnFYU2pkUE1mS1lqVEFmV1BmT2RCOThlZUZtbzdybi8yalBlNGhkR1dD?=
 =?utf-8?Q?30Gd6t1qYW2GUW51mFqqz/rZ8kFURM9hBn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3957bc-4ef6-4ddd-1e6f-08db04785ae6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 17:18:37.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shE7AYkQ82ok12Txf7TLBSk2Vq2gcYwaxD6EeLtYS8AY5Xhry7rf601jhtb7JmRRUFverfMmeJl5uUD/ScpyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010148
X-Proofpoint-GUID: iKQXjbOsbn5PGALZy7TzVXdohmn7tNst
X-Proofpoint-ORIG-GUID: iKQXjbOsbn5PGALZy7TzVXdohmn7tNst
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023 17:01, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 01, 2023 at 08:49:07AM -0800, Alexei Starovoitov escreveu:
>> On Wed, Feb 1, 2023 at 7:19 AM David Vernet <void@manifault.com> wrote:
>>>
>>> On Wed, Feb 01, 2023 at 12:02:07PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> Em Wed, Feb 01, 2023 at 01:59:30PM +0000, Alan Maguire escreveu:
>>>>> On 01/02/2023 03:02, David Vernet wrote:
>>>>>> On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
>>>>>>> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
>>>>>>>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
>>>>>>>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
>>>>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>>>>>>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>>>>>>>> +++ b/dwarves.h
>>>>>>>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>>>>>>>>>>>>>   uint8_t          has_addr_info:1;
>>>>>>>>>>>>>>>>>   uint8_t          uses_global_strings:1;
>>>>>>>>>>>>>>>>>   uint8_t          little_endian:1;
>>>>>>>>>>>>>>>>> + uint8_t          nr_register_params;
>>>>>>>>>>>>>>>>>   uint16_t         language;
>>>>>>>>>>>>>>>>>   unsigned long    nr_inline_expansions;
>>>>>>>>>>>>>>>>>   size_t           size_inline_expansions;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>>>>>>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
>>>>>>>>>>>>>>> defined if using a very old elf.h; below works around this
>>>>>>>>>>>>>>> (dwarves otherwise builds fine on this system).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Ok, will add it and will test with containers for older distros too.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
>>>>>>>>>>>>> repo at:
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>>>>>>>>>>>>>
>>>>>>>>>>>>> It failed yesterday and today due to problems with the installation of
>>>>>>>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
>>>>>>>>>>>>> notifications floating by.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
>>>>>>>>>>>>> iterator that Jiri noticed.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
>>>>>>>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
>>>>>>>>>>>> from the BTF representation, and as a result:
>>>>>>>>>>>>
>>>>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>>>>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>>>>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>>>>>>>>>>>>
>>>>>>>>>>>> Not sure why I didn't notice this previously.
>>>>>>>>>>>>
>>>>>>>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
>>>>>>>>>>>>
>>>>>>>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>>>>>>> {
>>>>>>>>>>>>         return -EOPNOTSUPP;
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> looks like this:
>>>>>>>>>>>>
>>>>>>>>>>>>    <8af83a2>   DW_AT_external    : 1
>>>>>>>>>>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
>>>>>>>>>>>>     <8af83a6>   DW_AT_decl_file   : 5
>>>>>>>>>>>>     <8af83a7>   DW_AT_decl_line   : 737
>>>>>>>>>>>>     <8af83a9>   DW_AT_decl_column : 5
>>>>>>>>>>>>     <8af83aa>   DW_AT_prototyped  : 1
>>>>>>>>>>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
>>>>>>>>>>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
>>>>>>>>>>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>>>>>>>>>>>>     <8af83b3>   DW_AT_name        : ctx
>>>>>>>>>>>>     <8af83b7>   DW_AT_decl_file   : 5
>>>>>>>>>>>>     <8af83b8>   DW_AT_decl_line   : 737
>>>>>>>>>>>>     <8af83ba>   DW_AT_decl_column : 51
>>>>>>>>>>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
>>>>>>>>>>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>>>>>>>>>>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
>>>>>>>>>>>>     <8af83c4>   DW_AT_decl_file   : 5
>>>>>>>>>>>>     <8af83c5>   DW_AT_decl_line   : 737
>>>>>>>>>>>>     <8af83c7>   DW_AT_decl_column : 61
>>>>>>>>>>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
>>>>>>>>>>>>
>>>>>>>>>>>> ...and because there are no further abstract origin references
>>>>>>>>>>>> with location information either, we classify it as lacking
>>>>>>>>>>>> locations for (some of) the parameters, and as a result
>>>>>>>>>>>> we skip BTF encoding. We can work around that by doing this:
>>>>>>>>>>>>
>>>>>>>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>>>>>>
>>>>>>>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
>>>>>>>>>>>
>>>>>>>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
>>>>>>>>>>> applied to arguments.
>>>>>>>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
>>>>>>>>>>> the way we do in selftests.
>>>>>>>>>>
>>>>>>>>>> There is also
>>>>>>>>>> # define __visible __attribute__((__externally_visible__))
>>>>>>>>>> that probably fits the best here.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> testing thus for seems to show that for x86_64, David's series
>>>>>>>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
>>>>>>>>> to cover recently-arrived kfuncs like cpumask) is sufficient
>>>>>>>>> to avoid resolve_btfids warnings.
>>>>>>>>
>>>>>>>> Nice. Alexei -- lmk how you want to proceed. I think using the
>>>>>>>> __bpf_kfunc macro in the short term (with __used and noinline) is
>>>>>>>> probably the least controversial way to unblock this, but am open to
>>>>>>>> other suggestions.
>>>>>>>
>>>>>>> Sounds good to me, but sounds like __used and noinline are not
>>>>>>> enough to address the issues on aarch64?
>>>>>>
>>>>>> Indeed, we'll have to make sure that's also addressed. Alan -- did you
>>>>>> try Alexei's suggestion to use __weak? Does that fix the issue for
>>>>>> aarch64? I'm still confused as to why it's only complaining for a small
>>>>>> subset of kfuncs, which include those that have external linkage.
>>>>>>
>>>>>
>>>>> I finally got to the bottom of the aarch64 issues; there was a 1-line bug
>>>>> in the changes I made to the DWARF handling code which leads to BTF generation;
>>>>> it was excluding a bunch of functions incorrectly, marking them as optimized out.
>>>>> The fix is:
>>>>>
>>>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>>>> index dba2d37..8364e17 100644
>>>>> --- a/dwarf_loader.c
>>>>> +++ b/dwarf_loader.c
>>>>> @@ -1074,7 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>>>>                         Dwarf_Op *expr = loc.expr;
>>>>>
>>>>>                         switch (expr->atom) {
>>>>> -                       case DW_OP_reg1 ... DW_OP_reg31:
>>>>> +                       case DW_OP_reg0 ... DW_OP_reg31:
>>>>>                         case DW_OP_breg0 ... DW_OP_breg31:
>>>>>                                 break;
>>>>>                         default:
>>>>>
>>>>> ..and because reg0 is the first parameter for aarch64, we were
>>>>> incorrectly landing in the "default:" of the switch statement
>>>>> and marking a bunch of functions as optimized out
>>>>> because we thought the first argument was. Sorry about this,
>>>>> and thanks for all the suggestions!
>>>
>>> Great, so inline and __used with __bpf_kfunc sounds like the way forward
>>> in the short term. Arnaldo / Alexei -- how do you want to resolve the
>>> dependency here? Going through bpf-next is probably a good idea so that
>>> we get proper CI coverage, and any kfuncs added to bpf-next after this
>>> can use the macro. Does that work for you?
>>
>> It feels fixed pahole should be done under some flag
>> otherwise when people update the pahole the existing and older
>> kernels might stop building with warns:
>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>> ...
>>

Good point, something like

--skip_inconsistent_proto	Skip functions that have multiple inconsistent
				function prototypes sharing the same name, or
				have optimized-out parameters.

? Implementation needs a bit of thought though because we're
not really doing the same thing that we were before. Previously we
were adding the first instance of a function in the CU we came across.
Probably safest to resurrect that behaviour for the legacy
non-skip-inconsistent-proto case I think. The final patch handling
inconsistent function prototypes will need to be reworked a bit to 
support this, since we tossed this approach and used saving/merging 
multiple instances in the tree instead.  Once I've built bpf trees I'll
have a go at getting this working.

>> Arnaldo, could you check what warns do you see with this fixed pahole
>> in bpf tree ?
> 
> Sure.
> 

I can collect this for x86_64/aarch64 too; might take a few hours
before I have the results.

>> If there are only few warns then we can manually add __used noinline
>> to these places, push to bpf tree and push to stable.
>>
>> Then in bpf-next we can clean up everything with __bpf_kfunc.
> 
