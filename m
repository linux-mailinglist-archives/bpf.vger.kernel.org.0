Return-Path: <bpf+bounces-2905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E31736686
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2D9281129
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E8AD48;
	Tue, 20 Jun 2023 08:41:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18221848A
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:41:12 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFDA2
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 01:41:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K0FtBw004661;
	Tue, 20 Jun 2023 08:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PnHa/vixgMby2rYzWELc5suWu2dOdr5AXH/Pt0l+zZg=;
 b=hVtJ1WEZvartB8bxz2LeX6ex2jUgc1JYNaZqwHWT4AK46usM//Dt+ZKBp4dk/6PPiY/Q
 2nszYdHsAECdAFXz44X1n68GVHyOEmUvUfJZmCHkqrkxZmK7nXNUHTXvTKs1zKG7dDpv
 Xl9pLOJRL/NXnAKfWjRI6r7MhBUSPjiJ0gwp9BEmirRH4Yk5uYmCWjruG5tDm1QFxDIx
 URtIya9r1t9+aYiu29VOaanlPFSvGqjljsGkZzGDQZW8xvTpBlg3kRQIlmn0yHWKygGo
 n3A+JQt4ZqQ3HB1IrdjlHQUodBWwDNaK2psSmoiBPzIzJfnCddcgXBTgu+xClW1lIeDd XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dm4rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 08:40:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K874Wk007973;
	Tue, 20 Jun 2023 08:40:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w14n3kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 08:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw+XW6GP1qUArcAMDxmFi16/w9X0378Vts42wuvSmE8KtC7Fm+/1C1bEK59lz1gBEj2LOsxZC0feb5Y+7nZUs1eWqzwKZtswLAa66IjrU1OyEgSWS8a8TXzv/laPM2Bnut0cxuCX839ZtITQROSrlFq6CgzgFf0oLrhAqeGka8c3G+ZMjFH73cShYc0QJpg16VK1sbWWfKLknokLve8moDwaxUVzdipZqfEWVtDUYTe0q9y9bSQF6AcIyUry5IsLz/5wLP+lM0wB7BV83Rk8rVXOT7KsN4rnkI1xkmtX/zK5xEh6S7xEJbemWdIwZKZKeFILSF5avSdngRQOPzxE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnHa/vixgMby2rYzWELc5suWu2dOdr5AXH/Pt0l+zZg=;
 b=jFrutpBnbXTGjMWQLj4QnYgplXU2TP1aMZnPlJgrkoRAms+Don0M/U8MWna1SFxdoE95BrBoC2g5utzxe41f8mQn1MjIKsfEHnjtuHFmesAUUtsdbc6DNF3wybAlZLdOexzQt7u9uFws8Krtuzk7gP6VIpNJRpP/4OSsssRTIsDMpk/p9RNDsx+Avz/upqH/bzkMp6F+mTgydbU4btKaNgNcAAdO1/clotVZVSHjXSyOm+VU1uo0eWgAeZjR4KP0BywcXZ7AsLGWLH0L4h4aS6g/UjZogunRJXwv9NtgsLbIVfPhcRTCtQgK7LduM3Ypid1ZADgGVdO61yIR1QDT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnHa/vixgMby2rYzWELc5suWu2dOdr5AXH/Pt0l+zZg=;
 b=fmBm6Fnd+33CmeyBljjYbNFDf1ROdk++cixyrYZyw4s9pEu13hYFEYwaMAWSvI7LlboSjn7GPtBES175JPEpcCDkDfO3aSufMgKCTkry0j4kJX/LAGcdxeC6cFn4rdAf4g72zHP4DE+lB7VYI2NNwFZp4cKt0ujRzcpMGzgYXwE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 08:40:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9%7]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 08:40:36 +0000
