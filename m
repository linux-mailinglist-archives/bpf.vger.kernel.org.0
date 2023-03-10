Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42226B502B
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCJSfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 13:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCJSe6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 13:34:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380A10BA70
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 10:34:44 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF4UZR024231;
        Fri, 10 Mar 2023 18:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lpTYqtOG3v+fwuOMBpw2mtfaYVDi0S30fcZtz4kTazc=;
 b=g9/s4qUdIN4+pw2dQCEdP/PQyd7FV7X/hLWF1agLyanbcjvgTyH0RhVtBwpHlfC2jTUa
 0jo72NLnNxBgrO9KOkSz3nKNqzNeL0Szd4NAlmpHnhRthGkutAFeAxd+TrgU01X6qHA6
 0iz4JGRoidroE6Qdj6WP/a5WKWI1xusyLeP2PK6RWUNpQThYCQRYJHsmupbMkhH8kaIv
 4RD626gIuMB4Zk4LYDSKL9yvigPZMFw4pdk3zZ47RL8F5LivbefhkDyyJnZS6wKCyBzz
 tlxn+MCZINbFTc4yQpD35EW9n/n+LC2XOdhVpyQmv/nnI3l11kbypV2jq7H24kAVmgBz jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y608h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:34:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHUlhv025166;
        Fri, 10 Mar 2023 18:34:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6frc39s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAOBYs6IOrhJNKMGaF0dxj4ptaPfMaqxb7b3tJ+gZuXm/FkLy7N0aby1vmsS6RKsaugiz7t+XyUNMep/XTi2BhthoH01QWhSvmbHPJXX2wTOVSf9m7XI4fVS2+jJLaF22XDhaqMoFxT8UA6BedksICtulX1euI+13qvpAM2fq0x6zy0LegA5x0EXSVazogruU/Q7+2OLJ29xHIbQmeNF163Cujk2zbAuEPAtfGeuPA4ydzlBvLvnfab8peJSfRWvLlGQgyRIS7s+F/EeE4W8I93nN74EpRIQcNQq/+aGH53hiydIoPwKBH3q8vkAQrgNywdBtBfSWLblorc54A9M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpTYqtOG3v+fwuOMBpw2mtfaYVDi0S30fcZtz4kTazc=;
 b=MNjiJ9BNDpi7bxBuydXAUOzG56lpZxsvEaOqExCcb5mtr3FDYDURscQWmOTeNv0e6s21m37Z0kidjfph1/F6uwwEJCKKLfZu++kOZMBQkSHhDr2MEZ+fIbDgSoPZixlVNiFkDK/MesAP19AjPkfpbzqQDVlOYdjmR3UBdvDzCQMXOyvp01uYON8Gg6fKHG7QTm0uWS3nTNvTKo8iyvEeCNQRnKBHdA8eQN8YueD7ed4r0EuoR2oJ5w27UG7G7uw4u5Eqx58RxTTPNmUzbSDTCl56KFIhTbNTo0tq3/we+XetfhEeje7p80W1HJUfxO/Vzq2UM1jKC2XpytvPvSai0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpTYqtOG3v+fwuOMBpw2mtfaYVDi0S30fcZtz4kTazc=;
 b=L492cuQrKeijTTc6ttbx7Td4OLG3FIZCvv7UnIWDMpFJR7zZVTJAf7KelTNRiv7gxkV3JL4IA3F2jTuaIKGaclFLDJ0kgsq/Vn+0jG2jXctDt3x+ztMGpeE1uWq7pWV3NHTsaEwf9Gr4wcGp4Rb4TECI1+KuN3nk9J00MMc3Dhc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB4973.namprd10.prod.outlook.com (2603:10b6:5:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:34:18 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2%6]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 18:34:18 +0000
Subject: Re: [RFC dwarves] syscall functions in BTF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org
References: <ZAsBYpsBV0wvkhh0@krava>
 <faf34d4b-d7a3-2573-383b-2bd8db422734@oracle.com>
 <ZAtGsuSO6Jx2ZLBy@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <e1a5bf01-4afc-1b8c-466a-b6ed073ddfa3@oracle.com>
