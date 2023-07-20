Return-Path: <bpf+bounces-5532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDAF75B898
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF2B1C2145D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214AE1BE83;
	Thu, 20 Jul 2023 20:18:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF21BE75
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:18:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC717271C
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:18:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEHHR025059;
	Thu, 20 Jul 2023 20:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xlKdSnj+rTBDfkcnjf9e/yLMsxOAfkH3U+MPB9WkZUw=;
 b=k0lSdZKOfyCQdu3QkeRN1WqbWVP6Wm2VAUlXlVffmdCdO2R9GTnbanCsg4qkZY6z2SRF
 69bkZ8vvF7yKcqAwDnbiNH0fnyZ2wlKeUHwrU2KOM+hNwtxEPn9FFe1fhDeK4ZrfeHIb
 Snk44PFdNunVsZjst7+L9gnUg3tMD+K90Xe5zrgq+T078sBbTKra6CHANDZkPrnG5Q/z
 GPoCEDtGD+5vK4TSPwuIPNSoEC52Tj2YYzx3b5v9ILHp4qvx2HPujIJyKak68B+Lv0S0
 eSJtavAo4/2ZzG+z+B0v+EqXRf9oE7q/VlUVCGtO6EvwzXljlezEFkTFsOf9/Z1mxHmh ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78agm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:18:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KIdwJN023916;
	Thu, 20 Jul 2023 20:18:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw9dexf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOM3qknRUGAaRuGnz4SAWcbQtAiq74u3d1+0fZ30IGS0v7PGNbTQMYV9KlLw+MRSwOq8Yaglno9F+JrETOoS/Y3xvYf9zHw+F4Zi4/1EdN1oUioJNR+H7mJllYlBcz/qVUeuyjQQgutxCCvn6C4WMVaxd/gbYArFhXUJGnfee5JiTn/dGJl8BzUyslbtRKf55hx+Xz+nWQFaG4R77cNStmztl/d8tBOirS+lJRpOqo7LjqQHcJxv71GW5SnFrh65oeXT3bz3q3Q1iT3UHEg/lj/flm6hOit1xC2mFhEiftpDsWcwnVtpVnSKcqdpeehjaCgXY735vUSwtiPcADbAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlKdSnj+rTBDfkcnjf9e/yLMsxOAfkH3U+MPB9WkZUw=;
 b=RN+8MWwxaK8Q+uMKoC2tQFIaPuunx2/5YTaXOJjfWbN3AJ5ayLOiO0KJLMg+FBTBRkdzLJhFcoccqXQldfB47iSXw2GdZkUudBgpIVm35pUKh+s8B0SD/QAAQGzQUfkcXyW792+ABAuMOeSxEPlOT92ZmvYLC9bxTt7TUVZKhGsKP5DaqP8++GSPXuaATqgeQfftLYtdBcL7jen6VobJlbLj+gSXsgBLnJ3AuKm8xtKB8RdzDPzRVzotDVQVAmrOnYu63gfhtR54ESRLk8p7NHLBKDuyHeldp8iP/lWG/zAKdauyoVi/+i6UyoKAZvTeSXIgE4lUsex1a9hsMYzugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlKdSnj+rTBDfkcnjf9e/yLMsxOAfkH3U+MPB9WkZUw=;
 b=Gu6cMW5ToumMNES7Jgo10Zaacz1Hq4Lri2M5Z7JuqKft6/aGjqSUENUj0n5u4NHYbNoMl9PBJmn4XCFYdyhbei28gCXzheHx70Em5+iZ1VRnPz8jgYjDRNgJJ5OZj2luZtbgX1kwJiS+gwy2Pdv2o3MfJqK6UWXPhW7pYirn/TY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 20:18:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 20:18:24 +0000
