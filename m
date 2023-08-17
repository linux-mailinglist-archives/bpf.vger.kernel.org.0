Return-Path: <bpf+bounces-8010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AED77FD82
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F52282137
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36127174D2;
	Thu, 17 Aug 2023 18:06:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB2171BB
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 18:06:18 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB00F19A1
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 11:06:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HI4qvI032692;
	Thu, 17 Aug 2023 18:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FKcMxV0rwh1v6gIfI505K/U5vXWcWgymzzUyn3MAX/M=;
 b=zjRPv7Y0Fs7vdoKCtG9IN/j6NqLN7n4/ZtBjjLNvT5NDsi5BFt/x9NrXkLM1GPGt9l31
 Zn4MUldf+Py/Ddy2i30Uc8uotZVFsrUhzRkgzdj1JFAlxlFO3dYIihDhXTdeBTsiB0WR
 sO00qvMxcJIgWNd9GHgGqp20oyrSQtnFastOXn3Znx5B2lbBSikJGkaWbkO38tqAq27b
 wS1z5ApPngkc2jZt3lS42WhBsLFNQSKeHolQHIVxKyJjq9Arh4n3Nan8TK1rlzSK5ZdN
 fuB+0QiKD27MmDX4wdlMvc8rUav9XLiqfTQVu+iYdhsmFJRzyXWK4/NV14h8aWkTB/qD KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w6274k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Aug 2023 18:06:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HHqJRv003706;
	Thu, 17 Aug 2023 18:06:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexymy69u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Aug 2023 18:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH3BVxn5LVv4F4Lpida7PfWDe0Y/3u02aBSMwDZGix5YUdj21skESuGdHSkaHw9mKIJu6VhYo6hnveNfbZLURmLbCFYi/j5vS4UzelGUePGX2WkBv++fCrfA8iIsxZ4iojzLFavGjLGjK+PNqxVSfrU/MNaYMrWOzOIvNgAMM0JCM4qIFm7pWuWA0oIiNW9aLQjdyN/MpspGzCN3DjrVD11Rajwmtm8qjAMTtjcTRjgU5r2kfeAoRWN/Zxog3dx3yC6edCd8JOtsJnZIpeED08HkZMGas+4khi8uBSDLlO8yHA/F2hrfMB2B45I47b1VtD3jMmD9hJK7Pu9FHRHi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKcMxV0rwh1v6gIfI505K/U5vXWcWgymzzUyn3MAX/M=;
 b=eW1EJVlTf5KciGhwyUeeBUGVL8CZqljB8XBW9oy84fcouJHdv40EozLerL+VKOHIss9okbrYEHRXO5yGciPWRiHBF6b1DKBrHKo2xLgy2XZdjGcIBnmkDkvmdQvD7WPapz0Y06rBa9WhU3oPcPOnd0L7NS/wbFv4QrU6sGHbw7e6ZGdBtICQ06okuLStCyky6zQTBxJVQbYvSCUIPwTWGrxPZhCSuTqYEtNxmvHkyaeJVMuMTVokPC7HBc2pfaNEimLNe4WK1wR66ztplIpW66igySSFeSpVV1wjiPDcTEqbuwoPtRpHwsI+BuetO9Ya9bmPOuiPZ+aY2ly0F1jjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKcMxV0rwh1v6gIfI505K/U5vXWcWgymzzUyn3MAX/M=;
 b=Klevgz+q0anhLYbIahp2ilpBLK+ME4OkRwEaPsK7gyNw3bQIMqP+QAEtscrt0b5fvN0SpfwHWtrW881MNJIbOr3FdYRZ3FGYV8MoouV/kKNKXnP7tUZK8e4y/RHLh3VdUfOIJsjKBw19dq7FhjPrhRkC3YGAedzzXayRbCl+4Ts=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB5104.namprd10.prod.outlook.com (2603:10b6:5:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:06:11 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f%5]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 18:06:11 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: Masks and overflow of signed immediates in BPF instructions
In-Reply-To: <73c939b9-a06b-ee02-f260-39fade8ac1b6@linux.dev> (Yonghong Song's
	message of "Thu, 17 Aug 2023 10:44:24 -0700")
