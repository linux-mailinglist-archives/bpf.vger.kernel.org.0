Return-Path: <bpf+bounces-22236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D43859C56
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 07:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65807B20BEE
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B220323;
	Mon, 19 Feb 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="lKbxUiyM"
X-Original-To: bpf@vger.kernel.org
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2133.outbound.protection.outlook.com [40.107.9.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861B200DD;
	Mon, 19 Feb 2024 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324780; cv=fail; b=uEkxMlzXp2HjKw/pi7O9o/lSgiE+9nY4sRbegcxKavi9OaqVRqAZkGqIstFa49XdCoXAPv4l/2xFvHL0lYdSBQOH0DHg7T9JqgWPwjhoZreoCJZunaNxVeaaAteZQdjt6+ivg9oNCubNvQl4LL6ZXvfJVu9NGUjhX6dmAW4d0Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324780; c=relaxed/simple;
	bh=GZTodXOCVj+HnKs6LEnMH5UYhETFH7qMGx0gIWQzVSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nkcgIZgS1KYHlt9b1LEai117JvJqTDheo1RcYPD/KSbDrT0dNH5+j4Xe+k+c0Bpqw/nDl8LPugN7kQmSNfSfI7KaYp15Id+DsC3blKm/QlhGrotnpG/33/bB9qEWaHNfr7rlmLshhABIFP50fgwnkkbCDUO+DElFvvhfGPSs+Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=lKbxUiyM; arc=fail smtp.client-ip=40.107.9.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHrYolKwcyDjqYgneiWM3sGB8cv1JMr1bJZlOZTTL95VsEf0Tp71pATFi7+0mhk8xvc5ud8jIYsg6Qjhrzl4irow+9Cg0JYYIjNcFq6NXuMn6VKSX350YsbcRvRm4MDdmj9DaF+1kxZvf3g92NHkaT6BCFYyjwU8RKSAo2TcSIWLwNwkj4BsotK8tDziMSRptdiJZU3eFtMOoo2dQ/6mU+UjbquW7VkxJQbFAsKLEGnstXeUt/idqZaxvH/BqdHyf+BoZeiWchBFd+x5/XXzxbmgImiMsoUgzeIc89Zhs+uxqX9CoYnQnAAhzBppVL04A68vrKIAmuBuxm24gPJnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZTodXOCVj+HnKs6LEnMH5UYhETFH7qMGx0gIWQzVSU=;
 b=U2mJc3oOcFK2WH5C0ZRKbZS9/7EkIbWqY+OQdWoen7zIF5mYtvGCIvbb18jAvQ1k7d3ofbNcOJ/zXWtgbyvu3da7ZFDDwq2m35E12az6RGm3cc3FBwBmqwOe5hq9VZSxRxJByjy0p4cyg0MYTI/osST/eL/Qx5edFy2qcdqpXCAc6owWcU1WZ8yaEC5lInA/Lnd7x5Gm1lOl0doQVEBCUMPDDu+8qrwX/xyy7/CzOg1taH2IpEhjcyIkavDraLgpzn08Lta7Oq2JIyvnsyayKRitazItZyES/6y1bthAxYV9MizHI/EloLVObvvzYPH6j2MKTr4smioRcc+tEW/G5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZTodXOCVj+HnKs6LEnMH5UYhETFH7qMGx0gIWQzVSU=;
 b=lKbxUiyMF4j1e7Kt0UTGFUG8dTMuWjafRW0oyEqV1k1DrLuKHLfjQRGTzpvVZbIcGJ2dYrw7HBHBi0qNpKCf5n0olADkZTLXL4zBw63NCBQNFOPDB1gna/kj+vxlhcAEvxvhQBGfhjVJ8VZlOQ9x9DtKuDtiypVDKK0Wh3lcwN2h/Zfp2iSqEL/XhxArMgNdwbePtS4hU2QSadhXCZ6P4nySyzfhGBIrUHzH8tU0rewmTT8oPCrQUVUrpYCcmQQnNb+quDXH5prf4g7udHf+MC/gtvKPz+jsyLsX2TuJtzSZHNpjMnxxo+2PQ5IAWb1XmrzlJvG+G6UpW4h14/y1aA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1585.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 06:39:33 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 06:39:33 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Hengqi Chen <hengqi.chen@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Kees Cook <keescook@chromium.org>, "linux-hardening
 @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
Thread-Topic: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
Thread-Index: AQHaYljzfGfzNXs5T0S1aXyBr4+rcLEQ5HsAgABTnQA=
Date: Mon, 19 Feb 2024 06:39:33 +0000
Message-ID: <4d53e0f9-cfee-4877-8b56-9f258c8325f6@csgroup.eu>
References:
 <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
 <CAEyhmHT8H3AXyOKMc3eQSdM2+1UDETJDPyEQ0-AEb6E8pt9LTg@mail.gmail.com>
In-Reply-To:
 <CAEyhmHT8H3AXyOKMc3eQSdM2+1UDETJDPyEQ0-AEb6E8pt9LTg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1585:EE_
x-ms-office365-filtering-correlation-id: 12a30797-97ba-4b68-ec74-08dc311588bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cHMzz8Lif6MugirMsi1JmvTEQbQhlE9rRe8Co49WNagcDymG08Yy4esNfjPLt12hqdEID4O6ZXXubEDckCHB8PdX1s9j0pAAj+UPKEp4I4QA2umnoRGow4Z4OgnDRhHXHE4N3NKqsGrs2ejQ2ewkT3aNyswA8IC65VciImEhDyjBNKU3N1Fb8mm3cIayzuP/2PKIRE1qGY7yPDx9NdvnHvjXJpuTHHn7bfU0aOCwoUePLzd4pEgxAtmZB3Np1YjeqZvRVs7bIvm4d4JN7eZ7QURtu1b7sXYPdzb5EZekf8MjxOQSsGFa1gBxp4yb+OuXgJ2HH+LbmL5YJyxvPnEPObHU+MgBCw6YTRPigMvo51IKSQWvt21WfhKpMkFrFthyidjgN4tYLzzk/qN3p9xOz/2v9R+KLUmbG7phPUlpWEVauw9RSrj2XwGUZbYMlpWIF6sLYppxnX1P04tBAiMzvlFxuoBIWEgooiCRmfMZvHp0cqN0jzPASneJ/0Rs9E1tqDdMesgBE9fFiVKS+SR1xS8ALd3jqx5sazfH97p16C4O/mQxQf7l0IXmaxj/47qL07fJXqwDPKXj2HCOKvWe7QgUy0O1ZX0PzCjt8ZOghDA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39850400004)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(122000001)(38100700002)(26005)(31686004)(31696002)(86362001)(66574015)(83380400001)(44832011)(15650500001)(478600001)(2906002)(5660300002)(53546011)(6486002)(7416002)(6512007)(6506007)(6916009)(8676002)(91956017)(4326008)(966005)(8936002)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(38070700009)(2616005)(36756003)(41300700001)(316002)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3ZaZTBjSkxPL1crRTIzdWhpQ1VKTFNNc3dML080alBoR2tFVTN5aWVhTXg5?=
 =?utf-8?B?YjlqY3kyblNuM3dHSldPcjVuZkZReGwrVnFlc3lFYWdJUFhHS2xHdVJFQkdF?=
 =?utf-8?B?Y2diMXpTU1ZyNmJxSGYrWWxEVFhLUHhrWWdVZ0J1WTBZOVpOeVhUcWF2dll6?=
 =?utf-8?B?a1gyMTJQQTdsYkQwZkRwdTBmVGIwQll3VW0randQbTBWNW4yY3E1eEsyZldv?=
 =?utf-8?B?ZjJGdXpsTkNsRng2eFZndS9YYW04VnVNc3JjV0h1ejRYb2Jaa3pPWURoNWJE?=
 =?utf-8?B?YzlrYm5tcEVUQVJHcHlUTjBidW1KT1d0d3dOK1FZWERaSzI5WFJMa2dRdXRE?=
 =?utf-8?B?aXpEcmVPQmQ4SnJtZXFZWmFITEJKd2dWcittaHdvT2F6dHFCTTNkSVpQL1VK?=
 =?utf-8?B?RU5Na1hDY2RFYzBHbGlwMFRVeHV1TGw4UnFML3cwZUIrT0JjcFVoZWR3d3NR?=
 =?utf-8?B?Z3F0eE9tRXlvdnpLS1F6RlNRR0hxUGtLcnl6cjFKOStUOHBmMW9Nay91YWdT?=
 =?utf-8?B?NGJvc2RHTlFOU0FXZGRZOWtqRGgxY29wdzhYcm44WnBKOUIyZU1rWXR4bDBJ?=
 =?utf-8?B?WjREVzIzbVBFTU5McFVzaCtuOEZEaE80eTRqaEhvUGtFbStNd1hGazRwY3g1?=
 =?utf-8?B?NkNQK3RGM0xMVFRTanNqVkxVbmZCT2FkRm9vMFpPVFBpOGxBSkxwbWV6T0s0?=
 =?utf-8?B?RGFBc3JHMUZzNllUeTBPKys0WDNmVXozb29JRVBwcEhiMW9GVDhGYXFTaE5T?=
 =?utf-8?B?eS9GRGxCTHQwU09OSXI4bkswTHdmRGFvL0pzaVN0d3NXQTVoZHljd1dTdlE4?=
 =?utf-8?B?VjJXcE5JZk9FMEtnc1VIVE1SS1NMczY0SzIvd01US1Q4TkRtS3ZKQUhjcXI1?=
 =?utf-8?B?Vk1rMXJFYlJRbUNiWThham1QZ3VlRG1tUXpSRi9TOFlYbU9aVGF3N2VhSE5x?=
 =?utf-8?B?VEwvdEFzRUd2bmJvMUpUVXRmZXBlbHVPMkNDaTVDTzFacy9lclIyQ2NKTnRD?=
 =?utf-8?B?aExrWVdGS01hRlhhZ1lFRFkzNDlzZm5wMExmbFVGcmdZbDM5eVBNYkwzamRo?=
 =?utf-8?B?QTEzTnlZVWRubmlRdndOTXBqRmZOWGFQZXdjbEZla2F0dzQ0NWFkcXRLVHdq?=
 =?utf-8?B?QmFJY0FIcUI4czYvR05jbXdNeEZBU3MvLzZNWVdrQlZHekxtdHN5NGViZitZ?=
 =?utf-8?B?V2poUEpmaVdBdHdCdW9CNmxZRnM5Z2pUK2pZTnVURm8rZDNRSW45enZJOFFG?=
 =?utf-8?B?Z1U3ZjUzaVJBZEdNR1pTRHVyUEM1N1NLVFJkMG9lNnpmVEpGT0VEdUxaOG1a?=
 =?utf-8?B?ejJUaFhhaVBjbzFlY09kZTZkanF4NzM2Tnd1ZGpCdko4YXgzUmh3TEQyeW9V?=
 =?utf-8?B?cnhXTHBRZGNZcGt3UTBtdHcyUEZYeUNDeHg1N0U0QU45NE1hMDlBbFcvaW5y?=
 =?utf-8?B?UXdqTTdVSmplNmRlNFhTZytCZGcrbXUvc1B1SHFEUXIvRVczQ3lFbDFxbDdB?=
 =?utf-8?B?YkMvb3N6ZjB2Z242TEJSNXlCdDBIeDRIV3I4NDUrUXVtV21lTlVRODZZaUhB?=
 =?utf-8?B?dTY3WHhIbnF1d0duTEk5eHR6c1FMWjN5WU1TNk51ajArUkp3cDJaTStYOTd2?=
 =?utf-8?B?VkpJbFdQVDVqK0FJT1p0MDVQSHJIcnU4cVRsR2dvRW9nTmUyK3lZOTMxKzhx?=
 =?utf-8?B?QUhEb1ZHZUkrQlJyWGg3MTRFUnc5ZjZOMUFFMDErbVFmQ1BpcGFyZFUwTS9s?=
 =?utf-8?B?WkZsZm9EYnRKZHJTK2lONWFCLzdjcmNnYXFuRzM3SDNROHRJMm1ORXE5OGRW?=
 =?utf-8?B?eTNVQ1dGS29WaDc3RDFTMGtMTzJsaW1pZWVNVFAwMUllUGx5K1RxSTZGRmRz?=
 =?utf-8?B?VGpEbDlVQXM3TCt4NFRidjUydEk4bTRhclM1ckRoaFNmb0ZsUGFZcnVhM2pz?=
 =?utf-8?B?WlltRDgvSjVQRHJObWJRL3lSV1VJSG5EOEd1WE5md0lzMDB5NlVRUzlzMWlt?=
 =?utf-8?B?QzBwYnN3Y21qVHkzVXBPUGJDbXF6MU02NDVmcU11Uno1eTZtZ0MybGFodytW?=
 =?utf-8?B?em9TajAvQ0NIalJvcEEzTVpQc0gvay9CSHFwRmRhOHJ6NVRmYmhBamdzcXVs?=
 =?utf-8?Q?QDR0fSD5ud0yAEQ3tKYMNp111?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <796B4CEC8893654C8CB170FC585C0F93@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a30797-97ba-4b68-ec74-08dc311588bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 06:39:33.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVoFTjRzRxvAHGAT+BmaqyN/kXWj7UnaBbfzVOd8lnJP+aQoo6eCJGnOvWh0WGOPW16kvNRwbh7/e6DBL4s0dy7c/FT72UuGnIi97VUyPUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1585

