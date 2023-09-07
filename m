Return-Path: <bpf+bounces-9434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26F797930
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1347D280EDC
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A4134D9;
	Thu,  7 Sep 2023 17:05:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66D13AC1
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 17:05:05 +0000 (UTC)
X-Greylist: delayed 802 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 10:04:44 PDT
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE131FE2
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=679; q=dns/txt; s=iport;
  t=1694106284; x=1695315884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZSeTVEoeHiF1hxB8g0dX8MIuuFKAKHu7PsptJPvI+3U=;
  b=Ergo0FXHyEjgK/RceQQYIANgieaYv4JfXrQJKdNxAc+trWHWsYNfRZC3
   MeaQ/zTEtwjBR/r0f3BnrzGcy9OuqChV2tv3niL4I3zRMaWf3ICx0IHSE
   huiQcIIgvUP6yQGTM2uqn/m9meb9I3qjaSVvw1VbRYjO1YjCUrBpdaZfy
   M=;
X-CSE-ConnectionGUID: 8QvaIB2wQp2pJAIL29XEyA==
X-CSE-MsgGUID: FET6TegXSX+vOhroliJEGg==
X-IPAS-Result: =?us-ascii?q?A0AeAgAlj/lkmJ1dJa1aHgEBCxIMQCWBHwuBZVJ1WzxHi?=
 =?us-ascii?q?B0DhS2IZAOde4ElA1YPAQEBDQEBRAQBAYUGAoZxAiU0CQ4BAgICAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ4U7CCUNhgUBAQECA?=
 =?us-ascii?q?RIVGQEBNwEECwIBCEYyJQIEAQ0NGoJcgjwjAwGcawGBQAKKKHiBATOBAYIJA?=
 =?us-ascii?q?QEGBAWybAmBR4gIAYoFJxuBSUSBWIJoPoJiAoEYSAKEEoIuiVCFQgeCXINdi?=
 =?us-ascii?q?TUqgQgIXoFqPQINVQsLXYEVUTmBPQICEScSE0dxGwMHA4ECECsHBC8bBwYJF?=
 =?us-ascii?q?xgVJQZRBC0kCRMSPgSBaYFTCoEGPxEOEYJEKzY2GUuCYwkVDDUESnYQKwQUG?=
 =?us-ascii?q?IEVBGofFR42ERIZDQMIdh0CESM8AwUDBDYKFQ0LIQUUQwNIBkwLAwIcBQMDB?=
 =?us-ascii?q?IE2BQ8fAhAaBg4tAwMaOANEHUADC209NQYOGwUEZlkFoHmCVgF0IkWBOaQuo?=
 =?us-ascii?q?SQKJ4NkoTsXg26lcZgtIKMYhGQCBAIEBQIOAQEGgWM6gVtwFYMiUhkPgzeKa?=
 =?us-ascii?q?QwNCYNWjzwBPHY7AgcLAQEDCYh/gkkBAQ?=
