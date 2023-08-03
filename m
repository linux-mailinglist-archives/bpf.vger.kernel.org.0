Return-Path: <bpf+bounces-6879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569EE76EF26
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D82282240
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2424179;
	Thu,  3 Aug 2023 16:11:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EE182C8
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 16:11:34 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAF02D7E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 09:11:32 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgEbJ005992;
	Thu, 3 Aug 2023 16:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5GvFa9J7Ex6WyJAFx7XpN/T05ia4iajukN1ldxUAQGs=;
 b=4Lp44poFU71/9G1ztpVFIdnFptq+kUIVRQQdqEwQ4DZ/G4/nuoBxdctSYNYYgErx4Nfu
 l9HkuK8KCwxmYwfrc++2dQUGZNAzF4DuF7KQCjqTeWDczp9t9zXIGWd8/3TF8G8uA6U4
 +O1CAJwPd/DaovlDb4aBKqvb34oUk7jHzJeppWjF+drPBht6HIravvjyUZgfXg0hyrjn
 S37KtZqx7C40JzLaHfrEburj9B31s/G+M9o+IJqS+xhpQbNAeoGcRNfAJSWta9S5tfr5
 cmp4N/nETpThi8kITuvz6ceORhj1rRk998/zUqkA4OmLA824bdKOtR7MY8PIbeWSvTzB hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttda3mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Aug 2023 16:11:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373Ekhpq003331;
	Thu, 3 Aug 2023 16:11:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s856rkqgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Aug 2023 16:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABHy3y7Ywqyn/XqnNVZ/afkoR+1p5/FXB9EJYDtrAW1Hkyt79DNi+5DoQIEM6yetvHoPJRhhA/TUOjvw2iu8odbQ1mKgA+/iaXoeY1BOxa3iDcslcZVlN5mPFgceLNnsfRS5vvvTv/z+uFYewVr5pcUTbSE5IPgSZQFVkkDZQHtllsLe1o70oAEyt75ZC5JEOdJPY44K+X9tVnmdcApzO2dVB61YelHcUsh0oU2neYr8V4xCAF46qzi+YpwHK7KP6tHEwPvwJJ+NWr/OoRGzibqEuttzRkbcBlQR6F9nf0s9QPfOZn6tUkUt9Ll9k1RoHIN9d1iK+cn2kxgnQmm7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GvFa9J7Ex6WyJAFx7XpN/T05ia4iajukN1ldxUAQGs=;
 b=OqRXPKqtDLU11aZkukbNUhLyvqisr36+nQUTQM+2ddKVqWd0CFcHchZZ6mUi0zShY3aY+0XnWzewS1PrVB/WcRIZbj5GB6m4bukrve26SZ9QZyNFWhkXBuwyHQFbAGzcSPdNs8jurffaNU8o8+AQlQVmbWMMcf06Z9awYNx7ZAr2wKOIM/WwQxvriX3Yo5bXJVIDyOSd3rWNHboAWQ9LVm4uEH/0C4mQ+Vx2V5O3ew6rn73IqAbaYmKZG1/Ggh2C55l0VvUDdPbICX3sjCqNez8H+ep+Ppc2hzy09ctiHip/Dk1PLi4o819hFt1RP5v74km8xkLRTp2IqbZQdnCG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GvFa9J7Ex6WyJAFx7XpN/T05ia4iajukN1ldxUAQGs=;
 b=LJhTjDUfFEA5LZCIfTvgi/SqwMXg75UC9BUJQ8VAtoie7G2xfEkb6gsDsrUUkEF8vIRhYJYti//cTrjo9MdHexKBztgKKs6ryXJi4tavu7y6zcj1AE4G+f/WQR8xBK4g9S1Ye0aJNouVx7ofGb8camYGPs1kROBGTU+2RRzcIRc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 16:11:02 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 16:11:02 +0000
