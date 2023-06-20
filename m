Return-Path: <bpf+bounces-2907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5510B736697
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774AE1C20BBF
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565BC13B;
	Tue, 20 Jun 2023 08:47:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060D1FDD
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:47:22 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE8C2
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 01:47:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K09ip6004672;
	Tue, 20 Jun 2023 08:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ug1/fKWfchsyM9w9PEdKZj1CFx/fobqY6emoSs63/Zs=;
 b=l3T34zi8NKCOlIZJ5ncrSi8r2Rm/HCFjrYpJzqP0b1lQ30bV3Pp2G5TpZTgqtfWKHLVy
 lluBS6ORwcoPJ5CkQ31w5enk0MfqYfmdgGNn1fMhVrwpr0iXaY5d+b8/1uJKw8Zg+SwZ
 CnN27WQ02jhQpAJcnocwRxpeKjfK7dsXi+zSbyMiJjOCil6BQYda3HknLzhdCqz0kKNy
 JotI5P1RrS81eH4HVQK3VZkxgnxUjW7DMj57OvdDChpP9O8f6UxnTA6Y7SkCBPFYw8oq
 LzeRaeWMkkgkFgSP7zEI45BK2hZtOpv9LKkixZbpcVSayTrkoSUSoMcdr7wg5BAKGyaN rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dm5mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 08:47:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8Is6x005794;
	Tue, 20 Jun 2023 08:47:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r93942jp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 08:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/5pAVpz8MycqXfmUAAUPZQx9tPMs16JG/yF6U1ArfVueEP/eVIYB0UArQcsd4DYO5V1qbE9o6oF83y6ojpvv9zuS6Nf6sFncZt3cUyuGTlWsPZLGKMC0iapZVNuY39ZLz9/ybHvt77NP19h7NkQwUZitd2+1D9nFD6o8TPFich+eFSi+suleu+xZlmGdXUS0M1gwmFSW3AGFVe6InMU4fZOnUjeTbBcDAOyt4kWQFn9vy/EFIqmT58tAn2h7iN69nsJzoyHYfvqO1tTOgxC7eoEzK1p2TI5zHW3SAgDAA9mwDQq/pV9TpGZT7/A6PzVv4fcrPFcb44HYh+SPMhotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug1/fKWfchsyM9w9PEdKZj1CFx/fobqY6emoSs63/Zs=;
 b=gzkSyz6rggXGPurtWnOQ4KNsHb0hm4sQz/y8tgU4LjBJnYXggc1kpwwtGfeJvs8/XOB2d8SgyPMceSoeUosfecBLXlCDXJd1tx9tEjnIaK9uPHrBpTbFdSYIkdz3By3EWmZux8T93uQsTDPxWsYdTRhvIqICsIhQAy+1MbtDNQjVlRFRWao6bYj7Er0hLHxF+Mv+BIwDGznjGAPYbe9Fraw2trqNL8HY0xGb0UEieLQkKXuchC9OJWE0GfS5V9v9g5t6HmgwSVtpWj3tQMHdcMTsNyahVvt7xEny8CriBqRp3aNkzSpN2dUmA82wlvHfcK7CfMGrKkp2xMioxeSrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug1/fKWfchsyM9w9PEdKZj1CFx/fobqY6emoSs63/Zs=;
 b=0MHlqUg221/EFh33i6tq7IqEnHHloojXRFQG0rECtnNBfEBlz7+spT+7SCD+qldPBH9DfwF0rSg8SCGAUr7ia/B9c4rbyHLaE6iETgECzQAHlBIyiAD1z7iyHjL0mZW1jhr3uYyt0HmQmqvtSfi/9WUcBBMx0D3Nmys4uAMiRTw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 08:46:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9%7]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 08:46:53 +0000
