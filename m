Return-Path: <bpf+bounces-6899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C376F57B
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 00:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49EE282376
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 22:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7BC263D2;
	Thu,  3 Aug 2023 22:10:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38882419F
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 22:10:45 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367BE2
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 15:10:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373LDmon021158;
	Thu, 3 Aug 2023 22:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5kNoZ9JEI3fMLNq78y3hCA3j/dKqYd/zMsII+PTq4Kk=;
 b=d+0qON1CruEBKLKSKYUYZaf+5AYPdDS12a+s/lCXiFoKiQLM38qjlStJ+U20qZy81AvI
 zgVzNvrqi0snkRqfmMX/WNuonJASdBM3W5017h+sVk0WYUFi+T1W2nGYzLCCoGS2RcOb
 vmskH7kSUwJQEuepVyVRu02vdzcx8V/r+xOyFJKQIhRM6h860nBfIslfoih5uZQ1cr3a
 Eht0pJEYdVwX7gFvNNrHXw7kkQMX3AKBwoYmgrenbBkI3ZeklHK2N1/sEHX99DX2z8tK
 1TYR8rHxSzVcJcDAypqYWVMHbiFw/mAF/te9tmJE+36DJ7OWoCN7qXhEcmBiJ1EAADnM rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tnbjpm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Aug 2023 22:10:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373LKkXJ012312;
	Thu, 3 Aug 2023 22:10:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2qt1kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Aug 2023 22:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdUNIdJf9Oxxlmac6Z72y2DeZWH4yRYMoZLLh5KlDAK4vYc5xecQNWf+FcqfCbbRK9cK2gwUoXUXDezBqn8XyYonQYJuh7V5i61SXGmh4+t1L/2/czIRfljYPawp65JEGEUgMy0j0MktWjAk9ycce5idPSsUve6X2TSVpF6PMKTlNDEHa2UvLKO04/nzv2UlLjr0WWOsdoMAIPHYEuAgCBIgRQjpMLqPsnK4rQcxmIW0miPtB7Xqlj5h2k7LfTvegD2+spkdrtRgVs4YydSGG49yGypoJuwMJg3VQO3M56mFYSYyo5gMf3iABow/ZxN742PicQf5rpi5oCGj7UJ04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kNoZ9JEI3fMLNq78y3hCA3j/dKqYd/zMsII+PTq4Kk=;
 b=R1ik3b4zrIxwymEPPPs7ElAkyQSjv0Q6vdfxwBbuDovoLWIG14VAd8h4LknxL19mD+naYMB1/6O1pN6SanKON6RfdsotRhD9wrk1h7C6XuI6Zj/acpRJmnyJzDAvE3RBXNlE10vzwFJiHXJgo1kXhK4i/8wjtwrCnIwVaSs+Oy6DToOCH6fMemZ/GS7vnZYDICFU+18sjfDd9GoUOd8uMOwyHexW0EB3CSQ/w82WRJXRfRx6KV/1eqh5AzHG9Keipe8LtVESK/lhfMGstuIKxSxvDl2j1vaOXCluPrknQTeVOwAdWzhVGwgkHnKZoumP6SLo8EjcJB0qUGI5MiwgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kNoZ9JEI3fMLNq78y3hCA3j/dKqYd/zMsII+PTq4Kk=;
 b=XG8U855yMR5+6wyaZVowdt6H/yTchSjHKFXqnJFJ3V/dphaTzetcVJ4Nv9WedusA59l8UCV04qVm97Pis2/+Z7WK6F8ervkDIFELq39z2awIfgQLiOrxTuRXWkjk0BP0OkjGGPaPS0zy2XW1rD2UTZItd1LxanZldtv/HxEczkQ=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 22:10:27 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::237d:96e6:7f50:e202]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::237d:96e6:7f50:e202%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 22:10:21 +0000
