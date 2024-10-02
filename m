Return-Path: <bpf+bounces-40800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EC698E76B
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 01:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55F81F2724D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 23:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6619F129;
	Wed,  2 Oct 2024 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hylCFukr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gvjdMjvL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF61991A9;
	Wed,  2 Oct 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913184; cv=fail; b=chyPmcT7y47mBvSNnxTf7D4LnwGayPA7NWWozF47TsuMQ0rYw2xLKx1pA+IZSoNfh4Uw4mvoRrLb+b4kWt9WaInGuBhg/VtTn1MiKQoMeWPYj39rfqSWfwCPsb0ibKPiNZlZ3fsJ1UE1tzkw1Bh9g0ZtEf+HAf4TVrdOIfC6nzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913184; c=relaxed/simple;
	bh=AOLEgWsPfDMkSDLMqnvsNcDQhghDwLxUec84ORXH/sI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rbszHxOtYCbqMQlVesw3O3QCjxjDtO7MrmKmgljCXl/cOqGv2mk3abeD0S3kYirOK00vVyszqH8PJ0RptfHEWnoz+lZQrw/TdDhEG6LqpynthkW/kUwOjOALPZw4B0nTlJVGmEenZZlfev+8Lds1O2ZiJS+rlWCyB730Gjacp8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hylCFukr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gvjdMjvL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492MffXZ023095;
	Wed, 2 Oct 2024 23:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=ULQXdjJIerhf33
	rNPik2z/qjcjmemNlO6ZUoMy3q58Q=; b=hylCFukr6WEmC/HNBNVXqFo2v+dHfG
	d+14pI0IcxU51lIhKLGonT4zBOKK6OqWSoV//udYxWVy0Xu4qLT/rYn3ZEH0+Ae7
	z/rbtJGuheTOAYJroAd3EnPblPI8GRzDupusYKa5/NZ8fR4J7eVQsWI/eWMZr1qx
	5OMRTZf3FwWf7W6rFdlxvD5L3mDu/rzQc2oghjgdKwy/T2ZVHP+YMt919m/YOEn0
	rHjVkVkRktO8GhA53ddK326jnHPTVrF09FeQVly8b4D8IGtr8FK72/n3BQAGVcnc
	DLeaWnezupnQJiorvvh36Ru4HtqeWFO5szD8fZ8OzJLiVA+6TDVA5GCg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabttst7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:52:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492LPxZq040820;
	Wed, 2 Oct 2024 23:52:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889gbr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH9kn5G00ZTbK+CpiplE3jfNumB2zwZedvkfiJjn3TwUGKtyGjJ2IlgjzOzYIhBgVY5XFqxcl7NHA86qSY9uWbtY+qGQS26uhzMMfhDY8sT46nkdto3NFDrdyHlfS7sbVAcHbEawQPhVqr4P0oA+p1MuQ3xdWi1JdnVXRbNNAOVw5fBgLoQ5gJh6KDU1qYRCXJSSJovQTx27jML/bWVb016jViuw6c+zIR85tj8BAsnqmcEJHHvML7mVppXyhMc7RHoV1rHO4MaXMYqExUx71ldlPQfs2uYgRhow1rElrztdXZGeU+eRxefBzCvmBedE7R9mdukgfNUcrtHpT1VMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULQXdjJIerhf33rNPik2z/qjcjmemNlO6ZUoMy3q58Q=;
 b=bK7NeOSIlwEQ+AGf4mLsGc6b2ZSAx4g0NM8/TmFyTRMyucAmlifyw7TacktNLHvtDyzLluFhtJD/YaBW3Brr8fUufopBrnRcCqgdjpZLvs4On5gk32YXIguUh20jw/iPwxnFv+ljXnjaD3x5li6Cqy7gElyZQDJi/r+Llqe5NphlAupIt84QHZX1x6lBC8lCYIXoukX2//8HlRYRvXDYWe6AK+heuN3yWs+iCWAzs2HwM/NJcCoymxdH9LG0byQWQrlj/Yz+vo9AQMbp1By+7tYd7HgOd8D39nuw36ltkvdOqksOQBDhWNTwjml+8IUTc9H92AP7gnUAmZBEn9snKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULQXdjJIerhf33rNPik2z/qjcjmemNlO6ZUoMy3q58Q=;
 b=gvjdMjvLj7oStm00D1H21qNrcaHhnkTIOuegsNaKRZ5It4dxnXSNPDgyTX1HUPevIublgyQN2DadoHgKgaMIwg+QsQdKGdBtoShYBnaNM+lybMYruhPMaRqcP8QbXbk+abAO7hswmcnXf9t25EFqfbkqv1UOPs/dAcjyKoFR1kY=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:52:56 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:52:56 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v3 0/5] Emit global variables in BTF