IronPort-PHdr: A9a23:BPa6RhVLjGy0kVjPtLQXijzluvHV8K0yAWYlg6HPw5pUeailupP6M
 1OavrNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2sil3u+14YDSSw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:coZ0LqpN3EMQf+dbqXqzoBM9JaFeBmIPZRIvgKrLsJaIsI4StFCzt
 garIBmBMvjeNjTzKY8jaIvn9UpX78KGzd5lGgZvqSE9Fy8R9uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOCn9T8ljf3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYAXNNwJcaDpOsPrS8Ew35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86rIGaRpz6xE78FU7tJo56jGqE4aue60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/yxWZcV7FLH7zXeX4fWNxmzsKWTV2692LmgXGddJystmKDQbn
 RAYAGhlghGrnem6xvewTfNhw5plJ8jwN4RZsXZlpd3bJa95GtaYHOObvpkBgWhYasNmRZ4yY
 +IVezNgaw7dYjVEO0wcD9Q1m+LAanzXKmAB8g/F+fVsi4TV5CJc7ObRPdXlQezJW+JVhEGcp
 0Dr0GusV3n2M/TGmWbarRpAnNTnlzv1cJwdGaf+9fNwhlCXgGsJB3UruUCTu/K1jAu1XMhSb
 hJS8Ss1pq90/0uuJjXgY/GmiC69oBc9cYBPKvVg8COk646Osja0F0FRG1atd+canMMxQDUr0
 HqAkNXoGSFjvdWppZS1q+n8QdSaZHV9EIMSWcMXZVBavIS78enfmjqKH4kzSvfk5jHgMWiom
 2jikcQou1kEYSc2O0iT51vLhXenoYLEC1Bz7QTMVWXj5QR8DGJEW2BKwQaAhRqjBN/JJrVkg
 JTis5PPhAzpJc3V/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43Y5pcI2KxO
 xOD4lM5CHpv0J2CM/Yfj2WZVZxC8EQcPYiNug38N4AXOcEhKGdrAgk3ORfBt4wSrKTcufhvZ
 cjEGSpdJX0bEq9ghCGnXPsQ1KRD+8zN7T27eHwP9Dz+ieD2TCfMEd8taQLSBshnt/nsiFuOr
 L5i2z6ilk83vBvWOHeHqOb+7DkicBAGOHwBg5wILLPZflU3QwnMyZb5mNscRmCspIwM/s/g9
 XCmUUgew1367UAr4y3TApy/QNsDhapCkE8=
IronPort-HdrOrdr: A9a23:TO2BoK9JpCLy+Oa2OX1uk+Gkdr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBQpTnhAsW9qXO1z+8N3WBjB8bTYOCAghroEGgC1/qt/9SEIVydygcz79
 YcT0ETMqyWMbE+t7eF3ODaKadh/DDkytHVuQ629R4EJm8aDtAF0+46MHflLqQcfng/OXNNLu
 vn2iMxnUvaRZ14VLXcOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXIIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0InErXMBeo58bLBiA13kAnkbzYhBOW
 VwrjqkXq9sfFT9deLGloP1vl9R5xCJSDEZ4J0uZjRkIPkjgflq3M8iFIc/KuZdIMo8g7pXTd
 WHAKznlYNrWELfYHbDsmZ1xtuwGnw1AxedW0AH/teYyj5MgRlCvgYlLeEk7zw9HagGOtN5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCYhv22tHKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arDcGVxpVE/h3EXW34VzXwzcNV4YR/p9THNfbWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umNmfqEZYh5Xy3Z3CTEwhWbCQ4gKdMZ7vVmLO+FmTDjJ2tTMru
X-Talos-CUID: =?us-ascii?q?9a23=3A62lqc2vKxXawOcy0GEARg8jh6It1S2PU7V2KPHa?=
 =?us-ascii?q?gU35LYZyxEw6g1bJNxp8=3D?=