Message-ID: <e75a1937-0a92-8563-2242-95e875169880@oracle.com>
Date: Thu, 20 Jul 2023 21:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 bpf-next 1/9] btf: add kind layout encoding, crcs to
 UAPI
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-2-alan.maguire@oracle.com>
 <CAEf4BzapHdQb=gXq9xLRGfRFBC=3xcQ=OSdV1o=+5nvgDwT4HA@mail.gmail.com>
 <b972e451-3a1f-4f29-b03a-68ce3ac765f1@oracle.com>
 <CAEf4Bzazke2aLWfEZChN2BCcf83b9_EufQVAP0Z19LY5z=+yZQ@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzazke2aLWfEZChN2BCcf83b9_EufQVAP0Z19LY5z=+yZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b2a10e-f9aa-4ce0-a78d-08db895e7886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PQUxbR94hCIraQE1MzXfWU9RpSs4GJeSJDLYgHFTtpZ/7/hdHHZKS818e/+7tlxxqnYPHKY84/vVfzb8XROzbSzq5MPEMg79a9nXMcTCBvAUy839H1tpnbaujaaM8uhgBikjOEYCI9iUgVOy64niK5ronJ1kfu/hjbpbtZ5kZbQxCZ8RgmCx4+FtZHfXDiXzzSQxKCkL2jM8hMRlVPe+tE6QBqY6l/ZwpT0LrvhB1f+xU29ogX+Ybl7f1+DzWvdN6ph3b8/J9iVCCZKXQh8xEMGrO0BlHrai9eBwCkc+M/kRVWIYMeogqu3x4QqOdIfJi2u3GubK1dmhth9Y8nr4KdnQaJU1eZhYc2vjhQgkB0rCZy3Jx/fNEI31dftkvtq8OsBmt1bqPOB5xvhpzVEVIFoM0xzp5snFWt0mRWBJYXAFFVkRpMuAcRuw7M1DcLmqQGlLZlBO8zuJ9p/I3lD+I7wzJ1n0TgdWT+vTX72dR5JLtUJmYLd5WR0pNjN3bMFtLonTzxmlr1WEtSpr6Ewok3iR3ikv45H0fnfX2L0TNJ1VRZI4B5CjUvE+aLGv9pzVZ/zo9ShWuR5fsZ31m66+e8LXgtHchTcT0a4TM3mKyEJfobPOI/BzClOAP8vsIOREVLw9KxPBPwq+1UM6bV2AChKSRo4x+In+TQjbayeWY0TXNZX5pXHDf8B8ELKOoxwp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(2616005)(83380400001)(2906002)(66946007)(6916009)(66476007)(66556008)(31686004)(6666004)(6486002)(966005)(6512007)(4326008)(36756003)(31696002)(86362001)(478600001)(316002)(8936002)(44832011)(7416002)(8676002)(38100700002)(186003)(41300700001)(6506007)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlgyTXZFL0xBSk9UOUM1TnFxNWFhRUdXR04yZnR0Q2xKbDhhL3MrQ3gxQ2Fz?=
 =?utf-8?B?cTlNRzlBc08zMjFWQlBmNHIyRE9pWTEzVmc5NXlBdGVxSnlvQ0xIdHhmYVRH?=
 =?utf-8?B?YjQ4dG1IdmtnQm1RNFl4WFYwMldMRDVDaitocEg4NWhLRnRCTlkxNkIwcGww?=
 =?utf-8?B?SmhHakV2MUNQa3BHSFFzWGk1TGcwZTFPc2JrWHg0dEtzTFgyRGprRW5DOFYx?=
 =?utf-8?B?L1EzV2tuamd5QUJMZ1c1TWdZK09KL3lyYzc0Zm1vbCtQRnNkWEttcFNSZHdy?=
 =?utf-8?B?N0JkUjJFa2ZYeURPYXVPcTdRSElPZjhCQ3JhZ2JoQnhiclpxeEExam1TMWc2?=
 =?utf-8?B?S2NrSUx0VUc2bjhjaG1qQzkvVC90SktvbUJYWE9zb01sUHdBdFRaZlNvdGpj?=
 =?utf-8?B?WW9tcnN2SVVOS1ljUXFiZmJ2ZkhOMFFETVVudFVaM0VjbXo2cXJ2bHpCaC9Z?=
 =?utf-8?B?TTlvbytwQWxFN1N0ZExLTkZEN0NiWGVIOHRpMjhFU3NpUWxkRHVYdmY3SVd0?=
 =?utf-8?B?SjFoODNQM0NsOWdlMjJobXJkRGNJaGtobnZnWGhGMi9leVA2ZzRhbWNxbGxR?=
 =?utf-8?B?YmlneU9ZeG4zb0NTOHNoRlg0LzJicml3WmlqaHBXbjRaS0t6RmtzcXNkWDdJ?=
 =?utf-8?B?TGRjdUZQVzFISG9vWWZrcXNac2xkbXNvSEFMcC9IajdzUHQxMW9XVGllY2c3?=
 =?utf-8?B?UWZHakphUWJDZlZVMHdHNUh2THNYTUVlYkZoZDFwV3JNWC9wdVNnT2tyQ0s0?=
 =?utf-8?B?Q1ZzNDhjU1VYdDd4ZGRqcmlIMUVuV0NoUGlyR3lKRzJPYWl3LzYvbitCRTN0?=
 =?utf-8?B?MGJ5Vy82WGNXNm5SbW9CeGVKclNzUkg2T1pUdWRXUmluL0hHamlMTis0bUlq?=
 =?utf-8?B?N1d2Y1BVaU8xUUZWclNDRVVSYnNXWmR2c0piQ0Via2RyMEVvS2FpaVRYbGpu?=
 =?utf-8?B?em9OVXBJazQxbGh5N2p0SGpwdEF6cmlTSzB6VnltTTVUVUVGYUZlZEl4b0pk?=
 =?utf-8?B?clc2NlFZd08zMzA4UUhHbXpkb214dThlZTVENml5N1kzYXVvMmF6Vk5yeVhh?=
 =?utf-8?B?TklVeFZOeEdYMC9lZnluMlRnQ2l3c1JwVUtaVTB0NDlQUEtnQ0RldVdGaHVS?=
 =?utf-8?B?TWEyTDdwQ2o5UnFTVTdkM21xMDRLSHJoRGJhdE1kZVJRbEt2VXVweUdYSlVI?=
 =?utf-8?B?R2dvQ2pMSVZ4WGUxeXlhMWluN3NIZnN5NTlZQjl3Z3NXMnJIeDRUNlR1SlRr?=
 =?utf-8?B?elVtNjZ1U0JzbnUwd1AwNVFzdDZ2Q2s5dW5IaEY4MXJXWE9EdUptWnYvWGJY?=
 =?utf-8?B?RDVkaGRnS2xSOWZ2SlUybXpUTzdzeHM1ZHZwZ1B1VFhpeVFnbnBTcE9Ed3dH?=
 =?utf-8?B?elpJRzVhcndMUUZJQnRUWjloNUlCOEs4RDByc21IVTh5ejRvck9FUi9XSk9G?=
 =?utf-8?B?bjdqK2ZEQjhDZllYL3A1NEdsVGNxR1NSRU9yb3JTMkhJcTEyVC9xREFiak9q?=
 =?utf-8?B?Q3JRbFFpVWxIVWhTUjNvY3AzVitsQ3JTNUNGbFdJaVdtOUErOENEaHVhYjJs?=
 =?utf-8?B?Z3FxV3Joam9zSVI1YWpHQ3RId3BCbWFyZE8xMzZ1QTdPclYxZWs3ZThmeVlB?=
 =?utf-8?B?OFpRWWpUL1E3dFovOVhjZmVuZ3QxL3VPSFV2L256dDNBRUpwbktXbExuMlRS?=
 =?utf-8?B?MW1LYzFSRnFFVjFHQWVpd1p5UnFuV0MxWWRKcTBzcmgyUjJzNnRKN0VHaE5i?=
 =?utf-8?B?b3M1ZVdQOElmaTBTZmJub2l2VFlYSitVZWRqOW16aUlqZ2FNN0JVTWh2cHAy?=
 =?utf-8?B?THYyUjd6YWE5cFpyQW85bFNCQnlwVWlNUGFPSEhJa3E3d2YwYXo3cURUQjQ5?=
 =?utf-8?B?MFl1VUZZcDlIKzF6OUlPQ1o2bHFFTmcySXBkeTVwdmNCWmhQb3c5dFJIWWVO?=
 =?utf-8?B?MHJBZzRYZStEeDBESm9sTitHUDd3VEhyQlczZFZwTjBqZ0FDY3VwUHNaSzlN?=
 =?utf-8?B?T0p0b3pIWVN5T0QrVUNScmg4b2h3VlR0ZFZFbk9LTThLTk92NjZMNUI4ckJ3?=
 =?utf-8?B?TjQyRkJnYWgwVEw2ZDdrTzQ4TGx6c09YU1drQWdxblFETE83c212bllob1h6?=
 =?utf-8?B?RWpQeG85enZCZi96UVhQMTZObUZrbmpZNlN6MW5MdFZ3N0k3QjA0eXpMaWlu?=
 =?utf-8?Q?OX//59UlZba/Ct1NYvTr2Pc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?bW9aM1JJc0JhUUhhelh4Tmx0dU1ndlpRNWFud1hhU2hmR0NzV0p5VisvYjRm?=
 =?utf-8?B?NTRMVHdlQ0xCeFlKKzJGN1MvazZoNnNmdXlSU3FoN2lZRU5KNTZWUERjNWY1?=
 =?utf-8?B?L29lVHoxRVhaTFg3TzR1akYvL1JETi9GT3NIRndEWFVlOUQzYWpocGM1S1NC?=
 =?utf-8?B?aHdIbEQ3bFpCVkR5T3FlaThZdkc5VmdUYW81ZC9yVnVTZlVldW1IQW01UWww?=
 =?utf-8?B?QmxhQ05lcnlQRUdmdU5lVjJDWUE5Q0I5MFYra3ZVaXhxclhsUHRxYVgyMzFV?=
 =?utf-8?B?a2ZaUFZiZGZtWERyU2t3eHdYWDRDUEJvc2hLVGJUWURFeW01OFQ4NVJRU0tG?=
 =?utf-8?B?UmtmRkFDY3FMYUVoTVIyVWtkbEl2Q2RGSFR2YzlKQWZxY0ZIL29BOGMxK2lk?=
 =?utf-8?B?SUhGbmRyd2NkRmZFVlFYZmhwV0ZaWXlzMEgrNDI4czdIRGkzYU1XQ2tZZ1lV?=
 =?utf-8?B?UWlUTmxKU1cwZHlnNW40cXphdmpKU3dBbENoOGNHbkNNQ0JPL1ladFFaWWp0?=
 =?utf-8?B?SHE2eHlJeVNuakEwOVhXb0N3R2tiWWZKRG5ucytCNEdybTFzZjR1SnFJRVd1?=
 =?utf-8?B?NHA4U0xWTkpheTF2YnAvanRSSW1XVnYrTks4Y2UvTExvQWNhYVRyTEtEdXpW?=
 =?utf-8?B?dCtmeE5MaGVNaDZOeUcxUUphSW9XSFNJaDFqbUNFTVdNd2pHdVNTRS8vVEtV?=
 =?utf-8?B?U0REYk9rUVo3QTdCL3RjcUR4VWVyM3RpWXpCcENrNWVQTk16M0hGdjZZZC9Q?=
 =?utf-8?B?MW5BVk1aa0h6YWwwQnJWYllhZHFId1dUQ2NUSTJwRzUydDRSZEFDc1JWUkFp?=
 =?utf-8?B?Y2hKc2lZQzd4dmRtNTNPRjNCWnQzdmFnYjVhSmNJZHIyY2l3TEQraG1TTW9M?=
 =?utf-8?B?VVJET2Z0NHprTkdjOStpMTBBalV3RndoTzJtMXR2OTZPekMwYzRXWk15UU1E?=
 =?utf-8?B?MW1UNURJdmVhV2tmQk1RQXVqZjgrVWhxV3F5WEhHZHJQSVVMWHlUZGNEQWN6?=
 =?utf-8?B?ZXpqZml0dGI4ZjkwSFVTTzhyUktrODk0ZUhjcERRZm10Ky9CTVg1N0w5b3dk?=
 =?utf-8?B?ajFYYUM2dEJYMTlDZHFvK1dTYWJwVUhVRGEvbWpNWnlsUWYwVjFtYjJoWENK?=
 =?utf-8?B?R3ZDVDFncGtsSDl3ODQrdnhhNndpQmpDZklDQ0FFMGxFQWpxaDdqdkdGQk81?=
 =?utf-8?B?d0dNM2NQNkN5NmxpWjRHUlRTTXpZRWpCMEY4SFpYalB4eU5CRmY1bUpIRGlZ?=
 =?utf-8?B?ZjBPN3dKNWMrSTNxdU03QnVHclduZlBzNTVCTURJUS9SYXJGQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b2a10e-f9aa-4ce0-a78d-08db895e7886
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:18:24.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf+O1h7f9OzwBbspNtAzP4Y42FXTqPImdGKjOPXWb7YiNHCJfzYGqoPJJjKNneIwQ6sLSnRhrcKG/wNd38++7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200172
X-Proofpoint-ORIG-GUID: IUINHFSwDg2mLg_hX1M_7xwolDA8quR5
X-Proofpoint-GUID: IUINHFSwDg2mLg_hX1M_7xwolDA8quR5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/07/2023 00:48, Andrii Nakryiko wrote:
> On Mon, Jul 3, 2023 at 6:42 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 22/06/2023 23:02, Andrii Nakryiko wrote:
>>> On Fri, Jun 16, 2023 at 10:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> BTF kind layouts provide information to parse BTF kinds.
>>>> By separating parsing BTF from using all the information
>>>> it provides, we allow BTF to encode new features even if
>>>> they cannot be used.  This is helpful in particular for
>>>> cases where newer tools for BTF generation run on an
>>>> older kernel; BTF kinds may be present that the kernel
>>>> cannot yet use, but at least it can parse the BTF
>>>> provided.  Meanwhile userspace tools with newer libbpf
>>>> may be able to use the newer information.
>>>>
>>>> The intent is to support encoding of kind layouts
>>>> optionally so that tools like pahole can add this
>>>> information.  So for each kind we record
>>>>
>>>> - kind-related flags
>>>> - length of singular element following struct btf_type
>>>> - length of each of the btf_vlen() elements following
>>>>
>>>> In addition we make space in the BTF header for
>>>> CRC32s computed over the BTF along with a CRC for
>>>> the base BTF; this allows split BTF to identify
>>>> a mismatch explicitly.
>>>>
>>>> The ideas here were discussed at [1], [2]; hence
>>>>
>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>
>>>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
>>>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
>>>> ---
>>>>  include/uapi/linux/btf.h       | 24 ++++++++++++++++++++++++
>>>>  tools/include/uapi/linux/btf.h | 24 ++++++++++++++++++++++++
>>>>  2 files changed, 48 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>>>> index ec1798b6d3ff..cea9125ed953 100644
>>>> --- a/include/uapi/linux/btf.h
>>>> +++ b/include/uapi/linux/btf.h
>>>> @@ -8,6 +8,22 @@
>>>>  #define BTF_MAGIC      0xeB9F
>>>>  #define BTF_VERSION    1
>>>>
>>>> +/* is this information required? If so it cannot be sanitized safely. */
>>>> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)
>>>
>>> hm.. I thought we agreed to not have OPTIONAL flag last time, no? From
>>> kernel's perspective nothing is optional. From libbpf perspective
>>> everything should be optional, unless we get type_id reference to
>>> something that we don't recognize. So why the flag and extra code to
>>> handle it?
>>>
>>> We can always add it later, if necessary.
>>>
>>
>> I totally agree we need to reject any BTF that contains references
>> to unknown objects if these references are made via known ones;
>> so for example an enum64 in a struct (in the case we didn't know
>> about an enum64). However, it's possible a BTF kind could point
>> _at_ other BTF kinds but not be pointed _to_ by any known kinds;
>> in such a case wouldn't optional make sense even for the kernel
>> to say "ignore any kinds that we don't know about that aren't
>> participating in any known BTF relationships"? Default assumption
>> without the optional flag would be to reject such BTF.
> 
> I think it's simpler (and would follow what we've been doing with
> kernel-side strict validation of everything) to reject everything
> unknown. "Being pointed to" isn't always contained within BTF itself.
> E.g., for line and func info, type_id comes during BPF_PROG_LOAD. So
> at the point of BTF validation you don't know that some FUNCs will be
> pointed to (as an example). So I'd avoid making unnecessarily
> dangerous assumptions that some pieces of information can be ignored.
> 
> And in general, kernel doesn't trust user-space data without
> validation, so we'd have to double-check all this OPTIONAL flagsole
> somehow anyways.
> 