Date: Wed,  2 Oct 2024 16:52:42 -0700
Message-ID: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR12CA0034.namprd12.prod.outlook.com
 (2603:10b6:408:60::47) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 816bd61c-c531-4a3f-882e-08dce33d5650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dy/eYE+eTt2GgPLvEd51Cweq4UQgFIi2nRoMde/MXbZ9r9oSZlkJAF2PhCdT?=
 =?us-ascii?Q?y+0K25fNMbPgoD+NdRLUbYfQBVohDGG/sYIxQxeCJNfj3qd6eBiumjkjmtUv?=
 =?us-ascii?Q?2NUWyOivbCsvAOHHpmdGPcBfhwSOs2WMCrhP+/TnmslpysSE0+04UKYCCQ6i?=
 =?us-ascii?Q?Zykq6lqR6SFx8UtJB8wEktjxqHkZSLdbIDznEVz113VeKl2piPPZaimpXW+C?=
 =?us-ascii?Q?NvSQ7yEAkcUEOdy/24RZTdnAmGV/zByNfSgrIytoFEiuUxItDjI5ckd79RIq?=
 =?us-ascii?Q?MBo+g90/9jCD1Ttpb9R3gcI9Yik6ovgy8n6IGdkjAQXCr5rCGv89yCzUglAJ?=
 =?us-ascii?Q?kwr6+/M6KCOaUKbZONi3wmLyaiOhO8lwtMFEYEbnzIjuEqw4jiMV/JaVH3Us?=
 =?us-ascii?Q?PyibpbaJNjpTSnV/2AIj46uWumdMq0QEU4v62OUquEh+Xr6r2RdvM7UdJNbE?=
 =?us-ascii?Q?hrgZwleeIz8Hr0YH5trr5Uiimh54x8mqm1C6LKhDnczY9tE81sWVn34ZnBvT?=
 =?us-ascii?Q?Li0MNx5baBWwRrsrThj+4CZt6IWULmSl9q+LQO7Nf6Uh+csLi7eVNWG87YA7?=
 =?us-ascii?Q?HTkhBTPEPreXIW+CK/juqCOVeAe7ob5Z1IZu+11BsuFpjRO5jhce164rc3k+?=
 =?us-ascii?Q?CMTzE2T829RERokoqeFoL4WOpXSKg9oT/rV4ogDvAvPrI7gwMISZeTAgd1Ef?=
 =?us-ascii?Q?YVulfE82yan5r8Da2HbF9j5L4fUWRp4sya14F7RH66vM4O/Z1QIerpcDI/I4?=
 =?us-ascii?Q?9qRyE62Ga05+1tl90e1gBykJlBK+pbLvQxyTcN14zKaLHV8EzUSPw+CN6QZl?=
 =?us-ascii?Q?q1V0kpgbmdfHjtLbcR/erQdafyAuN2Nk2YCz+ore1NZJGxg2u/tAnIXb0Qvl?=
 =?us-ascii?Q?QV6o1xeab/NR1gcgbQ2KY9265Tkwmm1yjvCiFNC4YBY1NnD/7VGPveEOXIl5?=
 =?us-ascii?Q?NxnYkvhKDRmtJ94d5Tk2yBFeSEIeXWSmg6tOzDu9HGVLAQnKfXUSKnMxQvC3?=
 =?us-ascii?Q?5kjAB6qZXvr+KfliLEUQdevx92PZyEdPqldlV0btJeO9wlL7empxfIzOlEDM?=
 =?us-ascii?Q?pU/WNhpsIDVG2Xqx+og3bAWO/6fUzGE+XwKvIdstqeqtzrIZF9Mq1/ivceOs?=
 =?us-ascii?Q?dhzjqRPoP009HXlkT7D1t3J4+gpWYaIzfjTnfYX16VZ+yoj7o40kiXZG9PX4?=
 =?us-ascii?Q?Yx1L1xU1727W+FqDqR0WV0UMD/YeNEXXdLOSdOTpnrOZ6hVuEDH/IL0jLzk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLK37qRgL/V/6a0kxB72yYddonkr7jrO+DUNT0WrDhR3//AdGgnLpnQIcI3p?=
 =?us-ascii?Q?RsOY/GWD/bDwNoXx494sHaW3gwY89iSYW7wL9QJ5wvaWmweR02IBdZ6Wsc94?=
 =?us-ascii?Q?GYLHGI4NeHlhrY9ZyfK6h9Gl3VmLTKl4E3YKslRJbDcCO9hQTRl6k1751Zt0?=
 =?us-ascii?Q?lqtuv7w101PvP7oNsOV2w3yg6XYeeEE+aTz1spgOTKRzUSMdaPFgjHuM1Ir5?=
 =?us-ascii?Q?9vG6JKSOPT/1dth9Xos8luY0SXAEOU85xuDeCZMf4IzPrdmgyElkNuAL5SVp?=
 =?us-ascii?Q?wXcXbXjJftA1bwTLB0Q2MEzZ2Kk/Oq9y+VWcnGqcTz672aMMXDo0vFowqeI8?=
 =?us-ascii?Q?XwAfT1pMZ6AGEAwpX4Z3ewrhopgUYJUKv9GpwmK1WUUu8VI9+3W//4dC+vnR?=
 =?us-ascii?Q?Zo6v8V17KNP2/kWYpm5ouJKTSH3Hv26lddWsuLB0pRLzVUQnduM8R/OfE/kV?=
 =?us-ascii?Q?2rgG2F7GK6ISf0qBG4diZmX13hnPpjRoOYp8Zcq4JeGzuNe9Z8RnfXpPMrkO?=
 =?us-ascii?Q?j2dl9/ekC7PYWXxau4WR537bRHdaNNBgo86QDkmLwmqm+wrQWkAq5arFhcmh?=
 =?us-ascii?Q?AAj8s2SpJf9QH9+du9p6yiwrsPznG20BXruYtUAy9YzGmWyRTGjCiYvpj5H8?=
 =?us-ascii?Q?asDxKYdGh/neqg07m7pfPVgBn11sD3nqMzLl3smfQmMxQUMKw5ARg2SmUmb6?=
 =?us-ascii?Q?nHQoC73DCqtLNZ2BAJr6L+GMdjhiOYUxqj4ARy6GfZW+6WKtofGGE78KsSIy?=
 =?us-ascii?Q?5j3qbfLe6KYLVakgimgve1R7lGThIBpQyY5aPDAfGazIj0lk7wv98fkJjbG9?=
 =?us-ascii?Q?IZ+RDjnQfmhhmISDvwkhCkVGR+7yy/ldRcfhZaeSSeTF/1+pyyuT67LxgXFX?=
 =?us-ascii?Q?8RDrv1WTs+VCGLV5FDG/breHQYre+uvnE4ZX/M+Q6Q5O15T9zi+aE0H6W9Dw?=
 =?us-ascii?Q?4P5/t6ZTozEp9tFFqCtgfaqKkZcxgZziYIw4Ulot3SijsV7HNlnyc9vMYdRY?=
 =?us-ascii?Q?CUeaUREUNkBxS0W1NYBr7RTNbS2wCXfvFQEIE2HTopqI8PFlIUpWYsh/YYhS?=
 =?us-ascii?Q?K7ql4kGfUVHkGCS20OaB81q0XO3rHpkK86eBC4dbPO/p76Tg3bM09f84c/nA?=
 =?us-ascii?Q?1xCF1EWtChBq1B6mFE1smESFAlOfnQbgjlv9Si7VFR2jYS1m8i8/RspfNZge?=
 =?us-ascii?Q?ybkrT9xH4qw7HbyVomfr8IVcjtO4pF70MShWgoJDyrLrGCVEvnXPl/qz+/VL?=
 =?us-ascii?Q?4APGWYN98bnPpg8nepiUcqJwMdM8/bNv5Y8iElrM3xmHzXCSsw3DXKRgz55/?=
 =?us-ascii?Q?G0J4uKpWMhY9N63bO1IRHcRfyzjUVAuHvpStzCY2laOYybK3WUqqyyHJS2ed?=
 =?us-ascii?Q?+l1LSdPoA67SJyTIzaJ/Vjpr9T728JAW7vYEwZ9FAJIcfApqMt2VBiLv1roW?=
 =?us-ascii?Q?/1pER7Y7kNc+/hxJ7wm3v0uNRIn07bduxO27RV0QbXk7nhaEQu2uBRLfUGT4?=
 =?us-ascii?Q?puEFLFO+cA8yC13FBukfP1InA7u9022TtnnR1/qY+dPKKTl4QSXw9Ey+OkUR?=
 =?us-ascii?Q?7PKurw3WDqfM2v9gvl9Auw1TWhGkMgAgRDmrbVH0w101Zvvk3SvVU6MyFf4n?=
 =?us-ascii?Q?37SfhNBzzkYaD+uu6oeyYJ0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7/6Uh26AWIcp1B3fXKZFzIqm2WeaIJysUcJVyRbbtiwo8jwAq2ZQMl3V8XV1hrvP8dh+XvuOfh80pLA6+NsU4PD7V5kzNA6rO5yFC8qCV6ckVFycQ9xTKFg0mHD0T7Qa14ZA3u2gXZ9GJWXnwSa3bwjI32zwfxMPUx9FTjw31YfYNpQLlpSRcLBxruszvaKqGWAvP7OMVFmd5FnyR7k7QPjLPk+jbWXlgzINwLH7iBSubLjFiYiWi1jiDVtR9QimpeZ0+yngR4c7e+l78PdA7iWbDC5Ax0oHX31zs3EBAxvgFerttd7rw0Nu9spt9j/YodaBbbQaVIAddB6SXc1Jh38orenZ26mJEHny6fAh9aPlH2UCMTHNN6AF7LdMjjtt8iNbNnZPVUCMSxboTjKUEfNihash78y6xUHOhme4NnIlljenjirlu4X9E7cQFVx0nDuIBZnmt4wEWDKna/ZZfr2feT8+DpxeyRzXswMHlndZiLzRqLQ32cgu3kxRFbB956Lht3/ajZ9gTekPIOSwcuzhcueErkC0wCxeqzn+CiMXSB33EHRwNrxfojyesHG8oL7MOkgJkbEblo2w6Zrub3/qVsj/9YoXTCQMfqlfBjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816bd61c-c531-4a3f-882e-08dce33d5650
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:52:56.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etu4UlwEGqb4cqFxMbyb2S4ISHjlsvL120j7yJmEhTVT9j0YTvw2B19BOb0uIenDuu4HiMEx6ji3Pwp/peW7owY73Ye6VP1TMCj24lnATbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020169
X-Proofpoint-ORIG-GUID: h9H2t3jfpNRDasfmbzY9EZ940loxftE4
X-Proofpoint-GUID: h9H2t3jfpNRDasfmbzY9EZ940loxftE4

