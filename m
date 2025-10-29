Return-Path: <bpf+bounces-72667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D6C17EE8
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B263AFD5A
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9542DEA90;
	Wed, 29 Oct 2025 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QEgOCbsL"
X-Original-To: bpf@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013060.outbound.protection.outlook.com [40.107.44.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C427F00A;
	Wed, 29 Oct 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701766; cv=fail; b=KbkFnF8NXJ+PL8xFg5P005HUNZ7lumhD2AIDGi4/3NNl34ne/kRm4HAqwnSoRdrIAgVl2cWBWQvMASq/4xMDVUI5O81Ybxp+RWbZOFJzeb2XDIkLbfJYuYG+hWLeu0xdFU3ouUzyUePi8fx6X5em9lfrqZjDLvuKOmiwARkyJ5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701766; c=relaxed/simple;
	bh=dbcRkIK4tlThcAHhN9vXmm99GAvgphvw3GGnDlrGyTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pKOZL3U2xqor+iQuJ+gfmMvmo6bFvQlK/bK0Gn3QBHuZD147GsYuIjqxlNpzaHW0dXoBLYVOM3/QtRXysvQNImFnTsKmqIRkODagETGfcexYkbl01feFgcJOsyrCZLno/TSjhWBNKqmHIZb8MvA51dw0wPRBasoEDIqo//eyoUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QEgOCbsL; arc=fail smtp.client-ip=40.107.44.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfNxJb1e72wkJpHarHV+F210Blwy87A/wYQnh2X7n8sJMdzaIcj8VsYh+NU3/a/iRddOLaNc7JRFLD33KkvfhIEexjvfb9idiYoZJX+r2uK8do4XdGl7bKujYK+etws26qAADSgm0vbcg7UaUCp5TkCCwKPx5DQ8tD1horuuajP05OXZVTC0ILEM3uO/Pruml87f1gLULD+AGucjgYUPzQvmsCDYMAI+75HPSzH1Ius7VZNZTPXQPmSWdBoJLgOST49IMr4P0905xekLtoYHMcA8zcq0aST1AbY983wnlTCAiAlMlU9NVK+TJMr7CMboo1pwHp9NXoQN6vwImjTz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCb0kJFeb0noJHf2RPIqMGBB3lQFG9xZqNYvCIwSXpk=;
 b=swCkIviijm8ubQBXrR6ATlhBgPHTHsrBgt48e7eHnPPd8HscBuDbFDWAY9laxshJoigdtJzlxTr4XHCB0M1lbJtVTHdnffVPO6gPBVDiiTIBa2TMwdXiJsg7VdaPD14CoF2OooSfdwv8rKsQ6ttdFbyLcAKgbD0zMPWDmu1zwFIAUy1mbEfNq40l2/ppAZWZL4G7JET0wyAC9qa6tha0ceuwmPIZ4Izl2louk9R7X9j/HzsFCwqo220bgfDPUkn4vHPcUUFEaXs4ZA9HwOvMQb/MTvRufrkRwOLSeyeqEyrHijzFuU7SZ4O9E3JlJVFtnjiKMyM98DWmtlZ6t8cHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCb0kJFeb0noJHf2RPIqMGBB3lQFG9xZqNYvCIwSXpk=;
 b=QEgOCbsLMrpGVeH/5yOTuEA/qxtftpsEcoRO/ScGOnzT7lX5bn12UowRGbtHPuhOF7MH9yf7l+757hwPUIUo/j+Vpi1u8J4Ipnp87r5CZcmguJVLHNeBfOKnlP/aCUr0UIfsJyfN/TubQrEpAWiwgMfthPy7VapD6QMW4ETRdv4eMCTDnPAtShAB/BBADjT06TWHldkzGKgaf+5oIoRpTyhjGwzxUVbzI/4Upz/vYDO4Z79Dof1Z72NHZHVpOmRGZFQTRPNpAlfkonptLS876zeByS4v/tusUgvlwXiLlJYpCpq12u4hczDqOcnRdefH3u6W3UoczUtoO1I2Esfwmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB7055.apcprd06.prod.outlook.com (2603:1096:990:6e::14)
 by TYSPR06MB6412.apcprd06.prod.outlook.com (2603:1096:400:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 01:35:56 +0000
Received: from JH0PR06MB7055.apcprd06.prod.outlook.com
 ([fe80::df0:e58f:7ef8:5a8d]) by JH0PR06MB7055.apcprd06.prod.outlook.com
 ([fe80::df0:e58f:7ef8:5a8d%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 01:35:56 +0000
Message-ID: <b2b8eda3-2b36-4784-a4b2-1275f3a26e43@vivo.com>
Date: Wed, 29 Oct 2025 09:35:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: Ignore the modules that failed to load
 BTF object
To: Alan Maguire <alan.maguire@oracle.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
References: <20251028135732.6489-1-cuibixuan@vivo.com>
 <CAEf4Bzbp2FYvTVz6SStj_p_ok+LLeXEAxcUiCkyWRf3wyjwi_Q@mail.gmail.com>
 <5f7583bd-2b62-46a3-b500-35c33111accb@oracle.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <5f7583bd-2b62-46a3-b500-35c33111accb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To JH0PR06MB7055.apcprd06.prod.outlook.com
 (2603:1096:990:6e::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB7055:EE_|TYSPR06MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0b2d85-2b36-4ae1-9e93-08de168b814c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUdmTXVDd2IrWDBRY0FvK1FNNldkT2hTUGVvTGduZVJEbHkrSlg3emhtTXVX?=
 =?utf-8?B?eXlVV3VNYnNZQXR1am4weG5mUzJWNSs2M1VoRDFabUs3enNwOGhxYjFacTJW?=
 =?utf-8?B?eG1JRFIwREFSYWFra1QzOGV4cy9GQUpWS0tKTzBLVDk0dGV4a2dVUVFzQ0hn?=
 =?utf-8?B?YTBmSmdCazlJRFQvMVA4clpyMlhGL1hxaytxbVlhWkMyQVlmM3dWZXVDSUFt?=
 =?utf-8?B?ZERBdFJ1RHlTZXFuYWxxMXY2RWlWcnZUK01rR0lSOTBjdklQZ1ByYUNDYWg3?=
 =?utf-8?B?MVpVWFdpUkJmWWU3eDhCZmx3VUxUcTVEVENVZ2d0MUFIbHJSWCszVVFrRDBF?=
 =?utf-8?B?NWl4ZWJPazdGc3V3eVNwQStmUm8yLzZDNEt1cTVlL1hlWU5kVGlpcmdlb2Mz?=
 =?utf-8?B?QTF3YW5DTmtJd1NNVkhmZEZnYVltT1RMRXViM2RES0FTZWN2Yi9HY2VvSjd0?=
 =?utf-8?B?UHFqSXYzYmtkWGNjVCtJT1Rob0xKVVhIdW9oZUQ1Tnk4amRYZnFQeWMxNjU5?=
 =?utf-8?B?VXdIRGE0VWVTbWJMRzZyRG84OXBqZG5rSGIxc2c0RlVoeHJHV3hvTXR4RHN4?=
 =?utf-8?B?V2MvcXYwTm5JUlUwWGJNR1RsbnFQYUdjM09sVnE0Zkgzcy9TTm1xcktLVW5m?=
 =?utf-8?B?Y0RjdnpibmdsSmVPcjA0aG1Gbi9lbVhkQXRIaTFlN25wUkx0N0FUdTNDWVJq?=
 =?utf-8?B?QnVRTTM2UWRpTk9odkhUUlN0Si9MOEZvZjMrRi9hS09Sb0w5dVhMUmJ6R0xF?=
 =?utf-8?B?Y3VKTC9jSHA3VkRRdHhPOWZ4cDZ2d29Ib2F5N0J0RURIOFo2YVNURkZEWStD?=
 =?utf-8?B?ajFYOUpHbFhINUpsQzZOcFN4SVdmYjJkT0o5V1h5eGRydElaVk9yWnc5VEc2?=
 =?utf-8?B?VDdCaW1aenh3dGY2ZmVFeDU1aDFPL2JmUTNQWUV2bnYyZjhIRDdXdVhjWlg1?=
 =?utf-8?B?WU9kdXMyaWpwaEJvelVhTjR1aTR0NFNVOGdtVko3ZEZleitWb3ZxZStUaDcw?=
 =?utf-8?B?RVY3YVhaT3JBTCt5cVFQZ2h5REtJUzBENnVHRUxPME9YMnlEcUtPWXhMempB?=
 =?utf-8?B?MlE1cXhiRklDRXVwclN1V0g5RVdTUGszQ2wxSHJmSjVqY1AzUXl1blVXcVRr?=
 =?utf-8?B?Q0FobDBmNU5EZEUrWmdLL293VzFSR2cwRW1LU2RBcmxodUtIMGJxcjNQcVdy?=
 =?utf-8?B?WTF5U1F3b20xMEo0S3BRSDl1ZzZmSkEwVHo4dGtLTHc5NGlBVkNVdVJXNmdK?=
 =?utf-8?B?cHpPVXFlcExia2tCaHdSNVFNVEVvWDVjUXVZYThpT0xodUVJN3BnL1Nwa1Nl?=
 =?utf-8?B?M09VNW5HYkxyRVNXSkozVmpxY2JNaU5uZXpDQ1FxNmpXSEw2T1ZUT3NlSXRn?=
 =?utf-8?B?SFVtUmFwSmJSMmZ3c0J4UkdQcDMzL1JsaTVySElDU2JEYWphZnJxeE9ucHRL?=
 =?utf-8?B?cU0zSFJsSTBqcGxZRVhzbU5zem4rS2Vqa3lNVUFNUUtsdW1YMkxUalZRcTgz?=
 =?utf-8?B?YnQvV05KTFJReTkyUkhNRDI1bzVQWENJMjRLZVBtS2ZCdzNZVU1GRlc2VzY0?=
 =?utf-8?B?Z2QrQTRzWlVjSUlsTXVqQy9qVkQybHRyZ0poSXdEWkk1Z3dmRFU0WkhLV1JD?=
 =?utf-8?B?UytoVEQ2akpYSGxFdGx2ZFAvaEVXYWJUbndJRHBubUU4ZThYbFhkV29xV1M5?=
 =?utf-8?B?cEhlVHF4VVdUK04yN3h0RkVObmpTaVZ5UDF2SFdWRHUwUGc1YVRZUm1MUXJB?=
 =?utf-8?B?OEVDbWtqcHNSVS9wV21GUzV4a0h2cTVNNGZMSUx4ODQ4NGhXZTR6cVVxelBX?=
 =?utf-8?B?cXNKSTJRNFR6K3lHdHVWN3RjcmJMUkVwVnJwc0p2M1h6RmpzTHZQQWd2bmlz?=
 =?utf-8?B?WjloSW92U3B0Rld4bkoxV1BPRmdXQ1NLMUxkWVY2bGVhekRxSjNrYldZNHR4?=
 =?utf-8?B?aG96c2ZvUThDN3BPNW1DYUVQTGZMT3M5L3FoMmRLYkM0T3lEeEZTS3E5MHdu?=
 =?utf-8?B?Rlk1TllNeHIzd3Bza1dRYnVDVEpOQ3RDNXV6MXhrVVpST0didkd1OWpWamph?=
 =?utf-8?Q?cs8Amt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB7055.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S25wUjY1TGthcGpWYmZ5MVRPcXZ0QlJUSzNlTSt0NmhXSnh1RzVuZDZJYkJ4?=
 =?utf-8?B?NTBjeEpxUHY1Yi9JTitpWjh6VW1PdHVCb3VxYTUwNm9YVURhRmpvSlNISnd6?=
 =?utf-8?B?a01mVEFQTUlEOFNhU21TSHRTZk1Kdzl1cXZBdjhnOTlEaGVKVUpuR1VwSTND?=
 =?utf-8?B?WDBjZ1lycHFSbXdLc0MwZkRXcGlpR1lUTHh1ZzB5NUszWE5TTXdQUkU4OVg5?=
 =?utf-8?B?UEtxcTR4UDlWMHBaUmZiQXRWZVAzRnlUcVJmbHJ1V2N0c1JsVHZJN2tnUTdT?=
 =?utf-8?B?aXJ4ekhrV0Z5YnFteVgvbWJ5citwdUpMRWZjZHlYSDJESW5JTmVsd1ZySDB1?=
 =?utf-8?B?UDdLcVJRWG5NSFZzMGtXVmUrOGV5VExWeG9IWHRDd3J3aVg4V1h2VUVVbVZh?=
 =?utf-8?B?V2h2bjdoTjR1RXcrTlJsNDRpZTBHWnhMYVRsZFliRlhqY3BPVkZjNkUxMEdE?=
 =?utf-8?B?TTlBWjl6c1dUZDlJN2ZjZWxoVFIzOXZMekRUd1dOMXQ4TWd6R1ZmN0ZHeThp?=
 =?utf-8?B?ZXNoL2RIbStOQlZ3Nm5QSHc4bmloWW53bmFTM1NhMGVDaVBPZFU1VDdrNjN5?=
 =?utf-8?B?ajJybUdBTzRyQzQ5dHp2eHFRMy9JejBjbDVaeDA1bGI1MXNMRlIzeTR3VjFa?=
 =?utf-8?B?SWZVbEwwUW9CL0d5YlBLR3FFbERLTzBNTW8vbnRHSUcvU0pVRHl0bWk0MjZW?=
 =?utf-8?B?bXVoOXVYUDIxU01lVzBlQk9jeWVzQ1Y2RjlNZnZzbkFZQlI3S3JWalFqMkZh?=
 =?utf-8?B?d0dmYk11eXZGMEl4VmlxUE10ZjdvR2xuMTZVY0svT3JYTGw5dlQyc3h1VnZa?=
 =?utf-8?B?aTdLT0xlZWZ4bXRrZ2xhR2JYK25kNU5rRUdrb2MvaVkvTHZEN3FOdlZOY01M?=
 =?utf-8?B?MUs1Z3R2SnpIT1ZPZm9tdHp2MHcwVjFldy91MExManVtMnZMYVR4TDZPVUQ2?=
 =?utf-8?B?dE1GSlBxeTdvRkcvdkNJQmIrSlpkaWFMbGprZmxCVHVKaTBTSGlxWldVckRB?=
 =?utf-8?B?bDJ5ZnFwOHNYeStjWC85S1F1azQ4dE9jWkxya1BROXNLdkg4UUU2VWJjSTNM?=
 =?utf-8?B?TEVhck1QdU1HRlNvVWZMT1BZOFNnSGVrNDRkVUY5U00zWnJSYWp2ZjloM055?=
 =?utf-8?B?UjRuN3R4dUdhSStGWEhuOVhmWWUrdXM5ZFRUeDlFUTMydnIzUy9nSXk3cVl3?=
 =?utf-8?B?cFdJa3lNKzdybC91c0xoRE5UN0ZYSlZ1U1VOU2pVTmgrbFBIby82MVAwNW9Q?=
 =?utf-8?B?S25XaXNSMkZheTRyUHBYbGVZLzV5THZUejJiY0ZkU3B6aGw1VTBoOHJhLysw?=
 =?utf-8?B?UVUzcWd6eVJWK1VvWjVtTVY2SDFIbDREak10RGRESFpsZDBEanMvSzIxenVs?=
 =?utf-8?B?bENBZnN3YWJEY3VHVnBsZGlVYWlsZVhvWm54RlhBT2pkYkRXYmJSU1hDOHl6?=
 =?utf-8?B?S0wrdHJORjJsS2c1Q1czQnc2bTMxb04yc0YzOXUyVkxsNGduTjNFRHNYOHRQ?=
 =?utf-8?B?Y3ZGU3RWU2JkVmgvKzExMHFwMnZkZms3c2VxTnVUc3RJNGFLN1lIQm14c0ZR?=
 =?utf-8?B?TnlpZ2pqNzlxQWVoeEJIeVFmbEJlSzhDc0Vkbktaa1h3Ym8ya0NjMk5EeFdh?=
 =?utf-8?B?K01lckdBSFZsSEhRMTU4SWZ2ZjZRQXgwQWlJNEs4Yk9MZjBVMzRJMVMzbmNn?=
 =?utf-8?B?RjN6ZjNqVEo2UVoyelYyWmFIUDBBb2FPRWVFbTI1VVdybG0yVXJ0K0w1QVZJ?=
 =?utf-8?B?RjNEWG9sdklBTS9wZ1ZzY0IrUmdUckJ2STBVZGlPWHhLSnMrS3FHYlBJVElj?=
 =?utf-8?B?alNCSkM1WHJDRlYvT2oyRnk4bmpRL0I3bUhrZUJkMzhHd0hwdSs3a0tDSEdy?=
 =?utf-8?B?RmRFZ01LK0VoK0xIMkVTNUpvTk0yY1N5dHpLWDl3TzlHbnRqN3J3VVBjaUVV?=
 =?utf-8?B?TVpWbmhwSVFrRkRQbldEdS9aVHoySXBwSjFsdXFaWk9xRHJvbkhPWUtuQkxp?=
 =?utf-8?B?eWpKRVBaV0luV3NuYWZKTXoyNGpQTDA5V0d3RkhuQTJEK1VZajJxRzV5d1Bn?=
 =?utf-8?B?ZlVtY1RUald5WE5kOVZ1N0JGUXVuUlFjMitYN2hBcTFtdVpNRE92aXRoZytw?=
 =?utf-8?Q?dTS98vFCIyYIY9du+UZvYjHAZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0b2d85-2b36-4ae1-9e93-08de168b814c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB7055.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 01:35:56.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+tsY83MrjdLpTi+sXd3KMm/0WkGHDDxfEW1CT7QzzDr40jpDwBuay1Y1nhB5eTGDp2xfN8PDxz/jYIEDXNk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6412

在 2025/10/29 2:21, Alan Maguire 写道:
>> It's not an expected condition to have kernel module with corrupted
>> BTF, so I don't think we should be doing this.
>>
>> pw-bot: cr
>>
> Would be good to understand this failure better. If the module is being
> built out-of-tree with relatively new pahole, it will have a .BTF.base
> section and a .BTF section; the .BTF.base section allows the module to
> carry stable references to vmlinux BTF types which then get fixed up to
> the real vmlinux BTF id references when the module is loaded. It is
> possible there are bugs in that code however, so it woul be good to
> figure that out. bpftool should dump BTF for your module using the
> .BTF.base section as base, so
> 
> bpftool btf dump file mymod.ko
> 
> should work (provided "objdump -h mymod.ko" shows a .BTF.base and .BTF
> section).  If it does, the BTF id relocation may be breaking and we
> might need to do further digging to understand where. It should relocate
> BTF kfunc ids also, but again there may be a bug lurking here.
> 
> If the BTF is loading into the kernel, comparing
> 
> bpftool btf dump -B /sys/kernel/btf file /sys/kernel/btf/mymod
> 
> ...to the .ko BTF would be valuable.
> 
> If your module only has a .BTF section and no .BTF.base section, it is
> possible it did not get (re)built against an updated vmlinux and has
> outdated type id references as a result.
Thank you, I will first look at the error reported by this module.

Bixuan Cui