makes sense. I think I'd been hoping the BTF kind layout would help
address the "newer pahole runs on older kernel" problem, but it
doesn't really. More on that below...

>>
>>>> +
>>>> +/* kind layout section consists of a struct btf_kind_layout for each known
>>>> + * kind at BTF encoding time.
>>>> + */
>>>> +struct btf_kind_layout {
>>>> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above */
>>>> +       __u8 info_sz;           /* size of singular element after btf_type */
>>>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
>>>> +};
>>>> +
>>>> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
>>>> +#define BTF_FLAG_CRC_SET               (1 << 0)
>>>> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
>>>> +
>>>>  struct btf_header {
>>>>         __u16   magic;
>>>>         __u8    version;
>>>> @@ -19,8 +35,16 @@ struct btf_header {
>>>>         __u32   type_len;       /* length of type section       */
>>>>         __u32   str_off;        /* offset of string section     */
>>>>         __u32   str_len;        /* length of string section     */
>>>> +       __u32   kind_layout_off;/* offset of kind layout section */
>>>> +       __u32   kind_layout_len;/* length of kind layout section */
>>>> +
>>>> +       __u32   crc;            /* crc of BTF; used if flags set BTF_FLAG_CRC_VALID */
>>>> +       __u32   base_crc;       /* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_VALID */
>>>>  };
>>>>
>>>> +/* required minimum BTF header length */
>>>> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)
>>>
>>> offsetof(struct btf_header, kind_layout_off) ?
>>>
>>> but actually why this needs to be a part of UAPI?
>>>
>>
>> no not really. I was trying to come up with a more elegant
>> way of differentiating between the old and new header formats
>> on the basis of size and eventually just gave up and added
>> a #define. It can absolutely be removed.
> 
> right, so that's why just checking if field is present based on
> btf_header.len and field offset is a good approach? Let's drop
> unnecessary constants from UAPI header
> 
>>
>>>> +
>>>>  /* Max # of type identifier */
>>>>  #define BTF_MAX_TYPE   0x000fffff
>>>>  /* Max offset into the string section */
>>>> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
>>>> index ec1798b6d3ff..cea9125ed953 100644
>>>> --- a/tools/include/uapi/linux/btf.h
>>>> +++ b/tools/include/uapi/linux/btf.h
>>>> @@ -8,6 +8,22 @@
>>>>  #define BTF_MAGIC      0xeB9F
>>>>  #define BTF_VERSION    1
>>>>
>>>> +/* is this information required? If so it cannot be sanitized safely. */
>>>> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)
>>>> +
>>>> +/* kind layout section consists of a struct btf_kind_layout for each known
>>>> + * kind at BTF encoding time.
>>>> + */
>>>> +struct btf_kind_layout {
>>>> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above */
>>>> +       __u8 info_sz;           /* size of singular element after btf_type */
>>>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
>>>> +};
>>>> +
>>>> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
>>>> +#define BTF_FLAG_CRC_SET               (1 << 0)
>>>> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
>>>> +
>>>>  struct btf_header {
>>>>         __u16   magic;
>>>>         __u8    version;
>>>> @@ -19,8 +35,16 @@ struct btf_header {
>>>>         __u32   type_len;       /* length of type section       */
>>>>         __u32   str_off;        /* offset of string section     */
>>>>         __u32   str_len;        /* length of string section     */
>>>> +       __u32   kind_layout_off;/* offset of kind layout section */
>>>> +       __u32   kind_layout_len;/* length of kind layout section */
>>>> +
>>>> +       __u32   crc;            /* crc of BTF; used if flags set BTF_FLAG_CRC_VALID */
>>>
>>> why are we making crc optional? shouldn't we just say that crc is
>>> always filled out?
>>>
>>
>> The approach I took was to have libbpf/pahole be flexible about
>> specification of crcs and kind layout; neither, one of these or both
>> are supported. When neither are specified we'll still generate
>> a larger header, but it will be zeros for the new fields so parseable
>> by older libbpf/kernel. I think we probably need to make it optional
>> for a while to support new pahole on older kernels.
> 
> I'm not sure how this "optional for a while" will turn to
> "non-optional", tbh, and who and when will decide that. I think the
> "new pahole on old kernel" problem is solvable easily by making all
> this new stuff opt-in. New kernel Makefiles will request pahole to
> emit them, if pahole is new enough. Old kernels won't know about this
> feature and even new pahole won't emit it.
>

Another approach would be if we could auto-detect the kinds supported
by an older kernel, and not emit anything > BTF_KIND_MAX for that
kernel. I've put together a proof-of-concept for that, see [1].

> I don't feel too strongly about it, just generally feeling like
> minimizing all the different supportable variations.
> 

Yeah, hopefully some of these options can go away eventually.
The auto-detection scheme in [1], or something like it, might
make things easier in future. Thanks!

Alan

[1]
https://lore.kernel.org/bpf/20230720201443.224040-1-alan.maguire@oracle.com/
>>
>>
>>>> +       __u32   base_crc;       /* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_VALID */
>>>
>>> here it would be nice if we could just rely on zero meaning not set,
>>> but I suspect not everyone will be happy about this, as technically
>>> crc 0 is a valid crc :(
>>>
>>
>> Right, I think we're stuck with the flags unfortunately.
> 
> yep. one extra reason why I like the idea of this being string offset,
> but whatever, small thing
> 
> 
>> Thanks for the review (and apologies for the belated response!)
>>
>> Alan
>>
>>>
>>>>  };
>>>>
>>>> +/* required minimum BTF header length */
>>>> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)
>>>> +
>>>>  /* Max # of type identifier */
>>>>  #define BTF_MAX_TYPE   0x000fffff
>>>>  /* Max offset into the string section */
>>>> --
>>>> 2.39.3
>>>>
> 

