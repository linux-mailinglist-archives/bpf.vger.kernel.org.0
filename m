Return-Path: <bpf+bounces-6311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A8767D22
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8BB282307
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1A3D9C;
	Sat, 29 Jul 2023 08:30:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67442C9C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 08:30:01 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E348B46A9
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 01:29:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36T6Cb1O013146;
	Sat, 29 Jul 2023 08:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CMuP4AOZ5ae2iyFswOdRqhWPUvaxrPW0hsFFIzKsbDk=;
 b=lZ+RXv7bGFG6fUOGQAPWqy6jNZTQW9J6Pe10PItOU1LTCz/I4sCv+OXhYbZ98c7f9SG9
 MMUK98UqlJTJa5eayRzgKpHzzYW3OAL5fUEH3F8Gx7wHl4p4ZRsJI1FUFwDabDMkMVf5
 2RiH2+vs9pEmINCpu8JT5z/9SFZaa+sJ6X9sRpm44cQKRLp7uc5ZyTURrqHJr4PHtcqV
 zBC2UQKHuc8OzhUiY+5fSyqCaFuLU/ZOJpIjnqR3j/AezziSuPQHQJrL/Yg01j2hW6/V
 G8dTPKiK3dkogP2hN5GtRp6HkeV/pnEjsIL5eNl8W24VKeW72LLo19WvKkOY0ncSau2D eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd054v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jul 2023 08:29:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36T5EssV037327;
	Sat, 29 Jul 2023 08:29:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78hcq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jul 2023 08:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT92JIKmykWNCI9BDcjdBOebS7ehPTuZ4SkEvUF2woBbYoUhE4AbW+66L7KUMyzQqu1HgxIVS8WUJcAomK4A5vrVuMKvHFUu61EnqeXvzU0cY02CUusOiSDkAJz3xx/yK934yUtYfDac9Jwcm9QGFtGeni/I9hg/ZdwchD7gDvOSgBVgxZp+zI8au9N4ylFVKD3L7+DK4FfFY4rZUtLANSh/Mjryy0PcPmw6EAd3YkC6Egv0zDgh/8j7wCpSXoD5o5esq8eTb+nbwI60SbnJRZBvWSsMBwYmkwZVEN3TlwiESfTLVKNowsCRAx/v4MPEa4+hBplXbPnMNwLKIiYL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMuP4AOZ5ae2iyFswOdRqhWPUvaxrPW0hsFFIzKsbDk=;
 b=OD8NNkiUXLW63IuzQQvocl6XaOyWrsxsjjA+PeezqqJYuXFmQtQiYmetPAo4wacGyReonwHIdKyRAsopvceE9X8aG5sq3oURHdFacrEhqHXn0GcE99tHHN07eJUx6VYPrMQojLkyOG7FbGqDxP/P1dmY6EzpkARk2C+r/QuQLeaNvbUXkEXMm/c/VwicGK99l5QmL5yJVo125nEXMXWGIrDPU06l9YD0cf44FHLwas8kwMvnMVytZfPWYLi7s78DqyGbMy/u0BBbSARrCRqJgcPxQ5LjkGo/3NVLMhcLZD7ki2MW+lRHH+hNxkkjxfwFuMRANUtcKj/QsQC5Dheizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMuP4AOZ5ae2iyFswOdRqhWPUvaxrPW0hsFFIzKsbDk=;
 b=in+gU+RuWjYzCczya9mFrFy87GUIw7qwKZmf+sq4aG5rmPTmFd0gKFk6XSJFFgvca4s160F9ytI1wLjqOhXWskXoEK/J9RISIX4swdKOcNeXrVXFKqlhYiQtYe6lJDwkzLdYB8bIWqhubZ3vPrH2U/uDTD2gsIG8gifXStQC3tQ=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 08:29:36 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 08:29:36 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: GCC and binutils support for BPF V4 instructions
In-Reply-To: <CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 28 Jul 2023 16:49:07 -0700")
References: <878rb0yonc.fsf@oracle.com>
	<13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
	<87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com>
	<CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