Hello all,

This is v3 of the series to add global variables to pahole's generated BTF.
Patches 1-3 of v2 were already merged. This series splits the last patch of v2
and does some small updates. It should apply cleanly to the "next" branch.
https://github.com/acmel/dwarves/commits/btf_global_vars/

Changes since v2:
1. Split things out into several smaller patches as can be seen in the log
   below.
2. Previously the global_var feature was defined with BTF_DEFAULT_FEATURE, but I
   think we agreed in the discussion of v2 that it would be better as
   BTF_NON_DEFAULT_FEATURE, so I changed it to align with our discussion.
3. Removed the "--encode_btf_global_vars" option.
3. I went through and straightened out my use of integer types for ELF section
   index (size_t, as returned by libelf) as well as the variable addr and size.
   To this end I did add a few checks to explicitly ensure we don't overflow the
   uint32_t fields in the DATASEC.

To test this out on a Linux build, you'll want to make the following change:

---------
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index b75f09f3f424..c88d9e526426 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)      += --skip_encoding_btf_inconsis
 else

 # Switch to using --btf_features for v1.26 and later.
-pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
+pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,global_var

 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
---------

With a suitable kernel config that has BTF enabled, you could then build like
so:

    PATH=path/to/pahole_build_dir make all

And you'll be able to examine the size of the results with readelf, or dump the
results with bpftool.

v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.brennan@oracle.com/T/
v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.brennan@oracle.com/

Stephen Brennan (5):
  btf_encoder: use bitfield to control var encoding
  btf_encoder: stop indexing symbols for VARs
  btf_encoder: explicitly check addr/size for u32 overflow
  btf_encoder: allow encoding VARs from many sections
  pahole: add global_var BTF feature

 btf_encoder.c      | 348 +++++++++++++++++++++------------------------
 btf_encoder.h      |   7 +
 dwarves.h          |   1 +
 man-pages/pahole.1 |   7 +-
 pahole.c           |   3 +-
 5 files changed, 178 insertions(+), 188 deletions(-)

-- 
2.43.5


