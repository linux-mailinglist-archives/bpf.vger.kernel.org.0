Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807B067CD3B
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 15:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjAZOD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 09:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjAZODt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 09:03:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389972B622
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 06:03:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QDiS0p016776;
        Thu, 26 Jan 2023 14:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6dpKqBY91bEsIsFSB3DCemSJJANC2veuHIvayAuj8OE=;
 b=NHQ7V+hznGOrMrsBPKScZH60WEl7AzLUbbUhBK26otTrgZfrwhcfZ4E5wiraveVGss+s
 HxT/B1TmvDdlgYgF6F6X6ClMowO0fiS/0/rePu1+Lit5gUIVFhy4cY23vMnKiXEyaMKg
 eqt1cA9Pp0AP/1I6KJi9UjHM5iHIaKHgW3F+bWcRtL+QTwa+KIXNqCBwSn/cG1Dx1qzM
 hxsi2/HWZDebuVgM/s1sgE/jTkzOqRLTqGPjVJ/4ZyFqyg6q0DMhNZQAAPpHR1Qi4/TR
 e9m98OzrDEHc4YYhavkqfXEdec7B+kzwIMrzG/pOnB4uuPsA8MknMCl+7ChTiveDxhz9 Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n12cs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 14:02:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QDdw3D034260;
        Thu, 26 Jan 2023 14:02:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7vthx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 14:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMUmaY7Y7XGF0VnW/2q4QO20nKTo/u8fvZe9hJw4FQtlfnF/olzYGsTx2JT2n+ET35gkgULA0q9nXx9cTmUSQ1nJyXVAK2pOMtNsg/VAk4q0ZiAaezkd0ky1CDXet+PBY2DBCWcPkHkZTC9MvmZJRt+4sY1LrY1sifnywrm9UzhBHpg8yZL38D56zAY10zFTbafqyVyV4i1Poe8RXeFaBwe/sUMfAIRxbKmva4V7X7VMNrH1lY9iEjkv6xS9bnxKwtsX1fCP2XVHmkJMUSRqN8ZOTDz/dhoYcg3FRsthzGlYh3m4kMU4FXtQ0pemfz6Z+m+XIVYAMK2eUS9zZjCdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dpKqBY91bEsIsFSB3DCemSJJANC2veuHIvayAuj8OE=;
 b=MLIDPJWu08xnQOG10ZXZkwHcbzu7aXa07+X2+rLH9Vm3JtpqT0np7vbRk4vz/2GBS7m+jiAQWRJpa1BaO8oJZbc1bDUsyiXY55SVigU5tdJTGgcLnlod85eHbtEWKbAKLOe3C/qBqqZ7r2Tc5058o5g7w+YQ/5xDjIjIZ8LGJ7us+Kp9eUyHUPikY9VRmutirRUYByZZ0SsuAvQLfVoInR9aaJY6o4cir49w3AYEG0q13opCgRUxyoKlvoEr/usVD+Yy+siuNOA/qCNFfSWYBOalWAN/AJ8gd7YvIDMDNgIx1FJUIz1XOEv0QC1Xq5qB38H8HSvtXvZ3g3RzoqWFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dpKqBY91bEsIsFSB3DCemSJJANC2veuHIvayAuj8OE=;
 b=nlbo8dbia5I5ME6lDSUs7Vyu7R82KjDHQoacTAr4Qn8w2vHoUPxp8FmeEr/uIWCouX1xUUuNt1DjhXNgF8aoPfCRVxonaId1ONPd9g77BhIZVEFqD/JhYZGJmj1d6Ad2HvA2A3Qlx18cmozMAxPLJdboIzec+Uhx0eyZuEw+S0M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN7PR10MB6476.namprd10.prod.outlook.com (2603:10b6:806:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Thu, 26 Jan
 2023 14:02:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 14:02:48 +0000
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org, yhs@fb.com,
        ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
 <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
 <3ca14d5e-5466-fb4e-b024-01ba33370372@oracle.com>
 <f23eb6cfe20966d7b417f29ec782f78fa0ab93d5.camel@gmail.com>
 <530ea13a-5229-82a8-d976-b0bc141c3448@oracle.com>
 <bc50242da1ea8b3b3eafb62e880ed4a278492d2c.camel@gmail.com>
 <9ed96849303fbc3dee1da5dccac05bd11fb04789.camel@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <2373c8fc-878f-d061-dc41-49a020438a2e@oracle.com>
Date:   Thu, 26 Jan 2023 14:02:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <9ed96849303fbc3dee1da5dccac05bd11fb04789.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0429.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::33) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN7PR10MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 479d602c-8ff5-469e-2c2d-08daffa601b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nO1Id1Mr7csU+0e5houzioRzSZmBybJuBnO8fQZ+ArIAQ01v535agrapwpiLx/GsSLBjyeSqTruW0ZayGIeQVdvcTdEcR0kfMAwgsQGK6fkAC4ih3OXAim50sw9U/tlBrl6aJ581OPP14wYlbu3M29PLUVTBlfHcmvi55NhbGG7hK9h/gOumRgj2iuFmVAIYEQ+n25zaOzpNqr3/IdecnLtHe2m6z1AV7iU75FwrmC6Qa3MTUjE0/xhCkZALiIRQtMqQ07lnU96ytxhQLNrBSGH54uyJO8Uk1YQyhoxkpU3cgabBBthq4y2QzGXROGhuhoR5F/UWOLTkBnUa5tcHum4ARkuBSlyGGkN8N6+IyCyhwSOGXjhODCxA14H4w3UWv1oXl4a7mYEedFLzFQhlBYB6JKIl0jWp0Afm2mpq3L0I3ohCj5MqI6icI6yH89rXjsQS8Nf+oKXRdsC/HGyVgQjy0htqawhGHjIgIL257z4amLiQdmOZ48xyhrpnM11dR1YNYj+HvergKgFu8LGSC1B7ejkeYegZCBd0prg60crfA5yqKGA49IThfG/5bxL+YB1AbRHYlT/c8U8lRTCZpSpXzfnUE8VFgj8iDAeM8FjB5GYoiU6MkR8gF2T6tJIWEmvOlB2UCgmTlCHU63+MuqlX+3Z64SNqMoAnUhsEqHazZXA22LfHnvych7aEYMkMt55Tuf+SnN3rmdEqVBZNBC68n+J1cbERLL7aMguKGtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199018)(38100700002)(83380400001)(478600001)(2616005)(66476007)(8676002)(66556008)(6486002)(31686004)(31696002)(66946007)(36756003)(41300700001)(53546011)(7416002)(2906002)(86362001)(6506007)(5660300002)(316002)(186003)(6512007)(6666004)(8936002)(4326008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZSbmdCMUMzcTRRc1Q4MlRYK1IyZUQyMzVRR0pzbjc3UGV1M0dTUGhXeUxx?=
 =?utf-8?B?bzMxUktJeVhmVVczcmJGNko2K2pqSElTYXhDRmRLMktiemU2SjhabkpqUWVn?=
 =?utf-8?B?aTIyS0Z0aVRjV2MzT1l0V3J1VkF2ek14V0x3QmRkRXNubEVFOXg2OXBaZzJm?=
 =?utf-8?B?M1VCN1EraG5yaTV3OFNFZElNa1M1Q010UGRjV1VXeDVYUlBqREJrT25RQVp6?=
 =?utf-8?B?RTQ4anhxWUtEd3ovN3J4SHBncGs3SG5JWGJMdWdXMUE0VE80R3lSclBGMTFI?=
 =?utf-8?B?WW9xQ3NUK3JnL0RneGdqOWI0ZVdwMUxJVTRXT0FQVGxuMGhjSnYwemVpanlK?=
 =?utf-8?B?SGNiZGsxeTNtMHVGTmJPZXRBeWdXeVZNWDFLRVdlMFlGNEtzeDdmK0pKNWx4?=
 =?utf-8?B?RFRXWnIvZTJ5ZlkxbkpwN2xzTjFiZXFwaGo2TzBSVzNtcUpUNHkxcEVoTEda?=
 =?utf-8?B?bXlBMy9JREg1ek94bStwMDczL0E4NVRmSDNidzBKTCthcmhNWWI5THkxd2U5?=
 =?utf-8?B?TkZuZ1ZpaG1RczdPWW5ld0cwNDFBRWJ1RVc3aUJWS2cxNkY0ZVhkMDhuMjBJ?=
 =?utf-8?B?em5rM091WGt2YTFFM2pyTXdpVDhLcURJMjNzcldnTTFCZ21lc1hkVlNIL0Rj?=
 =?utf-8?B?UWRyNXVtaTA4Ymtva0lpY1JTNmFoSFZpbE8rdFJuZXVMNWxlcklkTE9Ud3ZK?=
 =?utf-8?B?eWx4TCtLTTdlQmZpdGs4Nm5oMGlacVpBaDMwVktzM0FnSXpyWU80VllBelBh?=
 =?utf-8?B?U1ZydVJlTkh3dlBIcGduYUNBVG1TV2ZDMTcydEVTbzc3ZHRvOVByNGQ2ODB6?=
 =?utf-8?B?K0FHMzFkNzhhTERSRjE2eCtiKzhpMnZBMzkzTFlCUGF5SlYremUwRi9QU1pL?=
 =?utf-8?B?OHhGTXkxcXV3MEMrb1A0QlNHeW14a0NJcnU2ZjZtREdxTVNObHB4bHhEaVUx?=
 =?utf-8?B?K1hjYUhqckNmUGt3bWdmdUFFZjh5cThSa010WlNSVGxVWlA2Qy8xSmNOZm9Y?=
 =?utf-8?B?OXRCaG5veForLzU2b1VIMGR4WE1JYmh0ZXJPR2hKc2hFTGZ5TXZhazBoSEF4?=
 =?utf-8?B?ejVDRmJNTGhoRHg1Q3RDbmFBeUtjeDFBc094U0tnN09vT1dkUHV4TkFkTnlF?=
 =?utf-8?B?NXVSVmJHeVdnNDgxaExtRXFBODFGb0ttM3ZyQlk3MDhOeVN1TzVHL1NBeGc0?=
 =?utf-8?B?bE4yRUZCdU1rZmYwdFE0MTI1Mnd4TDBZRExkQ0lJNUJ0ekdRb3FiMzZsU3hm?=
 =?utf-8?B?TUU2dXE2Y3lRYkg3VWtMVmdwM1FCcmJ4SjQyOUx5VzVUN2t4UVVzZ3ErdEMr?=
 =?utf-8?B?aHdSTm9DM3pVSEJ1Rm5ocFJnTUVDQk9xN3FUY1hpU3liM2MvZnpkYkI0b0oz?=
 =?utf-8?B?SFVsakp3V01SZzVyNUM5MWhQOWQ5YlNCMUZJWmExSkQwZTJwbktWKzZBSjl3?=
 =?utf-8?B?eE5RSDdQWTNRMmNSQ1FTRURhQzZZS0J1eG1vUEpjeFkrdVNkZ1ErSGZVUFpK?=
 =?utf-8?B?SFF6Mlo0MU52cVdlc1BMRHlIZUVWWTZFODhVazg2bUVySWduZFBZcGZJREc0?=
 =?utf-8?B?a2RzVzArbVlBRUgvNUNmTWxQOUs5aWxOWkNteUtCS0JUYS9KU1kxZ2ladmZ1?=
 =?utf-8?B?S0I5ZENkSHJCUkRLZ1JHMFBVRWNDNTNEZE9GTS9mekpySzExRFBUNjVpQ25l?=
 =?utf-8?B?Y2VFSTVoQnptaWxFc090dEZNRTMyazR2KytzVlcxdmpZZ0thSFg5b0JMZXpY?=
 =?utf-8?B?cFQ5azZhM0pxcXUzNk9pblNSdHZXZmRFNzc2TGRlT1p4NDBXQVduMzJFY0hl?=
 =?utf-8?B?ZEZvdU1SdGtGUmYwNFRKVEJra1hDWjFWeWtiQjFtbHRvdW9kWFFsTitsSzVW?=
 =?utf-8?B?cW80U25YQWwvUlQrd0hwdGt0a040a1krcVVzVmhOUGI2TmZNc0YwREp3UVNI?=
 =?utf-8?B?aEp0aDBvZmV4SlZHTGttZnBxUmZjdUVzU3NQUURiUTNUdTlyVG12TEJCVklt?=
 =?utf-8?B?cXREUU54enlCSGdYOW04QnI5NWJQd0xHTHZwVzZDUlZqZTR5V0RrRFpPSmRO?=
 =?utf-8?B?VHpCNTlSUi9xTGN5NnYzcTNqNmprQXozWk5jbWh4dXBoTG44aGtDTTJNY2xT?=
 =?utf-8?B?d0lwSEo2YVRJMHd6alF6bHlUWmVFcXlsVk92dkVvdXVBRWg2L1pHTllpRGtL?=
 =?utf-8?Q?ZU6ruL9jhFyO2hlm0aqlMmY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dGl2RnRVWnRlVGlydVZIMkZoRVdFMXNiMjV5d0ZMc1d4amh4T0JvTG1MZ1di?=
 =?utf-8?B?SUtvdXQ4TUp4Q0hWajMrZFdkMW1OSzJxRkpoRHgzZklJdmlmWkxkVmpta2hM?=
 =?utf-8?B?NDFlMzFxTGR6TEFWamFyQllnblFzcExxakljWXJWN2pEVWNadFVueFk0NHpN?=
 =?utf-8?B?aEN4cWNYMmc3Q2xRMXBnMkpwYTdIWFFPb3UrSklCZkVraTRVKzZSR3diVGEr?=
 =?utf-8?B?VkRzT2MrbFpQTWdyZUM4R01lQnB5K1hPT2xtZCtaL21aVGliNnRlUk9nUU0y?=
 =?utf-8?B?Nm5DMzlZNUZDbXNqWVlNZkdiQTUrd3pQbWJlUWZDVHVTLzZkbWxsQ1R3dk5N?=
 =?utf-8?B?cmMyR09Nd0Z3b2R6SXlQcWEyeG1MYVNHU0QyY0tOa3lzeUR5cHAydkRwYmM2?=
 =?utf-8?B?b1d3eUo1VHZFcXZZdm14ZG9SUFNBeVUyRVhPeDlHUTVUWFZTZUFydGFIYU9t?=
 =?utf-8?B?cGtJR3QzUGl3QkpBZmpvTHQrNUdsemwwRmhUL1JpOEpqb2FGUjMzZlJBVW9B?=
 =?utf-8?B?VzcwZjFSN1E0WW5peWNpYVNPWEdqakF0VFNLSmhVNGljTUlPZ0FlQm16cXNQ?=
 =?utf-8?B?YWNXMWNvOWpDaXA2YUNYMTNoSWpvQ1dDSHljTWpXU0F3L0JJQ1gzK3ZJZWJL?=
 =?utf-8?B?Qy9qRnlaNytPcG9ZYUY5R3FpUStIdE1wR1I5OFhHMlRVb3hxazBFc0lvd0VN?=
 =?utf-8?B?a2lFVnZoZmk2Z0dUdzZtbCtBdFg3YXJ5T1BPYWM3Y3U1Z3prQWNoR1puNWZI?=
 =?utf-8?B?NzExZGFYckdVWFEvOTR1Yzl0ZGw4QnZFUTUyQjV2TU9mbU1kaVJSVTMvTlFn?=
 =?utf-8?B?a1ZYRWY0Vmtmd0N4UWVvOEo1S2t3aXJZRmNzL0kxNWlDUXgyTUFyUEdWY0pQ?=
 =?utf-8?B?KzNKOURhcEpYSlBFZ2IwbmR4V1N3UEc3dGUxZFdBc0tNdFhLMG02Umt3OWVF?=
 =?utf-8?B?QVhFKzlFNUhSdDYxblFQK0RLQzExeVhvTVZmcDJ1bmEraC9Lb3pEYjR5Si9Z?=
 =?utf-8?B?VTZqWkpQZmtlTnpteCs2WTV3QWVDem9wdFZBQ3Rac01HTU13RG02SlAzTnhK?=
 =?utf-8?B?bFAzaDd1Njl2amttSTdWVXBRUTRlRWNlRDNGN3ltSDhta0V6VEI0OEZWTUZY?=
 =?utf-8?B?Q1FOdWVzQ09zaTN4R2taMU1mVHVoVkE4SW5CWXZpYzVBNHp6Y0NjSVBaR09F?=
 =?utf-8?B?N2ZIVGFPc3ZjVFptZU9LYklDUVJQc080VXpzbWdmZjc3c2JXdXMrV2JXNmpy?=
 =?utf-8?B?WGlFSUQwbnRYUC85eitQUWx6UWxIR1Rua1lRUU9UNGN6TlVSQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479d602c-8ff5-469e-2c2d-08daffa601b1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 14:02:48.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJR13FVS6DZqX5ItOMC3vYZqlXX8ELdImBqFZQIZ0536zcPFE7EM6U4R8gpFyCXe+5dmEYc8wliXzac2K3w1ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260135
X-Proofpoint-GUID: q6F5v3YNqq9m7oNb6FzbLF9069gGP3WL
X-Proofpoint-ORIG-GUID: q6F5v3YNqq9m7oNb6FzbLF9069gGP3WL
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/01/2023 00:20, Eduard Zingerman wrote:
> On Thu, 2023-01-26 at 01:42 +0200, Eduard Zingerman wrote:
>> On Wed, 2023-01-25 at 22:52 +0000, Alan Maguire wrote:
>> [...]
>>>
>>> Thanks for this - I tried it, and we spot the optimization once we update
>>> die__create_new_parameter() as follows:
>>>
>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>> index f96b6ff..605ad45 100644
>>> --- a/dwarf_loader.c
>>> +++ b/dwarf_loader.c
>>> @@ -1529,6 +1530,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *di
>>>  
>>>         if (ftype != NULL) {
>>>                 ftype__add_parameter(ftype, parm);
>>> +               if (parm->optimized)
>>> +                       ftype->optimized_parms = 1;
>>>                 if (param_idx >= 0) {
>>>                         if (add_child_llvm_annotations(die, param_idx, conf, &(t
>>>                                 return NULL;
>>>
>>
>> Great, looks good.
>>
>>> With that change, I see:
>>>
>>> $ pahole --verbose --btf_encode_detached=test.btf test.o
>>> btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
>>> Found 0 per-CPU variables!
>>> Found 2 functions!
>>> File test.o:
>>> [1] INT int size=4 nr_bits=32 encoding=SIGNED
>>> [2] PTR (anon) type_id=3
>>> [3] PTR (anon) type_id=4
>>> [4] INT char size=1 nr_bits=8 encoding=SIGNED
>>> [5] FUNC_PROTO (anon) return=1 args=(1 argc, 2 argv)
>>> [6] FUNC main type_id=5
>>> added local function 'f', optimized-out params
>>> skipping addition of 'f' due to optimized-out parameters
>>
>> Sorry, I have one more silly program.
>>
>> I talked to Yonghong today and we discussed if compiler can change a
>> type of a function parameter as a result of some optimization.
>> Consider the following example:
>>
>>     $ cat test.c
>>     struct st {
>>       int a;
>>       int b;
>>     };
>>     
>>     __attribute__((noinline))
>>     static int f(struct st *s) {
>>       return s->a + s->b;
>>     }
>>     
>>     int main(int argc, char *argv[]) {
>>       struct st s = {
>>         .a = (long)argv[0],
>>         .b = (long)argv[1]
>>       };
>>       return f(&s);
>>     }
>>
>> When compiled by `clang` with -O3 the prototype of `f` is changed from
>> `int f(struct *st)` to `int f(int, int)`:
>>
>>     $ clang -O3 -g -c test.c -o test.o && llvm-objdump -d test.o
>>     ...
>>     0000000000000000 <main>:
>>            0: 8b 3e                        	movl	(%rsi), %edi
>>            2: 8b 76 08                     	movl	0x8(%rsi), %esi
>>            5: eb 09                        	jmp	0x10 <f>
>>            7: 66 0f 1f 84 00 00 00 00 00   	nopw	(%rax,%rax)
>>     
>>     0000000000000010 <f>:
>>           10: 8d 04 37                     	leal	(%rdi,%rsi), %eax
>>           13: c3                           	retq
>>     
>> But generated DWARF hides this information:
> 
> Actually, I'm not correct. The information is present because
> `DW_AT_location` attribute is not present (just as 4.1.4 says).
> So I think that the condition for optimized parameters detection has
> to be adjusted one more time:
> 
> 			has_location = attr_location(die, &loc.expr, &loc.exprlen) == 0;
> 			has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
> 
> 			if (has_location && loc.exprlen != 0) {
> 				Dwarf_Op *expr = loc.expr;
> 
> 				switch (expr->atom) {
> 				case DW_OP_reg1 ... DW_OP_reg31:
> 				case DW_OP_breg0 ... DW_OP_breg31:
> 					break;
> 				default:
> 					parm->optimized = true;
> 					break;
> 				}
> 			} else if (!has_location || has_const_value) {
> 				parm->optimized = true;
> 			}
> 
> (But again, the parameter is marked as optimized but the function is
>  not skipped in the final BTF, so either I applied our last change
>  incorrectly or something additional should be done).
>  
> wdyt?

I've been digging into this a bit, and the issue here is that for 
gcc-generated DWARF at least, location info is often in the abstract 
origin parameter references, so we have to combine observations across
abstract origin reference and original parameter to determine for sure
if the parameter really is missing location information. In the
case of this program there are no abstract origin references, so
it's a bit more straightforward, but we have to handle both cases
I think.

I'll try and polish up a v2 series that incorporates this shortly;
in testing it, it works on this case as desired I think:

LLVM_OBJCOPY=objcopy pahole --verbose -J ~/src/isra2/test2.o
btf_encoder__new: '/home/alan/src/isra2/test2.o' doesn't have '.data..percpu' section
Found 0 per-CPU variables!
Found 13 functions!
File /home/alan/src/isra2/test2.o:
[1] INT long size=8 nr_bits=64 encoding=SIGNED
[2] INT int size=4 nr_bits=32 encoding=SIGNED
[3] PTR (anon) type_id=4
[4] PTR (anon) type_id=5
[5] INT char size=1 nr_bits=8 encoding=SIGNED
[6] STRUCT st size=8
	a type_id=2 bits_offset=0
	b type_id=2 bits_offset=32
[7] PTR (anon) type_id=6
[8] FUNC_PROTO (anon) return=2 args=(2 argc, 3 argv)
[9] FUNC main type_id=8
added local function 'f', optimized-out params
skipping addition of 'f' due to optimized-out parameters

Thanks!

Alan

> 
>>     $ llvm-dwarfdump test.o
>>     ...
>>     0x0000005c:   DW_TAG_subprogram
>>                     DW_AT_low_pc	(0x0000000000000010)
>>                     DW_AT_high_pc	(0x0000000000000014)
>>                     DW_AT_frame_base	(DW_OP_reg7 RSP)
>>                     DW_AT_call_all_calls	(true)
>>                     DW_AT_name	("f")
>>                     DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>>                     DW_AT_decl_line	(7)
>>                     DW_AT_prototyped	(true)
>>                     DW_AT_type	(0x00000074 "int")
>>     
>>     0x0000006b:     DW_TAG_formal_parameter
>>                       DW_AT_name	("s")
>>                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>>                       DW_AT_decl_line	(7)
>>                       DW_AT_type	(0x0000009e "st *")
>>     
>>     0x00000073:     NULL
>>     ...
>>
>> Is this important?
>> (gcc does not do this for the particular example, but I don't know if
>>  it could be tricked to under some conditions).
>>
>> Thanks,
>> Eduard
>>
>> [...]
> 