Message-ID: <afe71df3-48e4-837a-e85d-b6a6764eee62@oracle.com>
Date: Thu, 3 Aug 2023 23:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
Content-Language: en-GB
To: Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: martin.lau@linux.dev, bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        =?UTF-8?Q?Tomasz_Pawe=c5=82_Gajc?= <tpgxyz@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
 <ZMwQivemlha+fU5i@kernel.org>
 <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ac3de9-992d-46bb-7e6c-08db946e6c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3I/4lQE0LVwS+WkkirnWP6aedUPiUpiQ4u+LSJ3WFR7/qQTQ7NV1E8pezEPJEg+sSROqMXQspASXRzy/WDZPUgZCME65xvzEainb/BqKUvRjjs07y4SJG8s/7saYMFTf8stMMlulKp9US/o8yeMbrqPEJP1RhJBvrYRbnOnaftkQecFR7D2DsbiWs45T7lf5mj+pFmREtlIPCd5z7H3FBaxEO+GgqsGMCFevDQImhFjFSqvF2YFtEcXszQZ9rTxwr44cE9FJmA6bnQoF5j9O7iaiza7swv2XNp/FAjYfq3vJRcAEBZGMOczkmXJV+2G2yVrTNXAeUKuYVHL/MAiAhVL8YcQLq+aChGii4PMtv2DZWSM64fMPnFECkhqrQctBZHO7l3olH9CFKTjXdJl5SslnKg+q9hVPp9/M8myh3VZipcH6Z0JrUc1tVrgADR1GMitrlsr3ctoDcYoDcG39n/HuvFYaTsMn3ZaPP5D5bzC3tOoipoynHkY28SxKAM9d66gidAZrK27vI7KYtYfBYxHWS+2kvTl9Up2W4OlKYnQQaduZ8cz1Zl8+XGmYF9nQSCJAFW3rY6PHYfvkfzVnb9FwaMnL6CMzvqNJAbrZtjhjvCHm8awK1U8BqgILt5thjTRUqrwMMzuLktUp35kE/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(186006)(451199021)(54906003)(6512007)(6666004)(6486002)(966005)(110136005)(478600001)(2616005)(66946007)(6506007)(53546011)(2906002)(66556008)(4326008)(41300700001)(5660300002)(316002)(8936002)(8676002)(44832011)(66476007)(38100700002)(36756003)(16799955002)(31696002)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rm5rZ2ZWNXA2RFRWWENVN0hPSGVrejM4aExkY0d6S1BtNFYzYVVWYnJIb0hM?=
 =?utf-8?B?NmQxbEloaGhvZXlIQVA5N1ZrWHJGOEZqRnJUcnJRNjdUMUhNbTdDUmt5bCtk?=
 =?utf-8?B?am5IT20zbStGbXpFMmZHRTZidUVyUEE1cmRMZkJCQ1VMS3Z5bWZvd29DbHAr?=
 =?utf-8?B?cFVqMERUZ1pZV0VkTytNUjBXZUFCSjVySTlwanlvTEQ0cWg5NGlsT25DQzBs?=
 =?utf-8?B?c1c4SmU0R0QrekVyZ3hWS0FsREFreGJlOFNvdEtIcEY4dFpVRE4zUTV0dGwz?=
 =?utf-8?B?RU50ZjJITXZBVmNKVjZNcytadTlRaVVzK0VBNy80Y2RHWlB4SjV3TGFLbW9y?=
 =?utf-8?B?K0ovMVNQMFVQWS9KdVdtZ2swWC92KzZNendHeXN6elRwcnNDTmtCeHg3WThN?=
 =?utf-8?B?T25pbFVVT2RKZnlVekRWT21HWFpnY2RsQXFoSkY2RjkzVWMyaXc0SDZ6UXFa?=
 =?utf-8?B?dXJoNlJDK0ZyVmxlek85T0VBek1HM3BNQjhWbHhjRUdCL0NpQWxDdW8yYnlM?=
 =?utf-8?B?M1pNZjJKSzJZWms3T3h0NHhBaFVWYVNJekUrNW16andLWmlvWExnUDVwRy9H?=
 =?utf-8?B?YlJteEtROGlBT0FTMHptbmpEQTZhRHJtU2pQbjNtMThyS2RXM1FGQ09UK2Zh?=
 =?utf-8?B?T2I5Zkt1Vllab1V3MHFqaEZLTmpHZEhzclFKZ1BCMnNnVUYxdTR6WlVvWGd4?=
 =?utf-8?B?c29sN2JZVTdyZG54K3djYWNndVd0SjZDSXBpdXNPcFVXYURPQVpremFkcFFN?=
 =?utf-8?B?ZlRIYXI4dFpaQ0trVmRIS2xhb1JwUkdlZHc0N3gyTUsvR1JESURqZHk3QUpX?=
 =?utf-8?B?aWRkTGkwWkN4U0dPUlQ1Und1aHQreWk2d1NkUDBUcHRQRzNVNDJiaDRTSGQ5?=
 =?utf-8?B?TUZNUzA4UXVhWFNaR3MvclRUbGJ3NnNuZnVXY0MyZTJwQXg1cGY3cTZWZ2t5?=
 =?utf-8?B?ZW1QS2twblpJNjlNK3NrSjdDY25XNnlyL1RCOU5ncEpuZjUwcWdZaHVxVElQ?=
 =?utf-8?B?RkY1cHM0elYvS1NPaU5YTHFZMC9zUnBJMklKQXRJK044ZVdleTV1bHJiLzdp?=
 =?utf-8?B?MzVyQ0NucStGTlArMDg0bmZqNDJCK0VHVWNuTCsvZUlQS2tJN1NXdzduVjhX?=
 =?utf-8?B?VDJhQ05ST0xkMzBDY0tqK3NFa2ZsM3o1SjVEZE9VcnFGWlV0dVR0aEtJTmJE?=
 =?utf-8?B?ZEcyV20vdGhNNnBtblgxQ0VBeUo3WjhTVzBYVlZua3owS2Voek1LUVJ4U2tT?=
 =?utf-8?B?em10ZkJBUFRxWXkvRStlWjdlUW1lS0ZRWExydU40dU5nWVhGZThmMGkrMDF2?=
 =?utf-8?B?dVBsaW0vbnQ3QkNJQUZXNFRLdnk0SHRKN2N2cFNLQ0RrenJKUW10MXdoWmEy?=
 =?utf-8?B?bDBhUU81c3VxanVhanJVbUVTYzdLNlFjNG45NlF2Uko4amtTZEwxK1h5U1Qw?=
 =?utf-8?B?MFBCQWRyTkgzZ1pjZGkyMDhlZkZQYjVGTkNYbDllVG0yOUdtSkhldUZ6ZFdh?=
 =?utf-8?B?WURZWFJSMkRuQ3pTeldNMzJFVVNPWFJ4REtFZHJQMzFRQ0IxRmsxcmJJTmZ5?=
 =?utf-8?B?YWYyR0FCQm01Vnp4L05sZEZwNFdUYnU2ZElqblFzaDkvQUF6YU9qTkQ5NUg5?=
 =?utf-8?B?UVNBOEpaZkRZbDEvb01MV2VlYXdkTDlQbE1nRDh2VW1xRlhTWXUwekNrYVlq?=
 =?utf-8?B?bXlLZC9sOU16MDNYbmlpZVBZRjdYNzlvd0ppZFN0UXRXam94aldyKzA2WXRB?=
 =?utf-8?B?dnpqNml6ZkUzMUQ5c0NZbkUwNWZFbi8xNkJUR1QyUHhGTFQwNHVPZkdaRzNT?=
 =?utf-8?B?ZjRINkRDa1pTRDJvSVNhamxFMHMzZkxiamxiNDJMLzdLODZoazdqVDR1R1Ev?=
 =?utf-8?B?ejdqUFpISGRqcVBaSmZ2RjNZekwxSlVmWmViUEk5TUZvWVpZWkE3NTRMeUpv?=
 =?utf-8?B?eU1jamNvTjRhNmhSYi9PbXU2K1RnNGFHZnUxWEQrSmVuWkhKZWpNcGFuK3FW?=
 =?utf-8?B?bXRKZXV0bk1NOExkbUdTWTdkUkdaMmM5aFNaeisvQ01kNmNoQmZ0aHdQOTVm?=
 =?utf-8?B?cU1DRVE3cWl5S0k4K1hLckw3SmJWK0lvLy9ILzdRT1ZhUFRNSTNJUGV2QlRm?=
 =?utf-8?B?K1JoT25VZTJOdFBmZkZpZVV3MVdzWVhNS2Q5dEN4anZPT1VyVGNtUVJBdTYw?=
 =?utf-8?Q?TYe4LSe+JgmMriKjd6vPaxw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	g1aDlUsMXv/3s6hTkMT3Oin85FtCKgCgi/duA5IiDZj4NIS2Rvt96URHs5ToTOWA/COPMaJUqRKNEWW52jiEVCrhtGNoaoVdR2OJVH4HtTm07asoHYENZJZv6OMKM56hGqBgJs2igTtD6cY4uC/03+isL3O9Vn+car8dcV+QteSEWw5EgXXlvqexsuqwy7iBE0muweziZcEZtHGmeNZ05IdamqvTmT5vlCbykAtZW+RC1Wt1bTwlhqa3oRA7KaoXHqFQp45J46ArR6vhrZCNYd0h28XU+y1a4T3IEUN6R/HbSu+D8Dc+GZWIdTlCuEE02XGNk224zS5fPDHrHYow+wTH9vwFfng5KL1ey4CArZAvO0XN4/PkPSbe2LggS73vch4yHf7SgDEZYvA4CFZQ5jm0RdVloDT64XSUbQcBJuthvX5ZkYBxrHXgz0+RJnjM9ZTw14wXHQykj38Lp2UDDNK8JBfJjI1rnDNKK7P24ws2r76MWVKwiMZkhp/YR1poTbtYiSqvBnx+6A2waVHq/dp/iEeiUwMtKi7f24ajF1gtsKrRGIvc0lDaM2Ml61DD19fokZyE9Jznfb9+ioVaLSBt0rj5ags9z/DX/4tfTnXJbaasdB0axvxZV9kC32fY7prc8mt2jpuMpT035E+3m9wyfG6M3ezCyYNG9ZwSsURegUjSN5DLpz4W4uXd8S0oduEDjTmocZoB9pN4cojl86Slh5R1h/6xPcTu60SDAazwSHx8di1mLPZdgvj4Ch8pmeH/0qbw2IA2zDH9vjyGzDsuoni5Mmy9z7UufvdY1mSmk6os2IPawsjUHyNWXsAvIh6bGQBHduQn3sMcWxCH29oP98eN1T0BXK3Kg7ZxFO5MHtwJoAH5vIYibSVxUyeh1g7WPW45yKD8B9312fcvQYlP/G6r9Xib0scExkW+Fb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ac3de9-992d-46bb-7e6c-08db946e6c60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 22:10:21.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXow+WNkPaQn95j/xlLTgZPfdJVbqrZICzb/nMLt5i5DWnD+p5Ng6EBAOnAWDIFgpxXz7ncnBLwjqrIcpTCrAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030199