Date:   Fri, 10 Mar 2023 18:34:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <ZAtGsuSO6Jx2ZLBy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: e34d5f7f-0003-41f5-3962-08db21960ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfOiFaNoQYrluKfMeYg06HqngsmlBPVmtyVfdZAEq4xnrn25xgCgQBg1bJ5eA4DJygguC8+jprlB0mPEj73a+hu1L/vw2nxQ/PjRh8GB9xKSLLov6q8MyW14mFdgdzXD/+M1DRkNpvyIVc8cRj6ASxskjfLnrJ8tDVNL6xGsJLB9atjkO+3jDy8cTH3eh5XE1cWfx3JXFyvKPGwQPxh93ELcNzMHNz+LANlXyU/4IiLFQUUNv6o9Ubmudkvi8Qj+C6S6TcbFMG7rOPoo4VU3KvL76vB+YSJ2ZyHYlIn6vE30O22yguBMOSGqeNzCEf1HDFPi84I74Apxmm3isK/JopjenRCsbqEQ2AOJAQSWLBbAGM+cYazUcifL65LLTqHMB86sc2DUeg1bzkOQDCIi0GkCukG6BzWBgTEhlBscLskilhh5YpC7cTGInQBHKiuP6uTF3DMjtDTSsye9y4dLZ4AIfD5EoAxJxLhIRE/yku2V1vXa1uqC8Tse23h+oM7z2SG0DC0jAhcd3Hw1JO3iVYV5iZVHnhLgu2Z4yQ3/FzPC3SZ3CXkHXMEW0VFCphSePfALp9feyyIEjI252wTW98Jei1BgJ7vwe6L9/eSezpOcayTAi0rA9ZG2h2wUwMFxrgmdq7m901EQPxZI8EoCrIMd/PBOsSOvY7KJatmsWh55K61NrEG9lt2xwfSw/Roj5D0P07sud3GBl7h2tsAtZXtpthe/Hoz/O1UTv+oO/PM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(6486002)(36756003)(186003)(31696002)(478600001)(31686004)(38100700002)(316002)(86362001)(6512007)(6506007)(83380400001)(41300700001)(6666004)(7416002)(2616005)(53546011)(44832011)(66946007)(4326008)(66556008)(5660300002)(8936002)(66476007)(6916009)(2906002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFRMlF2NzJlRHR2OXJqVEtBMGpyNktMOFAzVldpTURWK1NCVmVMRDJhMGhh?=
 =?utf-8?B?NlgzVEsvc05uYTd0cDlpcEJCbzlsdllFZFVQZWR6STBmTVNTSGgzNjhzclhq?=
 =?utf-8?B?b1ZlaTYwTkttNStmeWJUMUdqalUzTXE1bjlQRjlWK3hoRlY3VS9Ec0tGejhN?=
 =?utf-8?B?OVdLd3FWS3ZMaERGTFpCTTgwT1BwTUlaK1pwTHJhb3grSi9HQkRuQVdnQ2Rn?=
 =?utf-8?B?d3lsczhPeEZpUDVSc3drcFRLMUlqZ2RmT0puK1F4K1V5aC92eVc1QTNJMWpZ?=
 =?utf-8?B?Y1BrOEVOTENYVzdNSWJTV2ZIZkpWMlRJeDh1dnJQalFNdEIxWTFVMjRqNGlN?=
 =?utf-8?B?WHlvUGJsa0pWcnd1b1dQcUdBUG1ZWGxZQTFIbS93T2UwdzZYQ2tBd0VTWVJK?=
 =?utf-8?B?eThTODcwU3ZUQzRqM3ppZnlQcC9JLzMxNkgxZ1FEM2Q3d0xPYU1WbWRuQ2ds?=
 =?utf-8?B?TWpkSnBBNE5ZRS9pMFFkU0VUL0VrZFl2UHovYjgyTytqUTFGcm5VMW5RTlVv?=
 =?utf-8?B?V1ZCU21RY055bjdXejZMS05jZGxIcFlHS293dnBvNlQ1Tk9MaTlhNTFuVTFS?=
 =?utf-8?B?cm9JdzlRMlZHQml1Mi9uNzJMUGc3VXJ4UGcxWE82bzJTSjlQVVlPWEJvQnFJ?=
 =?utf-8?B?YnlZaFlndFBBa0lWcHJoR0ZrYVIxRXVMdHhqTHpnRUlCbE02bG94NTJFTWly?=
 =?utf-8?B?L2lERVZoWUJtczlMNTZsaXdUc3VQdERoY2FLczBYUTNZY1lkVWU3SnFvVDhY?=
 =?utf-8?B?UG5ueFZyWERQdEdMZjdUbHRId0JreXR3emI4YmFBbkJWcXhuUWVpRFd4NmJ0?=
 =?utf-8?B?dlIzdGcxOUNrbGp0R243dTg5cTVFTy9iRmhReEROZktDcTkzMzVqVkdLUE9E?=
 =?utf-8?B?RkZBdXh3cVZ0SGd2VjhyQWJaTy8vcU0ydlpybHJ2TUFGREdrNklRM3BVb3JG?=
 =?utf-8?B?Q0FnVmJhT0VRSFlTeHFKN1c3MGdqYmoycy9lS3Z4ZmdNR2xiZ3NJVGZ2cFFY?=
 =?utf-8?B?bmJMNW81TTAvNFY0akp5ZkZZQTdnbWVwN1BRUFV4bWNPTm9weVg0REpRWjBm?=
 =?utf-8?B?eW8zb1h6THpWd1dBNTU0Ym5RNVRid0U3angySmxDeVNxd05XZW5ueG9VbGc0?=
 =?utf-8?B?NU9KTWN1SmtQRTJSc0w1ME03d0hBVUFYakZuS1ZINHkzYWhQdE9IMVRDbDNE?=
 =?utf-8?B?MlRveTZ1U2laM1V1eDZxQlVHRUI2SEMyU0UzTlRmSmhnamFORDQ4NktxSlNu?=
 =?utf-8?B?VWpqdkU1WXg2NnI4aXlDZFY2RjNPRDlpM3pkUHlyR3BtUDdqYVV1TG9TNnRn?=
 =?utf-8?B?cStQUlQ4UHBlbXlFOGowQUg0aHQ5aHRFY2tSQUY5T3FaSCs0aStvN2tWRTd5?=
 =?utf-8?B?YXBDV0wzQTNFbW5TbFYzNnlxL0MvUUl3VGJTMUJJQVc1VXB3RjI5Q1p5ekpZ?=
 =?utf-8?B?T3UyRlZJc2V3a2YzNjBEOEprYW1GdmNPOERiMDlPaGY1djZyTmlhUEFNRVBQ?=
 =?utf-8?B?dGNlSFVISmhOV3BHWVNIWm15WERUTUpJMXViMUtmeFZtazVhRkdLd2dOZEpj?=
 =?utf-8?B?VlhteDNNckR6OVg4d1BEZC9RYm1Wc1dXbEJwcjFtcEpyc1ptRHQ5Vmh5ODRj?=
 =?utf-8?B?SFFKSll1ZWtITm9Fdk5RcHFBTXR5OGtvbUlnekJoeVNJSS9SZ09GWkN0Q1F0?=
 =?utf-8?B?WWRhM1A0NG1aMkcwaWNVT04xVUd3QlN4aWlzWlRna0MrTUlJQVh6SE5uallh?=
 =?utf-8?B?MjIrNzRqL2V3M2I4RDE2c0lkNmZBKzhlWndGSW1EQWg5UzA4WWJtUXpyT3pQ?=
 =?utf-8?B?RTdxenRDK2dxMW00VCtEQ25BY28zcmowcHN6em1PVlFtL1dIRStKUm9IaWI4?=
 =?utf-8?B?ZS9MN1h5OTYvN3JKbGJCYWhTazZOeGtoU3gvQnJEa2JxS1F2L0d3WE1hdUJi?=
 =?utf-8?B?M0Z1ZENzcUpHbFRndnVjMmtVQyt4SzZQL0xJbno3RmpGQVlIZ3J3dDVsN2Qv?=
 =?utf-8?B?SW9qK05sa0d1aHppQnZ2QkNIUUs0N203T0F3K3pxMkdEK0E2R05XM0lUNHU3?=
 =?utf-8?B?VGJrVjNlOTBhSFM1OHpWYng5NEN6RFFIZ0xrWGJTT3VVZW9oT0p5WG1oRjJT?=
 =?utf-8?B?d1cwQkV1UmNSL3c2UTVEWGw4bnh3YjhMWFpUbm84MjE5VTd5YnByaWMrdzVI?=
 =?utf-8?Q?17fKDmphbEmnzw1ACi600zc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?andVd2pOeWcxZHUrR2FYWWdaUnJMNWVjR3Z2eTBJT3JCWm9MNUhmZEloSlFP?=
 =?utf-8?B?RVU4UkJVMnF1emNYVUF0bUZNVnY4bmhFOVJuSEhJbDZYRFAzYTlXL1hUcnFC?=
 =?utf-8?B?bmhTZTg2d2JtWTBLWmdqQ09uZUlnZ0JmUWhsdGVuRFgvbGljNml6QVR4T21r?=
 =?utf-8?B?VnhZL0NYb0E5YkdhdlJDZXc5Wjh4MnVobTEyMHJnWXVBSXFwQWtuc2dDN3hl?=
 =?utf-8?B?aDd2Q2Z6NFR0UWlzOGIzc1graThrVm1wUXhXUDlzWlp5VmpCbzNnT2p0Sk1m?=
 =?utf-8?B?TU1QWWcxWWFsMUQxa1M1TG16UUp1eS8wUlhmdjBpTmI0cjNrbThmWC8vaUNj?=
 =?utf-8?B?Z3dBOTY5UDh0MmlvSDF2aEtEMmpMK1lhU3ZzNURiL3ZIbkZmdHB2RHhyYWV6?=
 =?utf-8?B?QThpdWdKaUZ6UXJYUFJiVjZSTldoTlJyVjRPdm1xbmFld3FYUkRtRU5TWEgr?=
 =?utf-8?B?eExvSUFPSkR4MnVCdXEya3NCN1drSFFPY1dBTUZ4aEJOWFNna1dEMTRQZnkz?=
 =?utf-8?B?aGNIU1pPbkM4b2Z5S05TY0lYcmVNOE9DNEU3b2FmVksvVEUvcy9odTBHdmlO?=
 =?utf-8?B?VW9GaG1aemRsVmdMNGdVMnVmRUFyMjVQQ2JqYWZBL01nME9vZVg4bFhSNitQ?=
 =?utf-8?B?bWw4TTcvVFE0SGpmMlYzeHloVlo1N05IczBhWmphaXB0akpHTE9hMUpVSE9O?=
 =?utf-8?B?NEZaV0JoMmtCWUtwVm10ZGIxa3VLSDM1dWtvUlN6MEJXbjlSak50bTdpNWs0?=
 =?utf-8?B?RnFqcmxGbW81Q3UrK2tMcmpkNkJmNEZkZ2JWcWwvcUltV0lWbDdDbGVqSi9r?=
 =?utf-8?B?dURzeXhXOFVucndpaDlUWnJUU0E0Ry9kb1lPNWNQNk1zZC9DMjd3em4zUlVp?=
 =?utf-8?B?VG05UXd4aE1PV2pxem9QWkR5SDNMM1BXdy9MWm80QWIyZ0t2TWFEUG45aTk0?=
 =?utf-8?B?eWl0SnQzRk9rV2ppaXlyQmp2YUVYbmgvOVl1YnEwT0t0VnNOcTUvdzNOdUdU?=
 =?utf-8?B?ajZPdGt4K0RrZkV0TkMzTGc1QVNjSFM4N1FZVnFMQjRCN2Ric2J6TmwwZ1k2?=
 =?utf-8?B?aC9Ed3VyUVAweEpGaG4wN1QxbnZmOWhMbU0yRWQxN1IxMldOSHpwa2E0dDlD?=
 =?utf-8?B?czFRSjI3aWlMajhRb204cFlKaVd3UU1JMk1BOEkyTEg5dlJOUG5NaHhOOWts?=
 =?utf-8?B?MTNjMllHbGxLM1ZSQWx6MzZLL2dWRnVZdHRYU1h4MmxtTTNTb0c1WHA1N1Y2?=
 =?utf-8?Q?5cO8nehusK2fzqJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d5f7f-0003-41f5-3962-08db21960ef1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:34:18.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ+RW+A4lPscnljYGc9vutIWKqukDBdhtxKs1h3otNotqPlf49dDO1Kdur34l/O1YswKjS2JE2j200OJhRRSwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100148
X-Proofpoint-GUID: Fq7upv0utVShoTBuJvqQ-6aZFpYJ-ysD
X-Proofpoint-ORIG-GUID: Fq7upv0utVShoTBuJvqQ-6aZFpYJ-ysD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/03/2023 15:03, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 10, 2023 at 12:43:31PM +0000, Alan Maguire escreveu:
>> On 10/03/2023 10:07, Jiri Olsa wrote:
>>> hi,
>>> with latest pahole fixes we get rid of some syscall functions (with
>>> __x64_sys_ prefix) and it seems to fall down to 2 cases:
>>>
>>> - weak syscall functions generated in kernel/sys_ni.c prevent these syscalls
>>>   to be generated in BTF. The reason is the __COND_SYSCALL macro uses
>>>   '__unused' for regs argument:
>>>
>>>         #define __COND_SYSCALL(abi, name)                                      \
>>>                __weak long __##abi##_##name(const struct pt_regs *__unused);   \
>>>                __weak long __##abi##_##name(const struct pt_regs *__unused)    \
>>>                {                                                               \
>>>                        return sys_ni_syscall();                                \
>>>                }
>>>
>>>   and having weak function with different argument name will rule out the
>>>   syscall from BTF functions
>>>
>>>   the patch below workarounds this by using the same argument name,
>>>   but I guess the real fix would be to check the whole type not just
>>>   the argument name.. or ignore weak function if there's non weak one
>>>
>>>   I guess there will be more cases like this in kernel
>>>
>>>
>  
>> Thanks for the report Jiri! I'm working on reusing the dwarves_fprintf.c
>> code to use string comparisons of function prototypes (minus parameter names!)
>> instead as a more robust comparison.  Hope to have something working soon..
> 
> Humm, that could be an option, a simple strcmp after snprintf'ing the
> function prototype, but there is also the type__compare_members_types()
> approach, used to order types in pahole, the same could be done for
> function prototypes?
> 
> I.e. to compare a function prototype for functions with the same name we
> would check its return value type, the number of arguments and then each
> of the arguments, continuing to consider the names as an heuristic that
> functions with all being so far equal having different argument names
> may indicate different functions, but if there is no name in both
> functions, look at its type instead, where we then would use
> type__compare_members_types() for structs/unions?
> 

We could do that too alright; the thing I like about stringifying the
prototype is we get a clear description when we hit a mismatch
(in verbose mode):

function mismatch for 'alloc_buffer'('alloc_buffer'): 'struct debug_buffer * ()(struct usb_bus *, ssize_t (*)(struct debug_buffer *))' != 'struct debug_buffer * ()(struct ohci_hcd *, ssize_t (*)(struct debug_buffer *))'

...and we can re-use the existing support for function display, which works great!
Luckily we don't have to do this very often; I counted 2113 prototype comparisons,
of which only 49 mismatches were detected. Thanks!

Alan

> - Arnaldo
>   
>>> - we also do not get any syscall with no arguments, because they are
>>>   generated as aliases to __do_<syscall> function:
>>>
>>>         $ nm ./vmlinux | grep _sys_fork
>>>         ffffffff81174890 t __do_sys_fork
>>>         ffffffff81174890 T __ia32_sys_fork
>>>         ffffffff81174880 T __pfx___x64_sys_fork
>>>         ffffffff81174890 T __x64_sys_fork
>>>
>>>   with:
>>>         #define __SYS_STUB0(abi, name)                                          \
>>>                 long __##abi##_##name(const struct pt_regs *regs);              \
>>>                 ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
>>>                 long __##abi##_##name(const struct pt_regs *regs)               \
>>>                         __alias(__do_##name);
>>>
>>>   the problem seems to be that there's no DWARF data for aliased symbol,
>>>   so pahole won't see any __x64_sys_fork record
>>>   I'm not sure how to fix this one
>>>
>>
>> Is this one a new issue, or did you just spot it when looking at the other case?
>>
>> Thanks!
>>
>> Alan
>>
>>>   technically we can always connect to __do_sys_fork, but we'd need to
>>>   have special cases for such syscalls.. would be great to have all with
>>>   '__x64_sys_' prefix
>>>
>>>
>>> thoughts?
>>>
>>> thanks,
>>> jirka
>>>
>>>
>>> ---
>>> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
>>> index fd2669b1cb2d..e02dab630577 100644
>>> --- a/arch/x86/include/asm/syscall_wrapper.h
>>> +++ b/arch/x86/include/asm/syscall_wrapper.h
>>> @@ -80,8 +80,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>>>  	}
>>>  
>>>  #define __COND_SYSCALL(abi, name)					\
>>> -	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
>>> -	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
>>> +	__weak long __##abi##_##name(const struct pt_regs *regs);	\
>>> +	__weak long __##abi##_##name(const struct pt_regs *regs)	\
>>>  	{								\
>>>  		return sys_ni_syscall();				\
>>>  	}
>>>
> 
