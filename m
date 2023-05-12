Return-Path: <bpf+bounces-442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC77700C81
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 18:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847751C21241
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77FF1DDEA;
	Fri, 12 May 2023 16:04:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF162414A
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 16:04:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A54B26BF
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 09:04:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4kwB023033;
	Fri, 12 May 2023 16:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=G45TsMoCd1Mdr/uGs0EknRcdg1hZOP3TEMDjH2abNl4=;
 b=NxqsjoPdCc41dF5D1yw2QyKlSWYFNoVzynf12jeNjhgtmNbLR51TjcekpnLfCJrn4ykK
 y6O4s932Zcrr1zD81KxixgsOe08nm5GfYUvLS1IgdwWu9gGHy8ZxdNRf81Q6+Oml/hUm
 oiYs+q+Puy25rhHHMz9MjFG2HJvHtvSw0qLnOyALDd1BhrOLyk2GzDGtJZpsxzXTq/wQ
 6EauJa2SQc8s/oz1UAa7ztTvhGkMj0blT3/vwnnzAAohrt4v4fQ6163JIRD6Sw/Ea5E+
 zOVct/gHEHANO6/EfEYX6zQPkOcn40URAIYN5fFX7rF3gMwPcmcwIchm/EiGGuuZ//HF 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77gb3t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 May 2023 16:03:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFpPdX018263;
	Fri, 12 May 2023 16:03:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mdhx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 May 2023 16:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiZXMP6HGcODVuYSePh+1mxB52aWGsJxIdcxBo7nrGjZsVn0M/Nk+NqgCih+rxm60ijA76TY3ImrVIEy8iLd/n3JHOjxX6rk62pn1vMjjrGOFD2/E4o2AwpcqZPaafhfqJqPoCyJeFXhtMfNwKYI8yHv3Qk0hLGWo2UVH6lx2BpZhh2pmzHwYmFzqC1fG4ryiMx3yCkPmP+EoeOAowmKtyqEw3wBBFN0Ey4X6SA2KOr13t7zBZR1aH8pAL/kYz/iZt6pvhoEHDWkW2iEZcHtvs2ndTrU4q72lcVQabq2PUEUApY9C9icet851Xt+ZFhOvBCqD1KzrfPUxM80zl6pJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G45TsMoCd1Mdr/uGs0EknRcdg1hZOP3TEMDjH2abNl4=;
 b=VVwiISeCvNYy4qJ4gXMB+zN3y2kws8JbOY3ubz+8aS9I3EOkp4958iEGBiICaZVVGChj1IgkoT+OMIoMunGUOYBEhKK327DPJlv9t47IJVcewsm6BhPAJLZ2jTI8SdAKoSO5e0aD0Up+MFqqko/lDh3TukQQmdkuD1RJFfNZcIv5B93Gfs0FY35hSosiW0UbOWO/2/5ye3ber/3xtUVRV5+wawWyGxFRRqZBg78+xqYXK3Dm6AYAQYlEK+7Url9cOVsH2tJnivGwbnht+Y9TAhROsmRfpz8laL0CR60pF4WlyCqcC8X0X9EWG7uTUwRUOLlIfuee10/2KYxsbBu4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G45TsMoCd1Mdr/uGs0EknRcdg1hZOP3TEMDjH2abNl4=;
 b=xVVGzoBTn5OAfhulH02NCHQGDqgR7ATRKzsI/W8wCfB+Cc4m+H96WZMX7H612CIhJy1c6fp4OQJVZHBCBH3cdOaOUD5OZFA3B0TZfCLOYSWXu4GoirtjIk3WHWvW6axU5TZLzV+ttxZDNQGuSMj72EJOBo4mG6RN91Xch/plYSQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 16:03:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 16:03:47 +0000
