Return-Path: <bpf+bounces-35660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46DE93C918
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A131C22238
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AD13A40C;
	Thu, 25 Jul 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lNX0FfLs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D61369B6;
	Thu, 25 Jul 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936831; cv=fail; b=hABCOan6CR2BPurUwlOKdsIgnXXH295BGb2AwYWZCca67aHg+Hgx0AbE+HtHGJxEUJqUnGP3EuvUTSuPHbCXJf6gg2QRPVenrkEyfiVGojKh4rOuw7BcNwEEJdj5TjwGeEQP5twv3X+0PPNHRA2yvOvH/1m5zVTcHNkbCMOdboM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936831; c=relaxed/simple;
	bh=+Yczro+om99Ko9bHIr/0k+lm5q3gjx+qIh3hINY1KQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WWqhjzdXeLw/Tttr0WgCq+d47PIQF46wEg8FhiJKt/4HGrMadBy3T3khkWrZ/4ZsYEWN2hXKBRjKD+JbPcwmVxIUMzfAaqTovRLI3pEkMisA2oiFE/4X7N1wXd4atn1ILj4EVx79S4NvR2eiwe2NtbO7GZ/lz5dv7i5Jy6bVFt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lNX0FfLs; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PJXMVW018713;
	Thu, 25 Jul 2024 12:47:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=+Yczro+om99Ko9bHIr/0k+lm5q3gjx+qIh3hINY1KQ0
	=; b=lNX0FfLsVb0OiZPcKlz2f44vwvgB1swHu7hgccfaHEckV2gXrCEw4pqwVg9
	d3JfMbD1aA/n7u/bjo1tX8AiXtSM6e+5JZfkBfMO0/N7nq4qjrOMF6cFnguhkFOG
	ia0Ba5bR4Cm4VANp4bz/KqLpOKmkoQlPn/NzT1I+DnG4P1cyePejzu9xT6OFSljO
	WSYUBLmSdyZAE12t2rzQdLI9hY9VeiiYcbbUvDx70i7RQeluapQ8f3//XH/oVYgj
	Wk279X9kruFusODzc+WgW455PYjtCHCOPDvXLNkQIlF3a/j0HmF/bbhzo1oTB/zB
	HQ/jTX68Y74oZYStnyQdUp7mhTg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40khqf4yn0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRtgo/NlAqw4gov7SOU8P47G/1eSnd8s/XcnqOhsjdCfYwSo39z8wmX6RlYtOQXcXf8i3LATdeFq0VXhFyZwD4DeL0Zuv0DqAf2+L/YW5X8we/tCL4xdpaBbg5MBnUYTxO9dil1/sPcE/ykxq5ahShP8jCw8ux+YA6iqxeqo1IcnrXdvP0NIA3tiPu5I6FJuIMrRy9kWVm2TuUhvYKZPTsUetgi48xVVqAkjUgozhh+yeBLU5CD5nxMjeRLFXlfZpX0aCTHGv8dQFZ2llbtyYQkWMZM4HGBNUBAcnH1hExy+zGy7wVpfpvKumMQpLfnWizGDTX0gBRYEA1Q5eqFNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yczro+om99Ko9bHIr/0k+lm5q3gjx+qIh3hINY1KQ0=;
 b=M1XuodbHPnZQ6Q5c+aesKC0WK9nqRa7p6UU9cJFcDoQSjcp1WxepY69dMdGrpeh/Oxt0uRma57lGVLlDsBISm1XNW4JGDN+YOJXMF448HPBgpvmbASQakf/f1MID9YVDgm1Kg5+nN+oLJ77bJzZev4DE0xcD1v3UwzoNCjhirJGZtm9d6BZKX83cI/AuETm9woEt1uOQxhfWT3/WfhBCH7niqYIgmib6n8nzDZvhhfLhrhBzVtLU6RoPD+zIC08CSe+nbeZ2V+6pFgxPNySn6ptOktoopYwR1Dn44lz8lVQ+djFsQGrntNf6d1ab5Y63sLiqlYLfREWwcTahG4w0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by DM4PR15MB5591.namprd15.prod.outlook.com (2603:10b6:8:109::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 19:47:05 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%7]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 19:47:04 +0000