Message-ID: <3a828a25-d5fd-1ee9-a255-3f09bc546fd9@oracle.com>
Date: Tue, 20 Jun 2023 09:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 4/9] btf: support kernel parsing of BTF with
 kind layout
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-5-alan.maguire@oracle.com> <ZI8BsoyLkCPLaRG3@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZI8BsoyLkCPLaRG3@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0274.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: e41bb06b-ebb9-4ea5-2a94-08db716a046c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jp7UAcGL9atNHpydQ2GVClp9jXnyepEleJCoTr95XXTsWCyESp04Y3LhzGarbdI1Zl1vJEFZGjCZg8/Ur5VTvt9wIDf0GKTZIcNAn1c0+D+ngLk5xUBYlgr+chSSE/csnwLS5n0M5iWEWHC6R0JC8UaQI5EQrdvGBA8VkNyFkJXo2SEUraE74YuTI1v5zbPQxiP/kLrHkoXA4tk4msiRMHzSXiF1AwoAto+oWuxVtIGTpC0uf/uWMbN0vNuCgD8ALY1XamabMyvAd+fPujKIBN9BrBQFxQHP+48Eio3rosv/yhlgX9eRtBBK0t3GRlzi9WJZNE7vD1qgxXa50mZur2nMWFneYbuXejxfpzGVI4/26MBm9Q348Q2iOrClTMyLDhX1A1t/gteYsgmOeKzD0c/8XMZsiUOawceMzgwg2fmo2yQyg5aMOuq1mkI6jF16WRKBlIlk4ucQQTHyvf8EW+DJDCaQdIkCrFRo8JkfJa5fTfRLjqiitR0W7QcAUnJTJlH6E0/RmFSlmm03B85NGs4y2rB3CeY2L+V8wKfS/F6AAjSep+qvKqBtKYqrV4H3b23NhCcRzG5tszd+fTXmCsYhQBBQf52MnTvNbWogheCCm9Qx4vxxb2+ifhUxletwYCmYNdmUpdhvkPm4Mua5qw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(6486002)(478600001)(83380400001)(31696002)(86362001)(6666004)(66476007)(66556008)(66946007)(316002)(38100700002)(6512007)(53546011)(6506007)(186003)(6916009)(4326008)(2616005)(31686004)(8676002)(8936002)(5660300002)(44832011)(2906002)(7416002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVMvUStyM3hoakdkenZYdFc2TWlDU2lJYm1aYVNlNTQzTWo0S0U0L1Y5NERO?=
 =?utf-8?B?UjkzN1VSYzBIZHV6Q1Mvb0x3SVQ0NGtJYXJDQlMzU3NMV284WkhGNkhlTlRP?=
 =?utf-8?B?b2R2aFZ5T2FwZlJIOWEyQTZoNmpGdkxZZTQ2Nit3TklXdkVnN3gwSGJjWmVk?=
 =?utf-8?B?a2tTUlNId0hKWHF0a1kvbjFTellqN3c4QmVFZ3pJYUFnRzJqR2MwbEZjZTNa?=
 =?utf-8?B?eG4xRkt4eURrb29nR1dWNFRoeGtBWW50QXhxeVVIbkJVTkkwNDFEbmFFSGVG?=
 =?utf-8?B?YXdlNUxreS9zS2RwSlZCcWpuWmRIaWUyZ01XVGUwWlVaQ2hTYmFaWUo1WU4z?=
 =?utf-8?B?RzNQamR4SDNiYmt0U09RWWlNY3AxbnM4RHJnOW9JSU45QnFWdE9iWnAwR2gv?=
 =?utf-8?B?NkNFM294NFBoZExSNzBlcXdnenI0aDRDS05mSzhYTHlnOUVCZWhjVm15ZTlV?=
 =?utf-8?B?ekpFa3RxYys3emY3TmIrL1ZvemhLeHoxSFVpQzZvV1Q0eHlzUHpqS2VWSWhE?=
 =?utf-8?B?ZmJ3SmluaHVIa1RIZlFHd0hVWHBkOU5PTStZN0xMK3Ywdlc4enpzbDhzZ0RJ?=
 =?utf-8?B?dTVZMDY4OWt0cStQUjQ5enRkakthdEdIYStpRksxUjh5bmRXcXIzZkY4NEFy?=
 =?utf-8?B?YWdkdHdkVUl2dzg3Z2ZLZlFjUktRS0FpRUY5LzNKVyt3REtoUEVZejlpWUo0?=
 =?utf-8?B?S05jc3N2VUpBQTBpQW5EZVVjVWtEcDRVeUhIQTA5NUNaNVczMzlWaTR1REl0?=
 =?utf-8?B?SC9LOWFGNFRjbVp3Nzd2STN1eWk2ZDd3VVNiUmVqeGlGSHhWNWo0eTVkUUVm?=
 =?utf-8?B?TmtIV1lKbGVENGN1T0wxektQbExWK1AxV3FrQjBQQVJvZnlMZ1pkSUcxWFdz?=
 =?utf-8?B?SFNNUWRrWTByOU9PaUdxRXdhd1IvZ0JrOEVhYlRDVWxhVlZBNGk5U1FhY0hZ?=
 =?utf-8?B?RW5qbE9rVy94Z1lwbFd4SFA0SUprZHJreEZFeWxUc3lXdXN4RUlqaHhUTG9R?=
 =?utf-8?B?VENQNVRsUzBaWEd1RUI2TytrTDg4VnlsQUV3eWhaVjlrd05qTTR2SGhYSGZZ?=
 =?utf-8?B?M1J2REtkWFRidzdJSzM4OUt1Nmh3MktlY3FNQmE0T2R4UGpzamx4VGZ4Rk1G?=
 =?utf-8?B?ak1vS0xIbVQrYmpCM05JOVpDRWd0c3ozMmRxRXJMMEtOa1ZqQStJaG9vMWgy?=
 =?utf-8?B?dGE2Y2g5bDdrTGp1OWJjYmlVaTJSNXNNdjJINjY0b29ESzVtTGZMMFIwMEZs?=
 =?utf-8?B?Q1FmODhBa3dhZ0pzUEJKMXRLSldBeHJDeXRCNG5pdnQzS21xZlhXMytmMzNv?=
 =?utf-8?B?V1cwdFNpS0d5UVpMZXRMTi8rV0pxZW9ndkpFeHBnNzIyWERjMEZNbi8zRXJL?=
 =?utf-8?B?TUZlSXBEcmpmRHlXU2xTUVFZTGNJU2wrYk90QWJuSE5FQUUwZmxoakozTXRx?=
 =?utf-8?B?Qm9sbVdwNnlhWXB5VStpeGJ5U2JBWHRoTStOOWx6WTdLaFM4K3phTGdHWVpR?=
 =?utf-8?B?blgwRXJyWUI2cEMwWmd4SXB3Z3dmRlFrc1czZGNTUnNmblB3aDBqQWxIbzhl?=
 =?utf-8?B?YzBIOCszNlhHME1Ybk9vS1l5WXU4OEs0YWpwSk9qS1pDWDBDR3c3K0tNcEd2?=
 =?utf-8?B?RUc2N0puK3lxOE1UZ3lLakFlbExYNWI0RXRXRFZKQWlJQTJTeUpQYWRnS2ZR?=
 =?utf-8?B?cDF1bWdpTDNCTXdSMXdSb1N6eHAzQm5PSE9CekRYcUxjajlBczlRMkFvU3Vt?=
 =?utf-8?B?ZXFXTzZkcGJWQWpNSlgzMzF2TEsrQUFzb2M4eGFNV2wvVUtvRmdzTG9RZStE?=
 =?utf-8?B?T3Uyandaa3o4V2J2SFREdjc5Q1RHOXBTR1BKcEFKSU1NYUVGMDVjSklYaklq?=
 =?utf-8?B?bmtDQ2N5Tkh5TEdEZUhSMVFLa2FnVC9DWmk0UTYvMkZnUHFDRjAyeHVWM2kv?=
 =?utf-8?B?Z1lLcUg0T0FJVldsMDZDdm14TkoxTHFBV0xFSUFEVTVTTklLdEUvU2tjejUy?=
 =?utf-8?B?WWtlbi9FRTV3N1ZoZGZHTEtrOEdWemw1YndoY3AwMjVNbUtyaXJjL3BoWkFE?=
 =?utf-8?B?S0dTYmVMbEI2dEJNZ3I2MTg0ZlVYT2hOL0RvYW1xSmtndFNOVGRuOHVYSmZa?=
 =?utf-8?B?UTVVQ21QTXJpQWw0VEJjenRKcjljWlkwRTlJVTRSU0FCSW5EYW1JMFI2UjFE?=
 =?utf-8?Q?jMdvqeuT1DiTdXUVSaJmBIs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?YTJ6RlRIbGszZW5TMnJlQ2daRWFpUFdOOEoxWkgyZDV1K1VaNGY0N01yczFa?=
 =?utf-8?B?NzZYd1h2RHJFNEhFTStuZEdLclhhVC9KZjNBQXdKb2l3Y0RRaFdTNGxIWFBx?=
 =?utf-8?B?aWdIbVp2ckMraFlZWEN0bFU3bkY4bkhyTFNxZ0lNd1lMcTRyQjQyUHBMSDhm?=
 =?utf-8?B?dGp5YzBEcjVjRGZmNTNpUVRzRmxEVjI2NitRdUUwMmtaZ1dybjV6VFZzS3Zp?=
 =?utf-8?B?bDRjd0JGbngwWHhQRGJaeW1WZTROa2lMVnRLSUU5QlNBNWJpUTk0UUo2dEZp?=
 =?utf-8?B?YWgvQUlubjEwaEJERExtSmxoWmpSOTFNK0VuL2ZUTjNaa1Y1TXRpRW1qeS9I?=
 =?utf-8?B?NVJkTTZ2WXFSUElCOG9NQ1YwNjREaWZPdzc4bm9GZFJwYjU5YThZL3Y5dHVn?=
 =?utf-8?B?WG1QdE13SmpXYzB4Zm9ZS0l1ZXBBMmdtRHJHaVk2eEw0TjNNZmgvYURSKzNF?=
 =?utf-8?B?SFYyWjd6ZkE3VFYzeVMwbkRwc1RnblQ4UXdxWWJkOGF0aUxUSktsekQ0UHVT?=
 =?utf-8?B?UWNDbzMxUDNBbzRTYW1VREg3eHEvdFl0anhJV1c1LzV4bWlUU3p2UkhpR3Y0?=
 =?utf-8?B?WXp5WUNsZjdKTE51QTZQQ0ZmTE43cFFZbmhWb09lek5YYmUvWWhwVnNXMTFl?=
 =?utf-8?B?V284Y2llQlVubW1CZGtvam5TTncxZ2pzS1oyQXlvWXhxY0U3SlB6c045bm9s?=
 =?utf-8?B?ZlBoT0lxb1NGa2JQc3ZWOTlzcjQ2Tmc5UEExS2ZJVk50Sjk1ZTQ2cVRZby9u?=
 =?utf-8?B?N0d6UkdtbVUwTkVSeSs5WXJxOHFzNDg5SXpDc3pLNE80Mkg2NG5VY3lnb08v?=
 =?utf-8?B?SjR1WVByZU5zUm52SzFSRzZUc2V2NUpLWWNFYzV1bmFIbmRsWFlsMGFxdE1y?=
 =?utf-8?B?SUMyZDhnMENzT0I0SWhrbXBjYngreGN0Sjl2N2tFb2VmR2NsVlpQb2c0NmVy?=
 =?utf-8?B?RzhEUGRUblpTMGFSUWx2K3ZjUEY4NGZ1RmNxZlEwbHp5UHRDUzZPaUtWSFVk?=
 =?utf-8?B?V0szOWJ3RXhYaDB4Qjk0TVc4MjJIZjJ6Nkd1UlArZ1JhYmJ5REdFamt2OFhq?=
 =?utf-8?B?WGJmN08zM2hKbFgrNngva3ZSQnV4SkJyN0p3UVJzZjdLY3Qzd20wWWNYZFRr?=
 =?utf-8?B?OEJKeGNoaDF2MTlDMFMvSkZoSklnWTNTQ0tVOGdRZmxPeVZlMmFOR09NL0Fr?=
 =?utf-8?B?dzhzMUlFdHZEemtyNkFGd2NEMUViQUZiVXFZN01HaDNGSWVGRnFGZ1Nndk1q?=
 =?utf-8?B?V0hxYjN1MmxGeE43bjgxV01yT1huU05MNGFNMS9GZmNVQUY4QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41bb06b-ebb9-4ea5-2a94-08db716a046c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:40:36.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaZdN2i44OC5jn3KZINHQlOqct8Rq9iqDQj5KNB3wMBOxT6vL7FHIJ3d26Ghzr4/K9aJRB3MjRkjVWD6Vgvyjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200076
X-Proofpoint-GUID: fNiqvdtCM8wqGLy8asJSefpo251-RK9t
X-Proofpoint-ORIG-GUID: fNiqvdtCM8wqGLy8asJSefpo251-RK9t
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18/06/2023 14:08, Jiri Olsa wrote:
> On Fri, Jun 16, 2023 at 06:17:22PM +0100, Alan Maguire wrote:
> 
> SNIP
> 
>>  static int btf_sec_info_cmp(const void *a, const void *b)
>> @@ -5193,32 +5246,37 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
>>  			      u32 btf_data_size)
>>  {
>>  	struct btf_sec_info secs[ARRAY_SIZE(btf_sec_info_offset)];
>> -	u32 total, expected_total, i;
>> +	u32 nr_secs = ARRAY_SIZE(btf_sec_info_offset);
>> +	u32 total, expected_total, gap, i;
>>  	const struct btf_header *hdr;
>>  	const struct btf *btf;
>>  
>>  	btf = env->btf;
>>  	hdr = &btf->hdr;
>>  
>> +	if (hdr->hdr_len < sizeof(struct btf_header))
>> +		nr_secs--;
>> +
>>  	/* Populate the secs from hdr */
>> -	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++)
>> +	for (i = 0; i < nr_secs; i++)
>>  		secs[i] = *(struct btf_sec_info *)((void *)hdr +
>>  						   btf_sec_info_offset[i]);
>>  
>> -	sort(secs, ARRAY_SIZE(btf_sec_info_offset),
>> +	sort(secs, nr_secs,
>>  	     sizeof(struct btf_sec_info), btf_sec_info_cmp, NULL);
>>  
>>  	/* Check for gaps and overlap among sections */
>>  	total = 0;
>>  	expected_total = btf_data_size - hdr->hdr_len;
>> -	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++) {
>> +	for (i = 0; i < nr_secs; i++) {
>>  		if (expected_total < secs[i].off) {
>>  			btf_verifier_log(env, "Invalid section offset");
>>  			return -EINVAL;
>>  		}
>> -		if (total < secs[i].off) {
>> -			/* gap */
>> -			btf_verifier_log(env, "Unsupported section found");
>> +		gap = secs[i].off - total;
>> +		if (gap >= 4) {
>> +			/* gap larger than alignment gap */
>> +			btf_verifier_log(env, "Unsupported section gap found");
>>  			return -EINVAL;
> 
> this sems to break several btf header tests with:
> 
> 	do_test_raw:PASS:check 0 nsec
> 	do_test_raw:FAIL:check expected err_str:Unsupported section found
> 
> 	magic: 0xeb9f
> 	version: 1
> 	flags: 0x0
> 	hdr_len: 40
> 	type_off: 4
> 	type_len: 16
> 	str_off: 16
> 	str_len: 5
> 	btf_total_size: 61
> 	Unsupported section gap found
> 	#23/48   btf/btf_header test. Gap between hdr and type:FAIL
> 
>

thanks for spotting this Jiri! I've reworked the logic and the
messages for v3 (in progress), and these pass now.

Alan

> jirka
> 
>>  		}
>>  		if (total > secs[i].off) {
>> @@ -5230,7 +5288,7 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
>>  					 "Total section length too long");
>>  			return -EINVAL;
>>  		}
>> -		total += secs[i].len;
>> +		total += secs[i].len + gap;
>>  	}
>>  
>>  	/* There is data other than hdr and known sections */
>> @@ -5293,7 +5351,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
>>  		return -ENOTSUPP;
>>  	}
>>  
>> -	if (hdr->flags) {
>> +	if (hdr->flags & ~(BTF_FLAG_CRC_SET | BTF_FLAG_BASE_CRC_SET)) {
>>  		btf_verifier_log(env, "Unsupported flags");
>>  		return -ENOTSUPP;
>>  	}
>> @@ -5530,6 +5588,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
>>  	if (err)
>>  		goto errout;
>>  
>> +	err = btf_parse_kind_layout_sec(env);
>> +	if (err)
>> +		goto errout;
>> +
>>  	err = btf_parse_type_sec(env);
>>  	if (err)
>>  		goto errout;
>> -- 
>> 2.39.3
>>

