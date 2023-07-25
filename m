Return-Path: <bpf+bounces-5834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215AC761AEB
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C3B1C20E27
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E2200CE;
	Tue, 25 Jul 2023 14:05:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DAA200C5
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 14:05:02 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A131FF5
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:04:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7ocVM017262;
	Tue, 25 Jul 2023 14:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QfesY94VcK6UeaU/gsbn/GDgSv5z2xgh5OiFLDtmfUg=;
 b=EV9QnGC31j4TDBt0MQGhQ/MNHeEcIyBpLfgwwDVwLegvOqQ7vbMo/99yoAkl6y101xL3
 pLtqu2qu8mjkoh9xrp5gqiSN/iqdmIeldBmA62l+gSLv7VHVZWwQ5K3E1/t0SIxkV0Rl
 ruPE7JtVE1Y/WWl0daAQzLHZMzZUtUzZ8hDHlQf3OQZVi25tO+zMx6h/t9QzXI/qyY4T
 7+KV9gMLMb828SXZxV9sor7I8/RB/EAfn5A5yfxN0+i1wQh+PQICNA0WIuVToDTb/mgv
 psY6TSHhvAFdatTLnLZY5WbyGSZfWrRMp3W6FoSpYN6UC9Fa4d60XsuEDmT/toSulIyA AA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c56q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 14:04:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PDMgUs030382;
	Tue, 25 Jul 2023 14:04:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jb3baa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 14:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuSRNb+FJFsVlwwndd749hAHtJtINziBoTohazv+TAvPYGERO7oHXfFTahTQf0cjDIOXuSNaYevi208t0qt5dm0JGB5Ktz7qxOR1lKM0EjGF/okvJU4rSkKcott6PLoIn3YKNa3s1xDbgm00sMC2lmVHppgjAOQc5Qu3/A8sl5QDBArOAjQM+YFin9VQvdkfZT6drnmqiaIN2kin7bNN+HKjWCGM5yMd8bBzUDdgzBg4Gs4/CJkgtTMPRIl72aR/laCRM3GpnZfCo5nikhff1sx6thEZq9YEj6ybU/KEuYr2BQ+lO3N5d3HDYEmb05OaY8dPLtqH9dh0fPcqHbznHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfesY94VcK6UeaU/gsbn/GDgSv5z2xgh5OiFLDtmfUg=;
 b=ZBPnq5YitmCbZp0CqxSYOwdTNQxlLJF7sFqxmfE9ynQw5iy0PgnzEwnN4Qe8rkd21aMRIyt+cm3/8+jdYlCUTQEgATe815+hyhXwvMThHIWyBdIfA/xJbirIVRKCwlpT1eqwNWFOjuAQiz+8GcQAM8kcouRnVGSds2BJWFIUdBJewKn779fX0Z8WZZG09S+QnHgsNIbpe5sBiGTnrBj7qFUdahdTo7PN2yy7C9j+v9iwVT/PH/aVb6vuVeY7PHucSi7TDCWmVzK3nYglif5lQQYRviunjQJiMFCFUau3M764egZT7St6Kdvp8FhMNKnuV0KqwkoNUHz7rS0i7H32XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfesY94VcK6UeaU/gsbn/GDgSv5z2xgh5OiFLDtmfUg=;
 b=nkxYLE8wGLUVYZQzB6cLLo1ZJkN2Mw7kAanKQGTJ1D/+/N0crGh44D4GxiGbvpvHWODn9rD4PDnjVCs0uLg+e7Nq8XvEIQ3Ucl0VvPEH7vPGxKuGtE1Dbn09BGtICgW64sbFrnLNnMkD687ZMbq4E5zX7IMa6RgBmy6JGMLc91Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6897.namprd10.prod.outlook.com (2603:10b6:208:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 14:04:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.035; Tue, 25 Jul 2023
 14:04:52 +0000
Message-ID: <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
Date: Tue, 25 Jul 2023 15:04:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
To: Timofei Pushkin <pushkin.td@gmail.com>
Cc: bpf@vger.kernel.org
References: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
 <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
In-Reply-To: <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 40636c9a-4b9f-4b39-a5f2-08db8d181de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	We7l6Phz1oEEdQG4cuJrjxWY4NTMaEGYu0pKimY7Ns7r67aPeeElmRiCbaMW8W7tCqPJkSDlpQIY9txgWp6b6jDvo69L7fiYaqTfzWwmHVRc1l+I3mXI+7nyCzwKu86kcAKnrfVJcYcWGIyMnnA8pUbpzVxd3egFD1g9UInrZHkSept9rCwVRm6jx/sKcniIR1C+YJ7dIP4LTdbwARl2t10Eygqp839qkgW8/kss9OTN9SmPeS907FAXH8a6A9C0r+p7WzGr3goXBpIFeKKDNb4X7m/ZZXe2ZHWub64Ka5SyAPdkSBPMsrxEsDJmT7eKrK8IQSVgSW3bgYziUu8OeMJnTST1bAAQYiT1XHq/qJvec73+5qucF1zyFRwtd+A/uegHUcYrMH1dnnAhA1QBwHHn1tB/bpfds21qF+BC06VDO5ZD70wDA6QmgEPATQmKU0ox9Bmt47rjS8eIEGlqbvrjwPkMgd+ajKyUsMHE3jnhWE7FAbB0Y0usbzmAY+Hux8Ca5pqNO7+yo4G1kZrbldMQRerZMtxKc+GakO6MnL9NSTle51kpq6IhFvRCRSpGbfFFrTp7zvjQrnaq4d7oVvoNntIi/XigPNmh2dEtb2Bi/cJgnw2b1fgTxZwNCoOnAMeATSQ6n3B30j1/bUInyQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(6666004)(4326008)(2906002)(66946007)(66476007)(66556008)(6916009)(478600001)(6512007)(83380400001)(86362001)(6486002)(31696002)(36756003)(186003)(2616005)(6506007)(53546011)(38100700002)(41300700001)(8676002)(8936002)(31686004)(5660300002)(44832011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZDdSTDN0cS9QWThNazY4WlkzRjljVWk3dUdEaENJTnpLc3huTlEyd2JtUlp1?=
 =?utf-8?B?bTVkZ2NPbUtuRnAwVEozL1U1TFk5VUxTOTIwOFk1VUJtamcvYkh1cWFlWkNv?=
 =?utf-8?B?dGFBYTFJNG0vT1JSRlZDZzlsN0cxVC9hb1gwSGIzVGRHR3hrUjM4QUdQaGEr?=
 =?utf-8?B?ckdvSVFvVkdnS01lck02V2JzaVlETVdtUE1RZnZRaCsxWnJSUjR4bTIvNHlG?=
 =?utf-8?B?Qmp0RkdvSkZraVZ1amNaOHhaK1F4dWVnLzcxVHBRdnJRc1pKR1lrYW44bHlp?=
 =?utf-8?B?N3ZOaXBHTW41RDFWakJRQ1BCVXg4bW9OMHgzeDZ0cU9zeCs4SVFkcU14c3RP?=
 =?utf-8?B?Z0NaL3NsVmQ4VWNtWjBxOTE0UHJSLzEvZTB6bUg4bnBOMDgrRVpmK2krSnlZ?=
 =?utf-8?B?QkhlQ0xoNGNsZ1JrTjZTZDY1OHljSldwNmpYQm51OFlPOTZSQ1NDTXZYWndo?=
 =?utf-8?B?N1BjUGZqZDV2Nk9FeTQ3SlA5MmNkOFFWdnRFRS9BQzlaOGF2ZTN0bmZnL2xv?=
 =?utf-8?B?ZUppRUpkM1o5MFRzbE5IczB1ZmpURy9BR2lQYXhPbEoyVXA1MjJtUDcyMTVQ?=
 =?utf-8?B?REc2Slo3dUlSbDZUMkFqRjFGSzlNWk5Db3QycXhWNjdCdTFBRGN0b3lyQUdH?=
 =?utf-8?B?eVVraVFwZm13dHRvMlVVd3c0K2NmcUE2RHlCa2RQaSt2NEpndDZ5d05pQVQz?=
 =?utf-8?B?blNIbjdDcTRRZ1crbVlDcS9mSFJZK283aE1aVGtuUEpJMzV3emJ3NGgwcHpm?=
 =?utf-8?B?VVp2bTNSTmlIaFJiS3hkYnFrak9VTTN3VENJZDl1TnlEY2tWeXUrazB4bllP?=
 =?utf-8?B?azhQQytwNXRGM01EZVpCdzQ1T2NHSE5mbUZVaW5WRlJ4UTBYejQybEJvN21y?=
 =?utf-8?B?amkyUTZ6R1VkamNCZ00xRGNodHgzOHdzNENEUGFLV1hiVlZVLzhlY2tPaThi?=
 =?utf-8?B?bzJTN1lrUVg5S200NlNqamJUQmczRkRKRXhieHgxZHhqQXZzbHlOdkh4Q0ZI?=
 =?utf-8?B?ZXR2eVZib2JoalpCZXVPZ3dYN1RYaVJHdWFPYkZlM1JTdWRhaHI0ZEhpN2JP?=
 =?utf-8?B?dGtiZ3NDblNjSVpQVWhEVnpRRGMzZmNMK3hCTDNneWlsNjhSdXkxWUdHY3Bv?=
 =?utf-8?B?Si8wWk5NSkdaVnVhVGhwSEoxL3F1TURJaCtNUlllZGk3dHE4c0ZnTTJxN3NL?=
 =?utf-8?B?Mm01Qmk1bFhjRnZZZEYzdUZoMHkzdlNuSnVrejFUVjM3UVhqdzFqZm04cVF3?=
 =?utf-8?B?ZmZFZkJZZld1S3VhZ0k5VUgwK2Y3dHQ2K0d2Rmw3NnVISkVCU3ozWUJ2Wm45?=
 =?utf-8?B?WENVVCtPempsOFJ1V0F2ZzNHUGFBeTVidnNrVm9wYThTYk56ZFN6RUsyYUl6?=
 =?utf-8?B?SHQ0aEZMWHNBRXdiejhVcCtpOTdXc3ZJdjJKalNVS0p6bFkrY1BTQTd6RWRk?=
 =?utf-8?B?RjVjTHI4NHBGTFE4M1Q3eVhoMjdwNmdoVWtlMFpub2JFc2t6VGRVc2lCdzBC?=
 =?utf-8?B?RkJPVyt2WlRDTzFKTUNhcUNmRjZDeTB1YlQ4ME5oUk81Qlkxb2xGdXdya1o4?=
 =?utf-8?B?YTArTks3ekphbU9zaUZnV1ZnUEloZEpHMGxjazBxeUpRODFHam85ejZaVHdw?=
 =?utf-8?B?MXpsT1Z4OFMwZVN1c0JDZjZ5cEFGMFNIa1Y1MkJyZWo5Rmo2L2FsS1Bsa1B5?=
 =?utf-8?B?enJKcnZGbE5maDNiaEFsRGhJY213ZStNS0JwSENjSzdpc0p0TW9IcGVBSi82?=
 =?utf-8?B?Y2drSS9IaGFVZWZ6dnFiRGhjUk14L3k3VFppbVFIelFFWHhpOW55aURYSUVB?=
 =?utf-8?B?NVAvMzVNbmdRWVozRHFyWVdQWUdEUmJZdUlwbGp4SmthQmVWQzNCbHRrUnVn?=
 =?utf-8?B?OUhIckM1c3NLcmJaUzRXZTdVdDBwbGw5dVlzMlFLTGhyL1ltZ1g1aHk3RXly?=
 =?utf-8?B?aDBUVFprdkZjdmJSRE8vS0JBNDI3MmQvb0MwcmtOL2llSHFiZmtCNzZqcVdU?=
 =?utf-8?B?ajZQdldRUGMvbENBNTBBT0dlZmptdDVPajNydHBuOXNaY3ArME13NWpkR3NT?=
 =?utf-8?B?cVFHU2F3bFQybFpYN2IxU3FmOTc0RzlWZ3M4TmVsbWpGdyt0WHhNZ1BabUZk?=
 =?utf-8?B?TzBCb3dEMkFNOG84aExQYVJiRlFEWmV1Qno3UHIwQytUUmRJMEZGOGh5bzBr?=
 =?utf-8?Q?YHprV9+H8rhIVzKZr0wYteM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XgUoMY0zcACl7wRidsk4y0vAk2WjKcghE1x9nIHNGQ3MU5bIQVklVDK0S50LulBtSV/qucOMF/vwtSFSD2Bfwt6QIpsgsZ9rV0Hf35pQlBAu9tag/KSrEVKNPknLzIoZ+2+4OqpmuT1p4MjZc3tpSua41bV9a8UKAI96g36uNyddxdBE+KFLCUqoWiuNK+D+oup9FZVHyW5QAuYYSaf/TTcv1kCge1ktzuESvI3Xe+RA+av673iiLdNY3zHfh/EbnA/ZnJNGVEc5gtnIdP7goqE6GArvl/C8WK+DB+G5dztLm8BgXqFbOimLMhCucssi0vTQmGMdX40rVSvcIduMbzNK8sjvULcE22T2DOBurboB86pfp1QSENQl7na9vHOlBnrszdOg9skvP2N2MtVmdyCsNdJfyZTNL7FzwmiSKsW2SXAjJjfM4WY1Otm1XTWqzgompy3ccAPSzqMO5DlE/YuuZ8a4zmlyUwQkUaVr+cf4b0UGraLT/aamlD8GUzgbVOqDwhoBDP4B9BHFkxa+/FPoIc9NYMfVTk25DfxPLkjhWUBdlnPxsVykciuZ137bRUAEtLy4bmOQAY4DBlLvt9++mM1a/bGVd9i31CmluqnYULJh8yYVJXq8ySqMHn1QvNYgV4tnooXBdAx6AhwPEP05WRMdXJI41jaojMdTRuKcCeFl+73c+3FtKRGjc6OMDiwTcGtDJZhP09NceGCkVCzxhzk7TcqwkQzLkeHLqh6HGf6qSc3zkNS3BsbrFEqCpRbgnqQzk5aqufI3Mx3zfY2tHFXtjFJ7CfKWXW4qIh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40636c9a-4b9f-4b39-a5f2-08db8d181de8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 14:04:52.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nqnFk9bG+j9Rk5uBYJBL+7UO+35NZ6HBmegN6fxaAmAn8LiYmHZ2WgaINjCthA4OLM54uToN+KVihZLPa5Bjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250124
X-Proofpoint-ORIG-GUID: 0N_MRiW7iL8O2IV0siiP5bc7ypTKkJkp
X-Proofpoint-GUID: 0N_MRiW7iL8O2IV0siiP5bc7ypTKkJkp
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/07/2023 00:00, Alan Maguire wrote:
> On 24/07/2023 16:04, Timofei Pushkin wrote:
>> On Mon, Jul 24, 2023 at 3:36 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 24/07/2023 11:32, Timofei Pushkin wrote:
>>>> Dear BPF community,
>>>>
>>>> I'm developing a perf_event BPF program which reads some register
>>>> values (frame and instruction pointers in particular) from the context
>>>> provided to it. I found that CO-RE-enabled PT_REGS macros give results
>>>> different from the results of the usual PT_REGS  macros. I run the
>>>> program on the same system I compiled it on, and so I cannot
>>>> understand why the results differ and which ones should I use?
>>>>
>>>> From my tests, the results of the usual macros are the correct ones
>>>> (e.g. I can symbolize the instruction pointers I get this way), but
>>>> since I try to follow the CO-RE principle, it seems like I should be
>>>> using the CO-RE-enabled variants instead.
>>>>
>>>> I did some experiments and found out that it is the
>>>> bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macros that
>>>> change the results and not __builtin_preserve_access_index. But I
>>>> still don't get why exactly it changes the results.
>>>>
>>>
>>> Can you provide the exact usage of the BPF CO-RE macros that isn't
>>> working, and the equivalent non-CO-RE version that is? Also if you
>>
>> As a minimal example, I wrote the following little BPF program which
>> prints instruction pointers obtained with non-CO-RE and CO-RE macros:
>>
>> volatile const pid_t target_pid;
>>
>> SEC("perf_event")
>> int do_test(struct bpf_perf_event_data *ctx) {
>>     pid_t pid = bpf_get_current_pid_tgid();
>>     if (pid != target_pid) return 0;
>>
>>     unsigned long p = PT_REGS_IP(&ctx->regs);
>>     unsigned long p_core = PT_REGS_IP_CORE(&ctx->regs);
>>     bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
>>
>>     return 0;
>> }
>>
>> From user space, I set the target PID and attach the program to CPU
>> clock perf events (error checking and cleanup omitted for brevity):
>>
>> int main(int argc, char *argv[]) {
>>     // Load the program also setting the target PID
>>     struct test_program_bpf *skel = test_program_bpf__open();
>>     skel->rodata->target_pid = (pid_t) strtol(argv[1], NULL, 10);
>>     test_program_bpf__load(skel);
>>
>>     // Attach to perf events
>>     struct perf_event_attr attr = {
>>         .type = PERF_TYPE_SOFTWARE,
>>         .size = sizeof(struct perf_event_attr),
>>         .config = PERF_COUNT_SW_CPU_CLOCK,
>>         .sample_freq = 1,
>>         .freq = true
>>     };
>>     for (int cpu_i = 0; cpu_i < libbpf_num_possible_cpus(); cpu_i++) {
>>         int perf_fd = syscall(SYS_perf_event_open, &attr, -1, cpu_i, -1, 0);
>>         bpf_program__attach_perf_event(skel->progs.do_test, perf_fd);
>>     }
>>
>>     // Wait for Ctrl-C
>>     pause();
>>     return 0;
>> }
>>
>> As an experiment, I launched a simple C program with an endless loop
>> in main and started the BPF program above with its target PID set to
>> the PID of this simple C program. Then by checking the virtual memory
>> mapped for the C program (with "cat /proc/<PID>/maps"), I found out
>> that its .text section got mapped into 55ca2577b000-55ca2577c000
>> address space. When I checked the output of the BPF program, I got
>> "non-CO-RE: 55ca2577b131, CO-RE: ffffa58810527e48". As you can see,
>> the non-CO-RE result maps into the .text section of the launched C
>> program (as it should since this is the value of the instruction
>> pointer), while the CO-RE result does not.
>>
>> Alternatively, if I replace PT_REGS_IP and PT_REGS_IP_CORE with the
>> equivalents for the stack pointer (PT_REGS_SP and PT_REGS_SP_CORE), I
>> get results that correspond to the stack address space from the
>> non-CO-RE macro, but I always get 0 from the CO-RE macro.
>>
>>> can provide details on the platform you're running on that will
>>> help narrow down the issue. Thanks!
>>
>> Sure. I'm running Ubuntu 22.04.1, kernel version 5.19.0-46-generic,
>> the architecture is x86_64, clang 14.0.0 is used to compile BPF
>> programs with flags -g -O2 -D__TARGET_ARCH_x86.
>>
> 
> Thanks for the additional details! I've reproduced this on
> bpf-next with LLVM 15; I'm seeing the same issues with the CO-RE
> macros, and with BPF_CORE_READ(). However with extra libbpf debugging
> I do see that we pick up the right type id/index for the ip field in
> pt_regs:
> 
> libbpf: prog 'do_test': relo #4: matching candidate #0 <byte_off> [216]
> struct pt_regs.ip (0:16 @ offset 128)
> 
> One thing I noticed - perhaps this will ring some bells for someone -
> if I use __builtin_preserve_access_index() I get the same (correct)
> value for ip as is retrieved with PT_REGS_IP():
> 
>     __builtin_preserve_access_index(({
>         p_core = ctx->regs.ip;
>     }));
> 
> I'll check with latest LLVM to see if the issue persists there.
> 


The problem occurs with latest bpf-next + latest LLVM too. Perf event
programs fix up context accesses to the "struct bpf_perf_event_data *"
context, so accessing ctx->regs in your program becomes accessing the
"struct bpf_perf_event_data_kern *" regs, which is a pointer to
struct pt_regs. So I _think_ that's why the

    __builtin_preserve_access_index(({
        p_core = ctx->regs.ip;
    }));


...works; ctx->regs is fixed up to point at the right place, then
CO-RE does its thing with the results. Contrast this with

bpf_probe_read_kernel(&ip, sizeof(ip), &ctx->regs.ip);

In the latter case, the fixups don't seem to happen and we get a
bogus address which appears to be consistently 218 bytes after the ctx
pointer. I've confirmed that a basic bpf_probe_read_kernel()
exposes the issue (and gives the same wrong address as a CO-RE-wrapped
bpf_probe_read_kernel()).

I tried some permutations like defining

	struct pt_regs *regs = &ctx->regs;

...to see if that helps, but I think in that case the accesses aren't
caught by the verifier because we use the & operator on the ctx->regs.

Not sure how smart the verifier can be about context accesses like this;
can someone who understands that code better than me take a look at this?

In the meantime the workaround described above should do the trick.

Thanks!

Alan