From: Manu Bretelle <chantra@meta.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: pull-request: bpf 2024-07-25
Thread-Topic: pull-request: bpf 2024-07-25
Thread-Index:
 AQHa3offaQgMHizIvEanecrbrzKztrIHcK8AgAALwwCAAADXAIAARwWAgAAC7QCAABKBgA==
Date: Thu, 25 Jul 2024 19:47:04 +0000
Message-ID: <804E813B-9F16-486F-9E92-EB8B3F84C5CB@meta.com>
References: <20240725114312.32197-1-daniel@iogearbox.net>
 <20240725063054.0f82cff5@kernel.org>
 <ce07f53f-bbe3-77d1-df59-ab5ce9e750d2@iogearbox.net>
 <20240725071600.2b9c0f62@kernel.org>
 <76460C8C-42B3-454F-BD5D-2815E6FB598A@meta.com>
 <20240725114040.26c1f483@kernel.org>
In-Reply-To: <20240725114040.26c1f483@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|DM4PR15MB5591:EE_
x-ms-office365-filtering-correlation-id: 35ba62be-3302-4d9a-02bc-08dcace28f2d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkE1M2dVcVVmWFFZclBKRk9xaGlLRHdjWWxvTFdKR0RQZkhTdmJQb3Y1anBo?=
 =?utf-8?B?Qk96aGQraXRKTG8wbStISmxBS1dDdXQ3TDdpYTNGMytjOU1mOUNIdkNiVVlG?=
 =?utf-8?B?cU0zeDFvdzNVMWxnK1RVeFBFY2dwQThLbzdiK0oyeTZzNE44K3ZXLzV2MSsx?=
 =?utf-8?B?NGsyTmljRTlVeG4wTkNKYmdkR1o5ZjkvNFRIQUNBSFdjMkhHcnBhUXVHUXpZ?=
 =?utf-8?B?Vy9oVi92UXFWUTN5R0xWTHMwL3FXV2RQTWt4SldwZFEwOHdHN3FCTUZEdEEr?=
 =?utf-8?B?eWpua1FvMDIzNURFd2ZrU2hrSzlNVnJmSkx2TFZObzBKWCtUd1c3NG40SUZt?=
 =?utf-8?B?Tkoxa2pnYzIzMVVuMkMwRjhFeW9jU05pWDF3SzZ2S2Vkai9IMmxKcVMxcy9r?=
 =?utf-8?B?M1o4ZVN3MWxIMFBvcFhZbDlqeDhVWW9PZU9SZXhDMkhkRmZBVmFFR0tLdWdJ?=
 =?utf-8?B?WXNUWjF2eFluT1dSc2ZoRUJLMFljL2FNZjBad3dVbEVxK3N6TUJQcG9obUtO?=
 =?utf-8?B?NkFGM1lEazNMdW1ZNnBGZmdNTGpUSU1qTlhMaWtKV1U4SWlmOEoxa0htWml3?=
 =?utf-8?B?N0V5VlovaU9nSVRIK09hVy9NQVZId2pKN1FnWXpwalR0clhQWHJjVWgxMUU0?=
 =?utf-8?B?NHJzZWl2bExYbzRpbXE4YXdZdmJSbWx0MExvdjE4am5HN2U0N1JaMi9IOTRS?=
 =?utf-8?B?cS9jN0hNRlR1Ymp0Qi9zWmV1TEY2NVlnS0p5bGJCbnpoTnpLT3U3cEZqNUY4?=
 =?utf-8?B?NzJud29CNlQ5cXBHT3lUZXZFcGtQdjd5TW1JQ21vY1M4S0VwYmFqWjMyczNZ?=
 =?utf-8?B?WTlOd2xWQWlrbm16U24zM1BJMVlacm5yWDlaaTVBOHBEblZQZW5wRlFRcWJC?=
 =?utf-8?B?c1UvVGJvQjRnelFTRlB4QW1NTkJIMFdGZHhuRWZPQmxxRDZJTHVnKy90anFR?=
 =?utf-8?B?eUdDUllkZlZMWmtNTHAzSFNsc0tYNVdlS2dJNndSaTFyODVQa2tNUDBQU042?=
 =?utf-8?B?Sll6NkZZWnBaWU1POElEOHNodFJGWXhVUlE2WVF3d0hrOFRmVnpMWi9Nck91?=
 =?utf-8?B?WWNaL1NOOWlOaUhJSklGQXRYYlozWlBYWGZNU3lCMk9BbllBVmo0clgvb2hS?=
 =?utf-8?B?dEVoeHpOYVlXVkJSTDdXencyMzR6S2hNM001cHFMeU04VTU0cG8wTWFBdlpv?=
 =?utf-8?B?WFd0WHdLZVlQR1d3YnU0azlqaDEvUmJvYWw1SllldTlBYmQvNnVGMnhqUjl2?=
 =?utf-8?B?MjlaNlZQRjRFbGgzZTFKSzJuSFZ5dFl4SjZWeXgxOGNsSXFhd2x6SUpwV3Rw?=
 =?utf-8?B?MVZHbS9lNGdaQTlIOEwrUTFUc1pORnhzMDRWbWhHNzJpUjQ1OFVlVk9JMjhP?=
 =?utf-8?B?TllGRGl2ZVN5Z2lhVW5hTzc4Qy96SmtoVjNnTVRpN3RvMmFMYWJMNm44UlhN?=
 =?utf-8?B?Q2Vzendpa1Z0OGdFUzNuR2NCQUwyMS8xdVFZcGR4ekZFZFdDWEl3WDdhLzA1?=
 =?utf-8?B?dXBWK3NRMTE2M2pyU3lkRGtFOEpDNUtGelJYNU9WZEFnNVpRaEtJREhrUGtB?=
 =?utf-8?B?L0NEM3U3NUtaMlhKWGRuS21FOGFFOVU1VC9pN3FxYzhMaXUwSDR6UkhxODBn?=
 =?utf-8?B?Y0ltWmdSWjBtMmRhU1ZmeWVEUExoODUxcGZBN2dWMmM1amVTemx1UmJ5U1pU?=
 =?utf-8?B?NWdlN0RycmVCa1l2ZVhidC9BWGN6eGxsYVZLNGk4YlBZN0w1eFhCOFlwRnVC?=
 =?utf-8?B?ekZUaWdIS2pYWGdraHBhWi9BajhoRURnclJMUi9vVHdJMlpCd2FlSDBGQ21t?=
 =?utf-8?B?Y2xoOW1EQjFqdkhNNFA0ajdLWXFFRzVvbkJXcERCaVdWcDhCUUMrT013dmVh?=
 =?utf-8?B?QTNIS2JLK08vYlBxNTN5SXdOVGhIb0hOYUh1SVRjRXJXblE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFU4Uy85TDlOVTRsZUVzT1B5ZGoxYUx2dnFlWWpuUUM4MHI0WDZ4YkpJcDBi?=
 =?utf-8?B?RlZBUkl1eFA0MFpTaEtPY29hOVplNTQ4aHZqbFJvUDdsdTFGczFQa0I0RU40?=
 =?utf-8?B?WW1BbFpwLzRnem03eWFsVTlJV1YzWWNPa3hROU1IQjVKZW41WFhXQUN5ZG96?=
 =?utf-8?B?c0JXMUtiOStCM3lwMThaS2d1YWRUKytvSHVmdXNQNWRHUjE3aW5nbmpXR0kw?=
 =?utf-8?B?dStlZVA4V05YMGRrZUNqdmxGamlXRUZoL0VMWStHeFJEUzNXTStVK3lnMHZx?=
 =?utf-8?B?MndMQlh2dXFXazhvNm1FZ1hEM1NRWE5vLzlDVkVoaThSTFhSQ2w4Q3lwRTNx?=
 =?utf-8?B?V3lOc014ZmhJVlhoMVhtaE1ibmxYNEdvZzlVZUY1MWFVM3AzYzM4Y2JhTnhv?=
 =?utf-8?B?c3ppOWdsV3l6QnpsZ1pkQ0tDYmpid05YTCs1WjVQTlZUYW9vanZrc2xSbEJ6?=
 =?utf-8?B?MEU3VUhpWU9ZczRDQVE5akE5ZUM1U1pEV2xSTFh5aWtPSmNmMXUwWStFQXg4?=
 =?utf-8?B?U3BCc3daeDl1Rm96WTAwVkRuRmdQa2Vxbm0zK2dUVXZnT0JiUWdkTFpocHR3?=
 =?utf-8?B?MTF5WTlHTUpvZmRQTHFOaTJkRjdIVW44eGRaaURtY1hHMTRrKzJJQlg3VGJz?=
 =?utf-8?B?YStFOFA5Mi9vY2xZekFkOENVWkVaMm96cWcybk8rSVJvYUtneGtLRyt2V20x?=
 =?utf-8?B?UDYxRE1GSGdVQ1Ara1Y5Z1hGU0s4eWJOTm1PelV1NVd4LzFCb2VrNlh1ZnNi?=
 =?utf-8?B?ZVVSZDJiNDRXcmtJanpacW10VWlabWkzUlIySkZER2pHUWxaQ1FOWkdqOEFO?=
 =?utf-8?B?dFJ0blVqRXJ4Ync3RzFpcUtTZ1Z2bmVPTnh0NGNJNmpqUVRMLzFEWW92emdZ?=
 =?utf-8?B?WDhNczEyOEVPR1hBV2tIc1AwOWc2VHNGNm9lUk1BYTBPT0h1bWFsNVlia29I?=
 =?utf-8?B?OTNNa1ZoTk9VYWZtZks3UGFPZk9xY3JUNDRGWW1EVHhNU09lVXNQK0l6M0Vr?=
 =?utf-8?B?OGlTZjg1cDNJZzMzOVg0M011UHRnV3pLRlcyRHNEeTI4V0tvU2s5eDk1RjhV?=
 =?utf-8?B?YTE0cTRnYVkya2hTSmdLbmtyQWJsQWkyajBqSXgzdVZFeWJ4TTExRnhmYUZ3?=
 =?utf-8?B?UisyRkpZM1FYYUNsYVQyWkxYcVl5SjBKdVk2eDdrdHJqTmpZM1JldE40STRM?=
 =?utf-8?B?SE5TcThPQzJqSkkxRDNmME84L1BnZnBjTzRzYWRvbDlXaEdCZnBvY3FOa0cx?=
 =?utf-8?B?a1dheFdqdG5LVEF6Z0ZGRmFyNnIwajdRQUZwaVlPenB1V1lZdU84OG96NUE2?=
 =?utf-8?B?QTA2MlZHTjY3a3owTWJIbmtWUnVraWZ0dzFtZjZ3ZndCd1duZHlCMnZwMXZs?=
 =?utf-8?B?akxiUjY5L0ZDSTMvSFZNc2tvNkNjOStvek5laXJHUVVBdzE5blMxWTlsZmdZ?=
 =?utf-8?B?Z2VwRjZvQ2lzeUU5dW4zMGdERk1FS1JLR3FEVVpXTWltUjN2SVRoYjVzalNM?=
 =?utf-8?B?N2k5a1l4UE12VnA5UWVOenZFVmlFMVc5TTVuYWRIbEo2UXJSckhlelpxb1FR?=
 =?utf-8?B?NFhzWFZ2cHF0QkhGSG9HMWRVNkhuS0VrTTZtVnMwTGN2TnFINmxsZVo0SEZr?=
 =?utf-8?B?N01ReGVJdDZ0UHRDVTB2Z3ZZS0NlYXdiSnFoRVRKOWlMMmJ6VEwrZUJFM3lC?=
 =?utf-8?B?K3dVQk5NU2VmNTRxTHdyb2lYZk5VaUNhc3NHbUF4OEFYTUNZc0JZR0VsdC84?=
 =?utf-8?B?QjNtYnZpN3dERjdtOG8wOHdBV3c2Ti9oQ21LRzgzMGxzdFpKbkdDaUZ3Q0Qr?=
 =?utf-8?B?TWRJUUhRUzFTN1VKMTNmcVRxb2pQR2pPTVNUREc0ZFlNeFlsUFM3OGRzb1px?=
 =?utf-8?B?NlVaeTBNNGtjRmJGQ1JCSk5OQmdkQTQ3WWVyNXBHeUQzVDZGbkE3L3NMS1Vq?=
 =?utf-8?B?a0hMZjZrUzNSRk9WNnhYOTlxU3FIU1FBS0I0aW1Obm5WZ3N0WlJpOUtuUmxM?=
 =?utf-8?B?NzJ4SjRHQ2pRU0JuYVM1MlNwRFBySkV2ODNsSHE0a2R6TGQvbVdlOXp1Y0NG?=
 =?utf-8?B?YzBnSjA3OTZ2bVhIMXg1bE1hUG1aQXNCcU56Vjd2NGx0YTVGQTA1QXR1V3Yw?=
 =?utf-8?B?QXVLazBnZjNwTmFuYkdBTEVVb2luS2RQQXIwZTgrUFFpbE9iNDdGNisyZE1R?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <563C00EA716CCA47B06A2D4040E762A4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ba62be-3302-4d9a-02bc-08dcace28f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 19:47:04.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WdeG5/vdLpGLYjgy0I+cx3SYvzMYCWPd3tPzS19it88nIs96BZbFiz7loAlwgPFEGWtZ32T4xhXCZ2ezjxg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5591