X-Talos-MUID: 9a23:FPgYtASEk3gD6RSPRXTCqQ08CMpn05+eS14qkY8Bv8imGAN/bmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by alln-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:56:58 +0000
Received: from rcdn-opgw-3.cisco.com (rcdn-opgw-3.cisco.com [72.163.7.164])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 3878uvLI029410
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 7 Sep 2023 08:56:57 GMT
X-CSE-ConnectionGUID: aPFxaPqbTrCRKCoYWBnJ5Q==
X-CSE-MsgGUID: 9kifcUl2QS6FYjl/Gl84KA==
Authentication-Results: rcdn-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=dzagorui@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,234,1688428800"; 
   d="scan'208";a="1390419"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by rcdn-opgw-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:56:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivj6vc5I3kalmHwK3vgM11APg2W1T3BKRt8W2EetPdF0GvY7cYKgcyEjLHWv0YKzo8cTkzSFp84sH/XPHpLw/yWGb761X6+vbpSQIKzF2LEYTRwwwDx6tlBn9UybAASdRXlv4wWoIkOFuEWQANJqzes4jOrBKtEedBAKHB2JkV5S9gQKRxa9Q3eTBi3F7rE+J7NMsh5KQ8pwvPoKxIIpd2Jgu6RDVLXv68+/kaiU1VaE6Uxl2oHZ8WG5kxYS0O4E3SY24aWQ9CcvTMoPqpCNef4bhRy7wHnevo5qfihgQ5w4+8oq/1epKMv+FXwvhuqE7/m8UmiY4lp7HsBybA3C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOyfjjORpkii7qNVD7C+PVSalBWLINCAVxrH1LUm8CI=;
 b=NK5siXZEaRUIkxJHhvzZVrd8LA0NQJIidD/OfBF0lBMDj8YE8KzUFNppqkiutkjgy4Ala9I7t+gsi5cSDwRhIcuI2emy1AmrzhWKGaiA2aXFMmMyfKqL1QrJZYziq1IRhcqUn/kufBUHwZ6UMsPdmDPdSxxDImWAqzSyh9ep6tyWUN9dtgSfiSsQipBsgPmnLLuLG4drJYnT4M2WkGM1ousy+UXDGtick+X8/oPketv1xCIZTPz8za59RISXtz763P0CwbilWPoe819UQ9c9MgGEBEwe3be39jTPgb4sE8vz5b5aADb4Y0TTkdvJLguCVCTqUBcKZ//lthNaGPna+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOyfjjORpkii7qNVD7C+PVSalBWLINCAVxrH1LUm8CI=;
 b=jOugz/Dob+cWggtdIyNKXU8cZ/oG8pjrUA1E0xcADbeA8iiCgYzdbCwID3QP7q4z01af9npTV2uuGRJGilEB40HTskQYtYKq6s813sWFghfWE1dCmf89yOFcX++Hwzwatc7V/cfgf8QVlNJOdqNlfgjwSuSxbCZnVXtzc+ZiMFs=