Message-ID: <1ba1c605-4237-d54b-fb7d-6a7c899a0746@oracle.com>
Date: Thu, 3 Aug 2023 17:10:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
Content-Language: en-GB
To: yonghong.song@linux.dev,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
 <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge>
 <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
 <998f8e89-fb00-820f-15d9-1d227cc09e54@oracle.com>
 <cddeb658-563e-9ff9-0ece-4509eabab663@linux.dev>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <cddeb658-563e-9ff9-0ece-4509eabab663@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4651bf07-a284-45b8-a351-08db943c3bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SJmzaFj1YdD12jbbolO2s0axJAENJQbnQPa2Us01jfK3X8iQMj2m+Ai676i3ZKipEM8G3U2U5L4GzFu982Dq5o5s0cyH61a8+WQKksBRRoRJIYX/H9T7cxKH7h9eLqg/Xns2IzzTqDBX4SfhdHR11tzpHj7GUkKDeR81pAaRqhlmLwCFIR+4JXxRTElrYaEpgEIyhG34g31A8xGtgTdUh1+zmXs5NsM1VM0GoMNZrpvZaiTgoqO34IVF7yswo+OLORzVvOWvyFwNfxl+NelCAvOE2k5fElBNvu9xNszMo0nbgKiKVsaUBcnWz1sbIiyOC04EdLfo6HMbiWzu1yvP5ZsPyp0cc3+k4//UTnW3ESK9oLBA51TmL/cqJ8ioVtyAp6VGsdzqcKhoDdISeJwPxpUplXeqONV+b294Zn/bbVl239ZG/153SYIF25kUbNIC91rJuCLLLo/nyDcRHUOritvPd/TZo5/pm66LbGgQOOVUDn/jHI1n9zUvtTzUF/9ZMxpszmJqttdijZ5bbbcx2Vjiy1qPRwiwFjXQFZzc22sxWlq+PwwOMgz0hQDzAu/pojvU3DMjDY8RGtnVa7qy8iYVp1DdUjaIX/+r3h/zcxw5h3dIdFU7CgLmeoTP1y93XgBx4IdriVbA2vhTgu3Dj7TcMhKJ0/WN7pNXZnKVeJdbNpJUISldh9uryY1JeTgK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2616005)(107886003)(53546011)(6506007)(186003)(8676002)(66476007)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(7416002)(44832011)(8936002)(41300700001)(6486002)(6666004)(966005)(6512007)(54906003)(110136005)(478600001)(38100700002)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzRDV0Ezc0tkd2dDWlhBT0pjQURhcExhbjYzc01jQ0ZGekZ1dzJtY3I2L0Zu?=
 =?utf-8?B?azY0dGdtTmFXSzd2Qng3NGxPcnJydFppaDhISVBRZ0xybThWSWNnUnNhTGRR?=
 =?utf-8?B?ZlljUUxnaUhwSnd5S2VvZTg2d0lMdTlsVG1XcW9yTUx6R29rTUVtRXhxd1RZ?=
 =?utf-8?B?TTBHTXQ3UlkvZEYvaFdKNmFESUliVDQvMXVWQ1BiOElNWUdXNElacnR4OThp?=
 =?utf-8?B?eXpCU2k4UWVqckdYT1RPYUs3dUpobUJnY29GaFZOUVhHWjB4eE82UTJPWUVB?=
 =?utf-8?B?Ynh0WVMwZFMzNjV0NnoyKzVWSmVwR1FmZkFaUTlTSzJxSGlCVmxjV0s1TUE1?=
 =?utf-8?B?YnpRS2N2cmg2eEJEclc1RWtkY1hnTk94UWNSRDA1djdVVEwvSjJRWmpKWUJV?=
 =?utf-8?B?K0c0bmRPeDdrbjBLbmJ3SGRkbDVqYVZLK2J4S2haV0NOVjVYVzNwZVdmWllw?=
 =?utf-8?B?ME01R2lyTWJQeE15d2twcEpvTWkxdzVOVk9kNnl1Zmc2aXJ1R0VML2lDNmIy?=
 =?utf-8?B?WERYbGprZG1GcnppN3FUM2pRVjFKekN0aU1OT2lXOVpseEpQazRobEVqckNF?=
 =?utf-8?B?ZzlyR2VtV01ROG1kVGU4emlEaTlIc1Q0Sm4reUgySzZPclZQcGdzUDQ5UC9i?=
 =?utf-8?B?VzJtZTA2YW9zNGdyc3B5SndySCtaNytKSDg2U3R1Uk1jSis0QlovTytaQXBK?=
 =?utf-8?B?VU9qT0l2akMzYUVCOVl6blN1YnlYTkVlOG94dkFOWmdQR0cxVUtXY1hJZzhZ?=
 =?utf-8?B?VVgya0NBVmFLSWNYTk80NkhJbE5NZkltMUUyNFdjUnA4TE02djdvb1poc2ZY?=
 =?utf-8?B?ZkpCaG1jRmVxS3JBQld1Ny9DZ0lIUXJmUzVnRzdHd2FhYWRiSCs1OHNuOVky?=
 =?utf-8?B?RHo2bjh5K1ZCVW0zOHAyVmR5WkFpdTJDc28xN0ROelhJckNienVxNkpYVzN5?=
 =?utf-8?B?cjdaZVRmeEZVbFUwVFgrTDN2Rk9jU0E3dnR6ajlDR1RJWjhCYkxFbFZMcWdC?=
 =?utf-8?B?YkpWVkVDOEVVYm5DY3BxVllRalgrSEJlMFNHNElyVGRmL2NvM2dmZnpHN2Ri?=
 =?utf-8?B?anFNQS9tQ3VpcWFYVUE2MXo1aGFIVFdKeWJNQ25VNndSWVEyZTJIQTNua1Mx?=
 =?utf-8?B?OUZjdXJlQVdENzFkL1l6RG80VDlhUEJuOTdTNC9RUnFPdk42S0p2Sms4Wk1D?=
 =?utf-8?B?T1RnZ0d1UXBSMGxTMHFtVytqaHkrMDRuTDdFMEVBQStQcHZIeDRlOXBiZk5L?=
 =?utf-8?B?U0xpM1FvUVN5dTZZQ3BWUGJSSWVwblVrQ3NzdkxNRHJucGRMV01pQWZhcU5o?=
 =?utf-8?B?ZVFjeWxEbmZ3NHl3NFNEa1ROYWphMzR0am12VTFET2VXaCtJTUF5UDZWeW0y?=
 =?utf-8?B?MEVNUGJ1WGFuNFBHNXRyZ1VLS2RKS2RjbXM4OFEvQUNRVW9uRTRPK1NEdW0x?=
 =?utf-8?B?MFJ3OGJBWTlyRWVSaEU2aWRxVlEwaTNVN1lEZDRmSWswajhVYkNlUW5XaElU?=
 =?utf-8?B?dHZ3UklCRlBMbDZTK0pkQklSQkszRXZxNTRvdHdacVFjQ0pQK1E3VEdYUnVW?=
 =?utf-8?B?R2pmbWhKWGUreHFIRFJKMUZhZFdYNVVEcngyYkxEOXptM0I0dzI1bmFxY2Ra?=
 =?utf-8?B?L0gyM0xpckJRLzd2VFgzQTQvR0RFOVpnamhUYnoyWWZDdHZ5U3RJZUJlWmZ5?=
 =?utf-8?B?MXpIK3R1OTNHdUh4SkZFSnhsdjB0TUVrSnNMYXJQWjIvWENHWUNlMjF2MkR1?=
 =?utf-8?B?azQ4dG5NZFl1Z0xXa3dVTTlXSEhtU1lGV0NSbmFNODdQTDJpRWtkV2w0U2d2?=
 =?utf-8?B?RXhxUWYvZkk5MU5TcWJwK3pKMVkrMEZZUEtodUhkdU5WMWcveGZEc3R6RDRk?=
 =?utf-8?B?SGVSTG55cVFEWU1qZ2hRUjBkVlp6Y3d4cXp5M1FDeW5LeS9VT0gwVmdrMFFm?=
 =?utf-8?B?V3kvQkVVaE9xOHR1ejI2OXNQazRuWXN5T1F6TXQybjFvTytSMW8xb0VRVlZ0?=
 =?utf-8?B?ejY3WUFWb2dEVUpzRHZZZE9OZFVDUEw4bERGWW5ENVVNVmZGeGFIQ0QydGxF?=
 =?utf-8?B?eUNESm9HdXN0L1ExYzBLRDkrTkZ1eWtQTzlXdUFQWEFNVFY3Z1drenRmRUl2?=
 =?utf-8?B?TFRlK0xNOE90UjZsS0xmZTJvZkUzKytwUFM0am1IazQ5SHFkMmJYQlI0cW10?=
 =?utf-8?Q?PrSj3Wt7LNOZSQKz66J7Oug=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?cGZaK2psNGxYRGVIbk5XY2o3MXp0dW8wZStuTGpVeTNFMGVlU3NTUjg3SjFL?=
 =?utf-8?B?a0cyMVJMSS9zWVNVbGdvQU1ORC9GaitBbjNvbjllZzZvdmZ5U0RsSTgrSitL?=
 =?utf-8?B?djdybDNDZW9FMXcvQ3hyUXIxTiszWE9HUUh2UnZJQWZSbVdlbVBraG00TEhN?=
 =?utf-8?B?cjdUczNEeUVZWnB4U2hmdGhXWWQ0UWxjZE9GYStCeGtCSFVmbWJhMGZEaTMv?=
 =?utf-8?B?QmRVa3BueWhJajB0aXNZNnV1TXY0cVFGZzFKOUV6STFxV1BGci9ZalRYSWZw?=
 =?utf-8?B?M2hHL2w1b3RWcGsvNHZyRnJxamFJejBjb2RHMFBFb0Fsb1lqYzd0cFVralNn?=
 =?utf-8?B?Vk13eEowbFBlSTJBcGhXY2lXQWxNVUE4dTBLU1ZNOWVyM09FaXB2OFBjc0JD?=
 =?utf-8?B?RUdOQ2J4MVp2OUNIV3YwVkRLMjRzSXVQTS85cCtuTUU2cFVuTEV4ZmwzWkxk?=
 =?utf-8?B?dk1GaTNQZUw5NERSTVdaSUNEREVnU0g3cGJmRHdWcGVwVkI4NUZHVnI0eGdm?=
 =?utf-8?B?TWRGREpONFJ2TG5VeXU3aVVTTGU2bFlQdVpZZEU5MHVxMUUwSm5yell1UEly?=
 =?utf-8?B?bXFqVXIweENudktBT29uMHo1QU1GajFjSEZPV3N6c2NHVVc0WGNONTRQek5P?=
 =?utf-8?B?d2Q1NTVwZEJRVGdWb1NsTmtSNjlHTTFJT24zcW1VRElBUUR0QllRQW1Obmk2?=
 =?utf-8?B?c0J6Y2UrcU5JZDVWaCtLRVliZ2JPZ0xnUEpRV3lZMXc4OTNHRlR5bnB0NGdX?=
 =?utf-8?B?Q2w3M01KZVppYVplcmRUVjNXb3Jvc25IYWRXSVpKb09SSE5mejZGSHdSaHV2?=
 =?utf-8?B?b3N4NGErREROUWx4blVaU3NoRGFrZFJjbk1kbk1TSm5uQjBoWEdYcXIyandP?=
 =?utf-8?B?TWlVeG5rZXJETTBvY3c4ZjVtN0hCWkJ1a09jaGhtMW9DM1ZYZEFHUWJKcnU3?=
 =?utf-8?B?c05pSVNPdnlyRXdqV0J2WEJnRXVVbTZOVmFXMzdFRUxWZC95dXFRTlk5SThP?=
 =?utf-8?B?V0tBZjY0UXd3Y0hSZ0F0czBxbjdoRGxFQU9sSjRNbmtvNUsyeG8wUkYrTFdT?=
 =?utf-8?B?ZEgxTm5HUnBUQkk4R09tazNxMWFBWVpwZk9qbTFoUTIvU0s5VllGa1hsRXJL?=
 =?utf-8?B?a1VLSmRqYWlXSTRQQ085cU01L1RQQzE5SndIeVlxY3pFRTF6S0lZazRZbHlY?=
 =?utf-8?B?aG9yTE5vWktyVElITGdieHJ4UmJPT0VTYWhzNzc3RTBNa0VXZERCUWc4SVFU?=
 =?utf-8?B?UGNjSW5sdldrUFhIbUtHc3F3TUorYXBRZUMxeDZ3ejdwT0tKdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4651bf07-a284-45b8-a351-08db943c3bc5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 16:11:02.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh4id8Ga9dH2ZMjfFPG9z3tK4dvCvnqHH+6IOXL+avQSnupoVmdAWsFi1ZhIIDt3lqXK45RoZT2GcqNj95hwxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030145