X-Proofpoint-GUID: AQoSUCpB108okuAJEVnGftVgcUCCnSqa
X-Proofpoint-ORIG-GUID: AQoSUCpB108okuAJEVnGftVgcUCCnSqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_19,2024-07-25_03,2024-05-17_01

DQoNCj4gT24gSnVsIDI1LCAyMDI0LCBhdCAxMTo0MOKAr0FNLCBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gdGhlIExMVk0xOSBJIHNlZSB0
aGlzIGluIGFsbCBvdXRwdXRzOg0KPiBhcjogbGliTExWTS5zby4xOS4wOiBjYW5ub3Qgb3BlbiBz
aGFyZWQgb2JqZWN0IGZpbGU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4gDQo+IEJ1dCBw
cmVzdW1hYmx5IHRoYXQncyBoYXJtbGVzcywgdGhlbi4NCg0KT2ggSSBzZWUuIEl0IHNlZW1zIHRo
aXMgaXMgb25seSBhZmZlY3RpbmcgZ2NjIGJ1aWxkcy4NCg0KU2VlbSB0aGF0IG5tL2FyIGFyZSBu
b3QgYWZmZWN0ZWQ6DQoNCiMgbGRkIC91c3IvYmluL2FyIC91c3IvYmluL25tDQovdXNyL2Jpbi9h
cjoNCiAgICAgICAgbGludXgtdmRzby5zby4xICgweDAwMDA3ZmZmYTczNzYwMDApDQogICAgICAg
IGxpYmJmZC0yLjM0LXN5c3RlbS5zbyA9PiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYmZkLTIu
MzQtc3lzdGVtLnNvICgweDAwMDA3ZjZlOTA2MDkwMDApDQogICAgICAgIGxpYmMuc28uNiA9PiAv
bGliL3g4Nl82NC1saW51eC1nbnUvbGliYy5zby42ICgweDAwMDA3ZjZlOTA0MTcwMDApDQogICAg
ICAgIGxpYnouc28uMSA9PiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliei5zby4xICgweDAwMDA3
ZjZlOTAzZmIwMDApDQogICAgICAgIGxpYmRsLnNvLjIgPT4gL2xpYi94ODZfNjQtbGludXgtZ251
L2xpYmRsLnNvLjIgKDB4MDAwMDdmNmU5MDNmNTAwMCkNCiAgICAgICAgL2xpYjY0L2xkLWxpbnV4
LXg4Ni02NC5zby4yICgweDAwMDA3ZjZlOTA3NmUwMDApDQovdXNyL2Jpbi9ubToNCiAgICAgICAg
bGludXgtdmRzby5zby4xICgweDAwMDA3ZmZkODE3YWQwMDApDQogICAgICAgIGxpYmJmZC0yLjM0
LXN5c3RlbS5zbyA9PiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYmZkLTIuMzQtc3lzdGVtLnNv
ICgweDAwMDA3ZjA5ZGM0YWIwMDApDQogICAgICAgIGxpYmMuc28uNiA9PiAvbGliL3g4Nl82NC1s
aW51eC1nbnUvbGliYy5zby42ICgweDAwMDA3ZjA5ZGMyYjkwMDApDQogICAgICAgIGxpYnouc28u
MSA9PiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliei5zby4xICgweDAwMDA3ZjA5ZGMyOWQwMDAp
DQogICAgICAgIGxpYmRsLnNvLjIgPT4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmRsLnNvLjIg
KDB4MDAwMDdmMDlkYzI5NzAwMCkNCiAgICAgICAgL2xpYjY0L2xkLWxpbnV4LXg4Ni02NC5zby4y
ICgweDAwMDA3ZjA5ZGM2MGMwMDApDQoNCg0KYnV0IHRoZSDigJxsbHZt4oCdIHZlcnNpb25zIGFy
ZToNCg0KIyBsZGQgL3Vzci9iaW4vbGx2bS1hciAvdXNyL2Jpbi9sbHZtLW5tDQovdXNyL2Jpbi9s
bHZtLWFyOg0KICAgICAgICBsaW51eC12ZHNvLnNvLjEgKDB4MDAwMDdmZmQ2NzViMjAwMCkNCiAg
ICAgICAgbGliTExWTS5zby4xOS4wID0+IG5vdCBmb3VuZA0KICAgICAgICBsaWJwdGhyZWFkLnNv
LjAgPT4gL2xpYi94ODZfNjQtbGludXgtZ251L2xpYnB0aHJlYWQuc28uMCAoMHgwMDAwN2ZlMGJh
MjFkMDAwKQ0KICAgICAgICBsaWJzdGRjKysuc28uNiA9PiAvbGliL3g4Nl82NC1saW51eC1nbnUv
bGlic3RkYysrLnNvLjYgKDB4MDAwMDdmZTBiYTAzYjAwMCkNCiAgICAgICAgbGlibS5zby42ID0+
IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJtLnNvLjYgKDB4MDAwMDdmZTBiOWVlYzAwMCkNCiAg
ICAgICAgbGliZ2NjX3Muc28uMSA9PiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliZ2NjX3Muc28u
MSAoMHgwMDAwN2ZlMGI5ZWQxMDAwKQ0KICAgICAgICBsaWJjLnNvLjYgPT4gL2xpYi94ODZfNjQt
bGludXgtZ251L2xpYmMuc28uNiAoMHgwMDAwN2ZlMGI5Y2RmMDAwKQ0KICAgICAgICAvbGliNjQv
bGQtbGludXgteDg2LTY0LnNvLjIgKDB4MDAwMDdmZTBiYTI2MDAwMCkNCi91c3IvYmluL2xsdm0t
bm06DQogICAgICAgIGxpbnV4LXZkc28uc28uMSAoMHgwMDAwN2ZmZWNkNmVhMDAwKQ0KICAgICAg
ICBsaWJMTFZNLnNvLjE5LjAgPT4gbm90IGZvdW5kDQogICAgICAgIGxpYnB0aHJlYWQuc28uMCA9
PiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGlicHRocmVhZC5zby4wICgweDAwMDA3ZmZhZGViMDUw
MDApDQogICAgICAgIGxpYnN0ZGMrKy5zby42ID0+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJz
dGRjKysuc28uNiAoMHgwMDAwN2ZmYWRlOTIzMDAwKQ0KICAgICAgICBsaWJtLnNvLjYgPT4gL2xp
Yi94ODZfNjQtbGludXgtZ251L2xpYm0uc28uNiAoMHgwMDAwN2ZmYWRlN2Q0MDAwKQ0KICAgICAg
ICBsaWJnY2Nfcy5zby4xID0+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJnY2Nfcy5zby4xICgw
eDAwMDA3ZmZhZGU3YjkwMDApDQogICAgICAgIGxpYmMuc28uNiA9PiAvbGliL3g4Nl82NC1saW51
eC1nbnUvbGliYy5zby42ICgweDAwMDA3ZmZhZGU1YzcwMDApDQogICAgICAgIC9saWI2NC9sZC1s
aW51eC14ODYtNjQuc28uMiAoMHgwMDAwN2ZmYWRlYjVhMDAwKQ0KDQoNCg0KU2VlbXMgdGhlIGxs
dm0gcGFja2FnZSByb20gbGx2bSByZXBvIHNoYWRvd3MgdGhlIG9uZSBmcm9tIHRoZSByZXBvLCBp
bnN0YWxsaW5nIGxpYmxsdm0xOSBhcyBhIHNpZGUgZWZmZWN0IGJ1dCBub3QgdXBkYXRpbmcgdGhl
IGxkIGNvbmYgcGF0aCAuDQoNCiMgZHBrZyAtbCB8IGdyZXAgbGx2bQ0KaWkgIGxpYmxsdm0xOTph
bWQ2NCAgICAgICAgICAgICAgICAgICAgICAgMToxOX4rKzIwMjQwNzIyMDUyNzE4K2YyZWI3Yzcz
NDRhNS0xfmV4cDF+MjAyNDA3MjIxNzI4MzkuMTA5OSBhbWQ2NCAgICAgICAgTW9kdWxhciBjb21w
aWxlciBhbmQgdG9vbGNoYWluIHRlY2hub2xvZ2llcywgcnVudGltZSBsaWJyYXJ5DQppaSAgbGx2
bSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxOjE5LjAtNTh+ZXhwMiswfjIwMjQw
MzAzMTAyMzM0LjE3fjEuZ2JwM2I2MWIzICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBMb3ct
TGV2ZWwgVmlydHVhbCBNYWNoaW5lIChMTFZNKQ0KaWkgIGxsdm0tMTkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMToxOX4rKzIwMjQwNzIyMDUyNzE4K2YyZWI3YzczNDRhNS0xfmV4cDF+
MjAyNDA3MjIxNzI4MzkuMTA5OSBhbWQ2NCAgICAgICAgTW9kdWxhciBjb21waWxlciBhbmQgdG9v
bGNoYWluIHRlY2hub2xvZ2llcw0KaWkgIGxsdm0tMTktZGV2ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMToxOX4rKzIwMjQwNzIyMDUyNzE4K2YyZWI3YzczNDRhNS0xfmV4cDF+MjAyNDA3MjIx
NzI4MzkuMTA5OSBhbWQ2NCAgICAgICAgTW9kdWxhciBjb21waWxlciBhbmQgdG9vbGNoYWluIHRl
Y2hub2xvZ2llcywgbGlicmFyaWVzIGFuZCBoZWFkZXJzDQppaSAgbGx2bS0xOS1saW5rZXItdG9v
bHMgICAgICAgICAgICAgICAgICAxOjE5fisrMjAyNDA3MjIwNTI3MTgrZjJlYjdjNzM0NGE1LTF+
ZXhwMX4yMDI0MDcyMjE3MjgzOS4xMDk5IGFtZDY0ICAgICAgICBNb2R1bGFyIGNvbXBpbGVyIGFu
ZCB0b29sY2hhaW4gdGVjaG5vbG9naWVzIC0gUGx1Z2lucw0KaWkgIGxsdm0tMTktcnVudGltZSAg
ICAgICAgICAgICAgICAgICAgICAgMToxOX4rKzIwMjQwNzIyMDUyNzE4K2YyZWI3YzczNDRhNS0x
fmV4cDF+MjAyNDA3MjIxNzI4MzkuMTA5OSBhbWQ2NCAgICAgICAgTW9kdWxhciBjb21waWxlciBh
bmQgdG9vbGNoYWluIHRlY2hub2xvZ2llcywgSVIgaW50ZXJwcmV0ZXINCmlpICBsbHZtLTE5LXRv
b2xzICAgICAgICAgICAgICAgICAgICAgICAgIDE6MTl+KysyMDI0MDcyMjA1MjcxOCtmMmViN2M3
MzQ0YTUtMX5leHAxfjIwMjQwNzIyMTcyODM5LjEwOTkgYW1kNjQgICAgICAgIE1vZHVsYXIgY29t
cGlsZXIgYW5kIHRvb2xjaGFpbiB0ZWNobm9sb2dpZXMsIHRvb2xzDQppaSAgbGx2bS1ydW50aW1l
OmFtZDY0ICAgICAgICAgICAgICAgICAgICAxOjE5LjAtNTh+ZXhwMiswfjIwMjQwMzAzMTAyMzM0
LjE3fjEuZ2JwM2I2MWIzICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBMb3ctTGV2ZWwgVmly
dHVhbCBNYWNoaW5lIChMTFZNKSwgYnl0ZWNvZGUgaW50ZXJwcmV0ZXINCg0KU2VlbXMgZXZlcnl0
aGluZyB3b3JrcyBzbyBmYXIuIEdvaW5nIHRvIGNyb3NzIGZpbmdlcnMgdGhhdCBpdCBob2xkcy4N
Cg0KTWFudQ0KDQo=