Received: from CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11)
 by BN9PR11MB5242.namprd11.prod.outlook.com (2603:10b6:408:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 08:56:56 +0000
Received: from CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::e3b:5c0b:3777:84e7]) by CY5PR11MB6187.namprd11.prod.outlook.com
 ([fe80::e3b:5c0b:3777:84e7%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 08:56:55 +0000
From: "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)"
	<dzagorui@cisco.com>
To: Quentin Monnet <quentin@isovalent.com>,
        "alastorze@fb.com"
	<alastorze@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org"
	<song@kernel.org>,
        "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org"
	<kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com"
	<haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpftool: fix -Wcast-qual warning
Thread-Topic: [PATCH] bpftool: fix -Wcast-qual warning
Thread-Index: AQHZ4LOzqtVE6zZGEE2m+y8hwQzN8bAOA0cAgAEJBaw=
Date: Thu, 7 Sep 2023 08:56:55 +0000
Message-ID:
 <CY5PR11MB6187F0721793B24A00C0699FD9EEA@CY5PR11MB6187.namprd11.prod.outlook.com>
References: <20230906111717.2876511-1-dzagorui@cisco.com>
 <3145d302-5ab2-4cd8-974c-6ae1fe436328@isovalent.com>
In-Reply-To: <3145d302-5ab2-4cd8-974c-6ae1fe436328@isovalent.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6187:EE_|BN9PR11MB5242:EE_
x-ms-office365-filtering-correlation-id: 913763b2-faf8-4614-b720-08dbaf80631a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m0E2OaPuif5us1JkCU6725IqKAQYO8FUchbKOMTjagE0n27xPGInFLit/rTdII/uKzW8Ihw36cpeURw4Gy4prpwHxWvjaap0TifmdQYCOc/v8yiheoP9E58ROSgn1uOVVeSwh8XyhZ4QCVbvM9CmiDHS5xa7OER2WaPJCYXW2c7CFCI9buIGkWWWBB9DkedtXotNx7PtSAm+GOr+1O50Zjn1ttTC+f7S1TXvo///TDbwtj6i7Bztkz5ZtqO6VQoXs+U212LXfMgeK5Es12vAPt9RJHfHbyTpoctNto+ScVikw8orB1nS2JlzllefkV+nnJm0zYCNAvsw6vY3cy++Pqq5Qwyva6U/lhxorBTpgSSUmOKxNQJOyq4FWeZFp/iiylgIDuX2EgTExMem1vIjzHPwAv6q8Z2hfNgo88WD6v4Knj0Yy5FbNn5uN6uBNAs27mNyDdx9yCl+q55n8B2IYifHeCn6BKF7YvjCNNlAPM7ZH43ju7+Wb8hm+0/IH8XgE9dovnQ/pPYVterboQDZ0g+03xWr13OFEMO+q9pEE5SaUJOUGbrLuX6+N9FsF4SzNMb+kh/Ivrc9FOYT5ag/4OQFMUuIoKa7xFp9SGAS6npHZrJpCmtCpu6UzRD8ybii33inLGcpgMXzQShQX/+qEg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(1800799009)(186009)(451199024)(52536014)(8936002)(8676002)(4326008)(5660300002)(41300700001)(66556008)(66476007)(66446008)(66946007)(76116006)(64756008)(4744005)(7416002)(91956017)(110136005)(316002)(2906002)(921005)(122000001)(38100700002)(38070700005)(83380400001)(55016003)(33656002)(9686003)(86362001)(478600001)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?k79FWE77wjFWIQdB0J8tRckYSv0MmPto4NgbaQt4xM9otb12gr8CNdNhQu?=
 =?iso-8859-1?Q?bJMr/2/lbFj1fvE9Hp2MXP6H+68FbMerBIpAtE2+kZz1NN1btS2JUS/FD3?=
 =?iso-8859-1?Q?o0ABfG35RWu077jZz4IBgiB4AeA35+0AjZDgL+I48nNEPy5JV8A6NAL6vY?=
 =?iso-8859-1?Q?3HzKFKkXtMgcq3lV5aErTY+dknYTBteT3yv6Zzw8PwwHST/WdK80SOeOdx?=
 =?iso-8859-1?Q?q1ZPri+6VCbRsnqIcOsSo7Kumy6De3P+497qzdit5VLNLeQJTC82G77ji9?=
 =?iso-8859-1?Q?btuo3B7xr8wY3EjzkHuJqk0ur7Wmd9ERHLYtlZFbwh8GB1mgeZCaoVqsOW?=
 =?iso-8859-1?Q?PdgN6ma+KyhA++ZOd2iLdQxDcJC0gUAb35xZe8dMrsDldsai60LFm6TWjl?=
 =?iso-8859-1?Q?KoD+I9rYOFLyinT4Gk8ZYVCP4e4SJHpFUD4ji2GD+qImUfmmqGrB2YQRZv?=
 =?iso-8859-1?Q?nBIuuQzu521zVL7WJEu/b6wE9a20G1KG01Kxxr4uWLoQQ/yf0Z/h5b76Ta?=
 =?iso-8859-1?Q?LqBtIeu4KQQfdBreYnNA6BcuM0tB/QHFRqqQT6+7SM5x8Nu852OijDCGI+?=
 =?iso-8859-1?Q?u6VZMWxn5V1njo+uO6yMlm8S3yIThC8iLmX9i54gKL9Go1oIbKG+t42taP?=
 =?iso-8859-1?Q?q03JdA9Z4qLS/eGE2fMEYK0nNJgjbe1clTeuREsrpGOAPwJWxWpoipDoIY?=
 =?iso-8859-1?Q?SpFGtWa8WsM5t9+i+M3ZNmvzZ3GGtPUV5TrKyiZZgTLEA+P3Pl7Ozqot5y?=
 =?iso-8859-1?Q?Su9UwhgwfcUxRqQZl0FVkTRf7mIqw5EZN8/dgrQjBKu1UjkGq679IjtduR?=
 =?iso-8859-1?Q?GiFJ9ijGtQBtvuzAtDV/dmv7e7NCLH3NZOdsXBEAeQGlOI6zvCPCns1/eR?=
 =?iso-8859-1?Q?fTjL+VCvh/22TcquMqFtGDElcuLjWxr9SrivA/08COErirWgDigYwEG8rm?=
 =?iso-8859-1?Q?/YsSmCw+aw7VQe0o+0h9qTq7A5MOaF7mZDQzXSiuiGD3G2oYTy0J0holQk?=
 =?iso-8859-1?Q?eyhdnMlmThcLR9xZAaDZNlQDiHKBzr3gZh2JJgbslDfWVGCFe0odEdgDVq?=
 =?iso-8859-1?Q?qsZhS0gSUetQVJNgACHXjkkXEjSCxvqj0p4HjvzS09pnVqTERSocEuMnuj?=
 =?iso-8859-1?Q?wEAhj8sr7/0gCheczCzB9t/VA6xzPFq8LpTnqrfZbPaGsn6HbYt88GrtkL?=
 =?iso-8859-1?Q?162z9Q58bHOLE0WcD7LjHml85ravPv//LdDKIzNirO7hL8FVK5yFNdo77Y?=
 =?iso-8859-1?Q?VbHEPzCyLOixcNJUWBfmP/uUy228Td2RXlPCzmLLeev9bo1QceKRr0XvZA?=
 =?iso-8859-1?Q?lefTWBOCqDNxDsid5b7qimgTr/AopBhdTVrGffjnb0HKNGlazGKOJtjtx8?=
 =?iso-8859-1?Q?nt7BKgyrr/XPEax+0eKLGtSOsjxkD4ME/ueKbYy5ZPN9DgNfWRJnE+Nrk9?=
 =?iso-8859-1?Q?IDyzpKgRypQATVVBNajxBoamJEttnEkisvoVeNLeKe/5FUtcvoDRpf04hN?=
 =?iso-8859-1?Q?ZxRz7FdjjssrnRhZ4expft/XmMUsPAhUQTYR4pPsZWONLsaysm566xg40u?=
 =?iso-8859-1?Q?1UVLrDnSRfmUNe7XTqUoJVf1hRWxsPG1TtIm0asBPazxF/zXFUT9LKEo4v?=
 =?iso-8859-1?Q?HSEp7vGm6ByNL85Bju9wGpaayffE472m7Y/ZBXCHiEORnMaUeJr2JWeQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913763b2-faf8-4614-b720-08dbaf80631a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 08:56:55.6281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBmV/rVwG7kSPzs6L4XqsYuzQtf7HO3yczscq3O06qrU1GkR6/LleFLU9BOCZWqiKCfqivXTjVqSzkaAy7U+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5242
X-Outbound-SMTP-Client: 72.163.7.164, rcdn-opgw-3.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> If I follow correctly, the cast was added in bpftool in a6cc6b34b93e=0A=
> ("bpftool: Provide a helper method for accessing skeleton's embedded ELF=
=0A=
> data"), which mentions indeed:=0A=
> =0A=
>    The assignment to s->data is cast to void * to ensure no warning is=0A=
>    issued if compiled with a previous version of libbpf where the=0A=
>    bpf_object_skeleton field is void * instead of const void *=0A=
> =0A=
> but in libbpf, s->data's type had already been changed since commit=0A=
> 08a6f22ef6f8 ("libbpf: Change bpf_object_skeleton data field to const=0A=
> pointer"), part of libbpf 0.6, is this correct?=0A=
yes, this is correct=0A=
=0A=
=0A=