References: <877cpwgzgh.fsf@oracle.com>
	<ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev>
	<87leec44v1.fsf@oracle.com> <87wmxv2ut4.fsf@oracle.com>
	<bbd86b4e-89ea-8e60-883e-f348117483b4@linux.dev>
	<878raa14rc.fsf@oracle.com>
	<92974205-730f-4815-1eda-f8ee8217d8dc@linux.dev>
	<83e093b1-97ec-14e3-56ee-8258eea66709@linux.dev>
	<87o7j5wox2.fsf@oracle.com>
	<73c939b9-a06b-ee02-f260-39fade8ac1b6@linux.dev>
Date: Thu, 17 Aug 2023 20:06:05 +0200
Message-ID: <87edk1wnle.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0385.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3aa801-79ed-4fdd-4e4e-08db9f4ca351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S3T2PRhaEEE50UdJLc8x9gOBZk+CcH0DazCFdB23g7AB8+0ZBITDOT2V4gm0M45XqZTR1mpbPzwcqUanCJ5cUGJJ843DN5jZTESTH1oQT9yVBW9kYh6vUAe1r4dmj2kP4Vg3T1hWr2HWuSOm0s9UG+vzT/drw6Y/aoMWmEfPefgJP9MztDuLhsrrLC9hb5TVZPcFUuBBqX90Z9H2GJzZqEOb6PfGelyXF+jZgijj1qKWkERju4WibJZSkZ36tNa2AUjq8HaWq8a8BbgwlaUqEb6MZA0c9zOPU8T8jB9z2CC80Zn8VVgVJtT8UHnYnUrJJdzW9V4WjIaUAonGcdo+gpkjow4tkg6iwXYouzHePLr/dU90B/GlarRPJc5rpKSv4kwNhc8LnWolqiIfFmZcMW43fR495WSKl6fYPla6LvPe2+L/8KDRay4a98s+XK/+6KbEVYzCyPo56Qb33gFd50+jZUlck29NleTDJ8tI7ZQQ0xuvztE5jT9G7XwQ9IjpfpeTr6fUzWnytSi3yZDu299XL7rYITaitDBjqhrCwymB2y+flXGO5dnO8baoItjI2yBsK9pcR2ZrgL+oEolrooK7jWFnaS6+UquuUEnCrG0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(83380400001)(2906002)(66556008)(66476007)(478600001)(6916009)(66946007)(6666004)(316002)(6486002)(53546011)(6506007)(2616005)(5660300002)(107886003)(6512007)(8676002)(8936002)(41300700001)(4326008)(26005)(36756003)(86362001)(38100700002)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXEvL2tNVTNmUm1uVmdZRE13all6NmhuTHVTQjVtTXJxRjhvRlBFTWpOQml2?=
 =?utf-8?B?Q2Q3dHBXY2tsbkhuVVNaNnk5RVhKTHNUM01OSVVpVmNNRlV2RjJ0blBRcjNO?=
 =?utf-8?B?TGtkZGVVWEFpb1VEZUoyTkk3L2R4NkdVVWMzelpPVXR0NEZ2Q0JHcEpSK3cr?=
 =?utf-8?B?MGZnSCtNWU9iNWVKK1VrR2NHeVpiKzdld2NqRVk4MVZESjVDSmhzWEpkZlhN?=
 =?utf-8?B?Z05VUVBMS3pDNXRtWXdXQU1iai90aU1HdWxPR2JsbGtMT3dPTHBvT3FpMDZ2?=
 =?utf-8?B?blgyeVhIbXZlM0FjR01UNmZqcU9GQkJOcWg5RnRCWVVKcEZhc2phVnliTWdK?=
 =?utf-8?B?N04wUHFoWFlKcjZrNXBvTDNpd1hFVXFQcXVIRXgyWXd2NXJkQ0ZBNjJOT0Fl?=
 =?utf-8?B?ZEUrSTVMbmJxUU9vWEJpV09DSjFtS1BzdTRsVE1yeHI5Mm5pNnVMVklVQWtx?=
 =?utf-8?B?YTRHTk44UVQzV2JxcUg1Nk1ldnJ1L0xIWVl6TEdVMXFEZ1ZQd3k5bWRFNk04?=
 =?utf-8?B?ZjhSaG9UTUVPNjZjb0dFSWxyQTNKeURXcmFKL0doNjhIZUxUNml0YjVmd0ZM?=
 =?utf-8?B?akdXZmV0OUZ3RVJkblluOWZmbXhEcHkwNUxycS9aMHRzMWhsS0l0bnNkc2M1?=
 =?utf-8?B?SHdjNlg4L1J1SUNFWXlZb3o5RFhMTEp1ckszcnJVa0hxSjdQS2ZjWmYxVFQ5?=
 =?utf-8?B?NEgvT0dTM1JSa3pjM1dNTEwwYThlQ1VJSTNmSE5TS0VCT1FZNFIzaFFMSEJj?=
 =?utf-8?B?LzV5YllUMjdGTjYycUhDazFwMWZtYWNLUk5IcXJseCszcU9Fc3VvcHlTV0tH?=
 =?utf-8?B?Zm9Oa0tVcHgxR1RjOU5ZOExDQU5ySFBqNEhPWUM1YnVLenNnVVh4T0wwUTU5?=
 =?utf-8?B?WC9iU1Bib3crazBrU0NjUHlxVGcvalE1Uk5adFAyTWRJUTMvTVRPQnV0bFlQ?=
 =?utf-8?B?V2ZPdTBlcnNBKzU5NXFycjRVb1dJTWRkSHd6MlIrTmZ0Slh1di9nNEY5K3ZR?=
 =?utf-8?B?MFlRVWZ4Njd2YU5qMGtGZldGUmFBV1lGSWQvRVV4eWQwWENmak1lSWl4ZE9r?=
 =?utf-8?B?WjRDTDN2aUdGQnRXSTVPTWxzSHFzRFdWaXkxa2VwdGZDb3JETkM2MWlZNk9G?=
 =?utf-8?B?dTFrNTNIYmU2bnpVMTVrYjRnSVNJMVZGc2xxVk03QzNPTjU0aUJFOWpaZHA5?=
 =?utf-8?B?eE9iN2tnQlc2WEtSU0RhOW1Fd0FrdkEyNTk5N1RVUTFrNEptd2dxYXc3Y0ND?=
 =?utf-8?B?d3BlMndLYmdlVkVsZytVLy9yZzdmaENDcTF4dFIyNUtWOENwRlZ5dHlpL21h?=
 =?utf-8?B?OTdmNWpTeW9WcWJzUHEwdy9UNk9xdzdBZXErdzJQNUxaSGNIU2M3VjlzaE5D?=
 =?utf-8?B?K1pTWFlXbEQ3NnR2OWRrMCtKREhDZHltQ0NBWW5iWmltajRNLzBWZlFSMThq?=
 =?utf-8?B?WTBDMkRBNUpqZnNTMGxjRUN3T3hteXJFbmJjOXR2TnJOemtGZVNDZEVGSFow?=
 =?utf-8?B?d0xiREEwYXd2QnRmNEpjRkpYNHRaeFhoZ1lDdjNScXFUQXQ2Qittbm5NTXJF?=
 =?utf-8?B?RnFEUkw4L0Nwd1hXWmFNMDFKZzE4ZFNiTStnOTJFYkFsSGxybi8zTGFmakxD?=
 =?utf-8?B?NTBNWnpKYnpQcEZ5M2UydVZ1ZmFuZktSR1VIVTYvbU9ZK1p2cXZhaExINEhW?=
 =?utf-8?B?TkhKb05rRnFaemNxSUxVRGUvMGlYbGlrajZzbDlxTmVsazQxK1RVZVFMZHBu?=
 =?utf-8?B?dTZTdlFBU3JjNnh3RXp2MUlEaWRsZzh2ME1veXZ4VFByd2lxbjR1aDZia2Z0?=
 =?utf-8?B?WFNQOHRFNUpLalUzbVFjQWVpdmlVeml1VktkSjlhdmdsZUkzVnFSbkorbytu?=
 =?utf-8?B?eUdvTHNhMWFGYmVzc2xDZ0x1UHJlVGc1ZlRZT21ZMUpVMFgzeGgzUFRZVHND?=
 =?utf-8?B?V1EvU0lGQWVrcXJlUjJpWU9vQTg3V1FVVGw3eStoMXdVK1BNZjF3anVGMndt?=
 =?utf-8?B?YWlhSDR5aENCU3VCNzV5N2NTSDB2eHVlZXRpbHB0a0JpZXZLSGI3dVk1cnpR?=
 =?utf-8?B?bFBQV3lXeEFidDFtMUFKaTBIV09QaXV1T0xQVGVia3hrV3NhUUJidVJHMmJr?=
 =?utf-8?B?bzhSOGhNUTZhRHNvWFRKb2FhMkxKdUJvU1VTUGh3akZ0OEw1ZFUvRWlmbXJw?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	12cEHlSTOYFoFq9JwVBZALqovm9BZwlz1mcGwNAY/ayTUD+fx5jBNkMPn8RIFxcrfRzwxGpzQXuXTX1ZKZR+7ROHuRG4SV55yHo0idMTFvMymur+foanhz7GKQjvCm/B5dkwR+AbJPO0eVysylp6TAaML6TLpX6neM60KV667yD22dBSTNp9U46/uzRvxERh1LrSD00oV/89gtM35BvZeVAtSqwbVlRPQ/pINspYB8ZSHFqAZztOi/dvU8Z9gGCu0nC7QAOPyFoktUekenyRli26KmPfDwgwq1nmRDiI9SkzITxLu5QdVbfnu/HxunNiLrmyCLkNTvAd27PpSs9wO6OsMDikzLHU4T7Hf7g54ReGf53sbgOx+3x/o/vnwXXtF7Tobggbjq7hgF01Q9d7g18NCPmdz2L8xofl0gKR2jlHUSfmEMYKS02NivCwlJR/py5O0/HDARAkaoMPpHJiEgDyjddrBciBUcf/dhDVKoKi4YgVYA2Qrd+FVUgPoL71U9ZZk5aHX4S8PXNnWNiUwINCpQQBYLQl5DDEexOCkTgyulVSg7JdPBcwfkOhniYoi+dPGqJatQxA4BjupKr5WX92x8IS0F1XD0X+mf/nXhj5LlDx/Py3cSKQxsSzb7hCGs3xP8gBay1E5mzaGcBaPVC7R43WyP43l+GmmBR31mwKwMkNtPM0WvR3UMQXltGwvb0nSmYqGCX5maQQuNMvv5CpzmOAqsTc8vUyvqd3Hre0PeIkJpkiRz0I6eRvJ5wbuyw1aNIs4DK3mua8AfT8e5PU7hJF8+bSFErsVW/rIxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3aa801-79ed-4fdd-4e4e-08db9f4ca351
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:06:11.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyjIw6mZoIb7tDteXqPO+xem83vOL9y9AjY0TlTTPB7p3OIlIOElR/PPTjUE4SW+XkdhxvZhydo3k8ltrVwzobQ0p0nYZPxWLay3/dZkydI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_13,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=944 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170163
X-Proofpoint-ORIG-GUID: 49gIbvIkw280DZE0wPgc9f0_NayXqYBM
X-Proofpoint-GUID: 49gIbvIkw280DZE0wPgc9f0_NayXqYBM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 8/17/23 10:37 AM, Jose E. Marchesi wrote:
>>=20
>>> On 8/17/23 9:23 AM, Yonghong Song wrote:
>>>> On 8/17/23 1:01 AM, Jose E. Marchesi wrote:
>>>>>
>>>>>> [...]
>>>>>> In llvm, for inline asm, 0xfffffffe, 4294967294 and -2 have the same
>>>>>> 4-byte bit-wise encoding, so they will be all encoded the same
>>>>>> 0xfffffffe in the actual insn.
>>>>>>
>>>>>> The following is an example for x86 target in llvm:
>>>>>>
>>>>>> $ cat t.c
>>>>>> int foo() {
>>>>>>  =C2=A0=C2=A0 int a, b;
>>>>>>
>>>>>>  =C2=A0=C2=A0 asm volatile("movl $0xfffffffe, %0" : "=3Dr"(a) :);
>>>>>>  =C2=A0=C2=A0 asm volatile("movl $-2, %0" : "=3Dr"(b) :);
>>>>>>  =C2=A0=C2=A0 return a + b;
>>>>>> }
>>>>>> $ clang -O2 -c t.c
>>>>>> $ llvm-objdump -d t.o
>>>>>>
>>>>>> t.o:=C2=A0=C2=A0=C2=A0 file format elf64-x86-64
>>>>>>
>>>>>> Disassembly of section .text:
>>>>>>
>>>>>> 0000000000000000 <foo>:
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: b9 fe ff ff ff=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 movl=C2=A0=C2=A0=C2=A0 $0xfffffffe, %ecx #
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D 0xFFFFFFFE
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5: b8 fe ff ff ff=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 movl=C2=A0=C2=A0=C2=A0 $0xfffffffe, %eax #
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm =3D 0xFFFFFFFE
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a: 01 c8=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addl=C2=A0=C2=A0=C2=
=A0 %ecx, %eax
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c: c3=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retq
>>>>>> $
>>>>>>
>>>>>> Whether it is 0xfffffffe or -2, the insn encoding is the same
>>>>>> and disasm prints out 0xfffffffe.
>>>>>
>>>>> Thanks for the explanation.
>>>>>
>>>>> I have pushed the commit below to binutils that makes GAS match the l=
lvm
>>>>> assembler behavior regarding constant immediates.=C2=A0 With this pat=
ch there
>>>>> are no more assembler errors when building the kernel bpf selftests.
>>>> Great! Thanks.
>>>>
>>>>>
>>>>> Note however that there is one pending divergence in the behavior of
>>>>> both assemblers when facing invalid programs where immediate operands
>>>>> cannot be represented in the number of bits of the field like in:
>>>>>
>>>>>  =C2=A0=C2=A0 $ cat foo.s
>>>>>  =C2=A0=C2=A0 if r1 > r2 goto 0x3fff1
>>>>>
>>>>> llvm silently truncates it to 16-bit:
>>>>>
>>>>>  =C2=A0=C2=A0 $ clang -target bpf foo.s
>>>>>  =C2=A0=C2=A0 $ bpf-unkonwn-none-objdump -M pseudoc -dr foo.o
>>>>>  =C2=A0=C2=A0 0000000000000000 <.text>:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 2d 21 f1 ff 00 0=
0 00 00=C2=A0=C2=A0=C2=A0=C2=A0 if r1>r2 goto -15
>>>>>
>>>>> GAS emits an error instead:
>>>>>
>>>>>  =C2=A0=C2=A0 $ as -mdialect=3Dpseudoc foo.s
>>>>>  =C2=A0=C2=A0 foo.s: Assembler messages:
>>>>>  =C2=A0=C2=A0 foo.s:1: Error: pc-relative offset out of range, shall =
fit in 16 bits.
>>>>>
>>>>> (The same happens with 32-bit immediates.)
>>>>>
>>>>> We think the error is pertinent, and we recommend the llvm assembler =
to
>>>>> behave the same way.
>>>> Thanks! We will take a look at this issue soon.
>>>
>>> A patch like below can issue the warning for the above case:
>>>
>>> diff --git a/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
>>> b/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
>>> index 420a2aad480a..fca6bf30fb4b 100644
>>> --- a/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
>>> +++ b/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
>>> @@ -136,6 +136,12 @@ void BPFMCCodeEmitter::encodeInstruction(const
>>> MCInst &MI,
>>>       OSE.write<uint16_t>(0);
>>>       OSE.write<uint32_t>(Imm >> 32);
>>>     } else {
>>> +    if (Opcode =3D=3D BPF::JUGT_rr) {
>>> +      const MCOperand &MO =3D MI.getOperand(2);
>>> +      int64_t Imm =3D MO.isImm() ? MO.getImm() : 0;
>>> +      if (Imm > INT16_MAX || Imm < INT16_MIN)
>> Shouldn't that be:
>>    if (Imm > UINT16_MAX || Imm < INT16_MIN)
>
> The number 'Imm' represents true offset (positive or negative)
> as represented in .s file.
> So positive offset 0xfffffffe cannot be presented.
> The encoding in insn with 0xfffffffe actually means -2.

Oh ok, so thats the value already encoded :)

>> ?
>>=20
>>> +        report_fatal_error("Branch target out of insn range");
>>> +    }
>>>       // Get instruction encoding and emit it
>>>       uint64_t Value =3D getBinaryCodeForInstr(MI, Fixups, STI);
>>>       CB.push_back(Value >> 56);
>>>
>>> Need to generalize to other related conditional/unconditional
>>> operands. Will have a formal patch for llvm soon.
>>>
>>> Thanks.
>>=20