X-Proofpoint-ORIG-GUID: 8nX5SZ0iY0kqSrqykHfLM6GORI0HPkiM
X-Proofpoint-GUID: 8nX5SZ0iY0kqSrqykHfLM6GORI0HPkiM
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/08/2023 21:50, Nick Desaulniers wrote:
> On Thu, Aug 3, 2023 at 1:39 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
>>> Hi Martin (and BTF/BPF team),
>>> I've observed 2 user reports with the error from the subject of this email.
>>> https://github.com/ClangBuiltLinux/linux/issues/1825
>>> https://bbs.archlinux.org/viewtopic.php?id=284177
>>>
>>> Any chance you could take a look at these reports and help us figure
>>> out what's going wrong here?  Nathan and I haven't been able to
>>> reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
>>>
>>> Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant detail?
>>
>> Masami had a problem with new versions of compilers that was solved
>> with:
>>
>> ------------------------ 8< --------------------------------------------
>>> To check that please tweak:
>>>
>>> ⬢[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/.config
>>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>>> ⬢[acme@toolbox perf-tools-next]$
>>>
>>> i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
>>> CONFIG_DEBUG_INFO_DWARF4.
>>
>> Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.
> 
> Downgrading from the now-6-year-old DWARFv5 to now-13-year-old DWARFv4
> is not what I'd consider a fix. Someday we can move to
> DWARFv5...someday...
> 
> What you describe sounds like build success, but reduction in debug info.
> 
> The reports I'm referring to seem to result in a build failure.
>

This is a strange one. The error in question

CC .vmlinux.export.o
UPD include/generated/utsversion.h
CC init/version-timestamp.o
LD .tmp_vmlinux.btf
BTF .btf.vmlinux.bin.o
libbpf: BTF header not found
pahole: .tmp_vmlinux.btf: Invalid argument

...occurs during BTF parsing when the raw size of the BTF is smaller
than the BTF header size, which should never happen unless BTF
is corrupted. Thing is, at that stage we shouldn't be parsing BTF,
we should be generating it from DWARF. The only time pahole parses BTF
is when it's creating split BTF for modules (it parses the base BTF), or
when it's reading existing BTF, neither of which it should be doing at
this stage.

But I suspect the issue is in gen_btf() in scripts/link-vmlinux.sh.
Prior to running pahole, we call "vmlinux_link .tmp_vmlinux.btf".
If that went awry somehow and .tmp_vmlinux.btf wasn't created, it
would explain the "Invalid argument" error:

$ pahole -J nosuchfile
pahole: nosuchfile: Invalid argument

I see some clang specifics in vmlinux_link(), so I think a good
first step would be to check if .tmp_vlinux.btf exists prior
to running pahole. The submitter mentioned swapping linkers seems to
help, so that seems a promising angle. If there's a kernel .config
available I can try and reproduce the failure too. Thanks!

Alan

>>
>>   LD      .tmp_vmlinux.btf
>>   BTF     .btf.vmlinux.bin.o
>>   LD      .tmp_vmlinux.kallsyms1
>>
>> And
>>
>> / # strings /sys/kernel/btf/vmlinux | wc -l
>> 89921
>> / # strings /sys/kernel/btf/vmlinux | grep -w kfree
>> kfree
>>
>> It seems the BTF is correctly generated. (with DWARF5, the number of symbols
>> are about 30000.)
> 
> 
> 