Date: Sat, 29 Jul 2023 10:29:29 +0200
Message-ID: <87jzujnms6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH0PR10MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a86d88-2795-4cc5-3073-08db900df120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E/XnTVK+ynjModt1+EeE0jQn1nwBsko+1zwRP9TRn8FzE8BBZHYvS7rNgKSvbRNMuSP/m7UZDuUcSo4xiKowqLEv559XZvVqPQ2RE2TFxpKVnuEjWFdvCiAwOyc8GlTvGOEQ/pJylrW825D9znSloya00rxrpbmfIx9STpIkTR1yU4rms3SuHZEOjQ2VXsxgJqhlvPtQ5IB/Ghp+p2WhBuYOsdFcOx2fCuopWFjauLslGZAeHYGsEx1KDF276OZfHrNSMEjOrLEh7Nb80aI6HFzCj6cH0EZFjCYcEuzlMqW8ZksDu6mBfJNTUk3WSSpatz4Nvrbj9JfCHX8fPQ9KFBNsUV6d3lYJO7Mg1U/HVl29hwDdoKymoVI0iA6u8J30iXMgyvYS1bytqOz8FSj/E9yUiTZmxfvsytkVaW+e0zJvzfllfl35/qiqgT1kx8OBuCfuMAuTM8iPYBeth8OAF1gsW+V33DAPHeZb+BQkcuetpTEWTbCpkEjYU1SNV218X8QQGvXNpvnmDK8AOKwZi4MjKNB7YgDxbrDl/BR0TDOlZYnhG59MWm7laghxXRrB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(6486002)(6666004)(83380400001)(53546011)(6506007)(26005)(6512007)(478600001)(4326008)(6916009)(54906003)(66556008)(66946007)(66476007)(186003)(2616005)(38100700002)(8936002)(8676002)(5660300002)(2906002)(316002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WThKZ20wQm9Uc2ZuTTRIWHF6Q1JZV29KOHN2UW1ZRnhJU0VuUGFoMDNCMzdO?=
 =?utf-8?B?UUozbjJKaXljZ0g1cHFTQ2NrdmJFRG56WVNkcU1wSmJ2YjUzR2g2cXBUc0Ir?=
 =?utf-8?B?dGQzUm5DUVZMR1VSZ1JhOUxaVnF3VHN3VGNWOWx4OWFuVjNzVWVXTy9XVHdk?=
 =?utf-8?B?czhid0paZ2ZKK0NZc3RQNFlQZTJGVHdCTHJzNExydVpxTVpRMlRxdUY4cjM4?=
 =?utf-8?B?MzlsNlY5MU4yZzJJWTBXNGh0dzJxa1dWWWorMHc4RVlHNXpLMW9KOUlOZ0dG?=
 =?utf-8?B?NXNmamp1eDlPQzc2Qlhxd0xHTTV1dHVjbEFwaVUzQVo5OTNDU00wbXhpYXBB?=
 =?utf-8?B?OFVWTFVIaWdSL1FBWnNFZGZNRjRMR01FNXdhV2t0NWhlWmt1TVhraVNaZXZY?=
 =?utf-8?B?ZHJybmRXOXAzaHMwOWtyVFduUUEydUxMM05ONEhHUVlVVncwQWV5S2ZPWTlM?=
 =?utf-8?B?RVh5UE4zcWU4OEo4bzVwSnk4a2h0eTZOUkdJTk5pOWpTUzlmUjVQUFNPNkRQ?=
 =?utf-8?B?NWwzWmt4SHVNTXRBSThDVFB4am5hZFV6Tkg0NVptMHpRV0dKZW9MVmVackRE?=
 =?utf-8?B?ckZLM0tsY3kxVHNmb2VDcHp0Rm1CMm9zc1M0QVNrNE1ncWNZWXdQUStlalg5?=
 =?utf-8?B?Mkk0dHM1MkNmcXVMK2plYllyYXpGOTI5a2hveFlCcThwcmNSRkwraXoxRjFl?=
 =?utf-8?B?dkw1MTdlSVhscS9XZHV4QXY0cnY1ZC9uaU41MnQ1S2plTHdkdDh4RWpnU3hV?=
 =?utf-8?B?MXZRbW9mRG9rSnE1SDRLckpEM21mL2lzTDdPZ0NkQVZFY01YQlRJRnlHQVhH?=
 =?utf-8?B?dFEwbU1YSlpRRFJLWkZNQlVnMTlsbm0vamc5d0hGTVVOcjVRNld3eXRNTmFG?=
 =?utf-8?B?ZnFSdnVjdzNOWjV0TzUydmZ6WGJ4dUZGWDRpTHNSTkdNbmpOL2czYko1OWh1?=
 =?utf-8?B?V3FlamFaMThIN3VZc3BwNTAxL1d2bmpQR0wvVlhOdkcvQlNlcTNVVXBIVEFM?=
 =?utf-8?B?K1BPYzJEZTZISC80dzJSRytMTk5iQjI0YXE0NWdtbVNXZnU0S0duTThxR1Qr?=
 =?utf-8?B?WmNIM1o0S0h1V1N3amJkL2tpdGNKUjRESmVKNFF3V01aRDZSV1o3MEhXNUNt?=
 =?utf-8?B?TjN4RzBhNzg2RFk3VEx4U29tSVVlY0hKSk1xeDJ6aHJJeEFtUGFyZU94RXVS?=
 =?utf-8?B?RitEYkFqT3hocUd3RU40NEhGUFNjMWZ3MUNmcm0wbjhOOERlRWpBOFZtQmFn?=
 =?utf-8?B?UjBKMmhabndXMnd2WVRtMVJQUTI5TFE0MmdJbmsvNC9oY2FWWllEOXYwdjVM?=
 =?utf-8?B?Ym50dHFVMW4xZFN5TzdzUW5scEpGWi91cGd0QThRVTRiY1QveEFKZis1bktL?=
 =?utf-8?B?Z2d6VVUzd2h1cXpWMmNTRUN3QmR6Vlg4bGpwWUl2NUUvWFlWT2dvdHMzSVVI?=
 =?utf-8?B?Y1UwajFJNlZjZFR6MHFkMTRyOVdKYkJUNkpEbUg4RHRkMll6NGZOcVFHQ2dX?=
 =?utf-8?B?c1BGeFp3M2kxWkhrcldnNHE0SC9MUmNnZGg2Y2dxcnBuRXBkWm56ckpBc2da?=
 =?utf-8?B?c09sTTM4QnNPdUhQaVczeEt1UXRkajRYeEg4N3JhaHJUMC9ERDVTamdBckc2?=
 =?utf-8?B?Y2ZiUXBOaERpL3M0aWFkek5KNjJQUnBUeWxPRkVjS1ZiS3lNTU1ENU51bEhH?=
 =?utf-8?B?cTdQemJZNG5HVU9CNFh6bS82YytxK3RyZWE0WkxoVGlJUEtzUDZMS1Vta0JQ?=
 =?utf-8?B?VFRvNWpFWTBsb01tb0RkRlJqQ1BwZDNXQjhHMU4rV0d3WmU3WnVDT1Z1NmxP?=
 =?utf-8?B?c3ZDMkxjU0ZQQmZNaWRCL3dDR04rZmVLNWM1MU8vWW1aUnkveWxybm1URUJD?=
 =?utf-8?B?THZJekRrb3dpcWtIVm5nUnZqb3pvQStDMWZNSmNWRTRwWmQ3bng2dnQyZTZn?=
 =?utf-8?B?am1ZUVNrUlRXZ0FsbkpnTThpQnJRWi9nOXRjbURJb2J3NEV6bTFiSldNQWxZ?=
 =?utf-8?B?cEo4bU84OVBFWDNPTHJDYmwzWWpuNXQ0YXVwY3M1cFZOQTluU0YxL1RnWDhs?=
 =?utf-8?B?enJ2TmUwSVptMVJSdDh0dXFGYlFmUmJnWS92RFZVOFFTZ04zRWdab2pRcmtN?=
 =?utf-8?B?TUp3bUhvbENqTVpaMTNvbURESEVDc2RTZUxheTdPVGlsUTlSR3d0dDZoc0VZ?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W83oZnJ6MwxF6KSQaUfAPQ4Dmgi6uHG0YRIApSDxGEtpHq9ICEbyeHMmYODWQuR7GuG7123lCv1HRxe8YTGJe23tJesWDbaiajjVrz5t+laGoa3FV3hSygryo0Rm2Ov/yDoxpNyDdB12N8eCZYqEbRR5PsNW8JjxPlbzjgQO++QvMMKCEhPEIoHPhEFou/VDlDaTVffpQFpp591OdmkhHacmuh/4fT0LRaKVwwjfgUHXrj1l3z+18daWNZX+v7ISE5VFvpJrD7T7ZeU+H7NbsiDYqW0kIx7uIavm5P42zFgC5ccP+OewtbbJOC8HN3ZD5gNlzBrrwYSrz8NWPkrztOZqDlrLwMi/mM5k4YzFUWNc5ma9Zv8bJUKNI3P9qUY6oFAHuueyF5EF3OdA2/jwuAO4xPBHEPk3uqYHK3AtCZRRYY2nxVSrPzi2X+2tCM4T5Eqd6XsE/FKoWza6rl9+9sHJ8bj8iKNxQbCXLgR3sHtCGmptASLe923lqekUYlm+n5VXC4gLoFfXu4cmgcigiKU0J0p5ZoIA+SgwqDDzVcb3cOQ4bsMNE/GVj15Oftso65yN8IDGOOUWzL8G+5qP34kJlSdAfXkTqHK4CEwn+/PdmdcypSUQsj2VHOqLvpl6o3rb6zo1GEC6FSONFdo7FWynLom0rNiHjY+ZMyJoyIXNvrMubiwqLXoB7whp0ojeLWTA/sO94Ig+U3TEEb/SSL4rU7vB8lMy+1xT2+6TYmkqIsYImktKCMz6kxXVca2Th5MxoB6qJqTt7gKNziV8waB55Qqtxw0C+oHPNBwuyiBg8QuwNbVDLFKynDFVrZs8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a86d88-2795-4cc5-3073-08db900df120
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 08:29:36.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh4UcGWFpLsPEGgtJqKKhCDcyIO1HygmF5V5FU+62AiZ5iNBhvNBrx9j+PDDC7QiGYlQQXAhYv+FTi/XbpZR6I8ufefOkg+WL+m5zGogp2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307290077
X-Proofpoint-GUID: ccVIEyLq-nfsveQo-2BW7ibmbCIVfPK1
X-Proofpoint-ORIG-GUID: ccVIEyLq-nfsveQo-2BW7ibmbCIVfPK1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Fri, Jul 28, 2023 at 11:01=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> >> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
>> >>> Hello.
>> >>> Just a heads up regarding the new BPF V4 instructions and their
>> >>> support
>> >>> in the GNU Toolchain.
>> >>> V4 sdiv/smod instructions
>> >>>    Binutils has been updated to use the V4 encoding of these
>> >>>    instructions, which used to be part of the xbpf testing dialect u=
sed
>> >>>    in GCC.  GCC generates these instructions for signed division whe=
n
>> >>>    -mcpu=3Dv4 or higher.
>> >>> V4 sign-extending register move instructions
>> >>> V4 signed load instructions
>> >>> V4 byte swap instructions
>> >>>    Supported in assembler, disassembler and linker.  GCC generates
>> >>> these
>> >>>    instructions when -mcpu=3Dv4 or higher.
>> >>> V4 32-bit unconditional jump instruction
>> >>>    Supported in assembler and disassembler.  GCC doesn't generate
>> >>> that
>> >>>    instruction.
>> >>>    However, the assembler has been expanded in order to perform the
>> >>>    following relaxations when the disp16 field of a jump instruction=
 is
>> >>>    known at assembly time, and is overflown, unless -mno-relax is
>> >>>    specified:
>> >>>      JA disp16  -> JAL disp32
>> >>>      Jxx disp16 -> Jxx +1; JA +1; JAL disp32
>> >>>    Where Jxx is one of the conditional jump instructions such as
>> >>> jeq,
>> >>>    jlt, etc.
>> >>
>> >> Sounds great. The above 'JA/Jxx disp16' transformation matches
>> >> what llvm did as well.
>> >
>> > Not by chance ;)
>> >
>> > Now what is pending in binutils is to relax these jumps in the linker =
as
>> > well.  But it is very low priority, compared to get these kernel
>> > selftests building and running.  So it will happen, but probably not
>> > anytime soon.
>>
>> By the way, for doing things like that (further object transformations
>> by linkers and the like) we will need to have the ELF files annotated
>> with:
>>
>> - The BPF cpu version the object was compiled for: v1, v2, v3, v4, and
>>
>> - Individual flags specifying the BPF cpu capabilities (alu32, bswap,
>>   jmp32, etc) required/expected by the code in the object.
>>
>> Note it is interesting to being able to denote both, for flexibility.
>>
>> There are 32 bits available for machine-specific flags in e_flags, which
>> are commonly used for this purpose by other arches.  For BPF I would
>> suggest something like:
>>
>> #define EF_BPF_ALU32  0x00000001
>> #define EF_BPF_JMP32  0x00000002
>> #define EF_BPF_BSWAP  0x00000004
>> #define EF_BPF_SDIV   0x00000008
>> #define EF_BPF_CPUVER 0x00FF0000
>
> Interesting idea. I don't mind, but what are we going to do with this inf=
o?
> I cannot think of anything useful libbpf could do with it.
> For other archs such flags make sense, since disasm of everything
> to discover properties is hard. For BPF we will parse all insns anyway,
> so additional info in ELF doesn't give any additional insight.

I mainly had link-time relaxation in mind.  The linker needs to know
what instructions are available (JMP32 or not) in order to decide what
to relax, and to what.

Also as you mention the disassembler can look in the object to determine
which instructions shall be recognized and with insructions shall be
reported as <unknown>.  Right now it is necessary to pass an explicit
option to the assembler, and the default is v4.