X-Proofpoint-GUID: mDgl1t8LjrX-o769adopz2gjjPz8cTve
X-Proofpoint-ORIG-GUID: mDgl1t8LjrX-o769adopz2gjjPz8cTve
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/08/2023 16:22, Yonghong Song wrote:
> 
> 
> On 8/3/23 1:21 AM, Alan Maguire wrote:
>> On 02/08/2023 17:33, Alexei Starovoitov wrote:
>>> On Tue, Aug 1, 2023 at 8:30 PM David Vernet <void@manifault.com> wrote:
>>>> I agree that this is the correct way to generalize this. The only thing
>>>> that we'll have to figure out is how to generalize treating const
>>>> struct
>>>> cpumask * objects as kptrs. In sched_ext [0] we export
>>>> scx_bpf_get_idle_cpumask() and scx_bpf_get_idle_smtmask() kfuncs to
>>>> return trusted global cpumask kptrs that can then be "released" in
>>>> scx_bpf_put_idle_cpumask(). scx_bpf_put_idle_cpumask() is empty and
>>>> exists only to appease the verifier that the trusted cpumask kptrs
>>>> aren't being leaked and are having their references "dropped".
>>>
>>> why is it KF_ACQUIRE ?
>>> I think it can just return a trusted pointer without acquire.
>>>
>>>> [0]:
>>>> https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>>>
>>>> I'd imagine that we have 2 ways forward if we want to enable progs to
>>>> fetch other global cpumasks with static lifetimes (e.g.
>>>> __cpu_possible_mask or nohz.idle_cpus_mask):
>>>>
>>>> 1. The most straightforward thing to do would be to add a new kfunc in
>>>>     kernel/bpf/cpumask.c that's a drop-in replacment for
>>>>     scx_bpf_put_idle_cpumask():
>>>>
>>>> void bpf_global_cpumask_drop(const struct cpumask *cpumask)
>>>> {}
>>>>
>>>> 2. Another would be to implement something resembling what Yonghong
>>>>     suggested in [1], where progs can link against global allocated
>>>> kptrs
>>>>     like:
>>>>
>>>> const struct cpumask *__cpu_possible_mask __ksym;
>>>>
>>>> [1]:
>>>> https://lore.kernel.org/all/3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev/#t
>>>>
>>>> In my opinion (1) is more straightforward, (2) is a better UX.
>>>
>>> 1 = adding few kfuncs.
>>> 2 = teaching pahole to emit certain global vars.
>>>
>>> nm vmlinux|g -w D|g -v __SCK_|g -v __tracepoint_|wc -l
>>> 1998
>>>
>>> imo BTF increase trade off is acceptable.
>>
>> Agreed, Stephen's numbers on BTF size increase were pretty modest [1].
>>
>> What was gating that work in my mind was previous discussion around
>> splitting aspects of BTF into a "vmlinux-extra". Experiments with this
>> seemed to show it's hard to support, and worse, tooling would have to
>> learn about its existence. We have to come up with a CONFIG convention
>> about specifying what ends up in -extra versus core vmlinux BTF, what do
>> we do about modules, etc. All feels like over-complication.
>>
>> I think a better path would be to support BTF in a vmlinux BTF module
>> (controlled by making CONFIG_DEBUG_INFO_BTF tristate). The module is
>> separately loadable, but puts vmlinux in the same place for tools -
>> /sys/kernel/btf/vmlinux. That solves already-existing issues of BTF size
>> for embedded use cases that have come up a few times, and lessens
>> concerns about BTF size for other users, while it all works with
>> existing tooling. I have a basic proof-of-concept but it will take time
>> to hammer into shape.
>>
>> Because variable-related size increases are pretty modest, so should we
>> proceed with the BTF variable support anyway? We can modularize BTF
>> separately later on for those concerned about BTF size.
> 
> Alan, it seems a consensus has reached that we should include
> global variables (excluding special kernel made ones like
> __SCK_ and __tracepoint_) in vmlinux BTF.
> please go ahead and propose a patch. Thanks!
>

Sounds good! Stephen and I will hopefully have something ready soon;
the changes are mostly in dwarves plus a kernel selftest. And
good idea on the filtering; this will eliminate a lot of unneeded
variables and cut down on size overheads. Thanks!

Alan

>>
>> [1]
>> https://lore.kernel.org/bpf/20221104231103.752040-1-stephen.s.brennan@oracle.com/

