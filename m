Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0592F6869B5
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjBAPOl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 10:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBAPOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 10:14:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9075420D08
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 07:13:54 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311FDUR1011978;
        Wed, 1 Feb 2023 15:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mJbhUpLkGgrxIuL1CR7LJ4CDF2ASWvF0GEPMdWXSrLQ=;
 b=aTpnnTHCv9O7Lu2fEJXsGIO7j79S4u05bRQUoEUT3QbTpDaFnuVE94uQ9e1pkvRG/Vm1
 /mM1wPWizQyzZIAUc8ZmUO5Lwcyv8veePr5xKAuHRTeYzvBujzTZdZjYobPXTEhujRFJ
 cwHDsqoP23GQNuqRn2D3yHl8uHm4w3iNHWZDVkEJhgFe2cFyXa44hP4B0uojsZ2HcSBX
 HplZu2F9Z2bGC+9AahYbSNFXEsN+WCiEHUPbDlNC6eEE+6i+uUF32LJ8oRQtT07TgEJN
 KVhbrHd2Pa0ewx1/C/jp/MyiepJw7RZJ+0jmEeohpDjSVhDoD+8ABCFHwJd1+3YOTyjS 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk648xuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 15:13:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311Drxgs013062;
        Wed, 1 Feb 2023 15:13:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5e7erx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 15:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMnzpkaBBfehqv9YpDsKDtsOhUzUPzmhDDtYF0a6To8w3WQWrQc8I0pzEIeyZMLsse31ylFsKL0+eOBKbsA9mkUFbBw8/TPPo6BbgKvqJFabh/eBu+LgNsqDNwZMjiAe9gsSX/P+rsx8IV7tN90eG/l+f+X5WMVYPln2jbUyKKIc1mHDIfulhen8Mqow7rGwSid4QOUUaVUN5TpJW47rtNiJGfNON3bwh05yoG4x+ETsZrngDDNy3nuTvL5tzgAMZvknEugRp9XXzsbKZW97FWR9IiLElJ29Vbq6xU+FJX865lo23YCRD4CFCDFBMel18/sC1SnecEm/1TY/yGUUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJbhUpLkGgrxIuL1CR7LJ4CDF2ASWvF0GEPMdWXSrLQ=;
 b=N/B7t4k9aSgY/ZRDC3v004Zo1L1S9c21Yy4xSJJ5SHd4zoE9r7NJHpVBAHwIT311S0oD3bPxwV+hWsNp9NRsxHSNBF0SDMtZrBgFhEw/cr73Sb431y1UAK7Yoq6UB5AH6n63N4+9LOYVyYKFM7HCa2k9E9DfR0X3Aq2xfQfI5FuVLv+gYDRv2M725vm6zVDEcTSY9+Ezb/sXMFj4VTYehADKUfpWNWmIMMYb+v6I3dUgMTPlcrkQ3OJMRtcm1yBmN5JgjdVr9NNZPkdTrtXF7HktbvJdPOGe7WR/MoW8PzUwpw/XFhK9ghj0TD5BRM8bhQ4AQD+qXPh+Ot8ILxefzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJbhUpLkGgrxIuL1CR7LJ4CDF2ASWvF0GEPMdWXSrLQ=;
 b=ATjiiPGpRrVeR5feqFCutSXQRs7KytWSqLwbRe/Gq9SHu55Lj5WcoK9OWbuXlcKzlR60WFak2qqw6xki1LM2s7jtPQvEXB1Sy03SPZc+XZmeH9iVVmg3uUBGPsmZGqhuyXCR8VKjgruI9nU0f1ztFNG3n2kaFlkvPqILeiANbpk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6416.namprd10.prod.outlook.com (2603:10b6:806:25b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Wed, 1 Feb
 2023 15:13:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 15:13:23 +0000
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
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
References: <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
 <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <13b74154-1ea7-b8f8-abbd-4e94e8499af1@oracle.com>
Date:   Wed, 1 Feb 2023 15:13:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9p+70RzH7QiO2Mw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0130.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::47) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ca7910-c3d1-4e67-1cb1-08db0466dc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2N8PLigoYUxxdq3tJS34Dcx4qNuvPWLuYBx5VwtPNw6ERPOISxRcyvTU8jWFpbCGIpNGk8TUbB0o2RRPfDYiZ0zC2XpxFrK649xEBLWp8t06UgcEusMZKjnNL8iHb5Y+ozeyZ1SBWktHJGKXajFfrytLafnwkEMvR9pnCYi2yyBrCpmVFH6/8wERo/XfsuLX8ypoJou+l8hyO0RsXhQuIYyem/hUuPmNPLglb73LUmbmVvkPKMOvGdH7he7zI1TS6WMPuX8O9bMza+ELOTfpiOZlloFj2dnbyvq+4lTn8DyjC2I7pc5He96pcQet+QzVCwDbsifLND+qs8yiGLpVSvRoAobXl5jnmgr9dgJT9nkBX+HHSPjTGqfLG32g3h9rjNGDYPVdXIk4Vrh2VUekz4HIdPqk+KEjq89/qu8uajbBCc4Ljgtxqv1GHaL1YPRWIg+bF/orTtxuHyAF208pbHZecgUXOSVlJEYVSqXdQLyfh8uPrl8TiB8PPiXZ+cFcFMugyrfx2phBrM/nejJnXdni5g58kAPutjv8dX/aQEdFhNziD0Q7ypfZ7gL25cLllm8x53PUDpfqMoQVrPuism3EgU+1cOzpTb23vYTNIQLAUltLURRUQyGCfrsoo/X+k5fFzRclCHazmkj4eco9Ljf1xj560MzxoTWHgr1nJRenBIp7gh5aWvgcc4xzrzE+F8C5ZHcOH6u7ArsP/aEvE63EZy7RyNgWvpXjKa3znvnC4GcFRE7z4/tYYJ81oMGuB9e2s+FkS3YTJSt08aXWwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199018)(8676002)(66946007)(66476007)(66556008)(6916009)(4326008)(6506007)(8936002)(54906003)(316002)(5660300002)(7416002)(44832011)(30864003)(41300700001)(31686004)(2906002)(966005)(478600001)(6486002)(6666004)(186003)(6512007)(53546011)(36756003)(2616005)(83380400001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNwajBFSmdDOVlxTnVlbVNXOE5qTFVzbU0wZUdrdkNJeW9ja1VRSjlCM1pP?=
 =?utf-8?B?S2hPdGliTGVSV2hlNllKdFV1cVFHVWdBRDlqWXhCc25MRUVIVlJLbGZzMk9R?=
 =?utf-8?B?alRUWXRzQ3Z1Q01zNFNUUGU5VEFRVDhBOWVtbjJzMXJFVW1GQ3B2aXNSSkxK?=
 =?utf-8?B?MzVLbWdrMlVPaWxkLzZNR2NuNEJxNUpOK205SFFGWDNCYXFUNHZRV2RHOG1s?=
 =?utf-8?B?UStkS1p1NWRjcHlycCtxaERQa01wZDNjVERnUm5GKzBjenlDRjA5Mjh6NTRV?=
 =?utf-8?B?blpycjJYOVp1bTQ2QlNxRGxpSUlJWXlGSVdqcURJUGNqdHp3Q2NHRUxLSE1U?=
 =?utf-8?B?ek9PQ2U0bkF3K2dFRlh2S25FQXZMR0hFdUlZS2k5NXB0MUNZdU9MUjB6dEhp?=
 =?utf-8?B?eitlWE8rV1A4STM2L3JQdmZtQ1VkNGpxeFR4ZEpMQmoxNGhza3BvOU5EWWxS?=
 =?utf-8?B?RXQ5WFFjQTlvbnBYWjFqdDlaRHBTNTlXN0RJa1RPTUNoRWE4K3hMUGJMRHg1?=
 =?utf-8?B?OU1GNWN1YlFNQUZvOG9yVXQwM2x1N0VmM0paOU1mRWdNYmprZ25oTEk1dVNz?=
 =?utf-8?B?U2VTU0VGTlBETklRTE9ud1BVdE1FSkwyelBUdWNWU2p3Znh1VzFyVzROM3VB?=
 =?utf-8?B?cUFPUmZxUm0vS1pwbE5wSENaZENiRjNmNkR3M2R1eXIrc1k4Ti80V2lWOHpC?=
 =?utf-8?B?TUNHbkxuM1E1VmlvQm90N25YcDhMbzFURUNJK3d5Q2hhenRBQVZXOGxZQmpH?=
 =?utf-8?B?L1BKY2tFU1FEM2pXbXlLRlVyMHQ4bWd5SVd4TDl3ZHNwSllEZ1l6NVpjN0Zo?=
 =?utf-8?B?c0U5c1Jka0hhTEhBbXJUUWRvbzdDbnM1NVB5dGZWcTIrR2g5WTN4ZlcybHJy?=
 =?utf-8?B?eE5WL0wxK0RDWm5aamthQko2VW5MdDRoSWhVcnJSMXRKRWdZdURkdmxBKzZa?=
 =?utf-8?B?c25qVHZRR0RSZzlEWjdLa0xpVnlGUHk4d1Z0c2ZyWkhrQy9iSklrbjlwV3lI?=
 =?utf-8?B?cDIrUFJMbkxqR2s5VHpJTlNjQWpsWDhWc3VUMWg4czdnRFZ2QmJJazJGSVg0?=
 =?utf-8?B?alMzTFd2R3gvWjR4Q0t2SzJ3dUt2WnFaTFVoZW12aWhqMGhqUEpvV04vSUF6?=
 =?utf-8?B?VUljaGZqRkxFRUtYMlY5REgxeE55dFRZN1JGU1FpOGVVU1IxeFZJODEySVpV?=
 =?utf-8?B?MkFHL2lTSm1sTEM0dzNFMllyNmRIcmtOVjlaNHcwOFFCNUlTTFNEbnZGalZQ?=
 =?utf-8?B?TlFRd0RMRlB4WEY4M1E5QjhtZTc2dEpBQzlodmFhYWpmaHBQTENrTkxtNFEx?=
 =?utf-8?B?Rmhtb3A0dDMwYXlpbHlrVzd5ZmtVOFU1cE14QkcwL3BuengwRXM4YVljWHU3?=
 =?utf-8?B?eTR0M1ZiYldCTm5LT0VhSG5rbjBYeWtaVkdwbmNYaDZpUmRpV28wQzR0eG5R?=
 =?utf-8?B?VW1OdmxONThIZDhLamxDMXhOUys2Y1pBOG1UZ1Fqc3RFb252aUNxM0lKUnVx?=
 =?utf-8?B?RWRwNXRHZlpKRVU5ZUdGQk9OcUFVcUtDaGIrcW1JWDdXVkVvTjZueHhmSkJT?=
 =?utf-8?B?a0grYXIvNnFTblFreDdVQllhMjJwUmxiaEhVUVppK3dKYTk4ZHV0UWJQZXVr?=
 =?utf-8?B?NnBJMkJ3Z0VsdkZ4YnY1alBIVHl5c2JZUDZpVEhMTlV3ZnAxQnpDNit5eTYr?=
 =?utf-8?B?bWNKU2tIMVdlWEc4dFhKVlNiZHJPT2R1OUJ6RDFCUEhlM09uRVNveU1Bb01q?=
 =?utf-8?B?YkpiVXIwY2xqVEhpZmVpS0x0NHRQL3NuRW15c3lqaFlnRVUwVDM3cTQvcWhP?=
 =?utf-8?B?OWM3TC9yNStEOGo2UW5BQzhzTGx5T25NMVpRQlJWTks3S1FPb3F6Q25IRld1?=
 =?utf-8?B?RDhUUTBCZE84cWxqZzVPT0FIWnZzUGxVdTMwNXlQL3UxMnVlSmxjMTVVaW5q?=
 =?utf-8?B?bXN4MUVEanpyRXYwWlErYk11U0FzeWU3SlFMZU1jVnFCSkwyc2xJd0xwaktp?=
 =?utf-8?B?S2wzdmQzL2s0VnhEd0x5d2xtVWx3blhGUnk2VjAzd3pWZi80aThSbGh3cE5V?=
 =?utf-8?B?S2NQMUZ2bExDOTlxL1dTK3l3Mk85emduVnNBZUwxV0lXVmtveW9WckZtU0RG?=
 =?utf-8?B?djRqMDN1YThtMEJHUVhqdUFOUm1QcTh1YkZxMHNWeGxCem5lZjdqYUVlZXc4?=
 =?utf-8?Q?yuXJqOos+NIxncSL0V8YJL8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R1lSMEN1Uk9yMUY4R0MrajU2T0hNcFAxNDBCclI3K1RBZ3Voa0JuOW1KdHp6?=
 =?utf-8?B?RGZxLzRoZGFXZXBZSVI0Y0YyaVVhdER1YzdPT1R4Q1RrWEhyRHlUQ1RGOHZr?=
 =?utf-8?B?U3NaUnRaR2dqWFFQTlI1SXp5NmtuSTN3SnlqaHZYVjdtNEE3eGNqL2crZnRa?=
 =?utf-8?B?OG5YaHVUOFErWEYwMFZnbHR1TnhnMWRyV1Nmdzk1MWFKQ0YrNUVlYTZ4aG5C?=
 =?utf-8?B?Y0FZY0lZaGw2bUExTzVTeUhUUWJJdllrb1FBcHRoRm53a01abVpKU3VidS83?=
 =?utf-8?B?T1o1SDNLV0tGSzg1aTVYRHFmRWFkOVNsTzdJa3ExSFU5ZU9QMW1LZ2I2SHFG?=
 =?utf-8?B?UWtPbUtwdkxDUXJKMlpzaGlWcmo1Q0JPRzNTMmFvM0JKNk9OSW5LZ3hvMzRp?=
 =?utf-8?B?Q09jbElIbUJYZStpV1ROdHhoRFd2YUVGaTkvcXRBaXNGeHRpelVjL1dCZUZ4?=
 =?utf-8?B?L2k3YXJuKzlYdndPLzJjc0JYS1hBalJCY243NjYwL0hqdFBJU2hhcDVGSmtY?=
 =?utf-8?B?QVBYYkVqME03TzkvcWhWcy9UcWdvWGNrZjIwNlREeC9mdjBjdVRzMjd2UStn?=
 =?utf-8?B?SHdnSW1KOGlGcnFzTXBUWndrYkR4dENxTmJvQW43b1pXWWFPUzFZM21WMEg3?=
 =?utf-8?B?cy9CaENFOUF6ejd1UDZ1Q21RZFFCelQxaXAvcm9QYmg1bUR3TVdTOE9peWF3?=
 =?utf-8?B?RTRweE44VHR5WGpMZjdQbWZlYnUxUGdnanVuTWRxbjVVL3FVdXJqM3FUYjU5?=
 =?utf-8?B?N000TDBGRk42YU1CK2NLYmxyTGJoVjk5V2tGbVZrbi9QM3duV3I3MWlpMnF4?=
 =?utf-8?B?eXI5MWptbENhOXFkWkIxVlNsaFdaV0xab1FyaW1TcnpJRzAxSXpnY0VhblZi?=
 =?utf-8?B?NVNLd052SmJrMURFbmY5UmUrK21ZeWlEMnprRXV1VkJBTDF0VHNKR1M2ejF2?=
 =?utf-8?B?ck1DNHdmZng3SWwvdHBjemcvaFFpbStabE14L0ptazRFaHplR3pYMnZWSHAy?=
 =?utf-8?B?OVMyRENiNU41R1pwU1ZZelg1ZjB6Y2IyZVJVM0dNdkFseTRtaXFjeElBWGxx?=
 =?utf-8?B?TVQxbjQ4eXp3SGtLbFBidzJtcm5ldlI3MzMxVVpPUDJ6c2NPTUN2bmpNcmQ2?=
 =?utf-8?B?YnR0a0pqZWtKaTFoeTN3L01QLzBvUEE4L3hUNkJtc2dOUW16ZEIxUjk0bWxi?=
 =?utf-8?B?dmJVMzVSV2l5RlJreTFnZnhGc2NvWDhqQlhBQjl0Wk1DeldrblYzU2ZxZm1j?=
 =?utf-8?B?aEcybTZGalhwMklQMTFlU0ZVdWhLem50ZkdnQ0VYdVNDV1Z0aGVDWXlIVmwz?=
 =?utf-8?Q?ochUcALorjZqo09SuRFmIqPrUtgE0Fl9hf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca7910-c3d1-4e67-1cb1-08db0466dc8a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:13:23.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hHCzMrjpR42wolHXfdOCacBlXRi9cZufmNgCYg63xmO/7R6emgY+60+Gj86X9/WU26Y73b1M8lVo9SeavAfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010130
X-Proofpoint-ORIG-GUID: qvpWjYfBvPiDVc2flStAvYaAH0PoNgV6
X-Proofpoint-GUID: qvpWjYfBvPiDVc2flStAvYaAH0PoNgV6
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023 15:02, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 01, 2023 at 01:59:30PM +0000, Alan Maguire escreveu:
>> On 01/02/2023 03:02, David Vernet wrote:
>>> On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
>>>> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
>>>>>
>>>>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
>>>>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
>>>>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>>>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>>>>> +++ b/dwarves.h
>>>>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>>>>>>>>>>   uint8_t          has_addr_info:1;
>>>>>>>>>>>>>>   uint8_t          uses_global_strings:1;
>>>>>>>>>>>>>>   uint8_t          little_endian:1;
>>>>>>>>>>>>>> + uint8_t          nr_register_params;
>>>>>>>>>>>>>>   uint16_t         language;
>>>>>>>>>>>>>>   unsigned long    nr_inline_expansions;
>>>>>>>>>>>>>>   size_t           size_inline_expansions;
>>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
>>>>>>>>>>>
>>>>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>>>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
>>>>>>>>>>>> defined if using a very old elf.h; below works around this
>>>>>>>>>>>> (dwarves otherwise builds fine on this system).
>>>>>>>>>>>
>>>>>>>>>>> Ok, will add it and will test with containers for older distros too.
>>>>>>>>>>
>>>>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
>>>>>>>>>> repo at:
>>>>>>>>>>
>>>>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>>>>>>>>>>
>>>>>>>>>> It failed yesterday and today due to problems with the installation of
>>>>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
>>>>>>>>>> notifications floating by.
>>>>>>>>>>
>>>>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
>>>>>>>>>> iterator that Jiri noticed.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
>>>>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
>>>>>>>>> from the BTF representation, and as a result:
>>>>>>>>>
>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>>>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>>>>>>>>>
>>>>>>>>> Not sure why I didn't notice this previously.
>>>>>>>>>
>>>>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
>>>>>>>>>
>>>>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>>>> {
>>>>>>>>>         return -EOPNOTSUPP;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> looks like this:
>>>>>>>>>
>>>>>>>>>    <8af83a2>   DW_AT_external    : 1
>>>>>>>>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
>>>>>>>>>     <8af83a6>   DW_AT_decl_file   : 5
>>>>>>>>>     <8af83a7>   DW_AT_decl_line   : 737
>>>>>>>>>     <8af83a9>   DW_AT_decl_column : 5
>>>>>>>>>     <8af83aa>   DW_AT_prototyped  : 1
>>>>>>>>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
>>>>>>>>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
>>>>>>>>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>>>>>>>>>     <8af83b3>   DW_AT_name        : ctx
>>>>>>>>>     <8af83b7>   DW_AT_decl_file   : 5
>>>>>>>>>     <8af83b8>   DW_AT_decl_line   : 737
>>>>>>>>>     <8af83ba>   DW_AT_decl_column : 51
>>>>>>>>>     <8af83bb>   DW_AT_type        : <0x8af421d>
>>>>>>>>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>>>>>>>>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
>>>>>>>>>     <8af83c4>   DW_AT_decl_file   : 5
>>>>>>>>>     <8af83c5>   DW_AT_decl_line   : 737
>>>>>>>>>     <8af83c7>   DW_AT_decl_column : 61
>>>>>>>>>     <8af83c8>   DW_AT_type        : <0x8adc424>
>>>>>>>>>
>>>>>>>>> ...and because there are no further abstract origin references
>>>>>>>>> with location information either, we classify it as lacking
>>>>>>>>> locations for (some of) the parameters, and as a result
>>>>>>>>> we skip BTF encoding. We can work around that by doing this:
>>>>>>>>>
>>>>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>>>
>>>>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
>>>>>>>>
>>>>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
>>>>>>>> applied to arguments.
>>>>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
>>>>>>>> the way we do in selftests.
>>>>>>>
>>>>>>> There is also
>>>>>>> # define __visible __attribute__((__externally_visible__))
>>>>>>> that probably fits the best here.
>>>>>>>
>>>>>>
>>>>>> testing thus for seems to show that for x86_64, David's series
>>>>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
>>>>>> to cover recently-arrived kfuncs like cpumask) is sufficient
>>>>>> to avoid resolve_btfids warnings.
>>>>>
>>>>> Nice. Alexei -- lmk how you want to proceed. I think using the
>>>>> __bpf_kfunc macro in the short term (with __used and noinline) is
>>>>> probably the least controversial way to unblock this, but am open to
>>>>> other suggestions.
>>>>
>>>> Sounds good to me, but sounds like __used and noinline are not
>>>> enough to address the issues on aarch64?
>>>
>>> Indeed, we'll have to make sure that's also addressed. Alan -- did you
>>> try Alexei's suggestion to use __weak? Does that fix the issue for
>>> aarch64? I'm still confused as to why it's only complaining for a small
>>> subset of kfuncs, which include those that have external linkage.
>>>
>>
>> I finally got to the bottom of the aarch64 issues; there was a 1-line bug
>> in the changes I made to the DWARF handling code which leads to BTF generation;
>> it was excluding a bunch of functions incorrectly, marking them as optimized out.
>> The fix is:
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index dba2d37..8364e17 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1074,7 +1074,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>                         Dwarf_Op *expr = loc.expr;
>>  
>>                         switch (expr->atom) {
>> -                       case DW_OP_reg1 ... DW_OP_reg31:
>> +                       case DW_OP_reg0 ... DW_OP_reg31:
>>                         case DW_OP_breg0 ... DW_OP_breg31:
>>                                 break;
>>                         default:
>>
>> ..and because reg0 is the first parameter for aarch64, we were
>> incorrectly landing in the "default:" of the switch statement
>> and marking a bunch of functions as optimized out
>> because we thought the first argument was. Sorry about this,
>> and thanks for all the suggestions!
>>
>> Arnaldo, will I send a v3 series incorporating the above fix
>> to patch 1?
> 
> I can fix it here. Done, I;ll force push it to the 'next' branch.
> 
> Also I noted the index_idx usage in parameter__new(), it can be -1 when
> processing:
> 
>  <1><2eb2>: Abbrev Number: 18 (DW_TAG_subroutine_type)
>     <2eb3>   DW_AT_prototyped  : 1
>     <2eb3>   DW_AT_sibling     : <0x2ec2>
>  <2><2eb7>: Abbrev Number: 3 (DW_TAG_formal_parameter)
>     <2eb8>   DW_AT_type        : <0x414>
>  <2><2ebc>: Abbrev Number: 3 (DW_TAG_formal_parameter)
>     <2ebd>   DW_AT_type        : <0x69>
>  <2><2ec1>: Abbrev Number: 0
> 
>  And in that case we don't have the location expression:
> 
>   <1><af36>: Abbrev Number: 77 (DW_TAG_subprogram)
>     <af37>   DW_AT_external    : 1
>     <af37>   DW_AT_name        : (indirect string, offset: 0x4ff7): startup_64_setup_env
>     <af3b>   DW_AT_decl_file   : 1
>     <af3b>   DW_AT_decl_line   : 592
>     <af3d>   DW_AT_decl_column : 13
>     <af3e>   DW_AT_prototyped  : 1
>     <af3e>   DW_AT_low_pc      : 0xffffffff81000570
>     <af46>   DW_AT_high_pc     : 0x6d
>     <af4e>   DW_AT_frame_base  : 1 byte block: 9c       (DW_OP_call_frame_cfa)
>     <af50>   DW_AT_call_all_calls: 1
>     <af50>   DW_AT_sibling     : <0xb11f>
>  <2><af54>: Abbrev Number: 67 (DW_TAG_formal_parameter)
>     <af55>   DW_AT_name        : (indirect string, offset: 0x2a50d): physbase
>     <af59>   DW_AT_decl_file   : 1
>     <af59>   DW_AT_decl_line   : 592
>     <af5b>   DW_AT_decl_column : 48
>     <af5c>   DW_AT_type        : <0x4c>
>     <af60>   DW_AT_location    : 0x10 (location list)
>     <af64>   DW_AT_GNU_locviews: 0xc
> 
> I.e. its just a function _type_, not an actual function, so I'm applying
> this on top of that first patch, ok?
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 7e05fde8a5c3ac26..253c5efaf3b55a93 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1035,7 +1035,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
>  
> -		if (param_idx >= cu->nr_register_params)
> +		if (param_idx >= cu->nr_register_params || param_idx < 0)
>  			return parm;
>  		/* Parameters which use DW_AT_abstract_origin to point at
>  		 * the original parameter definition (with no name in the DIE)
> 
>

ah, great catch. thanks again!

Alan
 
> - Arnaldo
>  
>> With this fix in place, prefixing the kfunc functions with
>>
>> __used noinline
>>
>> ...did the trick to ensure kfuncs were not excluded on x86_64
>> and aarch64.
>>
>>>>
>>>>> Yeah, I tend to think we should try to avoid using hidden / visible
>>>>> attributes given that (to my knowledge) they're really more meant for
>>>>> controlling whether a symbol is exported from a shared object rather
>>>>> than controlling what the compiler is doing when it creates the
>>>>> compilation unit. One could imagine that in an LTO build, the compiler
>>>>> would still optimize the function regardless of its visibility for that
>>>>> reason, though it's possible I don't have the full picture.
>>>>
>>>> __visible is specifically done to prevent optimization of
>>>> functions that are externally visible. That should address LTO concerns.
>>>> We haven't seen LTO messing up anything. Just something to keep in mind.
>>>
>>> Ah, fair enough. I was conflating that with the visibility("...")
>>> attribute. As you pointed out, __visible is something else entirely, and
>>> is meant to avoid possible issues with LTO.
>>>
>>> One other option we could consider is enforcing that kfuncs must have
>>> global linkage and can't be static. If we did that, it seems like
>>> __visible would be a viable option. Though we'd have to verify that it
>>> addresses the issue w/ aarch64.
>>>
> 