Message-ID: <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
Date: Fri, 12 May 2023 17:03:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org,
        jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
 <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0084.eurprd02.prod.outlook.com
 (2603:10a6:208:154::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 970f405d-ea34-45be-c7ed-08db530277ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OdNHQrXjABFvgtGonduqzfgdFfavh3mvPK3e36S2Mf50azuGSx7IJ7ZPIv3/pFPJ+3u8TFU567LrN9KjaCfJDUiHBZsfpkI3R312KbniHP0yJURh5e95ojj+VXYnL8rZN1NtAjQVbJwTZ1LUmdKaqGf3PkF9LnRo8Yrnmuk7OR89Xt/MqB4tuV99i1m8IviN2bXXpS56LMRC03flR4cb3HdfTDjwWCtZzm60bAtlRHOEgzDqeEkRyojJDQjGDrJbB4y66GnHxnX9vEhM/liSsa0KlhJa1KBSr2jWVl5O1fxLBl9cKZhtq1bJadS4gLHHKm+qae8PCcSsONURva3uWOPFrGHrclFiChL2pir0y1kpunvOzYpdLFarPV5ADNa7E2/jbabFx1jPeHPBuZop2hXCT77jv8Jr/MRIYAhlgYq07jN5VkqXaLG9/wBCPeg06G3WCuqn7M7U+n6w6AOezc+Ve0Alc1rDmIKsPTmHM8qgRyMKrXc7jYV8X/GVRyAuqeucVbU/4Fv6K12EvQTyeH3z+6zzNOmJk1opLKfFs4iyeQXpxUXF1pwQQ0iGhJ9F2eCtXEXo9ByqKWXxz7qL1JyS7XdK+20W1/QfXqb7Q4F12ilft898CWB4IRjb3c3K+aIsoEATSGnNIwZVNQjLZQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(31696002)(38100700002)(6666004)(6486002)(31686004)(186003)(86362001)(83380400001)(2616005)(8936002)(7416002)(2906002)(4326008)(5660300002)(44832011)(36756003)(8676002)(316002)(53546011)(6506007)(6512007)(6916009)(66556008)(41300700001)(66476007)(66946007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVVIaFVkMjNUSWh0Y3JVY3dnejcxZ3pac1dUMzNqaStGSVhSNnpvMk5qeFZy?=
 =?utf-8?B?Q01PMUtIQ2dXL1gxZEtDZjFzK0Rrb2RBRzV2RHNXUnFITHpNUnBxeGhEOHBD?=
 =?utf-8?B?Y1N1NWdpK3JnNzMzRVBHTG5LYklUUTlQUTdBSHk5OG5JcUlpOUk5MWY2NUt1?=
 =?utf-8?B?aUNrRGlQR3VzTnVITEUycWhnTGJMSlArR2Y4dHd1SHlFWlBENjREVHBxRWZB?=
 =?utf-8?B?amF0N0czd2FYZ2xRUFdvaFZPSForQmY4MzkxdXhUekRLTXVTZUVMRVVFeVVz?=
 =?utf-8?B?VXQxdnJpK3FJYW9rd1FsbjNtS1dTZUNiTE1uQVQ2OVRxTUMvblpiQTJRYlY3?=
 =?utf-8?B?SS90T1BSWjBjY1NuYW5nNWpiSFVocWkwMlpmYWtjallIMFJsM0cwVk10NEFu?=
 =?utf-8?B?bi9pWVdHaHdzTFl2bEtaWkQxNHpWTEpNRmVLeExpMGpFTXA3N25rVS9iK0Y5?=
 =?utf-8?B?S0ZMZ2p5ZHlicXo3UzgrU1JNdFJXdElFVjlyQnJ0RUQzZEo2elVDeGhEdzVZ?=
 =?utf-8?B?a2psSVRFMFM3VkFwbHpyaHpzT1NmUDhHbWJybWkwcEZUcmF6cERqL0kvQ0dk?=
 =?utf-8?B?TnZUeHpTWWlUV0RlcTdmMkFORld6cWdOQjljVmhuTWROK1I3N0E2K3B2bUti?=
 =?utf-8?B?Tk4xOHorWEpXN0dQRHJtc1dKblkxbHFkRDdKeWRrT0VBQncxbExxc1BRVnRw?=
 =?utf-8?B?K3N3SmEzeHZaeThmUmpZZXVxUGdpWnpkRUNIWlY0dHhya3Q5SHRFQi9NaTdT?=
 =?utf-8?B?S2tzdk1uRmhvc0NBc3hhUUlvT2xiVnF4OS9XeXdRYms1cVMrbitLM2VZd01C?=
 =?utf-8?B?cTZKNnRlNGI2SURzZm5GRVhraVNPdjZkRG1MZ25xbFBXNktOM08rMElVanhr?=
 =?utf-8?B?dnVsWHY1dEVMbncyaHVlY3YraXI3TEZNMEY1OW4wd2pxOWZSbUtsSjRBL0JI?=
 =?utf-8?B?cUVPQ21iQlJIZ2RWRWFtQkZEUmhzTU9HWUprWnBMcXRUc2dHWDgvZnNLWTYr?=
 =?utf-8?B?aEdpaEE5eUxnOHQxWVBkS3k2eGRBTjd2VzBndUs3SXB6dHl6MGdqTEFvc1Nq?=
 =?utf-8?B?MkFYOHpsVGUwYisxVDV1MTJ6VTg5anZwSU5DNXJmOHZwUzZNL1A2cnc2Skxr?=
 =?utf-8?B?a3JTc2FGcGZLRmFCbmRmK3NaL1ZCdDJJbEhJM0U1MjhkczladzJWekdRY0Jp?=
 =?utf-8?B?ZXVGby95Y3I3Rk5HcFFwNW5EcWxoL2YvTUpLV0ErTXhyOXRyKzN2ZklHaVAw?=
 =?utf-8?B?WDVYMmJVcW9TVnZQTXp0M2lrc1VUWFM0ejhqZkQ1RUZzMnhpQzZJWmZoc1M2?=
 =?utf-8?B?aDhwTEJqTGRNTm8rNzVBZ3VaVXI2QWJycml4eHB2S2tVMUo2aVZOTUd2a3g5?=
 =?utf-8?B?SUs3S3JBTmhWMG9CYnpvWWdGa3RwaFE3YWtGZVcxYkZkc1RZTDQ5R2Jib1ZM?=
 =?utf-8?B?b2JLWWxjNklqRG9pcEVRRFNzT0Z2Zk50cW9Rbzh3R0hqSTRnODY1Rk1IbER0?=
 =?utf-8?B?dmEwYVRUVUJrUmdTc0NzQkh4OVlqVkdFU29INVBCd08xTktpdDFiMHhwVU1V?=
 =?utf-8?B?ZGtGTUwrZjNVZkY1dHBmZlNiWlNFL01BOWR6NVNXMCtrWXBSanN3NXRDYWFY?=
 =?utf-8?B?NUM3NTdnay9PM2lrdGZXNWFqTTRhSFdIZTZRS1J3NXB6Qjc2VklscDkwZGxY?=
 =?utf-8?B?d2xzak9PeTZNUTFzcTZGei9VNTJzTVlZK0FXTmUxd2tWeDRtQzljeFplSHlt?=
 =?utf-8?B?NE1JU240d3I2SWpPdit3MWgzV05IbFVYd1Y5Z0Era29HMDlCZnAxRkhaYlVQ?=
 =?utf-8?B?WVRuck8rUThKZ3g2TktZR3dGRVY4TkxoYkpqRjlwMWRWRCtqc3FtUy93Q29S?=
 =?utf-8?B?dzNDVW9KS2YzdW4xZjV6Q1B5UUFOTE9FSUZGZTdzbEZ0V0s0OTI0Tjc0eUk5?=
 =?utf-8?B?dWs2QUhXOG9qNlZCUzZWT0hLOC82RWttd1BqWVlVWXArQlVuM2J0N0RSRWdI?=
 =?utf-8?B?d0JxZjFMZ082RU5IeEZQMVYydS9qMExGQXFTRkFXRmxMVjdqZmpFVkpJR05W?=
 =?utf-8?B?VmFhWDJWaXM2LzQrWHdxdzVsQ2RDeHQxczhwVk8yT2lHMlhEMk9DeDByQzlQ?=
 =?utf-8?B?R1FzWW85YVhuMVFHWC9Bdm4rZTRPNmxBeDhKajI3R1FJMkZwOWUva2JrVFIy?=
 =?utf-8?Q?9vNi7987ae0MsWdJkkmV2T4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?SU5MQ3VkVWNvZWpUZGVXSnVSYkVZdFFHdHJxT2tEUHBISlNSdUFpMHF0ZWZB?=
 =?utf-8?B?bGdoYlpab0w4UldrRmMvSkg2MDN5d1ZnYXlFR1J4TERVL0M1VVYxQ3pvSXpB?=
 =?utf-8?B?d2M1MHBWRDdkeGNKTlNYRE9XWVNPdmlGd09tU2FPYktzSTJYQUFoalNYZ1VV?=
 =?utf-8?B?aWVsQUxnQnQwWFNtSmwzU3FUbDhmNU96cCt2cTN4ZE1Vc2NrU0pOdjJJVGkv?=
 =?utf-8?B?Y210TmE0eFVSNDl1MHFnbWRlUjZMWjdtYlQ1N1hzM1dReUFuMU93dDRmRzh1?=
 =?utf-8?B?aWVKc3N1WmFJRW41R1ZkOFlGUlkwRVpwQ3ZQRkFiaFdCQXBleHhlVFJMYStM?=
 =?utf-8?B?a1lqU2xwSHZyd0dGc0JHTm9pMmFkTWFwSU1jNzNiRzlmdjR1b2kzMXZqL1Vw?=
 =?utf-8?B?Mk1kWkwySnFpZXRlR2EyUlVhY1BWbjA1dFJSZU9XQkVWSHM2SWppVTMwRkUr?=
 =?utf-8?B?SWxCelJ3Q2I2UC9CMFZmemt1Ty9KRTQ3ZlA5d2g2UkpybllJUWZpdnpmYWcy?=
 =?utf-8?B?RW5JbXZ2cmE3N2Nmbk9LeDVGS3lZMlRhSzVEaFozdlgrbFc5YmQ0d0RTa2JU?=
 =?utf-8?B?NWxuaWN0Z2ppWTVESHBvak9pSWovc0QxcGhPMDl3d2k3UzJzYlNlUi9peW1S?=
 =?utf-8?B?eVBpdVlqRUx4SklJaGRjc2djUFhjc2Z1Y1NDR3ZTT0p6OWZRTzdkOURDL285?=
 =?utf-8?B?b20yc3RVdmhwcXJNOVYxMHFucDZ6RjdzcjJrbERHMWJnTW1qTUZZZFU5TUtr?=
 =?utf-8?B?b0RiL1I0RVI3NkZudm1mWjhQMVNkMmFUem16bDJkSXN4bkRteVJrcm8wNVdO?=
 =?utf-8?B?Ylp1YjBWOXRVN2pKd2FVazdKSDNXT25jQTRrU3RZeXMwd0NXdkNQUTNDVFZv?=
 =?utf-8?B?V2V0enlqajdGVnVBVnRrQTNqVE9GSTZ4RWRtcTNqQUc0RVgyVlVCNTRTRW9h?=
 =?utf-8?B?bWFYUkVqNUxKR3UxcldjZ2JzTVk2QlJhOWxOazdydnhJVmFqeEZ2UXRwbEhr?=
 =?utf-8?B?RlQ5SFltZkk2OE91TUxNTmYyWW9uZ3ZzNmJHVTY3ZkFsMmQrSyt5Tm9uQjhr?=
 =?utf-8?B?MzBiNHBMb0FKREx3bWpmaC9jNDhvZDVFWmk3VEd4VmM1T1VoTHJLUFBXTU5W?=
 =?utf-8?B?em9LZjZNZmVzRm1nWlNoWlMzTzdSRUlpVVJyNVdOUjRneHRqSWd0Q2d3MzFo?=
 =?utf-8?B?RVovU01wL3RFamplUkVPRkpCRWEyRWdHRWFHM0ZnVjNGdkhGQ2NZY3hML3h6?=
 =?utf-8?Q?B6Ki8Qvp0LFRDsE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970f405d-ea34-45be-c7ed-08db530277ea
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:03:47.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l43D75gZw8nyqYLlW7u2l+IqRVgXQH8o03r11t8rjpHAc3erJWnq9u4BX/UvR7d5eNQAD4yj0Y2kWwZmfmJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120133
X-Proofpoint-GUID: Q2znrtOUCnlnkgROWLeK5eGLYhcUk5Mx
X-Proofpoint-ORIG-GUID: Q2znrtOUCnlnkgROWLeK5eGLYhcUk5Mx
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/05/2023 03:51, Yafang Shao wrote:
> On Wed, May 10, 2023 at 9:03 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> v1.25 of pahole supports filtering out functions with multiple inconsistent
>> function prototypes or optimized-out parameters from the BTF representation.
>> These present problems because there is no additional info in BTF saying which
>> inconsistent prototype matches which function instance to help guide attachment,
>> and functions with optimized-out parameters can lead to incorrect assumptions
>> about register contents.
>>
>> So for now, filter out such functions while adding BTF representations for
>> functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
>> This patch assumes that below linked changes land in pahole for v1.25.
>>
>> Issues with pahole filtering being too aggressive in removing functions
>> appear to be resolved now, but CI and further testing will confirm.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  scripts/pahole-flags.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>> index 1f1f1d397c39..728d55190d97 100755
>> --- a/scripts/pahole-flags.sh
>> +++ b/scripts/pahole-flags.sh
>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>         # see PAHOLE_HAS_LANG_EXCLUDE
>>         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>  fi
>> +if [ "${pahole_ver}" -ge "125" ]; then
>> +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>> +fi
>>
>>  echo ${extra_paholeopt}
>> --
>> 2.31.1
>>
> 
> That change looks like a workaround to me.
> There may be multiple functions that have the same proto, e.g.:
> 
>   $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
> kernel/bpf/ net/core/
>   kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
> bpf_iter_aux_info *aux)
>   net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
> bpf_iter_aux_info *aux)
> 
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
> bpf_iter_detach_map
>   [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>   'aux' type_id=2638
>   [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
> 
> We don't know which one it is in the BTF.
> However, I'm not against this change, as it can avoid some issues.
> 

In the above case, the BTF representation is consistent though.
That is, if I attach fentry progs to either of these functions
based on that BTF representation, nothing will crash.

That's ultimately what those changes are about; ensuring
consistency in BTF representation, so when a function is in
BTF we can know the signature of the function can be safely
used by fentry for example.

The question of being able to identify functions (as opposed
to having a consistent representation) is the next step.
Finding a way to link between kallsyms and BTF would allow us to
have multiple inconsistent functions in BTF, since we could map
from BTF -> kallsyms safely. So two functions called "foo"
with different function signatures would be okay, because
we'd know which was which in kallsyms and could attach
safely. Something like a BTF tag for the function that could
clarify that mapping - but just for cases where it would
otherwise be ambiguous - is probably the way forward
longer term.

Jiri's talking about this topic at LSF/MM/BPF this week I believe.

Thanks!

Alan