Message-ID: <fba51ab9-1c3a-7ea8-96db-234f5520af71@oracle.com>
Date: Tue, 20 Jun 2023 09:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 6/9] btf: generate BTF kind layout for
 vmlinux/module BTF
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-7-alan.maguire@oracle.com> <ZI8Bpy0XPedXTJY1@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZI8Bpy0XPedXTJY1@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0342.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4ec114-3788-4974-04e4-08db716ae569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o+kj7UzHLKiS6a5KzfWUPlNL34vT635hgNkFjASN6hhaO4MzC6rJVJJmDIKbp8N+SCXA31M8B1oT+Eg6DPRrPh8D7JwQXgMrVTx2uzw8eMFXOQO6fdy/E8s9+zWPbupJP23NdD6BUGWm6U/04I9zH6RxcbHxq5YqO0qGxZ+jb5k1tq1lCOogl9XIxPaU8RYtnzvhKwfq2PvNPllf9002Zsboi7TbsHy0yAwhOXhDnQVusmcaSoL/lPo20NphxB9EwL4EUs6oh+yaHxGEDpt8BX17SgYJ82ymlcJ4CUw9Ka014cy7Bbu7Kg+DRO2o16CUVAMnT/RmB3bfd8XUQ4n9KJlzNF8uP27bGEvSXjB/KvlxLoNSZpumRz4v3PH/REsrUzCk36P8400ohJ6ddF5WrjQdcd0PwbRacDUD0Fg3Mh7aS0s/2jww6kwnxSwGaJy/Eo3jh8cjLx6uFw5cdqQ5/j6Wr9y4dI84rirIPB83k4MHDF8IszUxy+d6x2WGtinjgEttoJsHwwzTuKlJgSCEDC2M9JdjCRxwQqIUnKPbtnA9Iejd25jG+LBpFIwo09/ptQwN6mq9hjzNC2plyI0mIrw79yDBj4LvTY8KmxrcqERJ1ZlUykDeGg8pCd1PHfAPpqgqNQzaNw/7FiKh1GOKhw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(6486002)(478600001)(31696002)(86362001)(6666004)(66476007)(66556008)(66946007)(316002)(38100700002)(6512007)(53546011)(6506007)(186003)(6916009)(4326008)(2616005)(31686004)(8676002)(8936002)(5660300002)(44832011)(2906002)(7416002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N3RVZ1BxZWMvWTVvM1dWdGpsV0h4NnpiNm1NbkZGZ1lyQkc2OSt4b2R0L0NT?=
 =?utf-8?B?d0xFYUZQNkprM21XK0lDaUNTRTZibm13NjBRc0lJK0NDQ1V4Q25EYlJER3pu?=
 =?utf-8?B?YXhEUnZoVDFqRkp0dXJzQUZZZ1daTjlyZjI3a0NSNlBQNzFFdDRLNnR6VkNu?=
 =?utf-8?B?QnJOZkdZMURKSWR4ZUI4QXJlbElFQ0MzZU13UTNtejVUVnRLVFd5SEtUN0Ji?=
 =?utf-8?B?WHY5YllzVy90N1RONldhUWdWMXZ1NVkwWCszSGw2YlFaWE4vbTJSWmNLTFBG?=
 =?utf-8?B?T0hCZzg2K1AwU3R2OUtTKzZHTWpMWU1EbWZpbjRTci9VMitFV1I0MjlEWHVF?=
 =?utf-8?B?cWhsN3FyZnlaMHVYem9QTXlYQ0t1MFZ3MXA4NGNlREVDeFA5L0VJUUx3WGU0?=
 =?utf-8?B?RGJIVmlFcWV0YnBodzVLZ0tLaWltQ0lVdDRiWDVYdDN4K01XejEvWGFPaVIz?=
 =?utf-8?B?WFpkUHlHbkFjdkJvTEV3MVFYVnplYjB0bVZkcDg4clNINzN3czZMTXVOd1lt?=
 =?utf-8?B?YVFGY1lQTTdJVWRsVjlJTXVnYTVEc21tdHlFOFRoRWw5YXJZczdJMnNQUzd6?=
 =?utf-8?B?RVVFNEZqQ3R3V25lc1JSMjE1UExRSC9ZTXVlSm1JaVlsa3lIZ3hUSHdjQk9k?=
 =?utf-8?B?S3RWV2xKTUliV29ja3RSYTRBOFFRYjgvcTZ4NVRyRERHUjNvdVp5Y1l5R2tG?=
 =?utf-8?B?OWZEUWhWdTBZcVB4TXFHUXpIYXJiWFVha245Mlk5eDFwSk5yNU5mYk1wSkVV?=
 =?utf-8?B?MnZtdGlWRlRhdWh2K3JVZ2FhUDFQWUFnODRsSWtVUUdaUzF5QVREOTZXSHRB?=
 =?utf-8?B?WGErUGJZNURqYjhpV3VSRER5R0pZY1RCN3Jtb0RwbnVrVVlTY0tWK3NuVkM0?=
 =?utf-8?B?SzRuVHhVNVhKamJhelhoY1JiRkdlc2hSSE95V3pjVy92VUU0YlFvUGgvenBY?=
 =?utf-8?B?NjlQa0IybUFUaUpGd0Q1Y3gvZ082czE1UWhXOU42Sm91NzZ3SU55czYxTEJZ?=
 =?utf-8?B?enkyN0U5NWxwNkNyeGZLMCtUOVFadUowYkxsWVVJUW1jZnNCZDRtSnlWeVNZ?=
 =?utf-8?B?MllmQktVN2MwQzJmQWlCMHVpQ1BLc3BiR1JhNVVLekY3aC9kWWp6MmVuK2FD?=
 =?utf-8?B?cEV5STZFN2prc3cwV2tQZ01CUEpnQnZKaE9Ea1NPZnp4MmRoc2RoRHlpQUcr?=
 =?utf-8?B?bHV2K1lEOUplcjhBa3B2ZXNoaEFTNHJ6NmZZeEN3Rjl0UkU4Z3c4ckF1SHRS?=
 =?utf-8?B?SzBtejczNk11Uys4eHNNc0ovWmVGOHV0WVFBbjFxek1TalAvejkydGJ1R0JF?=
 =?utf-8?B?NEd0MmVuZzFHRjFqa0RkM0tkSndsMktuN0h6bUJNakJkKzVRSlJBdUpTMzBZ?=
 =?utf-8?B?c1gzeUdJWWNENjViTmc5U00vcUxvU0NTcGV5dmowTVdXRCs1UndTYjJzbi9L?=
 =?utf-8?B?L1AvTjZtZGJrMXJITlJzMENNV1FWTkRjRFNDMlgzNHNpclgvUUVxSDJhU0x0?=
 =?utf-8?B?a1ZQNEFpa1YybW8yTFJ1TTR5VUViNGMvTnZGUno3NUhkMDRmRHhQaklFcVBn?=
 =?utf-8?B?K3BwQ3kySUNiOVBtbWU3ZEtTeExzbzVzeWtYUnJrdWxOV1pVcFJ4b1R2Vkh1?=
 =?utf-8?B?M2NyY2pqYWIzeVdYYWErWnhETjNGY3JWNGR4Qy9id3U4VXdDWFJhcUlacTAy?=
 =?utf-8?B?RHlzeU9heXcyemZKQXUxNnFPMzk1MWFyQ2YzbVkxeTRoUVMxZE9sbEJtY1Iw?=
 =?utf-8?B?U1dxVzcvY3RGNHNvV1B2Tmx2SGlqNExINHgrYytqam84V3FId3JLS3N1TG5T?=
 =?utf-8?B?WE56ZW0rRTF3eU40YkNzQSt2aFcvNXZIcDNxdko5VW1ycWZJZ2o0NkpVcFFD?=
 =?utf-8?B?R1JIcWw4VkVmeThYSVNDZEJHbVd6MHdTU3FmOWVZODdKMjUxZkF5bEZ1aXJG?=
 =?utf-8?B?QmZhaEZaMEorY0VPUExyTjlSNHdjUTdZakhJUnR3YmFDUytWRVFnZlgwVklO?=
 =?utf-8?B?ZjFINFBJbkRSOVFXWi9IZkhjK3k0cndRbGE5QzQwZjZZdXR6N3ZNL3RPb0hs?=
 =?utf-8?B?RWNla1BQVzM3WE5Ldm1jcUNYN0NaK2NGaERqelFSWjI0YVVXYzVHTkt6TmZR?=
 =?utf-8?B?OFVBNStoUDNRSW5wbDc0aGFFbDJpSXkxcmw4VGFQTm45K3I3bWNBdmlNV3J4?=
 =?utf-8?Q?i5WdMZOFmqYatE9h3iQX9EY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RnAwQjhXOVFLNUdma3Vyc2M4ODBLd1lnaFlUMWV3RmZWdVNmUWcydGx2RjNl?=
 =?utf-8?B?YlU5d3kzcmJnaTBlbUVjUjZpa0wvWXVUT2U1WU9oTENYNkkzODFYd3M4MHpC?=
 =?utf-8?B?Zk02TXRGY0xITGZKSFpBZXBzSFNGWXFpL3pqQkZMQjQ1SG1nYmVuRy9CZS9w?=
 =?utf-8?B?cTY0UXZNRDZIT1ZGOHVsUHZOcktQa1NtVTN6dGVPY1cxcVhSMUdCRjVKVkpz?=
 =?utf-8?B?VzNieVhCK3JnMlZnTytLQkU1WW1qeEFBTXdWb0VrSk8zMnpDcThxREhTRHRX?=
 =?utf-8?B?RTVjVTd4Y3lweDJrVFpId0NwNDIxSjJMMW5RVXBzWkRINXJ4YVNDUERCVXJN?=
 =?utf-8?B?eHVhYzJ0cFZnbTFCbXZJdHhTc0VlTDQrTDU2Yk9pYUxzTWdwd3Bod3NMeVJn?=
 =?utf-8?B?ZmpLUGJTUGdWYjNlaWRGdTJUQ2pmTmdwOFdzd0RrNktGb3ovYXczaDBVS1Q0?=
 =?utf-8?B?VlRteW9PTjA0UW1wamMzdEhQYWxhaEFHTVN5SmVXOE1FLzE2Wmt6QzJQUXp5?=
 =?utf-8?B?aTdnQ3ZzcWd1S3UrTk0wL29SdGZzUDcvSFRTczN6ZEk4a2krYXBNQmc2Y0V5?=
 =?utf-8?B?TGlBb0lsUDRrMUVMNWZrWkVyZVpFM0hVOWhWWkRvb05MSEt6NVFNSWRJa2tV?=
 =?utf-8?B?YlhoSmkvV200Um1VWDE0M0UxNHZmbzBhVHJPSE55TU82S2V4TDlxZFNHNEVM?=
 =?utf-8?B?c2VLSjZTZHFNRU1jSnFtTmJPMHVoR3VYYkJmZzNLakFFd3pPcWJ5L2N6NUxy?=
 =?utf-8?B?dWsxMWVLQ3JscXpJNFVoZDUybklIYlREQlJrRzFjSHhHUEI4aVJRQ2lqeFFX?=
 =?utf-8?B?U0lhVk5MRVBUWHd6RUk5NUoxa1VzUWxIckdjYVFRNWpUUEZ3V1NHOHJDWXdR?=
 =?utf-8?B?aTF0Z0QwaTR1MmRwVUtNSnRoeWZEUnk1T0VMWjJHUkcyV2o0RlczMEJCMGVa?=
 =?utf-8?B?bnpEQ2ZvaTJsTXhSK0xTZ004NlBqdjVNVG53VGcvZGQvelJadUdZM0tpS2dQ?=
 =?utf-8?B?ZHMrOVlzQXhPNVVpMXdiK3d1VFBFMjdEb0w4NytrRGxZWGtaZWpjWEF3Ymov?=
 =?utf-8?B?c3pld0JOM1Nad1UzVGdiYjRoQnhLZXp0dGJ0SFJpOWNDVURPTXBsUmhvWTBL?=
 =?utf-8?B?enZHYlhkL1pJQWtMcTlqWmJLQWJxclpDVnFiVWdCd1BiR0hpOTdaUk50RzVN?=
 =?utf-8?B?YVRaM08zZXlnakIxMWQ5OVF0ak85K3ZMTGh0cHFlS2ViQXBveGRaKzgrQXVJ?=
 =?utf-8?B?TUZUYzc5TG9DRnRlMlNETnlaOWx3ejJJRDg0ZjQ5QkREZXBwdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4ec114-3788-4974-04e4-08db716ae569
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:46:53.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhre6zCw6X6GSOPFX0+2CPOTa3ny6KZnG7yxdJ1qHxNFL4Yt8D58d4UsdOWDId2sKI6K1ErxgIC569L+eDE8hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200077
X-Proofpoint-GUID: -FttDioKS3kjqq0w5tRMkWG5bT3lREdb
X-Proofpoint-ORIG-GUID: -FttDioKS3kjqq0w5tRMkWG5bT3lREdb
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18/06/2023 14:07, Jiri Olsa wrote:
> On Fri, Jun 16, 2023 at 06:17:24PM +0100, Alan Maguire wrote:
>> Generate BTF kind layout information, crcs for kernel and module BTF
>> if support is available in pahole.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  scripts/pahole-flags.sh | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>> index 728d55190d97..cb304e0a4434 100755
>> --- a/scripts/pahole-flags.sh
>> +++ b/scripts/pahole-flags.sh
>> @@ -25,6 +25,13 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>  fi
>>  if [ "${pahole_ver}" -ge "125" ]; then
>>  	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>> +	pahole_help="$(${PAHOLE} --help)"
> 
> nice ;-)
> 
>> +	if [[ "$pahole_help" =~ "btf_gen_kind_layout" ]]; then
>> +		extra_paholeopt="${extra_paholeopt} --btf_gen_kind_layout"
>> +	fi
>> +	if [[ "$pahole_help" =~ "btf_gen_crc" ]]; then
>> +		extra_paholeopt="${extra_paholeopt} --btf_gen_crc"
>> +	fi
> 
> do we need to have an option to enable crc? could it be by default?
> 
> it's sort of related to the layout changes and I wonder we will want
> 'not to have it' if there's support for it in BTF
> 

I'm reluctant to enable by default yet because without CRC and kind
layout the new header format will work on older kernels too.  With
the kind layout len/offset 0 and CRCs 0, the header is just slightly
larger than the original.

I originally combined the two in the metadata section header, but
I think as separate concepts it makes sense to have separate
flags.

Thanks!

Alan

> jirka
> 
>>  fi
>>  
>>  echo ${extra_paholeopt}
>> -- 
>> 2.39.3
>>