DQoNCkxlIDE5LzAyLzIwMjQgw6AgMDI6NDAsIEhlbmdxaSBDaGVuIGEgw6ljcml0wqA6DQo+IFtW
b3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGhlbmdxaS5jaGVuQGdt
YWlsLmNvbS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEhlbGxvIENo
cmlzdG9waGUsDQo+IA0KPiBPbiBTdW4sIEZlYiAxOCwgMjAyNCBhdCA2OjU14oCvUE0gQ2hyaXN0
b3BoZSBMZXJveQ0KPiA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4+DQo+
PiBzZXRfbWVtb3J5X3JvKCkgY2FuIGZhaWwsIGxlYXZpbmcgbWVtb3J5IHVucHJvdGVjdGVkLg0K
Pj4NCj4+IENoZWNrIGl0cyByZXR1cm4gYW5kIHRha2UgaXQgaW50byBhY2NvdW50IGFzIGFuIGVy
cm9yLg0KPj4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGEgY292ZXIgbGV0dGVyIGZvciB0aGlzIHNlcmll
cywgY291bGQgeW91IGRlc2NyaWJlIGhvdw0KPiBzZXRfbWVtb3J5X3JvKCkgY291bGQgZmFpbC4N
Cj4gKE1vc3QgY2FsbHNpdGVzIG9mIHNldF9tZW1vcnlfcm8oKSBkaWRuJ3QgY2hlY2sgdGhlIHJl
dHVybiB2YWx1ZXMpDQoNClllYWgsIHRoZXJlIGlzIG5vIGNvdmVyIGxldHRlciBiZWNhdXNlIGFz
IGV4cGxhaW5lZCBpbiBwYXRjaCAyIHRoZSB0d28gDQpwYXRjaGVzIGFyZSBhdXRvbm9tb3VzLiBU
aGUgb25seSByZWFzb24gd2h5IEkgc2VudCBpdCBhcyBhIHNlcmllcyBpcyANCmJlY2F1c2UgdGhl
IHBhdGNoZXMgYm90aCBtb2RpZnkgaW5jbHVkZS9saW51eC9maWx0ZXIuaCBpbiB0d28gcGxhY2Vz
IA0KdGhhdCBhcmUgdG9vIGNsb3NlIHRvIGVhY2ggb3RoZXIuDQoNCkkgc2hvdWxkIGhhdmUgYWRk
ZWQgYSBsaW5rIHRvIGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy83DQpTZWUg
dGhhdCBsaW5rIGZvciBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCg0KSWYgd2UgdGFrZSBwb3dlcnBj
IGFzIGFuIGV4ZW1wbGUsIHNldF9tZW1vcnlfcm8oKSBpcyBhIGZyb250ZW5kIHRvIA0KY2hhbmdl
X21lbW9yeV9hdHRyKCkuIFdoZW4geW91IGxvb2sgYXQgY2hhbmdlX21lbW9yeV9hdHRyKCkgeW91
IHNlZSBpdCANCmNhbiByZXR1cm4gLUVJTlZBTCBpbiB0d28gY2FzZXMuIFRoZW4gaXQgY2FsbHMg
DQphcHBseV90b19leGlzdGluZ19wYWdlX3JhbmdlKCkuIFdoZW4geW91IGdvIGRvd24gdGhlIHJv
YWQgeW91IHNlZSB5b3UgDQpjYW4gZ2V0IC1FSU5WQUwgb3IgLUVOT01FTSBmcm9tIHRoYXQgZnVu
Y3Rpb24gb3IgaXRzIGNhbGxlZXMuDQoNCkNocmlzdG9waGUNCg==

